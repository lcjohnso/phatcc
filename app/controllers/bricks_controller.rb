class BricksController < ApplicationController
  before_action :login_required

	layout 'phatcc'

  def index
    @bricks = Brick.all
  end

  def show
    @brick = Brick.find(params[:id])
    @sclusters = @brick.clusters.all.order('clusters.avgrat')
  end

  def sort
    @brick = Brick.find(params[:id])
    @sclusters = @brick.clusters.all.order('clusters.avgscore')
  end

  def usersort
    @brick = Brick.find(params[:id])
    clusters = @brick.clusters.all
    @sclusters = clusters.sort_by{ |c| c.myrating(@user.username) }
  end

end
