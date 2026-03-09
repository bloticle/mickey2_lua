WorldofEvil_Pickups = 1
MusicEventVar = 0
local MickeyTrackNum = 0
local OswaldTrackNum = 0
WorldofEvil_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  Wait(0.5)
  ReplaceMusicStateOverride("MD2D_SeqA")
  Print("Set music state to A from WorldofEvil_CheckAtStart")
  if (HasCollectible("FilmReel_EM2_WorldOfEvil") == true) then
    WorldofEvil_Pickups = (WorldofEvil_Pickups - 1)
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "UnMute_All")
    AudioPostEventOn(GetPlayer(), ("Play_MX_2DProj_MadDoc_" .. tostring(GetLanguage())))
    MusicEventVar = 1
    Print("Started music event")
  end
  return 
end
WorldofEvil_CountTicket = function()
  Print("one ticket still here")
  WorldofEvil_Pickups = (WorldofEvil_Pickups + 1)
  return 
end
WorldofEvil_CheckOnPickup = function()
  Print("Picked up item")
  WorldofEvil_Pickups = (WorldofEvil_Pickups - 1)
  return 
end
WorldofEvil_2DTransitionSetup = function(target)
  Print("***WorldofEvil_2DTransitionSetup")
  local data = GetPrefabData(target)
  local visit = "2"
  local global = GetGlobal("EM2_EpisodeCheck")
  Print(("WorldofEvil_2DTransitionSetup: Episode " .. global))
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  if (data.Film_Position == "Left") then
    Print("WorldofEvil_2DTransitionSetup: Film_Position = Left so we are Heading to Autotopia")
    SetGlobal("Autotopia_HardLoad", 1)
    if (global < 4) then
      data.ActivatedLevels = "TCY_autotopia_visit1.SectionG_first"
    else
      data.ActivatedLevels = "TCY_autotopia_visit1.Main_Visit2"
      if (data.Film_Position == "Right") then
        Print("Service2_2DTransitionSetup: Film_Position = Right so we are Heading to Attic")
        if (global < 4) then
          data.ActivatedLevels = "LMR_MadDoctorAttic.Visit_1"
        else
          data.ActivatedLevels = "LMR_MadDoctorAttic.Visit_2"
        end
      end
    end
  elseif (data.Film_Position == "Right") then
    Print("Service2_2DTransitionSetup: Film_Position = Right so we are Heading to Attic")
    if (global < 4) then
      data.ActivatedLevels = "LMR_MadDoctorAttic.Visit_1"
    else
      data.ActivatedLevels = "LMR_MadDoctorAttic.Visit_2"
    end
  end
  SetupPosition(target)
  return 
end
WorldofEvil_TeleportPlayersToJar = function(target)
  Print("WorldofEvil_TeleportPlayersToJar")
  Disable(target)
  local _activator = _activator()
  local player = "Oswald"
  if (_activator == GetPlayer()) then
    player = "Mickey"
  end
  if (0 < GetHealth(_activator)) then
    Disable(("trn_maddoctor_01a_virtuos.TriggerBase_doorclose_" .. player))
    Prefab_MultiTrack_DisableControls((("trn_maddoctor_01a_virtuos.sidescroll2d_multitrack 01." .. player) .. "_CameraOverrideTracks 01"), _activator)
    Hide(_activator)
    SetCameraAttributesForPlayer("trn_maddoctor_01a_virtuos.Marker(CameraOverride)_TeleportBox3", _activator)
    wait(0.5)
    TeleportToEntity(_activator, "trn_maddoctor_01a_virtuos.PM_PlayersToJar")
    wait(2)
    TeleportToEntity(_activator, "trn_maddoctor_01a_virtuos.SplineKnot_telepoint 02")
    Unhide(_activator)
    _G[(("Set" .. player) .. "Plane")]((("trn_maddoctor_01a_virtuos.sidescroll2d_multitrack 01." .. player) .. "_CameraOverrideTracks 01"), 2)
    wait(0.5)
    ClearCameraAttributesForPlayer("trn_maddoctor_01a_virtuos.Marker(CameraOverride)_TeleportBox3", _activator)
    Prefab_MultiTrack_EnableControls((("trn_maddoctor_01a_virtuos.sidescroll2d_multitrack 01." .. player) .. "_CameraOverrideTracks 01"), _activator)
    Prefab_MultiTrack_EnableToss((("trn_maddoctor_01a_virtuos.sidescroll2d_multitrack 01." .. player) .. "_CameraOverrideTracks 01"))
    Enable(target)
  end
  return 
