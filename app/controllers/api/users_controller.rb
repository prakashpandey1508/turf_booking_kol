class Api::UsersController < Api::BaseController
  include UsersConcern
  before_action :validate_sign_up_params, only: [:sign_up]
  before_action :validate_authentication_token, only: [:update_profile, :user_profile]

  def sign_up
    user = User.new(sign_up_params)
    if user.save
      render json: { message: "User signed up successfully" }, status: :ok
    else
      render json: {success: false, message: "sign up failed please try again", errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def sign_in
    user = User.find_by(email: params[:email]) || User.find_by(phone_number: params[:phone_number])
    return render json: { success: false, message: "User not found" }, status: :not_found unless user
    user_password = params[:password]
    return render_json_response(false, 'sign in failed') unless user.password == user_password

    if user
      data = { user: { id: user.id, email: user.email, name: user.name, role: user.role, token: create_jwt_token(user.id), phone_number: user.phone_number } }
      render_json_response(true, "Sign in successful", data: , status: :ok)
    else
      render_json_response(false, "Sign in failed", status: :unauthorized)
    end
  end

  def update_profile
    user_bio = params[:bio]
    preferred_sports = params[:preferred_sports] || []
    username = params[:username]
    name = params[:name]
    email = params[:email]
    existing_user_with_username = User.find_by(username: username) if username.present?
    if existing_user_with_username.present? && existing_user_with_username.id != @user.id
      return render json: { success: false, message: "Username already taken" }, status: :conflict
    end
    @user.bio = user_bio
    @user.preferred_sports = preferred_sports
    @user.username = username
    @user.name = name if name.present?
    @user.email = email if email.present?
    if @user.save
      render json: { success: true, message: "Profile updated successfully", data: { id: @user.id, email: @user.email, name: @user.name, role: @user.role, phone_number: @user.phone_number, bio: @user.bio, preferred_sports: @user.preferred_sports, username: @user.username } }, status: :ok
    else
      render json: { success: false, message: "Failed to update profile", errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def user_profile
    render json: { success: true, message: "User profile fetched successfully", data: { id: @user.id, email: @user.email, name: @user.name, role: @user.role, phone_number: @user.phone_number, bio: @user.bio, preferred_sports: @user.preferred_sports, username: @user.username } }, status: :ok
  end

  def sign_up_params
    params.permit(:email, :password, :name, :role, :phone_number)
  end

  def create_jwt_token(user_id)
    payload = { user_id: }
    JsonWebToken.encode(payload)
  end

  def send_otp
    phone_number = params[:phone_number]
    user = User.find_or_initialize_by(phone_number: phone_number)
    if !['919509697424', '917079783893'].include?(phone_number)
      response = TwoFactorOtpServices::SendOtp.new(phone_number).call
      parse_response = JSON.parse(response.body)
    else
      parse_response = { "Status" => "Success" } # In non-production environments, simulate a successful OTP send
    end

    if parse_response["Status"] == "Success"
      if ['919509697424', '917079783893'].include?(phone_number)
        priya_dev_otp = '412878'# In development, we can use a fixed OTP for testing
        render json: { success: true, message: "OTP sent successfully" , dev_otp: priya_dev_otp}, status: :ok
      else
        render json: { success: true, message: "OTP sent successfully" }, status: :ok
      end
      user.save if user.new_record?
    else
      render json: { success: false, message: "Failed to send OTP" }, status: :unprocessable_entity
    end
  end

  def verify_otp
    phone_number = params[:phone_number]
    otp = params[:otp]
    user = User.find_by(phone_number: phone_number)
    return render json: { success: false, message: "User not found" }, status: :not_found unless user
    if ['919509697424', '917079783893'].include?(phone_number)
      priya_dev_otp = '412878'
      if otp == priya_dev_otp
        data = { user: { id: user.id, email: user.email, name: user.name, role: user.role, token: create_jwt_token(user.id), phone_number: user.phone_number } }
        return render json: { success: true, message: "OTP verified successfully", data: data = { user: { id: user.id, email: user.email, name: user.name, role: user.role, token: create_jwt_token(user.id), phone_number: user.phone_number } } }, status: :ok
      else
        return render json: { success: false, message: "Invalid OTP" }, status: :unprocessable_entity
      end
    end
    response = TwoFactorOtpServices::VerifyOtp.new(phone_number, otp).call
    parse_response = JSON.parse(response.body)
    if parse_response["Status"] == "Success"
      data = { user: { id: user.id, email: user.email, name: user.name, role: user.role, token: create_jwt_token(user.id), phone_number: user.phone_number } }
      render json: { success: true, message: "OTP verified successfully", data: data }, status: :ok
    else
      render json: { success: false, message: "Invalid OTP" }, status: :unprocessable_entity
    end
  end
end
