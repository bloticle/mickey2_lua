FTL_FloatGraveyard_Visit2SetupDebug = function()
  SetGlobal("FTL_FloatGraveyard_VisitNumber", 2)
  SetGlobal("FTL_FloatGraveyard_PipeDoorState", 1)
  SetGlobal("FTL_FloatGraveyard_IntroIGC", 2)
  SetGlobal("FTL_FloatGraveyard_JollyRogerState", 1)
  SetGlobal("FTL_FloatGraveyard_TankerGenerator", 0)
  SetGlobal("FTL_FloatGraveyard_FireworksState02", 2)
  SetGlobal("EM2_Camera", 1)
  DestroyEntity("BasherDrumInitial")
  Unhide("BasherDrumBroken")
  return 
end
FTL_Float_RunningSetup = 0
FTL_BasherSpawned = 0
FTL_Float_AudioPlaying = 0
FTL_FloatGraveyard_AlwaysSetup = function(entry)
  local currentLevel = string.sub(tostring(LevelManager_GetCurrentState()), 20, 21)
  if (FTL_Float_RunningSetup == 0) then
    FTL_Float_RunningSetup = 1
    if (GetGlobal("EM2_EpisodeCheck") == 1) then
      SetGlobal("EM2_EpisodeCheck", 2)
    end
    if (LevelManager_GetCurrentState() == "ftl_floatgraveyard.visit_2") then
      FTL_FloatGraveyard_Visit2SetupDebug()
    end
    FTL_FloatGraveyard_DetermineEnemies(nil, "determine")
    if (entry == "DEC") then
      FTL_FloatGraveyard_DetermineStreams("electric")
      FTL_FloatGraveyard_StreamCheck_StartOfLevel()
    end
    ForEachEntityInGroup(Hide, "FloatGraveyardHideGroup")
    FTL_FloatGraveyard_CameraValuesCustom()
    if (GetGlobal("FTL_FloatGraveyard_PipeDoorState") == 1) then
      DestroyEntity("ftl_floatgraveyard_01a_chesthall_art.CentralHallway_PipeHallDoor 01")
      ForEachEntityInGroup(DestroyEntity, "ChestHallFireworksGroup")
    end
    if (GetGlobal("FTL_FloatGraveyard_GremlinPhotoQuest") == 1) then
      Enable("GremlinPhoto_Marker 01")
    elseif (GetGlobal("FTL_FloatGraveyard_GremlinPhotoQuest") == 2) then
      ForEachEntityInGroup(Enable, "GremlinPhoto_BirdGroup")
    elseif (GetGlobal("FTL_FloatGraveyard_GremlinPhotoQuest") == 3) then
      Enable("GremlinPhoto_Marker 03")
    elseif (GetGlobal("FTL_FloatGraveyard_GremlinPhotoQuest") == 4) then
      Enable("GremlinPhoto_Marker 04")
    end
    if (1 <= GetGlobal("FTL_FloatGraveyard_BasherGenerator")) then
      if (currentLevel == "a1") then
        Prefab_BeetleworxSpawner_Base_TogglePlayerCollision("BasherSpawner_SpawnerLocation", "Off")
      end
    elseif (GetGlobal("FTL_FloatGraveyard_BasherGenerator") == 0) then
      if (FTL_BasherSpawned == 0) then
        if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
          FTL_BasherSpawned = 1
          FTL_FloatGraveyard_BasherGeneratorOpen()
        end
      end
    end
    if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 2) then
      if IsValidHandle("BasherSpawner_SpawnerLocation") then
        local data = GetPrefabData("BasherSpawner_SpawnerLocation")
        if (GetGlobal("FTL_FloatGraveyard_BasherGenerator") < 1) then
          Prefab_BeetleworxSpawner_Base_TogglePlayerCollision("BasherSpawner_SpawnerLocation", "Off")
          data.DoorsRemainOpen = "True"
          Prefab_BeetleworxSpawner_Base_ChangeState("BasherSpawner_SpawnerLocation", "Hacked")
          Prefab_BeetleworxSpawner_Base_Doors("BasherSpawner_SpawnerLocation", "Open")
          if IsValidHandle("ftl_floatgraveyard_01a_lightparade_art.prefab_beetleworxspawner_base 01.Wind") then
            DestroyEntity("ftl_floatgraveyard_01a_lightparade_art.prefab_beetleworxspawner_base 01.Wind")
          end
        end
      end
    end
    if (GetGlobal("FTL_FloatGraveyard_BasherGeneratorWall") == 1) then
      DestroyEntity("ftl_floatgraveyard_01a_basherhall_art.ElectricArea_BeetleworxGenerator 02")
      ForEachEntityInGroup(DestroyEntity, "BasherGeneratorFireworkGroup")
    end
    if (GetGlobal("FTL_FloatGraveyard_JollyRogerState") == 1) then
      if (entry ~= "stream") then
        TeleportToEntity("MiniFloatMovable", "MiniFloatKnot2")
        AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_JollyRogerDoor 02", "opened")
        AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_JollyRogerDoor 01", "open")
      end
    end
    if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 2) then
      ForceSketched("ftl_floatgraveyard_01a_art.FloatArea_GepettoLegLeft 02")
      ForEachEntityInGroup(AnimGBSequence, "GepettoLegPanelGroup", "opened")
      ForEachEntityInGroup(SetVulnerability, "GepettoLegPanelGroup", ST_SPIN, 0)
      DestroyEntity("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoChest 01")
      TimerEnable("ftl_floatgraveyard_01a_chesthall_art.FloatArea_PipeTimer 01")
      ForEachEntityInGroup(DestroyEntity, "GepettoFloatGear")
      DestroyEntity("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoChest 02")
      Disable("FloatArea_GepettoLegRightHack 01")
      Disable("FloatArea_GepettoLegLeftHack 01")
    end
    if (GetGlobal("FTL_FloatGraveyard_BasherHallDoor") == 1) then
      FTL_FloatGraveyard_DisableBasherSwitches()
    end
    if (GetGlobal("FTL_FloatGraveyard_FireworksState02") == 2) then
      FTL_AliceHouseState = 1
      ForEachEntityInGroup(DestroyEntity, "ShipFireworks")
      ForEachEntityInGroup(DestroyEntity, "AliceLargeFireworksGroup")
      DestroyEntity("FinalArea_AliceDoor 02")
      if (GetGlobal("EM2_EpisodeCheck") == 2) then
        ForEachEntityInGroup(FireUser1, "ThinnerSteamGroup")
      end
      AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_LargeHandPlatform", "fall")
    elseif (GetGlobal("FTL_FloatGraveyard_FireworksState01") == 2) then
      DestroyEntity("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_LargeFireworksCrate 01")
      AnimGBSequence("FinalArea_AliceDoor 02", "crack")
      AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_LargeHandPlatform", "fall")
    end
    FireThread(FTL_FloatGraveyard_ManageCircusCages)
    DecrementPaintAbilitiesDisabled(GetPlayer())
    FTL_Float_RunningSetup = 0
    if (entry == "DEC") then
      FTL_FloatGraveyard_IntroCutscene()
    end
  end
  return 
end
FTL_EnemyCount = 0
FTL_EnemyCountCheck = 0
FTL_FloatGraveyard_DetermineEnemies = function(target, action, enemy)
  if (action == "determine") then
    if (FTL_EnemyCountCheck == 0) then
      FTL_EnemyCountCheck = 1
      if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 2) then
        if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 2) then
          FTL_EnemyCount = (FTL_EnemyCount + 1)
        end
        if (GetGlobal("FTL_FloatGraveyard_BasherGeneratorWall") == 1) then
          FTL_EnemyCount = (FTL_EnemyCount + 1)
        end
        if (GetGlobal("FTL_FloatGraveyard_FireworksState02") == 2) then
          FTL_EnemyCount = (FTL_EnemyCount + 1)
        end
        if (2 <= FTL_EnemyCount) then
          SetGlobal("FTL_FloatGraveyard_SecondVisitEnemies", 2)
        else
          SetGlobal("FTL_FloatGraveyard_SecondVisitEnemies", 1)
          if (action == "check") then
            if (GetGlobal("FTL_FloatGraveyard_SecondVisitEnemies") == 2) then
              Unhide(target)
            else
              if (enemy == "ELP_Tanker") then
                DestroyEntity("MemoriesQuestPhotoMarker")
              end
              DestroyEntity(target)
            end
          end
        end
      end
    end
  elseif (action == "check") then
    if (GetGlobal("FTL_FloatGraveyard_SecondVisitEnemies") == 2) then
      Unhide(target)
    else
      if (enemy == "ELP_Tanker") then
        DestroyEntity("MemoriesQuestPhotoMarker")
      end
      DestroyEntity(target)
    end
  end
  return 
