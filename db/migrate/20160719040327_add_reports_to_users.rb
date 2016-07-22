class AddReportsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reports, :integer, default: 0
  end
end
