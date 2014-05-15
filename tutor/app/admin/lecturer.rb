ActiveAdmin.register Lecturer do

  menu parent: "Users",priority:1
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #permit_params :email, :password, :password_confirmation
  permit_params :email,:password,:password_confirmation,:dob,:gender,:degree,
                :university,:department,:name
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
   form do |f|
    f.inputs "Lecturer Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :degree
      f.input :university
      f.input :department
      f.input :dob
      f.input :gender
    end
    f.actions
  end


  
end
