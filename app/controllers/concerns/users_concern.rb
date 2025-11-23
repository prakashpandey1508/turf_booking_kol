module UsersConcern
  extend ActiveSupport::Concern

  included do
    def validate_sign_up_params
      required_params = [:email, :password, :name, :role, :phone_number]
      missing_params = required_params.select { |param| params[param].blank? }

      unless missing_params.empty?
        render json: { success: false, message: "Missing required parameters: #{missing_params.join(', ')}" }, status: :bad_request
      end
    end
  end
end