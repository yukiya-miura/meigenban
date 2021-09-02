Rails.application.routes.draw do
    root to: 'toppages#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    
    get 'posts', to: 'posts#new'
    post 'posts', to: 'posts#create'
    
    resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
    
    resources :posts, only: [:show, :destroy] do
        resources :comments, only: [:create, :edit, :update, :destroy]
    end
    
end
