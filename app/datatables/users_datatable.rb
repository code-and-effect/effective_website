class UsersDatatable < Effective::Datatable
  datatable do
    default_order :updated_at, :desc

    table_column :id, visible: false
    table_column :updated_at, label: 'Updated', as: :date
    table_column :created_at, label: 'Created', as: :date, visible: false

    table_column :email
    table_column :first_name, visible: false
    table_column :last_name, visible: false

    table_column :invitation_sent_at

    table_column :invitation_accepted_at do |user|
      if user.invitation_sent_at
        if user.invitation_accepted_at
          user.invitation_accepted_at.strftime('%F %H:%M')
        else
          "Not accepted (#{link_to 'resend', reinvite_user_invitation_path(user), method: :post, 'data-confirm' => 'Resend invitation?'})"
        end
      end
    end

    table_column :roles

    table_column :sign_in_count, visible: false
    table_column :last_sign_in_at, visible: false do |user|
      (user.current_sign_in_at.presence || user.last_sign_in_at).try(:strftime, '%F %H:%M')
    end

    actions_column
  end

  def collection
    User.all
  end
end
