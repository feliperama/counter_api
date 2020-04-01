class PagesController < ApplicationController
  def home
    @new_token = current_user.generate_token if current_user
  end
end
