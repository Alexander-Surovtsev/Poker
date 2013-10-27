module SessionsHelper
  
  def sign_in(user)
    cookies[:name] = user.name
    s = Session.new
    s.remember_token = s.generate_remember_token()
    s.user_id = user.id
    s.expire_date = 30.seconds.from_now
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
  
  def get_session
    if self.current_user == nil
      return
    end
    s = Session.find_by_user_id_and_remember_token(self.current_user.id, cookies[:password])
    if s== nil || s.expire_date <= Time.now
      return nil
    end
    return s
  end
  
  def current_user
    @current_user ||= User.find_by_name(cookies[:name])
    return @current_user
  end
  
  def signed_in?
    s = get_session
    if s == nil
      sign_out
      return false
    else
      if s.expire_date <= Time.now
        sign_out
      end
      s.expire_date = 30.seconds.from_now
      s.save
    end
    return true
  end
  
  def sign_out
    cookies.delete(:name)
    delete_expired_sessions
    @current_user = nil
  end
 
end