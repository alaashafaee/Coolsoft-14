ActiveAdmin.register Recommendation do

  menu parent: "Problems", priority:7
  permit_params :problem_id, :student_id, :recommender_id
  form do |f|
    f.inputs "Recommendation Details" do
     f.input :problem_id
     f.input :student_id
     f.input :recommender_id
    end
    f.actions
  end
end
