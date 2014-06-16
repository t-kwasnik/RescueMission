Rails.application.routes.draw do
  resources :questions

  resources :questions do
    resources :answers, only: [:create, :update]
  end

  get '/auth/github/callback', to: 'sessions#create'

  resources :sessions, only: [:destroy]

end
