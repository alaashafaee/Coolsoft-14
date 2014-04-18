class StudentsController < ApplicationController

  def get_performance
  	@solved = current_student.success_attempts
  	@failed = current_student.failure_attempts
  end

end
