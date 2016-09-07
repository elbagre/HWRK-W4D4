class User < ActiveRecord::Base
  validates(
    :user_name,
    :session_token,
    presence: true
  )

  has_many(
    :cats,
    class_name: "Cat",
    foreign_key: :user_id
  )

  has_many(
    :requests,
    class_name: "CatRentalRequest",
    foreign_key: :user_id
  )

  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: { message: "Password can't be blank" }

  after_initialize :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    if user && user.is_password?(password)
      return user
    else
      nil
    end
  end

  def generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

end
