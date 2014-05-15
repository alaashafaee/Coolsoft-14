ActiveAdmin.register Recommendation do

  menu parent: "Problems", priority:7
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :problem_id,:student_id,:recommender_id
  form do |f|
    f.inputs "Recommendation Details" do
     f.input :problem_id
     f.input :student_id
     f.input :recommender_id
    end
    f.actions
  end
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
end
