Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  get 'tags/index'
  namespace :api do
    namespace :v1 do
      resources :users, only:[:index]
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end
      resources :posts
      resources :tags
      resources :comments, only: [:create, :destroy]
    end
  end
end
