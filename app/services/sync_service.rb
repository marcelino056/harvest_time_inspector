class SyncService
  def initialize
    @harvest = HarvestService.new
  end

  def sync
    @harvest.sync
    developer_invoice_simulation
    time_report_simulation
  end

  def quickbook_simulation

  end

  def time_report_simulation
    Project.active.each do |project|
      project.time_entries.billable.group_by { |e| e.started_at.to_s(:month_and_year) }.each do |date, entries|
        padding_days = rand(1..10).days
        submit_date = DateTime.parse("1-#{date}").end_of_month + padding_days
        approved_at = submit_date + rand(2.5).days

        report = project.time_reports.create(
          start_date: DateTime.parse("1-#{date}"),
          end_date: DateTime.parse("1-#{date}").end_of_month,
          approved_at: approved_at
        )

        if padding_days > 3 && ![0,6].include?(submit_date.wday)
          rand_issue = IssueType.find((5..8).to_a.sample)
          report.issues.create(
            issue_type: rand_issue,
            comment: rand_issue.description,
            solved_at: rand(submit_date..approved_at)
          )
        end

        entries.map { |e| e.update(approved: true) }
      end
    end
  end

  def developer_invoice_simulation
    Developer.where("contract_type = 1 AND rate_per_hour IS NOT NULL").each do |dev|
      dev.time_entries.group_by { |e| e.started_at.to_s(:month_and_year) }.each do |date, results|
        padding_days = rand(1..10).days
        submit_date = DateTime.parse("1-#{date}").end_of_month + padding_days
        approved_at = submit_date + rand(2.5).days

        invoice = dev.contractor_invoices.create(
          total_hours: results.sum(&:total_hours),
          cost: dev.rate_per_hour,
          submitted_at: submit_date,
          approved_at: approved_at
        )

        if padding_days > 3 && ![0,6].include?(submit_date.wday)
          rand_issue = IssueType.find((1..4).to_a.sample)
          invoice.issues.create(
            issue_type: rand_issue,
            comment: rand_issue.description,
            solved_at: rand(submit_date..approved_at)
          )
        end

        results.map { |r| r.update(invoiced: true) }
      end
    end
  end
end
