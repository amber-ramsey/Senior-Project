Rails.application.routes.draw do
  resources :tests, except: [:index, :show, :edit, :destroy]
  
  resources :tests, only: [:edit] do
    resources :questions, except: [:index, :show]
  end

  resources :test_responses, only: [:destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  root 'sessions#new'

  # want to change edit/update/destroy to not have id's for tests/questions

  # Users
  get  '/users/list', to: 'users#index'
  get  '/profile', to: 'users#show'
  get  '/signup', to: 'users#new'
  post '/signedup', to: 'users#create'
  get  '/profile/edit', to: 'users#edit'
  patch  '/profile/update', to: 'users#update'
  delete '/profile/delete', to: 'users#destroy'

  # Tests
  get '/home', to: 'tests#index'
  get '/tests/:id', to: 'tests#show', as: 'take_test'
  post '/tests/:id', to: 'test_response#create', as: 'test_responses'
  delete '/tests/:id/edit/delete', to: 'tests#destroy', as: 'delete_test'
  get  '/test_results', to: 'tests#result_index'
  get  '/test_results/:id', to: 'tests#result'

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
