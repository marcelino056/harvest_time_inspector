class Project < ApplicationRecord
  has_many :time_entries
  has_many :time_reports

  scope :active, -> { where.not(montly_hours: nil) }

  def current_month_hours
    time_entries.month.sum(&:total_hours)
  end

  def pending_hours
    (current_month_hours / montly_hours.to_f) * 100
  end

  def delay_invoices
    (time_reports.with_error.count.to_f / time_reports.count) * 100
  end

  def month_accomplishment
    return 0 if montly_hours.nil?
    (current_month_hours / montly_hours.to_i) * 100
  end
end
