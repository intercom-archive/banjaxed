Rails.application.routes.draw do
  github_authenticate(org: ENV['GITHUB_ORG']) do
    root to: redirect(path: '/incidents', status: 302)

    resources :incidents, except: :destroy do
      resources :comments, only: [:new, :create, :index]
    end
  end
end
