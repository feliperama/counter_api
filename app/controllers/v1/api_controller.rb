# frozen_string_literal: true

class V1::ApiController < ActionController::Base
  protect_from_forgery with: :null_session

  respond_to :json

end

