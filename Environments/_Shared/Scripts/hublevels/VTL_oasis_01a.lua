VTL_Oasis_LauncherSetup = function(target, visit)
  Print("VTL_Oasis_LauncherSetup: visit = ")
  local level = tostring(LevelManager_GetCurrentState())
  if (string.sub(level, 11, 18) == "launcher") then
    Print("VTL_Oasis_LauncherSetup: We have a launcher load!")
    SetGlobal("VTL_Oasis_Visit", 3)
    SetGlobal("EM2_EpisodeCheck", 4)
    SetGlobal("VTL_Oasis_OpeningMoviePlayed", 1)
    ForEachEntityInGroup(Hide, "MainStoryExpansionProps")
    VTL_Oasis_SetupPirateAnimStates()
    local liftState = "Fixed"
    local craneState = "Fixed"
    if (level == "vtl_oasis.launcher_fixliftbreakcrane") then
      craneState = "Broken"
    elseif (level == "vtl_oasis.launcher_breakliftfixcrane") then
      liftState = "Broken"
    elseif (level == "vtl_oasis.launcher_breakliftcrane") then
      liftState = "Broken"
      craneState = "Broken"
    end
    if (liftState == "Fixed") then
      AnimGBSequence("vtl_oasis_01a_scripting.waterwheelPlatform_inert_01a", "on")
      SetGlobal("VTL_Oasis_MissingLiftGear", 2)
      SetPropertyFloat("vtl_oasis_01a_scripting.Marker(Usable)_waterwheelPlatform_inert_01a", "UsableRadius", 0)
    elseif (liftState == "Broken") then
      SetGlobal("VTL_Oasis_TikiSamsTunnelOpen", 1)
    end
    if (craneState == "Fixed") then
      SetGlobal("VTL_Oasis_BlotlingsQuest_State", 1)
      DestroyEntity("vtl_oasis_01a_ai_epilogue.PirateRanged_Starkey")
      LevelManager_SetCurrentState("vtl_oasis.Main_MainStory")
    elseif (craneState == "Broken") then
      SetGlobal("VTL_Oasis_BlotlingsQuest_State", 2)
      LevelManager_SetCurrentState("vtl_oasis.Main_MainStory")
    end
  end
  if (string.sub(level, -6, -1) == "loadin") then
    LevelManager_SetCurrentState("VTL_Oasis.Main_MainStory")
  end
  if (GetGlobal("EM2_TrainRide") == 1) then
    StartFadeOut(0)
    Print("VTL_Oasis_LauncherSetup: EM2_TrainRide == 1: Turning off Projector Jump Out Sequence - Firing VTL_Oasis_Setup")
    GetPrefabData("2D_FromMeanStreetNorth").MapLoad_SetupPosition = "IgnoreMe"
    GetPrefabData("2D_FromMeanStreetNorth").ExitFunction = "None"
    TeleportToEntity(GetPlayer(), "PM_TrainStationStart_Mickey")
    TeleportToEntity(GetPlayer2OrAI(), "PM_TrainStationStart_Oswald")
    wait(0)
    CameraReset()
    VTL_AlwaysSetup()
    VTL_Oasis_Setup()
  elseif (GetGlobal("VTL_Oasis_OpeningMoviePlayed") == 0) then
    GetPrefabData("2D_FromMeanStreetNorth").SkipJumpOutAnim = true
  elseif (GetGlobal("VTL_Oasis_BlotlingRoundUp_State") == 0) then
    if (GetGlobal("VTL_Oasis_CraneDecision") == 2) then
      Print("VTL_Oasis_LauncherSetup: Return Visit in Episode 4 Starting Starkeys Sequence")
    end
  end
  if (Quest_CheckStatus("A_Captains_Life_for_Me", "A_Captains_Life_for_Me_4a", Quest_Completed) == true) then
    DestroyEntity("vtl_oasis_01a_ai_epilogue.PirateRanged_v2_BelugaBilly")
  end
  return 
end
VTL_AlwaysSetup = function(projector)
  Print("VTL_AlwaysSetup")
  for i = 1, 3 do
    if GetPropertyBool(("vtl_oasis_01a_scripting.mirror_01a_toon 0" .. i), "Is Painted") then
      SetPropertyFloat(("vtl_oasis_01a_scripting.ProjectedLightbeam 0" .. i), "BeamExtendAmount", 0.5)
      SetPropertyFloat(("vtl_oasis_01a_scripting.ProjectedLightbeam 0" .. i), "BeamMaxLength", 50)
    end
  end
  if (0 < GetTotalCollectedCount("They_Have_Their_Trunks_On")) then
    Print("VTL_AlwaysSetup: Destroying action marker")
    DestroyEntity("TheyHaveTheirTrunksOswaldActionMarker")
  end
  if (projector ~= nil) then
    Print("VTL_AlwaysSetup: projector ~= nil")
    if (GetPrefabData(projector).ActivatedLevels == "VTL_Oasis.Transition2D") then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_AlwaysSetup called from the projector to Autotopia.")
      if (GetGlobal("EM2_EpisodeCheck") == 4) then
        SetGlobal("VTL_Oasis_Visit", 3)
        LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01b_Airlock")
      else
        LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01b_Airlock")
        AnimGBSequence("VTL_Oasis_madDocDoor_inert_01a", "open")
      end
      if (GetGlobal("VTL_Oasis_CraneDecision") == 1) then
        if (GetGlobal("VTL_Oasis_BlotlingsQuest_CantinaBuilt") ~= 0) then
          Enable("VTL_Oasis_PlaneTrigger_music_Cantina")
          ReplaceMusicStateOverride("VTL_Cantina")
        end
      end
      if (GetGlobal("VTL_Oasis_SkullDropped") == 0) then
        AnimGBSequence("VTL_Oasis_fallingObject_inert_02a", "rest")
      else
        ActivateNavMeshObstacle("VTL_Oasis_fallingObject_inert_02a", false)
      end
      if (GetGlobal("VTL_Oasis_HutDropped") == 0) then
        AnimGBSequence("VTL_Oasis_fallingHut_inert_01a", "Off")
      else
        ActivateNavMeshObstacle("VTL_Oasis_fallingHut_inert_01a", false)
      end
      WaitForLevelLoad()
      MusicPostEventOn("VTL_Oasis_Sound_Marker_music_cantina", "Play_MX_VTL_Expan")
      Print("Started VTL Expan music event from VTL_Oasis_FromAutotopia")
      SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Expansion")
      VTL_Oasis_Checkpoint(nil, "constructiontop")
    else
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_AlwaysSetup called from the projector in the Main Area.")
      SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Main")
      VTL_Oasis_Setup(projector)
      local global = GetGlobal("VTL_Oasis_Checkpoint_ZoneMapLoad")
      if (0 < global) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_AlwaysSetup called from the save checkpoint in the Expansion Area.")
        SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Expansion")
        if (global == 1) then
          LevelManager_SetCurrentState("vtl_oasis.Main")
        elseif (GetGlobal("EM2_EpisodeCheck") == 3) then
          LevelManager_SetCurrentState("vtl_oasis.Expansion_MainStory")
        else
          LevelManager_SetCurrentState("vtl_oasis.Expansion_Epilogue")
        end
        LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01b_Airlock")
        if (GetGlobal("VTL_AudioDirection") == 1) then
          AudioPostEventOn("vtl_oasis_01b_audio.pointsource_zone01c", "Play_sfx_vtl_zone01c_ambiance")
          MultiPosSoundStart("vtl_oasis_01c_audio.largeFalls_01c_control")
        elseif (GetGlobal("VTL_AudioDirection") == 2) then
          AudioPostEventOn("vtl_oasis_01b_audio.pointsource_expansion_amb", "Play_sfx_vtl_expansion_ambiance")
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_AlwaysSetup called from the save checkpoint in the Main Area.")
          SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Main")
          LevelManager_SetCurrentState("vtl_oasis.Main_MainStory")
          if (GetGlobal("EM2_EpisodeCheck") < 4) then
            LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01a_AI_MainStory")
          else
            LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01a_AI_Epilogue")
          end
          if (GetGlobal("EM2_TrainRide") == 0) then
            VTL_Oasis_Setup(projector)
          end
        end
      else
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_AlwaysSetup called from the save checkpoint in the Main Area.")
        SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Main")
        LevelManager_SetCurrentState("vtl_oasis.Main_MainStory")
        if (GetGlobal("EM2_EpisodeCheck") < 4) then
          LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01a_AI_MainStory")
        else
          LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01a_AI_Epilogue")
        end
        if (GetGlobal("EM2_TrainRide") == 0) then
          VTL_Oasis_Setup(projector)
        end
      end
      WaitForLevelLoad()
    end
  else
    local global = GetGlobal("VTL_Oasis_Checkpoint_ZoneMapLoad")
    if (0 < global) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_AlwaysSetup called from the save checkpoint in the Expansion Area.")
      SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Expansion")
      if (global == 1) then
        LevelManager_SetCurrentState("vtl_oasis.Main")
      elseif (GetGlobal("EM2_EpisodeCheck") == 3) then
        LevelManager_SetCurrentState("vtl_oasis.Expansion_MainStory")
      else
        LevelManager_SetCurrentState("vtl_oasis.Expansion_Epilogue")
      end
      LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01b_Airlock")
      if (GetGlobal("VTL_AudioDirection") == 1) then
        AudioPostEventOn("vtl_oasis_01b_audio.pointsource_zone01c", "Play_sfx_vtl_zone01c_ambiance")
        MultiPosSoundStart("vtl_oasis_01c_audio.largeFalls_01c_control")
      elseif (GetGlobal("VTL_AudioDirection") == 2) then
        AudioPostEventOn("vtl_oasis_01b_audio.pointsource_expansion_amb", "Play_sfx_vtl_expansion_ambiance")
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_AlwaysSetup called from the save checkpoint in the Main Area.")
        SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Main")
        LevelManager_SetCurrentState("vtl_oasis.Main_MainStory")
        if (GetGlobal("EM2_EpisodeCheck") < 4) then
          LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01a_AI_MainStory")
        else
          LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01a_AI_Epilogue")
        end
        if (GetGlobal("EM2_TrainRide") == 0) then
          VTL_Oasis_Setup(projector)
        end
      end
    else
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_AlwaysSetup called from the save checkpoint in the Main Area.")
      SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Main")
      LevelManager_SetCurrentState("vtl_oasis.Main_MainStory")
      if (GetGlobal("EM2_EpisodeCheck") < 4) then
        LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01a_AI_MainStory")
      else
        LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01a_AI_Epilogue")
      end
      if (GetGlobal("EM2_TrainRide") == 0) then
        VTL_Oasis_Setup(projector)
      end
    end
    WaitForLevelLoad()
  end
  if IsValidHandle("vtl_oasis_01c_epilogue.prefab_jumpvolumeavailability 01") then
    enableJumpVolumeAvailability("vtl_oasis_01c_epilogue.prefab_jumpvolumeavailability 01.TargetToSend")
  end
  if IsValidHandle("VTL_Oasis_jcBridge_inert_02a") then
    VTL_Oasis_ExitFunction_TikiSamsShopToJCRide_StartBoat()
    ForEachEntityInGroup(Disable, "BoatStartTrigger")
    if (GetGlobal("VTL_Oasis_JCBridge1KnockedDown") == 1) then
      ActivateNavMeshObstacle("VTL_Oasis_jcBridge_inert_01a", false)
    end
    if (GetGlobal("VTL_Oasis_JCBridge2KnockedDown") == 1) then
      ActivateNavMeshObstacle("VTL_Oasis_jcBridge_inert_02a", false)
    end
  end
  if IsValidHandle("DaisyHouseGusHint") then
    if (GetGlobal("VTL_Oasis_Daisy_Greeting_Played") == 1) then
      DestroyEntity("DaisyHouseGusHint")
    end
  end
  if IsValidHandle("VTL_TrainConductor") then
    if (GetGlobal("VTL_TrainStationIntro_Set") == 3) then
      DestroyEntity("VTL_TrainConductor")
    end
  end
  if (2 < GetGlobal("VTL_Oasis_Visit")) then
    if IsValidHandle("PeteHut_Glass") then
      DestroyEntity("PeteHut_Glass")
    end
  end
  return 
end
VTL_Oasis_DestroyTrainStation = function()
  SetGlobal("VTL_TrainStationIntro_Set", 3)
  return 
