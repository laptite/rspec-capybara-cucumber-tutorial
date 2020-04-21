Rails.application.routes.draw do
  devise_for :users
	root to: 'welcome#index'

  namespace :api do 
    resources :achievements, only: [ :index ]
  end

  resources :achievements
end
