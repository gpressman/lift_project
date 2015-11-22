class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:email, :current_height, :current_weight, :password]
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 
  def after_sign_in_path_for(resource)
    new_user_weight_path(current_user.id)
  end
  protect_from_forgery with: :exception

end
