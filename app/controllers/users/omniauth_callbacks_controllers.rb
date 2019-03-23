class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
      redirect_to root_path, notice: 'Google login success'
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url, notice: 'Error al iniciar sesión con Google.'
    end
  end
end