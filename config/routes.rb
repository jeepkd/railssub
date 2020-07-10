Rails.application.routes.draw do
  get 'pages/home'
  resources :accounts

  constraints(subdomain: /.+/) do
    # root to: 'accounts#show'
    get '/', to: 'accounts#show'
  end
  root to: 'pages#home'

end
