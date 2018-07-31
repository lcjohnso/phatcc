class RatingsController < ApplicationController
  before_action :login_required

	layout 'phatcc'

#  def show
#    @cluster = Cluster.find(params[:cluster_id])
#    @rating = @cluster.ratings.find(params[:id])
#  end

  def new
    @cluster = Cluster.find(params[:cluster_id])
    @rating = @cluster.ratings.build
  end

  def create
  	# Check User
  	if @user.username == "PHAT"
      flash[:message] = "PHAT user cannot rate clusters."
      @cluster = Cluster.find(params[:cluster_id])
      redirect_to :back #@cluster
    else
    	@cluster = Cluster.find(params[:cluster_id])
    	@rating = @cluster.ratings.build(params[:rating])
    	if @rating.save
    		@cluster.checklookflag
      	redirect_to :back #@cluster
    	else
      	flash[:message] = "ERROR: Rating not created!"
      	redirect_to :back #@cluster
    	end
    end
  end

#  def edit
#    @cluster = Cluster.find(params[:rating_id])
#    @rating = @cluster.ratings.find(params[:id])
#  end

  def update
   	# Check Login against User
  	if @user.username == "PHAT"
      flash[:message] = "PHAT user cannot edit cluster ratings." #Shouldn't need this...
      @cluster = Cluster.find(params[:cluster_id])
      redirect_to :back #@cluster
    else
    	@cluster = Cluster.find(params[:cluster_id])
    	@rating = Rating.find(params[:id])
    	if @rating.update_attributes(params[:rating])
    		@cluster.checklookflag
      	redirect_to :back #@cluster
    	else
      	flash[:message] = "ERROR: Rating not updated!"
      	redirect_to :back #@cluster
    	end
    end
  end

#  def destroy
#    @cluster = Cluster.find(params[:cluster_id])
#    @rating = Rating.find(params[:id])
#    @rating.destroy
#    redirect_to @cluster
#  end

end
