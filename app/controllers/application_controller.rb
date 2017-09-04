class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :set_gettext_locale

  helper_method :current_organization, :current_user, :signed_in?

  rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound, with: :render_404 unless Rails.env.development?

  rescue_from CanCan::AccessDenied, with: :access_denied! unless Rails.env.development?

  #check_authorization

  protected

  def current_organization
    @current_organization ||= current_user.current_organization
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user])
  end

  def signed_in?
    current_user != nil
  end

  def render_404
    render 'errors/not_found', status: :not_found
  end

  def access_denied!
    respond_to do |format|
      format.js  { head :forbidden }
      format.any { render 'errors/forbidden', status: :forbidden }
    end
  end

  def require_organization
    redirect_to root_path, alert: _('This page requires an active organization.') unless current_organization
  end

end