end
VTL_Oasis_Setup = function(projector)
  Print("Enter function: VTL_Oasis_Setup")
  StartFadeOut(0)
  Wait(0)
  if (GetGlobal("VTL_Oasis_Visit") ~= 3) then
    local episode = GetGlobal("EM2_EpisodeCheck")
    if (episode == 1) then
      if (GetGlobal("VTL_Oasis_OpeningMoviePlayed") == 0) then
        if (GetGlobal("EM2_TrainRide") ~= 1) then
          if (projector ~= nil) then
            Prefab_Projector_SetOnlySideCamera("2D_FromMeanStreetNorth", "noSCUPM")
          else
            TeleportToEntity(GetPlayer(), "VTL_Oasis_PositionMarker_MainAreaCheckpoint")
            TeleportToEntity(GetPlayer2OrAI(), "VTL_Oasis_PositionMarker_MainAreaCheckpoint_Oswald")
          end
        end
        PlayMovie(GetPlayer(), "PH_3_2_Daisy_in_VTL.bik")
        GiveCollectibleNoPopup("Film_PH3_2")
        SetGlobal("VTL_Oasis_OpeningMoviePlayed", 1)
        Quest_SetCriticalPath("Critical_Ventureland", "Critical_Ventureland_1")
        if (GetGlobal("VTL_TrainStationIntro_Set") == 0) then
          GetPrefabData("TrainStationExplosion").EpisodeCheck[reg_17] = 3
        end
      elseif (projector ~= nil) then
        GetPrefabData("2D_FromMeanStreetNorth").SkipJumpOutAnim = false
      end
      AnimGBSequence("vtl_oasis_01a_scripting.waterwheelPlatform_inert_01a", "broken")
      SetPropertyFloat("vtl_oasis_01a_scripting.Marker(Usable)_waterwheelPlatform_inert_01a", "UsableRadius", 7)
      SetGlobal("EM2_EpisodeCheck", 3)
      SetGlobal("VTL_Oasis_Visit", 2)
    end
    if (episode == 2) then
      AnimGBSequence("vtl_oasis_01a_scripting.waterwheelPlatform_inert_01a", "on")
      StopEmitters("VTL_Oasis_waterwheelPlatformSplash_01a")
      SetPropertyFloat("vtl_oasis_01a_scripting.Marker(Usable)_waterwheelPlatform_inert_01a", "UsableRadius", 0)
      SetGlobal("VTL_Oasis_Visit", 1)
    elseif (episode == 4) then
      SetGlobal("VTL_Oasis_Visit", 3)
    end
  end
  VTL_Oasis_GremlinLiftRepair()
  VTL_Oasis_GremlinClearJCDebris()
  if (GetGlobal("VTL_Oasis_JungleCruiseFastPass") ~= -1) then
    Print("function VTL_Oasis_Setup: vtl_oasis_01a_ai_mainstory.HappySmee_Exterior hidden!")
    Hide("vtl_oasis_01a_ai_mainstory.HappySmee_Exterior")
    SetGlobal("VTL_Oasis_SmeeDestroyed", 1)
  end
  if (Quest_CheckStatus("A_Captains_Life_for_Me", "A_Captains_Life_for_Me_4b", Quest_Completed) == true) then
    if (GetGlobal("EM2_EpisodeCheck") == 4) then
      Print("function VTL_Oasis_ExitInterior: vtl_oasis_01a_ai_epilogue.PirateMelee_DamienSalt hidden!")
      Hide("vtl_oasis_01a_ai_epilogue.PirateMelee_DamienSalt")
      SetGlobal("VTL_Oasis_DamienSaltDestroyed", 1)
    end
  end
  if (Quest_CheckStatus("A_Captains_Life_for_Me", "A_Captains_Life_for_Me_4a", Quest_Completed) == true) then
    DestroyEntity("vtl_oasis_01a_ai_epilogue.PirateRanged_v2_BelugaBilly")
  end
  if (GetGlobal("VTL_Oasis_Robinson_Freed_Played") == 1) then
    Unhide("VTL_Oasis_Gremlin_Variant4_Robinson_Main")
  end
  if (GetGlobal("MSS_HoraceQuest_Assistant") == 2) then
    AnimVarInt("VTL_Oasis_PirateMelee_v2_BarnacleJones", VAR_Mood_Type, 1)
    Hide("VTL_Oasis_PirateMelee_v2_BarnacleJones")
  end
  if (GetGlobal("MSS_HoraceQuest_Assistant") == 2) then
    Hide("VTL_Oasis_PirateRanged_ScurvyPat")
  end
  VTL_Oasis_Checkpoint(nil, "main")
  MusicPostEventOn(GetPlayer(), "Play_MX_VTL_Main")
  DoStinger("Stinger_Unique1", 10)
  SetCombatIntensityBias(-100)
  Print("Started VTL Main music event and disabled combat music")
  if (GetGlobal("EM2_TrainRide") == 1) then
    ShowHud()
    UnrestrictCutSceneInput()
    FireSequence("SpiritConversationMarker", "Gen_Spirit_TrainVentureland")
  end
  StartFadeIn(1)
  FireThread(VTL_Oasis_CheckForCraneStage2)
  if (GetGlobal("VTL_TrainStationIntro_Set") == 0) then
    SetGlobal("VTL_TrainStationIntro_Set", 1)
  end
  FireUser2("TrainStationExplosion")
  return 
