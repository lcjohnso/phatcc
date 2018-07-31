class UserController < ApplicationController
  before_action :login_required, :only => [:my_account] #:index, :show]

	layout 'phatcc'

  def login
    if not @user.nil? then
      flash[:message] = 'Already logged in!'
      redirect_to :action => 'my_account'
    end
  end

  def logout
    reset_session
    flash[:message] = 'Logged out.'
    redirect_to :action => 'login'
  end

  def my_account
  end

  def process_login
    if user = User.authenticate(params[:user]) then
      session[:id] = user.id # Remember the user's id during this session
      redirect_to session[:return_to] || '/'
    else
      flash[:error] = 'Invalid login!'
      redirect_to :action => 'login'
    end
  end

#	def index
#		@users = User.find(:all)
#		@clusters = Cluster.find(:all)
#	end

#	def show
#	end

end
