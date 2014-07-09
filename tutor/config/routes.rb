Tutor::Application.routes.draw do
	
	ActiveAdmin.routes(self)
	devise_for :admin_users, ActiveAdmin::Devise.config
	devise_for :teaching_assistants
	devise_for :students
	devise_for :lecturers

	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# Example of regular route:
	#   get 'products/:id' => 'catalog#view'
	# 	get 'products/index'
	get 'courses/sign_up'
	get 'courses/find_course/:id' => 'courses#find_course'
	get 'tracks/show_classmates/:id' => 'tracks#show_classmates'
	get 'solutions/mark_solution'
	get 'solutions/view_submissions'
	post 'solutions/compile_solution' => 'solutions#compile_solution'
	post 'courses/new' => 'courses#new'
	post 'courses/share' => 'courses#share'
	post 'solutions/execute' => 'solutions#execute'
	post '/posts/:id' => 'posts#update'
	post 'tracks/insert_recommendation' => 'tracks#insert_recommendation'
	post 'debuggers/:id' => 'debuggers#start'
	post 'cproblems/submit' => 'cproblems#submit'
	get 'contests/add_problems/:id' => 'contests#add_problems'
	get 'contests/:id/standings' => 'contests#standings'
	get 'contests/:id/registrants' => 'contests#registrants'
	get 'contests/:id/register' => 'contests#register'
	post 'contests/add/:id' => 'contests#add'
	get 'problems/edit'

	get 'c_problems/new'
	post 'c_problems/create'

	get "tips/new"
	get "tips/create"
	get "tips/show"
	get "tips/index"
	get "tips/edit"
	get "tips/destroy"
	post "tips/:id/edit" => 'tips#update'
	get "problems/destroy"
	get "test_cases/edit"
	get "test_cases/destroy"
	get "model_answers/edit"
	get "hints/edit"
	get "model_answers/destroy"
	get "model_answers/back"
	get "notes/destroy"
	get "grades/view_grades"

	# You can have the root of your site routed with "root"
	root 'site#index'
	resources :tracks do
		post 'getProblems', on: :member
	end
	resources :assignment_testcases
	resources :problems_by_tas
	resources :solutions
	resources :problems
	resources :courses
	resources :cproblems
	resources :contests
	resources :contributors

	post "courses/choose"
	post "courses/existing"
	post "courses/duplicate"
	get "model_answers/new"
	post "model_answers/new"

	resources :model_answers
	#resources :test_cases
	#devise_for :teaching_assistants
	#devise_for :students
	#devise_for :lecturers

	# Example of regular route:
	#   get 'products/:id' => 'catalog#view'
	resources :discussion_boards do
		post 'toggle', on: :member
	end
	post 'courses/new' => 'courses#new'
	resources :courses do
		post 'topics/new' => 'topics#new'
		resources :topics
	end
	resources :model_answers do
		post "model_answers/new"
	end

	resources :assignments do
		get "assignments/new"
		post "assignments/show"
		get "assignments/show"
	end
	resources :assignments_problems do
		get "assignment_problems/new"
		get "assignment_problems/edit"
		get "assignment_problems/show"
		get "assignment_problems/index"
		post "assignment_problems/update"
		post "assignment_problems/show"
	end
	post "/assignment_problems/complete"
	resources :assignments_testcases do
		get "assignment_testcases/new"
		get "assignment_testcases/show"
		get "assignment_testcases/index"
		get "assignment_testcases/edit"
		get "/assignment_testcases/new"
	end

	resources :courses do
		post 'hide', on: :member
	end
	resources :test_cases

	# Example of named route that can be invoked with purchase_url(id: product.id)
	#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

	# Example resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products
	resources :courses
	resources :test_cases
	resources :model_answers
	resources :solutions
	resources :topics
	resources :replies
	resources :hints
	resources :lecturers
	resources :teaching_assistants
	resources :students
	resources :posts
	resources :facebook
	resources :tips
	resources :notifications
	resources :contests
	resources :assignments
	resources :assignment_problems
	resources :notes
	resources :grades

	# Example resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end
	resources :tracks do
		member do
			get 'getProblems'
		end
	end

	resources :courses do
		member do
			get 'show_grades'
		end
	end

	resources :assignments do
		member do
			get 'show_correction'
		end
	end

	resources :courses do
		collection do
			post 'sort'
		end
	end

	resources :topics do
		collection do           
			post 'sort'
		end
	end

	resources :discussion_boards do
		member do
			post 'toggle'
		end
	end
	
	resources :model_answers do
		post "model_answers/new"
	end

	resources :tips do
		 get "tips/index"
	end

	resources :hints do
		 get "hints/index"
	end

	resources :solutions_constraints do
		collection do
			post "new"
		end
	end

	resources :problems do
		get 'done'
		get 'destroy_problem'
	end

	# Example resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Example resource route with more complex sub-resources:
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', on: :collection
	#     end
	#   end
	resources :courses do
		post 'topics/new' => 'topics#new'
		resources :topics
		resources :teaching_assistants
		post 'teaching_assistants/new' => 'teaching_assistants#new'
		resources :acknowledgements
		resources :resources, only: [:create, :index, :new, :destroy] do
			get :add_more, on: :collection
		end
	end

	get "utilities/simple_search"
	get "utilities/advanced_search"
	get "utilities/auto_complete"
	# Example resource route with concerns:
	#   concern :toggleable do
	#     post 'toggle'
	#   end
	#   resources :posts, concerns: :toggleable
	#   resources :photos, concerns: :toggleable

	# Example resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end

end
