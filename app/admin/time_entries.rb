ActiveAdmin.register TimeEntry do
  permit_params :developer_id, :billable, :project_id, :harvest_id,
                :pivotal_id, :description_long, :running, :invoiced,
                :total_hours, :approved, :reported_at, :last_modify,
                :started_at, :ended_time

  index do
    column :id
    column :developer
    column :billable
    column :running
    column :invoiced
    column :approved
    column :total_hours
    column 'En tiempo real', :live_reported?
  end
end
