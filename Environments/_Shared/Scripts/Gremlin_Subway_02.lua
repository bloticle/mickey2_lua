AI_Oswald = 1
gs_PlayerReachedPinballMachine = function()
  if (AI_Oswald == 1) then
    MoveToEntity("Oswald", "gremlinsubway_03a_dynamic.OswaldPath_PositionMarker 01")
    Hide("gremlinsubway_03a_dynamic.OswaldPath_Trigger 01")
    OswaldStreamAction("gremlinsubway_03a_dynamic.OswaldPath_PositionMarker 02")
    wait(5)
    OswaldStreamPause()
    Unhide("gremlinsubway_03a_dynamic.OswaldPath_Trigger 01")
  end
  return 
end
gs01_GetSilverPin = function()
  local silverPins = (GetGlobal("Silver_Pin") + 1)
  SetGlobal("Silver_Pin", silverPins)
  return 
end
gs01_GetBronzePin = function()
  local bronzePins = (GetGlobal("Silver_Pin") + 1)
  SetGlobal("Silver_Pin", bronzePins)
  return 
end
gs02_StartUp = function()
  Print("Function entered: gs02_StartUp")
  AudioEffectStart("trn_gremlinsubway_03a_audio_dec2.SND_reverb")
  SetHorizontalSplit(GetPlayer())
  local questID, stageID = Quest_GetCriticalPath()
  if (stageID == "Critical_OsTown_3") then
    Quest_SetCriticalPath("Critical_DEC", "Critical_DEC_2")
  end
  Prefab_DECFoopToob_Finish()
  if (GetGlobal("DEC2_GoldTicket") == 1) then
    DestroyEntity("gremlinsubway_03a_static.TRN_gremlinSubway_saxaphone_TriggerBase 01")
  end
  ForEachEntityInGroup(SetEntityToNotCollideWithBuddyAI, "Oswald2DAvoidObject")
  return 
end
gs02_DynamicSaveCheckPoint = function()
  wait(0.10000000149011612)
  SaveCheckpointNoPosition("gs02_StartUp")
  return 
end
gs02_SaxTicketSpit = function(target)
  Print("gs02_SaxTicketSpit function entered")
  if (GetGlobal("DEC2_GoldTicket") == 1) then
    Print("gs02_SaxTicketSpit says global DEC2_GoldTicket is 1, spawn 10 ticket")
    SplineFollower_SetDisabled("SilverTicket", false)
  elseif (GetGlobal("DEC2_GoldTicket") == 0) then
    Print("gs02_SaxTicketSpit says global DEC2_GoldTicket is 0, spawn gold ticket")
    SplineFollower_SetDisabled("GoldTicket", false)
  end
  return 
end
gs02_SaxTicketGlobal = function()
  Print("gs02_SaxTicketGlobal function entered")
  SetGlobal("DEC2_GoldTicket", 1)
  FireThread(gs02_DynamicSaveCheckPoint)
  Print("gs02_SaxTicketGlobal gold ticket has been picked up, global DEC2_GoldTicket is now 1")
  return 
end
gs02_BallerinaKey_On = function()
  SetRotatorMaxSpeed("gremlinsubway_03a_static.TRN_gremlinSubway_junkToy_04a_inert 01", 300)
  SetSplineFollowerInitialSpeed("gremlinsubway_03a_static.TRN_gremlinSubway_junkToy_04a_inert 01", 1)
  TimerReset("Ballerina_LogicTimerMarker 01")
  TimerEnable("Ballerina_LogicTimerMarker 01")
  return 
end
gs02_BallerinaReset = function()
  TimerDisable("Ballerina_LogicTimerMarker 01")
  SetRotatorMaxSpeed("gremlinsubway_03a_static.TRN_gremlinSubway_junkToy_04a_inert 01", 0)
  SetSplineFollowerInitialSpeed("gremlinsubway_03a_static.TRN_gremlinSubway_junkToy_04a_inert 01", 0)
  return 
end
gs_BallManager = function(target, ballNum)
  if (ballNum == 1) then
    return "DEC2_ChargeBall01"
  end
  return 
end
DEC2_StartWateringCan = function()
  local i = 1
  Enable("DEC2_TRN_gremlinSubway_wateringCan_01a_inert 01")
  AudioPostEventOn("gremlinsubway_03a_static.audio_dancing_clouds", "Play_sfx_dec_dancing_clouds_music_lp")
  while (i < 5) do
    ForcePainted(("DEC2_TRN_gremlinSubway_flower_01a_toon0" .. i))
    i = (i + 1)
    Wait(1)
  end
  return 
