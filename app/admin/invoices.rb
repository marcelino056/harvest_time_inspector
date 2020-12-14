ActiveAdmin.register Invoice do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :harvest_id, :client_id, :start_date, :end_date, :total_hours, :amount
  #
  # or
  #
  # permit_params do
  #   permitted = [:harvest_id, :client_id, :start_date, :end_date, :total_hours, :amount]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
