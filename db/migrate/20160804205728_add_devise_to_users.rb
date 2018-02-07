class AddDeviseToUsers < ActiveRecord::Migration[5.0]
  def change
    create_table(:users) do |t|
      # Devise
      t.string    :encrypted_password, null: false, default: ''
      t.string    :reset_password_token
      t.datetime  :reset_password_sent_at
      t.datetime  :remember_created_at
      t.integer   :sign_in_count, default: 0, null: false
      t.datetime  :current_sign_in_at
      t.datetime  :last_sign_in_at
      t.inet      :current_sign_in_ip
      t.inet      :last_sign_in_ip

      # User fields
      t.string    :email, null: false, default: ''
      t.string    :name

      t.integer   :roles_mask

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
