Rails.application.routes.draw do

authenticated :user do
	root :to => "events#index", :as => "authenticated_root"
  end

  root 'welcome#index'

  devise_for :users
resources :events do
	resources :guests, :tasks, :contacts, :shopping_items
end

end
