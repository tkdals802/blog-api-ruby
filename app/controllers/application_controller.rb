class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authorized


  def encode_token(payload)
    token_expiration = 1.hours.from_now.to_i
    payload[:exp] = token_expiration
    Rails.logger.info "payload #{payload[:exp]}"
    JWT.encode(payload, ENV['JWT_SECRET_KEY'], 'HS256')
  end

  def decoded_token
    header = request.headers['Authorization']
    if header
      token = header.split(' ')[1]
      begin
        JWT.decode(token, ENV['JWT_SECRET_KEY'])
      rescue JWT::DecodeError
        nil
      rescue JWT::ExpiredSignature
        Rails.logger.error "Token has expired"
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
      Rails.logger.info "decoded_token #{user_id} #{@user.username} #{@user.id}"
      @user
    end
  end

  def authorized
    unless !!current_user
      render json: {message: 'Please log in'}, status: 403
      return
    end

    if decoded_token.nil?
      render json: {message: 'Token is expired or invalid'}, status: 401
      return
    end
  end
end
