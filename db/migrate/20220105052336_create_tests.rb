class CreateTests < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.boolean :private
      t.string :password
      t.integer :time
      t.boolean :archive

      t.timestamps
    end
  end
end
