class GameController < ApplicationController
  protect_from_forgery 
  skip_before_action :verify_authenticity_token
  def pregame
    @teams = Team.all
    @game_setting = Game.new
  end
  
  def game_create
    @game_setting = Game.new(game_params)
    @game_setting.save
    redirect_to start5_path
  end
  
  def start5
    @team = Game.last.team
    @players = Player.where(team_name: @team)
    @start5_setting = Oncourt.new
    
  end
  
  def start5_setting
    @start5_setting = Oncourt.new(start5_params)
    @players = 
    @start5_setting.save
  end
  def time
    @game = Game.last
    @min = params[:min]
    @sec = params[:sec]
    @game.min = @min
    @game.sec = @sec
    if @game.save
    else
      @game.update
    end
  end
  
  def game
    @game = Game.last
    @period = @game.period_time
  end
  
  def game_params
    params.require(:game).permit(:team, :period_time)
  end
  
  def start5_params
    params.require(:oncourt).permit(:team,:p1,:p2,:p3,:p4,:p5)
  end
end
