Rails.application.routes.draw do
  resources :users
  resources :password_resets
  root 'users#index'
  get  '/user_list', to: 'users#index'
  get  '/log_in', to: 'users#log_in'
  get  '/sign_up', to: 'users#new'
  # pages to create
  # (create a test) (questions on test) (list of tests) (test results for admin and users) (page before test begins)
end
