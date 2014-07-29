Rails.application.routes.draw do
  resources :incidents, except: :destroy
end
