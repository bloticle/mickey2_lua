gs3_AlwaysSetup = function(target)
  Print("__Function: gs3_AlwaysSetup")
  AudioEffectStart("trn_gremlinsubway_03a_audio_dec3.reverb")
  local questID, stageID = Quest_GetCriticalPath()
  if (stageID == "Critical_RBF_4a") then
    Quest_SetCriticalPath("Critical_DEC", "Critical_DEC_3")
  end
  if (target == "DEC") then
    SetHorizontalSplit(GetPlayer())
    Prefab_DECFoopToob_Finish()
  end
  if (GetGlobal("DEC3_GoldTicket") == 1) then
    DestroyEntity("gremlinsubway_03b_dynamic.ETicket_Oswald_TriggerBase 01")
  end
  math.randomseed(os.time())
  ForEachEntityInGroup(SetEntityToNotCollideWithBuddyAI, "Oswald2DAvoidObject")
  return 
end
gs3_DynamicSaveCheckPoint = function()
  wait(0.10000000149011612)
  SaveCheckpointNoPosition("gs3_AlwaysSetup")
  return 
end
gs3_OswaldFollowDistanceChange = function(target, _Distance)
  Print(("__Function: gs3_OswaldFollowDistanceChange, Distance: " .. tostring(_Distance)))
  OswaldOverrideFollowingDistance(target, _Distance)
  return 
end
gs3_OswaldClearDistanceChange = function(target)
  Print("__Function: gs3_OswaldClearDistanceChange")
  OswaldClearOverrideFollowingDistance()
  return 
end
gs3_Oswald_StartBootsLeft = function()
  Hide(_self())
  OswaldIgnoreObstaclesAction("OswaldStartBootsLeft")
  Print(GetPlayer(), "*************************************************************************** OSWALD INITIALIZE")
  return 
end
gs3_Oswald_BalloonStartup = function()
  wait(2)
  return 
end
gs3_DropPlanes = function(target)
  if (GetPrefabData("Trolly").trolleyInPlay == 1) then
    local (for index), (for limit), (for step) = 1, 3, 1
    for x = (for index), (for limit), (for step) do
      SplineFollower_SetDisabled(("MoviePlane" .. tostring(x)), false)
      SplineFollower_StopAtPosition(("MoviePlane" .. tostring(x)), (("MoviePlane" .. tostring(x)) .. "_SplineTop"), (("MoviePlane" .. tostring(x)) .. "_SplineBottom"), 1)
      wait(0.20000000298023224)
      SetRotatorMaxSpeed(("MoviePlane" .. tostring(x)), 10)
      wait(0.800000011920929)
    end
  end
  return 
end
gs3_addCamera = function(player, camVal)
  local camPrefix = "Marker(CameraOverride)_O_"
  if (player == GetPlayer()) then
    camPrefix = "Marker(CameraOverride)_M_"
  end
  SetCameraAttributesForPlayer((camPrefix .. camVal), player)
  return 
end
gs3_subtractCamera = function(player, camVal)
  local camPrefix = "Marker(CameraOverride)_O_"
  if (player == GetPlayer()) then
    camPrefix = "Marker(CameraOverride)_M_"
  end
  ClearCameraAttributesForPlayer((camPrefix .. camVal), player, 1)
  return 
end
gs3_enableCameraTriggerLookUp02 = function(player)
  Print("gs3_enableCameraTriggerLookUp02 function entered")
  if (player == GetPlayer()) then
    Enable("trn_gremlinsubway_03a_pathdatabase.TriggerBase_CameraLookUp 02_M")
  else
    Enable("trn_gremlinsubway_03a_pathdatabase.TriggerBase_CameraLookUp 02_O")
  end
  return 
end
gs3_disableCameraTriggerLookUp02 = function(player)
  Print("gs3_disableCameraTriggerLookUp02 function entered")
  if (player == GetPlayer()) then
    Disable("trn_gremlinsubway_03a_pathdatabase.TriggerBase_CameraLookUp 02_M")
  else
    Disable("trn_gremlinsubway_03a_pathdatabase.TriggerBase_CameraLookUp 02_O")
  end
  return 
