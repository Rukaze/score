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
    period_time_allsecond = @period.to_i * 60
    start5players_id.each do |s|
      start5player = Changeplayer.new(inplayer: s, clock: period_time_allsecond , game_id: @game.id)
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
  
  def finish
    game = Game.last
    game.score = params[:score].to_i
    game.opp_score = params[:opp_score].to_i
    game.save
  end
  
  def stuts_record
    game = Game.last
    Stut.new(player_id: params[:p_id], player_name: params[:p_name], game_id: game.id, team_name: game.team, 
             playingtime: params[:playing_time].to_i,FGmake: params[:a].to_i + params[:c].to_i,
             FGmiss: params[:b].to_i + params[:d].to_i, Deepmake: params[:c].to_i, Deepmiss: params[:d].to_i, FTmake: params[:e].to_i,
             FTmiss: params[:f].to_i, DefReb: params[:g].to_i, OffReb: params[:h].to_i, Assist: params[:i].to_i,
             Block: params[:j].to_i, steal: params[:k].to_i, TO: params[:l].to_i, PF: params[:m].to_i, 
             point: params[:a].to_i * 2 + params[:c].to_i * 3 +  params[:e].to_i).save
  end
  
  def plays_array
    @play_kinds = ["FGmake","FGmiss","Deepmake","Deepmiss","FTmake","FTmiss","DefReb",
                   "OffReb","Assist","Block","steal","TO","PF"]
  end
  
  def box
    
  end
  
  
  def game_params
    params.require(:game).permit(:team, :period_time,:opp_name)
  end
  
  def start5_params
    params.require(:start5).permit(:team,:p1,:p2,:p3,:p4,:p5)
  end
  
  
end
 