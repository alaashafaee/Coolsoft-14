class StudentsController < ApplicationController

  def get_performance
  	@solved = Attempt.count(:conditions => { :success => true, :student_id => current_student.id })
  	@failed = Attempt.count(:conditions => { :failure => true, :student_id => current_student.id })
  end

end
