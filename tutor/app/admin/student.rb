ActiveAdmin.register Student do

  menu parent: "Users", priority: 3
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  permit_params :name,:email,:password,:password_confirmation,:faculty,:semester,
                :major,:university,:dob,:gender
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  form do |f|
    f.inputs "Student Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :faculty
      f.input :semester
      f.input :major
      f.input :university
      f.input :dob
      f.input :gender
    end
    f.actions
  end
end
