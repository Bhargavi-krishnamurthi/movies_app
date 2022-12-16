Rails.application.routes.draw do
  
  
  # get '/movies', to: 'movies#index'
  # get '/movies/new', to:'movies#new'
  # get '/movies/:id', to: 'movies#show', as: 'movie'
  # get '/movies/:id/edit', to: 'movies#edit', as: 'edit_movie'
  # patch '/movies/:id', to: 'movies#update'
  # post '/movies', to: 'movies#create'
  # delete '/movies/:id', to: 'movies#destroy'
  get 'session/create'
  root to: 'movies#index'
  get 'movies/filter/:filter', to: 'movies#index', as: :filtered_movies
  resources :movies do
    resources :reviews
    resources :favs, only: [:create]
  end
  
  get 'sign_up', to:'users#new'
  resources :users, except: [:new]

  resource :session, only: [:create,:destroy]
  get '/sign_in', to:'sessions#new', as: :sign_in
  get '/sign_out',to: 'sessions#sign_out', as: :sign_out
  
  # resources :favs, only: [:destroy]
  delete 'movies/:id/favs', to: 'favs#destroy'

end


# get 'session/create'
#   get '/sign_in', to: 'session#new'
#   root to: 'movies#index'
#   resources :users, except: [:new]
#   get '/sign_up', to: 'users#new'
#   resources :movies do
#     resources :reviews
#   end

#   resources :reviews, only: [:destroy]

#   resources :session, only: [:create, :destroy]
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html