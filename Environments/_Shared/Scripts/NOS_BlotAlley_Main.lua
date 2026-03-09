NOS_BlotAlley_2DToBlotAlleySetup = function(target)
  Print("__Function: NOS_BlotAlley_2DTransitionSetup")
  GetPrefabData("NOS_BlotAlley_BogEasyProjector").MapLoad_SetupPosition = "True"
  if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
    Print("__VISIT 1! Using Default Projector State Stream!")
  else
    if (GetGlobal("FTL_Fort_SpatterState") ~= 1) then
      Print("__IAN ANGRY, FLIPPING TO V2_NOIAN!")
      SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
      GetPrefabData("NOS_BlotAlley_BogEasyProjector").State_Stream = "nos_blotalley_main.section1_visit2_noian"
    end
    Print("__IAN NOT ANGRY, FLIPPING TO V2_IAN!")
    GetPrefabData("NOS_BlotAlley_BogEasyProjector").State_Stream = "nos_blotalley_main.section1_visit2_ian"
    GetPrefabData("NOS_BlotAlley_BogEasyProjector").ToFlyThrough = "False"
  end
  SetupPosition(target)
  return 
end
NOS_BlotAlley_Section4DoorStreamed = function(target)
  Print("__Function: NOS_BlotAlley_Section4DoorStreamed")
  return 
end
NOS_BlotAlley_PickBogEasyVisit = function(target)
  Print("__Function: NOS_BlotAlley_PickBogEasyVisit")
  if (GetGlobal("NOS_BogEasy_FirstVisit") ~= 1) then
    Print("__TRANSITION TO BOG EASY FLIPPING TO SECOND VISIT")
  end
  SetupPosition(target)
  return 
end
NOS_BlotAlley_HardLoadSetup = function(target)
  Print(("__Function: NOS_BlotAlley_HardLoadSetup called from: " .. tostring(GetName(target))))
  if (LevelManager_GetCurrentState() == "nos_blotalley_main.section1_visit1") then
    if (GetGlobal("NOS_BlotAlley_ZoneEntered") == 0) then
      GetPrefabData(target).SkipJumpOutAnim = true
    end
  elseif (LevelManager_GetCurrentState() == "nos_blotalley_main.section1_visit1") then
    if (GetGlobal("NOS_BlotAlley_ZoneEntered") == 1) then
      GetPrefabData(target).ToFlyThrough = "False"
    end
  end
  return 
end
NOS_BlotAlley_V2FlythroughTest = function(target)
  Print("__Function: NOS_BlotAlley_V2FlythroughTest")
  local state = LevelManager_GetCurrentState()
  if (state == "nos_blotalley_main.section1_visit2_noian") then
    SetGlobal("NOS_BlotAlley_VisitNum", 2)
    if (state == "nos_blotalley_main.section1_visit2_noian") then
      SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
      SetGlobal("NOS_BlotAlley_Ian_2ndVisit_ThinSpatter_Played", 1)
    end
    if (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 1) then
      if (GetGlobal("NOS_BlotAlley_Ian_2ndVisit_ThinSpatter_Played") == 0) then
        Print("__will play ian angry igc!")
        GetPrefabData(target).ToFlyThrough = "True"
      end
    else
      GetPrefabData(target).ToFlyThrough = "False"
    end
  end
  return 
