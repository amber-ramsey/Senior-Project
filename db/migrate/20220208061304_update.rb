class Update < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :picname, :string
    remove_column :tests, :archive, :boolean
    remove_column :users, :password, :string
    add_column :users, :password_digest, :string
  end
end
