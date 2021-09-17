Rails.application.routes.draw do
    root to: 'toppages#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    
    #get 'posts', to: 'posts#new'
    post 'posts', to: 'posts#create'
    
    get 'ranking', to: 'favorites#index'
    
    resources :users, only: [:index, :show, :create, :edit, :update, :destroy]do
        member do
            get :favorites
        end
        end            
    
    resources :posts, only: [:index, :show, :new, :edit, :update, :destroy] do
            resources :comments, only: [:create, :edit, :update, :destroy] 
    end
    
    resources :favorites, only: [:create, :destroy]
    resources :genres, only: [:show]
end
