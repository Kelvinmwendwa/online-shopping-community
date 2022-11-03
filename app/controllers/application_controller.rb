# frozen_string_literal: true

class ApplicationController < ActionController::API
  # prepare >> application_controller
  # #The jwt token is sent in the headers of a response within the "Authorization" key
  # #We need to decode it if it exists,
  # #When we decode it we get a two element array. User_id is the first one
  # #We find the user and authorize them
  # #if a new user needs a token, we encode it with our 'secret'

  # Login >>auth_controller
  # #To login we need to find the user and authenticate them.
  # #Then, we create(encode) a JWT token to be sent with user.

  # Sign up >>user_controller
  # #We create a user. If successful, we create a JWT token and send it with the response

  # #stay logged in >>  user_controller
  # if we authorize successfully, we return the user.

  def encode_token(payload)
    JWT.encode(payload, 'bReachers&ecret')
  end

  def decode_token
    if auth_header
      token = JSON.parse(auth_header.split(' ').last)
      begin
        JWT.decode(token, 'bReachers&ecret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def auth_header
    request.headers['Authorization']
  end

  def current_user
    if decode_token
      user_id = decode_token[0]['user_id']
      user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorize
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
