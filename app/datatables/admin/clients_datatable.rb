class Admin::ClientsDatatable < Effective::Datatable

  filters do
    scope :unarchived, label: 'All'
    scope :archived
  end

  datatable do
    order :updated_at, :desc

    col :id, visible: false
    col :updated_at, label: 'Updated', visible: false
    col :created_at, label: 'Created', visible: false

    col :name
    col :phone
    col :email

    col :users do |client|
      client.users.map do |user|
        mate = client.mates.find { |mate| mate.user_id == user.id }

        title = (can?(:edit, user) ? link_to(user, edit_admin_user_path(user), title: user.to_s) : user.to_s)
        badge = content_tag(:span, mate.roles.join, class: 'badge badge-info')

        content_tag(:div, (title + ' ' + badge), class: 'col-resource-item')
      end.join
    end

    col :archived, search: { value: false }

    actions_col
  end

  collection do
    Client.deep.all
  end

end
