class AddLiveEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :time_entries, :live_reported, :boolean
  end
end
