class User < ApplicationRecord
  belongs_to :company
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 ROLE_OPTIONS = %w(Site-Admin Admin User)

end
