Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, path: '/', constraints: { subdomain: 'api' } do
  		resources :events
	end

  root "home#index"
end