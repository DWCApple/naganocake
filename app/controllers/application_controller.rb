class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    items_path(current_end_user)
  end

  def after_sign_out_path_for(resource)
   root_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:email, :family_name, :first_name, :family_name_kana, :first_name_kana, :address, :telephone_number, :postal_code])
  end
end
