# frozen_string_literal: true

class V1::ApiController < ActionController::Base
  protect_from_forgery with: :null_session

  respond_to :json

  def authenticate_user!(options = {})
    head :unauthorized unless current_user
  rescue
    head :unauthorized
  end

  def current_user
    return @current_user if @current_user
    return nil if request.headers['Authorization'].blank?

    token = request.headers['Authorization'].remove('Bearer ').strip
    @current_user = User.by_token(token)
  end
end

