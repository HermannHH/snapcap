Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "landing#index"

  resources :nodes, param: :token do
    resources :file_stores, param: :token, module: :nodes
  end
end
