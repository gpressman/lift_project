class Exercise < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :attempts
	validates_uniqueness_of :name
end
