class V1::SessionsController < V1::ApiController 
  def create
    user = User.find_by_email(params[:email])

    if user && user.valid_password?(params[:password])
      render json: {
        data: {
          token: user.generate_token,
          email: user.email
        }
      }
    else
      render json: {
        errors: {
          :description => 'invalid email or password'
        }
      }, status: :unauthorized
    end
  end
end
