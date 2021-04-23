Rails.application.routes.draw do
  resources :articles
  get 'notes/search', action: :search, controller: 'notes'
  post 'notes/:id/likes', to: 'notes#like', as: 'note_like'
  # resources :comments
  devise_for :users
  resources :notes
  root "notes#index"
  resources :notes do 
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
