class ApplicationController < ActionController::Base
  def not_authenticated
    flash[:danger] = "ログインしてください"
    redirect_to login_path
  end
  
  def teams
    @teams = Team.where(user_id: current_user.id)
  end
  
  def teamowner
    if current_user.id.to_s != @team.user_id
      redirect_to root_path
    end
  end
end
