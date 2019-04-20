class CreateMates < ActiveRecord::Migration[5.2]
  def change
    create_table :mates do |t|
      t.integer :client_id
      t.integer :user_id

      t.integer :roles_mask

      t.timestamps
    end
  end
end
