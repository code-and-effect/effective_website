class CreateEffectiveLogging < ActiveRecord::Migration[4.2]
  def self.up
    create_table :logs do |t|
      t.integer       :parent_id
      t.integer       :user_id

      t.string        :associated_type
      t.integer       :associated_id

      t.integer       :logs_count

      t.string        :message
      t.text          :details

      t.string        :status

      t.timestamps
    end

    add_index :logs, :user_id
    add_index :logs, :parent_id
    add_index :logs, [:associated_type, :associated_id]
    add_index :logs, :associated_id
  end

  def self.down
    drop_table :logs
  end
end