end
FTL_DestinationZone = "none"
FTL_FloatGraveyard_DetermineStreams = function(area)
  if (area == "electric") then
    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
      LevelManager_SetCurrentState("FTL_FloatGraveyard.A1_IGC")
      FTL_DestinationZone = "FTL_FloatGraveyard.A1_IGC"
    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
      LevelManager_SetCurrentState("FTL_FloatGraveyard.A1_v1")
      FTL_DestinationZone = "FTL_FloatGraveyard.A1_v1"
    elseif (GetGlobal("OST_Moody_Destination") == 4) then
      LevelManager_SetCurrentState("FTL_FloatGraveyard.A1_Pirate")
      FTL_DestinationZone = "FTL_FloatGraveyard.A1_Pirate"
    else
      LevelManager_SetCurrentState("FTL_FloatGraveyard.A1_v2")
      FTL_DestinationZone = "FTL_FloatGraveyard.A1_v2"
      if (area == "gepetto") then
        if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
          LevelManager_SetCurrentState("FTL_FloatGraveyard.A2_IGC")
          FTL_DestinationZone = "FTL_FloatGraveyard.A2_IGC"
        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
          LevelManager_SetCurrentState("FTL_FloatGraveyard.A2_v1")
          FTL_DestinationZone = "FTL_FloatGraveyard.A2_v1"
        else
          LevelManager_SetCurrentState("FTL_FloatGraveyard.A2_v2")
          FTL_DestinationZone = "FTL_FloatGraveyard.A2_v2"
          if (area == "alice") then
            if (GetGlobal("FTL_FloatGraveyard_TankerGenerator") < 0) then
              if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_IGC")
                FTL_DestinationZone = "FTL_FloatGraveyard.A4_IGC"
              end
            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
              LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_v1")
              FTL_DestinationZone = "FTL_FloatGraveyard.A4_v1"
            elseif (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
              if (GetCurrentCount("BunnyChildren_FloatGraveyard") ~= 5) then
                LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_Bunny")
                FTL_DestinationZone = "FTL_FloatGraveyard.A4_Bunny"
              end
            else
              LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_v2")
              FTL_DestinationZone = "FTL_FloatGraveyard.A4_v2"
            end
          end
        end
      elseif (area == "alice") then
        if (GetGlobal("FTL_FloatGraveyard_TankerGenerator") < 0) then
          if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
            LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_IGC")
            FTL_DestinationZone = "FTL_FloatGraveyard.A4_IGC"
          end
        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
          LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_v1")
          FTL_DestinationZone = "FTL_FloatGraveyard.A4_v1"
        elseif (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
          if (GetCurrentCount("BunnyChildren_FloatGraveyard") ~= 5) then
            LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_Bunny")
            FTL_DestinationZone = "FTL_FloatGraveyard.A4_Bunny"
          end
        else
          LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_v2")
          FTL_DestinationZone = "FTL_FloatGraveyard.A4_v2"
        end
      end
    end
  elseif (area == "gepetto") then
    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
      LevelManager_SetCurrentState("FTL_FloatGraveyard.A2_IGC")
      FTL_DestinationZone = "FTL_FloatGraveyard.A2_IGC"
    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
      LevelManager_SetCurrentState("FTL_FloatGraveyard.A2_v1")
      FTL_DestinationZone = "FTL_FloatGraveyard.A2_v1"
    else
      LevelManager_SetCurrentState("FTL_FloatGraveyard.A2_v2")
      FTL_DestinationZone = "FTL_FloatGraveyard.A2_v2"
      if (area == "alice") then
        if (GetGlobal("FTL_FloatGraveyard_TankerGenerator") < 0) then
          if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
            LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_IGC")
            FTL_DestinationZone = "FTL_FloatGraveyard.A4_IGC"
          end
        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
          LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_v1")
          FTL_DestinationZone = "FTL_FloatGraveyard.A4_v1"
        elseif (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
          if (GetCurrentCount("BunnyChildren_FloatGraveyard") ~= 5) then
            LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_Bunny")
            FTL_DestinationZone = "FTL_FloatGraveyard.A4_Bunny"
          end
        else
          LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_v2")
          FTL_DestinationZone = "FTL_FloatGraveyard.A4_v2"
        end
      end
    end
  elseif (area == "alice") then
    if (GetGlobal("FTL_FloatGraveyard_TankerGenerator") < 0) then
      if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
        LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_IGC")
        FTL_DestinationZone = "FTL_FloatGraveyard.A4_IGC"
      end
    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
      LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_v1")
      FTL_DestinationZone = "FTL_FloatGraveyard.A4_v1"
    elseif (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
      if (GetCurrentCount("BunnyChildren_FloatGraveyard") ~= 5) then
        LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_Bunny")
        FTL_DestinationZone = "FTL_FloatGraveyard.A4_Bunny"
      end
    else
      LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_v2")
      FTL_DestinationZone = "FTL_FloatGraveyard.A4_v2"
    end
  end
  return 
end
FTL_FloatGraveyard_StreamCheck = function()
  while true do
    if (not (LevelManager_HasStateFinishedStreaming() == false)) then
      break
    end
    Wait(0.20000000298023224)
  end
  while true do
    if (not (LevelManager_WaitingForStreamingSync() == false)) then
      break
    end
    Wait(0.05000000074505806)
  end
  return 
end
FTL_FloatGraveyard_StreamCheck_StartOfLevel = function()
  while true do
    if (not (LevelManager_HasStateFinishedStreaming() == false)) then
      break
    end
    Wait(0.20000000298023224)
  end
  return 
end
FTL_FloatGraveyard_Checkpoint = function(target, location)
  Wait(0.5)
  if (location == "electric") then
    SaveCheckpoint(GetPlayer(), "FTL_FloatGraveyard_ElectricCheckpointSave", "ftl_floatgraveyard_01a.ElectricArea_MickeyMarker 01", "ftl_floatgraveyard_01a.ElectricArea_MickeyMarker 02")
  elseif (location == "gepetto") then
    SetGlobal("FTL_FloatGraveyard_A2CheckpointLocation", 1)
    SaveCheckpoint(GetPlayer(), "FTL_FloatGraveyard_A2CheckpointSave", "ftl_floatgraveyard_01a.GepettoArea_MickeyMarker 01", "ftl_floatgraveyard_01a.GepettoArea_OswaldMarker 01")
  elseif (location == "alice") then
    SaveCheckpoint(GetPlayer(), "FTL_FloatGraveyard_AliceCheckpointSave", "ftl_floatgraveyard_01a.FinalArea_MickeyMarker 01", "ftl_floatgraveyard_01a.FinalArea_OswaldMarker 01")
  elseif (location == "center") then
    SetGlobal("FTL_FloatGraveyard_A2CheckpointLocation", 2)
    SaveCheckpoint(GetPlayer(), "FTL_FloatGraveyard_A2CheckpointSave", "ftl_floatgraveyard_01a.CenterHall_MickeyMarker 01", "ftl_floatgraveyard_01a.CenterHall_OswaldMarker 01")
  end
  return 
end
FTL_FloatGraveyard_A2CheckpointSave = function(entry)
  SetGlobal("FTL_FloatGraveyard_RotatingAirlock", 1)
  Disable("MovingTurnstileBlockerCenter")
  Enable("MovingTurnstileBlockerAlice")
  TeleportToEntity("CenterHallwayMovingAirlock", "CenterHallway_MovingAirlock_Marker 02")
  if (GetGlobal("FTL_FloatGraveyard_A2CheckpointLocation") == 1) then
    FTL_FloatGraveyard_GepettoCheckpointSave(entry)
  elseif (GetGlobal("FTL_FloatGraveyard_A2CheckpointLocation") == 2) then
    FTL_FloatGraveyard_CenterCheckpointSave()
  end
  return 
end
FTL_FloatGraveyard_GepettoCheckpointSave = function(entry)
  FTL_MickeyStreamArea = 2
  FTL_OswaldStreamArea = 2
  FTL_StreamedSaveCheck = 2
  CameraReset()
  StromboliFloatMusicStateLoad()
  if (entry == "Projector_toFort") then
    if (GetGlobal("FTL_FloatGraveyard_ManageLoading") == 0) then
      SetGlobal("FTL_FloatGraveyard_ManageLoading", 1)
    end
    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
      AnimGBSequence("ftl_floatgraveyard_01a_art.FloatArea_GepettoArmRight 01", "Pos2")
      SetPropertyBool("ftl_floatgraveyard_01a_art.FloatArea_GepettoArmRight 01", "Start Active", true)
    end
    FTL_FloatGraveyard_DetermineStreams("gepetto")
    FTL_FloatGraveyard_StreamCheck()
  end
  FTL_FloatGraveyard_AlwaysSetup()
  DEBUG_GepettoAreaSetup()
  return 
end
FTL_FloatGraveyard_AliceCheckpointSave = function(entry)
  FTL_MickeyStreamArea = 4
  FTL_OswaldStreamArea = 4
  FTL_StreamedSaveCheck = 4
  CameraReset()
  AliceFloatMusicStateLoad()
  if (entry == "Projector_toPrescottArena_Paint") then
    SetGlobal("FTL_FloatGraveyard_ManageLoading", 1)
    FTL_FloatGraveyard_DetermineStreams("alice")
    FTL_FloatGraveyard_StreamCheck()
  end
  TeleportToEntity("CenterHallwayMovingAirlock", "CenterHallway_MovingAirlock_Marker 01")
  SetGlobal("FTL_FloatGraveyard_RotatingAirlock", 0)
  Enable("MovingTurnstileBlockerCenter")
  Disable("MovingTurnstileBlockerAlice")
  FTL_FloatGraveyard_AlwaysSetup()
  DEBUG_AliceAreaSetup()
  return 
end
FTL_FloatGraveyard_AliceHardLoad = function()
  local projector = "none"
  if (GetGlobal("FTL_FloatGraveyard_AliceProjector") == 1) then
    projector = "Projector_toPrescottArena_Paint"
  elseif (GetGlobal("FTL_FloatGraveyard_AliceProjector") == 2) then
    projector = "Projector_toPrescottArena_Thinner"
  end
  if (projector ~= "none") then
    GetPrefabData(projector).MapLoad_SetupPosition = "True"
    OnMapLoad_ProjectorSetup(projector)
    SetGlobal("FTL_FloatGraveyard_AliceProjector", 0)
  end
  return 
end
FTL_FloatGraveyard_CenterCheckpointSave = function()
  FTL_MickeyStreamArea = 3
  FTL_OswaldStreamArea = 3
  FTL_StreamedSaveCheck = 3
  CameraReset()
  FTL_FloatGraveyard_AlwaysSetup()
  DEBUG_CenterAreaSetup()
  return 
end
FTL_FloatGraveyard_ElectricCheckpointSave = function(entry)
  StartFadeOut(0)
  FTL_MickeyStreamArea = 1
  FTL_OswaldStreamArea = 1
  FTL_StreamedSaveCheck = 1
  CameraReset()
  SetGlobal("FTL_FloatGraveyard_RotatingAirlock", 1)
  Disable("MovingTurnstileBlockerCenter")
  Enable("MovingTurnstileBlockerAlice")
  TeleportToEntity("CenterHallwayMovingAirlock", "CenterHallway_MovingAirlock_Marker 02")
  FTL_FloatGraveyard_AlwaysSetup("DEC")
  DEBUG_ElectricAreaSetup()
  return 
end
FTL_StreamedSaveCheck = 0
FTL_StreamedSaveSafetyNet = 0
FTL_FloatGraveyard_StreamedAreaSave = function(target, current)
  if (FTL_StreamedSaveCheck ~= tonumber(current)) then
    if (DEBUG_ALLOWSTREAMING == 0) then
      if (tonumber(current) == 1) then
        SaveCheckpoint(GetPlayer(), "FTL_FloatGraveyard_ElectricCheckpointSave", "ftl_floatgraveyard_01a.ElectricArea_MickeyMarker 01", "ftl_floatgraveyard_01a.ElectricArea_MickeyMarker 02")
      elseif (tonumber(current) == 2) then
        SetGlobal("FTL_FloatGraveyard_A2CheckpointLocation", 1)
        SaveCheckpoint(GetPlayer(), "FTL_FloatGraveyard_A2CheckpointSave", "ftl_floatgraveyard_01a.GepettoArea_MickeyMarker 01", "ftl_floatgraveyard_01a.GepettoArea_OswaldMarker 01")
      elseif (tonumber(current) == 3) then
        FTL_StreamedSaveSafetyNet = 0
        SetGlobal("FTL_FloatGraveyard_A2CheckpointLocation", 2)
        SaveCheckpoint(GetPlayer(), "FTL_FloatGraveyard_A2CheckpointSave", "ftl_floatgraveyard_01a.CenterHall_MickeyMarker 01", "ftl_floatgraveyard_01a.CenterHall_OswaldMarker 01")
      elseif (tonumber(current) == 4) then
        if (GetGlobal("FTL_FloatGraveyard_Gus_Hint2_Played") == 1) then
          SaveCheckpoint(GetPlayer(), "FTL_FloatGraveyard_AliceCheckpointSave", "ftl_floatgraveyard_01a.FinalArea_MickeyMarker 01", "ftl_floatgraveyard_01a.FinalArea_OswaldMarker 01")
        end
      elseif (tonumber(current) == 5) then
        SetGlobal("FTL_FloatGraveyard_A2CheckpointLocation", 1)
        SaveCheckpoint(GetPlayer(), "FTL_FloatGraveyard_A2CheckpointSave", "ftl_floatgraveyard_01a.GepettoArea_MickeyMarker 02", "ftl_floatgraveyard_01a.GepettoArea_OswaldMarker 02")
      end
      FTL_StreamedSaveCheck = tonumber(current)
    end
  elseif (FTL_StreamedSaveSafetyNet == 1) then
    if (FTL_StreamedSaveCheck == 3) then
      FTL_StreamedSaveSafetyNet = 0
      SetGlobal("FTL_FloatGraveyard_A2CheckpointLocation", 2)
      SaveCheckpoint(GetPlayer(), "FTL_FloatGraveyard_A2CheckpointSave", "ftl_floatgraveyard_01a.CenterHall_MickeyMarker 01", "ftl_floatgraveyard_01a.CenterHall_OswaldMarker 01")
      FTL_StreamedSaveCheck = tonumber(current)
    end
  end
  return 
end
FTL_RotatingAirlockMickey = 0
FTL_RotatingAirlockOswald = 0
FTL_FloatGraveyard_SetAirlockPosition = function(target, direction, marker)
  if (GetName(target) == GetName(GetPlayer())) then
    if (direction == "enter") then
      OverrideSpawnTransform(PLAYER_ONE, GetPosition(marker), GetFacing(marker))
      FTL_RotatingAirlockMickey = 1
    elseif (direction == "exit") then
      ClearOverrideSpawnTransform(PLAYER_ONE)
      FTL_RotatingAirlockMickey = 0
      if (GetName(target) == GetName(GetPlayer2OrAI())) then
        if (direction == "enter") then
          OverrideSpawnTransform(PLAYER_TWO, GetPosition(marker), GetFacing(marker))
          FTL_RotatingAirlockOswald = 1
        elseif (direction == "exit") then
          ClearOverrideSpawnTransform(PLAYER_TWO)
          FTL_RotatingAirlockOswald = 0
        end
      end
    end
  elseif (GetName(target) == GetName(GetPlayer2OrAI())) then
    if (direction == "enter") then
      OverrideSpawnTransform(PLAYER_TWO, GetPosition(marker), GetFacing(marker))
      FTL_RotatingAirlockOswald = 1
    elseif (direction == "exit") then
      ClearOverrideSpawnTransform(PLAYER_TWO)
      FTL_RotatingAirlockOswald = 0
    end
  end
  return 
end
FTL_Fort_ToFloatGraveyard = function(exitProjector)
  if (exitProjector == "DEC") then
    FTL_FloatGraveyard_DetermineStreams("electric")
  end
  SetupPosition()
  return 
end
FTL_FloatGraveyard_CameraValuesCustom = function()
  SetDefaultCameraValues(7.5, 6, 5.5)
  SetTravelCameraValues(8.5, 13.5, -1)
  return 
end
FTL_FloatGraveyard_CameraValuesDefault = function()
  SetDefaultCameraValues(5.5, 7, 0)
  SetTravelCameraValues(7.5, 15, -7)
  return 
end
FTL_FloatGraveyard_CameraHintAndRelease = function(target, camera, delay)
  SetCameraAttributes(camera)
  if (delay == "none") then
    Wait(2)
  else
    Wait(tonumber(delay))
  end
  ClearAllCameraAttributes(target)
  return 
end
FTL_FloatGraveyard_SetGlobalVariable = function(target, variable, value)
  SetGlobal(variable, tonumber(value))
  return 
end
FTL_FloatGraveyard_SetLocalVariable = function(target, variable, value)
  _G[variable] = tonumber(value)
  return 
end
FTL_FloatGraveyard_ToGulch2 = function(target)
  SetGlobal("FTL_FloatGraveyard_ManageLoading", 0)
  SetupPosition(target)
  return 
end
FTL_FloatGraveyard_ToPrescottArena = function(target)
  SetGlobal("FTL_FloatGraveyard_ManageLoading", 0)
  if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
    SetGlobal("FTL_FloatGraveyard_VisitNumber", 2)
    SetGlobal("FTL_FloatGraveyard_CriticalHintFlow", 5)
    Quest_SetCriticalPath("Critical_Floatyard", "Critical_Floatyard_2")
    ForEachEntityInGroup(DestroyEntity, "GusHintAliceArea")
  end
  if (GetGlobal("FTL_FloatGraveyard_ThinnerProjector") == 1) then
    if IsValidHandle("ftl_floatgraveyard_01a_alicehouse_scripting.thinnerjetdamage 01.SteamJet_Blast") then
      Print("Destroying thinner jets")
      ForEachEntityInGroup(DestroyEntity, "AliceProjectorThinnerJet1")
      ForEachEntityInGroup(DestroyEntity, "AliceProjectorThinnerJet2")
    end
  end
  SetupPosition(target)
  return 
end
FTL_FloatGraveyard_ElectricStreamOswald = function(target, receptor)
  OswaldStreamAction(receptor)
  return 
end
FTL_FloatGraveyard_CoOpThrowOswald = function()
  OswaldTossAction()
  ClearNextPatrolNode(GetOswaldAI())
  return 
end
FTL_FloatGraveyard_SetPatrolOswald = function(target)
  ClearNextPatrolNode(GetOswaldAI())
  Wait(0.10000000149011612)
  OswaldSetPathAction(target)
  return 
end
FTL_FloatGraveyard_ClearPatrolOswald = function()
  ClearNextPatrolNode(GetOswaldAI())
  Wait(0.10000000149011612)
  OswaldStartFollowAction()
  return 
end
FTL_FloatGraveyard_SetHackOswald = function(target, hack)
  Wait(0.10000000149011612)
  OswaldHackAction(hack)
  return 
end
PostIGC_0250a_PrescottIntroElectricalParade = function()
  local data = GetPrefabData("DEC_toFort3D")
  local data2 = GetPrefabData("BasherSpawner_SpawnerLocation")
  LevelManager_SetCurrentState("FTL_FloatGraveyard.A1_v1")
  FTL_FloatGraveyard_StreamCheck()
  Prefab_DECFoopToob_Finish()
  AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.prefab_beetleworxspawner_base 01.OuterDoors_Left", "Rest")
  AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.prefab_beetleworxspawner_base 01.InnerDoors", "Rest")
  AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.prefab_beetleworxspawner_base 01.Orb", "Rest")
  TeleportToEntity("BasherGeneratorSpawner", "ElectricTeleportFloatMarker1")
  ShowHud()
  StartFadeIn(0.800000011920929)
  SetGlobal("FTL_FloatGraveyard_CriticalHintFlow", 1)
  Quest_SetCriticalPath("Critical_Floatyard", "Critical_Floatyard_1")
  ObservatoryItem_Activate("MSS_ObservatoryItem_Float", "7")
  Hide("ftl_floatgraveyard_01a_ai.GremlinPrescott 01")
  SetPropertyString("BasherGeneratorSpawner", "Spawn Group", "Float_BeetleworxBasher_AI")
  ForceSpawn("BasherGeneratorSpawner", 1)
  data2.BeetleworxNumSpawned[1] = 1
  SetGlobal("FTL_FloatGraveyard_IntroIGC", 1)
  SetGlobal("FTL_FloatGraveyard_BasherGenerator", 0)
  data2.SpawnerActive = "True"
  FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_Hint1")
  data.SkipExitAnimationAndTeleport[1] = "Animation"
  data.SkipExitAnimationAndTeleport[2] = "Teleport"
  FTL_FloatGraveyard_Checkpoint(nil, "electric")
  TeleportToEntity("BasherGeneratorSpawner", "ElectricBasherSpawnerMarker")
  FireThread(StationaryCamera_UntilPlayerMoves)
  return 
end
PostIGC_0250b_PrescottIntroGeppetto = function()
  ClearAllCameraAttributes()
  LevelManager_SetCurrentState("FTL_FloatGraveyard.A2_v1")
  FTL_FloatGraveyard_StreamCheck()
  ShowHud()
  StartFadeIn(0.800000011920929)
  UnrestrictCutSceneInput()
  ActivateGremlinHint("GusHintGepettoPaint1")
  SetGlobal("FTL_FloatGraveyard_CriticalHintFlow", 1)
  Quest_SetCriticalPath("Critical_Floatyard", "Critical_Floatyard_1")
  ObservatoryItem_Activate("MSS_ObservatoryItem_Float", "7")
  SetGlobal("FTL_FloatGraveyard_IntroIGC", 2)
  AnimGBSequence("ftl_floatgraveyard_01a_art.FloatArea_GepettoArmRight 01", "rest")
  AnimGBSequence("ftl_floatgraveyard_01a_art.FloatArea_GepettoArmLeft 01", "rest")
  Wait(0.20000000298023224)
  FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_Hint1")
  FTL_FloatGraveyard_Checkpoint(nil, "gepetto")
  FireThread(StationaryCamera_UntilPlayerMoves)
  return 
end
PostIGC_0255_PrescottBeforeBossFight = function()
  local data = GetPrefabData("TankerSpawner_SpawnerLocation")
  LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_v1")
  FTL_FloatGraveyard_StreamCheck()
  CameraReset()
  AnimGBSequence("AliceShutterMain", "opened")
  TeleportToEntity("AlicePaintProjectorStand", "PaintProjectorMarker2")
  TeleportToEntity("Float_BeetleworxTanker_Spawner", "TankerTeleportMarkerOutside")
  AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.prefab_beetleworxspawner_base 01.InnerDoors", "Rest")
  AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.prefab_beetleworxspawner_base 01.Orb", "Rest")
  AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.prefab_beetleworxspawner_base 01.OuterDoors_Left", "Rest")
  Wait(0.10000000149011612)
  ShowHud()
  StartFadeIn(0.800000011920929)
  UnrestrictCutSceneInput()
  SetGlobal("FTL_FloatGraveyard_CriticalHintFlow", 4)
  Quest_SetCriticalPath("Critical_Floatyard", "Critical_Floatyard_6")
  SetGlobal("FTL_FloatGraveyard_TankerGenerator", 0)
  Hide("ftl_floatgraveyard_01a_ai.GremlinPrescott 01")
  DestroyEntity("GusHintCenterNeutral1")
  TeleportToEntity("CenterHallwayMovingAirlock", "CenterHallway_MovingAirlock_Marker 01")
  SetGlobal("FTL_FloatGraveyard_TankerSpawned", 1)
  SetPropertyString("Float_BeetleworxTanker_Spawner", "Spawn Group", "Float_BeetleworxTanker_AI")
  ForceSpawn("ftl_floatgraveyard_01a_ai.TankerSpawner 01", 1)
  data.BeetleworxNumSpawned[1] = 1
  data.SpawnerActive = "True"
  AnimGBSequence("BandConcertScreen", "loop")
  FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_Hint2")
  TeleportToEntity("Float_BeetleworxTanker_Spawner", "TankerTeleportMarkerInside")
  FTL_FloatGraveyard_Checkpoint(nil, "alice")
  FireThread(StationaryCamera_UntilPlayerMoves)
  return 
end
FTL_FloatIntroPlayed = false
FTL_FloatGraveyard_IntroCutscene = function()
  if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
    TeleportToEntity("DEC_Camera", "DEC_CameraMarker")
    PlayIGC("IGC_0250a_PrescottIntroElectricalParade")
  else
    TeleportToEntity(GetPlayer(), "ftl_floatgraveyard_01a.ElectricArea_MickeyMarker 01")
    TeleportToEntity(GetPlayer2OrAI(), "ftl_floatgraveyard_01a.ElectricArea_MickeyMarker 02")
    Prefab_DECFoopToob_Finish()
    FTL_FloatGraveyard_DetermineStreams("electric")
    StartFadeIn(0.800000011920929)
    FireThread(StationaryCamera_UntilPlayerMoves)
  end
  MusicPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_ELP", "Play_MX_FGY_ELP")
  RemoveAllMusicStateOverride()
  Print("Started ELP 3D music event")
  return 
end
FTL_MickeyStreamArea = 1
FTL_OswaldStreamArea = 1
FTL_FloatGraveyard_ManageStreams = function(target, area)
  if (GetName(_activator()) == GetName(GetPlayer())) then
    if (DEBUG_ALLOWSTREAMING == 0) then
      if (GetName(_activator()) == GetName(GetPlayer())) then
        FTL_MickeyStreamArea = tonumber(area)
      elseif (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
        FTL_OswaldStreamArea = tonumber(area)
      else
        Print("Stream trigger triggered by enemy AI")
      end
      if (FTL_MickeyStreamArea == 1) then
        if (FTL_OswaldStreamArea == 1) then
          DEBUG_ElectricAreaSetup()
        end
      else
        if (FTL_MickeyStreamArea ~= 6) then
          if (FTL_MickeyStreamArea ~= 8) then
            if (FTL_MickeyStreamArea ~= 7) then
              if (FTL_MickeyStreamArea ~= 6) then
                if (FTL_MickeyStreamArea ~= 7) then
                  if (FTL_MickeyStreamArea ~= 5) then
                    if (FTL_MickeyStreamArea ~= 8) then
                      if (FTL_MickeyStreamArea ~= 5) then
                        if (FTL_MickeyStreamArea ~= 2) then
                          if (FTL_MickeyStreamArea ~= 5) then
                            if (FTL_MickeyStreamArea ~= 2) then
                              if (FTL_MickeyStreamArea ~= 6) then
                                if (FTL_MickeyStreamArea ~= 9) then
                                  if (FTL_MickeyStreamArea ~= 7) then
                                    if (FTL_MickeyStreamArea ~= 8) then
                                      if (FTL_MickeyStreamArea ~= 9) then
                                        if (FTL_MickeyStreamArea ~= 6) then
                                          if (FTL_MickeyStreamArea ~= 9) then
                                            if (FTL_MickeyStreamArea ~= 5) then
                                              if (FTL_MickeyStreamArea ~= 9) then
                                                if (FTL_MickeyStreamArea ~= 3) then
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
                    end
                  end
                end
              end
            end
          end
        end
        DEBUG_GepettoAreaSetup()
        DEBUG_ElectricAreaSetup()
        DEBUG_CenterAreaSetup()
        if (FTL_MickeyStreamArea ~= 1) then
          if (FTL_MickeyStreamArea ~= 5) then
            if (FTL_MickeyStreamArea ~= 1) then
              if (FTL_MickeyStreamArea ~= 6) then
                if (FTL_MickeyStreamArea ~= 3) then
                  if (FTL_MickeyStreamArea ~= 5) then
                    if (FTL_MickeyStreamArea ~= 3) then
                    end
                  end
                end
              end
            end
          end
        end
        DEBUG_ElectricAreaSetup()
        DEBUG_CenterAreaSetup()
        if (FTL_MickeyStreamArea == 2) then
          if (FTL_OswaldStreamArea == 2) then
            DEBUG_GepettoAreaSetup()
          end
        else
          if (FTL_MickeyStreamArea ~= 2) then
            if (FTL_MickeyStreamArea ~= 7) then
              if (FTL_MickeyStreamArea ~= 2) then
                if (FTL_MickeyStreamArea ~= 8) then
                  if (FTL_MickeyStreamArea ~= 3) then
                    if (FTL_MickeyStreamArea ~= 7) then
                      if (FTL_MickeyStreamArea ~= 3) then
                      end
                    end
                  end
                end
              end
            end
          end
          DEBUG_GepettoAreaSetup()
          DEBUG_CenterAreaSetup()
          if (FTL_MickeyStreamArea == 3) then
            if (FTL_OswaldStreamArea == 3) then
              FTL_FloatGraveyard_DetermineStreams("gepetto")
              DEBUG_CenterAreaSetup()
            end
          else
            if (FTL_MickeyStreamArea ~= 3) then
            end
            FTL_FloatGraveyard_DetermineStreams("gepetto")
            if (FTL_MickeyStreamArea == 4) then
              if (FTL_OswaldStreamArea == 4) then
                FTL_FloatGraveyard_DetermineStreams("alice")
                DEBUG_AliceAreaSetup()
              end
            else
              if (FTL_MickeyStreamArea ~= 1) then
              end
              FTL_FloatGraveyard_DetermineStreams("electric")
              DEBUG_GepettoAreaSetup()
              if (FTL_MickeyStreamArea ~= 2) then
              end
              FTL_FloatGraveyard_DetermineStreams("gepetto")
              DEBUG_ElectricAreaSetup()
              if (FTL_MickeyStreamArea ~= 1) then
              end
            end
          end
        end
      end
      FTL_FloatGraveyard_AlwaysSetup("stream")
    end
  end
  return 
end
FTL_FloatGraveyard_ManageJumps = function(target, action, name, edge1, edge2)
  if (action == "enable") then
    if (edge2 ~= nil) then
      local (for index), (for limit), (for step) = tonumber(edge1), tonumber(edge2), 1
      for i = (for index), (for limit), (for step) do
        enableJumpVolumeAvailability((((tostring(name) .. ".prefab_jumpvolumeavailability 0") .. i) .. ".TargetToSend"))
      end
    else
      enableJumpVolumeAvailability((((tostring(name) .. ".prefab_jumpvolumeavailability 0") .. tostring(edge1)) .. ".TargetToSend"))
      if (action == "disable") then
        if (edge2 ~= nil) then
          local (for index), (for limit), (for step), (for index) = tonumber(edge1), tonumber(edge2), 1, ".TargetToSend"
          for i = (for index), (for limit), (for step) do
            (for index) = disableJumpVolumeAvailability
            (for limit) = tostring
            (for step) = name
            (for limit) = (for limit)((for step))
            (for step) = ".prefab_jumpvolumeavailability 0"
            i = i
            (for limit) = ((((for limit) .. (for step)) .. i) .. ".TargetToSend")
            (for index)((for limit))
          end
        else
          disableJumpVolumeAvailability((((tostring(name) .. ".prefab_jumpvolumeavailability 0") .. tostring(edge1)) .. ".TargetToSend"))
        end
      end
    end
  elseif (action == "disable") then
    if (edge2 ~= nil) then
      local (for index), (for limit), (for step) = tonumber(edge1), tonumber(edge2), 1
      for i = (for index), (for limit), (for step) do
        (for index) = disableJumpVolumeAvailability
        (for limit) = tostring
        (for step) = name
        (for limit) = (for limit)((for step))
        (for step) = ".prefab_jumpvolumeavailability 0"
        i = i
        (for limit) = ((((for limit) .. (for step)) .. i) .. ".TargetToSend")
        (for index)((for limit))
      end
    else
      disableJumpVolumeAvailability((((tostring(name) .. ".prefab_jumpvolumeavailability 0") .. tostring(edge1)) .. ".TargetToSend"))
    end
  end
  return 
end
FTL_FloatGraveyard_SetCriticalPath = function(target, stage)
  if (stage == "5") then
    SetGlobal("FTL_FloatGraveyard_CriticalHintFlow", 3)
    Quest_SetCriticalPath("Critical_Floatyard", "Critical_Floatyard_5")
  elseif (GetGlobal("FTL_FloatGraveyard_CriticalHintFlow") < 3) then
    if (stage == "4a") then
      if (GetGlobal("FTL_FloatGraveyard_CriticalHintAirGust") == 0) then
        SetGlobal("FTL_FloatGraveyard_CriticalHintAirGust", 1)
        DestroyEntity("GusHintElectricPaint1")
      else
        return 
        if (GetGlobal("FTL_FloatGraveyard_CriticalHintGepetto") == 0) then
          SetGlobal("FTL_FloatGraveyard_CriticalHintGepetto", 1)
        else
          return 
        end
      end
    elseif (stage == "4b") then
      if (GetGlobal("FTL_FloatGraveyard_CriticalHintGepetto") == 0) then
        SetGlobal("FTL_FloatGraveyard_CriticalHintGepetto", 1)
      else
        return 
      end
    end
    SetGlobal("FTL_FloatGraveyard_CriticalHintFlow", 2)
    Quest_SetCriticalPath("Critical_Floatyard", ("Critical_Floatyard_" .. tostring(stage)))
  end
  return 
end
FTL_FloatGraveyard_ElectricAreaSetup = function()
  if (GetGlobal("FTL_FloatGraveyard_ManageLoading") == 0) then
    StartFadeOut(0)
    SetGlobal("FTL_FloatGraveyard_ManageLoading", 1)
  end
  return 
end
FTL_FloatGraveyard_ManageFooptoob = function(target)
  local data = GetPrefabData(target)
  if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
    data.SkipExitAnimationAndTeleport[1] = "False"
    data.SkipExitAnimationAndTeleport[2] = "False"
  end
  return 
end
FTL_FloatGraveyard_ExplodeDrumFX = function()
  local ImpulseValue = 500
  local LaunchDirection = (GetPosition("BasherDrumFX") - GetPosition("BasherDrumFXDestination"))
  LaunchDirection:normalize3()
  Unhide("BasherDrumFX")
  EnableMotion("BasherDrumFX")
  Wait(0.10000000149011612)
  ApplyImpulse("BasherDrumFX", (LaunchDirection.x * ImpulseValue), 1, 1)
  StartEmitters("BasherDrumDust")
  Wait(0.30000001192092896)
  FireThread(FTL_FloatGraveyard_DynamicObjectFade, "BasherDrumFX")
  Wait(2)
  StopEmitters("BasherDrumDust")
  return 
end
FTL_FloatGraveyard_MiniFloatPlaced = function(target, action)
  if (action == "move") then
    Wait(0.10000000149011612)
    DisableMotion("MiniFloatMovable")
    MoveToEntity("MiniFloatKnot1", "MiniFloatMovable", false)
    SplineFollower_TeleportToKnot("MiniFloatMovable", "MiniFloatKnot1")
    Enable("MiniFloatMovable")
    AudioPostEventOn(GetPlayer(), "Play_sfx_fgy_snail_float_placed")
    SetPropertyFloat("MiniFloatMovable", "UsableRadius", 0)
  elseif (action == "place") then
    AudioPostEventOn(GetPlayer(), "Stop_sfx_fgy_metal_scrape")
    StartEmitters("MiniFloatDust")
    SplineFollower_SetDisabled(target, true)
    Wait(0.10000000149011612)
    SetParentEntity(target, "ElectricArea_MiniFloatPad 02")
    SetGlobal("FTL_FloatGraveyard_ElectricFloat", (GetGlobal("FTL_FloatGraveyard_ElectricFloat") + 1))
    if (GetGlobal("FTL_FloatGraveyard_ElectricCable01") == 1) then
      if (GetGlobal("FTL_FloatGraveyard_ElectricCable02") == 1) then
        if (GetGlobal("FTL_FloatGraveyard_ElectricFloat") == 2) then
          if (GetGlobal("FTL_FloatGraveyard_JollyRogerState") == 0) then
            Prefab_OswaldElectricSwitch_ChangeState("SwitchSignMiniFloat", "Activate")
            Enable("BuddyActionMiniFloat")
          end
        end
      end
    end
    Wait(0.5)
    StopEmitters("MiniFloatDust")
  end
  return 
end
FTL_FloatGraveyard_MiniFloatShocked = function(target, action, event)
  if (GetGlobal("FTL_FloatGraveyard_ElectricCable01") == 1) then
    if (GetGlobal("FTL_FloatGraveyard_ElectricCable02") == 1) then
      if (GetGlobal("FTL_FloatGraveyard_ElectricFloat") == 2) then
        if (GetGlobal("FTL_FloatGraveyard_JollyRogerState") == 0) then
          if (action ~= "sequence") then
            Disable("BuddyActionMiniFloat")
            Enable("ElectricArea_MiniFloatPad 02")
            Enable("ElectricArea_MiniFloatPad 01")
            Wait(0.20000000298023224)
            FTL_FloatGraveyard_JollyRogerCheck()
          end
        end
      end
    end
  elseif StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    if (GetGlobal("FTL_FloatGraveyard_ElectricCable01") ~= 1) then
      if (GetGlobal("FTL_FloatGraveyard_ElectricCable02") ~= 1) then
        if (GetGlobal("FTL_FloatGraveyard_ElectricFloat") ~= 2) then
          if (GetGlobal("FTL_FloatGraveyard_JollyRogerState") ~= 0) then
            FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_MiniFloat01", 0)
          end
        end
      end
    end
  end
  return 
end
FTL_FloatGraveyard_MiniFloatRepaired = function(target, action)
  if (action == "paint") then
    StopEmitters("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_MiniFloatSparks 01")
    AudioPostEventOn("ftl_floatgraveyard_01a_fx.ElectricArea_MiniFloatSparks 01", "Stop_sfx_Machine_Sparks")
    if (GetGlobal("FTL_FloatGraveyard_ElectricFloat") ~= 3) then
      SetGlobal("FTL_FloatGraveyard_ElectricFloat", (GetGlobal("FTL_FloatGraveyard_ElectricFloat") + 1))
    end
  elseif (action == "thin") then
    StartEmitters("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_MiniFloatSparks 01")
    AudioPostEventOn("ftl_floatgraveyard_01a_fx.ElectricArea_MiniFloatSparks 01", "Play_sfx_Machine_Sparks")
    if (GetGlobal("FTL_FloatGraveyard_ElectricFloat") ~= 3) then
      SetGlobal("FTL_FloatGraveyard_ElectricFloat", (GetGlobal("FTL_FloatGraveyard_ElectricFloat") - 1))
    end
  elseif (GetGlobal("FTL_FloatGraveyard_JollyRogerState") == 0) then
    local before = 0
    local after = 0
    after = --[[ return 2 of ]] Jigsaw_GetPercentagePainted(target)
    before = Jigsaw_GetPercentagePainted(target)
    if (after == 1) then
      SetGlobal(("FTL_FloatGraveyard_ElectricCable" .. tostring(action)), 1)
    elseif (after < 1) then
      SetGlobal(("FTL_FloatGraveyard_ElectricCable" .. tostring(action)), 0)
    end
  end
  if (GetGlobal("FTL_FloatGraveyard_ElectricCable01") == 1) then
    if (GetGlobal("FTL_FloatGraveyard_ElectricCable02") == 1) then
      if (GetGlobal("FTL_FloatGraveyard_ElectricFloat") == 2) then
        if (GetGlobal("FTL_FloatGraveyard_JollyRogerState") == 0) then
          Prefab_OswaldElectricSwitch_ChangeState("SwitchSignMiniFloat", "Activate")
          Enable("BuddyActionMiniFloat")
        end
      end
    end
  else
    Prefab_OswaldElectricSwitch_ChangeState("SwitchSignMiniFloat", "Deactivate")
    Disable("BuddyActionMiniFloat")
  end
  return 
end
FTL_FloatGraveyard_JollyRogerCheck = function()
  if (GetGlobal("FTL_FloatGraveyard_JollyRogerState") == 0) then
    OswaldStreamAbort()
    SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") + 10))
    SetGlobal("FTL_FloatGraveyard_JollyRogerState", 1)
    FTL_FloatGraveyard_SetCriticalPath(nil, "3a")
    SetGlobal("FTL_FloatGraveyard_ElectricFloat", 3)
    FireUser2("HintLightParade")
    StartEmitters("JollyRogerCableSparks")
    ForceSpawn("ftl_floatgraveyard_01a_ai.HopperSpawner 01", 1)
    Wait(2.4000000953674316)
    AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_JollyRogerDoor 01", "open")
    SetPropertyBool("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_JollyRogerDoor 01", "Start Active", true)
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_ShipOpen")
    ActivateGremlinHint("GusHintElectricPaint1")
    Wait(1.399999976158142)
    AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_JollyRogerDoor 02", "opening", true)
    SetPropertyBool("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_JollyRogerDoor 02", "Start Active", true)
    SetPropertyFloat("JollyRogerRedChest", "UsableRadius", 2)
    SetPropertyBool("PirateBoatSpot", "ActionSpotEnabled", true)
    Wait(1.5)
    FTL_FloatGraveyard_Checkpoint(nil, "electric")
  end
  return 
end
FTL_FloatGraveyard_ToonDrumManage = function(target, action, group, trigger, top)
  if (action == "paint") then
    SetPropertyInt(top, "Collision Layer", 1)
    ForEachEntityInGroup(ForcePainted, group)
    Disable(trigger)
  elseif (action == "thin") then
    ForEachEntityInGroup(ForceSketched, group)
    Enable(trigger)
  end
  return 
end
FTL_FloatGraveyard_KickingFeetCheck = function(target, action, variable, leg)
  if (action == "painted") then
    SetGlobal("FTL_FloatGraveyard_KickingFeetCount", (GetGlobal("FTL_FloatGraveyard_KickingFeetCount") + 1))
    if (GetGlobal("Magic_Light_Parade_Pin") == 0) then
      Disable("BuddyActionGremlinToss")
    end
  elseif (action == "thinned") then
    SetGlobal("FTL_FloatGraveyard_KickingFeetCount", (GetGlobal("FTL_FloatGraveyard_KickingFeetCount") - 1))
    if (GetGlobal("FTL_FloatGraveyard_KickingFeetCount") == 0) then
      if (GetGlobal("Magic_Light_Parade_Pin") == 0) then
        Enable("BuddyActionGremlinToss")
      end
    end
  end
  return 
end
FTL_ClownDoorState01 = 0
FTL_ClownDoorState02 = 0
FTL_ClownDoorState03 = 0
FTL_FloatGraveyard_ClownDoorCheck = function(target, nose, activator, buddy)
  if (nose == "FTL_ClownNoseState01") then
    if (FTL_ClownDoorState01 == 0) then
      FTL_ClownDoorState01 = 1
      FTL_ClownDoorState02 = 0
      ForEachEntityInGroup(Disable, "GepettoElectricGearGroup")
      AnimGBSequence("ElectricArea_ClownMouth 02", "close")
      SetPropertyBool("ElectricArea_ClownMouth 02", "Start Active", true)
      if (activator == "gear") then
        if (GetPropertyBool("ClownNoseGepetto", "Is Painted") == false) then
          Enable("BuddyActionClownNose2")
        end
        Disable("BuddyActionClownNose1")
        Wait(2)
        FTL_FloatGraveyard_DetermineStreams("electric")
        Wait(2)
        FTL_FloatGraveyard_StreamCheck()
        ForEachEntityInGroup(SetRotatorMaxSpeed, "ElectricClownGearGroup", 0)
        FTL_ClownGearStreaming = 0
      elseif (activator == "switch") then
        OswaldStreamAbort()
        Disable(buddy)
      end
      ForEachEntityInGroup(Unhide, "OswaldAction_AirlockGear2")
      DEBUG_ElectricAreaSetup()
      Wait(0.5)
      AnimGBSequence("ElectricArea_ClownMouth 01", "open", true)
      SetPropertyBool("ElectricArea_ClownMouth 01", "Start Active", true)
      SetGlobal("FTL_FloatGraveyard_ClownAirlock", 1)
      ForEachEntityInGroup(Hide, "BasherAirlockShamGroup")
      if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
        ActivateGremlinHint("GusHintElectricNeutral1")
      end
      StartEmitters("ElectricClownMouthDust")
      ForEachEntityInGroup(Hide, "OswaldAction_AirlockGear1")
      Prefab_OswaldElectricSwitch_ChangeState("GepettoClownSwitch", "Reset")
      ForEachEntityInGroup(Enable, "GepettoGepettoGearGroup")
      Wait(3)
      StopEmitters("ElectricClownMouthDust")
    elseif (activator == "switch") then
      FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_Hint4")
      if (nose == "FTL_ClownNoseState02") then
        if (FTL_ClownDoorState02 == 0) then
          FTL_ClownDoorState02 = 1
          FTL_ClownDoorState01 = 0
          ForEachEntityInGroup(Disable, "GepettoGepettoGearGroup")
          AnimGBSequence("ElectricArea_ClownMouth 01", "close")
          SetPropertyBool("ElectricArea_ClownMouth 01", "Start Active", true)
          if (activator == "gear") then
            if (GetPropertyBool("ClownNoseElectric", "Is Painted") == false) then
              Enable("BuddyActionClownNose1")
            end
            Disable("BuddyActionClownNose2")
            Wait(2)
            FTL_FloatGraveyard_DetermineStreams("gepetto")
            Wait(2)
            FTL_FloatGraveyard_StreamCheck()
            ForEachEntityInGroup(SetRotatorMaxSpeed, "GepettoClownGearGroup", 0)
            FTL_ClownGearStreaming = 0
          elseif (activator == "switch") then
            OswaldStreamAbort()
            Disable(buddy)
          end
          ForEachEntityInGroup(Unhide, "OswaldAction_AirlockGear1")
          DEBUG_GepettoAreaSetup()
          Wait(0.5)
          AnimGBSequence("ElectricArea_ClownMouth 02", "open", true)
          SetPropertyBool("ElectricArea_ClownMouth 02", "Start Active", true)
          SetGlobal("FTL_FloatGraveyard_ClownAirlock", 2)
          ForEachEntityInGroup(Unhide, "BasherAirlockShamGroup")
          if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
            ActivateGremlinHint("GusHintGepettoNeutral2")
          end
          StartEmitters("GepettoClownMouthDust")
          ForEachEntityInGroup(Hide, "OswaldAction_AirlockGear2")
          Prefab_OswaldElectricSwitch_ChangeState("ElectricClownSwitch", "Reset")
          ForEachEntityInGroup(Enable, "GepettoElectricGearGroup")
          Wait(3)
          StopEmitters("GepettoClownMouthDust")
        elseif (activator == "switch") then
          FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_Hint4")
        end
      end
    end
  elseif (nose == "FTL_ClownNoseState02") then
    if (FTL_ClownDoorState02 == 0) then
      FTL_ClownDoorState02 = 1
      FTL_ClownDoorState01 = 0
      ForEachEntityInGroup(Disable, "GepettoGepettoGearGroup")
      AnimGBSequence("ElectricArea_ClownMouth 01", "close")
      SetPropertyBool("ElectricArea_ClownMouth 01", "Start Active", true)
      if (activator == "gear") then
        if (GetPropertyBool("ClownNoseElectric", "Is Painted") == false) then
          Enable("BuddyActionClownNose1")
        end
        Disable("BuddyActionClownNose2")
        Wait(2)
        FTL_FloatGraveyard_DetermineStreams("gepetto")
        Wait(2)
        FTL_FloatGraveyard_StreamCheck()
        ForEachEntityInGroup(SetRotatorMaxSpeed, "GepettoClownGearGroup", 0)
        FTL_ClownGearStreaming = 0
      elseif (activator == "switch") then
        OswaldStreamAbort()
        Disable(buddy)
      end
      ForEachEntityInGroup(Unhide, "OswaldAction_AirlockGear1")
      DEBUG_GepettoAreaSetup()
      Wait(0.5)
      AnimGBSequence("ElectricArea_ClownMouth 02", "open", true)
      SetPropertyBool("ElectricArea_ClownMouth 02", "Start Active", true)
      SetGlobal("FTL_FloatGraveyard_ClownAirlock", 2)
      ForEachEntityInGroup(Unhide, "BasherAirlockShamGroup")
      if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
        ActivateGremlinHint("GusHintGepettoNeutral2")
      end
      StartEmitters("GepettoClownMouthDust")
      ForEachEntityInGroup(Hide, "OswaldAction_AirlockGear2")
      Prefab_OswaldElectricSwitch_ChangeState("ElectricClownSwitch", "Reset")
      ForEachEntityInGroup(Enable, "GepettoElectricGearGroup")
      Wait(3)
      StopEmitters("GepettoClownMouthDust")
    elseif (activator == "switch") then
      FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_Hint4")
    end
  end
  OswaldStreamAbort()
  return 
end
FTL_FloatGraveyard_TrackClownDoors = function(target, door, action)
  if (door == "electric") then
    if (action == "open") then
      FTL_ClownDoorState01 = 1
      AnimGBSequence("ElectricArea_ClownMouth 01", "open")
      SetPropertyBool("ElectricArea_ClownMouth 01", "Start Active", true)
      Prefab_OswaldElectricSwitch_ChangeState("GepettoClownSwitch", "Reset")
    elseif (action == "close") then
      FTL_ClownDoorState01 = 0
      AnimGBSequence("ElectricArea_ClownMouth 01", "rest")
      SetPropertyBool("ElectricArea_ClownMouth 01", "Start Active", true)
      if (door == "gepetto") then
        if (action == "open") then
          FTL_ClownDoorState02 = 1
          AnimGBSequence("ElectricArea_ClownMouth 02", "open")
          SetPropertyBool("ElectricArea_ClownMouth 02", "Start Active", true)
          Prefab_OswaldElectricSwitch_ChangeState("ElectricClownSwitch", "Reset")
        elseif (action == "close") then
          FTL_ClownDoorState02 = 0
          AnimGBSequence("ElectricArea_ClownMouth 02", "rest")
          SetPropertyBool("ElectricArea_ClownMouth 02", "Start Active", true)
        end
      end
    end
  elseif (door == "gepetto") then
    if (action == "open") then
      FTL_ClownDoorState02 = 1
      AnimGBSequence("ElectricArea_ClownMouth 02", "open")
      SetPropertyBool("ElectricArea_ClownMouth 02", "Start Active", true)
      Prefab_OswaldElectricSwitch_ChangeState("ElectricClownSwitch", "Reset")
    elseif (action == "close") then
      FTL_ClownDoorState02 = 0
      AnimGBSequence("ElectricArea_ClownMouth 02", "rest")
      SetPropertyBool("ElectricArea_ClownMouth 02", "Start Active", true)
    end
  end
  return 
end
FTL_ClownGearGepetto1 = 0
FTL_ClownGearGepetto2 = 0
FTL_ClownGearElectric1 = 0
FTL_ClownGearElectric2 = 0
FTL_ClownGearOswald = 0
FTL_ClownGearStreaming = 0
FTL_FloatGraveyard_ClownDoorGears = function(target, nose, gear1, gear2, door, position, gear3, event)
  if (_G[door] == 0) then
    if (FTL_ClownGearStreaming == 0) then
      if (DamageEvent_Source(event) == GetPlayer()) then
        _G[gear1] = 1
      elseif (DamageEvent_Source(event) == GetPlayer2OrAI()) then
        _G[gear1] = 2
      end
      SetRotatorMaxSpeed(target, 255)
      if (_G[position] == 2) then
        OswaldSpinAction(gear3)
      end
      Wait(0.5)
      if (_G[gear1] ~= 1) then
      end
      FTL_ClownGearStreaming = 1
      Wait(1.5)
      FTL_FloatGraveyard_ClownDoorCheck(target, nose, "gear")
      if (FTL_ClownGearStreaming == 0) then
        _G[gear1] = 0
        SetRotatorMaxSpeed(target, 0)
      end
    end
  end
  return 
end
FTL_ClownGearElectricCheck = 0
FTL_ClownGearGepettoCheck = 0
FTL_FloatGraveyard_ClownDoorGearsPatrol = function(target, action, variable, node)
  local activator = _activator()
  if (action == "enter") then
    _G[variable] = (_G[variable] + 1)
    if (GetName(activator) == GetName(GetPlayer())) then
      SetPropertyBool(node, "ActionSpotEnabled", true)
    end
  elseif (action == "exit") then
    _G[variable] = (_G[variable] - 1)
    if (GetName(activator) == GetName(GetPlayer())) then
      SetPropertyBool(node, "ActionSpotEnabled", false)
    end
  end
  return 
end
FTL_FloatGraveyard_ClownDoorGearsHint = function()
  FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 02", "FTL_FloatGraveyard_Oswald_Hint2")
  return 
end
FTL_FloatGraveyard_BasherGeneratorBreak = function()
  DestroyEntity("BasherDrumInitial")
  Unhide("BasherDrumBroken")
  FTL_FloatGraveyard_BasherGeneratorOpen()
  return 
end
FTL_BasherGeneratorState = 0
FTL_FloatGraveyard_BasherGeneratorOpen = function()
  if (FTL_BasherGeneratorState == 1) then
    FTL_FloatGraveyard_BasherGeneratorClose()
    Wait(1)
  end
  ForceSpawn("ftl_floatgraveyard_01a_ai.BasherSpawner 01", 1)
  Wait(0.10000000149011612)
  AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_BeetleworxGenerator 01", "Open")
  AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_BeetleworxGenerator 02", "Open")
  AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_BeetleworxGeneratorLight 03", "Open")
  SetPropertyBool("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_BeetleworxGenerator 01", "Start Active", true)
  FTL_BasherGeneratorState = 1
  Wait(0.5)
  return 
end
FTL_FloatGraveyard_BasherFireworksTeleportCheck = function()
  if (1 <= GetGlobal("FTL_FloatGraveyard_BasherGenerator")) then
    FTL_FloatGraveyard_SetPatrolOswald("ftl_floatgraveyard_01a_ai.ElectricArea_BasherFireworksNode 01")
  end
  return 
end
FTL_FloatGraveyard_BasherFireworksCheck = function()
  if (DEBUG_GENERATORHEALTH == 0) then
    FTL_FloatGraveyard_ElectricStreamOswald("nothing", "ftl_floatgraveyard_01a_lightparade_art.ElectricArea_FireworksCrate 01")
  elseif (DEBUG_GENERATORHEALTH == 1) then
    FTL_FloatGraveyard_ElectricStreamOswald("nothing", "ftl_floatgraveyard_01a_lightparade_art.ElectricArea_FireworksCrate 02")
  else
    ClearNextPatrolNode(GetOswaldAI())
    OswaldStartFollowAction()
  end
  return 
end
FTL_FloatGraveyard_BasherGeneratorClose = function(target)
  if (GetGlobal("FTL_FloatGraveyard_BasherGenerator") < 1) then
    AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_BeetleworxGenerator 01", "Close")
    AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_BeetleworxGenerator 02", "Close")
    AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_BeetleworxGeneratorLight 03", "Close")
    FTL_BasherGeneratorState = 0
  end
  return 
end
FTL_FloatGraveyard_BasherGeneratorDisable = function(target, action)
  local data = GetPrefabData("BasherSpawner_SpawnerLocation")
  Disable("BuddyActionHackBasher")
  if (GetGlobal("FTL_FloatGraveyard_BasherGenerator") < 1) then
    ActivateGremlinHint("GusHintElectricThinner1")
    Prefab_BeetleworxSpawner_Base_TogglePlayerCollision("BasherSpawner_SpawnerLocation", "Off")
    data.DoorsRemainOpen = "True"
    if (action == "Hacked") then
      Prefab_BeetleworxSpawner_Base_ChangeState("BasherSpawner_SpawnerLocation", "Hacked")
      Prefab_BeetleworxSpawner_Base_Doors("BasherSpawner_SpawnerLocation", "Open")
    else
      Prefab_BeetleworxSpawner_Base_ChangeState("BasherSpawner_SpawnerLocation", "Thinned")
    end
    DestroyEntity("ftl_floatgraveyard_01a_lightparade_art.prefab_beetleworxspawner_base 01.Wind")
    FTL_FloatGraveyard_Checkpoint(nil, "electric")
  end
  return 
end
FTL_FloatGraveyard_BasherCameraTeleport = function(target, marker)
  TeleportToEntity(marker, target)
  SetParentEntity(marker, target)
  return 
end
FTL_FloatGraveyard_GeneratorHackManage = function(buddy, action)
  local variable = "none"
  local switch = "none"
  if (buddy == "BuddyActionHackTanker") then
    variable = "FTL_FloatGraveyard_TankerGenerator"
    switch = "FinalAreaSpawnerHack"
  elseif (buddy == "BuddyActionHackBasher") then
    variable = "FTL_FloatGraveyard_BasherGenerator"
    switch = "ElectricAreaSpawnerHack"
  end
  if (action == "paint") then
    if (GetGlobal(variable) < 1) then
      Enable(buddy)
      EnableComponent(switch, "Hack")
    end
  elseif (action == "thin") then
    OswaldAbortScriptedBehavior()
    DisableComponent(switch, "Hack")
    Disable(buddy)
  elseif (buddy == "electric") then
    FTL_FloatGraveyard_BasherGeneratorDisable(nil, buddy)
  elseif (buddy == "alice") then
    FTL_FloatGraveyard_TankerGeneratorDisable(nil, buddy)
  end
  return 
end
FTL_FloatGraveyard_GeneratorSwitch = function(target, variable, switch, door)
  if (_G[variable] == 0) then
    _G[variable] = 1
    AnimGBSequence(door, "opening")
    AnimGBSequence(switch, "Rise")
    Wait(1.2000000476837158)
    AnimGBSequence(switch, "Fall")
  end
  return 
end
FTL_FloatGraveyard_BasherDeath = function()
  if (GetGlobal("FTL_FloatGraveyard_BasherGenerator") < 1) then
    ClearParent("MemoriesQuestPhotoMarker")
  else
    DestroyEntity("MemoriesQuestPhotoMarker")
  end
  return 
end
FTL_GeneratorHoppersSpawned = 0
FTL_BasherSwitches = 0
FTL_BasherJunkState = 0
FTL_FloatGraveyard_BasherSwitchTeleport = function()
  if (FTL_BasherJunkState == 1) then
    FTL_FloatGraveyard_SetPatrolOswald("CentralHallway_EnterDoorNode01")
  end
  return 
end
FTL_FloatGraveyard_DisableBasherSwitches = function(target, action)
  if (action == "animation") then
    AnimGBSequence(target, "opened")
    ForEachEntityInGroup(Enable, "BasherDoorKillGroup")
    Wait(0.20000000298023224)
    ForEachEntityInGroup(Disable, "BasherDoorKillGroup")
  else
    if (GetGlobal("FTL_FloatGraveyard_BasherHallDoor") == 0) then
      AnimGBSequence("ftl_floatgraveyard_01a_basherhall_art.CentralHall_EnterDoor 01", "opening", true)
      SetPropertyBool("ftl_floatgraveyard_01a_basherhall_art.CentralHall_EnterDoor 01", "Start Active", true)
      OswaldStreamAbort()
    end
    SetGlobal("FTL_FloatGraveyard_BasherHallDoor", 1)
    FTL_BasherSwitches = 1
    ForEachEntityInGroup(Disable, "BuddyActionBasherDoor")
    ForEachEntityInGroup(Prefab_OswaldElectricSwitch_ChangeState, "BasherSwitchGroup", "Deactivate")
  end
  return 
end
FTL_FloatGraveyard_BasherSwitchesCheck = function(target, switch)
  if (FTL_BasherSwitches == 0) then
    FTL_FloatGraveyard_ElectricStreamOswald("nothing", switch)
  elseif (FTL_BasherSwitches == 1) then
    FTL_BasherSwitches = 2
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_Hint4")
    ClearNextPatrolNode(GetOswaldAI())
    OswaldStartFollowAction()
  else
    ClearNextPatrolNode(GetOswaldAI())
    OswaldStartFollowAction()
  end
  return 
end
FTL_FloatGraveyard_PopcornCartFall = function(target, step)
  if (step == "one") then
    AnimGBSequence("BasherPopcornCart", "fall", true)
    SetPropertyBool("BasherPopcornCart", "Start Active", true)
    Enable("BasherHallReviveTrigger")
  elseif (step == "two") then
    FTL_BasherJunkState = 1
    enableJumpVolumeAvailability("ftl_floatgraveyard_01a_basherhall_art.prefab_jumpvolumeavailability 01.TargetToSend")
    enableJumpVolumeAvailability("ftl_floatgraveyard_01a_basherhall_art.prefab_jumpvolumeavailability 02.TargetToSend")
  end
  return 
end
FTL_FloatGraveyard_BasherAirlockManage = function(set)
  if (GetGlobal("FTL_FloatGraveyard_BasherAirlock") == 0) then
    ForEachEntityInGroup(Enable, "BasherHallCageGroup")
    if (set == "BasherSwitchElectric") then
      ForEachEntityInGroup(Reverse, "BasherHallCageGroup")
      SetPropertyInt("BasherHallCage1Collision", "Collision Layer", 13)
      SetPropertyInt("BasherHallCage2Collision", "Collision Layer", 14)
      AnimGBSequence("BasherHallCage1", "loading")
      SetGlobal("FTL_FloatGraveyard_BasherAirlock", 1)
      FireUser2("DualSwitchHintTimer")
    elseif (set == "BasherSwitchMiddle") then
      Reverse("BasherHallCage2")
      SetPropertyInt("BasherHallCage2Collision", "Collision Layer", 14)
      AnimGBSequence("BasherHallCage2", "loading")
      ForEachEntityInGroup(StartEmitters, "CircusCageSparkGroup2")
      FireUser2("DualSwitchHintTimer")
      Disable("BasherDualSwitchHintTrigger1")
      FTL_FloatGraveyard_SetAirlockPosition(GetPlayer(), "enter", "BasherRespawnMarker")
      FTL_FloatGraveyard_SetAirlockPosition(GetPlayer2OrAI(), "enter", "BasherRespawnMarker")
      if (GetGlobal("FTL_FloatGraveyard_BasherHallDoor") == 1) then
        AnimGBSequence("BasherHallMainDoor", "closing")
      end
      Wait(3)
      AnimGBSequence("BasherHallCage1", "loading")
      ForEachEntityInGroup(StartEmitters, "CircusCageSparkGroup1")
      FTL_FloatGraveyard_DetermineStreams("electric")
      Prefab_DualSwitches_ChangeState("BasherSwitchCenter", "Reset")
      Wait(0)
      FTL_FloatGraveyard_StreamCheck()
      ForEachEntityInGroup(StopEmitters, "CircusCageSparksAll")
      DEBUG_ElectricAreaSetup()
      ForEachEntityInGroup(Hide, "BasherAirlockShamGroup")
      if (GetGlobal("FTL_FloatGraveyard_BasherHallDoor") == 1) then
        AnimGBSequence("BasherHallMainDoor", "opening")
      end
      SetGlobal("FTL_FloatGraveyard_BasherAirlock", 1)
      Reverse("BasherHallCage1")
      SetPropertyInt("BasherHallCage1Collision", "Collision Layer", 13)
      AnimGBSequence("BasherHallCage2", "rest")
      Wait(2)
      Prefab_DualSwitches_ChangeState("BasherSwitchMiddle", "Reset")
      Enable("BasherDualSwitchHintTrigger1")
    elseif (set == "BasherSwitchCenter") then
      Wait(2)
      Prefab_DualSwitches_ChangeState("BasherSwitchCenter", "Reset")
      if (GetGlobal("FTL_FloatGraveyard_BasherAirlock") == 1) then
        if (set == "BasherSwitchElectric") then
          Wait(2)
          Prefab_DualSwitches_ChangeState("BasherSwitchElectric", "Reset")
        elseif (set == "BasherSwitchMiddle") then
          ForEachEntityInGroup(Unhide, "BasherAirlockShamGroup")
          Reverse("BasherHallCage1")
          SetPropertyInt("BasherHallCage1Collision", "Collision Layer", 14)
          AnimGBSequence("BasherHallCage1", "loading")
          ForEachEntityInGroup(StartEmitters, "CircusCageSparkGroup1")
          FireUser2("DualSwitchHintTimer")
          Disable("BasherDualSwitchHintTrigger1")
          FTL_FloatGraveyard_SetAirlockPosition(GetPlayer(), "enter", "BasherRespawnMarker")
          FTL_FloatGraveyard_SetAirlockPosition(GetPlayer2OrAI(), "enter", "BasherRespawnMarker")
          if (GetGlobal("FTL_FloatGraveyard_BasherHallDoor") == 1) then
            AnimGBSequence("BasherHallMainDoor", "closing")
          end
          Wait(3)
          AnimGBSequence("BasherHallCage2", "loading")
          ForEachEntityInGroup(StartEmitters, "CircusCageSparkGroup1")
          FTL_FloatGraveyard_DetermineStreams("gepetto")
          Prefab_DualSwitches_ChangeState("BasherSwitchElectric", "Reset")
          Wait(0)
          FTL_FloatGraveyard_StreamCheck()
          ForEachEntityInGroup(StopEmitters, "CircusCageSparksAll")
          DEBUG_CenterAreaSetup()
          SetGlobal("FTL_FloatGraveyard_BasherAirlock", 0)
          if (GetGlobal("FTL_FloatGraveyard_BasherHallDoor") == 1) then
            AnimGBSequence("BasherHallMainDoor", "opening")
          end
          Reverse("BasherHallCage2")
          SetPropertyInt("BasherHallCage2Collision", "Collision Layer", 13)
          AnimGBSequence("BasherHallCage1", "rest")
          Wait(2)
          Prefab_DualSwitches_ChangeState("BasherSwitchMiddle", "Reset")
          Enable("BasherDualSwitchHintTrigger1")
        elseif (set == "BasherSwitchCenter") then
          ForEachEntityInGroup(Reverse, "BasherHallCageGroup")
          SetPropertyInt("BasherHallCage1Collision", "Collision Layer", 14)
          SetPropertyInt("BasherHallCage2Collision", "Collision Layer", 13)
          AnimGBSequence("BasherHallCage2", "loading")
          SetGlobal("FTL_FloatGraveyard_BasherAirlock", 0)
          FireUser2("DualSwitchHintTimer")
        end
      end
    end
  end
  if (GetGlobal("FTL_FloatGraveyard_BasherAirlock") == 1) then
    if (set == "BasherSwitchElectric") then
      Wait(2)
      Prefab_DualSwitches_ChangeState("BasherSwitchElectric", "Reset")
    elseif (set == "BasherSwitchMiddle") then
      ForEachEntityInGroup(Unhide, "BasherAirlockShamGroup")
      Reverse("BasherHallCage1")
      SetPropertyInt("BasherHallCage1Collision", "Collision Layer", 14)
      AnimGBSequence("BasherHallCage1", "loading")
      ForEachEntityInGroup(StartEmitters, "CircusCageSparkGroup1")
      FireUser2("DualSwitchHintTimer")
      Disable("BasherDualSwitchHintTrigger1")
      FTL_FloatGraveyard_SetAirlockPosition(GetPlayer(), "enter", "BasherRespawnMarker")
      FTL_FloatGraveyard_SetAirlockPosition(GetPlayer2OrAI(), "enter", "BasherRespawnMarker")
      if (GetGlobal("FTL_FloatGraveyard_BasherHallDoor") == 1) then
        AnimGBSequence("BasherHallMainDoor", "closing")
      end
      Wait(3)
      AnimGBSequence("BasherHallCage2", "loading")
      ForEachEntityInGroup(StartEmitters, "CircusCageSparkGroup1")
      FTL_FloatGraveyard_DetermineStreams("gepetto")
      Prefab_DualSwitches_ChangeState("BasherSwitchElectric", "Reset")
      Wait(0)
      FTL_FloatGraveyard_StreamCheck()
      ForEachEntityInGroup(StopEmitters, "CircusCageSparksAll")
      DEBUG_CenterAreaSetup()
      SetGlobal("FTL_FloatGraveyard_BasherAirlock", 0)
      if (GetGlobal("FTL_FloatGraveyard_BasherHallDoor") == 1) then
        AnimGBSequence("BasherHallMainDoor", "opening")
      end
      Reverse("BasherHallCage2")
      SetPropertyInt("BasherHallCage2Collision", "Collision Layer", 13)
      AnimGBSequence("BasherHallCage1", "rest")
      Wait(2)
      Prefab_DualSwitches_ChangeState("BasherSwitchMiddle", "Reset")
      Enable("BasherDualSwitchHintTrigger1")
    elseif (set == "BasherSwitchCenter") then
      ForEachEntityInGroup(Reverse, "BasherHallCageGroup")
      SetPropertyInt("BasherHallCage1Collision", "Collision Layer", 14)
      SetPropertyInt("BasherHallCage2Collision", "Collision Layer", 13)
      AnimGBSequence("BasherHallCage2", "loading")
      SetGlobal("FTL_FloatGraveyard_BasherAirlock", 0)
      FireUser2("DualSwitchHintTimer")
    end
  end
  return 
end
FTL_FloatGraveyard_BasherAirlockHintManage = function(target, action, airlock)
  if (action == "enter") then
    if (GetGlobal("FTL_FloatGraveyard_BasherAirlock") == tonumber(airlock)) then
      FireUser1("DualSwitchHintTimer")
      if (action == "exit") then
        FireUser2("DualSwitchHintTimer")
      end
    end
  elseif (action == "exit") then
    FireUser2("DualSwitchHintTimer")
  end
  return 
end
FTL_ClownNoseState01 = 0
FTL_ClownNoseState02 = 0
FTL_ClownNoseState03 = 0
FTL_FloatGraveyard_ClownNoseManage = function(target, action, nose, marker, receptor, mouth, variable, anim)
  if (_G[nose] < 2) then
    if (action == "painted") then
      _G[nose] = 0
      Disable(marker)
      OswaldStreamAbort()
    elseif (action == "thinned") then
      _G[nose] = 1
      if (GetGlobal("FTL_FloatGraveyard_ClownAirlock") ~= tonumber(receptor)) then
        Enable(marker)
      end
    elseif (action == "oswald") then
      ClearNextPatrolNode(GetOswaldAI())
      if (_G[nose] == 1) then
        if (_G[variable] == 0) then
          OswaldStreamAction(receptor)
        end
      else
        if (_G[nose] == 1) then
          FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_Hint4")
        else
          FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 02", "FTL_FloatGraveyard_Oswald_DoWhat")
        end
        ClearNextPatrolNode(GetOswaldAI())
        OswaldStartFollowAction()
        ClearNextPatrolNode(GetOswaldAI())
        OswaldStartFollowAction()
      end
    end
  else
    ClearNextPatrolNode(GetOswaldAI())
    OswaldStartFollowAction()
  end
  return 
end
FTL_FloatGraveyard_EnableSteamJets = function()
  if (GetGlobal("FTL_FloatGraveyard_ThinnerJetState2") < 2) then
    FireUser1("ClownHallThinnerJet1")
  end
  Wait(7.5)
  if (GetGlobal("FTL_FloatGraveyard_ThinnerJetState1") < 2) then
    FireUser1("ClownHallThinnerJet2")
  end
  return 
end
FTL_FloatGraveyard_CloseSteamJets = function(target, action, variable, shutter, jet)
  if (GetGlobal(variable) < 2) then
    if (action == "paint") then
      SetGlobal(variable, (GetGlobal(variable) - 1))
    elseif (action == "thin") then
      SetGlobal(variable, (GetGlobal(variable) + 1))
      if (GetGlobal(variable) == 2) then
        AnimGBSequence(shutter, "close", true)
        SetPropertyBool(shutter, "Start Active", true)
        FireUser2(jet)
      end
    end
  end
  return 
end
FTL_FloatGraveyard_StopSteamJets = function(target, volume)
  ForEachEntityInPrefab(DestroyEntity, volume)
  return 
end
FTL_FloatGraveyard_JollyRogerCamera = function(target, action)
  if (action == "enable") then
    SetCameraAttributesForPlayer("ElectricArea_JollyRogerCamera 01", _activator())
  elseif (action == "disable") then
    ClearCameraAttributesForPlayer("ElectricArea_JollyRogerCamera 01", _activator())
  end
  return 
end
FTL_FloatGraveyard_BasherDrumCheck = function()
  if (GetGlobal("FTL_FloatGraveyard_BasherGenerator") < 0) then
    if (0 < GetGlobal("FTL_FloatGraveyard_IntroIGC")) then
      if IsValidHandle("ElectricDrumBreakFX") then
        local data = GetPrefabData("BasherSpawner_SpawnerLocation")
        SetGlobal("FTL_FloatGraveyard_BasherGenerator", 0)
        StartEmitters("ElectricDrumBreakFX")
        data.SpawnerActive = "True"
        Wait(0.20000000298023224)
        DestroyEntity("BasherDrumInitial")
        Unhide("BasherDrumBroken")
        FireThread(Prefab_BeetleworxSpawner_Base_Spawn, "BasherSpawner_SpawnerLocation")
        Wait(1.7999999523162842)
        StopEmitters("ElectricDrumBreakFX")
      end
    end
  end
  return 
end
FTL_FloatGraveyard_ShipMastFall = function(target, action)
  if (action == "thin") then
    AnimGBSequence("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_JollyRogerMast 01", "fall", true)
    SetPropertyBool("ftl_floatgraveyard_01a_lightparade_art.ElectricArea_JollyRogerMast 01", "Start Active", true)
    SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") - 2))
  elseif (action == "fall") then
    AnimGBSequence(target, "fallRest")
    disableJumpVolumeAvailability("ftl_floatgraveyard_01a_lightparade_art.prefab_jumpvolumeavailability 01.TargetToSend")
    enableJumpVolumeAvailability("ftl_floatgraveyard_01a_lightparade_art.prefab_jumpvolumeavailability 02.TargetToSend")
    enableJumpVolumeAvailability("ftl_floatgraveyard_01a_lightparade_art.prefab_jumpvolumeavailability 03.TargetToSend")
    StartEmitters("PirateMastDustFX")
    Wait(3.5)
    StopEmitters("PirateMastDustFX")
  end
  return 
end
FTL_FloatGraveyard_DynamicObjectFade = function(target)
  local a = 1
  local (for index), (for limit), (for step) = 1, 0, -0.05000000074505806
  for a = (for index), (for limit), (for step) do
    SetR3MTConstRegAlpha(target, 3, a)
    Wait(0.05000000074505806)
  end
  Wait(0.5)
  DestroyEntity(target)
  return 
end
FTL_ShipAirlock1 = 0
FTL_ShipAirlock2 = 0
FTL_ShipHandle1 = 0
FTL_ShipHandle2 = 0
FTL_FloatGraveyard_ShipAirlock = function(target, variable, door, hack, buddy, object, action)
  if (object == "handle") then
    if (action == "pull") then
      _G[("FTL_ShipHandle" .. tostring(variable))] = 1
      if (hack ~= "AirlockReprogram1") then
        if (hack == "AirlockReprogram2") then
          if (GetGlobal("FTL_FloatGraveyard_ShipAirlock") == 11) then
            if (_G[("FTL_ShipAirlock" .. tostring(variable))] == 0) then
              FTL_FloatGraveyard_ShipAirlockCheck(target, variable, door, hack, buddy, action)
              if (action == "release") then
                _G[("FTL_ShipHandle" .. tostring(variable))] = 0
                if (hack ~= "AirlockReprogram1") then
                  if (hack == "AirlockReprogram2") then
                    if (GetGlobal("FTL_FloatGraveyard_ShipAirlock") == 11) then
                      if (_G[("FTL_ShipAirlock" .. tostring(variable))] == 1) then
                        FTL_FloatGraveyard_ShipAirlockCheck(target, variable, door, hack, buddy, action)
                        if (target == "buddyAction") then
                          OswaldHackAction(variable)
                        elseif (target == "1") then
                          _G[("FTL_ShipAirlock" .. tostring(target))] = 2
                          ForEachEntityInGroup(DisableComponent, ("ShipAirlockScreen" .. tostring(target)), "Hack")
                          ForEachEntityInGroup(Disable, ("ShipAirlockGroup" .. tostring(target)))
                          FTL_FloatGraveyard_SetCriticalPath(nil, "4a")
                          Wait(4)
                          FTL_FloatGraveyard_ShipAirlockCheck(nil, target, ("ShipAirlockDoor" .. tostring(target)))
                        end
                      end
                    end
                  end
                end
                if (_G[("FTL_ShipAirlock" .. tostring(variable))] == 1) then
                  FTL_FloatGraveyard_ShipAirlockCheck(target, variable, door, hack, buddy, action)
                  if (target == "buddyAction") then
                    OswaldHackAction(variable)
                  elseif (target == "1") then
                    _G[("FTL_ShipAirlock" .. tostring(target))] = 2
                    ForEachEntityInGroup(DisableComponent, ("ShipAirlockScreen" .. tostring(target)), "Hack")
                    ForEachEntityInGroup(Disable, ("ShipAirlockGroup" .. tostring(target)))
                    FTL_FloatGraveyard_SetCriticalPath(nil, "4a")
                    Wait(4)
                    FTL_FloatGraveyard_ShipAirlockCheck(nil, target, ("ShipAirlockDoor" .. tostring(target)))
                  end
                end
              end
            end
          end
        end
      end
      if (_G[("FTL_ShipAirlock" .. tostring(variable))] == 0) then
        FTL_FloatGraveyard_ShipAirlockCheck(target, variable, door, hack, buddy, action)
      end
    elseif (action == "release") then
      _G[("FTL_ShipHandle" .. tostring(variable))] = 0
      if (hack ~= "AirlockReprogram1") then
        if (hack == "AirlockReprogram2") then
          if (GetGlobal("FTL_FloatGraveyard_ShipAirlock") == 11) then
            if (_G[("FTL_ShipAirlock" .. tostring(variable))] == 1) then
              FTL_FloatGraveyard_ShipAirlockCheck(target, variable, door, hack, buddy, action)
              if (target == "buddyAction") then
                OswaldHackAction(variable)
              elseif (target == "1") then
                _G[("FTL_ShipAirlock" .. tostring(target))] = 2
                ForEachEntityInGroup(DisableComponent, ("ShipAirlockScreen" .. tostring(target)), "Hack")
                ForEachEntityInGroup(Disable, ("ShipAirlockGroup" .. tostring(target)))
                FTL_FloatGraveyard_SetCriticalPath(nil, "4a")
                Wait(4)
                FTL_FloatGraveyard_ShipAirlockCheck(nil, target, ("ShipAirlockDoor" .. tostring(target)))
              end
            end
          end
        end
      end
      if (_G[("FTL_ShipAirlock" .. tostring(variable))] == 1) then
        FTL_FloatGraveyard_ShipAirlockCheck(target, variable, door, hack, buddy, action)
        if (target == "buddyAction") then
          OswaldHackAction(variable)
        elseif (target == "1") then
          _G[("FTL_ShipAirlock" .. tostring(target))] = 2
          ForEachEntityInGroup(DisableComponent, ("ShipAirlockScreen" .. tostring(target)), "Hack")
          ForEachEntityInGroup(Disable, ("ShipAirlockGroup" .. tostring(target)))
          FTL_FloatGraveyard_SetCriticalPath(nil, "4a")
          Wait(4)
          FTL_FloatGraveyard_ShipAirlockCheck(nil, target, ("ShipAirlockDoor" .. tostring(target)))
        end
      end
    end
  elseif (target == "buddyAction") then
    OswaldHackAction(variable)
  elseif (target == "1") then
    _G[("FTL_ShipAirlock" .. tostring(target))] = 2
    ForEachEntityInGroup(DisableComponent, ("ShipAirlockScreen" .. tostring(target)), "Hack")
    ForEachEntityInGroup(Disable, ("ShipAirlockGroup" .. tostring(target)))
    FTL_FloatGraveyard_SetCriticalPath(nil, "4a")
    Wait(4)
    FTL_FloatGraveyard_ShipAirlockCheck(nil, target, ("ShipAirlockDoor" .. tostring(target)))
  end
  return 
end
FTL_FloatGraveyard_ShipAirlockCheck = function(target, variable, door, hack, buddy, action)
  if (action == "anim") then
    if (_G[("FTL_ShipAirlock" .. tostring(variable))] == 0) then
      _G[("FTL_ShipAirlock" .. tostring(variable))] = 1
    elseif (_G[("FTL_ShipAirlock" .. tostring(variable))] == 1) then
      _G[("FTL_ShipAirlock" .. tostring(variable))] = 0
    end
    if (_G[("FTL_ShipHandle" .. tostring(variable))] == 0) then
      if (_G[("FTL_ShipAirlock" .. tostring(variable))] == 1) then
        AnimGBSequence(door, "small close", true)
        ForEachEntityInGroup(DisableComponent, hack, "Hack")
        ForEachEntityInGroup(Disable, buddy)
        OswaldAbortScriptedBehavior()
      end
    elseif (_G[("FTL_ShipHandle" .. tostring(variable))] == 1) then
      if (_G[("FTL_ShipAirlock" .. tostring(variable))] == 0) then
        AnimGBSequence(door, "small open", true)
        ForEachEntityInGroup(EnableComponent, hack, "Hack")
        ForEachEntityInGroup(Reprogram_ChangeState, hack, "activate")
        ForEachEntityInGroup(Enable, buddy)
      end
    end
    if (_G[("FTL_ShipAirlock" .. tostring(variable))] == 3) then
      if (GetGlobal("FTL_FloatGraveyard_ShipAirlock") == 11) then
        if (variable == "1") then
          SetGlobal("FTL_FloatGraveyard_ShipAirlock", (GetGlobal("FTL_FloatGraveyard_ShipAirlock") - 10))
          FTL_ShipAirlock1 = 4
          FireThread(FTL_FloatGraveyard_ShipAirlockFX, "1", "fire")
        elseif (variable == "2") then
          SetGlobal("FTL_FloatGraveyard_ShipAirlock", (GetGlobal("FTL_FloatGraveyard_ShipAirlock") - 1))
          FTL_ShipAirlock2 = 4
          FireThread(FTL_FloatGraveyard_ShipAirlockFX, "2", "fire")
        end
        AnimGBSequence(door, "big open")
      else
        AnimGBSequence(door, "rumble")
        if (variable == "1") then
          AnimGBSequence("ShipAirlockDoor2", "big close")
          StartEmitters("ShipAirlockDust1_High")
          FTL_FloatGraveyard_ShipAirlockFX("2")
        elseif (variable == "2") then
          AnimGBSequence("ShipAirlockDoor1", "big close")
          StartEmitters("ShipAirlockDust2_High")
          FTL_FloatGraveyard_ShipAirlockFX("1")
        end
        if (LevelManager_GetCurrentState() == "ftl_floatgraveyard.a1_v1") then
          if (GetGlobal("FTL_FloatGraveyard_ShipAirlock") == 1) then
            FTL_FloatGraveyard_DetermineStreams("gepetto")
          elseif (LevelManager_GetCurrentState() == "ftl_floatgraveyard.a2_v1") then
            if (GetGlobal("FTL_FloatGraveyard_ShipAirlock") == 10) then
              FTL_FloatGraveyard_DetermineStreams("electric")
            end
          end
        end
        if (LevelManager_GetCurrentState() == "ftl_floatgraveyard.a2_v1") then
          if (GetGlobal("FTL_FloatGraveyard_ShipAirlock") == 10) then
            FTL_FloatGraveyard_DetermineStreams("electric")
          end
        end
        FTL_FloatGraveyard_StreamCheck()
        if (variable == "1") then
          FTL_ShipAirlock1 = 4
          FTL_ShipAirlock2 = 0
          SetGlobal("FTL_FloatGraveyard_ShipAirlock", 1)
          ForEachEntityInGroup(Hide, "BasherAirlockShamGroup")
          DEBUG_ElectricAreaSetup()
          FireThread(FTL_FloatGraveyard_ShipAirlockFX, "1", "fire")
        elseif (variable == "2") then
          FTL_ShipAirlock1 = 0
          FTL_ShipAirlock2 = 4
          SetGlobal("FTL_FloatGraveyard_ShipAirlock", 10)
          ForEachEntityInGroup(Unhide, "BasherAirlockShamGroup")
          DEBUG_CenterAreaSetup()
          FireThread(FTL_FloatGraveyard_ShipAirlockFX, "2", "fire")
        end
        AnimGBSequence(door, "big open")
        if (_G[("FTL_ShipAirlock" .. tostring(variable))] == 2) then
          _G[("FTL_ShipAirlock" .. tostring(variable))] = 3
          AnimGBSequence(door, "small close", true)
        elseif (_G[("FTL_ShipHandle" .. tostring(variable))] == 0) then
          AnimGBSequence(door, "small close", true)
          ForEachEntityInGroup(DisableComponent, hack, "Hack")
          ForEachEntityInGroup(Disable, buddy)
          OswaldAbortScriptedBehavior()
        elseif (_G[("FTL_ShipHandle" .. tostring(variable))] == 1) then
          AnimGBSequence(door, "small open", true)
          ForEachEntityInGroup(EnableComponent, hack, "Hack")
          ForEachEntityInGroup(Reprogram_ChangeState, hack, "activate")
          ForEachEntityInGroup(Enable, buddy)
        end
      end
    end
  elseif (_G[("FTL_ShipAirlock" .. tostring(variable))] == 2) then
    _G[("FTL_ShipAirlock" .. tostring(variable))] = 3
    AnimGBSequence(door, "small close", true)
  elseif (_G[("FTL_ShipHandle" .. tostring(variable))] == 0) then
    AnimGBSequence(door, "small close", true)
    ForEachEntityInGroup(DisableComponent, hack, "Hack")
    ForEachEntityInGroup(Disable, buddy)
    OswaldAbortScriptedBehavior()
  elseif (_G[("FTL_ShipHandle" .. tostring(variable))] == 1) then
    AnimGBSequence(door, "small open", true)
    ForEachEntityInGroup(EnableComponent, hack, "Hack")
    ForEachEntityInGroup(Reprogram_ChangeState, hack, "activate")
    ForEachEntityInGroup(Enable, buddy)
  end
  return 
end
FTL_FloatGraveyard_ShipAirlockFX = function(door, command)
  if (command ~= "fire") then
    Wait(2.700000047683716)
  end
  ForEachEntityInGroup(StartEmitters, (("ShipAirlockDust" .. tostring(door)) .. "_Group"))
  Wait(1)
  ForEachEntityInGroup(StopEmitters, (("ShipAirlockDust" .. tostring(door)) .. "_Group"))
  return 
end
FTL_FloatGraveyard_ShipAirlockAnimManage = function(target, check)
  if (target == "airlock") then
    if (GetGlobal("FTL_FloatGraveyard_ShipAirlock") == 1) then
      AnimGBSequence("ShipAirlockDoor1", "big rest up")
    elseif (GetGlobal("FTL_FloatGraveyard_ShipAirlock") == 10) then
      AnimGBSequence("ShipAirlockDoor2", "big rest up")
      if (GetGlobal("FTL_FloatGraveyard_ShipAirlock") == tonumber(check)) then
        AnimGBSequence(target, "big rest up")
      end
    end
  elseif (GetGlobal("FTL_FloatGraveyard_ShipAirlock") == tonumber(check)) then
    AnimGBSequence(target, "big rest up")
  end
  return 
end
FTL_FloatGraveyard_PlayDrumVFX = function(target)
  StartEmitters(target)
  Wait(1.5)
  StopEmitters(target)
  return 
end
FTL_FloatGraveyard_GepettoAreaSetup = function()
  return 
end
FTL_FloatGraveyard_ExitClownHall01 = function(target, direction)
  if (direction == "backward") then
    ClearAllCameraAttributes(target)
    if (GetNumPlayers() == 1) then
      FTL_OswaldStreamArea = 9
    end
  elseif (direction == "forward") then
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_Drums")
    if (GetNumPlayers() == 1) then
      FTL_OswaldStreamArea = 2
    end
    Wait(0.30000001192092896)
    SetCameraAttributes(target)
  end
  return 
end
FTL_FloatGraveyard_BreakLeg = function(target, foot, door, hack, spark, buddy)
  local before = 0
  local after = 0
  after = --[[ return 2 of ]] Jigsaw_GetPercentagePainted(target)
  before = Jigsaw_GetPercentagePainted(target)
  if (after == 0) then
    if (foot == "FloatArea_GepettoLegLeft 01") then
      SetGlobal("FTL_FloatYardGepettoFoot", 1)
      AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoLegLeft 01", "fall", true)
      AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoLegLeft 03", "fall")
    end
    if (buddy == "BuddyActionLeftHack") then
      if (GetGlobal("FTL_FloatGraveyard_StromboliHack") == 1) then
        Enable(hack)
        Enable(buddy)
      end
    elseif (buddy == "BuddyActionRightHack") then
      if (GetGlobal("FTL_FloatGraveyard_StromboliHack") == 10) then
        Enable(hack)
        Enable(buddy)
        if (0 < after) then
          Disable(hack)
          Disable(buddy)
        end
      end
    end
  elseif (0 < after) then
    Disable(hack)
    Disable(buddy)
  end
  if (foot == "destroy") then
    DestroyEntity("FloatArea_GepettoLegLeft 01")
    DestroyEntity("ftl_floatgraveyard_01a_art.FloatArea_GepettoLegLeft 03")
    DestroyEntity("GepettoLegTicket")
  end
  return 
end
FTL_GepettoHackOpen01 = 0
FTL_GepettoHackOpen02 = 0
FTL_FloatGraveyard_OpenLeg = function(target, buddy)
  AnimGBSequence(target, "opening", true)
  SetPropertyBool(target, "Start Active", true)
  if (buddy == "BuddyActionLeftHack") then
    SetGlobal("FTL_FloatGraveyard_StromboliHack", (GetGlobal("FTL_FloatGraveyard_StromboliHack") + 1))
    Enable("BuddyHackManageLeft")
    Enable("FloatArea_GepettoLegLeftHack 01")
  elseif (buddy == "BuddyActionRightHack") then
    SetGlobal("FTL_FloatGraveyard_StromboliHack", (GetGlobal("FTL_FloatGraveyard_StromboliHack") + 10))
    Enable("BuddyHackManageRight")
    Enable("FloatArea_GepettoLegRightHack 01")
  end
  Enable(buddy)
  return 
end
FTL_FloatGraveyard_HackCheck = function(target, variable, hack, panel)
  if (_G[variable] == 1) then
    if (_G[panel] == 0) then
      OswaldHackAction(hack)
    else
      ClearNextPatrolNode(GetOswaldAI())
      OswaldStartFollowAction()
      FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 02", "FTL_FloatGraveyard_Oswald_DoWhat")
      ClearNextPatrolNode(GetOswaldAI())
      OswaldStartFollowAction()
    end
  else
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 02", "FTL_FloatGraveyard_Oswald_DoWhat")
    ClearNextPatrolNode(GetOswaldAI())
    OswaldStartFollowAction()
  end
  return 
end
FTL_FloatGraveyard_HackLegManage = function(target, action)
  if (action == "enter") then
    Disable("BuddyActionGepettoPlate")
  elseif (action == "exit") then
    if (GetGlobal("FTL_FloatGraveyard_StromboliArm") ~= 22) then
      if (GetGlobal("FTL_FloatGraveyard_StromboliHack") ~= 22) then
        Enable("BuddyActionGepettoPlate")
      end
    end
  end
  return 
end
FTL_FloatGraveyard_HackLeg = function(buddy)
  local sparks = "none"
  local switch = "none"
  local trigger = "none"
  if (buddy == "BuddyActionLeftHack") then
    SetGlobal("FTL_FloatGraveyard_StromboliHack", (GetGlobal("FTL_FloatGraveyard_StromboliHack") + 1))
    sparks = "GepettoLeftLegSparks"
    switch = "FloatArea_GepettoLegLeftHack 01"
    trigger = "BuddyHackManageLeft"
  elseif (buddy == "BuddyActionRightHack") then
    SetGlobal("FTL_FloatGraveyard_StromboliHack", (GetGlobal("FTL_FloatGraveyard_StromboliHack") + 10))
    sparks = "GepettoRightLegSparks"
    switch = "FloatArea_GepettoLegRightHack 01"
    trigger = "BuddyHackManageRight"
  end
  DisableComponent(switch, "Hack")
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  StartEmitters(sparks)
  Disable(buddy)
  if (GetGlobal("FTL_FloatGraveyard_StromboliHack") == 12) then
    AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoChest 01", "rumble")
    Disable(trigger)
    if (GetGlobal("FTL_FloatGraveyard_StromboliArm") ~= 22) then
      if (GetGlobal("FTL_FloatGraveyard_StromboliHack") ~= 22) then
        Enable("BuddyActionGepettoPlate")
      end
    end
    if (FTL_GepettoDoor == 0) then
      if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") ~= 1) then
        AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoChest 02", "rumble")
      end
    end
  end
  if (GetGlobal("FTL_FloatGraveyard_StromboliHack") == 22) then
    if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 1) then
      AudioPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Stromboli", "WindDown_MX_FGY_Stromboli")
      FTL_FadeIn2DMusicDelayed()
      Print("Stromboli float had been fixed, Play Stromboli broken music WindDown, start 2D music")
    else
      AudioPostEventOn(GetPlayer(), "Stop_MX_FGY")
      AudioPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Stromboli", "WindUpDown_MX_FGY_Stromboli")
      Print("Stromboli float had not been fixed, interrupt 2D music, play Stromboli broken music WindUpDown, resume 2D music")
    end
    if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 1) then
      SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") - 20))
    elseif (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 0) then
      SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") - 15))
    else
      SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") - 10))
    end
    SetGlobal("FTL_FloatGraveyard_GepettoFloat", 2)
    Disable("BuddyActionGepettoPlate")
    Disable(trigger)
    Print(("Music - FTL_FloatGraveyard_GepettoFloat = " .. tostring(GetGlobal("FTL_FloatGraveyard_GepettoFloat"))))
    FireUser2("HintGepettoArea")
    AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoChest 01", "break", true)
    StartEmitters("GepettoChestFX")
    ActivateNavMeshObstacle("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoChest 01", false)
    TimerEnable("ftl_floatgraveyard_01a_chesthall_art.FloatArea_PipeTimer 01")
    ForEachEntityInGroup(DestroyEntity, "GepettoFloatGear")
    enableJumpVolumeAvailability("ftl_floatgraveyard_01a_gepetto_art.prefab_jumpvolumeavailability 08.TargetToSend")
    DestroyEntity("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoChest 02")
    ActivateGremlinHint("GusHintGepettoThinner1")
    FTL_FloatGraveyard_Checkpoint(nil, "gepetto")
    Wait(2)
    StopEmitters("GepettoChestFX")
  end
  return 
end
FTL_GepettoArmsPosition = 0
FTL_FloatGraveyard_GepettoArmMove = function()
  local global = "FTL_FloatGraveyard_StromboliArm"
  if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") < 2) then
    if (FTL_GepettoArmsPosition == 1) then
      FTL_GepettoArmsPosition = 2
      if (20 <= GetGlobal(global)) then
        if (GetGlobal(global) <= 22) then
          AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "Pos1ToPos2")
          SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "Start Active", true)
        end
      end
      if (GetGlobal(global) == 2) then
        AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "Pos1ToPos2")
        SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "Start Active", true)
        if (FTL_GepettoArmsPosition == 2) then
          FTL_GepettoArmsPosition = 1
          if (20 <= GetGlobal(global)) then
            if (GetGlobal(global) <= 22) then
              AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "Pos2ToPos1")
              SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "Start Active", true)
            end
          end
          if (GetGlobal(global) == 2) then
            AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "Pos2ToPos1")
            SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "Start Active", true)
            if (FTL_GepettoArmsPosition == 0) then
              FTL_GepettoArmsPosition = 1
              if (20 <= GetGlobal(global)) then
                if (GetGlobal(global) <= 22) then
                  AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "RestToPos1")
                  SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "Start Active", true)
                end
              end
              if (GetGlobal(global) == 2) then
                AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "RestToPos1")
                SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "Start Active", true)
              end
            end
          end
        elseif (FTL_GepettoArmsPosition == 0) then
          FTL_GepettoArmsPosition = 1
          if (20 <= GetGlobal(global)) then
            if (GetGlobal(global) <= 22) then
              AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "RestToPos1")
              SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "Start Active", true)
            end
          end
          if (GetGlobal(global) == 2) then
            AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "RestToPos1")
            SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "Start Active", true)
          end
        end
      end
    elseif (FTL_GepettoArmsPosition == 2) then
      FTL_GepettoArmsPosition = 1
      if (20 <= GetGlobal(global)) then
        if (GetGlobal(global) <= 22) then
          AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "Pos2ToPos1")
          SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "Start Active", true)
        end
      end
      if (GetGlobal(global) == 2) then
        AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "Pos2ToPos1")
        SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "Start Active", true)
        if (FTL_GepettoArmsPosition == 0) then
          FTL_GepettoArmsPosition = 1
          if (20 <= GetGlobal(global)) then
            if (GetGlobal(global) <= 22) then
              AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "RestToPos1")
              SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "Start Active", true)
            end
          end
          if (GetGlobal(global) == 2) then
            AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "RestToPos1")
            SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "Start Active", true)
          end
        end
      end
    elseif (FTL_GepettoArmsPosition == 0) then
      FTL_GepettoArmsPosition = 1
      if (20 <= GetGlobal(global)) then
        if (GetGlobal(global) <= 22) then
          AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "RestToPos1")
          SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmLeft 01", "Start Active", true)
        end
      end
      if (GetGlobal(global) == 2) then
        AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "RestToPos1")
        SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoArmRight 01", "Start Active", true)
      end
    end
  end
  return 
