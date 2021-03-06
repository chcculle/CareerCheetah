CareerCheetah::Application.routes.draw do
  resources :programs do
    resources :phases do
      resources :sections do
        resources :section_steps, :as => :section_step
        resources :cheetah_factor_rankings do
          collection do
            get :first_custom
          end
        end
        resources :career_suggestions
      end
    end
  end

  resources :cheetah_factor_rankings, only: [:create]
  resources :cheetah_factors, only: [:update]
  resources :career_rankings
  resources :user_careers, only: [:update] do
    resources :rate_cheetah_factors, only: [:index, :show, :create, :update]
  end

  resources :user_career_cheetah_factor_rankings

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
    resources :users do
      resources :user_careers, only: [:index]
      resources :career_suggestions, only: [:index]
    end
  end

  root "sessions#new"
end
