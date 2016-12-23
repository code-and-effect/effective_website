class CreateThings < ActiveRecord::Migration[5.0]
  def change
    create_table :things do |t|
      t.string :name
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