end
NOS_BlotAlley_Main = function(target)
  Print("___Function: NOS_BlotAlley_Main")
  MusicPostEventOn(GetPlayer(), "Play_MX_BLA")
  RemoveAllMusicStateOverride()
  SetPlayStyleScoreBias(-100)
  Print("Started BLA music event from NOS_BlotAlley_Main, set playstylescore bias to -100")
  if (target ~= nil) then
    NOS_BlotAlley_AlwaysSetup(target)
  end
  ObservatoryItem_Activate("MSS_ObservatoryItem_Alley", "5")
  local state = LevelManager_GetCurrentState()
  if (target ~= nil) then
    if (GetName(target) == "nos_blotalley_01a_section4_shared.Projector_TrainTunnels.ConversationMarker") then
      Print("__We came from the train tunnels projector!")
      if (state == "nos_blotalley_main.section4_visit2_ian") then
        Print("__In return visit!")
        if (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
          Print("__Quest started! Will use real bunny suction!")
          LevelManager_SetZoneStatusActive("nos_blotalley_main.bunnysuction_real")
        else
          Print("__Quest not started! Will use dummy bunny suction!")
          LevelManager_SetZoneStatusActive("nos_blotalley_main.bunnysuction_dummy")
          Print("__In visit 1! Use dummy suction!")
          LevelManager_SetZoneStatusActive("nos_blotalley_main.bunnysuction_dummy")
        end
      end
      Print("__In visit 1! Use dummy suction!")
      LevelManager_SetZoneStatusActive("nos_blotalley_main.bunnysuction_dummy")
      WaitForLevelLoad()
    elseif (GetName(target) == "nos_blotalley_01a_section1_shared.Projector_BogEasy.ConversationMarker") then
      Print("__We came from the bog easy projector!")
      if (GetGlobal("NOS_BlotAlley_VisitNum") == 2) then
        Print("__We're in second visit! Save a checkpoint!")
        NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Section1_Projector")
      end
    end
  end
  if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
    if (state == "nos_blotalley_main.section1_visit1") then
      if (GetGlobal("NOS_BlotAlley_Gus_AirlockInfo_Played") == 1) then
        NOS_BlotAlley_HandleHintNodes(nil, "AirlockB")
      else
        NOS_BlotAlley_HandleHintNodes(nil, "AirlockA")
        if (state == "nos_blotalley_main.section2_visit1_noian") then
          NOS_BlotAlley_HandleHintNodes(nil, "Building")
        elseif (state == "nos_blotalley_main.NOS_BlotAlley_v1_Pete") then
          if (GetGlobal("NOS_BlotAlley_Petetronic_OpenDoor_Played") == 1) then
            NOS_BlotAlley_HandleHintNodes(nil, "TTProjector")
          elseif (GetGlobal("NOS_BlotAlley_Petetronic_NeedScrapMetal_Played") == 0) then
            NOS_BlotAlley_HandleHintNodes(nil, "Club13")
          end
        end
      end
    elseif (state == "nos_blotalley_main.section2_visit1_noian") then
      NOS_BlotAlley_HandleHintNodes(nil, "Building")
    elseif (state == "nos_blotalley_main.NOS_BlotAlley_v1_Pete") then
      if (GetGlobal("NOS_BlotAlley_Petetronic_OpenDoor_Played") == 1) then
        NOS_BlotAlley_HandleHintNodes(nil, "TTProjector")
      elseif (GetGlobal("NOS_BlotAlley_Petetronic_NeedScrapMetal_Played") == 0) then
        NOS_BlotAlley_HandleHintNodes(nil, "Club13")
      end
    end
  end
  return 
end
NOS_BlotAlley_SaveCheckpoint = function(_Where, _Delay)
  Print(("__Function: NOS_BlotAlley_SaveCheckpoint, _Where: " .. tostring(_Where)))
  local OswaldMarker = (_Where .. tostring("_Oswald"))
  Print(("__Will save Oswald location as: " .. tostring(OswaldMarker)))
  if (_Delay == "Delay") then
    Wait(0.4000000059604645)
  end
  SaveCheckpoint(GetPlayer(), "NOS_BlotAlley_Main", tostring(_Where), tostring(OswaldMarker))
  return 
end
NOS_BlotAlley_CheckpointLoad = function(target)
  Print("__Function: NOS_BlotAlley_CheckpointLoad")
  NOS_BlotAlley_VisitCheckpointLoad(target)
  return 
end
NOS_BlotAlley_GusAirlockHint = function(target)
  Print("__Function: NOS_BlotAlley_GusAirlockHint")
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    Print("__Some other sequence was playing")
    wait(1)
  end
  NOS_BlotAlley_HandleHintNodes(nil, "AirlockB")
  ForceSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_AirlockInfo")
  DestroyEntity(target)
  return 
end
local BlastDoorsBlasted = {0, 0, 0, 0}
local LastMickeyLocation = -1
NOS_BlotAlley_OswaldRockActionSpotFromTrigger = function(target, _Direction)
  Print(("__Function: NOS_BlotAlley_OswaldRockActionSpotFromTrigger, _Direction: " .. tostring(_Direction)))
  if (GetPropertyInt("ShortcutDoor1", "Active Sequence ID") == 1) then
    if IsValidHandle("NOS_BlotAlley_TunnelBlocker") then
      if (GetPropertyInt("NOS_BlotAlley_TunnelBlocker", "Active Sequence ID") == 0) then
        if (_Direction == "Forward") then
          Disable("ShortcutTossActionMarker")
        elseif (_Direction == "Backward") then
          Enable("ShortcutTossActionMarker")
        end
      end
    end
  end
  return 
end
NOS_BlotAlley_BlastDoorStimmed = function(target, _event, _WhichDoor)
  Print(((("__Function: NOS_BlastDoorStimmed, _WhichDoor: " .. _WhichDoor) .. ", object: ") .. tostring(GetName(target))))
  if StimulusEvent_HasStimulusType(_event, ST_CROSSED_STREAM) then
    if (_WhichDoor == "1") then
      AnimGBSequence("ShortcutDoor1", "open")
      DestroyEntity("Door1_Sign")
      StartEmitters("ShortcutDoor1_Explosion")
      AudioPostEventOn("ShortcutDoor1", "Play_sfx_BLA_ShortcutDoor1Open")
      wait(3)
      StopEmitters("ShortcutDoor1_Explosion")
      SetPropertyInt("ShortcutDoor1", "Collision Layer", 1)
      Enable("ShortcutTossActionMarker")
    elseif (_WhichDoor == "2") then
      AnimGBSequence("ShortcutDoor2", "open")
      DestroyEntity("Door2_Sign")
      StartEmitters("ShortcutDoor2_Explosion")
      AudioPostEventOn("ShortcutDoor1", "Play_sfx_BLA_ShortcutDoor2Open")
      wait(3)
      StopEmitters("ShortcutDoor2_Explosion")
    end
  end
  return 
end
NOS_BlotAlley_BlastDoor = function(target, _Door)
  Print(("__Function: NOS_BlotAlley_BlastDoor, _Door: " .. _Door))
  Print((("__Blasting Door: " .. _Door) .. "!"))
  ShakeCamera(6, 10, 0, 20, 0.02500000037252903, 0.02500000037252903)
  BlastDoorsBlasted[tonumber(_Door)] = 1
  if (LastMickeyLocation == 1) then
    AnimGBSequence(("BlastDoor" .. _Door), "open")
  else
    AnimGBSequence(("BlastDoor" .. _Door), "open2")
  end
  wait(1)
  DestroyEntity(("BlastDoor" .. _Door))
  if (_Door ~= "2") then
    Unhide((("BlastDoor" .. _Door) .. "Static"))
  end
  OswaldStreamAbort()
  return 
end
NOS_BlotAlley_FreeGremlin = function(target)
  TeleportGremlinOut(target)
  NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Section1_Projector")
  return 
end
NOS_BlotAlley_ActivateOswaldSwitch = function(target, _Direction)
  Print("__Function: NOS_BlotAlley_ActivateOswaldSwitch")
  if (GetGlobal("NOS_BlotAlley_Bell1Rang") == 0) then
    if (GetGlobal("NOS_BlotAlley_AnimTreesGrown") == 0) then
      if (_Direction == "In") then
        AnimGBSequence("AnimatronicTreesShutter", "open")
      elseif (_Direction == "Out") then
        AnimGBSequence("AnimatronicTreesShutter", "close")
      end
    end
  end
  return 
end
NOS_BlotAlley_Room1AnimatePlatform = function(target)
  Print("__Function: NOS_BlotAlley_Room1AnimatePlatform")
  DestroyEntity("Room1_OswaldShocker_Trigger")
  AnimGBSequence("AnimatronicTreesShutter", "close")
  SetGlobal("NOS_BlotAlley_AnimTreesGrown", 1)
  Disable("OswaldPath_Section1_Node3")
  OswaldStreamAbort()
  AnimGBSequence("Room1_OswaldShockPoint_Platform1", "grow")
  NOS_BlotAlley_OswaldPathHandler(nil, "OswaldPath_Section1_Node4", "OswaldPath_Section1_Node3")
  wait(0.5)
  SetPropertyBool("OswaldPath_Section1_Node3", "TakeNoAction", true)
  AnimGBSequence("Room1_OswaldShockPoint_Platform3", "grow")
  return 
end
NOS_BlotAlley_HiddenRoomTriggerEntered = function(target, _Direction)
  Print(("__Function: NOS_BlotAlley_HiddenRoomTriggerEntered, _Direction: " .. tostring(_Direction)))
  if (GetGlobal("NOS_BlotAlley_HiddenPlatformAnimated") == 0) then
    if (_Direction == "In") then
      AnimGBSequence("SecretBalconyShutter", "open")
      Enable("Room3Platform_Hint")
    elseif (_Direction == "Out") then
      AnimGBSequence("SecretBalconyShutter", "close")
      Disable("Room3Platform_Hint")
    end
  end
  return 
end
NOS_BlotAlley_HiddenRoomAnimatePlatform = function(target)
  Print("__Function: NOS_BlotAlley_HiddenRoomAnimatePlatform")
  Disable("Room3Platform_Hint")
  DestroyEntity("HiddenRoomPlatform_Trigger")
  SetGlobal("NOS_BlotAlley_HiddenPlatformAnimated", 1)
  AnimGBSequence("SecretBalconyShutter", "close")
  SetPropertyBool("OswaldPath_Section1_Node3", "TakeNoAction", true)
  Disable("OswaldPath_Section1_Node3")
  OswaldStreamAbort()
  Enable("OswaldPath_Section1_Node3")
  AnimGBSequence("HiddenRoomPlatform", "on")
  AudioPostEventOn("HiddenRoomPlatform", "Play_sfx_BlotAlley_BalconyDoor")
  StartEmitters("TrainingPlatformDust")
  wait(3)
  StopEmitters("TrainingPlatformDust")
  SaveCheckpoint("CHECKPOINT_Section2_Airlock")
  return 
end
NOS_BlotAlley_AdBoxShocker = function(target, _Which)
  Print(("__Function: NOS_BlotAlley_AdBoxShocker, _Which: " .. tostring(_Which)))
  Prefab_ChairTableSetup_StartShock("AdBoxSetup", tostring(_Which))
  return 
end
NOS_BlotAlley_ShortcutOswaldShocker = function(target)
  Print("__Function: NOS_BlotAlley_ShortcutOswaldShocker")
  if (_activator() == GetPlayer()) then
    TeleportToEntity("NOS_BlotAlley_Oswald", GetPlayer())
  end
  OswaldStreamAction("ShortcutRoomUtilityDoor_OswaldShocker")
  return 
end
NOS_BlotAlley_ShortcutAnimatePlatform = function(target)
  Print("__Function: NOS_BlotAlley_HiddenRoomAnimatePlatform")
  AnimGBSequence("ShortcutRoomUtilityDoor", "open")
  Disable("ShortcutGateOswaldAction")
  OswaldStreamAbort()
  return 
end
NOS_BlotAlley_ShortcutRoomThinned = function(target)
  Print("__Function: NOS_BlotAlley_ShortcutRoomThinned")
  AnimGBSequence("NOS_BlotAlley_TunnelBlocker", "fall")
  ForEachEntityInGroup(DestroyEntity, "ShortcutDisableActionSpot")
  DestroyEntity("UpperPathDisableShortcutActionSpot")
  wait(2)
  DestroyEntity("NOS_BlotAlley_TunnelBlocker")
  Disable("ShortcutTossActionMarker")
  return 
end
NOS_BlotAlley_TunnelBlockerStimmed = function(target, _event)
  Print("__Function: NOS_BlotAlley_TunnelBlockerStimmed")
  if StimulusEvent_HasStimulusType(_event, ST_CROSSED_STREAM) then
    Print("__Hiding Tunnel Blocker")
    DestroyEntity("NOS_BlotAlley_TunnelBlocker")
    ForEachEntityInGroup(DestroyEntity, "ShortcutDisableActionSpot")
    DestroyEntity("UpperPathDisableShortcutActionSpot")
    StartEmitters("TunnelBlockerExplode")
    AudioPostEventOn("nos_blotalley_01a_audio.SND_TunnelBlockerExplode", "Play_sfx_BLA_TunnelBlockerExplode")
    Disable("ShortcutTossActionMarker")
    Unhide("TunnelBlockerExplode")
    ShakeCamera(6, 10, 0, 20, 0.02500000037252903, 0.02500000037252903)
    wait(5.5)
    StopEmitters("TunnelBlockerExplode")
  end
  return 
end
NOS_BlotAlley_SpladooshTrainingWallThinned = function(target)
  Print("__Function: NOS_BlotAlley_SpladooshTrainingWallThinned")
  SetPropertyFloat("SpladooshTrainingChest", "UsableRadius", 0)
  AnimGBSequence("Room4_Platform", "fall")
  Unhide("Room4_BuildingFallFX")
  StartEmitters("Room4_BuildingFallFX")
  wait(5.5)
  StopEmitters("Room4_BuildingFallFX")
  return 
end
local SillClearToClose = {1, 1, 1, 1}
NOS_BlotAlley_AnimateWindowSill = function(target, _WhichSill)
  AnimGBSequence(("WindowSill" .. _WhichSill), "open")
  AudioPostEventOn(("WindowSill" .. _WhichSill), "Play_sfx_ShuttersOpen_Lrg")
  wait(4.5)
  FireThread(NOS_BlotAlley_CloseWindowSill, target, _WhichSill)
  return 
end
NOS_BlotAlley_CloseWindowSill = function(target, _WhichSill)
  Print(((("__SillClearToClose[" .. tostring(_WhichSill)) .. "] value: ") .. tostring(SillClearToClose[tonumber(_WhichSill)])))
  while true do
    if (not (SillClearToClose[tonumber(_WhichSill)] == 0)) then
      break
    end
    Print("__Not clear to close!")
    wait(0.5)
  end
  AnimGBSequence(("WindowSill" .. _WhichSill), "close")
  AudioPostEventOn(("WindowSill" .. _WhichSill), "Play_sfx_ShuttersClose_Lrg")
  return 
end
NOS_BlotAlley_WindowKeepOpenTrigger = function(target, _Which, _Direction)
  Print(((("__Function: NOS_BlotAlley_WindowKeepOpenTrigger, _Which: " .. tostring(_Which)) .. ", _Direction: ") .. tostring(_Direction)))
  if (_Direction == "In") then
    SillClearToClose[tonumber(_Which)] = 0
  elseif (_Direction == "Out") then
    SillClearToClose[tonumber(_Which)] = 1
  end
  return 
end
local Section2PotsLeft = 3
local PlayersInCurtainArea = 0
NOS_BlotAlley_WoodBroken = function(target)
  Print("__Function: NOS_BlotAlley_WoodBroken")
  Section2PotsLeft = (Section2PotsLeft - 1)
  if (Section2PotsLeft == 0) then
    FireThread(NOS_BlotAlley_CheckCurtainDown, target)
  end
  return 
end
NOS_BlotAlley_CheckCurtainDown = function(target)
  Print("__Function: NOS_BlotAlley_CheckCurtainDown")
  while true do
    if (not (PlayersInCurtainArea ~= 0)) then
      break
    end
    wait(0.10000000149011612)
  end
  AnimGBSequence("NOS_BlotAlley_Section2Curtain", "down")
  return 
end
NOS_BlotAlley_PlayerInCurtainTrigger = function(target, _Direction)
  Print(("__Function: NOS_BlotAlley_PlayerInCurtainTrigger, _Direction: " .. tostring(_Direction)))
  if (_Direction == "In") then
    PlayersInCurtainArea = (PlayersInCurtainArea + 1)
  elseif (_Direction == "Out") then
    PlayersInCurtainArea = (PlayersInCurtainArea - 1)
  end
  return 
end
NOS_BlotAlley_EncyclopediaPhotoTaken = function(target)
  Print(("__Function: NOS_BlotAlley_EncyclopediaPhotoTaken, target: " .. tostring(target)))
  if (target == "MSN_Adelle_InkWellVar") then
    local Spatter1State = 0
    local Spatter2State = 0
    local InkWellState = GetPrefabData("BlotAlley_Inkwell_02").InkWellState
    Print(("__InkWellState: " .. tostring(InkWellState)))
    if (InkWellState == "Invisible") then
      SetGlobal(target, 2)
    elseif (InkWellState == "Indelible") then
      SetGlobal(target, 1)
    else
      SetGlobal(target, 3)
      if (target == "MSN_Adelle_SquareVar") then
        if (GetPrefabData("Room3Floor_FloorOnly").FloorState[1] == 0) then
          SetGlobal(target, 1)
        end
        SetGlobal(target, 2)
      elseif (target == "MSN_Adelle_Club13Var") then
        if (GetPrefabData("NOS_BlotAlley_GuardianPool_RoyalStreet").GP_State == "Paint") then
          SetGlobal(target, 2)
        elseif (GetPrefabData("NOS_BlotAlley_GuardianPool_RoyalStreet").GP_State == "Thinner") then
          SetGlobal(target, 1)
        else
          SetGlobal(target, 3)
          Print("__Whatever got passed in here isnt right")
        end
      else
        Print("__Whatever got passed in here isnt right")
      end
    end
  elseif (target == "MSN_Adelle_SquareVar") then
    if (GetPrefabData("Room3Floor_FloorOnly").FloorState[1] == 0) then
      SetGlobal(target, 1)
    end
    SetGlobal(target, 2)
  elseif (target == "MSN_Adelle_Club13Var") then
    if (GetPrefabData("NOS_BlotAlley_GuardianPool_RoyalStreet").GP_State == "Paint") then
      SetGlobal(target, 2)
    elseif (GetPrefabData("NOS_BlotAlley_GuardianPool_RoyalStreet").GP_State == "Thinner") then
      SetGlobal(target, 1)
    else
      SetGlobal(target, 3)
      Print("__Whatever got passed in here isnt right")
    end
  else
    Print("__Whatever got passed in here isnt right")
  end
  Print(((("__Set Global " .. tostring(target)) .. " to: ") .. tostring(GetGlobal(target))))
  FireThread(NOS_BlotAlley_EncyclopediaCheckpoint, target)
  return 
end
NOS_BlotAlley_EncyclopediaCheckpoint = function(target)
  Print("__Function: NOS_BlotAlley_EncyclopediaCheckpoint")
  wait(0.5)
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  if (target == "MSN_Adelle_InkWellVar") then
    NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Section1_Airlock")
  elseif (target == "MSN_Adelle_SquareVar") then
    NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Section2_Airlock")
  elseif (target == "MSN_Adelle_Club13Var") then
    NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Section4_Gate")
  end
  return 
end
NOS_BlotAlley_BreakChest = function(target)
  Print("__Function: NOS_BlotAlley_BreakChest")
  Print(("target: " .. GetName(target)))
  Kill(target)
  return 
end
NOS_BlotAlley_IanIGC = function(target, _Section)
  Print(("NOS_BlotAlley_IanIGC, _Section: " .. tostring(_Section)))
  if (_Section == "1") then
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    EnableSplitScreen(false)
    SetMapMarkerVisible("MapMarker_Ian", false)
    RestrictCutSceneInput()
    GrabCamera("IanIGC_CCP1", nil, CAMERA_INSTANT_TRANSITION, 0, GetNetworkPlayer())
    DisableMotion_Player(GetPlayer())
    DisableMotion_Player(GetPlayer2OrAI())
    DisableMotion("NOS_BlotAlley_Ian")
    TeleportToEntity(GetPlayer(), "IanAirlock3MickeyIGCLocation")
    TeleportToEntity(GetPlayer2OrAI(), "IanAirlock3OswaldIGCLocation")
    StreamZones(nil, "NOS_BlotAlley_v1_PeteGeo")
    WaitForLevelLoad()
    EnableMotion_Player(GetPlayer())
    EnableMotion_Player(GetPlayer2OrAI())
    FireThread(Prefab_SpatterController_IanProgressCheck, target)
    AnimGBSequence("IanGate", "open")
  elseif (_Section == "2") then
    StartFadeIn(0.800000011920929)
    wait(0.4000000059604645)
    GrabCamera("IanIGC_CCP2", nil, CAMERA_LERP_TRANSITION, 10, GetNetworkPlayer())
    wait(4)
    AnimGBSequence("IanGate", "close")
  elseif (_Section == "6") then
    ClearNextPatrolNode("NOS_BlotAlley_Ian")
    wait(0.10000000149011612)
    SetNextPatrolNode("NOS_BlotAlley_Ian", "IanIGC_ExitNode")
  elseif (_Section == "7") then
    if (IsAnySequencePlaying() == true) then
      wait(0.10000000149011612)
    end
    AnimVarInt("NOS_BlotAlley_Ian", VAR_Cutscene, 1)
    AnimEvent("NOS_BlotAlley_Ian", EVENT_Start_Cutscene)
    wait(1.7999999523162842)
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    DestroyEntity("DummyWall")
    StreamZones(nil, "NOS_BlotAlley_v1_Pete")
    WaitForLevelLoad()
    ForceSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_TheresPete")
  elseif (_Section == "8") then
    GrabCamera("IanIGC_CCP6", nil, CAMERA_INSTANT_TRANSITION, 0, GetNetworkPlayer())
    StartFadeIn(0.4000000059604645)
    wait(0.4000000059604645)
    GrabCamera("IanIGC_CCP7", nil, CAMERA_LERP_TRANSITION, 6, GetNetworkPlayer())
  elseif (_Section == "9") then
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    while true do
      if (not (IsAnySequencePlaying() == true)) then
        break
      end
      wait(0.10000000149011612)
    end
    ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
    ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetPlayer2OrAI())
    wait(0)
    SetCameraAttributesForPlayer("CCP8_Trigger_Mickey", GetPlayer())
    SetCameraAttributesForPlayer("CCP8_Trigger_Oswald", GetPlayer2OrAI())
    EnableSplitScreen(true)
    TeleportToEntity(GetPlayer(), "AfterIanIGC_Mickey")
    TeleportToEntity(GetPlayer2OrAI(), "AfterIanIGC_Oswald")
    Enable("CCP8_Trigger_Mickey")
    Enable("CCP8_Trigger_Oswald")
    StartFadeIn(0.800000011920929)
    NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Section4_Gate")
    wait(0.4000000059604645)
    UnrestrictCutSceneInput()
    wait(1)
    OswaldStopFollowAction()
    if (GetGlobal("NOS_BlotAlleyProgress") == 0) then
      Enable("OswaldGotoClubMarker")
      NOS_BlotAlley_HandleHintNodes(nil, "Club13")
      Prefab_Projector_ChangeState("TrainTunnels3DProjectorMarker", "Deactivate")
    else
      Prefab_Projector_ChangeState("TrainTunnels3DProjectorMarker", "Activate")
      if (_Section == "10") then
        if (GetName(_activator()) == GetName(GetPlayer())) then
          Print("__IanIGC: Destroying Mickey Camera Trigger!")
          ClearCameraAttributesForPlayer("CCP8_Trigger_Mickey", _activator())
          Disable("CCP8_Trigger_Mickey")
        else
          Print("__IanIGC: Destroying Oswald Camera Trigger!")
          ClearCameraAttributesForPlayer("CCP8_Trigger_Oswald", _activator())
          Disable("CCP8_Trigger_Oswald")
        end
      end
    end
  elseif (_Section == "10") then
    if (GetName(_activator()) == GetName(GetPlayer())) then
      Print("__IanIGC: Destroying Mickey Camera Trigger!")
      ClearCameraAttributesForPlayer("CCP8_Trigger_Mickey", _activator())
      Disable("CCP8_Trigger_Mickey")
    else
      Print("__IanIGC: Destroying Oswald Camera Trigger!")
      ClearCameraAttributesForPlayer("CCP8_Trigger_Oswald", _activator())
      Disable("CCP8_Trigger_Oswald")
    end
  end
  return 
