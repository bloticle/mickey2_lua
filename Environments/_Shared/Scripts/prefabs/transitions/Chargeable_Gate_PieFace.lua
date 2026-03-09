gsPG_Fire_PieGate = function(target)
  local data = GetPrefabData(target)
  wait(1)
  data.GateActive = 1
  local PieGateInitialCamera = 0
  while true do
    if (not (data.GateActive == 1)) then
      break
    end
    data.PieFXOn = 0
    Disable(GetRelativePrefabEntity(target, ".Trigger 01"))
    if (data.LastPie == 1) then
      data.LastPie = 2
      Unhide(".pie01")
      AnimGBSequence(GetRelativePrefabEntity(target, ".pieMotor02"), "pie2")
      AudioPostEventOn(GetRelativePrefabEntity(target, ".pie02"), "Play_sfx_dec_pieface_throw")
    elseif (data.LastPie == 2) then
      data.LastPie = 1
      Unhide(".pie02")
      AnimGBSequence(GetRelativePrefabEntity(target, ".pieMotor02"), "pie1")
      AudioPostEventOn(GetRelativePrefabEntity(target, ".pie01"), "Play_sfx_dec_pieface_throw")
    end
    wait(0.20000000298023224)
    Enable(GetRelativePrefabEntity(target, ".Trigger 01"))
    wait(1.7999999523162842)
    if (PieGateInitialCamera < 2) then
      PieGateInitialCamera = (PieGateInitialCamera + 1)
    end
  end
  return 
end
gsPG_PieGate_Charged = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    local data = GetPrefabData(target)
    if (data.GateActive == 0) then
      if (data.ElecBeamOn == 0) then
        if (data.TV_Override == 0) then
          data.GateActive = 1
          data.ElecBeamOn = 1
          FireThread(gsPG_Fire_PieGate, target)
          TimerEnable(GetRelativePrefabEntity(target, ".elecResetTimer"))
          TimerReset(GetRelativePrefabEntity(target, ".elecResetTimer"))
        end
      end
    elseif (data.GateActive == 1) then
      if (data.ElecBeamOn == 1) then
        TimerReset(GetRelativePrefabEntity(target, ".elecResetTimer"))
      end
    end
  end
  return 
end
gsPG_PieGate_TimeOut = function(target)
  local data = GetPrefabData(target)
  TimerDisable(GetRelativePrefabEntity(target, ".elecResetTimer"))
  data.ElecBeamOn = 0
  gsPG_Stop_PieGate(target)
  return 
end
gsPG_Stop_PieGate = function(target)
  local data = GetPrefabData(target)
  data.GateActive = 0
  data.FaceOrientation = 0
  StartRotateToPosition(GetRelativePrefabEntity(target, ".centerhinge"), 0)
  return 
end
gsPG_Pie_HitFace = function(target)
  local data = GetPrefabData(target)
  if (data.TV_Override == 0) then
    if (data.PieFXOn == 0) then
      data.PieFXOn = 1
      Hide(_activator())
      Print(GetPlayer(), "*_*_*_*_**_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* FACE STRUCK WITH PIE")
      if (data.LastPie == 1) then
        SetPropertyEntity(GetRelativePrefabEntity(target, ".PieFace_FX_Spawner 01"), "Spawn Destinations", GetRelativePrefabEntity(target, ".pie01"), 0)
        SetPropertyEntity(GetRelativePrefabEntity(target, ".PieFace_FX_Spawner 01"), "Spawn Destinations", GetRelativePrefabEntity(target, ".pie01"), 1)
        AudioPostEventOn(GetRelativePrefabEntity(target, ".pie01"), "Play_sfx_dec_pieface_splat")
      elseif (data.LastPie == 2) then
        SetPropertyEntity(GetRelativePrefabEntity(target, ".PieFace_FX_Spawner 01"), "Spawn Destinations", GetRelativePrefabEntity(target, ".pie02"), 0)
        SetPropertyEntity(GetRelativePrefabEntity(target, ".PieFace_FX_Spawner 01"), "Spawn Destinations", GetRelativePrefabEntity(target, ".pie02"), 1)
        AudioPostEventOn(GetRelativePrefabEntity(target, ".pie02"), "Play_sfx_dec_pieface_splat")
      end
      ForceSpawn(GetRelativePrefabEntity(target, ".PieFace_FX_Spawner 01"), 1)
      data.FaceOrientation = (data.FaceOrientation + 45)
      gsPG_gateResistInterrupt = 10
      AudioPostEventOn(target, "Play_sfx_dec_pieface_gear_backward")
      if (79 < data.FaceOrientation) then
        data.FaceOrientation = 80
        data.TV_Override = 1
        TimerDisable(GetRelativePrefabEntity(target, ".elecResetTimer"))
        data.GateActive = 0
        StartRotateToPosition(GetRelativePrefabEntity(target, ".centerhinge"), 80)
        AudioPostEventOn(target, "Play_sfx_dec_pieface_gear_backward")
      end
    end
  elseif (data.TV_Override == 1) then
    AudioPostEventOn(GetRelativePrefabEntity(target, ".pie01"), "Play_sfx_dec_pieface_splat")
    ClearParent(GetRelativePrefabEntity(target, ".GateWithFace"))
    AudioPostEventOn(target, "Play_sfx_dec_pieface_gear_backward")
    data.GateActive = 0
    data.FaceOrientation = 180
    SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".centerhinge"), 640)
    StartRotateToPosition(GetRelativePrefabEntity(target, ".centerhinge"), 180)
  end
  return 
end
gsPG_PieSplatFade = function(target)
  EnableMotion(target)
  ApplyImpulse(target, 0, 2000, 6000)
  wait(1)
  local a = 1
  local (for index), (for limit), (for step) = 1, 0, -0.05000000074505806
  for a = (for index), (for limit), (for step) do
    SetR3MTConstRegAlpha(target, 3, a)
    Wait(0.05000000074505806)
  end
  DestroyEntity(target)
  return 
end
gsPG_gateResistInterrupt = 0
gsPG_PieGate_Resistance = function(target)
  local data = GetPrefabData(target)
  local hinge = GetRelativePrefabEntity(target, ".centerhinge")
  while true do
    if (not (data.TV_Override == 0)) then
      break
    end
    if (not IsValidHandle(hinge)) then
      break
    end
    data.FaceOrientation = (data.FaceOrientation - 0.5)
    if (data.FaceOrientation < 0) then
      data.FaceOrientation = 0
    elseif (data.GateActive == 1) then
      if (gsPG_gateResistInterrupt == 0) then
        AudioPostEventOn(hinge, "Play_sfx_dec_pieface_gear_forward")
      end
    end
    StartRotateToPosition(hinge, data.FaceOrientation)
    if (0 < gsPG_gateResistInterrupt) then
      gsPG_gateResistInterrupt = (gsPG_gateResistInterrupt - 1)
    end
    wait(0.20000000298023224)
  end
  return 
end
gsPG_PieArmStartUp = function(target)
  FireThread(gsPG_PieGate_Resistance, target)
  return 
end
gsPG_PieArm_TVcharge = function(target)
  Print(GetPlayer(), "Pie Thrower charged by TV!")
  local data = GetPrefabData(target)
  wait(1)
  if (data.GateActive == 0) then
    data.TV_Override = 1
    data.GateActive = 1
    gsPG_Fire_PieGate(target)
  end
  return 
end
