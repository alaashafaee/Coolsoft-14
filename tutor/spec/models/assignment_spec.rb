require 'spec_helper'

describe Assignment do
	it 'Invalid assignment without title' do
		ass = Assignment.new(title:"bbbbb", publish: false , description:"Allows practice on instruction set formats." ,due_date: DateTime.now.to_date)
		expect(ass.title).not_to eq(nil)
	end

#	it 'InValid without a title' do
#		ass = Assignment.new
#		expect(ass.title).to eq(nil)
#	end
end