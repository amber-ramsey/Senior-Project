Rails.application.routes.draw do
  get 'project_documentation/test_plan'
  get 'session/new'
  resources :tests
  resources :questions
  resources :users
  resources :password_resets

  resources :users do
    resources :tests do
      resources :questions
    end
  end

  root 'sessions#new'
  get '/home', to: 'tests#index'
  get  '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get  '/signup', to: 'users#new'
  get  '/test', to: 'tests#new'
  get  '/test_results', to: 'tests#index2'
  get  '/test_results/:name', to: 'tests#show2'

end
