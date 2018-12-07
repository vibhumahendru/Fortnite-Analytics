Rails.application.routes.draw do
  resources :stats do
    post '/stats_compare', to: 'stats#comparison', :as => "compare"

  end
  resources :relationships


  # post '/players_save', to: 'players#stat_save', :as => "stat_save"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

resources :players do
  post '/players_save', to: 'players#stat_save', :as => "stat_save"
  post '/players_email', to: 'players#email_send', :as => "mail"
  post '/players_relation', to: 'players#add_follower', :as => "relate"
  post '/players_remove_follower', to: 'players#remove_follower', :as => "remove_follower"
end
get '/login', to: 'sessions#login', :as => "login"
post '/login', to: 'sessions#authorize', :as => "authorize"
post '/logout', to: 'sessions#logout', :as => "logout"

end
