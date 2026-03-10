MSN_CinemaUndermillSwap = 0
MSN_CinemaInterceptProtection = 0
local MSN_ProjectorsInUse = false
local MSN_NoCullFromTubes = 0
MSN_SaveCheckPoint01 = function()
  WaitForLevelLoad()
  SaveCheckpoint(GetPlayer(), "MSN_LoadCheckPoint", "MSNorth_UTLexit_MickeySpawn", "MSNorth_UTLexit_OswaldSpawn")
  return 
end
MSN_SaveCheckPoint02 = function()
  WaitForLevelLoad()
  SaveCheckpoint(GetPlayer(), "MSN_LoadCheckPoint", "EM2_NorthStartMarker", "EM2_NorthStartMarkerOswald")
  return 
end
MSN_SaveCheckPoint03 = function()
  SetGlobal("MSN_CameraTutorial", 1)
  SaveCheckpoint(GetPlayer(), "MSN_LoadCheckPoint", "EM2_NorthStartMarker", "EM2_NorthStartMarkerOswald")
  return 
end
MSN_LoadCheckPoint = function(target)
  LevelManager_SetZoneStatusUnloaded("MeanStreet_North.INT_Camera")
  LevelManager_SetZoneStatusUnloaded("MeanStreet_North.INT_Cinema")
  LevelManager_SetZoneStatusUnloaded("MeanStreet_North.INT_IceCream")
  LevelManager_SetZoneStatusUnloaded("MeanStreet_North.INT_Arcade")
  LevelManager_SetZoneStatusUnloaded("MeanStreet_North.INT_PinTrader")
  if (target == "DEC") then
    Prefab_DECFoopToob_Finish()
  end
  return 
end
MSTN_AlwaysSetupVisit1 = function()
  StartFadeOut(0)
  SetGlobal("MSN_VisitNumber", 1)
  MSTN_AlwaysSetup()
  return 
end
MSTN_AlwaysSetupVisit2 = function()
  StartFadeOut(0)
  SetGlobal("MSN_VisitNumber", 2)
  SetGlobal("MSN_IntroMoviePlayed", 1)
  SetGlobal("EM2_MSTN_AirConditionerFixed", 1)
  SetGlobal("MSN_HermanQuadrantTracker", 0)
  local global_ProjectorState = GetGlobal("MSN_ProectorState")
  if (global_ProjectorState == 0) then
    if (GetGlobal("2dDirection") == 0) then
      if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
        Print("######### MSTN_AlwaysSetupVisit2 UNDERMILL")
        if (GetGlobal("MSN_GremlinStructure_WindMill") == 1) then
          SetRotatorMaxSpeed("MSN_MCP", 100)
        end
        ForEachEntityInGroup(Unhide, "MSN_Fishhead_OswaldSwitch")
        DestroyEntity("MSN_VaultSign")
        local DECData = GetPrefabData("MSN_DEC_Activator")
        DECData.HardLoadExitFunction[reg_10] = "Reverse"
        DECData.HardLoadExitFunction[reg_8] = "MSN_LoadCheckPoint"
        Prefab_DECFoopToob_AlwaysSetup("MSN_DEC_Activator")
        SetGlobal("MSN_HermanQuadrantTracker", 0)
        if (GetGlobal("MSN_UndermillPipeDoor") == 1) then
          Prefab_OswaldElectricSwitch_ChangeState("MSN_UnderMillClosetMarker", "Deactivate")
          ForEachEntityInGroup(DestroyEntity, "MSN_UndermillPipeGroup")
        elseif (GetGlobal("MSN_UndermillPipeDoor") == 2) then
          Prefab_OswaldElectricSwitch_ChangeState("MSN_UnderMillClosetMarker", "Deactivate")
          ForEachEntityInGroup(DestroyEntity, "MSN_UndermillPipeGroup")
          DestroyEntity("MSN_UndermillPipeTreasure")
          if (GetGlobal("2dDirection") == 100) then
            if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
              StreamInterior(nil, "Int_Cinema")
            end
          elseif (0 < GetGlobal("MSN_Arcade_FromArcade")) then
            StreamInterior(nil, "Int_Arcade")
          end
        end
      end
    elseif (GetGlobal("2dDirection") == 100) then
      if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
        StreamInterior(nil, "Int_Cinema")
      end
    elseif (0 < GetGlobal("MSN_Arcade_FromArcade")) then
      StreamInterior(nil, "Int_Arcade")
    end
    LevelManager_SetCurrentState("MeanStreet_North.Visit_2")
    MSTN_AlwaysSetup()
  else
    MSN_ProjectorsInUse = true
    if (global_ProjectorState == 1) then
      GetPrefabData("MSN_OsTownProjector").MapLoad_SetupPosition = "True"
      FireThread(OnMapLoad_ProjectorSetup, "MSN_OsTownProjector")
    elseif (global_ProjectorState == 2) then
      GetPrefabData("BogEasyProjector").MapLoad_SetupPosition = "True"
      FireThread(OnMapLoad_ProjectorSetup, "BogEasyProjector")
    elseif (global_ProjectorState == 3) then
      GetPrefabData("VenturelandProjector").MapLoad_SetupPosition = "True"
      FireThread(OnMapLoad_ProjectorSetup, "VenturelandProjector")
    elseif (global_ProjectorState == 4) then
      GetPrefabData("TomorrowCityProjector").MapLoad_SetupPosition = "True"
      FireThread(OnMapLoad_ProjectorSetup, "TomorrowCityProjector")
    end
    SetGlobal("MSN_ProectorState", 0)
  end
  return 
end
local musicvar = 0
MSTN_AlwaysSetup = function()
  Print("############# MSTN_AlwaysSetup1 ########### MSTN_AlwaysSetup1 ############# MSTN_AlwaysSetup1 ########### MSTN_AlwaysSetup1 ############# MSTN_AlwaysSetup1 ########### MSTN_AlwaysSetup1")
  DecrementPaintAbilitiesDisabled(GetPlayer())
  if (musicvar == 0) then
    MusicPostEventOn(GetPlayer(), "Play_MX_MSN")
    RemoveAllMusicStateOverride()
    SetCombatIntensityBias(0)
    musicvar = 1
    Print("Started music event from MSTN_AlwaysSetup")
  end
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    if (GetGlobal("MSN_IntroMoviePlayed") == 1) then
      Print("###### MSTN_AlwaysSetup LOAD UNDERMILL")
      if (GetGlobal("2dDirection") ~= 100) then
        StreamInterior(nil, "MeanStreet_North.MSNUnderMill")
        if (GetGlobal("MSN_VisitNumber") == 1) then
          LevelManager_SetCurrentState("MeanStreet_North.Visit_1")
        elseif (2 <= GetGlobal("MSN_VisitNumber")) then
          LevelManager_SetCurrentState("MeanStreet_North.Visit_2")
        end
        Print("###### MSTN_AlwaysSetup LOAD UNDERMILL 2")
      else
        ReplaceMusicStateOverride("MSN_IntCinema")
        Print("Forced Cinema music state and started music event from MSTN_AlwaysSetup")
        Print("###### MSTN_AlwaysSetup LOAD UNDERMILL 4")
        MSN_CinemaUndermillSwap = 1
        MSN_CinemaInterceptProtection = 1
        TeleportToEntity(GetPlayer(), GetRelativePrefabEntity("MSTN_Cinema", ".ExitBuildingPosition"), true, true)
        wait(0)
        wait(0)
        TogglePlayerIconSubstitute(false, true)
        SetGlobal("2dDirection", 1)
        SetGlobal("PlayerFirstTimeInZone", 1)
        GetPrefabData("MSTN_Cinema").StartsInactive = "HardLoad"
        Wait(0.10000000149011612)
        WaitForLevelLoad()
        TeleportToEntity(GetPlayer(), "Cinema_FromActionLevel 01", true, true)
        TeleportToEntity(GetPlayer2OrAI(), "Cinema_FromActionLevel 02", true, true)
        wait(0.009999999776482582)
        if (GetGlobal("MSN_Fifer_Intro_Played") == 1) then
          if (2 <= GetGlobal("EM2_EpisodeCheck")) then
            Hide("MSN_FiferPig")
          end
        end
        Prefab_EnterInterior("MSTN_Cinema")
        GetPrefabData("MSTN_Cinema").StartsInactive = "False"
        SetActiveSubMap("meanstreetnorth_main.MapVolume 02")
        MSN_SaveCheckPoint02()
      end
    end
  end
  if (GetGlobal("MSN_VaultDoorStateSecondary") == 1) then
    Enable("MSN_CinemaInterceptTrigger")
  end
  if (0 < GetGlobal("MSN_Arcade_FromArcade")) then
    TeleportToEntity(GetPlayer(), GetRelativePrefabEntity("MSTN_Arcade", ".ExitBuildingPosition"), true, true)
    TogglePlayerIconSubstitute(false, true)
    SetGlobal("2dDirection", 1)
    SetGlobal("MSN_Arcade_FromArcade", 0)
    GetPrefabData("MSTN_Arcade").StartsInactive = "HardLoad"
    TeleportToEntity(GetPlayer(), "ArcadePlayer1Marker", true, true)
    TeleportToEntity(GetPlayer2OrAI(), "Cinema_FromActionLevel 02", true, true)
    Wait(0.009999999776482582)
    Prefab_EnterInterior("MSTN_Arcade")
    GetPrefabData("MSTN_Arcade").StartsInactive = "False"
  end
  SetGlobal("2dDirection", 1)
  if (GetGlobal("MSN_PostEp4Move") == 0) then
    if (GetGlobal("EM2_EpisodeCheck") == 4) then
      SetGlobal("MSN_PostEp4Move", 1)
      TeleportToEntity(GetPlayer(), "MSN_PostEp4Mickey", true, true)
      TeleportToEntity(GetPlayer2OrAI(), "MSN_PostEp4Oswald", true, true)
      MSN_SaveCheckPoint02()
    end
  end
  Print("############# MSTN_AlwaysSetup2 ########### MSTN_AlwaysSetup2 ############# MSTN_AlwaysSetup2 ########### MSTN_AlwaysSetup2 ############# MSTN_AlwaysSetup2 ########### MSTN_AlwaysSetup2")
  if (GetGlobal("MST_UtilidorsState") == 2) then
    TeleportToEntity(GetPlayer(), "MSN_FromBalloonMickey")
    TeleportToEntity(GetPlayer2OrAI(), "MSN_FromBalloonOswald")
    if (GetNumPlayers() == 2) then
      EnableSplitScreen(true)
    end
    SetGlobal("MST_UtilidorsState", 0)
    Unhide("MSN_BalloonTop")
    Unhide("MSN_BalloonBottom")
    CameraReset()
    ShowHud()
    MSN_SaveCheckPoint02()
  else
    Hide("MSN_BalloonTop")
    Hide("MSN_BalloonBottom")
  end
  local MSU_PneumaticTubesToMS = GetGlobal("MSU_PneumaticTubesToMS")
  if (0 < MSU_PneumaticTubesToMS) then
    local Mickey_loc = (("PM_FromUtilidorRoom" .. MSU_PneumaticTubesToMS) .. "_MickeyStart")
    local Oswald_loc = (("PM_FromUtilidorRoom" .. MSU_PneumaticTubesToMS) .. "_OswaldStart")
    MSN_NoCullFromTubes = 1
    TeleportToEntity(GetPlayer(), Mickey_loc)
    TeleportToEntity(GetPlayer2OrAI(), Oswald_loc)
    CameraReset()
    SetGlobal("MSU_PneumaticTubesToMS", 0)
    SaveCheckpoint(GetPlayer(), "MSN_LoadCheckPoint", Mickey_loc, Oswald_loc)
  end
  if (GetGlobal("MSN_GremlinStructure_WindMill") == 0) then
    ForEachEntityInGroup(Hide, "MSN_WindmillFixedProp")
    Hide("MSN_Windmill")
    SetPropertyFloat("MSN_WindMill_MainTrigger", "UsableRadius", 0)
  elseif (GetGlobal("MSN_GremlinStructure_WindMill") == 1) then
    Hide("MSN_WindmillPartial")
    MoveToEntity("MSN_HiddenSpecial1", "MSN_PhotoMoveMarker")
    MoveToEntity("MSN_HiddenSpecial2", "MSN_PhotoIncludeMarker")
    ForEachEntityInGroup(Hide, "MSN_WindmillPartialProp")
    WaitForLevelLoad()
    AnimGBSequence("MSN_Windmill", "fixed")
    DestroyEntity("MSN_WindmillFX2")
    SetRotatorMaxSpeed("MSN_WindmillDoor", 20)
    StartRotateToPosition("MSN_WindmillDoor", 90)
    ForEachEntityInGroup(Unhide, "MSN_WindmillArt")
    SetPropertyFloat("MSN_WindMill_MainTrigger", "UsableRadius", 2)
  end
  if (GetGlobal("MSN_GremlinStructure_Tower") == 0) then
    if (2 <= GetGlobal("MSN_VisitNumber")) then
      Prefab_OswaldElectricSwitch_ChangeState("MSN_GremHut03_OsSwitch", "Reset")
    end
  elseif (GetGlobal("MSN_GremlinStructure_Tower") == 1) then
    Prefab_OswaldElectricSwitch_ChangeState("MSN_GremHut03_OsSwitch", "Deactivate")
    AnimGBSequence("MSN_TowerSmallDoor", "opening")
    DestroyEntity("MSN_GremlinNozzle")
    SetPropertyFloat("MSN_Tower_MainTrigger", "UsableRadius", 2)
    DestroyEntity("MSN_Gremlin_Shaky")
  elseif (GetGlobal("MSN_GremlinStructure_Tower") == 2) then
    DestroyEntity("MSN_Gremlin_Shaky")
    DestroyEntity("MSN_SewerCap")
    DestroyEntity("MSTN_TowerTank")
    SetPropertyFloat("MSN_Tower_MainTrigger", "UsableRadius", 0)
    Prefab_OswaldElectricSwitch_ChangeState("MSN_GremHut03_OsSwitch", "Deactivate")
  end
  Print("############# MSTN_AlwaysSetup3 ########### MSTN_AlwaysSetup3 ############# MSTN_AlwaysSetup3 ########### MSTN_AlwaysSetup3 ############# MSTN_AlwaysSetup3 ########### MSTN_AlwaysSetup3")
  if (GetGlobal("MSN_SecretPathTracker") == 0) then
    SetRotatorMaxSpeed("MSN_SecretPlatform01", 60)
    StartRotateToPosition("MSN_SecretPlatform01", 290)
    Disable("MSN_HiddenForSecret")
    Prefab_OswaldElectricSwitch_ChangeState("MSN_SecretSwitch", "Deactivate")
  elseif (GetGlobal("MSN_SecretPathTracker") == 1) then
    Enable("MSN_HiddenForSecret")
    Enable("MSN_SecretHiddenHero")
    DestroyEntity("MSN_SecretSign")
    SetPropertyFloat("MSN_SecretEntranceTrigger", "UsableRadius", 2)
    SetRotatorMaxSpeed("MSN_SecretPlatform01", 60)
    StartRotateToPosition("MSN_SecretPlatform01", 359)
    SetPropertyFloat("MSN_SecretFirstKnot", "HoldTime", 5)
    SetSplineFollowerInitialSpeed("MSN_SecretPlatform01", 1)
    SetSplineFollowerInitialSpeed("MSN_SecretPlatform02", 2)
    Prefab_OswaldElectricSwitch_ChangeState("MSN_SecretSwitch", "Activate")
  elseif (GetGlobal("MSN_SecretPathTracker") == 2) then
    DestroyEntity("MSN_SecretSign")
    DestroyEntity("MSN_SecretPlatform01")
    DestroyEntity("MSN_SecretPlatform02")
    SetGlobal("MSN_SecretPathTracker", 3)
  elseif (GetGlobal("MSN_SecretPathTracker") == 3) then
    DestroyEntity("MSN_SecretSign")
    DestroyEntity("MSN_SecretPlatform01")
    DestroyEntity("MSN_SecretPlatform02")
  end
  if (GetGlobal("MSN_VisitNumber") == 1) then
    Unhide("MSN_SOTW")
    Hide("MSN_Nozzle")
    Prefab_OswaldElectricSwitch_ChangeState("MSN_PortableGeneratorSwitch", "Deactivate")
    Prefab_OswaldElectricSwitch_ChangeState("MSN_GremHut03_OsSwitch", "Deactivate")
  end
  if (GetGlobal("MSN_SOTW_Intro_Played") == 1) then
    DestroyEntity("MSN_SpiritConvoMarker")
    DestroyEntity("MSN_SpiritFX")
  end
  Print("############# MSTN_AlwaysSetup4 ########### MSTN_AlwaysSetup4 ############# MSTN_AlwaysSetup4 ########### MSTN_AlwaysSetup4 ############# MSTN_AlwaysSetup4 ########### MSTN_AlwaysSetup4")
  if (2 <= GetGlobal("MSN_VisitNumber")) then
    Enable("MSN_TubeQuadrant")
    Disable("MSN_CinemaActionMarker")
    ForEachEntityInGroup(Unhide, "MSN_WindmillOswaldSwitch")
    ForEachEntityInGroup(Unhide, "MSN_FishheadToon")
    Prefab_OswaldElectricSwitch_ChangeState("MSN_CinemaSwitch", "Deactivate")
  end
  if (GetGlobal("MSN_ConstructionWall") == 1) then
    AnimGBSequence("MSN_ConstructionAreaWall", "down")
  end
  if (GetGlobal("MSN_GremlinStructure_FishHead") == 0) then
    Hide("MSN_Fishhead")
    Hide("MSN_FishheadDestroyed")
  elseif (GetGlobal("MSN_GremlinStructure_FishHead") == 1) then
    Hide("MSN_FishheadPartial")
    ForEachEntityInGroup(Hide, "MSN_FishheadPartialProp")
    ForEachEntityInGroup(DestroyEntity, "MSN_FishheadToon")
    Hide("MSN_FishheadDestroyed")
    SetPropertyFloat("MSN_Fishhead_MainTrigger", "UsableRadius", 2)
    Enable("MSN_OpenFishheadMouth")
    Prefab_OswaldElectricSwitch_ChangeState("MSN_OswaldConstructionLever", "Deactivate")
  elseif (GetGlobal("MSN_GremlinStructure_FishHead") == 2) then
    DestroyEntity("MSN_Fishhead_BackEntranceCover")
    Hide("MSN_FishheadPartial")
    Hide("MSN_Fishhead")
    Unhide("MSN_FishheadDestroyed")
    SetPropertyFloat("MSN_Fishhead_MainTrigger", "UsableRadius", 0)
    Prefab_OswaldElectricSwitch_ChangeState("MSN_OswaldConstructionLever", "Deactivate")
    SetGlobal("MSN_GremlinStructure_FishHead", 3)
  elseif (GetGlobal("MSN_GremlinStructure_FishHead") == 3) then
    DestroyEntity("MSN_Fishhead_BackEntranceCover")
    Hide("MSN_Fishhead")
    Unhide("MSN_FishheadDestroyed")
    SetPropertyFloat("MSN_Fishhead_MainTrigger", "UsableRadius", 0)
    Prefab_OswaldElectricSwitch_ChangeState("MSN_OswaldConstructionLever", "Deactivate")
  end
  if (2 <= GetGlobal("EM2_EpisodeCheck")) then
    if (GetGlobal("MSN_GusHintVar") == 0) then
      SetGlobal("MSN_GusHintVar", 7)
      TimerEnable("EM2_GusHintTimer")
      TimerReset("EM2_GusHintTimer")
    end
    DestroyEntity("MSN_Gremlin_Sparks")
    DestroyEntity("MSN_Gremlin_Shaky")
  end
  Print("############# MSTN_AlwaysSetup5 ########### MSTN_AlwaysSetup5 ############# MSTN_AlwaysSetup5 ########### MSTN_AlwaysSetup5 ############# MSTN_AlwaysSetup5 ########### MSTN_AlwaysSetup5")
  local screens_activated = false
  screens_activated = "EM2_EpisodeCheck"
  if (2 <= GetGlobal(screens_activated)) then
    screens_activated = true
    screens_activated = Prefab_Projector_ChangeState
    FireThread(screens_activated, "VenturelandProjector", "Activate")
    screens_activated = Prefab_Projector_ChangeState
    FireThread(screens_activated, "BogEasyProjector", "Activate")
    screens_activated = Prefab_Projector_ChangeState
    FireThread(screens_activated, "MSN_OsTownProjector", "Activate")
    screens_activated = "EM2_EpisodeCheck"
    screens_activated = 4
    if (screens_activated <= GetGlobal(screens_activated)) then
      screens_activated = Prefab_Projector_ChangeState
      FireThread(screens_activated, "TomorrowCityProjector", "Activate")
    end
  end
  screens_activated = "MSN_RockWallFallen"
  screens_activated = 1
  if (GetGlobal(screens_activated) == screens_activated) then
    screens_activated = "MSN_SideTunnelDoor"
    DestroyEntity(screens_activated)
  end
  screens_activated = "MSN_VisitNumber"
  screens_activated = 1
  if (GetGlobal(screens_activated) == screens_activated) then
    screens_activated = "MSN_IntroMoviePlayed"
    screens_activated = 0
    if (GetGlobal(screens_activated) == screens_activated) then
      screens_activated = "MeanStreet_North.MSNorthIGC"
      LevelManager_SetZoneStatusActive(screens_activated)
      WaitForLevelLoad()
      screens_activated = "IGC_0100_MarkusIntro"
      PlayIGC(screens_activated)
    end
  end
  screens_activated = "RBF_AngelOrDevil"
  screens_activated = 2
  if (GetGlobal(screens_activated) == screens_activated) then
    screens_activated = "MSN_OswaldTower"
    screens_activated = 0
    if (GetGlobal(screens_activated) == screens_activated) then
      screens_activated = "MSN_CameraShopSign"
      Hide(screens_activated)
      screens_activated = "MSN_OswaldTower"
      SetGlobal(screens_activated, 1)
      screens_activated = "EM2_MSTN_NotFallenTower"
      Hide(screens_activated)
      screens_activated = Hide
      ForEachEntityInGroup(screens_activated, "MSN_TowerStandingProp")
      screens_activated = "MSN_HiddenHeroes_OswaldTower"
      DisableComponent(screens_activated, "Camera Ability Target Component")
      screens_activated = "MSN_HiddenHeroes_OswaldTower"
      Disable(screens_activated)
      screens_activated = "MSN_JamfaceOswaldTowerTrigger"
      Enable(screens_activated)
      screens_activated = "MSN_CamerEnterTrigger"
      SetPropertyFloat(screens_activated, "UsableRadius", 0)
      screens_activated = "MSN_FallenTowerResidue"
      Prefab_ScrapMetalSpawner_Launch(screens_activated)
      screens_activated = "MSN_CameraPedPathDetour"
      SetPropertyFloat(screens_activated, "BranchPathChance", 0)
    end
  else
    screens_activated = "RBF_AngelOrDevil"
    screens_activated = 2
    if (GetGlobal(screens_activated) == screens_activated) then
      screens_activated = "MSN_OswaldTower"
      screens_activated = 1
      if (GetGlobal(screens_activated) == screens_activated) then
        screens_activated = "MSN_CameraShopSign"
        Hide(screens_activated)
        screens_activated = "EM2_MSTN_NotFallenTower"
        Hide(screens_activated)
        screens_activated = Hide
        ForEachEntityInGroup(screens_activated, "MSN_TowerStandingProp")
        screens_activated = "MSN_HiddenHeroes_OswaldTower"
        DisableComponent(screens_activated, "Camera Ability Target Component")
        screens_activated = "MSN_HiddenHeroes_OswaldTower"
        Disable(screens_activated)
        screens_activated = "MSN_CamerEnterTrigger"
        SetPropertyFloat(screens_activated, "UsableRadius", 0)
        screens_activated = "MSN_JamfaceOswaldTowerTrigger"
        Enable(screens_activated)
        screens_activated = "MSN_CameraPedPathDetour"
        SetPropertyFloat(screens_activated, "BranchPathChance", 0)
        screens_activated = "MSN_JamfaceOswaldTowerTrigger"
        Enable(screens_activated)
      end
    else
      screens_activated = "RBF_AngelOrDevil"
      screens_activated = 2
      if (GetGlobal(screens_activated) ~= screens_activated) then
        screens_activated = "MSN_OswaldTower"
        screens_activated = 0
        if (GetGlobal(screens_activated) == screens_activated) then
          screens_activated = "MSN_CameraShopSign"
          Unhide(screens_activated)
          screens_activated = "MSN_CameraShopSignFallen"
          Hide(screens_activated)
          screens_activated = "EM2_MSTN_FallenTower"
          Hide(screens_activated)
          screens_activated = Hide
          ForEachEntityInGroup(screens_activated, "MSN_TowerFallenProp")
          screens_activated = "MSN_CamerEnterTrigger"
          SetPropertyFloat(screens_activated, "UsableRadius", 2)
        end
      else
        screens_activated = "MSN_OswaldTower"
        screens_activated = 2
        if (GetGlobal(screens_activated) == screens_activated) then
          screens_activated = Hide
          ForEachEntityInGroup(screens_activated, "MSN_TowerFallenProp")
          screens_activated = "MSN_CameraShopSignFallen"
          Hide(screens_activated)
          screens_activated = "EM2_MSTN_FallenTower"
          Hide(screens_activated)
          screens_activated = "MSN_HiddenHeroes_OswaldTower"
          DisableComponent(screens_activated, "Camera Ability Target Component")
          screens_activated = "MSN_HiddenHeroes_OswaldTower"
          Disable(screens_activated)
          screens_activated = "EM2_MSTN_NotFallenTower"
          Hide(screens_activated)
          screens_activated = "MSN_OswaldTowerRepairTrigger"
          Enable(screens_activated)
          screens_activated = "MSN_CameraShopSign"
          Unhide(screens_activated)
          screens_activated = "MSN_CamerEnterTrigger"
          SetPropertyFloat(screens_activated, "UsableRadius", 2)
        else
          screens_activated = "MSN_OswaldTower"
          screens_activated = 3
          if (GetGlobal(screens_activated) == screens_activated) then
            screens_activated = "MSN_CameraShopSign"
            Unhide(screens_activated)
            screens_activated = "MSN_CameraShopSignFallen"
            Hide(screens_activated)
            screens_activated = "EM2_MSTN_FallenTower"
            Hide(screens_activated)
            screens_activated = Hide
            ForEachEntityInGroup(screens_activated, "MSN_TowerFallenProp")
            screens_activated = "MSN_CamerEnterTrigger"
            SetPropertyFloat(screens_activated, "UsableRadius", 2)
          end
        end
      end
    end
  end
  screens_activated = "EM2_EpisodeCheck"
  screens_activated = 4
  if (screens_activated <= GetGlobal(screens_activated)) then
    screens_activated = "Critical_MSN"
    Quest_SetCriticalPath(screens_activated, "Critical_MSN_6")
    screens_activated = "MSN_AmmoUpgradeVar"
    screens_activated = 0
    if (GetGlobal(screens_activated) == screens_activated) then
      screens_activated = "MSN_AmmoUpgradeVar"
      SetGlobal(screens_activated, 1)
      screens_activated = "4"
      MST_AwardAmmoUpgrades(screens_activated)
    end
    if (screens_activated == false) then
      screens_activated = Prefab_Projector_ChangeState
      FireThread(screens_activated, "VenturelandProjector", "Activate")
      screens_activated = Prefab_Projector_ChangeState
      FireThread(screens_activated, "BogEasyProjector", "Activate")
      screens_activated = Prefab_Projector_ChangeState
      FireThread(screens_activated, "MSN_OsTownProjector", "Activate")
    end
  end
  screens_activated = "############# MSTN_AlwaysSetup6 ########### MSTN_AlwaysSetup6 ############# MSTN_AlwaysSetup6 ########### MSTN_AlwaysSetup6 ############# MSTN_AlwaysSetup6 ########### MSTN_AlwaysSetup6"
  Print(screens_activated)
  screens_activated = "MSN_Teleporter"
  screens_activated = 1
  if (GetGlobal(screens_activated) == screens_activated) then
    screens_activated = "MSN_ArcadeTeleportTrigger"
    Enable(screens_activated)
    screens_activated = "MSN_SiteTransportTrigger"
    Enable(screens_activated)
  end
  screens_activated = "MSN_VaultDoorState"
  screens_activated = 1
  if (GetGlobal(screens_activated) <= screens_activated) then
    screens_activated = Hide
    ForEachEntityInGroup(screens_activated, "MSN_BinPartsAll")
  else
    screens_activated = "MSN_VaultDoorState"
    screens_activated = 2
    if (screens_activated <= GetGlobal(screens_activated)) then
      screens_activated = 5
      for i = 1, screens_activated do
        i = "MSN_GremlinPartsBin"
        i = (i .. i)
        i = 1
        if (i <= GetGlobal(i)) then
          i = "MSN_MissingParts0"
          i = (i .. i)
          DestroyEntity(i)
        end
      end
    end
  end
  screens_activated = "MSN_VaultDoorState"
  screens_activated = 2
  if (GetGlobal(screens_activated) == screens_activated) then
    screens_activated = Enable
    ForEachEntityInGroup(screens_activated, "MSN_RobberyCamAll")
  end
  screens_activated = "############# MSTN_AlwaysSetup7 ########### MSTN_AlwaysSetup7 ############# MSTN_AlwaysSetup7 ########### MSTN_AlwaysSetup7 ############# MSTN_AlwaysSetup7 ########### MSTN_AlwaysSetup7"
  Print(screens_activated)
  screens_activated = "MST_Jehosaphat_Offer_Played"
  screens_activated = 1
  if (GetGlobal(screens_activated) == screens_activated) then
    screens_activated = "MSN_BalloonFence"
    Hide(screens_activated)
    screens_activated = "MSN_BalloonTop"
    Unhide(screens_activated)
    screens_activated = "MSN_BalloonBottom"
    Unhide(screens_activated)
    screens_activated = "MSN_BalloonCaptainTrigger"
    Enable(screens_activated)
  else
    screens_activated = "MSN_BalloonTop"
    Hide(screens_activated)
    screens_activated = "MSN_BalloonBottom"
    Hide(screens_activated)
  end
  screens_activated = "MSN_VisitNumber"
  screens_activated = 1
  if (GetGlobal(screens_activated) == screens_activated) then
    screens_activated = "MSN_IntroMoviePlayed"
    screens_activated = 1
    if (GetGlobal(screens_activated) == screens_activated) then
      screens_activated = "############# MSTN_AlwaysSetup8 ########### MSTN_AlwaysSetup8 ############# MSTN_AlwaysSetup8 ########### MSTN_AlwaysSetup8 ############# MSTN_AlwaysSetup8 ########### MSTN_AlwaysSetup8"
      Print(screens_activated)
      screens_activated = "MSN_UtilidorsExitSaveTrigger"
      Enable(screens_activated)
      screens_activated = 0
      if (MSN_CinemaUndermillSwap == screens_activated) then
        screens_activated = nil
        StreamInterior(screens_activated, "MeanStreet_North.MSNUnderMill")
      end
      screens_activated = 0.5
      StartFadeIn(screens_activated)
    end
  end
  screens_activated = "MSN_VisitNumber"
  screens_activated = 1
  if (screens_activated < GetGlobal(screens_activated)) then
    screens_activated = "############# MSTN_AlwaysSetup9 ########### MSTN_AlwaysSetup9 ############# MSTN_AlwaysSetup9 ########### MSTN_AlwaysSetup9 ############# MSTN_AlwaysSetup9 ########### MSTN_AlwaysSetup9"
    Print(screens_activated)
    screens_activated = "MSN_UtilidorsExitSaveTrigger"
    Enable(screens_activated)
    screens_activated = 0
    if (MSN_CinemaUndermillSwap == screens_activated) then
      screens_activated = nil
      StreamInterior(screens_activated, "MeanStreet_North.MSNUnderMill")
    end
    screens_activated = "EM2_NorthStartMarker"
    if (LastCheckpointPos_Mickey == screens_activated) then
      screens_activated = 0
      if (MSN_CinemaInterceptProtection == screens_activated) then
        MSN_JamfaceReloadIntercept()
      end
    else
      screens_activated = false
      if (MSN_ProjectorsInUse == screens_activated) then
        screens_activated = 0.5
        StartFadeIn(screens_activated)
      end
    end
  end
  screens_activated = "EM2_MSTN_CinemaFuse"
  screens_activated = 1
  if (GetGlobal(screens_activated) == screens_activated) then
    screens_activated = "MSN_CinemaFuseboxSpark"
    StartEmitters(screens_activated)
  end
  screens_activated = "MSN_VaultDoorState"
  screens_activated = 1
  if (GetGlobal(screens_activated) == screens_activated) then
    screens_activated = "MSN_VaultDoor"
    AnimGBSequence(screens_activated, "open")
    screens_activated = "MSN_VaultSign"
    DestroyEntity(screens_activated)
  else
    screens_activated = "MSN_VaultDoorState"
    screens_activated = 2
    if (screens_activated <= GetGlobal(screens_activated)) then
      screens_activated = "MSN_VaultSign"
      DestroyEntity(screens_activated)
      screens_activated = "MSN_VaultDoor"
      DestroyEntity(screens_activated)
    end
  end
  screens_activated = "EM2_EpisodeCheck"
  screens_activated = 2
  if (GetGlobal(screens_activated) == screens_activated) then
    screens_activated = "MSN_GusHint2"
    screens_activated = 0
    if (GetGlobal(screens_activated) == screens_activated) then
      screens_activated = "MSN_GusHint02"
      ActivateGremlinHint(screens_activated)
      screens_activated = "MSN_GusHint2"
      SetGlobal(screens_activated, 1)
    end
  end
  screens_activated = "EM2_EpisodeCheck"
  screens_activated = 2
  if (GetGlobal(screens_activated) == screens_activated) then
    screens_activated = "MSN_CriticalPathStage"
    screens_activated = 0
    if (GetGlobal(screens_activated) == screens_activated) then
      screens_activated = "Critical_MSN"
      Quest_SetCriticalPath(screens_activated, "Critical_MSN_4")
      screens_activated = "MSN_CriticalPathStage"
      SetGlobal(screens_activated, 1)
    end
  else
    screens_activated = "EM2_EpisodeCheck"
    screens_activated = 3
    if (GetGlobal(screens_activated) == screens_activated) then
      screens_activated = "MSN_CriticalPathStage"
      screens_activated = 1
      if (GetGlobal(screens_activated) == screens_activated) then
        screens_activated = "Critical_MSN"
        Quest_SetCriticalPath(screens_activated, "Critical_MSN_5")
        screens_activated = "MSN_CriticalPathStage"
        SetGlobal(screens_activated, 2)
      end
    end
  end
  MeanStreet_PriceMaster_North()
  screens_activated = "EM2_MSTN_GremlinMarkus"
  AnimVarInt(screens_activated, VAR_Mood_Type, MOOD_Positive)
  screens_activated = "MSN_VisitNumber"
  screens_activated = 1
  if (GetGlobal(screens_activated) == screens_activated) then
    screens_activated = "MSN_GremlinStructure_WindMill"
    screens_activated = 1
    if (GetGlobal(screens_activated) == screens_activated) then
      screens_activated = "EM2_MSTN_GremlinMarkus"
      Hide(screens_activated)
    end
  end
  screens_activated = "############# MSTN_AlwaysSetup10 ########### MSTN_AlwaysSetup10 ############# MSTN_AlwaysSetup10 ########### MSTN_AlwaysSetup10 ############# MSTN_AlwaysSetup10 ########### MSTN_AlwaysSetup10"
  Print(screens_activated)
  screens_activated = "EM2_MSTN_AirConditionerFixed"
  screens_activated = 1
  if (GetGlobal(screens_activated) ~= screens_activated) then
    screens_activated = "MSN_VisitNumber"
    screens_activated = 2
  else
    screens_activated = "MSN_AirCondit_SteamSmallPipe"
    DestroyEntity(screens_activated)
    screens_activated = "MSN_AirCondit_SteamLargePipe"
    DestroyEntity(screens_activated)
    screens_activated = Prefab_OswaldElectricSwitch_ChangeState
    FireThread(screens_activated, "MSN_AirConditionerSwitch", "Deactivate")
    screens_activated = "MSN_AirConditionerWindSpawner"
    ForceSpawn(screens_activated, 1)
    screens_activated = "MSN_OswaldAC_SecondAction"
    Disable(screens_activated)
    screens_activated = "MSN_OswaldAC_FirstAction"
    Disable(screens_activated)
  end
  screens_activated = "OST_BunnyQuest_Count"
  local OSTBunny = GetGlobal(screens_activated)
  screens_activated = GetGlobal
  screens_activated = screens_activated("MSN_BunnyQuest_Count")
  local BunnyTotal = (OSTBunny + screens_activated)
  SetGlobal("MSN_BunnyTotal", BunnyTotal)
  if (2 <= GetGlobal("MSN_VisitNumber")) then
    SetGlobal("EM2_MSTN_CinemaQuest", 2)
    AnimGBSequence("MSN_MarqueeLights", "on")
    if (GetGlobal("MSN_VaultDoorState") ~= 3) then
      MSN_ParkJamfaceSomewhere()
    end
  end
  ForEachEntityInGroup(Enable, "MSN_CullUndermill")
  Enable("MSN_CullProjUndermill")
  Print("############# MSTN_AlwaysSetup11 ########### MSTN_AlwaysSetup11 ############# MSTN_AlwaysSetup11 ########### MSTN_AlwaysSetup11 ############# MSTN_AlwaysSetup11 ########### MSTN_AlwaysSetup11")
  return 
