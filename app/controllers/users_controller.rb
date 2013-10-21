class UsersController < ApplicationController
  def register
    @user = User.new
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def get_user_by_cookies(cookies)
    @user = User.find_by_name_and_password(cookies[:name], cookies[:password])
    return @user
  end

  def checkName(name)
    @user = User.find_by_name(name)
    return @user
  end
  
  def create_user(name, password)
    @user = User.new
    @user[:name] = name
    @user[:password] = password
    return @user    
  end
  
  def check_password_and_confirmation(password, confirmation)
    return (password != nil and password == confirmation)
  end

  def confirm_registration
    sign_out
    if (params[:user] != nil)
      @par = params[:user]

      if checkName(@par[:name]) != nil
        respond_to do |format|
          format.html { redirect_to(user_register_path, :notice => "Incorrect name")}
          format.xml { head :ok}
        end
        return
      end

      if check_password_and_confirmation(@par[:password], @par[:password_confirmation])
        @user = create_user(@par[:name], @par[:password])
        @user.prepare_to_save
        if @user.save
          sign_in @user
          redirect_to tables_path
          return
        else
          @notice = "You are not registered"
        end
      else
        @notice = "Passwords are not equals"
      end
      respond_to do |format|
        format.html { redirect_to(user_register_path, :notice => @notice)}
        format.xml { head :ok}
      end
      return
    end
  end
end
