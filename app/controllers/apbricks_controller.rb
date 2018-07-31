class ApbricksController < ApplicationController
  before_action :login_required

	layout 'phatcc'

  def index
    @apbricks = Apbrick.all
  end

  def show
    @apbrick = Apbrick.find(params[:id])
    @sclusters = @apbrick.apobjects.find(:all, :order => 'apobjects.viewfrac DESC')
  end

  def csort
    @apbrick = Apbrick.find(params[:id])
    clusters = @apbrick.apobjects.all
    @sclusters = clusters.sort_by{ |c| c.viewfrac*(1.-c.galfrac) }.reverse
  end

  def gsort
    @apbrick = Apbrick.find(params[:id])
    galaxies = @apbrick.apobjects.all
    @sclusters = galaxies.sort_by{ |c| c.viewfrac*(c.galfrac) }.reverse
  end

end
