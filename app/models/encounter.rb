class Encounter < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 5}
  validates :content, presence: true, length: {minimum: 100}
  belongs_to :user
  has_many :comments
end