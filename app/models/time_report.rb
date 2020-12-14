class TimeReport < ApplicationRecord
  include Trackable
  belongs_to :project

  def status
    (approved_at.day > 3) ? 'Tarde' : 'A tiempo'
  end
end
