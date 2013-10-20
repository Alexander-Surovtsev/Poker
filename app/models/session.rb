class Session < ActiveRecord::Base
  
  def generate_remember_token
#    self.remember_token = SecureRandom.urlsafe_base64
    return "afsf" + SecureRandom.urlsafe_base64
  end  
  
end
