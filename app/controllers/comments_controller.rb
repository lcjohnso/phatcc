class CommentsController < ApplicationController
  before_action :login_required

	layout 'phatcc'

# Not currently supported
#  def index
#    @cluster = Cluster.find(params[:cluster_id])
#    @comments = @cluster.comments
#  end

  def show
    @cluster = Cluster.find(params[:cluster_id])
    @comment = @cluster.comments.find(params[:id])
  end

  def new
    @cluster = Cluster.find(params[:cluster_id])
    @comment = @cluster.comments.build
  end

  def create
  	# Check Login against User
  	if @user.username != params[:comment][:user]
      flash[:message] = "Username does not match!"
      @cluster = Cluster.find(params[:cluster_id])
      redirect_to new_cluster_comment_path(@cluster)
    else
    @cluster = Cluster.find(params[:cluster_id])
    @comment = @cluster.comments.build(params[:comment])
    if @comment.save
      redirect_to @cluster
    else
      render :action => "new"
    end
    end
  end

  def edit
    @cluster = Cluster.find(params[:cluster_id])
    @comment = @cluster.comments.find(params[:id])
  end

  def update
   	# Check Login against User
  	if @user.username != params[:comment][:user]
      flash[:message] = "Username does not match!"
      @cluster = Cluster.find(params[:cluster_id])
      @comment = Comment.find(params[:id])
      redirect_to edit_cluster_comment_path(@cluster, @comment)
    else

    @cluster = Cluster.find(params[:cluster_id])
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to cluster_comment_url(@cluster, @comment)
    else
      render :action => "edit"
    end
    end
  end

  def destroy
    @cluster = Cluster.find(params[:cluster_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @cluster
  end

end
