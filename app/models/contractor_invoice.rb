class ContractorInvoice < ApplicationRecord
  include Trackable
  belongs_to :developer

  def status
    (submitted_at.day > 3) ? 'Tarde' : 'A tiempo'
  end
end
