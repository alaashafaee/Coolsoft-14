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
	get "utilities/simple_search"
	get "utilities/advanced_search"
	get "utilities/auto_complete"
	get 'courses/sign_up'
	get 'tracks/show_classmates/:id' => 'tracks#show_classmates'
	post 'solutions/compile_solution' => 'solutions#compile_solution'
	post 'courses/new' => 'courses#new'
	post 'courses/share' => 'courses#share'
	post 'solutions/execute' => 'solutions#execute'
	post '/posts/:id' => 'posts#update'
	post 'tracks/insert_recommendation' => 'tracks#insert_recommendation'
	post 'debuggers/:id' => 'debuggers#start'

	get 'problems/edit'

	get "tips/new"
	get "tips/create"
	get "tips/show"
	get "tips/index"
	get "tips/edit"
	get "tips/destroy"	
	post "tips/:id/edit" => 'tips#update'

	# You can have the root of your site routed with "root"
	root 'site#index'
	resources :tracks do
		post 'getProblems', on: :member
	end
	resources :problems_by_tas
	resources :solutions
	resources :problems
	resources :courses
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
	resources :assignments
	resources :assignment_problems

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
	end

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