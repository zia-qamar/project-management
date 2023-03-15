# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "projects#index"
  devise_for :users

  resources :projects do
    put :update_status, on: :member
    resources :comments, only: [:create]
  end
end
