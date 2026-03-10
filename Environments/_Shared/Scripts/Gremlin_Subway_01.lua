gs_BallManager = function(target, ballNum)
  if (ballNum == 1) then
    return "ChargingBall02"
  elseif (ballNum == 2) then
    return "ChargingBall01"
  end
  return 
end
DEC_UnlockOswaldAbilities = function()
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Use")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Jump")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Bounce")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Spin")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Hover")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Toss")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "CoopMove")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Indelible")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Invisible")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Boomerang")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "ElectricBlast")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "ElectricStream")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "CrossedStream")
  return 
end
gs01_EnterFoopToOstown = function()
  if (GetGlobal("2dDirection") == 1) then
    GiveCollectible("Challenge_TunnelMouse__DEC1_Tracker")
  end
  return 
end
gs01_EnterFoopToMSN = function()
  if (GetGlobal("2dDirection") == 0) then
    GiveCollectible("Challenge_TunnelMouse__DEC1_Tracker")
  end
  return 
end
gs01_CheckpointSave = function()
  wait(0.10000000149011612)
  SaveCheckpointNoPosition("gs01_StartUp")
  return 
end
gs01_StartUp = function(target)
  AudioEffectStart("trn_gremlinsubway_02a_audio.reverb")
  ForEachEntityInGroup(SetEntityToNotCollideWithBuddyAI, "Oswald2DAvoidObject")
  SetHorizontalSplit(GetPlayer())
  local questID, stageID = Quest_GetCriticalPath()
  if (stageID == "Critical_MSN_3") then
    Quest_SetCriticalPath("Critical_DEC", "Critical_DEC_1")
  end
  Prefab_DECFoopToob_Finish()
  return 
end
gs01_addCamera = function(player, camVal)
  local camPrefix = "O_"
  if (player == GetPlayer()) then
    camPrefix = "M_"
  end
  SetCameraAttributesForPlayer(((camPrefix .. camVal) .. "Camera_Marker(CameraOverride) 01"), player)
  return 
end
gs01_subtractCamera = function(player, camVal)
  local camPrefix = "O_"
  if (player == GetPlayer()) then
    camPrefix = "M_"
  end
  ClearCameraAttributesForPlayer(((camPrefix .. camVal) .. "Camera_Marker(CameraOverride) 01"), player)
  return 
end
gs01_Bell01_on = 0
gs01_Bell02_on = 0
gs01_Bell03_on = 0
gs01_BellRung = function(target, bell)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* bell rung!!!")
  if (bell == "1") then
    if (gs01_Bell01_on == 0) then
      AnimGBReset("gremlinsubway_02a_static.TRN_gremlinSubway_bell_01a_inert 03")
      AnimGBSequence("gremlinsubway_02a_static.TRN_gremlinSubway_bell_01a_inert 03", "play")
    end
  elseif (bell == "2") then
    if (gs01_Bell02_on == 0) then
      AnimGBReset("gremlinsubway_02a_static.TRN_gremlinSubway_bell_01a_inert 02")
      AnimGBSequence("gremlinsubway_02a_static.TRN_gremlinSubway_bell_01a_inert 02", "play")
    end
  elseif (bell == "3") then
    if (gs01_Bell03_on == 0) then
      AnimGBReset("gremlinsubway_02a_static.TRN_gremlinSubway_bell_01a_inert 01")
      AnimGBSequence("gremlinsubway_02a_static.TRN_gremlinSubway_bell_01a_inert 01", "play")
    end
  end
  return 
end
gs01_BellToIdle = function(target)
  AnimGBSequence(target, "idle")
  return 
end
AI_Oswald = 0
gs_OswaldStartup = function()
  SetEntityToNotCollideWithBuddyAI("gremlinsubway_02a_dynamic.chargingball_single_ver01 01.tmp_physicsBall_01a 01")
  SetEntityToNotCollideWithBuddyAI("gremlinsubway_02a_dynamic.chargingball_single_ver01 02.tmp_physicsBall_01a 01")
  AI_Oswald = 1
  return 
end
gs_MickeyOnTrolley = function()
  if (AI_Oswald == 1) then
    MoveToEntity("Oswald", "gremlinsubway_02a_dynamic.OswaldPath_PositionMarker 02")
    OswaldIgnoreObstaclesAction("gremlinsubway_02a_dynamic.OswaldPath_PositionMarker 02")
    wait(1)
    OswaldStreamAction("gremlinsubway_02a_dynamic.OswaldPath_PositionMarker 01")
    wait(5)
    OswaldStreamPause()
  end
  return 
