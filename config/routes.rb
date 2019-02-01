Rails.application.routes.draw do
  root 'promotions#index'
  resources :promotions, only: [:new, :show, :create, :index] do
    member do
      post 'approve'
      post 'generate_coupons'
      resources :coupons, only: %i[index]
    end
  end

  get 'burn', to: 'coupons#burn_form'
  post 'burn', to: 'coupons#burn_coupon'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  namespace :api, defaults: { format: :JSON } do
    namespace :v1 do
      get 'coupons/:code', to: 'coupons#show'
      post 'coupons/burn/:code', to: 'coupons#use_coupon'
    end
  end
end
