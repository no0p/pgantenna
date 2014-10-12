Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
	get 'status' => 'home#index', :as => 'status'
	# get 'maintenance' =>
	
	# Authentication
	get 'login' => 'session#new', :as => 'login'
	post 'create_session' => 'session#create', :as => 'create_session'
	get 'logout' => 'session#destroy', :as => 'logout'
	
	
  # Settings	
	get 'settings' => 'admin#settings', :as => 'settings'
	post 'save_settings' => 'admin#save_settings', :as => 'save_settings'
	post 'create_alert_email' => 'admin#create_alert_email', :as => 'create_alert_email'
	delete 'delete_alert_email/:id' => 'admin#delete_alert_email', :as => 'delete_alert_email'
	get 'send_test_email' => 'admin#send_test_email', :as => 'send_test_email'
	post 'save_token' => 'admin#save_token', :as => 'save_token'
	
	# Box, Plot, Alert Customization Facility
	get 'index_plot' => 'editor#index_plot', :as => 'index_plot'
	get 'index_box' => 'editor#index_box', :as => 'index_box'
	get 'index_alert' => 'editor#index_alert', :as => 'index_alert'
	
	get 'new_plot' => 'editor#new_plot', :as => 'new_plot'
	get 'new_box' => 'editor#new_box', :as => 'new_box'
	get 'new_alert' => 'editor#new_alert', :as => 'new_alert'
	
	get 'edit_plot/:id' => 'editor#edit_plot', :as => 'edit_plot'
	get 'edit_box/:id' => 'editor#edit_box', :as => 'edit_box'
	get 'edit_alert/:id' => 'editor#edit_alert', :as => 'edit_alert'
	
	post 'update_plot/:id' => 'editor#update_plot', :as => 'update_plot'
	post 'update_box/:id' => 'editor#update_box', :as => 'update_box'
	post 'update_alert/:id' => 'editor#update_alert', :as => 'update_alert'
	
 	post 'create_plot' => 'editor#create_plot', :as => 'create_plot'
 	post 'create_box' => 'editor#create_box', :as => 'create_box'
 	post 'create_alert' => 'editor#create_alert', :as => 'create_alert'
 	
 	delete 'delete_plot/:id' => 'editor#delete_plot', :as => 'delete_plot'
 	delete 'delete_box/:id' => 'editor#delete_box', :as => 'delete_box'
 	delete 'delete_alert/:id' => 'editor#delete_alert', :as => 'delete_alert'
 	
 	delete 'reset_plots' => 'editor#reset_plots', :as => 'reset_plots'
  delete 'reset_boxes' => 'editor#reset_boxes', :as => 'reset_boxes'
  delete 'reset_alerts' => 'editor#reset_alerts', :as => 'reset_alerts'
end
