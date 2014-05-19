require 'spec_helper'

describe JavaCompiler do
  context "test java compiler" do
		before(:each) do
			s = Student.create(email: '1@student.com', password: 'Aa123456789', 
				password_confirmation: 'Aa123456789', name: 'StudentI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				faculty: "MET", university: "GUC", major: "CS", semester: 6, 
				advising: false, probation: false)
			problem = Problem.create(title: "Problem 1",
				description: "Given two numbers a and b, output a/b", incomplete: false)
			@code = "public class Coolsoft{public static void main(String [] args){}}"
			@student_id = s.id
			@problem_id = problem.id
			@problem_type = "Problem"
			@class_name = "Coolsoft"
			@solution = Solution.create(code: @code, student_id: @student_id,
				problem_id: @problem_id, problem_type: @problem_type, class_name: @class_name)
		end

		context "compiler" do
			

			it "compile with no errors or warnings" do
				expect(JavaCompiler.compile @solution, @code).to eq("")			
			end

			it "compile with no errors but with warnings" do
				@code= "import java.util.*; public class CoolSoft { public static void main(String [] args)" +
					" { LinkedList l = new LinkedList(); l.add(5); } }"
				expect(JavaCompiler.compile @solution, @code).to eq("students_solutions/st1pr1so1/Coolsoft.java:1:" +
					" class CoolSoft is public, should be declared in a file named CoolSoft.java\nimport java.util.*;" +
					" public class CoolSoft { public static void main(String [] args) { LinkedList l = new LinkedList();" +
					" l.add(5); } }\u001A\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\n" +
					"                           ^\nstudents_solutions/st1pr1so1/Coolsoft.java:1: warning: [unchecked]" +
					" unchecked call to add(E) as a member of the raw type java.util.LinkedList\nimport java.util.*;" +
					" public class CoolSoft { public static void main(String [] args) { LinkedList l = new LinkedList();" +
					" l.add(5); } }\u001A\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\n" +
					"                                                                                               " +
					"                             ^\n1 error\n1 warning\n")			
			end

			it "compile with errors" do
				@code = "public class Coolsoft{public static void main(String [] args){ int x }}"
				expect(JavaCompiler.compile @solution, @code).to eq("students_solutions/st1pr1so1/Coolsoft.java:1:" +
					" ';' expected\npublic class Coolsoft{public static void main(String [] args){ int x }}" +
					"\u001A\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\n                           " +
					"                                         ^\n1 error\n")			
			end

			it "compiler_feedback with no errors or warnings" do
				expect(JavaCompiler.compiler_feedback @solution).to eq({success: true, errors: nil, warnings: nil})
			end

			it "compiler_feedback with no errors but warnings" do
				@code= "import java.util.*; public class CoolSoft { public static void main(String [] args)" +
					" { LinkedList l = new LinkedList(); l.add(5); } }"
				@solution.code = @code
				expect(JavaCompiler.compiler_feedback @solution).to eq({:success=>false, :errors=>"Coolsoft.java:1: " +
					"class CoolSoft is public, should be declared in a file named CoolSoft.java\nimport java.util.*;" +
						" public class CoolSoft { public static void main(String [] args) { LinkedList l = new LinkedList();" +
						" l.add(5); } }          \n                           ^\nCoolsoft.java:1: warning: [unchecked] " +
						"unchecked call to add(E) as a member of the raw type java.util.LinkedList\nimport java.util.*; " +
						"public class CoolSoft { public static void main(String [] args) { LinkedList l = new LinkedList();" +
						" l.add(5); } }          \n                                                                     " +
						"                                                       ^\n1 error\n1 warning\n", :warnings=>nil})
			end

			it "compiler_feedback with errors" do
				@code = "public class Coolsoft{public static void main(String [] args){ int x }}"
				@solution.code = @code
				expect(JavaCompiler.compiler_feedback @solution).to eq({:success=>false, :errors=>"Coolsoft.java:1:" +
					" ';' expected\npublic class Coolsoft{public static void main(String [] args){ int x }}        " +
					"  \n                                                                   " +
					" ^\n1 error\n", :warnings=>nil})
			end

			it "file name contains special characters" do
				@solution.class_name = "CoolSoft!"
				expect(JavaCompiler.compile @solution, @code).to eq("The file name cannot contain special characters")			
			end

			it "file name contains line breaks" do
				@solution.class_name = "Cool\nSoft"
				expect(JavaCompiler.compile @solution, @code).to eq("The file name cannot contain line breaks")			
			end

			it "file name contains white spaces" do
				@solution.class_name = "Cool Soft"
				expect(JavaCompiler.compile @solution, @code).to eq("The file name cannot contain white spaces")		
			end

			it "file name is empty" do
				@solution.class_name = ""
				expect(JavaCompiler.compile @solution, @code).to eq("The file name cannot be empty")
			end

		end
	end
end
