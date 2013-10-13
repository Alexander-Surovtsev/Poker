def get_user_by_cookies(cookies)
  @user = User.find_by_name_and_password(cookies[:name], cookies[:password])
  return @user
end

def get_def_user
  @user = User.new
  @user[:name] = "Name"
  @user[:passwor] = "Password"
  return @user
end