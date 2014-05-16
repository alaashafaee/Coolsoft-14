require 'spec_helper'

describe AssignmentsController do

  describe "GET 'new'" do
  context 'when assignment is invalid' do
      assignment = new(:assignment)

      post :new, assignment: { title: 'assignmenttest', description: 'eh' }
  expect{
        post :new, :id => assignment.id}.to change(Assignment, :count).by(1)

  end
  end

  

end
