Rails.application.routes.draw do

  # Admin
  ActiveAdmin.routes(self)

  # Resources
  resources :events do
    resources :enrollments, only: [:edit, :create]
  end
  resources :memberships
  resources :organizations, only: [:switch] do
    post :switch, on: :member
  end
  resource  :profile, only: [:show]

  # Sessions
  get    :login,  to: 'sessions#new'
  post   :login,  to: 'sessions#create'
  delete :logout, to: 'sessions#destroy'

  # Static pages
  controller :pages do
    get :about
    get :help
  end

  root to: 'events#index'

end
