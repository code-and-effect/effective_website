class CreateEffectivePosts < ActiveRecord::Migration[4.2]
  def self.up
    create_table :posts do |t|
      t.integer :user_id

      t.string :title
      t.string :category

      t.boolean :draft, :default => false

      t.text :tags

      t.integer :roles_mask, :default => 0

      t.datetime :published_at

      t.datetime :updated_at
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :posts
  end

end
