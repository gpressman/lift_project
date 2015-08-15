class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|

      t.timestamps null: false
      t.integer :current_weight
      t.integer :current_height
      t.integer :body_fat
    end
  end
end
