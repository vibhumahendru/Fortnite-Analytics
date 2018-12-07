class StatsController < ApplicationController


  def show
    @stat = Stat.find(params[:id])
  end

  def comparison
    @stat = Stat.find(params[:stat_id])
    @player = @stat.player

    render :comparison
  end

  def destroy
    @stat = Stat.find(params[:id])
    @player = Player.find(@stat.player_id)
    @stat.destroy
    redirect_to @player
  end

end
