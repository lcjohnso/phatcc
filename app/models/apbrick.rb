class Apbrick < ActiveRecord::Base
  has_many :apobjects
  accepts_nested_attributes_for :apobjects

  def numberall
    @cs=Apobject.where("apbrick_id = ?",self.id)
    num = @cs.count
  end

  def numbercluster
    num = 0
    @cs=Apobject.where("apbrick_id = ? AND viewfrac >= ? AND galfrac < ?",self.id,0.35,0.5)
    num = @cs.count
  end

end
