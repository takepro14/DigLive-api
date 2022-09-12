Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end
      resources :posts
      resources :tags, only: [:index]
      resources :genres, only: [:index]
      resources :comments, only: [:create, :destroy]
      resources :board_comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
      resources :relationships, only: [:create, :destroy]
      resources :boards
    end
  end
end
