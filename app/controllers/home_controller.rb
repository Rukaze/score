class HomeController < ApplicationController
  def index
    @players = Player.all
  end
  
  def home
  end
  
  def reg
    @player = Player.new
    @teams = Team.all
  end
  
  def create
    @player = Player.new(player_params)
    @player.save
    redirect_to root_path
  end
  
  def team_reg
    @team = Team.new
  end
  
  def team_create
    @team = Team.new(team_params)
    @team.save
    redirect_to root_path
  end
  
  def player_params
    params.require(:player).permit(:name,:position,:team_name)
  end
  
  def team_params
    params.require(:team).permit(:team_name)
  end
end
