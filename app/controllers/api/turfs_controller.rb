class Api::TurfsController < Api::BaseController
  before_action :validate_authentication_token

  def index
    turfs = Turf.all
    render_json_response(true, "Turfs fetched successfully", data: { turfs: turfs }, status: :ok)
  end

  def show
    
  end

  def create
    turf = @user.turves.new(turf_creation_params)
    if turf.save
      render_json_response(true, "Turf created successfully", data: { turf: turf }, status: :ok)
    else
      render_json_response(false, "Turf creation failed", data: { errors: turf.errors.full_messages }, status: :unprocessable_entity)
    end
  end

  def update
    turf = Turf.find_by(id: params[:id])
    if turf&.update(turf_creation_params)
      render_json_response(true, "Turf updated successfully", status: :ok)
    else
      render_json_response(false, "Turf update failed", data: { errors: turf.errors.full_messages }, status: :unprocessable_entity)
    end
  end

  def destroy
    turf = Turf.find_by(id: params[:id])
    if turf&.destroy
      render_json_response(true, "Turf deleted successfully", status: :ok)
    else
      render_json_response(false, "Turf deletion failed", data: { errors: turf.errors.full_messages }, status: :unprocessable_entity)
    end
  end

  def turf_creation_params
    params.permit(:name, :pin_code, :address, :price_per_hour, :availability, :role)
  end
end
