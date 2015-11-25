class Exercise < ActiveRecord::Base
	belongs_to :user
	has_many :attempts
	validates_uniqueness_of :name
end
