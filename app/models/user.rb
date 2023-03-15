class User < ApplicationRecord
    attr_accessor :remember_token
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    before_save :downcase_email
    validates :email, presence: true, length: {maximum: 50},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
    validates :name, presence: true, length: {maximum: 50}
    #validates :password, presence: true, length: {minimum: Settings.digits.digit_6}, allow_nil:true
    has_secure_password
   

    class << self
        def digest string
        cost = if ActiveModel::SecurePassword.min_cost
                    BCrypt::Engine::MIN_COST
               else
                    BCrypt::Engine.cost
               end
            BCrypt::Password.create string, cost: cost
        end

        def new_token
        SecureRandom.urlsafe_base64
        end
    end

    def remember
        self.remember_token = User.new_token
        update remember_digest: User.digest(remember_token)
    end
    def authenticated? remember_token
        BCrypt::Password.new(remember_digest).is_password? remember_token
    end

    # Forgets a user.
    def forget
        update_attribute :remember_digest, nil
    end

    private

    def downcase_email
        self.email.downcase!
    end


end