end
NOS_BlotAlley_BearQuestManage = function(target)
  Print("__Function: NOS_BlotAlley_BearQuestManage")
  if (Quest_CheckStatus("Horaces_Assistant_Assistance", "Horaces_Assistant_Assistance_1", Quest_Discovered) == true) then
    GiveCollectible("Tedworth_Bear_Complete")
    Quest_SetStatus("Horaces_Assistant_Assistance", "Horaces_Assistant_Assistance_5", Quest_Discovered, false)
    Quest_SetStatus("Horaces_Assistant_Assistance", "Horaces_Assistant_Assistance_5", Quest_TurnIn, true)
  end
  GiveCollectible("Tedworth_Bear_Complete")
  return 
end
NOS_BlotAlley_TeddyBearCollected = function(target)
  Print("__Function: NOS_BlotAlley_TeddyBearCollected")
  SetGlobal("NOS_BlotAlley_NumTeddyBearsCollected", (GetGlobal("NOS_BlotAlley_NumTeddyBearsCollected") + 1))
  wait(0.10000000149011612)
  FireSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_TeddyBearGot")
  NOS_BlotAlley_SaveCheckpoint(target)
  Print(("__NOS_BlotAlley_NumTeddyBearsCollected Value: " .. tostring(GetGlobal("NOS_BlotAlley_NumTeddyBearsCollected"))))
  return 
