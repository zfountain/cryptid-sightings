class CreateEncounters < ActiveRecord::Migration
  def change
    create_table :encounters do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.belongs_to :user
 
      t.timestamps
    end
  end
end
