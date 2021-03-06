class User < ActiveRecord::Base
  require 'digest/sha2'
  
  ActiveRecord::Base.logger = nil

#  validates :id
 
#  validates :name, :presence => true, :uniquiness => true
   
#  validates :password, :confirmation => true
#  attr_accessor :password_confirmation
#  attr_reader :password
 
#  validate :password_must_be_present
 
 
#  before_save { |user| user.name = name.downcase }
#  before_save { |user| user.salt = generate_salt }
#  before_save { |user| user.remember_token = user.generate_remember_token }
#  before_save { |user| user.password = encrypt_password(user.password, user.salt) }
#  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  Name_RegEx = /^[a-zA-Z ]{3,30}/
  validates :name, :format => Name_RegEx
  
  def authenticate(pass)
    if (self.password == encrypt_password(pass, self.salt))
         return true
    end
    return false
   end
   
#  def generate_remember_token
#    self.remember_token = SecureRandom.urlsafe_base64
#    return "afsf" + SecureRandom.urlsafe_base64
#  end

  def prepare_to_save
    self.salt = generate_salt
    self.password = encrypt_password(self.password, self.salt)
#    self.remember_token = generate_remember_token
  end
  
  def encrypt_password(pass, salt)
    password = Digest::SHA2.hexdigest(pass + "wibble" + salt)
#    password += "wibble" + salt
    return password
  end

  def generate_salt
    return rand.to_s
  end
end
