require 'spec_helper'

describe SolutionsLayer do

	context "get_compiler tests" do
		it "get java compiler" do
			expect(SolutionsLayer.get_compiler "java").to eq JavaCompiler
		end

		it "get python compiler" do
			expect(SolutionsLayer.get_compiler "python").to eq PythonCompiler
		end

		it "no such compiler named foo" do
			expect(SolutionsLayer.get_compiler "foo").to eq false
		end
	end

	context "get_executer tests" do
		it "get java executer" do
			expect(SolutionsLayer.get_executer "java").to eq JavaExecuter
		end

		it "get python executer" do
			expect(SolutionsLayer.get_executer "python").to eq PythonExecuter
		end
	
		it "no such executer named foo" do
			expect(SolutionsLayer.get_executer "foo").to eq false
		end
	end

	context "get_debugger tests" do
		it "get java debugger" do
			expect(SolutionsLayer.get_debugger "java").to eq JavaDebugger
		end

		it "get python debugger" do
			expect(SolutionsLayer.get_debugger "python").to eq PythonDebugger
		end

		it "no such debugger named foo" do
			expect(SolutionsLayer.get_debugger "foo").to eq false
		end
	end

	context "test compile and execut and debug with java" do
		before(:all) do
			s = Student.create(email: '1@student.com', password: 'Aa123456789', 
				password_confirmation: 'Aa123456789', name: 'StudentI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				faculty: "MET", university: "GUC", major: "CS", semester: 6, 
				advising: false, probation: false)
			problem = Problem.create(title: "Problem 1",
				description: "Given two numbers a and b, output a/b", incomplete: false)
			test_cases = TestCase.create(output: "5\n", input:"10\n2")
			problem.test_cases << test_cases
			@code = "public class Coolsoft{public static void main(String [] args){}}"
			@student_id = 1
			@problem_id = problem.id
			@lang = "java"
			@cases1 = "1\n12\n123"
			@cases2 = "1\n12"
			@problem_type = "Problem"
			@class_name = "Coolsoft"
			@solution = Solution.create(code: @code, student_id: @student_id,
				problem_id: @problem_id, problem_type: @problem_type, class_name: @class_name)
		end

		context "compiler" do
			it "a solution is created" do
				expect(Solution).to receive(:create).and_return(@solution)
				SolutionsLayer.compile @lang, @code, @student_id, @problem_id, @problem_type, @class_name
			end

			it "java JavaCompiler.compiler_feedback was called" do
				expect(JavaCompiler).to receive(:compiler_feedback){
					{success: false, errors: ""}
				}
				SolutionsLayer.compile @lang, @code, @student_id, @problem_id, @problem_type, @class_name
			end

			it "get_compiler was called and JavaCompiler was returned" do
				expect(SolutionsLayer).to receive(:get_compiler).with("java"){JavaCompiler}
				SolutionsLayer.compile @lang, @code, @student_id, @problem_id, @problem_type, @class_name
			end

			it "get_solution was called and new Solution was returned" do
				expect(SolutionsLayer).to receive(:get_solution).and_return(@solution)
				SolutionsLayer.compile @lang, @code, @student_id, @problem_id, @problem_type, @class_name
			end

			it "Compiled successfuly" do
				feed_back = SolutionsLayer.compile(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name)
				expected_hash = {success: true, errors: nil}
				expect(feed_back).to eq expected_hash
			end
		end

		context "executer" do
			it "get_compiler was called and JavaCompiler was returned" do
				expect(SolutionsLayer).to receive(:get_compiler).with("java"){JavaCompiler}
				SolutionsLayer.execute(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
			end

			it "Compiled successfuly but wrong input" do
				feed_back = SolutionsLayer.execute(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
				expected_hash = {executer_feedback: false, executer_output: "Enter only 2 inputs"}
				expect(feed_back).to eq expected_hash
			end

			it "Compiled successfuly and run successfuly with no output" do
				feed_back = SolutionsLayer.execute(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases2)
				expected_hash = {executer_feedback: true,
					executer_output: {success: true, message: ""}
				}
				expect(feed_back).to eq expected_hash
			end

			it "Compilation error" do
				code = "public class Coolsoft{public static void main" +
					"(String [] args){System.out.println(5)}}"
				feed_back = SolutionsLayer.execute(@lang, code, @student_id,
					@problem_id, @problem_type, @class_name, @cases2)
				expected_hash = {compiler_error: true, compiler_output: {success: false,
					errors: "Coolsoft.java:1: error: ';' expected\npublic " +
					"class Coolsoft{public static void main(String [] args)" +
					"{System.out.println(5)}}\n                              " +
					"                                                     ^\n1 error\n"}
				}
				expect(feed_back).to eq expected_hash
			end

			it "Compiled successfuly and run successfuly with output" do
				code = "public class Coolsoft{public static void main" +
					"(String [] args){System.out.println(5);}}"
				feed_back = SolutionsLayer.execute(@lang, code, @student_id,
					@problem_id, @problem_type, @class_name, @cases2)
				expected_hash = {executer_feedback: true,
					executer_output: {success: true, message: "5\n"}
				}
				expect(feed_back).to eq expected_hash
			end
		end

		context "debugger" do
			it "get_solution called" do
				expect(SolutionsLayer).to receive(:get_solution).and_return(@solution)
				SolutionsLayer.debug(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
			end

			it "get_compiler called" do
				expect(SolutionsLayer).to receive(:get_compiler).and_return(JavaCompiler)
				SolutionsLayer.debug(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
			end

			it "get_debugger called" do
				expect(SolutionsLayer).to receive(:get_debugger).and_return(JavaDebugger)
				SolutionsLayer.debug(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
			end

			it "Compilation error" do
				code = "public class Coolsoft{public static void main" +
					"(String [] args){System.out.println(5)}}"
				feed_back = SolutionsLayer.debug(@lang, code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
				expected_hash = {success: false, data: {success: false,
					errors: "Coolsoft.java:1: error: ';'" +
					" expected\npublic class Coolsoft{public static void main(String [] args){" +
					"System.out.println(5)}}\n                                               " +
					"                                    ^\n1 error\n"}}
				expect(feed_back).to eq expected_hash
			end

			it "Debugged successfuly", focus: true do
				feed_back = SolutionsLayer.debug(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
				expected_hash = {data: [{status: true, line: 1, stream: "",
					locals: [" args = {\n\"1\", \"12\", \"123\"\n}\n"]}], success: true,
					status: "The debugging session was successful."}
				expect(feed_back).to eq expected_hash
			end
		end
	end

	context "test compile and execut and debug with python" do
		before(:all) do
			s = Student.create(email: '1@student.com', password: 'Aa123456789', 
				password_confirmation: 'Aa123456789', name: 'StudentI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				faculty: "MET", university: "GUC", major: "CS", semester: 6, 
				advising: false, probation: false)
			problem = Problem.create(title: "Problem 1",
				description: "Given two numbers a and b, output a/b", incomplete: false)
			test_cases = TestCase.create(output: "5\n", input:"10 2")
			problem.test_cases << test_cases
			@code = "x = 5\ny = 6\nprint x/y"
			@student_id = 1
			@problem_id = problem.id
			@lang = "python"
			@cases1 = "1 12 123"
			@cases2 = "1 12"
			@problem_type = "Problem"
			@class_name = "Coolsoft"
			@solution = Solution.create(code: @code, student_id: @student_id,
				problem_id: @problem_id, problem_type: @problem_type, class_name: @class_name)
		end

		context "compiler" do
			it "a solution is created" do
				expect(Solution).to receive(:create).and_return(@solution)
				SolutionsLayer.compile @lang, @code, @student_id, @problem_id, @problem_type, @class_name
			end

			it "python PythonCompiler.compiler_feedback was called" do
				expect(PythonCompiler).to receive(:compiler_feedback){
					{success: false, errors: ""}
				}
				SolutionsLayer.compile @lang, @code, @student_id, @problem_id, @problem_type, @class_name
			end

			it "get_compiler was called and PythonCompiler was returned" do
				expect(SolutionsLayer).to receive(:get_compiler).with("python"){PythonCompiler}
				SolutionsLayer.compile @lang, @code, @student_id, @problem_id, @problem_type, @class_name
			end

			it "get_solution was called and new Solution was returned" do
				expect(SolutionsLayer).to receive(:get_solution).and_return(@solution)
				SolutionsLayer.compile @lang, @code, @student_id, @problem_id, @problem_type, @class_name
			end

			it "Compiled successfuly" do
				feed_back = SolutionsLayer.compile(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name)
				expected_hash = {success: true, errors: nil}
				expect(feed_back).to eq expected_hash
			end
		end

		context "executer" do
			it "get_compiler was called and PythonCompiler was returned" do
				expect(SolutionsLayer).to receive(:get_compiler).with("python"){PythonCompiler}
				SolutionsLayer.execute(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
			end

			it "Compiled successfuly and run successfuly with no output" do
				code = "x = 6\ny = 5"
				feed_back = SolutionsLayer.execute(@lang, code, @student_id,
					@problem_id, @problem_type, @class_name, @cases2)
				expected_hash = {executer_feedback: true,
					executer_output: {success: true, message: ""}
				}
				expect(feed_back).to eq expected_hash
			end

			it "Compilation error" do
				code = "prin 5"
				feed_back = SolutionsLayer.execute(@lang, code, @student_id,
					@problem_id, @problem_type, @class_name, @cases2)
				expected_hash = {compiler_error: true, compiler_output: {success: false,
					errors: "  File \"Coolsoft.py\", line 1\n    prin 5\n         ^\nSyntaxError: invalid syntax\n"}
				}
				expect(feed_back).to eq expected_hash
			end

			it "Compiled successfuly and run successfuly with output" do
				code = "print 5"
				feed_back = SolutionsLayer.execute(@lang, code, @student_id,
					@problem_id, @problem_type, @class_name, @cases2)
				expected_hash = {executer_feedback: true,
					executer_output: {success: true, message: "5\n"}
				}
				expect(feed_back).to eq expected_hash
			end
		end

		context "debugger" do
			it "get_solution called" do
				expect(SolutionsLayer).to receive(:get_solution).and_return(@solution)
				SolutionsLayer.debug(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
			end

			it "get_compiler called" do
				expect(SolutionsLayer).to receive(:get_compiler).and_return(PythonCompiler)
				SolutionsLayer.debug(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
			end

			it "get_debugger called" do
				expect(SolutionsLayer).to receive(:get_debugger).and_return(PythonDebugger)
				SolutionsLayer.debug(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
			end

			it "Compilation error" do
				code = "a = [1,2"
				feed_back = SolutionsLayer.debug(@lang, code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
				expected_hash = {success: false, data: {success: false,
					errors: "  File \"Coolsoft.py\", line 1\n    a = [1,2\n     " +
					"      ^\nSyntaxError: unexpected EOF while parsing\n"}}
				expect(feed_back).to eq expected_hash
			end

			it "Debugged successfuly", focus: true do
				feed_back = SolutionsLayer.debug(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
				expected_hash = {data: [{:status=>true, :line=>1, :stream=>"", :locals=>[]},
					{:status=>true, :line=>2, :stream=>"", :locals=>[]},
					{:status=>true, :line=>3, :stream=>"", :locals=>[]},
					{:status=>false, :line=>3, :stream=>"0\r\n", :locals=>[], :exception=>""}],
					success: true, status: "The debugging session was successful."}
				expect(feed_back).to eq expected_hash
			end
		end
	end
	
end