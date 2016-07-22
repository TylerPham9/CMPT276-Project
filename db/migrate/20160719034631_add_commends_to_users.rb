class AddCommendsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :commends, :integer, default: 0
  end
end