end
gs01_ball_rolled = 0
gs01_ClockPainted = function()
  ForEachEntityInGroup(SetRotatorMaxSpeed, "ClockFaceGears", 60)
  SetRotatorMaxSpeed("TRN_gremlinSubway_gear_02a_inert 13", 80)
  wait(0.4000000059604645)
  AudioPostEventOn("trn_gremlinsubway_02a_audio.Clock_Gears", "Play_sfx_dec_clock_fully_painted_gears_lp")
  if (gs01_ball_rolled == 0) then
    wait(1)
    gs01_ball_rolled = 1
    SetRotatorMaxSpeed("TRN_gremlinSubway_putter_01a_inert 01", 30)
    wait(0.5)
    SetRotatorMaxSpeed("TRN_gremlinSubway_gameplayPinball_01a_inert 01", 180)
    SetSplineFollowerInitialSpeed("TRN_gremlinSubway_gameplayPinball_01a_inert 01", 2)
    AudioPostEventOn("trn_gremlinsubway_02a_audio.Clock_Gears", "Play_sfx_dec_clock_fully_painted_ball_roll")
  end
  return 
end
gs01_ClockThinned = function()
  AudioPostEventOn("trn_gremlinsubway_02a_audio.Clock_Gears", "Stop_sfx_dec_clock_fully_painted_gears_lp")
  ForEachEntityInGroup(SetRotatorMaxSpeed, "ClockFaceGears", 0)
  SetRotatorMaxSpeed("TRN_gremlinSubway_gear_02a_inert 13", 0)
  return 
end
gs01_Ball_InBucket = function()
  Hide("TRN_gremlinSubway_gameplayPinball_01a_inert 01")
  AudioPostEventOn("trn_gremlinsubway_02a_audio.Clock_Gears", "Play_sfx_dec_clock_fully_painted_ball_land")
  SetSplineFollowerInitialSpeed("Bucket_SplineFollower 01", 20)
  SetSplineFollowerInitialSpeed("TRN_gremlinSubway_bucket_Counter_01a_inert 17", 20)
  wait(2)
  FireUser1("BallGate_LogicRelayMarker 01")
  return 
end
gs01_Gizmo01_Started = 0
gs01_tixShowerCount = 0
gs01_tixShowerFired = 0
gs01_tixShower_TV_dropped = function()
  if (gs01_tixShowerFired == 0) then
    gs01_tixShowerCount = (gs01_tixShowerCount + 1)
    if (gs01_tixShowerCount < 3) then
      FireSequence("Gus", "DEC_v1_TicketPipeHint")
    elseif (gs01_tixShowerCount == 3) then
      gs01_TicketShower_Activated()
    end
  end
  return 
end
gs01_tixShower_TV_gone = function()
  if (gs01_tixShowerFired == 0) then
    gs01_tixShowerCount = (gs01_tixShowerCount - 1)
  end
  return 
end
gs01_tixShower_button_On = function()
  if (gs01_tixShowerFired == 0) then
    gs01_tixShowerCount = (gs01_tixShowerCount + 1)
    if (gs01_tixShowerCount == 3) then
      gs01_TicketShower_Activated()
    end
  end
  return 
end
gs01_tixShower_button_Off = function()
  if (gs01_tixShowerFired == 0) then
    gs01_tixShowerCount = (gs01_tixShowerCount - 1)
  end
  return 
end
gs01_Gizmo01_Boot = function()
  if (gs01_Gizmo01_Started == 0) then
    gs01_Gizmo01_Started = 1
    SetRotatorMaxSpeed("Gizmo01_SpinnerMarker(Rotatable) 01", 120)
    wait(0.699999988079071)
  end
  AnimGBReset("TRN_gremlinSubway_Boot_Motor 01")
  AnimGBSequence("TRN_gremlinSubway_Boot_Motor 01", "boot_kick")
  AudioPostEventOn("Gizmo01_SpinnerMarker(Rotatable) 01", "Play_sfx_dec_spiral_lp")
  return 
