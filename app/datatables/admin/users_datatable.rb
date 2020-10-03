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
    col :uid, visible: false
    col :updated_at, label: 'Updated', visible: false
    col :created_at, label: 'Created', visible: false

    col(:to_s, label: 'User', sql_column: true, partial: 'admin/users/col')
      .search do |collection, term|
        collection.where(id: effective_resource.search_any(term))
      end.sort do |collection, direction|
        collection.order(name: direction, first_name: direction)
      end

    col :email, visible: false
    col :name, visible: false
    col :first_name, visible: false
    col :last_name, visible: false

    col :roles, search: User::ROLES

    col :clients do |user|
      user.clients.map do |client|
        mate = user.mates.find { |mate| mate.client_id == client.id }

        title = (can?(:edit, client) ? link_to(client, edit_admin_client_path(client), title: client.to_s) : client.to_s)
        badge = content_tag(:span, mate.roles.join, class: 'badge badge-info')

        content_tag(:div, (title + ' ' + badge), class: 'col-resource-item')
      end.join
    end

    col :provider, label: 'Sign in with', search: sign_in_with_collection() do |user|
      user.provider || 'email'
    end

    col :invitation_accepted?, label: 'Invite Accepted?', as: :boolean
    col :invitation_sent_at, as: :date

    col :sign_in_count, visible: false

    col :last_sign_in_at, visible: false do |user|
      (user.current_sign_in_at.presence || user.last_sign_in_at).try(:strftime, '%F %H:%M')
    end

    actions_col
  end

  collection do
    User.deep.all
  end

  def sign_in_with_collection
    [['email', 'nil']] + (Devise.omniauth_providers rescue []).map { |provider| [provider, provider] }
  end

end
