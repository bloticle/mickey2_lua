TCY_Load_MD_FilmStrip = function(target)
  SetupPosition(target)
  return 
end
TCY_AUT_PickVTL_Visit = function(target)
  if (GetGlobal("EM2_EpisodeCheck") == 4) then
    GetPrefabData("toautotopia_Projector_Upper").ActivatedLevels = "VTL_Oasis.Expansion_Epilogue"
    GetPrefabData("toautotopia_Projector_Upper").State_Stream = "VTL_Oasis.From_AutotopiaV2"
  end
  SetupPosition(target)
  return 
end
VTL_Oasis_toAutotopia = function(projector)
  local data = GetPrefabData(projector)
  Print("***VTL_Oasis_StreamAutotopia && ExitFunction == AUT_ArriveFromVentureland")
  if (GetGlobal("Autotopia_Core_Progression") ~= -1) then
    GetPrefabData("intoAutotopiaMarker").ToFlyThrough = "False"
  end
  SetupPosition(projector)
  return 
end
TCY_aut_HardLoaded = function()
end
AUT_SaveCheckpoint_Gen = function()
  SaveCheckpointNoPosition(nil, "AUT_AlwaysSetup")
  return 
end
local AUT_CurrentCheckpointLocation = "ControlTower"
AUT_SetCheckpointLocation = function(target, location)
  if (location ~= nil) then
    AUT_CurrentCheckpointLocation = location
  end
  return 
end
AUT_SaveCheckpoint = function(location)
  if (location ~= nil) then
    AUT_CurrentCheckpointLocation = location
  end
  Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SaveCheckpoint saving to Save_" .. AUT_CurrentCheckpointLocation) .. "_MickeyStart"))
  SaveCheckpoint(nil, "AUT_AlwaysSetup", (("Save_" .. AUT_CurrentCheckpointLocation) .. "_MickeyStart"), (("Save_" .. AUT_CurrentCheckpointLocation) .. "_OswaldStart"))
  return 
end
AUT_OpenPearlChest = function()
  ForceSequence("GusGeneric_Marker(Conversation) 01", "Gus_FoundObject")
  SaveCheckpointNoPosition("AUT_AlwaysSetup")
  return 
