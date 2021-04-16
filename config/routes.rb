Rails
  .application
  .routes
  .draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    devise_for :users,
               sign_out_via: %i[get delete],
               controllers: {
                 omniauth_callbacks: 'users/omniauth_callbacks',
               }

    # Session management.
    get '/sign_in', to: 'sessions#sign_in_form'

    # post '/sign_in', to: 'sessions#send_sign_in_mail'
    get '/sign_out', to: 'sessions#sign_out_user'

    root to: 'home#index'
  end
