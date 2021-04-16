class HomeController < ApplicationController
  def index
    #noop
    redirect_to languages_path if current_user.present?
  end
end
