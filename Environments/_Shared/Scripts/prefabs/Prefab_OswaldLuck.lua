Prefab_OswaldRumble_EnterTrigger = function(target, activator)
  local char = activator
  local data = GetPrefabData(target)
  local costume = GetCurrentCostumeName(char)
  if (costume == "Gremlin") then
    if (data.ChestOpened == false) then
      local timer = GetRelativePrefabEntity(target, ".RumbleTimer")
      TimerEnable(timer)
      timer = GetRelativePrefabEntity(target, ".PositionTimer")
      TimerEnable(timer)
      AnimVarInt(char, VAR_State_Variation, 2)
    end
  end
  return 
end
Prefab_OswaldRumble_LeaveTrigger = function(target, activator)
  local char = activator
  local timer = GetRelativePrefabEntity(target, ".RumbleTimer")
  TimerDisable(timer)
  timer = GetRelativePrefabEntity(target, ".PositionTimer")
  TimerDisable(timer)
  AnimVarInt(char, VAR_State_Variation, 0)
  return 
end
Prefab_OswaldLuck_Disable = function(target, event, activator)
  if StimulusEvent_HasStimulusType(event, ST_SPIN) then
    if (activator == GetPlayer()) then
      if GetPropertyBool(target, "Is Painted") then
        Disable(GetRelativePrefabEntity(target, ".OL_Trigger"))
        Prefab_OswaldRumble_LeaveTrigger(target, GetPlayer2OrAI())
      end
    end
  end
  return 
end
OswaldRumble_DistanceToDelay = 2.5
OswaldRumble_RumbleLength = 0.10000000149011612
OswaldRumble_MaxDistance = 30
OswaldRumble_MinDistance = 0.5
OswaldRumble_DistanceToPlayback = 4
Prefab_OswaldRumble_OnPositionTimer = function(target)
  local data = GetPrefabData(target)
  if (data.ChestOpened == true) then
    local timer = GetRelativePrefabEntity(target, ".RumbleTimer")
    TimerDisable(timer)
    timer = GetRelativePrefabEntity(target, ".PositionTimer")
    TimerDisable(timer)
    AnimVarInt(activator, VAR_State_Variation, 0)
    return 
  end
  local markerEntity, markerEntity = GetRelativePrefabEntity(target, data.TreasureMarker), target
  markerEntity = data.TreasureMarker
  if (markerEntity == nil) then
    markerEntity = GetRelativePrefabEntity
    markerEntity = markerEntity(target, ".TreasureMarker")
    markerEntity = markerEntity
  end
  markerEntity = GetPosition
  markerEntity = markerEntity(GetPlayer2OrAI())
  markerEntity = (markerEntity - GetPosition(markerEntity))
  markerEntity = markerEntity.length2
  markerEntity = markerEntity(markerEntity)
  local distanceFromMarker = markerEntity
  distanceFromMarker = OswaldRumble_MinDistance
  distanceFromMarker = (markerEntity - distanceFromMarker)
  markerEntity = (distanceFromMarker / (OswaldRumble_MaxDistance - OswaldRumble_MinDistance))
  if (markerEntity < 0) then
    markerEntity = 0
  end
  if (1 < markerEntity) then
    markerEntity = 1
  end
  distanceFromMarker = OswaldRumble_DistanceToDelay
  distanceFromMarker = (markerEntity * distanceFromMarker)
  distanceFromMarker = (distanceFromMarker + OswaldRumble_RumbleLength)
  local newInterval = OswaldRumble_RumbleLength
  newInterval = (1 - markerEntity)
  newInterval = (newInterval * OswaldRumble_DistanceToPlayback)
  local newPlaybackSpeed = OswaldRumble_DistanceToPlayback
  newPlaybackSpeed = GetRelativePrefabEntity
  newPlaybackSpeed = newPlaybackSpeed(target, ".RumbleTimer")
  local rumbleTimer = target
  rumbleTimer = TimerSetInterval
  rumbleTimer(newPlaybackSpeed, distanceFromMarker)
  rumbleTimer = TimerIntervalLeft
  rumbleTimer = rumbleTimer(newPlaybackSpeed)
  if (distanceFromMarker < rumbleTimer) then
    rumbleTimer = TimerReset
    rumbleTimer(newPlaybackSpeed)
  end
  rumbleTimer = TimerSetInterval
  rumbleTimer(target, OswaldRumble_RumbleLength)
  return 
end
Prefab_OswaldRumble_OnRumbleTimer = function(target)
  if (IsPlayerAIControlled(PLAYER_TWO) == false) then
    Rumble(target, OswaldRumble_RumbleLength, 1)
  end
  AnimEvent(GetPlayer2OrAI(), EVENT_Start_CarriedByBalloon)
  return 
end

