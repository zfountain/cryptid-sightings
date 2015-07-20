class AddAttachmentImageToEncounters < ActiveRecord::Migration
  def self.up
    change_table :encounters do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :encounters, :image
  end
end
