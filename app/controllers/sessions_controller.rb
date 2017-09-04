class SessionsController < ApplicationController
  skip_authorization_check

  before_action :require_no_authentication, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user] = user.id
      redirect_to root_path
    else
      flash[:alert] = _('Incorrect username/password')
      render :new
    end
  end

  def destroy
    session.delete :user
    redirect_to root_path
  end

  protected

  def require_no_authentication
    redirect_to root_path if current_user
  end
end
