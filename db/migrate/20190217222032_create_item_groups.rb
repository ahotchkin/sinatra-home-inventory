class CreateItemGroups < ActiveRecord::Migration
  def change
    create_table :item_groups do |t|
      t.integer :item_id
      t.integer :group_id
    end
  end
end