end
gs01_TicketShower_Activated = function()
  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*__*_*_*_*_* TICKETS GOOOOOOOOOOOOO")
  FireSequence("Gus", "DEC_v1_TicketPipeActivated")
  gs01_tixShowerFired = 1
  MoveToEntity("Ticket_Pipe_ETicket_E 01", "Ticket_Pipe01_SplineFollower 01")
  SetParentEntity("Ticket_Pipe_ETicket_E 01", "Ticket_Pipe01_SplineFollower 01")
  SetSplineFollowerInitialSpeed("Ticket_Pipe01_SplineFollower 01", 13)
  wait(0.20000000298023224)
  MoveToEntity("Ticket_Pipe_ETicket_E 02", "Ticket_Pipe02_SplineFollower 01")
  SetParentEntity("Ticket_Pipe_ETicket_E 02", "Ticket_Pipe02_SplineFollower 01")
  SetSplineFollowerInitialSpeed("Ticket_Pipe02_SplineFollower 01", 13)
  wait(0.20000000298023224)
  MoveToEntity("Ticket_Pipe_ETicket_E 03", "Ticket_Pipe03_SplineFollower 01")
  SetParentEntity("Ticket_Pipe_ETicket_E 03", "Ticket_Pipe03_SplineFollower 01")
  SetSplineFollowerInitialSpeed("Ticket_Pipe03_SplineFollower 01", 13)
  wait(0.5)
  MoveToEntity("Ticket_Pipe_ETicket_E 04", "Ticket_Pipe01_SplineFollower 02")
  SetParentEntity("Ticket_Pipe_ETicket_E 04", "Ticket_Pipe01_SplineFollower 02")
  SetSplineFollowerInitialSpeed("Ticket_Pipe01_SplineFollower 02", 13)
  wait(0.20000000298023224)
  MoveToEntity("Ticket_Pipe_ETicket_E 05", "Ticket_Pipe02_SplineFollower 02")
  SetParentEntity("Ticket_Pipe_ETicket_E 05", "Ticket_Pipe02_SplineFollower 02")
  SetSplineFollowerInitialSpeed("Ticket_Pipe02_SplineFollower 02", 13)
  wait(0.20000000298023224)
  MoveToEntity("Ticket_Pipe_ETicket_E 06", "Ticket_Pipe03_SplineFollower 02")
  SetParentEntity("Ticket_Pipe_ETicket_E 06", "Ticket_Pipe03_SplineFollower 02")
  SetSplineFollowerInitialSpeed("Ticket_Pipe03_SplineFollower 02", 13)
  wait(0.20000000298023224)
  ClearParent("Ticket_Pipe_ETicket_E 01")
  ClearParent("Ticket_Pipe_ETicket_E 02")
  ClearParent("Ticket_Pipe_ETicket_E 03")
  SplineKnotComponent_SetBranchProbability("Ticket_Pipe01_SplineKnot 01", 1)
  SplineKnotComponent_SetBranchProbability("Ticket_Pipe02_SplineKnot 01", 1)
  SplineKnotComponent_SetBranchProbability("Ticket_Pipe03_SplineKnot 01", 1)
  SetSplineFollowerInitialSpeed("Ticket_Pipe01_SplineFollower 01", 0)
  SetSplineFollowerInitialSpeed("Ticket_Pipe02_SplineFollower 01", 0)
  SetSplineFollowerInitialSpeed("Ticket_Pipe02_SplineFollower 01", 0)
  SplineFollower_TeleportToKnot("Ticket_Pipe01_SplineFollower 01", "Ticket_Pipe01_SplineKnot 01")
  SplineFollower_TeleportToKnot("Ticket_Pipe02_SplineFollower 01", "Ticket_Pipe02_SplineKnot 01")
  SplineFollower_TeleportToKnot("Ticket_Pipe03_SplineFollower 01", "Ticket_Pipe03_SplineKnot 01")
  wait(0.5)
  MoveToEntity("Ticket_Pipe_ETicket_E 07", "Ticket_Pipe01_SplineFollower 03")
  SetParentEntity("Ticket_Pipe_ETicket_E 07", "Ticket_Pipe01_SplineFollower 03")
  SetSplineFollowerInitialSpeed("Ticket_Pipe01_SplineFollower 03", 13)
  wait(0.20000000298023224)
  MoveToEntity("Ticket_Pipe_ETicket_E 08", "Ticket_Pipe02_SplineFollower 03")
  SetParentEntity("Ticket_Pipe_ETicket_E 08", "Ticket_Pipe02_SplineFollower 03")
  SetSplineFollowerInitialSpeed("Ticket_Pipe02_SplineFollower 03", 13)
  wait(0.20000000298023224)
  MoveToEntity("Ticket_Pipe_ETicket_E 09", "Ticket_Pipe03_SplineFollower 03")
  SetParentEntity("Ticket_Pipe_ETicket_E 09", "Ticket_Pipe03_SplineFollower 03")
  SetSplineFollowerInitialSpeed("Ticket_Pipe03_SplineFollower 03", 13)
  wait(0.20000000298023224)
  ClearParent("Ticket_Pipe_ETicket_E 04")
  ClearParent("Ticket_Pipe_ETicket_E 05")
  ClearParent("Ticket_Pipe_ETicket_E 06")
  SplineKnotComponent_SetBranchProbability("Ticket_Pipe01_SplineKnot 02", 1)
  SplineKnotComponent_SetBranchProbability("Ticket_Pipe02_SplineKnot 02", 1)
  SplineKnotComponent_SetBranchProbability("Ticket_Pipe03_SplineKnot 02", 1)
  SetSplineFollowerInitialSpeed("Ticket_Pipe01_SplineFollower 02", 0)
  SetSplineFollowerInitialSpeed("Ticket_Pipe02_SplineFollower 02", 0)
  SetSplineFollowerInitialSpeed("Ticket_Pipe02_SplineFollower 02", 0)
  SplineFollower_TeleportToKnot("Ticket_Pipe01_SplineFollower 02", "Ticket_Pipe01_SplineKnot 02")
  SplineFollower_TeleportToKnot("Ticket_Pipe02_SplineFollower 02", "Ticket_Pipe02_SplineKnot 02")
  SplineFollower_TeleportToKnot("Ticket_Pipe03_SplineFollower 02", "Ticket_Pipe03_SplineKnot 02")
  wait(0.5)
  MoveToEntity("Ticket_Pipe_ETicket_E 10", "Ticket_Pipe01_SplineFollower 01")
  SetParentEntity("Ticket_Pipe_ETicket_E 10", "Ticket_Pipe01_SplineFollower 01")
  SetSplineFollowerInitialSpeed("Ticket_Pipe01_SplineFollower 01", 13)
  wait(0.20000000298023224)
  MoveToEntity("Ticket_Pipe_ETicket_E 11", "Ticket_Pipe02_SplineFollower 01")
  SetParentEntity("Ticket_Pipe_ETicket_E 11", "Ticket_Pipe02_SplineFollower 01")
  SetSplineFollowerInitialSpeed("Ticket_Pipe02_SplineFollower 01", 13)
  wait(0.20000000298023224)
  MoveToEntity("Ticket_Pipe_ETicket_E 12", "Ticket_Pipe03_SplineFollower 01")
  SetParentEntity("Ticket_Pipe_ETicket_E 12", "Ticket_Pipe03_SplineFollower 01")
  SetSplineFollowerInitialSpeed("Ticket_Pipe03_SplineFollower 01", 13)
  wait(0.5)
  MoveToEntity("Ticket_Pipe_ETicket_E 13", "Ticket_Pipe01_SplineFollower 02")
  SetParentEntity("Ticket_Pipe_ETicket_E 13", "Ticket_Pipe01_SplineFollower 02")
  SetSplineFollowerInitialSpeed("Ticket_Pipe01_SplineFollower 02", 13)
  wait(0.20000000298023224)
  MoveToEntity("Ticket_Pipe_ETicket_E 14", "Ticket_Pipe02_SplineFollower 02")
  SetParentEntity("Ticket_Pipe_ETicket_E 14", "Ticket_Pipe02_SplineFollower 02")
  SetSplineFollowerInitialSpeed("Ticket_Pipe02_SplineFollower 02", 13)
  wait(0.20000000298023224)
  MoveToEntity("Ticket_Pipe_ETicket_E 15", "Ticket_Pipe03_SplineFollower 02")
  SetParentEntity("Ticket_Pipe_ETicket_E 15", "Ticket_Pipe03_SplineFollower 02")
  SetSplineFollowerInitialSpeed("Ticket_Pipe03_SplineFollower 02", 13)
  wait(0.20000000298023224)
  ClearParent("Ticket_Pipe_ETicket_E 07")
  ClearParent("Ticket_Pipe_ETicket_E 08")
  ClearParent("Ticket_Pipe_ETicket_E 09")
  SplineKnotComponent_SetBranchProbability("Ticket_Pipe01_SplineKnot 03", 1)
  SplineKnotComponent_SetBranchProbability("Ticket_Pipe02_SplineKnot 03", 1)
  SplineKnotComponent_SetBranchProbability("Ticket_Pipe03_SplineKnot 03", 1)
  SetSplineFollowerInitialSpeed("Ticket_Pipe01_SplineFollower 03", 0)
  SetSplineFollowerInitialSpeed("Ticket_Pipe02_SplineFollower 03", 0)
  SetSplineFollowerInitialSpeed("Ticket_Pipe02_SplineFollower 03", 0)
  SplineFollower_TeleportToKnot("Ticket_Pipe01_SplineFollower 03", "Ticket_Pipe01_SplineKnot 03")
  SplineFollower_TeleportToKnot("Ticket_Pipe02_SplineFollower 03", "Ticket_Pipe02_SplineKnot 03")
  SplineFollower_TeleportToKnot("Ticket_Pipe03_SplineFollower 03", "Ticket_Pipe03_SplineKnot 03")
  wait(0.5)
  MoveToEntity("Ticket_Pipe_ETicket_E 16", "Ticket_Pipe01_SplineFollower 03")
  SetParentEntity("Ticket_Pipe_ETicket_E 16", "Ticket_Pipe01_SplineFollower 03")
  SetSplineFollowerInitialSpeed("Ticket_Pipe01_SplineFollower 03", 13)
  wait(0.20000000298023224)
  MoveToEntity("Ticket_Pipe_ETicket_E 17", "Ticket_Pipe02_SplineFollower 03")
  SetParentEntity("Ticket_Pipe_ETicket_E 17", "Ticket_Pipe02_SplineFollower 03")
  SetSplineFollowerInitialSpeed("Ticket_Pipe02_SplineFollower 03", 13)
  wait(0.20000000298023224)
  MoveToEntity("Ticket_Pipe_ETicket_E 18", "Ticket_Pipe03_SplineFollower 03")
  SetParentEntity("Ticket_Pipe_ETicket_E 18", "Ticket_Pipe03_SplineFollower 03")
  SetSplineFollowerInitialSpeed("Ticket_Pipe03_SplineFollower 03", 13)
  return 