end
gs02_EnablePinballJumps = function(target)
  enableJumpVolumeAvailability("gremlinsubway_03a_static.prefab_jumpvolumeavailability 07.TargetToSend")
  enableJumpVolumeAvailability("gremlinsubway_03a_static.prefab_jumpvolumeavailability 08.TargetToSend")
  enableJumpVolumeAvailability("gremlinsubway_03a_static.prefab_jumpvolumeavailability 09.TargetToSend")
  enableJumpVolumeAvailability("gremlinsubway_03a_static.prefab_jumpvolumeavailability 10.TargetToSend")
  enableJumpVolumeAvailability("gremlinsubway_03a_static.prefab_jumpvolumeavailability 11.TargetToSend")
  return 
end
gs02_addCamera = function(player, camVal)
  local camPrefix = "Marker(CameraOverride)_O_"
  if (player == GetPlayer()) then
    camPrefix = "Marker(CameraOverride)_M_"
  end
  SetCameraAttributesForPlayer((camPrefix .. camVal), player)
  return 
end
gs02_subtractCamera = function(player, camVal)
  local camPrefix = "Marker(CameraOverride)_O_"
  if (player == GetPlayer()) then
    camPrefix = "Marker(CameraOverride)_M_"
  end
  ClearCameraAttributesForPlayer((camPrefix .. camVal), player, 1)
  return 
end
gs02_EnterToobFunction_right = function()
  GiveCollectible("Challenge_TunnelMouse__DEC2_Tracker")
  return 
end
local DEC2_Drawbridge = 0
local DEC2_DrawbridgeDone = 0
local DEC2_DrawbridgeRotation = 0
local DEC2_DrawbridgeGearDirection = 0
local OswaldJumpEnabled = 0
local xRotation = 0
local DrawbridgeGearsInMotion = 0
DEC2_WakeUpWheel = function()
  if (DEC2_Drawbridge == 0) then
    DEC2_Drawbridge = 1
    while true do
      local initLeft = GetLeft("DEC2_loose_physics_wheel_ver01 02.TRN_gremlinSubway_gameplayWheel_01a_inert 01")
      local initUp = GetUp("DEC2_loose_physics_wheel_ver01 02.TRN_gremlinSubway_gameplayWheel_01a_inert 01")
      local initFacing = GetFacing("DEC2_loose_physics_wheel_ver01 02.TRN_gremlinSubway_gameplayWheel_01a_inert 01")
      wait(0.03999999910593033)
      xRotation = (GetLocalRotationX("DEC2_loose_physics_wheel_ver01 02.TRN_gremlinSubway_gameplayWheel_01a_inert 01", initLeft, initUp, initFacing) * 57.3248405456543)
      Print(("xRotation: " .. tostring(xRotation)))
      if (xRotation < 0) then
        if (0 < DEC2_DrawbridgeRotation) then
          DEC2_DrawbridgeRotation = (DEC2_DrawbridgeRotation - 10)
          Print(("and DEC2_DrawbridgeRotation > 0 so -10: " .. tostring(DEC2_DrawbridgeRotation)))
          if (DEC2_DrawbridgeGearDirection == 1) then
            ForEachEntityInGroup(Reverse, "DEC2_DropBridgeGears")
            DEC2_DrawbridgeGearDirection = 0
          end
          if (DrawbridgeGearsInMotion == 0) then
            DrawbridgeGearsInMotion = 1
            ForEachEntityInGroup(Enable, "DEC2_DropBridgeGears")
            AudioPostEventOn("trn_gremlinsubway_03a_audio_dec2.SND_env_Gears_4_LP", "Play_sfx_dec_gear_3_lp")
            wait(0.10000000149011612)
          end
          StartRotateToPosition("DEC2_TRN_gremlinSubway_platformDoor_01a_inert 01", DEC2_DrawbridgeRotation)
          wait(0.5)
        end
      elseif (0 < xRotation) then
        if (DEC2_DrawbridgeRotation < 80) then
          DEC2_DrawbridgeRotation = (DEC2_DrawbridgeRotation + 10)
          Print(("and DEC2_DrawbridgeRotation < 80 so +10: " .. tostring(DEC2_DrawbridgeRotation)))
          if (DEC2_DrawbridgeGearDirection == 0) then
            ForEachEntityInGroup(Reverse, "DEC2_DropBridgeGears")
            DEC2_DrawbridgeGearDirection = 1
          end
          if (DrawbridgeGearsInMotion == 0) then
            DrawbridgeGearsInMotion = 1
            ForEachEntityInGroup(Enable, "DEC2_DropBridgeGears")
            AudioPostEventOn("trn_gremlinsubway_03a_audio_dec2.SND_env_Gears_4_LP", "Play_sfx_dec_gear_3_lp")
            wait(0.10000000149011612)
          end
          StartRotateToPosition("DEC2_TRN_gremlinSubway_platformDoor_01a_inert 01", DEC2_DrawbridgeRotation)
          wait(0.5)
          if (40 < DEC2_DrawbridgeRotation) then
            if (OswaldJumpEnabled == 0) then
              OswaldJumpEnabled = 1
              enableJumpVolumeAvailability("gremlinsubway_03a_static.prefab_jumpvolumeavailability 05.TargetToSend")
            end
          end
          if (70 < DEC2_DrawbridgeRotation) then
            DEC2_DrawbridgeDone = 1
            ForEachEntityInGroup(DestroyEntity, "DrawbridgeAutoCompleteTrigger")
          end
        end
      end
      wait(0.20000000298023224)
      if (not (math.abs(xRotation) >= 0.5)) then
        break
      end
    end
    ForEachEntityInGroup(Disable, "DEC2_DropBridgeGears")
    DrawbridgeGearsInMotion = 0
    if (DEC2_DrawbridgeDone == 0) then
      DEC2_Drawbridge = 0
    end
  end
  return 
