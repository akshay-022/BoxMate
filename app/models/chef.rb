class Chef < ActiveRecord::Base
    def self.all_cuisines
      tags_arrays = Chef.distinct.pluck(:tags).map { |tags| JSON.parse(tags) }
      unique_tags = tags_arrays.flatten.uniq
    end
end
  