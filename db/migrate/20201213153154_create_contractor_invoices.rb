class CreateContractorInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :contractor_invoices do |t|
      t.references :developer, null: false, foreign_key: true
      t.float :total_hours
      t.float :cost
      t.datetime :submitted_at
      t.datetime :approved_at

      t.timestamps
    end
  end
end