end
MSN_DisableOswaldTowerPhoto = function()
  if (GetGlobal("RBF_AngelOrDevil") == 2) then
    if (GetGlobal("MSN_OswaldTower") == 0) then
      DisableComponent("meanstreetnorth_scripting.photo_hiddenhero 02.HH_PhotoMarker 01", "Camera Ability Target Component")
      Disable("meanstreetnorth_scripting.photo_hiddenhero 02.HH_PhotoMarker 01")
    end
  elseif (GetGlobal("RBF_AngelOrDevil") == 2) then
    if (GetGlobal("MSN_OswaldTower") == 1) then
      DisableComponent("meanstreetnorth_scripting.photo_hiddenhero 02.HH_PhotoMarker 01", "Camera Ability Target Component")
      Disable("meanstreetnorth_scripting.photo_hiddenhero 02.HH_PhotoMarker 01")
    end
  elseif (GetGlobal("MSN_OswaldTower") == 2) then
    DisableComponent("meanstreetnorth_scripting.photo_hiddenhero 02.HH_PhotoMarker 01", "Camera Ability Target Component")
    Disable("meanstreetnorth_scripting.photo_hiddenhero 02.HH_PhotoMarker 01")
  end
  return 
end
MSN_IntroMovieFinish = function()
  Print("###### MSN_IntroMovieFinish")
  SetGlobal("MSN_IntroMoviePlayed", 1)
  Wait(0.10000000149011612)
  LevelManager_SetZoneStatusUnloaded("MeanStreet_North.MSNorthIGC")
  Wait(0)
  ShowHud()
  Wait(0)
  Quest_SetCriticalPath("Critical_MSN", "Critical_MSN_7")
  StreamInterior(nil, "MeanStreet_North.MSNUnderMill")
  SaveCheckpoint(GetPlayer(), "MSN_LoadCheckPoint", "MSNorth_UTLexit_MickeySpawn")
  while true do
    if (not (LevelManager_HasZoneFinishedStreaming("MeanStreet_North.MSNUnderMill") == false)) then
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
  if (GetGlobal("MSN_VisitNumber") == 1) then
    ForEachEntityInGroup(Hide, "MSN_Fishhead_OswaldSwitch")
  end
  ForEachEntityInGroup(Enable, "MSN_CullUndermill")
  Enable("MSN_CullProjUndermill")
  if (GetGlobal("MSN_UndermillPipeDoor") == 1) then
    Prefab_OswaldElectricSwitch_ChangeState("MSN_UnderMillClosetMarker", "Deactivate")
    ForEachEntityInGroup(DestroyEntity, "MSN_UndermillPipeGroup")
  elseif (GetGlobal("MSN_UndermillPipeDoor") == 2) then
    Prefab_OswaldElectricSwitch_ChangeState("MSN_UnderMillClosetMarker", "Deactivate")
    ForEachEntityInGroup(DestroyEntity, "MSN_UndermillPipeGroup")
    DestroyEntity("MSN_UndermillPipeTreasure")
  end
  return 
end
EM2_MSTN_MovePlayer = function(target)
  MoveToEntity(target, "EM2_NorthStartMarker")
  return 
end
EM2_MSNorth_AddMetalCount = function()
  AddCurrency("ScrapMetal", 1)
  return 
end
EM2_MSNorth_RubeTransitionSet = function()
  SetGlobal("MSS_TransitionCheck", 2)
  return 
end
EM2_MSTN_LoadVentureland = function()
  UnrestrictCutSceneInput()
  LoadLevel(GetPlayer(), "levels/VTL_oasis_Visit1.level")
  return 
end
EM2_MSTN_LoadOsTown = function()
  UnrestrictCutSceneInput()
  LoadLevel(GetPlayer(), "levels/OST_Center_Visit1.level")
  return 
end
EM2_MSTN_LoadBogEasy = function()
  UnrestrictCutSceneInput()
  LoadLevel(GetPlayer(), "levels/NOS_BogEasy_Visit1.level")
  return 
end
EM2_MSTN_GazeboUnhide = function()
  Unhide("EM2_Gazebo")
  return 
end
EM2_MSTN_DefaultCam = function()
  ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
  Wait(1)
  SetDefaultCameraValues(5.5, 7, 0)
  SetTravelCameraValues(7.5, 15, -7)
  return 
end
EM2_MSTN_AskDEC_OsTown = function()
  FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_EnterDEC_Ostown", 1)
  return 
end
EM2_MSTN_LoadDEC_Ostown = function()
  LoadLevel(GetPlayer(), "levels/Transition_01.Level")
  return 
end
EM2_MSTN_HermanBreakDoor = function()
  SpendCurrency("ETicket", 100)
  SetGlobal("MSN_VaultDoorState", 2)
  SetGlobal("MSN_VaultDoorStateSecondary", 1)
  Quest_SetCriticalPath("Critical_MSN", "Critical_MSN_3")
  Prefab_OswaldElectricSwitch_ChangeState("MSN_VaultExitMarker", "Deactivate")
  Disable("MSN_FloorVaultExitMarker")
  SetPropertyFloat("EM2_MSTN_GremlinHerman", "UsableRadius", 0)
  DisableMotion("EM2_MSTN_GremlinHerman")
  DriveMotionWithPhysics("EM2_MSTN_GremlinHerman")
  Wait(0)
  TeleportGremlinToEntity("EM2_MSTN_GremlinHerman", "MSN_HermanSmashDoorMarker")
  local wrench = GetChildEntityByName("EM2_MSTN_GremlinHerman", "GremlinWrench")
  Unhide(wrench)
  AnimVarInt("EM2_MSTN_GremlinHerman", VAR_Cutscene, 1)
  AnimEvent("EM2_MSTN_GremlinHerman", EVENT_Start_Cutscene)
  Wait(0)
  MSN_SaveCheckPoint02()
  AnimGBSequence("MSN_VaultDoor", "break")
  EnableMotion("MSN_VaultSign")
  Wait(0)
  ApplyImpulse("MSN_VaultSign", -150, 100, 5)
  Wait(0)
  ApplyAngularImpulse("MSN_VaultSign", -150, 100, 5)
  Wait(1)
  FireThread(TeleportGremlinOut, "EM2_MSTN_GremlinHerman")
  Wait(1)
  DestroyEntity("MSN_VaultDoor")
  return 
end
EM2_MSTN_IceCreamAirFixed = function()
  if (GetGlobal("MSN_AirConditioner_LargePipe") == 1) then
    if (GetGlobal("MSN_AirConditioner_SmallPipe") == 1) then
      SetGlobal("MSN_GusHintVar", 6)
      TimerEnable("EM2_GusHintTimer")
      TimerReset("EM2_GusHintTimer")
      SetGlobal("EM2_MSTN_AirConditionerFixed", 1)
      ForceSpawn("MSN_AirConditionerWindSpawner", 1)
      OswaldStreamAbort()
      Disable("MSN_OswaldAC_SecondAction")
      Disable("MSN_OswaldAC_FirstAction")
      FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_AirFixed", 1)
    end
  else
    SetGlobal("MSN_GusHintVar", 6)
    TimerEnable("EM2_GusHintTimer")
    TimerReset("EM2_GusHintTimer")
    Prefab_OswaldElectricSwitch_ChangeState("MSN_AirConditionerSwitch", "Reset")
    ForceSequence("EM2_MSTN_GusConvoTrigger", "Generic Line 36")
  end
  return 