end
VTL_Oasis_CheckForCraneStage2 = function()
  if (4 <= GetGlobal("EM2_EpisodeCheck")) then
    if (Quest_CheckStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_1a", Quest_Completed) == true) then
      if (Quest_CheckStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_2a", Quest_Discovered) ~= true) then
        if (Quest_CheckStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_2a", Quest_Completed) ~= true) then
          if (GetGlobal("VTL_Oasis_BlotlingsQuest_State") == 1) then
            Quest_SetStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_2a", Quest_Discovered, true)
            Quest_SetStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_1b", Quest_Unavailable, false)
            Quest_SetStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_2b", Quest_Unavailable, false)
          end
        end
      end
    end
  end
  if (4 <= GetGlobal("EM2_EpisodeCheck")) then
    if (Quest_CheckStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_2b", Quest_Discovered) ~= true) then
      if (Quest_CheckStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_2b", Quest_Completed) ~= true) then
        if (GetGlobal("VTL_Oasis_BlotlingsQuest_State") == 2) then
          Quest_SetStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_2b", Quest_Discovered, true)
          Quest_SetStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_1a", Quest_Unavailable, false)
          Quest_SetStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_2a", Quest_Unavailable, false)
        end
      end
    end
  end
  return 
end
VTL_Oasis_Setup_JungleCruiseRideArea = function()
  if (GetGlobal("VTL_Oasis_JCBridge1KnockedDown") == 0) then
    AnimGBSequence("VTL_Oasis_jcBridge_inert_01a", "rest")
  else
    ActivateNavMeshObstacle("VTL_Oasis_jcBridge_inert_01a", false)
  end
  if (GetGlobal("VTL_Oasis_JCBridge2KnockedDown") == 0) then
    AnimGBSequence("VTL_Oasis_jcBridge_inert_02a", "rest")
  else
    ActivateNavMeshObstacle("VTL_Oasis_jcBridge_inert_02a", false)
  end
  return 
end
VTL_Oasis_Setup_ExpansionArea_MainStory = function(target, area)
  Print((("Entered function: VTL_Oasis_Setup_ExpansionArea_MainStory(" .. area) .. ")"))
  if (GetGlobal("EM2_EpisodeCheck") < 4) then
    VTL_Oasis_Checkpoint(nil, area)
  end
  return 
end
VTL_Oasis_Setup_ExpansionArea_Epilogue = function(target, area)
  Print((("Entered function: VTL_Oasis_Setup_ExpansionArea_Epilogue(" .. area) .. ")"))
  if (GetGlobal("EM2_EpisodeCheck") == 4) then
    VTL_Oasis_Checkpoint(nil, area)
  end
  return 
end
VTL_Oasis_Checkpoint = function(target, area, waitForApprentice)
  Print(("__Function: VTL_Oasis_Checkpoint, area: " .. tostring(area)))
  if (waitForApprentice == "true") then
    Wait(0.10000000149011612)
  end
  if (area == "main") then
    SetGlobal("VTL_Oasis_Checkpoint_ZoneMapLoad", 0)
    Print("VTL_Oasis_Checkpoint_ZoneMapLoad set to 0")
    SaveCheckpoint(GetPlayer(), "VTL_AlwaysSetup", "VTL_Oasis_PositionMarker_MainAreaCheckpoint", "VTL_Oasis_PositionMarker_MainAreaCheckpoint_Oswald")
  elseif (area == "expansiontop") then
    SetGlobal("VTL_Oasis_Checkpoint_ZoneMapLoad", 1)
    Print("VTL_Oasis_Checkpoint_ZoneMapLoad set to 1")
    SaveCheckpoint(GetPlayer(), "VTL_AlwaysSetup", "VTL_Oasis_PositionMarker_ExpansionAreaTopCheckpoint", "VTL_Oasis_PositionMarker_ExpansionAreaTopCheckpoint_Oswald")
  elseif (area == "expansionbottom") then
    SetGlobal("VTL_Oasis_Checkpoint_ZoneMapLoad", 1)
    Print("VTL_Oasis_Checkpoint_ZoneMapLoad set to 1")
    SaveCheckpoint(GetPlayer(), "VTL_AlwaysSetup", "VTL_Oasis_PositionMarker_ExpansionAreaBottomCheckpoint", "VTL_Oasis_PositionMarker_ExpansionAreaBottomCheckpoint_Oswald")
  elseif (area == "constructiontop") then
    SetGlobal("VTL_Oasis_Checkpoint_ZoneMapLoad", 2)
    Print("VTL_Oasis_Checkpoint_ZoneMapLoad set to 2")
    SaveCheckpoint(GetPlayer(), "VTL_AlwaysSetup", "VTL_Oasis_PositionMarker_ConstructionAreaTopCheckpoint", "VTL_Oasis_PositionMarker_ConstructionAreaTopCheckpoint_Oswald")
  elseif (area == "constructionbottom") then
    SetGlobal("VTL_Oasis_Checkpoint_ZoneMapLoad", 2)
    Print("VTL_Oasis_Checkpoint_ZoneMapLoad set to 2")
    SaveCheckpoint(GetPlayer(), "VTL_AlwaysSetup", "VTL_Oasis_PositionMarker_ConstructionAreaBottomCheckpoint", "VTL_Oasis_PositionMarker_ConstructionAreaBottomCheckpoint_Oswald")
  end
  return 
end
VTL_ConceptArt01_Save = function()
  VTL_Oasis_Checkpoint(nil, "expansiontop", "true")
  return 
end
VTL_ConceptArt02_Save = function()
  VTL_Oasis_Checkpoint(nil, "constructiontop", "true")
  return 
end
VTL_TikiTunnelConceptSave = function()
  SetGlobal("VTL_Oasis_Checkpoint_ZoneMapLoad", 0)
  Print("VTL_Oasis_Checkpoint_ZoneMapLoad set to 0")
  SaveCheckpoint(GetPlayer(), "VTL_AlwaysSetup", "VTL_Oasis_PositionMarker_MainAreaCheckpoint", "VTL_Oasis_PositionMarker_MainAreaCheckpoint_Oswald")
  return 
end
VTL_Cloth01_Save = function()
  VTL_Oasis_Checkpoint(nil, "main", "true")
  return 
end
VTL_Oasis_ReduceHiddenTicketAttractRadius = function(target)
  Print("Function VTL_Oasis_ReduceHiddenTicketAttractRadius entered")
  local childEntity = GetChildEntityByName(target, "ETicket_E_Parentable")
  childEntity = GetName(childEntity)
  Print(("Child Entity: " .. childEntity))
  SetPropertyBool(childEntity, "AutoAttracts", false)
  return 
end
VTL_Oasis_SmeeCutscene = function()
  RestrictCutSceneInput()
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  Prefab_EnterInterior_Ask("Interior_DaisysHouse", "Exit")
  UnrestrictCutSceneInput()
  return 
end
VTL_Oasis_FireSmeeDialog = function(target)
  Print("__Function: VTL_Oasis_FireSmeeDialog")
  Print("__Waiting for dialog to finish")
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  Print("__Firing Sequence!")
  ForceSequence("vtl_oasis_01a_ai_mainstory.HappySmee_Exterior", "VTL_Oasis_Smee_HookReturns")
  return 
end
VTL_Oasis_SetupPirateAnimStates = function()
  AnimVarInt("vtl_oasis_01a_ai_epilogue.PirateRanged_v2_BelugaBilly", VAR_Mood_Type, 1)
  AnimVarInt("vtl_oasis_01a_ai_epilogue.PirateRanged_v2_BelugaBilly", VAR_NPC_State, 4)
  AnimVarInt("vtl_oasis_01a_ai_epilogue.PirateMelee_DamienSalt", VAR_Mood_Type, 1)
  AnimVarInt("vtl_oasis_01a_ai_epilogue.PirateMelee_DamienSalt", VAR_NPC_State, 7)
  return 
end
local VTL_Oasis_MickeySide = 0
local VTL_Oasis_OswaldSide = 0
VTL_WaitForLevelLoad_True = function()
  WaitForLevelToLoad(true)
  return 
end
VTL_Oasis_Stream01a = function(player)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01a called!")
  local bIsOwaldAHuman = (not IsPlayerAIControlled(PLAYER_TWO))
  if (bIsOwaldAHuman == true) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01a finds Oswald is a player!")
    if (GetName(player) == GetName(GetPlayer())) then
      VTL_Oasis_MickeySide = "a"
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01a sets Mickey to sideA!")
      if (VTL_Oasis_OswaldSide == 0) then
        VTL_Oasis_OswaldSide = "c"
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01a finds Oswald is a player, was set to default value, so is still behind on SideC!")
      end
    else
      VTL_Oasis_OswaldSide = "a"
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01a sets player Oswald to sideA!")
      if (VTL_Oasis_MickeySide == 0) then
        VTL_Oasis_MickeySide = "c"
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01a finds Mickey was set to default value, so is still behind on SideC!")
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01a finds Oswald is AI, setting Mickey and AI Oswald to SideA!")
        VTL_Oasis_MickeySide = "a"
        VTL_Oasis_OswaldSide = "a"
      end
    end
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01a finds Oswald is AI, setting Mickey and AI Oswald to SideA!")
    VTL_Oasis_MickeySide = "a"
    VTL_Oasis_OswaldSide = "a"
  end
  if (VTL_Oasis_MickeySide == "a") then
    if (VTL_Oasis_OswaldSide == "a") then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01a finds Mickey and Oswald are both on SideA; streaming VTL_Oasis.Main!")
      LevelManager_SetCurrentState("VTL_Oasis.Main")
      OverrideSpawnTransform(PLAYER_ONE, GetPosition("VTL_Oasis_PositionMarker_ExpansionAreaTopCheckpoint"), GetFacing("VTL_Oasis_PositionMarker_ExpansionAreaTopCheckpoint"))
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("VTL_Oasis_PositionMarker_ExpansionAreaTopCheckpoint_Oswald"), GetFacing("VTL_Oasis_PositionMarker_ExpansionAreaTopCheckpoint_Oswald"))
    end
  end
  return 
end
VTL_Oasis_Stream01c = function(player)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01c called!")
  local bIsOwaldAHuman = (not IsPlayerAIControlled(PLAYER_TWO))
  if (bIsOwaldAHuman == true) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01c finds Oswald is a player!")
    if (GetName(player) == GetName(GetPlayer())) then
      VTL_Oasis_MickeySide = "c"
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01c sets Mickey to sideC!")
      if (VTL_Oasis_OswaldSide == 0) then
        VTL_Oasis_OswaldSide = "a"
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01a finds Oswald is a player! Oswald was set to default value, so is still behind on SideA!")
      end
    else
      VTL_Oasis_OswaldSide = "c"
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01c sets player Oswald to sideC!")
      if (VTL_Oasis_MickeySide == 0) then
        VTL_Oasis_MickeySide = "a"
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01a finds Mickey was set to default value, so is still behind on SideA!")
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01c finds Oswald is AI, setting Mickey and AI Oswald to SideC!")
        VTL_Oasis_MickeySide = "c"
        VTL_Oasis_OswaldSide = "c"
      end
    end
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01c finds Oswald is AI, setting Mickey and AI Oswald to SideC!")
    VTL_Oasis_MickeySide = "c"
    VTL_Oasis_OswaldSide = "c"
  end
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_Stream01c streaming into Expansion!")
  local visit_global = GetGlobal("VTL_Oasis_Visit")
  if (visit_global == 2) then
    LevelManager_SetCurrentState("VTL_Oasis.Expansion_MainStory")
  else
    LevelManager_SetCurrentState("VTL_Oasis.Expansion_Epilogue")
  end
  while true do
    if (not (LevelManager_HasStateFinishedStreaming() == false)) then
      break
    end
    Wait(0.10000000149011612)
  end
  while true do
    if (not (LevelManager_WaitingForStreamingSync() == false)) then
      break
    end
    Wait(0.05000000074505806)
  end
  if (visit_global ~= 2) then
    DestroyEntity("PeteHut_Glass")
  end
  if (GetGlobal("VTL_Oasis_SkullDropped") == 0) then
    AnimGBSequence("VTL_Oasis_fallingObject_inert_02a", "rest")
  else
    ActivateNavMeshObstacle("VTL_Oasis_fallingObject_inert_02a", false)
  end
  if (GetGlobal("VTL_Oasis_HutDropped") == 0) then
    AnimGBSequence("VTL_Oasis_fallingHut_inert_01a", "Off")
  else
    ActivateNavMeshObstacle("VTL_Oasis_fallingHut_inert_01a", false)
  end
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  return 
end
VTL_Oasis_DropHut = function(target)
  if (GetGlobal("VTL_Oasis_HutDropped") == 0) then
    SetGlobal("VTL_Oasis_HutDropped", 1)
    ActivateNavMeshObstacle("vtl_oasis_01c_art.fallingHut_inert_01a", false)
    AnimGBSequence("vtl_oasis_01c_art.fallingHut_inert_01a", "Fall")
    AudioPostEventOn(target, "Play_sfx_vtl_huts_creak")
    wait(0.8330000042915344)
    StartEmitters("vtl_oasis_01c_fx.VTL_hutSplash_01a 03")
    wait(4)
    StopEmitters("vtl_oasis_01c_fx.VTL_hutSplash_01a 03")
  end
  return 
end
VTL_Oasis_DropSkull = function(target)
  if (GetGlobal("VTL_Oasis_SkullDropped") == 0) then
    SetGlobal("VTL_Oasis_SkullDropped", 1)
    ActivateNavMeshObstacle("vtl_oasis_01c_art.fallingObject_inert_02a", false)
    AnimGBSequence("vtl_oasis_01c_art.fallingObject_inert_02a", "on")
    wait(2)
    StartEmitters("vtl_oasis_01c_fx.VTL_hutSplash_01a 04")
    wait(4)
    StopEmitters("vtl_oasis_01c_fx.VTL_hutSplash_01a 04")
  end
  return 
end
VTL_Oasis_SetGlobal = function(target, global, value)
  SetGlobal(global, tonumber(value))
  return 
end
local VTL_DaisyVisitedToggle = 0
VTL_Oasis_EnterFunction_DaisysHouse = function()
  OswaldOverrideFollowingDistance(GetPlayer2OrAI(), 1)
  AnimVarInt("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", VAR_Mood_Type, 1)
  AnimVarInt("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", VAR_NPC_State, 1)
  if (GetGlobal("VTL_Oasis_DaisyQuest_JackTurnIn") == 5) then
    Unhide("VTL_Oasis_StationaryPedestrianMaleGoat_JackKelly")
    AnimVarInt("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", VAR_Mood_Type, 0)
    ReplaceMusicStateOverride("VTL_IntTikiSam")
    Print("Playing generic music")
  else
    ReplaceMusicStateOverride("VTL_IntDaisy")
    Print("Playing Daisy music")
  end
  if (VTL_DaisyVisitedToggle == 0) then
    VTL_DaisyVisitedToggle = 1
  elseif (VTL_DaisyVisitedToggle == 1) then
    VTL_DaisyVisitedToggle = 2
  elseif (VTL_DaisyVisitedToggle == 2) then
    VTL_DaisyVisitedToggle = 0
  end
  if (GetGlobal("VTL_DaisyNewsRoom") < GetGlobal("EM2_EpisodeCheck")) then
    SetGlobal("VTL_DaisyNewsRoom", GetGlobal("EM2_EpisodeCheck"))
    VTL_DaisyVisitedToggle = 0
  end
  if (GetGlobal("EM2_EpisodeCheck") == 4) then
    if (VTL_DaisyVisitedToggle == 2) then
      ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oasis_Daisy_NewsNetwork_Rand")
    elseif (VTL_DaisyVisitedToggle == 1) then
      ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oasis_Daisy_NewsNetwork_Ep4_2")
    else
      ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oasis_Daisy_NewsNetwork_Ep4_1")
      if (GetGlobal("EM2_EpisodeCheck") == 3) then
        if (VTL_DaisyVisitedToggle == 1) then
          VTL_DaisyVisitedToggle = 2
          ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oaisis_Daisy_NewsNetwork")
        else
          ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oasis_Daisy_NewsNetwork_Ep3")
          if (VTL_DaisyVisitedToggle == 1) then
            VTL_DaisyVisitedToggle = 2
            ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oaisis_Daisy_NewsNetwork")
          else
            ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oasis_Daisy_NewsNetwork_Ep1_2")
          end
        end
      elseif (VTL_DaisyVisitedToggle == 1) then
        VTL_DaisyVisitedToggle = 2
        ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oaisis_Daisy_NewsNetwork")
      else
        ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oasis_Daisy_NewsNetwork_Ep1_2")
      end
    end
  elseif (GetGlobal("EM2_EpisodeCheck") == 3) then
    if (VTL_DaisyVisitedToggle == 1) then
      VTL_DaisyVisitedToggle = 2
      ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oaisis_Daisy_NewsNetwork")
    else
      ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oasis_Daisy_NewsNetwork_Ep3")
      if (VTL_DaisyVisitedToggle == 1) then
        VTL_DaisyVisitedToggle = 2
        ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oaisis_Daisy_NewsNetwork")
      else
        ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oasis_Daisy_NewsNetwork_Ep1_2")
      end
    end
  elseif (VTL_DaisyVisitedToggle == 1) then
    VTL_DaisyVisitedToggle = 2
    ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oaisis_Daisy_NewsNetwork")
  else
    ForceSequence("vtl_oasis_01a_daisyshouse.AnimatronicDaisy_Interior", "VTL_Oasis_Daisy_NewsNetwork_Ep1_2")
  end
  Prefab_EnterInterior_FadeIn()
  return 
end
VTL_Oasis_EnterFunction_CaptainsQuarters = function()
  OswaldOverrideFollowingDistance(GetPlayer2OrAI(), 1)
  if (GetGlobal("VTL_Oasis_DamienSaltDestroyed") == 1) then
    Unhide("VTL_Oasis_StationaryPedestrianFemaleCow_Henrietta")
    AnimVarInt("VTL_Oasis_StationaryPedestrianFemaleCow_Henrietta", VAR_Mood_Type, 1)
    AnimVarInt("VTL_Oasis_StationaryPedestrianFemaleCow_Henrietta", VAR_NPC_State, 6)
    Unhide("VTL_Oasis_PirateMelee_DamienSalt_Interior")
    AnimVarInt("VTL_Oasis_PirateMelee_DamienSalt_Interior", VAR_Mood_Type, 1)
    AnimVarInt("VTL_Oasis_PirateMelee_DamienSalt_Interior", VAR_NPC_State, 8)
    Wait(2)
  else
    DestroyEntity("VTL_Oasis_PirateMelee_DamienSalt_Interior")
  end
  if (GetGlobal("VTL_Oasis_SmeeDestroyed") == 1) then
    if (GetGlobal("EM2_EpisodeCheck") < 4) then
      Unhide("vtl_oasis_01a_captainsquarters.HappySmee_Interior")
      AnimVarInt("vtl_oasis_01a_captainsquarters.HappySmee_Interior", VAR_Mood_Type, 1)
      if (GetGlobal("VTL_Oasis_JungleCruiseFastPass") ~= -1) then
        Print("Interior Smee in CaptainHat anim state")
        TeleportToEntity("vtl_oasis_01a_captainsquarters.HappySmee_Interior", "VTL_Oasis_PositionMarker_Smee_MirrorTeleport")
        AnimVarInt("vtl_oasis_01a_captainsquarters.HappySmee_Interior", VAR_NPC_State, 6)
      elseif (GetGlobal("VTL_Oasis_Smee_HookReturns_Played") == 1) then
        Print("Interior Smee in UnCharted anim state")
        AnimVarInt("vtl_oasis_01a_captainsquarters.HappySmee_Interior", VAR_NPC_State, 5)
      end
    end
  end
  if HasCollectible("Black_Pearl") then
    SetPropertyFloat("vtl_oasis_01a_captainsquarters.Marker(Usable)_captainsQuarters_inert_01a", "UsableRadius", 4)
  else
    SetPropertyFloat("vtl_oasis_01a_captainsquarters.Marker(Usable)_captainsQuarters_inert_01a", "UsableRadius", 0)
  end
  if (Quest_CheckStatus("A_Captains_Life_for_Me", "A_Captains_Life_for_Me_4a", Quest_Completed) == true) then
    Hide("VTL_Oasis_PirateRanged_TreasureGuard")
    Enable("VTL_Oasis_seq_openchest_TriggerBase")
  else
    AnimVarInt("VTL_Oasis_PirateRanged_TreasureGuard", VAR_Mood_Type, 1)
    AnimVarInt("VTL_Oasis_PirateRanged_TreasureGuard", VAR_NPC_State, 5)
  end
  ReplaceMusicStateOverride("VTL_IntCaptainsQ")
  Prefab_EnterInterior_FadeIn()
  wait(1)
  if (IsHidden("VTL_Oasis_PirateRanged_TreasureGuard") == true) then
    Enable("VTL_Oasis_seq_openchest_TriggerBase")
  end
  return 
end
VTL_Oasis_EnterFunction_CaptainsQuartersBackroom = function()
  Hide("VTL_Oasis_INT_captainQuarters_toonWall_01a")
  VTL_Oasis_EnterFunction_CaptainsQuarters()
  return 
end
VTL_Oasis_EnterFunction_SwissFamilyTreehouse = function()
  if (GetGlobal("VTL_Oasis_TelephoneBoxCount") == 15) then
    SetGlobal("VTL_Oasis_ThreePigsQuest_PigsMissingAgain", 1)
    SetGlobal("MSN_Quest_3Pigs_State", 3)
  end
  if (GetGlobal("OST_Center_PracticalPig_Rescued_Played") == 1) then
    Unhide("VTL_Oasis_PigPractical")
  end
  if (GetGlobal("MSN_Fifer_Intro_Played") == 1) then
    if (GetGlobal("VTL_Oasis_ThreePigsQuest_PigsMissingAgain") == 0) then
      Unhide("VTL_Oasis_PigFifer")
    end
  end
  if (GetGlobal("FTL_Gulch_Fiddler_Rescued_Played") == 1) then
    if (GetGlobal("VTL_Oasis_ThreePigsQuest_PigsMissingAgain") == 0) then
      Unhide("VTL_Oasis_PigFiddler")
    end
  end
  if (GetGlobal("FTL_Fifer_Rescued_Played") == 1) then
    if (GetGlobal("VTL_Oasis_ThreePigsQuest_PigsMissingAgain") == 1) then
      Unhide("VTL_Oasis_PigFifer")
    end
  end
  if (GetGlobal("OST_Center_FiddlerPig_Rescued_Played") == 1) then
    if (GetGlobal("VTL_Oasis_ThreePigsQuest_PigsMissingAgain") == 1) then
      Unhide("VTL_Oasis_PigFiddler")
    end
  end
  if (GetGlobal("MSN_Quest_3Pigs_State") == 0) then
    FireSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Gus_PigFamilyTreehouse", 1)
  end
  if (Quest_CheckStatus("Creative_Threedom", "Creative_Threedom_10a", Quest_Completed) == true) then
    Print("Creative_Threedom complete: Pratical Way")
    AnimVarInt("VTL_Oasis_PigFiddler", VAR_NPC_State, 4)
    SetPropertyFloat("VTL_Oasis_PigFiddler", "UsableRadius", 0)
    AnimVarInt("VTL_Oasis_PigFifer", VAR_NPC_State, 5)
    SetPropertyFloat("VTL_Oasis_PigFifer", "UsableRadius", 0)
    AnimVarInt("VTL_Oasis_PigPractical", VAR_NPC_State, 6)
    ReplaceMusicStateOverride("VTL_IntPigs")
    Print("Playing 3 little pigs music")
  elseif (Quest_CheckStatus("Creative_Threedom", "Creative_Threedom_6b", Quest_Completed) == true) then
    AnimVarInt("VTL_Oasis_PigFiddler", VAR_Mood_Type, 0)
    AnimVarInt("VTL_Oasis_PigFifer", VAR_Mood_Type, 0)
    AnimVarInt("VTL_Oasis_PigPractical", VAR_Mood_Type, 0)
    ForEachEntityInGroup(Hide, "PigFiddler_Instrument")
    Hide("PigFifer_Instrument")
    ReplaceMusicStateOverride("MSN_IntCinema")
    Print("Playing cinema music")
  else
    ForEachEntityInGroup(Hide, "PigFiddler_Instrument")
    Hide("PigFifer_Instrument")
    ReplaceMusicStateOverride("VTL_IntTikiSam")
    Print("Playing generic music - pigs are not here or not playing instruments")
  end
  Prefab_EnterInterior_FadeIn()
  return 
end
VTL_Oasis_GetPracticalPigAnimCheck = function()
  if (AnimVarIntGet("VTL_Oasis_PigPractical", VAR_NPC_State) == 6) then
    SetGlobal("VTL_Oasis_PracticalPig_PlayingPiano", 1)
  else
    SetGlobal("VTL_Oasis_PracticalPig_PlayingPiano", 0)
  end
  return 
end
VTL_Oasis_EnterFunction_TreeHouseTunnel = function(target)
  local targetname = tostring(GetName(target))
  if (targetname == "vtl_oasis_01a_shared.exitbuildingcamera_treeHouseTunnelSideB.Trigger_EnterInterior") then
    AudioPostEventOn(GetPlayer(), "Stop_MX_VTL_Expan")
    MusicPostEventOn(GetPlayer(), "Play_MX_VTL_Main")
    Print("stopped VTL Expan music, started VTL Main music")
    SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Main")
  else
    Print("entered Tree Tunnel from main, music event doesnt change")
    AudioPostEventOn("vtl_oasis_01a_audio.SND_Amb_Main_1", "Stop_sfx_amb_VL_Jungle")
  end
  ReplaceMusicStateOverride("VTL_IntTreehouse")
  Print("music - changed to VTL_IntTreehouse state")
  Wait(0.10000000149011612)
  if (GetGlobal("EM2_EpisodeCheck") == 2) then
    Unhide("VTL_Oasis_PetePan_TreeTunnel")
    Disable("VTL_Oasis.exitbuildingcamera_treeHouseTunnelSideB.Trigger_ExitInterior")
  end
  Prefab_EnterInterior_FadeIn()
  return 
end
VTL_Oasis_EnterFunction_TikiSamsShop = function(target)
  OswaldOverrideFollowingDistance(GetPlayer2OrAI(), 1)
  if (GetGlobal("VTL_Oasis_TikiSamsTunnelOpen") == 1) then
    AnimGBSequence("vtl_oasis_01a_tikisamsshop.INT_tikiShop_basementDoor_01a_inert 01", "open")
    AudioPostEventOn("vtl_oasis_01a_audio.Snd_TrapDoor", "Play_sfx_VTL_trapdoor_open")
  end
  local targetname = tostring(GetName(target))
  if (targetname == "vtl_oasis_01a_shared.exitbuildingcamera_tikiSamsShopSideB.Trigger_EnterInterior") then
    AudioPostEventOn(GetPlayer(), "Stop_MX_VTL_JCRide")
    MusicPostEventOn(GetPlayer(), "Play_MX_VTL_Main")
    Print("stopped JCRide music, started VTL Main music")
    SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Main")
  else
    Print("entered Tree Tunnel from main, music event doesnt change")
    AudioPostEventOn("vtl_oasis_01a_audio.SND_Amb_Main_1", "Stop_sfx_amb_VL_Jungle")
  end
  ReplaceMusicStateOverride("VTL_IntTikiSam")
  Prefab_EnterInterior_FadeIn()
  return 
end
VTL_Oasis_EnterFunction_TikiSamsTunnel = function(target)
  Print(("music - target is " .. tostring(GetName(target))))
  local targetname = tostring(GetName(target))
  if (targetname == "vtl_oasis_01a_shared.exitbuildingcamera_tikiSamsTunnelSideB.Trigger_EnterInterior") then
    AudioPostEventOn(GetPlayer(), "Stop_MX_VTL_JCRide")
    MusicPostEventOn(GetPlayer(), "Play_MX_VTL_Main")
    Print("stopped JCRide music, started VTL Main music")
    SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Main")
  else
    Print("entered Tiki Sams Tunnel from main, music event doesnt change")
  end
  ReplaceMusicStateOverride("VTL_IntTikiSam")
  Print("music - changed to VTL_IntTikiSam state")
  Prefab_EnterInterior_FadeIn()
  return 
end
VTL_Oasis_EnterFunction_SpatterHouse = function()
  ReplaceMusicStateOverride("VTL_IntTikiSam")
  Prefab_EnterInterior_FadeIn()
  return 
end
VTL_Oasis_EnterFunction_HookLibrary = function()
  ReplaceMusicStateOverride("VTL_IntCaptainsQ")
  Prefab_EnterInterior_FadeIn()
  return 
end
VTL_Oasis_ExitInterior = function(target)
  local targetname = tostring(GetName(target))
  OswaldClearOverrideFollowingDistance()
  if (GetGlobal("EM2_EpisodeCheck") <= 3) then
    LevelManager_SetCurrentState("VTL_Oasis.Main_MainStory")
    LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01a_AI_MainStory")
    WaitForLevelLoad()
  else
    LevelManager_SetCurrentState("VTL_Oasis.Main_MainStory")
    LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01a_AI_Epilogue")
    WaitForLevelLoad()
  end
  VTL_Oasis_GremlinLiftRepair()
  VTL_Oasis_GremlinClearJCDebris()
  if (GetGlobal("VTL_Oasis_JungleCruiseFastPass") ~= -1) then
    if (targetname ~= "vtl_oasis_01a_scripting.exitbuildingcamera_captainsQuarters.Trigger_ExitInterior") then
      Print("function VTL_Oasis_ExitInterior: vtl_oasis_01a_ai_mainstory.HappySmee_Exterior hidden!")
      Hide("vtl_oasis_01a_ai_mainstory.HappySmee_Exterior")
      SetGlobal("VTL_Oasis_SmeeDestroyed", 1)
    end
  end
  if (Quest_CheckStatus("A_Captains_Life_for_Me", "A_Captains_Life_for_Me_4b", Quest_Completed) == true) then
    if (GetGlobal("EM2_EpisodeCheck") == 4) then
      if (targetname ~= "vtl_oasis_01a_scripting.exitbuildingcamera_captainsQuarters.Trigger_ExitInterior") then
        Print("function VTL_Oasis_ExitInterior: vtl_oasis_01a_ai_epilogue.PirateMelee_DamienSalt hidden!")
        Hide("vtl_oasis_01a_ai_epilogue.PirateMelee_DamienSalt")
        SetGlobal("VTL_Oasis_DamienSaltDestroyed", 1)
      end
    end
  end
  if (Quest_CheckStatus("A_Captains_Life_for_Me", "A_Captains_Life_for_Me_4a", Quest_Completed) == true) then
    DestroyEntity("vtl_oasis_01a_ai_epilogue.PirateRanged_v2_BelugaBilly")
  end
  if (GetGlobal("VTL_Oasis_Robinson_Freed_Played") == 1) then
    Unhide("VTL_Oasis_Gremlin_Variant4_Robinson_Main")
  end
  if (GetGlobal("MSS_HoraceQuest_Assistant") == 2) then
    AnimVarInt("VTL_Oasis_PirateMelee_v2_BarnacleJones", VAR_Mood_Type, 1)
    Hide("VTL_Oasis_PirateMelee_v2_BarnacleJones")
  end
  if (GetGlobal("MSS_HoraceQuest_Assistant") == 2) then
    Hide("VTL_Oasis_PirateRanged_ScurvyPat")
  end
  RemoveAllMusicStateOverride()
  Print("Exited interior, removed all music state overrides")
  if (GetGlobal("VTL_Oasis_DaisyMadeHook") == 1) then
    SetGlobal("VTL_Oasis_DaisyMadeHook", 2)
    StimulusEntity(nil, ST_PAINT, 5000, GetPosition("vtl_oasis_01a_ai_mainstory.HappySmee_Exterior"), "vtl_oasis_01a_ai_mainstory.HappySmee_Exterior")
    wait(1)
    UseQuestItems("Hooks_Coat", 1)
    UseQuestItems("Hooks_Hook", 1)
    UseQuestItems("Hooks_Hat", 1)
    UseQuestItems("Hooks_Rapier", 1)
    Prefab_ExitInterior_FadeIn(nil, "Interior_DaisysHouse")
    Hide("VTL_Oasis_fakeHookUndressed_inert_01a")
    Unhide("vtl_oasis_01a_scripting.fakeHook_inert_01a")
    FireUser1("VTL_Oasis_grabcamerafancy_SurpriseSmee.FancyCameraLookAt01")
    Wait(0.5)
    TeleportToEntity(GetPlayer(), "VTL_Oasis_PositionMarker_MickeyTeleport_SpinHook")
    Wait(3)
    AnimEvent(GetPlayer(), EVENT_Start_SpinAttack)
    Wait(0.10000000149011612)
    AnimGBSequence("vtl_oasis_01a_scripting.fakeHook_inert_01a", "on", true)
    SetGlobal("VTL_Oasis_FakeHook_Complete", 1)
    return 
  else
    Prefab_ExitInterior_FadeIn()
  end
  if (GetGlobal("VTL_Oasis_Daisy_Greeting_Played") == 1) then
    if (GetGlobal("VTL_Oasis_DaisyMadeHook") == 0) then
      if (GetGlobal("VTL_Oasis_Visit") == 2) then
        if (GetGlobal("VTL_Gus_SmeeLines_Played") == 0) then
          FireSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Gus_SmeeLines")
          ActivateGremlinHint("VTL_Oasis_PlayerHintMarkers_Smee")
        end
      end
    end
  end
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  VTL_Oasis_Checkpoint(nil, "main")
  return 
end
VTL_Oasis_ExitInterior_01c = function(target)
  LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01b_Airlock")
  WaitForLevelLoad()
  local InteriorToStream = GetPrefabData(target).InteriorToStream
  if (InteriorToStream == "VTL_int_TreeHouseTunnel") then
    AudioPostEventOn(GetPlayer(), "Stop_MX_VTL_Main")
    MusicPostEventOn(GetPlayer(), "Play_MX_VTL_Expan")
    Print("entered expansion from tree tunnel via exit int 01c, stopped VTL main music event and started VTL expan music event")
  else
    Print("entered expansion from exit int 01c, but not via tree tunnel - music event stays the same")
  end
  if IsValidHandle("VTL_Oasis_JCBoat_inert_01a") then
    AnimGBSequence("VTL_Oasis_JCBoat_inert_01a", "on")
  end
  RemoveAllMusicStateOverride()
  Print("left interior, removed all music state overrides")
  Prefab_ExitInterior_FadeIn()
  if (InteriorToStream == "VTL_int_BlotlingHouse") then
    VTL_Oasis_Checkpoint(nil, "constructiontop")
  elseif (InteriorToStream == "VTL_int_VerticalHouse") then
    VTL_Oasis_Checkpoint(nil, "constructionbottom")
  else
    VTL_Oasis_Checkpoint(nil, "expansiontop")
  end
  return 
end
VTL_Oasis_ExitFunction_TikiSamsShopToJCRide = function()
  TeleportToEntity(GetPlayer(), GetRelativePrefabEntity("Interior_TikiSamsShop", ".ExitBuildingPosition"), true, true)
  TeleportToEntity(GetPlayer2OrAI(), GetRelativePrefabEntity("Interior_TikiSamsShop", ".ExitBuildingPosition_Player2"), true, true)
  LevelManager_SetCurrentState("VTL_Oasis.Main")
  LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01b_Airlock")
  WaitForLevelLoad()
  TeleportToEntity(GetPlayer(), GetRelativePrefabEntity("Interior_TikiSamsShopSideB", ".ExitBuildingPosition"), true, true)
  TeleportToEntity(GetPlayer2OrAI(), GetRelativePrefabEntity("Interior_TikiSamsShopSideB", ".ExitBuildingPosition_Player2"), true, true)
  OswaldOverrideFollowingDistance(GetPlayer2OrAI(), 2)
  if (GetGlobal("EM2_EpisodeCheck") < 4) then
    ActivateGremlinHint("VTL_Oasis_PlayerHintMarkers_BottomTunnel")
  end
  if (GetGlobal("VTL_Oasis_JCBridge1KnockedDown") == 0) then
    AnimGBSequence("VTL_Oasis_jcBridge_inert_01a", "rest")
  else
    ActivateNavMeshObstacle("VTL_Oasis_jcBridge_inert_01a", false)
  end
  if (GetGlobal("VTL_Oasis_JCBridge2KnockedDown") == 0) then
    AnimGBSequence("VTL_Oasis_jcBridge_inert_02a", "rest")
  else
    ActivateNavMeshObstacle("VTL_Oasis_jcBridge_inert_02a", false)
  end
  AudioPostEventOn(GetPlayer(), "Stop_MX_VTL_Main")
  JCRideMusicOn()
  RemoveAllMusicStateOverride()
  Print("Exited Tiki Sam shop to JCRide - stopped VTL Main music, started JCRide music")
  SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Expansion")
  Prefab_ExitInterior_FadeIn()
  VTL_Oasis_Checkpoint(nil, "expansionbottom")
  return 
end
VTL_Oasis_ExitFunction_TikiSamsShopToJCRide_StartBoat = function(target)
  Print("__Function: VTL_Oasis_ExitFunction_TikiSamsShopToJCRide_DelayBoatStart")
  AnimGBSequence("VTL_Oasis_JCBoat_inert_01a", "on")
  ForEachEntityInGroup(Disable, "BoatStartTrigger")
  return 
end
VTL_Oasis_ExitFunction_TreeHouseTunnelToJCRide = function()
  TeleportToEntity(GetPlayer(), GetRelativePrefabEntity("Interior_TreeHouseTunnelSideA", ".ExitBuildingPosition"), true, true)
  TeleportToEntity(GetPlayer2OrAI(), GetRelativePrefabEntity("Interior_TreeHouseTunnelSideA", ".ExitBuildingPosition_Player2"), true, true)
  LevelManager_SetCurrentState("VTL_Oasis.Main")
  LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01b_Airlock")
  WaitForLevelLoad()
  TeleportToEntity(GetPlayer(), GetRelativePrefabEntity("Interior_TreeHouseTunnelSideB", ".ExitBuildingPosition"), true, true)
  TeleportToEntity(GetPlayer2OrAI(), GetRelativePrefabEntity("Interior_TreeHouseTunnelSideB", ".ExitBuildingPosition_Player2"), true, true)
  OswaldOverrideFollowingDistance(GetPlayer2OrAI(), 2)
  if (GetGlobal("EM2_EpisodeCheck") < 4) then
    ActivateGremlinHint("VTL_Oasis_PlayerHintMarkers_TopTunnel")
  end
  if (GetGlobal("VTL_Oasis_JCBridge1KnockedDown") == 0) then
    AnimGBSequence("VTL_Oasis_jcBridge_inert_01a", "rest")
  else
    ActivateNavMeshObstacle("VTL_Oasis_jcBridge_inert_01a", false)
  end
  if (GetGlobal("VTL_Oasis_JCBridge2KnockedDown") == 0) then
    AnimGBSequence("VTL_Oasis_jcBridge_inert_02a", "rest")
  else
    ActivateNavMeshObstacle("VTL_Oasis_jcBridge_inert_02a", false)
  end
  AnimGBSequence("VTL_Oasis_JCBoat_inert_01a", "on")
  AudioPostEventOn(GetPlayer(), "Stop_MX_VTL_Main")
  MusicPostEventOn(GetPlayer(), "Play_MX_VTL_Expan")
  RemoveAllMusicStateOverride()
  Print("Stopped VTL Main music, started VTL Expan music, removed all music state overrides")
  SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Expansion")
  Prefab_ExitInterior_FadeIn()
  if (GetGlobal("VTL_Oasis_DaisyMadeHook") == 0) then
    if (GetGlobal("VTL_Oasis_GaveClothesToSmee") == 0) then
      if (GetGlobal("VTL_Oasis_TikiSamsTunnelOpen") == 0) then
        GiveCollectible("Challenge_MakeYourOwnWay_Tracker")
      end
    end
  end
  VTL_Oasis_Checkpoint(nil, "expansiontop")
  return 
end
VTL_Oasis_ExitFunction_TikiSamsTunnelToJCRide = function()
  TeleportToEntity(GetPlayer(), GetRelativePrefabEntity("Interior_TikiSamsTunnelSideA", ".ExitBuildingPosition"), true, true)
  TeleportToEntity(GetPlayer2OrAI(), GetRelativePrefabEntity("Interior_TikiSamsTunnelSideA", ".ExitBuildingPosition_Player2"), true, true)
  LevelManager_SetCurrentState("VTL_Oasis.Main")
  LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01b_Airlock")
  WaitForLevelLoad()
  TeleportToEntity(GetPlayer(), GetRelativePrefabEntity("Interior_TikiSamsTunnelSideB", ".ExitBuildingPosition"), true, true)
  TeleportToEntity(GetPlayer2OrAI(), GetRelativePrefabEntity("Interior_TikiSamsTunnelSideB", ".ExitBuildingPosition_Player2"), true, true)
  Print("__Following Distance Set")
  OswaldOverrideFollowingDistance(GetPlayer2OrAI(), 2)
  if (GetGlobal("EM2_EpisodeCheck") < 4) then
    ActivateGremlinHint("VTL_Oasis_PlayerHintMarkers_BottomTunnel")
  end
  if (GetGlobal("VTL_Oasis_JCBridge1KnockedDown") == 0) then
    AnimGBSequence("VTL_Oasis_jcBridge_inert_01a", "rest")
  else
    ActivateNavMeshObstacle("VTL_Oasis_jcBridge_inert_01a", false)
  end
  if (GetGlobal("VTL_Oasis_JCBridge2KnockedDown") == 0) then
    AnimGBSequence("VTL_Oasis_jcBridge_inert_02a", "rest")
  else
    ActivateNavMeshObstacle("VTL_Oasis_jcBridge_inert_02a", false)
  end
  Print("__Boat On")
  AnimGBSequence("VTL_Oasis_JCBoat_inert_01a", "on")
  Print("__Audio On")
  AudioPostEventOn(GetPlayer(), "Stop_MX_VTL_Main")
  JCRideMusicOn()
  RemoveAllMusicStateOverride()
  Print("Exited Tiki Sam tunnel to JCRide - stopped VTL Main music, started JCRide music")
  Print("__Map")
  SetActiveFullMap("vtl_oasis_01a_shared.MapVolume_VTL_Oasis_Expansion")
  Print("__Fade in")
  Prefab_ExitInterior_FadeIn()
  if (GetGlobal("VTL_Oasis_DaisyMadeHook") == 0) then
    if (GetGlobal("VTL_Oasis_GaveClothesToSmee") == 0) then
      if (GetGlobal("VTL_Oasis_TikiSamsTunnelOpen") == 0) then
        GiveCollectible("Challenge_MakeYourOwnWay_Tracker")
      end
    end
  end
  Print("__Checkpoint")
  VTL_Oasis_Checkpoint(nil, "expansionbottom")
  return 
end
VTL_Oasis_RideTrain = function()
  SetGlobal("EM2_TrainRide", 1)
  local VTL_Oasis_TrainDestination = GetGlobal("VTL_Oasis_TrainDestination")
  SetGlobal("VTL_Oasis_TrainDestination", 0)
  VTL_Oasis_Checkpoint(nil, "main")
  if (VTL_Oasis_TrainDestination == 2) then
    LoadLevel(GetPlayer(), "NOS_BogEasy.LouisShack_V2")
  elseif (VTL_Oasis_TrainDestination == 3) then
    if (GetGlobal("EM2_EpisodeCheck") == 1) then
      LoadLevel(GetPlayer(), "OST_Center.Main_Visit1")
    else
      LoadLevel(GetPlayer(), "OST_Center.Main_Visit2")
      if (VTL_Oasis_TrainDestination == 4) then
        LoadLevel(GetPlayer(), "MeanStreet_South.Visit1")
      end
    end
  elseif (VTL_Oasis_TrainDestination == 4) then
    LoadLevel(GetPlayer(), "MeanStreet_South.Visit1")
  end
  return 
end
VTL_Oasis_LeaveZone = function(target)
  SetGlobal("VTL_Oasis_Checkpoint_ZoneMapLoad", 0)
  SetupPosition(target)
  return 
end
VTL_Oasis_StreamAutotopia = function(projector)
  SetGlobal("Autotopia_HardLoad", 0)
  local data = GetPrefabData(projector)
  if (data.ExitFunction == "VTL_Oasis_StreamAutotopia") then
    Print("***VTL_Oasis_StreamAutotopia && ExitFunction == VTL_Oasis_StreamAutotopia")
    if (GetGlobal("EM2_EpisodeCheck") == 4) then
      LevelManager_SetCurrentState("VTL_Oasis.To_AutotopiaV2")
      GetPrefabData("toautotopia_Projector_Upper").ActivatedLevels = "TCY_autotopia_visit1.Main_Visit2"
    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
      if (-1 < GetGlobal("Autotopia_Core_Progression")) then
        LevelManager_SetCurrentState("VTL_Oasis.To_AutotopiaV1_Ex")
        GetPrefabData("toautotopia_Projector_Upper").ActivatedLevels = "TCY_autotopia_visit1.SectionA_first"
      end
    else
      LevelManager_SetCurrentState("VTL_Oasis.To_AutotopiaV1")
      if (data.ExitFunction == "AUT_ArriveFromVentureland") then
        Print("***VTL_Oasis_StreamAutotopia && ExitFunction == AUT_ArriveFromVentureland")
        if (GetGlobal("AUT_v1_AreaIntro_Played") == 1) then
          GetPrefabData(projector).ToFlyThrough = "False"
        end
        SetupPosition()
      end
    end
  elseif (data.ExitFunction == "AUT_ArriveFromVentureland") then
    Print("***VTL_Oasis_StreamAutotopia && ExitFunction == AUT_ArriveFromVentureland")
    if (GetGlobal("AUT_v1_AreaIntro_Played") == 1) then
      GetPrefabData(projector).ToFlyThrough = "False"
    end
    SetupPosition()
  end
  return 
end
VTL_Oasis_StreamAutotpiaEnterFunction = function(target)
  if (GetGlobal("EM2_EpisodeCheck") == 4) then
    GetPrefabData("toautotopia_Projector_Lower").State_Stream = "VTL_Oasis.To_AutotopiaV2"
  elseif (-1 < GetGlobal("Autotopia_Core_Progression")) then
    GetPrefabData("toautotopia_Projector_Lower").State_Stream = "VTL_Oasis.To_AutotopiaV1_Ex"
  end
  SetupPosition(target)
  return 
end
VTL_Oasis_CrowsNestState = function()
  Print("Enter function: VTL_Oasis_CrowsNestState")
  if (GetGlobal("VTL_Oasis_CrowsNestState") == 1) then
    Unhide("VTL_Oasis_crowsNest_inert_01a_Rubble")
    Hide("VTL_Oasis_crowsNest_inert_02a_HalfBuilt")
    Hide("VTL_Oasis_crowsNest_inert_03a_Complete")
  elseif (GetGlobal("VTL_Oasis_CrowsNestState") == 2) then
    Hide("VTL_Oasis_crowsNest_inert_01a_Rubble")
    Unhide("VTL_Oasis_crowsNest_inert_02a_HalfBuilt")
    Hide("VTL_Oasis_crowsNest_inert_03a_Complete")
  else
    Hide("VTL_Oasis_crowsNest_inert_01a_Rubble")
    Hide("VTL_Oasis_crowsNest_inert_02a_HalfBuilt")
    Unhide("VTL_Oasis_crowsNest_inert_03a_Complete")
  end
  return 
end
correctOrder = {1, 2, 3}
chargedOrder = {nil, nil, nil}
lightningRodCount = 0
VTL_Oasis_CrowsNestLift = function(target, event, loc_num)
  loc_num = tonumber(loc_num)
  for i = 1, 3 do
    if (chargedOrder[i] == loc_num) then
      return 
    end
  end
  local stopShockingLightningRod = function()
    wait(2)
    OswaldStreamAbort()
    return 
  end
  FireThread(stopShockingLightningRod)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    Unhide(("VTL_Oasis_GBL_lightningRodEnergizedFX_01a_0" .. loc_num))
    StartEmitters(("VTL_Oasis_GBL_lightningRodEnergizedFX_01a_0" .. loc_num))
    if (GetGlobal("VTL_Oasis_CrowsNestState") == 3) then
      lightningRodCount = (lightningRodCount + 1)
      Print(("lightningRodCount = " .. lightningRodCount))
      chargedOrder[lightningRodCount] = loc_num
      if (lightningRodCount == 3) then
        for stopShockingLightningRod = 1, 3 do
          j = "] = "
          Print(((("correctOrder[" .. stopShockingLightningRod) .. j) .. correctOrder[stopShockingLightningRod]))
          j = "] = "
          Print(((("chargedOrder[" .. stopShockingLightningRod) .. j) .. chargedOrder[stopShockingLightningRod]))
        end
        if (correctOrder[1] ~= chargedOrder[1]) then
          Print("chargedOrder is incorrect, try again!")
          AudioPostEventOn(GetPlayer(), "Play_sfx_dryfire_buzzer")
          ForEachEntityInGroup(StopEmitters, "VTL_Oasis_GBL_lightningRodEnergizedFX")
          Wait(1)
          ForEachEntityInGroup(Hide, "VTL_Oasis_GBL_lightningRodEnergizedFX")
          stopShockingLightningRod = 1
          SetVulnerability(target, ST_ELECTRIC, stopShockingLightningRod)
          lightningRodCount = 0
          stopShockingLightningRod = nil
          chargedOrder = {nil, nil, stopShockingLightningRod}
        end
        Print("chargedOrder correct, reward revealed!")
        AnimGBSequence("VTL_Oasis_crowsNest_inert_03a_Complete", "up")
        ForEachEntityInGroup(Disable, "VTL_Oasis_hiddenoswald_action_shocklightningrod_Marker_BuddyAIAction")
        Enable("VTL_Oasis_seq_openchest_crowsNest_TriggerBase_01")
        DoStinger("Stinger_Indy", 5)
      end
    end
  end
  return 
end
VTL_Oasis_CrowsNestLift_EnableOswaldActionSpot = function(target, locationNum)
  if (GetGlobal("VTL_Oasis_CrowsNestFullyBuilt") == 1) then
    if (locationNum == "3") then
      if GetPropertyBool("VTL_Oasis_treeTransition_toon_01a", "Is Painted") then
        Disable(target)
      end
    else
      Enable(target)
    end
  end
  return 
end
VTL_Oasis_ChestDisplay_FakeHook_Sword = function()
  SetGlobal("VTL_Oasis_FakeHook_Count", (GetGlobal("VTL_Oasis_FakeHook_Count") - 1))
  Wait(2)
  if (GetGlobal("VTL_Oasis_Daisy_Greeting_Played") == 0) then
    ForceSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "Gus_FoundObject")
  else
    ForceSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_Gus_Hint01")
  end
  VTL_Oasis_Checkpoint(nil, "main")
  return 
end
VTL_Oasis_ChestDisplay_FakeHook_Hat = function()
  DestroyEntity("HookHatHintTrig")
  ClearCameraAttributesForPlayer("HookHatHintOverride", GetPlayer())
  ClearCameraAttributesForPlayer("HookHatHintOverride", GetPlayer2OrAI())
  SetGlobal("VTL_Oasis_FakeHook_Count", (GetGlobal("VTL_Oasis_FakeHook_Count") - 1))
  Wait(2)
  if (GetGlobal("VTL_Oasis_Daisy_Greeting_Played") == 0) then
    ForceSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "Gus_FoundObject")
  else
    ForceSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_Gus_Hint01")
  end
  VTL_Oasis_Checkpoint(nil, "main")
  return 
end
VTL_Oasis_ChestDisplay_FakeHook_Coat = function()
  SetGlobal("VTL_Oasis_FakeHook_Count", (GetGlobal("VTL_Oasis_FakeHook_Count") - 1))
  Wait(2)
  if (GetGlobal("VTL_Oasis_Daisy_Greeting_Played") == 0) then
    ForceSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "Gus_FoundObject")
  else
    ForceSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_Gus_Hint01")
  end
  VTL_Oasis_Checkpoint(nil, "main")
  return 
end
VTL_Oasis_ChestDisplay_FakeHook_Hook = function()
  DestroyEntity("VTL_HookCamTrig")
  SetGlobal("VTL_Oasis_FakeHook_Count", (GetGlobal("VTL_Oasis_FakeHook_Count") - 1))
  Wait(1)
  ClearCameraAttributesForPlayer("VTL_HookCamOverride", GetPlayer())
  ClearCameraAttributesForPlayer("VTL_HookCamOverride", GetPlayer2OrAI())
  Wait(1)
  if (GetGlobal("VTL_Oasis_Daisy_Greeting_Played") == 0) then
    ForceSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "Gus_FoundObject")
  else
    ForceSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_Gus_Hint01")
  end
  VTL_Oasis_Checkpoint(nil, "main")
  return 
