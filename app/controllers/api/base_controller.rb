class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session  # Disable CSRF for API
end