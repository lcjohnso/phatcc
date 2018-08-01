class ApobjectsController < ApplicationController
  before_action :login_required

	layout 'phatcc'

  def show
    @apobject = Apobject.find(params[:id])
    @apbrick = Apbrick.find(@apobject.apbrick_id)

    sapobjects = @apbrick.apobjects.all.order(viewfrac: :desc)
    @iclst = sapobjects.index(@apobject)
    if @apobject != sapobjects.last
  	   @napobject = sapobjects[@iclst+1]
    end

    if @apobject != sapobjects.first
 	     @papobject = sapobjects[@iclst-1]
    end
  end

  def cshow
    @apobject = Apobject.find(params[:id])
    @apbrick = Apbrick.find(@apobject.apbrick_id)

    clusters = @apbrick.apobjects.all
    sapobjects = clusters.sort_by{ |c| c.viewfrac*(1.-c.galfrac) }.reverse
    @iclst = sapobjects.index(@apobject)
    if @apobject != sapobjects.last
      @napobject = sapobjects[@iclst+1]
    end
    if @apobject != sapobjects.first
      @papobject = sapobjects[@iclst-1]
    end
  end

  def gshow
    @apobject = Apobject.find(params[:id])
    @apbrick = Apbrick.find(@apobject.apbrick_id)

    galaxies = @apbrick.apobjects.all
    sapobjects = galaxies.sort_by{ |c| c.viewfrac*(c.galfrac) }.reverse
    @iclst = sapobjects.index(@apobject)
    if @apobject != sapobjects.last
      @napobject = sapobjects[@iclst+1]
    end
    if @apobject != sapobjects.first
      @papobject = sapobjects[@iclst-1]
    end
  end

end
