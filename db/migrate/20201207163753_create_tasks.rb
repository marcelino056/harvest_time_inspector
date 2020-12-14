class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :project
      t.string :pivotal_id
      t.string :name
      t.datetime :delivere_date
      t.datetime :finished_at

      t.timestamps
    end
  end
end
