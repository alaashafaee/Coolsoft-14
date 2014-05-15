ActiveAdmin.register Attempt do

  
  menu parent: "Problems", priority:6
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  permit_params :student_id,:problem_id,:failure,:success,:incomplete,:created_at
                :updated_at
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end  
end
