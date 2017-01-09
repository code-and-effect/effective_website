class CreateEffectiveTrash < ActiveRecord::Migration[4.2]
  def self.up
    create_table :trash do |t|
      t.integer       :user_id

      t.string        :trashed_type
      t.integer       :trashed_id

      t.string        :trashed_to_s
      t.string        :trashed_extra

      t.text          :details

      t.timestamps
    end

    add_index :trash, :user_id
    add_index :trash, [:trashed_type, :trashed_id]
    add_index :trash, :trashed_id
    add_index :trash, :trashed_extra
  end

  def self.down
    drop_table :trash
  end
end