end
EM2_MSTN_CinemaFuseBox = function()
  SetGlobal("EM2_MSTN_CinemaFuse", 1)
  StartEmitters("MSN_CinemaFuseboxSpark")
  return 
end
EM2_MSTN_GetMarkusGoing = function()
  FireUser1("EM2_MSTN_MarkusIntro01")
  Wait(0.800000011920929)
  MoveToEntity(GetPlayer(), "MSTN_MickeyIGCMarker01")
  EnableMotion("EM2_MSTN_GremlinMarkus")
  AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Mood_Type, MOOD_Positive)
  Wait(3)
  TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSTN_MarkusIGCMarker")
  return 
end
EM2_MSTN_FoundToolBox = function()
  FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_MarkusBoxFound", 1)
  Enable("MSN_ToolboxTrig")
  return 
end
EM2_MSTN_GusTunnelWarning = function()
  AudioPostEventOn("MSN_TunnelDust01", "Play_sfx_MSN_RockDebris")
  Print("sfx rock debris")
  Wait(0.10000000149011612)
  ForEachEntityInGroup(StartEmitters, "MSN_TunnelDust")
  StartEmitters("MSN_FirstBuildingOuterDust1")
  StartEmitters("MSN_FirstBuildingOuterDust2")
  Wait(1)
  if (GetGlobal("MSN_TunnelPassVar") == 0) then
    ShakeCamera(3, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
    Prefab_ScrapMetalSpawner_Launch("MSN_ScrapLauncher1")
    SetGlobal("MSN_TunnelPassVar", 1)
    FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_TunnelWarning", 1)
    MSN_SaveCheckPoint02()
  end
  Wait(2)
  StopEmitters("MSN_FirstBuildingOuterDust1")
  StopEmitters("MSN_FirstBuildingOuterDust2")
  ForEachEntityInGroup(StopEmitters, "MSN_TunnelDust")
  return 
end
EM2_MSTN_GusTunnelYell = function()
  if (GetGlobal("MSN_RockWallFallen") == 0) then
    Enable("MSN_TunnelCamExitTrigger")
    ShakeCamera(3, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
    AudioPostEventOn("MSN_TunnelDust02", "Play_sfx_MSN_RockDebris")
    Print("sfx rock debris")
    Wait(0.10000000149011612)
    ForEachEntityInGroup(StartEmitters, "MSN_TunnelDust")
    Wait(2)
    ForEachEntityInGroup(StopEmitters, "MSN_TunnelDust")
  else
    ShakeCamera(3, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
    AudioPostEventOn("MSN_TunnelDust02", "Play_sfx_MSN_RockDebris")
    Print("sfx rock debris")
    Wait(0.10000000149011612)
    ForEachEntityInGroup(StartEmitters, "MSN_TunnelDust")
    Wait(2)
    ForEachEntityInGroup(StopEmitters, "MSN_TunnelDust")
  end
  return 
end
MSN_TunnelWallFall = function()
  if (GetGlobal("MSN_RockWallFallen") == 0) then
    Disable("MSN_TunnelCamTrigger")
    ShakeCamera(2, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
    ForEachEntityInGroup(StartEmitters, "MSN_TunnelDust")
    AnimGBSequence("MSN_SideTunnelDoor", "open")
    AudioPostEventOn("MSN_SideTunnelDoor", "Play_sfx_msn_tertiary_tunnel_wall")
    DoStinger("Comment_Dest", 5)
    Wait(1)
    ClearAllCameraAttributes()
    FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_YellForTunnel", 1)
    SetGlobal("MSN_RockWallFallen", 1)
    Wait(1)
    MSN_SaveCheckPoint02()
    DestroyEntity("MSN_SideTunnelDoor")
    ForEachEntityInGroup(StopEmitters, "MSN_TunnelDust")
  end
  return 
end
EM2_MSTN_TeleporterResolveIGC = function()
  FireUser1("MSN_MarkusIGCTeleporter")
  return 
end
EM2_MSTN_TeleporterResolveIGCFinish = function()
  FireUser3("MSN_MarkusIGCTeleporter")
  Hide("EM2_MSTN_GremlinMarkus")
  return 
end
EM2_MSTN_MarkusWindmillIntro = function()
  if (GetGlobal("MSTN_PostOsTown") == 1) then
    FireSequence("EM2_MSTN_GremlinMarkus", "MSN_Markus_Windmill", 1)
  end
  return 
end
MSN_MoveWindmillConvo = function()
  if (GetGlobal("MSTN_PostOsTown") == 1) then
    Unhide("EM2_MSTN_GremlinMarkus")
    TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSN_MarkusWindmillMarker")
    ForEachEntityInGroup(Unhide, "MSN_WindmillOswaldSwitch")
  end
  return 
end
EM2_MSTN_BrokeWindmill = function()
  ForEachEntityInGroup(DestroyEntity, "MSN_WindmillOswaldSwitch")
  AudioPostEventOn("meanstreetnorth_audio.Play_sfx_msn_windmill_on", "Stop_sfx_msn_windmill_on")
  AudioPostEventOn("meanstreetnorth_audio.Play_sfx_msn_gremlin_generator", "Stop_sfx_msn_gremlin_generator")
  AudioPostEventOn("meanstreetnorth_audio.Play_sfx_msn_gremlin_console", "Stop_sfx_msn_gremlin_console")
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  Wait(1)
  FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_BrokeWindmill", 1)
  return 
end
EM2_MSN_FishheadMachineVar = 0
EM2_MSN_FishheadFirstWarning = 0
MSN_OswaldFishheadVar = 0
MSN_FishheadMachineThinned = function()
  EM2_MSN_FishheadMachineVar = (EM2_MSN_FishheadMachineVar + 1)
  if (EM2_MSN_FishheadFirstWarning == 0) then
    FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_FishheadWarning", 1)
    EM2_MSN_FishheadFirstWarning = 1
  end
  if (EM2_MSN_FishheadMachineVar == 2) then
    if (MSN_OswaldFishheadVar == 0) then
      Enable("MSN_PortableGeneratorAction")
    end
  end
  MSN_FishheadBlowUp()
  return 
end
MSN_FishheadOswaldSwitch = function()
  MSN_OswaldFishheadVar = 1
  Enable("MSN_ConstructionSparks1")
  MSN_FishheadBlowUp()
  return 
end
MSN_FishheadMachinePainted = function()
  EM2_MSN_FishheadMachineVar = (EM2_MSN_FishheadMachineVar - 1)
  return 
end
MSN_FishheadBlowUp = function()
  if (EM2_MSN_FishheadMachineVar == 2) then
    if (MSN_OswaldFishheadVar == 1) then
      SetGlobal("MSN_GremlinStructure_FishHead", 2)
      if (GetGlobal("MeanStreet_HasAnyBldgDestroyed") == 0) then
        SetGlobal("MeanStreet_HasAnyBldgDestroyed", 1)
        SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") + 50))
      end
      MSN_SaveCheckPoint02()
      OswaldStreamAbort()
      Disable("MSN_PortableGeneratorAction")
      Enable("MSN_ConstructionSpark02")
      Wait(1)
      ForceSpawn("MSN_FishheadExplosionFXSpawner", 1)
      Wait(1)
      Unhide("MSN_Fishhead")
      Hide("MSN_FishheadPartial")
      AnimGBSequence("MSN_Fishhead", "explode")
      AudioPostEventOn(GetPlayer(), "Play_sfx_FishHead_Explode")
      DoStinger("Comment_Dest", 5)
      DestroyEntity("MSN_Fishhead_MainTrigger")
      Unhide("MSN_FishheadDestroyed")
      ForEachEntityInGroup(DestroyEntity, "MSN_FishheadToon")
      ForEachEntityInGroup(DestroyEntity, "MSN_Fishhead_OswaldSwitch")
      Prefab_ScrapMetalSpawner_Launch("MSN_FishheadMetalSpawner")
      ForceSequence("EM2_MSTN_GremlinMarkus", "MSN_Jamface_FishheadBroke", 1)
      Wait(1)
      DestroyEntity("MSN_Fishhead_BackEntranceCover")
      ForEachEntityInGroup(DestroyEntity, "MSN_SecretFX_FishheadFX")
      Wait(1)
      DestroyEntity("MSN_Fishhead")
    end
  end
  return 
end
MSN_Fishhead_Move = function()
  SetGlobal("MSN_JamFace_Location", 1)
  Wait(0)
  Unhide("EM2_MSTN_GremlinMarkus")
  TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSN_MarkusFishheadMarker")
  return 
end
MSN_FishheadOswaldWarning = function()
  FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Fishhead_OswaldWarning", 1)
  return 
end
MSN_GremHut03Counter = 0
MSN_GremlinHut03Completed = 0
MSN_GremHut03Electric = 0
MSN_GremHut03Master = 0
MSN_SpraySwitchControl = 0
MSN_TowerNozzle = function(target, _event)
  Print("MSN_GremHut03Counter")
  if (GetGlobal("MSN_GremlinStructure_Tower") == 0) then
    if StimulusEvent_HasStimulusType(_event, ST_PAINT) then
      MSN_SpraySwitchControl = 1
      MSN_GremHut03Counter = (MSN_GremHut03Counter + 1)
    elseif StimulusEvent_HasStimulusType(_event, ST_THINNER) then
      MSN_SpraySwitchControl = 0
      MSN_GremHut03Counter = (MSN_GremHut03Counter - 1)
    end
    Print(MSN_GremHut03Counter)
    if (90 <= MSN_GremHut03Counter) then
      MSN_GremHut03Counter = 90
    elseif (MSN_GremHut03Counter <= -90) then
      MSN_GremHut03Counter = -90
    end
    if (MSN_GremHut03Counter == 25) then
      if (MSN_SpraySwitchControl == 0) then
        AnimGBSequence("MSN_GremlinPumpPaint", "EmptyStage1")
        AnimGBSequence("MSN_GremlinPumpPaint02", "RestOff")
      elseif (MSN_SpraySwitchControl == 1) then
        AnimGBSequence("MSN_GremlinPumpPaint", "FillStage1")
        if (MSN_GremHut03Counter == 45) then
          if (MSN_SpraySwitchControl == 0) then
            AnimGBSequence("MSN_GremlinPumpPaint02", "EmptyStage2")
          end
        elseif (MSN_GremHut03Counter == 50) then
          if (MSN_SpraySwitchControl ~= 0) then
            if (MSN_SpraySwitchControl == 1) then
              AnimGBSequence("MSN_GremlinPumpPaint02", "FillStage2")
              AnimGBSequence("MSN_GremlinPumpPaint", "RestStage1")
              if (MSN_GremHut03Counter == 79) then
                if (MSN_GremlinHut03Completed == 1) then
                  AnimGBSequence("MSN_GremlinPumpPaint02", "EmptyStage2")
                end
                MSN_GremlinHut03Completed = 0
              elseif (80 <= MSN_GremHut03Counter) then
                AnimGBSequence("MSN_GremlinPumpPaint02", "FillStage3")
                MSN_GremlinHut03Completed = 1
                if (MSN_GremHut03Electric == 0) then
                  MSN_GremlinHut03OswaldTurn()
                else
                  MSN_GremlinHut03Master()
                end
                Wait(3)
                AnimGBSequence("MSN_GremlinPumpPaint", "RestStage3")
              elseif (MSN_GremHut03Counter == -25) then
                if (MSN_SpraySwitchControl == 1) then
                  AnimGBSequence("MSN_GremlinPumpThinner", "EmptyStage1")
                  AnimGBSequence("MSN_GremlinPumpThinner02", "RestOff")
                elseif (MSN_SpraySwitchControl == 0) then
                  AnimGBSequence("MSN_GremlinPumpThinner", "FillStage1")
                  if (MSN_GremHut03Counter == -50) then
                    if (MSN_SpraySwitchControl == 1) then
                      AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
                    elseif (MSN_SpraySwitchControl == 0) then
                      AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage2")
                      AnimGBSequence("MSN_GremlinPumpThinner", "RestStage1")
                      if (MSN_GremHut03Counter == -79) then
                        if (MSN_GremlinHut03Completed == 2) then
                          AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
                        end
                        MSN_GremlinHut03Completed = 0
                      elseif (MSN_GremHut03Counter <= -80) then
                        AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
                        MSN_GremlinHut03Completed = 2
                        if (MSN_GremHut03Electric == 0) then
                          MSN_GremlinHut03OswaldTurn()
                        else
                          MSN_GremlinHut03Master()
                        end
                      end
                    end
                  elseif (MSN_GremHut03Counter == -79) then
                    if (MSN_GremlinHut03Completed == 2) then
                      AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
                    end
                    MSN_GremlinHut03Completed = 0
                  elseif (MSN_GremHut03Counter <= -80) then
                    AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
                    MSN_GremlinHut03Completed = 2
                    if (MSN_GremHut03Electric == 0) then
                      MSN_GremlinHut03OswaldTurn()
                    else
                      MSN_GremlinHut03Master()
                    end
                  end
                end
              elseif (MSN_GremHut03Counter == -50) then
                if (MSN_SpraySwitchControl == 1) then
                  AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
                elseif (MSN_SpraySwitchControl == 0) then
                  AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage2")
                  AnimGBSequence("MSN_GremlinPumpThinner", "RestStage1")
                  if (MSN_GremHut03Counter == -79) then
                    if (MSN_GremlinHut03Completed == 2) then
                      AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
                    end
                    MSN_GremlinHut03Completed = 0
                  elseif (MSN_GremHut03Counter <= -80) then
                    AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
                    MSN_GremlinHut03Completed = 2
                    if (MSN_GremHut03Electric == 0) then
                      MSN_GremlinHut03OswaldTurn()
                    else
                      MSN_GremlinHut03Master()
                    end
                  end
                end
              elseif (MSN_GremHut03Counter == -79) then
                if (MSN_GremlinHut03Completed == 2) then
                  AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
                end
                MSN_GremlinHut03Completed = 0
              elseif (MSN_GremHut03Counter <= -80) then
                AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
                MSN_GremlinHut03Completed = 2
                if (MSN_GremHut03Electric == 0) then
                  MSN_GremlinHut03OswaldTurn()
                else
                  MSN_GremlinHut03Master()
                end
              end
            end
          end
        elseif (MSN_GremHut03Counter == 79) then
          if (MSN_GremlinHut03Completed == 1) then
            AnimGBSequence("MSN_GremlinPumpPaint02", "EmptyStage2")
          end
          MSN_GremlinHut03Completed = 0
        elseif (80 <= MSN_GremHut03Counter) then
          AnimGBSequence("MSN_GremlinPumpPaint02", "FillStage3")
          MSN_GremlinHut03Completed = 1
          if (MSN_GremHut03Electric == 0) then
            MSN_GremlinHut03OswaldTurn()
          else
            MSN_GremlinHut03Master()
          end
          Wait(3)
          AnimGBSequence("MSN_GremlinPumpPaint", "RestStage3")
        elseif (MSN_GremHut03Counter == -25) then
          if (MSN_SpraySwitchControl == 1) then
            AnimGBSequence("MSN_GremlinPumpThinner", "EmptyStage1")
            AnimGBSequence("MSN_GremlinPumpThinner02", "RestOff")
          elseif (MSN_SpraySwitchControl == 0) then
            AnimGBSequence("MSN_GremlinPumpThinner", "FillStage1")
            if (MSN_GremHut03Counter == -50) then
              if (MSN_SpraySwitchControl == 1) then
                AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
              elseif (MSN_SpraySwitchControl == 0) then
                AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage2")
                AnimGBSequence("MSN_GremlinPumpThinner", "RestStage1")
                if (MSN_GremHut03Counter == -79) then
                  if (MSN_GremlinHut03Completed == 2) then
                    AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
                  end
                  MSN_GremlinHut03Completed = 0
                elseif (MSN_GremHut03Counter <= -80) then
                  AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
                  MSN_GremlinHut03Completed = 2
                  if (MSN_GremHut03Electric == 0) then
                    MSN_GremlinHut03OswaldTurn()
                  else
                    MSN_GremlinHut03Master()
                  end
                end
              end
            elseif (MSN_GremHut03Counter == -79) then
              if (MSN_GremlinHut03Completed == 2) then
                AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
              end
              MSN_GremlinHut03Completed = 0
            elseif (MSN_GremHut03Counter <= -80) then
              AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
              MSN_GremlinHut03Completed = 2
              if (MSN_GremHut03Electric == 0) then
                MSN_GremlinHut03OswaldTurn()
              else
                MSN_GremlinHut03Master()
              end
            end
          end
        elseif (MSN_GremHut03Counter == -50) then
          if (MSN_SpraySwitchControl == 1) then
            AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
          elseif (MSN_SpraySwitchControl == 0) then
            AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage2")
            AnimGBSequence("MSN_GremlinPumpThinner", "RestStage1")
            if (MSN_GremHut03Counter == -79) then
              if (MSN_GremlinHut03Completed == 2) then
                AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
              end
              MSN_GremlinHut03Completed = 0
            elseif (MSN_GremHut03Counter <= -80) then
              AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
              MSN_GremlinHut03Completed = 2
              if (MSN_GremHut03Electric == 0) then
                MSN_GremlinHut03OswaldTurn()
              else
                MSN_GremlinHut03Master()
              end
            end
          end
        elseif (MSN_GremHut03Counter == -79) then
          if (MSN_GremlinHut03Completed == 2) then
            AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
          end
          MSN_GremlinHut03Completed = 0
        elseif (MSN_GremHut03Counter <= -80) then
          AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
          MSN_GremlinHut03Completed = 2
          if (MSN_GremHut03Electric == 0) then
            MSN_GremlinHut03OswaldTurn()
          else
            MSN_GremlinHut03Master()
          end
        end
      end
    elseif (MSN_GremHut03Counter == 45) then
      if (MSN_SpraySwitchControl == 0) then
        AnimGBSequence("MSN_GremlinPumpPaint02", "EmptyStage2")
      end
    elseif (MSN_GremHut03Counter == 50) then
      if (MSN_SpraySwitchControl ~= 0) then
        if (MSN_SpraySwitchControl == 1) then
          AnimGBSequence("MSN_GremlinPumpPaint02", "FillStage2")
          AnimGBSequence("MSN_GremlinPumpPaint", "RestStage1")
          if (MSN_GremHut03Counter == 79) then
            if (MSN_GremlinHut03Completed == 1) then
              AnimGBSequence("MSN_GremlinPumpPaint02", "EmptyStage2")
            end
            MSN_GremlinHut03Completed = 0
          elseif (80 <= MSN_GremHut03Counter) then
            AnimGBSequence("MSN_GremlinPumpPaint02", "FillStage3")
            MSN_GremlinHut03Completed = 1
            if (MSN_GremHut03Electric == 0) then
              MSN_GremlinHut03OswaldTurn()
            else
              MSN_GremlinHut03Master()
            end
            Wait(3)
            AnimGBSequence("MSN_GremlinPumpPaint", "RestStage3")
          elseif (MSN_GremHut03Counter == -25) then
            if (MSN_SpraySwitchControl == 1) then
              AnimGBSequence("MSN_GremlinPumpThinner", "EmptyStage1")
              AnimGBSequence("MSN_GremlinPumpThinner02", "RestOff")
            elseif (MSN_SpraySwitchControl == 0) then
              AnimGBSequence("MSN_GremlinPumpThinner", "FillStage1")
              if (MSN_GremHut03Counter == -50) then
                if (MSN_SpraySwitchControl == 1) then
                  AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
                elseif (MSN_SpraySwitchControl == 0) then
                  AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage2")
                  AnimGBSequence("MSN_GremlinPumpThinner", "RestStage1")
                  if (MSN_GremHut03Counter == -79) then
                    if (MSN_GremlinHut03Completed == 2) then
                      AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
                    end
                    MSN_GremlinHut03Completed = 0
                  elseif (MSN_GremHut03Counter <= -80) then
                    AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
                    MSN_GremlinHut03Completed = 2
                    if (MSN_GremHut03Electric == 0) then
                      MSN_GremlinHut03OswaldTurn()
                    else
                      MSN_GremlinHut03Master()
                    end
                  end
                end
              elseif (MSN_GremHut03Counter == -79) then
                if (MSN_GremlinHut03Completed == 2) then
                  AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
                end
                MSN_GremlinHut03Completed = 0
              elseif (MSN_GremHut03Counter <= -80) then
                AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
                MSN_GremlinHut03Completed = 2
                if (MSN_GremHut03Electric == 0) then
                  MSN_GremlinHut03OswaldTurn()
                else
                  MSN_GremlinHut03Master()
                end
              end
            end
          elseif (MSN_GremHut03Counter == -50) then
            if (MSN_SpraySwitchControl == 1) then
              AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
            elseif (MSN_SpraySwitchControl == 0) then
              AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage2")
              AnimGBSequence("MSN_GremlinPumpThinner", "RestStage1")
              if (MSN_GremHut03Counter == -79) then
                if (MSN_GremlinHut03Completed == 2) then
                  AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
                end
                MSN_GremlinHut03Completed = 0
              elseif (MSN_GremHut03Counter <= -80) then
                AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
                MSN_GremlinHut03Completed = 2
                if (MSN_GremHut03Electric == 0) then
                  MSN_GremlinHut03OswaldTurn()
                else
                  MSN_GremlinHut03Master()
                end
              end
            end
          elseif (MSN_GremHut03Counter == -79) then
            if (MSN_GremlinHut03Completed == 2) then
              AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
            end
            MSN_GremlinHut03Completed = 0
          elseif (MSN_GremHut03Counter <= -80) then
            AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
            MSN_GremlinHut03Completed = 2
            if (MSN_GremHut03Electric == 0) then
              MSN_GremlinHut03OswaldTurn()
            else
              MSN_GremlinHut03Master()
            end
          end
        end
      end
    elseif (MSN_GremHut03Counter == 79) then
      if (MSN_GremlinHut03Completed == 1) then
        AnimGBSequence("MSN_GremlinPumpPaint02", "EmptyStage2")
      end
      MSN_GremlinHut03Completed = 0
    elseif (80 <= MSN_GremHut03Counter) then
      AnimGBSequence("MSN_GremlinPumpPaint02", "FillStage3")
      MSN_GremlinHut03Completed = 1
      if (MSN_GremHut03Electric == 0) then
        MSN_GremlinHut03OswaldTurn()
      else
        MSN_GremlinHut03Master()
      end
      Wait(3)
      AnimGBSequence("MSN_GremlinPumpPaint", "RestStage3")
    elseif (MSN_GremHut03Counter == -25) then
      if (MSN_SpraySwitchControl == 1) then
        AnimGBSequence("MSN_GremlinPumpThinner", "EmptyStage1")
        AnimGBSequence("MSN_GremlinPumpThinner02", "RestOff")
      elseif (MSN_SpraySwitchControl == 0) then
        AnimGBSequence("MSN_GremlinPumpThinner", "FillStage1")
        if (MSN_GremHut03Counter == -50) then
          if (MSN_SpraySwitchControl == 1) then
            AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
          elseif (MSN_SpraySwitchControl == 0) then
            AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage2")
            AnimGBSequence("MSN_GremlinPumpThinner", "RestStage1")
            if (MSN_GremHut03Counter == -79) then
              if (MSN_GremlinHut03Completed == 2) then
                AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
              end
              MSN_GremlinHut03Completed = 0
            elseif (MSN_GremHut03Counter <= -80) then
              AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
              MSN_GremlinHut03Completed = 2
              if (MSN_GremHut03Electric == 0) then
                MSN_GremlinHut03OswaldTurn()
              else
                MSN_GremlinHut03Master()
              end
            end
          end
        elseif (MSN_GremHut03Counter == -79) then
          if (MSN_GremlinHut03Completed == 2) then
            AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
          end
          MSN_GremlinHut03Completed = 0
        elseif (MSN_GremHut03Counter <= -80) then
          AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
          MSN_GremlinHut03Completed = 2
          if (MSN_GremHut03Electric == 0) then
            MSN_GremlinHut03OswaldTurn()
          else
            MSN_GremlinHut03Master()
          end
        end
      end
    elseif (MSN_GremHut03Counter == -50) then
      if (MSN_SpraySwitchControl == 1) then
        AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
      elseif (MSN_SpraySwitchControl == 0) then
        AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage2")
        AnimGBSequence("MSN_GremlinPumpThinner", "RestStage1")
        if (MSN_GremHut03Counter == -79) then
          if (MSN_GremlinHut03Completed == 2) then
            AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
          end
          MSN_GremlinHut03Completed = 0
        elseif (MSN_GremHut03Counter <= -80) then
          AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
          MSN_GremlinHut03Completed = 2
          if (MSN_GremHut03Electric == 0) then
            MSN_GremlinHut03OswaldTurn()
          else
            MSN_GremlinHut03Master()
          end
        end
      end
    elseif (MSN_GremHut03Counter == -79) then
      if (MSN_GremlinHut03Completed == 2) then
        AnimGBSequence("MSN_GremlinPumpThinner02", "EmptyStage2")
      end
      MSN_GremlinHut03Completed = 0
    elseif (MSN_GremHut03Counter <= -80) then
      AnimGBSequence("MSN_GremlinPumpThinner02", "FillStage3")
      MSN_GremlinHut03Completed = 2
      if (MSN_GremHut03Electric == 0) then
        MSN_GremlinHut03OswaldTurn()
      else
        MSN_GremlinHut03Master()
      end
    end
  end
  return 
end
MSN_GremlinHut03OswaldTurn = function()
  if (MSN_GremHut03Electric == 0) then
    Enable("MSN_OswaldShockGremlinTower")
  end
  return 
end
MSN_OswaldShootTowerSwitch = function()
  OswaldStreamAction("MSN_GremHut03_OsSwitch")
  return 
end
MSN_GremlinHut03Electric = function()
  OswaldStreamAbort()
  Disable("MSN_OswaldShockGremlinTower")
  MSN_GremHut03Electric = 1
  if (MSN_GremlinHut03Completed == 0) then
    ForceSequence("EM2_MSTN_GremlinMarkus", "MSN_Grem03_RepeatInstruction")
  end
  MSN_GremlinHut03Master()
  return 
end
MSN_GremlinHut03Master = function()
  if (MSN_GremlinHut03Completed == 1) then
    if (MSN_GremHut03Electric == 1) then
      if (GetGlobal("MSN_GremlinStructure_Tower") == 0) then
        SetGlobal("MSN_GremlinStructure_Tower", 1)
        SetGlobal("MSN_SprayVar", 1)
        ForEachEntityInGroup(DestroyEntity, "MSN_GremlinHutComponents")
        AnimGBSequence("MSN_TowerSmallDoor", "opening")
        SetPropertyFloat("MSN_Tower_MainTrigger", "UsableRadius", 2)
        FireSequence("EM2_MSTN_GremlinMarkus", "MSN_Markus_GremHut03Fixed", 1)
        AudioPostEventOn("meanstreetnorth_audio.Play_sfx_msn_gremlin_hut_come_alive", "Play_sfx_msn_gremlin_hut_come_alive")
        DoStinger("Comment_Rest", 5)
        TeleportGremlinOut("MSN_Gremlin_Shaky")
      end
    end
  end
  if (MSN_GremlinHut03Completed == 2) then
    if (MSN_GremHut03Electric == 1) then
      if (GetGlobal("MSN_GremlinStructure_Tower") == 0) then
        SetGlobal("MSN_GremlinStructure_Tower", 2)
        SetGlobal("MSN_SprayVar", 1)
        Disable("MSN_JamfaceTowerTeleTrigger")
        if (GetGlobal("MeanStreet_HasAnyBldgDestroyed") == 0) then
          SetGlobal("MeanStreet_HasAnyBldgDestroyed", 1)
          SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") + 50))
        end
        MSN_GremHut03Master = 1
        ForEachEntityInGroup(DestroyEntity, "MSN_GremlinHutComponents")
        SetParentEntity("MSN_GremlinPumpThinner02", "MSTN_TowerTank")
        AnimGBSequence("MSTN_TowerTank", "down")
        Prefab_OswaldElectricSwitch_ChangeState("MSN_GremHut03_OsSwitch", "Deactivate")
        Wait(0)
        DestroyEntity("MSN_GremlinPumpThinner02")
        AudioPostEventOn(nil, "Play_sfx_msn_gremlin_hut_cannister_fall")
        DoStinger("Comment_Dest", 5)
        Wait(2)
        ForceSpawn("MSN_TankExplodeFXSpawner", 1)
        ForceSpawn("MSN_TankSplashThinnerSpawner", 1)
        AnimGBSequence("MSN_SewerCap", "destroyed")
        Wait(0.10000000149011612)
        Prefab_ScrapMetalSpawner_Launch("MSN_PitMetalSpawner")
        ForceSequence("EM2_MSTN_GremlinMarkus", "MSN_Markus_GremHut03Destroyed", 1)
        Wait(3)
        DestroyEntity("MSN_SewerCap")
        StopEmitters("MSN_TankExplodeFX")
        StopEmitters("MSN_TankSplashThinner")
        TeleportGremlinOut("EM2_MSTN_GremlinMarkus")
        TeleportGremlinOut("MSN_Gremlin_Shaky")
      end
    end
  end
  return 
end
MSN_TowerFall = function()
  DestroyEntity("EM2_MSTN_NotFallenTower")
  Wait(2)
  Unhide("EM2_MSTN_FallenTower")
  SetPropertyFloat("MSN_CameraPedPathDetour", "BranchPathChance", 0)
  return 
end
MSN_AirConditionerSmallPipe_Painted = function()
  if (GetGlobal("EM2_MSTN_AirConditionerFixed") == 0) then
    Enable("MSN_OswaldAC_FirstAction")
    SetGlobal("MSN_AirConditioner_SmallPipe", 1)
    StopEmitters("MSN_AirCondit_SteamSmallPipe")
    MSN_AirConditionerToonMaster()
  end
  return 
end
MSN_AirConditionerSmallPipe_Thinned = function()
  if (GetGlobal("EM2_MSTN_AirConditionerFixed") == 0) then
    Disable("MSN_OswaldAC_SecondAction")
    SetGlobal("MSN_AirConditioner_SmallPipe", 0)
    if (GetGlobal("MSN_AirConditioner_SmallPipe") == 0) then
      if (GetGlobal("MSN_AirConditioner_LargePipe") == 0) then
        Disable("MSN_OswaldAC_FirstAction")
      end
    end
    StartEmitters("MSN_AirCondit_SteamSmallPipe")
    AudioPostEventOn("meanstreetnorth_audio.Play_sfx_msn_ac_unit_lp", "Stop_sfx_msn_ac_unit_lp")
  end
  return 
end
MSN_AirConditionerLargePipe_Painted = function()
  if (GetGlobal("EM2_MSTN_AirConditionerFixed") == 0) then
    Enable("MSN_OswaldAC_FirstAction")
    SetGlobal("MSN_AirConditioner_LargePipe", 1)
    StopEmitters("MSN_AirCondit_SteamLargePipe")
    MSN_AirConditionerToonMaster()
  end
  return 
end
MSN_AirConditionerLargePipe_Thinned = function()
  if (GetGlobal("EM2_MSTN_AirConditionerFixed") == 0) then
    Disable("MSN_OswaldAC_SecondAction")
    SetGlobal("MSN_AirConditioner_LargePipe", 0)
    if (GetGlobal("MSN_AirConditioner_SmallPipe") == 0) then
      if (GetGlobal("MSN_AirConditioner_LargePipe") == 0) then
        Disable("MSN_OswaldAC_FirstAction")
      end
    end
    StartEmitters("MSN_AirCondit_SteamLargePipe")
    AudioPostEventOn("meanstreetnorth_audio.Play_sfx_msn_ac_unit_lp", "Stop_sfx_msn_ac_unit_lp")
  end
  return 
end
MSN_AirConditionerToonMaster = function()
  if (GetGlobal("MSN_AirConditioner_SmallPipe") == 1) then
    if (GetGlobal("MSN_AirConditioner_LargePipe") == 1) then
      Disable("MSN_OswaldAC_FirstAction")
      Wait(0)
      Enable("MSN_OswaldAC_SecondAction")
    end
  end
  return 
end
MSN_OswaldShootConditioner = function()
  OswaldStreamAction("MSN_AirConditionerOsSwitch")
  AudioPostEventOn("meanstreetnorth_audio.Play_sfx_msn_ac_unit_lp", "Play_sfx_msn_ac_unit_lp")
  StartEmitters("MSN_AirCondit_SteamTop")
  return 
end
MSN_AirConditioner_FanOn = function()
  if (GetGlobal("EM2_MSTN_AirConditionerFixed") == 0) then
    StopEmitters("MSN_AirCondit_SteamTop")
  elseif (GetGlobal("EM2_MSTN_AirConditionerFixed") == 1) then
    StartEmitters("MSN_AirCondit_SteamTop")
    Disable("MSN_OswaldAC_SecondAction")
    Disable("MSN_OswaldAC_FirstAction")
  end
  return 
end
MSN_GremHut3_Painted = function()
  if (OswaldUpVar == 1) then
    OswaldSetPathAction("MSN_Gremhut03_OsPatrol")
    Wait(2)
    OswaldStreamAction("MSN_GremHut03_OsSwitch")
    MSN_GremlinHut03Painted()
  else
    OswaldTeleportToLocationAction("MSTN_OswaldArcadeTeleport")
    Wait(0.20000000298023224)
    OswaldSetPathAction("MSN_Gremhut03_OsPatrol")
    Wait(2)
    OswaldStreamAction("MSN_GremHut03_OsSwitch")
    MSN_GremlinHut03Painted()
  end
  return 
end
MSN_GremHut3_Thinned = function()
  OswaldSetPathAction("MSN_Gremhut03_OsPatrol")
  Wait(2)
  OswaldStreamAction("MSN_GremHut03_OsSwitch")
  MSN_GremlinHut03Thinned()
  return 
end
MSN_MarkusHutQuestTeleportIn = function()
  MoveToEntity(GetPlayer(), "MSN_MickeyConstructionIGCMarker")
  TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSN_TalkerConstructionMarker")
  return 
end
MSN_UnhideTheParts = function()
  ForEachEntityInGroup(Unhide, "MSN_PartsContainers")
  Unhide("EM2_MSTN_GremlinMarkus")
  TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSN_MarkusPostVaultRobbery")
  return 
end
MSN_OswaldWalkTo_Generator = function()
  OswaldSetPathAction("MSN_PortableGenOswaldSpot")
  return 
end
MSN_MakeOswaldShootGenerator = function()
  OswaldStreamAction("MSN_GeneratorShootMarker")
  return 
end
MSN_ShopClosedPrompt = function()
  FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_ShopClosed", 1)
  return 
end
MSN_Fishhead_PreFixed = function()
  SetGlobal("MSN_GremlinStructure_FishHead", 1)
  SpendCurrency("ScrapMetal", 50)
  Prefab_OswaldElectricSwitch_ChangeState("MSN_OswaldConstructionLever", "Deactivate")
  MSN_SaveCheckPoint02()
  return 
end
MSN_MoveOswaldCinemaRoof = function()
  TeleportToEntity(GetOswaldAI(), "MSN_OswaldCimenaRoofMarker")
  return 
end
MSN_OswaldShootCinemaSign = function()
  OswaldStreamAction("MSN_CinemaFuseboxSignMarker")
  return 
end
MSN_AskGotoUtilidor = function()
  FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_AskUtilidorsElevator", 1)
  return 
end
OswaldUpVar = 0
MickeyUpVar = 0
MSTN_HideGremlinMarkus = function()
  TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSTN_MarkusRoofMarker")
  return 
end
MSTN_TransporterPartObtained = function()
  SetGlobal("EM2_MSTN_ToolBox", 1)
  SetGlobal("EM2_MSTN_ToolBoxQuest", 3)
  FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_FoundTransporterPart", 1)
  return 
end
MSTN_MakeMarkusFixTransporter = function()
  TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSTN_TransporterFixMarker")
  return 
end
MSN_EnterInteriorCameraShop = function()
  InterruptCurrentSequence()
  ReplaceMusicStateOverride("MSN_IntCameraShop")
  if (4 <= GetGlobal("EM2_EpisodeCheck")) then
    SetPropertyFloat("MSN_JackKelly", "UsableRadius", 0)
    Hide("MSN_JackKelly")
  end
  Prefab_EnterInterior_FadeIn()
  return 
end
MSN_EnterInteriorCinema = function()
  InterruptCurrentSequence()
  ReplaceMusicStateOverride("MSN_IntCinema")
  if (GetGlobal("MSN_Fifer_Intro_Played") == 1) then
    if (2 <= GetGlobal("EM2_EpisodeCheck")) then
      Hide("MSN_FiferPig")
    end
  end
  if (2 <= GetGlobal("EM2_EpisodeCheck")) then
    FireThread(Prefab_Projector_ChangeState, "MSN_CinemaProjector", "Activate")
  end
  Prefab_EnterInterior_FadeIn()
  return 
end
MSN_EnterInteriorPennyArcade = function()
  InterruptCurrentSequence()
  if (GetGlobal("MSN_ArcadeMachine01_On") == 1) then
    AnimVarInt("MSN_Flynn", VAR_Mood_Type, MOOD_Positive)
  end
  if (1 <= GetGlobal("MSN_ArcadeMachine03_On")) then
    Unhide("MSN_ArcadeMachine_DocRide")
    SetPropertyFloat("MSN_Arcade_NewRideTrigger", "UsableRadius", 2)
  elseif (GetGlobal("MSN_ArcadeMachine03_On") == 0) then
    Hide("MSN_ArcadeMachine_DocRide")
    SetPropertyFloat("MSN_Arcade_NewRideTrigger", "UsableRadius", 0)
  end
  if (1 <= GetGlobal("MSN_ArcadeMachine02_On")) then
    Unhide("MSN_ArcadeMachine_Dragon")
    SetPropertyFloat("MSN_Arcade_DragonTrigger", "UsableRadius", 2)
  elseif (GetGlobal("MSN_ArcadeMachine02_On") == 0) then
    SetPropertyFloat("MSN_Arcade_DragonTrigger", "UsableRadius", 0)
  end
  if (1 <= GetGlobal("MSN_ArcadeMachine01_On")) then
    Unhide("MSN_ArcadeMachine_Arena")
    SetPropertyFloat("MSN_Arcade_ArenaTrigger", "UsableRadius", 2)
  elseif (GetGlobal("MSN_ArcadeMachine01_On") == 0) then
    SetPropertyFloat("MSN_Arcade_ArenaTrigger", "UsableRadius", 0)
  end
  ReplaceMusicStateOverride("MSN_IntArcade")
  Prefab_EnterInterior_FadeIn()
  return 
end
MSN_InPinTrader = false
MSN_EnterInteriorPinTrader = function()
  InterruptCurrentSequence()
  ReplaceMusicStateOverride("MSN_IntPinTrader")
  MSN_InPinTrader = true
  SetupBlackBags()
  Prefab_EnterInterior_FadeIn()
  return 
end
MSN_ExitInteriorPinTrader = function()
  MSN_InPinTrader = false
  MSN_StreamUnderMill()
  return 
end
MSN_SpawnBunnyChildren = function()
  InterruptCurrentSequence()
  local BunnyCount = GetGlobal("MSN_BunnyQuest_Count")
  if (0 < BunnyCount) then
    BunnyCount = (BunnyCount / 5)
    ForceSpawn("MSN_BunnyChildSpawner", BunnyCount)
  end
  ReplaceMusicStateOverride("MSN_IntIceCream")
  Prefab_EnterInterior_FadeIn()
  return 
end
MSN_UsherPigPayment = function()
  GiveCurrencyItem("Gold_Pin", 1)
  AddCurrency("ETicket", 50)
  MSN_SaveCheckPoint02()
  return 
end
MSN_ETicket1000 = function()
  AddCurrency("ETicket", 1000)
  return 
end
MSN_ETicket1500 = function()
  AddCurrency("ETicket", 1500)
  return 
end
MSN_ETicket2500 = function()
  AddCurrency("ETicket", 2500)
  return 
end
MSN_ETicket3500 = function()
  AddCurrency("ETicket", 3500)
  return 
end
MSN_ETicket6000 = function()
  AddCurrency("ETicket", 6000)
  return 
end
MSN_PictureRewardPositive = function()
  GiveCurrencyItem("Bronze_Pin", 1)
  return 
end
MSN_PictureRewardNegative = function()
  AddCurrency("ETicket", 100)
  return 
end
MSN_PigCheck = function()
  Unhide("MSN_FiferPig")
  return 
end
MSN_HermanGotPaid = function()
  SpendCurrency("ETicket", 100)
  return 
end
MSN_GusRemindArcade = function()
  SetGlobal("MSN_GusHintVar", 3)
  TimerEnable("EM2_GusHintTimer")
  TimerReset("EM2_GusHintTimer")
  FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_GotoPennyArcade")
  AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Mood_Type, MOOD_Positive)
  Wait(0)
  AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Cutscene, 103)
  AnimEvent("EM2_MSTN_GremlinMarkus", EVENT_Start_Cutscene)
  return 
end
MSN_OswaldJump_Enable = function(target)
  FireThread(enableJumpVolumeAvailability, target)
  return 
end
MSN_OswaldJump_Disable = function(target)
  FireThread(disableJumpVolumeAvailability, target)
  return 
end
MSN_MakeOswaldJumpBalcony = function()
  OswaldSetPathAction("MSN_OswaldBalconyToss")
  return 
end
DBC_MakeOswaldFollow = function()
  OswaldStartFollowAction()
  return 
end
MSN_SendOswaldToBricks = function()
  OswaldSetPathAction("MSN_OswaldWaitNearBricks")
  return 
end
MSN_ThinBricks = function()
  Enable("MSN_BricksTrigger")
  return 
end
MSN_PaintBricks = function()
  OswaldStartFollowAction()
  Disable("MSN_BricksTrigger")
  return 
end
MSN_EnterOsTownProjector = function(target)
  SetGlobal("MSN_GusHintVar", 8)
  SetupPosition(target)
  return 
end
MSN_EnterBogEasyProjector = function(target)
  SetGlobal("MSN_GusHintVar", 8)
  if (3 <= GetGlobal("EM2_EpisodeCheck")) then
    SetGlobal("NOS_BogEasy_FirstVisit", 0)
  end
  Wait(0)
  SetupPosition(target)
  return 
end
MSN_EnterVenLandProjector = function(target)
  SetGlobal("MSN_GusHintVar", 8)
  SetupPosition(target)
  return 
end
MSN_EnterTomCityProjector = function(target)
  SetGlobal("MSN_FromTomCityProjector", 1)
  SetGlobal("MSN_GusHintVar", 8)
  SetupPosition(target)
  return 
end
MSN_BandConcert2DTransitionSetup = function()
  LevelManager_SetCurrentState("MeanStreet_North.BandConcert2D")
  WaitForLevelLoad()
  SetupPosition(target)
  return 
end
MSN_ReturnFromHUB = function(target)
  if (GetGlobal("MSN_VisitNumber") == 1) then
    SetGlobal("MSN_VisitNumber", 2)
  end
  MSTN_AlwaysSetupVisit2()
  ShowHud()
  Projector_To_IGC_Cleanup(target, true)
  MSN_SaveCheckPoint02()
  wait(0.5)
  StartFadeIn(0.5)
  return 
end
MSN_CinemaRoofSwitchPainted = function()
  OswaldStreamAction("MSN_CinemaFuseboxSignMarker")
  return 
end
MSN_OswaldShootCinemaSwitch = function()
  OswaldStreamAction("MSN_CinemaFuseboxSignMarker")
  return 
end
MSN_CinemaRoofSuccess = function()
  SetGlobal("EM2_MSTN_CinemaFuse", 1)
  OswaldStreamAbort()
  Disable("MSN_CinemaActionMarker")
  Wait(0.10000000149011612)
  StartEmitters("MSN_CinemaFuseboxSpark")
  OswaldStartFollowAction()
  SetGlobal("MSN_GusHintVar", 1)
  TimerEnable("EM2_GusHintTimer")
  TimerReset("EM2_GusHintTimer")
  if (GetGlobal("MSN_Usher_FuseBroke_Played") == 0) then
    FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_CinemaFixedNoQuest")
  elseif (GetGlobal("MSN_Usher_FuseBroke_Played") == 1) then
    FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_CinemaFixed")
  end
  return 
end
MSN_GusFuseBoxInstruction = function()
  FireSequence("EM2_MSTN_GusConvoTrigger", "Generic_Gus_Whatisthat3")
  return 
end
MSN_RoofOswaldFollow = function()
  OswaldStartFollowAction()
  return 
end
MSN_OswaldJumpOffRoof = function()
  OswaldJumpAction("MSN_JumpRoofMarker")
  return 
end
MSN_RescueOswald = function()
  OswaldTeleportToMickeyAction()
  return 
end
MSN_EnableRoofJump10 = function()
  FireThread(enableJumpVolumeAvailability, "MSN_JumpRoof10")
  FireThread(enableJumpVolumeAvailability, "MSN_JumpRoof11")
  return 
end
MSN_DisableRoofJump10 = function()
  FireThread(disableJumpVolumeAvailability, "MSN_JumpRoof10")
  FireThread(disableJumpVolumeAvailability, "MSN_JumpRoof11")
  return 
end
FromVentToMSN = function(target)
  SetGlobal("MSN_ProectorState", 3)
  SetupPosition(target)
  return 
end
MSN_GiveLockbreakerPin = function()
  GiveCollectible("Lockbreaker")
  return 
end
MSN_Spirit = function()
  ForceSequence("MSN_SpiritConvoMarker", "MSN_SOTW_Intro")
  return 
end
MSN_SpiritDone = function()
  SetPropertyFloat("MSN_SpiritConvoMarker", "UsableRadius", 0)
  Hide("MSN_SpiritFX")
  SetGlobal("MSN_SOTW_Intro_Played", 1)
  MSN_SaveCheckPoint02()
  return 
end
MSN_StreamUnderMill = function()
  DecrementPaintAbilitiesDisabled(GetPlayer())
  StreamInterior(nil, "MeanStreet_North.MSNUnderMill")
  Prefab_ExitInterior_FadeIn()
  while true do
    if (not (LevelManager_HasZoneFinishedStreaming("MeanStreet_North.MSNUnderMill") == false)) then
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
  ForEachEntityInGroup(Enable, "MSN_CullUndermill")
  Enable("MSN_CullProjUndermill")
  RemoveAllMusicStateOverride()
  if (GetGlobal("MSN_GremlinStructure_WindMill") == 1) then
    SetRotatorMaxSpeed("MSN_MCP", 100)
  end
  if (GetGlobal("MSN_VisitNumber") == 1) then
    ForEachEntityInGroup(Hide, "MSN_Fishhead_OswaldSwitch")
    Disable("MSN_PortableGeneratorAction")
  end
  if (GetGlobal("MSN_UndermillPipeDoor") == 1) then
    Prefab_OswaldElectricSwitch_ChangeState("MSN_UnderMillClosetMarker", "Deactivate")
    ForEachEntityInGroup(DestroyEntity, "MSN_UndermillPipeGroup")
  elseif (GetGlobal("MSN_UndermillPipeDoor") == 2) then
    Prefab_OswaldElectricSwitch_ChangeState("MSN_UnderMillClosetMarker", "Deactivate")
    ForEachEntityInGroup(DestroyEntity, "MSN_UndermillPipeGroup")
    DestroyEntity("MSN_UndermillPipeTreasure")
  end
  return 
end
MSN_WindmillTeleportCheck = 0
MSN_FixWindmill = function()
  SetGlobal("MSN_GusHintVar", 5)
  SetGlobal("MSN_GremlinStructure_WindMill", 1)
  SetGlobal("MSN_FixWindmillChatGuard", 1)
  SpendCurrency("ScrapMetal", 50)
  Quest_SetCriticalPath("Critical_MSN", "Critical_MSN_3")
  Wait(0)
  MSN_SaveCheckPoint02()
  TimerEnable("EM2_GusHintTimer")
  TimerReset("EM2_GusHintTimer")
  Enable("MSN_ApproachWindmill")
  local wrench = GetChildEntityByName("EM2_MSTN_GremlinMarkus", "GremlinWrench")
  TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSN_GremlinWindmillMarker01")
  Unhide(wrench)
  Wait(0.10000000149011612)
  if (MSN_WindmillTeleportCheck == 0) then
    AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Cutscene, 1)
    AnimEvent("EM2_MSTN_GremlinMarkus", EVENT_Start_Cutscene)
  end
  ActivateGremlinHint("MSN_GusHint01")
  FireThread(FireSequence, "EM2_MSTN_GusConvoTrigger", "Genric Line 16", 1)
  return 
end
MSN_ApproachFixedWindmill = function()
  MSN_WindmillTeleportCheck = 1
  EnableMotion("MSN_WindmillBoard02")
  ApplyImpulse("MSN_WindmillBoard02", 100, 100, 100)
  Wait(0.4000000059604645)
  EnableMotion("MSN_WindmillBoard03")
  ApplyImpulse("MSN_WindmillBoard03", 110, 140, 110)
  Wait(0.4000000059604645)
  EnableMotion("MSN_WindmillBoard01")
  ApplyImpulse("MSN_WindmillBoard01", 120, 110, 90)
  AudioPostEventOn("meanstreetnorth_audio.Play_sfx_msn_windmill_on", "Play_sfx_msn_windmill_on")
  Wait(0.10000000149011612)
  local wrench = GetChildEntityByName("EM2_MSTN_GremlinMarkus", "GremlinWrench")
  Hide(wrench)
  FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_MarkusWindmillMarker")
  Wait(0.20000000298023224)
  SetRotatorMaxSpeed("MSN_WindmillDoor", 20)
  StartRotateToPosition("MSN_WindmillDoor", 90)
  ForEachEntityInGroup(Unhide, "MSN_WindmillArt")
  Enable("MSN_WindMill_MainTrigger")
  SetPropertyFloat("MSN_WindMill_MainTrigger", "UsableRadius", 2)
  DoStinger("Comment_Rest", 5)
  SetRotatorMaxSpeed("MSN_MCP", 100)
  FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_GoWindmill", 1)
  return 
end
MSN_Take50Metal = function()
  SpendCurrency("ScrapMetal", 50)
  return 
end
MSN_MovePlayersToUnderMill = function()
  RestrictCutSceneInput()
  StartFadeOut(0.5)
  Wait(0.5)
  while true do
    if (not (LevelManager_HasZoneFinishedStreaming("MeanStreet_North.MSNUnderMill") == false)) then
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
  OswaldStopFollowAction()
  Wait(0)
  TeleportToEntity(GetPlayer2OrAI(), "MSN_UnderMillOswaldMarker")
  Wait(0)
  TeleportToEntity(GetPlayer(), "MSN_UnderMillMickeyMarker")
  Wait(0)
  OswaldStartFollowAction()
  Wait(1)
  UnrestrictCutSceneInput()
  if (GetGlobal("MSN_GremlinStructure_WindMill") == 1) then
    SetRotatorMaxSpeed("MSN_MCP", 100)
  end
  StartFadeIn(0.5)
  Wait(0.5)
  if (GetGlobal("MSN_Gus_DECHelp_Played") == 0) then
    if (GetGlobal("OST_Center_OpeningMoviePlayed") == 0) then
      FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_DECHelp", 1)
    end
  end
  return 
end
MSN_VaultEnterUnderMillHelp = function()
  if (GetGlobal("MSN_Gus_DECHelp_Played") == 0) then
    if (GetGlobal("OST_Center_OpeningMoviePlayed") == 0) then
      FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_DECHelp", 1)
    end
  end
  return 
end
MSN_OpenVaultFromBehind = function()
  if (GetGlobal("MSN_VaultDoorState") == 0) then
    AnimGBSequence("MSN_VaultDoor", "open")
    DestroyEntity("MSN_VaultSign")
    SetGlobal("MSN_VaultDoorState", 1)
    Disable("MSN_FloorVaultExitMarker")
    if (GetGlobal("MSN_Gus_NoLeaveUnderMillYet_Played") == 0) then
      if (GetGlobal("OST_Center_OpeningMoviePlayed") == 0) then
        FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_NoLeaveUnderMillYet")
      end
    end
  end
  FireThread(TeleportGremlinOut, "EM2_MSTN_GremlinHerman")
  OswaldStreamAbort()
  return 
end
MSN_Give25Metal = function()
  AddCurrency("ScrapMetal", 25)
  if (50 <= GetCurrency("ScrapMetal")) then
    if (GetGlobal("MSN_Gus_HaveEnoughMetal_Played") == 0) then
      FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_HaveEnoughMetal")
      SetGlobal("MSN_GusHintVar", 4)
      TimerEnable("EM2_GusHintTimer")
      TimerReset("EM2_GusHintTimer")
    end
  end
  return 
end
MSN_MarqueeLightsOn = function()
  AnimGBSequence("MSN_MarqueeLights", "on")
  return 
end
MSN_PedLocSpawn = 1
MSN_Ped01_EnterTracker = 0
MSN_Ped02_EnterTracker = 0
MSN_PedGenderSpawn = 1
MSN_PedSpawn_FirstTime = 0
MSN_SyncDestroyEntity = function(target)
  DestroyEntity(target)
  return 
end
MSN_PedEnterShop = function(target)
  local targetName = GetPropertyString(target, "EntityGroups", 0)
  if (targetName == "MSN_Floyd3") then
    MSN_Ped01_EnterTracker = 1
  elseif (targetName == "MSN_Annette2") then
    MSN_Ped02_EnterTracker = 1
  end
  return 
end
MSN_PedRespawnMaster = function()
  if (MSN_PedSpawn_FirstTime == 0) then
    MSN_PedSpawn_FirstTime = 1
    ForceSpawn("MSN_Spawner_PedIceCream", 1)
    ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
  end
  if (MSN_Ped01_EnterTracker == 1) then
    if (MSN_Ped01_EnterTracker == 1) then
      MSN_Ped01_EnterTracker = 0
    end
    if (MSN_Ped02_EnterTracker == 1) then
      MSN_Ped02_EnterTracker = 0
    end
    MSN_PedLocSpawn = math.random(1, 5)
    MSN_PedGenderSpawn = math.random(1, 2)
    if (MSN_PedLocSpawn == 1) then
      if (MSN_PedGenderSpawn == 1) then
        ForceSpawn("MSN_Spawner_PedCinema", 1)
      elseif (MSN_PedGenderSpawn == 2) then
        ForceSpawn("MSN_Spawner2_PedCinema", 1)
        if (MSN_PedLocSpawn == 2) then
          if (MSN_PedGenderSpawn == 1) then
            ForceSpawn("MSN_Spawner_PedIceCream", 1)
          elseif (MSN_PedGenderSpawn == 2) then
            ForceSpawn("MSN_Spawner2_PedIceCream", 1)
            if (MSN_PedLocSpawn == 3) then
              if (MSN_PedGenderSpawn == 1) then
                ForceSpawn("MSN_Spawner_PedArcade", 1)
              elseif (MSN_PedGenderSpawn == 2) then
                ForceSpawn("MSN_Spawner2_PedArcade", 1)
                if (MSN_PedLocSpawn == 4) then
                  if (GetGlobal("MSN_OswaldTower") == 0) then
                    if (MSN_PedGenderSpawn == 1) then
                      ForceSpawn("MSN_Spawner_PedCamera", 1)
                    elseif (MSN_PedGenderSpawn == 2) then
                      ForceSpawn("MSN_Spawner2_PedCamera", 1)
                      MSN_PedLocSpawn = 5
                      if (MSN_PedLocSpawn == 5) then
                        if (MSN_PedGenderSpawn == 1) then
                          ForceSpawn("MSN_Spawner_PedPinTrader", 1)
                        elseif (MSN_PedGenderSpawn == 2) then
                          ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
                        end
                      end
                    end
                  end
                  MSN_PedLocSpawn = 5
                elseif (MSN_PedLocSpawn == 5) then
                  if (MSN_PedGenderSpawn == 1) then
                    ForceSpawn("MSN_Spawner_PedPinTrader", 1)
                  elseif (MSN_PedGenderSpawn == 2) then
                    ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
                  end
                end
              end
            elseif (MSN_PedLocSpawn == 4) then
              if (GetGlobal("MSN_OswaldTower") == 0) then
                if (MSN_PedGenderSpawn == 1) then
                  ForceSpawn("MSN_Spawner_PedCamera", 1)
                elseif (MSN_PedGenderSpawn == 2) then
                  ForceSpawn("MSN_Spawner2_PedCamera", 1)
                  MSN_PedLocSpawn = 5
                  if (MSN_PedLocSpawn == 5) then
                    if (MSN_PedGenderSpawn == 1) then
                      ForceSpawn("MSN_Spawner_PedPinTrader", 1)
                    elseif (MSN_PedGenderSpawn == 2) then
                      ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
                    end
                  end
                end
              end
              MSN_PedLocSpawn = 5
            elseif (MSN_PedLocSpawn == 5) then
              if (MSN_PedGenderSpawn == 1) then
                ForceSpawn("MSN_Spawner_PedPinTrader", 1)
              elseif (MSN_PedGenderSpawn == 2) then
                ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
              end
            end
          end
        elseif (MSN_PedLocSpawn == 3) then
          if (MSN_PedGenderSpawn == 1) then
            ForceSpawn("MSN_Spawner_PedArcade", 1)
          elseif (MSN_PedGenderSpawn == 2) then
            ForceSpawn("MSN_Spawner2_PedArcade", 1)
            if (MSN_PedLocSpawn == 4) then
              if (GetGlobal("MSN_OswaldTower") == 0) then
                if (MSN_PedGenderSpawn == 1) then
                  ForceSpawn("MSN_Spawner_PedCamera", 1)
                elseif (MSN_PedGenderSpawn == 2) then
                  ForceSpawn("MSN_Spawner2_PedCamera", 1)
                  MSN_PedLocSpawn = 5
                  if (MSN_PedLocSpawn == 5) then
                    if (MSN_PedGenderSpawn == 1) then
                      ForceSpawn("MSN_Spawner_PedPinTrader", 1)
                    elseif (MSN_PedGenderSpawn == 2) then
                      ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
                    end
                  end
                end
              end
              MSN_PedLocSpawn = 5
            elseif (MSN_PedLocSpawn == 5) then
              if (MSN_PedGenderSpawn == 1) then
                ForceSpawn("MSN_Spawner_PedPinTrader", 1)
              elseif (MSN_PedGenderSpawn == 2) then
                ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
              end
            end
          end
        elseif (MSN_PedLocSpawn == 4) then
          if (GetGlobal("MSN_OswaldTower") == 0) then
            if (MSN_PedGenderSpawn == 1) then
              ForceSpawn("MSN_Spawner_PedCamera", 1)
            elseif (MSN_PedGenderSpawn == 2) then
              ForceSpawn("MSN_Spawner2_PedCamera", 1)
              MSN_PedLocSpawn = 5
              if (MSN_PedLocSpawn == 5) then
                if (MSN_PedGenderSpawn == 1) then
                  ForceSpawn("MSN_Spawner_PedPinTrader", 1)
                elseif (MSN_PedGenderSpawn == 2) then
                  ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
                end
              end
            end
          end
          MSN_PedLocSpawn = 5
        elseif (MSN_PedLocSpawn == 5) then
          if (MSN_PedGenderSpawn == 1) then
            ForceSpawn("MSN_Spawner_PedPinTrader", 1)
          elseif (MSN_PedGenderSpawn == 2) then
            ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
          end
        end
      end
    elseif (MSN_PedLocSpawn == 2) then
      if (MSN_PedGenderSpawn == 1) then
        ForceSpawn("MSN_Spawner_PedIceCream", 1)
      elseif (MSN_PedGenderSpawn == 2) then
        ForceSpawn("MSN_Spawner2_PedIceCream", 1)
        if (MSN_PedLocSpawn == 3) then
          if (MSN_PedGenderSpawn == 1) then
            ForceSpawn("MSN_Spawner_PedArcade", 1)
          elseif (MSN_PedGenderSpawn == 2) then
            ForceSpawn("MSN_Spawner2_PedArcade", 1)
            if (MSN_PedLocSpawn == 4) then
              if (GetGlobal("MSN_OswaldTower") == 0) then
                if (MSN_PedGenderSpawn == 1) then
                  ForceSpawn("MSN_Spawner_PedCamera", 1)
                elseif (MSN_PedGenderSpawn == 2) then
                  ForceSpawn("MSN_Spawner2_PedCamera", 1)
                  MSN_PedLocSpawn = 5
                  if (MSN_PedLocSpawn == 5) then
                    if (MSN_PedGenderSpawn == 1) then
                      ForceSpawn("MSN_Spawner_PedPinTrader", 1)
                    elseif (MSN_PedGenderSpawn == 2) then
                      ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
                    end
                  end
                end
              end
              MSN_PedLocSpawn = 5
            elseif (MSN_PedLocSpawn == 5) then
              if (MSN_PedGenderSpawn == 1) then
                ForceSpawn("MSN_Spawner_PedPinTrader", 1)
              elseif (MSN_PedGenderSpawn == 2) then
                ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
              end
            end
          end
        elseif (MSN_PedLocSpawn == 4) then
          if (GetGlobal("MSN_OswaldTower") == 0) then
            if (MSN_PedGenderSpawn == 1) then
              ForceSpawn("MSN_Spawner_PedCamera", 1)
            elseif (MSN_PedGenderSpawn == 2) then
              ForceSpawn("MSN_Spawner2_PedCamera", 1)
              MSN_PedLocSpawn = 5
              if (MSN_PedLocSpawn == 5) then
                if (MSN_PedGenderSpawn == 1) then
                  ForceSpawn("MSN_Spawner_PedPinTrader", 1)
                elseif (MSN_PedGenderSpawn == 2) then
                  ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
                end
              end
            end
          end
          MSN_PedLocSpawn = 5
        elseif (MSN_PedLocSpawn == 5) then
          if (MSN_PedGenderSpawn == 1) then
            ForceSpawn("MSN_Spawner_PedPinTrader", 1)
          elseif (MSN_PedGenderSpawn == 2) then
            ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
          end
        end
      end
    elseif (MSN_PedLocSpawn == 3) then
      if (MSN_PedGenderSpawn == 1) then
        ForceSpawn("MSN_Spawner_PedArcade", 1)
      elseif (MSN_PedGenderSpawn == 2) then
        ForceSpawn("MSN_Spawner2_PedArcade", 1)
        if (MSN_PedLocSpawn == 4) then
          if (GetGlobal("MSN_OswaldTower") == 0) then
            if (MSN_PedGenderSpawn == 1) then
              ForceSpawn("MSN_Spawner_PedCamera", 1)
            elseif (MSN_PedGenderSpawn == 2) then
              ForceSpawn("MSN_Spawner2_PedCamera", 1)
              MSN_PedLocSpawn = 5
              if (MSN_PedLocSpawn == 5) then
                if (MSN_PedGenderSpawn == 1) then
                  ForceSpawn("MSN_Spawner_PedPinTrader", 1)
                elseif (MSN_PedGenderSpawn == 2) then
                  ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
                end
              end
            end
          end
          MSN_PedLocSpawn = 5
        elseif (MSN_PedLocSpawn == 5) then
          if (MSN_PedGenderSpawn == 1) then
            ForceSpawn("MSN_Spawner_PedPinTrader", 1)
          elseif (MSN_PedGenderSpawn == 2) then
            ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
          end
        end
      end
    elseif (MSN_PedLocSpawn == 4) then
      if (GetGlobal("MSN_OswaldTower") == 0) then
        if (MSN_PedGenderSpawn == 1) then
          ForceSpawn("MSN_Spawner_PedCamera", 1)
        elseif (MSN_PedGenderSpawn == 2) then
          ForceSpawn("MSN_Spawner2_PedCamera", 1)
          MSN_PedLocSpawn = 5
          if (MSN_PedLocSpawn == 5) then
            if (MSN_PedGenderSpawn == 1) then
              ForceSpawn("MSN_Spawner_PedPinTrader", 1)
            elseif (MSN_PedGenderSpawn == 2) then
              ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
            end
          end
        end
      end
      MSN_PedLocSpawn = 5
    elseif (MSN_PedLocSpawn == 5) then
      if (MSN_PedGenderSpawn == 1) then
        ForceSpawn("MSN_Spawner_PedPinTrader", 1)
      elseif (MSN_PedGenderSpawn == 2) then
        ForceSpawn("MSN_Spawner2_PedPinTrader", 1)
      end
    end
  end
  return 
end
MSN_GotTubePart = function()
  Enable("MSN_TubeQuadrant")
  SetGlobal("MSN_VacTubePart", 1)
  if (GetGlobal("MSN_Jamface_VacTubeIntro_Played") == 0) then
    ForceSequence("EM2_MSTN_GusConvoTrigger", "Gus_FoundObject")
  else
    ForceSequence("EM2_MSTN_GusConvoTrigger", "Genric Line 30")
  end
  MSN_SaveCheckPoint02()
  return 
end
MSN_JamfaceTalksTower = function()
  if (GetGlobal("MSN_MarkusPostQuake02_Played") == 0) then
    SetGlobal("MSN_GremlinQuadrantTracker", 100)
    Unhide("EM2_MSTN_GremlinMarkus")
    AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Mood_Type, MOOD_Negative)
    TeleportToEntity("EM2_MSTN_GremlinMarkus", "MSN_JamfaceTowerMarker")
  end
  return 
