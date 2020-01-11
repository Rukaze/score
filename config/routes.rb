Rails.application.routes.draw do
   root to: 'home#home'
   get 'index', to:'home#index'
   get 'reg', to:'home#reg'
   get 'team_reg', to: 'home#team_reg'
   post 'team_create', to: 'home#team_create'
   post 'create', to:'home#create'
   get 'team_page', to:'home#team_page'
end
