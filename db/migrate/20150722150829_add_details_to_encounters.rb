class AddDetailsToEncounters < ActiveRecord::Migration
  def change
    add_column :encounters, :city, :string
    add_column :encounters, :state, :string
    add_column :encounters, :country, :string
  end
end
