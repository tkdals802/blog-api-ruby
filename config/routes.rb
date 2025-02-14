Rails.application.routes.draw do
  get "categories/index"
  get "categories/show"
  get "categories/create"
  get "categories/destroy"
  get "tags/index"
  get "tags/show"
  get "tags/create"
  get "tags/destroy"
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :api do
    resources :users, only: [:index, :show ,:create ,:update ,:destroy] do
      post 'login', on: :collection
    end
    resources :articles do
      post 'tags', to: 'articles#add_tags'
      get 'tags', to: 'articles#show_tags'
      collection do
        get 'search', to: 'articles#search'
      end
    end

    resources :tags do
      get 'articles', to: 'tags#show_articles'
    end

    resources :categories do
    end
  end
end
