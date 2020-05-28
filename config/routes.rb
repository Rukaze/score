Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'users/new'
  get 'users/create'
  root to: 'home#home'
  get 'index', to:'home#index'
  get 'reg', to:'home#reg'
  post 'create', to:'home#create'
  get 'pregame', to:'game#pregame'
  get 'game', to:'game#game'
  post 'game_create', to:'game#game_create'
  resources :employees, only: [:index, :show]
  post 'game/check/:min/:sec' , to:'game#time'
  get 'start5', to:'game#start5'
  get 'game/getplayerInfo/:id', to:'game#player_info'
  post 'game/start5_confirm/:p1id/:p2id/:p3id/:p4id/:p5id', to:'game#start5_confirm'
  post 'game/finish/:score/:opp_score', to:'game#finish'
  post 'game/stuts_record/:p_id/:p_name/:playing_time/:a/:b/:c/:d/:e/:f/:g/:h/:i/:j/:k/:l/:m', to:'game#stuts_record'
  #get 'home/get_details/:id', to:'home#get_details'
  get 'home/box', to:'home#box'
  
  get 'home/player_select', to:'home#player_select'
  get 'home/player_edit', to:'home#player_edit'
  patch 'home/player_update' , to:'home#player_update'
  patch 'home/player_delete', to:'home#player_delete'
  resources :users, only: [:new, :create]
  get "/login" => "sessions#new"
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  resources :teams do
    member do
      get 'details'
    end
  end
  #get 'team_reg', to: 'home#team_reg'
  #post 'team_create', to: 'home#team_create'
  #get 'home/team_edit', to: 'home#team_edit'
  #patch 'home/team_update' , to:'home#team_update'
  #patch 'home/team_delete', to:'home#team_delete'
  #get 'team_page', to:'home#team_page'
end
