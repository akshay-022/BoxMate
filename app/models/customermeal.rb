class Customermeal < ActiveRecord::Base

    belongs_to :customerinfo
    belongs_to :chefmeal

    def self.all_cuisines
        #tags_arrays = Chef.distinct.pluck(:tags).map { |tags| JSON.parse(tags) }
        #unique_tags = tags_arrays.flatten.uniq
        return ["indian", "jain", "chinese", "vietnamese", "gluten-free"]
    end
end