end
NOS_BlotAlley_ReturnVisit_IanAngryCalculateQuestHealthLoss = function(target)
  Print("__Function: NOS_BlotAlley_ReturnVisit_IanAngryCalculateQuestHealthLoss")
  if (GetGlobal("NOS_BlotAlley_Costume_Africa") == 2) then
    SetGlobal("BTA_QuestHealth", (GetGlobal("BTA_QuestHealth") - 4))
  elseif (GetGlobal("NOS_BlotAlley_Costume_Asia") == 2) then
    SetGlobal("BTA_QuestHealth", (GetGlobal("BTA_QuestHealth") - 3))
  elseif (GetGlobal("NOS_BlotAlley_Costume_Jester") == 2) then
    SetGlobal("BTA_QuestHealth", (GetGlobal("BTA_QuestHealth") - 4))
  elseif (GetGlobal("NOS_BlotAlley_Costume_TopHat") == 2) then
    SetGlobal("BTA_QuestHealth", (GetGlobal("BTA_QuestHealth") - 4))
  end
  SetGlobal("BTA_QuestHealth", (GetGlobal("BTA_QuestHealth") - 15))
  return 
end
local DumpsterFXBusy = {0, 0, 0, 0}
NOS_BlotAlley_DumpsterFX = function(target, _Which)
  Print(("__Function: NOS_BlotAlley_DumpsterFX, _Which: " .. tostring(_Which)))
  if (DumpsterFXBusy[tonumber(_Which)] == 0) then
    DumpsterFXBusy[tonumber(_Which)] = 1
    StartEmitters(("DumpsterFX_" .. tostring(_Which)))
    AudioPostEventOn(target, "Play_sfx_ImpactDumpsterBounce")
    wait(1)
    StopEmitters(("DumpsterFX_" .. tostring(_Which)))
    DumpsterFXBusy[tonumber(_Which)] = 0
  end
  return 
end
NOS_BlotAlley_PeteDumpsterStateChange = function(target, _State)
  Print(("__Function: NOS_BlotAlley_PeteDumpsterStateChange, _State: " .. tostring(_State)))
  local pooldata = GetPrefabData("NOS_BlotAlley_GuardianPool_RoyalStreet")
  if (_State == "Thinned") then
    SetGlobal(pooldata.GP_PaintedObjects[1], (GetGlobal(pooldata.GP_PaintedObjects[1]) - 1))
  elseif (_State == "Painted") then
    SetGlobal(pooldata.GP_PaintedObjects[1], (GetGlobal(pooldata.GP_PaintedObjects[1]) + 1))
  end
  Print(((("*_*_*_*_*_*_* Prefab_GuardianPoolObject: " .. pooldata.GP_PaintedObjects[1]) .. " = ") .. GetGlobal(pooldata.GP_PaintedObjects[1])))
  Prefab_ChangeGuardianPoolState("NOS_BlotAlley_GuardianPool_RoyalStreet")
  return 
end
NOS_BlotAlley_HandleHintNodes = function(target, _Stage)
  Print(("__Function: NOS_BogEasy_HandleHintNodes, _Stage: " .. tostring(_Stage)))
  DisableGuardianHint("GusHints")
  ActivateGremlinHint(("GusHintNode_" .. tostring(_Stage)))
  return 
end
local HintNodeShouldBeActive_S1 = {0, 0, 0, 0, 0}
local HintNodeShouldBeActive_S2 = {0, 0, 0, 0, 0}
local CompletelyDisabled = {0, 0}
NOS_BlotAlley_OswaldHint_CompletelyDisable = function(target, _Who, _Direction)
  Print(((("__Function: NOS_BlotAlley_OswaldHint_CompletelyDisable, _Who: " .. tostring(_Who)) .. ", _Direction: ") .. tostring(_Direction)))
  if (_Who == "Section1") then
    if (_Direction == "Down") then
      CompletelyDisabled[1] = 1
      NOS_BlotAlley_OswaldPathHandler(nil, "None", "OswaldPath_Section1")
    elseif (_Direction == "Up") then
      CompletelyDisabled[1] = 0
      local (for index), (for limit), (for step) = 1, 5, 1
      for x = (for index), (for limit), (for step) do
        if (HintNodeShouldBeActive_S1[x] == 1) then
          Print((("__Re-enabling node: " .. tostring(x)) .. "!"))
          NOS_BlotAlley_OswaldPathHandler(nil, ("OswaldPath_Section1_Node" .. tostring(x)), "OswaldPath_Section1")
        end
      end
      if (_Who == "Section2") then
        if (_Direction == "Down") then
          CompletelyDisabled[2] = 1
          NOS_BlotAlley_OswaldPathHandler(nil, "None", "OswaldPath_Section2")
        elseif (_Direction == "Up") then
          CompletelyDisabled[2] = 0
        end
      end
    end
  elseif (_Who == "Section2") then
    if (_Direction == "Down") then
      CompletelyDisabled[2] = 1
      NOS_BlotAlley_OswaldPathHandler(nil, "None", "OswaldPath_Section2")
    elseif (_Direction == "Up") then
      CompletelyDisabled[2] = 0
    end
  end
  return 