end
VTL_Oasis_ChestDisplay_HooksTreasureObtained = function()
  VTL_Oasis_Checkpoint(nil, "main")
  return 
end
VTL_Oasis_ChestDisplay_HooksMapObtained = function()
  VTL_Oasis_Checkpoint(nil, "main")
  return 
end
VTL_Oasis_RepairLift = function()
  if HasCollectible("Coconut_Gear") then
    AnimGBSequence("vtl_oasis_01a_scripting.waterwheelPlatform_inert_01a", "on")
    StopEmitters("VTL_Oasis_waterwheelPlatformSplash_01a")
    AudioPostEventOn(GetPlayer(), "Play_sfx_vtl_wtrwhlpltfrm_success")
    UseQuestItems("Coconut_Gear", 1)
    SetGlobal("VTL_Oasis_MissingLiftGear", 2)
    SetPropertyFloat("vtl_oasis_01a_scripting.Marker(Usable)_waterwheelPlatform_inert_01a", "UsableRadius", 0)
    FireSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_Gus_LiftRepaired", 1)
  elseif (GetGlobal("VTL_Oasis_MissingLiftGear") ~= 2) then
    FireSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_Gus_MissingGear", 1)
  end
  return 
end
VTL_LaunchCoconutGear = function()
  ForEachEntityInPrefab(Unhide, "VTL_Oasis_pickup_worlditem_GearLift_Item")
  wait(0.10000000149011612)
  Enable("VTL_Oasis_SplineFollower_GearToss")
  Print("VTL_LaunchCoconutGear : Launching Item")
  if (GetGlobal("VTL_Oasis_MissingLiftGear") ~= 2) then
    SetGlobal("VTL_Oasis_MissingLiftGear", 1)
  end
  wait(2.5)
  FireSequence("Global_Gus_HintMarker", "VTL_Oasis_Gus_GearObtained")
  return 
