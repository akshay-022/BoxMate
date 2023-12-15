class Subscription < ActiveRecord::Base

    belongs_to :customerinfo
    belongs_to :chefinfo
    
end


