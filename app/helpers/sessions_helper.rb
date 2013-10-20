module SessionsHelper
  
  def sign_in(user)
    cookies[:name] = user.name
#    user.remember_token = user.generate_remember_token
#    user.save
#    user.update_attributes(:remember_token => user.remember_token)
    s = Session.new
    s.remember_token = s.generate_remember_token()
    s.user_id = user.id
    s.expire_date = DateTime.now
    s.save()
    
    cookies[:password] = s.remember_token
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_name(cookies[:name])
    if @current_user == nil
      return
    end
    s = Session.find_by_user_id_and_remember_token(@current_user.id, cookies[:password])
    if s == nil
      @current_user = nil
    else
      s.expire_date = DateTime.now
      s.save
    end
    return @current_user
  end

  def signed_in?
    !(self.current_user.nil?)
  end
  
  def sign_out
    cokies[:expires] = Time.at(0)
#    @current_user.remember_token = user.generate_remember_token
#    user.save
    
    @current_user = nil
  end
  
end
