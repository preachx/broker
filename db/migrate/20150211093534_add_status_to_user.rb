class AddStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :status, :integer, default: 0
    add_index :users, :status
  end
end
