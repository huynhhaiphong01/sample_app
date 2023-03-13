class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    before_save :downcase_email
    validates :email, presence: true, length: {maximum: 50},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
    validates :name, presence: true, length: {maximum: 50}

    has_secure_password
    private

    def downcase_email
        self.email.downcase!
    end

    # Returns the hash digest of the given string.
    def User.digest string
        cost = if ActiveModel::SecurePassword.min_cost
                    BCrypt::Engine::MIN_COST
            else
                BCrypt::Engine.cost
            end
            BCrypt::Password.create string, cost: cost
    end
end


