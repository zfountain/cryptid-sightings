class Comment < ActiveRecord::Base
  # Iclude SanitizeHelper to strip tags from form submissions
  include ActionView::Helpers::SanitizeHelper

  belongs_to :encounter
  belongs_to :user

  before_save do |comment|
    comment.content = strip_tags(comment.content)
  end

end