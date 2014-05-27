class Artwork < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :title, presence: true
  validates :image_url, presence: true
end
