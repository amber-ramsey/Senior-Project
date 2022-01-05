class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :password
      t.integer :schoolID
      t.boolean :isAdmin

      t.timestamps
    end
  end
end
