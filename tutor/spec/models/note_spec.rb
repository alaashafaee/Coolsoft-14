require 'spec_helper'

describe Note do
	it 'is valid with a content, solution_id and line' do
		solution = Solution.new(
			code: "println(My first solution)\n
			int x =10;\n x++;\n Double y\n y = x/3;",
			length: 5,
			status: 1)
		solution.save
		note = Note.new(
			content: 'This is a comment on a line of code',
			line: 1,
			solution_id: solution.id)
		expect(note).to be_valid
	end

	it 'is invalid without content' do
		solution = Solution.new(
			code: "println(My first solution)\n
			int x =10;\n x++;\n Double y\n y = x/3;",
			length: 5,
			status: 1)
		note = Note.new(
			line: 1,
			solution_id: solution.id)
		expect(note).not_to be_valid
	end

	it 'is invalid without line' do
		solution = Solution.new(
			code: "println(My first solution)\n
			int x =10;\n x++;\n Double y\n y = x/3;",
			length: 5,
			status: 1)
		note = Note.new(
			content: "This is a comment on a line of code",
			solution_id: solution.id)
		expect(note).not_to be_valid
	end

	it 'is invalid without solution_id' do
	note = Note.new(
		content: "This is a comment on a line of code",
		line: 1)
	expect(note).not_to be_valid
	end

	it 'Changes the number of notes' do
		solution = Solution.new(
			code: "println(My first solution)\n
			int x =10;\n x++;\n Double y\n y = x/3;",
			length: 5,
			status: 1)
		solution.save
		note = Note.new(
			content: "This is a comment on a line of code",
			line: 1,
			solution_id: solution.id)
		expect {note.save}.to change {Note.count}.by(1)
	end
end