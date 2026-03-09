gs04_addCamera = function(player, camVal)
  local camPrefix = "O_"
  if (player == GetPlayer()) then
    camPrefix = "M_"
  end
  SetCameraAttributesForPlayer(((camPrefix .. camVal) .. "Camera_Marker(CameraOverride) 01"), player)
  return 
end
gs04_subtractCamera = function(player, camVal)
  local camPrefix = "O_"
  if (player == GetPlayer()) then
    camPrefix = "M_"
  end
  ClearCameraAttributesForPlayer(((camPrefix .. camVal) .. "Camera_Marker(CameraOverride) 01"), player)
  return 
end
DEC4_RespawnPieCameraCheck = function(target, event, instigator)
  Print("DEC4_RespawnPieCameraCheck function entered")
  local subEvent = ReviveEvent_GetSubEvent(event)
  if (subEvent == ReviveEvent_Respawn) then
    Print("DEC4_RespawnPieCameraCheck respawning")
    if (GetGlobal("2dDirection") == 1) then
      wait(0.5)
      Print("DEC4_RespawnPieCameraCheck setting pie cam")
      if (GetPropertyInt(target, "SideScrollActive") == 2) then
        SetCameraAttributesForPlayer(target, instigator)
      end
    end
  end
  return 
end
gs04_EnterToob_toGulch = function()
  if (GetGlobal("2dDirection") == 1) then
    GiveCollectible("Challenge_TunnelMouse__DEC4_Tracker")
  end
  return 
end
gs04_EnterToob_toRBC = function()
  if (GetGlobal("2dDirection") == 0) then
    GiveCollectible("Challenge_TunnelMouse__DEC4_Tracker")
  end
  return 
end
local OswaldLavaSide = "Left"
gs04_SetOswaldLavaSide = function(target, side)
  OswaldLavaSide = side
  return 
end
gs04_Oswald_LavaPath = function(target)
  if (OswaldLavaSide == "OverLava") then
    OswaldSetPathAction(target)
  elseif (GetName(target) == "gremlinsubway_04a_static.Oswald_LavaPatrolNode 01") then
    if (OswaldLavaSide == "Right") then
      OswaldSetPathAction("gremlinsubway_04a_static.Oswald_LavaPatrolNode 01b")
    end
  elseif (GetName(target) == "gremlinsubway_04a_static.Oswald_LavaPatrolNode 02") then
    if (OswaldLavaSide == "Left") then
      OswaldSetPathAction("gremlinsubway_04a_static.Oswald_LavaPatrolNode 02b")
    end
  end
  return 
end
local gs04_flipsInAction = 0
gs04_HitFirstSpringpad = function(target, phase)
  if (gs04_flipsInAction == 0) then
    if (phase == "1") then
      gs04_flipsInAction = 1
      AnimGBReset("SpringPadFlips")
      AnimGBSequence("SpringPadFlips", "play", true)
      AudioPostEventOn("SpringPadFlips", "Play_sfx_dec_ball_toss_throw")
    end
  elseif (phase == "2") then
    gs04_flipsInAction = 0
  end
  return 
end
gs_BallManager = function(target, ballNum)
  if (ballNum == 1) then
    return "DEC04_Ball_01"
  elseif (ballNum == 2) then
    return "DEC04_Ball_02"
  elseif (ballNum == 3) then
    return "DEC04_Ball_03"
  end
  return 
end
AI_Oswald = 1
gs_PlayerReachedTrolley = function()
  if (AI_Oswald == 1) then
    MoveToEntity("Oswald", "gremlinsubway_04a_dynamic.OswaldPath_PositionMarker 01")
    Hide("gremlinsubway_04a_dynamic.OswaldPath_Trigger 02")
    OswaldStreamAction("gremlinsubway_04a_dynamic.OswaldPath_PositionMarker 02")
    wait(5)
    OswaldStreamPause()
    Unhide("gremlinsubway_04a_dynamic.OswaldPath_Trigger 02")
  end
  return 
end
gs04_GetSilverPin = function()
  local silverPins = (GetGlobal("Silver_Pin") + 1)
  SetGlobal("Silver_Pin", silverPins)
  return 
end
gs04_GetBronzePin = function()
  local bronzePins = (GetGlobal("Silver_Pin") + 1)
  SetGlobal("Silver_Pin", bronzePins)
  return 
end
gs04_activatePiefaceJump = function()
  enableJumpVolumeAvailability("finalJumpUnlock1target")
  SetPropertyBool("FinalJumpActivation1", "ActionSpotEnabled", true)
  return 
