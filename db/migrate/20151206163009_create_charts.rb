class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
      t.string :name
      t.integer :user_id
      t.integer :x_coordinate_exercise_id
      t.integer :y_coordinate_exercise_id

      t.timestamps null: false
    end
  end
end