end
VTL_Oasis_GremlinLiftRepair = function()
  if (GetGlobal("VTL_Oasis_MissingLiftGear") == 2) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_GremlinLiftRepair sets up lift gizmo.")
    AnimGBSequence("vtl_oasis_01a_scripting.waterwheelPlatform_inert_01a", "on")
    StopEmitters("VTL_Oasis_waterwheelPlatformSplash_01a")
    SetPropertyFloat("vtl_oasis_01a_scripting.Marker(Usable)_waterwheelPlatform_inert_01a", "UsableRadius", 0)
  end
  return 
end
VTL_Oasis_GremlinClearJCDebris = function()
  if (GetGlobal("VTL_Oasis_TrainQuest_DebrisCleared") == 2) then
    DestroyEntity("VTL_Oasis_jungleCruiseDebris_inert_01a")
    ForEachEntityInGroup(DestroyEntity, "VTL_Oasis_ScrapMetal_JCDebris")
  end
  return 
end
VTL_Oasis_StartJungleBoatRide = function()
  AnimGBSequence("vtl_oasis_01a_scripting.JCBoat_inert_01a", "on")
  return 
end
bridgeSupportCount = 0
VTL_Oasis_LowerJCBridge = function(target)
  bridgeSupportCount = (bridgeSupportCount + 1)
  if (bridgeSupportCount == 2) then
    Disable("VTL_Oasis_hiddenoswald_action_boomerang02.Marker(BuddyAIAction) 01")
    AnimGBSequence(target, "down")
    ActivateNavMeshObstacle(target, false)
    SetGlobal("VTL_Oasis_JCBridge2KnockedDown", 1)
    Wait(1)
    Enable("Bridge_KnockbackTrigger")
    Wait(0.5)
    StartEmitters("VTL_Oasis_DustMedium_01a")
    Disable("Bridge_KnockbackTrigger")
  else
    Disable("VTL_Oasis_hiddenoswald_action_boomerang01.Marker(BuddyAIAction) 01")
    Wait(1)
    Enable("VTL_Oasis_hiddenoswald_action_boomerang02.Marker(BuddyAIAction) 01")
  end
  return 
