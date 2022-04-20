class AddTestDescription < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :description, :string
    remove_column :questions, :picname, :string
  end
end
