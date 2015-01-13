Rails.application.routes.draw do

authenticated :user do
	root :to => "users#show", :as => "authenticated_root"
  end

  root 'welcome#index'

  devise_for :users
  resources :users, only: [:show]
  
resources :events do
	resources :guests, :tasks, :contacts, :shopping_items
end

resources :guests do
  member do
    patch 'set_attending'
  end
end

resources :tasks do
  member do
    patch 'set_done'
  end
end

resources :shopping_items do
  member do
    patch 'set_bought'
  end
end

end
