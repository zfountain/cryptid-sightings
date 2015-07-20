class Cryptid < ActiveRecord::Base
  validates :name, length: { minimum: 3 }
  has_many :encounters
end