end
gs02_SetSpinVulnerable = function(target)
  SetVulnerability(target, ST_SPIN, 1)
  return 
end
gs02_DrawbridgeStim = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_SPIN) then
    if (DEC2_DrawbridgeDone == 0) then
      SetVulnerability(target, ST_SPIN, 0)
      FireThread(DrawbridgeAutoComplete)
    end
  elseif (DEC2_DrawbridgeDone == 1) then
    SetVulnerability(target, ST_SPIN, 0)
  end
  return 
end
DrawbridgeAutoComplete = function()
  if (DEC2_DrawbridgeDone == 0) then
    DEC2_DrawbridgeDone = 1
    DEC2_Drawbridge = 1
    if (DEC2_DrawbridgeGearDirection == 0) then
      ForEachEntityInGroup(Reverse, "DEC2_DropBridgeGears")
      DEC2_DrawbridgeGearDirection = 1
    end
    ForEachEntityInGroup(Enable, "DEC2_DropBridgeGears")
    StartRotateToPosition("DEC2_TRN_gremlinSubway_platformDoor_01a_inert 01", 80)
    wait(2)
    ForEachEntityInGroup(Disable, "DEC2_DropBridgeGears")
    if (OswaldJumpEnabled == 0) then
      OswaldJumpEnabled = 1
      enableJumpVolumeAvailability("gremlinsubway_03a_static.prefab_jumpvolumeavailability 05.TargetToSend")
    end
    ForEachEntityInGroup(DestroyEntity, "DrawbridgeAutoCompleteTrigger")
  end
  return 
end
local DEC2_BasketBall = 0
local BasketBallAnimState = "rest"
gs02_WakeUpBasketball = function()
  Print("function entered: gs02_WakeUpBasketball")
  if (DEC2_BasketBall == 0) then
    DEC2_BasketBall = 1
    local initLeftBasketBall = GetLeft("DEC2_loose_physics_wheel_ver01 01.TRN_gremlinSubway_gameplayWheel_01a_inert 01")
    local initUpBasketBall = GetUp("DEC2_loose_physics_wheel_ver01 01.TRN_gremlinSubway_gameplayWheel_01a_inert 01")
    local initFacingBasketBall = GetFacing("DEC2_loose_physics_wheel_ver01 01.TRN_gremlinSubway_gameplayWheel_01a_inert 01")
    wait(0.03999999910593033)
    local xRotation = (GetLocalRotationX("DEC2_loose_physics_wheel_ver01 01.TRN_gremlinSubway_gameplayWheel_01a_inert 01", initLeftBasketBall, initUpBasketBall, initFacingBasketBall) * 57.3248405456543)
    if (xRotation < 0) then
      if (BasketBallAnimState == "rest") then
        BasketBallAnimState = "windUp"
        Enable("BasketBallGear")
        wait(1.5)
        Disable("BasketBallGear")
        Reverse("BasketBallGear")
        AnimGBSequence("BasketBallMachine", "windUp", true)
      end
    elseif (0 < xRotation) then
      if (BasketBallAnimState == "windUp_done") then
        BasketBallAnimState = "toss"
        Enable("BasketBallGear")
        wait(1.5)
        AudioPostEventOn("trn_gremlinsubway_03a_audio_dec2.SND_env_Gears_1_LP", "Play_sfx_basketball_toss_throw")
        Disable("BasketBallGear")
        Reverse("BasketBallGear")
        AnimGBSequence("BasketBallMachine", "toss", true)
        FireThread(BasketBallAudioDelay)
      end
    end
    DEC2_BasketBall = 0
  end
  return 
