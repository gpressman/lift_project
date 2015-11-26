class User < ActiveRecord::Base
  has_many :weights
  has_many :exercises
  has_many :attempts
  


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
