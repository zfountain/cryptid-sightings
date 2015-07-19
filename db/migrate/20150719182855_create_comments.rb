class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, :null => false
      t.references :encounter, :index => true
      t.belongs_to :user, :null => false

      t.timestamps
    end
    add_foreign_key :comments, :encounters
  end
end
