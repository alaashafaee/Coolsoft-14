require 'spec_helper'

describe Assignment do
	it 'is valid with a title and description' do
		assignment = Assignment.new(
			title: 'rspec assignemt',
			description: 'This is a test assignemnt',
			due_date: Date.new(2015,1,1))
		expect(assignment).to be_valid
	end 

	it 'is invalid without title' do
		assignment = Assignment.new(
			description: 'This is a test assignemnt',
			due_date: Date.new(2015,1,1)
			)
		expect(assignment).not_to be_valid
	end 

	it 'is valid if it includes problems' do

		aproblem1 = AssignmentProblem.new(
			title: 'P1',
			description: 'P2')
		aproblem2 = AssignmentProblem.new(
			title: 'P1',
			description: 'p2')

		assignment = Assignment.new(
			title: 'rspec assignemt',
			description: 'This is a test assignemnt',
			due_date: Date.new(2015,1,1), problems:[aproblem1 , aproblem2])
		
		expect(assignment.problems[0]).to eq(aproblem1)
		expect(assignment.problems[1]).to eq(aproblem2)
	end

	it 'Changes the number of assignment' do
		assignment = Assignment.new(
			title: 'rspec assignemt',
			description: 'This is a test assignemnt',
			due_date: Date.new(2015,1,1))

		expect {assignment.save}.to change {Assignment.count}.by(1)
	end
end