end
AUT_AlwaysSetup = function(projector)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup Called!!")
  if (projector ~= nil) then
    Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup called on " .. GetPropertyString(projector, "EntityGroups", 1)) .. "!!"))
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup called without a projector!!")
  end
  if (3 < GetGlobal("EM2_EpisodeCheck")) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds EM2_EpisodeCheck > 3; Entered Visit 02 of Autotopia!!")
    MusicPostEventOn(GetPlayer(), "Play_MX_AUT")
    AudioPostEventOn("tcy_autotopia_01a_audio.Snd_Amb_2D", "Play_sfx_AUT_amb")
    AudioSetState("tcy_autotopia_01a_audio.Snd_Amb_2D", "amb_AUT_state", "autotopia_exterior")
    AudioEffectStop("tcy_autotopia_01a_audio.Snd_Amb_reverb")
    RemoveAllMusicStateOverride()
    Print("Started AUT music event v2")
    if (GetGlobal("Autotopia_CostumeCaveOpen") == 1) then
      if (Quest_CheckStatus("Rebuilding_Autotopia", "Rebuilding_Autotopia_1", Quest_Completed) == false) then
        Quest_SetStatus("Rebuilding_Autotopia", "Rebuilding_Autotopia_1", Quest_Completed, false)
      end
    end
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds EM2_EpisodeCheck is 3 or less; Entered Visit 01 of Autotopia!!")
    if (GetGlobal("Autotopia_Siphon01") == 0) then
      SetGlobal("AUT_EngineBlock01", 0)
      SetGlobal("AUT_EngineBlock02", 0)
      SetGlobal("AUT_EngineBlock03", 0)
    end
    if (GetGlobal("Autotopia_Siphon02") == 0) then
      SetGlobal("AUT_EngineBlock04", 0)
      SetGlobal("AUT_EngineBlock05", 0)
      SetGlobal("AUT_EngineBlock06", 0)
    end
    if (GetGlobal("Autotopia_Siphon03") == 0) then
      SetGlobal("AUT_EngineBlock07", 0)
      SetGlobal("AUT_EngineBlock08", 0)
      SetGlobal("AUT_EngineBlock09", 0)
    end
    if (0 < GetGlobal("Autotopia_Siphon01")) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds Autotopia_Siphon01 > 0; Setting up bwrx spawner!!")
      local CurrentLevel = LevelManager_GetCurrentState()
      if (CurrentLevel == "tcy_autotopia_visit1.sectionc_first") then
        SetPropertyEntity("FirstBwrxSpawner 01", "Spawn Destinations", "tcy_autotopia_01d_both.PatrolNode 01", 0)
        if (0 < GetGlobal("Autotopia_Siphon01")) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds players loading into sectionc_first; Setting up bwrx spawner!!")
          SetPropertyFloat("tcy_autotopia_01a_shared.PatrolNode 03", "BranchPathChance", 1)
          SetPropertyFloat("tcy_autotopia_01a_shared.PatrolNode 04", "BranchPathChance", 1)
        end
      elseif (CurrentLevel == "tcy_autotopia_visit1.sectione_first") then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds players loading into sectione_first; Setting up bwrx spawner!!")
        SetPropertyEntity("FirstBwrxSpawner 01", "Spawn Destinations", "tcy_autotopia_01d_both.PatrolNode 01", 0)
        SetPropertyFloat("tcy_autotopia_01a_shared.PatrolNode 03", "BranchPathChance", 1)
        SetPropertyFloat("tcy_autotopia_01a_shared.PatrolNode 04", "BranchPathChance", 1)
      end
      Enable("FirstBwrxSpawner 01")
    end
    MusicPostEventOn(GetPlayer(), "Play_MX_AUT")
    AudioPostEventOn("tcy_autotopia_01a_audio.Snd_Amb_2D", "Play_sfx_AUT_amb")
    AudioSetState("tcy_autotopia_01a_audio.Snd_Amb_2D", "amb_AUT_state", "autotopia_exterior")
    AudioEffectStop("tcy_autotopia_01a_audio.Snd_Amb_reverb")
    RemoveAllMusicStateOverride()
    Print("Started AUT music event v1")
  end
  local CurrentLevel, CurrentLevel = LevelManager_GetCurrentState(), "EM2_EpisodeCheck"
  if (CurrentLevel == "tcy_autotopia_visit1.sectiona_first") then
    CurrentLevel = GetGlobal
    CurrentLevel = CurrentLevel("Autotopia_Siphon01")
    if (CurrentLevel == 1) then
      CurrentLevel = GetGlobal
      CurrentLevel = CurrentLevel("Autotopia_Siphon02")
      if (CurrentLevel == 0) then
        CurrentLevel = Print
        CurrentLevel("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds players are in sectiona_first; activate gus hints!!")
        CurrentLevel = ActivateGremlinHint
        CurrentLevel("Gus PlayerHintMarkers Visit01 01")
      end
    end
  elseif (CurrentLevel == "tcy_autotopia_visit1.sectionc_first") then
    CurrentLevel = GetGlobal
    CurrentLevel = CurrentLevel("Autotopia_Siphon02")
    if (CurrentLevel == 1) then
      CurrentLevel = GetGlobal
      CurrentLevel = CurrentLevel("Autotopia_Siphon03")
      if (CurrentLevel == 0) then
        CurrentLevel = Print
        CurrentLevel("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds players are in sectionc_first; activate gus hints!!")
        CurrentLevel = ActivateGremlinHint
        CurrentLevel("Gus PlayerHintMarkers Visit01 02")
      end
    end
  elseif (CurrentLevel == "tcy_autotopia_visit1.sectione_first") then
    CurrentLevel = GetGlobal
    CurrentLevel = CurrentLevel("Autotopia_Siphon03")
    if (CurrentLevel == 1) then
      CurrentLevel = GetGlobal
      CurrentLevel = CurrentLevel("Autotopia_Core_Progression")
      if (CurrentLevel < 1) then
        CurrentLevel = Print
        CurrentLevel("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds players are in sectione_first; activate gus hints!!")
        CurrentLevel = ActivateGremlinHint
        CurrentLevel("Gus PlayerHintMarkers Visit01 03")
      end
    end
  end
  CurrentLevel = Print
  CurrentLevel("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup checking levelString to find appropriate gate to open!!")
  CurrentLevel = tostring
  CurrentLevel = CurrentLevel(LevelManager_GetCurrentState())
  local levelString = LevelManager_GetCurrentState()
  levelString = Print
  levelString((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup checking finds current state is " .. CurrentLevel) .. "!!"))
  if (CurrentLevel == "tcy_autotopia_visit1.main_visit2") then
    levelString = AUT_Zone_Loaded
    levelString(GetPlayer(), "A")
  else
    levelString = string
    levelString = levelString.sub
    levelString = levelString(CurrentLevel, 22, 28)
    if (levelString == "section") then
      levelString = string
      levelString = levelString.sub
      levelString = levelString(CurrentLevel, 29, 29)
      local section = CurrentLevel
      section = Print
      section(("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup: 29th character = " .. levelString))
      if (levelString == "a") then
        section = AUT_Zone_Loaded
        section(GetPlayer(), "A")
      end
      if (levelString == "c") then
        section = AUT_Zone_Loaded
        section(GetPlayer(), "C")
      elseif (levelString == "e") then
        section = AUT_Zone_Loaded
        section(GetPlayer(), "E")
      end
    end
  end
  levelString = GetGlobal
  levelString = levelString("Autotopia_Core_Progression")
  if (levelString == -1) then
    levelString = Print
    levelString("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds Autotopia_Core_Progression == -1; Playing initial IGC!!")
    levelString = PlayIGC
    levelString("IGC_0310_AutotopiaIntro")
  end
  levelString = GetGlobal
  levelString = levelString("Autotopia_CostumeCaveOpen")
  if (levelString == 1) then
    levelString = GetGlobal
    levelString = levelString("EM2_EpisodeCheck")
    if (levelString == 4) then
      levelString = Print
      levelString(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds Autotopia_CostumeCaveOpen == 1")
      levelString = ForceSpawn
      levelString("StuffusSpawner 01", 1)
      levelString = Print
      levelString(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds Stuffus is missing; SPAWN BACKUP STUFFUS")
      levelString = GetGlobal
      levelString = levelString("EM2_EpisodeCheck")
      if (3 < levelString) then
        levelString = Print
        levelString(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds EM2_EpisodeCheck > 3")
        levelString = GetGlobal
        levelString = levelString("Autotopia_PlayerCar")
        if (levelString < 1) then
          levelString = Print
          levelString(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds Autotopia_PlayerCar < 1; removing garage debris")
          levelString = ForEachEntityInGroup
          levelString(Hide, "GarageDebris")
          levelString = FireThread
          levelString(TeleportGremlinToEntity, "Stuffus", "StuffusToGarage_PositionMarker 01")
          levelString = Print
          levelString(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup teleports STUFFUS TO GARAGE")
        else
          levelString = GetGlobal
          levelString = levelString("Autotopia_PlayerCar")
          if (levelString == 1) then
            levelString = FireThread
            levelString(TeleportGremlinToEntity, "Stuffus", "StuffusRaceLinePositionMarker 01")
            levelString = 1
            AUT_CarIgnition = levelString
            levelString = Print
            levelString(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds Autotopia_PlayerCar == 1; Stuffus to finish line")
            levelString = Unhide
            levelString("Bridge01")
            levelString = Unhide
            levelString("Trophy_TCY_podium_01a_inert 01")
            levelString = Enable
            levelString("RaceFinishLineTriggerBase 01")
            levelString = ForEachEntityInGroup
            levelString(Hide, "RacewayDebris")
            levelString = ForEachEntityInGroup
            levelString(Hide, "GarageDebris")
            levelString = AUT_RestorePlayerCars
            levelString()
          end
        end
      end
    end
  end
  levelString = DestroyEntity
  levelString("LaunchMapMarker")
  levelString = GetPropertyString
  levelString = levelString(projector, "EntityGroups", 1)
  if (levelString == "intoAutotopiaMarker") then
    levelString = Print
    levelString(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_AlwaysSetup finds player has exited from the main projector, override save position")
    levelString = AUT_SaveCheckpoint
    levelString("Projector")
  end
  return 
end
AUT_kickoff_introIGC = function()
  wait(3.5)
  PlayIGC("IGC_0310_AutotopiaIntro")
  return 
end
AUT_EnterAutotopia = function()
  if (GetGlobal("AUT_Race_PracticeFlag") ~= 3) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_EnterAutotopia detects that AUT_Race_PracticeFlag ~= 3; do standard projector setup")
    if (-1 < GetGlobal("Autotopia_Core_Progression")) then
      GetPrefabData("intoAutotopiaProjector").ToFlyThrough = "False"
      GetPrefabData("intoAutotopiaProjector").SkipSideCameraRelease = false
    end
    if (GetGlobal("Autotopia_HardLoad") == 0) then
      GetPrefabData("intoAutotopiaProjector").MapLoad_SetupPosition = "True"
      OnMapLoad_ProjectorSetup("intoAutotopiaProjector")
    else
      GetPrefabData("ControlTowerProjector").MapLoad_SetupPosition = "True"
      OnMapLoad_ProjectorSetup("ControlTowerProjector")
    end
    SetGlobal("Autotopia_HardLoad", 0)
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_EnterAutotopia detects that AUT_Race_PracticeFlag == 3; skip projector setup")
    ShowReticleOnly()
    ForEachEntityInGroup(Hide, "RacewayDebris")
    AUT_AlwaysSetup(nil)
  end
  return 
end
AUT_ColorCars = function(target, clr1, clr2, clr3)
  SetR3MTColorReg(target, 0, vector4(clr1, clr2, clr3))
  return 
end
AUT_ReturnFromRace = function()
  if (GetGlobal("AUT_Race_PracticeFlag") == 3) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_ReturnFromRace detects that AUT_Race_PracticeFlag == 3; fade in and save")
    StartFadeIn(0.5)
    FireUser3("GremlinOpensCaveCam")
    AUT_SaveCheckpoint("ControlTower")
    if (GetGlobal("Autotopia_Core_Progression") == 1) then
      ForEachEntityInGroup(Hide, "racePumpPipes")
    end
    if (GetGlobal("Autotopia_Core_Progression") == 3) then
      ForEachEntityInGroup(Hide, "Derby01Obstacle")
      ForEachEntityInGroup(Hide, "Derby02Obstacle")
      ForEachEntityInGroup(Hide, "Derby03Obstacle")
      ForEachEntityInGroup(Hide, "Derby04Obstacle")
    end
  end
  return 
end
AUT_ScrapMetalCheck = function()
  local player = _player()
  local scrap = GetCurrency("ScrapMetal")
  SetGlobal("AUT_LogicCheck", scrap)
  wait(0.009999999776482582)
  return 
end
AUT_EticketsCheck = function()
  local player = _player()
  local tickets = GetTicketCount()
  SetGlobal("AUT_LogicCheck", tickets)
  wait(0.009999999776482582)
  return 
end
AUT_GremlinFreed_in1stVisit = function()
end
AUT_WaitForStream = function()
  wait(0.10000000149011612)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GateZoneLoaded called! Waiting for Stream to complete.")
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
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GateZoneLoaded - stream has finished.")
  return 
end
AUT_SwitchThinnerGate_ZoneD = function()
  TimerDisable("StreamTunnel_LogicTimerMarker 01")
  ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp_Success")
  AUT_SwitchThinnerGate("D", "last")
  return 
end
AUT_SwitchThinnerGate = function(gate, phase)
  if (gate == "B") then
    Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area B; AUT_GateB is set to " .. GetGlobal("AUT_GateB")) .. "!"))
    if (GetGlobal("AUT_GateB") == 1) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called; TUNNEL B GATE CLOSING TO ZONE A")
      Enable("ZoneB_ThinnerGate_A_TriggerDamageBase 01")
      AnimGBSequence("ZoneB_ThinnerGate_A_fireColumn 01", "turnOnLeft", true)
      AnimGBSequence("ZoneB_ThinnerGate_A_fireColumn 02", "turnOnRight", true)
      AudioPostEventOn("ZoneB_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
      ForEachEntityInGroup(Unhide, "ZoneB_ThinnerGate_A_Collision")
      AnimGBSequence("ZoneB_TankA", "FillUp", true)
      SetRotatorMaxSpeed("ZoneB_LoadGear", 120)
      AudioPostEventOn("ZoneB_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
      SetGlobal("AUT_GateB", 2)
      if (GetGlobal("EM2_EpisodeCheck") < 4) then
        SetPropertyEntity("FirstBwrxSpawner 01", "Spawn Destinations", "tcy_autotopia_01d_both.PatrolNode 01", 0)
        ForEachEntityInGroup(SetNextPatrolNode, "BlotworxPatrol", "tcy_autotopia_01a_shared.PatrolNode 08")
        if (AUT_BwrxPatrol01 ~= 0) then
          Kill(AUT_BwrxPatrol01)
          AUT_BwrxPatrol01 = 0
        end
        if (AUT_BwrxPatrol02 ~= 0) then
          Kill(AUT_BwrxPatrol02)
          AUT_BwrxPatrol02 = 0
        end
        StreamZones(GetPlayer(), "SectionC_first.part")
      elseif (GetGlobal("EM2_EpisodeCheck") == 4) then
        if (GetGlobal("Autotopia_PlayerCar") == -1) then
          StreamZones(GetPlayer(), "SectionC_second.part")
        elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
          if (GetGlobal("Autotopia_Core_State") == 1) then
            StreamZones(GetPlayer(), "SectionC_trial.part")
          else
            StreamZones(GetPlayer(), "SectionC_derby.part")
          end
        end
      end
      AUT_SaveCheckpoint("Tunnel01")
      AUT_WaitForStream()
      AUT_Zone_Loaded(GetPlayer(), "C")
    elseif (GetGlobal("AUT_GateB") == 2) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called; TUNNEL B GATE CLOSING TO ZONE C")
      Enable("ZoneB_ThinnerGate_C_TriggerDamageBase 01")
      AnimGBSequence("ZoneB_ThinnerGate_C_fireColumn 01", "turnOnRight", true)
      AnimGBSequence("ZoneB_ThinnerGate_C_fireColumn 02", "turnOnLeft", true)
      AudioPostEventOn("ZoneB_ThinnerGate_C_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
      ForEachEntityInGroup(Unhide, "ZoneB_ThinnerGate_C_Collision")
      AnimGBSequence("ZoneB_TankC", "FillUp", true)
      SetRotatorMaxSpeed("ZoneB_LoadGear", 120)
      AudioPostEventOn("ZoneB_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
      SetGlobal("AUT_GateB", 1)
      if (GetGlobal("EM2_EpisodeCheck") < 4) then
        if (GetGlobal("Autotopia_Siphon03") == 0) then
          StreamZones(GetPlayer(), "SectionA_first.part")
          SetPropertyEntity("FirstBwrxSpawner 01", "Spawn Destinations", "FirstBwrxSpawner 01", 0)
        else
          StreamZones(GetPlayer(), "SectionG_first.part")
          if (GetGlobal("Autotopia_PlayerCar") == -1) then
            StreamZones(GetPlayer(), "SectionA_second.part")
          elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
            if (GetGlobal("Autotopia_Core_State") == 1) then
              StreamZones(GetPlayer(), "SectionA_trial.part")
            else
              StreamZones(GetPlayer(), "SectionA_derby.part")
            end
          end
        end
      elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
        StreamZones(GetPlayer(), "SectionA_second.part")
      elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
        if (GetGlobal("Autotopia_Core_State") == 1) then
          StreamZones(GetPlayer(), "SectionA_trial.part")
        else
          StreamZones(GetPlayer(), "SectionA_derby.part")
        end
      end
      AUT_SaveCheckpoint("Tunnel01")
      AUT_WaitForStream()
      AUT_Zone_Loaded(GetPlayer(), "A")
      if (gate == "D") then
        Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area D; AUT_GateD is set to " .. GetGlobal("AUT_GateD")) .. "!"))
        if (GetGlobal("AUT_GateD") == 1) then
          if (phase == "first") then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called; TUNNEL D GATE CLOSING TO ZONE C")
            Enable("ZoneD_ThinnerGate_C_TriggerDamageBase 01")
            AnimGBSequence("ZoneD_ThinnerGate_C_fireColumn 01", "turnOnLeft", true)
            AnimGBSequence("ZoneD_ThinnerGate_C_fireColumn 02", "turnOnRight", true)
            AudioPostEventOn("ZoneD_ThinnerGate_C_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
            ForEachEntityInGroup(Unhide, "ZoneD_ThinnerGate_C_Collision")
            if (GetGlobal("EM2_EpisodeCheck") < 4) then
              StreamZones(GetPlayer(), "SectionE_first.part")
              Disable("FirstBwrxSpawner 01")
            elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
              StreamZones(GetPlayer(), "SectionE_second.part")
            elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
              if (GetGlobal("Autotopia_Core_State") == 1) then
                StreamZones(GetPlayer(), "SectionE_trial.part")
              else
                StreamZones(GetPlayer(), "SectionE_derby.part")
                if (phase == "last") then
                  AUT_StreamingActive = 1
                  AUT_CoopSet03_TanksSetup = 3
                  SetGlobal("AUT_GateD", 2)
                  AUT_SaveCheckpoint("Tunnel02")
                  AnimGBSequence("ZoneD_TankC", "FillUp", true)
                  wait(1)
                  AUT_WaitForStream()
                  AUT_Zone_Loaded(GetPlayer(), "E")
                  if (GetGlobal("AUT_GateD") == 2) then
                    if (phase == "first") then
                      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called; TUNNEL D GATE CLOSING TO ZONE E")
                      Enable("ZoneD_ThinnerGate_E_TriggerDamageBase 01")
                      AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 01", "turnOnLeft", true)
                      AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 02", "turnOnRight", true)
                      AudioPostEventOn("ZoneD_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                      ForEachEntityInGroup(Unhide, "ZoneD_ThinnerGate_E_Collision")
                      if (GetGlobal("EM2_EpisodeCheck") < 4) then
                        StreamZones(GetPlayer(), "SectionC_first.part")
                      elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                        StreamZones(GetPlayer(), "SectionC_second.part")
                      elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                        if (GetGlobal("Autotopia_Core_State") == 1) then
                          StreamZones(GetPlayer(), "SectionC_trial.part")
                        else
                          StreamZones(GetPlayer(), "SectionC_derby.part")
                          if (phase == "last") then
                            AUT_StreamingActive = 1
                            AUT_CoopSet03_TanksSetup = 3
                            SetGlobal("AUT_GateD", 1)
                            AUT_SaveCheckpoint("Tunnel02")
                            AnimGBSequence("ZoneD_TankE", "FillUp", true)
                            wait(1)
                            AUT_WaitForStream()
                            AUT_Zone_Loaded(GetPlayer(), "C")
                            if (gate == "F") then
                              Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
                              if (GetGlobal("AUT_GateF") == 2) then
                                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
                                Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
                                AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
                                AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
                                AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                                ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
                                ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
                                ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                                ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                                SetGlobal("AUT_GateF", 1)
                                wait(1)
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  StreamZones(GetPlayer(), "SectionE_first.part")
                                elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                                  StreamZones(GetPlayer(), "SectionE_second.part")
                                elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                                  if (GetGlobal("Autotopia_Core_State") == 1) then
                                    StreamZones(GetPlayer(), "SectionE_trial.part")
                                  else
                                    StreamZones(GetPlayer(), "SectionE_derby.part")
                                  end
                                end
                                AUT_SaveCheckpoint("Tunnel03")
                                AUT_WaitForStream()
                                AUT_Zone_Loaded(GetPlayer(), "E")
                              elseif (GetGlobal("AUT_GateF") == 1) then
                                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
                                Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
                                AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
                                AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
                                AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                                ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
                                ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
                                ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                                ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                                SetGlobal("AUT_GateF", 2)
                                wait(1)
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  StreamZones(GetPlayer(), "SectionG_first.part")
                                elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                                  StreamZones(GetPlayer(), "SectionA_second.part")
                                elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                                  if (GetGlobal("Autotopia_Core_State") == 1) then
                                    StreamZones(GetPlayer(), "SectionA_trial.part")
                                  else
                                    StreamZones(GetPlayer(), "SectionA_derby.part")
                                  end
                                end
                                AUT_SaveCheckpoint("Tunnel03")
                                AUT_WaitForStream()
                                AUT_Zone_Loaded(GetPlayer(), "A")
                              end
                            end
                          end
                        end
                      end
                    elseif (phase == "last") then
                      AUT_StreamingActive = 1
                      AUT_CoopSet03_TanksSetup = 3
                      SetGlobal("AUT_GateD", 1)
                      AUT_SaveCheckpoint("Tunnel02")
                      AnimGBSequence("ZoneD_TankE", "FillUp", true)
                      wait(1)
                      AUT_WaitForStream()
                      AUT_Zone_Loaded(GetPlayer(), "C")
                      if (gate == "F") then
                        Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
                        if (GetGlobal("AUT_GateF") == 2) then
                          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
                          Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
                          AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
                          AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
                          AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                          ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
                          ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
                          ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                          ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                          SetGlobal("AUT_GateF", 1)
                          wait(1)
                          if (GetGlobal("EM2_EpisodeCheck") < 4) then
                            StreamZones(GetPlayer(), "SectionE_first.part")
                          elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                            StreamZones(GetPlayer(), "SectionE_second.part")
                          elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                            if (GetGlobal("Autotopia_Core_State") == 1) then
                              StreamZones(GetPlayer(), "SectionE_trial.part")
                            else
                              StreamZones(GetPlayer(), "SectionE_derby.part")
                            end
                          end
                          AUT_SaveCheckpoint("Tunnel03")
                          AUT_WaitForStream()
                          AUT_Zone_Loaded(GetPlayer(), "E")
                        elseif (GetGlobal("AUT_GateF") == 1) then
                          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
                          Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
                          AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
                          AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
                          AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                          ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
                          ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
                          ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                          ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                          SetGlobal("AUT_GateF", 2)
                          wait(1)
                          if (GetGlobal("EM2_EpisodeCheck") < 4) then
                            StreamZones(GetPlayer(), "SectionG_first.part")
                          elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                            StreamZones(GetPlayer(), "SectionA_second.part")
                          elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                            if (GetGlobal("Autotopia_Core_State") == 1) then
                              StreamZones(GetPlayer(), "SectionA_trial.part")
                            else
                              StreamZones(GetPlayer(), "SectionA_derby.part")
                            end
                          end
                          AUT_SaveCheckpoint("Tunnel03")
                          AUT_WaitForStream()
                          AUT_Zone_Loaded(GetPlayer(), "A")
                        end
                      end
                    end
                  end
                end
              end
            end
          elseif (phase == "last") then
            AUT_StreamingActive = 1
            AUT_CoopSet03_TanksSetup = 3
            SetGlobal("AUT_GateD", 2)
            AUT_SaveCheckpoint("Tunnel02")
            AnimGBSequence("ZoneD_TankC", "FillUp", true)
            wait(1)
            AUT_WaitForStream()
            AUT_Zone_Loaded(GetPlayer(), "E")
            if (GetGlobal("AUT_GateD") == 2) then
              if (phase == "first") then
                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called; TUNNEL D GATE CLOSING TO ZONE E")
                Enable("ZoneD_ThinnerGate_E_TriggerDamageBase 01")
                AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 01", "turnOnLeft", true)
                AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 02", "turnOnRight", true)
                AudioPostEventOn("ZoneD_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                ForEachEntityInGroup(Unhide, "ZoneD_ThinnerGate_E_Collision")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  StreamZones(GetPlayer(), "SectionC_first.part")
                elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                  StreamZones(GetPlayer(), "SectionC_second.part")
                elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                  if (GetGlobal("Autotopia_Core_State") == 1) then
                    StreamZones(GetPlayer(), "SectionC_trial.part")
                  else
                    StreamZones(GetPlayer(), "SectionC_derby.part")
                    if (phase == "last") then
                      AUT_StreamingActive = 1
                      AUT_CoopSet03_TanksSetup = 3
                      SetGlobal("AUT_GateD", 1)
                      AUT_SaveCheckpoint("Tunnel02")
                      AnimGBSequence("ZoneD_TankE", "FillUp", true)
                      wait(1)
                      AUT_WaitForStream()
                      AUT_Zone_Loaded(GetPlayer(), "C")
                      if (gate == "F") then
                        Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
                        if (GetGlobal("AUT_GateF") == 2) then
                          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
                          Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
                          AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
                          AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
                          AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                          ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
                          ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
                          ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                          ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                          SetGlobal("AUT_GateF", 1)
                          wait(1)
                          if (GetGlobal("EM2_EpisodeCheck") < 4) then
                            StreamZones(GetPlayer(), "SectionE_first.part")
                          elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                            StreamZones(GetPlayer(), "SectionE_second.part")
                          elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                            if (GetGlobal("Autotopia_Core_State") == 1) then
                              StreamZones(GetPlayer(), "SectionE_trial.part")
                            else
                              StreamZones(GetPlayer(), "SectionE_derby.part")
                            end
                          end
                          AUT_SaveCheckpoint("Tunnel03")
                          AUT_WaitForStream()
                          AUT_Zone_Loaded(GetPlayer(), "E")
                        elseif (GetGlobal("AUT_GateF") == 1) then
                          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
                          Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
                          AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
                          AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
                          AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                          ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
                          ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
                          ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                          ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                          SetGlobal("AUT_GateF", 2)
                          wait(1)
                          if (GetGlobal("EM2_EpisodeCheck") < 4) then
                            StreamZones(GetPlayer(), "SectionG_first.part")
                          elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                            StreamZones(GetPlayer(), "SectionA_second.part")
                          elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                            if (GetGlobal("Autotopia_Core_State") == 1) then
                              StreamZones(GetPlayer(), "SectionA_trial.part")
                            else
                              StreamZones(GetPlayer(), "SectionA_derby.part")
                            end
                          end
                          AUT_SaveCheckpoint("Tunnel03")
                          AUT_WaitForStream()
                          AUT_Zone_Loaded(GetPlayer(), "A")
                        end
                      end
                    end
                  end
                end
              elseif (phase == "last") then
                AUT_StreamingActive = 1
                AUT_CoopSet03_TanksSetup = 3
                SetGlobal("AUT_GateD", 1)
                AUT_SaveCheckpoint("Tunnel02")
                AnimGBSequence("ZoneD_TankE", "FillUp", true)
                wait(1)
                AUT_WaitForStream()
                AUT_Zone_Loaded(GetPlayer(), "C")
                if (gate == "F") then
                  Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
                  if (GetGlobal("AUT_GateF") == 2) then
                    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
                    Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
                    AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
                    AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
                    AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                    ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
                    ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
                    ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                    ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                    SetGlobal("AUT_GateF", 1)
                    wait(1)
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      StreamZones(GetPlayer(), "SectionE_first.part")
                    elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                      StreamZones(GetPlayer(), "SectionE_second.part")
                    elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                      if (GetGlobal("Autotopia_Core_State") == 1) then
                        StreamZones(GetPlayer(), "SectionE_trial.part")
                      else
                        StreamZones(GetPlayer(), "SectionE_derby.part")
                      end
                    end
                    AUT_SaveCheckpoint("Tunnel03")
                    AUT_WaitForStream()
                    AUT_Zone_Loaded(GetPlayer(), "E")
                  elseif (GetGlobal("AUT_GateF") == 1) then
                    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
                    Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
                    AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
                    AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
                    AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                    ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
                    ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
                    ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                    ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                    SetGlobal("AUT_GateF", 2)
                    wait(1)
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      StreamZones(GetPlayer(), "SectionG_first.part")
                    elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                      StreamZones(GetPlayer(), "SectionA_second.part")
                    elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                      if (GetGlobal("Autotopia_Core_State") == 1) then
                        StreamZones(GetPlayer(), "SectionA_trial.part")
                      else
                        StreamZones(GetPlayer(), "SectionA_derby.part")
                      end
                    end
                    AUT_SaveCheckpoint("Tunnel03")
                    AUT_WaitForStream()
                    AUT_Zone_Loaded(GetPlayer(), "A")
                  end
                end
              end
            end
          end
        elseif (GetGlobal("AUT_GateD") == 2) then
          if (phase == "first") then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called; TUNNEL D GATE CLOSING TO ZONE E")
            Enable("ZoneD_ThinnerGate_E_TriggerDamageBase 01")
            AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 01", "turnOnLeft", true)
            AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 02", "turnOnRight", true)
            AudioPostEventOn("ZoneD_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
            ForEachEntityInGroup(Unhide, "ZoneD_ThinnerGate_E_Collision")
            if (GetGlobal("EM2_EpisodeCheck") < 4) then
              StreamZones(GetPlayer(), "SectionC_first.part")
            elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
              StreamZones(GetPlayer(), "SectionC_second.part")
            elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
              if (GetGlobal("Autotopia_Core_State") == 1) then
                StreamZones(GetPlayer(), "SectionC_trial.part")
              else
                StreamZones(GetPlayer(), "SectionC_derby.part")
                if (phase == "last") then
                  AUT_StreamingActive = 1
                  AUT_CoopSet03_TanksSetup = 3
                  SetGlobal("AUT_GateD", 1)
                  AUT_SaveCheckpoint("Tunnel02")
                  AnimGBSequence("ZoneD_TankE", "FillUp", true)
                  wait(1)
                  AUT_WaitForStream()
                  AUT_Zone_Loaded(GetPlayer(), "C")
                  if (gate == "F") then
                    Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
                    if (GetGlobal("AUT_GateF") == 2) then
                      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
                      Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
                      AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
                      AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
                      AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                      ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
                      ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
                      ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                      ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                      SetGlobal("AUT_GateF", 1)
                      wait(1)
                      if (GetGlobal("EM2_EpisodeCheck") < 4) then
                        StreamZones(GetPlayer(), "SectionE_first.part")
                      elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                        StreamZones(GetPlayer(), "SectionE_second.part")
                      elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                        if (GetGlobal("Autotopia_Core_State") == 1) then
                          StreamZones(GetPlayer(), "SectionE_trial.part")
                        else
                          StreamZones(GetPlayer(), "SectionE_derby.part")
                        end
                      end
                      AUT_SaveCheckpoint("Tunnel03")
                      AUT_WaitForStream()
                      AUT_Zone_Loaded(GetPlayer(), "E")
                    elseif (GetGlobal("AUT_GateF") == 1) then
                      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
                      Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
                      AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
                      AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
                      AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                      ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
                      ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
                      ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                      ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                      SetGlobal("AUT_GateF", 2)
                      wait(1)
                      if (GetGlobal("EM2_EpisodeCheck") < 4) then
                        StreamZones(GetPlayer(), "SectionG_first.part")
                      elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                        StreamZones(GetPlayer(), "SectionA_second.part")
                      elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                        if (GetGlobal("Autotopia_Core_State") == 1) then
                          StreamZones(GetPlayer(), "SectionA_trial.part")
                        else
                          StreamZones(GetPlayer(), "SectionA_derby.part")
                        end
                      end
                      AUT_SaveCheckpoint("Tunnel03")
                      AUT_WaitForStream()
                      AUT_Zone_Loaded(GetPlayer(), "A")
                    end
                  end
                end
              end
            end
          elseif (phase == "last") then
            AUT_StreamingActive = 1
            AUT_CoopSet03_TanksSetup = 3
            SetGlobal("AUT_GateD", 1)
            AUT_SaveCheckpoint("Tunnel02")
            AnimGBSequence("ZoneD_TankE", "FillUp", true)
            wait(1)
            AUT_WaitForStream()
            AUT_Zone_Loaded(GetPlayer(), "C")
            if (gate == "F") then
              Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
              if (GetGlobal("AUT_GateF") == 2) then
                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
                Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
                AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
                AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
                AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
                ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
                ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                SetGlobal("AUT_GateF", 1)
                wait(1)
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  StreamZones(GetPlayer(), "SectionE_first.part")
                elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                  StreamZones(GetPlayer(), "SectionE_second.part")
                elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                  if (GetGlobal("Autotopia_Core_State") == 1) then
                    StreamZones(GetPlayer(), "SectionE_trial.part")
                  else
                    StreamZones(GetPlayer(), "SectionE_derby.part")
                  end
                end
                AUT_SaveCheckpoint("Tunnel03")
                AUT_WaitForStream()
                AUT_Zone_Loaded(GetPlayer(), "E")
              elseif (GetGlobal("AUT_GateF") == 1) then
                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
                Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
                AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
                AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
                AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
                ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
                ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                SetGlobal("AUT_GateF", 2)
                wait(1)
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  StreamZones(GetPlayer(), "SectionG_first.part")
                elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                  StreamZones(GetPlayer(), "SectionA_second.part")
                elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                  if (GetGlobal("Autotopia_Core_State") == 1) then
                    StreamZones(GetPlayer(), "SectionA_trial.part")
                  else
                    StreamZones(GetPlayer(), "SectionA_derby.part")
                  end
                end
                AUT_SaveCheckpoint("Tunnel03")
                AUT_WaitForStream()
                AUT_Zone_Loaded(GetPlayer(), "A")
              end
            end
          end
        end
      elseif (gate == "F") then
        Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
        if (GetGlobal("AUT_GateF") == 2) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
          Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
          AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
          AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
          AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
          ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
          ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
          ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
          ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
          SetGlobal("AUT_GateF", 1)
          wait(1)
          if (GetGlobal("EM2_EpisodeCheck") < 4) then
            StreamZones(GetPlayer(), "SectionE_first.part")
          elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
            StreamZones(GetPlayer(), "SectionE_second.part")
          elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
            if (GetGlobal("Autotopia_Core_State") == 1) then
              StreamZones(GetPlayer(), "SectionE_trial.part")
            else
              StreamZones(GetPlayer(), "SectionE_derby.part")
            end
          end
          AUT_SaveCheckpoint("Tunnel03")
          AUT_WaitForStream()
          AUT_Zone_Loaded(GetPlayer(), "E")
        elseif (GetGlobal("AUT_GateF") == 1) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
          Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
          AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
          AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
          AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
          ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
          ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
          ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
          ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
          SetGlobal("AUT_GateF", 2)
          wait(1)
          if (GetGlobal("EM2_EpisodeCheck") < 4) then
            StreamZones(GetPlayer(), "SectionG_first.part")
          elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
            StreamZones(GetPlayer(), "SectionA_second.part")
          elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
            if (GetGlobal("Autotopia_Core_State") == 1) then
              StreamZones(GetPlayer(), "SectionA_trial.part")
            else
              StreamZones(GetPlayer(), "SectionA_derby.part")
            end
          end
          AUT_SaveCheckpoint("Tunnel03")
          AUT_WaitForStream()
          AUT_Zone_Loaded(GetPlayer(), "A")
        end
      end
    end
  elseif (gate == "D") then
    Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area D; AUT_GateD is set to " .. GetGlobal("AUT_GateD")) .. "!"))
    if (GetGlobal("AUT_GateD") == 1) then
      if (phase == "first") then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called; TUNNEL D GATE CLOSING TO ZONE C")
        Enable("ZoneD_ThinnerGate_C_TriggerDamageBase 01")
        AnimGBSequence("ZoneD_ThinnerGate_C_fireColumn 01", "turnOnLeft", true)
        AnimGBSequence("ZoneD_ThinnerGate_C_fireColumn 02", "turnOnRight", true)
        AudioPostEventOn("ZoneD_ThinnerGate_C_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
        ForEachEntityInGroup(Unhide, "ZoneD_ThinnerGate_C_Collision")
        if (GetGlobal("EM2_EpisodeCheck") < 4) then
          StreamZones(GetPlayer(), "SectionE_first.part")
          Disable("FirstBwrxSpawner 01")
        elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
          StreamZones(GetPlayer(), "SectionE_second.part")
        elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
          if (GetGlobal("Autotopia_Core_State") == 1) then
            StreamZones(GetPlayer(), "SectionE_trial.part")
          else
            StreamZones(GetPlayer(), "SectionE_derby.part")
            if (phase == "last") then
              AUT_StreamingActive = 1
              AUT_CoopSet03_TanksSetup = 3
              SetGlobal("AUT_GateD", 2)
              AUT_SaveCheckpoint("Tunnel02")
              AnimGBSequence("ZoneD_TankC", "FillUp", true)
              wait(1)
              AUT_WaitForStream()
              AUT_Zone_Loaded(GetPlayer(), "E")
              if (GetGlobal("AUT_GateD") == 2) then
                if (phase == "first") then
                  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called; TUNNEL D GATE CLOSING TO ZONE E")
                  Enable("ZoneD_ThinnerGate_E_TriggerDamageBase 01")
                  AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 01", "turnOnLeft", true)
                  AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 02", "turnOnRight", true)
                  AudioPostEventOn("ZoneD_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                  ForEachEntityInGroup(Unhide, "ZoneD_ThinnerGate_E_Collision")
                  if (GetGlobal("EM2_EpisodeCheck") < 4) then
                    StreamZones(GetPlayer(), "SectionC_first.part")
                  elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                    StreamZones(GetPlayer(), "SectionC_second.part")
                  elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                    if (GetGlobal("Autotopia_Core_State") == 1) then
                      StreamZones(GetPlayer(), "SectionC_trial.part")
                    else
                      StreamZones(GetPlayer(), "SectionC_derby.part")
                      if (phase == "last") then
                        AUT_StreamingActive = 1
                        AUT_CoopSet03_TanksSetup = 3
                        SetGlobal("AUT_GateD", 1)
                        AUT_SaveCheckpoint("Tunnel02")
                        AnimGBSequence("ZoneD_TankE", "FillUp", true)
                        wait(1)
                        AUT_WaitForStream()
                        AUT_Zone_Loaded(GetPlayer(), "C")
                        if (gate == "F") then
                          Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
                          if (GetGlobal("AUT_GateF") == 2) then
                            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
                            Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
                            AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
                            AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
                            AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                            ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
                            ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
                            ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                            ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                            SetGlobal("AUT_GateF", 1)
                            wait(1)
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              StreamZones(GetPlayer(), "SectionE_first.part")
                            elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                              StreamZones(GetPlayer(), "SectionE_second.part")
                            elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                              if (GetGlobal("Autotopia_Core_State") == 1) then
                                StreamZones(GetPlayer(), "SectionE_trial.part")
                              else
                                StreamZones(GetPlayer(), "SectionE_derby.part")
                              end
                            end
                            AUT_SaveCheckpoint("Tunnel03")
                            AUT_WaitForStream()
                            AUT_Zone_Loaded(GetPlayer(), "E")
                          elseif (GetGlobal("AUT_GateF") == 1) then
                            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
                            Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
                            AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
                            AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
                            AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                            ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
                            ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
                            ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                            ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                            SetGlobal("AUT_GateF", 2)
                            wait(1)
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              StreamZones(GetPlayer(), "SectionG_first.part")
                            elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                              StreamZones(GetPlayer(), "SectionA_second.part")
                            elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                              if (GetGlobal("Autotopia_Core_State") == 1) then
                                StreamZones(GetPlayer(), "SectionA_trial.part")
                              else
                                StreamZones(GetPlayer(), "SectionA_derby.part")
                              end
                            end
                            AUT_SaveCheckpoint("Tunnel03")
                            AUT_WaitForStream()
                            AUT_Zone_Loaded(GetPlayer(), "A")
                          end
                        end
                      end
                    end
                  end
                elseif (phase == "last") then
                  AUT_StreamingActive = 1
                  AUT_CoopSet03_TanksSetup = 3
                  SetGlobal("AUT_GateD", 1)
                  AUT_SaveCheckpoint("Tunnel02")
                  AnimGBSequence("ZoneD_TankE", "FillUp", true)
                  wait(1)
                  AUT_WaitForStream()
                  AUT_Zone_Loaded(GetPlayer(), "C")
                  if (gate == "F") then
                    Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
                    if (GetGlobal("AUT_GateF") == 2) then
                      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
                      Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
                      AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
                      AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
                      AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                      ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
                      ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
                      ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                      ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                      SetGlobal("AUT_GateF", 1)
                      wait(1)
                      if (GetGlobal("EM2_EpisodeCheck") < 4) then
                        StreamZones(GetPlayer(), "SectionE_first.part")
                      elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                        StreamZones(GetPlayer(), "SectionE_second.part")
                      elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                        if (GetGlobal("Autotopia_Core_State") == 1) then
                          StreamZones(GetPlayer(), "SectionE_trial.part")
                        else
                          StreamZones(GetPlayer(), "SectionE_derby.part")
                        end
                      end
                      AUT_SaveCheckpoint("Tunnel03")
                      AUT_WaitForStream()
                      AUT_Zone_Loaded(GetPlayer(), "E")
                    elseif (GetGlobal("AUT_GateF") == 1) then
                      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
                      Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
                      AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
                      AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
                      AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                      ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
                      ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
                      ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                      ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                      SetGlobal("AUT_GateF", 2)
                      wait(1)
                      if (GetGlobal("EM2_EpisodeCheck") < 4) then
                        StreamZones(GetPlayer(), "SectionG_first.part")
                      elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                        StreamZones(GetPlayer(), "SectionA_second.part")
                      elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                        if (GetGlobal("Autotopia_Core_State") == 1) then
                          StreamZones(GetPlayer(), "SectionA_trial.part")
                        else
                          StreamZones(GetPlayer(), "SectionA_derby.part")
                        end
                      end
                      AUT_SaveCheckpoint("Tunnel03")
                      AUT_WaitForStream()
                      AUT_Zone_Loaded(GetPlayer(), "A")
                    end
                  end
                end
              end
            end
          end
        end
      elseif (phase == "last") then
        AUT_StreamingActive = 1
        AUT_CoopSet03_TanksSetup = 3
        SetGlobal("AUT_GateD", 2)
        AUT_SaveCheckpoint("Tunnel02")
        AnimGBSequence("ZoneD_TankC", "FillUp", true)
        wait(1)
        AUT_WaitForStream()
        AUT_Zone_Loaded(GetPlayer(), "E")
        if (GetGlobal("AUT_GateD") == 2) then
          if (phase == "first") then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called; TUNNEL D GATE CLOSING TO ZONE E")
            Enable("ZoneD_ThinnerGate_E_TriggerDamageBase 01")
            AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 01", "turnOnLeft", true)
            AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 02", "turnOnRight", true)
            AudioPostEventOn("ZoneD_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
            ForEachEntityInGroup(Unhide, "ZoneD_ThinnerGate_E_Collision")
            if (GetGlobal("EM2_EpisodeCheck") < 4) then
              StreamZones(GetPlayer(), "SectionC_first.part")
            elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
              StreamZones(GetPlayer(), "SectionC_second.part")
            elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
              if (GetGlobal("Autotopia_Core_State") == 1) then
                StreamZones(GetPlayer(), "SectionC_trial.part")
              else
                StreamZones(GetPlayer(), "SectionC_derby.part")
                if (phase == "last") then
                  AUT_StreamingActive = 1
                  AUT_CoopSet03_TanksSetup = 3
                  SetGlobal("AUT_GateD", 1)
                  AUT_SaveCheckpoint("Tunnel02")
                  AnimGBSequence("ZoneD_TankE", "FillUp", true)
                  wait(1)
                  AUT_WaitForStream()
                  AUT_Zone_Loaded(GetPlayer(), "C")
                  if (gate == "F") then
                    Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
                    if (GetGlobal("AUT_GateF") == 2) then
                      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
                      Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
                      AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
                      AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
                      AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                      ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
                      ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
                      ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                      ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                      SetGlobal("AUT_GateF", 1)
                      wait(1)
                      if (GetGlobal("EM2_EpisodeCheck") < 4) then
                        StreamZones(GetPlayer(), "SectionE_first.part")
                      elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                        StreamZones(GetPlayer(), "SectionE_second.part")
                      elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                        if (GetGlobal("Autotopia_Core_State") == 1) then
                          StreamZones(GetPlayer(), "SectionE_trial.part")
                        else
                          StreamZones(GetPlayer(), "SectionE_derby.part")
                        end
                      end
                      AUT_SaveCheckpoint("Tunnel03")
                      AUT_WaitForStream()
                      AUT_Zone_Loaded(GetPlayer(), "E")
                    elseif (GetGlobal("AUT_GateF") == 1) then
                      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
                      Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
                      AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
                      AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
                      AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                      ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
                      ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
                      ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                      ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                      SetGlobal("AUT_GateF", 2)
                      wait(1)
                      if (GetGlobal("EM2_EpisodeCheck") < 4) then
                        StreamZones(GetPlayer(), "SectionG_first.part")
                      elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                        StreamZones(GetPlayer(), "SectionA_second.part")
                      elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                        if (GetGlobal("Autotopia_Core_State") == 1) then
                          StreamZones(GetPlayer(), "SectionA_trial.part")
                        else
                          StreamZones(GetPlayer(), "SectionA_derby.part")
                        end
                      end
                      AUT_SaveCheckpoint("Tunnel03")
                      AUT_WaitForStream()
                      AUT_Zone_Loaded(GetPlayer(), "A")
                    end
                  end
                end
              end
            end
          elseif (phase == "last") then
            AUT_StreamingActive = 1
            AUT_CoopSet03_TanksSetup = 3
            SetGlobal("AUT_GateD", 1)
            AUT_SaveCheckpoint("Tunnel02")
            AnimGBSequence("ZoneD_TankE", "FillUp", true)
            wait(1)
            AUT_WaitForStream()
            AUT_Zone_Loaded(GetPlayer(), "C")
            if (gate == "F") then
              Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
              if (GetGlobal("AUT_GateF") == 2) then
                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
                Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
                AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
                AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
                AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
                ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
                ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                SetGlobal("AUT_GateF", 1)
                wait(1)
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  StreamZones(GetPlayer(), "SectionE_first.part")
                elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                  StreamZones(GetPlayer(), "SectionE_second.part")
                elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                  if (GetGlobal("Autotopia_Core_State") == 1) then
                    StreamZones(GetPlayer(), "SectionE_trial.part")
                  else
                    StreamZones(GetPlayer(), "SectionE_derby.part")
                  end
                end
                AUT_SaveCheckpoint("Tunnel03")
                AUT_WaitForStream()
                AUT_Zone_Loaded(GetPlayer(), "E")
              elseif (GetGlobal("AUT_GateF") == 1) then
                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
                Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
                AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
                AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
                AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
                ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
                ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                SetGlobal("AUT_GateF", 2)
                wait(1)
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  StreamZones(GetPlayer(), "SectionG_first.part")
                elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                  StreamZones(GetPlayer(), "SectionA_second.part")
                elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                  if (GetGlobal("Autotopia_Core_State") == 1) then
                    StreamZones(GetPlayer(), "SectionA_trial.part")
                  else
                    StreamZones(GetPlayer(), "SectionA_derby.part")
                  end
                end
                AUT_SaveCheckpoint("Tunnel03")
                AUT_WaitForStream()
                AUT_Zone_Loaded(GetPlayer(), "A")
              end
            end
          end
        end
      end
    elseif (GetGlobal("AUT_GateD") == 2) then
      if (phase == "first") then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called; TUNNEL D GATE CLOSING TO ZONE E")
        Enable("ZoneD_ThinnerGate_E_TriggerDamageBase 01")
        AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 01", "turnOnLeft", true)
        AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 02", "turnOnRight", true)
        AudioPostEventOn("ZoneD_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
        ForEachEntityInGroup(Unhide, "ZoneD_ThinnerGate_E_Collision")
        if (GetGlobal("EM2_EpisodeCheck") < 4) then
          StreamZones(GetPlayer(), "SectionC_first.part")
        elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
          StreamZones(GetPlayer(), "SectionC_second.part")
        elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
          if (GetGlobal("Autotopia_Core_State") == 1) then
            StreamZones(GetPlayer(), "SectionC_trial.part")
          else
            StreamZones(GetPlayer(), "SectionC_derby.part")
            if (phase == "last") then
              AUT_StreamingActive = 1
              AUT_CoopSet03_TanksSetup = 3
              SetGlobal("AUT_GateD", 1)
              AUT_SaveCheckpoint("Tunnel02")
              AnimGBSequence("ZoneD_TankE", "FillUp", true)
              wait(1)
              AUT_WaitForStream()
              AUT_Zone_Loaded(GetPlayer(), "C")
              if (gate == "F") then
                Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
                if (GetGlobal("AUT_GateF") == 2) then
                  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
                  Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
                  AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
                  AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
                  AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                  ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
                  ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
                  ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                  ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                  SetGlobal("AUT_GateF", 1)
                  wait(1)
                  if (GetGlobal("EM2_EpisodeCheck") < 4) then
                    StreamZones(GetPlayer(), "SectionE_first.part")
                  elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                    StreamZones(GetPlayer(), "SectionE_second.part")
                  elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                    if (GetGlobal("Autotopia_Core_State") == 1) then
                      StreamZones(GetPlayer(), "SectionE_trial.part")
                    else
                      StreamZones(GetPlayer(), "SectionE_derby.part")
                    end
                  end
                  AUT_SaveCheckpoint("Tunnel03")
                  AUT_WaitForStream()
                  AUT_Zone_Loaded(GetPlayer(), "E")
                elseif (GetGlobal("AUT_GateF") == 1) then
                  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
                  Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
                  AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
                  AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
                  AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
                  ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
                  ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
                  ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
                  ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                  SetGlobal("AUT_GateF", 2)
                  wait(1)
                  if (GetGlobal("EM2_EpisodeCheck") < 4) then
                    StreamZones(GetPlayer(), "SectionG_first.part")
                  elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
                    StreamZones(GetPlayer(), "SectionA_second.part")
                  elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
                    if (GetGlobal("Autotopia_Core_State") == 1) then
                      StreamZones(GetPlayer(), "SectionA_trial.part")
                    else
                      StreamZones(GetPlayer(), "SectionA_derby.part")
                    end
                  end
                  AUT_SaveCheckpoint("Tunnel03")
                  AUT_WaitForStream()
                  AUT_Zone_Loaded(GetPlayer(), "A")
                end
              end
            end
          end
        end
      elseif (phase == "last") then
        AUT_StreamingActive = 1
        AUT_CoopSet03_TanksSetup = 3
        SetGlobal("AUT_GateD", 1)
        AUT_SaveCheckpoint("Tunnel02")
        AnimGBSequence("ZoneD_TankE", "FillUp", true)
        wait(1)
        AUT_WaitForStream()
        AUT_Zone_Loaded(GetPlayer(), "C")
        if (gate == "F") then
          Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
          if (GetGlobal("AUT_GateF") == 2) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
            Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
            AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
            AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
            AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
            ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
            ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
            ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
            ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
            SetGlobal("AUT_GateF", 1)
            wait(1)
            if (GetGlobal("EM2_EpisodeCheck") < 4) then
              StreamZones(GetPlayer(), "SectionE_first.part")
            elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
              StreamZones(GetPlayer(), "SectionE_second.part")
            elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
              if (GetGlobal("Autotopia_Core_State") == 1) then
                StreamZones(GetPlayer(), "SectionE_trial.part")
              else
                StreamZones(GetPlayer(), "SectionE_derby.part")
              end
            end
            AUT_SaveCheckpoint("Tunnel03")
            AUT_WaitForStream()
            AUT_Zone_Loaded(GetPlayer(), "E")
          elseif (GetGlobal("AUT_GateF") == 1) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
            Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
            AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
            AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
            AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
            ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
            ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
            ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
            ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
            SetGlobal("AUT_GateF", 2)
            wait(1)
            if (GetGlobal("EM2_EpisodeCheck") < 4) then
              StreamZones(GetPlayer(), "SectionG_first.part")
            elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
              StreamZones(GetPlayer(), "SectionA_second.part")
            elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
              if (GetGlobal("Autotopia_Core_State") == 1) then
                StreamZones(GetPlayer(), "SectionA_trial.part")
              else
                StreamZones(GetPlayer(), "SectionA_derby.part")
              end
            end
            AUT_SaveCheckpoint("Tunnel03")
            AUT_WaitForStream()
            AUT_Zone_Loaded(GetPlayer(), "A")
          end
        end
      end
    end
  elseif (gate == "F") then
    Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called for Area F; AUT_GateF is set to " .. GetGlobal("AUT_GateF")) .. "!"))
    if (GetGlobal("AUT_GateF") == 2) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 2; TUNNEL F GATE CLOSING TO ZONE A")
      Enable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
      AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOnRight", true)
      AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOnLeft", true)
      AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
      ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_A_Collision")
      ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "FillUp", true)
      ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
      ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
      SetGlobal("AUT_GateF", 1)
      wait(1)
      if (GetGlobal("EM2_EpisodeCheck") < 4) then
        StreamZones(GetPlayer(), "SectionE_first.part")
      elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
        StreamZones(GetPlayer(), "SectionE_second.part")
      elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
        if (GetGlobal("Autotopia_Core_State") == 1) then
          StreamZones(GetPlayer(), "SectionE_trial.part")
        else
          StreamZones(GetPlayer(), "SectionE_derby.part")
        end
      end
      AUT_SaveCheckpoint("Tunnel03")
      AUT_WaitForStream()
      AUT_Zone_Loaded(GetPlayer(), "E")
    elseif (GetGlobal("AUT_GateF") == 1) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SwitchThinnerGate called and AUT_GateF is 1; TUNNEL F GATE CLOSING TO ZONE E")
      Enable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
      AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOnRight", true)
      AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOnLeft", true)
      AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Play_sfx_AUT_thinner_curtain_LP")
      ForEachEntityInGroup(Unhide, "ZoneF_ThinnerGate_E_Collision")
      ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "FillUp", true)
      ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 120)
      ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
      SetGlobal("AUT_GateF", 2)
      wait(1)
      if (GetGlobal("EM2_EpisodeCheck") < 4) then
        StreamZones(GetPlayer(), "SectionG_first.part")
      elseif (GetGlobal("Autotopia_PlayerCar") == -1) then
        StreamZones(GetPlayer(), "SectionA_second.part")
      elseif (-1 < GetGlobal("Autotopia_PlayerCar")) then
        if (GetGlobal("Autotopia_Core_State") == 1) then
          StreamZones(GetPlayer(), "SectionA_trial.part")
        else
          StreamZones(GetPlayer(), "SectionA_derby.part")
        end
      end
      AUT_SaveCheckpoint("Tunnel03")
      AUT_WaitForStream()
      AUT_Zone_Loaded(GetPlayer(), "A")
    end
  end
  return 
end
AUT_CurtainToLoop = function(target, side)
  if (side == "L") then
    AnimGBSequence(target, "loopLeft")
  elseif (side == "R") then
    AnimGBSequence(target, "loopRight")
  end
  return 
end
AUT_GateZoneLoaded = function(target, zone)
  CoopGate02_Activated = 0
  if (zone == "A") then
    if (GetGlobal("EM2_EpisodeCheck") < 4) then
      AUT_Damage_MainContainer()
    end
    if IsValidHandle("ZoneB_ThinnerGate_A_TriggerDamageBase 01") then
      if (0 < GetGlobal("Autotopia_Siphon01")) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GateZoneLoaded - TUNNEL B GATE OPENS TO ZONE A")
        SetGlobal("AUT_GateB", 1)
        Disable("ZoneB_ThinnerGate_A_TriggerDamageBase 01")
        AudioPostEventOn("ZoneB_ThinnerGate_A_fireColumn 01", "Stop_sfx_AUT_thinner_curtain_LP")
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GateZoneLoaded - ZoneB_ThinnerGate_A_fireColumn - Stop_sfx_AUT_thinner_curtain_LP")
        AnimGBSequence("ZoneB_ThinnerGate_A_fireColumn 01", "turnOffLeft")
        AnimGBSequence("ZoneB_ThinnerGate_A_fireColumn 02", "turnOffRight")
        ForEachEntityInGroup(Hide, "ZoneB_ThinnerGate_A_Collision")
        AnimGBSequence("ZoneB_TankA", "Empty")
        SetRotatorMaxSpeed("ZoneB_LoadGear", 0)
        AudioPostEventOn("ZoneB_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
      end
    end
    if IsValidHandle("ZoneF_ThinnerGate_A_TriggerDamageBase 01") then
      if (0 < GetGlobal("Autotopia_Siphon03")) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GateZoneLoaded - TUNNEL F GATE OPENS TO ZONE A")
        SetGlobal("AUT_GateF", 2)
        Disable("ZoneF_ThinnerGate_A_TriggerDamageBase 01")
        AudioPostEventOn("ZoneF_ThinnerGate_A_fireColumn 01", "Stop_sfx_AUT_thinner_curtain_LP")
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GateZoneLoaded - ZoneF_ThinnerGate_A_fireColumn - Stop_sfx_AUT_thinner_curtain_LP")
        AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 01", "turnOffRight")
        AnimGBSequence("ZoneF_ThinnerGate_A_fireColumn 02", "turnOffLeft")
        ForEachEntityInGroup(Hide, "ZoneF_ThinnerGate_A_Collision")
        ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankA", "Empty")
        ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 0)
      end
    end
  elseif (zone == "C") then
    if IsValidHandle("ZoneB_ThinnerGate_C_TriggerDamageBase 01") then
      if (0 < GetGlobal("Autotopia_Siphon01")) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GateZoneLoaded - TUNNEL B GATE OPENS TO ZONE C")
        SetGlobal("AUT_GateB", 2)
        Disable("ZoneB_ThinnerGate_C_TriggerDamageBase 01")
        AudioPostEventOn("ZoneB_ThinnerGate_C_fireColumn 01", "Stop_sfx_AUT_thinner_curtain_LP")
        AnimGBSequence("ZoneB_ThinnerGate_C_fireColumn 01", "turnOffRight")
        AnimGBSequence("ZoneB_ThinnerGate_C_fireColumn 02", "turnOffLeft")
        ForEachEntityInGroup(Hide, "ZoneB_ThinnerGate_C_Collision")
        AnimGBSequence("ZoneB_TankC", "Empty")
        SetRotatorMaxSpeed("ZoneB_LoadGear", 0)
        AudioPostEventOn("ZoneB_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
      end
    end
    if IsValidHandle("ZoneD_ThinnerGate_C_TriggerDamageBase 01") then
      if (0 < GetGlobal("Autotopia_Siphon02")) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GateZoneLoaded - TUNNEL D GATE OPENS TO ZONE C")
        SetGlobal("AUT_GateD", 1)
        Disable("ZoneD_ThinnerGate_C_TriggerDamageBase 01")
        AudioPostEventOn("ZoneD_ThinnerGate_C_fireColumn 0", "Stop_sfx_AUT_thinner_curtain_LP")
        AnimGBSequence("ZoneD_ThinnerGate_C_fireColumn 01", "turnOffLeft")
        AnimGBSequence("ZoneD_ThinnerGate_C_fireColumn 02", "turnOffRight")
        ForEachEntityInGroup(Hide, "ZoneD_ThinnerGate_C_Collision")
        AnimGBSequence("ZoneD_TankC", "Empty")
        SetRotatorMaxSpeed("ZoneD_LoadGear", 0)
        AudioPostEventOn("ZoneD_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
      end
    end
  elseif (zone == "E") then
    if IsValidHandle("ZoneD_ThinnerGate_E_TriggerDamageBase 01") then
      if (0 < GetGlobal("Autotopia_Siphon02")) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GateZoneLoaded - TUNNEL D GATE OPENS TO ZONE E")
        SetGlobal("AUT_GateD", 2)
        Disable("ZoneD_ThinnerGate_E_TriggerDamageBase 01")
        AudioPostEventOn("ZoneD_ThinnerGate_E_fireColumn 01", "Stop_sfx_AUT_thinner_curtain_LP")
        AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 01", "turnOffLeft")
        AnimGBSequence("ZoneD_ThinnerGate_E_fireColumn 02", "turnOffRight")
        ForEachEntityInGroup(Hide, "ZoneD_ThinnerGate_E_Collision")
        AnimGBSequence("ZoneD_TankE", "Empty")
        SetRotatorMaxSpeed("ZoneD_LoadGear", 0)
        AudioPostEventOn("ZoneD_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
      end
    end
    if IsValidHandle("ZoneF_ThinnerGate_E_TriggerDamageBase 01") then
      if (0 < GetGlobal("Autotopia_Siphon03")) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GateZoneLoaded - TUNNEL F GATE OPENS TO ZONE E")
        SetGlobal("AUT_GateF", 1)
        Disable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
        AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Stop_sfx_AUT_thinner_curtain_LP")
        AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOffRight")
        AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOffLeft")
        ForEachEntityInGroup(Hide, "ZoneF_ThinnerGate_E_Collision")
        ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "Empty")
        ForEachEntityInGroup(SetRotatorMaxSpeed, "ZoneF_LoadGear", 0)
        ForEachEntityInGroup(AudioPostEventOn, "ZoneF_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
      end
    end
    if (GetGlobal("Autotopia_CostumeCaveOpen") ~= 0) then
      if IsValidHandle("GarageDebris") then
        ForEachEntityInGroup(DestroyEntity, "GarageDebris")
      end
    end
  end
  return 
end
AUT_SetupGuardianPool = function(target)
  if (GetGlobal("Autotopia_Core_State") == 1) then
    local data = GetPrefabData(target)
    data.GP_ThinThreshold = 0
    Prefab_ChangeGuardianPoolState(target)
  end
  return 
end
AUT_SetupZoneA_Tower = function()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SetupZoneA_Tower called!!")
  if (0 < GetGlobal("Autotopia_Core_Progression")) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SetupZoneA_Tower finds Autotopia_Core_Progression > 0; zone A first visit complete!!")
    AnimGBSequence("tcy_autotopia_01a_dynamic.TCY_autotopia_01a_mainTowerDoor_01a 01", "open")
    AnimGBSequence("tcy_autotopia_01a.TCY_autotopia_01a_mainTowerLift_01a 01", "down")
    enableJumpVolumeAvailability("TowerJumps_Oswald_Target")
    Prefab_Projector_ChangeState("ControlTowerProjector", "Activate")
    if (GetGlobal("Autotopia_Core_State") == 2) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SetupZoneA_Tower finds Autotopia_Core_State == 2; setup zone A thinner path!!")
      AnimGBSequence("tcy_autotopia_01a.TCY_autotopia_01a_mainTowerPistons_01a 01", "moveUp")
    end
  end
  return 
end
AUT_SetupZoneA_Boulder = function()
  if (GetGlobal("Autotopia_CostumeCaveOpen") == 1) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SetupZoneA_Tower finds Autotopia_CostumeCaveOpen == 1; zone A costume cave opened!!")
    DestroyEntity("TCY_autotopia_01a_breakable_03a 01")
  end
  return 
end
AUT_Setup_ZoneA_Geysers = function()
  if (GetGlobal("Autotopia_Core_State") == 1) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* setup zone A paint path!!")
    TCY_GeyserLaunch_Extended("ControlTowerGeyser1")
    TCY_GeyserLaunch_Extended("ControlTowerGeyser2")
    TCY_GeyserLaunch_Extended("ControlTowerGeyser3")
    TCY_GeyserLaunch_Extended("ControlTowerGeyser4")
    AUT_SiphonPool_A_Changed(GetPlayer())
  else
    TCY_GeyserStartup("ControlTowerGeyser1")
    TCY_GeyserStartup("ControlTowerGeyser2")
    TCY_GeyserStartup("ControlTowerGeyser3")
    TCY_GeyserStartup("ControlTowerGeyser4")
  end
  return 
end
AUT_Zone_Loaded = function(target, zone)
  AUT_StreamingActive = 0
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* stream has completed!")
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Zone has fully streamed in!!")
  AUT_GateZoneLoaded("AUT_CurrentGate", zone)
  if (zone == "A") then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* zone A is activating!")
  end
  return 
end
AUT_SetupZoneC_Observatory = function()
  ObservatoryItem_Activate("MSS_ObservatoryItem_Auto", "8")
  return 
end
AUT_SetupZoneE_Boulder = function()
  if (0 < GetGlobal("Autotopia_Siphon03")) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* zone E shortcut opened!!")
    DestroyEntity("TCY_autotopia_01a_tunnelBlocker_03a 01")
    DestroyEntity("tcy_autotopia_01a.TCY_autotopia_01a_shortcutBlocker_02a 01")
  end
  return 
end
AUT_SetupZoneE_Garage = function(phase)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SetupZoneE_Garage activated for the garage tanks!")
  if (GetGlobal("Autotopia_Garage_Opened") == 0) then
    ForEachEntityInGroup(Hide, "GarageTank02")
  end
  if (GetGlobal("Autotopia_Garage_Opened") == 2) then
    ForEachEntityInGroup(Hide, "GarageTank01")
  end
  if (0 < GetGlobal("Autotopia_Garage_Opened")) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SetupZoneE_Garage activated, opening garage!")
    SetSplineFollowerInitialSpeed("tcy_autotopia_01a.TCY_gremlinDoor_01a_inert 01", 20)
  else
    SetPropertyBool("BlueChest_Garage", "ActionSpotEnabled", false)
  end
  if (GetGlobal("Autotopia_CostumeCaveOpen") == 1) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_SetupZoneE_Garage activated for the garage debris!")
    ForEachEntityInGroup(Hide, "GarageDebris")
  end
  return 
end
AUT_StreamingActive = 0
AUT_CoOp_Hint01 = 0
AUT_CoOp_Hint02 = 0
AUT_Lever01_Active = 0
AUT_CoopSet01_Lever = function(target, phase)
  if (phase == "pull") then
    AnimGBSequence("TCY_gearCoverDoors_01a_inert 01", "open")
    if (AUT_CoOp_Hint01 == 0) then
      AUT_CoOp_Hint01 = 1
      ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel01_coOp")
    end
    AUT_Lever01_Active = 1
    SetPropertyBool("Tunnel01_OswaldSpinsGearMarker", "ActionSpotEnabled", true)
  elseif (phase == "release") then
    if (AUT_Lever01_Active == 1) then
      AUT_Lever01_Active = 0
      AnimGBSequence("TCY_gearCoverDoors_01a_inert 01", "close")
      SetRotatorMaxSpeed("GBL_gear_01a_inert 01", 0)
      SetPropertyBool("Tunnel01_OswaldSpinsGearMarker", "ActionSpotEnabled", false)
    end
  end
  return 
end
AUT_CoopSet01_GearStruck = function()
  if (AUT_StreamingActive == 0) then
    if (AUT_Lever01_Active == 1) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_CoopSet01_GearStruck activated, variables are set correctly, calling AUT_SwitchThinnerGate('B')!")
      AudioPostEventOn("GBL_gear_01a_inert 01", "Play_sfx_aut_gerCoverDoor_gear_spin")
      AudioPostEventOn("GBL_gear_01a_inert 01", "Play_sfx_aut_gerCoverDoor_gate_opens")
      AUT_StreamingActive = 1
      SetPropertyBool("Tunnel01_OswaldSpinsGearMarker", "ActionSpotEnabled", false)
      SetRotatorMaxSpeed("GBL_gear_01a_inert 01", 720)
      Unhide("TCY_autotopia_01a_tunnelBlocker_02a 01")
      ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp_Success")
      AUT_SwitchThinnerGate("B", nil)
      wait(1.7000000476837158)
      SetRotatorMaxSpeed("GBL_gear_01a_inert 01", 0)
      if IsValidHandle("ZoneB_ThinnerActivationTrigger") then
        FireUser2("Tunnel_B_Thinner01")
        FireUser2("Tunnel_B_Thinner02")
        DestroyEntity("ZoneB_ThinnerActivationTrigger")
      end
    end
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* STREAMING IS ALREADY ACTIVE, CANNOT LAUNCH ANOTHER STREAM")
  end
  return 
end
CoopSet02_Gear01Set = 0
CoopSet02_Gear02Set = 0
CoopGate02_Activated = 0
CoopGate02_OswaldReady = 0
AUT_MickeyAt_Coop02Gear01 = function(target, gearnum)
  if (gearnum == "1") then
    SetPropertyBool("CoopGate_Set02_OswaldPatrolNode 02", "ActionSpotEnabled", true)
  elseif (gearnum == "2") then
    SetPropertyBool("CoopGate_Set02_OswaldPatrolNode 01", "ActionSpotEnabled", true)
  end
  return 
end
AUT_MickeyAt_Coop02Gear02 = function(target, gearnum)
  if (gearnum == "1") then
    SetPropertyBool("CoopGate_Set02_OswaldPatrolNode 04", "ActionSpotEnabled", true)
  elseif (gearnum == "2") then
    SetPropertyBool("CoopGate_Set02_OswaldPatrolNode 03", "ActionSpotEnabled", true)
  end
  return 
end
AUT_MickeyLeaves_Coop02Gear = function()
  SetPropertyBool("CoopGate_Set02_OswaldPatrolNode 01", "ActionSpotEnabled", false)
  SetPropertyBool("CoopGate_Set02_OswaldPatrolNode 02", "ActionSpotEnabled", false)
  SetPropertyBool("CoopGate_Set02_OswaldPatrolNode 03", "ActionSpotEnabled", false)
  SetPropertyBool("CoopGate_Set02_OswaldPatrolNode 04", "ActionSpotEnabled", false)
  OswaldStartFollowAction()
  CoopGate02_Activated = 0
  return 
end
AUT_OswaldReachGear02 = function()
  CoopGate02_OswaldReady = 1
  return 
end
AUT_CoopSet02_Gear01Spun = function(target, event, gear1, gear2)
  Print((("AUT_CoopSet02_Gear01Spun reads Gear " .. gear1) .. " struck!"))
  if (CoopGate02_Activated == 0) then
    if (CoopGate02_OswaldReady == 1) then
      OswaldSpinAction(target)
    end
    SetRotatorMaxSpeed(target, 720)
    if (DamageEvent_Source(event) == GetPlayer()) then
      _G[gear1] = 1
    elseif (DamageEvent_Source(event) == GetPlayer2OrAI()) then
      _G[gear1] = 2
    end
    Wait(0.5)
    if (_G[gear1] ~= 1) then
    end
    _G[gear1] = 0
    _G[gear2] = 0
    Print("AUT_CoopSet02_Gear01Spun reads both gears struck! Calling AUT_SwitchThinnerGate('F')")
    CoopGate02_Activated = 1
    SetRotatorMaxSpeed("CoopGate_Set02_GBL_gear_01a_inert 01", 0)
    SetRotatorMaxSpeed("CoopGate_Set02_GBL_gear_01a_inert 02", 0)
    SetRotatorMaxSpeed("CoopGate_Set02_GBL_gear_01a_inert 03", 0)
    SetRotatorMaxSpeed("CoopGate_Set02_GBL_gear_01a_inert 04", 0)
    if (AUT_StreamingActive == 0) then
      AUT_StreamingActive = 1
      AUT_SwitchThinnerGate("F", nil)
    end
    SetPropertyBool("CoopGate_Set02_OswaldPatrolNode 01", "ActionSpotEnabled", false)
    SetPropertyBool("CoopGate_Set02_OswaldPatrolNode 02", "ActionSpotEnabled", false)
    SetPropertyBool("CoopGate_Set02_OswaldPatrolNode 03", "ActionSpotEnabled", false)
    SetPropertyBool("CoopGate_Set02_OswaldPatrolNode 04", "ActionSpotEnabled", false)
    OswaldStartFollowAction()
    Print("gears stop")
    _G[gear1] = 0
    if (CoopGate02_Activated == 0) then
      SetRotatorMaxSpeed(target, 0)
      if (AUT_CoOp_Hint02 == 0) then
        AUT_CoOp_Hint02 = 1
        ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp")
      end
    end
  end
  return 
end
AUT_CoopSet03_Lvr01_On = 0
AUT_CoopSet03_Lvr02_On = 0
AUT_CoopSet03_TanksSetup = 0
AUT_CoopSet03_Lever01_Set = function(target, lever, phase)
  if (lever == "1") then
    if (phase == "pull") then
      AUT_CoopSet03_Lvr01_On = 1
      if (AUT_CoopSet03_Lvr02_On == 1) then
        if (AUT_StreamingActive == 0) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_CoopSet03_Lever01_Set activated by lever 1; both levers are active, calling AUT_SwitchThinnerGate('D')!")
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Streaming ACTIVATED FOR ZONE D")
          if (AUT_CoopSet03_TanksSetup == 0) then
            AUT_SwitchThinnerGate("D", "first")
            AUT_CoopSet03_TanksSetup = 1
          end
          SetRotatorMaxSpeed("ZoneD_LoadGear", 120)
          AudioPostEventOn("ZoneD_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
          ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp_Wait")
          TimerReset("StreamTunnel_LogicTimerMarker 01")
          TimerEnable("StreamTunnel_LogicTimerMarker 01")
        end
      else
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Streaming FOR ZONE D CANNOT ENGAGE")
        Print((((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* StreamingActive Flag set to: " .. AUT_StreamingActive) .. " and Lever01 Flag set to: ") .. AUT_CoopSet03_Lvr01_On) .. " "))
        if (phase == "release") then
          AUT_CoopSet03_Lvr01_On = 0
          TimerDisable("StreamTunnel_LogicTimerMarker 01")
          if (AUT_StreamingActive == 0) then
            if (AUT_CoopSet03_TanksSetup ~= 3) then
              ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp")
            end
            SetRotatorMaxSpeed("ZoneD_LoadGear", 0)
            AudioPostEventOn("ZoneD_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
            if (lever == "2") then
              if (phase == "pull") then
                AUT_CoopSet03_Lvr02_On = 1
                if (AUT_CoopSet03_Lvr01_On == 1) then
                  if (AUT_StreamingActive == 0) then
                    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_CoopSet03_Lever01_Set activated by lever 2; both levers are active, calling AUT_SwitchThinnerGate('D')!")
                    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Streaming ACTIVATED FOR ZONE D")
                    if (AUT_CoopSet03_TanksSetup == 0) then
                      AUT_SwitchThinnerGate("D", "first")
                      AUT_CoopSet03_TanksSetup = 1
                    end
                    SetRotatorMaxSpeed("ZoneD_LoadGear", 120)
                    AudioPostEventOn("ZoneD_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                    ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp_Wait")
                    TimerReset("StreamTunnel_LogicTimerMarker 01")
                    TimerEnable("StreamTunnel_LogicTimerMarker 01")
                  end
                else
                  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Streaming FOR ZONE D CANNOT ENGAGE")
                  Print((((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* StreamingActive Flag set to: " .. AUT_StreamingActive) .. " and Lever02 Flag set to: ") .. AUT_CoopSet03_Lvr02_On) .. " "))
                  if (phase == "release") then
                    AUT_CoopSet03_Lvr02_On = 0
                    TimerDisable("StreamTunnel_LogicTimerMarker 01")
                    if (AUT_StreamingActive == 0) then
                      if (AUT_CoopSet03_TanksSetup ~= 3) then
                        ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp")
                      end
                      SetRotatorMaxSpeed("ZoneD_LoadGear", 0)
                      AudioPostEventOn("ZoneD_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
                    end
                  end
                end
              elseif (phase == "release") then
                AUT_CoopSet03_Lvr02_On = 0
                TimerDisable("StreamTunnel_LogicTimerMarker 01")
                if (AUT_StreamingActive == 0) then
                  if (AUT_CoopSet03_TanksSetup ~= 3) then
                    ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp")
                  end
                  SetRotatorMaxSpeed("ZoneD_LoadGear", 0)
                  AudioPostEventOn("ZoneD_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
                end
              end
            end
          end
        end
      end
    elseif (phase == "release") then
      AUT_CoopSet03_Lvr01_On = 0
      TimerDisable("StreamTunnel_LogicTimerMarker 01")
      if (AUT_StreamingActive == 0) then
        if (AUT_CoopSet03_TanksSetup ~= 3) then
          ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp")
        end
        SetRotatorMaxSpeed("ZoneD_LoadGear", 0)
        AudioPostEventOn("ZoneD_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
        if (lever == "2") then
          if (phase == "pull") then
            AUT_CoopSet03_Lvr02_On = 1
            if (AUT_CoopSet03_Lvr01_On == 1) then
              if (AUT_StreamingActive == 0) then
                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_CoopSet03_Lever01_Set activated by lever 2; both levers are active, calling AUT_SwitchThinnerGate('D')!")
                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Streaming ACTIVATED FOR ZONE D")
                if (AUT_CoopSet03_TanksSetup == 0) then
                  AUT_SwitchThinnerGate("D", "first")
                  AUT_CoopSet03_TanksSetup = 1
                end
                SetRotatorMaxSpeed("ZoneD_LoadGear", 120)
                AudioPostEventOn("ZoneD_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
                ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp_Wait")
                TimerReset("StreamTunnel_LogicTimerMarker 01")
                TimerEnable("StreamTunnel_LogicTimerMarker 01")
              end
            else
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Streaming FOR ZONE D CANNOT ENGAGE")
              Print((((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* StreamingActive Flag set to: " .. AUT_StreamingActive) .. " and Lever02 Flag set to: ") .. AUT_CoopSet03_Lvr02_On) .. " "))
              if (phase == "release") then
                AUT_CoopSet03_Lvr02_On = 0
                TimerDisable("StreamTunnel_LogicTimerMarker 01")
                if (AUT_StreamingActive == 0) then
                  if (AUT_CoopSet03_TanksSetup ~= 3) then
                    ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp")
                  end
                  SetRotatorMaxSpeed("ZoneD_LoadGear", 0)
                  AudioPostEventOn("ZoneD_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
                end
              end
            end
          elseif (phase == "release") then
            AUT_CoopSet03_Lvr02_On = 0
            TimerDisable("StreamTunnel_LogicTimerMarker 01")
            if (AUT_StreamingActive == 0) then
              if (AUT_CoopSet03_TanksSetup ~= 3) then
                ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp")
              end
              SetRotatorMaxSpeed("ZoneD_LoadGear", 0)
              AudioPostEventOn("ZoneD_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
            end
          end
        end
      end
    end
  elseif (lever == "2") then
    if (phase == "pull") then
      AUT_CoopSet03_Lvr02_On = 1
      if (AUT_CoopSet03_Lvr01_On == 1) then
        if (AUT_StreamingActive == 0) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_CoopSet03_Lever01_Set activated by lever 2; both levers are active, calling AUT_SwitchThinnerGate('D')!")
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Streaming ACTIVATED FOR ZONE D")
          if (AUT_CoopSet03_TanksSetup == 0) then
            AUT_SwitchThinnerGate("D", "first")
            AUT_CoopSet03_TanksSetup = 1
          end
          SetRotatorMaxSpeed("ZoneD_LoadGear", 120)
          AudioPostEventOn("ZoneD_LoadGear", "Play_sfx_AUT_TunnelGearMachine_LP")
          ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp_Wait")
          TimerReset("StreamTunnel_LogicTimerMarker 01")
          TimerEnable("StreamTunnel_LogicTimerMarker 01")
        end
      else
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Streaming FOR ZONE D CANNOT ENGAGE")
        Print((((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* StreamingActive Flag set to: " .. AUT_StreamingActive) .. " and Lever02 Flag set to: ") .. AUT_CoopSet03_Lvr02_On) .. " "))
        if (phase == "release") then
          AUT_CoopSet03_Lvr02_On = 0
          TimerDisable("StreamTunnel_LogicTimerMarker 01")
          if (AUT_StreamingActive == 0) then
            if (AUT_CoopSet03_TanksSetup ~= 3) then
              ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp")
            end
            SetRotatorMaxSpeed("ZoneD_LoadGear", 0)
            AudioPostEventOn("ZoneD_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
          end
        end
      end
    elseif (phase == "release") then
      AUT_CoopSet03_Lvr02_On = 0
      TimerDisable("StreamTunnel_LogicTimerMarker 01")
      if (AUT_StreamingActive == 0) then
        if (AUT_CoopSet03_TanksSetup ~= 3) then
          ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Tunnel02_coOp")
        end
        SetRotatorMaxSpeed("ZoneD_LoadGear", 0)
        AudioPostEventOn("ZoneD_LoadGear", "Stop_sfx_AUT_TunnelGearMachine_LP")
      end
    end
  end
  return 
end
AUT_GremlinOpensCave = function(phase)
  if (phase == 1) then
    FireUser1("StuffusExposesCostumeCaveCameraMarker")
    TeleportGremlinToEntity("Stuffus", "tcy_autotopia_01a_both.Gremlin_PositionMarker 01")
  elseif (phase == 2) then
    AnimVarInt("Stuffus", VAR_Cutscene, 1)
    AnimEvent("Stuffus", EVENT_Start_Cutscene)
    AudioPostEventOn("tcy_autotopia_02a.pickupspawner_questobject 01", "Play_sfx_Gremlin_Mvmt_Hammer_IGC")
  elseif (phase == 3) then
    FireUser1("GremlinOpensCaveCam")
    wait(1)
    Enable("Gremlin_car_Tires 01")
    Enable("Gremlin_car_Tires 02")
    SetRotatorMaxSpeed("Gremlin_car_Tires 01", 640)
    SetRotatorMaxSpeed("Gremlin_car_Tires 02", 640)
    wait(0.5)
    SetSplineFollowerInitialSpeed("Gremlin_car_01a_inert 01", 12)
    AudioPostEventOn("Gremlin_car_01a_inert 01", "Play_sfx_AUT_GremlinCarCrash")
    DoStinger("Stinger_Reveal1", 2)
    TeleportGremlinToEntity("Stuffus", "tcy_autotopia_01a_gremlin.StuffusPositionMarker 01")
  elseif (phase == 4) then
    AnimGBSequence("TCY_autotopia_01a_breakable_03a 01", "crash")
    wait(2)
    DestroyEntity("TCY_autotopia_01a_breakable_03a 01")
    SetRotatorMaxSpeed("Gremlin_car_Tires 01", 0)
    Disable("Gremlin_car_Tires 01")
    Disable("Gremlin_car_Tires 02")
    AUT_SaveCheckpoint("Projector")
  elseif (phase == 5) then
    TeleportGremlinToEntity("Stuffus", "StuffusToGarage_PositionMarker 01")
  else
    TeleportGremlinToEntity("Stuffus", "Stuffus_Cuts_ToGaragePositionMarker 01")
  end
  return 
end
AUT_GremlinLockCheck = function()
  if (AUT_gremlinDoorLatch01_on == 1) then
    if (AUT_gremlinDoorLatch02_on == 1) then
      if (AUT_gremlinDoorLatch03_on == 1) then
        local gremTumblr01 = 0
        local gremTumblr02 = 0
        local gremTumblr03 = 0
        if (270 < AUT_gremlinTumbler01) then
          gremTumblr01 = (AUT_gremlinTumbler01 - 270)
        elseif (AUT_gremlinTumbler01 < 270) then
          gremTumblr01 = (270 - AUT_gremlinTumbler01)
        end
        if (90 < AUT_gremlinTumbler02) then
          gremTumblr02 = (AUT_gremlinTumbler02 - 90)
        elseif (AUT_gremlinTumbler02 < 90) then
          gremTumblr02 = (90 - AUT_gremlinTumbler02)
        end
        if (270 < AUT_gremlinTumbler03) then
          gremTumblr03 = (AUT_gremlinTumbler03 - 270)
        elseif (AUT_gremlinTumbler03 < 270) then
          gremTumblr03 = (270 - AUT_gremlinTumbler03)
        end
        if (gremTumblr01 < 15) then
          if (gremTumblr02 < 15) then
            if (gremTumblr02 < 15) then
              SetCameraAttributesForPlayer("TCY_gremlinDoor_Marker(CameraOverride) 01", nil)
              wait(1)
              SetSplineFollowerInitialSpeed("tcy_autotopia_01a.TCY_gremlinDoor_01a_inert 01", 20)
              SetPropertyBool("BlueChest_Garage", "ActionSpotEnabled", true)
              wait(2)
              ClearCameraAttributesForPlayer("TCY_gremlinDoor_Marker(CameraOverride) 01", nil)
              SetGlobal("Autotopia_Garage_Opened", 1)
            end
          end
        else
          wait(1)
          FireUser3("gremlinDoor_thinner")
          wait(2)
          FireUser2("gremlinDoor_thinner")
        end
      end
    end
  end
  return 
end
TCY_GearCameraOn = function(target, player)
  if (GetGlobal("Autotopia_Garage_Opened") == 0) then
    if (GetGlobal("Autotopia_CostumeCaveOpen") == 1) then
      SetCameraAttributesForPlayer("TCY_gremlinDoor_Marker(CameraOverride) 01", player)
      SetPropertyBool("Oswald_LockpickPatrolNode 01", "ActionSpotEnabled", true)
    end
  end
  return 
end
TCY_GearCameraOff = function(target, player)
  if (GetGlobal("Autotopia_Garage_Opened") == 0) then
    if (GetGlobal("Autotopia_CostumeCaveOpen") == 1) then
      ClearCameraAttributesForPlayer("TCY_gremlinDoor_Marker(CameraOverride) 01", player)
      SetPropertyBool("Oswald_LockpickPatrolNode 01", "ActionSpotEnabled", false)
      UseAbilityDetach(GetPlayer2OrAI())
      OswaldStartFollowAction()
    end
  end
  return 
end
TCY_OswaldMove_LockPin = function()
  SetPropertyBool("Oswald_LockpickPatrolNode 01", "ActionSpotEnabled", false)
  UseAbilityAttach(GetPlayer2OrAI())
  while true do
    if (not (IsUsingUseAbility(GetOswaldAI()) ~= nil)) then
      break
    end
    if (not (IsUseAbilityGrabbing(GetOswaldAI()) == false)) then
      break
    end
    if (not (GetGlobal("Autotopia_Garage_Opened") == 0)) then
      break
    end
    Print("__Oswald isnt successfully attached to a node yet!")
    wait(0.5)
  end
  QueueBrainEvent(GetOswaldAI(), BRAIN_BlindMoveNoFacing, vector4(0, 0, 0, 0), "Oswald_LockpickPatrolNode 02", vector4(5, 0.20000000298023224, 0, 0))
  return 
end
AUT_gremlinLatchPos = 0
AUT_gremlinDoorLatch01_on = 0
AUT_gremlinDoorLatch02_on = 0
AUT_gremlinDoorLatch03_on = 0
AUT_gremlinTumbler01 = 0
AUT_gremlinTumbler02 = 0
AUT_gremlinTumbler03 = 0
AUT_gremlinDoorPower = 0
AUT_GusLatchHint = 0
AUT_LatchAtLock01 = function()
  AUT_gremlinLatchPos = 1
  Print("************************************LATCH HIT TUMBLER 01")
  if (AUT_GusLatchHint == 0) then
    AUT_GusLatchHint = 1
    ForceSequence("Marker(Conversation) Gus 01", "AUT_v2_Gus_LockGizmo")
  end
  return 
end
AUT_LatchRemovedLock01 = function()
  AUT_gremlinLatchPos = 0
  AUT_gremlinDoorLatch01_on = 0
  Unhide("LatchPad01")
  Print("************************************LATCH REMOVED FROM TUMBLER 01")
  return 
end
AUT_LatchAtLock02 = function()
  AUT_gremlinLatchPos = 2
  Print("************************************LATCH HIT TUMBLER 02")
  return 
end
AUT_LatchRemovedLock02 = function()
  AUT_gremlinLatchPos = 1
  AUT_gremlinDoorLatch02_on = 0
  Unhide("LatchPad02")
  Print("************************************LATCH REMOVED FROM TUMBLER 02")
  return 
end
AUT_LatchAtLock03 = function()
  AUT_gremlinLatchPos = 3
  Print("************************************LATCH HIT TUMBLER 03")
  return 
end
AUT_LatchRemovedLock03 = function()
  AUT_gremlinLatchPos = 2
  AUT_gremlinDoorLatch03_on = 0
  Unhide("LatchPad03")
  Print("************************************LATCH REMOVED FROM TUMBLER 03")
  return 
end
driveGearLeft = 0
driveGearup = 0
driveGearfacing = 0
AUT_GremlinTumblerInitialize = function()
  AUT_gremlinTumbler01 = 90
  AUT_gremlinTumbler02 = 0
  AUT_gremlinTumbler03 = 180
  Enable("gremlinDoorLock01")
  Enable("gremlinDoorLock02")
  Enable("gremlinDoorLock03")
  StartRotateToPosition("gremlinDoorLock01", 90)
  StartRotateToPosition("gremlinDoorLock02", 0)
  StartRotateToPosition("gremlinDoorLock03", 180)
  driveGearLeft = GetLeft("TCY_garageGear_01a_inert 01")
  driveGearup = GetUp("TCY_garageGear_01a_inert 01")
  driveGearfacing = GetFacing("TCY_garageGear_01a_inert 01")
  return 
end
AUT_GremlinGaragePanelThinned = function(target, state)
  if (state == "thinned") then
    if (GetGlobal("Autotopia_Garage_Opened") == 0) then
      SetPropertyBool("Oswald_HackGarageHint", "ActionSpotEnabled", true)
    end
  elseif (state == "painted") then
    SetPropertyBool("Oswald_HackGarageHint", "ActionSpotEnabled", false)
  end
  return 
end
AUT_GremlinGaragePanelHacked = function()
  SetGlobal("Autotopia_Garage_Opened", 2)
  SetCameraAttributesForPlayer("TCY_gremlinDoor_Marker(CameraOverride) 01", nil)
  wait(1)
  SetPropertyEntity("explosion_FX_Spawner", "Spawn Destinations", "GarageExplosionPositionMarker 01", 0)
  ForceSpawn("explosion_FX_Spawner", 1)
  ForEachEntityInGroup(Hide, "GarageTank01")
  ForEachEntityInGroup(Unhide, "GarageTank02")
  wait(0.30000001192092896)
  SetSplineFollowerInitialSpeed("tcy_autotopia_01a.TCY_gremlinDoor_01a_inert 01", 20)
  SetPropertyBool("BlueChest_Garage", "ActionSpotEnabled", true)
  wait(1.5)
  ClearCameraAttributesForPlayer("TCY_gremlinDoor_Marker(CameraOverride) 01", nil)
  SetPropertyBool("Oswald_HackGarageHint", "ActionSpotEnabled", false)
  AUT_SaveCheckpoint("Garage")
  DoStinger("Comment_Dest", 5)
  Print("lock destructive music comment")
  return 
end
AUT_PlayerOnGarageGear = 0
AUT_GearSpun = function()
  if (AUT_RaceActive == 7) then
    AUT_PlayerOnGarageGear = 1
  end
  if (0 < GetGlobal("Autotopia_PlayerCar")) then
    if (GetGlobal("Autotopia_Garage_Opened") == 2) then
      if (GetGlobal("AUT_Stuffus_RepairOffered") == 2) then
        TeleportGremlinToEntity("Stuffus", "StuffusToGarage_PositionMarker 01")
        SetGlobal("AUT_Stuffus_RepairOffered", 3)
        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Stuffus moved to garage")
      end
    end
  end
  while true do
    if (not (AUT_PlayerOnGarageGear == 1)) then
      break
    end
    local xRotation = (GetLocalRotationX("TCY_garageGear_01a_inert 01", driveGearLeft, driveGearup, driveGearfacing) * 57.3248405456543)
    if (xRotation < 0) then
      xRotation = ((180 - (xRotation * -1)) + 180)
    end
    if (AUT_gremlinDoorLatch01_on == 0) then
      AUT_gremlinTumbler01 = (90 + xRotation)
      if (360 < AUT_gremlinTumbler01) then
        AUT_gremlinTumbler01 = (AUT_gremlinTumbler01 - 360)
      end
      if (AUT_gremlinTumbler01 < 275) then
        if (265 < AUT_gremlinTumbler01) then
          if (0 < AUT_gremlinLatchPos) then
            Print("*_*_*_**_*_*_*_*_**_*_*_*_**_*_*_*_*_* TUMBLER 01 LOCKED IN")
            AUT_gremlinDoorLatch01_on = 1
            Hide("LatchPad01")
            StartRotateToPosition("gremlinDoorLock01", 270)
          end
        end
      elseif (AUT_gremlinDoorLatch01_on == 0) then
        StartRotateToPosition("gremlinDoorLock01", AUT_gremlinTumbler01)
      end
    end
    if (AUT_gremlinDoorLatch02_on == 0) then
      AUT_gremlinTumbler02 = xRotation
      if (AUT_gremlinTumbler02 < 95) then
        if (85 < AUT_gremlinTumbler02) then
          if (1 < AUT_gremlinLatchPos) then
            Print("*_*_*_**_*_*_*_*_**_*_*_*_**_*_*_*_*_* TUMBLER 02 LOCKED IN")
            AUT_gremlinDoorLatch02_on = 1
            Hide("LatchPad02")
            StartRotateToPosition("gremlinDoorLock02", 90)
          end
        end
      elseif (AUT_gremlinDoorLatch02_on == 0) then
        StartRotateToPosition("gremlinDoorLock02", AUT_gremlinTumbler02)
      end
    end
    if (AUT_gremlinDoorLatch03_on == 0) then
      local fastRotation = (xRotation * 2)
      if (360 < fastRotation) then
        fastRotation = (fastRotation - 360)
      end
      AUT_gremlinTumbler03 = (180 + fastRotation)
      if (360 < AUT_gremlinTumbler03) then
        AUT_gremlinTumbler03 = (AUT_gremlinTumbler03 - 360)
      end
      if (AUT_gremlinDoorLatch03_on == 0) then
        AUT_gremlinTumbler03 = xRotation
        if (AUT_gremlinTumbler03 < 285) then
          if (255 < AUT_gremlinTumbler03) then
            if (2 < AUT_gremlinLatchPos) then
              Print("*_*_*_**_*_*_*_*_**_*_*_*_**_*_*_*_*_* TUMBLER 03 LOCKED IN")
              AUT_gremlinDoorLatch03_on = 1
              Hide("LatchPad03")
              StartRotateToPosition("gremlinDoorLock03", 270)
            end
          end
        elseif (AUT_gremlinDoorLatch03_on == 0) then
          StartRotateToPosition("gremlinDoorLock03", AUT_gremlinTumbler03)
        end
      end
    end
    wait(0.10000000149011612)
  end
  return 
end
AUT_LatchConnected = function()
  if (GetGlobal("Autotopia_Garage_Opened") == 0) then
    SetGlobal("Autotopia_Garage_Opened", 1)
    SetCameraAttributesForPlayer("TCY_gremlinDoor_Marker(CameraOverride) 01", nil)
    wait(1)
    DoStinger("Comment_Rest", 5)
    Print("lock restorative music comment")
    SetSplineFollowerInitialSpeed("tcy_autotopia_01a.TCY_gremlinDoor_01a_inert 01", 20)
    SetPropertyBool("BlueChest_Garage", "ActionSpotEnabled", true)
    wait(2)
    ClearCameraAttributesForPlayer("TCY_gremlinDoor_Marker(CameraOverride) 01", nil)
    SetPropertyBool("Oswald_LockpickPatrolNode 01", "ActionSpotEnabled", false)
    UseAbilityDetach(GetPlayer2OrAI())
    OswaldAbortScriptedBehavior()
    wait(0)
    OswaldStartFollowAction()
    AUT_SaveCheckpoint("Garage")
  end
  return 
end
AUT_RaceActive = 7
AUT_GearOff = function()
  if (AUT_RaceActive == 7) then
    AUT_PlayerOnGarageGear = 0
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* PLAYERS LEAVE GEAR MECHANISM")
    OswaldStartFollowAction()
  end
  if (0 < GetGlobal("Autotopia_PlayerCar")) then
    if (GetGlobal("Autotopia_Garage_Opened") == 2) then
      TeleportGremlinToEntity("Stuffus", "StuffusRaceLinePositionMarker 01")
      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Stuffus moved to finish line")
      if (GetGlobal("AUT_Stuffus_RepairOffered") == 3) then
        SetGlobal("AUT_Stuffus_RepairOffered", 2)
      end
    end
  end
  return 
end
AUT_ControlTower_Wastelandica = function()
  if (GetGlobal("Autotopia_Siphon01") == 2) then
    SetGlobal("MSN_Adelle_ControlTowerVar", 1)
  elseif (GetGlobal("Autotopia_Siphon01") == 1) then
    SetGlobal("MSN_Adelle_ControlTowerVar", 2)
  end
  return 
end
AUT_SwampTower_Wastelandica = function()
  if (GetGlobal("Autotopia_Siphon03") == 2) then
    SetGlobal("MSN_Adelle_LargePoolVar", 1)
  elseif (GetGlobal("Autotopia_Siphon03") == 1) then
    SetGlobal("MSN_Adelle_LargePoolVar", 2)
  end
  return 
end
AUT_MemoriesQuest_Garage = function(target, event, obj)
  local score = GetPictureScoreFromEvent(event)
  Print(((("Photo " .. obj) .. " ") .. tostring(score)))
  if (score == 1) then
    FireSequence("Marker(Conversation) Gus 01", "AUT_MemoriesPhoto")
  end
  return 
end
AUT_SiphonPool_C_Changed = function(guardianpool)
  FireUser1("Siphon02_Geyser")
  return 
end
AUT_SiphonPool_A_Changed = function(guardianpool)
  if (GetGlobal("Autotopia_Core_State") == 1) then
    if (0 < GetGlobal("Autotopia_Core_Progression")) then
      FireUser1("ControlTowerGeyser1")
      FireUser1("ControlTowerGeyser2")
      FireUser1("ControlTowerGeyser3")
      FireUser1("ControlTowerGeyser4")
    end
  end
  return 
end
AUT_CameraPull = function(player, camera)
  SetCameraAttributesForPlayer(camera, player)
  wait(2)
  ClearCameraAttributesForPlayer(camera, player)
  return 
end
AUT_Quest_GoofysCar = function()
  Hide("tcy_autotopia_01c_both.TCY_autotopia_01a_breakable_02a 01")
  return 
end
AUT_GuardianPool_rx = function(trigger, target, hasPlaystyle)
  Print("Prefab_ThinnerWaterfall")
  if (target == GetPlayer()) then
    Print("Prefab_ThinnerWaterfall: Player1 or Player2")
    if (GetPropertyBool(target, "Indelible") ~= true) then
      local playstyle = 0
      if (hasPlaystyle ~= nil) then
        playstyle = GetPropertyFloat(trigger, "CurrentPlaystyle")
        Print("Prefab_ThinnerWaterfall: hasPlaystyle")
      end
      Print(("Prefab_ThinnerWaterfall: playstyle: " .. playstyle))
      if (playstyle <= 0.30000001192092896) then
        Print("Prefab_ThinnerWaterfall: Player1 or Player2 are not indelible")
        if TriggeredFromAbove(trigger, target) then
          Print("Prefab_ThinnerWaterfall: From Above")
          StimulusEntity(trigger, ST_DAMAGE_LEAP, 0.033330000936985016, GetPosition(target), target)
        end
      end
    end
  end
  return 
end

