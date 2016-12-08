module Effective
  module Datatables
    class Users < Effective::Datatable

      datatable do
        default_order :updated_at, :desc

        table_column :id, visible: false
        table_column :updated_at, label: 'Updated', as: :date
        table_column :created_at, label: 'Created', as: :date, visible: false

        table_column :email
        table_column :first_name, visible: false
        table_column :last_name, visible: false

        table_column :roles

        table_column :sign_in_count
        table_column :last_sign_in_at

        table_column :archived, visible: false, filter: { selected: false }

        actions_column
      end

      def collection
        User.all
      end

    end
  end
end
