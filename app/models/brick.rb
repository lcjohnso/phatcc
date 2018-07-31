class Brick < ActiveRecord::Base
  has_many :clusters
  has_many :ratings
  accepts_nested_attributes_for :clusters
  
  def numcomplete
  	@cs=Cluster.find(:all, :conditions => ["brick_id = ?",self.id])
		tnum=@cs.count
		@rates=Rating.find(:all, :conditions => ["brick_id = ?", self.id])
		rnum=@rates.count
		num=sprintf("%.2f",rnum.to_f/tnum.to_f)
	end
	
	def usernumcomplete(uname)
		@rates=Rating.find(:all, :conditions => ["user = ? and brick_id = ?",uname, self.id])
		@rates.count
	end
	
	def numberlookflag
		num = 0
		@cs=Cluster.find(:all, :conditions => ["brick_id = ? AND lookflag = ?",self.id,1])
		num = @cs.count
  end
  
  def numberall
  	@cs=Cluster.find(:all, :conditions => ["brick_id = ?",self.id])
    num = @cs.count
  end

	def numbergood
		num = 0
		@cs=Cluster.find(:all, :conditions => ["brick_id = ? AND avgrat < ?",self.id,2.0])
		num = @cs.count
	end
	
end
