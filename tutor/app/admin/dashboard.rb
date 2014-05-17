ActiveAdmin.register_page "Dashboard" do

	# [Admin - Story 3.19]
	# It gets some informations of the last 4 Lecturers,TAs,Students that 
	#   have been added to the database.
	# Parameters: none.
	# Returns:
	#   For a lecturer/TA, it returns name,email,university,degree.
	#   For a student, it returns name,email.university,faculty,major.     
	# Author: Mimi
	menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }
	content :title => proc{ I18n.t("active_admin.dashboard") } do
		columns do
			column do
				panel "Recent Lecturers" do
					table_for Lecturer.limit(4) do
						column("name"){|lecturer| (lecturer.name)} 
						column("email"){|lecturer| link_to(lecturer.email,admin_lecturer_path(lecturer.id))} 
						column("university"){|lecturer| (lecturer.university)} 
						column("department"){|lecturer| (lecturer.department)} 
						column("degree"){|lecturer| (lecturer.degree)} 
					end
				end
			end
		end
		columns do
			column do
				panel "Recent TAs" do
					table_for TeachingAssistant.limit(4) do
						column("name"){|teaching_assistant| (teaching_assistant.name)} 
						column("email"){|teaching_assistant| link_to(teaching_assistant.email,admin_teaching_assistant_path(teaching_assistant.id))} 
						column("university"){|teaching_assistant| (teaching_assistant.university)} 
						column("department"){|teaching_assistant| (teaching_assistant.department)} 
						column("degree"){|teaching_assistant| (teaching_assistant.degree)} 
					end
				end
			end
		end
		columns do
			column do
				panel "Recent Students" do
					table_for Student.limit(4) do
						column("name"){|student| (student.name)} 
						column("email"){|student| link_to(student.email,admin_lecturer_path(student.id))} 
						column("university"){|student| (student.university)} 
						column("faculty"){|student| (student.faculty)} 
						column("major"){|student| (student.major)} 
					end
				end
			end
		end
	end
end