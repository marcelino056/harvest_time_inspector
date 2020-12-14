class Developer < ApplicationRecord
  enum contract_type: [:employee, :contractor, :administrative]
  has_many :time_entries
  has_many :contractor_invoices

  scope :active, -> { where.not(contract_long: nil) }
  scope :unsubmitted, -> { joins(:time_entries).where(time_entries: {approved: false}).uniq }
  scope :contractor, -> { where(contract_type: 1) }

  def delay_invoices
    (contractor_invoices.sended_late.count.to_f / contractor_invoices.count) * 100
  end

  def live_report_average
    (time_entries.month.map { |e| !e.live_reported? }.count.to_f / time_entries.month.count) * 100
  end

  def today_hours
    time_entries.today.sum(&:total_hours)
  end

  def effectivity
    return 0 if month_hours == 0
    (time_entries.month.billable.sum(&:total_hours) / month_hours) * 100
  end

  def week_hours
    time_entries.week.sum(&:total_hours)
  end

  def last_week_hours
    time_entries.previous_week.sum(&:total_hours)
  end

  def last_week_approved?
    time_entries.previous_week.any?(&:approved)
  end

  def month_hours
    time_entries.month.sum(&:total_hours)
  end

  def completed_average
    return 0 if contract_long.nil?
    ((month_hours / montly_hours) * 100).round(2)
  end

  def pending_hours_for_today
    return 0 if contract_long.nil?
    contract_long - today_hours
  end

  def montly_hours
    return 0 if contract_long.nil?
    business_days_of_month(Time.now.month) * contract_long
  end

  def running?
    time_entries.running.any?
  end

  private
  def business_days_of_month(month, year = Time.now.year)
    first_day = Date.parse("#{year}-#{month}-01")
    end_day = first_day.end_of_month
    current_day = first_day
    days = 0

    while current_day < end_day
      unless current_day.wday == 0 || current_day.wday == 6 || Holyday.all.map(&:official_day).include?(current_day)
        days = days + 1
      end
      current_day = current_day + 1.day
    end
    days
  end
end
