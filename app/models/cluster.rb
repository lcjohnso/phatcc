class Cluster < ActiveRecord::Base
  belongs_to :brick
  has_many :comments
  has_many :ratings
  accepts_nested_attributes_for :comments, :reject_if => proc {|attrs| attrs['body'].blank? } 
	accepts_nested_attributes_for :ratings

	#Navigation
	def next
		self.class.find :first, :conditions => ["brick_id=? AND id > ?",self.brick_id,self.id], :order => "id"
  end

	def previous
		self.class.find :first, :conditions => ["brick_id=? AND id < ?",self.brick_id,self.id], :order => "id DESC"
	end

	#Data Checks / Flag Setting
	def checklookflag
		rates=[]
		self.ratings.each {|r| rates.concat([r.score])}
		arat=rates.sum.to_f/rates.length
		ndif=rates.max-rates.min
		if ndif > 1
			self.update_attributes(:lookflag => 1, :avgscore => arat)
		else
			self.update_attributes(:lookflag => 0, :avgscore => arat)
		end
	end

	def checkratings(user)
		rates=[]
		urate=0
		rateflag=0
		self.ratings.each do |r|
			if user == r.user
				urate=r.score
			end
			rates.concat([r.score])
		end
		
		uniqrates=rates.uniq
		uniqrates.sort!.reverse!
		nperuniq=[]
		uniqrates.each do |i|
			tmp=0
			rates.each do |j|
				if i == j
					tmp+=1
				end
			end
			nperuniq.concat([tmp])
		end
		imax=nperuniq.index(nperuniq.max)
		if not imax.nil?
			if uniqrates[imax] != urate && urate != 0
				rateflag=1
			end
		end
		
		out=[rateflag,urate]
	end

	def myrating(user)
		urate=0
		self.ratings.each do |r|
			if user == r.user
				urate=r.score
			end
		end
		urate
	end

	#Interpreted Values
	def prioritycolor(score)
		if (avgrat > 0 and avgrat < 2)
			bckcolor="BGCOLOR='green'"
		elsif (avgrat >= 2)
			bckcolor="BGCOLOR='yellow'"
		else
			bckcolor="BGCOLOR='red'"
		end
		bckcolor
	end
	
	def absmag
		if self.apmag2 != nil
			absmag = sprintf("%.2f",self.apmag2 - 24.47)
		else
			absmag = -999
		end
		absmag
	end
	
	def obsmag
		if self.apmag2 != nil
			obsmag = sprintf("%.2f",self.apmag2)
		else
			obsmag = -999
		end
		obsmag
	end
	
	def optcolor
		if (self.apmag2 != nil && self.apmag3 != nil)
			optcolor = sprintf("%.2f",self.apmag2-self.apmag3)
	  else
	  	optcolor = -999
	  end
		optcolor
	end
	
	def radangular
		rad = sprintf("%.2f",self.radius)
	end
	
	def halfangular
		rad = sprintf("%.2f",self.hlr2*0.05)
	end
	
	def halfphysical
		if self.hlr2 != nil
			gal = Brick.find(self.brick_id)
			rad = self.hlr2*0.05
			arcpc = Math::tan(1.0/(0.78*1000000.0))*206265.0
			hlrad = sprintf("%.2f",rad/arcpc)
		else
			hlrad = -999
		end
		hlrad
	end

  #Image Filename Assignment
	def fileid
		name = self.fieldname+'_'+self.id.to_s
	end

	def image_color
    path = WEB_URL+IMAGE_DIR+'/'+self.fileid+'_color.jpg'
  end
  
	def image_context
    path = WEB_URL+IMAGE_DIR+'/'+self.fileid+'_context.jpg'
  end

 	def image_336
    path = WEB_URL+IMAGE_DIR+'/'+self.fileid+'_F336W.jpg'
  end

 	def image_475
    path = WEB_URL+IMAGE_DIR+'/'+self.fileid+'_F475W.jpg'
  end
  
 	def image_814
    path = WEB_URL+IMAGE_DIR+'/'+self.fileid+'_F814W.jpg'
  end
  
 	def image_160
    path = WEB_URL+IMAGE_DIR+'/'+self.fileid+'_F160W.jpg'
  end
  
# def cmd_image
#  	path = WEB_URL+IMAGE_DIR+'/'+self.fileid+'.st.png'
#	end
  
#	def i_fits
#   path = WEB_URL+IMAGE_DIR+'/'+self.fileid+'_F814W.fits'
# end
  
end
