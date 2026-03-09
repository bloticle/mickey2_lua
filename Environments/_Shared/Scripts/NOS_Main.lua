NOS_EnterProjector = function(target, _ToWhere)
  Print(("__Function: NOS_EnterProjector, _ToWhere: " .. tostring(_ToWhere)))
  if (_ToWhere ~= "MSN") then
  end
  Mickey_Projector_Enter()
  return 
end
NOS_PickBlotAlleyVisit = function(target)
  Print("__Function: NOS_PickBlotAlleyVisit")
  Print("Setting FirstVisit Global")
  SetGlobal("NOS_BogEasy_FirstVisit", 0)
  if (GetGlobal("NOS_BogEasy_MagicShopEligibleForUpgrade") == 0) then
    Print("__Magic shop not built up! will not build later!")
  else
    Print("__Magic shop paid for! will build later!")
    SetGlobal("NOS_BogEasy_MagicShopEligibleForUpgrade", 2)
  end
  if (GetGlobal("NOS_BogEasy_DonaldQuest_DonaldTimerState") == -1) then
    Print("__Donald quest not started or done! Will not update")
  end
  Print("__Donald quest active!")
  local FinishQuest = false
  if (not (not Quest_CheckStatus("Donalds_Date", "Donalds_Date_1", Quest_Discovered))) then
    Quest_SetStatus("Donalds_Date", "Donalds_Date_1", Quest_Unavailable, false)
  end
  if (not (not Quest_CheckStatus("Donalds_Date", "Donalds_Date_4", Quest_Discovered))) then
    Quest_SetStatus("Donalds_Date", "Donalds_Date_4", Quest_Unavailable, false)
  end
  if Quest_CheckStatus("Donalds_Date", "Donalds_Date_4", Quest_Completed) then
    Print("__Forge was fixed! We should send donald off at least in his tugboat")
    FinishQuest = true
  end
  if (not (not Quest_CheckStatus("Donalds_Date", "Donalds_Date_2", Quest_Discovered))) then
    Quest_SetStatus("Donalds_Date", "Donalds_Date_2", Quest_Unavailable, false)
  end
  Print(("__FinishQuest: " .. tostring(FinishQuest)))
  if (FinishQuest == true) then
    GiveCollectible("Challenge_Perfectionist_DonaldDate_Tracker")
    if (GetGlobal("NOS_BogEasy_DonaldQuest_WhichGear") == 10) then
      SetGlobal("NOS_BogEasy_DonaldQuest_WhichCompleted", 1)
      SetGlobal("Extras_Donald_And_Daisy_Paint", 1)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3a", Quest_Unavailable, false)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3b", Quest_Completed, true)
    else
      SetGlobal("NOS_BogEasy_DonaldQuest_WhichCompleted", -1)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3a", Quest_Completed, true)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3b", Quest_Unavailable, false)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3a", Quest_Unavailable, false)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3b", Quest_Unavailable, false)
    end
  else
    Quest_SetStatus("Donalds_Date", "Donalds_Date_3a", Quest_Unavailable, false)
    Quest_SetStatus("Donalds_Date", "Donalds_Date_3b", Quest_Unavailable, false)
  end
  NOS_BogEasy_ReturnVisit_DonaldQuestLeftZone(nil)
  SetupPosition(target)
  return 
end
NOS_BogEasy_2DToBogEasySetup = function(target)
  Print("__Function: NOS_BogEasy_2DToBogEasySetup")
  SetGlobal("NOS_BogEasy_FirstVisitProgress", 4)
  GetPrefabData("NOS_BogEasy_ToBlotAlleyProjector").MapLoad_SetupPosition = "True"
  SetupPosition(target)
  return 
end
NOS_PickMSTNVisit = function(target)
  Print("__Function: NOS_PickMSTNVisit")
  if (GetGlobal("NOS_BogEasy_MagicShopEligibleForUpgrade") == 0) then
    Print("__Magic shop not built up! will not build later!")
  else
    Print("__Magic shop paid for! will build later!")
    SetGlobal("NOS_BogEasy_MagicShopEligibleForUpgrade", 2)
  end
  if (GetGlobal("NOS_BogEasy_DonaldQuest_DonaldTimerState") == -1) then
    Print("__Donald quest not started or done! Will not update")
  end
  Print("__Donald quest active!")
  local FinishQuest = false
  if (not (not Quest_CheckStatus("Donalds_Date", "Donalds_Date_1", Quest_Discovered))) then
    Quest_SetStatus("Donalds_Date", "Donalds_Date_1", Quest_Unavailable, false)
  end
  if (not (not Quest_CheckStatus("Donalds_Date", "Donalds_Date_4", Quest_Discovered))) then
    Quest_SetStatus("Donalds_Date", "Donalds_Date_4", Quest_Unavailable, false)
  end
  if Quest_CheckStatus("Donalds_Date", "Donalds_Date_4", Quest_Completed) then
    Print("__Forge was fixed! We should send donald off at least in his tugboat")
    FinishQuest = true
  end
  if (not (not Quest_CheckStatus("Donalds_Date", "Donalds_Date_2", Quest_Discovered))) then
    Quest_SetStatus("Donalds_Date", "Donalds_Date_2", Quest_Unavailable, false)
  end
  Print(("__FinishQuest: " .. tostring(FinishQuest)))
  if (FinishQuest == true) then
    GiveCollectible("Challenge_Perfectionist_DonaldDate_Tracker")
    if (GetGlobal("NOS_BogEasy_DonaldQuest_WhichGear") == 10) then
      SetGlobal("NOS_BogEasy_DonaldQuest_WhichCompleted", 1)
      SetGlobal("Extras_Donald_And_Daisy_Paint", 1)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3a", Quest_Unavailable, false)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3b", Quest_Completed, true)
    else
      SetGlobal("NOS_BogEasy_DonaldQuest_WhichCompleted", -1)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3a", Quest_Completed, true)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3b", Quest_Unavailable, false)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3a", Quest_Unavailable, false)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3b", Quest_Unavailable, false)
    end
  else
    Quest_SetStatus("Donalds_Date", "Donalds_Date_3a", Quest_Unavailable, false)
    Quest_SetStatus("Donalds_Date", "Donalds_Date_3b", Quest_Unavailable, false)
  end
  NOS_BogEasy_ReturnVisit_DonaldQuestLeftZone(nil)
  SetupPosition(target)
  return 
end
local comingFromCheckpoint = false
NOS_BogEasy_LoadCheckpoint = function(target)
  Print("__Function: NOS_BogEasy_LoadCheckpoint")
  comingFromCheckpoint = true
  NOS_AlwaysSetup(target)
  return 
