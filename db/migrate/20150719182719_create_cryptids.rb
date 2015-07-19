class CreateCryptids < ActiveRecord::Migration
  def change
    create_table :cryptids do |t|
      t.string :name, :null => false
      t.text :content
 
      t.timestamps
    end
  end
end
