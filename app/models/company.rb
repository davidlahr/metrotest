class Company < ApplicationRecord
  has_many :users
  has_many :metrofiles
end