end
gs01_PlayerOn_TicketButton01 = function()
  OswaldSetPathAction("Ticket_Pipe_PatrolNode 02")
  return 
end
gs01_PlayerOff_TicketButton01 = function()
  OswaldStartFollowAction()
  return 
end
gs01_PlayerOn_TicketButton02 = function()
  OswaldSetPathAction("Ticket_Pipe_PatrolNode 01")
  return 
end
gs01_PlayerOff_TicketButton02 = function()
  OswaldStartFollowAction()
  return 
end
gs01_Gizmo02_PieOven = function()
  StartEmitters("NOS_musicalNotes_01a 01")
  AnimGBSequence("TRN_gremlinSubway_hamster_01a_inert 01", "wake", true)
  AudioPostEventOn("TRN_gremlinSubway_hamster_01a_inert 01", "Play_sfx_turtle_running_wheel_lp")
  SetRotatorMaxSpeed("TRN_gremlinSubway_hamsterWheel_01a_inert 01", 120)
  AnimGBSequence("TRN_gremlinSubway_boomBoxSpeaker_01a_inert 01", "loop")
  ForEachEntityInGroup(SetRotatorMaxSpeed, "Gizmo02_Gears", 40)
  return 
end
gs01_Turtle_toLoop = function()
  AnimGBSequence("TRN_gremlinSubway_hamster_01a_inert 01", "run")
  return 
