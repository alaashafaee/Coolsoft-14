require 'spec_helper'

include Devise::TestHelpers

describe Problem do
	it 'is valid with a title and description' do
		problem = Problem.new(
			title: 'rspec problem',
			description: 'This is a problem test',
			track_id: '4',
			owner_id: '1'
			)
		expect(problem).to be_valid
	end 

	it 'is invalid without title' do
		problem = Problem.new(
			description: 'This is a new problem'
			)
		expect(problem).not_to be_valid
	end 
	
	it ' is added successfully to a track ' do
		problem1 = Problem.new(
			title: 'Problem1',
			description: 'Problem2',
			track_id: '4',
			owner_id: '1'
			)
		problem2 = Problem.new(
			title: 'Problem1',
			description: 'Problem2',
			track_id: '4',
			owner_id: '1'
			)

		track = Track.new(
			title: 'rspec track',
			difficulty: '4',
			problems: [problem1,problem2])

		expect(track.problems).to include(problem1, problem2)
	end
end