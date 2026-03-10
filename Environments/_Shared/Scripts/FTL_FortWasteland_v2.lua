local musicvar = 0
FTL_Fort_Visit_Setup = function(method, currentLevel)
  Print("*_*_*_*_*_*_*_*_*_*@@@@ FTL_Fort_Setup() VISIT 2")
  if (currentLevel == "dock") then
    if (GetGlobal("OST_Moody_Destination") == 3) then
      if (GetGlobal("FTL_Fort_Greene_Intro_Played") == 0) then
        LevelManager_SetZoneStatusActive("FTL_Fort01a.Q_Memories")
      end
    else
      LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.Q_Memories")
      if (currentLevel == "fort") then
        LevelManager_SetZoneStatusActive("FTL_Fort01a.V2_NPCs")
      end
    end
  elseif (currentLevel == "fort") then
    LevelManager_SetZoneStatusActive("FTL_Fort01a.V2_NPCs")
  end
  WaitForLevelLoad()
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    SetGlobal("EM2_EpisodeCheck", 3)
    SetGlobal("FTL_Fort_SpatterState", 1)
    SetGlobal("MSS_ObservatoryItem_Fort", 1)
    SetGlobal("FTL_Ian_FortIntro_Played", 1)
    FireThread(FTL_Fort_Setup, "setupTurrets")
  end
  if (1 <= GetGlobal("MSS_ObservatoryItem_Fort")) then
    AnimGBSequence("FTL_fort_rockfaceRubble", "Anim")
  end
  if (musicvar == 0) then
    MusicPostEventOn(GetPlayer(), "Play_MX_DG2")
    RemoveAllMusicStateOverride()
    musicvar = 1
    Print("Started music event from FTL_Fort_Visit_Setup")
  end
  if (tostring(MostRecentCheckpointCallback) ~= "FTL_Fort_Setup") then
    if (currentLevel == "dock") then
      if (GetGlobal("FTL_Fort_SpatterState") ~= 1) then
        ForceSpawn("Spawner_DestructiveBlotworx", 1)
      end
      FTL_SaveCheckpoint("Docks")
    elseif (currentLevel == "fort") then
      FTL_SaveCheckpoint("Fort_Entrance")
    end
  end
  if (currentLevel == "fort") then
    if (method == "DEC") then
      Prefab_DECFoopToob_Finish("DEC_toFloat3D")
    end
  end
  return 
end
FTL_Fort_EnterJail = function()
  LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.V2_AI_Forest")
  LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.V2_AI_Forest_Sweepers")
  if (GetGlobal("FTL_Gulch_Fiddler_Rescued_Played") == 0) then
    if (GetGlobal("MSN_Quest_3Pigs_State") ~= 2) then
      ForceSpawn("Spawner_Fiddler", 1)
    end
  end
  ReplaceMusicStateOverride("DG2_IntFortJail")
  Prefab_EnterInterior_FadeIn()
  return 
end
FTL_Fort_AirlockStreaming_Visit = function(loc)
  Print(("FTL_Fort_AirlockStreaming_Visit: loc = " .. loc))
  local zones = {}
  local location = string.sub(loc, 1, 4)
  Print(("FTL_Fort_AirlockStreaming_Visit: location = " .. location))
  if (location == "Dock") then
    if (GetGlobal("OST_Moody_Destination") == 3) then
      if (GetGlobal("FTL_Fort_Greene_Intro_Played") == 0) then
        table.insert(zones, "FTL_Fort01a.Q_Memories")
      end
    else
      LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.Q_Memories")
      if (location == "Fort") then
        table.insert(zones, "FTL_Fort01a.V2_NPCs")
        if (string.sub(loc, 5, -1) == "_ALTrees") then
          local SpawnAI = 0
          if (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
            if (GetCurrentCount("BunnyChildren_FortWasteland") ~= 5) then
              Print("FTL_Fort_AirlockStreaming_Visit: Stream In Bunny")
              table.insert(zones, "FTL_Fort01a.Q_BunnyChildren")
              SpawnAI = (SpawnAI + 1)
            end
          else
            Print("FTL_Fort_AirlockStreaming_Visit: Unload Bunny")
            table.insert(zones, "FTL_Fort01a.Q_BunnyChildrenDummy")
            LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.Q_BunnyChildren")
          end
          if (GetGlobal("FTL_Shaky_Freed_Played") == 0) then
            table.insert(zones, "FTL_fort01a.Q_RescueGremlin")
            SpawnAI = (SpawnAI + 1)
          else
            Print("FTL_Fort_AirlockStreaming_Visit: Unload Gremlin")
            LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.Q_RescueGremlin")
          end
          if (SpawnAI < 2) then
            table.insert(zones, "FTL_Fort01a.V2_AI_Forest")
            SpawnAI = (SpawnAI + 1)
            if (SpawnAI < 2) then
              if (GetGlobal("FTL_Fort_SpatterState") ~= 1) then
                table.insert(zones, "FTL_Fort01a.V2_AI_Forest_Sweepers")
              end
            end
          end
        end
      end
    end
  elseif (location == "Fort") then
    table.insert(zones, "FTL_Fort01a.V2_NPCs")
    if (string.sub(loc, 5, -1) == "_ALTrees") then
      local SpawnAI = 0
      if (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
        if (GetCurrentCount("BunnyChildren_FortWasteland") ~= 5) then
          Print("FTL_Fort_AirlockStreaming_Visit: Stream In Bunny")
          table.insert(zones, "FTL_Fort01a.Q_BunnyChildren")
          SpawnAI = (SpawnAI + 1)
        end
      else
        Print("FTL_Fort_AirlockStreaming_Visit: Unload Bunny")
        table.insert(zones, "FTL_Fort01a.Q_BunnyChildrenDummy")
        LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.Q_BunnyChildren")
      end
      if (GetGlobal("FTL_Shaky_Freed_Played") == 0) then
        table.insert(zones, "FTL_fort01a.Q_RescueGremlin")
        SpawnAI = (SpawnAI + 1)
      else
        Print("FTL_Fort_AirlockStreaming_Visit: Unload Gremlin")
        LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.Q_RescueGremlin")
      end
      if (SpawnAI < 2) then
        table.insert(zones, "FTL_Fort01a.V2_AI_Forest")
        SpawnAI = (SpawnAI + 1)
        if (SpawnAI < 2) then
          if (GetGlobal("FTL_Fort_SpatterState") ~= 1) then
            table.insert(zones, "FTL_Fort01a.V2_AI_Forest_Sweepers")
          end
        end
      end
    end
  end
  local state, state = ("FTL_fort01a.V2_" .. loc), loc
  state = state
  return state, zones
end