end
MSN_OswaldTowerBlowUp = function(target, event)
  if (GetGlobal("MSN_OswaldTower") == 1) then
    if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
      SetGlobal("MSN_OswaldTower", 2)
      AnimGBSequence("EM2_MSTN_FallenTower", "explode")
      Prefab_Activate_Doors("MSN_CamerEnterTrigger", "open")
      FireSequence("EM2_MSTN_GusConvoTrigger", "Generic Line 37", 1)
      Prefab_ScrapMetalSpawner_Launch("MSN_FallenTowerExplodeSpawner")
      AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Mood_Type, MOOD_Positive)
      MSN_SaveCheckPoint02()
      Wait(0)
      MSN_ParkJamfaceSomewhere()
    end
  end
  return 
end
MSN_SecretPathBroke = function(target, event)
  if (GetGlobal("MSN_SecretPathTracker") == 0) then
    if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
      SetGlobal("MSN_SecretPathTracker", 2)
      if (GetGlobal("MeanStreet_HasAnyBldgDestroyed") == 0) then
        SetGlobal("MeanStreet_HasAnyBldgDestroyed", 1)
        SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") + 50))
      end
      Disable("MSN_SecretPathOswaldAction")
      SetPropertyFloat("MSN_SecretFirstKnot", "BranchPathChance", 1)
      SetPropertyFloat("MSN_SecretFirstKnot", "HoldTime", 0)
      Wait(0)
      SetSplineFollowerInitialSpeed("MSN_SecretPlatform01", 40)
      FireThread(Prefab_ScrapMetalSpawner_Launch, "MSN_SecretPlatformMetal")
      ForceSpawn("MSN_SecretFXSpawner_FishheadFX", 1)
      ForceSpawn("MSN_SecretFXSpawner_BigDrum", 1)
      SetRotatorMaxSpeed("MSN_SecretPlatform01", 50)
      SetSplineFollowerInitialSpeed("MSN_SecretPlatform01", 40)
      Wait(0.10000000149011612)
      DestroyEntity("MSN_SecretSign")
      DestroyEntity("MSN_SecretPlatform02")
      MSN_SaveCheckPoint02()
      Wait(0.6000000238418579)
      SetRotatorMaxSpeed("MSN_SecretPlatform01", 350)
      Wait(1.5)
      FireSequence("EM2_MSTN_GremlinMarkus", "MSN_Jamface_SecretPathBroke", 1)
      ForEachEntityInGroup(DestroyEntity, "MSN_SecretFX_FishheadFX")
      StopEmitters("MSN_SecretFX_BigDrum")
      Wait(2)
      MSN_ParkJamfaceSomewhere()
    end
  end
  return 
