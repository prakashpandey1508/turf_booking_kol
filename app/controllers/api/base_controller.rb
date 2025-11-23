class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session  # Disable CSRF for API
  def validate_authentication_token
    token = request.headers['Authorization']&.split(' ')&.last
    unless token
      render json: { success: false, message: 'Missing authentication token' }, status: :unauthorized
      return
    end
    user_id = JsonWebToken.decode(token)[:user_id] rescue nil
    unless user_id && User.exists?(user_id)
      render json: { success: false, message: 'Invalid authentication token' }, status: :unauthorized
    end
    @user = User.find(user_id)
  end

  def render_json_response(success, message, data: {}, status: :ok)
    response = { success:, message: }
    response[:data] = data unless data.empty?
    render json: response, status: status
  end
end