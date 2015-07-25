class Cryptid < ActiveRecord::Base
  # Iclude SanitizeHelper to strip tags from form submissions
  include ActionView::Helpers::SanitizeHelper

  validates :name, length: { minimum: 3 }
  has_many :encounters

  before_save do |cryptid|
    cryptid.name = strip_tags(cryptid.name)
    cryptid.content = strip_tags(cryptid.content)
  end

  # Paperclip image view
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  # Only allow specified image types to be uploaded
  validates_attachment :image,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 4.megabytes

end