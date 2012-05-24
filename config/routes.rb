Teletrack::Application.routes.draw do
  
  root :to => "sessions#new"
  
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "staffs#new", :as => "sign_up"
  
  resources :staffs
  resources :sessions
	
  resources :tickets	
  
  resources :notes

  resources :statuses

  resources :priorities

  resources :components

  resources :types
    
  match '/mobile' => 'mobile#index'
  
  match '/dociphone' => 'dociphone#index'  
   
  match '/documentation' => 'documentation#index'
  
  match '/jqueryfiletree' => 'jqueryfiletree#content'

  match '/admin' => 'admin#index'  
  match '/admin/backup_data' => 'admin#backup_data'    
  match '/admin/backup_app' => 'admin#backup_app'     
  
  match '/:controller(/:action(/:id))'
  
end
