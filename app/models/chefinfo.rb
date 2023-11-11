class Chefinfo < ActiveRecord::Base

  has_many :chefmeals, dependent: :delete_all
end
  