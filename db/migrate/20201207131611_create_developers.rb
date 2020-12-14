class CreateDevelopers < ActiveRecord::Migration[6.0]
  def change
    create_table :developers do |t|
      t.string :name
      t.string :harvest_id
      t.datetime :last_report
      t.float :rate_per_hour
      t.integer :contract_type
      t.integer :contract_long
      t.timestamps
    end
  end
end
