class HomeController < ApplicationController
  
  before_action :find_player, only: [:player_edit, :player_update, :player_delete]
  before_action :teamowner, only: [:team_edit, :team_update,:team_delete, :player_select,
                                   :player_edit, :player_update, :player_delete]
  before_action :team_presence, only: [:reg]
  before_action :require_login, only: [:reg,:team_reg,:player_select,:player_edit,:team_edit]
  def index
    @players = Player.all
  end
  
  def home
    if current_user
      teams
    end
  end
  
  def reg
    @player = Player.new
    teams
  end
  
  def create
    @player = Player.new(player_params)
    if @player.save
      flash[:success] = "#{@player.name}を登録しました"
      redirect_to reg_path
    else
      @player = Player.new
      teams
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
  
  
  
  
  
  
  def box
    @game = Game.last
    @players = Player.where(team_id: @game.team)
    @team = Team.find(@game.team)
    @player_stuts_array = []
    @players.each do |p|
      @stuts = Stut.find_by(player_id: p.id, game_id: @game.id)
      box_stuts
      stuts_array = [p.name,p.position,@mts,@pts,@reb,@oreb,@dreb,@ast,@stl,
                     @blk,@fgm,@fga,"#{@fgp}%",@dpm,@dpa,"#{@dpp}%",@ftm,@fta,"#{@ftp}%",
                     @tov,@pf].map(&:to_s)
      @player_stuts_array.push(stuts_array)
    end
  end
  
  
  
  private
  
    def player_params
      params.require(:player).permit(:name,:position,:team_id)
    end
    
    
    
    
    
    def find_player
      @player = Player.find(params[:id])
      @team = Team.find(@player.team_id)
    end
    
    def team_presence
      if Team.last.nil?
        flash[:warning] = "チームを登録してください"
        redirect_to team_reg_path
      end
    end
    
    def box_stuts
      while @stuts.nil? do
        sleep(0.1)
      end
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
      get_shot_percent
      @tov = @stuts.TO
      @pf = @stuts.PF
    end
    
    def get_shot_percent
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
      @fta = @ftm + @stuts.FTmiss
      if @fta == 0
        @ftp = 0
      else
        @ftp =  @ftm.fdiv(@fta).round(3) * 100
      end
    end
    
    
    
    
end
