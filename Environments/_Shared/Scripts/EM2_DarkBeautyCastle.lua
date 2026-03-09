DBC_SetupCheck = 0
local MusicVar = 0
DBC_IntroShotCheck = 0
DBC_AlwaysSetup = function()
  if (DBC_SetupCheck == 0) then
    DBC_SetupCheck = 1
    if (GetGlobal("DBC_IntroMoviePlayed") == 0) then
      DBC_IntroShotCheck = 1
      RestrictCutSceneInput()
      StartFadeOut(0)
    end
    Print("+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+ Calling DBC_AlwaysSetup function")
    Wait(0.10000000149011612)
    local MickeyLoc = GetPosition(GetPlayer())
    SetTransformation("MickeyPermissionIcon", vector4(MickeyLoc.x, (MickeyLoc.y + 2), MickeyLoc.z), vector4(0, 0, 0))
    SetParentEntity("MickeyPermissionIcon", GetPlayer())
    if (GetGlobal("DBC_Gus_GusSeesLedge_Played") == 1) then
      if (GetGlobal("DBC_Ortensia_Exit_Played") == 0) then
        FireUser1("TimerOswaldPrompt")
      end
    end
    if (GetGlobal("DBC_IntroMoviePlayed") == 0) then
      SetGlobal("DBC_IntroMoviePlayed", 1)
      SetCameraAttributesForPlayer("IntroHallwayCamera")
      PlayMovie(GetPlayer(), "PH_1_1_Intro_DBC.bik")
      GiveCollectibleNoPopup("Film_PH1_1")
      Quest_SetCriticalPath("Critical_DBC", "Critical_DBC_2")
      FireThread(DBC_Checkpoint_Save, nil, "entrance")
      Wait(0.10000000149011612)
      DBC_Checkpoint_Hallway()
      Wait(0.10000000149011612)
      StartFadeIn(0.800000011920929)
    end
    AudioSetState("dbc_courtyard_01a_audio.SND_Amb_DBC_main", "amb_DBC_state", "DBC_InsideCastleB")
    AudioPostEventOn("dbc_courtyard_01a_audio.SND_Amb_DBC_main", "Play_sfx_amb_DBC")
    AudioEffectStart("dbc_courtyard_01a_audio.SND_reverb")
    if (GetGlobal("DBC_Gus_SecondTower_Played") == 0) then
      RemovePhysicsFromWorld("FallenTowerSteps")
    end
  end
  if (MusicVar == 0) then
    if (GetGlobal("MusicState") == 0) then
      MusicVar = 1
      MusicPostEventOn(GetPlayer(), "Play_MX_DBC")
      Print("started DBC Music event from DBC_AlwaysSetup")
    end
  end
  return 
end
DBC_FirstJumpCameraTopOverride = function(target, enable)
  if (enable == "true") then
    SetCameraAttributesForPlayer("FirstJumpCameraTop", target)
  else
    ClearCameraAttributesForPlayer("FirstJumpCameraTop", target, 2)
  end
  return 
end
DBC_FirstJumpCameraOverride = function(target, enable)
  if (enable == "true") then
    SetCameraAttributesForPlayer("FirstJumpCamera", target)
  else
    ClearCameraAttributesForPlayer("FirstJumpCamera", target, 2)
  end
  return 
end
DBC_UnlockOswaldAbilities = function(ability)
  local remote = GetChildEntityByName(GetPlayer2OrAI(), "oswald_remote")
  if (ability == "initial") then
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
  elseif (ability == "remote") then
    UnhidePlayerTool(PLAYER_TWO)
    OswaldClearBoomerangTargets()
    UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "ElectricBlast")
    UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "ElectricStream")
    UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "CrossedStream")
  end
  return 
end
DBC_CurrentIcon = 0
DBC_ManageIcons = function(target, action, icon)
  if (action == "hide") then
    Hide(icon)
  elseif (action == "unhide") then
    Unhide(icon)
  end
  return 
end
DBC_PermissionIconCheck = 0
TutorialRun = 0
DBC_ManageIcons_BalconyPermission = function(target, action)
  if (action == "hide") then
    DBC_PermissionIconCheck = (DBC_PermissionIconCheck - 1)
  else
    DBC_PermissionIconCheck = (DBC_PermissionIconCheck + 1)
  end
  if (GetGlobal("DBC_Gus_GusSeesLedge_Played") == 1) then
    if (DBC_BalconyState == 0) then
      if (GetName(_activator()) == GetName(GetPlayer())) then
        DBC_ManageIcons(target, action, "MickeyPermissionIcon")
      elseif (GetName(_activator()) == GetName(GetPlayer2())) then
        DBC_ManageIcons(target, action, "OswaldPermissionIcon")
      end
    end
  end
  if (GetGlobal("DBC_Gus_GusSeesLedge2_Played") == 1) then
    if (action == "hide") then
      if (DBC_PermissionIconCheck < 2) then
        DismissTextBox()
      end
    elseif (action == "unhide") then
      if (DBC_PermissionIconCheck == 2) then
        if (DBC_BalconyState == 0) then
          if (GetNumPlayers() == 1) then
            FireSequence("ConversationMarkerTutorial", "Tutorial_TossTraining1P", 0)
          else
            FireSequence("ConversationMarkerTutorial", "Tutorial_TossTraining", 0)
            if (GetGlobal("Tutorial_CallForHelp2Training_Played") == 1) then
              if (action == "hide") then
                DismissTextBox()
              else
                FireSequence("ConversationMarkerTutorial", "Tutorial_CallForHelp2Training", 0)
              end
            end
          end
        end
      end
    end
  elseif (GetGlobal("Tutorial_CallForHelp2Training_Played") == 1) then
    if (action == "hide") then
      DismissTextBox()
    else
      FireSequence("ConversationMarkerTutorial", "Tutorial_CallForHelp2Training", 0)
    end
  end
  return 
end
DBC_SpawnIcons = function()
  local activator = _activator()
  Print("+_+_+_+_+_++_+_+_++_+_+_++_+ Oswald was just spawned!")
  if (DBC_CallForHelpTraining == 1) then
    DBC_CallForHelpTrainingManage("CallForHelpTrigger")
  end
  local (for index), (for limit), (for step) = 1, 8, 1
  for i = (for index), (for limit), (for step) do
    ForceSpawn(("OverheadIconSpawner" .. i), 1)
    Wait(0.10000000149011612)
    Print(("___________________________Spawning from OverheadIconSpawner" .. tostring(i)))
    local OswaldLoc = GetPosition(GetPlayer2OrAI())
    SetTransformation(("DBC_OswaldIconGroup" .. i), vector4(OswaldLoc.x, (OswaldLoc.y + 2), OswaldLoc.z), vector4(0, 0, 0))
    SetParentEntity(("DBC_OswaldIconGroup" .. i), GetPlayer2OrAI())
    if (DBC_CurrentIcon == i) then
      Unhide(("DBC_OswaldIconGroup" .. tostring(DBC_CurrentIcon)))
      Print(("___________________________Just unhid DBC_OswaldIconGroup" .. tostring(i)))
    end
    Wait(0.10000000149011612)
  end
  if (GetGlobal("DBC_TrainState") == 3) then
    if (activator == GetOswaldAI()) then
      DismissTextBox()
    end
  end
  if (DBC_CallForHelpTraining == 2) then
    if (activator == GetOswaldAI()) then
      Print("_____________________________Should be unhiding the permission icon now")
    end
  end
  return 
end
DBC_SetLocalVariable = function(target, variable, value)
  _G[variable] = tonumber(value)
  return 
end
DBC_ManageChestIcons = function(target, event, activator, icon)
  if (activator == GetPlayer()) then
    if StimulusEvent_HasStimulusType(event, ST_SPIN) then
      FireUser1(icon)
      if (icon == "BreakableIcon7") then
        Disable("BuddyActionTossChandelier")
      end
    end
  end
  return 
end
DBC_TurnOffChestIcon = function(target, event, activator, icon)
  FireUser3(icon)
  return 
end
DBC_TurnOnChestIcon = function(target, event, activator, icon)
  FireUser2(icon)
  return 
end
DBC_DestroyChestIcons = function()
  local (for index), (for limit), (for step) = 1, 9, 1
  for i = (for index), (for limit), (for step) do
    if IsValidHandle((("dbc_courtyard_01a_scripting.training_tutorialicon 0" .. i) .. ".ControllerIcon")) then
      DestroyEntity((("dbc_courtyard_01a_scripting.training_tutorialicon 0" .. i) .. ".ControllerIcon"))
    end
  end
  local (for index), (for limit), (for step) = 10, 23, 1
  for i = (for index), (for limit), (for step) do
    (for index) = IsValidHandle
    (for limit) = "dbc_courtyard_01a_scripting.training_tutorialicon "
    (for step) = i
    i = ".ControllerIcon"
    (for limit) = (((for limit) .. (for step)) .. i)
    (for index) = (for index)((for limit))
    if (for index) then
      (for index) = DestroyEntity
      (for limit) = "dbc_courtyard_01a_scripting.training_tutorialicon "
      (for step) = i
      i = ".ControllerIcon"
      (for limit) = (((for limit) .. (for step)) .. i)
      (for index)((for limit))
    end
  end
  return 
end
DBC_EarthquakeSFX = function()
  AudioPostEventOn(GetPlayer(), "Play_sfx_DBC_amb_Earthquake")
  Wait((0.5 + math.random()))
  AudioPostEventOn(GetPlayer(), "Play_sfx_DustFallingSml")
  return 
end
DBC_AmbientEarthquake = function()
  Rumble(nil, 0.30000001192092896)
  Rumble(nil, 0.30000001192092896, 1)
  ShakeCamera(1.2999999523162842, 7, 0.5, 0.4000000059604645, 0.009999999776482582, 0.0020000000949949026)
  DBC_EarthquakeSFX()
  return 
end
DBC_GetPlayerCheck = function()
  if (GetNumPlayers() == 1) then
    SetGlobal("EM2_NumberPlayers", 1)
  else
    SetGlobal("EM2_NumberPlayers", 2)
  end
  return 
end
DBC_MoveControllerCheck = function()
  Print(((("DBC_MoveControllerCheck P1 " .. tostring(IsPlayerMoveControlled(0))) .. " and P2 ") .. tostring(IsPlayerMoveControlled(1))))
  if (not IsPlayerMoveControlled(0)) then
  end
  SetGlobal("EM2_MoveControllerCheck", 2)
  if (GetNumPlayers() == 2) then
    if (not (not IsPlayerMoveControlled(0))) then
      return 
    end
  else
    SetGlobal("EM2_MoveControllerCheck", 0)
  end
  return 
end
MickeyInTrigger = 0
OswaldInTrigger = 0
DBC_Electric_2ndStageSwitch1Var = 0
DBC_Electric_2ndStageSwitch2Var = 0
DBC_MakeOswaldFollow = function()
  ClearNextPatrolNode(GetOswaldAI())
  Wait(0.10000000149011612)
  OswaldStartFollowAction()
  return 
end
DBC_MakeOswaldSpin = function()
  OswaldSpinAction()
  return 
end
DBC_TeleportOswaldToplayer = function()
  local PlayerPosi = GetPosition(GetPlayer())
  TeleportToEntity(GetOswaldAI(), PlayerPosi)
  OswaldStartFollowAction()
  return 
end
DBC_OswaldBalconyBegin = function()
  DBC_OswaldEnableBalconyJumps()
  return 
end
DBC_OswaldBalconyPathTrackerVar = 0
DBC_OswaldEnableBalconyJumps = function()
  enableJumpVolumeAvailability("DBC_OswaldBlockJump01")
  enableJumpVolumeAvailability("DBC_OswaldBalconyJump02")
  if (DBC_OswaldBalconyPathTrackerVar == 1) then
    enableJumpVolumeAvailability("DBC_OswaldBalconyJump03")
    enableJumpVolumeAvailability("DBC_OswaldBalconyJump04")
  elseif (DBC_OswaldBalconyPathTrackerVar == 2) then
    enableJumpVolumeAvailability("DBC_OswaldBalconyJump05")
    enableJumpVolumeAvailability("DBC_OswaldBalconyJump06")
  end
  return 
end
DBC_BalconyJumpsDisable = function()
  WaitForLevelLoad()
  disableJumpVolumeAvailability("DBC_OswaldBlockJump01")
  disableJumpVolumeAvailability("DBC_OswaldBalconyJump02")
  disableJumpVolumeAvailability("DBC_OswaldBalconyJump03")
  disableJumpVolumeAvailability("DBC_OswaldBalconyJump04")
  disableJumpVolumeAvailability("DBC_OswaldBalconyJump05")
  disableJumpVolumeAvailability("DBC_OswaldBalconyJump06")
  return 
end
DBC_MoveOrtensiaToTrain = function()
  MoveToEntity("DBC_2ndVisitOrtensia", "DBC_Ortensia1stTrainPosition")
  Wait(0.10000000149011612)
  DisableMotion("DBC_2ndVisitOrtensia")
  return 
end
DBC_StartOrtensiaWalking = function()
  SetNextPatrolNode("DBC_Ortensia", "DBC_OrtensiaPatrol01")
  return 
end
DBC_Make1stPitCollapse = function()
  ForEachEntityInGroup(AnimGBSequence, "DBC_Pit1_FloorItems", "fall")
  Rumble(nil, 0.800000011920929)
  Rumble(nil, 0.800000011920929, 1)
  ShakeCamera(1.2000000476837158, 4.199999809265137, 0.800000011920929, 0.75, 0.03099999949336052, 0.03099999949336052)
  AnimGBSequence("DBC_HallDoorLeftNew", "fall")
  AnimGBSequence("DBC_HallDoorRightNew", "fall")
  DoStinger("DBC_Stinger_1stFloor", 2)
  Print("Music DBC_Make1stPitCollapse")
  ActivateGremlinHint("GusHintHallway1")
  return 
end
DBC_GlideTutorial = function(target, action)
  Print("__________________________________________DBC_GlideTutorial function fired")
  if (action == "hint") then
    Print("_________________________________Disabling first guardian hint")
    DisableGuardianHint("GusHintHallway1")
    DBC_RunsAwayIGC()
  end
  return 
end
DBC_FirstPitConvo = function()
  FireSequence("DBC_GusConversationTrigger", "DBC_Gus_FirstPit", 0)
  return 
end
DBC_MoveOrtensiaToLaunch = function()
  Print("###### Move Ortensia To Launch")
  FireSequence("ConversationMarkerOrtensia", "DBC_Ortensia_Taunts")
  SetNextPatrolNode("DBC_Ortensia", "DBC_OrtensiaNodeAfterFirstPit")
  return 
end
DBC_RunsAwayIGC = function()
  SetNextPatrolNode("DBC_Ortensia", "DBC_HideOrtensia")
  FireSequence("ConversationMarkerOrtensia", "DBC_Ortensia_Taunts", 0)
  DBC_AmbientEarthquake()
  return 
end
DBC_FireRunAway2Seq = function()
  FireSequence("DBC_OswaldConvoTrigger", "DBC_Oswald_OrtensiaRunsAway02", 0)
  MoveToEntity(GetPlayer(), "DBC_MickeyPostOrtensiaMarker")
  return 
end
DBC_MoveOrtensiaDownHallway = function()
  ClearNextPatrolNode("DBC_Ortensia")
  TeleportToEntity("DBC_Ortensia", "DBC_OrtensiaHallEscape")
  return 
end
DBC_TowerFallVar = 0
DBC_MakeTowerFall = function(target)
  if (DBC_TowerFallVar == 0) then
    DBC_TowerFallVar = 1
    Rumble(nil, 0.6000000238418579)
    Rumble(nil, 0.6000000238418579, 1)
    ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
    DestroyEntity("DBC_Ortensia")
    AnimGBSequence("DBC_NewBalcony", "fall")
    SetPropertyBool("DBC_NewBalcony", "Start Active", true)
    Print("Music DBC_MakeTowerFall")
    wait(1.2000000476837158)
    ActivateGremlinHint("GusHintHallway2")
    ForEachEntityInGroup(Enable, "BalconyCollapseTriggerGroup")
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_GusSeesLedge", 0)
  end
  return 
