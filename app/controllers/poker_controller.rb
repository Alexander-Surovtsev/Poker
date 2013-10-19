class PokerController < ApplicationController
#  require 'WorkWithCookies.rb'
  
#  def index
#    @user = User.find_by_name_and_password(cookies[:name], cookies[:password])
##    @user = get_user_by_cookies(cookies)
##    @user = nil
#    respond_to do |format|
#      format.html 
#      format.json { render json: @user}
#    end
#  end

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

#  def set_cookies(cookies, user)
#    cookies[:name] = user[:name]
#    cookies[:password] = user[:password]
#  end
  
  def create_user(name, password)
    @user = User.new
    @user[:name] = name
    @user[:password] = password
    return @user    
  end
  
#  def tryLogin(cookies)
#    @user = get_user_by_cookies(cookies)
#    if (@user != nil)
#      @text = "loggined #{@user[:name]}"
#    else
#      respond_to do |format|
#        format.html { redirect_to(poker_index_path, :notice => "Please, try login again")}
#        format.xml { head :ok}
#      end
#    end
#  end
  
  def check_password_and_confirmation(password, confirmation)
    return (password != nil and password == confirmation)
  end

  def tables
    if (params[:user] != nil)
      @par = params[:user]

      if checkName(@par[:name]) != nil
        respond_to do |format|
          format.html { redirect_to(poker_register_path, :notice => "Incorrect name")}
          format.xml { head :ok}
        end
        return
      end

      if check_password_and_confirmation(@par[:password], @par[:password_confirmation])
        @user = create_user(@par[:name], @par[:password])
        if @user.save
          sign_in @user
          redirect_to poker_index_path
#          set_cookies(cookies, @user)
#          respond_to do |format|
#            format.html { redirect_to(poker_tables_path, :notice => "You are loggin as #{@user[:name]}")}
#            format.xml { head :ok}
#          end
          return
        else
          @notice = "You are not registered"
        end
      else
        @notice = "Passwords are not equals"
      end
      respond_to do |format|
        format.html { redirect_to(poker_register_path, :notice => @notice)}
        format.xml { head :ok}
      end
      return
    end
  end
#    else
#      @user = get_user_by_cookies(cookies)
#      if (@user != nil)
#        @text = "loggined #{@user[:name]}"
#      else
#        respond_to do |format|
#          format.html { redirect_to(poker_index_path, :notice => "Please, try login again")}
#          format.xml { head :ok}
#        end
#      end
#    end

  # respond_to do |format|
  # # if @userto[:password] == @user[:password_confirmation]
  # if @user.save
  # format.xml {render :xml => @user, :status => :created, :location => @user}
  # end
  #
  # # end
  # end

  def create_table
  end

  def game
  end
  
  def sign_out
    cookies.delete domain: 'localhost'
    respond_to do |format|
      format.html {redirect_to(poker_index_path, :notice => "You are signed out")}
      format.xml {head :ok}
    end
  end  
end