end
VTL_Oasis_FallingHutGusWarning = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_THINNER) then
    FireSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_Gus_ThinnerWarning")
  end
  return 
end
VTL_Oasis_ReduceZoneHealth = function(target, amount)
  SetGlobal("VTL_QuestHealth", (GetGlobal("VTL_QuestHealth") - tonumber(amount)))
  return 
end
VTL_Oasis_PetePanFairyBlocker = function(target)
  Print("Enter function: VTL_Oasis_PetePanFairyPlayer")
  if (GetPropertyBool(_activator(), "Invisible") == false) then
    if (GetGlobal("VTL_Oasis_BribedPetePan") == 0) then
      TeleportToEntity("VTL_Oasis_SKH_fairyMagicSwirl_01b_PetePanFairyBlocker", target)
      SetParentEntity("VTL_Oasis_SKH_fairyMagicSwirl_01b_PetePanFairyBlocker", target)
      StartEmitters("VTL_Oasis_SKH_fairyMagicSwirl_01b_PetePanFairyBlocker")
      DisableMovementInput(target)
      IncrementAllAbilitiesDisabled(target)
      AnimEvent(target, EVENT_Special_6)
      ForceSequence("vtl_oasis_01a_ai.PetePan 01", "VTL_Oasis_PetePan_BeatIt", 1)
      Wait(2)
      StopEmitters("VTL_Oasis_SKH_fairyMagicSwirl_01b_PetePanFairyBlocker")
      ClearParent("VTL_Oasis_SKH_fairyMagicSwirl_01b_PetePanFairyBlocker")
      AnimEvent(target, EVENT_Stop_Knockback_InAir)
      AnimEvent(target, EVENT_Special_7)
      EnableMovementInput(target)
      DecrementAllAbilitiesDisabled(target)
    end
  end
  return 
