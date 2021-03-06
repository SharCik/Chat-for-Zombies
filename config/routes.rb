Rails.application.routes.draw do
  

  devise_for :users


  resources :users
  match '/profile_update',  to: 'users#update',            via: 'get'
  match '/profile_edit',  to: 'users#edit',            via: 'get'
  match '/profile',  to: 'users#show',            via: 'get'
  match '/inbox', to: 'users#list_conversations',       via: 'post' ,    defaults:{ format: 'js' }
  match '/unread', to: 'users#unread',       via: 'post' ,    defaults:{ format: 'js' }
  match '/delete', to: 'users#delete_dialog',       via: 'post' ,    defaults:{ format: 'js' }
  match '/delete_selected', to: 'conversations#destroy',       via: 'post' ,    defaults:{ format: 'js' }
  match '/favarite', to: 'favorites#add',       via: 'get'
  match '/del_from_favarite', to: 'favorites#delete',       via: 'get' 
  authenticated :user do
    root 'users#index'
  end

  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  resources :conversations do
    resources :messages
  end


  
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
