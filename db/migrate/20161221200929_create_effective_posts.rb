class CreateEffectivePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :user_id

      t.string :title
      t.string :category

      t.boolean :draft, :default => false
      t.datetime :published_at

      t.text :tags

      t.integer :roles_mask, :default => 0

      # Events fields
      t.datetime :start_at
      t.datetime :end_at
      t.string :location
      t.string :website_name
      t.string :website_href

      t.text :extra

      t.datetime :updated_at
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :posts
  end

end