end
VTL_Oasis_PetePanFairyBlocker_SetExternalVelocity = function(target)
  if (GetPropertyBool(_activator(), "Invisible") == false) then
    if (GetGlobal("VTL_Oasis_BribedPetePan") == 0) then
      SetExternalVelocity(target, vector4(1.5, 0, -12), 0.8999999761581421)
    end
  end
  return 
end
VTL_Oswald_Action = function(action)
  if (action == "Glide") then
    QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Wait_For_Attach, GetPosition("Bridge_KnockbackPositionMarker"))
    OswaldStartFollowAction()
  end
  return 
end
VTL_Oasis_ActivateConstructionGremlinHint = function(target)
  if (0 < GetGlobal("VTL_Oasis_CraneDecision")) then
    ActivateGremlinHint("VTL_Oasis_PlayerHintMarkers_MadDocDoor")
  else
    ActivateGremlinHint(target)
  end
  return 
end
VTL_Oasis_AnvilSketchTutorial = function(step)
  if (step == "one") then
    RestrictCutSceneInput()
    Wait(1)
    FireSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Gus_AnvilTutorial", 1)
  elseif (step == "two") then
    SetGlobal("EM2_AnvilSketch", 1)
    Wait(1)
    PlayMovie(GetPlayer(), "PH_Training_Anvil.bik")
    GiveCollectibleNoPopup("Film_PH_Anvil")
    UnrestrictCutSceneInput()
    if (GetGlobal("VTL_Oasis_GiantPearlPurchased") == 1) then
      Quest_SetStatus("A_Captains_Life_for_Me", "A_Captains_Life_for_Me_2", Quest_TurnIn, true)
      SetPropertyFloat("vtl_oasis_01a_scripting.Marker(Usable)_treasureDoor_inert_01a", "UsableRadius", 3)
      SetGlobal("VTL_Oasis_GiantPearlPurchased", 0)
    end
    VTL_Oasis_Checkpoint(nil, "main")
  end
  return 
end
VTL_Oasis_GiantPearlPurchased = function()
  SetGlobal("VTL_Oasis_GiantPearlPurchased", 1)
  ForEachEntityInPrefab(DestroyEntity, "vtl_oasis_01a_tikisamsshop.pickup_worlditem_BlackPearl.Item")
  return 
end
VTL_Oasis_AnvilDestroy_JCDebris = function()
  DestroyEntity("VTL_Oasis_jungleCruiseDebris_inert_01a")
  AudioPostEventOn(GetPlayer(), "Play_sfx_vtl_rubble_falling")
  for i = 1, 10 do
    ForceSpawn("vtl_oasis_01a_scripting.SpawnScrapMetalDebris", 1)
    wait(0.10000000149011612)
  end
  FireUser1("TrainStationExplosion")
  SetGlobal("VTL_Oasis_TrainQuest_DebrisCleared", 2)
  return 
end
VTL_Oasis_BreakJCDebris = function()
  SetHealth(_self(), 0)
  return 
end
VTL_OpenFinalExit_v1 = function()
  Quest_SetCriticalPath("Critical_Ventureland", "Critical_Ventureland_3")
  return 
end
VTL_Oasis_CrossingStreamsDestroy_Crane = function(target, event)
  Print("Function entered: VTL_Oasis_CrossingStreamsDestroy_Crane")
  if (GetGlobal("VTL_Oasis_CraneDecision") ~= 2) then
    if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
      SetGlobal("VTL_Oasis_CraneDecision", 2)
      if (GetGlobal("EM2_EpisodeCheck") < 4) then
        SetGlobal("VTL_Oasis_BlotlingsQuest_State", 2)
      end
      SetGlobal("VTL_QuestHealth", (GetGlobal("VTL_QuestHealth") - 20))
      DoStinger("Comment_Dest", 5)
      AnimGBSequence(target, "broke")
      AnimGBSequence("VTL_Oasis_steamShovel_inert_01a", "thin")
      AnimGBSequence("VTL_Oasis_madDocDoor_inert_01a", "explode")
      ForEachEntityInPrefab(DestroyEntity, "CraneElectricityMachine")
      ForEachEntityInPrefab(DestroyEntity, "CraneElectricShocker")
      SetPropertyBool("ToonGearElectricMachineHiddenOswald", "ActionSpotEnabled", false)
      ClearCameraAttributesForPlayer("CraneHintCamOverride", GetPlayer())
      ClearCameraAttributesForPlayer("CraneHintCamOverride", GetPlayer2OrAI())
      DestroyEntity("CraneHintCamTrig")
      enableJumpVolumeAvailability("vtl_oasis_01c_mainstory.prefab_jumpvolumeavailability 01.TargetToSend")
      enableJumpVolumeAvailability("vtl_oasis_01c_mainstory.prefab_jumpvolumeavailability 02.TargetToSend")
      OswaldStreamAbort()
      ActivateGremlinHint("VTL_Oasis_PlayerHintMarkers_MadDocDoor")
      ForEachEntityInGroup(StopEmitters, "VTL_Oasis_SparksSmoke_01a")
      StartEmitters("VTL_Oasis_steamShovelExplode_01a")
      Wait(2)
      DestroyEntity("VTL_Oasis_signDynamite_01a_inert")
      Wait(3)
      StopEmitters("VTL_Oasis_steamShovelExplode_01a")
      Wait(1)
      StartEmitters("VTL_Oasis_steamShovelImpactDust_01a")
      ForceSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_DestroyedCrane")
    end
  end
  return 
end
VTL_Oasis_RepairCrane = function()
  SetGlobal("VTL_Oasis_CraneDecision", 1)
  AnimGBSequence("VTL_Oasis_steamShovel_inert_01a", "paint")
  StopEmitters("VTL_Oasis_SparksSmoke_01a")
  SetGlobal("VTL_Oasis_BlotlingsQuest_State", 1)
  SetGlobal("VTL_QuestHealth", (GetGlobal("VTL_QuestHealth") + 20))
  ActivateGremlinHint("VTL_Oasis_PlayerHintMarkers_MadDocDoor")
  ClearCameraAttributesForPlayer("CraneHintCamOverride", GetPlayer())
  ClearCameraAttributesForPlayer("CraneHintCamOverride", GetPlayer2OrAI())
  DestroyEntity("CraneHintCamTrig")
  OswaldStreamAbort()
  SetPropertyBool("ToonGearElectricMachineHiddenOswald", "ActionSpotEnabled", false)
  FireUser3("CraneElectricShocker")
  ForceSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_RepairedCrane")
  wait(0.6000000238418579)
  Prefab_OswaldElectricSwitch_ChangeState("CraneElectricShocker", "FullyCharged")
  Wait(12.300000190734863)
  StartEmitters("VTL_Oasis_steamShovelImpactDust_01a")
  return 
end
VTL_Oasis_EndDoorAISpotCheck = function(target, direction)
  if (GetGlobal("VTL_Oasis_ExitDoorsReprogramGlobal") == 0) then
    if (GetGlobal("VTL_Oasis_BlotlingsQuest_State") ~= 2) then
      if (direction == "painted") then
        SetPropertyBool(target, "ActionSpotEnabled", true)
      elseif (direction == "sketched") then
        SetPropertyBool(target, "ActionSpotEnabled", false)
      elseif (direction == "reprogram") then
        AnimGBSequence(target, "open")
      end
    end
  end
  return 
end
VTL_Oasis_AwardHardHatAreaAchievement = function()
  GiveCollectible("Challenge_HardHatArea_Tracker")
  return 
end
VTL_Oasis_CranePersist = function()
  if (GetGlobal("VTL_Oasis_CraneDecision") == 2) then
    Print("Crane was Destroyed...so I am BURNING it ALL.")
    DestroyEntity("VTL_Oasis_signDynamite_01a_inert")
    DestroyEntity("CraneBase")
  end
  return 
end
VTL_Oasis_TikiHead_BlackPearlPlaced = function()
  SetGlobal("VTL_Oasis_BlackPearlObtained", 0)
  SetGlobal("VTL_Oasis_BlackPearlPlaced", 2)
  UseQuestItems("Black_Pearl", 1)
  Unhide("VTL_Oasis_blackPearl_01a_inert_tikihead")
  SetPropertyFloat("vtl_oasis_01a_scripting.Marker(Usable)_treasureDoor_inert_01a", "UsableRadius", 0)
  if (GetGlobal("VTL_Oasis_MirrorsPainted") == 3) then
    AnimGBSequence("vtl_oasis_01a_scripting.treasureDoor_inert_01a", "down")
    StartEmitters("VTL_Oasis_treasureDoorDust_01a")
    DoStinger("Stinger_Indy", 5)
  end
  Wait(0.10000000149011612)
  FireSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_Gus_TikiHead_BlackPearlPlaced", 0)
  return 
end
VTL_Oasis_TikiHead_BlackPearlQuestion = function()
  FireSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_Gus_TikiHead_BlackPearlQuestion", 1)
  return 
end
VTL_Oasis_MirrorPainted = function()
  SetGlobal("VTL_Oasis_MirrorsPainted", (GetGlobal("VTL_Oasis_MirrorsPainted") + 1))
  if (GetGlobal("VTL_Oasis_BlackPearlPlaced") == 2) then
    if (GetGlobal("VTL_Oasis_MirrorsPainted") == 3) then
      AnimGBSequence("vtl_oasis_01a_scripting.treasureDoor_inert_01a", "down")
      StartEmitters("VTL_Oasis_treasureDoorDust_01a")
      DoStinger("Stinger_Indy", 5)
    end
  end
  return 
end
VTL_Oasis_MirrorThinned = function()
  SetGlobal("VTL_Oasis_MirrorsPainted", (GetGlobal("VTL_Oasis_MirrorsPainted") - 1))
  return 
end
VTL_Oasis_CaptainsQuarters_BlackPearlPlaced = function()
  if (HasCollectible("Black_Pearl") == true) then
    SetGlobal("VTL_Oasis_BlackPearlObtained", 0)
    SetGlobal("VTL_Oasis_BlackPearlPlaced", 1)
    UseQuestItems("Black_Pearl", 1)
    Unhide("VTL_Oasis_blackPearl_01a_inert_captainsquarters")
    AudioPostEventOn(GetPlayer(), "Play_sfx_Pickup_MiniQuestItem")
    SetPropertyFloat("vtl_oasis_01a_captainsquarters.Marker(Usable)_captainsQuarters_inert_01a", "UsableRadius", 0)
    ForEachEntityInGroup(Hide, "HandLeverShells")
    ForEachEntityInGroup(Unhide, "HandLevers")
    ForEachEntityInGroup(SetPropertyBool, "HandLevers", "Look At Trigger Enabled", true)
    if GetPropertyBool("HandLever2Toon", "Is Painted") then
      SetPropertyBool("HandLever2", "Look At Trigger Enabled", false)
    end
    Wait(0.10000000149011612)
    FireSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_Gus_CaptainsQuarters_BlackPearlPlaced", 0)
  end
  return 
end
VTL_Oasis_CaptainsQuarters_BlackPearlQuestion = function()
  FireSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_Gus_CaptainsQuarters_BlackPearlQuestion", 1)
  return 
