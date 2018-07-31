class Rating < ActiveRecord::Base
  belongs_to :cluster
	belongs_to :brick
    
  def prioritycolor(score)
		if (score == 1)
			bckcolor="BGCOLOR='green'"
		elsif (score == 2)
			bckcolor="BGCOLOR='yellow'"
		elsif (score == 3)
			bckcolor="BGCOLOR='red'"
		else
			bckcolor=""
		end
		bckcolor
	end
end
