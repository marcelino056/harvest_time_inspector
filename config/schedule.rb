every 2.minutes do
  runner 'HarvestService.new.update_hours'
end

every 1.hour do
  runner 'harvestService.new.sync'
end
