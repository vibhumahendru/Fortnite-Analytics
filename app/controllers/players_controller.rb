class PlayersController < ApplicationController

  def index
    @players = Player.all
    @session_user = session_user
  end

  # def send_to_login
  #   if !authorized?
  #     redirect_to login_path
  #   end
  # end

  def show
    @player = Player.find(params[:id])
    @session_user = session_user
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.create(player_params)
    redirect_to login_path
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    @player.update(player_params)
    redirect_to @player
  end

  def stat_save
    Time.zone = 'Eastern Time (US & Canada)'

    @player = Player.find(params[:player_id])
    @stat = Stat.create(player_id: params[:player_id], total_wins: @player.total_wins, total_kills: @player.total_kills, total_matches: @player.total_matches, kill_death_ratio: @player.kd_ratio, rank: @player.rank, current_time: Time.zone.now)
    redirect_to @player
  end

  def email_send
    @player = Player.find(params[:player_id])
    @player.mail_my_stats
    flash[:email] = "Email Sent!"
    redirect_to @player
  end

  def show_save_stat

  end

  def add_follower
    @player = Player.find(params[:player_id])

  @relation =   Relationship.create(follower_id: session[:player_id], followed_id: @player.id )
  redirect_to @player
  end

  def remove_follower
    @player = Player.find(params[:player_id])
    @relation = Relationship.find_by(follower_id: session[:player_id], followed_id: @player.id)
    @relation.delete
    redirect_to @player
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to players_path
  end

private

  def player_params
    params.require(:player).permit(:full_name, :player_id, :email, :username, :console_type)
  end

end