end
WorldofEvil_MadDocReveal = function()
  RestrictCutSceneInput()
  if (GetNumPlayers() == 1) then
    SetPropertyFloat("trn_maddoctor_01a_virtuos.Marker(CameraOverride)_MD_intro 01", "TransitionTime", 1)
  end
  SetCameraAttributesForPlayer("trn_maddoctor_01a_virtuos.Marker(CameraOverride)_MD_intro 01", GetPlayer())
  wait(8)
  ClearCameraAttributesForPlayer("trn_maddoctor_01a_virtuos.Marker(CameraOverride)_MD_intro 01", GetPlayer())
  EnableSplitScreen(true)
  UnrestrictCutSceneInput()
  return 
end
local OswaldPastVent = false
WorldofEvil_RecoverOswaldFromBack = function(target, state)
  if (state == "on") then
    if (OswaldPastVent == false) then
      Enable("AI_Oswald_RecoverFromBack")
    end
  else
    OswaldPastVent = true
    Disable("AI_Oswald_RecoverFromBack")
  end
  return 
end
WorldofEvil_ClearTransforms = function()
  Print("WorldofEvil_ClearTransforms function entered")
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  return 
end
WorldofEvil_SetRespawnTransform = function(character)
  Print("WorldofEvil_SetRespawnTransform function entered")
  if (character == GetPlayer()) then
    OverrideSpawnTransform(PLAYER_ONE, GetPosition("Marker_SpawnPastDoor_Mickey"), GetFacing("Marker_SpawnPastDoor_Mickey"))
    MickeyTrackNum = 0
  else
    OverrideSpawnTransform(PLAYER_TWO, GetPosition("Marker_SpawnPastDoor_Oswald"), GetFacing("Marker_SpawnPastDoor_Oswald"))
    OswaldTrackNum = 0
  end
  return 
end
WorldofEvil_CustomReviveScript = function(target, event, instigator)
  local subEvent = ReviveEvent_GetSubEvent(event)
  if (subEvent == ReviveEvent_Respawn) then
    Print(("WorldofEvil_CustomReviveScript respawn calling WorldofEvil_CustomRescueScript for " .. GetPropertyString(instigator, "EntityGroups", 0)))
    WorldofEvil_CustomRescueScript(target, instigator)
  end
  return 
end
WorldofEvil_CustomRescueScript = function(target, instigator)
  Print("WorldofEvil_CustomRescueScript function entered")
  if (instigator == GetPlayer()) then
    SetPropertyBool("MadDoc_MickeyFrontCam1", "InstantTransition", true)
    SetPropertyBool("MadDoc_MickeyFrontCam2", "InstantTransition", true)
    SetPropertyBool("MadDoc_MickeyBackCam", "InstantTransition", true)
    DeactivateCameraOverrideTrack(target, instigator)
    ActivateCameraOverrideTrack(target, instigator, MickeyTrackNum)
    SetPropertyBool("MadDoc_MickeyFrontCam1", "InstantTransition", false)
    SetPropertyBool("MadDoc_MickeyFrontCam2", "InstantTransition", false)
    SetPropertyBool("MadDoc_MickeyBackCam", "InstantTransition", false)
    Print(("WorldofEvil_CustomReviveScript respawned Mickey to track " .. tostring(MickeyTrackNum)))
  else
    SetPropertyBool("MadDoc_OswaldFrontCam1", "InstantTransition", true)
    SetPropertyBool("MadDoc_OswaldFrontCam2", "InstantTransition", true)
    SetPropertyBool("MadDoc_OswaldBackCam", "InstantTransition", true)
    DeactivateCameraOverrideTrack(target, instigator)
    ActivateCameraOverrideTrack(target, instigator, OswaldTrackNum)
    SetPropertyBool("MadDoc_OswaldFrontCam1", "InstantTransition", false)
    SetPropertyBool("MadDoc_OswaldFrontCam2", "InstantTransition", false)
    SetPropertyBool("MadDoc_OswaldBackCam", "InstantTransition", false)
    Print(("WorldofEvil_CustomReviveScript respawned Oswald to track " .. tostring(OswaldTrackNum)))
  end
  return 
end
WorldofEvil_TrackCheck = function()
  Print("WorldofEvil_TrackCheck function entered")
  while true do
    wait(0)
  end
  Print(("WorldofEvil_TrackCheck 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
  if (string.sub(tostring(GetGlobal("2dDirection")), -2, -2) == "1") then
    MickeyTrackNum = 0
  else
    MickeyTrackNum = 1
  end
  if (string.sub(tostring(GetGlobal("2dDirection")), -1, -1) == "1") then
    OswaldTrackNum = 0
    ForEachEntityInGroup(Enable, "MadDoc_FrontGotoNode")
    OswaldPastVent = true
  else
    OswaldTrackNum = 1
    ForEachEntityInGroup(Enable, "MadDoc_BackGotoNode")
  end
  return 
end
WorldofEvil_ManageOswaldAssistMickey = function(target, action, node1)
  Print("***WorldofEvil_ManageOswaldAssistMickey")
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
