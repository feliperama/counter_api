class V1::CountersController < V1::ApiController 
  before_action :authenticate_user!

  def next
    gc = GlobalCounter.find_or_create_by(name: 'current_int')
    gc.value += 1
    gc.save!

    render json: formatted_current_int_data(gc.value) 
  end

  def current
    gc = GlobalCounter.find_or_create_by(name: 'current_int')

    render json: formatted_current_int_data(gc.value) 
  end

  def update
    new_value = validated_current_int_value

    if new_value
      gc = GlobalCounter.find_by(name: 'current_int')
      gc.value = validated_current_int_value
      gc.save!

      render json: formatted_current_int_data(gc.value) 
    else
      render json: { error: 'invalid request params' }, status: :unprocessable_entity
    end
  end

  private

  def validated_current_int_value
    value = params.require('data').permit('current')['current']

    if value.class == Integer || value.match(/\A[-+]?[0-9]*\.?[0-9]+\Z/)
      value
    else
      nil
    end
  end

  def formatted_current_int_data(value)
    {
      data: {
        current_int: value 
      }
    }
  end
end
