class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.integer :harvest_id
      t.references :client, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.float :total_hours
      t.float :amount

      t.timestamps
    end
  end
end
