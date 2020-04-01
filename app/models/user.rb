class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  class << self
    def by_token(token)
      payload = decode_token(token)
      return if payload['user_id'].nil?

      find(payload['user_id']) if payload['expires_at'].to_datetime >= Time.current
    rescue JWT::DecodeError
      nil
    end

    def decode_token(token)
      JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256').first
    end

    alias find_by_token by_token
  end

  def generate_token
    payload = {
      user_id: id,
      expires_at: 1.week.from_now
    }
    JWT.encode payload, ENV['JWT_SECRET'], 'HS256'
  end
end