end
FTL_GepettoDoor = 0
FTL_GepettoPlate = 0
FTL_FloatGraveyard_GepettoDoorCheck = function(target, action)
  if (action == "enter") then
    FTL_GepettoDoor = (FTL_GepettoDoor + 1)
  elseif (action == "exit") then
    FTL_GepettoDoor = (FTL_GepettoDoor - 1)
    if (FTL_GepettoDoor == 0) then
      if (FTL_GepettoPlate == 0) then
        if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") < 1) then
          AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoChest 02", "closing")
          disableJumpVolumeAvailability("ftl_floatgraveyard_01a_gepetto_art.prefab_jumpvolumeavailability 08.TargetToSend")
        end
      end
    end
  end
  return 
end
FTL_FloatGraveyard_GepettoPressurePlate = function(target, direction)
  if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") < 2) then
    if (direction == "down") then
      AudioPostEventOn(GetPlayer(), "Play_sfx_PressurePlateDown")
      FTL_GepettoPlate = 1
      AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoChest 02", "opening")
      SetPropertyBool("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoChest 02", "Start Active", true)
      enableJumpVolumeAvailability("ftl_floatgraveyard_01a_gepetto_art.prefab_jumpvolumeavailability 08.TargetToSend")
      ForceSpawn("PressurePlateSparkSpawner", 1)
    elseif (direction == "up") then
      AudioPostEventOn(GetPlayer(), "Play_sfx_PressurePlateUp")
      FTL_GepettoPlate = 0
      if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") < 1) then
        if (FTL_GepettoDoor == 0) then
          AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.FloatArea_GepettoChest 02", "closing")
          disableJumpVolumeAvailability("ftl_floatgraveyard_01a_gepetto_art.prefab_jumpvolumeavailability 08.TargetToSend")
        end
      end
      if (GetGlobal("FTL_FloatGraveyard_StromboliArm") ~= 22) then
        ClearNextPatrolNode(GetOswaldAI())
        Wait(0.10000000149011612)
        OswaldStartFollowAction()
      end
    elseif (direction == "activate") then
      if (GetGlobal("FTL_FloatGraveyard_StromboliHack") ~= 22) then
        Enable("BuddyActionGepettoPlate")
        DestroyEntity(target)
      end
    end
  end
  return 