end
gs3_FireFireworks = function(target, _Which)
  Print(("__Function: gs3_FireFireworks, _Which: " .. tostring(_Which)))
  AnimGBSequence(("Confetti" .. tostring(_Which)), "blow")
  wait(0.6000000238418579)
  ForEachEntityInGroup(EnableMotion, ("Fireworks" .. tostring(_Which)))
  ForEachEntityInGroup(StartEmitters, ("FireworksTrail" .. tostring(_Which)))
  local (for index), (for limit), (for step) = 1, 3, 1
  for x = (for index), (for limit), (for step) do
    ApplyImpulse(((("Fireworks" .. tostring(_Which)) .. "_") .. tostring(x)), 0, math.random(12, 16), math.random(-5, 5))
  end
  FireThread(gs3_DestroyFireworks, target, _Which)
  wait(0.20000000298023224)
  AnimGBSequence(("Confetti" .. tostring(_Which)), "rest")
  return 
end
gs3_DestroyFireworks = function(target, _Group)
  Print(("__Function: gs3_DestroyFireworks, _Group: " .. tostring(_Group)))
  local data = GetPrefabData(target)
  local strG = tostring(_Group)
  local spawner = ("FireworksSpawner" .. strG)
  wait(0.800000011920929)
  local (for index), (for limit), (for step) = 1, 3, 1
  for x = (for index), (for limit), (for step) do
    local strX = tostring(x)
    local tixSpawner = GetRelativePrefabEntity(target, ".ticketSpawner 01")
    local tgtKnot = GetRelativePrefabEntity(target, ((".SplineKnot " .. strX) .. "1"))
    Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* gs3_DestroyFireworks is targeting tgtKnot .SplineKnot " .. strX) .. "1!!"))
    TeleportToEntity(tgtKnot, ((("Fireworks" .. strG) .. "_") .. strX))
    SetPropertyInt(tixSpawner, "Index To Spawn", (x - 1))
    SetPropertyEntity(tixSpawner, "Spawn Destinations", tgtKnot, 0)
    ForceSpawn(tixSpawner, 1)
    SetPropertyEntity(spawner, "Spawn Destinations", ((("Fireworks" .. strG) .. "_") .. strX), 0)
    SetPropertyInt(spawner, "Index To Spawn", (x - 1))
    ForceSpawn(spawner, 1)
    DestroyEntity(((("FireworksTrail" .. strG) .. "_") .. strX))
    Hide(((("Fireworks" .. strG) .. "_") .. strX))
    wait(0.5)
  end
  wait(1)
  DestroyEntity(("FireworksSpawner" .. strG))
  ForEachEntityInGroup(DestroyEntity, ("Fireworks" .. strG))
  return 
end
local TapeBlockers = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
gs3_TapeBlockerStimmed = function(target, _event)
  Print("__Function: gs3_TapeBlockerStimmed")
  if StimulusEvent_HasStimulusType(_event, ST_PAINT) then
    local n = tonumber(string.sub(tostring(GetName(target)), -2, -1))
    Print(("n = " .. tostring(n)))
    if (TapeBlockers[n] == 0) then
      Print("__Knocking this one over!")
      EnableMotion(target)
      wait(0.10000000149011612)
      ApplyImpulse(target, 10, 0, 0)
      FireUser1(target)
      TapeBlockers[n] = 1
    end
    local count = 0
    local (for index), (for limit), (for step) = 1, 10, 1
    for x = (for index), (for limit), (for step) do
      if (TapeBlockers[x] == 1) then
        count = (count + 1)
      end
    end
    if (count == 10) then
      FireThread(Prefab_TicketRain, "gremlinsubway_03b_dynamic.prefab_2dticketsplinetriple 04.SplineKnot 11")
      FireThread(Prefab_TicketRain, "gremlinsubway_03b_dynamic.prefab_2dticketsplinetriple 06.SplineKnot 11")
      FireThread(Prefab_TicketRain, "gremlinsubway_03b_dynamic.prefab_2dticketsplinetriple 05.SplineKnot 11")
    end
  end
  return 
end
gs3_FireCannon = function(target, _Cannon)
  Print(("__Function: gs3_FireCannon, _Cannon: " .. tostring(_Cannon)))
  Enable(("Cannon_Shooter" .. tostring(_Cannon)))
  wait(0.10000000149011612)
  Disable(("Cannon_Shooter" .. tostring(_Cannon)))
  return 
end
gs_BallManager = function(target, ballNum)
  if (ballNum == 1) then
    return "Ball1"
  elseif (ballNum == 2) then
    return "Ball2"
  end
  return 
end
gs3_ChargeBallDoorSetup = function(target)
  if (GetGlobal("DEC3_ChargePlatform1") == 0) then
    if (GetGlobal("DEC3_ChargePlatformTV1") == 0) then
      StartRotateToPosition(target, 75)
    end
  end
  return 
