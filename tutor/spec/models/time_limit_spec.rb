require 'spec_helper'

describe TimeLimit do
	context "TimeLimit Execeded" do
		it "sleeping" do
			expect(TimeLimit.start 5, "sleep 20").not_to raise_error
		end

		it "infinite loop" do
			expect(TimeLimit.start(5){
				while true
				end
				}).not_to raise_error
		end
	end

	context "TimeLimit wasnot Execeded" do
		it "echo foo" do
			expect(TimeLimit.start 1, "echo foo").to eq [true, "foo\n", ""]
		end
	end
end
