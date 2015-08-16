class AddHeightWeightAndBodyFatToUser < ActiveRecord::Migration
  def change
  	add_column :users, :current_weight, :integer
  	add_column :users, :current_bodyfat, :string
  	add_column :users, :current_height, :string
  end
end
