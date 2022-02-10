Rails.application.routes.draw do
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
  # get  '/test/question/question:id', to: 'questions#new', as 'newquestion'
  # get  '/test/question/question:id', to: 'questions#edit', as: 'editquestion'
  # get  '/:name', to: 'tests#show'
  get  '/test_results', to: 'tests#index2'
  get  '/test_results/:name', to: 'tests#show2'
end
