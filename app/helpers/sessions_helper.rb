module SessionsHelper
  
  def sign_in(user)
    cookies[:name] = user.name
    cookies[:password] = user.password
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end
  
   def current_user
    @current_user ||= User.find_by_name_and_password(cookies[:name], cookies[:password])
  end

  def signed_in?
    !(self.current_user.nil?)
  end
  
  def sign_out
    cokies.delete(:name)
    @current_user = nil
  end
  
end
