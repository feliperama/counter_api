class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: %i[facebook]

  class << self
    def by_token(token)
      payload = decode_token(token)
      return if payload['user_id'].nil?

      find(payload['user_id']) if payload['expires_at'].to_datetime >= Time.current
    rescue JWT::DecodeError
      nil
    end

    def decode_token(token)
      JWT.decode(token, ENV['SECRET_KEY_BASE'], true, algorithm: 'HS256').first
    end

    alias find_by_token by_token
  end

  def generate_token
    payload = {
      user_id: id,
      expires_at: 1.week.from_now
    }
    JWT.encode payload, ENV['SECRET_KEY_BASE'], 'HS256'
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
