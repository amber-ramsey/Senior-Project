class CreateTestResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :test_responses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.datetime :began_at, precision: 6, null: false
      t.datetime :left_at, precision: 6, null: false      
      t.string :response      
      t.boolean :isCorrect, null: false
    end
  end
end
