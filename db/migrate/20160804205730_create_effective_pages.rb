class CreateEffectivePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :meta_description

      t.boolean :draft, :default => false

      t.string :layout, :default => 'application'
      t.string :template

      t.string :slug
      t.integer :roles_mask, :default => 0

      t.datetime :updated_at
      t.datetime :created_at
    end
    add_index :pages, :slug, :unique => true

    create_table :menus do |t|
      t.string      :title
      t.timestamps
    end

    create_table :menu_items do |t|
      t.integer       :menu_id

      t.integer       :menuable_id
      t.string        :menuable_type

      t.string        :title

      t.string        :url
      t.string        :special

      t.string        :classes
      t.boolean       :new_window, :default => false
      t.integer       :roles_mask, :default => nil

      t.integer       :lft
      t.integer       :rgt
    end
    add_index :menu_items, :lft
  end

  def self.down
    drop_table :pages
    drop_table :menus
    drop_table :menu_items
  end

end
