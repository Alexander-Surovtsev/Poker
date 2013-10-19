class SessionsController < ApplicationController

  def new
    if signed_in?
      redirect_to poker_index_path
    end 
#    if params[:session] == nil
#      user = nil
#    else
#      user = User.find_by_name_and_password(params[:session][:name], params[:session][:password])
#    end
#    if user
#      sign_in user
#      redirect_to poker_index_path
#    else
#      redirect_to sign_in_path
      #flash.now[:error] = 'Invalid email/password combination'
      
#    end
  end

  def create
    user =  User.find_by_name(params[:session][:name]) 
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to poker_index_path
    else
      redirect_to signin_path
    end    
  end
  
  def destroy
    cookies.delete(:name)

    redirect_to signin_path
  end
  
end