end
MSN_SecretPathFixed = function()
  SetGlobal("MSN_SecretPathTracker", 1)
  MSN_SaveCheckPoint02()
  SetPropertyFloat("MSN_SecretEntranceTrigger", "UsableRadius", 2)
  DestroyEntity("MSN_SecretSign")
  SpendCurrency("ScrapMetal", 50)
  Disable("MSN_SecretPathStartTrigger")
  SetRotatorMaxSpeed("MSN_SecretPlatform01", 60)
  StartRotateToPosition("MSN_SecretPlatform01", 90)
  SetPropertyFloat("MSN_SecretFirstKnot", "HoldTime", 5)
  SetSplineFollowerInitialSpeed("MSN_SecretPlatform01", 1)
  SetSplineFollowerInitialSpeed("MSN_SecretPlatform02", 2)
  Prefab_OswaldElectricSwitch_ChangeState("MSN_SecretSwitch", "Activate")
  Enable("MSN_HiddenForSecret")
  return 
end
MSN_BreakableAddMetal = function()
  AddCurrency("ScrapMetal", 2)
  return 
end
MSN_StopFireworks = function()
  OswaldStreamAbort()
  Wait(0)
  OswaldStartFollowAction()
  return 
end
MSN_GiveCamera = function()
  UnlockAbility(GetPlayer(), "Camera")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Camera")
  ForEachEntityInGroup(Enable, "MSN_HiddenHeroes")
  ForEachEntityInGroup(EnableComponent, "MSN_HiddenHeroes", "Camera Ability Target Component")
  Wait(0)
  if (GetGlobal("RBF_AngelOrDevil") == 2) then
    if (GetGlobal("MSN_OswaldTower") == 0) then
      DisableComponent("MSN_HiddenHeroes_OswaldTower", "Camera Ability Target Component")
    end
  end
  if (GetGlobal("RBF_AngelOrDevil") == 2) then
    if (GetGlobal("MSN_OswaldTower") == 1) then
      DisableComponent("MSN_HiddenHeroes_OswaldTower", "Camera Ability Target Component")
    end
  end
  if (GetGlobal("MSN_OswaldTower") == 2) then
    DisableComponent("MSN_HiddenHeroes_OswaldTower", "Camera Ability Target Component")
  end
  SetGlobal("MSS_HiddenHeroesQuest", 1)
  SetGlobal("EM2_HiddenOswald060", 1)
  SetGlobal("EM2_HiddenMickey013", 1)
  SetGlobal("EM2_HiddenOswald023", 1)
  SetGlobal("EM2_HiddenOswald059", 1)
  SetGlobal("EM2_HiddenMickey047", 1)
  SetGlobal("EM2_HiddenMickey049", 1)
  return 