end
NOS_BlotAlley_OswaldHintTriggerHit = function(target, _Direction)
  Print(("__Function: NOS_BlotAlley_OswaldHintTriggerHit, _Direction: " .. tostring(_Direction)))
  local Group = GetPropertyString(target, "EntityGroups", 0)
  local Hints = {}
  local Section = string.sub(Group, -5, -5)
  Print(("__Section: " .. tostring(Section)))
  if (_Direction == "Forward") then
    Print(("__Hint To Disable: " .. tostring(Hints[1])))
    Print(("__Hint To Enable: " .. tostring(Hints[2])))
    if (Hints[2] == "0") then
      Print("__Reached last node in this chain! Will disable everything")
      NOS_BlotAlley_OswaldPathHandler(nil, "None", ("OswaldPath_Section" .. tostring(Section)))
    else
      local ToEnable = ((("OswaldPath_Section" .. tostring(Section)) .. "_Node") .. tostring(Hints[2]))
      Print(("__Will Enable Node: " .. tostring(ToEnable)))
      NOS_BlotAlley_OswaldPathHandler(nil, ToEnable, ("OswaldPath_Section" .. tostring(Section)))
      if (_Direction == "Backward") then
        Print(("__Hint To Disable: " .. tostring(Hints[2])))
        Print(("__Hint To Enable: " .. tostring(Hints[1])))
        if (Hints[1] == "0") then
          Print("__Reached beginning node in this chain! Will disable everything")
          NOS_BlotAlley_OswaldPathHandler(nil, "None", ("OswaldPath_Section" .. tostring(Section)))
        else
          local ToEnable, ToEnable = ((("OswaldPath_Section" .. tostring(Section)) .. "_Node") .. tostring(Hints[1])), tostring(Section)
          ToEnable = Print
          ToEnable(("__Will Enable Node: " .. tostring(ToEnable)))
          ToEnable = NOS_BlotAlley_OswaldPathHandler
          ToEnable(nil, ToEnable, ("OswaldPath_Section" .. tostring(Section)))
        end
      end
    end
  elseif (_Direction == "Backward") then
    Print(("__Hint To Disable: " .. tostring(Hints[2])))
    Print(("__Hint To Enable: " .. tostring(Hints[1])))
    if (Hints[1] == "0") then
      Print("__Reached beginning node in this chain! Will disable everything")
      NOS_BlotAlley_OswaldPathHandler(nil, "None", ("OswaldPath_Section" .. tostring(Section)))
    else
      local ToEnable, ToEnable = ((("OswaldPath_Section" .. tostring(Section)) .. "_Node") .. tostring(Hints[1])), tostring(Section)
      ToEnable = Print
      ToEnable(("__Will Enable Node: " .. tostring(ToEnable)))
      ToEnable = NOS_BlotAlley_OswaldPathHandler
      ToEnable(nil, ToEnable, ("OswaldPath_Section" .. tostring(Section)))
    end
  end
  return 
