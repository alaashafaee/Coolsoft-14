require 'spec_helper'

describe AssignmentProblem do
	it 'is valid with a title and description' do
		assignment = AssignmentProblem.new(
			title: 'rspec assignemt problem',
			description: 'This is an assignment problem test')
		expect(assignment).to be_valid
	end 

	it 'is invalid without title' do
		assignment = AssignmentProblem.new(
			description: 'This is a test assignemnt'
			)
		expect(assignment).not_to be_valid
	end 
	
	it ' is added successfully to an asssignmet ' do
		aproblem1 = AssignmentProblem.new(
			title: 'P1',
			description: 'P2',
			)
		aproblem2 = AssignmentProblem.new(
			title: 'P1',
			description: 'P2',
			)

		assignment = Assignment.new(
			title: 'rspec assignemt',
			description: 'This is a test assignemnt',
			due_date: Date.new(2015,1,1) ,
			problems: [aproblem1,aproblem2])

		expect(assignment.problems).to include(aproblem1)
	end
end