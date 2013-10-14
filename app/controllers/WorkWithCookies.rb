def get_user_by_cookies(cookies)
  if cookies == nil
    return nil
  end
  @user = User.find_by_name_and_password(cookies[:name], cookies[:password])
  return @user
end

def get_def_user
  @user = User.new
  @user[:name] = "Name"
  @user[:passwor] = "Password"
  return @user
end

def set_cookies(cookies, user)
  cookies[:name] = user[:name]
  cookies[:password] = user[:password]
end

def checkName(name)
  @user = User.find_by_name(name)
  return @user
end
