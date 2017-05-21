--- === Hermes ===
---
--- Controls for Hermes music player

local obj={}
-- obj.__index = obj

-- Metadata
obj.name = "Hermes"
obj.version = "0.1"
obj.author = "Matthew Fallshaw <m@fallshaw.me>"
obj.license = "MIT - https://opensource.org/licenses/MIT"


--- Hermes:state_paused
--- Constant
--- Returned by `Hermes:getPlaybackState()` to indicates Hermes is paused
obj.state_paused = "paus"   -- Note Applescript Hermes Dictionary claims this is "paused"

--- Hermes:state_playing
--- Constant
--- Returned by `Hermes:getPlaybackState()` to indicates Hermes is playing
obj.state_playing = "play"  -- Note Applescript Hermes Dictionary claims this is "playing"

--- Hermes:state_stopped
--- Constant
--- Returned by `Hermes:getPlaybackState()` to indicates Hermes is stopped
obj.state_stopped = "stopped"  -- Claimed by Applescript Hermes Dictionary, untested


-- Internal function to pass a command to Applescript.
local function tell(cmd)
  local _cmd = 'tell application "Hermes" to ' .. cmd
  local ok, result = hs.applescript.applescript(_cmd)
  if ok then
    return result
  else
    return nil
  end
end

--- Hermes:playpause()
--- Method
--- Toggles play/pause of current Hermes track
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
function obj:playpause()
  tell('playpause')
  return obj
end

--- Hermes:play()
--- Method
--- Plays the current Hermes track
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
function obj:play()
  tell('play')
  return obj
end

--- Hermes:pause()
--- Method
--- Pauses the current Hermes track
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
function obj:pause()
  tell('pause')
  return obj
end

--- Hermes:next()
--- Method
--- Skips to the next itunes track
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
function obj:next()
  tell('next song')
  return obj
end

--- Hermes:displayCurrentTrack()
--- Method
--- Displays information for current track on screen
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
function obj:displayCurrentTrack()
  local artist = tell('artist of the current song as string') or "Unknown artist"
  local album  = tell('album of the current song as string') or "Unknown album"
  local track  = tell('title of the current song as string') or "Unknown track"
  hs.alert.show(track .."\n".. album .."\n".. artist, 1.75)
  return obj
end

--- Hermes:getCurrentArtist() -> string or nil
--- Function
--- Gets the name of the current Artist
---
--- Parameters:
---  * None
---
--- Returns:
---  * A string containing the Artist of the current track, or nil if an error occurred
function obj:getCurrentArtist()
  return tell('artist of the current song as string')
end

--- Hermes:getCurrentAlbum() -> string or nil
--- Function
--- Gets the name of the current Album
---
--- Parameters:
---  * None
---
--- Returns:
---  * A string containing the Album of the current track, or nil if an error occurred
function obj:getCurrentAlbum()
  return tell('album of the current song as string')
end

--- Hermes:getCurrentTrack() -> string or nil
--- Function
--- Gets the name of the current track
---
--- Parameters:
---  * None
---
--- Returns:
---  * A string containing the name of the current track, or nil if an error occurred
function obj:getCurrentTrack()
  return tell('title of the current song as string')
end

--- Hermes:getPlaybackState()
--- Function
--- Gets the current playback state of Hermes
---
--- Parameters:
---  * None
---
--- Returns:
---  * A string containing one of the following constants:
---    - `Hermes:state_stopped`
---    - `Hermes:state_paused`
---    - `Hermes:state_playing`
function obj:getPlaybackState()
  if obj.isRunning() then
    return tell('get playback state')
  else
    return nil
  end
end

--- Hermes:isRunning()
--- Function
--- Returns whether Hermes is currently open. Most other functions in Hermes.spoon will automatically start the application, so this function can be used to guard against that.
---
--- Parameters:
---  * None
---
--- Returns:
---  * A boolean value indicating whether the Hermes application is running.
function obj:isRunning()
  return hs.application.get("Hermes") ~= nil
end

--- Hermes:isPlaying()
--- Function
--- Returns whether Hermes is currently playing
---
--- Parameters:
---  * None
---
--- Returns:
---  * A boolean value indicating whether Hermes is currently playing a track, or nil if an error occurred (unknown player state). Also returns false if the application is not running
function obj:isPlaying()
  -- We check separately to avoid starting the application if it's not running
  if not obj.isRunning() then
    return false
  end
  state = obj.getPlaybackState()
  if state == obj.state_playing then
    return true
  elseif state == obj.state_paused or state == obj.state_stopped then
    return false
  else  -- unknown state
    return nil
  end
end

--- Hermes:getVolume()
--- Function
--- Gets the current Hermes volume setting
---
--- Parameters:
---  * None
---
--- Returns:
---  * A number, between 1 and 100, containing the current Hermes playback volume
function obj:getVolume()
  return tell('playback volume')
end

--- Hermes:setVolume(vol)
--- Method
--- Sets the Hermes playback volume
---
--- Parameters:
---  * vol - A number, between 1 and 100
---
--- Returns:
---  * None
function obj:setVolume(v)
  v=tonumber(v)
  if not v then error('volume must be a number 1..100',2) end
  tell('set playback volume to '..math.min(100,math.max(0,v)))
  return obj
end

--- Hermes:volumeUp()
--- Method
--- Increases the Hermes playback volume by 5
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
function obj:volumeUp()
  tell('increase volume')
  return obj
end

--- Hermes:volumeDown()
--- Method
--- Decreases the Hermes playback volume by 5
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
function obj:volumeDown()
  tell'decrease volume'
  return obj
end

--- Hermes:getPosition()
--- Function
--- Gets the playback position (in seconds) of the current song
---
--- Parameters:
---  * None
---
--- Returns:
---  * A number indicating the current position in the song
function obj:getPosition()
  return tell('playback position')
end

--- Hermes:getDuration()
--- Function
--- Gets the duration (in seconds) of the current song
---
--- Parameters:
---  * None
---
--- Returns:
---  * The number of seconds long the current song is, 0 if no song is playing
function obj:getDuration()
  local duration = tonumber(tell('current song duration'))
  return duration ~= nil and duration or 0
end



--- Hermes:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for Hermes
---
--- Parameters:
---  * mapping - A table containing hotkey modifier/key details for the following items:
---   * show - This will cause the mouse circle to be drawn
function obj:bindHotkeys(mapping)
  if (self.hotkey) then
    self.hotkey:delete()
  end
  local mods = mapping["displayCurrentTrack"][1]
  local hotkey = mapping["displayCurrentTrack"][2]
  self.hotkey = hs.hotkey.bind(mods, hotkey, function() hs.alert.show(self:isPlaying()) end)

  return self
end

return obj
