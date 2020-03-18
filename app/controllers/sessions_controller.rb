class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  def new
  end
  
  def create
    @user = login(params[:login],params[:password])
    if @user
      redirect_to root_path
    else
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_path
  end
  
  private
    
    def not_authenticated
    redirect_to root_path
    end
end
