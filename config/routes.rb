Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/get_all_latlong_for_current_user' => 'home#get_all_latlong_for_current_user',:as => :get_all_latlong_for_current_user
  get '/share_location' => 'home#share_location',:as => :share_location
  post '/save_shared_location' => 'home#save_shared_location',:as => :save_shared_location
  get '/:username' => 'home#user_show',:as => :user_show

end
