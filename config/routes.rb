CareerCheetah::Application.routes.draw do
  resources :programs do
    resources :phases do
      resources :sections do
        resources :section_steps, :as => :section_step
        resources :cheetah_factor_rankings
        resources :user_careers
      end
    end
  end

  resources :cheetah_factor_rankings, only: [:create]

  resources :response_option_selections
  resource :program_navigation do
    member do
      get "next"
      get "previous"
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  match '/login',  to: 'sessions#new',         via: 'get'
  match '/logout', to: 'sessions#destroy',     via: 'delete'

  namespace :admin do
    resources :programs
    resources :users
  end

  root "sessions#new"
end