end
gs3_ChargeBallDoor = function(target)
  StartRotateToPosition(target, 0)
  wait(1)
  ActivateNavMeshObstacle(target, false)
  enableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 01.TargetToSend")
  disableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 19.TargetToSend")
  return 
end
gs3_EnterToobFunction_DECToRBCaverns = function()
  if (GetGlobal("2dDirection") == 1) then
    GiveCollectible("Challenge_TunnelMouse__DEC3_Tracker")
  end
  return 
end
gs3_RF_EnterDevilReverse = function()
  SetGlobal("RF_ReverseDevil", 1)
  SetGlobal("RF_TempReverseDevil", 1)
  if (GetGlobal("2dDirection") == 0) then
    GiveCollectible("Challenge_TunnelMouse__DEC3_Tracker")
  end
  return 
end
gs3_DinosaurTicketSpit = function(target)
  Print("Function entered: gs3_DinosaurTicketSpit")
  if (GetGlobal("DEC3_GoldTicket") == 1) then
    Print("gs3_DinosaurTicketSpit says global DEC3_GoldTicket is 1, spawn 10 ticket")
    Unhide("gremlinsubway_03b_dynamic.ETicket_C_Splinefollower 01")
    wait(0.4000000059604645)
    Enable("gremlinsubway_03b_dynamic.ETicket_C_Splinefollower 01")
  elseif (GetGlobal("DEC3_GoldTicket") == 0) then
    Print("gs3_DinosaurTicketSpit says global DEC3_GoldTicket is 0, spawn gold ticket")
    Unhide("gremlinsubway_03b_dynamic.ETicket_Oswald_SplineFollower 01")
    TeleportToEntity("gremlinsubway_03b_dynamic.ETicket_Oswald_TriggerBase 01", "gremlinsubway_03b_dynamic.ETicket_Oswald_SplineFollower 01")
    Enable("gremlinsubway_03b_dynamic.ETicket_Oswald_TriggerBase 01")
    SetParentEntity("gremlinsubway_03b_dynamic.ETicket_Oswald_TriggerBase 01", "gremlinsubway_03b_dynamic.ETicket_Oswald_SplineFollower 01")
    wait(0.4000000059604645)
    Enable("gremlinsubway_03b_dynamic.ETicket_Oswald_SplineFollower 01")
  else
    Print(("LUA ERROR: Global DEC3_GoldTicket is not 0 or 1, called from gs3_DinosaurTicketSpit, global is " .. tostring(GetGlobal("DEC3_GoldTicket"))))
  end
  return 
end
gs3_DinosaurTicketGlobal = function(target)
  Print("Function entered: gs3_DinosaurTicketGlobal")
  SetGlobal("DEC3_GoldTicket", 1)
  FireThread(gs3_DynamicSaveCheckPoint)
  Print("Trigger hit gs3_DinosaurTicketGlobal, global DEC3_GoldTicket should be 1")
  wait(0.10000000149011612)
  DestroyEntity(target)
  return 
end
local DEC3_JVA9_top = 1
local DEC3_JVA9_bottom = 1
updateDEC3_JVA9 = function(target, state)
  if (target == GetEntity("trn_gremlinsubway_03a_pathgeo.TRN_gremlinSubway_platformJunk_03a_toon 04")) then
    if (state == "0") then
      DEC3_JVA9_top = 0
    elseif (state == "1") then
      DEC3_JVA9_top = 1
      if (target == GetEntity("trn_gremlinsubway_03a_pathgeo.TRN_gremlinSubway_platformJunk_01a_toon 11")) then
        if (state == "0") then
          DEC3_JVA9_bottom = 0
        elseif (state == "1") then
          DEC3_JVA9_bottom = 1
        end
      end
    end
  elseif (target == GetEntity("trn_gremlinsubway_03a_pathgeo.TRN_gremlinSubway_platformJunk_01a_toon 11")) then
    if (state == "0") then
      DEC3_JVA9_bottom = 0
    elseif (state == "1") then
      DEC3_JVA9_bottom = 1
    end
  end
  if (DEC3_JVA9_top == 0) then
    if (DEC3_JVA9_bottom == 0) then
      enableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 09.TargetToSend")
    else
      disableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 09.TargetToSend")
      enableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 10.TargetToSend")
      disableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 09.TargetToSend")
      disableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 10.TargetToSend")
    end
  else
    disableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 09.TargetToSend")
    disableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 10.TargetToSend")
  end
  return 
