Rails.application.routes.draw do
  resources :tests, except: [:index, :show, :edit, :destroy]
  resources :tests, only: [:show, :edit] do
    resources :questions, except: [:index, :show]
  end
  # check if I need this
  resources :password_resets

  root 'sessions#new'

  # want to change edit/update/destroy to not have id's for tests/questions

  # Users
  get  '/users/list', to: 'users#index'
  get  '/profile', to: 'users#show'
  get  '/signup', to: 'users#new'
  post '/signedup', to: 'users#create'
  get  '/profile/edit', to: 'users#edit'
  put  '/profile/update', to: 'users#update'
  delete '/profile/delete', to: 'users#destroy'

  # Tests
  get '/home', to: 'tests#index'
  delete '/tests/:id/edit/delete', to: 'tests#destroy', as: 'delete_test'
  get  '/test_results', to: 'tests#index2'
  get  '/test_results/:name', to: 'tests#show2'

  # Questions


  # Project Documentation
  get '/project_documentation/test_plan'

  # Sessions
  get  '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

=begin  
default paths example

get '/hotels', to: 'hotels#index'
get '/hotels/:id', to: 'hotels#show'
get '/hotels/new', to: 'hotels#new'
post '/hotels', to: 'hotels#create'
get '/hotels/:id/edit', to: 'hotels#edit'
put '/hotels/:id', to: 'hotels#update'
delete '/hotels/:id', to: 'hotels#destroy'
=end

end
