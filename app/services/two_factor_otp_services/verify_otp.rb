module TwoFactorOtpServices
  class VerifyOtp
    include HTTParty
    base_uri "https://2factor.in/API/V1"

    def initialize(phone_number, otp_code)
      @phone_number = phone_number
      @otp_code = otp_code
    end

    def call
      api_key = ENV['TWO_FACTOR_OTP_API_KEY'] || "9d016f9a-cee2-11f0-a6b2-0200cd936042"
      self.class.get("/#{api_key}/SMS/VERIFY3/#{@phone_number}/#{@otp_code}")
    end
  end
end