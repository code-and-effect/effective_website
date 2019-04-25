class CreateEffectiveRegions < ActiveRecord::Migration[4.2]
  def self.up
    create_table :regions do |t|
      t.string :regionable_type
      t.integer :regionable_id

      t.string :title
      t.text :content
      t.text :snippets

      t.datetime :updated_at
      t.datetime :created_at
    end

    add_index :regions, [:regionable_type, :regionable_id]
    add_index :regions, :regionable_id

    create_table :ck_assets do |t|
      t.boolean :global, default: false

      t.datetime :updated_at
      t.datetime :created_at
    end

  end

  def self.down
    drop_table :regions
    drop_table :ck_assets
  end

end