end
NOS_BlotAlley_OswaldPathHandler = function(target, _NodeToActivate, ...)
  Print("__Function: NOS_BlotAlley_OswaldPathHandler")
  local DeactivateArgs = {}
  if ((#DeactivateArgs) ~= 0) then
    local (for index), (for limit), (for step) = 1, (#DeactivateArgs), 1
    for x = (for index), (for limit), (for step) do
      Print(("__Disabling all nodes in group: " .. tostring(DeactivateArgs[x])))
      ForEachEntityInGroup(Disable, DeactivateArgs[x])
    end
  end
  Print(("__Enabling Node: " .. tostring(_NodeToActivate)))
  if (_NodeToActivate ~= "None") then
    local Section = tostring(string.sub(_NodeToActivate, -7, -7))
    local ShouldBeActiveTable = 0
    if (Section == "1") then
      ShouldBeActiveTable = HintNodeShouldBeActive_S1
    elseif (Section == "2") then
      ShouldBeActiveTable = HintNodeShouldBeActive_S2
    end
    Section = Section
    local Table = NOS_BlotAlley_ConvertOswaldStateGlobalToTable(("NOS_BlotAlley_OswaldNodeStates_S" .. Section))
    Section = (#Table)
    ShouldBeActiveTable = 1
    local (for index) = 1
    for Table = (for index), Section, ShouldBeActiveTable do
      (for index) = Print
      (for limit) = "__Table Value["
      (for step) = tostring
      x = Table
      (for step) = (for step)(x)
      x = "]: "
      (for limit) = ((((for limit) .. (for step)) .. x) .. tostring(Table[Table]))
      (for index)((for limit))
    end
    Section = string
    Section = Section.sub
    ShouldBeActiveTable = _NodeToActivate
    Table = -1
    Section = Section(ShouldBeActiveTable, Table, -1)
    local Hint = tonumber(Section)
    Section = 1
    ShouldBeActiveTable = (#ShouldBeActiveTable)
    Table = 1
    for x = Section, ShouldBeActiveTable, Table do
      if (x ~= Hint) then
        ShouldBeActiveTable[x] = 0
      else
        ShouldBeActiveTable[x] = 1
      end
      Hint = x
      Hint = "]: "
      (for index) = tostring
      (for limit) = ShouldBeActiveTable[x]
      (for index) = (for index)((for limit))
      Print(((("__ShouldBeActiveTable[" .. tostring(Hint)) .. Hint) .. (for index)))
    end
    Section = Table[Hint]
    if (Section == 1) then
      Section = CompletelyDisabled
      ShouldBeActiveTable = tonumber
      Table = Section
      ShouldBeActiveTable = ShouldBeActiveTable(Table)
      Section = Section[ShouldBeActiveTable]
      if (Section == 0) then
        Section = GetPropertyBool
        ShouldBeActiveTable = GetPlayer
        ShouldBeActiveTable = ShouldBeActiveTable()
        Table = "Invisible"
        Section = Section(ShouldBeActiveTable, Table)
        if (Section == false) then
          Section = Print
          ShouldBeActiveTable = "__This node should activate!"
          Section(ShouldBeActiveTable)
          if (_NodeToActivate == "OswaldPath_Section1_Node3") then
            Section = GetGlobal
            ShouldBeActiveTable = "NOS_BlotAlley_AnimTreesGrown"
            Section = Section(ShouldBeActiveTable)
            if (Section == 0) then
              Section = SetPropertyBool
              ShouldBeActiveTable = _NodeToActivate
              Table = "TakeNoAction"
              Section(ShouldBeActiveTable, Table, false)
            else
              Section = SetPropertyBool
              ShouldBeActiveTable = _NodeToActivate
              Table = "TakeNoAction"
              Section(ShouldBeActiveTable, Table, true)
            end
          end
          Section = Enable
          ShouldBeActiveTable = _NodeToActivate
          Section(ShouldBeActiveTable)
        end
      end
    else
      Section = Print
      ShouldBeActiveTable = "__Something is stopping this hint from being active! ShouldBeActiveTable for this object set to 1, will activate next time it's able!"
      Section(ShouldBeActiveTable)
      Section = Print
      ShouldBeActiveTable = "__ShouldBeActiveTable["
      Table = tostring
      Table = Table(Hint)
      ShouldBeActiveTable = (((ShouldBeActiveTable .. Table) .. "]: ") .. tostring(ShouldBeActiveTable[Hint]))
      Section(ShouldBeActiveTable)
    end
  end
  return 
end
NOS_BlotAlley_ConvertOswaldStateGlobalToTable = function(Global)
  Print(("__Function: NOS_BlotAlley_ConvertOswaldStateGlobalToTable, Global: " .. tostring(Global)))
  local GlobalTable = tostring(GetGlobal(Global))
  local TableLength = string.len(GlobalTable)
  Print(("__GlobalTableSize: " .. tostring(string.len(GlobalTable))))
  local Table = {0}
  local (for index), (for limit), (for step) = 1, TableLength, 1
  for x = (for index), (for limit), (for step) do
    local State = tonumber(string.sub(GlobalTable, x, x))
    if ((#Table) == 1) then
      Table[x] = State
    else
      table.insert(Table, State)
    end
  end
  return Table
end
NOS_BlotAlley_ConvertOswaldTableToGlobal = function(Table)
  Print("__Function: NOS_BlotAlley_ConvertOswaldTableToGlobal")
  local ToSet = ""
  local (for index), (for limit), (for step) = 1, (#Table), 1
  for x = (for index), (for limit), (for step) do
    Print(((("__Table[" .. tostring(x)) .. "]: ") .. tostring(Table[x])))
    ToSet = (ToSet .. tostring(Table[x]))
  end
  Print(("ToSet: " .. tostring(ToSet)))
  return tonumber(ToSet)
end
NOS_BlotAlley_OswaldHintManipulator = function(target, _WhatAreWe, ...)
  Print(("__Function: NOS_BlotAlley_OswaldHintManipulator, _WhatAreWe: " .. tostring(_WhatAreWe)))
  if (_WhatAreWe == "Room1Balcony1") then
    local Table = NOS_BlotAlley_ConvertOswaldStateGlobalToTable("NOS_BlotAlley_OswaldNodeStates_S1")
    if (_WhatAreWe == "Room1Balcony1") then
      Print("__Room1 Balcony State Change")
      local args = {}
      if (args[1] == "Painted") then
        if (GetGlobal("NOS_BlotAlley_Bell1Rang") == 0) then
          Print("__Bell not rung! will set to activate this hint")
          Table[2] = 1
        end
        if (HintNodeShouldBeActive_S1[2] == 1) then
          if (GetGlobal("NOS_BlotAlley_Bell1Rang") == 0) then
            if (CompletelyDisabled[1] == 0) then
              Print("__We should be enabled based on where mickey is! Enable us!")
              Enable("OswaldPath_Section1_Node2")
            end
          end
        else
          Print("__We should NOT be enabled based on where mickey is! Don't do anything except set us up to activate!")
          if (args[1] == "Thinned") then
            Print("__Disable us!")
            Table[2] = 0
            Disable("OswaldPath_Section1_Node2")
            if (_WhatAreWe == "Bell1Rung") then
              Print("__Bell 1 Rung! will deactivate all upper oswald hints on the balconies")
              Table[2] = 0
              Table[3] = 0
              Disable("OswaldPath_Section1_Node2")
              Disable("OswaldPath_Section1_Node3")
            elseif (_WhatAreWe == "ThirdBalcony") then
              local args, args = {}, ...
              args = args[1]
              if (args == "Painted") then
                args = SetGlobal
                args("NOS_BlotAlley_OswaldPlatformPathClear", (GetGlobal("NOS_BlotAlley_OswaldPlatformPathClear") + 1))
              else
                args = args[1]
                if (args == "Thinned") then
                  args = SetGlobal
                  args("NOS_BlotAlley_OswaldPlatformPathClear", (GetGlobal("NOS_BlotAlley_OswaldPlatformPathClear") - 1))
                end
              end
              args = GetGlobal
              args = args("NOS_BlotAlley_OswaldPlatformPathClear")
              if (0 < args) then
                args = CompletelyDisabled
                args = args[1]
                if (args == 0) then
                  Table[3] = 1
                  args = HintNodeShouldBeActive_S1
                  args = args[3]
                  if (args == 1) then
                    args = Enable
                    args("OswaldPath_Section1_Node3")
                  end
                end
              else
                Table[3] = 0
                args = Disable
                args("OswaldPath_Section1_Node3")
                if (_WhatAreWe == "LastBalcony") then
                  local args = {}
                  if (args[1] == "Painted") then
                    Table[4] = 1
                    if (HintNodeShouldBeActive_S1[4] == 1) then
                      if (CompletelyDisabled[1] == 0) then
                        args = "OswaldPath_Section1_Node4"
                        Enable(args)
                      end
                    end
                  elseif (args[1] == "Thinned") then
                    Table[4] = 0
                    args = "OswaldPath_Section1_Node4"
                    Disable(args)
                    if (_WhatAreWe == "PathToAirlock") then
                      Print("__PathToAirlock State Change!")
                      local args = {}
                      if (args[1] == "Painted") then
                        args = GetGlobal
                        args = args("NOS_BlotAlley_OswaldS1PathClear")
                        args = (args + 1)
                        SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
                      elseif (args[1] == "Thinned") then
                        args = GetGlobal
                        args = args("NOS_BlotAlley_OswaldS1PathClear")
                        args = (args - 1)
                        SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
                      end
                      if (GetGlobal("NOS_BlotAlley_OswaldS1PathClear") == 4) then
                        if (CompletelyDisabled[1] == 0) then
                          Table[5] = 1
                          if (HintNodeShouldBeActive_S1[5] == 1) then
                            Enable("OswaldPath_Section1_Node5")
                          end
                        end
                      else
                        Table[5] = 0
                        Disable("OswaldPath_Section1_Node5")
                      end
                    end
                  end
                elseif (_WhatAreWe == "PathToAirlock") then
                  Print("__PathToAirlock State Change!")
                  local args = {}
                  if (args[1] == "Painted") then
                    args = GetGlobal
                    args = args("NOS_BlotAlley_OswaldS1PathClear")
                    args = (args + 1)
                    SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
                  elseif (args[1] == "Thinned") then
                    args = GetGlobal
                    args = args("NOS_BlotAlley_OswaldS1PathClear")
                    args = (args - 1)
                    SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
                  end
                  if (GetGlobal("NOS_BlotAlley_OswaldS1PathClear") == 4) then
                    if (CompletelyDisabled[1] == 0) then
                      Table[5] = 1
                      if (HintNodeShouldBeActive_S1[5] == 1) then
                        Enable("OswaldPath_Section1_Node5")
                      end
                    end
                  else
                    Table[5] = 0
                    Disable("OswaldPath_Section1_Node5")
                  end
                end
              end
            elseif (_WhatAreWe == "LastBalcony") then
              local args = {}
              if (args[1] == "Painted") then
                Table[4] = 1
                if (HintNodeShouldBeActive_S1[4] == 1) then
                  if (CompletelyDisabled[1] == 0) then
                    args = "OswaldPath_Section1_Node4"
                    Enable(args)
                  end
                end
              elseif (args[1] == "Thinned") then
                Table[4] = 0
                args = "OswaldPath_Section1_Node4"
                Disable(args)
                if (_WhatAreWe == "PathToAirlock") then
                  Print("__PathToAirlock State Change!")
                  local args = {}
                  if (args[1] == "Painted") then
                    args = GetGlobal
                    args = args("NOS_BlotAlley_OswaldS1PathClear")
                    args = (args + 1)
                    SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
                  elseif (args[1] == "Thinned") then
                    args = GetGlobal
                    args = args("NOS_BlotAlley_OswaldS1PathClear")
                    args = (args - 1)
                    SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
                  end
                  if (GetGlobal("NOS_BlotAlley_OswaldS1PathClear") == 4) then
                    if (CompletelyDisabled[1] == 0) then
                      Table[5] = 1
                      if (HintNodeShouldBeActive_S1[5] == 1) then
                        Enable("OswaldPath_Section1_Node5")
                      end
                    end
                  else
                    Table[5] = 0
                    Disable("OswaldPath_Section1_Node5")
                  end
                end
              end
            elseif (_WhatAreWe == "PathToAirlock") then
              Print("__PathToAirlock State Change!")
              local args = {}
              if (args[1] == "Painted") then
                args = GetGlobal
                args = args("NOS_BlotAlley_OswaldS1PathClear")
                args = (args + 1)
                SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
              elseif (args[1] == "Thinned") then
                args = GetGlobal
                args = args("NOS_BlotAlley_OswaldS1PathClear")
                args = (args - 1)
                SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
              end
              if (GetGlobal("NOS_BlotAlley_OswaldS1PathClear") == 4) then
                if (CompletelyDisabled[1] == 0) then
                  Table[5] = 1
                  if (HintNodeShouldBeActive_S1[5] == 1) then
                    Enable("OswaldPath_Section1_Node5")
                  end
                end
              else
                Table[5] = 0
                Disable("OswaldPath_Section1_Node5")
              end
            end
          end
        end
      elseif (args[1] == "Thinned") then
        Print("__Disable us!")
        Table[2] = 0
        Disable("OswaldPath_Section1_Node2")
        if (_WhatAreWe == "Bell1Rung") then
          Print("__Bell 1 Rung! will deactivate all upper oswald hints on the balconies")
          Table[2] = 0
          Table[3] = 0
          Disable("OswaldPath_Section1_Node2")
          Disable("OswaldPath_Section1_Node3")
        elseif (_WhatAreWe == "ThirdBalcony") then
          local args, args = {}, ...
          args = args[1]
          if (args == "Painted") then
            args = SetGlobal
            args("NOS_BlotAlley_OswaldPlatformPathClear", (GetGlobal("NOS_BlotAlley_OswaldPlatformPathClear") + 1))
          else
            args = args[1]
            if (args == "Thinned") then
              args = SetGlobal
              args("NOS_BlotAlley_OswaldPlatformPathClear", (GetGlobal("NOS_BlotAlley_OswaldPlatformPathClear") - 1))
            end
          end
          args = GetGlobal
          args = args("NOS_BlotAlley_OswaldPlatformPathClear")
          if (0 < args) then
            args = CompletelyDisabled
            args = args[1]
            if (args == 0) then
              Table[3] = 1
              args = HintNodeShouldBeActive_S1
              args = args[3]
              if (args == 1) then
                args = Enable
                args("OswaldPath_Section1_Node3")
              end
            end
          else
            Table[3] = 0
            args = Disable
            args("OswaldPath_Section1_Node3")
            if (_WhatAreWe == "LastBalcony") then
              local args = {}
              if (args[1] == "Painted") then
                Table[4] = 1
                if (HintNodeShouldBeActive_S1[4] == 1) then
                  if (CompletelyDisabled[1] == 0) then
                    args = "OswaldPath_Section1_Node4"
                    Enable(args)
                  end
                end
              elseif (args[1] == "Thinned") then
                Table[4] = 0
                args = "OswaldPath_Section1_Node4"
                Disable(args)
                if (_WhatAreWe == "PathToAirlock") then
                  Print("__PathToAirlock State Change!")
                  local args = {}
                  if (args[1] == "Painted") then
                    args = GetGlobal
                    args = args("NOS_BlotAlley_OswaldS1PathClear")
                    args = (args + 1)
                    SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
                  elseif (args[1] == "Thinned") then
                    args = GetGlobal
                    args = args("NOS_BlotAlley_OswaldS1PathClear")
                    args = (args - 1)
                    SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
                  end
                  if (GetGlobal("NOS_BlotAlley_OswaldS1PathClear") == 4) then
                    if (CompletelyDisabled[1] == 0) then
                      Table[5] = 1
                      if (HintNodeShouldBeActive_S1[5] == 1) then
                        Enable("OswaldPath_Section1_Node5")
                      end
                    end
                  else
                    Table[5] = 0
                    Disable("OswaldPath_Section1_Node5")
                  end
                end
              end
            elseif (_WhatAreWe == "PathToAirlock") then
              Print("__PathToAirlock State Change!")
              local args = {}
              if (args[1] == "Painted") then
                args = GetGlobal
                args = args("NOS_BlotAlley_OswaldS1PathClear")
                args = (args + 1)
                SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
              elseif (args[1] == "Thinned") then
                args = GetGlobal
                args = args("NOS_BlotAlley_OswaldS1PathClear")
                args = (args - 1)
                SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
              end
              if (GetGlobal("NOS_BlotAlley_OswaldS1PathClear") == 4) then
                if (CompletelyDisabled[1] == 0) then
                  Table[5] = 1
                  if (HintNodeShouldBeActive_S1[5] == 1) then
                    Enable("OswaldPath_Section1_Node5")
                  end
                end
              else
                Table[5] = 0
                Disable("OswaldPath_Section1_Node5")
              end
            end
          end
        elseif (_WhatAreWe == "LastBalcony") then
          local args = {}
          if (args[1] == "Painted") then
            Table[4] = 1
            if (HintNodeShouldBeActive_S1[4] == 1) then
              if (CompletelyDisabled[1] == 0) then
                args = "OswaldPath_Section1_Node4"
                Enable(args)
              end
            end
          elseif (args[1] == "Thinned") then
            Table[4] = 0
            args = "OswaldPath_Section1_Node4"
            Disable(args)
            if (_WhatAreWe == "PathToAirlock") then
              Print("__PathToAirlock State Change!")
              local args = {}
              if (args[1] == "Painted") then
                args = GetGlobal
                args = args("NOS_BlotAlley_OswaldS1PathClear")
                args = (args + 1)
                SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
              elseif (args[1] == "Thinned") then
                args = GetGlobal
                args = args("NOS_BlotAlley_OswaldS1PathClear")
                args = (args - 1)
                SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
              end
              if (GetGlobal("NOS_BlotAlley_OswaldS1PathClear") == 4) then
                if (CompletelyDisabled[1] == 0) then
                  Table[5] = 1
                  if (HintNodeShouldBeActive_S1[5] == 1) then
                    Enable("OswaldPath_Section1_Node5")
                  end
                end
              else
                Table[5] = 0
                Disable("OswaldPath_Section1_Node5")
              end
            end
          end
        elseif (_WhatAreWe == "PathToAirlock") then
          Print("__PathToAirlock State Change!")
          local args = {}
          if (args[1] == "Painted") then
            args = GetGlobal
            args = args("NOS_BlotAlley_OswaldS1PathClear")
            args = (args + 1)
            SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
          elseif (args[1] == "Thinned") then
            args = GetGlobal
            args = args("NOS_BlotAlley_OswaldS1PathClear")
            args = (args - 1)
            SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
          end
          if (GetGlobal("NOS_BlotAlley_OswaldS1PathClear") == 4) then
            if (CompletelyDisabled[1] == 0) then
              Table[5] = 1
              if (HintNodeShouldBeActive_S1[5] == 1) then
                Enable("OswaldPath_Section1_Node5")
              end
            end
          else
            Table[5] = 0
            Disable("OswaldPath_Section1_Node5")
          end
        end
      end
    elseif (_WhatAreWe == "Bell1Rung") then
      Print("__Bell 1 Rung! will deactivate all upper oswald hints on the balconies")
      Table[2] = 0
      Table[3] = 0
      Disable("OswaldPath_Section1_Node2")
      Disable("OswaldPath_Section1_Node3")
    elseif (_WhatAreWe == "ThirdBalcony") then
      local args, args = {}, ...
      args = args[1]
      if (args == "Painted") then
        args = SetGlobal
        args("NOS_BlotAlley_OswaldPlatformPathClear", (GetGlobal("NOS_BlotAlley_OswaldPlatformPathClear") + 1))
      else
        args = args[1]
        if (args == "Thinned") then
          args = SetGlobal
          args("NOS_BlotAlley_OswaldPlatformPathClear", (GetGlobal("NOS_BlotAlley_OswaldPlatformPathClear") - 1))
        end
      end
      args = GetGlobal
      args = args("NOS_BlotAlley_OswaldPlatformPathClear")
      if (0 < args) then
        args = CompletelyDisabled
        args = args[1]
        if (args == 0) then
          Table[3] = 1
          args = HintNodeShouldBeActive_S1
          args = args[3]
          if (args == 1) then
            args = Enable
            args("OswaldPath_Section1_Node3")
          end
        end
      else
        Table[3] = 0
        args = Disable
        args("OswaldPath_Section1_Node3")
        if (_WhatAreWe == "LastBalcony") then
          local args = {}
          if (args[1] == "Painted") then
            Table[4] = 1
            if (HintNodeShouldBeActive_S1[4] == 1) then
              if (CompletelyDisabled[1] == 0) then
                args = "OswaldPath_Section1_Node4"
                Enable(args)
              end
            end
          elseif (args[1] == "Thinned") then
            Table[4] = 0
            args = "OswaldPath_Section1_Node4"
            Disable(args)
            if (_WhatAreWe == "PathToAirlock") then
              Print("__PathToAirlock State Change!")
              local args = {}
              if (args[1] == "Painted") then
                args = GetGlobal
                args = args("NOS_BlotAlley_OswaldS1PathClear")
                args = (args + 1)
                SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
              elseif (args[1] == "Thinned") then
                args = GetGlobal
                args = args("NOS_BlotAlley_OswaldS1PathClear")
                args = (args - 1)
                SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
              end
              if (GetGlobal("NOS_BlotAlley_OswaldS1PathClear") == 4) then
                if (CompletelyDisabled[1] == 0) then
                  Table[5] = 1
                  if (HintNodeShouldBeActive_S1[5] == 1) then
                    Enable("OswaldPath_Section1_Node5")
                  end
                end
              else
                Table[5] = 0
                Disable("OswaldPath_Section1_Node5")
              end
            end
          end
        elseif (_WhatAreWe == "PathToAirlock") then
          Print("__PathToAirlock State Change!")
          local args = {}
          if (args[1] == "Painted") then
            args = GetGlobal
            args = args("NOS_BlotAlley_OswaldS1PathClear")
            args = (args + 1)
            SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
          elseif (args[1] == "Thinned") then
            args = GetGlobal
            args = args("NOS_BlotAlley_OswaldS1PathClear")
            args = (args - 1)
            SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
          end
          if (GetGlobal("NOS_BlotAlley_OswaldS1PathClear") == 4) then
            if (CompletelyDisabled[1] == 0) then
              Table[5] = 1
              if (HintNodeShouldBeActive_S1[5] == 1) then
                Enable("OswaldPath_Section1_Node5")
              end
            end
          else
            Table[5] = 0
            Disable("OswaldPath_Section1_Node5")
          end
        end
      end
    elseif (_WhatAreWe == "LastBalcony") then
      local args = {}
      if (args[1] == "Painted") then
        Table[4] = 1
        if (HintNodeShouldBeActive_S1[4] == 1) then
          if (CompletelyDisabled[1] == 0) then
            args = "OswaldPath_Section1_Node4"
            Enable(args)
          end
        end
      elseif (args[1] == "Thinned") then
        Table[4] = 0
        args = "OswaldPath_Section1_Node4"
        Disable(args)
        if (_WhatAreWe == "PathToAirlock") then
          Print("__PathToAirlock State Change!")
          local args = {}
          if (args[1] == "Painted") then
            args = GetGlobal
            args = args("NOS_BlotAlley_OswaldS1PathClear")
            args = (args + 1)
            SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
          elseif (args[1] == "Thinned") then
            args = GetGlobal
            args = args("NOS_BlotAlley_OswaldS1PathClear")
            args = (args - 1)
            SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
          end
          if (GetGlobal("NOS_BlotAlley_OswaldS1PathClear") == 4) then
            if (CompletelyDisabled[1] == 0) then
              Table[5] = 1
              if (HintNodeShouldBeActive_S1[5] == 1) then
                Enable("OswaldPath_Section1_Node5")
              end
            end
          else
            Table[5] = 0
            Disable("OswaldPath_Section1_Node5")
          end
        end
      end
    elseif (_WhatAreWe == "PathToAirlock") then
      Print("__PathToAirlock State Change!")
      local args = {}
      if (args[1] == "Painted") then
        args = GetGlobal
        args = args("NOS_BlotAlley_OswaldS1PathClear")
        args = (args + 1)
        SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
      elseif (args[1] == "Thinned") then
        args = GetGlobal
        args = args("NOS_BlotAlley_OswaldS1PathClear")
        args = (args - 1)
        SetGlobal("NOS_BlotAlley_OswaldS1PathClear", args)
      end
      if (GetGlobal("NOS_BlotAlley_OswaldS1PathClear") == 4) then
        if (CompletelyDisabled[1] == 0) then
          Table[5] = 1
          if (HintNodeShouldBeActive_S1[5] == 1) then
            Enable("OswaldPath_Section1_Node5")
          end
        end
      else
        Table[5] = 0
        Disable("OswaldPath_Section1_Node5")
      end
    end
    local ToSet = NOS_BlotAlley_ConvertOswaldTableToGlobal(Table)
    ToSet = ToSet
    Print(("__Will set global to: " .. tostring(ToSet)))
    SetGlobal("NOS_BlotAlley_OswaldNodeStates_S1", ToSet)
  end
  return 
end
NOS_BlotAlley_Room1_JumpVolumeToggle = function(target, _Direction)
  Print("__Function: NOS_BlotAlley_Room1_DisableAISightLines")
  if (_Direction == "Backward") then
    disableJumpVolumeAvailability("OswaldDrop_00")
  elseif (_Direction == "Forward") then
    enableJumpVolumeAvailability("OswaldDrop_00")
  end
  return 
end
NOS_BlotAlley_IanRVStreamed = function(target)
  Print("__Function: NOS_BlotAlley_IanRVStreamed")
  if (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 1) then
    Hide("NOS_BlotAlley_Ian_RV")
  end
  return 
end
NOS_BlotAlley_IanAngryRollup = function(target)
  Print("__Function: NOS_BlotAlley_IanAngryRollup")
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  SetPropertyFloat("NOS_BlotAlley_Ian_RV", "UsableRadius", 0)
  AnimVarInt("NOS_BlotAlley_Ian_RV", VAR_Cutscene, 1)
  AnimEvent("NOS_BlotAlley_Ian_RV", EVENT_Start_Cutscene)
  wait(1.7999999523162842)
  StartFadeOut(0.800000011920929)
  wait(0.800000011920929)
  LevelManager_SetCurrentState("nos_blotalley_main.section1_visit2_noian")
  ClearAllCameraAttributes()
  EnableSplitScreen(true)
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
  SetCameraAttributesForPlayer(GetRelativePrefabEntity("NOS_BlotAlley_BogEasyProjector", ".ProjectorMarker"), GetPlayer())
  SetCameraAttributesForPlayer(GetRelativePrefabEntity("NOS_BlotAlley_BogEasyProjector", ".ProjectorMarker"), GetPlayer2OrAI())
  WaitForLevelLoad()
  StartFadeIn(0.800000011920929)
  ShowHud()
  UnrestrictCutSceneInput()
  NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Section1_Projector")
  return 
end
NOS_BlotAlley_ConceptArtPickedUp = function(target)
  Print("__Function: NOS_BlotAlley_ConceptArtPickedUp")
  NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Section2_Airlock")
  return 
end
NOS_BlotAlley_FireworksKilledInThinner = function(target)
  Print("__Function: NOS_BlotAlley_FireworksKilledInThinner")
  local ActivatorName = GetName(_activator())
  if (ActivatorName == "nos_blotalley_01a_propsscripting.Fireworks_Section2 08") then
    DestroyEntity(_activator())
  end
  local data = GetPrefabData("FireworksSpawner_BlotAlley")
  DestroyEntity(_activator())
  Print(((("Mickey is in the trigger : " .. data.MickeyInTrigger) .. "Oswald is in the trigger ") .. data.OswaldInTrigger))
  wait(3)
  while true do
    if (data.MickeyInTrigger == "True") then
      wait(0.10000000149011612)
    end
  end
  AudioPostEventOn(GetRelativePrefabEntity("FireworksSpawner_BlotAlley", ".Doors"), "Play_sfx_gbl_fireworks_door_close")
  AnimGBSequence(GetRelativePrefabEntity("FireworksSpawner_BlotAlley", ".Doors"), "close", true)
  data.DispenserActive = "True"
  SetPropertyFloat(GetRelativePrefabEntity("FireworksSpawner_BlotAlley", ".HandleToGrab"), "UsableRadius", 3)
  return 
end
NOS_BlotAlley_KillPlayersInSweeperCubbyHole = function(target)
  Print("__Function: NOS_BlotAlley_KillPlayersInSweeperCubbyHole")
  Kill(_activator())
  return 
end
NOS_BlotAlley_Section4ProjectorEntered = function(target)
  Print("__Function: NOS_BlotAlley_Section4ProjectorEntered")
  if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
    if (GetGlobal("NOS_BlotAlley_PeteRewardUnavailable") == 0) then
      Print("__First Visit! Will set up endgame variables!")
      local ProgressBeforeProjector = GetGlobal("NOS_BlotAlleyProgress")
      Print(("__ProgressBeforeProjector: " .. tostring(ProgressBeforeProjector)))
      SetGlobal("NOS_BlotAlleyProgress", 1)
      SetGlobal("NOS_BlotAlley_PeteRewardUnavailable", 1)
      if (ProgressBeforeProjector == 0) then
        Print("__Setting pete to bad ending!")
        SetGlobal("Extras_Petetronic_Present", 1)
        SetGlobal("BTA_QuestHealth", (GetGlobal("BTA_QuestHealth") - 5))
      else
        Print("__Setting pete to good ending!")
        SetGlobal("Extras_Petetronic_Present", 0)
        SetGlobal("BTA_QuestHealth", (GetGlobal("BTA_QuestHealth") + 5))
        Print("__Either it's return visit or we came through here already! Dont do anything!")
      end
    end
  else
    Print("__Either it's return visit or we came through here already! Dont do anything!")
  end
  SetupPosition(target)
  return 
end
