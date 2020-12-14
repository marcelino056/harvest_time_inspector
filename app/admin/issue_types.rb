ActiveAdmin.register IssueType do
  permit_params :name, :description

  index do
    render 'shared/issues_chart'
    column :id
    column :name
    column :description
    actions
  end
end
