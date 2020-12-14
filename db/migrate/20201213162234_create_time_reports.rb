class CreateTimeReports < ActiveRecord::Migration[6.0]
  def change
    create_table :time_reports do |t|
      t.references :project, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer :to
      t.datetime :approved_at

      t.timestamps
    end
  end
end
