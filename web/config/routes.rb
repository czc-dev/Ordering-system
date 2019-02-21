# frozen_string_literal: true

Rails.application.routes.draw do
  # 独自定義のルーティング
  root to: 'home#index'

  post 'ajax/details/', to: 'ajax#details'
  post 'ajax/details/add', to: 'ajax#add_details', as: 'ajax_add_details'
  post 'ajax/:patient_id/orders', to: 'ajax#patient_orders', as: 'ajax_patient_orders'
  post 'ajax/:order_id/inspections', to: 'ajax#order_inspections', as: 'ajax_order_inspections'

  get 'new/order',  to: 'manage_step#new_order'
  post 'new/order', to: 'manage_step#redirect_to_new_order'

  get  '/login', to: 'auth#login'
  post '/login', to: 'auth#create'
  delete '/logout', to: 'auth#destroy'

  get '/orders', to: 'recent_orders#index', as: 'recent_orders'

  # RESTfulなルーティング
  resources :employees
  with_options(except: :show) do |opt|
    opt.resources :patients, shallow: true do
      opt.resources :orders, shallow: true do
        opt.resources :inspections
      end
    end
  end
end
