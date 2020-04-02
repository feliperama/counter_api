class PagesController < ApplicationController
  def home
    @new_token = current_user.generate_token if current_user

    if Rails.env == "production"
      @curl_base_path = "https://cherry-sundae-20794.herokuapp.com"
    else
      @curl_base_path = "http://localhost"
    end
  end
end
