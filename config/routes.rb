Rails.application.routes.draw do
  # POST /registrations
  resources :orders do
    collection do
      get :express
    end
  end
  get "paypal_express/checkout"
  resources :link_request_offers do
    member do
      get :offer_payment
    end
  end
  resources :link_requests
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end
    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end
  root to: 'link_requests#index'
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users
end
