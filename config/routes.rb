Rails.application.routes.draw do
  root 'promotions#index'
  resources :promotions, only: [:new, :show, :create, :index] do
    member do
      post 'approve'
      post 'generate_coupons'
      resources :coupons, only: %i[index]
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end
