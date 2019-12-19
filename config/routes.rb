# frozen_string_literal: true

Rails.application.routes.draw do
  root 'site#index'

  mount API::Base, at: '/'
end
