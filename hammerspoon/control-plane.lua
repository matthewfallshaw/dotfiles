local logger = hs.logger.new("ControlPlane")
logger.i("Loading ControlPlane")

local obj = {}

obj.cachedLocation = ''
obj.locationFacts = {}

function obj.killApp(appname)
  local app = hs.application.get(appname)
  if app then
    logger.i("Closing " .. appname)
    app:kill()
    if app:isRunning() then app:kill9() end
  end
end

function obj.resumeApp(appname)
  local app = hs.application.get(appname)
  if app and app:isRunning() then
    -- no action
  else
    return hs.application.open(appname)
  end
end

function obj.location()
  if obj.locationFacts['network'] and obj.locationFacts['network'] == 'iPhone' then
    -- At top because iPhone network is expensive; other network inferences below
    logger.i("Inferring iPhone from network")
    return obj.locationFacts['network']
  elseif obj.locationFacts['monitor'] then
    logger.i("Inferring ".. obj.locationFacts['monitor'] .." from monitor")
    return obj.locationFacts['monitor']
  elseif obj.locationFacts['psu'] then
    logger.i("Inferring ".. obj.locationFacts['psu'] .." from psu")
    return obj.locationFacts['psu']
  else
    logger.i("Inferring … well, failing to infer, so falling back to 'Roaming'")
    return 'Roaming'
  end
end

function obj.queueActions()
  obj.actionTimer:start()
end

function obj.actions()
  local newLocation = obj.location()
  if obj.cachedLocation ~= newLocation then
    logger.i("Actions for cachedLocation: ".. obj.cachedLocation ..", newLocation: ".. newLocation)
    if obj.cachedLocation ~= '' then
      logger.i(obj.cachedLocation .. " Exit")
      if obj[obj.cachedLocation .. 'ExitActions'] then
        obj[obj.cachedLocation .. 'ExitActions']()  -- Exit actions for current location
      end
    end
    logger.i(newLocation .. " Entry")
    if obj[newLocation .. 'EntryActions'] then
      obj[newLocation .. 'EntryActions']()     -- Entry actions for new location
    end
    obj.cachedLocation = newLocation
  else
    logger.i("(location unchanged: ".. obj.cachedLocation ..")")
  end
end
obj.actionTimer = hs.timer.delayed.new(5, obj.actions)

function obj:start()
  for k,v in pairs(obj) do
    if type(v) == 'function' and string.find(k, "Callback$") then
      v()
    end
    if type(v) == 'userdata' and string.find(k, "Watcher$") then
      logger.i("Starting " .. k)
      v:start()
    end
  end
  obj.queueActions()
  return obj
end

-- ## Watchers & Callbacks ##

-- On certain events update locationFacts and trigger a location check

-- Network configuration change (iPhone)
function obj.networkConfCallback(_, keys)
  logger.i("Network config changed (" .. hs.inspect(keys) .. ")")
  -- Work out which network we're on
  if (hs.network.reachability.internet():status() & hs.network.reachability.flags.reachable) > 0 then
    local pi4, pi6 = hs.network.primaryInterfaces() -- use pi4, ignore pi6
    if pi4 then
      logger.i("Primary interface is ".. pi4)
    else
      logger.i("hs.network.reachability.internet():status() == ".. hs.network.reachability.internet():status() .." but hs.network.primaryInterfaces() == false… which is confusing")
    end
    if hs.network.interfaceDetails(pi4).Link and hs.network.interfaceDetails(pi4).Link.Expensive then
      logger.i("recording network = iPhone")
      obj.locationFacts['network'] = 'iPhone'
    elseif hs.fnutils.contains({'blacknode5', 'blacknode2.4'}, hs.wifi.currentNetwork()) then
      logger.i("recording network = Canning")
      obj.locationFacts['network'] = 'Canning'
    elseif hs.wifi.currentNetwork() == 'bellroy' then
      logger.i("recording network = Fitzroy")
      obj.locationFacts['network'] = 'Fitzroy'
    else
      logger.i("Unknown network")
      logger.i("recording network = nil")
      obj.locationFacts['network'] = nil
    end
  else
    logger.i("No primary interface")
    logger.i("recording network = nil")
    obj.locationFacts['network'] = nil
  end
  obj.queueActions()
