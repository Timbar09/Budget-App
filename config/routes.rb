Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'splash#index'	

  resources :categories, only: %i[index new create] do
    resources :expenses, only: %i[index new create]
  end
end
