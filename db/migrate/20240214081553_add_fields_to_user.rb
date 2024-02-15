class AddFieldsToUser < ActiveRecord::Migration[7.1]
  def up
    change_table :users, bulk: true do |t|
      t.string :provider
      t.string :uid
    end
  end

  def down
    change_table :users, bulk: true do |t|
      t.remove :provider
      t.remove :uid
    end
  end
end