end
MSN_OpenUnderMillCloset = function()
  SetGlobal("MSN_UndermillPipeDoor", 1)
  SetSplineFollowerInitialSpeed("MSN_UnderMill_ClosetDoor02", 1)
  SetSplineFollowerInitialSpeed("MSN_UnderMill_ClosetDoor01", 1)
  Wait(0)
  OswaldStreamAbort()
  DestroyEntity("MSN_UnderMillCloset1Marker")
  return 
end
MSN_RemoveTubePart = function()
  UseQuestItems("Tube_Part")
  return 
end
MSN_JamfaceLocSpawn = 2
MSN_Jamface_QuadFourLeave = 0
MSN_Jamface_QuadFiveLeave = 0
MSN_ParkJamfaceCheck = function()
  MSN_Jamface_QuadFourLeave = 0
  return 
end
MSN_ParkJamfaceCheck_Mill = function()
  MSN_Jamface_QuadFiveLeave = 0
  return 
end
MSN_JamfaceTimer = function()
  TimerReset("EM2_Shoot_LogicTimer")
  TimerEnable("EM2_Shoot_LogicTimer")
  return 
end
MSN_JamfaceTimer_Mill = function()
  TimerReset("EM2_Mill_LogicTimer")
  TimerEnable("EM2_Mill_LogicTimer")
  return 
end
MSN_ParkJamfaceSomewhere_Quad4 = function()
  if (MSN_Jamface_QuadFourLeave == 0) then
    TimerReset("EM2_Shoot_LogicTimer")
    TimerDisable("EM2_Shoot_LogicTimer")
    MSN_ParkJamfaceSomewhere()
  end
  return 
end
MSN_ParkJamfaceSomewhere_Quad5 = function()
  if (MSN_Jamface_QuadFiveLeave == 0) then
    MSN_ShouldJamfaceLeaveMill = 0
    TimerReset("EM2_Mill_LogicTimer")
    TimerDisable("EM2_Mill_LogicTimer")
    MSN_ParkJamfaceSomewhere()
  end
  return 
end
MSN_GenericJamfaceTimerReset = function()
  TimerReset("EM2_Shoot_LogicTimer")
  TimerDisable("EM2_Shoot_LogicTimer")
  return 
end
MSN_MillJamfaceTimerReset = function()
  TimerReset("EM2_Mill_LogicTimer")
  TimerDisable("EM2_Mill_LogicTimer")
  return 
end
MSN_ParkJamfaceSomewhere = function()
  if (MSN_Jamface_QuadFourLeave == 0) then
    SetGlobal("MSN_Jamface_StareProjector", 0)
    SetPropertyFloat("EM2_MSTN_GremlinMarkus", "UsableRadius", 3)
    AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Mood_Type, MOOD_Positive)
    MSN_JamfaceLocSpawn = math.random(1, 6)
    if (MSN_JamfaceLocSpawn == 1) then
      SetGlobal("MSN_GremlinQuadrantTracker", 10)
      FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_JamfacePark01")
    elseif (MSN_JamfaceLocSpawn == 2) then
      SetGlobal("MSN_GremlinQuadrantTracker", 10)
      FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_JamfacePark02")
    elseif (MSN_JamfaceLocSpawn == 3) then
      SetGlobal("MSN_GremlinQuadrantTracker", 10)
      FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_JamfacePark03")
    elseif (MSN_JamfaceLocSpawn == 4) then
      if (GetGlobal("MSN_GremlinStructure_WindMill") == 1) then
        SetGlobal("MSN_GremlinQuadrantTracker", 10)
      else
        SetGlobal("MSN_GremlinQuadrantTracker", 20)
      end
      MSN_ShouldJamfaceLeaveMill = 1
      FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_JamfacePark04")
    elseif (MSN_JamfaceLocSpawn == 5) then
      SetGlobal("MSN_GremlinQuadrantTracker", 10)
      FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_JamfacePark05")
    elseif (MSN_JamfaceLocSpawn == 6) then
      if (2 <= GetGlobal("EM2_EpisodeCheck")) then
        if (GetGlobal("MSN_Jamface_StareProjector") == 0) then
          SetGlobal("MSN_Jamface_StareProjector", 1)
        end
      end
      SetGlobal("MSN_GremlinQuadrantTracker", 10)
      FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_JamfacePark06")
    end
  end
  return 
end
MSN_Jamface_ToQuadrant01 = function()
  MSN_GenericJamfaceTimerReset()
  MSN_MillJamfaceTimerReset()
  if (GetGlobal("MSN_GremlinStructure_Tower") == 0) then
    if (GetGlobal("MSN_GremlinQuadrantTracker") ~= 1) then
      SetGlobal("MSN_GremlinQuadrantTracker", 1)
      TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSN_Hut03IGCMarkusMarker")
    end
  end
  return 
end
MSN_Jamface_ToQuadrant02 = function()
  MSN_GenericJamfaceTimerReset()
  MSN_MillJamfaceTimerReset()
  if (GetGlobal("MSN_GremlinStructure_FishHead") == 0) then
    if (GetGlobal("MSN_GremlinQuadrantTracker") ~= 2) then
      SetGlobal("MSN_GremlinQuadrantTracker", 2)
      TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSN_MarkusFishheadMarker")
    end
  end
  return 
end
MSN_Jamface_ToQuadrant03 = function()
  MSN_GenericJamfaceTimerReset()
  MSN_MillJamfaceTimerReset()
  if (GetGlobal("MSN_TunnelPassVar") == 1) then
    if (GetGlobal("MSN_Teleporter") == 0) then
      if (GetGlobal("MSN_GremlinQuadrantTracker") ~= 3) then
        SetGlobal("MSN_GremlinQuadrantTracker", 3)
        TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSN_JamfaceTubeMarker")
      end
    end
  end
  return 
end
MSN_Jamface_ToQuadrant04 = function()
  MSN_GenericJamfaceTimerReset()
  MSN_MillJamfaceTimerReset()
  MSN_Jamface_QuadFourLeave = 1
  MSN_ShouldJamfaceLeaveMill = 0
  MSN_Jamface_QuadFiveLeave = 0
  if (GetGlobal("MSN_SecretPathTracker") == 0) then
    if (GetGlobal("MSN_GremlinQuadrantTracker") ~= 4) then
      SetGlobal("MSN_GremlinQuadrantTracker", 4)
      TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSN_JamfaceSecretPathMarker")
    end
  end
  return 
end
MSN_ShouldJamfaceLeaveMill = 0
MSN_Jamface_ToQuadrant05 = function()
  MSN_GenericJamfaceTimerReset()
  MSN_MillJamfaceTimerReset()
  MSN_Jamface_QuadFiveLeave = 1
  MSN_Jamface_QuadFourLeave = 0
  if (GetGlobal("MSN_GremlinStructure_WindMill") == 1) then
    SetGlobal("MSN_GremlinQuadrantTracker", 10)
  else
    SetGlobal("MSN_GremlinQuadrantTracker", 20)
  end
  if (MSN_ShouldJamfaceLeaveMill == 0) then
    MSN_ShouldJamfaceLeaveMill = 1
    TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSN_JamfacePark04")
  end
  return 
end
MSN_SetDoorBrokeFlag = function(target, event)
  if (GetGlobal("MSN_VaultDoorState") == 0) then
    if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
      SetGlobal("MSN_VaultDoorState", 2)
      SetGlobal("MSN_VaultDoorStateSecondary", 1)
      Quest_SetCriticalPath("Critical_MSN", "Critical_MSN_3")
      ForceInterruptSequence("EM2_MSTN_GremlinHerman", "MSN_Herman_Greets")
      EnableMotion("MSN_VaultSign")
      ApplyImpulse("MSN_VaultSign", 150, 100, 5)
      Wait(0)
      ApplyAngularImpulse("MSN_VaultSign", 150, 100, 5)
      FireThread(TeleportGremlinOut, "EM2_MSTN_GremlinHerman")
      Disable("MSN_HiddenOswaldVault")
      MSN_SaveCheckPoint02()
      DestroyEntity("MSN_FloorVaultExitMarker")
      AnimGBSequence("MSN_VaultDoor", "break")
      AudioPostEventOn("meanstreetnorth_audio.Play_sfx_Windmill_Gears_LP", "Play_sfx_Windmill_Gears_LP")
      MSN_StopFireworks()
      Wait(1.7000000476837158)
      DestroyEntity("MSN_VaultDoor")
    end
  end
  return 
end
MSN_ForceProjectorsOn = function()
  Prefab_Projector_ChangeState("VenturelandProjector", "Activate")
  Prefab_Projector_ChangeState("BogEasyProjector", "Activate")
  Prefab_Projector_ChangeState("MSN_OsTownProjector", "Activate")
  return 
end
MSN_SetVisitTo2 = function()
  SetGlobal("MSN_GusHintVar", 0)
  if (GetGlobal("MSN_VisitNumber") == 1) then
    SetGlobal("MSN_VisitNumber", 2)
    GiveCollectibleNoPopup("Challenge_WalkingMeanStreets_Tracker")
  end
  return 
end
MSN_OswaldShockExitVault = function()
  OswaldStreamAction("MSN_VaultExitMarker")
  return 
end
MSN_OswaldShockUnderMillCloset = function()
  OswaldStreamAction("MSN_UnderMillClosetMarker")
  return 
end
MSN_BossBattle_Enter = function(target, num)
  ForceSequence("EM2_MSTN_GusConvoTrigger", ("MSN_Gus_BossBattle" .. num))
  return 
end
MSN_Arcade_ActivateDragon = function()
  Wait(0.10000000149011612)
  ForEachEntityInGroup(Unhide, "MSNArcade_Ticket_Dragon")
  ForEachEntityInGroup(SetSplineFollowerInitialSpeed, "MSNArcade_TicketSplineFollower_Dragon", 2)
  MSN_ArcadeTicketReveal_Tron()
  return 
end
Arcade_ActivateArena = function()
  Wait(0.10000000149011612)
  ForEachEntityInGroup(Unhide, "MSNArcade_Ticket_Prescott")
  ForEachEntityInGroup(SetSplineFollowerInitialSpeed, "MSNArcade_TicketSplineFollower_Prescott", 2)
  MSN_ArcadeTicketReveal_Tron()
  return 
end
MSN_Arcade_ActivateMDNR = function()
  StartFadeOut(1)
  Wait(1)
  Unhide("MSN_ArcadeMachine_DocRide")
  StartFadeIn(1)
  Wait(0.10000000149011612)
  ForEachEntityInGroup(Unhide, "MSNArcade_Ticket_MDNR")
  ForEachEntityInGroup(SetSplineFollowerInitialSpeed, "MSNArcade_TicketSplineFollower_MDNR", 2)
  MSN_ArcadeTicketReveal_Tron()
  return 
end
MSN_ArcadeTicketReveal_Tron = function()
  if (GetGlobal("MSN_ArcadeMachine01_On") == 1) then
    if (GetGlobal("MSN_ArcadeMachine02_On") == 1) then
      if (GetGlobal("MSN_ArcadeMachine03_On") == 1) then
        Wait(0.10000000149011612)
        Unhide("MSNArcade_Ticket_Tron")
        SetSplineFollowerInitialSpeed("MSNArcade_TicketSplineFollower_Tron", 2)
      end
    end
  end
  return 
end
MSN_GiveGridPin = function()
  GiveCollectible("Game_Grid")
  return 
end
MSN_AskTVPrompt = function()
  ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_TVPrompt")
  return 
end
MSN_GremlinRaisePrices = function()
  SetGlobal("MSN_GremlinRobberyDiscount", 5)
  SetPropertyFloat("EM2_MSTN_GremlinMarkus", "UsableRadius", 3)
  Wait(0)
  SetGlobal("MSN_VaultDoorState", 4)
  SetGlobal("MSN_VaultDoorStateSecondary", 2)
  MSN_SaveCheckPoint02()
  if (GetGlobal("MSN_GremlinYellPos") == 0) then
    FireUser3("VaultYellCamProjectors")
  elseif (GetGlobal("MSN_GremlinYellPos") == 1) then
    FireUser3("MSN_VaultYellCamUtil")
  elseif (GetGlobal("MSN_GremlinYellPos") == 2) then
    FireUser3("MSN_VaultRobberyVault")
  elseif (GetGlobal("MSN_GremlinYellPos") == 3) then
    FireUser3("MSN_BalloonRobberyCamera")
  elseif (GetGlobal("MSN_GremlinYellPos") == 4) then
    FireUser3("MSN_JamfaceCinemaInterceptCam")
  elseif (GetGlobal("MSN_GremlinYellPos") == 5) then
    FireUser3("MSN_ReloadInterceptCam")
  end
  Disable("MSN_CinemaInterceptTrigger")
  return 
end
MSN_BalloonCaptainShowUp = function()
  if (MSN_BalloonEnabled == 0) then
    SetGlobal("MSN_HermanQuadrantTracker", 1)
    TeleportGremlinToEntity("EM2_MSTN_GremlinHerman", "MSN_BalloonCaptainMarker")
  end
  return 
end
MSN_BalloonCaptainLeave = function()
  if (GetGlobal("MSN_VaultDoorState") == 0) then
    SetGlobal("MSN_HermanQuadrantTracker", 0)
    TeleportGremlinToEntity("EM2_MSTN_GremlinHerman", "MSN_HermanVaultSpot")
  else
    TeleportGremlinOut("EM2_MSTN_GremlinHerman")
  end
  return 
end
MSN_TakeBalloonPrompt = function()
  ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_BalloonPrompt")
  return 
end
MSN_BalloonEnabled = 0
MSN_EnableBalloonTrigger = function()
  MSN_BalloonEnabled = 1
  Enable("MSN_BalloonTrigger")
  return 
end
MSN_HardLoad_South = function()
  DecrementPaintAbilitiesDisabled(GetPlayer())
  SetGlobal("MSN_GusHintVar", 0)
  SetGlobal("MSN_HermanQuadrantTracker", 0)
  Wait(0)
  LoadLevel(GetPlayer(), "MeanStreet_South.Visit1")
  return 
end
MSN_HardLoad_North = function()
  SetGlobal("MSN_GusHintVar", 0)
  DecrementPaintAbilitiesDisabled(GetPlayer())
  Wait(0)
  if (GetGlobal("MSN_VisitNumber") == 1) then
    LoadLevel(GetPlayer(), "MeanStreet_North.Visit_1")
  elseif (2 <= GetGlobal("MSN_VisitNumber")) then
    LoadLevel(GetPlayer(), "MeanStreet_North.Visit_2")
  end
  return 
end
MSN_ChargeBalloonPayment = function()
  SpendCurrency("ETicket", 25)
  return 
end
MSN_VaultDoorFinishedCheck = function()
  if (0 < GetGlobal("MSN_VaultDoorState")) then
    Prefab_OswaldElectricSwitch_ChangeState("MSN_VaultExitMarker", "Deactivate")
    DestroyEntity("MSN_FloorVaultExitMarker")
  end
  return 
end
MSN_OutOfCameraTutorialRange = function()
  Disable("MSN_CameraTutorialTrigger")
  InterruptCurrentSequence()
  Wait(0.10000000149011612)
  Disable("MSN_CameraModeMarker")
  ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_CameraTutorial06")
  return 
end
MSN_EnableCameraTutorialTrigger = function()
  Enable("MSN_CameraTutorialTrigger")
  return 
end
MSN_CameraTutorial01 = function(state)
  if (state == nil) then
    Enable("MSN_CameraModeMarker")
    wait(0.20000000298023224)
    ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_CameraTutorial")
  elseif (state == "finished") then
    EnableMovementInput(GetPlayer())
    EnableMovementInput(GetPlayer2OrAI())
    MSN_SaveCheckPoint03()
  end
  return 
end
MSN_ExitCameraShop = function()
  StreamInterior(nil, "MeanStreet_North.MSNUnderMill")
  RemoveAllMusicStateOverride()
  Prefab_ExitInterior_FadeIn()
  if (GetGlobal("EM2_Camera") == 1) then
    if (GetGlobal("MSN_CameraTutorial") == 0) then
      Print("+_+_+_+_+_+_+_+_+ MSN_ExitCameraShop() Enabling prefab exit building camera First Person Camera")
      local Cam_Override1 = GetRelativePrefabEntity("MSTN_Camera", ".ExitBuildingOverride1")
      local Cam_Override2 = GetRelativePrefabEntity("MSTN_Camera", ".ExitBuildingOverride2")
      SetPropertyBool(Cam_Override1, "DisableFirstPerson", false)
      SetPropertyBool(Cam_Override2, "DisableFirstPerson", false)
      wait(0)
      local _player = GetPlayer()
      ClearCameraAttributesForPlayer(Cam_Override1, _player)
      ClearCameraAttributesForPlayer(Cam_Override2, GetPlayer2OrAI())
      wait(0)
      SetCameraAttributesForPlayer(Cam_Override1, _player)
      SetCameraAttributesForPlayer(Cam_Override2, GetPlayer2OrAI())
      wait(0)
      MSN_CameraTutorial01()
      SetPropertyBool(Cam_Override1, "DisableFirstPerson", true)
      SetPropertyBool(Cam_Override2, "DisableFirstPerson", true)
    end
  end
  while true do
    if (not (LevelManager_HasZoneFinishedStreaming("MeanStreet_North.MSNUnderMill") == false)) then
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
  Wait(0)
  ForEachEntityInGroup(Enable, "MSN_CullUndermill")
  Enable("MSN_CullProjUndermill")
  if (GetGlobal("MSN_GremlinStructure_WindMill") == 1) then
    SetRotatorMaxSpeed("MSN_MCP", 100)
  end
  if (GetGlobal("MSN_VisitNumber") == 1) then
    ForEachEntityInGroup(Hide, "MSN_Fishhead_OswaldSwitch")
    Disable("MSN_PortableGeneratorAction")
  end
  if (GetGlobal("MSN_UndermillPipeDoor") == 1) then
    Prefab_OswaldElectricSwitch_ChangeState("MSN_UnderMillClosetMarker", "Deactivate")
    ForEachEntityInGroup(DestroyEntity, "MSN_UndermillPipeGroup")
  elseif (GetGlobal("MSN_UndermillPipeDoor") == 2) then
    Prefab_OswaldElectricSwitch_ChangeState("MSN_UnderMillClosetMarker", "Deactivate")
    ForEachEntityInGroup(DestroyEntity, "MSN_UndermillPipeGroup")
    DestroyEntity("MSN_UndermillPipeTreasure")
  end
  return 
end
MSN_CameraTutorialCompleted = function()
  SetGlobal("MSN_CameraTutorial", 1)
  Wait(0)
  SaveCheckpoint(GetPlayer(), "MSN_LoadCheckPoint", "EM2_NorthStartMarker")
  return 
end
MSN_CameraTutorialCutShort = function()
  SetGlobal("MSN_CameraTutorial", 1)
  return 
end
MSN_UndermillRockWall = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    AnimGBSequence("MSN_UnderMillRock", "open")
    Wait(2)
    DestroyEntity("MSN_UnderMillRock")
  end
  return 
end
MSN_FishEyeCheck = function()
  if (GetGlobal("MSN_GremlinStructure_FishHead") == 1) then
    AnimGBSequence("MSN_Fishhead", "fixed", true)
    Unhide("MSN_FishBulbFX")
  end
  return 
