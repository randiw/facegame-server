class AddIndexToUsersLinkedinId < ActiveRecord::Migration
  def change
    add_index :users, :linkedin_id, unique: true
  end
end