end
FTL_FloatGraveyard_GepettoPressurePlateCheck = function()
  if (GetGlobal("FTL_FloatGraveyard_StromboliArm") ~= 22) then
    Print("Don't move Oswald")
  else
    ClearNextPatrolNode(GetOswaldAI())
    OswaldStartFollowAction()
  end
  return 
end
FTL_GepettoSaveCheck = 0
FTL_FloatGraveyard_GepettoGearSwap = function(target, action, gear)
  local global = "FTL_FloatGraveyard_StromboliArm"
  if (action == "painted") then
    TimerEnable("ftl_floatgraveyard_01a_gepetto_scripting.FloatArea_GepettoArmLogicTimer 01")
    Enable(target)
    enableJumpVolumeAvailability("ftl_floatgraveyard_01a_gepetto_art.prefab_jumpvolumeavailability 03.TargetToSend")
    if (gear == "left") then
      SetGlobal(global, (GetGlobal(global) + 10))
      if (20 <= GetGlobal(global)) then
        if (GetGlobal(global) <= 22) then
          if (FTL_Float_RunningSetup == 0) then
            SetGlobal("FTL_FloatGraveyard_GepettoFloat", (GetGlobal("FTL_FloatGraveyard_GepettoFloat") + 1))
            SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") + 5))
            Print(("Music - FTL_FloatGraveyard_GepettoFloat = " .. tostring(GetGlobal("FTL_FloatGraveyard_GepettoFloat"))))
          end
        end
      end
    elseif (gear == "right") then
      SetGlobal(global, (GetGlobal(global) + 1))
      if (GetGlobal(global) == 2) then
        if (FTL_Float_RunningSetup == 0) then
          SetGlobal("FTL_FloatGraveyard_GepettoFloat", (GetGlobal("FTL_FloatGraveyard_GepettoFloat") + 1))
          SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") + 5))
          Print(("Music - FTL_FloatGraveyard_GepettoFloat = " .. tostring(GetGlobal("FTL_FloatGraveyard_GepettoFloat"))))
        end
      end
    end
    if (GetGlobal(global) == 22) then
      if (FTL_Float_RunningSetup == 0) then
        if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 1) then
          AudioPostEventOn(GetPlayer(), "Stop_MX_FGY")
          MusicPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Stromboli", "WindUp_MX_FGY_Stromboli")
          Print("Stromboli float has been fixed, Play Stromboli music WindUp")
        end
        FireUser2("HintGepettoArea")
        Disable("BuddyActionGepettoPlate")
        ActivateGremlinHint("GusHintGepettoPaint1")
        if (FTL_GepettoSaveCheck == 0) then
          FTL_GepettoSaveCheck = 1
          FTL_FloatGraveyard_Checkpoint(nil, "gepetto")
        end
      end
    end
  elseif (action == "thinned") then
    if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 1) then
      AudioPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Stromboli", "WindDown_MX_FGY_Stromboli")
      FTL_FadeIn2DMusicDelayed()
      Print("Stromboli float had been fixed, Play Stromboli broken music WindDown, start 2D music")
    end
    Disable(target)
    if (GetGlobal("FTL_FloatGraveyard_StromboliHack") ~= 22) then
      Enable("BuddyActionGepettoPlate")
    end
    if (gear == "left") then
      SetGlobal(global, (GetGlobal(global) - 10))
      if (10 <= GetGlobal(global)) then
        if (GetGlobal(global) <= 12) then
          SetGlobal("FTL_FloatGraveyard_GepettoFloat", (GetGlobal("FTL_FloatGraveyard_GepettoFloat") - 1))
          SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") - 5))
          Print(("Music - FTL_FloatGraveyard_GepettoFloat = " .. tostring(GetGlobal("FTL_FloatGraveyard_GepettoFloat"))))
        end
      end
    elseif (gear == "right") then
      SetGlobal(global, (GetGlobal(global) - 1))
      if (GetGlobal(global) == 1) then
        SetGlobal("FTL_FloatGraveyard_GepettoFloat", (GetGlobal("FTL_FloatGraveyard_GepettoFloat") - 1))
        SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") - 5))
        Print(("Music - FTL_FloatGraveyard_GepettoFloat = " .. tostring(GetGlobal("FTL_FloatGraveyard_GepettoFloat"))))
      end
    end
  end
  return 
