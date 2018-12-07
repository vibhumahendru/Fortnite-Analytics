class ApplicationController < ActionController::Base

  def session_user
    if session[:player_id]
      Player.find(session[:player_id])
    else
      nil
    end
  end
  #
  # def authorized?
  #   !!session_user
  # end
end
