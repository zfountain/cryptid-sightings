class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 8 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true

  has_many :encounters
  has_many :comments

  # Paperclip image view
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  # Only allow specified image types to be uploaded
  validates_attachment :image,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  # Define roles for Can Can authorization
  ROLES = %w[admin moderator author banned]
  # Define base roles to be managed in Ability model
  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

end