end
FTL_FloatGraveyard_ExtendDrum = function(target, action)
  if (GetGlobal("FTL_FloatGraveyard_ExtendingDrum") == 0) then
    if (action == "trigger") then
      FTL_FloatGraveyard_SetPatrolOswald("FloatArea_BounceDrumNode 01")
    elseif (action == "shock") then
      OswaldStreamAction("OswaldTimerDrum1")
    elseif (action == "enter") then
      Enable("BuddyActionExtendDrum1")
    elseif (action == "exit") then
      Disable("BuddyActionExtendDrum1")
    else
      SetGlobal("FTL_FloatGraveyard_ExtendingDrum", 1)
      ForEachEntityInGroup(Disable, "BuddyActionExtendDrumGroup")
      OswaldStreamAbort()
      FTL_FloatGraveyard_ClearPatrolOswald()
      AnimGBSequence("ftl_floatgraveyard_01a_gepetto_art.BounceDrumArm 01", "extendShort")
    end
  end
  return 
end
FTL_HallFootToon01 = 0
FTL_HallFootToon02 = 0
FTL_HallFootToon03 = 0
FTL_HallFootToon04 = 0
FTL_FloatGraveyard_HallFootChange = function(target, action, foot, knot, variable)
  if (action == "painted") then
    _G[variable] = 1
  elseif (action == "thinned") then
    _G[variable] = 0
    Enable(foot)
  end
  return 
end
FTL_FloatGraveyard_HallFootCheck = function(target, foot, variable)
  if (_G[variable] == 1) then
    Disable(foot)
  end
  return 
end
FTL_FloatGraveyard_HallFootImpact = function(target, variable, volume, emitter)
  if (_G[variable] ~= 1) then
    Enable(volume)
    StartEmitters(emitter)
    Wait(0.10000000149011612)
    Disable(volume)
    StopEmitters(emitter)
  end
  return 
end
FTL_HallFootCharging = 0
FTL_FloatGraveyard_HallFootStop = function(target, var1, foot)
  if (_G[var1] == 1) then
    SetSplineFollowerInitialSpeed(foot, 0)
  end
  return 
end
FTL_FloatGraveyard_HallFootInitiate = function()
  if (GetGlobal("FTL_FloatGraveyard_Gus_Hazard1_Played") == 0) then
    FTL_HallFootResetCheck1 = 1
    FTL_HallFootResetCheck2 = 1
    ForEachEntityInGroup(Enable, "RetractingFootGroup1")
    FTL_FloatGraveyard_HallFootRetract("nothing", "close", "RetractingFootGroup1")
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_Hazard1")
    Wait(2)
    ForEachEntityInGroup(Enable, "BuddyActionCuckooShock")
  end
  return 
end
FTL_FloatGraveyard_HallFootCheckpointReset = function()
  if (GetGlobal("FTL_FloatGraveyard_Gus_Hazard1_Played") == 1) then
    if (GetGlobal("FTL_FloatGraveyard_BirdBlocker1") == 0) then
      if (FTL_HallFootResetCheck1 == 0) then
        FTL_HallFootResetCheck1 = 1
        Enable("RetractingBird1")
        FTL_FloatGraveyard_HallFootRetract(nil, "close", "RetractingBird1")
      end
    end
    if (GetGlobal("FTL_FloatGraveyard_BirdBlocker2") == 0) then
      if (FTL_HallFootResetCheck2 == 0) then
        FTL_HallFootResetCheck2 = 1
        Enable("RetractingBird2")
        FTL_FloatGraveyard_HallFootRetract(nil, "close", "RetractingBird2")
      end
    end
  end
  return 
end
FTL_HallFootHint = 0
FTL_FloatGraveyard_HallFootHint = function()
  if (FTL_HallFootHint == 1) then
    FTL_HallFootHint = 2
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 02", "FTL_FloatGraveyard_Oswald_Hazard1")
  end
  return 
end
FTL_FloatGraveyard_HallFootRetract = function(target, action, foot, var1, var2)
  if (action == "open") then
    FTL_HallFootCharging = 1
    ForEachEntityInGroup(SetSplineFollowerInitialSpeed, foot, 1.5)
  elseif (action == "close") then
    FTL_HallFootCharging = 0
    ForEachEntityInGroup(SetSplineFollowerInitialSpeed, foot, 10)
    if (GetGlobal("FTL_FloatGraveyard_BirdBlocker1") == 0) then
      SetGlobal("FTL_FloatGraveyard_BirdPosition1", 0)
    end
    if (GetGlobal("FTL_FloatGraveyard_BirdBlocker2") == 0) then
      SetGlobal("FTL_FloatGraveyard_BirdPosition2", 0)
    end
  end
  ForEachEntityInGroup(Reverse, foot)
  return 
end
FTL_HallFootResetCheck1 = 0
FTL_HallFootResetCheck2 = 0
FTL_FloatGraveyard_HallFootToon = function(target, action, foot, var1, var2)
  if (action == "painted") then
    SetGlobal(var1, 1)
    if (GetGlobal(var2) == 1) then
      Disable(foot)
    end
    if (GetGlobal("FTL_FloatGraveyard_BirdBlocker1") == 1) then
      if (GetGlobal("FTL_FloatGraveyard_BirdBlocker2") == 1) then
        if (GetGlobal("FTL_FloatGraveyard_BirdPosition1") == 1) then
          if (GetGlobal("FTL_FloatGraveyard_BirdPosition2") == 1) then
            ForEachEntityInGroup(Disable, "BuddyActionCuckooShock")
            OswaldStreamAbort()
          end
        end
      end
    end
  elseif (action == "thinned") then
    if (FTL_HallFootResetCheck1 == 0) then
      if (var1 == "FTL_FloatGraveyard_BirdBlocker1") then
        FTL_HallFootResetCheck1 = 1
        Enable("RetractingBird1")
        FTL_FloatGraveyard_HallFootRetract(nil, "close", "RetractingBird1")
      end
    end
    if (FTL_HallFootResetCheck2 == 0) then
      if (var1 == "FTL_FloatGraveyard_BirdBlocker2") then
        FTL_HallFootResetCheck2 = 1
        Enable("RetractingBird2")
        FTL_FloatGraveyard_HallFootRetract(nil, "close", "RetractingBird2")
      end
    end
    SetGlobal(var1, 0)
    if (GetGlobal(var2) == 1) then
      Enable(foot)
      if (FTL_HallFootCharging == 0) then
        SetGlobal(var2, 0)
      end
    end
    ForEachEntityInGroup(Enable, "BuddyActionCuckooShock")
  end
  return 
end
FTL_HallFootOswaldPosition = 0
FTL_FloatGraveyard_HallFootSetOswaldPosition = function(target, area)
  if (target == GetPlayer2OrAI()) then
    FTL_HallFootOswaldPosition = tonumber(area)
  end
  return 
end
FTL_FloatGraveyard_HallFootOswaldCheck = function()
  if (FTL_HallFootCharging == 0) then
    if (FTL_HallFootOswaldPosition == 1) then
      OswaldStreamAction("RetractingHandSwitch1")
    elseif (FTL_HallFootOswaldPosition == 2) then
      OswaldStreamAction("RetractingHandSwitch2")
    end
  end
  return 
end
FTL_PipeSteamTimer = 0
FTL_FloatGraveyard_HallPipeCheck = function()
  if (FTL_PipeSteamTimer == 0) then
    FTL_PipeSteamTimer = 1
    TimerEnable("ftl_floatgraveyard_01a_chesthall_art.FloatArea_PipeTimer 01")
  end
  return 
end
FTL_PipeSteamCycle = 0
FTL_FloatGraveyard_HallPipeSteam = function()
  if (FTL_PipeSteamCycle == 0) then
    FTL_PipeSteamCycle = 1
    ForEachEntityInGroup(StopEmitters, "SteamFX2")
    AudioPostEventOn("ftl_floatgraveyard_01a_chesthall_scripting.FloatArea_PipeSteam 01a", "Stop_sfx_fgy_steam")
    ForEachEntityInGroup(Hide, "SteamVolume2")
    Wait(2)
    ForEachEntityInGroup(StartEmitters, "SteamFX1")
    AudioPostEventOn("ftl_floatgraveyard_01a_chesthall_scripting.FloatArea_PipeSteam 03a", "Play_sfx_fgy_steam")
    ForEachEntityInGroup(Unhide, "SteamVolume1")
  elseif (FTL_PipeSteamCycle == 1) then
    FTL_PipeSteamCycle = 0
    ForEachEntityInGroup(StopEmitters, "SteamFX1")
    AudioPostEventOn("ftl_floatgraveyard_01a_chesthall_scripting.FloatArea_PipeSteam 03a", "Stop_sfx_fgy_steam")
    ForEachEntityInGroup(Hide, "SteamVolume1")
    Wait(2)
    ForEachEntityInGroup(StartEmitters, "SteamFX2")
    AudioPostEventOn("ftl_floatgraveyard_01a_chesthall_scripting.FloatArea_PipeSteam 01a", "Play_sfx_fgy_steam")
    ForEachEntityInGroup(Unhide, "SteamVolume2")
  end
  return 
end
FTL_FloatGraveyard_HallPipeCleanup = function(target, emitter, volume, action)
  FTL_FloatGraveyard_HallPipeCheck()
  if (action == "thinned") then
    Unhide(emitter)
    Enable(volume)
  elseif (action == "painted") then
    Hide(emitter)
    Disable(volume)
  end
  return 
end
FTL_FloatAreaDirection = 0
FTL_PrescottCenter = 0
FTL_FloatGraveyard_PrescottSightedFloatCenter = function(target, step, position)
  if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
    if (step == "one") then
      if (GetGlobal("FTL_FloatGraveyard_Gus_SeePrescotCenter_Played") == 0) then
        if (FTL_PrescottCenter == 0) then
          FTL_PrescottCenter = 1
          TeleportGremlinToEntity("ftl_floatgraveyard_01a_ai.GremlinPrescott 01", "PrescottMarker_CenterHall")
          SetPropertyBool("CenterPrescottLookTrigger", "Look At Trigger Enabled", true)
        end
      end
    elseif (step == "two") then
      FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_SeePrescotCenter")
      TeleportGremlinOut("ftl_floatgraveyard_01a_ai.GremlinPrescott 01")
      ActivateGremlinHint("GusHintCenterNeutral1")
      Wait(0.10000000149011612)
      SetPropertyBool("CenterPrescottLookTrigger", "Look At Trigger Enabled", false)
    end
  end
  return 
end
FTL_FloatGraveyard_ProjectorHackManage = function(target, action)
  if (GetGlobal("FTL_FloatGraveyard_ProjectorHackCheck") == 0) then
    if (action == "paint") then
      Enable("BuddyActionProjectorGate")
    elseif (action == "thin") then
      Disable("BuddyActionProjectorGate")
      OswaldAbortScriptedBehavior()
    end
  end
  return 
