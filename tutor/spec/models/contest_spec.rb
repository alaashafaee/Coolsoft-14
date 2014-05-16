require 'spec_helper'

describe Contest do
	it 'is valid by passing all validations' do
		contest = Contest.new(title:"rspec contest",
			description:"This contest will not see the light", incomplete:false,
			start_time:Time.now+2.days, end_time:Time.now+7.days)
		expect(contest).to be_valid
	end 

	it 'is invalid without title' do
		contest = Contest.new(description:"This contest will not see the light",
			incomplete:false, start_time:Time.now+2.days, end_time:Time.now+7.days)
		expect(contest).not_to be_valid
	end 

	it 'is invalid with end date not after start date' do
		contest = Contest.new(title:"Any title", description:"Yes you can",
		incomplete:false, start_time:Time.now+4.days, end_time:Time.now+3.days)
		expect(contest).not_to be_valid
	end

	it 'is invalid with past start time' do
		contest = Contest.new(title:"rspec contest",
			description:"This contest will not see the light", incomplete:false,
			start_time:Time.now-2.days, end_time:Time.now+7.days)
		expect(contest).not_to be_valid
	end

	it 'increments Contest count' do
		contest = Contest.new(title:"rspec contest",
			description:"This contest will see the light", incomplete:false,
			start_time:Time.now+2.days, end_time:Time.now+7.days)

		expect {contest.save}.to change {Contest.count}.by(1)
	end

end