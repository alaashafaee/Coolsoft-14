require 'spec_helper'

describe Resource do
	before(:all) do
		@resource_1 = Resource.new(link: 'https://google.com',
			description: 'Google is a search engine')
		@resource_2 = Resource.new(link: 'https://google.com',
			description: 'Google is a search engine', course_id: 1)
	end

	it 'is valid with a link' do
		expect(@resource_1).to be_valid
	end

end