class User < ActiveRecord::Base
  has_many :weights
  has_and_belongs_to_many :exercises
  has_many :attempts
  


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
