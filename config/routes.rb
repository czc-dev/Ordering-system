# frozen_string_literal: true

Rails.application.routes.draw do
  get 'inspections/index'
  get 'inspections/show'
  get 'inspections/new'
  get 'inspections/edit'
  get 'orders/index'
  get 'orders/new'
  get 'orders/show'
  get 'orders/edit'
  get 'patients/index'
  get 'patients/show'
  get 'patients/edit'
  resources :patients, shallow: true do
    resources :orders, shallow: true do
      resources :inspections
    end
  end
end
