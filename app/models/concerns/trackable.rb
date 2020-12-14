module Trackable
  extend ActiveSupport::Concern

  included do
    has_many :issues, as: :trackable
    scope :sended_late, -> { joins(:issues).where(issues: {issue_type: 1}) }
    scope :with_error, -> { joins(:issues) }

    def delayed_time
      return 0 if approved_at.day < 3
      "#{approved_at.day - 3} dias"
    end

    def cause
      return unless issues.present?
      issues.first.issue_type.name
    end
  end
end
