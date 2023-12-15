class ChefReview < ActiveRecord::Base
  belongs_to :chefinfo
  belongs_to :customerinfo
end
