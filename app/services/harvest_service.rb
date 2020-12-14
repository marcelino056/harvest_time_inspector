class HarvestService

  attr_accessor :client

  def initialize
    @client = Harvesting::Client.new
  end

  def sync
    update_developers
    update_clients
    update_projects
    update_hours
    update_invoices
  end

  def update_invoices
    @client.invoices.each do |invoice|
      Invoice.find_or_create_by(harvest_id: invoice.id) do |n_invoice|
        n_invoice.client = Client.find_by(harvest_id: invoice.client.id)
        n_invoice.start_date = invoice.period_start
        n_invoice.end_date = invoice.period_end
        n_invoice.total_hours = invoice.line_items.sum(&:quantity)
        n_invoice.amount =invoice.amount
      end
    end
  end

  def update_hours
    entries = []
    current_page = 0
    last_update = (Setting.last_harvest_sync || Time.now.beginning_of_year).strftime('%Y-%m-%dT%H:%M:%S')

    loop do
      query = "time_entries/?page=#{current_page += 1}&updated_since=#{last_update}"
      response = @client.get(query)
      response['time_entries'].each do |entry|

        report = TimeEntry.find_or_create_by(harvest_id: entry['id']) do |n_entry|
          n_entry.developer = Developer.find_by(harvest_id: entry['user']['id'])
          n_entry.project = Project.find_by(harvest_id: entry['project']['id'])
          n_entry.reported_at = entry['created_at']
        end

        report.update(
          project_id: Project.find_by(harvest_id: entry['project']['id']).id,
          billable: entry['billable'],
          approved: entry['is_locked'],
          description_long: entry['notes'].nil? ? 0 : entry['notes'].length,
          last_modify: entry['updated_at'],
          started_at: DateTime.parse([entry['spent_date'], entry['started_time']].join(' ')),
          ended_time: DateTime.parse([entry['spent_date'], entry['ended_time']].join(' ')),
          running: entry['is_running'],
          invoiced: entry['is_invoiced'],
          total_hours: entry['hours'],
          live_reported: entry['timer_started_at'] == entry['created_at']
        )
      end
      break if response['next_page'].nil?
    end

    Setting.last_harvest_sync = Time.now
  end

  def update_projects
    @client.projects.each do |project|
      Project.find_or_create_by(harvest_id: project.id) do |n_project|
        n_project.name = project.name
      end
    end
  end

  def update_developers
    @client.users.map do |dev|
      if dev.is_active
        Developer.find_or_create_by(harvest_id: dev.id) do |n_dev|
          n_dev.contract_type = dev.is_contractor ? :contractor : :employee
          n_dev.name = [dev.first_name, dev.last_name].join(' ')
          n_dev.rate_per_hour = dev.default_hourly_rate
        end
      end
    end
  end

  def update_clients
    @client.clients.map do |client|
      if client.is_active
        Client.find_or_create_by(harvest_id: client.id) do |n_client|
          n_client.name = client.name
        end
      end
    end
  end
end
