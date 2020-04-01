class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  def decode_token(token)
    payload = JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256').first

    expires_at = payload['expires_at'].to_datetime

    if expires_at < Time.current
      raise "Token #{token} has expired at #{expires_at}"
    elsif payload["user_id"].nil? || payload["user_id"] != self.id
      raise "Token user_id invalid"
    end

    payload
  end

  def generate_token
    payload = {
      user_id: id,
      expires_at: 1.week.from_now
    }
    JWT.encode payload, ENV['JWT_SECRET'], 'HS256'
  end
end
