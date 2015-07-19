class RemoveUserIdFromEncounters < ActiveRecord::Migration
  def change
    remove_column :encounters, :user_id, :integer
  end
end
