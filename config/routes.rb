Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only:[:index]
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end
      resources :posts
    end
  end
end
