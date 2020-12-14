ActiveAdmin.register Developer do

  scope :active

  permit_params do
    permitted = [:name, :harvest_id, :pivotal_id,:last_report,
                :rate_per_hour, :contract_type, :contract_long]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  index do
    panel 'Rendimiento por developer' do
      render 'shared/developer'
    end

    panel 'Reportando horas en vivo' do
      render 'shared/live_reported'
    end

    panel 'Relacion de horas del mes' do
      render 'shared/month_hours'
    end

    column "Nombre", :name
    column 'Hoy', :today_hours
    column 'Semana', :week_hours
    column 'Mes', :month_hours
    column 'Cumplimiento' do |d|
      number_to_percentage d.completed_average
    end
    column 'Productividad' do |d|
      number_to_percentage d.effectivity
    end
    column 'Pendientes', :pending_hours_for_today
    column 'Contrato', :contract_type
    column 'Horas diarias', :contract_long
    column 'Running', :running?

    actions
  end
end
