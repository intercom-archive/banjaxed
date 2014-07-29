Rails.application.routes.draw do
  root to: redirect(path: '/incidents', status: 302)

  resources :incidents, except: :destroy
end
