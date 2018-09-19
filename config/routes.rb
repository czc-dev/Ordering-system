# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  resources :patients, shallow: true do
    resources :orders, shallow: true do
      resources :inspections
    end
  end

  post 'orders/:order_id/ajax_index/', to: 'inspections#ajax_index'

  get 'new/order',  to: 'manage_step#new_order'
  post 'new/order', to: 'manage_step#redirect_to_new_order'
  get 'edit/order', to: 'manage_step#edit_order'
  get 'new/inspection',  to: 'manage_step#new_inspection'
  get 'edit/inspection', to: 'manage_step#edit_inspection'
end
