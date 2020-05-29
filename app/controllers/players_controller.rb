class PlayersController < ApplicationController
  before_action :team, only: [:new,:create,:show,:edit,:destroy,:update,:index]
  before_action :find_player, only: [:edit, :update, :destroy]
  before_action :teamowner, only: [:edit, :update,:delete]
  before_action :require_login
  
  def new
    @player = Player.new
  end
  
  def create
    @player = Player.new(player_params)
    @player.team_id = @id
    if @player.save
      flash[:success] = "#{@player.name}を登録しました"
      redirect_to team_path(id: @id)
    else
      @player = Player.new
      team
      flash.now[:danger] = '名前が入ってない又はチーム内で被ってます'
      render 'new'
    end
  end
  
  def edit
  end
  
  def index
    @players = Player.where(team_id: @id)
  end
  
  def update
    @player.update!(player_params)
    flash[:success] = '名前とポジションを変更しました'
    redirect_to team_path(id: @id)
  rescue
    flash[:danger] = '名前が入ってない又は既に存在してます'
    redirect_to edit_team_player_path(team_id: @id,id: @player.id)
  end
  
  
  def destroy
    @player.destroy
    flash[:success] = 'プレイヤーを削除しました'
    redirect_to team_path(id: @id)
  end
  
  private
  
    def player_params
      params.require(:player).permit(:name,:position)
    end
    
    def team
      @team = Team.find(params[:team_id])
      @id = @team.id
    end
    
    def find_player
      @player = Player.find(params[:id])
    end
end
