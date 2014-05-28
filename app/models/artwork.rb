class Artwork < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :title, presence: true

  has_attached_file :art_image, :styles => { :medium => "500x700>", :thumb => "200x200>" }, :default_url => ""
  validates_attachment_content_type :art_image, :content_type => /\Aimage\/.*\Z/
end
