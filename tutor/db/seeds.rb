# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts("**************************************************************")
puts("                      Creating records                    ")
puts("**************************************************************")

puts("# ----------------------- Admins ----------------------- ")
	l = AdminUser.new(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
	l.save!

puts("# ----------------------- Lecturers ----------------------- ")
	l = Lecturer.new(email: '1@lecturer.com', password: '123456789', 
		password_confirmation: '123456789', name: 'LecturerI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "PhD", university: "GUC", department: "MET")
	l.save!
	l = Lecturer.new(email: '2@lecturer.com', password: '123456789', 
		password_confirmation: '123456789', name: 'LecturerII',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "PhD", university: "Uni", department: "Dep")
	l.save!

puts("# ----------------------- Students ----------------------- ")
	s = Student.new(email: '1@student.com', password: '123456789', 
		password_confirmation: '123456789', name: 'StudentI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		faculty: "MET", university: "GUC", major: "CS", semester: 6, 
		advising: false, probation: false)
	s.save!
	s = Student.new(email: '2@student.com', password: '123456789', 
		password_confirmation: '123456789', name: 'StudentII',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: false,
		faculty: "Fac", university: "Uni", major: "Maj", semester: 6, 
		advising: true, probation: true)
	s.save!
	s = Student.new(email: '3@student.com', password: '123456789', 
		password_confirmation: '123456789', name: 'StudentIII',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: false,
		faculty: "Fac", university: "Uni", major: "Maj", semester: 6, 
		advising: false, probation: true)
	s.save!
	s = Student.new(email: '4@student.com', password: '123456789', 
		password_confirmation: '123456789', name: 'StudentIV',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		faculty: "Fac", university: "Uni", major: "Maj", semester: 8, 
		advising: true, probation: false)
	s.save!

puts("# ----------------------- TeachingAssistants ----------------------- ")
	t = TeachingAssistant.new(email: '1@ta.com', password: '123456789', 
		password_confirmation: '123456789', name: 'TAI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "MSc", university: "GUC", department: "MET",
		graduated_from: "GUC", graduated_year: 2005)
	t.save!
	t = TeachingAssistant.new(email: '2@ta.com', password: '123456789', 
		password_confirmation: '123456789', name: 'TAII',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "BSc", university: "Uni", department: "Dep",
		graduated_from: "Uni", graduated_year: 2009)
	t.save!

puts("# ----------------------- Courses ----------------------- ")

	Course.create(name:"Data Structures and Alogrithms", 
				description:"This is a very easy course", code:"CSEN1", year:2014, semester:1, link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
	Course.create(name:"Computer Programming Lab", 
				description:"This course's evaluation system is the bad", code:2, year:2014, semester:1, link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
	Course.create(name:"Course3", 
				description:"This is course three", code:3, year:2014, semester:1, link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
	Course.create(name: "CS 2", 
				description:"This is course four", code: "cs2", year: 2014, semester: 2, university: "GUC", link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
	Course.create(name: "CS 3", 
				description:"This is course five", code: "cs3", year: 2014, semester: 3, university: "GUC", link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
	Course.create(name: "CS 4", 
				description:"This is course six", code: "cs4", year: 2014, semester: 4, university: "AUC", link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
	Course.create(name: "CS 5", 
				description:"This is course seven", code: "cs5", year: 2014, semester: 5, university: "AUC", link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")

puts("# ----------------------- Course_Student ----------------------- ")
	CourseStudent.create(share: true)

puts("# ----------------------- DiscussionBoards ----------------------- ")
	DiscussionBoard.create(title:"DiscussionBoard1", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard2", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard3", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard4", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard5", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard6", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard7", activated: true)

puts("# ----------------------- Posts ----------------------- ")
	Post.create(title:"My 1st Post", content: "The Main Objective is to be a winner", views_count: 20)
	Post.create(title:"My 2nd Post", content: "It is very hard to keep in this life, be happy", views_count: 100)
	Post.create(title:"My 3th Post", content: "Post3")
	Post.create(title:"My 4th Post", content: "Post4")

puts("# ----------------------- Replies ----------------------- ")
	Reply.create(content: "Reply1")
	Reply.create(content: "Reply2")
	Reply.create(content: "Reply3")
	Reply.create(content: "Reply4")
	Reply.create(content: "Reply5")
	Reply.create(content: "Reply6")
	Reply.create(content: "Reply7")
	Reply.create(content: "Reply8")
	Reply.create(content: "Reply9")
	Reply.create(content: "Reply10")
	Reply.create(content: "Reply11")
	Reply.create(content: "Reply12")
	Reply.create(content: "Reply13")

puts("# ----------------------- Topics ----------------------- ")
	Topic.create(title: "Topic1", description: "This is Topic1 description")
	Topic.create(title: "Topic2", description: "This is Topic2 description")
	Topic.create(title: "Topic3", description: "This is Topic3 description")

puts("# ----------------------- Hints ----------------------- ")
	Hint.create(message: "Do not Try to Solve CS problem-1", category: false, time: 5, submission_counter:10)
 	Hint.create(message: "Do not Try to Solve CS problem-2", category: true, time: 5, submission_counter:10)
 	Hint.create(message: "Do not Try to Solve CS problem-3", category: false, time: 5, submission_counter:10)

puts("# ----------------------- ModelAnswer ----------------------- ")
	ModelAnswer.create(title: "Answer1", answer: "System.out.println('SQL baaaad')-1")
	ModelAnswer.create(title: "Answer2", answer: "System.out.println('SQL baaaad')-2")
	ModelAnswer.create(title: "Answer3", answer: "System.out.println('SQL baaaad')-3")
	ModelAnswer.create(title: "Answer4", answer: "System.out.println('SQL baaaad')-4")
	ModelAnswer.create(title: "Answer5", answer: "System.out.println('SQL baaaad')-5")
	ModelAnswer.create(title: "Answer6", answer: "System.out.println('SQL baaaad')-6")

puts("# ----------------------- Test Cases ----------------------- ")
	TestCase.create(output: "hello World 1", input:"x = 0")
	TestCase.create(output: "hello World 2", input:"x = 1")
	TestCase.create(output: "hello World 3", input:"x = 2")
	TestCase.create(output: "5.0\n", input:"10\n2")
	TestCase.create(output: "2.5\n", input:"5\n2")
	TestCase.create(output: "Infinity\n", input:"10\n0")

puts("# ----------------------- Method Parameters ----------------------- ")
	MethodParameter.create(parameter:"MethodParameters 1", params_type: "int")
	MethodParameter.create(parameter:"MethodParameters 2", params_type: "int")
	MethodParameter.create(parameter:"MethodParameters 3", params_type: "int")

puts("# ----------------------- Variable Constraints ----------------------- ")
	VariableConstraint.create(variable_name: "VariableConstraint 1")
	VariableConstraint.create(variable_name: "VariableConstraint 2")
	VariableConstraint.create(variable_name: "VariableConstraint 3")

puts("# ----------------------- Problems ----------------------- ")
	## Assignments
		AssignmentProblem.create(title: "AssignmentProblem 1", description: "Your program is to use the brute-force approach in order 
			to find the Answer to Life, the Universe, and Everything. More precisely... rewrite small numbers from 
			input to output. Stop processing input after reading in the number 42. All numbers at input are integers 
			of one or two digits.", final_grade: 100)
		AssignmentProblem.create(title: "AssignmentProblem 2", description: "he Antique Comedians of Malidinesia prefer 
			comedies to tragedies. Unfortunately, most of the ancient plays are tragedies. Therefore 
			the dramatic advisor of ACM has decided to transfigure some tragedies into comedies. 
			Obviously, this work is very hard because the basic sense of the play must be kept intact, 
			although all the things change to their opposites. For example the numbers: if any 
			number appears in the tragedy, it must be converted to its reversed form before 
			being accepted into the comedy play. Reversed number is a number written in arabic 
			numerals but the order of digits is reversed. The first digit becomes last and vice 
			versa. For example, if the main hero had 1245 strawberries in the tragedy, he has 
			5421 of them now. Note that all the leading zeros are omitted. That means if 
			the number ends with a zero, the zero is lost by reversing (e.g. 1200 gives 21). 
			Also note that the reversed number never has any trailing zeros. ACM needs to 
			calculate with reversed numbers. Your task is to add two reversed numbers and output their 
			reversed sum. Of course, the result is not unique because any particular number is a 
			reversed form of several numbers (e.g. 21 could be 12, 120 or 1200 before reversing). 
			Thus we must assume that no zeros were lost by reversing 
			(e.g. assume that the original number was 12).", final_grade: 100)
		AssignmentProblem.create(title: "AssignmentProblem 3", description: "This wont be a hard Problem", final_grade:10)
		AssignmentProblem.create(title: "AssignmentProblem 4", description: "This will be very easy Problem", final_grade:10)
	## Contests
		Cproblem.create(title: "ContestProblem 1", description: "This is very easy Problem")
		Cproblem.create(title: "ContestProblem 2", description: "Given two numbers a and b, output a/b")
		Cproblem.create(title: "ContestProblem 3", description: "This is very hard Problem")
		Cproblem.create(title: "ContestProblem 4", description: "This wont be a hard Problem")
		Cproblem.create(title: "ContestProblem 5", description: "This will be very easy Problem")
		Cproblem.create(title: "ContestProblem 6", description: "This is very easy Problem")
	## Exercise

		Problem.create(title: "Problem 1", description: "Given two numbers a and b, output a/b",
					incomplete: false,
					snippet: "public class CoolSoft {\n\tpublic static void main(String [] args)
					{\n\t\t\n\t}\n}", seen: true, duplicated: false)
		Problem.create(title: "Problem 2", description: "This is very hard Problem",
					incomplete: false,
					snippet: "public class CoolSoft {\n\tpublic static void main(String [] args)
					{\n\t\t\n\t}\n}", seen: true, duplicated: false)
		Problem.create(title: "Problem 3", description: "This wont be a hard Problem",
					incomplete: false,
					snippet: "public class CoolSoft {\n\tpublic static void main(String [] args)
					{\n\t\t\n\t}\n}", seen: true, duplicated: false)
		Problem.create(title: "Problem 4", description: "This will be very easy Problem",
					incomplete: true,
					snippet: "public class CoolSoft {\n\tpublic static void main(String [] args)
					{\n\t\t\n\t}\n}", seen: true, duplicated: false)
		Problem.create(title: "Problem 5", description: "This is very easy Problem",
					snippet: "public class CoolSoft {\n\tpublic static void main(String [] args)
					{\n\t\t\n\t}\n}", seen: true, duplicated: false)
	## Bank
		## problem 1
		Problem.create(id: 100, title: "Bubble Sort", description: "Given array of numbers a use them bubble 
			sort to sort them descendingly ", incomplete: false, seen:true)
		ModelAnswer.create(id: 100, title: "Answer1",problem_id: 100, answer: "")
		TestCase.create(output: "1,2,2,3,5", input:"1,5,3,2,2", model_answer_id: 100)
		TestCase.create(output: "-100,-20,49,100", input:"-100,-20,49,100", model_answer_id: 100)
		ModelAnswer.create(id: 100, title: "Answer1", problem_id: 100, answer: '
				import java.io.BufferedReader;
				import java.io.IOException;
				import java.io.InputStreamReader;
				import java.util.Arrays;
				public class Main {
					public static void main(String[] args) throws IOException {
						BufferedReader str = new BufferedReader(
								new InputStreamReader(System.in));
						String s;
						int n = 0;
						int[] num = null;
						while (!(s = str.readLine()).equals(null)) {
							String[] split = s.split(",");
							n = split.length;
							num = new int[n];
							for (int i = 0; i < n; i++) {
								num[i] = Integer.parseInt(split[i]);
							}
							insertionSort(num);
							String result = Arrays.toString(num);
							result = result.substring(1, result.length() - 1);
							System.out.println(result);
							break;
						}
					}
						public static void BubbleSort(int[] num) {
						int j;
						boolean flag = true; // set flag to true to begin first pass
						int temp; // holding variable

						while (flag) {
							flag = false; // set flag to false awaiting a possible swap
							for (j = 0; j < num.length - 1; j++) {
								if (num[j] < num[j + 1]) // change to > for ascending sort
								{
									temp = num[j]; // swap elements
									num[j] = num[j + 1];
									num[j + 1] = temp;
									flag = true; // shows a swap occurred
									}
								}
							}
						}
					}
				} ')	
		## problem 2
		Problem.create(id: 101, title: "Insertion Sort", description: "Given array of numbers a use the insertion 
			sort to sort them ascendingly  ",incomplete: true, seen:true)
		ModelAnswer.create(id: 101, title: "Answer1", problem_id: 101, answer: 'import java.io.BufferedReader;
				import java.io.IOException;
				import java.io.InputStreamReader;
				import java.util.Arrays;
				public class Main {
					public static void main(String[] args) throws IOException {
						BufferedReader str = new BufferedReader(
								new InputStreamReader(System.in));
						String s;
						int n = 0;
						int[] num = null;
						while (!(s = str.readLine()).equals(null)) {
							String[] split = s.split(",");
							n = split.length;
							num = new int[n];
							for (int i = 0; i < n; i++) {
								num[i] = Integer.parseInt(split[i]);
							}
							insertionSort(num);
							String result = Arrays.toString(num);
							result = result.substring(1, result.length() - 1);
							System.out.println(result);
							break;
						}
					}
					public static void insertionSort(int num[]) {
						for (int i = 0; i < num.length; i++) {
							int value = num[i];
							int j = i - 1;
							while (j >= 0 && num[j] > value) {
								num[j + 1] = num[j];
								j = j - 1;
							}
							num[j + 1] = value;
						}
					}
				}')
		TestCase.create(output: "1,2,2,3,5", input:"1,5,3,2,2", model_answer_id: 101)
		TestCase.create(output: "-100,-20,49,100", input:"-100,-20,49,100", model_answer_id: 101)
		## problem 3 	
		Problem.create(id: 103 , title: "SelectionSort Sort", description: "Given array of numbers a use the selection 
			sort to sort them descendingly ", incomplete: false, seen:true)
		ModelAnswer.create(id: 103, title: "Answer1",problem_id: 103, answer: 'import java.io.BufferedReader;
				import java.io.BufferedReader;
				import java.io.IOException;
				import java.io.InputStreamReader;
				import java.util.Arrays;
				public class Main {
					public static void main(String[] args) throws IOException {
						BufferedReader str = new BufferedReader(
								new InputStreamReader(System.in));
						String s;
						int n = 0;
						int[] num = null;
						while (!(s = str.readLine()).equals(null)) {
							String[] split = s.split(",");
							n = split.length;
							num = new int[n];
							for (int i = 0; i < n; i++) {
								num[i] = Integer.parseInt(split[i]);
							}
							SelectionSort(num);
							String result = Arrays.toString(num);
							result = result.substring(1, result.length() - 1);
							System.out.println(result);
							break;
						}
					}
					public static void SelectionSort(int[] num) {
						int i, j, first, temp;
						for (i = num.length - 1; i > 0; i--) {
							first = 0; // initialize to subscript of first element
							for (j = 1; j <= i; j++) // locate smallest element between
														// positions 1 and i.
							{
								if (num[j] < num[first])
									first = j;
							}
							temp = num[first]; // swap smallest found with element in position
												// i.
							num[first] = num[i];
							num[i] = temp;
					}
				}')
		TestCase.create(output: "1,2,2,3,5", input:"1,5,3,2,2", model_answer_id: 103)
		TestCase.create(output: "-100,-20,49,100", input:"-100,-20,49,100", model_answer_id: 103)	
		## problem 4
		Problem.create(id: 104, title: "The Mean", description: "Given array of numbers calclate 
			the mean for them ", incomplete: false, seen:true)
		TestCase.create(output: "1.0", input:"1 1 1 ", model_answer_id: 104)
		TestCase.create(output: "2.0", input:"1 2 3 ", model_answer_id: 104)
		TestCase.create(output: "2.3333333333333335", input:"1 2 4", model_answer_id: 104)
		Hint.create(message: "The mean is the sum over the number of the items",
		 			category: false, time: 5, submission_counter:1, model_answer_id: 104)
		ModelAnswer.create(id: 104, title: "Answer1", problem_id: 104, answer: '
			public class Main2 {
				public static void main(String[] args) throws IOException {
				BufferedReader str = new BufferedReader(
				new InputStreamReader(System.in));
				String s;
				double n = 0.0;
				double[] num = null;
				double result = 0 ;
				while (!(s = str.readLine()).equals(null)) {
					String[] split = s.split(" ");
					n = split.length;
					num = new double[(int) n];
					for (int i = 0; i < n; i++) {
						num[i] = Double.parseDouble(split[i]);
						result += num[i];
					}
					System.out.println(result/n);
					break;
				}
			}
		}')
		## problem 5
		Problem.create(id: 105 , title: "The max-so-far", description: "Given array of numbers get
			the greatst elements so far",incomplete: false, seen:true)
		TestCase.create(output: "1", input:"1 1 1 ", model_answer_id: 105)
		TestCase.create(output: "222", input:"0 222 -2 ", model_answer_id: 105)
		TestCase.create(output: "-1", input:"-1 -2 -5", model_answer_id: 105)
		Hint.create(message: "Assume that the max-so-far is the first element ",
		 			category: true, time: 5, submission_counter:1, model_answer_id: 105)
		ModelAnswer.create(id: 105,title: "Answer1", problem_id: 105, answer:'
			import java.io.BufferedReader;
			import java.io.IOException;
			import java.io.InputStreamReader;
			public class Main {
				public static void main(String[] args) throws IOException {
					int n = 0;
					BufferedReader str = new BufferedReader(
							new InputStreamReader(System.in));
					String s = str.readLine();
					String[] split = s.split(" ");
					n = split.length;
					int[] num = new int[n];
					int max = Integer.MIN_VALUE;
					for (int i = 0; i < n; i++) {
						num[i] = Integer.parseInt(split[i]);
						if(num[i]>max)
							max = num[i];
					}
					System.out.println(max);
				}
			}')
		## problem 6
		Problem.create(id: 106 , title: "The minmum-so-far", description: "Given array of numbers get
			the smallest elements so far", incomplete: false, seen:true)
		TestCase.create(output: "1", input:"1 1 1 ", model_answer_id: 106)
		TestCase.create(output: "-2", input:"0 222 -2 ", model_answer_id: 106)
		TestCase.create(output: "-4", input:"-1 -2 -5", model_answer_id: 106)
		Hint.create(message: "Assume that the minmum-so-far is the first element ",
		 			category: true, time: 5, submission_counter:1, model_answer_id: 106)
		ModelAnswer.create(id: 106, title: "Answer1", problem_id: 106, answer:'
			import java.io.BufferedReader;
			import java.io.IOException;
			import java.io.InputStreamReader;
			public class Main {
				public static void main(String[] args) throws IOException {
					int n = 0;			
					BufferedReader str = new BufferedReader(
							new InputStreamReader(System.in));
					String s = str.readLine();
					String[] split = s.split(" ");
					n = split.length;
					int[] num = new int[n];
					int max = Integer.MIN_VALUE;
					for (int i = 0; i < n; i++) {
						num[i] = Integer.parseInt(split[i]);
						if(num[i]>max)
							max = num[i];
					}
					System.out.println(max);
				}
			}')
		## problem 7	
		Problem.create(id: 107, title: "Triangle!", description: "Write a java method triangle that
			takes two integers seed and level and displays a pattern like the one given in the 
			examples below:
			triangle(3,4), where 3 is the seed and 4 is the level will display:
			3
			4 5
			6 7 8 
			9 0 1 2
			triangle(7,5), where 7 is the seed and 5 is the level
			7
			8 9
			0 1 2
			3 4 5 6	
			7 8 9 0 1",incomplete: false, seen:true)
		TestCase.create(output: "3 
			4 5 
			6 7 8 
			9 0 1 2 ", input:"3 4", model_answer_id: 107)
		TestCase.create(output: "7 
			8 9 
			0 1 2 
			3 4 5 6 
			7 8 9 0 1 ", input:"7 5", model_answer_id: 107)
		ModelAnswer.create(id: 107, title: "Answer1",problem_id: 107, answer:'
			import java.io.BufferedReader;
			import java.io.IOException;
			import java.io.InputStreamReader;
			public class Main2 {
				public static void main(String[] args) throws IOException {
					InputStreamReader inStream = new InputStreamReader(System.in);
					BufferedReader stdin = new BufferedReader(inStream);
					String inData;
					inData = stdin.readLine();
					String [] split = inData.split(" ");
					int seed = Integer.parseInt(split[0]);
					int size = Integer.parseInt(split[1]);
					drawPattern(seed, size);
				}
				public static void drawPattern(int seed, int size) {
					int i, j;
					for (i = 1; i <= size; i++) {
						for (j = 1; j <= i; j++) {
							if (seed > 9)
								seed = 0;
							System.out.print(seed + " ");
							seed++;
						}
						System.out.println();
					}
				}
			}')
		## Problem 8
		Problem.create(id: 108, title: "Multiplication", description: "Given array of numbers 
			multipy all it elements",incomplete: false, seen:true)
		TestCase.create(output: "6", input:"1 2 3 ", model_answer_id: 108)
		TestCase.create(output: "0", input:"0 0 0 ", model_answer_id: 108)
		TestCase.create(output: "-3", input:"-1 -1 -1", model_answer_id: 108)
		ModelAnswer.create(id: 108,title: "Answer1",problem_id: 108, answer:'
			import java.io.BufferedReader;
			import java.io.IOException;
			import java.io.InputStreamReader;
			public class Main {
				public static void main(String[] args) throws IOException {
					int n = 0;
					int result = 0;
					BufferedReader str = new BufferedReader(
							new InputStreamReader(System.in));
					String s = str.readLine();
					String[] split = s.split(" ");
					n = split.length;
					int[] num = new int[n];
					for (int i = 0; i < n; i++) {
						num[i] = Integer.parseInt(split[i]);
						result*=num[i];
					}
					System.out.println(result);
				}
			}')
		## Problem 9
		Problem.create(id: 109, title: "The reminder", description: "Given two numbers
			a ,b calculate the reminder from dividing a over b ",incomplete: false, seen:true)
		TestCase.create(output: "1", input:"3 2", model_answer_id: 109)
		TestCase.create(output: "0", input:"4 2", model_answer_id: 109)
		TestCase.create(output: "-3", input:"-1 -1 -1", model_answer_id: 109)
		Hint.create(message: "use the java pre-defined operator %",
	 			category: false, time: 5, submission_counter:1, model_answer_id: 109)
		ModelAnswer.create(id: 109,title: "Answer1",problem_id: 109, answer:'
			import java.io.BufferedReader;
			import java.io.IOException;
			import java.io.InputStreamReader;
			public class Main2 {
				public static void main(String[] args) throws IOException {
					BufferedReader str = new BufferedReader(
							new InputStreamReader(System.in));
					String s = str.readLine();
					String[] split = s.split(" ");
					int a = Integer.parseInt(split[0]);
					int b = Integer.parseInt(split[1]);
					System.out.println(a % b);
				}
			}')
		## Problem 10
		Problem.create(id: 110, title: "Fibonacci", description: "Use a recursive function to 
			calculate the Fibonacci number", incomplete: false, seen:true)
		TestCase.create(output: "1", input:"1", model_answer_id: 110)
		TestCase.create(output: "5", input:"5", model_answer_id: 110)
		TestCase.create(output: "8", input:"6", model_answer_id: 110)
		ModelAnswer.create(id: 110,title: "Answer1",problem_id: 110, answer:'
			import java.io.BufferedReader;
			import java.io.IOException;
			import java.io.InputStreamReader;
			public class Main {
				public static void main(String[] args) throws IOException {
					BufferedReader str = new BufferedReader(
							new InputStreamReader(System.in));
					String s = str.readLine();
					String[] split = s.split(" ");
					int a = Integer.parseInt(split[0]);
					System.out.println(fib(a));
				}
				public static int fib(int n) {
					if (n <= 1)
						return n;
					else
						return fib(n - 1) + fib(n - 2);
				}
			}')

puts("# ----------------------- Tracks ----------------------- ")
	Track.create(title: "Track 1", difficulty: 0)
	Track.create(title: "Track 2", difficulty: 1)
	Track.create(title: "Track 3", difficulty: 2)
	Track.create(title: "Track 4", difficulty: 3)

puts("# -----------------------Solutions---------------------------")
	Solution.create(code: "println(My first submitted solution);", length: 5, status: 1)
	Solution.create(code:"println(My second solution)", length:5, status:0)
	Solution.create(code:"println(My third solution)", length:5, status:3)
	Solution.create(code: "println(My first solution) \n int x =10;\n x++;\nDouble y\n y = x/3;", length: 5, status: 0)

puts("# ----------------------- TrackProgression ----------------------- ")
	TrackProgression.create(level: 1, topic_id: 1)
	TrackProgression.create(level: 1, topic_id: 1)
	TrackProgression.create(level: 1, topic_id: 1)
	TrackProgression.create(level: 0, topic_id: 1)
	TrackProgression.create(level: 2, topic_id: 2)

puts("# ----------------------- Attempts ----------------------- ")
	Attempt.create(success: true)
	Attempt.create(failure: true)
	Attempt.create(success: true)
	Attempt.create(failure: true)
	Attempt.create(success: true)
	Attempt.create(success: true)
	Attempt.create(success: true)
	Attempt.create(success: true)
	Attempt.create(success: true)
	Attempt.create(failure: true)
	Attempt.create(failure: true)
	Attempt.create(failure: true)
	Attempt.create(failure: true)

puts("# ----------------------- Recommendations ----------------------- ")
	Recommendation.create(problem_id:1, student_id:1, recommender_id:2)
	Recommendation.create(problem_id:2, student_id:1, recommender_id:2)
	Recommendation.create(problem_id:5, student_id:1, recommender_id:2)

puts("# ----------------------- Contests ----------------------- ")
	Contest.create(title: "Iteration", description: "If you can solve this you will get a level up",
		incomplete: false, start_time: Time.now + 1.second, end_time: Time.now + 7.days)
	Contest.create(title: "Recursion", description: "If you can solve this you will get 2 level up",
		incomplete: false, start_time: Time.now + 1.days, end_time: Time.now + 10.days)
	Contest.create(title: "DB", description: "If you can solve this you will get 4 level up",
		incomplete: false, start_time: Time.now + 5.days, end_time: Time.now + 12.days)
	Contest.create(title: "DFS", description: "If you can solve this you will get 28 level up",
		incomplete: false, start_time: Time.now + 6.days, end_time: Time.now + 19.days)

puts("# ----------------------- Sleeping ----------------------- ")	
	sleep 3
puts("# ----------------------- Finished ----------------------- ")	
puts("# ----------------------- Contests ----------------------- ")
	ContestProgress.create!(status:true, trials: 1)
	ContestProgress.create!(status:false, trials: 2)
	ContestProgress.create!(status:true, trials: 3)
	ContestProgress.create!(status:false, trials: 4)
	ContestProgress.create!(status:true, trials: 5)
	ContestProgress.create!(status:false, trials: 6)
	ContestProgress.create!(status:false, trials: 7)
	ContestProgress.create!(status:true, trials: 8)
	ContestProgress.create!(status:true, trials: 9)

puts("# ----------------------- Assignments ----------------------- ")
	Assignment.create(title:"DSD Assignment_1", publish: true, due_date: Date.new(2009,6,13),
		 description:"This is your first DSD assignment. It contains exersices on basics of logic design.")
	Assignment.create(title:"DMENT Assignment_2", publish: true, due_date: Date.new(2015,1,1))
	Assignment.create(title:"DSD Assignment_3", publish: true, due_date: DateTime.now.to_date)
	Assignment.create(title:"CA Assignment", publish: false, description:"Allows practice on instruction set formats.", due_date: DateTime.now.to_date)

puts("# ----------------------- Grades ----------------------- ")

	Grade.create(grade: 100, student_id: 1, problem_id: 1)
	Grade.create(grade: 80, student_id: 1, problem_id: 2)

puts("**************************************************************")
puts("                      Creating Relations                    ")
puts("**************************************************************")

puts("# ----------------------- Lecturers ----------------------- ")
	## Topics
		Lecturer.first.topics << Topic.first
	## Tracks
		Lecturer.first.tracks << Track.first
	## Problems
		Lecturer.first.problems << Problem.first
		Lecturer.first.problems << Problem.find_by_id(2)
		Lecturer.first.problems << Problem.find_by_id(3)
		Lecturer.first.problems << Problem.find_by_id(4)
		Lecturer.first.problems << Problem.find_by_id(5)

		Lecturer.first.assignment_problems << AssignmentProblem.first
		Lecturer.first.assignment_problems << AssignmentProblem.find_by_id(2)
		Lecturer.first.assignment_problems << AssignmentProblem.find_by_id(3)
		Lecturer.first.assignment_problems << AssignmentProblem.find_by_id(4)

		Lecturer.first.contest_problems << Cproblem.first
		Lecturer.first.contest_problems << Cproblem.find_by_id(2)
		Lecturer.first.contest_problems << Cproblem.find_by_id(3)
		Lecturer.first.contest_problems << Cproblem.find_by_id(4)
		Lecturer.first.contest_problems << Cproblem.find_by_id(5)
	## Courses
		Lecturer.first.courses << Course.first
		Lecturer.first.courses << Course.find_by_id(2)
		Lecturer.first.courses << Course.find_by_code("cs2")
		Lecturer.first.courses << Course.find_by_code("cs3")
		Lecturer.find_by_id(2).courses << Course.find_by_code("cs4")
		Lecturer.find_by_id(2).courses << Course.find_by_code("cs5")
	## Posts
		Lecturer.first.posts << Post.first
		Lecturer.first.posts << Post.find_by_id(2)
	## Replies
		Lecturer.first.replies << Reply.first
		Lecturer.first.replies << Reply.find_by_id(2)
		Lecturer.first.replies << Reply.find_by_id(3)
		Lecturer.first.replies << Reply.find_by_id(4)
		Lecturer.first.replies << Reply.find_by_id(5)
		Lecturer.first.replies << Reply.find_by_id(6)
		Lecturer.first.replies << Reply.find_by_id(7)
		Lecturer.first.replies << Reply.find_by_id(8)
		Lecturer.first.replies << Reply.find_by_id(9)
		Lecturer.first.replies << Reply.find_by_id(10)
		Lecturer.first.replies << Reply.find_by_id(11)
		Lecturer.first.replies << Reply.find_by_id(12)
		Lecturer.first.replies << Reply.find_by_id(13)
	## Contests
		Lecturer.first.contests << Contest.first
		Lecturer.first.contests << Contest.find_by_id(2)
		Lecturer.first.contests << Contest.find_by_id(3)
	## Assignments
		Lecturer.first.assignments << Assignment.first
		Lecturer.first.assignments << Assignment.find_by_id(2)
		Lecturer.first.assignments << Assignment.find_by_id(3)
		Lecturer.first.assignments << Assignment.find_by_id(4)
	## Grades
		Lecturer.first.grades << Grade.first
		Lecturer.find_by_id(2).grades << Grade.find_by_id(2)

puts("# ----------------------- Students ----------------------- ")
	## CourseStudent
		Student.first.course_students << CourseStudent.first
	## Solutions
		Student.first.solutions << Solution.first
		Student.first.solutions << Solution.find_by_id(4)
		Student.first.solutions << Solution.find_by_id(2)
		Student.first.solutions << Solution.find_by_id(3)
	## Attempts
		Student.first.attempts << Attempt.first
		Student.first.attempts << Attempt.find_by_id(2)
		Student.first.attempts << Attempt.find_by_id(3)
		Student.first.attempts << Attempt.find_by_id(4)
		Student.first.attempts << Attempt.find_by_id(5)
		Student.first.attempts << Attempt.find_by_id(6)
		Student.first.attempts << Attempt.find_by_id(7)
		Student.first.attempts << Attempt.find_by_id(8)
		Student.first.attempts << Attempt.find_by_id(9)
		Student.first.attempts << Attempt.find_by_id(10)
		Student.first.attempts << Attempt.find_by_id(11)
		Student.first.attempts << Attempt.find_by_id(12)
		Student.first.attempts << Attempt.find_by_id(13)
	## Courses
		Student.find(2).courses << Course.first
		Student.find(3).courses << Course.first
		Student.find(4).courses << Course.first
		# Other way to add Course into student, but it will require getting Course_student via searching
		# since the table has key on (student_id and course_id)then the array will always be 1 elemet [0]
		Student.find_by_id(2).courses << Course.find_by_id(2)
		CourseStudent.where(student_id:2, course_id:2)[0].update(share: true)
		Student.first.courses << Course.find_by_id(2)
		CourseStudent.where(student_id:1, course_id:2)[0].update(share: true)
	## Tracks Progressions
		Student.find_by_id(2).progressions << TrackProgression.first
		Student.find_by_id(3).progressions << TrackProgression.find_by_id(2)
		Student.find_by_id(4).progressions << TrackProgression.find_by_id(3)
		Student.first.progressions << TrackProgression.find_by_id(4)
		Student.first.progressions << TrackProgression.find_by_id(5)
	## Contests
		Student.first.contests << Contest.first
		Student.find_by_id(2).contests << Contest.first
		Student.find_by_id(3).contests << Contest.first
		Student.find_by_id(4).contests << Contest.first
	## Contests progress
		Student.first.contest_progresses << ContestProgress.first
		Student.first.contest_progresses << ContestProgress.find_by_id(2)
		Student.first.contest_progresses << ContestProgress.find_by_id(3)
		Student.find_by_id(2).contest_progresses << ContestProgress.find_by_id(4)
		Student.find_by_id(2).contest_progresses << ContestProgress.find_by_id(5)
		Student.find_by_id(2).contest_progresses << ContestProgress.find_by_id(6)
		Student.find_by_id(3).contest_progresses << ContestProgress.find_by_id(7)
		Student.find_by_id(3).contest_progresses << ContestProgress.find_by_id(8)
		Student.find_by_id(3).contest_progresses << ContestProgress.find_by_id(9)
		
	## Grades
		Student.first.grades << Grade.first
		Student.first.grades << Grade.find_by_id(2)

puts("# ----------------------- TeachingAssistants ----------------------- ")
	## Courses
		TeachingAssistant.first.courses << Course.first
		TeachingAssistant.find_by_id(2).courses << Course.find_by_id(2)
	## Contests
		TeachingAssistant.first.contests << Contest.find(4)

puts("# ----------------------- Posts ----------------------- ")
	## Replies
		Post.first.replies << Reply.first
		Post.first.replies << Reply.find_by_id(2)
		Post.first.replies << Reply.find_by_id(3)
		Post.first.replies << Reply.find_by_id(4)
		Post.first.replies << Reply.find_by_id(5)
		Post.first.replies << Reply.find_by_id(6)
		Post.first.replies << Reply.find_by_id(7)
		Post.first.replies << Reply.find_by_id(8)
		Post.first.replies << Reply.find_by_id(9)
		Post.first.replies << Reply.find_by_id(10)
		Post.first.replies << Reply.find_by_id(11)
		Post.first.replies << Reply.find_by_id(12)
		Post.first.replies << Reply.find_by_id(13)

puts("# ----------------------- Problems ----------------------- ")
	## TestCases
		Problem.first.test_cases << TestCase.find_by_id(4)
		Problem.first.test_cases << TestCase.find_by_id(5)
		Problem.first.test_cases << TestCase.find_by_id(6)
		Problem.find_by_id(2).test_cases << TestCase.first
		Problem.find_by_id(3).test_cases << TestCase.first
	## Model Answers
		Problem.first.model_answers << ModelAnswer.first
		Problem.first.model_answers << ModelAnswer.find_by_id(2)
		Problem.find_by_id(2).model_answers << ModelAnswer.find_by_id(3)
		Problem.find_by_id(2).model_answers << ModelAnswer.find_by_id(4)
		Problem.find_by_id(3).model_answers << ModelAnswer.find_by_id(5)
		Problem.find_by_id(3).model_answers << ModelAnswer.find_by_id(6)
	## Solutions
		AssignmentProblem.first.solutions << Solution.first
		AssignmentProblem.first.solutions << Solution.find_by_id(4)
		Problem.find_by_id(2).solutions << Solution.find_by_id(2)
		Problem.find_by_id(3).solutions << Solution.find_by_id(3)

	## Attempts
		Problem.first.attempts << Attempt.first
		Problem.first.attempts << Attempt.find_by_id(2)
		Problem.first.attempts << Attempt.find_by_id(3)
		Problem.first.attempts << Attempt.find_by_id(4)
		Problem.first.attempts << Attempt.find_by_id(5)
		Problem.first.attempts << Attempt.find_by_id(6)
		Problem.first.attempts << Attempt.find_by_id(7)
		Problem.first.attempts << Attempt.find_by_id(8)
		Problem.first.attempts << Attempt.find_by_id(9)
		Problem.first.attempts << Attempt.find_by_id(10)
		Problem.first.attempts << Attempt.find_by_id(11)
		Problem.first.attempts << Attempt.find_by_id(12)
		Problem.first.attempts << Attempt.find_by_id(13)
	## Contest Progress
		Cproblem.find_by_id(1).contests_progresses << ContestProgress.first
		Cproblem.find_by_id(2).contests_progresses << ContestProgress.find_by_id(2)
		Cproblem.find_by_id(3).contests_progresses << ContestProgress.find_by_id(3)
		Cproblem.find_by_id(1).contests_progresses << ContestProgress.find_by_id(4)
		Cproblem.find_by_id(2).contests_progresses << ContestProgress.find_by_id(5)
		Cproblem.find_by_id(3).contests_progresses << ContestProgress.find_by_id(6)
		Cproblem.find_by_id(1).contests_progresses << ContestProgress.find_by_id(7)
		Cproblem.find_by_id(2).contests_progresses << ContestProgress.find_by_id(8)
		Cproblem.find_by_id(3).contests_progresses << ContestProgress.find_by_id(9)

	## Hints
		Problem.first.model_answers.first.hints << Hint.first
		Problem.first.model_answers.first.hints << Hint.all.second

puts("# ----------------------- Tracks ----------------------- ")
	## Problems
		Track.first.problems << Problem.first
		Track.first.problems << Problem.find_by_id(2)
		Track.find_by_id(2).problems << Problem.find_by_id(3)
		Track.find_by_id(2).problems << Problem.find_by_id(4)
		Track.find_by_id(3).problems << Problem.find_by_id(5)

puts("# ----------------------- Topics ----------------------- ")
	## Tracks
		Topic.first.tracks << Track.first
		Topic.first.tracks << Track.find_by_id(2)
		Topic.find_by_id(2).tracks << Track.find_by_id(3)
		Topic.find_by_id(3).tracks << Track.find_by_id(4)

puts("# ----------------------- Courses ----------------------- ")
	## Topics
		Course.first.topics << Topic.first
		Course.first.topics << Topic.find_by_id(2)
		Course.find_by_id(2).topics << Topic.find_by_id(3)
	## Discussion Board
		Course.first.discussion_board = DiscussionBoard.first
		Course.find_by_id(2).discussion_board = DiscussionBoard.find_by_id(2)
		Course.find_by_id(3).discussion_board = DiscussionBoard.find_by_id(3)
		Course.find_by_id(4).discussion_board = DiscussionBoard.find_by_id(4)
		Course.find_by_id(5).discussion_board = DiscussionBoard.find_by_id(5)
		Course.find_by_id(6).discussion_board = DiscussionBoard.find_by_id(6)
		Course.find_by_id(7).discussion_board = DiscussionBoard.find_by_id(7)
	## Course Student	
		Course.first.course_students << CourseStudent.first
	## Assignments
		Course.first.assignments << Assignment.first
		Course.first.assignments << Assignment.find_by_id(2)
		Course.first.assignments << Assignment.find_by_id(4)
		Course.find_by_id(2).assignments << Assignment.find_by_id(3)
	## Contests
		Course.first.contests << Contest.first
		Course.first.contests << Contest.find(2)
		Course.find(2).contests << Contest.find(3)
		Course.first.contests << Contest.find(4)


puts("# ----------------------- DiscussionBoard ----------------------- ")
	## Posts
		DiscussionBoard.first.posts << Post.first
		DiscussionBoard.first.posts << Post.find_by_id(2)

puts("# ----------------------- Contests ----------------------- ")
	## Problems
		Contest.first.problems << Cproblem.find_by_id(1)
		Contest.first.problems << Cproblem.find_by_id(2)
		Contest.first.problems << Cproblem.find_by_id(3)

	## Contests Progress
		Contest.first.progress << ContestProgress.first
		Contest.first.progress << ContestProgress.find_by_id(2)
		Contest.first.progress << ContestProgress.find_by_id(3)
		Contest.first.progress << ContestProgress.find_by_id(4)
		Contest.first.progress << ContestProgress.find_by_id(5)
		Contest.first.progress << ContestProgress.find_by_id(6)
		Contest.first.progress << ContestProgress.find_by_id(7)
		Contest.first.progress << ContestProgress.find_by_id(8)
		Contest.first.progress << ContestProgress.find_by_id(9)

puts("# ----------------------- Assignment ----------------------- ")
	## Problems
		Assignment.first.problems << AssignmentProblem.first
		Assignment.first.problems << AssignmentProblem.find_by_id(2)
		Assignment.find_by_id(2).problems << AssignmentProblem.find_by_id(3)
		Assignment.find_by_id(3).problems << AssignmentProblem.find_by_id(4)

puts("# ----------------------- Grades ----------------------- ")
	## Problems
		Grade.first.update(problem_id:Assignment.first.problems.first.id)
		Grade.find_by_id(2).update(problem_id:Assignment.first.problems.find_by_id(2).id)

puts("# --------------------------------------------------------- ")