end
MSN_FaceCheck = function()
  if (GetGlobal("MSN_GremlinStructure_FishHead") == 1) then
    AnimGBSequence("MSN_Fishhead", "open")
    AudioPostEventOn("meanstreetnorth_art.MST_north_01a_FishHeadBuild_01a 02", "Play_sfx_msn_fish_head_start")
  end
  return 
end
MSN_PostTankSpray = function(target, _event)
  if (not (not StimulusEvent_HasStimulusType(_event, ST_PAINT))) then
    local stim = "Paint"
    if StimulusEvent_HasStimulusType(_event, ST_THINNER) then
      stim = "Thinner"
    end
    local TankSpray = function()
      StartEmitters((("MSN_Tank" .. stim) .. "Spray"))
      Wait(2)
      StopEmitters((("MSN_Tank" .. stim) .. "Spray"))
      return 
    end
    if (GetGlobal("MSN_GremlinStructure_Tower") == 2) then
      if (GetGlobal("MSN_SprayVar") == 1) then
        FireThread(TankSpray)
      end
    end
    if (GetPropertyInt("MSN_Nozzle", "Active Sequence ID") == 0) then
      AnimGBSequence("MSN_Nozzle", "react")
      Wait(1.100000023841858)
      AnimGBSequence("MSN_Nozzle", "rest")
    end
  end
  return 
end
MSN_GusHintMaster = function()
  if (GetGlobal("MSN_GusHintVar") == 1) then
    ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_CinemaFixed")
  elseif (GetGlobal("MSN_GusHintVar") == 2) then
    ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_DECHelp")
  elseif (GetGlobal("MSN_GusHintVar") == 3) then
    ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_GotoPennyArcade")
  elseif (GetGlobal("MSN_GusHintVar") == 4) then
    ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_HaveEnoughMetal")
  elseif (GetGlobal("MSN_GusHintVar") == 5) then
    ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_LetsGoDEC")
  elseif (GetGlobal("MSN_GusHintVar") == 6) then
    ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_AirConditionerFixed")
  elseif (GetGlobal("MSN_GusHintVar") == 7) then
    SetGlobal("MSN_GusHintVar", 8)
    ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_ProjectorsOnRepeat")
  end
  return 
end
MSN_StartUndermillHint = function()
  SetGlobal("MSN_GusHintVar", 2)
  TimerEnable("EM2_GusHintTimer")
  TimerReset("EM2_GusHintTimer")
  return 
end
MSN_StopGusHintTimer = function()
  SetGlobal("MSN_GusHintVar", 0)
  TimerReset("EM2_GusHintTimer")
  TimerDisable("EM2_GusHintTimer")
  return 
end
MSN_StopGusHintTimer_Special = function()
  if (GetGlobal("MSN_Jamface_NearWindmill_Intro_Played") == 0) then
    SetGlobal("MSN_GusHintVar", 0)
    TimerReset("EM2_GusHintTimer")
    TimerDisable("EM2_GusHintTimer")
    AnimEvent("EM2_MSTN_GremlinMarkus", EVENT_Force_Idle)
  end
  return 
end
MSN_HideJamface = function()
  if (GetGlobal("MSN_GremlinStructure_WindMill") == 1) then
    if (GetGlobal("MSN_VisitNumber") == 1) then
      TeleportGremlinOut("EM2_MSTN_GremlinMarkus")
    end
  end
  return 
end
MSN_HideMarkus = function()
  DisableMotion("EM2_MSTN_GremlinMarkus")
  DriveMotionWithPhysics("EM2_MSTN_GremlinMarkus")
  local wrench = GetChildEntityByName("EM2_MSTN_GremlinMarkus", "GremlinWrench")
  TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSN_MarkusWindmillMarker02")
  Unhide(wrench)
  AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Cutscene, 1)
  AnimEvent("EM2_MSTN_GremlinMarkus", EVENT_Start_Cutscene)
  return 
end
MSN_JamfacePriceMasterBranch = function()
  local payoff = GetGlobal("MeanStreet_PriceTracker")
  SpendCurrency("ScrapMetal", payoff)
  Wait(0)
  if (GetGlobal("MSN_GremlinQuadrantTracker") == 1) then
    SetGlobal("MSN_GremlinStructure_Tower", 0)
    Wait(0)
    MSN_SaveCheckPoint02()
  elseif (GetGlobal("MSN_GremlinQuadrantTracker") == 2) then
    SetGlobal("MSN_GremlinStructure_FishHead", 1)
    Wait(0)
    MSN_SaveCheckPoint02()
  elseif (GetGlobal("MSN_GremlinQuadrantTracker") == 4) then
    SetGlobal("MSN_GremlinQuadrantTracker", 10)
    SetGlobal("MSN_SecretPathTracker", 1)
    Disable("MSN_SecretPathStartTrigger")
    Wait(0)
    MSN_SaveCheckPoint02()
  elseif (GetGlobal("MSN_GremlinQuadrantTracker") == 20) then
    SetGlobal("MSN_GremlinStructure_WindMill", 1)
    SetGlobal("MSN_GremlinQuadrantTracker", 10)
    Wait(0)
    MSN_SaveCheckPoint02()
  elseif (GetGlobal("MSN_GremlinQuadrantTracker") == 8) then
    SetGlobal("MSN_OswaldTower", 3)
    Wait(0)
    MSN_SaveCheckPoint02()
  end
  ForceSequence("EM2_MSTN_GremlinMarkus", "MSN_Jamface_RepairFishAgain", 1)
  return 
end
MeanStreet_PriceMaster_North = function()
  Print("############## MeanStreet_PriceMaster_North 1")
  if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_1", Quest_TurnIn) == true) then
    Print("############## MeanStreet_PriceMaster_North 2")
    if (GetGlobal("GremlinRescuedRewardTier1") == 0) then
      SetGlobal("GremlinRescuedRewardTier1", 1)
    end
  end
  if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_2", Quest_TurnIn) == true) then
    Print("############## MeanStreet_PriceMaster_North 3")
    if (GetGlobal("GremlinRescuedRewardTier2") == 0) then
      SetGlobal("GremlinRescuedRewardTier2", 1)
    end
  end
  if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_3", Quest_TurnIn) == true) then
    Print("############## MeanStreet_PriceMaster_North 4")
    if (GetGlobal("GremlinRescuedRewardTier3") == 0) then
      SetGlobal("GremlinRescuedRewardTier3", 1)
    end
  end
  if (GetGlobal("MeanStreet_HasAnyBldgDestroyed") == 0) then
    Print("############## MeanStreet_PriceMaster_North 5")
    if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_1", Quest_TurnIn) == true) then
      if (GetGlobal("GremlinRescuedRewardTier1") == 1) then
        SetGlobal("GremlinRescuedRewardTier1", 2)
        SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") - 5))
      end
    end
    if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_2", Quest_TurnIn) == true) then
      if (GetGlobal("GremlinRescuedRewardTier2") == 1) then
        SetGlobal("GremlinRescuedRewardTier2", 2)
        SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") - 5))
      end
    end
    if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_3", Quest_TurnIn) == true) then
      if (GetGlobal("GremlinRescuedRewardTier3") == 1) then
        SetGlobal("GremlinRescuedRewardTier3", 2)
        SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") - 5))
      end
    end
  elseif (GetGlobal("MeanStreet_HasAnyBldgDestroyed") == 1) then
    Print("############## MeanStreet_PriceMaster_North 6")
    if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_1", Quest_TurnIn) == true) then
      if (GetGlobal("GremlinRescuedRewardTier1") == 1) then
        SetGlobal("GremlinRescuedRewardTier1", 2)
        SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") - 10))
      end
    end
    if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_2", Quest_TurnIn) == true) then
      if (GetGlobal("GremlinRescuedRewardTier2") == 1) then
        SetGlobal("GremlinRescuedRewardTier2", 2)
        SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") - 10))
      end
    end
    if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_3", Quest_TurnIn) == true) then
      if (GetGlobal("GremlinRescuedRewardTier3") == 1) then
        SetGlobal("GremlinRescuedRewardTier3", 2)
        SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") - 10))
      end
    end
  end
  return 
end
MSN_BringBackParts = function(target, location)
  Print("#### MSN_BringBackParts")
  MSN_BringBackParts_Accepted(target, location)
  return 
end
MSN_BringBackParts_Accepted = function(target, location)
  local targetName = GetPropertyString(target, "EntityGroups", 0)
  Print("####### MSN_BringBackParts_Accepted")
  SetPropertyFloat(target, "UsableRadius", 0)
  ForceSequence("EM2_MSTN_GremlinMarkus", "MSN_MarkusVaultRecovery", 1)
  Wait(3)
  SetFacing("EM2_MSTN_GremlinMarkus", GetFacing(target))
  AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Cutscene, 1)
  AnimEvent("EM2_MSTN_GremlinMarkus", EVENT_Start_Cutscene)
  Wait(2)
  if (targetName == "MSN_MissingParts01") then
    ForceSpawn("MSN_Bin1FXSpawner", 1)
    SetGlobal("MSN_GremlinPartsBin1", 1)
  elseif (targetName == "MSN_MissingParts02") then
    ForceSpawn("MSN_Bin2FXSpawner", 1)
    SetGlobal("MSN_GremlinPartsBin2", 1)
  elseif (targetName == "MSN_MissingParts03") then
    ForceSpawn("MSN_Bin3FXSpawner", 1)
    SetGlobal("MSN_GremlinPartsBin3", 1)
  elseif (targetName == "MSN_MissingParts04") then
    ForceSpawn("MSN_Bin4FXSpawner", 1)
    SetGlobal("MSN_GremlinPartsBin4", 1)
  elseif (targetName == "MSN_MissingParts05") then
    ForceSpawn("MSN_Bin5FXSpawner", 1)
    SetGlobal("MSN_GremlinPartsBin5", 1)
  end
  DestroyEntity(target)
  AudioPostEventOn(GetPlayer(), "Play_sfx_msn_construction_horse_break")
  AnimEvent("EM2_MSTN_GremlinMarkus", EVENT_Force_Idle)
  if (GetGlobal("MeanStreet_HasAnyBldgDestroyed") == 0) then
    SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") - 5))
  elseif (GetGlobal("MeanStreet_HasAnyBldgDestroyed") == 1) then
    SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") - 10))
  end
  Wait(0)
  MSN_SaveCheckPoint02()
  ForEachEntityInGroup(DestroyEntity, "MSN_BinFX")
  return 
end
MSN_BlowUpParts = function(target, event, binNumber)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    if (binNumber == "bin5") then
      StartEmitters("MSN_Bin5FX")
      SetGlobal("MSN_GremlinPartsBin5", 1)
      DestroyEntity(target)
      Prefab_ScrapMetalSpawner_Launch("MSN_PartsBin5")
      Wait(3)
      StopEmitters("MSN_Bin5FX")
    elseif (binNumber == "bin1") then
      StartEmitters("MSN_Bin1FX")
      DestroyEntity(target)
      SetGlobal("MSN_GremlinPartsBin1", 1)
      Prefab_ScrapMetalSpawner_Launch("MSN_PartsBin1")
      Wait(3)
      StopEmitters("MSN_Bin1FX")
    elseif (binNumber == "bin2") then
      StartEmitters("MSN_Bin2FX")
      DestroyEntity(target)
      SetGlobal("MSN_GremlinPartsBin2", 1)
      Prefab_ScrapMetalSpawner_Launch("MSN_PartsBin2")
      Wait(3)
      StopEmitters("MSN_Bin2FX")
    elseif (binNumber == "bin3") then
      StartEmitters("MSN_Bin3FX")
      SetGlobal("MSN_GremlinPartsBin3", 1)
      DestroyEntity(target)
      Prefab_ScrapMetalSpawner_Launch("MSN_PartsBin3")
      Wait(3)
      StopEmitters("MSN_Bin3FX")
    elseif (binNumber == "bin4") then
      StartEmitters("MSN_Bin4FX")
      SetGlobal("MSN_GremlinPartsBin4", 1)
      DestroyEntity(target)
      Prefab_ScrapMetalSpawner_Launch("MSN_PartsBin4")
      Wait(3)
      StopEmitters("MSN_Bin4FX")
    end
  end
  return 
end
MSN_GremlinPartsHide = function()
  if (1 <= GetGlobal("MSN_GremlinPartsBin1")) then
    DestroyEntity("MSN_MissingParts01")
  end
  if (1 <= GetGlobal("MSN_GremlinPartsBin2")) then
    DestroyEntity("MSN_MissingParts02")
  end
  if (1 <= GetGlobal("MSN_GremlinPartsBin3")) then
    DestroyEntity("MSN_MissingParts03")
  end
  if (1 <= GetGlobal("MSN_GremlinPartsBin4")) then
    DestroyEntity("MSN_MissingParts04")
  end
  if (1 <= GetGlobal("MSN_GremlinPartsBin5")) then
    DestroyEntity("MSN_MissingParts05")
  end
  return 
end
MSN_OswaldTowerRepairRadius = function()
  SetGlobal("MSN_GremlinQuadrantTracker", 8)
  TeleportGremlinToEntity("EM2_MSTN_GremlinMarkus", "MSN_OswaldTwrRepairWait")
  return 
end
MSN_HydrantBreak = function(target, which)
  if (which == "front") then
    StartEmitters("MSN_FrontSpray")
    Wait(0.800000011920929)
    StopEmitters("MSN_FrontSpray")
  elseif (which == "Back") then
    StartEmitters("MSN_FrontSpray")
    Wait(0.800000011920929)
    StopEmitters("MSN_FrontSpray")
  end
  return 
end
MSN_CameraTutorStart = function()
  Print("##### PICTURE MORE START")
  if (GetGlobal("MSN_Gus_CameraTutorial02_Played") == 1) then
    if (GetGlobal("MSN_Gus_CameraTutorial04_Played") == 0) then
      ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_CameraTutorial04")
    end
  end
  return 
end
MSN_CameraTutorPicTaken = function()
  Print("##### PICTURE MORE Taken")
  return 
end
MSN_CameraTutorStop = function()
  Print("##### PICTURE MORE Stop")
  if (GetGlobal("MSN_Gus_CameraTutorial04_Played") == 1) then
    if (GetGlobal("MSN_Gus_CameraTutorial06_Played") == 0) then
      ForceSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_CameraTutorial06")
    end
  end
  return 
end
MSN_ArcTube = 0
MSN_SiteTube = 0
MSN_ActivateTransportSystem = function()
  SetGlobal("MSN_Teleporter", 1)
  UseQuestItems("Tube_Part", 1)
  Enable("MSN_SiteTransportTrigger")
  Enable("MSN_ArcadeTeleportTrigger")
  Disable("MSN_TubeQuadrant")
  MSN_SaveCheckPoint02()
  TeleportGremlinOut("EM2_MSTN_GremlinMarkus")
  return 
end
MSN_TransportStartLoc = 0
MSN_OpenTransportTubes = function(target, loc)
  Print("######### BANKTUBE MSN_OpenTransportTubes Rescue")
  Disable("MSN_ArcadeTeleportTrigger")
  Disable("MSN_SiteTransportTrigger")
  if (loc == "arcade") then
    Print("######### BANKTUBE MSN_OpenTransportTubes ARCADE Rescue")
    Disable("MSN_SiteInsideTeleTrigger")
    AnimGBSequence("MSTN_ConstructionTeleporterCap", "open")
    AudioPostEventOn("MSTN_ConstructionTeleporterCap", "Play_sfx_msn_transportOpen")
    ForceSpawn("MSN_PushColumnSite", 1)
    Enable("MSN_SiteImpulse")
    Disable("MSN_SiteFreezeCamera")
    Disable("MSN_ArcadeCameraOverride")
    Enable("MSN_ArcadeInnerTeleTrigger")
    Enable("MSN_SiteCameraOverride")
    Enable("MSN_ArcadeFreezeCamera")
    Unhide("MSN_TubeWind01")
    AudioPostEventOn("MSN_TubeWind01", "Play_sfx_MSN_transport_wind")
    MSN_SiteTube = 1
    MSN_ArcTube = 1
    MSN_TransportStartLoc = 0
    AnimGBSequence("MSTN_ArcadeTransporterEntrance", "open")
    AudioPostEventOn("MSTN_ArcadeTransporterEntrance", "Play_sfx_msn_transportOpen")
    Enable("MSN_SiteImpulse")
  elseif (loc == "site") then
    Print("######### BANKTUBE MSN_OpenTransportTubes SITE Rescue")
    Disable("MSN_ArcadeInnerTeleTrigger")
    AnimGBSequence("MSTN_ArcadeTransporterEntrance", "open")
    AudioPostEventOn("MSTN_ArcadeTransporterEntrance", "Play_sfx_msn_transportOpen")
    ForceSpawn("MSN_PushColumnArcade", 1)
    Enable("MSN_ArcadeImpulse")
    Disable("MSN_ArcadeFreezeCamera")
    Disable("MSN_SiteCameraOverride")
    Enable("MSN_SiteInsideTeleTrigger")
    Enable("MSN_ArcadeCameraOverride")
    Enable("MSN_SiteFreezeCamera")
    Unhide("MSN_TubeWind02")
    AudioPostEventOn("MSN_TubeWind02", "Play_sfx_MSN_transport_wind")
    MSN_ArcTube = 1
    MSN_SiteTube = 1
    MSN_TransportStartLoc = 1
    AnimGBSequence("MSTN_ConstructionTeleporterCap", "open")
    AudioPostEventOn("MSTN_ConstructionTeleporterCap", "Play_sfx_msn_transportOpen")
  end
  TimerEnable("MSN_TransportTubeTimer")
  TimerReset("MSN_TransportTubeTimer")
  return 
end
MSN_ArcTubeOccupied = function()
  Print("######### BANKTUBE MSN_ArcTubeOccupied rescue")
  MSN_ArcTube = 1
  return 
end
MSN_SiteTubeOccupied = function()
  Print("######### BANKTUBE MSN_SiteTubeOccupied rescue")
  MSN_SiteTube = 1
  return 
end
MSN_ArcTubeClear = function()
  MSN_ArcTube = 0
  return 
end
MSN_SiteTubeClear = function()
  MSN_SiteTube = 0
  return 
end
MSN_TransportTubeTimerCount = 0
MSN_TubesAllClear = function(target)
  Print("######### BANKTUBE MSN_TubesAllClear Rescue")
  MSN_TransportTubeTimerCount = (MSN_TransportTubeTimerCount + 1)
  Print(MSN_TransportTubeTimerCount)
  if (MSN_TransportTubeTimerCount < 14) then
    if (MSN_ArcTube == 0) then
      if (MSN_SiteTube == 0) then
        if (MSN_TransportStartLoc == 0) then
          Print("######### MSN_TransportStartLoc 0 #########")
          TimerDisable("MSN_TransportTubeTimer")
          TimerReset("MSN_TransportTubeTimer")
          MSN_TransportTubeTimerCount = 0
          AnimGBSequence("MSTN_ArcadeTransporterEntrance", "close")
          AudioPostEventOn("MSTN_ArcadeTransporterEntrance", "Play_sfx_msn_transportClose")
          Hide("MSN_TubeWind01")
          AudioPostEventOn("MSN_TubeWind01", "Stop_sfx_MSN_transport_wind")
          Wait(2)
          AnimGBSequence("MSTN_ConstructionTeleporterCap", "close")
          AudioPostEventOn("MSTN_ConstructionTeleporterCap", "Play_sfx_msn_transportClose")
          Wait(0.800000011920929)
          ClearAllCameraAttributes()
          ForEachEntityInGroup(DestroyEntity, "MSN_AirConditionerWind")
          DecrementPaintAbilitiesDisabled(GetPlayer())
          OswaldAbortScriptedBehavior()
          Wait(0)
          OswaldStartFollowAction()
          Disable("MSN_ArcadeImpulse")
          Disable("MSN_SiteImpulse")
          MSN_ArcTube = 0
          MSN_SiteTube = 0
          Wait(1)
          Enable("MSN_SiteTransportTrigger")
          Enable("MSN_ArcadeTeleportTrigger")
        elseif (MSN_TransportStartLoc == 1) then
          Print("######### MSN_TransportStartLoc 1 #########")
          TimerDisable("MSN_TransportTubeTimer")
          TimerReset("MSN_TransportTubeTimer")
          MSN_TransportTubeTimerCount = 0
          AnimGBSequence("MSTN_ConstructionTeleporterCap", "close")
          AudioPostEventOn("MSTN_ConstructionTeleporterCap", "Play_sfx_msn_transportClose")
          Hide("MSN_TubeWind02")
          AudioPostEventOn("MSN_TubeWind02", "Stop_sfx_MSN_transport_wind")
          Wait(2)
          AnimGBSequence("MSTN_ArcadeTransporterEntrance", "close")
          AudioPostEventOn("MSTN_ArcadeTransporterEntrance", "Play_sfx_msn_transportClose")
          Wait(0.800000011920929)
          ClearAllCameraAttributes()
          ForEachEntityInGroup(DestroyEntity, "MSN_AirConditionerWind")
          DecrementPaintAbilitiesDisabled(GetPlayer())
          OswaldAbortScriptedBehavior()
          Wait(0)
          OswaldStartFollowAction()
          Disable("MSN_ArcadeImpulse")
          Disable("MSN_SiteImpulse")
          MSN_ArcTube = 0
          MSN_SiteTube = 0
          Wait(1)
          Enable("MSN_SiteTransportTrigger")
          Enable("MSN_ArcadeTeleportTrigger")
          Print("###### Rescue STARTED")
          TimerDisable("MSN_TransportTubeTimer")
          TimerReset("MSN_TransportTubeTimer")
          MSN_TransportTubeTimerCount = 0
          AnimGBSequence("MSTN_ConstructionTeleporterCap", "open")
          AnimGBSequence("MSTN_ConstructionTeleporterCap", "open")
          AudioPostEventOn("MSTN_ConstructionTeleporterCap", "Play_sfx_msn_transportOpen")
          Disable("MSN_SiteInsideTeleTrigger")
          Disable("MSN_ArcadeInnerTeleTrigger")
          Disable("MSN_ArcadeTeleportTrigger")
          Disable("MSN_SiteTransportTrigger")
          if (MSN_TransportStartLoc == 0) then
            ForceSpawn("MSN_PushColumnArcade", 1)
          elseif (MSN_TransportStartLoc == 1) then
            ForceSpawn("MSN_PushColumnSite", 1)
          end
          Hide("MSN_TubeWind02")
          AudioPostEventOn("MSN_TubeWind02", "Stop_sfx_MSN_transport_wind")
          Hide("MSN_TubeWind01")
          AudioPostEventOn("MSN_TubeWind01", "Stop_sfx_MSN_transport_wind")
          Disable("MSN_SiteFreezeCamera")
          Disable("MSN_ArcadeFreezeCamera")
          Enable("MSN_ArcadeCameraOverride")
          Enable("MSN_SiteCameraOverride")
          Wait(4)
          AnimGBSequence("MSTN_ArcadeTransporterEntrance", "close")
          AudioPostEventOn("MSTN_ArcadeTransporterEntrance", "Play_sfx_msn_transportClose")
          AnimGBSequence("MSTN_ConstructionTeleporterCap", "close")
          AudioPostEventOn("MSTN_ConstructionTeleporterCap", "Play_sfx_msn_transportClose")
          Wait(2)
          ClearAllCameraAttributes()
          ForEachEntityInGroup(DestroyEntity, "MSN_AirConditionerWind")
          DecrementPaintAbilitiesDisabled(GetPlayer())
          OswaldAbortScriptedBehavior()
          Wait(0)
          OswaldStartFollowAction()
          Disable("MSN_ArcadeImpulse")
          Disable("MSN_SiteImpulse")
          Wait(2)
          MSN_ArcTube = 0
          MSN_SiteTube = 0
          Enable("MSN_ArcadeTeleportTrigger")
          Enable("MSN_SiteTransportTrigger")
        end
      end
    end
  else
    Print("###### Rescue STARTED")
    TimerDisable("MSN_TransportTubeTimer")
    TimerReset("MSN_TransportTubeTimer")
    MSN_TransportTubeTimerCount = 0
    AnimGBSequence("MSTN_ConstructionTeleporterCap", "open")
    AnimGBSequence("MSTN_ConstructionTeleporterCap", "open")
    AudioPostEventOn("MSTN_ConstructionTeleporterCap", "Play_sfx_msn_transportOpen")
    Disable("MSN_SiteInsideTeleTrigger")
    Disable("MSN_ArcadeInnerTeleTrigger")
    Disable("MSN_ArcadeTeleportTrigger")
    Disable("MSN_SiteTransportTrigger")
    if (MSN_TransportStartLoc == 0) then
      ForceSpawn("MSN_PushColumnArcade", 1)
    elseif (MSN_TransportStartLoc == 1) then
      ForceSpawn("MSN_PushColumnSite", 1)
    end
    Hide("MSN_TubeWind02")
    AudioPostEventOn("MSN_TubeWind02", "Stop_sfx_MSN_transport_wind")
    Hide("MSN_TubeWind01")
    AudioPostEventOn("MSN_TubeWind01", "Stop_sfx_MSN_transport_wind")
    Disable("MSN_SiteFreezeCamera")
    Disable("MSN_ArcadeFreezeCamera")
    Enable("MSN_ArcadeCameraOverride")
    Enable("MSN_SiteCameraOverride")
    Wait(4)
    AnimGBSequence("MSTN_ArcadeTransporterEntrance", "close")
    AudioPostEventOn("MSTN_ArcadeTransporterEntrance", "Play_sfx_msn_transportClose")
    AnimGBSequence("MSTN_ConstructionTeleporterCap", "close")
    AudioPostEventOn("MSTN_ConstructionTeleporterCap", "Play_sfx_msn_transportClose")
    Wait(2)
    ClearAllCameraAttributes()
    ForEachEntityInGroup(DestroyEntity, "MSN_AirConditionerWind")
    DecrementPaintAbilitiesDisabled(GetPlayer())
    OswaldAbortScriptedBehavior()
    Wait(0)
    OswaldStartFollowAction()
    Disable("MSN_ArcadeImpulse")
    Disable("MSN_SiteImpulse")
    Wait(2)
    MSN_ArcTube = 0
    MSN_SiteTube = 0
    Enable("MSN_ArcadeTeleportTrigger")
    Enable("MSN_SiteTransportTrigger")
  end
  return 