end
NOS_BogEasy_SaveCheckpoint = function(_Marker, _SkipWait)
  Print(("__Function: NOS_BogEasy_SaveCheckpoint, _Marker: " .. tostring(_Marker)))
  local OswaldMarker = (_Marker .. "_Oswald")
  Print(("__OswaldMarker: " .. tostring(OswaldMarker)))
  if (_SkipWait == nil) then
    while true do
      if (not (IsAnySequencePlaying() == true)) then
        break
      end
      wait(0.10000000149011612)
    end
  end
  if (_Marker == "CHECKPOINT_Projector_MeanStreet") then
    SetGlobal("NOS_BogEasy_LastCheckpointLocation", 0)
  elseif (_Marker == "CHECKPOINT_ShantyShop_ShantyTown") then
    SetGlobal("NOS_BogEasy_LastCheckpointLocation", 1)
  elseif (_Marker == "CHECKPOINT_ShantyShop_LouisShack") then
    SetGlobal("NOS_BogEasy_LastCheckpointLocation", 2)
  elseif (_Marker == "CHECKPOINT_LouisShack_Airlock") then
    SetGlobal("NOS_BogEasy_LastCheckpointLocation", 3)
  elseif (_Marker == "CHECKPOINT_OldTown_Airlock") then
    SetGlobal("NOS_BogEasy_LastCheckpointLocation", 4)
  elseif (_Marker == "CHECKPOINT_OldTown") then
    SetGlobal("NOS_BogEasy_LastCheckpointLocation", 5)
  elseif (_Marker == "CHECKPOINT_Projector_BlotAlley") then
    SetGlobal("NOS_BogEasy_LastCheckpointLocation", 6)
  elseif (_Marker == "CHECKPOINT_TrainTeleportMarker_Mickey") then
    SetGlobal("NOS_BogEasy_LastCheckpointLocation", 7)
  end
  Print(("__NOS_BogEasy_LastCheckpointLocation value: " .. tostring(GetGlobal("NOS_BogEasy_LastCheckpointLocation"))))
  SaveCheckpoint(GetPlayer(), "NOS_AlwaysSetup", _Marker, OswaldMarker)
  return 
end
NOS_V1_MSSProjectorFlythroughTest = function(target)
  Print("__Function: NOS_HardLoadSetup")
  if (GetGlobal("NOS_BogEasy_FirstVisitProgress") == 0) then
    if (LevelManager_GetCurrentState() == "nos_bogeasy.shantytown_v1") then
      Print("__Priming to fire IGC!")
      GetPrefabData("NOS_BogEasy_ToMeanStreetProjector").ToFlyThrough = "True"
    end
  end
  return 
end
NOS_AlwaysSetup = function(target)
  Print("___NOS_MAIN_ALWAYS_SETUP")
  Print("__Streaming Blank Interior")
  StreamInterior(nil, "interior_blank_reload")
  Print(("___Picking Setup Script.  First Visit? " .. GetGlobal("NOS_BogEasy_FirstVisit")))
  if (target ~= nil) then
    Print("__Target not nil! We must be coming from a projector")
    if (LevelManager_GetCurrentState() == "nos_bogeasy.shantytown_v1") then
      if (GetGlobal("NOS_BogEasy_FirstVisitProgress") ~= 0) then
        NOS_BogEasy_TeleportPlayersToMSSProjectorLocation(target)
      end
    elseif (LevelManager_GetCurrentState() == "nos_bogeasy.shantytown_v2") then
      NOS_BogEasy_TeleportPlayersToMSSProjectorLocation(target)
      local LastCheckpointLocation = GetGlobal("NOS_BogEasy_LastCheckpointLocation")
      Print(("__LastCheckpointLocation: " .. tostring(LastCheckpointLocation)))
      if (LastCheckpointLocation == 0) then
        NOS_BogEasy_TeleportPlayersToMSSProjectorLocation(nil)
      else
      end
    end
  else
    local LastCheckpointLocation = GetGlobal("NOS_BogEasy_LastCheckpointLocation")
    Print(("__LastCheckpointLocation: " .. tostring(LastCheckpointLocation)))
    if (LastCheckpointLocation == 0) then
      NOS_BogEasy_TeleportPlayersToMSSProjectorLocation(nil)
    else
    end
  end
  NOS_BogEasy_AlwaysSetup(target)
  return 
end
NOS_BogEasy_TeleportPlayersToMSSProjectorLocation = function(target)
  Print("__Function: NOS_BogEasy_TeleportPlayersToMSSProjectorLocation")
  if (LevelManager_GetCurrentState() == "nos_bogeasy.shantytown_v2") then
    if (target == nil) then
      Print("__Coming from checkpoint! Dont need the extra fade out!")
    else
      StartFadeOut(0)
      ClearAllCameraAttributes()
      wait(0.4000000059604645)
    end
  end
  TeleportToEntity(GetPlayer(), "CHECKPOINT_Projector_MeanStreet")
  TeleportToEntity(GetPlayer2OrAI(), "OswaldTeleportAfterProjectorMarker")
  ClearAllCameraAttributes()
  CameraReset()
  wait(0.10000000149011612)
  SetCameraAttributesForPlayer(GetRelativePrefabEntity("NOS_BogEasy_ToMeanStreetProjector", ".ProjectorMarker"), GetPlayer())
  SetCameraAttributesForPlayer(GetRelativePrefabEntity("NOS_BogEasy_ToMeanStreetProjector", ".ProjectorMarker"), GetPlayer2OrAI())
  wait(0.800000011920929)
  if (LevelManager_GetCurrentState() == "nos_bogeasy.shantytown_v2") then
    wait(0.20000000298023224)
  end
  FireThread(NOS_BogEasy_SetStationaryCamera)
  if (target == nil) then
    Print("__Coming from checkpoint! Don't need the extra fade in")
  else
    StartFadeIn(0.800000011920929)
    UnrestrictCutSceneInput()
    ShowHud()
  end
  NOS_BogEasy_SaveCheckpoint("CHECKPOINT_Projector_MeanStreet")
  return 
end
NOS_BogEasy_SetStationaryCamera = function(target)
  Print("__Function: NOS_BogEasy_SetStationaryCamera")
  FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer2OrAI())
  StationaryCamera_UntilPlayerMoves()
  Disable("DamageLeapDisableTrigger")
  wait(0)
  Enable("DamageLeapDisableTrigger")
  return 
