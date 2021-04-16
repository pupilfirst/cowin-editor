class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: %i[facebook google_oauth2]

 # GET /auth/:provider/callback
 def oauth_callback
    user = User.find_by_email(auth_hash['info']['email'])

    if user.present?
      sign_in user
      redirect_to after_sign_in_path_for(user)
    else
      if !auth_hash['info']['email'].to_s.empty?
        user = User.create!(email: auth_hash['info']['email'], name: auth_hash['info']['name'].presence || 'John Doe')
        sign_in user
        redirect_to after_sign_in_path_for(user)
      else
        flash.alert = email_blank_flash
        redirect_to root_path
      end
    end
  end

  alias google_oauth2 oauth_callback
  alias facebook oauth_callback

  def failure
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def provider_name
    params[:action].split('_').first.capitalize
  end

  def email_blank_flash
    message = "We're sorry, but we did not receive your email address from #{provider_name}. "

    message += case provider_name
      when 'Facebook'
        'Please <a href="https://www.facebook.com/settings?tab=applications" target="_blank" rel="noopener">remove \' Your Site Builder \' from your authorized apps list</a> and try signing in again.'
      else
        'Please sign in using another method.'
    end

    message.html_safe
  end
end
