Skeleton1_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
Skeleton1_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 0) then
    GetPrefabData("ProjectorToBogEasy").ActivatedLevels = "NOS_BogEasy.ShantyTown_V2"
  end
  if (HasCollectible("FilmReel_EM2_SkeletonDance1") == true) then
    if (AlreadyCheckedFilmReel == false) then
      Skeleton1_Pickups = (Skeleton1_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_SkeletonDance")
    MusicEventVar = 1
    Print("Started music event")
  end
  if (Skeleton1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  return 
end
Skeleton1_CountTicket = function()
  Print("one ticket still here")
  Skeleton1_Pickups = (Skeleton1_Pickups + 1)
  return 
end
Skeleton1_CheckOnPickup = function()
  Print("Picked up item")
  Skeleton1_Pickups = (Skeleton1_Pickups - 1)
  if (Skeleton1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
Skeleton1_ToMSNSetup = function(target)
  Print("__Function: Skeleton1_ToMSNSetup")
  SetGlobal("MSN_ProectorState", 2)
  return 
end
local DoorInUse = 0
Skeleton1_ThroughChurch = function(character)
  Print("Skeleton1_ThroughChurch")
  local characterToUse = character
  local player = "Oswald"
  local isOswald = true
  local sideScroll = "mst_north_01a_2dfilmstrip_tobogeasy.sidescroll2d_coop 01.Marker(CameraOverride) 02"
  if (characterToUse == GetPlayer()) then
    player = "Mickey"
    isOswald = false
    sideScroll = "mst_north_01a_2dfilmstrip_tobogeasy.sidescroll2d_coop 01.Marker(CameraOverride) 01"
  end
  Prefab_MultiTrack_DisableControls((("mst_north_01a_2dfilmstrip_tobogeasy.sidescroll2d_multitrack 02." .. player) .. "_CameraOverrideTracks"), characterToUse)
  if (characterToUse ~= GetPlayer()) then
    Disable("trn_skeletondance_01a_virtuos.prefab_gotonodevolume 01.TriggerBase 01")
    if (characterToUse == GetOswaldAI()) then
      OswaldStopMovingAction()
      ClearNextPatrolNode(GetOswaldAI())
    end
  end
  SetCameraAttributesForPlayer("trn_skeletondance_01a_virtuos.CO_TeleportThroughChurch", characterToUse)
  wait(2.5)
  if isOswald then
    characterToUse = GetPlayer2OrAI()
  end
  SetPropertyFloat(sideScroll, "TransitionTime", 1)
  if (character == GetOswaldAI()) then
    if (GetGlobal("OswaldAITeleportCheck") == 1) then
      return 
    end
  end
  _G[(("Set" .. player) .. "PlaneWithTeleport")]((("mst_north_01a_2dfilmstrip_tobogeasy.sidescroll2d_multitrack 02." .. player) .. "_CameraOverrideTracks"), 0, "trn_skeletondance_01a_virtuos.SplineKnot_ChurchDoorInside")
  wait(0.25)
  SetRotatorMaxSpeed("trn_skeletondance_01a_virtuos.TRN_skeletonDance_01a_door 01", 90)
  StartRotateToPosition("trn_skeletondance_01a_virtuos.TRN_skeletonDance_01a_door 01", 90)
  DoorInUse = (DoorInUse + 1)
  wait(1.5)
  if isOswald then
    characterToUse = GetPlayer2OrAI()
  end
  ClearCameraAttributesForPlayer("trn_skeletondance_01a_virtuos.CO_TeleportThroughChurch", characterToUse)
  wait(0.5)
  if isOswald then
    characterToUse = GetPlayer2OrAI()
  end
  if (characterToUse == GetOswaldAI()) then
    if (GetGlobal("OswaldAITeleportCheck") == 1) then
      return 
    end
  end
  ApplyImpulse(characterToUse, 1000, 0, 0)
  if (characterToUse == GetOswaldAI()) then
    if (GetGlobal("OswaldAITeleportCheck") == 0) then
      OswaldStartFollowAction()
    end
  end
  wait(0.5)
  if (characterToUse == GetOswaldAI()) then
    if (GetGlobal("OswaldAITeleportCheck") == 1) then
      return 
    end
  end
  Prefab_MultiTrack_EnableControls((("mst_north_01a_2dfilmstrip_tobogeasy.sidescroll2d_multitrack 02." .. player) .. "_CameraOverrideTracks"), characterToUse)
  Prefab_MultiTrack_EnableToss((("mst_north_01a_2dfilmstrip_tobogeasy.sidescroll2d_multitrack 02." .. player) .. "_CameraOverrideTracks"))
  DoorInUse = (DoorInUse - 1)
  if (DoorInUse == 0) then
    StartRotateToPosition("trn_skeletondance_01a_virtuos.TRN_skeletonDance_01a_door 01", 0)
  end
  SetPropertyFloat(sideScroll, "TransitionTime", 0)
  return 
end
local ChurchBellRung = false
Skeleton1_ChurchBellRung = function()
  if (ChurchBellRung == false) then
    ChurchBellRung = true
    AnimGBSequence("trn_skeletondance_01a_virtuos.TRN_skeletonDance_bell_01a 01", "shake", true)
    AnimGBSequence("trn_skeletondance_01a_virtuos.TRN_skeletonDance_batonthechurch_01a 01", "fly_away", true)
    Disable("trn_skeletondance_01a_virtuos.TriggerDamageBase 12")
    Unhide("trn_skeletondance_01a_virtuos.ETicket_Oswald_NIF 01")
    Hide("trn_skeletondance_01a_virtuos.ETicket_Oswald 01")
    SplineFollower_SetDisabled("trn_skeletondance_01a_virtuos.TRN_skeletonDance_01a_skeletontemp 02", false)
    if (GetEntity("trn_skeletondance_01a_virtuos.ETicket_Oswald_NIF 01") ~= nil) then
      Enable("trn_skeletondance_01a_virtuos.TriggerBase_OswaldGoldTicketJump")
    end
    wait(0.5)
    ForceSpawn("trn_skeletondance_01a_virtuos.Spawner 02", 1)
    wait(0.699999988079071)
    ForceSpawn("trn_skeletondance_01a_virtuos.Spawner 01", 1)
    wait(3.799999952316284)
    AnimGBSequence("trn_skeletondance_01a_virtuos.TRN_skeletonDance_bell_01a 01", "idle2", true)
  end
  return 
end
local GlideAbilityActive = true
Skeleton1_CheckGlideDisable = function()
  Print("Skeleton1_CheckGlideDisable function entered")
  while true do
    wait(0)
  end
  Print(("Skeleton1_CheckGlideDisable 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
  if (string.sub(tostring(GetGlobal("2dDirection")), -2, -2) ~= string.sub(tostring(GetGlobal("2dDirection")), -1, -1)) then
    if (GlideAbilityActive == true) then
      Print("Skeleton1_CheckGlideDisable disabling Glide since Mickey and Oswald on different tracks")
      GlideAbilityActive = false
      IncrementAbilityDisabled(GetPlayer(), "Earlift")
      Print("Skeleton1_CheckGlideDisable disabled Glide ability")
    end
  end
  return 
end
Skeleton1_EnterToMSN = function(target)
  if (GlideAbilityActive == false) then
    GlideAbilityActive = true
    DecrementAbilityDisabled(GetPlayer(), "Earlift")
    Print("Skeleton1_EnterToMSN enabled Glide ability")
  end
  SetupPosition(target)
  return 
end
Skeleton1_EnterToBogEasy = function(target)
  if (GlideAbilityActive == false) then
    GlideAbilityActive = true
    DecrementAbilityDisabled(GetPlayer(), "Earlift")
    Print("Skeleton1_EnterToBogEasy enabled Glide ability")
  end
  SetupPosition(target)
  return 
end
SkeletonDance1_ManageOswaldAssistMickey = function(target, action, node1)
  Print("***SkeletonDance1_ManageOswaldAssistMickey")
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
