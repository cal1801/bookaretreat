Rails.application.routes.draw do
  #devise_scope :user do
  #  get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
  #  get "/sign_up" => "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
  #end
  devise_for :users
  resources :camp_types
  resources :camp_infos
  resources :amenities
  resources :site_setups
  resources :images
  resources :contacts
  resources :addresses
  resources :camps do
    collection do
      get 'search'
      get 'all'
      get 'site_index'
    end
    member do
      put 'update_value'
    end
  end

  get '*path' => redirect('/')

  get 'sitemap.xml', :to => 'sitemap#index', :defaults => { :format => 'xml' }

  # The priority is based on order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'camps#index'

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
