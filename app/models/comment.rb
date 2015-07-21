class Comment < ActiveRecord::Base
  belongs_to :encounter
  belongs_to :user
end