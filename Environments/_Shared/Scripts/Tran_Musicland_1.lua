Musicland1_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
Musicland1_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  if (HasCollectible("FilmReel_EM2_MusicLand1") == true) then
    if (AlreadyCheckedFilmReel == false) then
      Musicland1_Pickups = (Musicland1_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_MusicLand")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (Musicland1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  return 
end
Musicland1_CountTicket = function()
  Print("one ticket still here")
  Musicland1_Pickups = (Musicland1_Pickups + 1)
  return 
end
Musicland1_CheckOnPickup = function()
  Print("Picked up item")
  Musicland1_Pickups = (Musicland1_Pickups - 1)
  if (Musicland1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
Musicland1_TeleportOswald_toFront = function(oswald)
  if (GetGlobal("OswaldAITeleportCheck") == 0) then
    Prefab_MultiTrack_DisableControls("nos_blotalley_01a_2dfilmstrip_totraintunnels.sidescroll2d_multitrack 01.Oswald_CameraOverrideTracks 01", oswald)
    SetCameraAttributesForPlayer("trn_musicland_01a.Marker(CameraOverride)_ToFront", oswald)
    Disable("trn_musicland_01a.hiddenoswald_action 01.Marker(BuddyAIAction) 01")
    Disable("trn_musicland_01a.hiddenoswald_action 02.Marker(BuddyAIAction) 01")
    wait(0.4000000059604645)
    if (GetGlobal("OswaldAITeleportCheck") == 1) then
      return 
    end
    SetOswaldPlaneWithTeleport("nos_blotalley_01a_2dfilmstrip_totraintunnels.sidescroll2d_multitrack 01.Oswald_CameraOverrideTracks 01", 0, "trn_musicland_01a.SplineKnot 04")
    wait(0.4000000059604645)
    ClearCameraAttributesForPlayer("trn_musicland_01a.Marker(CameraOverride)_ToFront", oswald)
    wait(0.20000000298023224)
    Prefab_MultiTrack_EnableControls("nos_blotalley_01a_2dfilmstrip_totraintunnels.sidescroll2d_multitrack 01.Oswald_CameraOverrideTracks 01", oswald)
    Prefab_MultiTrack_EnableToss("nos_blotalley_01a_2dfilmstrip_totraintunnels.sidescroll2d_multitrack 01.Oswald_CameraOverrideTracks 01")
  end
  return 
end
Musicland1_2DTransitionSetup = function(target)
  Print("***Musicland1_2DTransitionSetup")
  local data = GetPrefabData(target)
  local visit = "2"
  local global = GetGlobal("EM2_EpisodeCheck")
  Print(("Musicland1_2DTransitionSetup: Episode " .. global))
  if (data.Film_Position == "Right") then
    Print("Musicland1_2DTransitionSetup: Film_Position = Right so we are Heading to Train Tunnels")
    if (global < 3) then
      visit = "1"
    end
    data.ActivatedLevels = ("TRT_TrainTunnels.ClockV" .. visit)
  elseif (data.Film_Position == "Left") then
    Print("Musicland1_2DTransitionSetup: Film_Position = Left so we are Heading to Blot Alley")
  end
  SetupPosition(target)
  return 
end
local MickeyState = 0
local OswaldState = 0
Musicland1_StopFollowCheck = function(character)
  if (character == GetPlayer()) then
    MickeyState = 1
    if (OswaldState == 1) then
      OswaldStopMovingAction()
    else
      FireThread(Musicland1_ProjectorEnterCheck)
      OswaldState = 1
      if (MickeyState == 1) then
        OswaldStopMovingAction()
      end
    end
  else
    OswaldState = 1
    if (MickeyState == 1) then
      OswaldStopMovingAction()
    end
  end
  return 
end
Musicland1_StartFollow = function(character)
  if (character == GetPlayer()) then
    MickeyState = 0
    ProjectorEnterCheckActive = false
  else
    OswaldState = 0
  end
  OswaldStartFollowAction()
  return 
end
local ProjectorEnterCheckActive = false
Musicland1_ProjectorEnterCheck = function()
  if (ProjectorEnterCheckActive == false) then
    ProjectorEnterCheckActive = true
    while true do
      wait(0.10000000149011612)
      if (not (GetGlobal("OswaldAITeleportCheck") ~= 1)) then
        break
      end
    end
    if (GetGlobal("OswaldAITeleportCheck") == 1) then
      Disable("trn_musicland_01a.TriggerBase 06")
      Disable("trn_musicland_01a.TriggerBase 08")
      Disable("trn_musicland_01a.hiddenoswald_action 01.Marker(BuddyAIAction) 01")
      OswaldAbortScriptedBehavior()
      OswaldStopMovingAction()
    end
  end
  return 
end
Musicland1_PickBlotAlleyVisit_2D = function(target)
  Print("__Function: NOS_BogEasy_PickBlotAlleyVisit_2D")
  if (GetGlobal("FTL_Fort_SpatterState") ~= 10) then
    Print("__WE'VE DONE THE FORT FIGHT, CHECK VISIT 2 CRITERIA")
    if (GetGlobal("FTL_Fort_SpatterState") ~= 1) then
      Print("__We've made Ian angry in gulch! Visit 2!")
      SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
      GetPrefabData("MusicLand_Projector_ToBlotAlley").ActivatedLevels = "nos_blotalley_main.section4_visit2_noian"
    elseif (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 1) then
      Print("__We made ian angry in bta! We must be in visit 2!")
      GetPrefabData("MusicLand_Projector_ToBlotAlley").ActivatedLevels = "nos_blotalley_main.section4_visit2_noian"
    elseif (GetGlobal("NOS_BlotAlley_VisitNum") == 2) then
      Print("__We havent made anyone angry and we're in visit 2 already!")
      GetPrefabData("MusicLand_Projector_ToBlotAlley").ActivatedLevels = "nos_blotalley_main.section4_visit2_ian"
    else
      Print("__We should be in a persisted version of visit 1!")
      Print("__WE HAVENT DONE THE GULCH FIGHT YET, VISIT 1!")
    end
  else
    Print("__WE HAVENT DONE THE GULCH FIGHT YET, VISIT 1!")
  end
  return 
end
Musicland1_CheckForGoldTicket = function()
  if (GetEntity("trn_musicland_01a.ETicket_Oswald_NIF 01") ~= nil) then
    Enable("trn_musicland_01a.hiddenoswald_action 02.Marker(BuddyAIAction) 01")
  end
  return 
end
Musicland1_OswaldDied = function(target, event)
  local subEvent = ReviveEvent_GetSubEvent(event)
  if (subEvent == ReviveEvent_Respawn) then
    Enable(target)
  end
  return 
end

