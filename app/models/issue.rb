class Issue < ApplicationRecord
  belongs_to :issue_type
  belongs_to :trackable, polymorphic: true
end
