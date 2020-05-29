class HomeController < ApplicationController
  
  
  
  
  def home
    if current_user
      teams
    end
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