end
gs01_Oswald_BeneathTrolley = function()
  OswaldIgnoreObstaclesAction("SpringPad_BeneathTrolley")
  return 
end
gs01_TrainState = 1
gs01_OswaldAtTrain = 0
gs01_TrainThinned = function()
  gs01_TrainState = 0
  if (gs01_OswaldAtTrain == 1) then
    OswaldIgnoreObstaclesAction("Oswald_TrainPositionMarker 01")
  end
  return 
end
gs01_TrainPainted = function()
  gs01_TrainState = 1
  return 
end
gs01_OswaldNearTrain = function()
  gs01_OswaldAtTrain = 1
  OswaldJumpAction(".Oswald_PositionMarker 02a")
  return 
end
gs01_OswaldLeaveTrain = function()
  gs01_OswaldAtTrain = 0
  return 
end
gs01_HardLoadDemo = function()
  LoadLevel(GetPlayer(), "OST_Center.Main_Visit1")
  return 
end
gs01_ConfettiTimer01on = 0
gs01_ConfettiTimer02on = 0
gs01_ConfettiTimer03on = 0
gs01_ConfettiButton = function(target, button)
  if (button == "1") then
    gs01_ConfettiTimer01on = 1
    FireUser1("ConfettiButton01_LogicTimerMarker 01")
    TimerReset("ConfettiButton01_LogicTimerMarker 01")
    TimerEnable("ConfettiButton01_LogicTimerMarker 01")
  elseif (button == "2") then
    gs01_ConfettiTimer02on = 1
    FireUser1("ConfettiButton02_LogicTimerMarker 01")
    TimerReset("ConfettiButton02_LogicTimerMarker 01")
    TimerEnable("ConfettiButton02_LogicTimerMarker 01")
  elseif (button == "3") then
    gs01_ConfettiTimer03on = 1
    FireUser1("ConfettiButton03_LogicTimerMarker 01")
    TimerReset("ConfettiButton03_LogicTimerMarker 01")
    TimerEnable("ConfettiButton03_LogicTimerMarker 01")
  end
  return 
