# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  resources :patients, shallow: true do
    resources :orders, shallow: true do
      resources :inspections
    end
  end
end
