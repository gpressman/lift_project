class FixTimestampsInWeight < ActiveRecord::Migration
  def change
  	change_column :weights, :created_at, :datetime, :null => true, :default => nil
  end
end
