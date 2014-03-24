Seddit::Application.routes.draw do
  root to: "static_pages#index"
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]

  resources :sub_seddits, only: [:new, :create, :show, :index], path: "s" do
    resources :posts, only: [:new, :create]
  end
  resources :posts, only: [:show] do
    resources :comments, only: [:new, :create]
  end
  resources :comments, only: [:show] do
    resources :comments, only: [:new, :create]
  end

  resources :votes, only: [:create, :update]

  namespace :api, :defaults => { :format => :json } do
    resources :sub_seddits, only: [:index, :show, :create], path: "s" do
      resources :posts, only: [:index]
    end
    resources :posts, only: [:show, :create] do
      resources :comments, only: [:index, :create]
    end
    resources :comments, only: [:show, :create] do
      resources :comments, only: [:create]
    end

    resources :votes, only: [:create, :update, :destroy]
  end
end
