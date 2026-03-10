cbp_RetrieveDockCharge = function(target)
end
mcs_BalloonFan_TimeOut = function(target)
  TimerDisable(GetRelativePrefabEntity(target, ".BalloonFan_LogicTimerMarker 01"))
  local data = GetPrefabData(target)
  data.BalloonFanOn = 0
  AnimGBSequence(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "end")
  AudioPostEventOn(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "Play_sfx_dec_fan_stop")
  local x = 3
  while true do
    if (not (data.BalloonPainted == 1)) then
      break
    end
    if (not (0 < x)) then
      break
    end
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), x)
    x = (x - 1)
    wait(0.30000001192092896)
  end
  if (data.BalloonPainted == 1) then
    AudioPostEventOn(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), "Play_sfx_dec_balloon_descend")
  end
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 02"), 0)
  local y = 0
  while true do
    if (not (data.BalloonPainted == 1)) then
      break
    end
    if (not (y < 3)) then
      break
    end
    y = (y + 1)
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), y)
    wait(0.30000001192092896)
  end
  TimerEnable(GetRelativePrefabEntity(target, ".BalloonFan_LogicTimerMarker 02"))
  TimerReset(GetRelativePrefabEntity(target, ".BalloonFan_LogicTimerMarker 02"))
  return 
end
cbp_ChargeFan = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    local data = GetPrefabData(target)
    if (data.OnInitially == 0) then
      data.BalloonFanOn = 1
      AnimGBSequence(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "loop")
      TimerEnable(GetRelativePrefabEntity(target, ".BalloonFan_ElecLogicTimerMarker 01"))
      TimerReset(GetRelativePrefabEntity(target, ".BalloonFan_ElecLogicTimerMarker 01"))
    end
    if (data.BalloonPainted == 1) then
      AudioPostEventOn(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), "Play_sfx_dec_balloon_ascend")
      SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 02"), 1)
      SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), 3)
    end
  end
  return 
end
mcs_BalloonFan_ElecTimeOut = function(target)
  TimerDisable(GetRelativePrefabEntity(target, ".BalloonFan_ElecLogicTimerMarker 01"))
  local data = GetPrefabData(target)
  data.BalloonFanOn = 0
  AnimGBSequence(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "end")
  AudioPostEventOn(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "Play_sfx_dec_fan_stop")
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 02"), 0)
  return 
end
mcs_BalloonFan_Restart = function(target)
  local data = GetPrefabData(target)
  TimerDisable(GetRelativePrefabEntity(target, ".BalloonFan_LogicTimerMarker 02"))
  if (data.OnInitially == 0) then
    data.BalloonFanOn = 1
    AnimGBSequence(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "loop")
    AudioPostEventOn(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "Play_sfx_dec_fan_start")
    wait(0.5)
    TimerEnable(GetRelativePrefabEntity(target, ".BalloonFan_LogicTimerMarker 01"))
    TimerReset(GetRelativePrefabEntity(target, ".BalloonFan_LogicTimerMarker 01"))
  end
  if (data.BalloonPainted == 1) then
    AudioPostEventOn(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), "Play_sfx_dec_balloon_ascend")
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 02"), 1)
    local y = 0
    while true do
      if (not (data.BalloonPainted == 1)) then
        break
      end
      if (not (y < 3)) then
        break
      end
      y = (y + 1)
      SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), y)
      wait(0.20000000298023224)
    end
  end
  return 
end
mcs_Balloon_Released = function(target)
  local data = GetPrefabData(target)
  if (data.BalloonFanOn == 1) then
    if (data.BalloonPainted == 1) then
      SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 02"), 1)
      local y = 0
      while true do
        if (not (data.BalloonPainted == 1)) then
          break
        end
        if (not (y < 3)) then
          break
        end
        y = (y + 1)
        SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), y)
        wait(0.20000000298023224)
      end
    end
  end
  return 
end
mcs_Balloon_PaintIn = function(target)
  local data = GetPrefabData(target)
  data.BalloonPainted = 1
  if (data.BalloonFanOn == 1) then
    local x = 3
    while true do
      if (not (data.BalloonPainted == 1)) then
        break
      end
      if (not (0 < x)) then
        break
      end
      if (not (data.BalloonFanOn == 1)) then
        break
      end
      SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), x)
      x = (x - 1)
      wait(0.30000001192092896)
    end
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 02"), 1)
    local y = 0
    while true do
      if (not (data.BalloonPainted == 1)) then
        break
      end
      if (not (y < 3)) then
        break
      end
      if (not (data.BalloonFanOn == 1)) then
        break
      end
      y = (y + 1)
      SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), y)
      wait(0.30000001192092896)
    end
  end
  return 
