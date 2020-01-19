class GameController < ApplicationController
  def pregame
    @teams = Team.all
    @game_setting = Game.new
  end
  
  def game_create
    @game_setting = Game.new(game_params)
    @game_setting.save
    redirect_to game_path
  end
  
  def game
    @game = Game.last
    gon.period = @game.period_time
  end
  
  def game_params
    params.require(:game).permit(:team, :period_time)
  end
end
