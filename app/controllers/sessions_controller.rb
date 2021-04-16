class SessionsController < ApplicationController
  before_action :authenticate_user!, only: %w[sign_out_user]

  # GET /sign_in
  def sign_in_form
    @path = params[:referrer]
    if current_user.present?
      flash.notice = 'You are already signed in.'
      redirect_to after_sign_in_path_for(current_user)
    end
  end

  # GET /sign_out
  def sign_out_user
    sign_out current_user
    flash.notice = 'You have been signed out.'
    redirect_to root_path
  end
end
