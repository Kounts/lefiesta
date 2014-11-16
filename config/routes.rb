Rails.application.routes.draw do

resources :events do
	resources :guests, :tasks, :contacts, :shopping_items
end
  root 'welcome#index'
end
