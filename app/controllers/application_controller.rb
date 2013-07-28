class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    home_index_path
  end

  def user_is_administrator?
    current_user.role.name == "Administrador"
  end
end
