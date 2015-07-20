class AddAttachmentImageToCryptids < ActiveRecord::Migration
  def self.up
    change_table :cryptids do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :cryptids, :image
  end
end
