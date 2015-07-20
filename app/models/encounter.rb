class Encounter < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 5}
  validates :content, presence: true, length: {minimum: 10}
  belongs_to :user
  belongs_to :cryptid
  has_many :comments

  # Paperclip image view
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  # Only allow specified image types to be uploaded
  validates_attachment :image,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

end