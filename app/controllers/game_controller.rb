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
    start5players_id = [s.p1,s.p2,s.p3,s.p4,s.p5]
    gametime_allsecond = @period.to_i * 60
    start5players_id.each do |s|
      start5player = Changeplayer.new(inplayer: s, clock: gametime_allsecond , game_id: @game.id)
      start5player.save
    end
    @start5players = Array.new
    @players = Player.where(team_name: @game.team)
    start5players_id.each do |pid|
      player =  @players.find(pid)
      @start5players.push(player)
    end
    @reserves = @players.where.not(id: @start5players_id)
  end
  
  def changeplayer_command
    inplayer_id = params[:inPlayer_id]
    outplayer_id = params[:outPlayer_id]
    clock_allsecond = params[:clock].to_i
    changeplayer = Changeplayer.new(inplayer: inplayer_id, outplayer: outplayer_id, 
                                    clock: clock_allsecond, game_id: Game.last.id)
    changeplayer.save
  end
  
  def play_record
    plays_array
    play = @play_kinds[params[:play_id].to_i]
    player = Player.find(params[:player_id])
    Scoring.new(kind: play, player_id: player.id, game_id: Game.last.id).save
  end
  
  def plays_array
    @play_kinds = ["FGmake","FGmiss","3Pmake","3Pmiss","FTmake","FTmiss","DefReb",
                   "OfeReb","Assist","Block","steel","TO","PF"]
  end
  
  def game_params
    params.require(:game).permit(:team, :period_time)
  end
  
  def start5_params
    params.require(:start5).permit(:team,:p1,:p2,:p3,:p4,:p5)
  end
  
  
end
 