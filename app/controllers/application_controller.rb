class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(github_id: github_user.id) if user_signed_in?
  end

  def user_signed_in?
    github_user.present?
  end

  helper_method :current_user, :user_signed_in?
end
