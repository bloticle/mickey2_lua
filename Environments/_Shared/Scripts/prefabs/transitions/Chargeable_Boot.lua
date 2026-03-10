gsCB_BootCharged = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    local data = GetPrefabData(target)
    if (data.OswaldCharges == 1) then
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".ElecBeam_Indicator 01"), 360)
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".TRN_gremlinSubway_gameplayBoot_01A_inert 01"), 120)
      TimerEnable(GetRelativePrefabEntity(target, ".LogicTimerMarker 01"))
      TimerReset(GetRelativePrefabEntity(target, ".LogicTimerMarker 01"))
    end
  end
  return 
end
gsCB_BootStartUp = function(target)
  local data = GetPrefabData(target)
  if (data.OswaldCharges == 0) then
    SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".TRN_gremlinSubway_gameplayBoot_01A_inert 01"), 45)
  end
  return 
end
gsCB_BootTimeOut = function(target)
  local data = GetPrefabData(target)
  TimerDisable(GetRelativePrefabEntity(target, ".LogicTimerMarker 01"))
  SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".TRN_gremlinSubway_gameplayBoot_01A_inert 01"), 0)
  SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".ElecBeam_Indicator 01"), 0)
  return 
end