end
DBC_GusSeesLedgeCamEnd = function()
  FireUser3("DBC_PostOrtensiaLedgeCam")
  Wait(0.800000011920929)
  MoveToEntity(GetPlayer(), "DBC_MickeyPostOrtensiaMarker")
  return 
end
DBC_OrtensiaHallEscapeMove = function()
  MoveToEntity("DBC_Ortensia", "DBC_OrtensiaHallEscape")
  Wait(0.10000000149011612)
  SetNextPatrolNode("DBC_Ortensia", "DBC_OrtensiaEscape02")
  return 
end
DBC_OswaldFirstPitJump = function()
  FireUser1("DBC_OswaldFirstPitIntro")
  Wait(0.800000011920929)
  MoveToEntity(GetOswaldAI(), "DBC_OswaldFirstPitStart")
  return 
end
DBC_OswaldJumpFirstPit = function()
  OswaldAddGlideTargetAction("DBC_OswaldFirstPitDestination")
  OswaldGlideAction("DBC_OswaldFirstPitDestination")
  Wait(4)
  DBC_OswaldWait01()
  return 
end
DBC_OswaldJumpIntoPit = function()
  OswaldJumpNoFollowAction("DBC_InsidePitNode")
  Wait(4)
  OswaldSetPathAction("DBC_InsidePitNode")
  return 
end
DBC_OswaldWait01 = function()
  OswaldSetPathAction("DBC_OswaldWaitAfterFirstPit")
  return 
end
DBC_FirstPitIGC_End = function()
  FireUser3("DBC_OswaldFirstPitJump")
  Wait(0.800000011920929)
  Enable("DBC_FirstPitLookHintTrigger")
  MoveToEntity(GetOswaldAI(), "DBC_OswaldFirstPitWaitingMarker")
  return 
end
DBC_FirstPitFellChat = function()
  FireSequence("DBC_GusConversationTrigger", "DBC_Gus_FirstPitFell", 0)
  return 
end
DBC_BalconyDoorGear01 = 0
DBC_BalconyDoorGear02 = 0
DBC_BalconyDoorManage = function(target, action, node1, node2)
  local activator = GetName(_activator())
  if (action == "approach") then
    FireSequence("dbc_courtyard_01a_shared.ConversationalTrigger 01", "DBC_Gus_SpinBothGears", 0)
    Wait(0.800000011920929)
    Disable("BuddyActionGearSpin")
  elseif (action == "enter") then
    if (activator == GetName(GetPlayer())) then
      Enable(node1)
      Disable(node2)
    end
  elseif (action ~= "exit") then
    if (action == "spin") then
      OswaldSpinAction(node1)
      OswaldStopMovingAction()
    end
  end
  return 
end
DBC_BalconyDoorMaster = function(target, variable, gear)
  SetVulnerability(target, ST_SPIN, 0)
  SetRotatorMaxSpeed(target, 300)
  _G[variable] = 1
  Print(("DBC_BalconyDoorMaster: DBC_BalconyDoorGear01 = " .. tostring(DBC_BalconyDoorGear01)))
  Print(("DBC_BalconyDoorMaster: DBC_BalconyDoorGear02 = " .. tostring(DBC_BalconyDoorGear02)))
  Wait(0.5)
  if (DBC_BalconyDoorGear01 == 1) then
    if (DBC_BalconyDoorGear02 == 1) then
      SetGlobal("DBC_BalconyDoor", 1)
      DBC_UnderhallDelay = 1
      ForEachEntityInGroup(Disable, "BuddyActionBalconyGearGroup")
      OswaldStartMovingAction()
      SetRotatorMaxSpeed("DBC_BalconyDoorRight", 60)
      StartRotateToPosition("DBC_BalconyDoorRight", 270)
      SetRotatorMaxSpeed("DBC_BalconyDoorLeft", 60)
      StartRotateToPosition("DBC_BalconyDoorLeft", -270)
      Disable("DBC_BalconyGearTrigger01")
      Disable("DBC_BalconyGearTrigger02")
      Disable("HallwayGearCameraTrigger")
      Disable("CollapsedBalconyLongShot")
      Enable("FloorCollapseTrigger")
      FireUser1("BreakableIcon11")
      FireUser1("BreakableIcon12")
      InterruptCurrentSequence()
      OswaldStartFollowAction()
      SetMapMarkerVisible("MapMarkerRemote", true)
    end
  end
  Wait(0.5)
  DBC_BalconyDoorGear01 = 0
  DBC_BalconyDoorGear02 = 0
  SetRotatorMaxSpeed(target, 0)
  SetVulnerability(target, ST_SPIN, 1)
  return 
end
DBC_BalconyGearEncourage = function(target)
  if (_activator() == _player()) then
    MickeyInTrigger = 1
  else
    OswaldInTrigger = 1
  end
  if (_activator() == GetOswaldAI()) then
    OswaldInTrigger = 1
  end
  if (MickeyInTrigger == 1) then
    if (OswaldInTrigger == 1) then
      FireSequence("DBC_GusConversationTrigger", "DBC_Gus_SpinBothGears", 0)
    end
  end
  return 
end
DBC_ReviveDisabled = 0
DBC_DisablePlayerRevive = function(target, action, location)
  local activator = GetName(_activator())
  if (location == "balcony") then
    if (activator == GetName(GetPlayer2OrAI())) then
      if (action == "enter") then
        SetPlayerUnrevivable(GetPlayer2OrAI())
      elseif (action == "exit") then
        SetPlayerRevivable(GetPlayer2OrAI())
        if (activator == GetName(GetPlayer())) then
          if (DBC_ReviveDisabled == 0) then
            DBC_ReviveDisabled = 1
            SetPlayerUnrevivable(GetPlayer())
          end
        end
      end
    end
  elseif (activator == GetName(GetPlayer())) then
    if (DBC_ReviveDisabled == 0) then
      DBC_ReviveDisabled = 1
      SetPlayerUnrevivable(GetPlayer())
    end
  end
  return 
end
DBC_GusRepeatIntersectionStart = function()
  TimerEnable("DBC_IntersectionTimer")
  SetNextPatrolNode("DBC_Ortensia", "DBC_OrtensiaEscape02")
  AnimGBSequence("HallwayDebris_Small", "fall")
  SetPropertyBool("HallwayDebris_Small", "Start Active", true)
  AnimGBSequence("HallwayDebris_Large", "fall")
  SetPropertyBool("HallwayDebris_Large", "Start Active", true)
  wait(0.10000000149011612)
  SetCameraAttributesForPlayer("HallwayCollapseOrtensiaCameraOverride", _activator())
  wait(2)
  ClearCameraAttributesForPlayer("HallwayCollapseOrtensiaCameraOverride", _activator(), 2)
  Rumble(nil, 0.6000000238418579)
  Rumble(nil, 0.6000000238418579, 1)
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  StartEmitters("CollapsingHallDust01")
  wait(2)
  FireSequence("DBC_OswaldConvoTrigger", "DBC_Oswald_OrtensiaRunsAway02", 0)
  Wait(6)
  StopEmitters("CollapsingHallDust01")
  SetPropertyBool("CollapsingBalconyLookatTrigger", "Look At Trigger Enabled", true)
  return 
end
DBC_CollapsingBalconyIGC = function(target, step)
  if (step == "one") then
    Print("Disabled glide tutorial")
    SetGlobal("DBC_GlideTutorialCheck", 2)
    StartFadeOut(0.800000011920929)
    Wait(0.4000000059604645)
    RestrictCutSceneInput()
    Wait(0.5)
    OswaldAbortScriptedBehavior()
    OswaldStopMovingAction()
    DBC_ManageIcons(nil, "hide", "DBC_OverheadIconDoubleJump")
    DBC_CurrentIcon = 0
    Wait(0.20000000298023224)
    TeleportToEntity(GetPlayer(), "BalconyCollapseMickeyMarker")
    TeleportToEntity(GetPlayer2OrAI(), "BalconyCollapseOswaldMarker")
    TeleportToEntity("DBC_Ortensia", "BalconyCollapseIGCNode")
    SetNextPatrolNode("DBC_Ortensia", "BalconyCollapseIGCNode")
    FireUser1("BalconyCollapseIGC1")
    DoStinger("DBC_Stinger_Hallway", 2)
    Wait(0.5)
    FireThread(DBC_CollapsingBalconyIGC, "nothing", "two")
    Wait(0.5)
    SetNextPatrolNode("DBC_Ortensia", "DBC_OrtensiaEscape02")
    FireSequence("DBC_OswaldConvoTrigger", "DBC_Oswald_OrtensiaRunsAway02", 0)
  elseif (step == "two") then
    ForEachEntityInGroup(AnimGBSequence, "HallwayDebrisGroup", "fall")
    ForEachEntityInGroup(SetPropertyBool, "HallwayDebrisGroup", "Start Active", true)
    Wait(3)
    Rumble(nil, 0.6000000238418579)
    Rumble(nil, 0.6000000238418579, 1)
    ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
    StartEmitters("CollapsingHallDust01")
    Wait(1)
    AudioPostEventOn("dbc_courtyard_01a_audio.SND_Hallway_Collapse", "Play_sfx_DBC_FallingRock_Impact")
    Wait(0.5)
    StopEmitters("CollapsingHallDust01")
    AudioPostEventOn("dbc_courtyard_01a_audio.SND_Hallway_Collapse", "Play_sfx_DBC_FallingRock_Debris")
  elseif (step == "three") then
    Wait(1)
    Enable("BuddyActionCallForHelp")
    Wait(7)
    StopEmitters("CollapsingHallDust01")
  elseif (step == "four") then
    Rumble(nil, 0.4000000059604645)
    Rumble(nil, 0.4000000059604645, 1)
    FireUser1("BalconyCollapseIGC2")
    Wait(0.5)
    FireThread(DBC_MakeTowerFall)
  elseif (step == "five") then
    FireUser3("BalconyCollapseIGC2")
    Wait(0.800000011920929)
    if (GetNumPlayers() == 1) then
      TeleportToEntity(GetPlayer(), "BalconyCollapseOswaldMarker2")
    else
      TeleportToEntity(GetPlayer(), "BalconyCollapseMickeyMarker2")
      TeleportToEntity(GetPlayer2OrAI(), "BalconyCollapseOswaldMarker2")
    end
    Wait(0.10000000149011612)
    Quest_SetCriticalPath("Critical_DBC", "Critical_DBC_8b")
    UnrestrictCutSceneInput()
    OswaldStartMovingAction()
    ResetDefaultCameraValues()
    ResetTravelCameraValues()
    TimerEnable("DBC_IntersectionTimer")
    if (GetNumPlayers() == 1) then
      Enable("CallForHelpTrigger")
      DBC_CallForHelpTraining = 1
      Wait(0.4000000059604645)
      DBC_ManageIcons("nothing", "unhide", "MickeyPermissionIcon")
      Enable("CallForHelpCameraTrigger")
      FireSequence("ConversationMarkerTutorial", "Tutorial_CallForHelp2Training", 0)
    else
      DBC_CallForHelpTraining = 2
      Wait(0.4000000059604645)
      Disable("BuddyActionCallForHelp")
      Enable("BuddyActionTossTraining")
      Enable("CollapsedBalconyLongShot")
      FireSequence("DBC_GusConversationTrigger", "DBC_Gus_GusSeesLedge2", 0)
    end
    Wait(0.4000000059604645)
  end
  return 
end
DBC_CallForHelpTraining = 0
DBC_CallForHelpTrainingManage = function(target)
  DBC_CallForHelpTraining = 2
  Disable(target)
  Disable("BuddyActionCallForHelp")
  Enable("BuddyActionTossTraining")
  Disable("CallForHelpCameraTrigger")
  Enable("CollapsedBalconyLongShot")
  FireSequence("DBC_GusConversationTrigger", "DBC_Gus_GusSeesLedge2", 0)
  return 
end
DBC_GusRepeatIntersectionStop = function()
  DBC_HideControllerIcon()
  TimerDisable("DBC_IntersectionTimer")
  return 
end
DBC_GusRepeatIntersection = function()
  if (IsAnySequencePlaying() == false) then
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_HowToToss", 0)
  end
  return 
end
DBC_BalconyDoorOpener = function(target)
  if (_activator() == _player()) then
    MickeyInTrigger = 1
  else
    OswaldInTrigger = 1
  end
  if (_activator() == GetOswaldAI()) then
    OswaldInTrigger = 1
  end
  if (MickeyInTrigger == 1) then
    if (OswaldInTrigger == 1) then
      SetRotatorMaxSpeed("DBC_BalconyDoorRight", 60)
      StartRotateToPosition("DBC_BalconyDoorRight", 270)
      SetRotatorMaxSpeed("DBC_BalconyDoorLeft", 60)
      StartRotateToPosition("DBC_BalconyDoorLeft", -270)
    end
  end
  return 
end
DBC_Gear01Var = 0
DBC_Gear02Var = 0
DBC_IntersectionGear01Check = function()
  DBC_Gear01Var = 1
  OswaldSpinAction("DBC_Gear01Upper")
  DBC_IntersectionGearMaster()
  return 
end
DBC_IntersectionGear01Reset = function()
  DBC_Gear01Var = 0
  return 
end
DBC_IntersectionGear02Check = function()
  DBC_Gear02Var = 1
  OswaldSpinAction("DBC_Gear02Upper")
  DBC_IntersectionGearMaster()
  return 
end
DBC_IntersectionGear02Reset = function()
  DBC_Gear02Var = 0
  return 
end
DBC_IntersectionGearMaster = function()
  if (DBC_Gear01Var == 1) then
    if (DBC_Gear02Var == 1) then
      SetRotatorMaxSpeed("DBC_Gear02", 250)
      SetRotatorMaxSpeed("DBC_Gear01", 250)
      SetRotatorMaxSpeed("DBC_Gear03Inert", 250)
      DBC_LedgeAccessCamStart()
      DBC_MoveChandelier()
      DBC_OswaldBalconyPathTrackerVar = 2
      Wait(3)
      SetRotatorMaxSpeed("DBC_Gear02", 0)
      SetRotatorMaxSpeed("DBC_Gear01", 0)
      SetRotatorMaxSpeed("DBC_Gear03Inert", 0)
    end
  end
  return 
end
DBC_LedgeAccessCamStart = function()
  Enable("DBC_FirstHallPaintChoiceTrigger")
  Unhide("DBC_FirstHallPaintDecal")
  return 
end
DBC_GusSeesLedgeCamEnd = function()
  FireUser3("DBC_CoopTutorialCam")
  return 
end
DBC_OrtensiaKeepsRunning = function()
  FireSequence("ConversationMarkerOrtensia", "DBC_Ortensia_Taunts", 0)
  return 
end
DBC_OrtensiaRunsMore = function()
  SetNextPatrolNode("DBC_Ortensia", "DBC_FinalPathforOrtensia")
  FireUser1("DBC_OrtensiaRunsAwayCam02")
  return 
end
DBC_OrtensiaEscapes = function()
  FireUser1("DBC_OrtensiaRunsAwayCam03")
  return 
end
DBC_BalconyState = 0
DBC_BalconyCollapse = function()
  DBC_BalconyState = 1
  DBC_CallForHelpTraining = 3
  DBC_ManageIcons(nil, "hide", "MickeyPermissionIcon")
  DBC_ManageIcons(nil, "hide", "OswaldPermissionIcon")
  DBC_CurrentIcon = 0
  Quest_SetCriticalPath("Critical_DBC", "Critical_DBC_1")
  ForEachEntityInGroup(DestroyEntity, "BalconyCollapseTriggerGroup")
  DisableGuardianHint("GusHintHallway2")
  AnimGBSequence("DBC_NewBalcony", "fall2")
  enableJumpVolumeAvailability("dbc_hallway_01a_art.prefab_jumpvolumeavailability 01.TargetToSend")
  enableJumpVolumeAvailability("dbc_hallway_01a_art.prefab_jumpvolumeavailability 02.TargetToSend")
  enableJumpVolumeAvailability("dbc_hallway_01a_art.prefab_jumpvolumeavailability 03.TargetToSend")
  FireSequence("DBC_GusConversationTrigger", "DBC_Gus_BalconyBreak", 0)
  TimerDisable("DBC_IntersectionTimer")
  DestroyEntity("HallwayScriptedGlideTrigger")
  ClearNextPatrolNode(GetOswaldAI())
  Wait(0.10000000149011612)
  DBC_OswaldEnableBalconyJumps()
  Wait(0.800000011920929)
  Enable("BuddyActionGearSpin")
  Wait(0.5)
  Enable("BuddyActionTossChandelier")
  FireUser1("TimerOswaldPrompt")
  return 
