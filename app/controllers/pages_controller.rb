class PagesController < ApplicationController
  def home
    @new_token = current_user.generate_token if current_user

    @curl_base_path = Rails.application.secrets.counter_api_uri
    # if Rails.env == "production"
    #   @curl_base_path = "https://cherry-sundae-20794.herokuapp.com"
    # else
    #   @curl_base_path = "http://localhost"
    # end
  end
end
