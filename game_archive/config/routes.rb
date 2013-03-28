GameArchive::Application.routes.draw do

	get "users/manage"
	post "users/update"
	
	get "search/query"
	post "search/result"

	devise_for :users, skip: :registrations
	devise_scope :user do
		resource :registration,
					 only: [:edit, :update],
					 path: 'users',
					 controller: 'devise/registrations',
					 as: :user_registration do
		end
	end

	resources :companies, :except => :destroy do
		member do
			get 'report' => 'companies#new_report'
			post 'report' => 'companies#create_report'
		end
	end 
	get "companies/:id/version/:version" => "companies#show_version", :as => "company_version"
	post "companies/:id/version/:version" => "companies#restore_version", :as => "restore_company_version"

	resources :developers, :except => :destroy do
		member do
			get 'report' => 'developers#new_report'
			post 'report' => 'developers#create_report'
		end
	end
	get "developers/:id/version/:version" => "developers#show_version", :as => "developer_version"
	post "developers/:id/version/:version" => "developers#restore_version", :as => "restore_devloper_version"

	resources :games, :except => :destroy do
		member do
			get 'report' => 'games#new_report'
			post 'report' => 'games#create_report'
		end
	end 
	get "games/:id/version/:version" => "games#show_version", :as => "game_version"
	post "games/:id/version/:version" => "games#restore_version", :as => "restore_game_version"
	


	
	resources :reportblockcontents, only: [:index, :destroy]

	resources :tokenlists, only: [:index]
	
	resources :genres do
			member do
			get 'join'
		end
	end
	resources :tags do
			member do
			get 'join'
		end
	end
	resources :media do
			member do
			get 'join'
		end
	end		
	resources :modes do
			member do
			get 'join'
		end
	end
	resources :platforms do
			member do
			get 'join'
		end
	end

	resources :about, only: [:index]
	
	# The priority is based upon order of creation:
	# first created -> highest priority.

	# Sample of regular route:
	#		match 'products/:id' => 'catalog#view'
	# Keep in mind you can assign values other than :controller and :action

	# Sample of named route:
	#		match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
	# This route can be invoked with purchase_url(:id => product.id)

	# Sample resource route (maps HTTP verbs to controller actions automatically):
	#		resources :products

	# Sample resource route with options:
	#		resources :products do
	#			member do
	#				get 'short'
	#				post 'toggle'
	#			end
	#
	#			collection do
	#				get 'sold'
	#			end
	#		end

	# Sample resource route with sub-resources:
	#		resources :products do
	#			resources :comments, :sales
	#			resource :seller
	#		end

	# Sample resource route with more complex sub-resources
	#		resources :products do
	#			resources :comments
	#			resources :sales do
	#				get 'recent', :on => :collection
	#			end
	#		end

	# Sample resource route within a namespace:
	#		namespace :admin do
	#			# Directs /admin/products/* to Admin::ProductsController
	#			# (app/controllers/admin/products_controller.rb)
	#			resources :products
	#		end

	# You can have the root of your site routed with "root"
	# just remember to delete public/index.html.
	authenticated :user do
		root :to => 'home#index'
	end
	root :to => 'home#index'

	# See how all your routes lay out with "rake routes"

	# This is a legacy wild controller route that's not recommended for RESTful applications.
	# Note: This route will make all actions in every controller accessible via GET requests.
	# match ':controller(/:action(/:id))(.:format)'

	match '/ajax', :controller => 'ajax', :action => 'get'

end