end
FTL_FloatGraveyard_ProjectorGateHack = function(target)
  if (GetGlobal("FTL_FloatGraveyard_ProjectorHackCheck") == 0) then
    SetGlobal("FTL_FloatGraveyard_ProjectorHackCheck", 1)
    Disable("BuddyActionProjectorGate")
    AnimGBSequence("ftl_floatgraveyard_01a_art.FloatArea_ProjectorDoor 01", "opening")
    SetPropertyBool("ftl_floatgraveyard_01a_art.FloatArea_ProjectorDoor 01", "Start Active", true)
    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
      RestrictCutSceneInput()
      SetCameraAttributesForPlayer("ProjectorGateCamera")
      Wait(1)
      PlayIGC("IGC_0250b_PrescottIntroGeppetto")
    end
  end
  return 
end
FTL_FloatGraveyard_ResetFallingFloat = function(target, spawner, constraint)
  DestroyEntity(target)
  SetConstraintEntities(constraint, nil, nil)
  Wait(5)
  ForceSpawn(spawner, 1)
  return 
end
FTL_FloatGraveyard_ClearDrumConstraint = function(target)
  SetConstraintEntities(FallingDrumConstraint, nil, nil)
  DestroyEntity(target)
  return 
end
FTL_FloatGraveyard_SpawnFallingFloat = function(target)
  DestroyEntity(target)
  Wait(2)
  ForceSpawn("ftl_floatgraveyard_01a_centercorridor_scripting.CentralHallway_FallingFloatSpawner 01", 1)
  return 
end
FTL_FloatGraveyard_DestroyFallingFloat = function(target)
  local floatSpeed = GetVelocity(target)
  if (math.abs(floatSpeed.x) < 1) then
    if (math.abs(floatSpeed.y) < 1) then
      if (math.abs(floatSpeed.z) < 1) then
        FTL_FloatGraveyard_SpawnFallingFloat(target)
      end
    end
  end
  return 
end
FTL_PipeHallDoor = 0
FTL_FloatGraveyard_DestroyPipeHallDoor = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    AudioPostEventOn("ftl_floatgraveyard_01a_audio.SND_pipeHallDoor", "Play_sfx_FGY_Wall_Break")
    DestroyEntity(target)
    FireUser1("ChestRubbleFireworksTrigger")
    Unhide("PipeHallDoorFX")
    StartEmitters("PipeHallDoorFX")
    SetGlobal("FTL_FloatGraveyard_PipeDoorState", 1)
    SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") - 3))
    ForEachEntityInGroup(DestroyEntity, "OswaldAction_PipeFireworks")
    DestroyEntity("GusHintGepettoThinner1")
    Wait(3)
    StopEmitters("PipeHallDoorFX")
  end
  return 
end
FTL_FloatGraveyard_PipeFireworksTeleportCheck = function()
  Wait(0.10000000149011612)
  FTL_FloatGraveyard_SetPatrolOswald("CentralHallway_PipeFireworksNode01")
  return 
end
FTL_FloatGraveyard_PipeFireworksCheck = function()
  FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_FireworksHint3")
  ForEachEntityInGroup(Unhide, "OswaldAction_PipeFireworks")
  return 
end
FTL_FloatGraveyard_PrescottSightedFloat = function(target, step)
  if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") < 2) then
      if (step ~= "one") then
        if (step == "two") then
          FTL_FloatGraveyard_Checkpoint(nil, "gepetto")
        end
      end
    end
  end
  return 
end
FTL_NearTurnstyle01 = 0
FTL_NearTurnstyle02 = 0
FTL_MickeyTurnstile = 0
FTL_OswaldTurnstile = 0
FTL_TurnstileDoorGrabbed = 0
FTL_TurnstileDoorClosed = 0
FTL_TurnstileStreamRequireCheckPoint = 0
FTL_TurnstileDoorAirlockInProgress = 0
FTL_FloatGraveyard_ReleaseTurnstyle = function(target, variable)
  _G[variable] = 0
  return 
end
FTL_TurnstileOrientation = 0
FTL_FloatGraveyard_TrackTurnstyleRotation = function(target, variable, platform, location)
  Wait(0.20000000298023224)
  _G[variable] = 1
  while true do
    if (not (_G[variable] == 1)) then
      break
    end
    local TurnstileDirection = (GetHeading(target) * 57.3248405456543)
    if (TurnstileDirection < 0) then
      TurnstileDirection = ((180 - (TurnstileDirection * -1)) + 180)
    end
    TurnstileDirection = math.floor(TurnstileDirection)
    FTL_TurnstileOrientation = TurnstileDirection
    Print(nil, ((("Turnstyle '" .. GetName(target)) .. "' Direction: ") .. TurnstileDirection))
    StartRotateToPosition("CenterHallwayMovingAirlock", TurnstileDirection)
    Wait(0)
  end
  return 
end
AirlockTurnstileAngle = 0
AirlockTurnstileGrabbed = "true"
FTL_AirlockTurnstileDust = function(target, direction)
  AirlockTurnstileAngle = GetHeading(target)
  AirlockTurnstileGrabbed = direction
  while true do
    if (not (AirlockTurnstileGrabbed == "true")) then
      break
    end
    local AirlockTurnstileNewAngle = GetHeading(target)
    if (AirlockTurnstileNewAngle ~= AirlockTurnstileAngle) then
      AirlockTurnstileAngle = AirlockTurnstileNewAngle
      StartEmitters("CenterTurnstileFX")
    else
      StopEmitters("CenterTurnstileFX")
    end
    wait(0.10000000149011612)
  end
  StopEmitters("CenterTurnstileFX")
  return 
end
FTL_FloatGraveyard_CheckNearTurnstile = function(target, location)
  local player = _activator()
  if (location == "inside") then
    if (player == GetPlayer()) then
      FTL_MickeyTurnstile = 1
    elseif (player == GetPlayer2OrAI()) then
      FTL_OswaldTurnstile = 1
      if (location == "outside") then
        if (player == GetPlayer()) then
          FTL_MickeyTurnstile = 0
        elseif (player == GetPlayer2OrAI()) then
          FTL_OswaldTurnstile = 0
        end
      end
    end
  elseif (location == "outside") then
    if (player == GetPlayer()) then
      FTL_MickeyTurnstile = 0
    elseif (player == GetPlayer2OrAI()) then
      FTL_OswaldTurnstile = 0
    end
  end
  return 
end
FTL_FloatGraveyard_ReadyAirlock = function()
  SetRotatorMaxSpeed("CenterHallwayMovingAirlock", 20)
  StartRotateToPosition("CenterHallwayMovingAirlock", 0)
  return 
end
FTL_FloatGraveyard_ManageAirlock = function(target, action)
  if (action == "grab") then
    if (FTL_MickeyTurnstile == 1) then
      FTL_TurnstileDoorGrabbed = 1
      if (FTL_TurnstileDoorClosed == 0) then
        if (FTL_TurnstileDoorAirlockInProgress == 0) then
          FTL_TurnstileDoorAirlockInProgress = 1
          AnimGBSequence("CenterHallway_MovingAirlock 02", "closing", true)
          ForEachEntityInGroup(Enable, "MovingTurnstileBlockerGroup")
          SetPropertyInt("RotatingAirlockCollision", "Collision Layer", 2)
        end
      end
    end
  elseif (action == "release") then
    FTL_TurnstileDoorGrabbed = 0
    if (FTL_TurnstileDoorClosed == 1) then
      if (GetGlobal("FTL_FloatGraveyard_RotatingAirlock") == 0) then
        SetGlobal("FTL_FloatGraveyard_RotatingAirlock", 1)
        FTL_MickeyStreamArea = 3
        FTL_OswaldStreamArea = 3
        DisableComponent("CenterHallwayMovingTurnstile", "Coop Movable Component")
        FTL_FloatGraveyard_StreamCheck()
        DEBUG_CenterAreaSetup()
        FTL_FloatGraveyard_ShipAirlockAnimManage("airlock")
        AnimGBSequence("CenterHallway_MovingAirlock 02", "opening", true)
        Disable("MovingTurnstileBlockerCenter")
        SetPropertyInt("RotatingAirlockCollision", "Collision Layer", 13)
        if (FTL_TurnstileStreamRequireCheckPoint == 1) then
          FTL_TurnstileStreamRequireCheckPoint = 0
          FTL_FloatGraveyard_Checkpoint(nil, "center")
        end
      elseif (GetGlobal("FTL_FloatGraveyard_RotatingAirlock") == 1) then
        SetGlobal("FTL_FloatGraveyard_RotatingAirlock", 0)
        FTL_MickeyStreamArea = 4
        FTL_OswaldStreamArea = 4
        DisableComponent("CenterHallwayMovingTurnstile", "Coop Movable Component")
        FTL_FloatGraveyard_StreamCheck()
        DEBUG_AliceAreaSetup()
        if (GetGlobal("FTL_FloatGraveyard_TankerGenerator") < 0) then
          TeleportToEntity("AlicePaintProjectorStand", "PaintProjectorMarker1")
        end
        AnimGBSequence("CenterHallway_MovingAirlock 02", "opening", true)
        Disable("MovingTurnstileBlockerAlice")
        SetPropertyInt("RotatingAirlockCollision", "Collision Layer", 13)
        FTL_CircusCageCheck = 0
        if (FTL_TurnstileStreamRequireCheckPoint == 1) then
          FTL_TurnstileStreamRequireCheckPoint = 0
          if (0 <= GetGlobal("FTL_FloatGraveyard_TankerGenerator")) then
            FTL_FloatGraveyard_Checkpoint(nil, "alice")
            if (action == "door") then
              if (FTL_TurnstileDoorClosed == 0) then
                FTL_TurnstileDoorClosed = 1
                FTL_TurnstileStreamRequireCheckPoint = 1
                if (GetGlobal("FTL_FloatGraveyard_RotatingAirlock") == 0) then
                  FTL_FloatGraveyard_DetermineStreams("gepetto")
                elseif (GetGlobal("FTL_FloatGraveyard_RotatingAirlock") == 1) then
                  FTL_FloatGraveyard_DetermineStreams("alice")
                  if (FTL_TurnstileDoorClosed == 1) then
                    FTL_TurnstileDoorClosed = 0
                    FTL_TurnstileDoorAirlockInProgress = 0
                    EnableComponent("CenterHallwayMovingTurnstile", "Coop Movable Component")
                  end
                end
              elseif (FTL_TurnstileDoorClosed == 1) then
                FTL_TurnstileDoorClosed = 0
                FTL_TurnstileDoorAirlockInProgress = 0
                EnableComponent("CenterHallwayMovingTurnstile", "Coop Movable Component")
              end
            end
          end
        end
      end
    end
  elseif (action == "door") then
    if (FTL_TurnstileDoorClosed == 0) then
      FTL_TurnstileDoorClosed = 1
      FTL_TurnstileStreamRequireCheckPoint = 1
      if (GetGlobal("FTL_FloatGraveyard_RotatingAirlock") == 0) then
        FTL_FloatGraveyard_DetermineStreams("gepetto")
      elseif (GetGlobal("FTL_FloatGraveyard_RotatingAirlock") == 1) then
        FTL_FloatGraveyard_DetermineStreams("alice")
        if (FTL_TurnstileDoorClosed == 1) then
          FTL_TurnstileDoorClosed = 0
          FTL_TurnstileDoorAirlockInProgress = 0
          EnableComponent("CenterHallwayMovingTurnstile", "Coop Movable Component")
        end
      end
    elseif (FTL_TurnstileDoorClosed == 1) then
      FTL_TurnstileDoorClosed = 0
      FTL_TurnstileDoorAirlockInProgress = 0
      EnableComponent("CenterHallwayMovingTurnstile", "Coop Movable Component")
    end
  end
  return 
end
FTL_AirlockAICount = 0
FTL_FloatGraveyard_AirlockTrackAI = function(target, action)
  if (action == "enter") then
    FTL_AirlockAICount = (FTL_AirlockAICount + 1)
  elseif (action == "exit") then
    FTL_AirlockAICount = (FTL_AirlockAICount - 1)
  end
  if (FTL_AirlockAICount == 0) then
    EnableComponent("CenterHallwayMovingTurnstile", "Coop Movable Component")
  else
    DisableComponent("CenterHallwayMovingTurnstile", "Coop Movable Component")
  end
  return 
end
FTL_FloatGraveyard_FinalIGCCheck = function()
  if (GetGlobal("FTL_FloatGraveyard_TankerGenerator") < 0) then
    if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
      Unhide("IGC_Tanker")
      Unhide("ftl_floatgraveyard_01a_ai.GremlinPrescott 01")
      RestrictCutSceneInput()
      Wait(0.10000000149011612)
      PlayIGC("IGC_0255_PrescottBeforeBossFight")
    end
  end
  return 
end
FTL_FloatGraveyard_ExplodeAliceDoorFX = function()
  DestroyEntity("AliceHouseDoor3")
  Unhide("AliceDoorFX")
  StartEmitters("AliceDoorFX")
  Wait(1.5)
  StopEmitters("AliceDoorFX")
  return 
end
FTL_FloatGraveyard_CenterPlatformDrop = function()
  FTL_CenterFallingPlatform = 1
  EnableMotion("ftl_floatgraveyard_01a_centercorridor_scripting.CentralHallway_UpperPlatform 01")
  disableJumpVolumeAvailability("ftl_floatgraveyard_01a_centercorridor_art.prefab_jumpvolumeavailability 01.TargetToSend")
  disableJumpVolumeAvailability("ftl_floatgraveyard_01a_centercorridor_art.prefab_jumpvolumeavailability 02.TargetToSend")
  disableJumpVolumeAvailability("ftl_floatgraveyard_01a_centercorridor_art.prefab_jumpvolumeavailability 03.TargetToSend")
  return 
end
FTL_FloatGraveyard_AliceAreaSetup = function()
  return 
