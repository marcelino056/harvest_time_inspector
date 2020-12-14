class IssueType < ApplicationRecord
  has_many :issues

  def frequency
    ((issues.count.to_f / Issue.count) * 100.00).round(2)
  end
end
