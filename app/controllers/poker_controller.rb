class PokerController < ApplicationController
  require 'WorkWithCookies.rb'
  
  def index
#    @user = User.new
#    if cookies[:name] and cookies[:password]
#      @user[:name] = cookies[:name]
#      @user[:password] = cookies[:password]
#    else
#      @user[:name] = "Name"
#      @user[:password] = "Password"
#    end
    @user = get_user_by_cookies(cookies)
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def register
    @user = User.new
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def tables
    if (params[:user] != nil)
      @par = params[:user]
      @user = User.new
      @user[:name] = @par[:name]
      if (@par[:password_confirmation] != nil)
        if (@par[:password] == @par[:password_confirmation])
          @user[:password] = @par[:password]
          usr = check_name(@par[:name])#User.find_by_name(@par[:name])
          if usr !=  nil
            respond_to do |format|
              format.html { redirect_to(poker_register_path, :notice => "Incorrect name")}
              format.xml { head :ok}
            end
            return
          end
          respond_to do |format|
            if @user.save
              set_cookies(cookies, @user)
              format.html { redirect_to(poker_tables_path, :notice => "You are loggin as #{@user[:name]}")}
              format.xml { head :ok}
            else
              format.html { redirect_to(poker_register_path, :notice => "You are not registred")}
              format.xml { head :ok}
            end
          end
          return
        else
          @text = "1"
        end
      else
        respond_to do |format|
          if (@par[:password] != nil)
            @user = User.find_by_name_and_password(@par[:name], @par[:password])
            if @user != nil
              cookies[:name] = @user[:name]
              cookies[:password] = @user[:password]
              format.html { redirect_to(poker_tables_path, :notice => "You are loggin as #{@user[:name]}")}
              format.xml { head :ok}
            else
              format.html { redirect_to(poker_index_path, :notice => "You are not loggin")}
              format.xml { head :ok}
            end
          end
        end
      end
    else
      @user = get_user_by_cookies(cookies)
      if (@user != nil)
        @text = "loggined #{@user[:name]}"
      else
        respond_to do |format|
          format.html { redirect_to(poker_index_path, :notice => "Please, try login again")}
          format.xml { head :ok}
        end
      end
    end

  # respond_to do |format|
  # # if @userto[:password] == @user[:password_confirmation]
  # if @user.save
  # format.xml {render :xml => @user, :status => :created, :location => @user}
  # end
  #
  # # end
  # end
  end

  def create_table
  end

  def game
  end
end
