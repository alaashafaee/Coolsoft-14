ActiveAdmin.register Problem do

  menu parent: "Problems", priority:1
  permit_params :title,:description,:incomplete,:views_count,:time_limit,:track_id,
                :snippet,:fill_gaps,:public,:owner_id,:owner_type,:created_at,
                :updated_at
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