end
MSN_TransportTubeTeleport = function(target, tube)
  Print("######### BANKTUBE MSN_TransportTubeTeleport Rescue")
  if (tube == "site") then
    Print("######### BANKTUBE MSN_TransportTubeTeleport SITE Rescue")
    TeleportToEntity(target, "MSN_ArcadeInsideTeleMarker")
  elseif (tube == "arcade") then
    Print("######### BANKTUBE MSN_TransportTubeTeleport ARCADE Rescue")
    TeleportToEntity(target, "MSN_SiteInsideTeleMarker")
  end
  return 
end
MSN_TeleOswaldSite = function()
  Print("######### MSN_TeleOswaldSite  #########")
  OswaldStopMovingAction()
  TeleportToEntity(GetOswaldAI(), "MSN_SiteInsideTeleMarker")
  Wait(0)
  QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Wait_For_Attach_NoSupport, GetPosition("MSN_SiteInsideTeleMarker"))
  return 
end
MSN_TeleOswaldArcade = function()
  OswaldStopMovingAction()
  TeleportToEntity(GetOswaldAI(), "MSN_ArcadeInsideTeleMarker")
  Wait(0)
  QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Wait_For_Attach_NoSupport, GetPosition("MSN_ArcadeInsideTeleMarker"))
  return 
end
MSN_TeleportJamfaceOut = function()
  FireThread(TeleportGremlinOut, "EM2_MSTN_GremlinHerman")
  return 
end
MSN_TeleportJamfaceOut02 = function()
  FireThread(TeleportGremlinOut, "EM2_MSTN_GremlinMarkus")
  return 
end
MSN_FixSecretDoor = function()
  Disable("MSN_ActivateSecretLedgeAction")
  Disable("MSN_HiddenForSecret")
  SetPropertyFloat("MSN_SecretEntranceTrigger", "UsableRadius", 2)
  OswaldStreamAbort()
  SetSplineFollowerInitialSpeed("MSN_SecretDoor", 2)
  AudioPostEventOn("MSN_SecretDoor", "Play_sfx_Door_Boat_SlidingCloseMed")
  return 
end
MSN_ActivateSecretLedgeHidden = function()
end
MSN_ShockSecretPanel = function()
  OswaldStreamAction("MSN_OswaldSecretWallTarget")
  return 
end
MSN_ApplyImpulseTube = function(target, which)
  if (which == "arcade") then
    ApplyImpulse(target, 150, 3, 150)
  elseif (which == "site") then
    ApplyImpulse(target, 5, 3, 150)
  end
  return 
end
MSN_RobberyCamUtilIntercept = function()
  if (GetGlobal("MSN_MarkusVaultRobbery_Played") == 0) then
    if (GetGlobal("MSN_VaultDoorState") == 2) then
      if (2 <= GetGlobal("MSN_VisitNumber")) then
        SetGlobal("MSN_GremlinQuadrantTracker", 10)
        SetGlobal("MSN_GremlinYellPos", 1)
        SetGlobal("MSN_VaultDoorState", 3)
        StartFadeOut(0.5)
        Wait(0.5)
        SetPropertyFloat("EM2_MSTN_GremlinMarkus", "UsableRadius", 0)
        AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Mood_Type, MOOD_Negative)
        TeleportToEntity(GetPlayer(), "MSNorth_UTLexit_MickeySpawn")
        TeleportToEntity(GetPlayer2OrAI, "MSNorth_UTLexit_OswaldSpawn")
        FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_UtilJamfaceRobberyMarker")
        SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") + 50))
        FireUser1("MSN_VaultYellCamUtil")
      end
    end
  end
  return 
end
MSN_RobberyCamVaultIntercept = function()
  if (GetGlobal("MSN_MarkusVaultRobbery_Played") == 0) then
    if (GetGlobal("MSN_VaultDoorState") == 2) then
      if (2 <= GetGlobal("MSN_VisitNumber")) then
        SetGlobal("MSN_GremlinQuadrantTracker", 10)
        SetGlobal("MSN_GremlinYellPos", 2)
        SetGlobal("MSN_VaultDoorState", 3)
        StartFadeOut(0.5)
        Wait(0.5)
        SetPropertyFloat("EM2_MSTN_GremlinMarkus", "UsableRadius", 0)
        AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Mood_Type, MOOD_Negative)
        TeleportToEntity(GetPlayer(), "MSN_MickeyRobberyVaultExit")
        TeleportToEntity(GetPlayer2OrAI, "MSN_OswaldRobberyVaultExit")
        FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_JamfaceRobberyVaultMarker")
        SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") + 50))
        FireUser1("MSN_VaultRobberyVault")
      end
    end
  end
  return 
end
MSN_RobberyCamBalloonIntercept = function()
  if (GetGlobal("MSN_MarkusVaultRobbery_Played") == 0) then
    if (GetGlobal("MSN_VaultDoorState") == 2) then
      if (2 <= GetGlobal("MSN_VisitNumber")) then
        SetGlobal("MSN_GremlinQuadrantTracker", 10)
        SetGlobal("MSN_GremlinYellPos", 3)
        SetGlobal("MSN_VaultDoorState", 3)
        StartFadeOut(0.5)
        Wait(0.5)
        SetPropertyFloat("EM2_MSTN_GremlinMarkus", "UsableRadius", 0)
        AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Mood_Type, MOOD_Negative)
        TeleportToEntity(GetPlayer(), "MSN_FromBalloonMickey")
        TeleportToEntity(GetPlayer2OrAI, "MSN_FromBalloonOswald")
        FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_MarkusPostVaultRobbery")
        SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") + 50))
        FireUser1("MSN_BalloonRobberyCamera")
      end
    end
  end
  return 
end
MSN_RobberyCamProjIntercept = function()
  if (GetGlobal("MSN_MarkusVaultRobbery_Played") == 0) then
    if (GetGlobal("MSN_VaultDoorState") == 2) then
      StartFadeOut(0)
      SetPropertyFloat("EM2_MSTN_GremlinMarkus", "UsableRadius", 0)
      SetGlobal("MSN_GremlinQuadrantTracker", 10)
      SetGlobal("MSN_GremlinYellPos", 0)
      SetGlobal("MSN_VaultDoorState", 3)
      AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Mood_Type, MOOD_Negative)
      Wait(0)
      TeleportToEntity(GetPlayer(), "MSN_RobberyMarkerProj_Mickey")
      TeleportToEntity(GetPlayer2OrAI, "MSN_RobberyMarkerProj_Oswald")
      FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_RobberyMarkerProj_Jamface")
      SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") + 50))
      FireUser1("VaultYellCamProjectors")
    end
  end
  return 
end
MSN_JamfaceCinemaIntercept = function()
  if (GetGlobal("MSN_MarkusVaultRobbery_Played") == 0) then
    if (GetGlobal("MSN_VaultDoorState") == 2) then
      StartFadeOut(0)
      SetPropertyFloat("EM2_MSTN_GremlinMarkus", "UsableRadius", 0)
      SetGlobal("MSN_GremlinQuadrantTracker", 10)
      SetGlobal("MSN_GremlinYellPos", 4)
      SetGlobal("MSN_VaultDoorState", 3)
      AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Mood_Type, MOOD_Negative)
      Wait(0)
      FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_JamfaceCinemaRobberyMarker")
      SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") + 50))
      FireUser1("MSN_JamfaceCinemaInterceptCam")
    end
  end
  return 
end
MSN_JamfaceReloadIntercept = function()
  if (GetGlobal("MSN_MarkusVaultRobbery_Played") == 0) then
    if (GetGlobal("MSN_VaultDoorState") == 2) then
      StartFadeOut(0)
      SetPropertyFloat("EM2_MSTN_GremlinMarkus", "UsableRadius", 0)
      SetGlobal("MSN_GremlinQuadrantTracker", 10)
      SetGlobal("MSN_GremlinYellPos", 5)
      SetGlobal("MSN_VaultDoorState", 3)
      AnimVarInt("EM2_MSTN_GremlinMarkus", VAR_Mood_Type, MOOD_Negative)
      Wait(0)
      FireThread(TeleportGremlinToEntity, "EM2_MSTN_GremlinMarkus", "MSN_JamfaceReloadInterceptMarker")
      SetGlobal("MeanStreet_PriceTracker", (GetGlobal("MeanStreet_PriceTracker") + 50))
      FireUser1("MSN_ReloadInterceptCam")
    end
  else
    StartFadeIn(0.5)
  end
  return 
end
MSN_CatchPartsBin = function(target)
  local groupName = GetPropertyString(target, "EntityGroups", 0)
  if (groupName == "MSN_MissingParts01") then
    if (GetGlobal("MSN_GremlinPartsBin1") == 0) then
      SetGlobal("MSN_GremlinPartsBin2", 2)
    end
  elseif (groupName == "MSN_MissingParts02") then
    if (GetGlobal("MSN_GremlinPartsBin2") == 0) then
      SetGlobal("MSN_GremlinPartsBin2", 2)
    end
  elseif (groupName == "MSN_MissingParts03") then
    if (GetGlobal("MSN_GremlinPartsBin3") == 0) then
      SetGlobal("MSN_GremlinPartsBin2", 2)
    end
  elseif (groupName == "MSN_MissingParts04") then
    if (GetGlobal("MSN_GremlinPartsBin4") == 0) then
      SetGlobal("MSN_GremlinPartsBin2", 2)
    end
  elseif (groupName == "MSN_MissingParts05") then
    if (GetGlobal("MSN_GremlinPartsBin5") == 0) then
      SetGlobal("MSN_GremlinPartsBin2", 2)
    end
  end
  return 
end
MSN_CriticalPath = function(target, step)
  if (step == "N1") then
    Quest_SetCriticalPath("Critical_MSN", "Critical_MSN_1")
  else
  end
  return 
end
MSN_GremlinShaky = function()
  if (GetGlobal("EM2_EpisodeCheck") >= 2) then
  end
  MoveToEntity("MSN_Gremlin_Shaky", "MSN_ShakyHammerTime")
  local wrench = GetChildEntityByName("MSN_Gremlin_Shaky", "GremlinWrench")
  Unhide(wrench)
  Wait(0.10000000149011612)
  AnimVarInt("MSN_Gremlin_Shaky", VAR_Cutscene, 1)
  AnimEvent("MSN_Gremlin_Shaky", EVENT_Start_Cutscene)
  return 
end
MSN_Jamface_RescuePayout = function(target, Tier)
  Wait(0.5)
  if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_3", Quest_TurnIn) == true) then
    if (GetGlobal("GremlinRescuedRewardTier3") == 2) then
      Print("############################# MSN_Jamface_RescuePayout 1")
      SetGlobal("GremlinRescuedRewardTier3", 3)
      ForceSequence("EM2_MSTN_GremlinMarkus", "MSN_Jamface_RescuedRewardTier1")
    end
  elseif (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_2", Quest_TurnIn) == true) then
    if (GetGlobal("GremlinRescuedRewardTier2") == 2) then
      Print("############################# MSN_Jamface_RescuePayout 1")
      SetGlobal("GremlinRescuedRewardTier2", 3)
      ForceSequence("EM2_MSTN_GremlinMarkus", "MSN_Jamface_RescuedRewardTier1")
    end
  elseif (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_1", Quest_TurnIn) == true) then
    if (GetGlobal("GremlinRescuedRewardTier1") == 2) then
      Print("############################# MSN_Jamface_RescuePayout 3")
      SetGlobal("GremlinRescuedRewardTier1", 3)
      ForceSequence("EM2_MSTN_GremlinMarkus", "MSN_Jamface_RescuedRewardTier1")
    end
  end
  return 
end
MSN_GremlinDropAchieve = function()
  GiveCurrencyItem("Gold_Pin", 1)
  GiveCollectible("Challenge_Perfectionist_OpGremlinDrop_Tracker")
  return 
end
MSN_ConstructionWallGlobal = function()
  SetGlobal("MSN_ConstructionWall", 1)
  MSN_SaveCheckPoint02()
  return 
end
MSN_CullUpperGroup1 = function(target)
  Print("MSN_CullUpperGroup1")
  if (_activator() == GetPlayer()) then
    ForEachEntityInGroup(ClearAppCulledViewport, "CullUndermill1", 0)
    ForEachEntityInGroup(SetAppCulledViewport, "UpperCullGroup1", 0)
    ForEachEntityInGroup(SetAppCulledViewport, "UpperCullGroup2", 0)
  elseif (_activator() == GetPlayer2OrAI()) then
    ForEachEntityInGroup(ClearAppCulledViewport, "CullUndermill1", 1)
    ForEachEntityInGroup(SetAppCulledViewport, "UpperCullGroup1", 1)
    ForEachEntityInGroup(SetAppCulledViewport, "UpperCullGroup2", 1)
  end
  return 
end
MSN_CullUndermill1 = function(target)
  Print("MSN_CullUndermill1")
  if (_activator() == GetPlayer()) then
    ForEachEntityInGroup(ClearAppCulledViewport, "UpperCullGroup1", 0)
    ForEachEntityInGroup(ClearAppCulledViewport, "UpperCullGroup2", 0)
  elseif (_activator() == GetPlayer2OrAI()) then
    ForEachEntityInGroup(ClearAppCulledViewport, "UpperCullGroup1", 1)
    ForEachEntityInGroup(ClearAppCulledViewport, "UpperCullGroup2", 1)
  end
  return 
end
MSN_CullUpperGroup2 = function(target)
  Print("MSN_CullUpperGroup2")
  if (_activator() == GetPlayer()) then
    ForEachEntityInGroup(SetAppCulledViewport, "UpperCullGroup2", 0)
    ForEachEntityInGroup(SetAppCulledViewport, "CullUndermill1", 0)
  elseif (_activator() == GetPlayer2OrAI()) then
    ForEachEntityInGroup(SetAppCulledViewport, "UpperCullGroup2", 1)
    ForEachEntityInGroup(SetAppCulledViewport, "CullUndermill1", 1)
  end
  return 
end
MSN_StopCullingUpperGroup2 = function(target)
  Print("MSN_StopCullingUpperGroup2")
  if (_activator() == GetPlayer()) then
    ForEachEntityInGroup(ClearAppCulledViewport, "UpperCullGroup2", 0)
  elseif (_activator() == GetPlayer2OrAI()) then
    ForEachEntityInGroup(ClearAppCulledViewport, "UpperCullGroup2", 1)
  end
  return 
end
MSN_CullProjectorGroup1 = function(target)
  Print("MSN_CullProjectorGroup1")
  if (MSN_NoCullFromTubes == 0) then
    if (_activator() == GetPlayer()) then
      ForEachEntityInGroup(SetAppCulledViewport, "CullUndermill1", 0)
      ForEachEntityInGroup(SetAppCulledViewport, "ProjectorCullGroup1", 0)
    elseif (_activator() == GetPlayer2OrAI()) then
      ForEachEntityInGroup(SetAppCulledViewport, "CullUndermill1", 1)
      ForEachEntityInGroup(SetAppCulledViewport, "ProjectorCullGroup1", 1)
    end
    MSN_NoCullFromTubes = 0
  end
  return 
end
MSN_StopCullingProjectorGroup1 = function(target)
  Print("MSN_StopCullingProjectorGroup1")
  if (_activator() == GetPlayer()) then
    ForEachEntityInGroup(ClearAppCulledViewport, "ProjectorCullGroup1", 0)
  elseif (_activator() == GetPlayer2OrAI()) then
    ForEachEntityInGroup(ClearAppCulledViewport, "ProjectorCullGroup1", 1)
  end
  return 
end
MSN_CullJustUndermill = function(target)
  Print("MSN_CullJustUndermill")
  if (_activator() == GetPlayer()) then
    ForEachEntityInGroup(SetAppCulledViewport, "CullUndermill1", 0)
  elseif (_activator() == GetPlayer2OrAI()) then
    ForEachEntityInGroup(SetAppCulledViewport, "CullUndermill1", 1)
  end
  return 
end
MSN_StopCullingJustUndermill = function(target)
  Print("MSN_StopCullingJustUndermill")
  if (_activator() == GetPlayer()) then
    ForEachEntityInGroup(ClearAppCulledViewport, "CullUndermill1", 0)
  elseif (_activator() == GetPlayer2OrAI()) then
    ForEachEntityInGroup(ClearAppCulledViewport, "CullUndermill1", 1)
  end
  return 
end
MSN_UndermillCleanup = function()
  if (GetGlobal("MSN_UndermillPipeDoor") == 1) then
    Print("###### MSTN_AlwaysSetup LOAD UNDERMILL 3")
    DestroyEntity("MSN_UndermillTreasure")
    DestroyEntity("MSN_UnderMill_ClosetDoor01")
    DestroyEntity("MSN_UnderMill_ClosetDoor02")
    Prefab_OswaldElectricSwitch_ChangeState("MSN_UnderMillClosetMarker", "Deactivate")
  elseif (GetGlobal("MSN_UndermillPipeDoor") == 2) then
    Prefab_OswaldElectricSwitch_ChangeState("MSN_UnderMillClosetMarker", "Deactivate")
    ForEachEntityInGroup(DestroyEntity, "MSN_UndermillPipeGroup")
    DestroyEntity("MSN_UndermillPipeTreasure")
  end
  return 
end
MSN_WindDisablePaint = function(target, action)
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
MSN_JamfaceAngry = function()
  if (GetGlobal("MSN_JamfaceAngryVar") == 0) then
    SetGlobal("MSN_JamfaceAngryVar", 1)
    GiveCollectible("Challenge_Perfectionist_OpGremlinDrop_Tracker")
    if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_3", Quest_Completed) ~= true) then
      Print("############################# MSN_JamfaceAngry 1")
      Quest_SetStatus("Operation_Gremlin", "Operation_Gremlin_3", Quest_Unavailable, false)
    end
    if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_2", Quest_Completed) ~= true) then
      Print("############################# MSN_JamfaceAngry 2")
      Quest_SetStatus("Operation_Gremlin", "Operation_Gremlin_2", Quest_Unavailable, false)
    end
    if (Quest_CheckStatus("Operation_Gremlin", "Operation_Gremlin_1", Quest_Completed) ~= true) then
      Print("############################# MSN_JamfaceAngry 3")
      Quest_SetStatus("Operation_Gremlin", "Operation_Gremlin_1", Quest_Unavailable, false)
    end
    MSN_SaveCheckPoint02()
  end
  return 
end
MSN_PedestrianRescue = function()
  Print("#### MSN_PedestrianRescue ##### MSN_PedestrianRescue")
  if (MSN_Ped01_EnterTracker == 0) then
    ForEachEntityInGroup(SetNextPatrolNode, "MSN_BothBeds", "MSN_PedRescue03")
  end
  return 
end
MSN_ClosetTreasureObtained = function()
  SetGlobal("MSN_UndermillPipeDoor", 2)
  return 
end

