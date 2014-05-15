ActiveAdmin.register AssignmentProblem do

  menu parent: "Problems", priority:2
  permit_params :title,:description,:time_limit,:owner_id,:owner_type,:created_at,
                :updated_at,:assignment_id,:final_grade
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
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
