# frozen_string_literal: true

Rails.application.routes.draw do
  # 独自定義のルーティング
  root to: 'home#index'

  get  '/new-order/index', to: 'choose_patient_for_new_orders#new', as: 'new_order'
  post '/new-order/index', to: 'choose_patient_for_new_orders#create'

  get  '/login', to: 'auth#new'
  post '/login', to: 'auth#create'
  delete '/logout', to: 'auth#destroy'

  get '/orders', to: 'recent_orders#index', as: 'recent_orders'

  # ajax用RESTfulルーティング
  namespace :ajax do
    resources :inspection_details,    only: :index
    resources :selecting_inspections, only: :new
    resources :orders,      only: %i[index edit]
    resources :inspections, only: %i[index edit]
  end

  # RESTfulなルーティング
  resources :employees

  resources(:patients, except: :show) do
    resources(:orders, except: %i[show edit], shallow: true) do
      resources(:inspections, except: %i[show edit], shallow: true)
    end
  end
end
