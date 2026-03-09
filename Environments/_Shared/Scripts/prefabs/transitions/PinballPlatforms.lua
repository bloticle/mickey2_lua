gsPM_PinballMachineStartUp = function(reg_0)
  return 
end
Oswald_PB_Active = 0
gsPM_PinballMachine_Charged = function(target)
  local data = GetPrefabData(target)
  if (GetEntity("trn_gremlinsubway_03a_audio_dec2.Snd_Pinball_Power_On") ~= nil) then
    AudioPostEventOn("trn_gremlinsubway_03a_audio_dec2.Snd_Pinball_Power_On", "Play_sfx_dec_pinball_power_on")
  end
  if (GetEntity("trn_gremlinsubway_04a_audio.Snd_Pinball_Power_On") ~= nil) then
    AudioPostEventOn("trn_gremlinsubway_04a_audio.Snd_Pinball_Power_On", "Play_sfx_dec_pinball_power_on")
  end
  wait(0.0010000000474974513)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".pinballPaddle 01"), 20)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".pinballPaddle 02"), 20)
  wait(0.30000001192092896)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".pinballPaddle 03"), 20)
  while true do
    if (not (data.PinballChargeLevel < 8)) then
      break
    end
    data.PinballChargeLevel = (data.PinballChargeLevel + 1)
    Unhide(GetRelativePrefabEntity(target, (".PowerLight 0" .. data.PinballChargeLevel)))
    wait(0.30000001192092896)
  end
  if (data.FireUserTarget ~= "None") then
    FireUser1(data.FireUserTarget)
  end
  data.MachineCharged = true
  Oswald_PB_Active = 1
  Disable(data.HiddenOswaldActionToDisable)
  DestroyEntity(GetRelativePrefabEntity(target, ".HiddenOswald_TriggerBase"))
  return 
end
gsPM_PinballMachine_DrainPower = function(target)
  local data = GetPrefabData(target)
  if (1 < data.PinballChargeLevel) then
    Hide(GetRelativePrefabEntity(target, (".PowerLight 0" .. data.PinballChargeLevel)))
    data.PinballChargeLevel = (data.PinballChargeLevel - 1)
  elseif (data.PinballChargeLevel == 1) then
    data.PinballChargeLevel = 0
    Hide(GetRelativePrefabEntity(target, ".PowerLight 01"))
    gsPM_PinballMachine_Exhausted(target)
  end
  return 
end
gsPM_BallToRelease = 0
gsPM_PinballMachine_Exhausted = function(target)
  local data = GetPrefabData(target)
  TimerDisable(GetRelativePrefabEntity(target, ".PinballShutdown_LogicTimerMarker 01"))
  wait(0.0010000000474974513)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".pinballPaddle 01"), 60)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".pinballPaddle 02"), 60)
  wait(0.30000001192092896)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".pinballPaddle 03"), 60)
  Oswald_PB_Active = 0
  return 
end
gsPM_BallShooter = function(target)
  local data = GetPrefabData(target)
  gsPM_BallToRelease = target
  local sf = GetRelativePrefabEntity(_self(), ".Ball_SplineMotor 01")
  local ball = target
  Disable(sf)
  DisableMotion(ball)
  Disable(ball)
  TeleportToEntity(ball, sf)
  SetParentEntity(ball, sf)
  Enable(sf)
  SetSplineFollowerInitialSpeed(sf, 25)
  AnimGBSequence(GetRelativePrefabEntity(_self(), ".pinball_Shooter"), "launch")
  wait(0.6000000238418579)
  AnimGBSequence(GetRelativePrefabEntity(_self(), ".pinball_Shooter"), "idle")
  return 
end
gsPM_ReleaseBall = function(target)
  local data = GetPrefabData(target)
  local sf = GetRelativePrefabEntity(_self(), ".Ball_SplineMotor 01")
  local ball = gsPM_BallToRelease
  ClearParent(ball)
  EnableMotion(ball)
  SetPropertyBool(ball, "Is Mover", false)
  Disable(sf)
  MoveToEntity(ball, sf)
  SplineFollower_TeleportToKnot(sf, GetRelativePrefabEntity(_self(), ".SplineKnot 01"))
  return 
end
gsPM_OswaldTrigger01 = function(target)
  local data = GetPrefabData(target)
  if (Oswald_PB_Active == 0) then
    Print("**************************************** OSWALD SHOCK TARGET")
    OswaldStreamAction(GetRelativePrefabEntity(target, ".Oswald_ShockMarker 01"), 4)
    wait(2)
    OswaldStreamAbort()
    Print("**************************************** OSWALD CEASE SHOCK")
  end
  return 
end
gsPM_OswaldTrigger02 = function(target)
  if (Oswald_PB_Active == 1) then
    wait(1)
    local data = GetPrefabData(target)
    OswaldJumpNoFollowAction(GetRelativePrefabEntity(target, ".Oswald_PositionMarker 03"))
  end
  return 
end
gsPM_OswaldTrigger03 = function(target)
  if (Oswald_PB_Active == 1) then
    if (GetEntity("trn_gremlinsubway_03a_audio_dec2.Snd_Pinball_Power_On") ~= nil) then
      AudioPostEventOn("trn_gremlinsubway_03a_audio_dec2.Snd_Pinball_Power_On", "Play_sfx_dec_pinball_power_on")
    end
    if (GetEntity("trn_gremlinsubway_04a_audio.Snd_Pinball_Power_On") ~= nil) then
      AudioPostEventOn("trn_gremlinsubway_04a_audio.Snd_Pinball_Power_On", "Play_sfx_dec_pinball_power_on")
    end
    wait(2)
    local data = GetPrefabData(target)
    Print("**************************************** OSWALD SHOCK TARGET")
    OswaldStreamAction(GetRelativePrefabEntity(target, ".Oswald_ShockMarker 01"), 4)
    wait(2)
    OswaldStreamAbort()
    Print("**************************************** OSWALD CEASE SHOCK")
    wait(0.5)
    OswaldJumpNoFollowAction(GetRelativePrefabEntity(target, ".Oswald_PositionMarker 04"))
  end
  return 
end
gsPM_OswaldTrigger04 = function(target)
  if (Oswald_PB_Active == 1) then
    wait(1)
    local data = GetPrefabData(target)
    OswaldJumpAction(GetRelativePrefabEntity(target, ".Oswald_PositionMarker 05"))
  end
  return 
end
gsPM_SetOswald2DAimOffset = function(target)
  local data = GetPrefabData(target)
  Print(("gsPM_SetOswald2DAimOffset: data.AimOffsetX is " .. tostring(data.AimOffsetX)))
  Print(("gsPM_SetOswald2DAimOffset: data.AimOffsetZ is " .. tostring(data.AimOffsetZ)))
  Set2DAimOffset(PLAYER_TWO, vector4(data.AimOffsetX, 0, data.AimOffsetZ, 0))
  return 
end
gsPM_ClearOswald2DAimOffset = function(target)
  Set2DAimOffset(PLAYER_TWO, vector4(0, 0, 0, 0))
  return 
end
gsPM_EnableHiddenOswald = function(target)
  local data = GetPrefabData(target)
  if (data.MachineCharged == false) then
    Enable(data.HiddenOswaldActionToDisable)
  else
    DestroyEntity(target)
  end
  return 
end
gsPM_DisableHiddenOswald = function(target)
  local data = GetPrefabData(target)
  if (data.MachineCharged == false) then
    Disable(data.HiddenOswaldActionToDisable)
  else
    DestroyEntity(target)
  end
  return 
end
