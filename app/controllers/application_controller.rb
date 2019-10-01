class ApplicationController < ActionController::Base

  protect_from_forgery prepend: true
  before_action :authenticate_user!

  add_flash_types :success

  # def after_sign_in_path_for(resource)
  #   # stored_location_for(resource) || authenticated_root_path
  #   # stored_location_for(resource)
  # end

end
