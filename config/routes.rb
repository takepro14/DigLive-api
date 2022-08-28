Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end
      resources :posts
      resources :tags
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
      resources :relationships, only: [:create, :destroy]
    end
  end
end
