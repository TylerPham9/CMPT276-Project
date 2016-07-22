class User < ActiveRecord::Base
    before_save { self.email = email.downcase if email}
    # Checks username and email are not blank 
    validates :username, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, length: { maximum: 255 },
                     format: { with: VALID_EMAIL_REGEX },
                     uniqueness: { case_sensitive: false }, unless: :guest?
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
    validates_presence_of :username, :email, :password_digest, unless: :guest?
    validates_uniqueness_of :username, allow_blank: true
    # validates_confirmation_of :password, unless: :guest?
    
    #
    has_secure_password(validations: false)
    
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    def self.new_guest
        new { |u| u.guest = true

        }
    end
    
end