end
updateDEC3_JVA12_17 = function(target, state)
  if (state == "0") then
    enableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 14.TargetToSend")
    enableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 15.TargetToSend")
    enableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 16.TargetToSend")
    enableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 17.TargetToSend")
    disableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 12.TargetToSend")
    disableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 13.TargetToSend")
  else
    enableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 12.TargetToSend")
    enableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 13.TargetToSend")
    disableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 14.TargetToSend")
    disableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 15.TargetToSend")
    disableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 16.TargetToSend")
    disableJumpVolumeAvailability("trn_gremlinsubway_03a_pathdatabase.prefab_jumpvolumeavailability 17.TargetToSend")
  end
  return 
end
gs3_CrayonTapeCheck = function(target)
  if (GetPropertyBool("DEC3_TopTapeBetweenCrayons", "Is Painted") == false) then
    OswaldSetPathAction(target)
  end
  return 
end
g3_TeaKettle = function(target)
  Print("DEC3: g3_TeaKettle activated")
  AudioPostEventOn("CandlePlatform", "Play_sfx_dec3_candle_rope")
  ForEachEntityInGroup(SetRotatorMaxSpeed, "CandleGears", 100)
  SetSplineFollowerInitialSpeed("CandlePlatform", 4)
  SplineFollower_StopAtPosition("CandlePlatform", "SplineKnot_Candle1", "SplineKnot_Candle2", 1)
  wait(2.4000000953674316)
  ForEachEntityInGroup(SetRotatorMaxSpeed, "CandleGears", 0)
  wait(2.5)
  AudioPostEventOn("CandlePlatform", "Play_sfx_dec3_kettle_steam")
  Unhide("TeaKettleSteam")
  AudioPostEventOn(target, "Play_sfx_dec3_gears_oneshot")
  ForEachEntityInGroup(SetRotatorMaxSpeed, "TeaKettleRotators", 100)
  local (for index), (for limit), (for step) = 1, 4, 1
  for shots = (for index), (for limit), (for step) do
    Enable("Cannon_Shooter_TeaKettle")
    wait(0.10000000149011612)
    Disable("Cannon_Shooter_TeaKettle")
    wait(0.5)
    if (shots == 3) then
      ForceSketched("gremlinsubway_03b_static.TRN_gremlinSubway_junkToy_05a_toon 01")
    end
  end
  DestroyEntity("gremlinsubway_03b_static.TorchFlameInert_01_FX 01")
  DestroyEntity("TeaKettleSteam")
  ForEachEntityInGroup(Enable, "WindupToy")
  local (for index), (for limit), (for step), (for index) = 100, 0, -5, 1
  for speed = (for index), (for limit), (for step) do
    (for index) = ForEachEntityInGroup
    (for limit) = SetRotatorMaxSpeed
    (for step) = "TeaKettleRotators"
    speed = speed
    (for index)((for limit), (for step), speed)
    (for index) = wait
    (for limit) = 0.20000000298023224
    (for index)((for limit))
    if (speed == 60) then
      (for index) = ForEachEntityInGroup
      (for limit) = SetSplineFollowerInitialSpeed
      (for step) = "WindupToy"
      speed = 2
      (for index)((for limit), (for step), speed)
    end
  end
  Enable("trn_gremlinsubway_03a_pathdatabase.TriggerBase_CameraLookAheadCat 01")
  return 
end
gs3_BucketDrop = function(target)
  Print("DEC3: gs3_BucketDrop activated")
  AudioPostEventOn("TeaKettleBucket", "Play_sfx_dec3_gate_rise")
  SetSplineFollowerInitialSpeed("TeaKettleBucket", 3)
  SetSplineFollowerInitialSpeed("TeaKettleCat_Render", 3)
  SplineFollower_StopAtPosition("TeaKettleBucket", "SplineKnot_Bucket1", "SplineKnot_Bucket2", 1)
  SplineFollower_StopAtPosition("TeaKettleCat_Render", "SplineKnot_Cat1", "SplineKnot_Cat2", 1)
  wait(2)
  DestroyEntity("TeaKettleCat_Collision")
  wait(1)
  Disable("trn_gremlinsubway_03a_pathdatabase.TriggerBase_CameraLookAheadCat 01")
  wait(1.100000023841858)
  DestroyEntity("trn_gremlinsubway_03a_pathdatabase.TriggerBase_CameraLookAheadCat 01")
  return 
end
