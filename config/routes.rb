Rails.application.routes.draw do
  resources :tests
  resources :questions
  resources :users
  resources :password_resets
  root 'users#log_in'
  get '/home', to: 'tests#index'
  get  '/user_list', to: 'users#index'
  get  '/log_in', to: 'users#log_in'
  get  '/sign_up', to: 'users#new'
  get  '/new_test', to: 'tests#new'
  get  '/:name', to: 'tests#show'
  get  '/test_results', to: 'tests#index2'
  get  '/test_results/:name', to: 'tests#show2'
end