end
obj.networkConfWatcher = hs.network.configuration.open():setCallback( function(_, keys) obj.networkConfCallback(_, keys) end ):monitorKeys({
  "State:/Network/Interface",
  "State:/Network/Global/IPv4",
  "State:/Network/Global/IPv6",
  "State:/Network/Global/DNS",
})

-- Attached power supply change (Canning, Fitzroy)
function obj.powerCallback()
  logger.i("Power changed")
  if hs.battery.psuSerial() == 3136763 then
    logger.i("recording psu = Canning")
    obj.locationFacts['psu'] = 'Canning'
  elseif hs.battery.psuSerial() == 7411505 then
    logger.i("recording psu = Fitzroy")
    obj.locationFacts['psu'] = 'Fitzroy'
  else
    logger.i("recording psu = nil")
    obj.locationFacts['psu'] = nil
  end
  obj.queueActions()
end
obj.batteryWatcher = hs.battery.watcher.new( function() obj.powerCallback() end )

-- Attached monitor change (Canning, Fitzroy)
function obj.screenCallback()
  logger.i("Monitor changed")
  if hs.screen.find(188814579) then
    logger.i("recording monitor = Canning")
    obj.locationFacts['monitor'] = 'Canning'
  elseif hs.screen.find(724061396) then
    logger.i("recording monitor = Fitzroy")
    obj.locationFacts['monitor'] = 'Fitzroy'
  elseif hs.screen.find(69992768) then
    logger.i("recording monitor = CanningServer")
    obj.locationFacts['monitor'] = "CanningServer"
  else
    logger.i("recording monitor = nil")
    obj.locationFacts['monitor'] = nil
  end
  obj.queueActions()
end
obj.screenWatcher = hs.screen.watcher.new( function() obj.screenCallback() end )


-- ## Utility functions ##
function obj.slackStatus(location)
  if location == "" then
    logger.i("Slack status -")
  else
    logger.i("Slack status " .. location)
  end
  hs.task.new("~/bin/slack-status", obj.slackStatusRetryCallback, function(...) return false end, {location}):start()
end

function obj.slackStatusRetryCallback(exitCode, stdOut, stdErr)
  logger.i("Stack status retry callback - exitCode:" .. tostring(exitCode) .. " stdOut:" .. tostring(stdOut) .. " stdErr:" .. tostring(stdErr))
  if exitCode ~= 0 then  -- if task fails, try again after 30s
    logger.w("Stack status failed:" .. (stdErr or stdOut or ""))
    hs.timer.doAfter(30, function() hs.task.new("~/bin/slack-status", obj.slackStatusRetryCallback, function(...) return false end, {obj.cachedLocation}) end):start()
  end
end


-- ##########################
-- ## Entry & Exit Actions ##
-- ##########################

-- iPhone
function obj.iPhoneEntryActions()
  logger.i("Pausing Crashplan, closing Dropbox & GDrive")
  local output, status = hs.execute("/Users/matt/bin/crashplan-pause")
  if not status then
    logger.e("Crashplan may have failed to exit")
  end
  obj.killApp("Dropbox")
  obj.killApp("Google Drive")
  obj.killApp("Transmission")
end

function obj.iPhoneExitActions()
  logger.i("Resuming Crashplan, opening Dropbox & GDrive")
  local output, status = hs.execute("/Users/matt/bin/crashplan-resume")
  if not status then
    logger.e("Crashplan may have failed to resume")
  end
  obj.resumeApp("Dropbox")
  obj.resumeApp("Google Drive")
end

-- Fitzroy
function obj.FitzroyEntryActions()
  obj.killApp("Transmission")

  obj.slackStatus("Fitzroy")
end

function obj.FitzroyExitActions()
  logger.i("Wifi On")
  hs.wifi.setPower(true)
end

-- Canning
function obj.CanningEntryActions()
  obj.slackStatus("Canning")
end

function obj.CanningExitActions()
  obj.killApp("Transmission")

  logger.i("Wifi On")
  hs.wifi.setPower(true)

  obj.slackStatus("")
end

-- Roaming
function obj.RoamingEntryActions()
  obj.killApp("Transmission")
end

return obj
