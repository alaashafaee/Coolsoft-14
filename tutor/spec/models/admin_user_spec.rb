require 'spec_helper'

describe AdminUser do

	all_activeadmin_resources = ActiveAdmin.application.namespaces.first[1].resources
	activeadmin_resources = all_activeadmin_resources.select{|r| r.is_a?(ActiveAdmin::Resource) &&
							r.include_in_menu?}

	context "check resources" do
		it "check student resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Student")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check AdminUser resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "AdminUser")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Assignment resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Assignment")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Assignment_problem resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "AssignmentProblem")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Attempt resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Attempt")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Contest resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Contest")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Course_Student resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "CourseStudent")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check DiscussionBoard resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "DiscussionBoard")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Grade resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Grade")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Hint resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Hint")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Lecturer resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Lecturer")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check ModelAnswer resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "ModelAnswer")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Post resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Post")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Problem resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Problem")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Recommendation resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Recommendation")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Reply resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Reply")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check TeachingAssistant resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "TeachingAssistant")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check TestCase resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "TestCase")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Topic resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Topic")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check Track resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "Track")
				@flag = true
				end	
			end
			@flag.should == true
		end

		it "check TrackProgression resource" do
			@flag = false;
			activeadmin_resources.each do |resource|
				resource_name = resource.resource_class.name
				if(resource_name == "TrackProgression")
				@flag = true
				end	
			end
			@flag.should == true
		end
	end 

	context "Student" do
		let(:resource_class) { Student }
		let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
		let(:resource)       { all_resources[resource_class] }
		it "check Student in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for Student" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end

	context "Lecturer" do
		let(:resource_class) { Lecturer }
		let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
		let(:resource)       { all_resources[resource_class] }
		it "check Lecturer in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for Lecturer" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end

	context "TeachingAssistant" do
		let(:resource_class) { TeachingAssistant }
		let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
		let(:resource)       { all_resources[resource_class] }
		it "check if TeachingAssistant in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for TeachingAssistant" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end

	context "AdminUser" do
		let(:resource_class) { AdminUser }
		let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
		let(:resource)       { all_resources[resource_class] }
		it "check if AdminUser in menu" do	
			resource.should be_include_in_menu
		end
		
		it "check the actions for AdminUser" do	
		resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end

	context "Assignment" do
		let(:resource_class) { Assignment }
		let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
		let(:resource)       { all_resources[resource_class] }
		it "Assignment in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for Assignment" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end
	
	context "Problem" do
		let(:resource_class) { Problem }
		let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
		let(:resource)       { all_resources[resource_class] }
		it "Problem in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for Problem" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end

	context "Post" do
		let(:resource_class) { Post }
		let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
		let(:resource)       { all_resources[resource_class] }
		it "Post in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for Lecturer" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end	

	context "DiscussionBoard" do
		let(:resource_class) { DiscussionBoard }
			let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
			let(:resource)       { all_resources[resource_class] }
		it "DiscussionBoard in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for DiscussionBoard" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end

	context "Reply" do
		let(:resource_class) { Reply }
			let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
			let(:resource)       { all_resources[resource_class] }
		it "Reply in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for Reply" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end

	context "Grade" do
		let(:resource_class) { Grade }
			let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
			let(:resource)       { all_resources[resource_class] }
		it "Grade in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for Grade" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end

	context "ModelAnswer" do
		let(:resource_class) { ModelAnswer }
			let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
			let(:resource)       { all_resources[resource_class] }
		it "ModelAnswer in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for ModelAnswer" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end

	context "Course" do
		let(:resource_class) { Course }
			let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
			let(:resource)       { all_resources[resource_class] }
		it "Course in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for Course" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end

	context "TestCase" do
		let(:resource_class) { TestCase }
			let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
			let(:resource)       { all_resources[resource_class] }
		it "TestCase in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for TestCase" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end	

	context "Track" do
		let(:resource_class) { Track }
			let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
			let(:resource)       { all_resources[resource_class] }
		it "Track in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for Track" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end			

	context "TrackProgression" do
		let(:resource_class) { TrackProgression }
			let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
			let(:resource)       { all_resources[resource_class] }
		it "TrackProgression in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for TrackProgression" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end	

	context "Recommendation" do
		let(:resource_class) { Recommendation }
			let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
			let(:resource)       { all_resources[resource_class] }
		it "Recommendation in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for Recommendation" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end			

	context "Hint" do
		let(:resource_class) { Hint }
			let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
			let(:resource)       { all_resources[resource_class] }
		it "Hint in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for Hint" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end					
	
	context "check member-of-menu Cproblem" do
		let(:resource_class) { Cproblem }
			let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
			let(:resource)       { all_resources[resource_class] }
		it "Cproblem in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for Cproblem" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end			
	
	context "check member-of-menu AssignmentProblem" do
		let(:resource_class) { AssignmentProblem }
			let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
			let(:resource)       { all_resources[resource_class] }
		it "AssignmentProblem in menu" do	
			resource.should be_include_in_menu
		end

		it "check the actions for AssignmentProblem" do	
			resource.defined_actions.should =~ [:create, :new, :update, :edit, :index, :show, :destroy]
		end
	end			

end
