Rails.application.routes.draw do
   root to: 'home#home'
   get 'index', to:'home#index'
   get 'reg', to:'home#reg'
   get 'team_reg', to: 'home#team_reg'
   post 'team_create', to: 'home#team_create'
   post 'create', to:'home#create'
   get 'team_page', to:'home#team_page'
   get 'pregame', to:'game#pregame'
   get 'game', to:'game#game'
   post 'game_create', to:'game#game_create'
   resources :employees, only: [:index, :show]
   post 'game/check/:min/:sec' , to:'game#time'
   get 'start5', to:'game#start5'
   get 'game/getplayerInfo/:id', to:'game#player_info'
   post 'game/start5_confirm/:p1id/:p2id/:p3id/:p4id/:p5id', to:'game#start5_confirm'
end
