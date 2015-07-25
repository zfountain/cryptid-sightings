class Encounter < ActiveRecord::Base
  # Iclude SanitizeHelper to strip tags from form submissions
  include ActionView::Helpers::SanitizeHelper
  validates :title, presence: true, length: {minimum: 5}
  validates :content, presence: true, length: {minimum: 10}
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  belongs_to :user
  belongs_to :cryptid
  has_many :comments, :dependent => :destroy

  #Sanitize each field before saving to the database
  before_save do |encounter|
    encounter.title = strip_tags(encounter.title)
    encounter.content = strip_tags(encounter.content)
    encounter.city = strip_tags(encounter.city)
    encounter.state = strip_tags(encounter.state)
   encounter.country = strip_tags(encounter.country)
  end

  # Paperclip image view
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  # Only allow specified image types to be uploaded
  validates_attachment :image,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 4.megabytes

end