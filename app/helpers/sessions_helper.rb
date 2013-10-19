module SessionsHelper
  
  def sign_in(user)
    cookies[:name] = user.name
    user.remember_token = user.generate_remember_token
    user.save
#    user.token = user.generate_remember_token
    user.update_attributes(:remember_token => user.remember_token)
    cookies[:password] = user.remember_token
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end
  
   def current_user
#    @current_user ||= User.find_by_name_and_remember_token(cookies[:name], cookies[:password])
    @current_user ||= User.find_by_name_and_remember_token(cookies[:name], cookies[:password])
  end

  def signed_in?
    !(self.current_user.nil?)
  end
  
  def sign_out
    cokies.delete(:name)
    @current_user = nil
  end
  
end
