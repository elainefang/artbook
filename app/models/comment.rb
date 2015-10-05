class Comment < ActiveRecord::Base
  belongs_to :artwork

  validates :artwork, presence: true
  validates :comment_text, presence: true

end
