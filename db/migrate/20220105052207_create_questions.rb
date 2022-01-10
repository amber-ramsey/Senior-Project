class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :query
      t.string :ch1
      t.string :ch2
      t.string :ch3
      t.string :ch4
      t.string :ch5
      t.string :ch6
      t.string :ch7
      t.string :ch8
      t.string :ch9
      t.string :ch10
      t.string :correct
      t.references :test, null: false, foreign_key: true

      t.timestamps
    end
  end
end
