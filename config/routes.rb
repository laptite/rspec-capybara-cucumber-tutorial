Rails.application.routes.draw do
  devise_for :users
	root to: 'welcome#index'

  namespace :api do 
    resources :achievements, only: [:index]
  end

  resources :achievements do 
    resources :encouragements, only: [:new, :create]
  end
end
