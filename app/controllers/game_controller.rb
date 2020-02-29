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
    
  end
  
  def player_info
    @player = Player.find(params[:id])
    render json: @player
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
  
  
  
  def start5_confirm
    @start5 = Start5.new
    @start5.team = Game.last.team
    @start5.p1 = Player.find(params[:p1id]).id
    @start5.p2 = Player.find(params[:p2id]).id
    @start5.p3 = Player.find(params[:p3id]).id
    @start5.p4 = Player.find(params[:p4id]).id
    @start5.p5 = Player.find(params[:p5id]).id
    @start5.save
  end
  
  def game
    @game = Game.last
    @period = @game.period_time
    s = Start5.last
    @start5players_id = [s.p1,s.p2,s.p3,s.p4,s.p5]
    @start5players = Array.new
    @players = Player.where(team_name: @game.team)
    @start5players_id.each do |pid|
      player =  @players.find(pid)
      @start5players.push(player)
    end
    @reserves = @players.where.not(id: @start5players_id)
  end
  
  def game_params
    params.require(:game).permit(:team, :period_time)
  end
  
  def start5_params
    params.require(:start5).permit(:team,:p1,:p2,:p3,:p4,:p5)
  end
end
