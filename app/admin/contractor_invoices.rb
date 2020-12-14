ActiveAdmin.register ContractorInvoice do
  permit_params :developer_id, :total_hours, :cost, :submitted_at, :approved_at

  index do
    column :developer
    column :total_hours
    column :cost
    column :submitted_at
    column :approved_at
    column :status
    actions
  end

  show do
    attributes_table do
      row :developer
      row :total_hours
      row :cost
      row :submitted_at
      row :approved_at
      row :status
      row :delayed_time
      row :cause
    end
  end
end
