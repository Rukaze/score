class HomeController < ApplicationController
  before_action :find_team, only: [:team_edit, :team_update, :team_page, :team_delete, :player_select]
  before_action :find_player, only: [:player_edit, :player_update, :player_delete]
  before_action :team_presence, only: [:reg]
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
    if @player.save
      flash[:success] = "#{@player.name}を登録しました"
      redirect_to reg_path
    else
      @player = Player.new
      @teams = Team.all
      flash.now[:danger] = '名前が入ってない又はチーム内で被ってます'
      render 'reg'
    end
  end
  
  def player_select
    @players = Player.where(team_id: @team.id)
  end
  
  def player_edit
  end
  
  def player_update
    @player.update!(player_params)
    flash[:success] = '名前とポジションを変更しました'
    redirect_to team_page_path(id: @player.team_id)
  rescue
    flash[:danger] = '名前が入ってない又は既に存在してます'
    redirect_to home_player_edit_path(id: @player.id)
  end
  
  def player_delete
    team_id = @player.team_id
    @player.destroy
    flash[:success] = 'プレイヤーを削除しました'
    redirect_to team_page_path(id: team_id)
  end
  
  
  def team_reg
    @team = Team.new
  end
  
  def team_create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "#{@team.team_name}を登録しました"
      redirect_to reg_path
    else
      @team = Team.new
      flash.now[:danger] = '名前が入ってない又は既に存在してます'
      render 'team_reg'
    end
  end
  
  def team_edit
  end
  
  def team_update
    @team.update!(team_params)
    flash[:success] = 'チーム名を変更しました'
    redirect_to team_page_path(id: @team.id)
  rescue
    flash[:danger] = '名前が入ってない又は既に存在してます'
    redirect_to home_team_edit_path(id: @team.id)
  end
  
  def team_delete
    @team.destroy
    flash[:success] = 'チームを削除しました'
    redirect_to root_path
  end
  
  
  def team_page
    @team_name = @team.team_name
    @players = Player.where(team_id: @team.id)
    @player_stuts_array = []
    @players.each do |p|
      @each_game_stuts = Stut.where(player_id: p.id)
      @play_times = @each_game_stuts.where('playingtime > 0').count
      if @play_times == 0
        @play_times = 1
      end
      @stuts = @each_game_stuts.all
      simple_stuts
      stuts_array = [p.position,@mpg,@ppg,@rpg,@apg,"#{@fgp}%","#{@dpp}%","#{@ftp}%"].map(&:to_s)
      @player_stuts_array.push(stuts_array)
    end
    all_games = Game.where(team: @team.id)
    @win = 0
    @lose = 0
    @draw = 0
    all_games.each do |a|
      if a.score > a.opp_score
        @win += 1
      elsif a.score == a.opp_score
        @draw += 1
      else
        @lose += 1
      end
    end
    if all_games.length <= 5
      @games = all_games
    else
      @games = all_games[-5..-1]
    end
  end
  
  def get_details
    @each_game_stuts = Stut.where(player_id: params[:id])
    @play_times = @each_game_stuts.where('playingtime > 0').count
    @stuts = @each_game_stuts.all
    player_name = Player.find(params[:id]).name
    if @play_times == 0
      @play_times = 1
    end
    simple_stuts
    detail_stuts
    stuts_array = [player_name,@mpg,@ppg,@rpg,@orpg,@drpg,@apg,@spg,@bpg,
                   @fga,@fgm,"#{@fgp}%",@dpa,@dpm,"#{@dpp}%",@fta,@ftm,"#{@ftp}%",
                   @topg].map(&:to_s)

    render json: stuts_array
  end
  
  
  def box
    sleep(0.1)
    @game = Game.last
    @players = Player.where(team_id: @game.team)
    @team = Team.find(@game.team)
    @player_stuts_array = []
    @players.each do |p|
      @stuts = Stut.find_by(player_id: p.id, game_id: @game.id)
      box_stuts
      stuts_array = [p.name,p.position,@mts,@pts,@reb,@oreb,@dreb,@ast,@stl,
                     @blk,@fgm,@fga,"#{@fgp}%",@dpm,@dpm,"#{@dpp}%",@ftm,@fta,"#{@ftp}%",
                     @tov,@pf].map(&:to_s)
      @player_stuts_array.push(stuts_array)
    end
  end
  
  def box_stuts
    @mts = @stuts.playingtime.fdiv(60).round(1)
    @pts = @stuts.point
    @oreb = @stuts.OffReb
    @dreb = @stuts.DefReb
    @reb = @oreb + @dreb
    @ast = @stuts.Assist
    @stl = @stuts.steal
    @blk = @stuts.Block
    @fgm = @stuts.FGmake
    @fga = @fgm + @stuts.FGmiss
    
    if  @fga == 0
      @fgp = 0
    else
      @fgp = @fgm.fdiv(@fga).round(3) * 100
    end
    @dpm = @stuts.Deepmake
    @dpa = @dpm + @stuts.Deepmiss
    if @dpa == 0
      @dpp = 0
    else
      @dpp = @dpm.fdiv(@dpa).round(3) * 100
    end
    @ftm = @stuts.FTmake
    @fta = @ftm + @stuts.FGmiss
    if @fta == 0
      @ftp = 0
    else
      @ftp =  @ftm.fdiv(@fta).round(3) * 100
    end
    @tov = @stuts.TO
    @pf = @stuts.PF
  end
  
  
  def simple_stuts
    @mpg = @stuts.sum(:playingtime).fdiv(@play_times).fdiv(60).round(1)
    @ppg = @stuts.sum(:point).fdiv(@play_times).round(1)
    @reb = @stuts.sum(:DefReb) + @stuts.sum(:OffReb)
    @rpg = @reb.fdiv(@play_times).round(1)
    @apg = @stuts.sum(:Assist).fdiv(@play_times).round(1)
    @fg_all = @stuts.sum(:FGmake) + @stuts.sum(:FGmiss)
    if  @fg_all == 0
      @fgp = 0
    else
      @fgp = @stuts.sum(:FGmake).fdiv(@fg_all).round(3) * 100
    end
    @deep_all = @stuts.sum(:Deepmake) + @stuts.sum(:Deepmiss)
    if @deep_all == 0
      @dpp = 0
    else
      @dpp = @stuts.sum(:FGmake).fdiv(@deep_all).round(3) * 100
    end
    @ft_all= @stuts.sum(:FTmake) + @stuts.sum(:FTmiss)
    if @ft_all == 0
      @ftp = 0
    else
      @ftp =  @stuts.sum(:FTmake).fdiv(@ft_all).round(3) * 100
    end
  end
  
  def detail_stuts
    @orpg = @stuts.sum(:OffReb).fdiv(@play_times).round(1)
    @drpg = @stuts.sum(:DefReb).fdiv(@play_times).round(1)
    @spg = @stuts.sum(:steal).fdiv(@play_times).round(1)
    @bpg = @stuts.sum(:Block).fdiv(@play_times).round(1)
    @fga = @fg_all.fdiv(@play_times).round(1)
    @fgm = @stuts.sum(:FGmake).fdiv(@play_times).round(1)
    @dpa = @deep_all.fdiv(@play_times).round(1)
    @dpm = @stuts.sum(:Deepmake).fdiv(@play_times).round(1)
    @fta = @ft_all.fdiv(@play_times).round(1)
    @ftm = @stuts.sum(:FTmake).fdiv(@play_times).round(1)
    @topg = @stuts.sum(:TO).fdiv(@play_times).round(1)
  end
  
  private
  
    def player_params
      params.require(:player).permit(:name,:position,:team_id)
    end
    
    def team_params
      params.require(:team).permit(:team_name)
    end
    
    def find_team
      @team = Team.find(params[:id])
    end
    
    def find_player
      @player = Player.find(params[:id])
    end
    
    def team_presence
      if Team.last.nil?
        flash[:warning] = "チームを登録してください"
        redirect_to team_reg_path
      end
    end
end
