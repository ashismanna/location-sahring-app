Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  #restFull routing

  resources :locations do
  	collection do
  		post :save_shared_location
  		get :share_location
  	end
  end

  resources :users do
  	collection do
  		get :get_all_latlong_details
  	end
  end
end