end
mcs_Balloon_ThinOut = function(target)
  local data = GetPrefabData(target)
  data.BalloonPainted = 0
  if (data.BalloonFanOn == 1) then
    local x = 3
    while true do
      if (not (data.BalloonPainted == 0)) then
        break
      end
      if (not (0 < x)) then
        break
      end
      SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), x)
      x = (x - 1)
      wait(0.30000001192092896)
    end
  end
  AudioPostEventOn(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), "Stop_sfx_dec_balloon_rise_fall")
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 02"), 0)
  local y, y = 0, GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 01")
  while true do
    if (not (data.BalloonPainted == 0)) then
      break
    end
    if (not (y < 8)) then
      break
    end
    y = (y + 1)
    y = GetRelativePrefabEntity
    y = y(target, ".tmp_platform_01a 01")
    SetSplineFollowerInitialSpeed(y, y)
    y = 0.10000000149011612
    wait(y)
    y = target
  end
  return 
end
cbp_FanSwitch_toLoop = function(target)
  local data = GetPrefabData(target)
  AnimGBSequence(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "loop")
  return 
end
cbp_ActivateFan = function(target)
  local data = GetPrefabData(target)
  if (data.OnInitially == 0) then
    SetCameraAttributes(GetRelativePrefabEntity(target, ".BalloonActivateMarker(CameraOverride) 01"))
    wait(1)
    data.BalloonFanOn = 1
    AnimGBSequence(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "loop")
    AudioPostEventOn(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "Play_sfx_dec_fan_start")
    TimerEnable(GetRelativePrefabEntity(target, ".BalloonFan_LogicTimerMarker 01"))
    TimerReset(GetRelativePrefabEntity(target, ".BalloonFan_LogicTimerMarker 01"))
    wait(1)
    SetCameraAttributes("Marker(CameraOverride) 01")
  end
  if (data.BalloonPainted == 1) then
    AudioPostEventOn(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), "Play_sfx_dec_balloon_ascend")
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 02"), 1)
    local y = 0
    while true do
      if (not (data.BalloonPainted == 1)) then
        break
      end
      if (not (y < 3)) then
        break
      end
      y = (y + 1)
      SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), y)
      wait(0.20000000298023224)
    end
  end
  return 
end
cbp_TVActivateFan = function(target)
  local data = GetPrefabData(target)
  if (data.OnInitially == 0) then
    SetCameraAttributes(GetRelativePrefabEntity(target, ".BalloonActivateMarker(CameraOverride) 01"))
    wait(1)
    data.BalloonFanOn = 1
    AnimGBSequence(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "loop")
    AudioPostEventOn(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "Play_sfx_dec_fan_start")
    TimerEnable(GetRelativePrefabEntity(target, ".BalloonFan_LogicTimerMarker 01"))
    TimerReset(GetRelativePrefabEntity(target, ".BalloonFan_LogicTimerMarker 01"))
    wait(1)
    SetCameraAttributes("Marker(CameraOverride) 01")
  end
  if (data.BalloonPainted == 1) then
    AudioPostEventOn(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), "Play_sfx_dec_balloon_ascend")
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 02"), 1)
    local y = 0
    while true do
      if (not (data.BalloonPainted == 1)) then
        break
      end
      if (not (y < 3)) then
        break
      end
      y = (y + 1)
      SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), y)
      wait(0.20000000298023224)
    end
  end
  return 
end
cbp_StartUpFan = function(target)
  local data = GetPrefabData(target)
  if (data.OnInitially == 1) then
    data.BalloonFanOn = 1
    AnimGBSequence(GetRelativePrefabEntity(target, ".tmp_fanblade_01a 01"), "loop")
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), 3)
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 02"), 1)
  elseif (data.OnInitially == 0) then
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".tmp_platform_01a 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 01"), GetRelativePrefabEntity(target, ".BalloonPlatform_SplineKnot 02"), 0)
  end
  return 
end

