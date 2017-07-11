Rails.application.routes.draw do
  devise_for :users

  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end

  resources :charges, only: [:new, :create, :destroy]

  get '/charges', to: 'charges#destroy', as: :downgrade

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
