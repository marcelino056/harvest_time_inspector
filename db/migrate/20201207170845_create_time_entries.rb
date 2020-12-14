class CreateTimeEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :time_entries do |t|
      t.references :developer, null: false, foreign_key: true
      t.boolean :billable
      t.references :project, null: true, foreign_key: true
      t.string :harvest_id
      t.string :pivotal_id
      t.string :description_long
      t.boolean :running
      t.boolean :invoiced
      t.float :total_hours
      t.boolean :approved
      t.datetime :reported_at
      t.datetime :last_modify
      t.datetime :started_at
      t.datetime :ended_time

      t.timestamps
    end
  end
end
