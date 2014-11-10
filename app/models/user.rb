class User < ActiveRecord::Base
  attr_accessor :remember_token
  validates :name, presence: true
  
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: {maximum: 255}
  # , format: { with: VALID_EMAIL_REGEX }

  validates :linkedin_id, presence: true, uniqueness: true
  
  # has_secure_password

  # Return the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:token, remember_token)
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    BCrypt::Password.new(token).is_password?(remember_token)
  end
  
end