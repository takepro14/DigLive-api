Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        get :search, on: :collection
      end
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end
      resources :posts do
        get :search, on: :collection
      end
      resources :tags, only: [:index]
      resources :genres, only: [:index]
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
      resources :relationships, only: [:create, :destroy]
      resources :notifications, only: :index do
        put :update_all, on: :collection
        get :count_all, on: :collection
      end
      resources :tasks, only: :index
    end
  end
end