end
gs04_SetupFromFoopToob = function()
  AudioEffectStart("trn_gremlinsubway_04a_audio.SND_reverb")
  ForEachEntityInGroup(SetEntityToNotCollideWithBuddyAI, "Oswald2DAvoidObject")
  SetHorizontalSplit(GetPlayer())
  local questID, stageID = Quest_GetCriticalPath()
  if (stageID == "Critical_RBC_1") then
    Quest_SetCriticalPath("Critical_DEC", "Critical_DEC_4")
  end
  Prefab_DECFoopToob_Finish()
  return 
end
gs04_CheckpointSave = function()
  wait(0.10000000149011612)
  SaveCheckpointNoPosition("gs04_SetupFromFoopToob")
  return 
end
gs_PlayerReachedPinballMachine = function()
  if (AI_Oswald == 1) then
    MoveToEntity("Oswald", "gremlinsubway_04a_dynamic.OswaldPath_PositionMarker 03")
    Hide("gremlinsubway_04a_dynamic.OswaldPath_Trigger 01")
    OswaldStreamAction("gremlinsubway_04a_dynamic.OswaldPath_PositionMarker 04")
    wait(5)
    OswaldStreamPause()
    Unhide("gremlinsubway_04a_dynamic.OswaldPath_Trigger 01")
  end
  return 
end
gs4_Transition_DisneyGulch = function()
  local TeleportToMarker = "Projector_ToCavernsDevil"
  RestrictCutSceneInput()
  StartFadeOut(0.4000000059604645)
  wait(0.75)
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    LevelManager_SetCurrentState("FTL_Gulch.Canyon_v1")
  else
    LevelManager_SetCurrentState("FTL_Gulch.Canyon_v2")
    GetPrefabData(exitProjector).ToFlyThrough = "False"
  end
  WaitForLevelLoad()
  wait(0.5)
  TeleportToEntity(GetPlayer(), TeleportToMarker)
  TeleportToEntity(GetPlayer2OrAI(), TeleportToMarker)
  wait(0.009999999776482582)
  ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
  CameraReset()
  wait(0)
  FTL_Gulch_2DTransitionSetup(TeleportToMarker, true)
  return 
end
gs_BeginBubbleSequence = function()
  AnimGBSequence("bubbleMachine_01a_inert 01", "start", true)
  ForEachEntityInGroup(Enable, "04BubbleSpinnerGroup")
  wait(1)
  StartEmitters("bubble_Particle 01")
  return 
end
gs04_OswaldRodeTrolley = function()
  OswaldIgnoreObstaclesAction("Oswald_LeaveTrolleyMarker")
  return 
end
gs04_BallBouncedOnPinball = function()
  OswaldIgnoreObstaclesAction("OswaldToPinballMachineMarker01")
  return 
end
gs04_UpperCharger = function()
  ForEachEntityInGroup(Enable, "FingerGears")
  SplineFollower_SetDisabled("UpperChargerFinger", false)
  wait(2)
  ForEachEntityInGroup(Disable, "FingerGears")
  SplineFollower_SetDisabled("magnet_01a_inert 01", false)
  wait(0.5)
  Enable("magnet_pinball_01")
  wait(0.5)
  SplineFollower_SetDisabled("magnet_Eyeball_01a_inert 01", false)
  Enable("magnet_pinball_02")
  wait(0.5)
  SplineFollower_SetDisabled("magnet_Eyeball_01a_inert 02", false)
  Enable("magnet_pinball_03")
  wait(0.5)
  SplineFollower_SetDisabled("magnet_Eyeball_01a_inert 03", false)
  wait(2)
  ForEachEntityInGroup(Enable, "BucketGears")
  SplineFollower_SetDisabled("magnet_bucket_01a_inert 01", false)
  SplineFollower_StopAtPosition("magnet_bucket_01a_inert 01", "Magnet_Bucket01_SplineKnot 01", "Magnet_Bucket01_SplineKnot 02", 1)
  wait(1)
  ForEachEntityInGroup(Disable, "BucketGears")
  enableJumpVolumeAvailability("CrayonPath_Active01")
  enableJumpVolumeAvailability("CrayonPath_Active02")
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
DEC04_BookThinnedOut = function()
  local dec4_Ball02Position = GetPosition("DEC04_Ball_02")
  StimulusEntity(nil, ST_THINNER, 1, dec4_Ball02Position, "DEC04_Ball_02")
  return 
end
DEC4_OswaldRescueOnLoad = function(target)
  Print("DEC4_OswaldRescueOnLoad function entered")
  wait(0.20000000298023224)
  if (GetGlobal("2dDirection") == 1) then
    Print("DEC4_OswaldRescueOnLoad 2dDirection is 1 so teleporting Oswald to start point")
    TeleportToEntity(GetPlayerOrAI(PLAYER_TWO), target)
  end
  return 
end
