module HomeHelper
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
      @fgp = (100 * @stuts.sum(:FGmake)).fdiv(@fg_all).round(1) 
    end
    @deep_all = @stuts.sum(:Deepmake) + @stuts.sum(:Deepmiss)
    if @deep_all == 0
      @dpp = 0
    else
      @dpp = (100 * @stuts.sum(:Deepmake)).fdiv(@deep_all).round(1) 
    end
    @ft_all= @stuts.sum(:FTmake) + @stuts.sum(:FTmiss)
    if @ft_all == 0
      @ftp = 0
    else
      @ftp =  (100 * @stuts.sum(:FTmake)).fdiv(@ft_all).round(1) 
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
end
