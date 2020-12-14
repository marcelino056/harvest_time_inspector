class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :harvest_id
      t.string :pivotal_id
      t.string :montly_hours

      t.timestamps
    end
  end
end