end
FTL_FloatGraveyard_PrescottTransitionSetup = function()
  if (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
    if (GetCurrentCount("BunnyChildren_FloatGraveyard") ~= 5) then
      LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_Bunny")
    end
  else
    LevelManager_SetCurrentState("FTL_FloatGraveyard.A4_v2")
  end
  FTL_FloatGraveyard_StreamCheck()
  SetupPosition()
  return 
end
FTL_FloatGraveyard_AliceMachineCheck = function()
  if (FTL_AliceMachineState == 0) then
    FTL_FloatGraveyard_ElectricStreamOswald("nothing", "SwitchTimerAliceMachine")
    Wait(0.800000011920929)
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_MiniFloat01")
    OswaldStreamAbort()
  elseif (FTL_AliceMachineState == 1) then
    FTL_FloatGraveyard_ElectricStreamOswald("nothing", "SwitchTimerAliceMachine")
  elseif (FTL_AliceMachineState == 2) then
    ClearNextPatrolNode(GetOswaldAI())
    OswaldStartFollowAction()
  end
  return 
end
FTL_AliceMachineState = 0
FTL_FloatGraveyard_AliceMachineRepair = function(target, action)
  if (action == "paint") then
    StopEmitters("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_MachineSparks 01")
    FTL_AliceMachineState = 1
    if (GetGlobal("FTL_FloatGraveyard_AliceMachines") ~= 1) then
      Prefab_OswaldElectricSwitch_ChangeState("AliceHouseSwitch", "Activate")
      Enable("BuddyActionActivatePlatforms")
    end
  elseif (action == "thin") then
    Disable("BuddyActionActivatePlatforms")
    StartEmitters("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_MachineSparks 01")
    FTL_AliceMachineState = 0
    if (GetGlobal("FTL_FloatGraveyard_AliceMachines") ~= 1) then
      Prefab_OswaldElectricSwitch_ChangeState("AliceHouseSwitch", "Deactivate")
    end
  end
  return 
end
FTL_FloatGraveyard_AliceMachineSwitch = function()
  FTL_AliceMachineState = 2
  Disable("BuddyActionActivatePlatforms")
  if (GetGlobal("FTL_FloatGraveyard_AliceMachines") ~= 1) then
    MusicPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Alice", "Windup_MX_FGY_Alice")
    Print("Fixed Alice float - starting float music Windup")
  end
  SetGlobal("FTL_FloatGraveyard_AliceMachines", 1)
  SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") + 5))
  Print(("Music - FTL_FloatGraveyard_AliceMachines = " .. tostring(GetGlobal("FTL_FloatGraveyard_AliceMachines"))))
  OswaldStreamAbort()
  ForEachEntityInGroup(Enable, "FinalAreaHands")
  ActivateGremlinHint("GusHintAlicePaint1")
  ForEachEntityInGroup(DestroyEntity, "OswaldAction_ActivatePlatforms")
  FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_Hint3")
  ForEachEntityInGroup(Unhide, "FTL_MushroomCamHintTrig")
  FTL_FloatGraveyard_Checkpoint(nil, "alice")
  return 
end
seenMickey = 0
seenOswald = 0
MickeyInTrigger = 0
OswaldInTrigger = 0
CurrentActivator = _player()
FTL_RobotEye01 = 0
FTL_RobotEye02 = 0
FTL_RobotEye03 = 0
FTL_RobotEye04 = 0
FTL_GremlinHint = 0
FTL_ProjectorShutterCheck = 0
FTL_FloatGraveyard_AliceDoorCloseCheck = function(target, variable)
  _G[variable] = 1
  if (_activator() == _player()) then
    MickeyInTrigger = 1
  else
    OswaldInTrigger = 1
  end
  CurrentActivator = _activator()
  if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
    if (variable == "FTL_RobotEye01") then
      if (FTL_GremlinHint == 0) then
        ActivateGremlinHint("GusHintAlicePaint2")
      end
    end
  end
  FTL_FloatGraveyard_AliceDoorClose(target, variable)
  return 
end
FTL_FloatGraveyard_AliceDoorClose = function(target, variable)
  if (GetPropertyBool(CurrentActivator, "Invisible") == false) then
    if (variable == "FTL_RobotEye01") then
      if (FTL_ShutterOpen == 1) then
        FTL_FloatGraveyard_AliceDoorClose2()
      end
    elseif (variable == "FTL_RobotEye03") then
      if (FTL_ShutterOpen == 2) then
        FTL_FloatGraveyard_AliceDoorClose2()
      end
    elseif (variable == "FTL_RobotEye02") then
      FTL_FloatGraveyard_AliceDoorClose2()
    end
  end
  return 
end
FTL_FloatGraveyard_AliceDoorClose2 = function(target)
  FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_PlayerSpotted")
  TimerDisable("ftl_floatgraveyard_01a_alicehouse_scripting.FinalArea_ShutterLogicTimer 01")
  if (CurrentActivator == _player()) then
    seenMickey = 1
  else
    seenOswald = 1
  end
  Prefab_Projector_ChangeState("Projector_toPrescottArena_Paint", "Deactivate")
  FTL_FloatGraveyard_EyeBeamColorShift("seen")
  if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
    if (FTL_ProjectorShutterCheck == 0) then
      if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
        AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 01", "closing", true)
      end
    end
  end
  AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 02", "closing")
  if (FTL_RobotEye01 == 1) then
    Unhide("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_RobotEyeBeam 01")
    if (GetGlobal("NOS_BogEasy_PictureQuest_FloatGraveyardPictureGot") == 1) then
      Enable("PhotoMarker_MagicShopQuest 01")
      SetMapMarkerVisible("FriendInDeedQuest1", true)
    end
  end
  if (FTL_RobotEye02 == 1) then
    Unhide("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_RobotEyeBeam 02")
    if (GetGlobal("NOS_BogEasy_PictureQuest_FloatGraveyardPictureGot") == 1) then
      Enable("PhotoMarker_MagicShopQuest 02")
      SetMapMarkerVisible("FriendInDeedQuest1", true)
    end
  end
  if (FTL_RobotEye03 == 1) then
    Unhide("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_RobotEyeBeam 03")
    if (GetGlobal("NOS_BogEasy_PictureQuest_FloatGraveyardPictureGot") == 1) then
      Enable("PhotoMarker_MagicShopQuest 03")
      SetMapMarkerVisible("FriendInDeedQuest1", true)
    end
  end
  if (FTL_RobotEye04 == 1) then
    Unhide("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_RobotEyeBeam 04")
    if (GetGlobal("NOS_BogEasy_PictureQuest_FloatGraveyardPictureGot") == 1) then
      Enable("PhotoMarker_MagicShopQuest 04")
      SetMapMarkerVisible("FriendInDeedQuest1", true)
    end
  end
  return 
end
FTL_FloatGraveyard_AliceDoorOpen = function(target, variable)
  _G[variable] = 0
  if (_activator() == _player()) then
    seenMickey = 0
    MickeyInTrigger = 0
  else
    seenOswald = 0
    OswaldInTrigger = 0
  end
  local numberSeen = 0
  numberSeen = (seenMickey + seenOswald)
  if (numberSeen == 0) then
    if (MickeyFailSafe ~= 0) then
      return 
    end
    if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
      Prefab_Projector_ChangeState("Projector_toPrescottArena_Paint", "Activate")
    end
    FTL_FloatGraveyard_EyeBeamColorShift("unseen")
    if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
      if (FTL_ProjectorShutterCheck == 0) then
        if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
          AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 01", "opening")
        end
      end
    end
    AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 02", "opening")
  end
  if (GetGlobal("FTL_FloatGraveyard_Gus_PlayerSpotted_Played") == 1) then
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_PlayerNotSeen")
  end
  if (FTL_RobotEye01 == 0) then
    AudioPostEventOn(GetPlayer(), "Stop_sfx_fgy_eye_beam_start")
  end
  if (FTL_RobotEye02 == 0) then
    AudioPostEventOn(GetPlayer(), "Stop_sfx_fgy_eye_beam_start")
  end
  if (FTL_RobotEye03 == 0) then
    AudioPostEventOn(GetPlayer(), "Stop_sfx_fgy_eye_beam_start")
  end
  if (FTL_RobotEye04 == 0) then
    AudioPostEventOn(GetPlayer(), "Stop_sfx_fgy_eye_beam_start")
  end
  return 
end
MickeyFailSafe = 0
OswaldFailSafe = 0
FTL_RobotEyeFailSafe = function(target, direction)
  if (direction == "in") then
    if (_activator() == _player()) then
      SetPlayerUnrevivable(GetPlayer())
      MickeyFailSafe = 1
    else
      SetPlayerUnrevivable(GetPlayer2OrAI())
      OswaldFailSafe = 1
      if (direction == "out") then
        if (_activator() == _player()) then
          MickeyFailSafe = 0
          SetPlayerRevivable(GetPlayer())
        else
          OswaldFailSafe = 0
          SetPlayerRevivable(GetPlayer2OrAI())
          if (direction == "killcheck") then
            if (MickeyFailSafe == 1) then
              KillAIAndRescuePlayer(GetPlayer())
            end
            if (OswaldFailSafe == 1) then
              KillAIAndRescuePlayer(GetPlayer2OrAI())
            end
            local numberSeen = 0
            numberSeen = (seenMickey + seenOswald)
            if (numberSeen == 0) then
              if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
                Prefab_Projector_ChangeState("Projector_toPrescottArena_Paint", "Activate")
              end
              FTL_FloatGraveyard_EyeBeamColorShift("unseen")
              if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
                if (FTL_ProjectorShutterCheck == 0) then
                  if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                    AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 01", "opening")
                  end
                end
              end
              AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 02", "opening")
            end
          end
        end
      elseif (direction == "killcheck") then
        if (MickeyFailSafe == 1) then
          KillAIAndRescuePlayer(GetPlayer())
        end
        if (OswaldFailSafe == 1) then
          KillAIAndRescuePlayer(GetPlayer2OrAI())
        end
        local numberSeen = 0
        numberSeen = (seenMickey + seenOswald)
        if (numberSeen == 0) then
          if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
            Prefab_Projector_ChangeState("Projector_toPrescottArena_Paint", "Activate")
          end
          FTL_FloatGraveyard_EyeBeamColorShift("unseen")
          if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
            if (FTL_ProjectorShutterCheck == 0) then
              if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 01", "opening")
              end
            end
          end
          AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 02", "opening")
        end
      end
    end
  elseif (direction == "out") then
    if (_activator() == _player()) then
      MickeyFailSafe = 0
      SetPlayerRevivable(GetPlayer())
    else
      OswaldFailSafe = 0
      SetPlayerRevivable(GetPlayer2OrAI())
      if (direction == "killcheck") then
        if (MickeyFailSafe == 1) then
          KillAIAndRescuePlayer(GetPlayer())
        end
        if (OswaldFailSafe == 1) then
          KillAIAndRescuePlayer(GetPlayer2OrAI())
        end
        local numberSeen = 0
        numberSeen = (seenMickey + seenOswald)
        if (numberSeen == 0) then
          if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
            Prefab_Projector_ChangeState("Projector_toPrescottArena_Paint", "Activate")
          end
          FTL_FloatGraveyard_EyeBeamColorShift("unseen")
          if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
            if (FTL_ProjectorShutterCheck == 0) then
              if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 01", "opening")
              end
            end
          end
          AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 02", "opening")
        end
      end
    end
  elseif (direction == "killcheck") then
    if (MickeyFailSafe == 1) then
      KillAIAndRescuePlayer(GetPlayer())
    end
    if (OswaldFailSafe == 1) then
      KillAIAndRescuePlayer(GetPlayer2OrAI())
    end
    local numberSeen = 0
    numberSeen = (seenMickey + seenOswald)
    if (numberSeen == 0) then
      if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
        Prefab_Projector_ChangeState("Projector_toPrescottArena_Paint", "Activate")
      end
      FTL_FloatGraveyard_EyeBeamColorShift("unseen")
      if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
        if (FTL_ProjectorShutterCheck == 0) then
          if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
            AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 01", "opening")
          end
        end
      end
      AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 02", "opening")
    end
  end
  return 
end
FTL_FloatGraveyard_EyeBeamColorShift = function(action)
  if (action ~= "seen") then
  end
  return 
end
FTL_FloatGraveyard_LoseInvisibilty = function(target, character)
  if (character == "Mickey") then
    if (MickeyInTrigger == 1) then
      CurrentActivator = _player()
      FTL_FloatGraveyard_AliceDoorClose2(target)
    end
  elseif (OswaldInTrigger == 1) then
    CurrentActivator = _player2()
    FTL_FloatGraveyard_AliceDoorClose2(target)
  end
  return 
end
FTL_ShutterOpen = 1
FTL_FloatGraveyard_AliceShutterOpen = function()
  if (FTL_ShutterOpen == 1) then
    FTL_ShutterOpen = 2
    AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 07", "opening", true)
    AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 05", "closing")
    ForEachEntityInGroup(Hide, "FinalShutterGroup2")
  elseif (FTL_ShutterOpen == 2) then
    FTL_ShutterOpen = 1
    AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 05", "opening", true)
    AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 07", "closing")
    ForEachEntityInGroup(Hide, "FinalShutterGroup1")
  end
  return 
end
FTL_FloatGraveyard_RobotEyeEnable = function(target, eye, variable)
  Unhide(eye)
  if (_G[variable] == 1) then
    FTL_FloatGraveyard_AliceDoorClose(target, variable)
  end
  return 
end
FTL_FloatGraveyard_DamageShip = function()
  DestroyEntity("HandSparkSpawner")
  AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_LargeHandPlatform", "twist_wrist", true)
  SetPropertyBool("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_LargeHandPlatform", "Start Active", true)
  AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_LargeFireworksCrate 01", "fall", true)
  SetPropertyBool("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_LargeFireworksCrate 01", "Start Active", true)
  AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_MiniFloat 02", "fall")
  SetPropertyBool("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_MiniFloat 02", "Start Active", true)
  return 
end
FTL_AliceHouseState = 0
FTL_FloatGraveyard_DamageHouse = function(target, step)
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  Disable("BuddyActionFinalFireworks")
  FireThread(FTL_FloatGraveyard_LargeFireworksExplodeFX, "AliceFireworksExplodeFX")
  AudioPostEventOn(GetPlayer(), "Play_sfx_fgy_fireworks_explode")
  if (GetGlobal("FTL_FloatGraveyard_FireworksState01") == 1) then
    SetGlobal("FTL_FloatGraveyard_FireworksState01", 2)
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_DamageHouse01", 0)
    AnimGBSequence("FinalArea_AliceDoor 02", "crack")
    SetPropertyBool("FinalArea_AliceDoor 02", "Start Active", true)
    AudioPostEventOn(GetPlayer(), "Play_sfx_fgy_fireworks_explode")
    SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") - 5))
    ActivateGremlinHint("GusHintAliceThinner1")
  elseif (GetGlobal("FTL_FloatGraveyard_FireworksState02") == 1) then
    SetGlobal("FTL_FloatGraveyard_FireworksState02", 2)
    Unhide("LightUpSkyPin")
    AnimGBSequence("FinalArea_AliceDoor 02", "collapse", true)
    AnimGBSequence("AliceShutterMain", "closing", true)
    SetPropertyBool("AliceShutterMain", "Start Active", true)
    Prefab_Projector_ChangeState("Projector_toPrescottArena_Paint", "Deactivate")
    SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") - 5))
    SetGlobal("FTL_FloatGraveyard_CriticalHintFlow", 5)
    if (GetGlobal("EM2_EpisodeCheck") == 2) then
      ForEachEntityInGroup(FireUser1, "ThinnerSteamGroup")
      Quest_SetCriticalPath("Critical_Floatyard", "Critical_Floatyard_2")
      ActivateGremlinHint("GusHintAliceThinner2")
    end
    if (GetGlobal("FTL_FloatGraveyard_AliceMachines") == 1) then
      AudioPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Alice", "Hitch_MX_FGY_Alice")
      Print("Alice float music playing, but wall blown up - play float hitch music")
    end
    if (GetGlobal("EM2_EpisodeCheck") == 2) then
      FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_DamageHouse02", 0)
    else
      FTL_FloatGraveyard_Checkpoint(nil, "alice")
    end
  end
  return 
end
FTL_FloatGraveyard_FireworksDetonate = function(target, event, variable)
  local child = GetChildEntityByIndex(target, 0)
  if (GetGlobal(variable) == 1) then
    if (not (not StimulusEvent_HasStimulusType(event, ST_ELECTRIC))) then
      if (0 < GetHealth(target)) then
        SetHealth(target, 0)
        AudioPostEventOn(GetPlayer(), "Play_sfx_fireworxBucket_explode")
        AnimGBSequence(target, "Active")
        Unhide(child)
        StartEmitters(child)
        Wait(0.800000011920929)
        OswaldStreamAbort()
        Wait(2.4000000953674316)
        ClearParent(child)
        Wait(3.4000000953674316)
        DestroyEntity(child)
      end
    end
  end
  return 
end
FTL_FloatGraveyard_LargeFireworksExplodeFX = function(target)
  StartEmitters(target)
  Wait(2)
  StopEmitters(target)
  return 
end
FTL_FloatGraveyard_LargeFireworksCheck = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    FTL_FloatGraveyard_DamageHouse()
  end
  return 
end
FTL_FloatGraveyard_LargeFireworksDrop = function(target, variable, sequence, crate)
  if (GetGlobal("FTL_FloatGraveyard_FireworksState01") == 1) then
    DestroyEntity("AliceLargeFireworks1")
    DestroyEntity("AliceLargeFireworks2")
    SetGlobal("FTL_FloatGraveyard_FireworksState01", 2)
    SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") - 5))
    FTL_FloatGraveyard_DamageHouse(target, "second")
  else
    SetGlobal(variable, 1)
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", sequence, 0)
    Enable("BuddyActionFinalFireworks")
  end
  return 
end
FTL_TankerGeneratorState = 0
FTL_FloatGraveyard_TankerGeneratorOpen = function()
  if (GetGlobal("FTL_FloatGraveyard_TankerGenerator") < 1) then
    if (GetGlobal("FTL_FloatGraveyard_TankerSpawned") == 0) then
      SetGlobal("FTL_FloatGraveyard_TankerSpawned", 1)
      ForceSpawn("ftl_floatgraveyard_01a_ai.TankerSpawner 01", 1)
      Wait(0.10000000149011612)
      AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceDoor 01", "Open")
      AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_BeetleworxGeneratorLight 03", "Open")
      AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceDoor 04", "Open")
      SetPropertyBool("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceDoor 01", "Start Active", true)
      FTL_TankerGeneratorState = 1
    end
  end
  return 
end
FTL_FloatGraveyard_TankerGeneratorClose = function(target)
  if (GetGlobal("FTL_FloatGraveyard_TankerGenerator") < 1) then
    if (FTL_TankerGeneratorState == 1) then
      AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceDoor 01", "Close")
      AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_BeetleworxGeneratorLight 03", "Close")
      AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceDoor 04", "Close", true)
      FTL_TankerGeneratorState = 0
    end
  end
  return 
end
FTL_FloatGraveyard_TankerGeneratorDisable = function(target, action)
  Disable("BuddyActionHackTanker")
  if (action == "Hacked") then
    Prefab_BeetleworxSpawner_Base_ChangeState("TankerSpawner_SpawnerLocation", "Hacked")
  else
    Prefab_BeetleworxSpawner_Base_ChangeState("TankerSpawner_SpawnerLocation", "Thinned")
  end
  return 
end
FTL_FloatGraveyard_TankerDeath = function(target, variable)
  if (GetGlobal("FTL_FloatGraveyard_TankerGenerator") < 1) then
    if (variable == "FTL_TankerSpawned") then
      SetGlobal("FTL_FloatGraveyard_TankerSpawned", 0)
    else
      _G[variable] = 0
    end
  end
  FTL_FloatGraveyard_TankerGeneratorOpen()
  return 
end
FTL_FloatGraveyard_GremlinKipRescue = function()
  if (GetGlobal("FTL_FloatGraveyard_Tiestow_Broken_Played") == 1) then
    if (GetGlobal("FTL_FloatGraveyard_TankerGenerator") < 1) then
      TeleportGremlinToEntity("GremlinTiestow", "ftl_floatgraveyard_01a_ai.GremlinKip_Marker 01")
      Wait(0.30000001192092896)
      FireSequence("GremlinTiestow", "FTL_FloatGraveyard_Tiestow_Generator")
    end
  else
    FTL_FloatGraveyard_Checkpoint(nil, "alice")
  end
  return 
end
FTL_FloatGraveyard_GremlinTiestowLoadCheck = function()
  if IsValidHandle("GremlinTiestowUnbrokenCage") then
    Print("FTL_FloatGraveyard_GremlinTiestowLoadCheck - Cage not destroyed")
  elseif IsValidHandle("GremlinTiestow") then
    Print("FTL_FloatGraveyard_GremlinTiestowLoadCheck - Cage destroyed and the gremlin is still around, resetting gremlin")
    Hide("GremlinTiestow")
    Wait(1)
    TeleportGremlinIn("GremlinTiestow", "GremlinTiestowMarker")
    SetNPCState("GremlinTiestow", 0)
    AnimVarInt("GremlinTiestow", VAR_Mood_Type, MOOD_Positive)
    SetVulnerability("GremlinTiestow", ST_PAINT, 1)
    SetVulnerability("GremlinTiestow", ST_THINNER, 1)
    SetVulnerability("GremlinTiestow", ST_SPIN, 1)
    SetVulnerability("GremlinTiestow", ST_KNOCKBACK, 1)
    SetPropertyBool("GremlinTiestow", "ForceInvulnerable", false)
    SetPropertyFloat("GremlinTiestow", "NegativeThreshold", 2.5)
    SetPropertyFloat("GremlinTiestow", "PositiveThreshold", 2.5)
    SetPropertyFloat("GremlinTiestow", "UsableRadius", 2)
  end
  return 
end
FTL_ClownHandCheck = 0
FTL_FloatGraveyard_ClownHandCheck = function(target, step)
  if (step == "first") then
    FTL_ClownHandCheck = 1
  elseif (step == "second") then
    if (FTL_ClownHandCheck == 1) then
      Reverse("ftl_floatgraveyard_01a_alicehouse_scripting.FinalArea_HandPlatform 09")
    end
  end
  return 
end
FTL_FloatGraveyard_RevealShipFireworks = function(target, action)
  if (GetGlobal("FTL_FloatGraveyard_ShipFireworks") < 2) then
    if (action == "painted") then
      Disable("RobotHandGlideVolume")
      SetGlobal("FTL_FloatGraveyard_ShipFireworks", 0)
      Disable("BuddyActionArmToss2")
    elseif (action == "thinned") then
      Enable("RobotHandGlideVolume")
      SetGlobal("FTL_FloatGraveyard_ShipFireworks", 1)
      FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_FireworksHint2")
      Enable("BuddyActionArmToss2")
    end
  end
  return 
end
FTL_FloatGraveyard_ShockShipFireworks = function(target, action)
  local activator = _activator()
  if (GetName(activator) == GetName(GetPlayer())) then
    if (GetGlobal("FTL_FloatGraveyard_Oswald_Fireworks1_Played") == 0) then
      if (action == "enter") then
        if (GetGlobal("FTL_FloatGraveyard_Oswald_Fireworks1_Played") == 0) then
          Enable("BuddyActionFireworksWait")
          Disable("BuddyActionArmToss1")
        end
      elseif (action == "exit") then
        Disable("BuddyActionFireworksWait")
        if (GetGlobal("FTL_FloatGraveyard_ShipFireworks") == 0) then
          Enable("BuddyActionArmToss1")
          if (action == "oswald") then
            if (GetGlobal("FTL_FloatGraveyard_ShipFireworks") == 1) then
              SetGlobal("FTL_FloatGraveyard_ShipFireworks", 2)
              Disable(target)
              Disable("BuddyActionArmToss3")
              RestrictCutSceneInput()
              OswaldStopFollowAction()
              OswaldStopMovingAction()
              OswaldAbortScriptedBehavior()
              FTL_FloatGraveyard_ShockShipIGC()
            end
          end
        end
      end
    end
  elseif (action == "oswald") then
    if (GetGlobal("FTL_FloatGraveyard_ShipFireworks") == 1) then
      SetGlobal("FTL_FloatGraveyard_ShipFireworks", 2)
      Disable(target)
      Disable("BuddyActionArmToss3")
      RestrictCutSceneInput()
      OswaldStopFollowAction()
      OswaldStopMovingAction()
      OswaldAbortScriptedBehavior()
      FTL_FloatGraveyard_ShockShipIGC()
    end
  end
  return 
end
FTL_FloatGraveyard_ShockShipIGC = function()
  StartFadeOut(0.800000011920929)
  Disable("BuddyActionFireworksWait")
  Wait(0.800000011920929)
  Wait(0.10000000149011612)
  TeleportToEntity(GetPlayer2OrAI(), "ShockShipMarker1")
  Unhide("TeleMickeyTrig")
  GrabCamera("ShockShipCamera", nil, CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
  StartFadeIn(0.800000011920929)
  Wait(0.5)
  FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 02", "FTL_FloatGraveyard_Oswald_Fireworks1", 0)
  Wait(1)
  OswaldBlastAction("HedgeFireworksMain")
  Enable("BuddyActionFireworksWait")
  Wait(0.6000000238418579)
  StimulusEntity(nil, ST_ELECTRIC, 1, GetPosition("HedgeFireworksAlt"), "HedgeFireworksAlt")
  StimulusEntity(nil, ST_ELECTRIC, 1, GetPosition("HedgeFireworksMain"), "HedgeFireworksMain")
  OswaldStartMovingAction()
  OswaldStartFollowAction()
  Wait(0.10000000149011612)
  FTL_FloatGraveyard_ClearPatrolOswald()
  Wait(3)
  StartFadeOut(0.800000011920929)
  Wait(0.800000011920929)
  DestroyEntity("TeleMickeyTrig")
  DestroyEntity("BuddyActionFireworksWait")
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
  Wait(0.10000000149011612)
  CameraReset()
  Wait(0.10000000149011612)
  StartFadeIn(0.800000011920929)
  UnrestrictCutSceneInput()
  return 
end
FTL_FloatGraveyard_AliceHandManage = function(target)
  resumeJumpVolumeWait("ftl_floatgraveyard_01a_alicehouse_art.prefab_jumpvolumewait 01.TargetToSend")
  resumeJumpVolumeWait("ftl_floatgraveyard_01a_alicehouse_art.prefab_jumpvolumewait 02.TargetToSend")
  Wait(3)
  Reverse(target)
  pauseJumpVolumeWait("ftl_floatgraveyard_01a_alicehouse_art.prefab_jumpvolumewait 01.TargetToSend")
  pauseJumpVolumeWait("ftl_floatgraveyard_01a_alicehouse_art.prefab_jumpvolumewait 02.TargetToSend")
  return 
end
FTL_FloatGraveyard_FinalClownNose = function()
  FTL_ClownDoorState03 = 1
  AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_ClownMouth 01", "opening", true)
  SetPropertyBool("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_ClownMouth 01", "Start Active", true)
  AudioPostEventOn("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_ClownMouth 01", "Play_sfx_FGY_AirBlastLift")
  OswaldStreamAbort()
  Disable("BuddyActionClownNose3")
  DisableGuardianHint("GusHintAliceThinner3")
  return 
end
FTL_FloatGraveyard_ShipTossCheck = function()
  if (GetGlobal("FTL_FloatGraveyard_ShipFireworks") == 1) then
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 02", "FTL_FloatGraveyard_Oswald_Fireworks2")
  elseif (GetGlobal("FTL_FloatGraveyard_Gus_DamageHouse01_Played") == 1) then
    OswaldTossAction()
  else
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 02", "FTL_FloatGraveyard_Oswald_DoWhat")
  end
  return 
end
FTL_ShipFollowCheck = 0
FTL_FloatGraveyard_SetShipPatrol = function(target, action)
  if (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
    if (action == "enter") then
      if (GetGlobal("FTL_FloatGraveyard_Oswald_Fireworks1_Played") == 0) then
        if (GetGlobal("FTL_FloatGraveyard_ShipFireworks") == 1) then
          Enable("BuddyActionArmToss3")
        end
      end
    elseif (action == "exit") then
      Disable("BuddyActionArmToss3")
    end
  else
  end
  return 
end
FTL_FloatGraveyard_ShipTossAbortCheck = function()
  if (FTL_ShipFollowCheck == 0) then
    OswaldTossAbort()
  end
  return 
end
FTL_FloatGraveyard_ShipFollowManage = function(target, action)
  if (GetGlobal("FTL_FloatGraveyard_Oswald_Fireworks1_Played") == 0) then
    if (target == GetPlayer()) then
      if (action == "enter") then
        OswaldStopFollowAction()
      elseif (action == "exit") then
        OswaldStartFollowAction()
      end
    end
  end
  return 
end
FTL_FloatGraveyard_ArmHackCheck = function(target, action)
  if (action == "paint") then
    if (GetGlobal("FTL_FloatGraveyard_ChimneyReprogram") < 1) then
      OswaldAbortScriptedBehavior()
      Disable("BuddyActionChimneyHack")
      Reprogram_ChangeState("AliceChimneyHack", "off")
    end
  elseif (action == "thin") then
    if (GetGlobal("FTL_FloatGraveyard_ChimneyReprogram") < 1) then
      Enable("BuddyActionChimneyHack")
      Reprogram_ChangeState("AliceChimneyHack", "activate")
      FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_Hint5")
    end
  elseif (target == "hack") then
    Disable("BuddyActionChimneyHack")
    AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_LargeFireworksCrate 02", "fall", true)
    SetPropertyBool("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_LargeFireworksCrate 02", "Start Active", true)
    AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_LargeHandCrane", "play")
    SetPropertyBool("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_LargeHandCrane", "Start Active", true)
  end
  return 
end
FTL_OswaldWindPosition = 0
FTL_FloatGraveyard_TriggerAIWindJump = function(target, location)
  if (location == "ledge") then
    if (GetName(_activator()) == GetName(GetPlayer())) then
      FTL_FloatGraveyard_SetPatrolOswald("OswaldWindNode2")
    elseif (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
      FTL_FloatGraveyard_ClearPatrolOswald()
      if (location == "node") then
        OswaldJumpNoFollowAction("OswaldWindMarker")
      elseif (location == "debug1") then
        if (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
          FTL_OswaldWindPosition = 1
        end
      elseif (location == "debug2") then
        if (FTL_OswaldWindPosition == 0) then
          TeleportToEntity(GetOswaldAI(), target)
          Wait(0.10000000149011612)
          FTL_FloatGraveyard_ClearPatrolOswald()
        end
      end
    end
  elseif (location == "node") then
    OswaldJumpNoFollowAction("OswaldWindMarker")
  elseif (location == "debug1") then
    if (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
      FTL_OswaldWindPosition = 1
    end
  elseif (location == "debug2") then
    if (FTL_OswaldWindPosition == 0) then
      TeleportToEntity(GetOswaldAI(), target)
      Wait(0.10000000149011612)
      FTL_FloatGraveyard_ClearPatrolOswald()
    end
  end
  return 
end
FTL_FloatGraveyard_OpenClownMouth = function(mouth)
  if (mouth == "1") then
    FTL_FloatGraveyard_ClownNoseManage(nil, "oswald", "FTL_ClownNoseState01", "BuddyActionClownNose1", "SwitchTimerNose1", "ftl_floatgraveyard_01a_lightparade_art.ElectricArea_ClownNose 01", "FTL_ClownDoorState01", "open")
  elseif (mouth == "2") then
    FTL_FloatGraveyard_ClownNoseManage(nil, "oswald", "FTL_ClownNoseState02", "BuddyActionClownNose2", "SwitchTimerNose2", "ftl_floatgraveyard_01a_lightparade_art.ElectricArea_ClownMouth 01", "FTL_ClownDoorState02", "open")
  elseif (mouth == "3") then
    FTL_FloatGraveyard_ClownNoseManage(nil, "oswald", "FTL_ClownNoseState03", "BuddyActionClownNose3", "SwitchTimerNose3", "ftl_floatgraveyard_01a_alicehouse_art.FinalArea_ClownMouth 01", "FTL_ClownDoorState03", "opening")
  end
  return 
end
FTL_FloatGraveyard_DestroyHedge = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    ForEachEntityInGroup(DestroyEntity, "HedgePiece")
    ForEachEntityInGroup(DestroyEntity, "HedgeFireworks")
    FireThread(FTL_FloatGraveyard_LargeFireworksExplodeFX, "AliceHedgeExplodeFX")
    OswaldStreamAbort()
    SetGlobal("FTL_FloatGraveyard_ShipFireworks", 2)
    FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 02", "FTL_FloatGraveyard_Oswald_Fireworks1", 0)
    DisableGuardianHint("GusHintAliceThinner1")
    Disable("BuddyActionArmToss1")
    Disable("BuddyActionArmToss2")
    Disable("BuddyActionArmToss3")
    enableJumpVolumeAvailability("ftl_floatgraveyard_01a_alicehouse_art.prefab_jumpvolumeavailability 01.TargetToSend")
    enableJumpVolumeAvailability("ftl_floatgraveyard_01a_alicehouse_art.prefab_jumpvolumeavailability 02.TargetToSend")
    Wait(0.10000000149011612)
    ActivateGremlinHint("GusHintAliceThinner3")
  end
  return 
end
FTL_FloatGraveyard_WindVolumeAbilitesManage = function(target, action)
  local activator = _activator()
  if (GetName(activator) == GetName(GetPlayer())) then
    if (action == "enter") then
      IncrementPaintAbilitiesDisabled(GetPlayer())
    elseif (action == "exit") then
      DecrementPaintAbilitiesDisabled(GetPlayer())
    end
  end
  return 
end
FTL_EncyclopediaPhoto1 = 0
FTL_FloatGraveyard_EncyclopediaElectric = function()
  if (GetGlobal("FTL_FloatGraveyard_KickingFeetCount") == 2) then
    SetGlobal("MSN_Adelle_ToonLegsVar", 2)
  else
    SetGlobal("MSN_Adelle_ToonLegsVar", 1)
  end
  return 
end
FTL_EncyclopediaPhoto2 = 0
FTL_FloatGraveyard_EncyclopediaCenterHall = function()
  local (for index), (for limit), (for step) = 1, 7, 1
  for i = (for index), (for limit), (for step) do
    local before = 0
    local after = 0
    after = --[[ return 2 of ]] Jigsaw_GetPercentagePainted(("FTL_CenterHallToon" .. i))
    before = Jigsaw_GetPercentagePainted(("FTL_CenterHallToon" .. i))
    if (after == 1) then
      FTL_EncyclopediaPhoto2 = (FTL_EncyclopediaPhoto2 + 1)
    end
  end
  local (for index), (for limit), (for step) = 8, 10, 1
  for i = (for index), (for limit), (for step) do
    (for index) = i
    (for index) = "Is Painted"
    if (GetPropertyBool(("FTL_CenterHallToon" .. (for index)), (for index)) == true) then
      FTL_EncyclopediaPhoto2 = (FTL_EncyclopediaPhoto2 + 1)
    end
  end
  if (8 <= FTL_EncyclopediaPhoto2) then
    SetGlobal("MSN_Adelle_ToonChasmVar", 2)
  else
    SetGlobal("MSN_Adelle_ToonChasmVar", 1)
  end
  return 
end
FTL_FloatGraveyard_PirateBeckonManage = function(target, action)
  if (GetGlobal("FTL_FloatGraveyard_Greene_Intro_Played") == 0) then
    if (GetGlobal("FTL_FloatGraveyard_Moody_Intro_Played") == 0) then
      if (action == "enter") then
        TimerEnable(target)
      elseif (action == "exit") then
        TimerDisable(target)
      end
    end
  end
  return 
end
FTL_FloatGraveyard_MemoriesQuestPhoto = function(target, action, marker)
  if (action == "setup") then
    if (GetGlobal("OST_Greene_Item4") == 1) then
      Enable(target)
      SetMapMarkerVisible("MemoriesQuestMarker", true)
    end
  elseif (action == "destroy") then
    DestroyEntity(marker)
  end
  return 
end
FTL_FloatGraveyard_MemoriesQuestPin = function()
  GiveCollectible("Everyone_Loves_a_Parade")
  AddCurrency("ETicket", -25)
  SetGlobal("FTL_FloatGraveyard_GreenePin", (GetGlobal("FTL_FloatGraveyard_GreenePin") + 1))
  SetGlobal("OST_Moody_Destination", 3)
  return 
end
FTL_FloatGraveyard_DeedPhotoCheck = function()
  SetMapMarkerVisible("FriendInDeedQuest1", false)
  GiveCollectibleNoPopup("Challenge_PicturePerfect_FloatPic_Tracker")
  if (HasCollectible("Metairie_Photo") == false) then
    GiveCollectible("Metairie_Photo")
    Quest_SetStatus("A_Friend_In_Deed", "A_Friend_In_Deed_4b", Quest_TurnIn, true)
  end
  FTL_FloatGraveyard_Checkpoint(nil, "alice")
  return 
end
FTL_FloatGraveyard_TakeGremlinPhoto = function(target, photo)
  FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_GremlinPhoto")
  if (photo == "birds") then
    ForEachEntityInGroup(Disable, "GremlinPhoto_BirdGroup")
  else
    Disable(target)
  end
  return 
end
FTL_FloatGraveyard_BunnyChildrenCleanup = function()
  FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 01", "FTL_FloatGraveyard_Gus_BunnyChildrenUpdate")
  FTL_FloatGraveyard_Checkpoint(nil, "alice")
  return 
end
FTL_FloatGraveyard_CheckpointCollectible = function()
  FTL_FloatGraveyard_Checkpoint(nil, "alice")
  return 
end
DEBUG_GENERATORHEALTH = 0
DEBUG_FIREWORKSSTATE01 = 0
DEBUG_FIREWORKSSTATE02 = 0
DEBUG_DESTROYGENERATOR = function(target, event, location, crate)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    if (location == "inside") then
      if (_G[crate] == 0) then
        _G[crate] = 1
        Wait(0.4000000059604645)
        DestroyEntity(target)
        DEBUG_GENERATORHEALTH = (DEBUG_GENERATORHEALTH + 1)
        OswaldStreamAbort()
        if (DEBUG_GENERATORHEALTH == 2) then
          DestroyEntity("ftl_floatgraveyard_01a_basherhall_art.ElectricArea_BeetleworxGenerator 02")
          ForEachEntityInGroup(DestroyEntity, "OswaldAction_BasherGenerator")
          SetGlobal("FTL_FloatGraveyard_BasherGeneratorWall", 1)
          SetPropertyFloat("ftl_floatgraveyard_01a_lightparade_scripting.DEBUGTriggerUse 01", "UsableRadius", 0)
          FTL_FloatGraveyard_BasherGeneratorDisable()
          FTL_FloatGraveyard_Checkpoint(nil, "electric")
        end
      end
    elseif (location == "ship") then
      DestroyEntity(target)
      OswaldStreamAbort()
      ForEachEntityInGroup(DestroyEntity, "ShipFireworks")
      SetGlobal("FTL_FloatGraveyard_ShipFireworks", 2)
      FireSequence("ftl_floatgraveyard_01a_scripting.ConversationMarker 02", "FTL_FloatGraveyard_Oswald_Fireworks1", 0)
      Disable("BuddyActionArmToss1")
      Disable("BuddyActionArmToss2")
      enableJumpVolumeAvailability("ftl_floatgraveyard_01a_alicehouse_art.prefab_jumpvolumeavailability 01.TargetToSend")
      enableJumpVolumeAvailability("ftl_floatgraveyard_01a_alicehouse_art.prefab_jumpvolumeavailability 02.TargetToSend")
    elseif (location == "outside") then
      DestroyEntity(target)
    end
  end
  return 
end
DEBUG_SPAWNFALLINGFLOAT = function(target, spawner)
  ForceSpawn(spawner, 1)
  return 
end
FTL_FloatGraveyard_DestroyGenerator = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    local data = GetPrefabData("BasherSpawner_SpawnerLocation")
    SetGlobal("FTL_FloatGraveyard_BasherGeneratorWall", 1)
    SetGlobal("FTL_FloatGraveyard_PlaystyleQuests", (GetGlobal("FTL_FloatGraveyard_PlaystyleQuests") - 10))
    FTL_StreamedSaveSafetyNet = 1
    FTL_FloatGraveyard_SetCriticalPath(nil, "3b")
    FireUser1("BasherGeneratorFireworksTrigger")
    FireUser2("HintLightParade")
    DEBUG_GENERATORHEALTH = 3
    DestroyEntity(target)
    DestroyEntity("GusHintElectricThinner1")
    if IsValidHandle("BasherHallFireworks") then
      DestroyEntity("BasherHallFireworks")
    end
    if IsValidHandle("BasherDrumInitial") then
      DestroyEntity("BasherDrumInitial")
      Unhide("BasherDrumBroken")
    end
    StartEmitters("LargeDrumExplodeFX")
    AudioPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_ELP", "Hitch_MX_FGY_ELP")
    Print("Blew up basher generator door - play ELP hitch music")
    if (GetGlobal("FTL_FloatGraveyard_BasherGenerator") < 1) then
      SetGlobal("FTL_FloatGraveyard_BasherGenerator", 0)
      data.SpawnerActive = "True"
      Prefab_BeetleworxSpawner_Base_OrbThinned("BasherSpawner_SpawnerLocation")
      Prefab_BeetleworxSpawner_Base_ChangeState("BasherSpawner_SpawnerLocation", "Thinned")
    elseif (GetGlobal("FTL_FloatGraveyard_BasherGenerator") == 2) then
      SetGlobal("FTL_FloatGraveyard_BasherGenerator", 1)
    end
    OswaldStreamAbort()
    FTL_FloatGraveyard_Checkpoint(nil, "electric")
    Wait(2)
    StopEmitters("LargeDrumExplodeFX")
  end
  return 
end
DEBUG_FOLLOW = function(target, move)
  if (move == "start") then
    OswaldStartFollowAction()
  elseif (move == "stop") then
    OswaldStopFollowAction()
  end
  return 
end
DEBUG_ALLOWSTREAMING = 0
DEBUG_DISABLESTREAMING = function()
  SetGlobal("FTL_FloatGraveyard_ManageLoading", 0)
  DEBUG_ALLOWSTREAMING = 1
  return 
end
FTL_FloatGraveyard_ManageJumpVolumesBasher = function()
  if (FTL_BasherJunkState == 1) then
    enableJumpVolumeAvailability("ftl_floatgraveyard_01a_basherhall_art.prefab_jumpvolumeavailability 01.TargetToSend")
    enableJumpVolumeAvailability("ftl_floatgraveyard_01a_basherhall_art.prefab_jumpvolumeavailability 02.TargetToSend")
  end
  return 
end
FTL_FloatGraveyard_DisableJumpVolumesAlice = function()
  if (GetGlobal("FTL_FloatGraveyard_Oswald_Fireworks1_Played") == 0) then
    disableJumpVolumeAvailability("ftl_floatgraveyard_01a_alicehouse_art.prefab_jumpvolumeavailability 01.TargetToSend")
    disableJumpVolumeAvailability("ftl_floatgraveyard_01a_alicehouse_art.prefab_jumpvolumeavailability 02.TargetToSend")
  end
  return 
end
FTL_CenterFallingPlatform = 0
FTL_FloatGraveyard_DisableJumpVolumesCenter = function()
  if (FTL_CenterFallingPlatform == 1) then
    disableJumpVolumeAvailability("ftl_floatgraveyard_01a_centercorridor_art.prefab_jumpvolumeavailability 01.TargetToSend")
    disableJumpVolumeAvailability("ftl_floatgraveyard_01a_centercorridor_art.prefab_jumpvolumeavailability 02.TargetToSend")
    disableJumpVolumeAvailability("ftl_floatgraveyard_01a_centercorridor_art.prefab_jumpvolumeavailability 03.TargetToSend")
  end
  return 
end
DEBUG_AliceAreaSetup = function()
  DestroyEntity("AliceHardLoadMarker")
  FTL_FloatGraveyard_DisableJumpVolumesAlice()
  FTL_FloatGraveyard_EyeBeamColorShift("unseen")
  if (1 < GetGlobal("TRT_DestroyedDioramas")) then
    TeleportToEntity("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 06", "AliceShutterMarker")
    AnimGBSequence("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 06", "open")
    SetPropertyBool("ftl_floatgraveyard_01a_alicehouse_art.FinalArea_AliceShutter 06", "Start Active", true)
    Enable("AliceChestSpinnableTrigger")
  end
  if (GetGlobal("NOS_BogEasy_PictureQuest_FloatGraveyardPictureGot") == 1) then
    ForEachEntityInGroup(Enable, "MagicShopPhotoGroup")
    SetMapMarkerVisible("FriendInDeedQuest1", true)
  end
  if (GetGlobal("FTL_FloatGraveyard_TankerGenerator") < 1) then
    SetPropertyBool("TankerGeneratorLights", "InvulnerableToPaintThinner", true)
    if (GetGlobal("FTL_FloatGraveyard_TankerGenerator") < 0) then
      AnimGBSequence("AliceShutterMain", "closed")
    end
    if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 2) then
      SetGlobal("FTL_FloatGraveyard_TankerGenerator", 1)
    end
  end
  if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 2) then
    ForEachEntityInGroup(Hide, "RobotEyeTriggerGroup")
    ForEachEntityInGroup(Hide, "RobotEyeBeamGroup")
  end
  if (GetGlobal("FTL_FloatGraveyard_AliceMachines") == 1) then
    FTL_AliceMachineState = 2
    ForEachEntityInGroup(Enable, "FinalAreaHands")
    ForEachEntityInGroup(DestroyEntity, "OswaldAction_ActivatePlatforms")
    ForEachEntityInGroup(Unhide, "FTL_MushroomCamHintTrig")
  end
  if (GetGlobal("FTL_FloatGraveyard_FireworksState02") == 2) then
    Prefab_Projector_ChangeState("Projector_toPrescottArena_Paint", "Deactivate")
  end
  if (GetGlobal("FTL_FloatGraveyard_RotatingAirlock") == 0) then
    Enable("MovingTurnstileBlockerCenter")
    Disable("MovingTurnstileBlockerAlice")
  end
  if (GetPropertyBool("AliceToon5", "Is Painted") == false) then
    FTL_ClownNoseState03 = 1
    Enable("BuddyActionClownNose3")
  end
  if (GetGlobal("FTL_FloatGraveyard_FireworksState01") == 2) then
    if IsValidHandle("HedgePieceMain") then
      Enable("BuddyActionArmToss1")
      Disable("BuddyActionFireworksWait")
    end
  end
  return 
end
DEBUG_CenterAreaSetup = function()
  FTL_FloatGraveyard_ManageJumpVolumesBasher()
  FTL_FloatGraveyard_DisableJumpVolumesCenter()
  FTL_FloatGraveyard_ManageCircusCages()
  FTL_FloatGraveyard_GremlinTiestowLoadCheck()
  if (GetGlobal("FTL_FloatGraveyard_RotatingAirlock") == 1) then
    Disable("MovingTurnstileBlockerCenter")
    Enable("MovingTurnstileBlockerAlice")
  end
  if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 2) then
    TimerEnable("ftl_floatgraveyard_01a_chesthall_art.FloatArea_PipeTimer 01")
  end
  FTL_FloatGraveyard_HallFootCheckpointReset()
  return 
end
DEBUG_ElectricAreaSetup = function()
  local data = GetPrefabData("BasherSpawner_SpawnerLocation")
  local currentLevel = string.sub(tostring(LevelManager_GetCurrentState()), 20, 21)
  FTL_FloatGraveyard_ManageJumpVolumesBasher()
  FTL_FloatGraveyard_MemoriesQuestPhoto("nothing", "setup")
  if (GetPropertyBool("ClownNoseElectric", "Is Painted") == false) then
    FTL_ClownNoseState01 = 1
  end
  if (1 <= GetGlobal("FTL_FloatGraveyard_BasherGenerator")) then
    if IsValidHandle("BasherDrumInitial") then
      DestroyEntity("BasherDrumInitial")
      Unhide("BasherDrumBroken")
    end
    if (GetGlobal("FTL_FloatGraveyard_BasherGenerator") == 1) then
      if (currentLevel == "a1") then
        Prefab_BeetleworxSpawner_Base_Doors("BasherSpawner_SpawnerLocation", "Open")
      end
    elseif (GetGlobal("FTL_FloatGraveyard_BasherGenerator") == 2) then
      if (currentLevel == "a1") then
        if (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
          while true do
            if (not (data.BeetleworxNumSpawned[1] == 0)) then
              break
            end
            Wait(0.10000000149011612)
          end
          data.DoorsRemainOpen = "True"
        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 2) then
          Prefab_BeetleworxSpawner_Base_Doors("BasherSpawner_SpawnerLocation", "Open")
        end
      end
    end
    if (currentLevel == "a1") then
      Prefab_BeetleworxSpawner_Base_TogglePlayerCollision("BasherSpawner_SpawnerLocation", "Off")
    end
  else
    FireThread(FTL_FloatGraveyard_BasherDrumCheck)
  end
  return 
end
DEBUG_GepettoAreaSetup = function()
  if (20 <= GetGlobal("FTL_FloatGraveyard_StromboliHack")) then
    if (GetGlobal("FTL_FloatGraveyard_StromboliHack") <= 22) then
      Disable("FloatArea_GepettoLegRightHack 01")
    end
  end
  if (GetGlobal("FTL_FloatGraveyard_StromboliHack") == 2) then
    Disable("FloatArea_GepettoLegLeftHack 01")
  end
  if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 0) then
    TimerEnable("ftl_floatgraveyard_01a_gepetto_scripting.FloatArea_GepettoArmLogicTimer 01")
  end
  if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 2) then
    TimerEnable("ftl_floatgraveyard_01a_chesthall_art.FloatArea_PipeTimer 01")
  end
  if (GetGlobal("FTL_FloatYardGepettoFoot") == 1) then
    if IsValidHandle("FloatArea_GepettoLegLeft 01") then
      DestroyEntity("FloatArea_GepettoLegLeft 01")
      DestroyEntity("ftl_floatgraveyard_01a_art.FloatArea_GepettoLegLeft 03")
      DestroyEntity("GepettoLegTicket")
    end
  end
  if (GetPropertyBool("ClownNoseGepetto", "Is Painted") == false) then
    FTL_ClownNoseState02 = 1
  end
  FTL_FloatGraveyard_HallFootCheckpointReset()
  return 
end
FTL_FloatGraveyard_ManageHints = function(target, action, hint)
  if (action == "start") then
    FireUser1(hint)
  elseif (action == "stop") then
    FireUser2(hint)
  end
  return 
end
StromboliFloatMusicStateLoad = function()
  if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 1) then
    MusicPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Stromboli", "Play_MX_FGY_Stromboli")
    Print("Started Stromboli 3D music event")
  else
    MusicPostEventOn(GetPlayer(), "Play_MX_FGY")
    Print("Started FGY 2D music event")
  end
  return 
