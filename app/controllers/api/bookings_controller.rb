class Api::BookingsController < Api::BaseController
  before_action :validate_authentication_token

  def create
    booking = @user.bookings.new(booking_params)
    if booking.save
      render_json_response(true, "Booking created successfully", data: { booking: booking }, status: :ok)
    else
      render_json_response(false, "Booking creation failed", data: { errors: booking.errors.full_messages }, status: :unprocessable_entity)
    end
  end

  private

  def booking_params
    params.permit(:turf_id, :booking_date, :start_time, :end_time, :total_hours, :total_price, :status, :payment_status)
  end
end
