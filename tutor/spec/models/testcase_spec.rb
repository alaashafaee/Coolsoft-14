require 'spec_helper'
include Devise::TestHelpers
describe TestCase do
	it 'is valid with a input and output' do
		testcase = TestCase.new(
			input: 'x',
			output: 'y')
		expect(testcase).to be_valid
	end

	it 'is invalid without input' do
		testcase = TestCase.new(output: 'y')
		expect(testcase).to be_invalid
	end

	it 'is invalid without output' do
		testcase = TestCase.new(input: 'y')
		expect(testcase).to be_invalid
	end
	
	it ' is added successfully to a problem ' do
		testcase1 = TestCase.new(
			input: 'x',
			output: 'y',
			)
		testcase2 = TestCase.new(
			input: 'z',
			output: 'f',
			)

		problem = AssignmentProblem.new(
			title: 'problemtest',
			description: 'test rspec',
			test_cases: [testcase1,testcase2])

		expect(problem.test_cases).to include(testcase1)
	end
end