end
NOS_BogEasy_TeleportGremlinOutFromCage = function(target)
  Print("__Function: NOS_BogEasy_TeleportGremlinOutFromCage")
  if (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress") == -1) then
    Print("__Magic Shop hasn't been streamed before! Will set it to be able to be built")
    SetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress", 0)
  else
    Print(("__The magic shop has been streamed before! Value was: " .. tostring(GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress"))))
  end
  TeleportGremlinOut("NOS_BogEasy_GremlinSparks_Caged")
  NOS_BogEasy_SaveCheckpoint("CHECKPOINT_Projector_MeanStreet")
  return 
end
NOS_BogEasy_GusAirlockTutorial = function(target)
  Print("__Function: NOS_BogEasy_GusAirlockTutorial")
  FireSequence("NOS_BogEasy_Gus", "NOS_Gus_Airlock")
  return 
end
NOS_BogEasy_ShantyTrapDoorStateChange = function(target, _State)
  Print(("__Function: NOS_BogEasy_Visit1_ShantyTrapDoorThinned, _State: " .. tostring(_State)))
  if (_State == "Thinned") then
    Print("__Enabling interior trigger")
    if (GetGlobal("NOS_BogEasy_FirstVisit") == 1) then
      FireSequence("NOS_BogEasy_Gus", "NOS_Gus_ShantyTrapDoor")
    end
    Enable("NOS_BogEasy_EnterInterior_ShantyShop_TrapDoor")
  else
    Print("__Disabling interior trigger")
    Disable("NOS_BogEasy_EnterInterior_ShantyShop_TrapDoor")
  end
  return 
end
NOS_BogEasy_EnteredShantyShop = function(target)
  Print("__Function: NOS_BogEasy_EnteredShantyShop")
  Print("__SWITCHING STATE TO INT_ShantyShop!")
  Prefab_FireworksManager_StreamZoneOut("FireworksManager", "A")
  LevelManager_SetCurrentState("NOS_BogEasy.ShantyShop")
  SetPropertyBool("Airlock_Gator_Lookat", "Look At Trigger Enabled", false)
  Prefab_BogEasyAirlock_EntityHide(nil, "Hide")
  if (GetGlobal("NOS_BogEasy_FirstVisit") ~= 1) then
    local targetname = tostring(GetName(target))
    if (targetname == "nos_bogeasy_01a_main_sharedscripting.ExitCamera_ShantyShop_LouisShack.Trigger_EnterInterior") then
      local data = GetPrefabData("NOS_BogEasy_Jugband")
      if (data.CurrentState == "Fixed") then
        AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Stop_MX_BOG_Jugband_Good")
        MusicPostEventOn(GetPlayer(), "Play_MX_BOG")
        Print("Stopping jugband music from enter shanty shop")
      end
    end
  elseif (GetGlobal("NOS_BogEasy_FirstVisit") == 1) then
    if (GetGlobal("NOS_Tom_Panic_Played") == 0) then
      NOS_BogEasy_HandleHintNodes(nil, "ShantyShopExit")
    end
  end
  ReplaceMusicStateOverride("BOG_IntShantyShop")
  AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_Thinner_Swamp 01", "stop_bogeasy_thinner_river_01")
  Prefab_EnterInterior_FadeIn()
  return 
end
NOS_BogEasy_EnteredLouisShack = function(target)
  ReplaceMusicStateOverride("BOG_IntLouis")
  Prefab_EnterInterior_FadeIn()
  return 
end
NOS_BogEasy_EnteredShoppe = function(target)
  ReplaceMusicStateOverride("BOG_IntShoppe")
  AnimVarInt("NOS_BogEasy_Ghost_Gilbert_Shoppe", VAR_NPC_State, 4)
  wait(1)
  Prefab_EnterInterior_FadeIn()
  return 
end
NOS_BogEasy_ReturnVisit_EnterForge = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_EnterForge")
  SetGlobal("NOS_BogEasy_SparksLocation", 0)
  TeleportToEntity("NOS_BogEasy_GremlinSparks", "GremlinSparks_HouseMarker")
  ReplaceMusicStateOverride("BOG_IntForge")
  Prefab_EnterInterior_FadeIn()
  return 
end
NOS_BogEasy_Shoppe_MoveGilbert = function(target)
  Print("__Function: NOS_BogEasy_Shoppe_MoveGilbert")
  AnimEvent("NOS_BogEasy_Ghost_Gilbert_Shoppe", EVENT_Special_1)
  return 
end
NOS_BogEasy_EnteredFerryBoat = function(target)
  ReplaceMusicStateOverride("BOG_IntFerryBoat")
  Prefab_EnterInterior_FadeIn()
  return 
end
NOS_BogEasy_LouisRefill = function(target)
  Print("__Function: NOS_BogEasy_LouisRefill")
  SetAmmo("Paint", GetAmmoMax("Paint"))
  SetAmmo("Thinner", GetAmmoMax("Thinner"))
  SetPropertyInt(GetPlayer(), "Health", GetPropertyInt(GetPlayer(), "MaxHealth", 0), 0)
  return 
end
NOS_BogEasy_ExitBuilding = function(target, _WhichBuilding)
  Print(("NOS_BogEasy_Main Function: NOS_BogEasy_ExitBuilding, _WhichBuilding: " .. tostring(_WhichBuilding)))
  local FirstVisitIGC = 0
  if (_WhichBuilding == "LouisShack") then
    Prefab_ExitInterior_FadeIn()
  elseif (_WhichBuilding == "ShantyShop_LouisShack") then
    Prefab_BogEasyAirlock_SwitchState("BogEasy_Airlock", "LouisShack")
    WaitForLevelLoad()
    Print("__ExitBuilding: Exiting Shanty Shop @ Louis Shack Side!")
    NOS_BogEasy_StreamZone(nil, "LouisShack")
    if (GetGlobal("NOS_BogEasy_FirstVisit") == 1) then
      if (GetGlobal("NOS_Tom_Panic_Played") == 0) then
        Print("__ExitBuilding: Will fire IGC!")
        FirstVisitIGC = 1
        GetPrefabData("NOS_BogEasy_EnterInterior_ShantyShop_LouisShack").SkipExitFade = "True"
      end
    else
      Print("__ExitBuilding: Will not fire IGC!")
      GetPrefabData("NOS_BogEasy_EnterInterior_ShantyShop_LouisShack").SkipExitFade = "False"
    end
    AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_2D_Amb_Start", "Play_bogeasy_thinner_river_2D")
    Prefab_ExitInterior_FadeIn("OHAI", "NOS_BogEasy_EnterInterior_ShantyShop_LouisShack")
  elseif (_WhichBuilding == "ShantyShop_ShantyTown") then
    Print("__ExitBuilding: Exiting Shanty Shop @ ShantyTown Side!")
    Prefab_BogEasyAirlock_EntityHide(nil, "Hide")
    NOS_BogEasy_StreamZone(nil, "ShantyTown")
    Prefab_ExitInterior_FadeIn("OHAI", "NOS_BogEasy_EnterInterior_ShantyShop_ShantyTown")
    AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_Thinner_Swamp 01", "play_bogeasy_thinner_river_01")
  else
    Print("__ExitBuilding: Fading in!")
    Prefab_ExitInterior_FadeIn()
  end
  if (FirstVisitIGC == 1) then
    NOS_BogEasy_Visit1_TomIGC(target)
  end
  if (_WhichBuilding == "ShantyShop_LouisShack") then
    Prefab_FireworksManager_StreamZoneIn("FireworksManager", "A")
    if (GetGlobal("NOS_BogEasy_FirstVisit") ~= 1) then
      Prefab_BunniesForBunnyHat_PlaceBunniesInSection(nil, "LouisShack")
      GetPrefabData("TrainStationExplosion").FancyCamEndFireUser[1] = "AutoFire"
      FireUser2("TrainStationExplosion")
    end
    NOS_BogEasy_SaveCheckpoint("CHECKPOINT_ShantyShop_LouisShack")
  elseif (_WhichBuilding == "ShantyShop_ShantyTown") then
    SetGlobal("NOS_BogEasy_ShantyTown_CheckpointLocation", 1)
    if (GetGlobal("NOS_BogEasy_FirstVisit") ~= 1) then
      Prefab_BunniesForBunnyHat_PlaceBunniesInSection(nil, "ShantyTown")
      NOS_BogEasy_SaveCheckpoint("CHECKPOINT_ShantyShop_ShantyTown")
    elseif (GetGlobal("NOS_BogEasy_Spawner_ShantyTown_State") == 0) then
      NOS_BogEasy_SaveCheckpoint("CHECKPOINT_Projector_MeanStreet")
    else
      NOS_BogEasy_SaveCheckpoint("CHECKPOINT_ShantyShop_ShantyTown")
    end
  end
  Enable("nos_bogeasy_01a_louisshackarea_audio.Trig_Music_JugbandState")
  RemoveAllMusicStateOverride()
  return 
end
NOS_BogEasy_ForgeEmergencyGeneratorStreamed = function(target)
  Print("__Function: NOS_BogEasy_ForgeEmergencyGeneratorStreamed")
  local ForgeStatus = GetGlobal("NOS_BogEasy_ForgeFixed")
  if (ForgeStatus < 0) then
    SplineFollower_TeleportToKnot("Forge_EmergencyGeneratorPlatform", "Forge_EmergencyGenerator_Knot1")
  elseif (0 <= ForgeStatus) then
    SplineFollower_TeleportToKnot("Forge_EmergencyGeneratorPlatform", "Forge_EmergencyGenerator_Knot2")
  end
  return 
end
NOS_BogEasy_Visit1_TomIGC = function(target)
  Print("__Function: NOS_BogEasy_Visit1_TomIGC")
  GrabCamera("TomIGC 00", nil, CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
  wait(0.800000011920929)
  StartFadeIn(0.800000011920929)
  ForceSequence("NOS_BogEasy_Pedestrian_TrainConductorTom_V1", "NOS_Tom_Panic")
  wait(0.10000000149011612)
  UnpauseAllAI()
  return 
end
NOS_BogEasy_Visit1_TomIGCCleanup = function(target)
  Print("__Function: NOS_BogEasy_Visit1_TomIGCCleanup")
  StartFadeOut(0.800000011920929)
  wait(0.800000011920929)
  if (GetGlobal("NOS_BogEasy_FirstVisitProgress") == 1) then
    Print("__Will play train station explosion!")
    FireUser2("TrainStationExplosion")
  end
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetPlayer2OrAI())
  ClearAllCameraAttributes()
  EnableSplitScreen(true)
  if (GetGlobal("NOS_BogEasy_FirstVisitProgress") == 1) then
    SetGlobal("NOS_BogEasy_FirstVisitProgress", 2)
    wait((tonumber(GetPrefabData(GetPrefabData("TrainStationExplosion").FancyCamEntity).transitionTime) + 0.800000011920929))
    FireUser3("TrainStationExplosion")
  end
  UnrestrictCutSceneInput()
  StartFadeIn(0.800000011920929)
  UnrestrictCutSceneInput()
  RemoveAllMusicStateOverride()
  NOS_BogEasy_SaveCheckpoint("CHECKPOINT_ShantyShop_LouisShack")
  return 
end
NOS_BogEasy_StreamZone = function(target, _Zone)
  Print(("__Function: NOS_BogEasy_StreamZone, _Zone: " .. tostring(_Zone)))
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 1) then
    Print("__FIRST VISIT!")
    if (_Zone == "ShantyTown") then
      LevelManager_SetCurrentState("nos_bogeasy.shantytown_v1")
    elseif (_Zone == "LouisShack") then
      LevelManager_SetCurrentState("nos_bogeasy.louisshack_v1")
      if (_Zone == "ShantyTown") then
        LevelManager_SetCurrentState("nos_bogeasy.shantytown_v2")
      elseif (_Zone == "LouisShack") then
        LevelManager_SetCurrentState("nos_bogeasy.louisshack_v2")
      end
    end
  elseif (_Zone == "ShantyTown") then
    LevelManager_SetCurrentState("nos_bogeasy.shantytown_v2")
  elseif (_Zone == "LouisShack") then
    LevelManager_SetCurrentState("nos_bogeasy.louisshack_v2")
  end
  return 
end
NOS_BogEasy_DonaldEmulate = function(target)
  Print("__Function: NOS_BogEasy_DonaldEmulate")
  LevelManager_SetCurrentState("nos_bogeasy.oldtown_v2")
  WaitForLevelLoad()
  TeleportToEntity(GetPlayer(), "MickeyRespawnMarker_OldTown")
  Prefab_BogEasyAirlock_SwitchState("BogEasy_Airlock", "OldTown")
  AudioPostEventOn("nos_bogeasy_01a_whirlpool_audio.Snd_Whirlpool", "Play_sfx_Steamboat_Whirlpool_Lp")
  AudioPostEventOn("nos_bogeasy_01a_whirlpool_audio.Snd_Whirlpool", "Play_sfx_Steamboat_Engine_Lp")
  AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_Thinner_Swamp 01", "stop_bogeasy_thinner_river_01")
  AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_2D_Amb_Start", "Play_sfx_amb_bogeasy_edge")
  return 
end
NOS_BogEasy_DoorLocked = function(target)
  Print("__Function: NOS_BogEasy_DoorLocked")
  ForceSequence("NOS_BogEasy_Gus", "NOS_Gus_DoorLocked")
  DestroyEntity(target)
  return 
end
InDoorTrigger = {0, 0, 0, 0, 0, 0}
NOS_BogEasy_OpenDoorTriggerEntered = function(target, _WhichDoor)
  if (_WhichDoor == "LouisShack") then
    if (InDoorTrigger[1] == 0) then
      InDoorTrigger[1] = 1
    else
      return 
      if (InDoorTrigger[2] == 0) then
        InDoorTrigger[2] = 1
      else
        return 
        if (InDoorTrigger[3] == 0) then
          InDoorTrigger[3] = 1
        else
          return 
          if (InDoorTrigger[4] == 0) then
            InDoorTrigger[4] = 1
          else
            return 
            if (InDoorTrigger[5] == 0) then
              InDoorTrigger[5] = 1
            else
              return 
              if (InDoorTrigger[6] == 0) then
                InDoorTrigger[6] = 1
              else
                return 
              end
            end
          end
        end
      end
    end
  elseif (_WhichDoor == "BookStore") then
    if (InDoorTrigger[2] == 0) then
      InDoorTrigger[2] = 1
    else
      return 
      if (InDoorTrigger[3] == 0) then
        InDoorTrigger[3] = 1
      else
        return 
        if (InDoorTrigger[4] == 0) then
          InDoorTrigger[4] = 1
        else
          return 
          if (InDoorTrigger[5] == 0) then
            InDoorTrigger[5] = 1
          else
            return 
            if (InDoorTrigger[6] == 0) then
              InDoorTrigger[6] = 1
            else
              return 
            end
          end
        end
      end
    end
  elseif (_WhichDoor == "ShantyShop") then
    if (InDoorTrigger[3] == 0) then
      InDoorTrigger[3] = 1
    else
      return 
      if (InDoorTrigger[4] == 0) then
        InDoorTrigger[4] = 1
      else
        return 
        if (InDoorTrigger[5] == 0) then
          InDoorTrigger[5] = 1
        else
          return 
          if (InDoorTrigger[6] == 0) then
            InDoorTrigger[6] = 1
          else
            return 
          end
        end
      end
    end
  elseif (_WhichDoor == "ShantyShop_LouisShack") then
    if (InDoorTrigger[4] == 0) then
      InDoorTrigger[4] = 1
    else
      return 
      if (InDoorTrigger[5] == 0) then
        InDoorTrigger[5] = 1
      else
        return 
        if (InDoorTrigger[6] == 0) then
          InDoorTrigger[6] = 1
        else
          return 
        end
      end
    end
  elseif (_WhichDoor == "Forge") then
    if (InDoorTrigger[5] == 0) then
      InDoorTrigger[5] = 1
    else
      return 
      if (InDoorTrigger[6] == 0) then
        InDoorTrigger[6] = 1
      else
        return 
      end
    end
  elseif (_WhichDoor == "MagicShop") then
    if (InDoorTrigger[6] == 0) then
      InDoorTrigger[6] = 1
    else
      return 
    end
  end
  Print("___Function: NOS_BogEasy_OpenDoorTriggerEntered")
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 1) then
    if (_WhichDoor == "ShantyShop") then
      if (GetGlobal("NOS_BogEasy_Spawner_ShantyTown_State") == 0) then
        ForceSequence("NOS_BogEasy_Pedestrian_Metairie", "NOS_Metairie_Panic")
        return 
      end
    elseif (_WhichDoor ~= "LouisShack") then
      if (_WhichDoor ~= "ShantyShop_LouisShack") then
        return 
      end
    end
  end
  if (_WhichDoor == "LouisShack") then
    AnimGBSequence("NOS_BogEasy_LouisShackDoor", "open")
    SetPropertyFloat("NOS_BogEasy_EnterInterior_LouisShack", "UsableRadius", 3)
    GetPrefabData("NOS_BogEasy_EnterInterior_LouisShack").StartsInactive = "False"
  elseif (_WhichDoor == "BookStore") then
    AnimGBSequence("NOS_BogEasy_ShoppeDoor", "open")
    SetPropertyFloat("NOS_BogEasy_EnterInterior_Shoppe", "UsableRadius", 3)
    GetPrefabData("NOS_BogEasy_EnterInterior_Shoppe").StartsInactive = "False"
  elseif (_WhichDoor == "ShantyShop") then
    AnimGBSequence("NOS_BogEasy_ShantyShopDoor", "open")
    SetPropertyFloat("NOS_BogEasy_EnterInterior_ShantyShop_ShantyTown", "UsableRadius", 3)
    GetPrefabData("NOS_BogEasy_EnterInterior_ShantyShop_ShantyTown").StartsInactive = "False"
  elseif (_WhichDoor == "ShantyShop_LouisShack") then
    AnimGBSequence("ShantyShop_LouisShack_Doors", "open")
    SetPropertyFloat("NOS_BogEasy_EnterInterior_ShantyShop_LouisShack", "UsableRadius", 3)
    GetPrefabData("NOS_BogEasy_EnterInterior_ShantyShop_LouisShack").StartsInactive = "False"
  elseif (_WhichDoor == "Forge") then
    if (GetGlobal("NOS_Sparks_OnCageBroken_Played") == 0) then
      ForceSequence("NOS_BogEasy_Gus", "NOS_Gus_DoorLocked")
    else
      AnimGBSequence("NOS_BogEasy_ForgeDoor1", "open")
      SetPropertyFloat("NOS_BogEasy_EnterInterior_Forge", "UsableRadius", 3)
      GetPrefabData("NOS_BogEasy_EnterInterior_Forge").StartsInactive = "False"
      if (_WhichDoor == "MagicShop") then
        if (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress") == 2) then
          AnimGBSequence("NOS_BogEasy_MagicShopDoor", "open")
          SetPropertyFloat("NOS_BogEasy_EnterInterior_MagicShop", "UsableRadius", 3)
          GetPrefabData("NOS_BogEasy_EnterInterior_MagicShop").StartsInactive = "False"
        end
      end
    end
  elseif (_WhichDoor == "MagicShop") then
    if (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress") == 2) then
      AnimGBSequence("NOS_BogEasy_MagicShopDoor", "open")
      SetPropertyFloat("NOS_BogEasy_EnterInterior_MagicShop", "UsableRadius", 3)
      GetPrefabData("NOS_BogEasy_EnterInterior_MagicShop").StartsInactive = "False"
    end
  end
  return 
end
NOS_BogEasy_WhirlpoolDoor = function(target, _State)
  Print(("__Function: NOS_BogEasy_WhirlpoolDoor, _State: " .. tostring(_State)))
  if (_State == "Painted") then
    SetPropertyFloat("NOS_BogEasy_EnterInterior_FerryBoat", "UsableRadius", 0)
    GetPrefabData("NOS_BogEasy_EnterInterior_FerryBoat").StartsInactive = "True"
  elseif (_State == "Thinned") then
    SetPropertyFloat("NOS_BogEasy_EnterInterior_FerryBoat", "UsableRadius", 3)
    GetPrefabData("NOS_BogEasy_EnterInterior_FerryBoat").StartsInactive = "False"
  end
  return 
end
NOS_BogEasy_OpenDoorTriggerExited = function(target, _WhichDoor)
  Print("___Function: NOS_BogEasy_OpenDoorTriggerExited")
  if (_WhichDoor == "LouisShack") then
    InDoorTrigger[1] = 0
  elseif (_WhichDoor == "BookStore") then
    InDoorTrigger[2] = 0
  elseif (_WhichDoor == "ShantyShop") then
    InDoorTrigger[3] = 0
  elseif (_WhichDoor == "ShantyShop_LouisShack") then
    InDoorTrigger[4] = 0
  elseif (_WhichDoor == "Forge") then
    InDoorTrigger[5] = 0
  elseif (_WhichDoor == "MagicShop") then
    InDoorTrigger[6] = 0
  end
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 1) then
    if (_WhichDoor ~= "LouisShack") then
      if (_WhichDoor ~= "ShantyShop") then
        if (_WhichDoor ~= "ShantyShop_LouisShack") then
          return 
        end
      end
    end
  end
  if (_WhichDoor == "LouisShack") then
    AnimGBSequence("NOS_BogEasy_LouisShackDoor", "close")
    SetPropertyFloat("NOS_BogEasy_EnterInterior_LouisShack", "UsableRadius", 0)
    GetPrefabData("NOS_BogEasy_EnterInterior_LouisShack").StartsInactive = "True"
  elseif (_WhichDoor == "BookStore") then
    AnimGBSequence("NOS_BogEasy_ShoppeDoor", "close")
    SetPropertyFloat("NOS_BogEasy_EnterInterior_Shoppe", "UsableRadius", 0)
    GetPrefabData("NOS_BogEasy_EnterInterior_Shoppe").StartsInactive = "True"
  elseif (_WhichDoor == "ShantyShop") then
    AnimGBSequence("NOS_BogEasy_ShantyShopDoor", "close")
    SetPropertyFloat("NOS_BogEasy_EnterInterior_ShantyShop_ShantyTown", "UsableRadius", 0)
    GetPrefabData("NOS_BogEasy_EnterInterior_ShantyShop_ShantyTown").StartsInactive = "True"
  elseif (_WhichDoor == "ShantyShop_LouisShack") then
    AnimGBSequence("ShantyShop_LouisShack_Doors", "close")
    SetPropertyFloat("NOS_BogEasy_EnterInterior_ShantyShop_LouisShack", "UsableRadius", 0)
    GetPrefabData("NOS_BogEasy_EnterInterior_ShantyShop_LouisShack").StartsInactive = "True"
  elseif (_WhichDoor == "Forge") then
    AnimGBSequence("NOS_BogEasy_ForgeDoor1", "close")
    SetPropertyFloat("NOS_BogEasy_EnterInterior_Forge", "UsableRadius", 0)
    GetPrefabData("NOS_BogEasy_EnterInterior_Forge").StartsInactive = "True"
  elseif (_WhichDoor == "MagicShop") then
    AnimGBSequence("NOS_BogEasy_MagicShopDoor", "close")
    SetPropertyFloat("NOS_BogEasy_EnterInterior_MagicShop", "UsableRadius", 0)
    GetPrefabData("NOS_BogEasy_EnterInterior_MagicShop").StartsInactive = "True"
  end
  return 
end
NOS_BogEasy_ToonStateChanged = function(target, _Type, _State, _GlobalSection, _GlobalNumber, _GlobalChunk)
  Print(((((((((("__ToonStateChanged: Function: NOS_BogEasy_ToonStateChanged, _Type: " .. tostring(_Type)) .. ", _State: ") .. tostring(_State)) .. ", _GlobalSection: ") .. tostring(_GlobalSection)) .. ", GlobalNumber: ") .. tostring(_GlobalNumber)) .. ", _GlobalChunk: ") .. tostring(_GlobalChunk)))
  Print(("__ToonStateChanged: ToonPiece: " .. tostring(GetName(target))))
  local ConvertGlobalToTable = function(Global)
    local Value = tostring(GetGlobal(Global))
    Print(((("__Global: " .. tostring(Global)) .. " Value: ") .. tostring(Value)))
    local TableToReturn = {-1, -1, -1, -1}
    local (for index), (for limit), (for step) = 2, 5, 1
    for x = (for index), (for limit), (for step) do
      TableToReturn[(x - 1)] = tonumber(string.sub(Value, x, x))
    end
    return TableToReturn
  end
  local ConvertTableToGlobalValue = function(Table)
    local StringToReturn = "1"
    local (for index), (for limit), (for step) = 1, 4, 1
    for x = (for index), (for limit), (for step) do
      StringToReturn = (StringToReturn .. tostring(Table[x]))
    end
    Print(("__Will return string value: " .. tostring(StringToReturn)))
    return tonumber(StringToReturn)
  end
  local DoGlobalChange = false
  local ChangeTo = -1
  if (_Type == "Jigsaw") then
    local PreviousPercentage, Percentage = Jigsaw_GetPercentagePainted(target)
    if (Percentage < 1) then
      if (PreviousPercentage == 1) then
        DoGlobalChange = true
        ChangeTo = 0
      end
    elseif (Percentage == 1) then
      if (PreviousPercentage < 1) then
        DoGlobalChange = true
        ChangeTo = 1
        if (_Type == "Oneshot") then
          DoGlobalChange = true
          if (_State == "Painted") then
            ChangeTo = 1
          elseif (_State == "Thinned") then
            ChangeTo = 0
          end
        end
      end
    end
  elseif (_Type == "Oneshot") then
    DoGlobalChange = true
    if (_State == "Painted") then
      ChangeTo = 1
    elseif (_State == "Thinned") then
      ChangeTo = 0
    end
  end
  if (DoGlobalChange == true) then
    local GlobalToUse, GlobalToUse = ((("NOS_BogEasy_ToonState_" .. tostring(_GlobalSection)) .. "_") .. tostring(_GlobalNumber)), "_"
    GlobalToUse = "__Will change value of global: "
    GlobalToUse = (((((GlobalToUse .. tostring(GlobalToUse)) .. " Chunk: ") .. tostring(_GlobalChunk)) .. " to: ") .. tostring(ChangeTo))
    Print(GlobalToUse)
    GlobalToUse = GlobalToUse
    local Table, Table = ConvertGlobalToTable(GlobalToUse), tostring(GlobalToUse)
    GlobalToUse = Print
    Table = "__Old Table Values: [1]: "
    Table = (((((((Table .. tostring(Table[1])) .. ", [2]: ") .. tostring(Table[2])) .. ", [3]: ") .. tostring(Table[3])) .. ", [4]: ") .. tostring(Table[4]))
    GlobalToUse(Table)
    GlobalToUse = tonumber
    Table = _GlobalChunk
    GlobalToUse = GlobalToUse(Table)
    Table[GlobalToUse] = ChangeTo
    GlobalToUse = Print
    Table = "__New Table Values: [1]: "
    Table = (((((((Table .. tostring(Table[1])) .. ", [2]: ") .. tostring(Table[2])) .. ", [3]: ") .. tostring(Table[3])) .. ", [4]: ") .. tostring(Table[4]))
    GlobalToUse(Table)
    GlobalToUse = SetGlobal
    Table = GlobalToUse
    GlobalToUse(Table, ConvertTableToGlobalValue(Table))
  end
  if (GetGlobal("NOS_BogEasy_ToonState_LouisShack_1") == 11111) then
    if (GetGlobal("NOS_BogEasy_ToonState_LouisShack_2") == 11111) then
      if (GetGlobal("NOS_BogEasy_ToonState_LouisShack_3") == 11111) then
        if (GetGlobal("NOS_BogEasy_ToonState_OldTown_1") == 11111) then
          if (GetGlobal("NOS_BogEasy_ToonState_OldTown_2") == 11111) then
            if (GetGlobal("NOS_BogEasy_ToonState_OldTown_3") == 11111) then
              if (GetGlobal("NOS_BogEasy_ToonState_OldTown_4") == 11111) then
                if (GetGlobal("NOS_BogEasy_ToonState_OldTown_5") == 11111) then
                  if (GetGlobal("NOS_BogEasy_ToonState_ShantyTown_1") == 11111) then
                    if (GetGlobal("NOS_BogEasy_ToonState_ShantyTown_2") == 11111) then
                      if (GetGlobal("NOS_BogEasy_ToonState_ShantyTown_3") == 11111) then
                        if (GetGlobal("NOS_BogEasy_ToonState_ShantyTown_4") == 11111) then
                          if (GetGlobal("NOS_Rolly_OutOfToon_SecondGoal_Played") == 1) then
                            if Quest_CheckStatus("Out_Of_Toon", "Out_Of_Toon_2a", Quest_Discovered) then
                              Quest_SetStatus("Out_Of_Toon", "Out_Of_Toon_2a", Quest_TurnIn, true)
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return 
end
NOS_BogEasy_Shop = function(_ItemBought)
  Print(("__Function: NOS_BogEasy_Shop, _ItemBought: " .. tostring(_ItemBought)))
  if (_ItemBought == "RougeConcept1") then
    GiveCollectible("ConceptArt_01_EXP_1")
  elseif (_ItemBought == "RougeConcept2") then
    GiveCollectible("ConceptArt_02_EXP_2")
  elseif (_ItemBought == "RougeConcept3") then
    GiveCollectible("ConceptArt_03_EXP_3")
  elseif (_ItemBought == "RougeConcept4") then
    GiveCollectible("ConceptArt_04_EXP_4")
  elseif (_ItemBought == "RougeConcept5") then
    GiveCollectible("ConceptArt_05_Inky")
  elseif (_ItemBought == "RougeConcept6") then
    GiveCollectible("ConceptArt_06_Mickey_Oswald")
  elseif (_ItemBought == "RougeConcept7") then
    GiveCollectible("ConceptArt_07_Oswald")
  elseif (_ItemBought == "RougeConcept8") then
    GiveCollectible("ConceptArt_08_Bunny_Children")
  elseif (_ItemBought == "RougeConcept9") then
    GiveCollectible("ConceptArt_09_Croc")
  elseif (_ItemBought ~= "CaptainHookPin") then
    if (_ItemBought == "TV_Sketch") then
      SetGlobal("NOS_BogEasy_TrainQuest_BoughtTVSketch", 1)
      if (GetGlobal("NOS_Gus_SketchTraining_Played") == 0) then
        SetGlobal("NOS_BogEasy_ShantyShopExit", 1)
      end
    end
  end
  return 
end
NOS_BogEasy_ShopExited = function(target)
  Print("__Function: NOS_BogEasy_ShopExited")
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  if (GetGlobal("NOS_BogEasy_ShantyShopExit") == 1) then
    RestrictCutSceneInput()
    FireSequence("NOS_BogEasy_Gus", "NOS_Gus_SketchTraining", 1)
  end
  return 
end
NOS_BogEasy_PlayTVMovie = function(target)
  Print("__Function: NOS_BogEasy_PlayMovie")
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  StartFadeOut(0.800000011920929)
  wait(0.800000011920929)
  PlayMovie(GetPlayer(), "PH_Training_TV.bik")
  GiveCollectibleNoPopup("Film_PH_TV")
  UnrestrictCutSceneInput()
  StartFadeIn(0.800000011920929)
  return 
end
NOS_BogEasy_TrainStation_AIOswaldPowerSwitch = function(target)
  Print("__Function: NOS_BogEasy_TrainStation_AIOswaldPowerSwitch")
  OswaldStreamAction("TrainStationQuest_OswaldShock")
  return 
end
InTransition = 0
NOS_BogEasy_AirlockGator = function(target)
  Print("__Function: NOS_BogEasy_AirlockGator")
  if (InTransition == 0) then
    InTransition = 1
    local Position = GetPosition(GetPlayer())
    Print((((((("__Position of Player on Hit: [" .. tostring(Position.x)) .. ", ") .. tostring(Position.y)) .. ", ") .. tostring(Position.z)) .. "]"))
    SetPositionFloat("Airlock_GatorSplineKnot2", Position.x, -3.5, Position.z)
    SetPositionFloat("Airlock_GatorSplineKnot1", Position.x, -6, Position.z)
    local Knot1 = GetPosition("Airlock_GatorSplineKnot1")
    local Knot2 = GetPosition("Airlock_GatorSplineKnot2")
    Print((((((("__Position of Knot 1: [" .. tostring(Knot1.x)) .. ", ") .. tostring(Knot1.y)) .. ", ") .. tostring(Knot1.z)) .. "]"))
    Print((((((("__Position of Knot 2: [" .. tostring(Knot2.x)) .. ", ") .. tostring(Knot2.y)) .. ", ") .. tostring(Knot2.z)) .. "]"))
    SplineFollower_TeleportToKnot("Airlock_Gator", "Airlock_GatorSplineKnot1")
    local MickeyFacing = GetFacing(GetPlayer())
    Print((((((("__Mickey Facing: [" .. tostring(MickeyFacing.x)) .. ", ") .. tostring(MickeyFacing.y)) .. ", ") .. tostring(MickeyFacing.z)) .. "]"))
    local GatorFacing = GetFacing("Airlock_Gator")
    Print((((((("__Gator Old Facing: [" .. tostring(GatorFacing.x)) .. ", ") .. tostring(GatorFacing.y)) .. ", ") .. tostring(GatorFacing.z)) .. "]"))
    GatorFacing.x = (-MickeyFacing.x)
    GatorFacing.z = (-MickeyFacing.z)
    Print((((((("__Gator New Facing: [" .. tostring(GatorFacing.x)) .. ", ") .. tostring(GatorFacing.y)) .. ", ") .. tostring(GatorFacing.z)) .. "]"))
    SetFacing("Airlock_Gator", GatorFacing)
    wait(0.20000000298023224)
    SplineFollower_SetDisabled("Airlock_Gator", false)
    SplineFollower_StopAtPosition("Airlock_Gator", "Airlock_GatorSplineKnot1", "Airlock_GatorSplineKnot2", 1)
    wait(3)
    SplineFollower_StopAtPosition("Airlock_Gator", "Airlock_GatorSplineKnot1", "Airlock_GatorSplineKnot2", 0)
    wait(2)
    SplineFollower_SetDisabled("Airlock_Gator", true)
    InTransition = 0
  end
  return 
end
local GatorTickets = {0, 0, 0, 0, 0, 0}
NOS_BogEasy_WhirlpoolGatorTrigger = function(target, _Entered)
  local Gator = _activator()
  local GatorID = GetName(Gator)
  local GatorNum = string.sub(GatorID, -2, -1)
  if (_Entered == "Enter") then
    AnimGBSequence(Gator, "lower")
    wait(1)
    if (GatorTickets[tonumber(GatorNum)] ~= 0) then
      DestroyEntity(("TicketOnGator" .. tostring(GatorNum)))
      GatorTickets[tonumber(GatorNum)] = 0
    end
    local ChanceToSpawn = math.random(0, 10)
    if (5 < ChanceToSpawn) then
      GatorTickets[tonumber(GatorNum)] = 1
      local Rand = math.random(0, 2)
      SetPropertyInt("GatorTicketSpawner", "Index To Spawn", Rand)
      local GroupName = ("TicketOnGator" .. tostring(GatorNum))
      SetPropertyString("GatorTicketSpawner", "Spawn Group", GroupName)
      local Spawned = ForceSpawn("GatorTicketSpawner", 1)
      SetParentEntity(Spawned[1], Gator)
      SetPropertyString(Spawned[1], "Bone Attach Name", "ticketBone", 0)
    end
  elseif (_Entered == "Exit") then
    AnimGBSequence(Gator, "rise")
  end
  return 
end
NOS_BogEasy_OswaldDistanceWhirlpoolOverride = function(target, _Direction)
  Print(("__Function: NOS_BogEasy_OswaldDistanceWhirlpoolOverride, _Direction: " .. tostring(_Direction)))
  if (GetName(_activator()) == GetName(GetPlayer())) then
    if (_Direction == "In") then
      OswaldOverrideTeleportDistance(nil, 100)
    elseif (_Direction == "Out") then
      OswaldClearOverrideTeleportDistance()
    end
  end
  return 
end
NOS_BogEasy_OswaldGator = function(target, _Entered)
  if (_Entered == "Enter") then
    Enable("OswaldGotoBoat")
  else
    wait(2.5)
    Disable("OswaldGotoBoat")
  end
  return 
end
NOS_BogEasy_TicketPickedUp = function(target)
  local ParentEntity = GetPropertyEntity(target, "Parent Entity")
  if IsValidHande(ParentEntity) then
    local GroupName = tonumber(string.sub(GetPropertyString(GetName(ParentEntity), "EntityGroups", 0), -2, -1))
    GatorTickets[GroupName] = 0
  end
  return 
end
NOS_BogEasy_OswaldShockFirework = function(_Which)
  Print(("__Function: NOS_BogEasy_OswaldShockFirework, _Which: " .. tostring(_Which)))
  if (_Which == "OldTownWall") then
    OswaldStreamAction(LastOldTownWallFirework)
  elseif (_Which == "GraveyardWall") then
    OswaldStreamAction(LastGraveyardWallFirework)
  end
  return 
end
NOS_BogEasy_ReturnVisit_ThinnerCryptDoorStimmed = function(target, _event, _Which)
  Print(("__Function: NOS_BogEasy_ReturnVisit_ThinnerCryptDoorStimmed, _Which: " .. tostring(_Which)))
  if StimulusEvent_HasStimulusType(_event, ST_CROSSED_STREAM) then
    if (_Which == "OldTownWall") then
      StartEmitters("BreakableFacadeDust")
      AnimGBSequence(target, "explode")
      FireUser1("OldTownFakeWall_FireworksTrigger")
      DestroyEntity("FireworksSign_SecretWall")
      wait(3.200000047683716)
      StopEmitters("BreakableFacadeDust")
    elseif (_Which == "CryptWall") then
      AnimGBSequence(target, "break")
      FireUser1("CryptWall_FireworksTrigger")
      DestroyEntity("FireworksSign_Crypt")
    end
    wait(2)
    DestroyEntity(target)
  end
  return 
end
NOS_BogEasy_TrainConductorStreamed = function(target)
  Print("__Function: NOS_BogEasy_TrainConductorStreamed")
  QueueBrainEvent("NOS_BogEasy_Pedestrian_TrainConductorTom_V2", BRAIN_StopWander)
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 0) then
    Print("__Return Visit!")
    if (GetGlobal("NOS_Tom_TrainQuest_Lure_Played") == 1) then
      if (GetGlobal("NOS_Tom_TrainQuest_Completed_Played") == 0) then
        if (GetGlobal("NOS_BogEasy_TrainRestored") == 0) then
          if (GetGlobal("NOS_BogEasy_TrainDestroyed") == 0) then
            Enable("TrainStationQuest_TVActivationTrigger")
            Enable("TrainStationQuest_QuestCompleteTrigger")
          end
        end
      end
    end
    local TrainFixed = GetGlobal("NOS_BogEasy_TrainRestored")
    local TrainDestroyed = GetGlobal("NOS_BogEasy_TrainDestroyed")
    if (TrainFixed == 1) then
      if (TrainFixed == 1) then
        SetGlobal("NOS_BogEasy_TrainQuest_CanBuyTicket", 1)
        TeleportToEntity("NOS_BogEasy_Pedestrian_TrainConductorTom_V2", "NOS_BogEasy_TrainQuest_QuestCompletedTeleportMarker")
        SetPropertyBool("NOS_BogEasy_Pedestrian_TrainConductorTom_V2", "ShouldFacePlayer", false)
        AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_TrainStation", "Play_sfx_BE_TrainStation_Fixed")
      end
      if (TrainDestroyed == 1) then
        SetGlobal("NOS_BogEasy_TrainQuest_CanBuyTicket", 0)
        AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_TrainStation", "Play_sfx_BE_TrainStation_Destroyed")
        DestroyEntity("NOS_BogEasy_Pedestrian_TrainConductorTom_V2")
        if (GetGlobal("NOS_BogEasy_TrainDestroyed") == 1) then
          AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_TrainStation", "Play_sfx_BE_TrainStation_Destroyed")
        end
      end
    end
  elseif (GetGlobal("NOS_BogEasy_TrainDestroyed") == 1) then
    AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_TrainStation", "Play_sfx_BE_TrainStation_Destroyed")
  end
  return 
end
NOS_BogEasy_TrainStationDoorBlasted = function(target)
  Print("__Function: NOS_BogEasy_TrainStationDoorBlasted")
  SetGlobal("NOS_BogEasy_TrainDestroyed", 1)
  SetGlobal("NOS_BogEasy_TrainRestored", 0)
  Disable("TrainStationQuest_TVActivationTrigger")
  Disable("TrainStationQuest_QuestCompleteTrigger")
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 0) then
    FireSequence("NOS_BogEasy_Pedestrian_TrainConductorTom_V2", "NOS_Tom_DamageStation")
  end
  return 
end
local GatorsEmitting = {0, 0}
local BoatEmitting = 0
NOS_BogEasy_ShantyGatorsJumpedOn = function(target, _Which)
  Print(("__Function: NOS_BogEasy_ShantyGatorsJumpedOn, _Which: " .. tostring(_Which)))
  if (GatorsEmitting[tonumber(_Which)] == 0) then
    GatorsEmitting[tonumber(_Which)] = 1
    StartEmitters(("ShantyRippleGator" .. tostring(_Which)))
    wait(2)
    StopEmitters(("ShantyRippleGator" .. tostring(_Which)))
    GatorsEmitting[tonumber(_Which)] = 0
  end
  return 
end
NOS_BogEasy_LouisShackBoatJumped = function(target)
  Print("__Function: NOS_BogEasy_LouisShackBoatJumped")
  if (BoatEmitting == 0) then
    BoatEmitting = 1
    StartEmitters("LouisShackBoatRippleFX")
    wait(4)
    BoatEmitting = 0
  end
  return 
end
NOS_BogEasy_HandleHintNodes = function(target, _Stage)
  Print(("__Function: NOS_BogEasy_HandleHintNodes, _Stage: " .. tostring(_Stage)))
  ActivateGremlinHint(("GusHintMarker_" .. tostring(_Stage)))
  return 
end
NOS_BogEasy_PickMetairiePhoto = function(target)
  Print("__Function: NOS_BogEasy_PickMetairiePhoto")
  if (GetGlobal("NOS_BogEasy_PictureQuest_AutotopiaPictureGot") == 2) then
    Print("__Autotopia picture was the best one taken!")
    SetGlobal("NOS_BogEasy_PictureQuest_AutotopiaPictureGot", 3)
    return 
  end
  if (GetGlobal("NOS_BogEasy_PictureQuest_FloatGraveyardPictureGot") == 2) then
    Print("__FG picture was the best one taken!")
    SetGlobal("NOS_BogEasy_PictureQuest_FloatGraveyardPictureGot", 3)
    return 
  end
  if (GetGlobal("NOS_BogEasy_PictureQuest_GulchPictureGot") == 2) then
    Print("__Gulch picture was the best one taken!")
    SetGlobal("NOS_BogEasy_PictureQuest_GulchPictureGot", 3)
    return 
  end
  return 
end
NOS_BogEasy_GilbertConversation_ResetGiveConversationGlobal = function(target)
  Print("__Function: NOS_BogEasy_GilbertConversation_ResetGiveConversationGlobal")
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  SetGlobal("NOS_Gilbert_DonaldQuest_GiveShoddyGear_Played", 0)
  return 
end
NOS_BogEasy_SaveClothGot = function(target)
  Print("__Function: NOS_BogEasy_ClothGot")
  NOS_BogEasy_SaveCheckpoint("CHECKPOINT_ShantyShop_LouisShack")
  return 
end
NOS_BogEasy_GiveBuildingDeed = function(target)
  Print("__Function: NOS_BogEasy_GiveBuildingDeed")
  SetGlobal("NOS_QuestHealth", (GetGlobal("NOS_QuestHealth") + 10))
  SetGlobal("NOS_BogEasy_SparksDeedGiven", 1)
  GiveCollectible("House_Deed")
  return 
end
NOS_BogEasy_GoldPinGot = function(target)
  Print("__Function: NOS_BogEasy_GoldPinGot")
  NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
  return 
end
NOS_BogEasy_AllPhoneBoxesPainted = function(target)
  Print(("__Function: NOS_BogEasy_AllPhoneBoxesPainted, target: " .. tostring(target)))
  if (target == 1) then
    NOS_BogEasy_SaveCheckpoint("CHECKPOINT_LouisShack_Airlock")
  elseif (target == 2) then
    NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
  elseif (target == 3) then
    NOS_BogEasy_SaveCheckpoint("CHECKPOINT_Projector_MeanStreet")
  else
    Print("__What got passed into target here?")
  end
  return 
end
NOS_BogEasy_OldTownSpawnerLightFX_Streamed = function(target)
  Print("__Function: NOS_BogEasy_OldTownSpawnerLightFX_Streamed")
  if (GetGlobal("NOS_BogEasy_Spawner_OldTown_State") == 1) then
    StartEmitters("OldTownBwxLightSparks")
  end
  return 
end
NOS_BogEasy_FireworksKilledInThinner = function(target)
  Print("__Function: NOS_BogEasy_FireworksKilledInThinner")
  local ActivatorName = GetName(_activator())
  if (ActivatorName == "nos_bogeasy_01a_main_sharedscripting.LouisShackFireworks_1") then
    DestroyEntity(_activator())
  end
  local data = GetPrefabData("FireworksSpawner_BogEasy")
  DestroyEntity(_activator())
  Print(((("Mickey is in the trigger : " .. data.MickeyInTrigger) .. "Oswald is in the trigger ") .. data.OswaldInTrigger))
  wait(3)
  while true do
    if (data.MickeyInTrigger == "True") then
      wait(0.10000000149011612)
    end
  end
  AudioPostEventOn(GetRelativePrefabEntity("FireworksSpawner_BogEasy", ".Doors"), "Play_sfx_gbl_fireworks_door_close")
  AnimGBSequence(GetRelativePrefabEntity("FireworksSpawner_BogEasy", ".Doors"), "close", true)
  data.DispenserActive = "True"
  SetPropertyFloat(GetRelativePrefabEntity("FireworksSpawner_BogEasy", ".HandleToGrab"), "UsableRadius", 3)
  return 
end
NOS_BogEasy_MagicShopNavmeshToggle = function(target)
  Print("__Function: NOS_BogEasy_MagicShopNavmeshToggle")
  local DisableNavmesh = false
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 0) then
    if (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress") ~= 2) then
      DisableNavmesh = true
    end
  else
    DisableNavmesh = true
  end
  if (DisableNavmesh == true) then
    SetUserEdgeDisabled("Environments/_Design/BogEasy/NOS_BogEasy_01a_OldTownArea_Shared.gsa", "MagicShopJump", true)
  else
    SetUserEdgeDisabled("Environments/_Design/BogEasy/NOS_BogEasy_01a_OldTownArea_Shared.gsa", "MagicShopJump", false)
    Disable(target)
  end
  return 
end
