require 'spec_helper'

describe SolutionsLayer do

	context "get_compiler tests" do
		it "get java compiler" do
			expect(SolutionsLayer.get_compiler "java").to eq JavaCompiler
		end

		it "no such compiler named blabla" do
			expect(SolutionsLayer.get_compiler "blabla").to eq false
		end
	end

	context "get_executer tests" do
		it "get java executer" do
			expect(SolutionsLayer.get_executer "java").to eq JavaExecuter
		end
	
		it "raise error when trying to get a non valid blabla executer" do
			expect{SolutionsLayer.get_executer "blabla"}.to raise_error(NameError)
		end
	end

	context "get_debugger tests" do
		it "get java debugger" do
				expect(SolutionsLayer.get_debugger "java").to eq JavaDebugger
			end

		it "no such debugger named blabla" do
			expect(SolutionsLayer.get_debugger "blabla").to eq false
		end
	end

	context "test compile and execut and debug with java" do
		before(:all) do
			s = Student.create(email: '1@student.com', password: '123456789', 
				password_confirmation: '123456789', name: 'StudentI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				faculty: "MET", university: "GUC", major: "CS", semester: 6, 
				advising: false, probation: false)
			problem = Problem.create(title: "Problem 1",
				description: "Given two numbers a and b, output a/b", incomplete: false)
			test_cases = TestCase.create(output: "5\n", input:"10 2")
			problem.test_cases << test_cases
			@code = "public static void main(String [] args){}}"
			@student_id = 1
			@problem_id = problem.id
			@lang = "java"
			@cases1 = "1 12 123"
			@cases2 = "1 12"
			@solution = Solution.create(code: @code, student_id: @student_id,
				problem_id: @problem_id)
		end

		context "compiler" do
			it "a solution is created" do
				expect(Solution).to receive(:create).and_return(@solution)
				SolutionsLayer.compile @lang, @code, @student_id, @problem_id
			end

			it "java JavaCompiler.compiler_feedback was called" do
				expect(JavaCompiler).to receive(:compiler_feedback){
					{success: false, errors: ""}
				}
				SolutionsLayer.compile @lang, @code, @student_id, @problem_id
			end

			it "get_compiler was called and JavaCompiler was returned" do
				expect(SolutionsLayer).to receive(:get_compiler).with("java"){JavaCompiler}
				SolutionsLayer.compile @lang, @code, @student_id, @problem_id
			end

			it "get_solution was called and new Solution was returned" do
				expect(SolutionsLayer).to receive(:get_solution).and_return(@solution)
				SolutionsLayer.compile @lang, @code, @student_id, @problem_id
			end

			it "Compiled successfuly" do
				feed_back = SolutionsLayer.compile @lang, @code, @student_id, @problem_id
				expected_hash = {success: true, errors: nil}
				expect(feed_back).to eq expected_hash
			end
		end

		context "executer" do
			it "get_compiler was called and JavaCompiler was returned" do
				expect(SolutionsLayer).to receive(:get_compiler).with("java"){JavaCompiler}
				SolutionsLayer.execute @lang, @code, @student_id, @problem_id, @cases1
			end

			it "Compiled successfuly but wrong input" do
				feed_back = SolutionsLayer.execute @lang, @code, @student_id, @problem_id, @cases1
				expected_hash = {executer_feedback: false, executer_output: "Enter only 2 numbers"}
				expect(feed_back).to eq expected_hash
			end

			it "Compiled successfuly and run successfuly with no output" do
				feed_back = SolutionsLayer.execute @lang, @code, @student_id, @problem_id, @cases2
				expected_hash = {executer_feedback: true,
					executer_output: {success: true, message: ""}
				}
				expect(feed_back).to eq expected_hash
			end

			it "Compilation error" do
				code = "public static void main(String [] args){System.out.println(5)}}"
				feed_back = SolutionsLayer.execute @lang, code, @student_id, @problem_id, @cases2
				expected_hash = {compiler_error: true,
       				compiler_output: {success: false,
       					errors: "CoolSoft.java:2: error: ';' expected\npublic " +
       					"static void main(String [] args){System.out.println(5)}}" +
       					"\n                                              " + 
       					"               ^\n1 error\n"}
				}
				expect(feed_back).to eq expected_hash
			end

			it "Compiled successfuly and run successfuly with output" do
				code = "public static void main(String [] args){System.out.println(5);}}"
				feed_back = SolutionsLayer.execute @lang, code, @student_id, @problem_id, @cases2
				expected_hash = {executer_feedback: true,
					executer_output: {success: true, message: "5\n"}
				}
				expect(feed_back).to eq expected_hash
			end
		end

		context "debugger" do
			it "get_solution called" do
				expect(SolutionsLayer).to receive(:get_solution).and_return(@solution)
				SolutionsLayer.debug @lang, @code, @student_id, @problem_id, @cases1
			end

			it "get_compiler called" do
				expect(SolutionsLayer).to receive(:get_compiler).and_return(JavaCompiler)
				SolutionsLayer.debug @lang, @code, @student_id, @problem_id, @cases1
			end

			it "get_debugger called" do
				expect(SolutionsLayer).to receive(:get_debugger).and_return(JavaDebugger)
				SolutionsLayer.debug @lang, @code, @student_id, @problem_id, @cases1
			end

			it "Compilation error" do
				code = "public static void main(String [] args){System.out.println(5)}}"
				feed_back = SolutionsLayer.debug @lang, code, @student_id, @problem_id, @cases1
				expected_hash = {data: {success: false, errors: "CoolSoft.java:2: error: ';'" +
					" expected\npublic static void main(String [] args){" +
					"System.out.println(5)}}\n                            " +
					"                                 ^\n1 error\n"}, success: false}
				expect(feed_back).to eq expected_hash
			end

			it "Debugged successfuly", focus: true do
				feed_back = SolutionsLayer.debug @lang, @code, @student_id, @problem_id, @cases1
				expected_hash = {data: [{status: true, line: 2, stream: "",
					locals: [" args = {\n\"1\", \"12\", \"123\"\n}\n"]}], success: true}
				expect(feed_back).to eq expected_hash
			end
		end
	end

end
