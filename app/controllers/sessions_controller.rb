class SessionsController < ApplicationController

  def new
    if signed_in?
      redirect_to index_path
    end 
  end

  def create
    user =  User.find_by_name(params[:session][:name]) 
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to index_path
    else
      redirect_to signin_path
    end    
  end
  
  def destroy
    sign_out

    redirect_to signin_path
  end
  
  def notification
    signed_in?
  end
  
end
