class Customermeal < ActiveRecord::Base

    belongs_to :customerinfo
    belongs_to :chefmeal
end
