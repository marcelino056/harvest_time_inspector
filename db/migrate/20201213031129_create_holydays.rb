class CreateHolydays < ActiveRecord::Migration[6.0]
  def change
    create_table :holydays do |t|
      t.string :name
      t.date :official_day

      t.timestamps
    end
  end
end
