Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    namespace :api do
      namespace :v1 do
        resources :users, :only => [:index, :show, :update, :create, :destroy] do
          
        end
        get 'typeahead/:input' => 'users#typeahead'
                # get 'prescriptions/:id' => "tazors#prescription"


      end    
    end
end
