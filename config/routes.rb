# frozen_string_literal: true

Rails.application.routes.draw do
  # 独自定義のルーティング
  root to: 'home#index'

  get  '/new-order/index', to: 'choose_patient_for_new_orders#new', as: 'new_order'
  post '/new-order/index', to: 'choose_patient_for_new_orders#create'

  get  '/login', to: 'employee_sessions#new'
  post '/login', to: 'employee_sessions#create'
  get '/logout', to: 'employee_sessions#destroy'

  get '/orders', to: 'recent_orders#index', as: 'recent_orders'

  get  '/create', to: 'init_organizations#new'
  post '/create', to: 'init_organizations#create'

  # 履歴管理 PaperTrail::Version のためのルーティング
  get 'histories',     to: 'paper_trail/versions#index'
  get 'histories/:id', to: 'paper_trail/versions#show', as: 'history'

  # ajax用RESTfulルーティング
  namespace :ajax do
    resources :select_exam_sets,  only: :new
    resources :select_exam_items, only: %i[index new]
    resources :orders, only: %i[index edit]
    resources :exams,  only: %i[index edit]
  end

  # RESTfulなルーティング
  resources(:organizations, except: :index) do
    resources(:employees, shallow: true)
    resources(:invitations, only: %i[index new create destroy], shallow: true)

    resources(:patients, except: :show, shallow: true) do
      resources(:orders, except: %i[show edit], shallow: true) do
        resources(:exams, except: %i[show edit], shallow: true)
      end
    end
  end

  resources :exam_items, except: :show
  resources :exam_sets,  except: :show
end
