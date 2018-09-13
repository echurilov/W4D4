class User < ApplicatonRecord
  validates :email, :password_digest, :session_token, presence: true
  validates :email, unique: true

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(email,password)
    user = User.where(email: email)
    pw = user.is_password?(password)
    if user && pw
      user
    else
      nil
    end
  end

  def reset_session_token
    self.session_token = User.generate_session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
