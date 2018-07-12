class Admin::UsersDatatable < Effective::Datatable

  datatable do
    order :updated_at, :desc

    col :id, visible: false
    col :updated_at, label: 'Updated'
    col :created_at, label: 'Created', visible: false

    col :email
    col :name, visible: false

    col :invitation_sent_at

    col :invitation_accepted_at do |user|
      if user.invitation_sent_at
        if user.invitation_accepted_at
          user.invitation_accepted_at.strftime('%F %H:%M')
        else
          "Not accepted (#{link_to 'resend', reinvite_user_invitation_path(user), method: :post, 'data-confirm' => 'Resend invitation?'})"
        end
      end
    end

    col :roles

    col :sign_in_count, visible: false
    col :last_sign_in_at, visible: false do |user|
      (user.current_sign_in_at.presence || user.last_sign_in_at).try(:strftime, '%F %H:%M')
    end

    actions_col do |user|
      render_resource_actions(resource, user, partial: :dropleft) do
        dropdown_link_to('Impersonate', impersonate_user_path(user), title: "Impersonate #{user}", data: { method: :post, confirm: "Impersonate #{user}?"})
      end
    end

  end

  collection do
    User.all
  end

end
