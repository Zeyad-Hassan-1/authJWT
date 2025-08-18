class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: true
    # validates :email, presence: true, uniqueness: true

    def generate_password_reset_token!
        self.reset_token = SecureRandom.urlsafe_base64
        self.reset_sent_at = Time.now.utc
        save!(validate: false) # Skip validations for password reset
    end

    def password_reset_expired?
        reset_sent_at < 1.hour.ago
    end
end
