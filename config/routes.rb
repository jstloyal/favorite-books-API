Rails.application.routes.draw do
  root 'books#index'
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end

  resources :books do
    put :favorite, on: :member
  end
end
