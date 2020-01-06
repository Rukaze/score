Rails.application.routes.draw do
   root to: 'home#index'
   get 'reg', to:'home#reg'
end
