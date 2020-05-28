class TeamsController < ApplicationController
  before_action :find_team, only: [:show]
  #[:team_edit, :team_update, :team_page, :team_delete, :player_select]
  def new
    @team = Team.new
  end
  
  def create
    @team = Team.new(team_params)
    @team.user_id = current_user.id
    if @team.save
      flash[:success] = "#{@team.team_name}を登録しました"
      redirect_to reg_path
    else
      @team = Team.new
      flash.now[:danger] = '名前が入ってない又は既に存在してます'
      render 'new'
    end
  end
  
  def show
    @team_name = @team.team_name
    @players = Player.where(team_id: @team.id)
    @player_stuts_array = []
    @players.each do |p|
      @each_game_stuts = Stut.where(player_id: p.id).where('playingtime > 0')
      @play_times = @each_game_stuts.count
      if @play_times == 0
        @play_times = 1
      end
      @stuts = @each_game_stuts.all
      simple_stuts
      stuts_array = [p.position,@mpg,@ppg,@rpg,@apg,"#{@fgp}%","#{@dpp}%","#{@ftp}%"].map(&:to_s)
      @player_stuts_array.push(stuts_array)
    end
    all_games = Game.where(team: @team.id).where.not(score: nil)
    @win = 0
    @lose = 0
    @draw = 0
    all_games.each do |g|
      if g.score > g.opp_score
        @win += 1
      elsif g.score == g.opp_score
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
  
  def details
    @each_game_stuts = Stut.where(player_id: params[:id]).where('playingtime > 0')
    @play_times = @each_game_stuts.count
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
  
  private
  
    def team_params
      params.require(:team).permit(:team_name)
    end
    
    def find_team
      if params[:id]
        @team = Team.find(params[:id])
      else
        @team = Team.find_by(team_name: params[:team_name])
      end
      
      if @team.nil?
        flash[:warning] = "そのチーム名は存在していません"
        redirect_to root_path
      end
    end
    
    def simple_stuts
      @mpg = sum(:playingtime).fdiv(@play_times).fdiv(60).round(1)
      @ppg = per_game(sum(:point))
      @reb = sum(:DefReb) + sum(:OffReb)
      @rpg = per_game(@reb)
      @apg = per_game(sum(:Assist))
      @fg_all = sum(:FGmake) + sum(:FGmiss)
      if  @fg_all == 0
        @fgp = 0
      else
        @fgp = (100 * sum(:FGmake)).fdiv(@fg_all).round(1) 
      end
      @deep_all = sum(:Deepmake) + sum(:Deepmiss)
      if @deep_all == 0
        @dpp = 0
      else
        @dpp = (100 * sum(:Deepmake)).fdiv(@deep_all).round(1) 
      end
      @ft_all= sum(:FTmake) + sum(:FTmiss)
      if @ft_all == 0
        @ftp = 0
      else
        @ftp =  (100 * sum(:FTmake)).fdiv(@ft_all).round(1) 
      end
    end
    
    def detail_stuts
      @orpg = per_game(sum(:OffReb))
      @drpg = per_game(sum(:DefReb))
      @spg = per_game(sum(:steal))
      @bpg = per_game(sum(:Block))
      @fga = per_game(@fg_all)
      @fgm = per_game(sum(:FGmake))
      @dpa = per_game(@deep_all)
      @dpm = per_game(sum(:Deepmake))
      @fta = per_game(@ft_all)
      @ftm = per_game(sum(:FTmake))
      @topg = per_game(sum(:TO))
    end
    
    def per_game(n)
      n.fdiv(@play_times).round(1)
    end
    
    def sum(n)
      @stuts.sum(n)
    end
end
