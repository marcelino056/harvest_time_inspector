ActiveAdmin.register TimeReport do
  permit_params :project_id, :start_date, :end_date, :to, :approved_at

  form do |f|
    f.inputs 'Reporte de horas' do
      f.input :project, as: :select2
      f.input :start_date
      f.input :end_date
      f.submit
    end
  end

  index do
    column :project
    column :start_date
    column :end_date
    column :approved_at
    column :status
    column 'motivo', :cause
    actions
  end

end
