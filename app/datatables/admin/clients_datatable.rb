class Admin::ClientsDatatable < Effective::Datatable

  datatable do
    order :updated_at, :desc

    col :id, visible: false
    col :updated_at, label: 'Updated', visible: false
    col :created_at, label: 'Created', visible: false

    col :name
    col :phone
    col :email
    col :users

    col :archived, search: { value: false }

    actions_col
  end

  collection do
    Client.deep.all
  end

end
