Rails.application.routes.draw do

  root 'welcome#index'

  devise_for :users
resources :events do
	resources :guests, :tasks, :contacts, :shopping_items
end

end