end
DBC_OswaldGotoLaunch02 = function()
  OswaldSetPathAction("DBC_OswaldLaunchNode02")
  return 
end
DBC_UnderEnemySpawn = function()
  Enable("DBC_UnderSpatterSpawner")
  return 
end
DBC_FellDownSecondPitGusSeesRemote = function()
  FireSequence("DBC_GusConversationTrigger", "DBC_Gus_EncourageOswaldRemote", 0)
  Wait(0.5)
  OswaldSetPathAction("DBC_OswaldRemotePatrolNode")
  return 
end
DBC_MakePitFall = function()
  FireSequence("DBC_GusConversationTrigger", "DBC_Gus_RumblingCam", 0)
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  StartEmitters("UndercroftHallwayDust")
  ForEachEntityInGroup(AnimGBSequence, "DBC_Pit2_FloorItems", "fall", true)
  DoStinger("DBC_Stinger_Lab", 2)
  Print("Music DBC_MakePitFall")
  return 
end
DBC_RubbleDoorTracker = 0
DBC_RubbleDoorOpen = function(target, event)
  if (DBC_RubbleDoorTracker == 0) then
    if StimulusEvent_HasStimulusType(event, ST_PHYSICAL) then
      DBC_RubbleDoorTracker = 1
      AnimGBSequence("DBC_RubbleDoor", "fall")
      SetPropertyBool("DBC_RubbleDoor", "Start Active", true)
      StartEmitters("UnderhallRubbleSplashFX")
      enableJumpVolumeAvailability("DBC_UnderhallOswaldJump01")
      Wait(2)
      DBC_MakeOswaldJumpToElectrical()
    end
  end
  return 
end
DBC_RemoteDescription = 0
DBC_Underhall_RemoteDescriptionCheck = function()
  if (GetGlobal("DBC_RemoteStandState") == 0) then
    if (DBC_RemoteDescription == 0) then
      if (GetName(_activator()) == GetName(GetPlayer())) then
        DBC_RemoteDescription = 1
        SetPropertyFloat("OswaldRemoteStandSwitch", "Target Value", 0)
        ActivateGremlinHint("GusHintUnderhall1")
        FireSequence("dbc_courtyard_01a_shared.ConversationalTrigger 01", "DBC_Gus_Boomerang01", 0)
      end
    end
  end
  return 
end
DBC_OswaldBoomerangTutorial = function(step)
  OswaldStopMovingAction()
  if (step == "one") then
    Wait(0.800000011920929)
    QueueThought(GetPlayer2OrAI(), "OswaldBoomarmarangThoughtBubble_Small")
    Wait(0.75)
    OswaldAddBoomerangTarget("OswaldRemoteStandSwitch")
    Wait(0.75)
    ClearThought(GetPlayer2OrAI())
    DBC_CurrentIcon = 2
    Wait(0.75)
    OswaldBoomerangAction()
    DBC_CurrentIcon = 0
    Wait(1)
  elseif (step == "two") then
    Wait(0.10000000149011612)
    QueueThought(GetPlayer2OrAI(), "OswaldBoomarmarangThoughtBubble_Small")
    Wait(0.75)
    OswaldAddBoomerangTarget("OswaldRemote")
    Wait(0.75)
    ClearThought(GetPlayer2OrAI())
    DBC_CurrentIcon = 2
    Wait(0.75)
    OswaldBoomerangAction()
    DBC_CurrentIcon = 0
  end
  return 
end
DBC_Underhall_CollectRemote = function()
  DisableGuardianHint("GusHintUnderhall3")
  DestroyEntity("OswaldRemoteCorona")
  SetMapMarkerVisible("MapMarkerRemote", false)
  OswaldStartFollowAction()
  OswaldStartMovingAction()
  DBC_UnlockOswaldAbilities("remote")
  SetPlayerRevivable(GetPlayer())
  ForEachEntityInGroup(Disable, "BuddyActionBoomerangTrainingGroup2")
  AnimGBSequence("OswaldRemoteStand", "restLowered")
  FireUser2("TimerBoomerang")
  DoStinger("DBC_Stinger_FindRemote", 2)
  DBC_CurrentIcon = 0
  DBC_ManageIcons(nil, "hide", "DBC_OswaldIconGroup2")
  return 
end
DBC_Underhall_LabStreamCheck = function()
  if (LevelManager_GetCurrentState() == "darkbeautycastle_v1.stream_2") then
    if (LevelManager_HasZoneFinishedStreaming("DarkBeautyCastle_V1.DBC_ElectricalRoom") == false) then
      while true do
        if (not (LevelManager_HasStateFinishedStreaming() == false)) then
          break
        end
        Wait(0.20000000298023224)
      end
    end
    while true do
      if (not (LevelManager_WaitingForStreamingSync() == false)) then
        break
      end
      Wait(0.05000000074505806)
    end
    DBC_UnderhallRevealExitIGC("one")
  end
  return 
end
DBC_UnderhallRevealExitIGC = function(step)
  if (step == "one") then
    StartScriptedIGC()
    RestrictCutSceneInput()
    OswaldAbortScriptedBehavior()
    OswaldStopMovingAction()
    Rumble(nil, 0.699999988079071)
    Rumble(nil, 0.699999988079071, 1)
    ShakeCamera(1.2999999523162842, 7, 0.5, 0.4000000059604645, 0.009999999776482582, 0.0020000000949949026)
    StartFadeOut(0.800000011920929)
    Wait(0.8999999761581421)
    TeleportToEntity(GetPlayer(), "RevealExitMarkerMickey")
    TeleportToEntity(GetPlayer2OrAI(), "RevealExitMarkerOswald")
    GrabCamera("UnderhallRevealExitCamera", nil, CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
    GrabCamera("UnderhallRevealExitCamera", nil, CAMERA_INSTANT_TRANSITION, 0, GetPlayer2OrAI())
    EnableSplitScreen(false)
    StartFadeIn(0.800000011920929)
    DBC_ExitUnderhall("sequence")
  elseif (step == "two") then
    StartFadeOut(0.800000011920929)
    Wait(0.800000011920929)
    ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
    ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetPlayer2OrAI())
    EnableSplitScreen(true)
    Wait(0.10000000149011612)
    CameraReset()
    OswaldStartMovingAction()
    Wait(0.10000000149011612)
    StartFadeIn(0.800000011920929)
    Quest_SetCriticalPath("Critical_DBC", "Critical_DBC_4")
    UnrestrictCutSceneInput()
    ActivateGremlinHint("GusHintUnderhall2")
    DBC_Checkpoint_Save("nothing", "underhall")
  end
  return 
end
DBC_ExitUnderhall = function(action)
  Rumble(nil, 0.699999988079071)
  Rumble(nil, 0.699999988079071, 1)
  ShakeCamera(1.2999999523162842, 7, 0.5, 0.4000000059604645, 0.009999999776482582, 0.0020000000949949026)
  DBC_EarthquakeSFX()
  SetSplineFollowerInitialSpeed("DBC_ElevatorPlatform", 100)
  SplineFollower_StopAtPosition("DBC_ElevatorPlatform", "DBC_ElectricalElevatorKnot01", "DBC_ElectricalElevatorKnot02", 1)
  if (action == "sequence") then
    AnimGBSequence("DBC_RubbleDoor", "fall", true)
    SetPropertyBool("DBC_RubbleDoor", "Start Active", true)
    StartEmitters("UnderhallRubbleSplashFX")
    Wait(1.399999976158142)
    Unhide("UnderhallBronzePin")
    Wait(0.6000000238418579)
    FireSequence("DBC_GusConversationTrigger", "DBC_Oswald_UnderhallCollapse", 0)
  else
    DBC_LoadCheckpoint()
    DBC_UnderhallStreamed = 1
    ForEachEntityInGroup(DestroyEntity, "DBC_Pit2_FloorItems")
    if (GetGlobal("DBC_Oswald_GrabbedRemote_Played") == 0) then
      OswaldStopMovingAction()
      Wait(1)
      SetPlayerUnrevivable(GetPlayer())
    elseif IsValidHandle("UnderhallBronzePin") then
      Unhide("UnderhallBronzePin")
    end
    if (GetGlobal("DBC_Oswald_UnderhallCollapse_Played") == 1) then
      ActivateGremlinHint("GusHintUnderhall2")
    end
  end
  enableJumpVolumeAvailability("dbc_intersection_01a_art.prefab_jumpvolumeavailability 01.TargetToSend")
  Disable("BeamTutorialTrigger1")
  return 
end
DBC_MakeOswaldJumpToElectrical = function()
  OswaldSetPathAction("DBC_OswaldJumpElectricalMarker")
  return 
end
DBC_OswaldElectricalJumpAction = function()
  DBC_HideIcon_Z()
  OswaldJumpNoFollowAction("DBC_OswaldGetIntoElectrical")
  Wait(5)
  OswaldSetPathAction("DBC_OswaldElevatorSwitchNode")
  return 
end
DBC_UnderhallDelay = 0
DBC_OswaldJumpIntoUnderhall = function()
  if (GetGlobal("DBC_Gus_DescribeUnderhall_Played") == 0) then
    if (GetGlobal("DBC_Oswald_UnderhallCollapse_Played") == 0) then
      if (DBC_UnderhallDelay == 0) then
        Wait(1.600000023841858)
      end
      FireSequence("DBC_GusConversationTrigger", "DBC_Gus_DescribeUnderhall", 0)
      Wait(2)
      FireUser1("TimerBoomerang")
      SetCameraAttributesForPlayer("UnderhallRemoteCamera")
    end
  end
  return 
end
MickeyInTrigger_Under = 0
OswaldInTrigger_Under = 0
DBC_UnderhallStreamed = 0
DBC_UnderhallStream_OswaldCheck = function()
  Print("Underhall Oswald Trigger hit")
  OswaldInTrigger_Under = 1
  DBC_UnderhallStream_Master()
  return 
end
DBC_UnderhallStream_MickeyCheck = function(target)
  Print("Underhall Mickey Trigger hit")
  if (target == GetPlayer()) then
    MickeyInTrigger_Under = 1
    DBC_UnderhallStream_Master()
  elseif (target == GetPlayer2()) then
    OswaldInTrigger_Under = 1
    DBC_UnderhallStream_Master()
  end
  return 
