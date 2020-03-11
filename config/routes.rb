Rails.application.routes.draw do

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
   delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  root to: 'pages#home'

  resources :projects, only: [:index, :show, :new, :create] do
    resources :reports, only: [:index, :new, :create]
  end

  resources :clients, only: [:index, :new, :create]

  get '/createboard', to: 'tests#createboard'
  get '/getboard', to: 'tests#getboard'
end
