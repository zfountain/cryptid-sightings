class Encounter < ActiveRecord::Base
  # validates :title, presence: true, length: {minimum: 5}
  # validates :content
  belongs_to :user
  has_many :comments
end