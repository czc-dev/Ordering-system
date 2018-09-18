# frozen_string_literal: true

Rails.application.routes.draw do
  resources :patients, shallow: true do
    resources :orders, shallow: true do
      resources :inspections
    end
  end
end
