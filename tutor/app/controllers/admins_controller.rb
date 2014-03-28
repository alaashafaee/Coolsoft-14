class AdminsController < ApplicationController
	#a method to choose all lecturers whose requests aren't approved 
	def allLecturers
  	@lecturers = lecturer.find_by verified_type : false
  end
    #a method to choose all TAs whose requests aren't approved
    def allTAs
  	@TAs = teaching_assistants.find_by verified_type : false
  end
  	#a method to approve the requests of TAs
    def approveRequestsTA
  	@x= x.find_by_id(params[:id])
	x.update(verified_type: true)
  end
  	#a method to approve the requests of Lecturers
    def approveRequestsLecturer
  	@y=y.find_by_id(params[:id])
  	y.update(verified_type: true)
  end

end