end
gs01_ConfettiButtonOff = function(target, button)
  if (button == "1") then
    gs01_ConfettiTimer01on = 0
  elseif (button == "2") then
    gs01_ConfettiTimer02on = 0
  elseif (button == "3") then
    gs01_ConfettiTimer03on = 0
  end
  return 
end
gs01_ConfettiTimerFired = function(target, fettiNum)
  if (fettiNum == "1") then
    if (gs01_ConfettiTimer01on == 1) then
      AnimGBSequence("gremlinsubway_02a_dynamic.TRN_gremlinSubway_confettiPopper_01a_inert 01", "blow")
      wait(0.5)
      AudioPostEventOn("gremlinsubway_02a_dynamic.TRN_gremlinSubway_confettiPopper_01a_inert 01", "Play_sfx_dec_confetti_blast")
      StartEmitters("gremlinsubway_02a_dynamic.GBL_confettiBlast_01a 02")
      wait(1)
      StartEmitters("gremlinsubway_02a_dynamic.GBL_confettiBlast_01a 02")
      wait(0.5)
      AnimGBSequence("gremlinsubway_02a_dynamic.TRN_gremlinSubway_confettiPopper_01a_inert 01", "rest")
      wait(0.5)
      StopEmitters("gremlinsubway_02a_dynamic.GBL_confettiBlast_01a 02")
    end
  elseif (fettiNum == "2") then
    if (gs01_ConfettiTimer02on == 1) then
      AnimGBSequence("gremlinsubway_02a_dynamic.TRN_gremlinSubway_confettiPopper_01a_inert 02", "blow")
      wait(0.5)
      AudioPostEventOn("gremlinsubway_02a_dynamic.TRN_gremlinSubway_confettiPopper_01a_inert 02", "Play_sfx_dec_confetti_blast")
      StartEmitters("gremlinsubway_02a_dynamic.GBL_confettiBlast_01a 01")
      wait(1)
      StartEmitters("gremlinsubway_02a_dynamic.GBL_confettiBlast_01a 01")
      wait(0.5)
      AnimGBSequence("gremlinsubway_02a_dynamic.TRN_gremlinSubway_confettiPopper_01a_inert 02", "rest")
      wait(0.5)
      StopEmitters("gremlinsubway_02a_dynamic.GBL_confettiBlast_01a 01")
    end
  elseif (fettiNum == "3") then
    if (gs01_ConfettiTimer03on == 1) then
      AnimGBSequence("gremlinsubway_02a_dynamic.TRN_gremlinSubway_confettiPopper_01a_inert 03", "blow")
      wait(1)
      AudioPostEventOn("gremlinsubway_02a_dynamic.TRN_gremlinSubway_confettiPopper_01a_inert 03", "Play_sfx_dec_confetti_blast")
      StartEmitters("gremlinsubway_02a_dynamic.GBL_confettiBlast_01a 03")
      wait(0.5)
      StartEmitters("gremlinsubway_02a_dynamic.GBL_confettiBlast_01a 03")
      wait(1)
      AnimGBSequence("gremlinsubway_02a_dynamic.TRN_gremlinSubway_confettiPopper_01a_inert 03", "rest")
      wait(0.5)
      StopEmitters("gremlinsubway_02a_dynamic.GBL_confettiBlast_01a 03")
    end
  else
    TimerDisable(target)
  end
  return 
end

