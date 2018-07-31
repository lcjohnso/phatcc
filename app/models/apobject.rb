class Apobject < ActiveRecord::Base
  belongs_to :apbrick

	#Interpreted Values
	def prioritycolor
          if (self.viewfrac > 0.35 and self.galfrac < 0.5)
            bckcolor="BGCOLOR='green'"
          elsif (self.viewfrac > 0.35)
            bckcolor="BGCOLOR='red'"
          else
            bckcolor="BGCOLOR='yellow'"
          end
          bckcolor
	end

	def altidcolor
          if (self.altflag == 1)
            bckcolor="BGCOLOR='green'"
          elsif (self.altflag == 0 and self.altid != nil)
            bckcolor="BGCOLOR='red'"
          else
            bckcolor=""
          end
          bckcolor
	end

	def yr1idcolor
          if (self.yr1flag == 2)
            bckcolor="BGCOLOR='green'"
          elsif (self.yr1flag == 1)
            bckcolor="BGCOLOR='yellow'"
          elsif (self.yr1flag == 0 and self.yr1id != nil)
            bckcolor="BGCOLOR='red'"
          else
            bckcolor=""
          end
          bckcolor
	end
	
	def absmag
          if self.mag475 != nil
            absmag = sprintf("%.2f",self.mag475 - 24.47)
          else
            absmag = -999
          end
          absmag
	end
	
	def obsmag
          if self.mag475 != nil
            obsmag = sprintf("%.2f",self.mag475)
          else
            obsmag = -999
          end
          obsmag
	end
	
	def optcolor
          if (self.mag475 != nil && self.mag814 != nil)
            optcolor = sprintf("%.2f",self.mag475-self.mag814)
	  else
            optcolor = -999
	  end
          optcolor
	end
	
	def radangular
          rad = sprintf("%.2f",self.pixrad*0.05)
	end
	
	def halfangular
          if self.pixhlr475 != nil
            rad = sprintf("%.2f",self.pixhlr475*0.05)
          else
            rad = -999
          end
          rad
	end
	
	def halfphysical
          if self.pixhlr475 != nil
            rad = self.pixhlr475*0.05
            arcpc = 0.2625 #Math::tan(1.0/(0.78*1000000.0))*206265.0
            hlrad = sprintf("%.2f",rad/arcpc)
          else
            hlrad = -999
          end
          hlrad
	end

  #Image Filename Assignment
	def fileid
          name = 'ap'+self.id.to_s
	end

	def image_color
          path = WEB_URL+IMAGE_DIR_AP+'_color/'+self.fileid+'_color.jpg'
        end
        
 	def image_275
          path = WEB_URL+IMAGE_DIR_AP+'_F275W/'+self.fileid+'_F275W.jpg'
        end
        
  	def image_336
          path = WEB_URL+IMAGE_DIR_AP+'_F336W/'+self.fileid+'_F336W.jpg'
        end
        
	def image_475
          path = WEB_URL+IMAGE_DIR_AP+'_F475W/'+self.fileid+'_F475W.jpg'
        end
        
 	def image_814
          path = WEB_URL+IMAGE_DIR_AP+'_F814W/'+self.fileid+'_F814W.jpg'
        end
        
 	def image_110
          path = WEB_URL+IMAGE_DIR_AP+'_F110W/'+self.fileid+'_F110W.jpg'
        end

  	def image_160
          path = WEB_URL+IMAGE_DIR_AP+'_F160W/'+self.fileid+'_F160W.jpg'
        end
       
        def cmd_image
          path = WEB_URL+CMD_DIR_AP+'/cmd_'+self.fileid+'.png'
	end

        def sed_image
          path = WEB_URL+'/ap_seds/'+self.fileid+'_sed.png'
	end

	def fit_cmd
          path = WEB_URL_LORI+self.fileid+'/'+self.fileid+'_cmd.png'
	end

	def fit_res
          path = WEB_URL_LORI+self.fileid+'/'+self.fileid+'_out.cmd_WFC.png'
	end

	def fit_pdf
          path = WEB_URL_LORI+self.fileid+'/'+self.fileid+'_pdf.png'
	end

	def intfit_pdf
          path = WEB_URL+'/ap_intpdf/'+self.fileid+'_pdf1d.png'
	end

	def intfit_pdf2d
          path = WEB_URL+'/ap_intpdf/'+self.fileid+'_pdf2d.png'
	end

        def nclink
          if self.ncid != nil
            path = NC_URL_PRE+self.ncid+NC_URL_POST
          else
            path = 'None'
          end
	end

        def profile_image
          path = WEB_URL+IMG_DIR_PROFILE+'/ap_king_webimgs/'+self.fileid+'_F475W_king.png'
	end

        def profilemod_image
          path = WEB_URL+IMG_DIR_PROFILE+'/ap_kingmod_webimgs/'+self.fileid+'_F475W_kingmod.png'
	end

end
