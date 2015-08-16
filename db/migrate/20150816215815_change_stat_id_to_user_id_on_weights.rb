class ChangeStatIdToUserIdOnWeights < ActiveRecord::Migration
  def change
  	rename_column :weights, :stat_id, :user_id
  end
end
