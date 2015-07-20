class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 8 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  # Define roles for Can Can authorization
  ROLES = %w[admin moderator author banned]
  # Define base roles to be managed in Ability model
  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

end