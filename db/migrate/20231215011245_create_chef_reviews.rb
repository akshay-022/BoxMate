class CreateChefReviews < ActiveRecord::Migration
  def change
    create_table :chef_reviews do |t|
      t.references :chefinfo, index: true, foreign_key: true
      t.references :customerinfo, index: true, foreign_key: true
      t.text :content
      t.integer :rating

      t.timestamps null: false
    end
  end
end