end
VTL_Oasis_LeverFlipped = function(target)
  if (GetPropertyInt(target, "Active Sequence ID") == 0) then
    SetGlobal("VTL_Oasis_LeversFlipped", (GetGlobal("VTL_Oasis_LeversFlipped") + 1))
    AnimGBSequence(target, "flip", true)
    if (GetGlobal("VTL_Oasis_LeversFlipped") == 3) then
      AnimGBSequence("vtl_oasis_01a_scripting.thinnerDam_inert_01a", "drain")
      AnimGBSequence("vtl_oasis_01a_scripting.thinner_01i", "drain")
      ForEachEntityInGroup(AnimGBSequence, "VTL_Oasis_BridgePlatforms", "drain")
      AudioPostEventOn("vtl_oasis_01a_audio.SND_event_drain_1", "Play_sfx_VTL_Evnt_Pool_Drained")
      Wait(3.5)
      DestroyEntity("vtl_oasis_01a_scripting.thinner_01i")
      ForEachEntityInGroup(AnimGBSequence, "VTL_Oasis_BridgePlatforms", "down")
      AnimGBSequence("vtl_oasis_01a_scripting.thinnerDam_inert_01a", "up")
      ForEachEntityInGroup(Disable, "VTL_Oasis_BridgePlatforms")
      FireSequence("vtl_oasis_01a_scripting.Marker(Conversation)_Gus", "VTL_Oasis_Gus_BelugaBillyQuest_Levers", 1)
    end
  end
  return 
end
VTL_Oasis_LeverLookAtTriggerEnabled = function(target, state)
  if (state == "thinned") then
    if (IsHidden(target) == false) then
      SetPropertyBool(target, "Look At Trigger Enabled", true)
    end
  elseif (state == "painted") then
    SetPropertyBool(target, "Look At Trigger Enabled", false)
  end
  return 
end
VTL_Oasis_BlotlingEnemies = function(target, state)
  Print("Entered function: VTL_Oasis_BlotlingEnemies")
  if (state == "1") then
    SetGlobal("VTL_Oasis_BlotlingRoundUp_BlotlingCount", (GetGlobal("VTL_Oasis_BlotlingRoundUp_BlotlingCount") - 1))
    Print("************************* VTL_Oasis_BlotlingRoundUp_BlotlingCount -1")
  elseif (state == "2") then
    if (GetCurrentTeam(target) == 2) then
      Print("************************** VTL_Oasis_BlotlingEnemies:   GetCurrentTeam = 2")
      SetGlobal("VTL_Oasis_BlotlingRoundUp_BlotlingCount", (GetGlobal("VTL_Oasis_BlotlingRoundUp_BlotlingCount") + 1))
      SetGlobal("VTL_Oasis_BlotlingRoundUp_BlotlingsPainted", (GetGlobal("VTL_Oasis_BlotlingRoundUp_BlotlingsPainted") - 1))
    else
      Print("************************** VTL_Oasis_BlotlingEnemies:   GetCurrentTeam != 2")
      SetGlobal("VTL_Oasis_BlotlingRoundUp_BlotlingCount", (GetGlobal("VTL_Oasis_BlotlingRoundUp_BlotlingCount") - 1))
      SetGlobal("VTL_Oasis_BlotlingRoundUp_BlotlingsPainted", (GetGlobal("VTL_Oasis_BlotlingRoundUp_BlotlingsPainted") + 1))
    end
  end
  return 
end
VTL_Oasis_TakeCompassFromScurvyPat = function()
  SetGlobal("VTL_Oasis_CompassObtained", -1)
  GiveCollectible("Barnacle_Jones_Compass")
  return 
end
DEBUG_VTL_RadialMenuTeleport = function(target, zone)
  if (zone == "Zone_01b") then
    LevelManager_SetCurrentState("VTL_Oasis.Main")
    LevelManager_SetZoneStatusActive("VTL_Oasis.Zone01b_Airlock")
    WaitForLevelLoad()
  end
  return 
end
VTL_Oasis_TEMP_OswaldTeleportThenAction = function(functionname, functionparameter1, positionmarker)
  if (positionmarker == nil) then
    OswaldTeleportToMickeyAction()
  else
    OswaldTeleportToLocationAction(positionmarker)
  end
  FireThread(_G[functionname], functionparameter1)
  return 
end
JCRideMusicOn = function()
  MultiPosSoundStart("vtl_oasis_01b_art.audio_Boats_mx_control")
  SetMusicEvent("JCBoatRideMusic")
  return 
end
VTL_Oasis_ScurvyPatGiveCompassCheck = function(target)
  Print(("VTL_Oasis_ScurvyPatGiveCompassCheck: the compass collectible value is: " .. tostring(GetTotalCollectedCount("Barnacle_Jones_Compass"))))
  if (GetTotalCollectedCount("Barnacle_Jones_Compass") == 0) then
    ForEachEntityInPrefab(Unhide, target)
    ClearParent(target)
  end
  return 
end
VTL_Oasis_ScurvyPatCompassSaveCheckpoint = function()
  SetGlobal("VTL_Oasis_CompassObtained", -1)
  VTL_Oasis_Checkpoint(nil, "main", "false")
  return 
end
VTL_Oasis_HideInEpisode4Check = function(target)
  if (4 <= GetGlobal("EM2_EpisodeCheck")) then
    Hide(target)
  end
  return 
end
VTL_Oasis_DisableBackDoor = function(target)
  local data = GetPrefabData(target)
  if (GetGlobal("EM2_EpisodeCheck") < 3) then
    data.StartsInactive = "True"
    SetPropertyFloat(target, "UsableRadius", 0)
  else
    SetPropertyFloat(target, "UsableRadius", 3)
    data.StartsInactive = "False"
  end
  return 
end
local VTL_Oasis_OsNearInkwell = 0
VTL_Oasis_OswaldinkwellFailsafe = function(player, state)
  if (state == "AI_OsNear") then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_OswaldinkwellFailsafe: Oswald Nears Inkwell!")
    VTL_Oasis_OsNearInkwell = 1
  elseif (state == "AI_OsLeave") then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_OswaldinkwellFailsafe: Oswald Leaves Inkwell!")
    VTL_Oasis_OsNearInkwell = 0
  elseif (state == "InkWellUsed") then
    if (GetName(player) == GetName(GetPlayer())) then
      if (VTL_Oasis_OsNearInkwell == 0) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* VTL_Oasis_OswaldinkwellFailsafe is teleporting Oswald")
        OswaldTeleportToLocationAction("OswaldTeleport_PositionMarker 01")
      end
    end
  end
  return 
end
VTL_Oasis_ScurvyPatRandomizedPictureOp = function(target)
  Print("__Function: VTL_Oasis_ScurvyPatRandomizedPictureOp")
  Print(("VTL_Oasis_ScurvyPatGiveCompassCheck: the compass collectible value is: " .. tostring(GetTotalCollectedCount("Barnacle_Jones_Compass"))))
  if (GetTotalCollectedCount("Barnacle_Jones_Compass") == 1) then
    Print("__Already got compass, should never pull it out!")
    return 
  end
  local CompassPossibility = math.random(0, 100)
  if (CompassPossibility < 75) then
    Print("__Will pop out compass!")
    wait(0.5)
    AnimVarInt("VTL_Oasis_PirateRanged_ScurvyPat", VAR_NPC_State, 2)
    Enable("VTL_Oasis_Position Marker (Camera Ability)_ScurvyPatCompass")
    wait(10)
    AnimVarInt("VTL_Oasis_PirateRanged_ScurvyPat", VAR_NPC_State, 0)
    Disable("VTL_Oasis_Position Marker (Camera Ability)_ScurvyPatCompass")
    wait(3)
  else
    Disable("VTL_Oasis_Position Marker (Camera Ability)_ScurvyPatCompass")
    Print("__Won't play pop out compass!")
  end
  return 
end
VTL_Oasis_CheckScurvyPatAvailable = function(target)
  Print("__Function: VTL_Oasis_CheckScurvyPatAvailable")
  if (GetGlobal("VTL_Oasis_Jones_HoraceQuest_End_Played") == 1) then
    if (GetGlobal("VTL_Oasis_CompassObtained") == 0) then
      if (GetTotalCollectedCount("Barnacle_Jones_Compass") == 1) then
        if (HasCollectible("Barnacle_Jones_Compass") == false) then
          DestroyEntity(target)
        end
      end
    end
  end
  return 
end
VTL_Oasis_ResetBarnacleJonesGive = function(target)
  Print("__Function: VTL_Oasis_ResetBarnacleJonesGive")
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.20000000298023224)
  end
  SetGlobal("VTL_Oasis_Jones_HoraceQuest_End_Played", 0)
  return 
end
VTL_PracticalPig_ETicketSystemTimeCheck = function(target)
  Print("__Function: VTL_PracticalPig_ETicketSystemTimeCheck")
  local StoredYear = tonumber(string.sub(tostring(GetGlobal("VTL_SystemDate_Year")), 2, 3))
  local StoredMonth = tonumber(string.sub(tostring(GetGlobal("VTL_SystemDate_MonthDay")), 2, 3))
  local StoredDay = tonumber(string.sub(tostring(GetGlobal("VTL_SystemDate_MonthDay")), 4, 5))
  local StoredHour = tonumber(string.sub(tostring(GetGlobal("VTL_SystemDate_HourMinute")), 2, 3))
  local StoredMinute = tonumber(string.sub(tostring(GetGlobal("VTL_SystemDate_HourMinute")), 4, 5))
  Print(((((((((("__Stored Time is: " .. tostring(StoredHour)) .. ":") .. tostring(StoredMinute)) .. ", ") .. tostring(StoredMonth)) .. "/") .. tostring(StoredDay)) .. " - ") .. tostring(StoredYear)))
  local CurrentYear = tonumber(os.date("%y"))
  local CurrentMonth = tonumber(os.date("%m"))
  local CurrentDay = tonumber(os.date("%d"))
  local CurrentHour = tonumber(os.date("%H"))
  local CurrentMinute = tonumber(os.date("%M"))
  Print(((((((((("__Current Time is: " .. tostring(CurrentHour)) .. ":") .. tostring(CurrentMinute)) .. ", ") .. tostring(CurrentMonth)) .. "/") .. tostring(CurrentDay)) .. " - ") .. tostring(CurrentYear)))
  StoredYear = (StoredYear * 525960)
  StoredMonth = (StoredMonth * 43829)
  StoredDay = (StoredDay * 1440)
  StoredHour = (StoredHour * 60)
  CurrentYear = (CurrentYear * 525960)
  CurrentMonth = (CurrentMonth * 43829)
  CurrentDay = (CurrentDay * 1440)
  CurrentHour = (CurrentHour * 60)
  local TotalCurrentTime = ((((CurrentYear + CurrentMonth) + CurrentDay) + CurrentHour) + CurrentMinute)
  local TotalStoredTime = ((((StoredYear + StoredMonth) + StoredDay) + StoredHour) + StoredMinute)
  Print(("__TotalCurrentTime: " .. tostring(TotalCurrentTime)))
  Print(("__TotalStoredTime: " .. tostring(TotalStoredTime)))
  local TimePassed = (TotalCurrentTime - TotalStoredTime)
  Print(("__Time Passed (minutes): " .. tostring(TimePassed)))
  if (TimePassed < 0) then
    Print("__Someone cheated! value < 0, resetting current time and giving reward")
    SetGlobal("VTL_SystemDate_ShouldGiveETickets", 1)
    VTL_PracticalPig_GiveETicketsSystemTimeUpdate(nil)
  elseif (30 <= TimePassed) then
    Print("__Will Give E-Tickets!")
    SetGlobal("VTL_SystemDate_ShouldGiveETickets", 1)
  else
    Print("__Won't give E-Tickets!")
    SetGlobal("VTL_SystemDate_ShouldGiveETickets", 0)
  end
  return 
end
VTL_PracticalPig_GiveETicketsSystemTimeUpdate = function(target)
  Print("__Function: VTL_PracticalPig_GiveETicketsSystemTimeUpdate")
  local CurrentYear = tonumber(os.date("%y"))
  local CurrentMonth = tonumber(os.date("%m"))
  local CurrentDay = tonumber(os.date("%d"))
  local CurrentHour = tonumber(os.date("%H"))
  local CurrentMinute = tonumber(os.date("%M"))
  SetGlobal("VTL_SystemDate_Year", tonumber(tostring(("1" .. tostring(CurrentYear)))))
  SetGlobal("VTL_SystemDate_MonthDay", tonumber((("1" .. string.format("%02d", tostring(CurrentMonth))) .. string.format("%02d", tostring(CurrentDay)))))
  SetGlobal("VTL_SystemDate_HourMinute", tonumber((("1" .. string.format("%02d", tostring(CurrentHour))) .. string.format("%02d", tostring(CurrentMinute)))))
  return 
end
VTL_Audio_Direction = function(Target, Direction)
  if (Direction == "Forward") then
    SetGlobal("VTL_AudioDirection", 1)
  elseif (Direction == "Backward") then
    SetGlobal("VTL_AudioDirection", 2)
  end
  return 
end

