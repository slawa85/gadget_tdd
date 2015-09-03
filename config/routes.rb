Rails.application.routes.draw do
  devise_for :users

  resources :gadgets do
    collection do
      get :search
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
end
