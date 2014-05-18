require 'spec_helper'

describe PythonDebugger do
	context "Valid Variables" do

		before (:all) do
			@p = PythonDebugger.new
		end

		it 'has an invalid name' do
			expect(@p.is_valid_variable("'__reserved__'", "'Test'")).to eq(false)
		end

		it 'has an invalid value 1' do
			expect(@p.is_valid_variable("'a'", "<built-in function compile>")).to eq(false)
		end

		it 'has an invalid value 2' do
			expect(@p.is_valid_variable("'a'", "<type 'module'>")).to eq(false)
		end

		it 'has an invalid value 3' do
			expect(@p.is_valid_variable("'a'", "<type 'exceptions.OSError'>")).to eq(false)
		end

		it 'has an invalid name and value' do
			expect(@p.is_valid_variable("'__reserved__'", "<type 'exceptions.OSError'>")).to eq(false)
		end

		it 'has a valid name and value' do
			expect(@p.is_valid_variable("'a'", "'Test'")).to eq(true)
		end

	end
end
