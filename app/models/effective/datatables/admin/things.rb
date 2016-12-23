module Effective
  module Datatables
    class Admin::Things < Effective::Datatable

      datatable do
        table_column :name
        table_column :description

        actions_column
      end

      def collection
        Thing.all
      end

    end
  end
end
