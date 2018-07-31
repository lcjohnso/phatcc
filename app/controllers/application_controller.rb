class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  ## Scrub sensitive parameters from your log
  #filter_parameter_logging :password

  before_action :set_user

protected
  def set_user
    @user = User.find(session[:id]) if @user.nil? && session[:id]
  end

  def login_required
    return true if @user
    access_denied
    return false
  end

  def access_denied
    session[:return_to] = request.url
    flash[:error] = 'Sorry - login required to view page.'
    redirect_to :controller => 'user', :action => 'login'
  end

end
