class AddDatePurchasedToItems < ActiveRecord::Migration
  def change
    add_column :items, :date_purchased, :date
  end
end
