class HomeController < ApplicationController
  def index
    @players = Player.all
  end
  
  def reg
  end
end
