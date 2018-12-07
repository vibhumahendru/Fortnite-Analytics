class SessionsController < ApplicationController

  def login
    render layout: 'login'
  end

  def authorize
    if Player.find_by(username: params[:username])
      @player = Player.find_by(username: params[:username])
      session[:player_id] = @player.id
      redirect_to players_path
    else
      flash[:bad_user] = "Username Not Found, try again!"
      redirect_to login_path
    end
  end

  def logout
    session[:player_id] = nil
    redirect_to login_path
  end

end
