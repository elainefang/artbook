class Comment < ActiveRecord::Base
  belongs_to :artwork

  validates :artwork, presence: true
  validates :content, presence: true
end
