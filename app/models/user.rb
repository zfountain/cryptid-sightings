class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # Iclude SanitizeHelper to strip tags from form submissions
  include ActionView::Helpers::SanitizeHelper

  validates :password, length: { minimum: 8 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :encounters
  has_many :comments, :dependent => :destroy

  before_save do |user|
    user.username = strip_tags(user.username)
    user.first_name = strip_tags(user.first_name)
    user.last_name = strip_tags(user.last_name)
    user.email = strip_tags(user.email)
    user.email = strip_tags(user.email)
  end

  # Paperclip image view
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  # Only allow specified image types to be uploaded
  validates_attachment :image,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 4.megabytes

  # Define roles for Can Can authorization
  ROLES = %w[admin moderator author banned]
  # Define base roles to be managed in Ability model
  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

end