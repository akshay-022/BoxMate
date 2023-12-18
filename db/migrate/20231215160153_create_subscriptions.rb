class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :customerinfo, index: true, foreign_key: true
      t.references :chefinfo, index: true, foreign_key: true
    end
  end
end
