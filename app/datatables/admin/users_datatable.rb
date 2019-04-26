class Admin::UsersDatatable < Effective::Datatable

  filters do
    scope :unarchived, label: 'All'
    scope :admins
    scope :staff
    scope :clients
    scope :archived
  end

  datatable do
    order :updated_at, :desc

    col :id, visible: false
    col :updated_at, label: 'Updated', visible: false
    col :created_at, label: 'Created', visible: false

    col :email
    col :name
    col :roles, search: User::ROLES

    col :clients do |user|
      user.clients.map do |client|
        mate = user.mates.find { |mate| mate.client_id == client.id }

        title = (can?(:edit, client) ? link_to(client, edit_admin_client_path(client), title: client.to_s) : client.to_s)
        badge = content_tag(:span, mate.roles.join, class: 'badge badge-info')

        content_tag(:div, (title + ' ' + badge), class: 'col-resource-item')
      end.join
    end

    col :invitation_accepted?, label: 'Invite Accepted?', as: :boolean
    col :invitation_sent_at, as: :date

    col :sign_in_count, visible: false
    
    col :last_sign_in_at, visible: false do |user|
      (user.current_sign_in_at.presence || user.last_sign_in_at).try(:strftime, '%F %H:%M')
    end

    actions_col do |user|
      if can?(:reinvite, user)
        dropdown_link_to('Reinvite', reinvite_user_invitation_path(user), title: "Reinvite #{user}", data: { method: :post, confirm: "Reinvite #{user}?"})
      end

      if can?(:impersonate, user)
        dropdown_link_to('Impersonate', impersonate_user_path(user), title: "Impersonate #{user}", data: { method: :post, confirm: "Impersonate #{user}?"})
      end
    end
  end

  collection do
    User.deep.all
  end

end
