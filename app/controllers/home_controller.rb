class HomeController < ApplicationController
  def index
    @players = Player.all
  end
  
  def home
    @teams = Team.all
    
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
  
  def team_page
    @team = Team.find_by(id: params[:id])
    @players = Player.where(team_name: @team.team_name)
    @player_stuts_array = []
    @players.each do |p|
      each_game_stuts = Stut.where(player_id: p.id)
      play_times = each_game_stuts.where('playingtime > 0').count
      stuts = each_game_stuts.all
      mpg = stuts.sum(:playingtime).fdiv(play_times).fdiv(60).round(1)
      ppg = stuts.sum(:point).fdiv(play_times).round(1)
      reb = stuts.sum(:DefReb) + stuts.sum(:OffReb)
      rpg = reb.fdiv(play_times).round(1)
      apg = stuts.sum(:Assist).fdiv(play_times).round(1)
      fg_all = stuts.sum(:FGmake) + stuts.sum(:FGmiss)
      if  fg_all == 0
        fgp = 0
      else
        fgp = stuts.sum(:FGmake).fdiv(fg_all).round(3) * 100
      end
      deep_all = stuts.sum(:Deepmake) + stuts.sum(:Deepmiss)
      if deep_all == 0
        dgp = 0
      else
        dgp = stuts.sum(:FGmake).fdiv(deep_all).round(3) * 100
      end
      ft_all= stuts.sum(:FTmake) + stuts.sum(:FTmiss)
      if ft_all == 0
        ftp = 0
      else
        ftp =  stuts.sum(:FTmake).fdiv(ft_all).round(3) * 100
      end
      stuts_array = [p.position,mpg.to_s,ppg.to_s,rpg.to_s,apg.to_s,"#{fgp.to_s}%","#{dgp.to_s}%","#{ftp.to_s}%"]
      @player_stuts_array.push(stuts_array)
    end
  end
  
  def get_details
    each_game_stuts = Stut.where(player_id: params[:id])
    
      play_times = each_game_stuts.where('playingtime > 0').count
      stuts = each_game_stuts.all
      mpg = stuts.sum(:playingtime).fdiv(play_times).fdiv(60).round(1)
      ppg = stuts.sum(:point).fdiv(play_times).round(1)
      reb = stuts.sum(:DefReb) + stuts.sum(:OffReb)
      rpg = reb.fdiv(play_times).round(1)
      orpg = stuts.sum(:OffReb).fdiv(play_times).round(1)
      drpg = stuts.sum(:DefReb).fdiv(play_times).round(1)
      apg = stuts.sum(:Assist).fdiv(play_times).round(1)
      spg = stuts.sum(:steal).fdiv(play_times).round(1)
      bpg = stuts.sum(:Block).fdiv(play_times).round(1)
      fg_all = stuts.sum(:FGmake) + stuts.sum(:FGmiss)
      fga = fg_all.fdiv(play_times).round(1)
      fgm = stuts.sum(:FGmake).fdiv(play_times).round(1)
      if  fg_all == 0
        fgp = 0
      else
        fgp = stuts.sum(:FGmake).fdiv(fg_all).round(3) * 100
      end
      deep_all = stuts.sum(:Deepmake) + stuts.sum(:Deepmiss)
      dpa = deep_all.fdiv(play_times).round(1)
      dpm = stuts.sum(:Deepmake).fdiv(play_times).round(1)
      if deep_all == 0
        dgp = 0
      else
        dgp = stuts.sum(:FGmake).fdiv(deep_all).round(3) * 100
      end
      ft_all= stuts.sum(:FTmake) + stuts.sum(:FTmiss)
      fta = ft_all.fdiv(play_times).round(1)
      ftm = stuts.sum(:FTmake).fdiv(play_times).round(1)
      if ft_all == 0
        ftp = 0
      else
        ftp =  stuts.sum(:FTmake).fdiv(ft_all).round(3) * 100
      end
      topg = stuts.sum(:TO).fdiv(play_times).round(1)
      stuts_array = [stuts.last.player_name,mpg.to_s,ppg.to_s,rpg.to_s,orpg.to_s,drpg.to_s,apg.to_s,spg.to_s,bpg.to_s,
                     fga.to_s,fgm.to_s,"#{fgp.to_s}%",dpa.to_s,dpm.to_s,"#{dgp.to_s}%",fta.to_s,ftm.to_s,"#{ftp.to_s}%",
                     topg.to_s]
      render json: stuts_array
  end
  def player_params
    params.require(:player).permit(:name,:position,:team_name)
  end
  
  def team_params
    params.require(:team).permit(:team_name)
  end
end
