ActiveAdmin.register Project do
  permit_params :name, :harvest_id, :pivotal_id, :montly_hours

  scope :active

  index do

    column :name
    column :current_month_hours
    column :month_accomplishment do |d|
      number_to_percentage d.month_accomplishment
    end
    column :montly_hours
    actions

    div class: 'pannel' do
      h3 "Trabajadas: #{collection.sum(&:current_month_hours)}"
      h3 "Contratadas: #{collection.sum { |n| n.montly_hours.to_i }}"
    end
  end
end