end
DBC_Underhall_StreamCheck = function(target, direction)
  if (LevelManager_GetCurrentState() ~= "darkbeautycastle_v1.stream_2") then
    if (GetName(_activator()) == GetName(GetPlayer())) then
      Print("+_+_+_+_+_+_+_+_+_+_+_+ Mickey hit stream trigger")
      if (direction == "forward") then
        OverrideSpawnTransform(PLAYER_ONE, GetPosition("UnderhallSpawnOverrideMickey"), GetFacing("UnderhallSpawnOverrideMickey"))
        MickeyInTrigger_Under = 1
        DBC_UnderhallStream_Master()
      elseif (direction == "back") then
        MickeyInTrigger_Under = 0
        if (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
          Print("+_+_+_+_+_+_+_+_+_+_+_+ Oswald hit stream trigger")
          if (direction == "forward") then
            OverrideSpawnTransform(PLAYER_TWO, GetPosition("UnderhallSpawnOverrideOswald"), GetFacing("UnderhallSpawnOverrideOswald"))
            OswaldInTrigger_Under = 1
            DBC_UnderhallStream_Master()
          elseif (direction == "back") then
            OswaldInTrigger_Under = 0
          end
        end
      end
    elseif (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
      Print("+_+_+_+_+_+_+_+_+_+_+_+ Oswald hit stream trigger")
      if (direction == "forward") then
        OverrideSpawnTransform(PLAYER_TWO, GetPosition("UnderhallSpawnOverrideOswald"), GetFacing("UnderhallSpawnOverrideOswald"))
        OswaldInTrigger_Under = 1
        DBC_UnderhallStream_Master()
      elseif (direction == "back") then
        OswaldInTrigger_Under = 0
      end
    end
  end
  return 
end
DBC_UnderhallStream_Master = function()
  if (MickeyInTrigger_Under == 1) then
    if (OswaldInTrigger_Under == 1) then
      if (DBC_UnderhallStreamed == 0) then
        Print("Underhall Master Trigger hit")
        DBC_UnderhallStreamed = 1
        ClearOverrideSpawnTransform(PLAYER_ONE)
        ClearOverrideSpawnTransform(PLAYER_TWO)
        SetRotatorMaxSpeed("DBC_BalconyDoorRight", 340)
        StartRotateToPosition("DBC_BalconyDoorRight", 0)
        SetRotatorMaxSpeed("DBC_BalconyDoorLeft", 340)
        StartRotateToPosition("DBC_BalconyDoorLeft", 0)
        ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
        Wait(1.2000000476837158)
        LevelManager_SetCurrentState("DarkBeautyCastle_V1.Stream_2")
        DBC_Checkpoint_Save(nil, "underhall")
        Wait(0.20000000298023224)
        if (GetGlobal("DBC_Oswald_GrabbedRemote_Played") == 1) then
          if (GetGlobal("DBC_Oswald_UnderhallCollapse_Played") == 0) then
            DBC_Underhall_LabStreamCheck()
          end
        end
      end
    end
  end
  return 
end
DBC_RemoteSwitchState = 0
DBC_ActivateRemoteStand = function(target, action, event)
  if (GetGlobal("DBC_RemoteStandState") == 0) then
    SetGlobal("DBC_RemoteStandState", 1)
    ForEachEntityInGroup(Disable, "BuddyActionBoomerangTrainingGroup1")
    Enable("BuddyActionBoomerangTraining2a")
    DisableGuardianHint("GusHintUnderhall1")
    FireUser2("RepeatingHintPaintSwitch")
    ForceInterruptSequence("dbc_courtyard_01a_shared.ConversationalTrigger 01", "DBC_Gus_Boomerang01")
    Wait(0.800000011920929)
    AnimGBSequence("OswaldRemoteStandSwitch", "fall", true)
    SetPropertyBool("OswaldRemoteStandSwitch", "Start Active", true)
    AudioPostEventOn("dbc_intersection_01a_art.Underhall_RemoteStandSwitch 01", "Play_sfx_SwitchGeneric")
    Wait(1)
    Unhide("RemoteStandElectricity")
    AnimGBSequence("OswaldRemoteStand", "spin")
    SetPropertyBool("OswaldRemoteStand", "Start Active", true)
    AudioPostEventOn("dbc_courtyard_01a_audio.SND_Remote_Stand", "Play_sfx_DBC_remote_stand_start")
    Wait(2)
    AnimGBSequence("OswaldRemoteStand", "lower", true)
    EnableComponent("OswaldRemote", "Pickup Component")
    Quest_SetCriticalPath("Critical_DBC", "Critical_DBC_3")
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_Boomerang02", 0)
    Wait(0.4000000059604645)
    ActivateGremlinHint("GusHintUnderhall3")
    local (for index), (for limit), (for step) = 1, 5, 1
    for i = (for index), (for limit), (for step) do
      DBC_ActivateUnderhallMachines(tostring(i))
      Wait(0.6000000238418579)
    end
  end
  return 
end
DBC_ActivateUnderhallMachines = function(machine)
  AnimGBSequence(("UnderhallMachine0" .. tostring(machine)), "active")
  SetPropertyBool(("UnderhallMachine0" .. tostring(machine)), "Start Active", true)
  if (machine == "1") then
    AudioPostEventOn("dbc_courtyard_01a_audio.SND_events_PowerOn_Mach01", "Play_sfx_LabMachine2")
  elseif (machine == "2") then
    AudioPostEventOn("dbc_courtyard_01a_audio.SND_events_PowerOn_UM_02", "Play_sfx_LabMachine2")
  elseif (machine == "3") then
    AudioPostEventOn("dbc_courtyard_01a_audio.SND_events_PowerOn_Mach03", "Play_sfx_LabMachine_Bubbler")
  elseif (machine == "4") then
    AudioPostEventOn("dbc_courtyard_01a_audio.SND_events_PowerOn_UM_01", "Play_sfx_LabMachine3")
  elseif (machine == "5") then
    AudioPostEventOn("dbc_courtyard_01a_audio.SND_events_PowerOn_Mach02", "Play_sfx_LabMachine_Bubbler")
  end
  return 
end
DBC_OswaldGetsRemote_UnderhallNode = function()
  DestroyEntity("DBC_OswaldRemoteStandIn")
  FireSequence("DBC_GusConversationTrigger", "DBC_Gus_OswaldGotRemote", 0)
  return 
end
DBC_RemoteStandInteract = function(target, action)
  if (action == "trigger") then
    if (_activator() == _player2()) then
      SetPropertyFloat(target, "UsableRadius", 2)
    end
  elseif (action == "lower") then
    if (_activator() == GetPlayer2OrAI()) then
      DestroyEntity("Underhall_RemoteStandTrigger 01")
      AnimGBSequence("OswaldRemoteStand", "lower", true)
    end
  elseif (action == "remote") then
    if (GetNumPlayers() == 1) then
      DBC_OswaldGetsRemote_UnderhallNode()
    else
      SetPropertyFloat("OswaldRemote", "UsableRadius", 3)
    end
  end
  return 
end
DBC_OswaldGotRemoteVar = 0
DBC_OswaldGotRemoteIGC = function()
  Print("######## Oswald Walked to his Remote")
  return 
end
DBC_DisableOswald = function(buddy, sequence)
  Disable(buddy)
  OswaldStopMovingAction()
  if (sequence ~= "nothing") then
    FireSequence("dbc_courtyard_01a_shared.ConversationalTrigger 01", sequence, 0)
  end
  return 
end
DBC_RemoteControlTraining = function(buddy1, buddy2, trigger)
  if (trigger == "lookat") then
    buddy1 = "1"
  end
  Disable(("BuddyActionBeamTraining" .. tostring(buddy1)))
  Enable(("BuddyActionBeamTraining" .. tostring(buddy2)))
  return 
end
DBC_ExitMachineStage01 = function()
  ForEachEntityInGroup(StartEmitters, "DBC_DestructMachineFX")
  FireSequence("DBC_GusConversationTrigger", "DBC_Gus_MachineBreakWarn", 0)
  return 
end
DBC_LastMachineVar = 0
DBC_ExitMachineStage02 = function()
  if (DBC_ElectricalMachineTracker < 2) then
    DBC_LastMachineVar = 1
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_MachineBroken", 0)
  elseif (2 <= DBC_ElectricalMachineTracker) then
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_LookOut", 0)
    Wait(1)
    ForEachEntityInGroup(DestroyEntity, "DBC_DestructMachineALL")
    Unhide("ThinDeepPin")
    DestroyEntity("DBC_Electrical_TopSparks03")
    StartEmitters("DBC_LastMachineExplodeFX")
    Wait(2)
    StopEmitters("DBC_LastMachineExplodeFX")
    StartEmitters("DBC_BlastMachineDamagedSparks")
    StartEmitters("DBC_DestructBlastMachineFX01")
    StartEmitters("DBC_DestructBlastMachineFX02")
    DestroyEntity("DBC_ElectricMachine2Lever")
    Disable("DBC_Electric_Spawner02")
    Disable("DBC_Electric_Spawner02b")
    StartEmitters("DBC_BlastMachineExplodeFX")
    Wait(1.5)
    SetPropertyFloat("DBC_ElectricDoorBranch", "BranchPathChance", 1)
    StopEmitters("DBC_BlastMachineExplodeFX")
    StartEmitters("DBC_ElectTreasureDoorExplodeFX")
    SetRotatorMaxSpeed("DBC_ElectricRoomDoor", 30)
    StartRotateToPosition("DBC_ElectricRoomDoor", -130)
    Wait(2)
    StopEmitters("DBC_ElectTreasureDoorExplodeFX")
  end
  return 
end
DBC_OswaldRemoteTutorial = function(step)
  if (step == "one") then
    Disable("ActionSpotTrackRunner")
    OswaldStopMovingAction()
    Wait(0)
    QueueThought(GetPlayer2OrAI(), "OswaldBeamThoughtBubble_Small")
    Wait(1.5)
    ClearThought(GetPlayer2OrAI())
    DBC_CurrentIcon = 3
    Wait(0.75)
    OswaldStreamAction("FirstMachineSwitch")
    DBC_CurrentIcon = 0
  elseif (step == "two") then
    Disable("ActionSpotTrackRunner")
    OswaldStopMovingAction()
    Wait(0)
    QueueThought(GetPlayer2OrAI(), "OswaldBlastThoughtBubble_Small")
    Wait(1.5)
    ClearThought(GetPlayer2OrAI())
    FireThread(DBC_ElectricalRoom_ElectricBlastLoop)
    Wait(1)
    if (DBC_SecondMachineDoor == 1) then
      if (GetGlobal("DBC_ElectricRoomPower") < 2) then
        if (GetGlobal("DBC_ElectricMachine2") == 1) then
          OswaldBlastAction("DBC_SecondMachineMarker")
        end
      end
    end
  elseif (step == "three") then
    Disable("ActionSpotTrackRunner")
    OswaldStopMovingAction()
    Wait(0)
    QueueThought(GetPlayer2OrAI(), "OswaldBeamThoughtBubble_Small")
    Wait(1.5)
    ClearThought(GetPlayer2OrAI())
    DBC_CurrentIcon = 3
    Wait(0.75)
    OswaldStreamAction("ThirdMachineTimer")
    DBC_CurrentIcon = 0
  end
  return 
end
DBC_TopPlatformVar = 0
DBC_Electrical_TopPlatformMaster = function()
  if (DBC_TopPlatformVar == 0) then
    SetRotatorMaxSpeed("DBC_RotatorSphere03", 15)
    StartRotateToPosition("DBC_RotatorSphere03", 30)
    DBC_TopPlatformVar = 1
  elseif (DBC_TopPlatformVar == 1) then
    SetRotatorMaxSpeed("DBC_RotatorSphere03", 15)
    StartRotateToPosition("DBC_RotatorSphere03", -30)
    DBC_TopPlatformVar = 0
  end
  return 
end
DBC_Electric_2ndStageRightSwitch = function()
  DBC_Electric_2ndStageSwitch1Var = 1
  DBC_Electric_2ndStageMaster()
  return 
end
DBC_BlastShouldGotoMasterVar = 0
DBC_Electric_2ndStageLeftSwitch = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    DBC_BlastShouldGotoMasterVar = (DBC_BlastShouldGotoMasterVar + 1)
    DBC_Electric_2ndStageSwitch2Var = 1
    if (DBC_BlastShouldGotoMasterVar == 1) then
      DBC_Electric_2ndStageMaster()
    end
  end
  return 
end
DBC_BlastMachine1 = 0
DBC_BlastMachine2 = 0
DBC_SecondMachineShock = function(target, variable, sign)
  if (_G[variable] == 0) then
    _G[variable] = 1
    Print(("+_+_+_+_+_+_+_+_+_+ Just activated" .. tostring(sign)))
    Wait(0.5)
    if (DBC_BlastMachine1 == 1) then
      if (DBC_BlastMachine2 == 1) then
        DBC_Electric_2ndStageMaster()
      end
    else
      _G[variable] = 0
      Print(("+_+_+_+_+_+_+_+_+_+ Just deactivated" .. tostring(sign)))
      Prefab_OswaldElectricSwitch_ChangeState(sign, "Reset")
      FireSequence("DBC_GusConversationTrigger", "DBC_Gus_BlastPrompt", 0)
    end
  end
  return 
end
DBC_Electric_2ndStageMaster = function()
  if (1 < GetGlobal("DBC_ElectricRoomPower")) then
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_BlastAlreadyFired", 0)
  elseif (GetGlobal("DBC_ElectricRoomPower") == 1) then
    DismissTextBox()
    ClearAllCameraAttributes()
    DisableGuardianHint("GusHintElectric2")
    ActivateGremlinHint("GusHintElectric3")
    Wait(0.10000000149011612)
    SetCameraAttributesForPlayer("ElectricMachineCamera03")
    ForEachEntityInGroup(Disable, "BuddyActionBeamTrainingGroup2")
    DBC_CurrentIcon = 0
    if (GetGlobal("DBC_ThirdMachineState") ~= 0) then
      Enable("BuddyActionBeamTraining5")
    else
      Enable("BuddyActionBeamTraining6")
    end
    Enable("ThirdMachineCameraTrigger")
    OswaldStartFollowAction()
    OswaldStartMovingAction()
    StartEmitters("LabMachineSparks2")
    StartEmitters("LabMachineSparks3")
    AudioPostEventOn("dbc_electricalroom_01a.Sound_ElectricWire_02", "Play_sfx_DBC_ElecConductionNodeStable_Lp")
    SetGlobal("DBC_ElectricRoomPower", 2)
    SetPropertyFloat("LabMachinePullHandle", "UsableRadius", 0)
    Unhide("DBC_MachineCore")
    Disable("DBC_Electrical_BadSpawner02")
    Disable("DBC_Electrical_BadSpawner03")
    StopEmitters("DBC_Electrical_TopSparks02")
    StopEmitters("DBC_Electrical_TopSparks03")
    Unhide("DBC_BlastEffect_MiddleSpark")
    StartEmitters("DBC_BlastEffect_MiddleSpark")
    if (DBC_LastMachineVar == 1) then
      Wait(2)
      DBC_ExitMachineStage02()
    end
    Wait(0.30000001192092896)
    DBC_Electric_2ndStageSwitch1Var = 0
    DBC_Electric_2ndStageSwitch2Var = 0
    DBC_BlastShouldGotoMasterVar = 0
    DestroyEntity("GusHintElectric2")
  end
  return 
end
DBC_BlastMachineSequenceDetermine = function(target)
  if (GetGlobal("DBC_Gus_RemoteTutor03_Played") == 1) then
    if (DBC_SecondMachineDoor == 0) then
      FireSequence("dbc_courtyard_01a_shared.ConversationalTrigger 01", "DBC_Gus_PullHandle", 0)
    elseif (DBC_SecondMachineDoor == 1) then
      FireSequence("DBC_GusConversationTrigger", "DBC_Gus_RemoteTutor04", 0)
    end
    ClearAllCameraAttributes()
    DestroyEntity(target)
  end
  return 
end
DBC_SecondMachineStatus = 0
DBC_SecondMachineDoor = 0
DBC_ElectricalRoom_PullHandle = function(target, action)
  if (action == "pull") then
    DBC_SecondMachineDoor = 1
    Enable("BeamTutorialTrigger2")
    if (GetGlobal("DBC_ElectricRoomPower") == 0) then
      FireSequence("DBC_GusConversationTrigger", "DBC_BlastMachineNoPower", 0)
    else
      if (DBC_SecondMachineStatus < 2) then
        DBC_SecondMachineStatus = 1
      end
      FireSequence("DBC_GusConversationTrigger", "DBC_Gus_RemoteTutor04", 0)
      ForEachEntityInGroup(Enable, "BlastDoorGroup")
      AudioPostEventOn("dbc_courtyard_01a_audio.SND_Blast_Doors", "Play_sfx_DBC_BlastMachineOpening")
      Unhide("DBC_BlastMachineSwitchRight")
      Unhide("DBC_BlastMachineSwitchLeft")
      if (action == "release") then
        DBC_SecondMachineDoor = 0
        Disable("BeamTutorialTrigger2")
        if (GetGlobal("DBC_ElectricRoomPower") ~= 0) then
          if (GetGlobal("DBC_ElectricRoomPower") == 1) then
            if (DBC_SecondMachineStatus < 2) then
              DBC_SecondMachineStatus = 0
            end
            TimerDisable("PullHandleTimer")
            TimerReset("PullHandleTimer")
            Hide("DBC_BlastMachineSwitchRight")
            Hide("DBC_BlastMachineSwitchLeft")
          elseif (2 <= GetGlobal("DBC_ElectricRoomPower")) then
            Disable("LabPullHandleTrigger")
          end
        end
      end
    end
  elseif (action == "release") then
    DBC_SecondMachineDoor = 0
    Disable("BeamTutorialTrigger2")
    if (GetGlobal("DBC_ElectricRoomPower") ~= 0) then
      if (GetGlobal("DBC_ElectricRoomPower") == 1) then
        if (DBC_SecondMachineStatus < 2) then
          DBC_SecondMachineStatus = 0
        end
        TimerDisable("PullHandleTimer")
        TimerReset("PullHandleTimer")
        Hide("DBC_BlastMachineSwitchRight")
        Hide("DBC_BlastMachineSwitchLeft")
      elseif (2 <= GetGlobal("DBC_ElectricRoomPower")) then
        Disable("LabPullHandleTrigger")
      end
    end
  end
  ForEachEntityInGroup(Reverse, "BlastDoorGroup")
  AudioPostEventOn("dbc_courtyard_01a_audio.SND_Blast_Doors", "Play_sfx_DBC_BlastMachineOpening")
  return 
end
DBC_ElectricalRoom_PullHandleCheck = function()
  if (GetGlobal("DBC_ElectricRoomPower") < 2) then
    if (GetGlobal("DBC_ElectricMachine2") == 1) then
      OswaldBlastAction("DBC_SecondMachineMarker")
      Wait(2)
    end
  end
  return 
end
DBC_LabRestoredIGC = 0
DBC_ElectricalRoom_ThirdMachineCheck = function()
  if (GetGlobal("DBC_ElectricRoomPower") < 2) then
    FireSequence("DBC_GusConversationTrigger", "DBC_BlastMachineNoPower", 0)
    Prefab_OswaldElectricSwitch_ChangeState("ThirdMachineSwitch", "Reset")
  elseif (GetGlobal("DBC_ThirdMachineState") == 0) then
    if (GetGlobal("DBC_ElectricRoomPower") == 2) then
      OswaldStreamAbort()
      Prefab_OswaldElectricSwitch_ChangeState("ThirdMachineSwitch", "Reset")
    end
  else
    if (GetPropertyInt("dbc_electricalroom_01a_art.seq_openchest_oswald 01.seq_openchest 01.Chest", "Active Sequence ID") == 0) then
      Enable("ActionSpotTrackRunner")
    end
    if (GetGlobal("DBC_ThirdMachineState") == 1) then
      if (GetGlobal("DBC_ElectricRoomPower") == 2) then
        RestrictCutSceneInput()
        DBC_LabRestoredIGC = 1
        ForEachEntityInGroup(Disable, "BuddyActionBeamTrainingGroup3")
        ClearAllCameraAttributes()
        Disable("ThirdMachineCameraTrigger")
        OswaldStreamAbort()
        DBC_CurrentIcon = 0
        FireUser2("TimerElectricRoom")
        DisableGuardianHint("GusHintElectric3")
        Wait(0.10000000149011612)
        SetGlobal("DBC_ElectricRoomPower", 3)
        SetGlobal("DBC_QuestHealth", (GetGlobal("DBC_QuestHealth") + 10))
        FireUser1("PlatformRevealCamera")
        wait(1)
        AnimGBSequence("ElectricRoomPlatforms", "fall", true)
        SetPropertyBool("ElectricRoomPlatforms", "Start Active", true)
        ForEachEntityInGroup(FireUser1, "CenterPlatfomCameras")
        AnimGBSequence("DBC_Electric_TopExit", "open")
        SetPropertyBool("DBC_Electric_TopExit", "Start Active", true)
        ForEachEntityInGroup(Unhide, "DBC_ElectricTeslaCore")
        ForEachEntityInGroup(StartEmitters, "DBC_ElectricTeslaCore")
        OswaldStartFollowAction()
        FireSequence("DBC_GusConversationTrigger", "DBC_Gus_ElectricalStepsNotice", 0)
        DestroyEntity("GusHintElectric3")
        DBC_LabRestoredIGC = 0
        UnrestrictCutSceneInput()
      end
    elseif (GetGlobal("DBC_ThirdMachineState") == 2) then
      ClearAllCameraAttributes()
      Disable("ThirdMachineCameraTrigger")
      ForEachEntityInGroup(Disable, "BuddyActionBeamTrainingGroup3")
      OswaldStreamAbort()
      DBC_CurrentIcon = 0
      StartEmitters("LabMachineSparks5")
      FireUser2("TimerElectricRoom")
      DisableGuardianHint("GusHintElectric3")
      Wait(0.5)
      FireSequence("DBC_GusConversationTrigger", "DBC_Gus_LookOut", 0)
      Wait(1.399999976158142)
      if (GetGlobal("DBC_ElectricRoomPower") == 3) then
        SetGlobal("DBC_QuestHealth", (GetGlobal("DBC_QuestHealth") - 20))
      else
        SetGlobal("DBC_QuestHealth", (GetGlobal("DBC_QuestHealth") - 10))
      end
      SetGlobal("DBC_QuestHealth", (GetGlobal("DBC_QuestHealth") + 10))
      SetGlobal("DBC_ElectricRoomPower", 4)
      ForEachEntityInGroup(DestroyEntity, "DBC_DestructMachineALL")
      Unhide("DBC_ElectricalRoommachine3BrokenState")
      local ExplosionDirection = (GetPosition("ThirdMachineCutsceneEndMarker2") - GetPosition("DBC_ElectricalRoommachine3BrokenState"))
      ExplosionDirection:normalize3()
      ApplyImpulse("DBC_ElectricalRoommachine3BrokenState", (ExplosionDirection.x * 1000), 1200, (ExplosionDirection.z * 1000))
      StartEmitters("DBC_LastMachineExplodeFX")
      StopEmitters("LabMachineSparks5")
      Unhide("ThinDeepPin")
      AudioPostEventOn("dbc_courtyard_01a_audio.SND_Lab_Machine_Explode", "Play_sfx_MachineExplodes")
      DestroyEntity("DBC_Electrical_TopSparks03")
      DestroyEntity("GusHintElectric3")
      wait(0.20000000298023224)
      if (GetGlobal("DBC_CourtTowerFall") == 1) then
        DBC_Checkpoint_Save(nil, "courtyard")
      else
        DBC_Checkpoint_Save(nil, "electric")
      end
      FireThread(DBC_FadeoutElectricalRoom_ThirdMachine)
      Wait(2)
      StopEmitters("DBC_LastMachineExplodeFX")
      StartEmitters("DBC_DestructBlastMachineFX01")
      StartEmitters("DBC_DestructBlastMachineFX02")
      Disable("DBC_Electric_Spawner02")
      Disable("DBC_Electric_Spawner02b")
      StartEmitters("DBC_BlastMachineExplodeFX")
      Wait(1.5)
      SetPropertyFloat("DBC_ElectricDoorBranch", "BranchPathChance", 1)
      StopEmitters("DBC_BlastMachineExplodeFX")
      StartEmitters("DBC_ElectTreasureDoorExplodeFX")
      Wait(2)
      StopEmitters("DBC_ElectTreasureDoorExplodeFX")
    end
  end
  return 
end
DBC_FadeoutElectricalRoom_ThirdMachine = function()
  local (for index), (for limit), (for step) = 1, 0, -0.05000000074505806
  for a = (for index), (for limit), (for step) do
    SetR3MTConstRegAlpha("DBC_ElectricalRoommachine3BrokenState", 3, a)
    Wait(0.05000000074505806)
  end
  DestroyEntity("DBC_ElectricalRoommachine3BrokenState")
  return 
end
DBC_ElectricalRoom_ThirdMachineCutsceneEnd = function()
  TeleportToEntity(GetPlayer(), "ThirdMachineCutsceneEndMarker1")
  TeleportToEntity(GetPlayer2OrAI(), "ThirdMachineCutsceneEndMarker2")
  return 
end
DBC_ThirdMachineClamp02 = 1
DBC_ElectricalRoom_ThirdMachineClamp = function(target, action, variable, object)
  if (action == "paint") then
    if (object == "cable") then
      Enable("BeamTutorialTrigger3")
      if (GetGlobal("DBC_ThirdMachineState") ~= 2) then
        SetGlobal("DBC_ThirdMachineState", 1)
        if (GetGlobal("DBC_ElectricRoomPower") == 2) then
          Enable("BuddyActionBeamTraining5")
          Disable("BuddyActionBeamTraining6")
          OswaldSetPathAction("ThirdMachineNode1")
        end
      end
      if (GetGlobal("DBC_ElectricRoomPower") == 2) then
        StopEmitters("LabMachineSparks3")
        Hide("LabMachineSparks3")
        StartEmitters("LabMachineSparks4")
        Unhide("LabMachineSparks4")
        _G[variable] = 1
        if (action == "thin") then
          if (object == "cable") then
            if (GetGlobal("DBC_ThirdMachineState") ~= 2) then
              SetGlobal("DBC_ThirdMachineState", 0)
              if (GetGlobal("DBC_ElectricRoomPower") == 2) then
                Disable("BuddyActionBeamTraining5")
                Enable("BuddyActionBeamTraining6")
                Disable("BeamTutorialTrigger3")
              end
            end
            if (GetGlobal("DBC_ElectricRoomPower") == 2) then
              StopEmitters("LabMachineSparks4")
              Hide("LabMachineSparks4")
              StartEmitters("LabMachineSparks3")
              Unhide("LabMachineSparks3")
            end
            OswaldStreamAbort()
          else
            _G[variable] = 0
            if (action == "stim") then
              FireSequence("DBC_GusConversationTrigger", "DBC_Gus_MachineBreakWarn", 0)
            end
          end
        elseif (action == "stim") then
          FireSequence("DBC_GusConversationTrigger", "DBC_Gus_MachineBreakWarn", 0)
        end
      end
    else
      _G[variable] = 1
      if (action == "thin") then
        if (object == "cable") then
          if (GetGlobal("DBC_ThirdMachineState") ~= 2) then
            SetGlobal("DBC_ThirdMachineState", 0)
            if (GetGlobal("DBC_ElectricRoomPower") == 2) then
              Disable("BuddyActionBeamTraining5")
              Enable("BuddyActionBeamTraining6")
              Disable("BeamTutorialTrigger3")
            end
          end
          if (GetGlobal("DBC_ElectricRoomPower") == 2) then
            StopEmitters("LabMachineSparks4")
            Hide("LabMachineSparks4")
            StartEmitters("LabMachineSparks3")
            Unhide("LabMachineSparks3")
          end
          OswaldStreamAbort()
        else
          _G[variable] = 0
          if (action == "stim") then
            FireSequence("DBC_GusConversationTrigger", "DBC_Gus_MachineBreakWarn", 0)
          end
        end
      elseif (action == "stim") then
        FireSequence("DBC_GusConversationTrigger", "DBC_Gus_MachineBreakWarn", 0)
      end
    end
  elseif (action == "thin") then
    if (object == "cable") then
      if (GetGlobal("DBC_ThirdMachineState") ~= 2) then
        SetGlobal("DBC_ThirdMachineState", 0)
        if (GetGlobal("DBC_ElectricRoomPower") == 2) then
          Disable("BuddyActionBeamTraining5")
          Enable("BuddyActionBeamTraining6")
          Disable("BeamTutorialTrigger3")
        end
      end
      if (GetGlobal("DBC_ElectricRoomPower") == 2) then
        StopEmitters("LabMachineSparks4")
        Hide("LabMachineSparks4")
        StartEmitters("LabMachineSparks3")
        Unhide("LabMachineSparks3")
      end
      OswaldStreamAbort()
    else
      _G[variable] = 0
      if (action == "stim") then
        FireSequence("DBC_GusConversationTrigger", "DBC_Gus_MachineBreakWarn", 0)
      end
    end
  elseif (action == "stim") then
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_MachineBreakWarn", 0)
  end
  if (DBC_ThirdMachineClamp02 == 0) then
    if (GetGlobal("DBC_ElectricRoomPower") == 3) then
      AnimGBSequence("ThirdMachineCable2", "fall", true)
    else
      AnimGBSequence("ThirdMachineCable2", "fall")
    end
    Enable("BeamTutorialTrigger3")
    StopEmitters("LabMachineSparks4")
    Hide("LabMachineSparks4")
    StopEmitters("LabMachineSparks3")
    Hide("LabMachineSparks3")
    StopEmitters("ThirdMachineClampSpark")
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_MachineBroken", 0)
    SetGlobal("DBC_ThirdMachineState", 2)
    SplineKnotComponent_SetBranchProbability("ThirdMachineBranchKnot", 1)
    if (GetGlobal("DBC_ElectricRoomPower") == 2) then
      if (DBC_LabRestoredIGC == 0) then
        Prefab_OswaldElectricSwitch_ChangeState("ThirdMachineSwitch", "Reset")
        Enable("BuddyActionBeamTraining5")
        Disable("BuddyActionBeamTraining6")
        OswaldSetPathAction("ThirdMachineNode1")
      end
    end
  end
  return 
end
DBC_ElectricalRoom_ThirdMachineSparkCheck = function(target, position)
  DestroyEntity(target)
  return 
end
DBC_ElectricalRoom_EnablePlatformJumps = function()
  enableJumpVolumeAvailability("dbc_electricalroom_01a_art.prefab_jumpvolumeavailability 01.TargetToSend")
  enableJumpVolumeAvailability("dbc_electricalroom_01a_art.prefab_jumpvolumeavailability 02.TargetToSend")
  enableJumpVolumeAvailability("dbc_electricalroom_01a_art.prefab_jumpvolumeavailability 03.TargetToSend")
  enableJumpVolumeAvailability("dbc_electricalroom_01a_art.prefab_jumpvolumeavailability 04.TargetToSend")
  enableJumpVolumeAvailability("dbc_electricalroom_01a_art.prefab_jumpvolumeavailability 05.TargetToSend")
  enableJumpVolumeAvailability("dbc_electricalroom_01a_art.prefab_jumpvolumeavailability 06.TargetToSend")
  enableJumpVolumeAvailability("dbc_electricalroom_01a_art.prefab_jumpvolumeavailability 06.TargetToSend")
  enableJumpVolumeAvailability("dbc_electricalroom_01a_art.prefab_jumpvolumeavailability 07.TargetToSend")
  AnimGBSequence("DBC_Electric_TopExit", "open")
  DBC_Checkpoint_Save(nil, "electric")
  return 
end
DBC_Electric_ReachFirstMachine = function()
  FireUser1("TimerElectricRoom")
  SetPropertyBool("FirstMachineLookAt", "Look At Trigger Enabled", true)
  OswaldStopMovingAction()
  return 
end
DBC_BeamTutorialManage = function(target, action, value)
  if (action == "enter") then
    if (_activator() == GetPlayer2()) then
      if (GetGlobal("DBC_ElectricRoomPower") == tonumber(value)) then
        if (value == "1") then
          FireThread(DBC_ElectricalRoom_ElectricBlastLoop)
        else
          DBC_CurrentIcon = 3
          if (value == "0") then
            FireSequence("dbc_courtyard_01a_shared.ConversationalTrigger 01", "DBC_Gus_RemoteTutor02", 0)
            if (action == "exit") then
              if (_activator() == GetPlayer2()) then
                DBC_CurrentIcon = 0
              end
            end
          end
        end
      end
    end
  elseif (action == "exit") then
    if (_activator() == GetPlayer2()) then
      DBC_CurrentIcon = 0
    end
  end
  return 
end
DBC_Electric_FirstStageGood = function(target, object)
  if (object == "FirstMachineSpark") then
    Print("++++++++++++++++++++++++++++++++++++++++++++++++++Triggered from VFX")
    if (DBC_SecondMachineDoor == 1) then
      DBC_SecondMachineStatus = 1
      ForEachEntityInGroup(Enable, "BlastDoorGroup")
      Unhide("DBC_BlastMachineSwitchRight")
      Unhide("DBC_BlastMachineSwitchLeft")
    end
  elseif (GetGlobal("DBC_ElectricRoomPower") == 0) then
    Print("++++++++++++++++++++++++++++++++++++++++++++++++++Triggered from switch")
    ClearAllCameraAttributes()
    OswaldStartFollowAction()
    OswaldStartMovingAction()
    DisableGuardianHint("GusHintElectric1")
    ActivateGremlinHint("GusHintElectric2")
    Wait(0.10000000149011612)
    SetCameraAttributesForPlayer("ElectricMachineCamera02", nil)
    ForEachEntityInGroup(Disable, "BuddyActionBeamTrainingGroup1")
    Enable("BuddyActionBeamTraining3")
    SetPropertyFloat("LabMachinePullHandle", "UsableRadius", 3.5)
    DBC_CurrentIcon = 0
    DismissTextBox()
    StartEmitters("LabMachineSparks1")
    AudioPostEventOn("dbc_electricalroom_01a.Sound_ElectricWire_01", "Play_sfx_DBC_ElecConductionNodeStable_Lp")
    SetGlobal("DBC_ElectricRoomPower", 1)
    Disable("DBC_Electrical_BadSpawner01")
    Wait(0.5)
    OswaldStreamAbort()
    DestroyEntity("GusHintElectric1")
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_RemoteTutor03", 0)
    DBC_Electric_FirstStageGood(nil, "FirstMachineSpark")
  end
  return 
end
DBC_Electric_MachineFX = function()
  if (1 <= GetGlobal("DBC_ElectricRoomPower")) then
    Enable("DBC_Electric_Spawner01")
    Enable("DBC_Electric_Spawner01b")
    ForEachEntityInGroup(StartEmitters, "DBC_FirstStageElectricSparks")
    ForEachEntityInGroup(StartEmitters, "DBC_Electric_Stage1CableSparks")
    Disable("DBC_Electrical_BadSpawner01")
    StopEmitters("DBC_Electrical_TopSparks01")
  elseif (2 <= GetGlobal("DBC_ElectricRoomPower")) then
    Enable("DBC_Electric_Spawner02b")
    ForEachEntityInGroup(StartEmitters, "DBC_2ndStageElectricSparks")
    ForEachEntityInGroup(StartEmitters, "DBC_Electric_Stage2CableSparks")
    Disable("DBC_Electrical_BadSpawner02")
    Disable("DBC_Electrical_BadSpawner03")
    StopEmitters("DBC_Electrical_TopSparks02")
    StopEmitters("DBC_Electrical_TopSparks03")
    Unhide("DBC_BlastEffect_MiddleSpark")
    StartEmitters("DBC_BlastEffect_MiddleSpark")
  end
  return 
end
DBC_OswaldShoot1stMachine_Part2 = function()
  OswaldStreamAction("DBC_FirstMachineTarget")
  Enable("DBC_SecondMachineSpeechStart")
  return 
end
DBC_OswaldShoot1stMachine = function()
  OswaldSetPathAction("DBC_OswaldShootfirstSwitchMarker")
  return 
end
DBC_OswaldWalkRemote = function()
  FireUser1("DBC_Electrical_OswaldRemote01")
  Wait(0.800000011920929)
  MoveToEntity(GetPlayer(), "DBC_ElectricalMickeyMarker")
  MoveToEntity(GetOswaldAI(), "DBC_ElectricalOswaldMarker")
  Wait(0.20000000298023224)
  OswaldSetPathAction("DBC_OswaldRemotePatrolNode")
  return 
end
DBC_OswaldGetsRemote = function()
  Wait(0.5)
  OswaldSpinAction()
  Wait(1)
  DestroyEntity("DBC_OswaldRemoteStandIn")
  Wait(1)
  FireUser1("DBC_Electrical_OswaldRemote02")
  AnimGBSequence("DBC_ElectricalFallingTower", "fall")
  Wait(2.5999999046325684)
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  return 
end
DBC_SecondMachinePatrolNode = function()
  DBC_ShowIcon_B()
  Wait(0.30000001192092896)
  DBC_HideIcon_B()
  Wait(0.30000001192092896)
  DBC_ShowIcon_B()
  Wait(0.30000001192092896)
  DBC_HideIcon_B()
  ClearNextPatrolNode(GetOswaldAI())
  OswaldBlastAction("DBC_SecondMachineMarker")
  DBC_ShowIcon_B()
  OswaldStartFollowAction()
  Wait(1)
  DBC_HideIcon_B()
  DBC_Electric_2ndStageSwitch1Var = 1
  Wait(0.10000000149011612)
  DBC_Electric_2ndStageMaster()
  return 
end
DBC_ElectricalRoom_ElectricBlastLoop = function()
  return 
end
DBC_ElectricalTowerFall = function()
  AnimGBSequence("DBC_ElectricalFallingTower", "fall")
  Wait(2.799999952316284)
  Rumble(nil, 0.800000011920929)
  Rumble(nil, 0.800000011920929, 1)
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  return 
end
DBC_ElectricalMachineTracker = 0
DBC_GrabTurnstile = false
DBC_PlatformPostition = 0
DBC_TurnStileStart = function(target)
  Print("DBC_TurnStileStart")
  local turnstileRotation = 0
  local startingRotationPosition = 0
  local numOfRotations = 12.566370964050293
  startingRotationPosition = (startingRotationPosition - GetTotalRotation(target))
  DBC_GrabTurnstile = true
  SetSplineFollowerInitialSpeed("DBC_ElevatorPlatform", 1)
  while true do
    if (not (DBC_GrabTurnstile == true)) then
      break
    end
    turnstileRotation = (GetTotalRotation(target) + startingRotationPosition)
    DBC_PlatformPostition = (turnstileRotation / numOfRotations)
    if (1 < DBC_PlatformPostition) then
      DBC_PlatformPostition = 1
    elseif (DBC_PlatformPostition < 0) then
      DBC_PlatformPostition = 0
    end
    if (0.550000011920929 <= DBC_PlatformPostition) then
      DBC_Turnstile_Finish_WIP("one")
      return 
    end
    SplineFollower_StopAtPosition("DBC_ElevatorPlatform", "DBC_ElectricalElevatorKnot02", "DBC_ElectricalElevatorKnot01", DBC_PlatformPostition)
    Wait(0)
  end
  return 
end
DBC_Turnstile_Finish = function()
  Print("DBC_Turnstile_Finish")
  DBC_GrabTurnstile = false
  StopAbility(GetPlayer(), "CoopMove")
  StopAbility(GetPlayer2OrAI(), "CoopMove")
  DisableComponent("ElectricRoomTurnstile", "Coop Movable Component")
  DBC_Turnstile_ManageFX(nil, "release")
  ClearAllCameraAttributes()
  ActivateGremlinHint("GusHintElectric1")
  SplineFollower_StopAtPosition("DBC_ElevatorPlatform", "DBC_ElectricalElevatorKnot02", "DBC_ElectricalElevatorKnot01", 1)
  AudioPostEventOn("ElectricRoomTurnstile", "Play_sfx_turnstile_clunk")
  Wait(2)
  SetCameraAttributesForPlayer("ElectricMachineCamera01")
  Hide("DBC_Electrical_Elevator")
  SetPropertyInt("DBC_ElectricMachine2Lever", "Is Mover", 1)
  TimerDisable("PlaystyleTimer_Zone02")
  LevelManager_SetCurrentState("DarkBeautyCastle_V1.Stream_3")
  Wait(1)
  Enable("BuddyActionBeamTraining1")
  Wait(0.5)
  ForEachEntityInGroup(AnimGBSequence, "ElectricTurnstileGroup", "move")
  ForEachEntityInGroup(SetPropertyBool, "ElectricTurnstileGroup", "Start Active", true)
  Wait(2)
  SplineFollower_SetDisabled("DBC_ElevatorPlatform", true)
  Wait(0.10000000149011612)
  DBC_Checkpoint_Save(nil, "electric")
  return 
end
DBC_Turnstile_Finish_WIP = function(step)
  if (step == "one") then
    Print("DBC_Turnstile_Finish")
    RestrictCutSceneInput()
    OswaldStopMovingAction()
    DBC_GrabTurnstile = false
    StopAbility(GetPlayer(), "CoopMove")
    StopAbility(GetPlayer2OrAI(), "CoopMove")
    DisableComponent("ElectricRoomTurnstile", "Coop Movable Component")
    AudioPostEventOn("ElectricRoomTurnstile", "Play_sfx_turnstile_clunk")
    DBC_Turnstile_ManageFX(nil, "release")
    TimerDisable("PlaystyleTimer_Zone02")
    SplineFollower_StopAtPosition("DBC_ElevatorPlatform", "DBC_ElectricalElevatorKnot02", "DBC_ElectricalElevatorKnot01", 1)
    Enable("BeamTutorialTrigger1")
    FireThread(DBC_ElectricalTowerFall)
    Wait(0.4000000059604645)
    FireUser1("RemoteTutorialIGC")
    Wait(1.600000023841858)
    AudioPostEventOn("dbc_courtyard_01a_audio.SND_event_ElevatorReachTop_1", "Play_sfx_ElevatorStop")
  elseif (step == "two") then
    Print("_______________________________DBC_Turnstile_IGCOutro: Fire thread fired")
    Wait(2)
    SetPropertyInt("DBC_ElectricMachine2Lever", "Is Mover", 1)
    Wait(1.5)
    ForEachEntityInGroup(AnimGBSequence, "ElectricTurnstileGroup", "move")
    ForEachEntityInGroup(SetPropertyBool, "ElectricTurnstileGroup", "Start Active", true)
  end
  return 
end
DBC_Turnstile_IGCOutro = function()
  Print("_______________________________DBC_Turnstile_IGCOutro: Function fired")
  Wait(0.800000011920929)
  TeleportToEntity(GetPlayer(), "RemoteIGCMarkerMickey")
  TeleportToEntity(GetPlayer2OrAI(), "RemoteIGCMarkerOswald")
  Quest_SetCriticalPath("Critical_DBC", "Critical_DBC_5")
  UnrestrictCutSceneInput()
  OswaldStartMovingAction()
  Enable("BuddyActionBeamTraining1")
  SplineFollower_SetDisabled("DBC_ElevatorPlatform", true)
  Wait(0.10000000149011612)
  SetCameraAttributesForPlayer("ElectricMachineCamera01")
  Wait(0.20000000298023224)
  ActivateGremlinHint("GusHintElectric1")
  LevelManager_SetCurrentState("DarkBeautyCastle_V1.Stream_3")
  DBC_Checkpoint_Save(nil, "electric")
  return 
end
DBC_Turnstile_Cancel = function(target)
  if (DBC_GrabTurnstile == false) then
    Print("DBC_Turnstile_Cancel DBC_GrabTurnstile = false")
    return 
  end
  Print("DBC_Turnstile_Cancel")
  DBC_GrabTurnstile = false
  DisableComponent("ElectricRoomTurnstile", "Coop Movable Component")
  DBC_Turnstile_ManageFX(nil, "release")
  SetSplineFollowerInitialSpeed("DBC_ElevatorPlatform", 4.5)
  SplineFollower_StopAtPosition("DBC_ElevatorPlatform", "DBC_ElectricalElevatorKnot02", "DBC_ElectricalElevatorKnot01", 0)
  local waitTime = (3 * DBC_PlatformPostition)
  wait(waitTime)
  EnableComponent("ElectricRoomTurnstile", "Coop Movable Component")
  return 
end
DBC_Turnstile_ManageFX = function(target, direction)
  if (direction == "up") then
    Unhide("TurnstileVFXUp")
    Hide("TurnstileVFXDown")
  elseif (direction == "down") then
    Hide("TurnstileVFXUp")
    Unhide("TurnstileVFXDown")
  elseif (direction == "release") then
    ForEachEntityInGroup(Hide, "TurnstileVFXGroup")
  end
  return 
end
DBC_MoveOswaldToBalcony = function()
  MoveToEntity(GetOswaldAI(), "DBC_OswaldBalconyMarker")
  return 
end
DBC_CourtCamSequenceStart = function(target, location, action)
  Print("+_+_+_+_+_+ Falling rubble: Function triggered")
  if (action == "trigger") then
    ForEachEntityInGroup(DestroyEntity, "FallingTowerTriggerGroup")
  end
  if (GetGlobal("DBC_CourtTowerFall") == 0) then
    SetGlobal("DBC_CourtTowerFall", 1)
    Quest_SetCriticalPath("Critical_DBC", "Critical_DBC_6")
    FireSequence("DBC_OswaldConvoTrigger", "DBC_Oswald_CourtEntry", 0)
    Wait(0.5)
    AnimGBSequence("DBC_CourtyardTowerAnim", "fall", true)
    DBC_CourtShakeCamera()
    DoStinger("DBC_Stinger_Courtyard", 2)
    Print("Music DBC_CourtCamSequenceStart")
    Wait(1.399999976158142)
    StartEmitters("FallingTowerDust1")
    Wait(0.6000000238418579)
    ReplaceMusicStateOverride("DBC_5_Courtyard")
    FireSequence("DBC_OswaldConvoTrigger", "DBC_Oswald_SawTowerFall", 0)
  end
  if (GetGlobal("DBC_CourtyardEntered") == 0) then
    SetGlobal("DBC_CourtyardEntered", 1)
    if (location == "balcony") then
      DBC_Checkpoint_Save(nil, "courtbalcony")
    elseif (location == "ground") then
      DBC_Checkpoint_Save(nil, "courtyard")
    end
  end
  DBC_SpatterCourtCount = 2
  DBC_SpatterCourtSpawned = 2
  FireThread(DBC_Courtyard_QueueSpatter)
  Wait(0.20000000298023224)
  ForceSpawn("SpatterCourtyard_Spawner 01", 1)
  Wait(0.20000000298023224)
  ForceSpawn("SpatterCourtyard_Spawner 01", 1)
  return 
end
DBC_Courtyard_FallingTutorial = function(target, action)
  if (action == "enter") then
    if (GetGlobal("DBC_CourtTowerFall") == 0) then
      FireSequence("ConversationMarkerTutorial", "Tutorial_SafetyFallTrainingAlt", 0)
    end
  elseif (action == "exit") then
    ForceInterruptSequence("ConversationMarkerTutorial", "Tutorial_SafetyFallTrainingAlt")
  end
  return 
end
DBC_SwitchTowerToRubble = function()
  Hide("DBC_CourtyardTowerAnim")
  Unhide("DBC_FallenTowerDust")
  Wait(3)
  Hide("DBC_FallenTowerDust")
  return 
end
MickeyInTrigger_Court = 0
OswaldInTrigger_Court = 0
DBC_Courtyard_StreamCheck = function(target, direction, location)
  if (GetName(_activator()) == GetName(GetPlayer())) then
    Print("+_+_+_+_+_+_+_+_+_+_+_+ Mickey hit stream trigger")
    if (direction == "forward") then
      MickeyInTrigger_Court = 1
    elseif (direction == "back") then
      MickeyInTrigger_Court = 0
      if (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
        Print("+_+_+_+_+_+_+_+_+_+_+_+ Oswald hit stream trigger")
        if (direction == "forward") then
          OswaldInTrigger_Court = 1
        elseif (direction == "back") then
          OswaldInTrigger_Court = 0
        end
      end
    end
  elseif (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
    Print("+_+_+_+_+_+_+_+_+_+_+_+ Oswald hit stream trigger")
    if (direction == "forward") then
      OswaldInTrigger_Court = 1
    elseif (direction == "back") then
      OswaldInTrigger_Court = 0
    end
  end
  if (MickeyInTrigger_Court == 1) then
    if (OswaldInTrigger_Court == 1) then
      ForEachEntityInGroup(DestroyEntity, "CourtyardStreamTrigger")
      AnimGBSequence("CourtyardRubble1", "fall")
      AudioPostEventOn("dbc_courtyard_01a_audio.SND_Courtyard_Rubble", "Play_sfx_Courtyard_Rubble")
      AnimGBSequence("DBC_Electric_TopExit", "closed2")
      Wait(0.5)
      Enable("SpatterKillTrigger")
      Wait(2.5)
      if (LevelManager_GetCurrentState() == "darkbeautycastle_v1.stream_3") then
        LevelManager_SetCurrentState("DarkBeautyCastle_V1.Stream_4")
      end
      Wait(0.10000000149011612)
      if (GetGlobal("DBC_CourtyardEntered") == 0) then
        SetGlobal("DBC_CourtyardEntered", 1)
        if (location == "ground") then
          DBC_Checkpoint_Save(nil, "courtyard")
        elseif (location == "balcony") then
          DBC_Checkpoint_Save(nil, "courtbalcony")
        end
      end
      Wait(2)
      Disable("SpatterKillTrigger")
    end
  end
  return 
end
DBC_StartCourtAttack = function()
  if (GetGlobal("DBC_Gus_CourtSeesEnemies_Played") == 0) then
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_CourtSeesEnemies", 0)
    Print("+_+_+_+_+_+_+_+_+_+_+Spawning spatters")
  end
  return 
end
DBC_SpatterCourtFriend = 0
DBC_SpatterCourtThin = 0
DBC_SpatterCourtCount = 0
DBC_SpatterCourtSpawned = 0
DBC_DefeatCourtSpatter = function(target, action)
  if (action == "team") then
    if (GetCurrentTeam(target) == 2) then
      DBC_SpatterCourtFriend = (DBC_SpatterCourtFriend - 1)
    elseif (GetCurrentTeam(target) == 3) then
      DBC_SpatterCourtFriend = (DBC_SpatterCourtFriend + 1)
      if (action == "thinned") then
        FireSequence("DBC_GusConversationTrigger", "DBC_Gus_Combat05", 0)
        DBC_SpatterCourtThin = (DBC_SpatterCourtThin + 1)
        DBC_SpatterCourtCount = (DBC_SpatterCourtCount - 1)
        DBC_SpatterSpawnQueue = (DBC_SpatterSpawnQueue + 1)
        if (DBC_SpatterCourtThin < 4) then
          DBC_SpatterCourtCount = (DBC_SpatterCourtCount + 1)
        end
      end
    end
  elseif (action == "thinned") then
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_Combat05", 0)
    DBC_SpatterCourtThin = (DBC_SpatterCourtThin + 1)
    DBC_SpatterCourtCount = (DBC_SpatterCourtCount - 1)
    DBC_SpatterSpawnQueue = (DBC_SpatterSpawnQueue + 1)
    if (DBC_SpatterCourtThin < 4) then
      DBC_SpatterCourtCount = (DBC_SpatterCourtCount + 1)
    end
  end
  return 
end
DBC_SpatterSpawnQueue = 0
DBC_Courtyard_QueueSpatter = function()
  while true do
    if (not (DBC_SpatterCourtCount ~= DBC_SpatterCourtFriend)) then
      break
    end
    if (0 < DBC_SpatterSpawnQueue) then
      if (DBC_SpatterCourtSpawned ~= 5) then
        if (DBC_SpatterCourtFriend ~= 2) then
          DBC_SpatterSpawnQueue = (DBC_SpatterSpawnQueue - 1)
          Print(("+_+_+_+_+_+_+_+_+_+_+ Enemy spawned. DBC_SpatterCourtCount is " .. tostring(DBC_SpatterCourtCount)))
          Prefab_SpatterPipe_Spawn("CourtyardSpatterPipe")
          DBC_SpatterCourtSpawned = (DBC_SpatterCourtSpawned + 1)
          Wait(2)
        end
      end
    end
    Wait(1)
  end
  if (DBC_SpatterCourtCount == DBC_SpatterCourtFriend) then
    if (DBC_SpatterCourtThin ~= 22) then
      if (3 <= DBC_SpatterCourtThin) then
        SetGlobal("DBC_QuestHealth", (GetGlobal("DBC_QuestHealth") - 5))
      else
        SetGlobal("DBC_QuestHealth", (GetGlobal("DBC_QuestHealth") + 5))
      end
      DBC_SpatterCourtThin = 22
      TimerDisable("CombatPromptTimer")
      if (GetGlobal("DBC_Gus_SecondTower_Played") == 0) then
        FireUser1("grabcamerafancy_fallingCourtyardTower")
        SetGlobal("DBC_CourtyardCombatFinished", 1)
        InterruptCurrentSequence()
        ForceInterruptSequence("DBC_GusConversationTrigger", "DBC_Gus_Combat02")
        DBC_AmbientEarthquake()
        AnimGBSequence("FallenTowerSteps", "fall", true)
        SetPropertyBool("FallenTowerSteps", "Start Active", true)
        OswaldStopMovingAction()
        wait(0.800000011920929)
        TeleportToEntity(GetPlayer(), "MickeyFallingTowerLocation")
        TeleportToEntity(GetPlayer2OrAI(), "OswaldFallingTowerLocation")
        Quest_SetCriticalPath("Critical_DBC", "Critical_DBC_7")
        Wait(1.899999976158142)
        StartEmitters("FallingTowerDust2")
        Wait(1.100000023841858)
        AnimGBSequence("CourtyardDoor", "Open")
        SetPropertyBool("CourtyardDoor", "Start Active", true)
      end
    end
  end
  return 
end
DBC_Courtyard_BlotworxSpotted = function(target)
  SetPropertyBool("BlockerLookAtTrigger", "Look At Trigger Enabled", true)
  SetCameraAttributesForPlayer("BlotworxSpottedCamera", target)
  ClearNextPatrolNode("SpawnedBlotworx")
  DisableGuardianHint("GusHintCourtyard2")
  Wait(2)
  ClearAllCameraAttributes(target)
  return 
end
DBC_BlotworxDoor = 0
DBC_BlotworxDefeated = 0
DBC_BobDied = function(target, action)
  if (action == "team") then
    if (GetCurrentTeam(target) == 2) then
      SetGlobal("DBC_QuestHealth", (GetGlobal("DBC_QuestHealth") - 10))
    elseif (GetCurrentTeam(target) == 3) then
      SetGlobal("DBC_QuestHealth", (GetGlobal("DBC_QuestHealth") + 10))
      if (action == "death") then
        SetGlobal("DBC_QuestHealth", (GetGlobal("DBC_QuestHealth") - 10))
      end
    end
  elseif (action == "death") then
    SetGlobal("DBC_QuestHealth", (GetGlobal("DBC_QuestHealth") - 10))
  end
  if (DBC_BlotworxDefeated == 0) then
    DBC_BlotworxDefeated = 1
    while true do
      if (not IsAnySequencePlaying()) then
        break
      end
      wait(0.10000000149011612)
    end
    FireSequence("DBC_OswaldConvoTrigger", "DBC_Oswald_ApproachStation", 0)
    ActivateGremlinHint("GusHintCourtyard3")
  end
  return 
end
DBC_CourtyardStepsFall = function(target, step)
  if (step == "one") then
    if (GetGlobal("DBC_Oswald_CourtExit_Played") == 0) then
      enableJumpVolumeAvailability("dbc_courtyard_01a_art.prefab_jumpvolumeavailability 01.TargetToSend")
      enableJumpVolumeAvailability("dbc_courtyard_01a_art.prefab_jumpvolumeavailability 02.TargetToSend")
      enableJumpVolumeAvailability("dbc_courtyard_01a_art.prefab_jumpvolumeavailability 03.TargetToSend")
      enableJumpVolumeAvailability("dbc_courtyard_01a_art.prefab_jumpvolumeavailability 04.TargetToSend")
      enableJumpVolumeAvailability("dbc_courtyard_01a_art.prefab_jumpvolumeavailability 05.TargetToSend")
      FireSequence("DBC_GusConversationTrigger", "DBC_Gus_SecondTower", 0)
      SetGlobal("DBC_Gus_SecondTower_Played", 1)
      Enable("FallingTowerCollision")
      ActivateGremlinHint("GusHintCourtyard1")
      AnimGBSequence(target, "fallen")
      OswaldStartMovingAction()
      AddPhysicsToWorld("FallenTowerSteps")
      if (LevelManager_GetCurrentState() == "darkbeautycastle_v1.stream_3") then
        LevelManager_SetCurrentState("DarkBeautyCastle_V1.Stream_4")
        AnimGBSequence("CourtyardRubble1", "fall")
        AudioPostEventOn("dbc_courtyard_01a_audio.SND_Courtyard_Rubble", "Play_sfx_Courtyard_Rubble")
        AnimGBSequence("DBC_Electric_TopExit", "closed2")
      end
    end
  elseif (step == "two") then
    Enable("BuddyActionCoopGlide3")
  end
  return 
end
DBC_Courtyard_BlotworxDoorOpen = function(target)
  DBC_BlotworxDoor = 1
  ClearNextPatrolNode(target)
  AnimGBSequence("CourtyardDoor", "Open")
  return 
end
DBC_SpatterLookAt = 0
DBC_Courtyard_ParentTriggers = function(target, enemy)
  if (enemy == "spatter") then
    if (DBC_SpatterLookAt == 0) then
      DBC_SpatterLookAt = 1
      TeleportToEntity("SpatterLookAtTrigger", target)
      SetParentEntity("SpatterLookAtTrigger", target)
    end
  elseif (enemy == "blocker") then
    TeleportToEntity("BlockerLookAtTrigger", target)
    SetParentEntity("BlockerLookAtTrigger", target)
  end
  return 
end
DBC_StartTowerFallCamera = function()
  FireUser1("DBC_CourtTowerFallStartCam")
  return 
end
DBC_CourtTowerFallingAction = function()
  FireUser1("DBC_CourtTowerFallingCamera")
  return 
end
DBC_CourtExitCamStop = function()
  FireSequence("DBC_GusConversationTrigger", "DBC_Gus_FoundTrainQuest", 0)
  return 
end
DBC_StopCourtEnemyCam = function()
  FireUser3("DBC_CourtShowEnemies")
  Wait(2)
  return 
end
DBC_Court_BreakMeleeDoors = function(target)
  if (GetGlobal("DBC_Gus_CourtStage3_Played") == 0) then
    DestroyEntity(target)
    ForceSpawn("DBC_BlotworxSpawner", 1)
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_CourtStage3", 0)
  end
  return 
end
DBC_EndBobIntroCam = function()
  FireUser3("DBC_BobEntranceCamera")
  return 
end
DBC_GlidePositionCheck = 0
DBC_CoopGlideTutorial = function(target, step, action)
  if (step == "one") then
    if (GetNumPlayers() == 2) then
      DBC_ManageIcons(nil, "unhide", "MickeyPermissionIcon")
    end
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_HowToCoopGlide", 0)
    Disable("BuddyActionCoopGlide3")
    Enable("BuddyActionCoopGlide2")
    ActivateGremlinHint("GusHintCourtyard2")
    Wait(0.6000000238418579)
    SetGlobal("DBC_GlideTutorialCheck", 1)
  elseif (step == "two") then
    if (GetNumPlayers() == 2) then
      DBC_ManageIcons(nil, "hide", "MickeyPermissionIcon")
    end
    SetGlobal("DBC_GlideTutorialCheck", 2)
    FireSequence("DBC_GusConversationTrigger", "DBC_Gus_HowToCoopGlide2", 0)
    AudioPostEventOn(GetPlayer(), "Play_vox_Oswald_effort")
    QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Wait_For_Attach, GetPosition("CoopGlideDestination"))
    OswaldStartFollowAction()
    Wait(7)
  elseif (step == "three") then
    if (_activator() == GetPlayer()) then
      if (action == "enter") then
        DBC_GlidePositionCheck = 1
        if (GetGlobal("DBC_GlideTutorialCheck") == 1) then
          if (GetNumPlayers() == 2) then
            DBC_ManageIcons(nil, "unhide", "MickeyPermissionIcon")
            FireSequence("ConversationMarkerTutorial", "Tutorial_OswaldPermissionTraining", 0)
          end
        end
      elseif (action == "exit") then
        DBC_GlidePositionCheck = 0
        if (GetNumPlayers() == 2) then
          DBC_ManageIcons(nil, "hide", "MickeyPermissionIcon")
        end
        DismissTextBox()
        if (step == "four") then
          if (GetGlobal("DBC_GlideTutorialCheck") == 1) then
            SetGlobal("DBC_GlideTutorialCheck", 2)
            ForceInterruptSequence("DBC_GusConversationTrigger", "DBC_Gus_HowToCoopGlide2")
          end
        elseif (step == "five") then
          if (DBC_GlidePositionCheck == 1) then
            if (GetNumPlayers() == 2) then
              DBC_ManageIcons(nil, "unhide", "MickeyPermissionIcon")
              FireSequence("ConversationMarkerTutorial", "Tutorial_OswaldPermissionTraining", 0)
            end
          end
        end
      end
    end
  elseif (step == "four") then
    if (GetGlobal("DBC_GlideTutorialCheck") == 1) then
      SetGlobal("DBC_GlideTutorialCheck", 2)
      ForceInterruptSequence("DBC_GusConversationTrigger", "DBC_Gus_HowToCoopGlide2")
    end
  elseif (step == "five") then
    if (DBC_GlidePositionCheck == 1) then
      if (GetNumPlayers() == 2) then
        DBC_ManageIcons(nil, "unhide", "MickeyPermissionIcon")
        FireSequence("ConversationMarkerTutorial", "Tutorial_OswaldPermissionTraining", 0)
      end
    end
  end
  return 
end
DBC_TowerFallStart = function()
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  Wait(0.5)
  AnimGBSequence("DBC_CourtyardTowerAnim", "fall")
  return 
end
DBC_CoopGlideResetVar = 4
DBC_ResetOswaldCheck = function()
  Wait(1)
  OswaldSetPathAction("DBC_OswaldCoopGlidePatrol")
  return 
end
DBC_OswaldHasJumpedCoop = function()
  DBC_CoopGlideResetVar = 1
  Enable("DBC_SafetyNetTrigger")
  return 
end
DBC_OswaldJumpBackCoopGlide = function(target)
  Print("OSWALD REACHED OTHER SIDE")
  if (_activator() == GetOswaldAI()) then
    if (0 < DBC_CoopGlideResetVar) then
      Disable("DBC_SafetyNetTrigger")
      OswaldSetPathAction("DBC_OswaldJumpBackToStartCoop")
    end
  end
  return 
end
DBC_MickeyFellCoop = function()
  DBC_CoopGlideResetVar = 2
  return 
end
DBC_OswaldJumpBackToStartCoop = function()
  OswaldGlideAction("DBC_OswaldCoopGlideMarker")
  return 
end
DBC_GoToTrainNode = function()
  OswaldSetPathAction("DBC_OswaldJumpToTrain")
  return 
end
DBC_MakeOswaldJumpTrain = function()
  OswaldJumpAction("DBC_OswaldToTrainMarker")
  return 
end
DBC_TrainOswaldVar = 0
DBC_TrainMickeyVar = 0
DBC_TrainStationEnter_Mickey = function()
  DBC_TrainMickeyVar = 1
  DBC_TrainStream_Master()
  return 
end
DBC_TrainStationExit_Mickey = function()
  DBC_TrainMickeyVar = 0
  return 
end
DBC_TrainStationEnter_Oswald = function()
  DBC_TrainOswaldVar = 1
  DBC_TrainStream_Master()
  return 
end
DBC_TrainStationExit_Oswald = function()
  DBC_TrainOswaldVar = 0
  return 
end
DBC_TrainStream_Master = function()
  if (DBC_TrainOswaldVar == 1) then
    if (DBC_TrainMickeyVar == 1) then
      AnimGBSequence("DBC_TrainStationDoor", "Close")
      Print("+_+_+_+_+_+_+_+Streaming State 6, adding IGC layer")
      LevelManager_SetCurrentState("DarkBeautyCastle_V1.Stream_6")
    end
  end
  return 
end
DBC_Train03Stop = function()
  FireUser3("DBC_TrainCam02")
  return 
end
DBC_RubbleState = 0
DBC_CrossStreamsRubble = function(target, _event)
  if StimulusEvent_HasStimulusType(_event, ST_CROSSED_STREAM) then
    if (DBC_RubbleState == 0) then
      Disable("FireworksCheckTrigger2")
      DBC_ManageIcons(nil, "hide", "MickeyPermissionIcon")
      DismissTextBox()
      DBC_RubbleState = 1
      AnimGBSequence("DBC_TrainRubble", "explode", true)
      StartEmitters("TrainRubbleExplodeFX")
      Print("Music DBC_CrossStreamsRubble")
      Wait(2)
      StopEmitters("TrainRubbleExplodeFX")
    end
  end
  return 
end
DBC_TrainStation_IGCIntro = function()
  TimerDisable("FireworksPromptTimer")
  ForEachEntityInGroup(Unhide, "IGCCharacterGroup")
  DismissTextBox()
  Wait(1)
  DismissTextBox()
  PlayIGC("IGC_0070_TrainExit")
  return 
end
PostIGC_0070_TrainExit = function()
  Print("+_+_+_+_+_+_+_+_+_+_+_+_+_+ IGC Cleanup function")
  SetGlobal("MSN_TrainSceneFinished", 1)
  DismissTextBox()
  Wait(0.10000000149011612)
  LoadLevel(GetPlayer(), "MeanStreet_South.Visit1")
  return 
end
DBC_OswaldReachTrainNode = function()
  Wait(1)
  DBC_MoveToMS()
  return 
end
DBC_TrainStation_LoadCheck = function()
  if (LevelManager_GetCurrentState() == "darkbeautycastle_v1.stream_3") then
    if (GetGlobal("DBC_Gus_SecondTower_Played") == 1) then
      LevelManager_SetCurrentState("DarkBeautyCastle_V1.Stream_4")
    end
  end
  return 
end
DBC_TrainStation_ReachOrtensia = function()
  OswaldStopMovingAction()
  Wait(0.20000000298023224)
  return 
end
local ReachDoorBusy = 0
DBC_TrainStation_ReachDoor = function(target, step)
  Print("+_+_+_+_+_+_+_+_+_+ Hit train station door")
  if (step == "one") then
    if (LevelManager_GetCurrentState() == "darkbeautycastle_v1.stream_4") then
      if (ReachDoorBusy == 0) then
        ReachDoorBusy = 1
        Print("+_+_+_+_+_+_+_+_+_+ Opening train station door")
        DestroyEntity(target)
        AnimGBSequence("DBC_TrainStationDoor", "Open")
        RestrictCutSceneInput()
        Enable("BuddyActionFaceOrtensia")
        DoStinger("Stinger_Success", 2)
        Print("Found Ortensia music stinger")
        wait(1)
        FireUser1("ArrivedAtStationGrabCamera")
        wait(0.4000000059604645)
        TeleportToEntity(GetPlayer(), "TrainSpawnMarker1")
        TeleportToEntity(GetPlayer2OrAI(), "TrainSpawnMarker2")
        AnimGBSequence("DBC_TrainStationDoor", "Rest")
        Disable("BuddyActionFaceOrtensia")
        wait(1)
        FireSequence("OrtensiaTrainStation", "DBC_Ortensia_Exit", 0)
      end
    end
  elseif (step == "three") then
    local data = GetPrefabData(target)
    data.DispenserActive = "True"
    ShakeCamera(1.2999999523162842, 7, 0.5, 0.4000000059604645, 0.009999999776482582, 0.0020000000949949026)
    FireThread(DBC_EarthquakeSFX)
    Wait(0.30000001192092896)
    Prefab_FireworksDispenserTriggered(target)
    Wait(1.7999999523162842)
    FireUser1("ArrivedAtStationGrabCamera2")
  elseif (step == "four") then
    FireUser3("ArrivedAtStationGrabCamera3")
    Quest_SetCriticalPath("Critical_DBC", "Critical_DBC_9")
    UnrestrictCutSceneInput()
    TimerEnable("FireworksPromptTimer")
    SetPropertyFloat("OrtensiaTrainStation", "UsableRadius", 2)
    DBC_Checkpoint_Save("nothing", "train")
    DBC_DestroyChestIcons()
  end
  return 
end
DBC_TrainStationAfterDoor = function()
  Rumble(nil, 0.699999988079071)
  Rumble(nil, 0.699999988079071, 1)
  ShakeCamera(2.0999999046325684, 3.299999952316284, 1, 0.18000000715255737, 0.019999999552965164, 0.019999999552965164)
  FireThread(DBC_EarthquakeSFX)
  LevelManager_SetCurrentState("DarkBeautyCastle_V1.Stream_6")
  Disable("BuddyActionFaceOrtensia")
  SetGlobal("DBC_TrainState", 2)
  SetPropertyFloat("OrtensiaTrainStation", "UsableRadius", 0)
  Wait(1)
  FireSequence("OrtensiaTrainStation", "DBC_Ortensia_Train02", 0)
  return 
end
DBC_PlacedFireworks = "none"
DBC_TrainStation_ShockFireworks = function(target, action)
  if (action == "shock") then
    OswaldStreamAction("FireworksTargetMarker")
  elseif (action == "place") then
    SetGlobal("DBC_TrainState", 3)
    DBC_PlacedFireworks = GetName(_activator())
    SetPropertyFloat(DBC_PlacedFireworks, "UsableRadius", 0)
    if (GetNumPlayers() == 2) then
      if (DBC_FireworksTriggerOswald == 1) then
        DBC_ManageIcons(nil, "unhide", "DBC_OverheadIconB")
      end
    end
    Wait(2)
    SetPropertyFloat(DBC_PlacedFireworks, "UsableRadius", 2)
  elseif (action == "remove") then
    SetGlobal("DBC_TrainState", 2)
    DBC_PlacedFireworks = "none"
  elseif (action == "parent") then
    local FireworksLoc = GetPosition(target)
    SetTransformation("FireworksTargetMarker", vector4(FireworksLoc.x, (FireworksLoc.y + 1.100000023841858), FireworksLoc.z), vector4(0, 0, 0))
    SetParentEntity("FireworksTargetMarker", target)
  end
  return 
end
DBC_FireworksTriggerMickey = 0
DBC_FireworksTriggerOswald = 0
DBC_TrainStation_MickeyFireworksCheck = function(target, action, variable)
  if (GetName(_activator()) == GetName(GetPlayer())) then
    if (action == "enter") then
      DBC_FireworksTriggerMickey = 1
    elseif (action == "exit") then
      DBC_FireworksTriggerMickey = 0
      if (GetName(_activator()) == GetName(GetPlayer2())) then
        if (action == "enter") then
          DBC_FireworksTriggerOswald = 1
        elseif (action == "exit") then
          DBC_FireworksTriggerOswald = 0
        end
      end
    end
  elseif (GetName(_activator()) == GetName(GetPlayer2())) then
    if (action == "enter") then
      DBC_FireworksTriggerOswald = 1
    elseif (action == "exit") then
      DBC_FireworksTriggerOswald = 0
    end
  end
  if (action == "enter") then
    if (DBC_PlacedFireworks ~= "none") then
      if (GetName(_activator()) ~= GetName(GetPlayer())) then
        if (GetName(_activator()) == GetName(GetPlayer2())) then
          DBC_ManageIcons(nil, "unhide", "DBC_OverheadIconB")
          if (action == "exit") then
            if (GetName(_activator()) == GetName(GetPlayer())) then
              DBC_ManageIcons(nil, "hide", "MickeyPermissionIcon")
              if (GetNumPlayers() == 1) then
                DismissTextBox()
              end
            else
            end
          end
        end
      end
    end
  elseif (action == "exit") then
    if (GetName(_activator()) == GetName(GetPlayer())) then
      DBC_ManageIcons(nil, "hide", "MickeyPermissionIcon")
      if (GetNumPlayers() == 1) then
        DismissTextBox()
      end
    else
    end
  end
  return 
end
DBC_FireworksPromptCheck = function()
  if (IsAnySequencePlaying() == false) then
    FireSequence("dbc_courtyard_01a_shared.ConversationalTrigger 01", "DBC_Gus_Train02", 0)
  end
  return 
end
DBC_FireworksBuddyActionReset = function()
  Disable("BuddyActionFireworks")
  ClearParent("FireworksTargetMarker")
  DBC_ManageIcons(nil, "hide", "MickeyPermissionIcon")
  return 
end
DBC_RespawnFireworksOnFallingOut = function()
  FireThread(Prefab_ClearFireworksFromScene, "SpawnedFireworks")
  return 
end
DBC_TrainPositionMickey = 0
DBC_TrainPositionOswald = 0
DBC_TrainStation_ManagePlayerPosition = function(target, direction)
  if (GetName(_activator()) == GetName(GetPlayer())) then
    if (direction == "forward") then
      DBC_TrainPositionMickey = 1
    else
      DBC_TrainPositionMickey = 0
      if (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
        if (direction == "forward") then
          DBC_TrainPositionOswald = 1
        else
          DBC_TrainPositionOswald = 0
        end
      end
    end
  elseif (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
    if (direction == "forward") then
      DBC_TrainPositionOswald = 1
    else
      DBC_TrainPositionOswald = 0
    end
  end
  if (GetGlobal("DBC_TrainState") == 1) then
    DBC_TrainStation_ReachDoor(nil, "two")
  end
  return 
end
DBC_CauseQuakeShake_bak = function()
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  ForceSpawn("DBC_RubbleSpawn01", 1)
  ForceSpawn("DBC_RubbleSpawn04", 1)
  ForceSpawn("DBC_RubbleSpawn05", 1)
  ForEachEntityInGroup(StartEmitters, "DBC_Dust_All")
  Wait(1)
  ForceSpawn("DBC_RubbleSpawn02", 1)
  ForceSpawn("DBC_RubbleSpawn03", 1)
  ForceSpawn("DBC_RubbleSpawn06", 1)
  Wait(2)
  ForEachEntityInGroup(StopEmitters, "DBC_Dust_All")
  return 
end
DBC_CourtShakeCamera = function()
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  DBC_EarthquakeSFX()
  return 
end
DBC_AmbientCameraShake_Bak = function()
  local x = math.random(1, 2)
  if (x == 1) then
    ShakeCamera(3, 10, 0.5, 1.75, 0.004999999888241291, 0.004999999888241291)
  elseif (x == 2) then
    ShakeCamera(4, 8, 0.75, 1, 0.006000000052154064, 0.006000000052154064)
  end
  ForceSpawn("DBC_RubbleSpawn01", 1)
  ForceSpawn("DBC_RubbleSpawn04", 1)
  ForceSpawn("DBC_RubbleSpawn05", 1)
  ForEachEntityInGroup(StartEmitters, "DBC_Dust_All")
  Wait(1)
  ForceSpawn("DBC_RubbleSpawn02", 1)
  ForceSpawn("DBC_RubbleSpawn03", 1)
  ForceSpawn("DBC_RubbleSpawn06", 1)
  Wait(2)
  ForEachEntityInGroup(StopEmitters, "DBC_Dust_All")
  return 
end
DBC_DefaultCameraSettings = function()
  SetDefaultCameraValues(5.5, 7, 12)
  SetTravelCameraValues(7.5, 15, -7)
  return 
end
DBC_IntersectionCameraClear = function()
  SetDefaultCameraValues(4.5, 16, -13)
  SetTravelCameraValues(7.5, 25, -20)
  return 
end
DBC_IntersectionCameraSet = function()
  SetDefaultCameraValues(10, 10, 14)
  SetTravelCameraValues(12, 18, -9)
  return 
end
DBC_RemoteFXTest = function()
  ForceSpawn("DBC_RemoteMachineSpawner01", 1)
  return 
end
DBC_MakeTowerFallOver = function()
  if (GetGlobal("DBC_CourtTowerFall") == 0) then
    SetGlobal("DBC_CourtTowerFall", 1)
    AnimGBSequence("DBC_FallingCourtyardTower", "fall")
    OswaldStartFollowAction()
  end
  return 
end
DBC_LoadCheckpoint = function()
  if (GetGlobal("MusicState") == 1) then
    ReplaceMusicStateOverride("DBC_1_Start")
    Print("Spawned and set music state to 1")
  elseif (GetGlobal("MusicState") == 2) then
    ReplaceMusicStateOverride("DBC_2_1stFloor")
    Print("Spawned and set music state to 2")
  elseif (GetGlobal("MusicState") == 3) then
    ReplaceMusicStateOverride("DBC_3_Hallway")
    Print("Spawned and set music state to 3")
  elseif (GetGlobal("MusicState") == 4) then
    ReplaceMusicStateOverride("DBC_4_Lab")
    Print("Spawned and set music state to 4")
  elseif (GetGlobal("MusicState") == 5) then
    ReplaceMusicStateOverride("DBC_5_Courtyard")
    Print("Spawned and set music state to 5")
  end
  return 
end
DBC_Checkpoint_Save = function(target, location)
  Wait(0.5)
  if (location == "entrance") then
    SetGlobal("MusicState", 1)
    ReplaceMusicStateOverride("DBC_1_Start")
    Print("Set MusicState Global var to 1, set state accordingly")
    SaveCheckpoint(GetPlayer(), "DBC_Checkpoint_Hallway", "DBC_CheckPointMarker_Entrance", "DBC_HallwayMickeyStart")
  elseif (location == "balcony") then
    SetGlobal("MusicState", 2)
    Print("Set MusicState Global var to 2")
    SaveCheckpoint(GetPlayer(), "DBC_Checkpoint_Balcony", "DBC_CheckPointMarker_Balcony")
  elseif (location == "underhall") then
    SetGlobal("MusicState", 3)
    Print("Set MusicState Global var to 3")
    SaveCheckpoint(GetPlayer(), "DBC_ExitUnderhall", "DBC_OswaldUnderMarker")
  elseif (location == "electric") then
    SetGlobal("MusicState", 4)
    Print("Set MusicState Global var to 4")
    SaveCheckpoint(GetPlayer(), "DBC_CheckpointLoad_Electric", "DBC_CheckPointMarker_ElectricalRoom01")
  elseif (location == "courtyard") then
    SetGlobal("MusicState", 5)
    Print("Set MusicState Global var to 5")
    SaveCheckpoint(GetPlayer(), "DBC_CheckpointLoad_Courtyard", "DBC_MickeyBobMarker")
  elseif (location == "courtbalcony") then
    SetGlobal("MusicState", 5)
    Print("Set MusicState Global var to 5")
    SaveCheckpoint(GetPlayer(), "DBC_CheckpointLoad_Courtyard", "DBC_CheckpointMarker_CourtBalcony1", "DBC_CheckpointMarker_CourtBalcony2")
  elseif (location == "train") then
    SaveCheckpoint(GetPlayer(), "DBC_CheckpointLoad_Train", "TrainSpawnMarker1", "TrainSpawnMarker2")
  end
  return 
end
DBC_ElectricalRoomCheckpointDetermine = function()
  if (GetGlobal("DBC_CourtTowerFall") == 1) then
    DBC_Checkpoint_Save(nil, "courtyard")
  else
    DBC_Checkpoint_Save(nil, "electric")
  end
  return 
end
DBC_CourtyardCheckpointDetermine = function(location)
  if (GetGlobal("DBC_TrainState") == 0) then
    if (location == "ground") then
      DBC_Checkpoint_Save(nil, "courtyard")
    elseif (location == "balcony") then
      DBC_Checkpoint_Save(nil, "courtbalcony")
      DBC_Checkpoint_Save(nil, "train")
    end
  else
    DBC_Checkpoint_Save(nil, "train")
  end
  return 
end
DBC_Checkpoint_Hallway = function()
  if (DBC_IntroShotCheck == 0) then
    RestrictCutSceneInput()
  end
  EnablePlayer(PLAYER_TWO, true)
  EnableSplitScreen(true)
  TeleportToEntity(GetPlayer2OrAI(), "DBC_HallwayMickeyStart")
  SetDefaultCameraValues(5.5, 4, 3)
  SetTravelCameraValues(7.5, 6, 3)
  Wait(0.10000000149011612)
  DBC_UnlockOswaldAbilities("initial")
  HidePlayerTool(PLAYER_TWO)
  FireThread(DBC_LoadCheckpoint)
  Wait(0.4000000059604645)
  SetNextPatrolNode("DBC_Ortensia", "dbc_hallway_01a_scripting.Hallway_OrtensiaRun_Node 01")
  DBC_AmbientEarthquake()
  FireSequence("DBC_GusConversationTrigger", "DBC_Gus_AskOswaldToJoin", 0)
  return 
end
DBC_Checkpoint_Balcony = function()
  DBC_LoadCheckpoint()
  enableJumpVolumeAvailability("dbc_hallway_01a_art.prefab_jumpvolumeavailability 01.TargetToSend")
  enableJumpVolumeAvailability("dbc_hallway_01a_art.prefab_jumpvolumeavailability 02.TargetToSend")
  enableJumpVolumeAvailability("dbc_hallway_01a_art.prefab_jumpvolumeavailability 03.TargetToSend")
  return 
end
DBC_CheckpointLoad_Electric = function()
  DBC_LoadCheckpoint()
  DisableComponent("ElectricRoomTurnstile", "Coop Movable Component")
  if (GetGlobal("DBC_ElectricRoomPower") == 0) then
    Enable("BuddyActionBeamTraining1")
    ActivateGremlinHint("GusHintElectric1")
    SetCameraAttributesForPlayer("ElectricMachineCamera01")
  elseif (GetGlobal("DBC_ElectricRoomPower") == 1) then
    ActivateGremlinHint("GusHintElectric2")
    SetCameraAttributesForPlayer("ElectricMachineCamera02")
    Prefab_OswaldElectricSwitch_ChangeState("FirstMachineSwitch", "FullyCharged")
    Wait(0.10000000149011612)
    StartEmitters("LabMachineSparks1")
    SetPropertyFloat("LabMachinePullHandle", "UsableRadius", 3.5)
  elseif (GetGlobal("DBC_ElectricRoomPower") == 2) then
    ActivateGremlinHint("GusHintElectric3")
    SetCameraAttributesForPlayer("ElectricMachineCamera03")
    Wait(0.10000000149011612)
    StartEmitters("LabMachineSparks1")
    StartEmitters("LabMachineSparks2")
    StartEmitters("LabMachineSparks3")
    Prefab_OswaldElectricSwitch_ChangeState("FirstMachineSwitch", "FullyCharged")
    ForEachEntityInGroup(Prefab_OswaldElectricSwitch_ChangeState, "SecondMachineSwitchGroup", "FullyCharged")
  elseif (GetGlobal("DBC_ElectricRoomPower") == 3) then
    StartEmitters("LabMachineSparks1")
    StartEmitters("LabMachineSparks2")
    StartEmitters("LabMachineSparks4")
    Prefab_OswaldElectricSwitch_ChangeState("FirstMachineSwitch", "FullyCharged")
    ForEachEntityInGroup(Prefab_OswaldElectricSwitch_ChangeState, "SecondMachineSwitchGroup", "FullyCharged")
    Prefab_OswaldElectricSwitch_ChangeState("ThirdMachineSwitch", "FullyCharged")
  elseif (GetGlobal("DBC_ElectricRoomPower") == 4) then
    StartEmitters("LabMachineSparks1")
    StartEmitters("LabMachineSparks2")
    Prefab_OswaldElectricSwitch_ChangeState("FirstMachineSwitch", "FullyCharged")
    ForEachEntityInGroup(Prefab_OswaldElectricSwitch_ChangeState, "SecondMachineSwitchGroup", "FullyCharged")
    Prefab_OswaldElectricSwitch_ChangeState("ThirdMachineSwitch", "FullyCharged")
    if (GetGlobal("Beauty_Thin_Deep_Pin") == 0) then
      Unhide("ThinDeepPin")
    end
  end
  return 
end
DBC_CheckpointLoad_Courtyard = function()
  if (LevelManager_GetCurrentState() == "darkbeautycastle_v1.stream_3") then
    LevelManager_SetCurrentState("DarkBeautyCastle_V1.Stream_4")
  end
  DBC_LoadCheckpoint()
  AnimGBSequence("DBC_CourtyardTowerAnim", "restFallen", true)
  AnimGBSequence("CourtyardRubble1", "fall")
  AnimGBSequence("DBC_Electric_TopExit", "closed2")
  DBC_CourtCamSequenceStart()
  return 
end
DBC_CheckpointLoad_Train = function()
  local data = GetPrefabData("DBC_FireworksDispenser")
  data.DispenserActive = "True"
  DBC_LoadCheckpoint()
  DBC_TrainPositionMickey = 1
  DBC_TrainPositionOswald = 1
  TimerEnable("Timer_TrainEarthquake")
  TimerDisable("Timer_AmbientEarthquake")
  TimerEnable("FireworksPromptTimer")
  DBC_DestroyChestIcons()
  return 
end
