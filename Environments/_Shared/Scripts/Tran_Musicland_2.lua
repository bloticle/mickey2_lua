Musicland2_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
Musicland2_CheckAtStart = function()
  ResetMusicEvent()
  Print("Restoration***********************CheckAtStart Fired")
  if (HasCollectible("FilmReel_EM2_MusicLand2") == true) then
    if (AlreadyCheckedFilmReel == false) then
      Musicland2_Pickups = (Musicland2_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_MusicLand")
    MusicEventVar = 1
    Print("Restoration***********************Started music event")
  end
  wait(1)
  if (Musicland2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Restoration***********************Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Restoration***********************Playing bad music state")
  end
  return 
end
Musicland2_CountTicket = function()
  Print("Restoration***********************one ticket still here")
  Musicland2_Pickups = (Musicland2_Pickups + 1)
  return 
end
Musicland2_CheckOnPickup = function()
  Print("Restoration***********************Picked up item")
  Musicland2_Pickups = (Musicland2_Pickups - 1)
  if (Musicland2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Restoration***********************Playing good music state")
  end
  return 
end
Musicland2_2DTransitionSetup = function(target)
  Print("***Musicland2_2DTransitionSetup")
  local data = GetPrefabData(target)
  local visit = "2"
  local global = GetGlobal("EM2_EpisodeCheck")
  Print(("Musicland2_2DTransitionSetup: Episode " .. global))
  if (data.Film_Position == "Left") then
    Print("Musicland2_2DTransitionSetup: Film_Position = Left so we are Heading to Train Tunnels")
    if (global < 3) then
      visit = "1"
    end
    data.ActivatedLevels = ("TRT_TrainTunnels.BlotV" .. visit)
  elseif (data.Film_Position == "Right") then
    Print("Musicland2_2DTransitionSetup: Film_Position = Right so we are Heading to Fort Wasteland")
    if (global == 1) then
      SetGlobal("EM2_EpisodeCheck", 2)
    end
    if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
      data.ActivatedLevels = "FTL_fort01a.V1_Docks_ALTrees"
    else
      data.ActivatedLevels = "FTL_fort01a.V2_Docks_ALTrees"
    end
  end
  SetupPosition(target)
  return 
end
local OswaldMadeIt = false
Musicland2_SaxophoneShortcut = function(player, setting)
  if (setting == "plyr") then
    Prefab_MultiTrack_DisableControls("Musicland2Override", player)
    SetCameraAttributesForPlayer("trn_musicland_02a.Marker(CameraOverride) 01", player)
    Enable("trn_musicland_02a.CameraControlPointSplineFollower 01")
    wait(1.7999999523162842)
    AnimGBSequence("trn_musicland_02a.TRN_musicland_star_02a 01", "action")
    wait(0.20000000298023224)
    if (player == GetPlayer()) then
      SetMickeyPlaneWithTeleport("Musicland2Override", 0, "trn_musicland_02a.SplineKnot 04")
    else
      SetOswaldPlaneWithTeleport("Musicland2Override_Oswald", 0, "trn_musicland_02a.SplineKnot 04")
    end
    wait(1)
    ClearCameraAttributesForPlayer("trn_musicland_02a.Marker(CameraOverride) 01", player)
    Prefab_MultiTrack_EnableControls("Musicland2Override", player)
    Prefab_MultiTrack_EnableToss("Musicland2Override")
  elseif (setting == "oswaldMadeIt") then
    OswaldMadeIt = true
    OswaldStopMovingAction()
    SetOswaldPlaneWithTeleport("Musicland2Override_Oswald", 0, "trn_musicland_02a.SplineKnot 04")
    wait(0.10000000149011612)
    OswaldStartFollowAction()
    Prefab_MultiTrack_EnableControls("Musicland2Override", player)
    Prefab_MultiTrack_EnableToss("Musicland2Override")
  else
    Prefab_MultiTrack_DisableControls("Musicland2Override", player)
    AnimGBSequence("trn_musicland_02a.TRN_musicLand_poise02_02a 01", "action")
    AnimGBSequence("trn_musicland_02a.TRN_musicland_Windnew_02a 01", "idle")
    AnimGBSequence("trn_musicland_02a.TRN_musicLand_saxlid_02a 01", "action")
    Enable("trn_musicland_02a.TriggerBase 03")
    wait(0.5)
    OswaldJumpAction("trn_musicland_02a.PatrolNode 01")
    wait(1.2999999523162842)
    AnimGBSequence("trn_musicland_02a.TRN_musicland_star_02a 01", "action")
    wait(0.20000000298023224)
    if (OswaldMadeIt == false) then
      OswaldStopMovingAction()
      SetOswaldPlaneWithTeleport("Musicland2Override_Oswald", 0, "trn_musicland_02a.SplineKnot 04")
      wait(0.10000000149011612)
      OswaldStartFollowAction()
      Prefab_MultiTrack_EnableControls("Musicland2Override", player)
      Prefab_MultiTrack_EnableToss("Musicland2Override")
    end
  end
  return 
end
local Musicland2_DoorOpened = 0
Musicland2_DoorOpen = function(character)
  if (Musicland2_DoorOpened == 0) then
    Musicland2_DoorOpened = 2
    AnimGBSequence("trn_musicland_02a.TRN_musicLand_door_02a 01", "action")
    wait(1)
    resumeJumpVolumeWait("trn_musicland_02a.prefab_jumpvolumeavailability 03.TargetToSend")
    Musicland2_DoorOpened = 1
    if (character == GetPlayer()) then
      Enable("trn_musicland_02a.TriggerBase 04")
    else
      Enable("trn_musicland_02a.TriggerBase 04_Oswald")
    end
  end
  return 
end
Musicland2_DoorClose = function()
  if (Musicland2_DoorOpened == 1) then
    Musicland2_DoorOpened = 2
    pauseJumpVolumeWait("trn_musicland_02a.prefab_jumpvolumeavailability 03.TargetToSend")
    AnimGBSequence("trn_musicland_02a.TRN_musicLand_door_02a 01", "close")
    Disable("trn_musicland_02a.TriggerBase 07")
    wait(1)
    Musicland2_DoorOpened = 0
    Enable("trn_musicland_02a.TriggerBase 07")
  end
  return 
end
Music2_CheckTracks = function()
  Print("Music2_CheckTracks function entered")
  while true do
    wait(0)
  end
  Print(("Music2_CheckTracks 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
  if (string.sub(tostring(GetGlobal("2dDirection")), -1, -1) == "1") then
    Disable("Music2_HiddenOswaldPlaneTrigger")
    ForEachEntityInGroup(Enable, "Music2_DrumPlaneTrigger")
  else
    Enable("Music2_HiddenOswaldPlaneTrigger")
    ForEachEntityInGroup(Disable, "Music2_DrumPlaneTrigger")
    if (GetEntity("trn_musicland_02a.ETicket_Oswald_NIF 02") ~= nil) then
      Enable("trn_musicland_02a.hiddenoswald_action 02.Marker(BuddyAIAction) 01")
    end
  end
  return 
end
local DrumJumpActive = false
local DrumJumpState = 0
Music2_DrumJumpAI = function()
  Print("Music2_DrumJumpAI function entered")
  while true do
    Print(((("Music2_DrumJumpAI repeat, DrumJumpState is " .. tostring(DrumJumpState)) .. ", DrumJumpActive is ") .. tostring(DrumJumpActive)))
    local posOswald = GetPosition(GetPlayerOrAI(PLAYER_TWO))
    local posDrumLidLeft = GetPosition("DrumLidLeft")
    local posDrumLidRight = GetPosition("DrumLidRight")
    posOswald = posOswald.z
    posDrumLidLeft = posDrumLidLeft.z
    posDrumLidRight = posDrumLidRight.z
    if (posOswald < posDrumLidLeft) then
      if (DrumJumpState ~= 1) then
        DrumJumpState = 1
        enableJumpVolumeAvailability("Music2_DrumJump1")
        disableJumpVolumeAvailability("Music2_DrumJump2")
        disableJumpVolumeAvailability("Music2_DrumJump3")
        disableJumpVolumeAvailability("Music2_DrumJump4")
        disableJumpVolumeAvailability("Music2_DrumJump4_2")
        Print("Music2_DrumJumpAI state 1")
      end
    elseif (posOswald < posDrumLidRight) then
      if (DrumJumpState ~= 23) then
        DrumJumpState = 23
        enableJumpVolumeAvailability("Music2_DrumJump2")
        enableJumpVolumeAvailability("Music2_DrumJump3")
        disableJumpVolumeAvailability("Music2_DrumJump1")
        disableJumpVolumeAvailability("Music2_DrumJump4")
        disableJumpVolumeAvailability("Music2_DrumJump4_2")
        Print("Music2_DrumJumpAI state 23")
      end
    elseif (DrumJumpState ~= 4) then
      DrumJumpState = 4
      enableJumpVolumeAvailability("Music2_DrumJump4")
      enableJumpVolumeAvailability("Music2_DrumJump4_2")
      disableJumpVolumeAvailability("Music2_DrumJump1")
      disableJumpVolumeAvailability("Music2_DrumJump2")
      disableJumpVolumeAvailability("Music2_DrumJump3")
      Print("Music2_DrumJumpAI state 4")
    end
    wait(0.10000000149011612)
  end
  Print("Music2_DrumJumpAI end loop")
  for x = 1, 4 do
    x = tostring
    x = x(x)
    enableJumpVolumeAvailability(("Music2_DrumJump" .. x))
  end
  DrumJumpState = 0
  return 
end
Music2_SetDrumJumpState = function(target, state)
  Print("Music2_SetDrumJumpState function entered")
  if (state == "on") then
    DrumJumpActive = true
    FireThread(Music2_DrumJumpAI)
  else
    Print("Music2_SetDrumJumpState DrumJumpActive set false")
    DrumJumpActive = false
  end
  return 
end
Music2_SpecialToggle_JVW4 = function(target, state)
  if (state == "pause") then
    SetUserEdgeWaiting("Environments/_Design/TrainTunnels/TRT_dioramas_01a_2DFilmStrip_ToGulch2.gsa", "Music2_SpecialToggle_JVW4", true)
  else
    SetUserEdgeWaiting("Environments/_Design/TrainTunnels/TRT_dioramas_01a_2DFilmStrip_ToGulch2.gsa", "Music2_SpecialToggle_JVW4", false)
  end
  return 
end
Musicland2_ManageOswaldAssistMickey = function(target, action, node1)
  Print("***Musicland2_ManageOswaldAssistMickey")
  local activator = GetName(_activator())
  if (action == "enter") then
    if (activator == GetName(GetPlayer())) then
      SetPropertyBool("OswaldAssistLeverGroup", "ActionSpotEnabled", true)
    end
  elseif (action == "exit") then
    if (activator == GetName(GetPlayer())) then
      SetPropertyBool("OswaldAssistLeverGroup", "ActionSpotEnabled", false)
    end
  end
  return 
end

