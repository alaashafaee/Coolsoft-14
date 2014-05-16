require 'spec_helper'

describe Resource do
	before(:all) do
		@resource_1 = Resource.new(link: 'https://google.com',
			description: 'Google is a search engine')
		@resource_2 = Resource.new(description: 'Google is a search engine', course_id: 1)
	end

	it 'is valid with a link' do
		expect(@resource_1).to be_valid
	end

	it 'is not valid with a link' do
		expect(@resource_2).not_to be_valid
	end

end