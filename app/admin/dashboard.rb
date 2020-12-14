ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel 'Facturas de contratistas' do
          render 'shared/contractor_invoice'
          table_for ContractorInvoice.all.sort_by(&:approved_at) do
            column :developer
            column :submitted_at
            column :approved_at
            column :status
          end
        end
      end

      column do
        panel "Reportes de horas" do
          render 'shared/time_reports'
          table_for TimeReport.all.sort_by(&:approved_at) do
            column :id
            column :project
            column :approved_at
            column :status
          end
        end
      end
    end

    columns do
      column do
        panel "Causas de tardansas" do
          render 'shared/issues_chart'
          table_for IssueType.all do
            column :name
            column 'Frecuencia' do |cause|
              number_to_percentage(cause.frequency, precision: 2)
            end
          end
        end
      end
      column do
        panel 'Estatus de proyecto' do
          table_for Project.active do
            column :name
            column :current_month_hours
            column :montly_hours
            column :pending_hours do |p|
              number_to_percentage(p.pending_hours, precision: 2)
            end
          end
        end
      end
    end

    columns do
      column do
        panel 'Horas reportadas por empleado' do
          table_for Developer.active do
            column 'Nombre', :name
            column 'Hoy', :today_hours
            column 'Semana', :week_hours
            column 'Pendientes', :pending_hours_for_today
            column 'Running', :running?
          end
        end
      end

      column do
        panel "Horas a revisar" do
          table_for Developer.unsubmitted do
            column 'Nombre', :name
            column 'horas', :last_week_hours
            column 'Aprobadas', :last_week_approved?
          end
        end
      end
    end
  end # content
end
