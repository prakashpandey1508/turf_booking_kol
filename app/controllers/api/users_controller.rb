class Api::UsersController < Api::BaseController
  def sign_up
    user = User.new(sign_up_params)
    if user.save
      render json: { message: "User signed up successfully" }, status: :ok
    else
      render json: {success: false, message: "sign up failed please try again", errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.permit(:email, :password, :name, :role)
  end
end
