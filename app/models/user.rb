class User < ActiveRecord::Base
  has_many :weights
  has_and_belongs_to_many :exercises
  has_many :attempts
  has_many :charts
  


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
