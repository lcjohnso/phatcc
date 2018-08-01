class ClustersController < ApplicationController
  before_action :login_required

	layout 'phatcc'

  def show
    @cluster = Cluster.find(params[:id])
    @brick = Brick.find(@cluster.brick_id)
    if @cluster.ratings.exists?(:user => @user.username)
    	@userrating = @cluster.ratings.where("user = ?", @user.username).first
    else
    	@userrating = @cluster.ratings.build(:user => @user.username, :score => "0", :brick_id => @cluster.brick_id)
 		end

 		sclusters = @brick.clusters.all.order("clusters.avgrat")
 		@iclst = sclusters.index(@cluster)
 		if @cluster != sclusters.last
 			@ncluster = sclusters[@iclst+1]
 	  end
 		if @cluster != sclusters.first
 			@pcluster = sclusters[@iclst-1]
 		end
  end

  def sushow
    @cluster = Cluster.find(params[:id])
    @brick = Brick.find(@cluster.brick_id)
    if @cluster.ratings.exists?(:user => @user.username)
    	@userrating = @cluster.ratings.where("user = ?", @user.username).first
    else
    	@userrating = @cluster.ratings.build(:user => @user.username, :score => "0", :brick_id => @cluster.brick_id)
 		end

		clusters = @brick.clusters.all
    sclusters = clusters.sort_by{ |c| c.myrating(@user.username) }
 		@iclst = sclusters.index(@cluster)
 		if @cluster != sclusters.last
 			@ncluster = sclusters[@iclst+1]
 	  end
 		if @cluster != sclusters.first
 			@pcluster = sclusters[@iclst-1]
 		end
  end

  def sashow
    @cluster = Cluster.find(params[:id])
    @brick = Brick.find(@cluster.brick_id)
    if @cluster.ratings.exists?(:user => @user.username)
    	@userrating = @cluster.ratings.where("user = ?", @user.username).first
    else
    	@userrating = @cluster.ratings.build(:user => @user.username, :score => "0", :brick_id => @cluster.brick_id)
 		end

 		sclusters = @brick.clusters.all.order("clusters.avgscore")
 		@iclst = sclusters.index(@cluster)
 		if @cluster != sclusters.last
 			@ncluster = sclusters[@iclst+1]
 	  end
 		if @cluster != sclusters.first
 			@pcluster = sclusters[@iclst-1]
 		end
  end

  def update
  	@cluster = Cluster.find(params[:id])
    if @cluster.update_attributes(params[:cluster])
      #redirect_to @cluster
      redirect_to :back
    else
    	flash[:message] = "Bad Update!"
      #redirect_to @cluster
      redirect_to :back
    end
  end

end
