module SessionsHelper
  
  def sign_in(user)
    cookies[:name] = user.name
#    user.remember_token = user.generate_remember_token
#    user.save
#    user.update_attributes(:remember_token => user.remember_token)
    s = Session.new
    s.remember_token = s.generate_remember_token()
    s.user_id = user.id
    s.expire_date = 5.seconds.from_now
    s.save()
    
    cookies[:password] = s.remember_token
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def delete_expired_sessions
    Session.where("expire_date <= ?", Time.now).delete_all  
  end
  
  def get_session(current_user)
    if current_user == nil
      return
    end
    s = Session.find_by_user_id_and_remember_token(current_user.id, cookies[:password])
    if s.expire_date <= Time.now
      return nil
    end
    return s
  end
  
  def current_user
    @current_user ||= User.find_by_name(cookies[:name])
    return @current_user
  end
  
  def signed_in?
    s = get_session(self.current_user)
    if s == nil
#      @current_user = nil
      sign_out
    else
      if s.expire_date <= Time.now
#        s.destroy
        sign_out
#        @current_user = nil
      end
      s.expire_date = 5.seconds.from_now
#      s.expire_date = Time.now
      s.save
    end
    return !(@current_user.nil?)
  end
  
  def sign_out
    cookies.delete(:name)
#    @current_user.remember_token = user.generate_remember_token
#    user.save
    delete_expired_sessions
    @current_user = nil
  end
 
end