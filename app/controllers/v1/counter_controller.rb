class V1::CounterController < V1::ApiController 
  before_action :authenticate_user!

  def next
    render json: {data: '1'}
  end
end
