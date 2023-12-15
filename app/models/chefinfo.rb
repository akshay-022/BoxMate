class Chefinfo < ActiveRecord::Base
  has_many :chefmeals, :dependent => :destroy
  has_many :chef_reviews

  def self.all_cuisines
    tags_arrays = Chefinfo.distinct.pluck(:tags).map { |tags| tags.split(',') }
    unique_tags = tags_arrays.flatten.uniq
    return unique_tags
    # return ["indian", "jain", "chinese", "vietnamese", "gluten-free"]
  end
end
  