class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :user_id
      t.integer :exercise_id
      t.float :score

      t.timestamps null: false
    end
  end
end
