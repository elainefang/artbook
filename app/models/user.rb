class User < ActiveRecord::Base
  has_many :artworks, dependent: :destroy

  has_many :users, through: :follows

  belongs_to :user

  acts_as_follower

  # Add handlers to run when creating and saving
  before_create :create_remember_token
  before_save :normalize_fields

  # Validate name:
  validates :first_name,
    presence: true,
    length: { maximum: 50 }

  # Validate name:
  validates :last_name,
    presence: true,
    length: { maximum: 50 }

  # Validate email address:
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }


  # Secure password features:
  has_secure_password


  # Create a new remember token for a user:
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  # Hash a token:
  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  private

  # Creates a new session token for the user:
  def create_remember_token
    self.remember_token = User.hash(User.new_remember_token)
  end

  # Normalize fields for consistency:
  def normalize_fields
    self.email.downcase!
  end

end
