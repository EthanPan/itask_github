Itask::Application.routes.draw do  
  devise_for :users

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => "course_years#index"
  # match 'login', :to => 'devise#sign_in', :as => 'signin'
  # match 'logout', :to => 'devise#logout', :as => 'signout'
  #match 'account/register', :to => 'account#register', :via => [:get, :post], :as => 'register'
  match 'manage', :to => 'manage#index'
  match 'attachments/download/:id/:filename', :controller => 'attachments', :action => 'download', :id => /\d+/, :filename => /.*/, :via => :get
  match 'attachments/download/:id', :controller => 'attachments', :action => 'download', :id => /\d+/, :via => :get
    # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :events
  resources :users do
    member do
      get 'assignments'
      get 'courses'
    end
  end
  resources :course_years do
    member do
      get 'apply'
      get 'manage'
    end
     resources :assignments

  end
  resources :user_course_years do
    member do
      get 'approve'
    end
  end
  resources :assignments do
     resources :student_course_assignments do
		member do 
		  get 'grade'
		  put 'grade'
		end
	 end

  end
  resources :student_course_assignments

  resources :attachments  do
      member do
        get 'download'
      end
  end
  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