end
SetNextBasketBallAnimState = function()
  Print(("function entered SetNextBasketBallAnimState and state is " .. BasketBallAnimState))
  if (BasketBallAnimState == "windUp") then
    BasketBallAnimState = "windUp_done"
  elseif (BasketBallAnimState == "toss") then
    AnimGBSequence("BasketBallMachine", "rest")
    wait(0.10000000149011612)
    BasketBallAnimState = "rest"
  end
  return 
end
BasketBallAudioDelay = function()
  wait(1)
  AudioPostEventOn("trn_gremlinsubway_03a_audio_dec2.Snd_events_basketball_seq1", "Play_sfx_basketball_lp")
  return 
end
PianoKeyFakeEnable = function(target)
  SetPropertyFloat(target, "Weight Requirement", 10)
  return 
end
PianoKeyFakeDisable = function(target)
  SetPropertyFloat(target, "Weight Requirement", 10000)
  return 
end
local MickeyInPlanePocket = false
local OswaldInPlanePocket = false
DEC2_PlaneStuckCheck = function(character, state)
  Print("DEC2_PlaneStuckCheck function entered")
  if (state == "in") then
    if (character == GetPlayer()) then
      Print("DEC2_PlaneStuckCheck Mickey in plane pocket")
      MickeyInPlanePocket = true
      if (OswaldInPlanePocket == true) then
        FireThread(DEC2_MovePlaneSplineFollower)
      end
    else
      Print("DEC2_PlaneStuckCheck Oswald in plane pocket")
      OswaldInPlanePocket = true
      if (MickeyInPlanePocket == true) then
        FireThread(DEC2_MovePlaneSplineFollower)
        if (character == GetPlayer()) then
          Print("DEC2_PlaneStuckCheck Mickey exited plane pocket")
          MickeyInPlanePocket = false
        else
          Print("DEC2_PlaneStuckCheck Oswald exited plane pocket")
          OswaldInPlanePocket = false
        end
        Print("DEC2_PlaneStuckCheck lowering splinefollower")
        SetSplineFollowerInitialSpeed("PlaneStuck_SplineFollower", 10)
        SplineFollower_StopAtPosition("PlaneStuck_SplineFollower", "PlaneStuck_SplineKnot1", "PlaneStuck_SplineKnot2", 0)
      end
    end
  else
    if (character == GetPlayer()) then
      Print("DEC2_PlaneStuckCheck Mickey exited plane pocket")
      MickeyInPlanePocket = false
    else
      Print("DEC2_PlaneStuckCheck Oswald exited plane pocket")
      OswaldInPlanePocket = false
    end
    Print("DEC2_PlaneStuckCheck lowering splinefollower")
    SetSplineFollowerInitialSpeed("PlaneStuck_SplineFollower", 10)
    SplineFollower_StopAtPosition("PlaneStuck_SplineFollower", "PlaneStuck_SplineKnot1", "PlaneStuck_SplineKnot2", 0)
  end
  return 
end
DEC2_MovePlaneSplineFollower = function()
  Print("DEC2_MovePlaneSplineFollower function entered")
  Enable("PlaneStuck_SplineFollower")
  SetSplineFollowerInitialSpeed("PlaneStuck_SplineFollower", 1)
  SplineFollower_StopAtPosition("PlaneStuck_SplineFollower", "PlaneStuck_SplineKnot1", "PlaneStuck_SplineKnot2", 1)
  return 
end

