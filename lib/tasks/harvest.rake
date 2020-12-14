desc 'Harvest update time tracking'
task update_timesheets: :environment  do
  update_since = (Setting.last_harvest_sync || Time.now)

  Setting.last_harvest_sync = Time.now
end
