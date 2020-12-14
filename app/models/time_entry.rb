class TimeEntry < ApplicationRecord
  belongs_to :developer
  belongs_to :project, optional: true

  scope :running, -> { where(running: true)}
  scope :today, -> { where('started_at BETWEEN ? AND ?', Time.now.beginning_of_day, Time.now.end_of_day) }
  scope :week, -> { where('started_at BETWEEN ? AND ?', self.beginning_of_week, self.end_of_week) }
  scope :this_year, -> { where('started_at BETWEEN ? AND ?', Time.now.beginning_of_year, Time.now.end_of_year) }
  scope :previous_week, -> { where('started_at BETWEEN ? AND ?', self.beginning_of_last_week, self.end_of_last_week) }
  scope :month, -> { where('started_at BETWEEN ? AND ?', self.beginning_of_month, self.end_of_month) }
  scope :billable, -> { where(billable: true) }
  scope :unapproved, -> { where(approved: false).group_by(&:developer) }
  scope :not_billable, -> { where(invoiced: false) }

  private
  def self.last_week
    Time.now - 1.week
  end

  def self.beginning_of_last_week
    last_week.beginning_of_week
  end

  def self.end_of_last_week
    last_week.end_of_week
  end


  def beginning_of_day
    Time.now.beginning_of_day - 4.hours
  end

  def end_of_day
    Time.now.end_of_day - 4.hours
  end

  def self.beginning_of_week
    Time.now.beginning_of_week - 4.hours
  end

  def self.end_of_week
    Time.now.end_of_week - 4.hours
  end

  def self.beginning_of_month
    Time.now.beginning_of_month - 4.hours
  end

  def self.end_of_month
    Time.now.end_of_month - 4.hours
  end
end