end
StromboliFloatMusicStateEnter = function()
  if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 1) then
    AudioPostEventOn(GetPlayer(), "FadeOut_MX_FGY")
    FTL_FadeInStromboliMusicDelayed()
    Print("Stopped FGY 2D music event, Started Stromboli 3D music event")
  else
    Print("Stromboli not fixed, continue playing FGY 2D music")
  end
  Print(("Music - FTL_FloatGraveyard_GepettoFloat = " .. tostring(GetGlobal("FTL_FloatGraveyard_GepettoFloat"))))
  return 
end
StromboliFloatMusicStateExit = function()
  if (GetGlobal("FTL_FloatGraveyard_GepettoFloat") == 1) then
    AudioPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Stromboli", "FadeOut_MX_FGY_Stromboli")
    FTL_FadeIn2DMusicDelayed()
    Print("Stopped Stromboli 3D music event, Started FGY 2D music event")
  else
    Print("Stromboli not fixed, continue playing FGY 2D music")
  end
  Print(("Music - FTL_FloatGraveyard_GepettoFloat = " .. tostring(GetGlobal("FTL_FloatGraveyard_GepettoFloat"))))
  return 
end
AliceFloatMusicStateLoad = function()
  if (GetGlobal("FTL_FloatGraveyard_AliceMachines") == 1) then
    MusicPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Alice", "Play_MX_FGY_Alice")
    Print("Started Alice 3D music event")
  else
    MusicPostEventOn(GetPlayer(), "Play_MX_FGY")
    Print("Started FGY 2D music event")
  end
  return 
end
AliceFloatMusicStateEnter = function()
  if (GetGlobal("FTL_FloatGraveyard_AliceMachines") == 1) then
    AudioPostEventOn(GetPlayer(), "FadeOut_MX_FGY")
    FTL_FadeInAliceMusicDelayed()
    Print("Stopped FGY 2D music event, started Alice 3D music event")
  else
    Print("Alice not fixed, continue playing FGY 2D music")
    Print(("Music - FTL_FloatGraveyard_AliceMachines = " .. tostring(GetGlobal("FTL_FloatGraveyard_AliceMachines"))))
  end
  return 
end
AliceFloatMusicStateExit = function()
  if (GetGlobal("FTL_FloatGraveyard_AliceMachines") == 1) then
    AudioPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Alice", "FadeOut_MX_FGY_Alice")
    FTL_FadeIn2DMusicDelayed()
    Print("Stopped Alice 3D music event, started FGY 2D music event")
  else
    Print("Alice not fixed, continue playing FGY 2D music")
    Print(("Music - FTL_FloatGraveyard_AliceMachines = " .. tostring(GetGlobal("FTL_FloatGraveyard_AliceMachines"))))
  end
  return 
end
ChestStingerResumeAliceFloatMusic = function()
  wait(7)
  MusicPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Alice", "FadeIn_MX_FGY_Alice")
  Print("Started Alice 3D music event")
  return 
end
ChestStingerResumeELPFloatMusic = function()
  wait(7)
  MusicPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_ELP", "FadeIn_MX_FGY_ELP")
  Print("Started ELP 3D music event")
  return 
end
FTL_FadeIn2DMusicDelayed = function()
  wait(2)
  MusicPostEventOn(GetPlayer(), "FadeIn_MX_FGY")
  return 
end
FTL_FadeInELPMusicDelayed = function()
  wait(2)
  MusicPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_ELP", "FadeIn_MX_FGY_ELP")
  return 
end
FTL_FadeInStromboliMusicDelayed = function()
  wait(2)
  MusicPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Stromboli", "Stop_MX_FGY_Stromboli")
  return 
end
FTL_FadeInAliceMusicDelayed = function()
  wait(2)
  MusicPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Alice", "Play_MX_FGY_Alice")
  return 
end
FTL_CandySphereInitialImpulse = function(target)
  local LaunchDirection = (GetPosition("CentralHallway_FallingFloatMarkerTarget") - GetPosition(target))
  LaunchDirection:normalize3()
  ApplyImpulse(target, (LaunchDirection.x * 2000), 0, 0)
  return 
end
FTL_Minifloat_ReParent = function()
  if (GetGlobal("FTL_FloatGraveyard_JollyRogerState") == 1) then
    TeleportToEntity("MiniFloatMovable", "ElectricArea_MiniFloatPad 02")
    SetPropertyFloat("MiniFloatMovable", "UsableRadius", 0)
    DisableMotion("MiniFloatMovable")
    EnableComponent("MiniFloatMovable", "Rotator")
    SetRotatorMaxSpeed("MiniFloatMovable", 100)
    wait(3)
    AudioPostEventOn("MiniFloatMovable", "Stop_sfx_fgy_metal_scrape")
  end
  return 
end
FTL_FloatGraveyard_ResetFallingPlayer = function(target)
  local activator = _activator()
  KillAIAndRescuePlayer(activator)
  if (GetName(activator) == GetName(GetOswaldAI())) then
    return 
  elseif (GetHealth(activator) == 0) then
    FreezeCamera(activator)
  end
  return 
end
FTL_FloatGraveyard_DisableTicketAttract = function(target, amount)
  local childName = ""
  if (amount == "one") then
    childName = "ETicket_E_Parentable"
  elseif (amount == "ten") then
    childName = "ETicket_C_Nif"
  end
  local childEntity = GetChildEntityByName(target, childName)
  childEntity = GetName(childEntity)
  SetPropertyBool(childEntity, "AutoAttracts", false)
  return 
end
FTL_FloatGraveyard_CenterClothCheckpoint = function()
  FTL_FloatGraveyard_Checkpoint(nil, "center")
  return 
end
FTL_FloatGraveyard_GepettoClothCheckpoint = function()
  SetGlobal("FTL_FloatGraveyard_A2CheckpointLocation", 1)
  SaveCheckpoint(GetPlayer(), "FTL_FloatGraveyard_A2CheckpointSave", "ftl_floatgraveyard_01a.GepettoArea_MickeyMarker 02", "ftl_floatgraveyard_01a.GepettoArea_OswaldMarker 02")
  return 
end
FTL_FloatGraveyard_SpawnerCheckpoint = function(enemy)
  if (enemy == "basher") then
    FTL_FloatGraveyard_Checkpoint(nil, "electric")
  elseif (enemy == "tanker") then
    FTL_FloatGraveyard_Checkpoint(nil, "alice")
  end
  return 
end
FTL_CircusCageCheck = 0
FTL_FloatGraveyard_ManageCircusCages = function()
  local currentLevel = string.sub(tostring(LevelManager_GetCurrentState()), 20, 21)
  if (currentLevel == "a4") then
    return 
  elseif (FTL_CircusCageCheck == 0) then
    FTL_CircusCageCheck = 1
    ForEachEntityInGroup(Enable, "BasherHallCageGroup")
    if (GetGlobal("FTL_FloatGraveyard_BasherAirlock") == 0) then
      Reverse("BasherHallCage2")
      SetPropertyInt("BasherHallCage2Collision", "Collision Layer", 13)
    end
    if (GetGlobal("FTL_FloatGraveyard_BasherAirlock") == 1) then
      Reverse("BasherHallCage1")
      SetPropertyInt("BasherHallCage1Collision", "Collision Layer", 13)
    end
    FireThread(FTL_FloatGraveyard_EnableSteamJets)
  end
  return 
end
FTL_LightParadeDrumStateChange = function(target, _Which, _State)
  Print(((("__Function: FTL_LightParadeDrumStateChange, _Which: " .. tostring(_Which)) .. ", _State: ") .. tostring(_State)))
  if (_Which == "Tall") then
    if (_State == "Painted") then
      Disable("DrumCollisionTrigger_Tall")
    elseif (_State == "Thinned") then
      Enable("DrumCollisionTrigger_Tall")
      if (_Which == "Short") then
        if (_State == "Painted") then
          Disable("DrumCollisionTrigger_Short")
        elseif (_State == "Thinned") then
          Enable("DrumCollisionTrigger_Short")
        end
      end
    end
  elseif (_Which == "Short") then
    if (_State == "Painted") then
      Disable("DrumCollisionTrigger_Short")
    elseif (_State == "Thinned") then
      Enable("DrumCollisionTrigger_Short")
    end
  end
  return 
end
FTL_LightParadeDrum_TriggerInside = function(target, _Which, _State)
  if (_Which == "Tall") then
    if (_State == "In") then
      SetPropertyInt("BouncyDrumTop_Tall", "Collision Layer", 16)
    elseif (_State == "Empty") then
      SetPropertyInt("BouncyDrumTop_Tall", "Collision Layer", 1)
      if (_Which == "Short") then
        if (_State == "In") then
          SetPropertyInt("BouncyDrumTop_Short", "Collision Layer", 16)
        elseif (_State == "Empty") then
          SetPropertyInt("BouncyDrumTop_Short", "Collision Layer", 1)
        end
      end
    end
  elseif (_Which == "Short") then
    if (_State == "In") then
      SetPropertyInt("BouncyDrumTop_Short", "Collision Layer", 16)
    elseif (_State == "Empty") then
      SetPropertyInt("BouncyDrumTop_Short", "Collision Layer", 1)
    end
  end
  return 
end
