class Chefinfo < ActiveRecord::Base
  has_many :chefmeals, :dependent => :destroy
end
  