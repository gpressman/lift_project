class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.integer :weight
      t.integer :stat_id

      t.timestamps null: false
    end
  end
end
