Rails.application.routes.draw do
  get 'schools/index'

  get 'stuff/index'
   get 'admin' => 'school_admins#index'

  get 'approve' => 'school_admins#approve'

  get 'about' => 'static_pages#about'

  get 'contact' => 'static_pages#contact'

  get 'schools/new'

  get 'schools/edit'

  get  'schools/show'

  get 'schools/all'

  get 'schools/states'

  get 'nearby_schools' => 'schools#schools_near_you'

  get 'school_admins/destroy'

  get 'search' => 'schools#search'

  get 'signup' => 'users#new'

  get 'login' => 'sessions#new' #path to log in form for creating a new new session, becomes login_path

  post 'login' => 'sessions#create' #path to actually log in, and create a new session for the user

  get 'logout' => 'sessions#destroy' #path to destroy a user session when they log out or after some time

  get 'primary' => 'schools#primary_schools'

  get 'secondary' => 'schools#secondary_schools'

  get 'primary_and_secondary' => 'schools#primary_and_secondary_schools'

  get 'universities' => 'schools#universities'

  get 'creches' => 'schools#creches'
  root'schools#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
