MST_South_Visit2SetupDebug = function()
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    SetGlobal("EM2_EpisodeCheck", 2)
    SetGlobal("MSS_VisitNumber", 2)
    SetGlobal("MSN_VisitNumber", 2)
    SetGlobal("MSS_IntroCutscene_Check", 1)
    SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") + 3))
    SetGlobal("MSS_GremlinStructure_Agency", 1)
    SetGlobal("MSS_WaltsOpened", 1)
    SetGlobal("OST_Gus_HackTraining_Start_Played", 1)
    Prefab_Activate_Doors("WaltsApartmentEnterTrigger", "open")
    SetMapMarkerVisible("WaltsApartmentEnterTrigger", true)
    Wait(0.10000000149011612)
  end
  return 
end
MSS_RunningSetup = 0
MSS_IntroCutsceneFade = 0
MSS_ForemanLocation = 0
MSS_AlwaysSetup = function()
  MSS_RunningSetup = 1
  StartFadeOut(0)
  if (LevelManager_GetCurrentState() == "meanstreet_south.visit2") then
    MST_South_Visit2SetupDebug()
  end
  SetGlobal("Util_ComingFromNorth", 0)
  Print("Set Util_ComingFromNorth to 0")
  MusicPostEventOn(GetPlayer(), "Play_MX_MSS")
  RemoveAllMusicStateOverride()
  SetCombatIntensityBias(0)
  Print("Started MSS music event, reset combatintensitybias")
  AudioPostEventOn("meanstreetsouth_fx.MST_southAgencyMachineDust_01a 01", "Play_sfx_MachineElectric_01")
  AudioPostEventOn("meanstreetsouth_audio.Sound_LiquidPool", "Play_sfx_ThinnerPoolMine")
  AudioPostEventOn("meanstreetsouth_audio.Sound_Fusebox", "Play_sfx_FuseboxLP")
  Print("Started MSS ambience sfx")
  ForEachEntityInGroup(Hide, "MeanStreetSouthHideGroup")
  if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3a", Quest_Completed) == true) then
    SetGlobal("MSS_HiddenFlowersBusy", -1)
    Unhide("FlowerBed_Mickey")
    Enable("meanstreetsouth_audio.PlaneTrigger_Music_Garden_Mickey")
    Disable("meanstreetsouth_audio.PlaneTrigger_Music_Garden_Oswald")
  elseif (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3b", Quest_Completed) == true) then
    SetGlobal("MSS_HiddenFlowersBusy", -1)
    Unhide("FlowerBed_Oswald")
    Disable("meanstreetsouth_audio.PlaneTrigger_Music_Garden_Mickey")
    Enable("meanstreetsouth_audio.PlaneTrigger_Music_Garden_Oswald")
  else
    Unhide("FlowerBed_Neutral")
    Disable("meanstreetsouth_audio.PlaneTrigger_Music_Garden_Mickey")
    Disable("meanstreetsouth_audio.PlaneTrigger_Music_Garden_Oswald")
  end
  if (GetGlobal("MSS_VisitNumber") == 2) then
    if (GetGlobal("MSS_VisitNumber") == 1) then
      SetGlobal("MSS_VisitNumber", 2)
    end
    if (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
      if (GetCurrentCount("BunnyChildren_MeanStreetsSouth") ~= 5) then
        StreamInterior(nil, "Visit3_AI")
        WaitForLevelLoad()
      end
    else
      if (0 < GetGlobal("Autotopia_Core_Progression")) then
        StreamInterior(nil, "Visit2")
      else
        StreamInterior(nil, "Visit4_AI")
      end
      WaitForLevelLoad()
    end
    if (GetGlobal("MSS_TrainRestored") == -2) then
      DestroyEntity("TrainConductor")
    end
    if (GetGlobal("MST_Jehosaphat_Offer_Played") == 1) then
      if (GetGlobal("MSN_IntroMoviePlayed") == 1) then
        ForEachEntityInGroup(Unhide, "FastTravelGroup1")
        SetMapMarkerVisible("BalloonMapMarker", true)
      end
    end
    if (GetGlobal("MSS_HoraceQuest_Assistant") == 3) then
      if (Quest_CheckStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_12b", Quest_Completed) == false) then
        SetMapMarkerVisible("ClothesMakeSpatterClarabelle", true)
      end
    end
    if (GetGlobal("MSS_GuardianPool_Pipes") == 3) then
      AnimGBSequence("MST_southThinnerStream_01a 01", "LoopNothing")
    end
    if (GetGlobal("MSS_Switch_RobotEntrance") == 2) then
      DestroyEntity("GremlinStructure_Pool_UtilidorCheckTrigger 01")
      Enable("meanstreetsouth_art.CanyonDoor")
    end
    TeleportToEntity("Seth", "SethMarker")
    SetPropertyFloat("Seth", "High LOD Range", 30)
    TeleportToEntity("meanstreetsouth_ai.Gremlin_Foreman", "PoolSummonMarker")
    MSS_ForemanLocation = 1
    SetGlobal("MSS_GremlinStructure_Active", 1)
    SetPropertyFloat("meanstreetsouth_ai.Gremlin_Foreman", "Tether Radius", 0.10000000149011612)
    SetPropertyFloat("meanstreetsouth_ai.Gremlin_Foreman", "Wander Radius", 0.10000000149011612)
    Enable("LuggageCheckTrigger")
  end
  if (GetGlobal("MSS_VisitNumber") == 1) then
    StreamInterior(nil, "Visit1_AI")
    WaitForLevelLoad()
  end
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    Unhide("meanstreetsouth_sham1.Sham_NewRide 01")
    if (GetGlobal("MSS_Gus_UndergroundIntro_Played") == 1) then
      FireUser1("CriticalFlowHint")
    end
    SetMapMarkerVisible("ProjectorToGulchLab", false)
    TeleportToEntity("JailEnterTrigger", "ExitBuildingJailPosition")
  elseif (GetGlobal("EM2_EpisodeCheck") == 2) then
    Unhide("GremlinStuffus")
    Unhide("meanstreetsouth_sham1.Sham_NewRide 02")
    if (GetGlobal("MSS_Gus_IntroEpisode2_Played") == 1) then
      FireUser1("CriticalFlowHint")
    end
    if (GetGlobal("MSS_Horace_ThinnedPat_Played") == 0) then
      if (Quest_CheckStatus("Horaces_Assistant_Assistance", "Horaces_Assistant_Assistance_6a", Quest_Completed) == false) then
        if (Quest_CheckStatus("Horaces_Assistant_Assistance", "Horaces_Assistant_Assistance_6b", Quest_Completed) == false) then
          SetMapMarkerVisible("HoraceAssistantHorace", true)
        end
      end
    end
    TeleportToEntity("JailEnterTrigger", "ExitBuildingJailPosition")
    if (not (not Quest_CheckStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_1", Quest_Discovered))) then
      if Quest_CheckStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_2", Quest_Undiscovered) then
        Quest_SetStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_2", Quest_Discovered, false)
        if (GetGlobal("EM2_EpisodeCheck") == 3) then
          Unhide("meanstreetsouth_sham1.Sham_NewRide 03")
          if (GetGlobal("MSS_Gus_IntroEpisode3_Played") == 1) then
            FireUser1("CriticalFlowHint")
          end
          TeleportToEntity("JailEnterTrigger", "ExitBuildingJailPosition")
          if (not (not Quest_CheckStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_1", Quest_Discovered))) then
            if Quest_CheckStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_3", Quest_Undiscovered) then
              Quest_SetStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_3", Quest_Discovered, false)
              if (GetGlobal("EM2_EpisodeCheck") == 4) then
                Unhide("meanstreetsouth_sham1.Sham_NewRide 03")
                DestroyEntity("GusHintUtilidor5")
                TeleportToEntity("JailEnterTriggerAlt", "ExitBuildingJailPosition")
                if IsValidHandle("ClockWind") then
                  DestroyEntity("ClockWind")
                  Disable("BuddyActionClockShock")
                  Disable("BuddyActionClockWait")
                  Disable("BuddyActionTrainToss2")
                  Disable("BuddyActionTrainToss1")
                  Disable("meanstreetsouth_scripting.prefab_glidetomidairvolume 01.TriggerBase 01")
                  Disable("ClockSetPatrolTrigger")
                  Disable("ClockFan")
                end
              end
            end
          end
        elseif (GetGlobal("EM2_EpisodeCheck") == 4) then
          Unhide("meanstreetsouth_sham1.Sham_NewRide 03")
          DestroyEntity("GusHintUtilidor5")
          TeleportToEntity("JailEnterTriggerAlt", "ExitBuildingJailPosition")
          if IsValidHandle("ClockWind") then
            DestroyEntity("ClockWind")
            Disable("BuddyActionClockShock")
            Disable("BuddyActionClockWait")
            Disable("BuddyActionTrainToss2")
            Disable("BuddyActionTrainToss1")
            Disable("meanstreetsouth_scripting.prefab_glidetomidairvolume 01.TriggerBase 01")
            Disable("ClockSetPatrolTrigger")
            Disable("ClockFan")
          end
        end
      end
    end
  elseif (GetGlobal("EM2_EpisodeCheck") == 3) then
    Unhide("meanstreetsouth_sham1.Sham_NewRide 03")
    if (GetGlobal("MSS_Gus_IntroEpisode3_Played") == 1) then
      FireUser1("CriticalFlowHint")
    end
    TeleportToEntity("JailEnterTrigger", "ExitBuildingJailPosition")
    if (not (not Quest_CheckStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_1", Quest_Discovered))) then
      if Quest_CheckStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_3", Quest_Undiscovered) then
        Quest_SetStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_3", Quest_Discovered, false)
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          Unhide("meanstreetsouth_sham1.Sham_NewRide 03")
          DestroyEntity("GusHintUtilidor5")
          TeleportToEntity("JailEnterTriggerAlt", "ExitBuildingJailPosition")
          if IsValidHandle("ClockWind") then
            DestroyEntity("ClockWind")
            Disable("BuddyActionClockShock")
            Disable("BuddyActionClockWait")
            Disable("BuddyActionTrainToss2")
            Disable("BuddyActionTrainToss1")
            Disable("meanstreetsouth_scripting.prefab_glidetomidairvolume 01.TriggerBase 01")
            Disable("ClockSetPatrolTrigger")
            Disable("ClockFan")
          end
        end
      end
    end
  elseif (GetGlobal("EM2_EpisodeCheck") == 4) then
    Unhide("meanstreetsouth_sham1.Sham_NewRide 03")
    DestroyEntity("GusHintUtilidor5")
    TeleportToEntity("JailEnterTriggerAlt", "ExitBuildingJailPosition")
    if IsValidHandle("ClockWind") then
      DestroyEntity("ClockWind")
      Disable("BuddyActionClockShock")
      Disable("BuddyActionClockWait")
      Disable("BuddyActionTrainToss2")
      Disable("BuddyActionTrainToss1")
      Disable("meanstreetsouth_scripting.prefab_glidetomidairvolume 01.TriggerBase 01")
      Disable("ClockSetPatrolTrigger")
      Disable("ClockFan")
    end
  end
  if (0 < GetGlobal("MSS_GremlinStructure_TownHall")) then
    if (GetGlobal("MSS_GremlinStructure_TownHall") == 1) then
      AnimGBSequence("meanstreetsouth_art.GremlinStructure_FireStation_Door 02", "open")
      SetPropertyFloat("meanstreetsouth_scripting.GremlinStructure_FireStation_DoorTrigger 02", "UsableRadius", 2)
      StartEmitters("meanstreetsouth_fx.MST_fireHouseSmoke_01a 01")
      ForEachEntityInGroup(StopEmitters, "GremlinFireSparksFX")
    else
      AnimGBSequence("meanstreetsouth_art.GremlinStructure_FireStation_Door 01", "open")
      StartEmitters("meanstreetsouth_fx.MST_fireHouseBroken_01a 01")
      Prefab_OswaldElectricSwitch_ChangeState("WaterTowerSwitch1", "Deactivate")
      Prefab_OswaldElectricSwitch_ChangeState("WaterTowerSwitch2", "Deactivate")
      MSS_WaterTowerPanel01 = 1
      MSS_WaterTowerPanel02 = 1
    end
  end
  if (0 < GetGlobal("MSS_GremlinStructure_GuardianPool")) then
    if (GetGlobal("MSS_GremlinStructure_GuardianPool") == 1) then
      Enable("meanstreetsouth_art.GremlinStructure_Pool_Trigger 01")
    else
      StartEmitters("RobotHeadSmokeFX2")
      Enable("meanstreetsouth_visit2.GremlinStructure_Pool_EntryTrigger 01")
      StartEmitters("RobotHeadSmokeFX1")
      ForEachEntityInGroup(StartEmitters, "RobotHeadSparksFX")
    end
  else
    StartEmitters("RobotHeadSmokeFX1")
    ForEachEntityInGroup(StartEmitters, "RobotHeadSparksFX")
  end
  if (0 < GetGlobal("MSS_GremlinStructure_Emporium")) then
    if (GetGlobal("MSS_GremlinStructure_Emporium") == 1) then
      Enable("meanstreetsouth_art.GremlinStructure_Emporium_Door")
      AnimGBSequence("GremlinStructure_Emporium_Arm", "loop")
      SetPropertyBool("GremlinStructure_Emporium_Arm", "Allow Standing", false)
      SetPropertyFloat("meanstreetsouth_visit2.GremlinStructure_Emporium_EntryTrigger 02", "UsableRadius", 2.5)
      ForEachEntityInGroup(StopEmitters, "GremlinEmporiumSparksFX")
    else
      AnimGBSequence("meanstreetsouth_art.GremlinStructure_Emporium_Platform", "break")
      enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 20.TargetToSend")
      enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 11.TargetToSend")
    end
  end
  if (GetGlobal("MSS_WaltsOpened") == 0) then
    Prefab_Activate_Doors("WaltsApartmentEnterTrigger", "close")
  end
  if (GetGlobal("MSS_TownHallRoof") == 0) then
    Prefab_Activate_Doors("JailEnterTrigger", "close")
    Prefab_Activate_Doors("JailEnterTriggerAlt", "close")
  end
  if (0 < GetGlobal("MSS_GremlinStructure_Agency")) then
    if (GetGlobal("MSS_GremlinStructure_Agency") == 1) then
      StopEmitters("meanstreetsouth_fx.MST_southAgencyMachineLightBulb_01b 01")
      Hide("meanstreetsouth_fx.MST_southAgencyMachineLightBulb_01b 01")
      AnimGBSequence("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Fan", "rest")
      Enable("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Fan")
      enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumewait 01.TargetToSend")
      Enable("meanstreetsouth_art.MadHatter_Sign_Toon")
    end
    StopEmitters("meanstreetsouth_fx.MST_southAgencyMachineLightBulb_01a 01")
    Hide("meanstreetsouth_fx.MST_southAgencyMachineLightBulb_01a 01")
    DestroyEntity("MadHatterCameraTrigger1")
  end
  if (GetGlobal("MSS_TrainStationDoor") == 1) then
    AnimGBSequence("meanstreetsouth_art.TrainTunnel_Doors", "restOpen")
  end
  if (0 < GetGlobal("MSS_TownHallRoof")) then
    if IsValidHandle("meanstreetsouth_art.TownHall_Inert 01") then
      DestroyEntity("meanstreetsouth_art.TownHall_Inert 01")
    end
  end
  if (1 < GetGlobal("EM2_EpisodeCheck")) then
    Prefab_Projector_ChangeState("ProjectorToGulchLab", "Activate")
    SetPropertyFloat("ProjectorDialog_Trigger 01", "UsableRadius", 0)
    ForEachEntityInGroup(Enable, "FireStationGroup")
    if (GetGlobal("NOS_BlotAlley_Ditto_Thanks_Played") ~= 1) then
      Hide("GremlinDitto")
    end
  end
  if (GetGlobal("MSS_GremlinStructure_Agency") == 2) then
    AnimGBSequence("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Machine", "fall")
    SetPropertyBool("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Machine", "Start Active", true)
    Hide("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Machine")
  elseif (GetGlobal("MSS_GremlinStructure_Agency") == 3) then
    AnimGBSequence("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Machine", "fall")
    SetPropertyBool("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Machine", "Start Active", true)
    Hide("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Machine")
  end
  if (GetGlobal("MSS_ObservatoryHackBox") == 0) then
    Enable("ObservatoryLift_HackBox 01")
  else
    Reverse("ObservatoryLift 01")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumewait 02.TargetToSend")
    resumeJumpVolumeWait("meanstreetsouth_main.prefab_jumpvolumewait 02.TargetToSend")
  end
  if (GetGlobal("MSS_CartDestroyed") == 1) then
    MSS_CartPoolState = 1
  end
  if (0 < GetGlobal("MSS_ClockOpened")) then
    TeleportToEntity("meanstreetsouth_art.ClockFace", "ClockFaceMarker")
  end
  if (GetGlobal("MSS_HoraceQuest_Note") == 3) then
    SetGlobal("MSS_HoraceQuest_Note", 4)
    SetGlobal("MSS_HoraceQuest_Assistant", 3)
  elseif (GetGlobal("MSS_HoraceQuest_Note") == 2) then
    SetGlobal("MSS_HoraceQuest_Note", 1)
  end
  ForEachEntityInGroup(SetAppCulledViewport, "CullingGroup_FlowerBed", 0)
  ForEachEntityInGroup(SetAppCulledViewport, "CullingGroup_FlowerBed", 1)
  ForEachEntityInGroup(SetAppCulledViewport, "CullingGroup_Emporium", 0)
  ForEachEntityInGroup(SetAppCulledViewport, "CullingGroup_Emporium", 1)
  ForEachEntityInGroup(SetAppCulledViewport, "CullingGroup_Robot", 0)
  ForEachEntityInGroup(SetAppCulledViewport, "CullingGroup_Robot", 1)
  ForEachEntityInGroup(SetAppCulledViewport, "CullingGroup_Robot_Geo", 0)
  ForEachEntityInGroup(SetAppCulledViewport, "CullingGroup_Robot_Geo", 1)
  ForEachEntityInGroup(SetAppCulledViewport, "CullingGroup_Robot_Terrain", 0)
  ForEachEntityInGroup(SetAppCulledViewport, "CullingGroup_Robot_Terrain", 1)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main", 0)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main", 1)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Underground", 0)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Underground", 1)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Underground_Terrain", 0)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Underground_Terrain", 1)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_VisibleSide", 0)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_VisibleSide", 1)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_VisibleBack", 0)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_VisibleBack", 1)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_VisibleBoth", 0)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_VisibleBoth", 1)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_Terrain1", 0)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_Terrain1", 1)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_Terrain2", 0)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_Terrain2", 1)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_Terrain3", 0)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_Terrain3", 1)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_NPC", 0)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_NPC", 1)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_Seth", 0)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_Main_Seth", 1)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_GuardianPool", 0)
  ForEachEntityInGroup(ClearAppCulledViewport, "CullingGroup_GuardianPool", 1)
  MST_South_RubblePileManageJump()
  MST_South_WaltsToonManageJump()
  MST_South_FireStationToonManage()
  MST_South_EmporiumToonManageJump()
  MST_South_AgencyMachineManageJump()
  MST_South_TrainRampManageJump()
  MST_South_HatterHatManageJump()
  MST_South_SetupAgencyAI()
  MSS_IntroCutscene()
  if (GetGlobal("EM2_TrainRide") == 1) then
    SetGlobal("MST_UtilidorsState", 0)
  end
  if (0 < GetGlobal("MST_UtilidorsState")) then
    if (GetGlobal("MST_UtilidorsState") == 1) then
      TeleportToEntity(GetPlayer(), "MSSouth_UTLexit_MickeySpawn")
      TeleportToEntity(GetPlayer2OrAI(), "MSSouth_UTLexit_OswaldSpawn")
      Wait(0.10000000149011612)
    elseif (GetGlobal("MST_UtilidorsState") == 2) then
      TeleportToEntity(GetPlayer(), "BalloonMickeySpawn")
      TeleportToEntity(GetPlayer2OrAI(), "BalloonOswaldSpawn")
      Wait(0.30000001192092896)
    end
    SetGlobal("MST_UtilidorsState", 0)
    CameraReset()
    Wait(0.10000000149011612)
  end
  local MSU_PneumaticTubesToMS = GetGlobal("MSU_PneumaticTubesToMS")
  if (0 < MSU_PneumaticTubesToMS) then
    TeleportToEntity(GetPlayer(), (("PM_FromUtilidorRoom" .. MSU_PneumaticTubesToMS) .. "_MickeyStart"))
    TeleportToEntity(GetPlayer2OrAI(), (("PM_FromUtilidorRoom" .. MSU_PneumaticTubesToMS) .. "_OswaldStart"))
    CameraReset()
    SetGlobal("MSU_PneumaticTubesToMS", 0)
  end
  Wait(0.5)
  if (MSS_IntroCutsceneFade == 0) then
    StartFadeIn(0.800000011920929)
  end
  if (GetGlobal("EM2_TrainRide") == 1) then
    FireSequence("SpiritConversationMarker", "Gen_Spirit_TrainMSS")
  end
  Disable("LuggageCheckTrigger")
  MSS_RunningSetup = 2
  MST_South_Checkpoint(nil, "train")
  return 
end
MST_UpgradeAwarded = 0
MSS_IntroCutscene = function()
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    if (GetGlobal("MSS_IntroCutscene_Check") == 0) then
      SetGlobal("MSS_IntroCutscene_Check", 1)
      StartFadeOut(0)
      DisableGuardianHint("GusHintUtilidor1")
      PlayMovie(GetPlayer(), "PH_1_2_Meet_the_Mad_Doctor.bik")
      GiveCollectibleNoPopup("Film_PH1_2")
      SetGlobal("MST_UtilidorsState", 0)
      Quest_SetCriticalPath("Critical_MSS", "Critical_MSS_2")
      RestrictCutSceneInput()
      StartFadeIn(0.800000011920929)
      FireUser1("RubeIntro_IGC")
      FireThread(Prefab_Projector_SetOnlySideCamera, "ProjectorToGulchLab")
      Wait(1.5)
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_UndergroundIntro")
      Wait(4.599999904632568)
      Prefab_TrainStationExplosion_TriggerExplosion("TrainDestructionTrigger")
      Wait(17.5)
      ClearCutSceneStack()
    end
  elseif (GetGlobal("EM2_EpisodeCheck") == 2) then
    if (GetGlobal("MSS_IntroCutscene_Check") == 1) then
      MST_UpgradeAwarded = 1
      if (GetGlobal("MSS_TrainRestored") < 0) then
        MSS_IntroCutsceneFade = 1
      end
      SetGlobal("MSS_IntroCutscene_Check", 2)
      GiveCollectibleNoPopup("Film_PH2_1")
      StartFadeOut(0)
      PlayMovie(GetPlayer(), "PH_2_1_Intro_EP2.bik")
      GiveCollectibleNoPopup("Film_PH2_1")
      SetGlobal("MST_UtilidorsState", 0)
      ActivateGremlinHint("GusHintUtilidor5")
      Quest_SetCriticalPath("Critical_BogEasy", "Critical_BogEasy_2")
      if (GetGlobal("MSS_HiddenFlowersBusy") == 1) then
        SetGlobal("MSS_HiddenFlowersBusy", 2)
      end
      if (GetGlobal("MSS_TrainRestored") < 0) then
        FireUser2("TrainDestructionTrigger")
      elseif (0 <= GetGlobal("MSS_TrainRestored")) then
        StartFadeIn(0.800000011920929)
        FireThread(Prefab_Projector_SetOnlySideCamera, "ProjectorToGulchLab")
        Wait(0.800000011920929)
        FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_IntroEpisode2")
      end
    end
    if (GetGlobal("MSS_HiddenFlowersBusy") == 0) then
      MST_South_HiddenHeroesRestart_SafetyNet()
    end
    if (MST_UpgradeAwarded == 0) then
      if (GetGlobal("EM2_UpgradesCollected") == 0) then
        MST_AwardAmmoUpgrades("2")
      end
    end
  elseif (GetGlobal("EM2_EpisodeCheck") == 3) then
    if (GetGlobal("MSS_IntroCutscene_Check") == 2) then
      MST_UpgradeAwarded = 1
      SetGlobal("MSS_IntroCutscene_Check", 3)
      StartFadeOut(0)
      PlayMovie(GetPlayer(), "PH_3_1_MS_Celebration.bik")
      GiveCollectibleNoPopup("Film_PH3_1")
      SetGlobal("MST_UtilidorsState", 0)
      ActivateGremlinHint("GusHintUtilidor5")
      Quest_SetCriticalPath("Critical_Ventureland", "Critical_Ventureland_1")
      if (GetGlobal("MSS_HiddenFlowersBusy") == 1) then
        SetGlobal("MSS_HiddenFlowersBusy", 2)
      end
      StartFadeIn(0.800000011920929)
      FireThread(Prefab_Projector_SetOnlySideCamera, "ProjectorToGulchLab")
      Wait(0.800000011920929)
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_IntroEpisode3")
    end
    if (GetGlobal("MSS_HiddenFlowersBusy") == 0) then
      MST_South_HiddenHeroesRestart_SafetyNet()
    end
    if (MST_UpgradeAwarded == 0) then
      if (GetGlobal("EM2_UpgradesCollected") == 1) then
        MST_AwardAmmoUpgrades("3")
      end
    end
  elseif (GetGlobal("EM2_EpisodeCheck") == 4) then
    FireThread(Prefab_Projector_SetOnlySideCamera, "ProjectorToGulchLab")
    if (GetGlobal("MSS_HiddenFlowersBusy") == 1) then
      SetGlobal("MSS_HiddenFlowersBusy", 2)
    elseif (GetGlobal("MSS_HiddenFlowersBusy") == 0) then
      MST_South_HiddenHeroesRestart_SafetyNet()
    end
    StartFadeIn(0.800000011920929)
  end
  return 
end
MST_South_Checkpoint = function(target, location)
  Wait(0.5)
  if (location == "train") then
    SaveCheckpoint(GetPlayer(), nil, "MickeyCheckpointMarker1", "OswaldCheckpointMarker1")
  elseif (location == "underground") then
    SaveCheckpoint(GetPlayer(), nil, "MickeyCheckpointMarker2", "OswaldCheckpointMarker2")
  end
  return 
end
MST_South_PrefabCheckpoint = function()
  MST_South_Checkpoint(nil, "train")
  return 
end
MST_South_PhoneTrioCheckpoint = function(num, target, location)
  MST_South_Checkpoint(target, location)
  return 
end
MST_South_SetLocalVariable = function(target, variable, value)
  _G[variable] = tonumber(value)
  return 
end
MSS_ToGulchLab = function(target)
  SetGlobal("FTL_Gulch_ProjectorExit", 10)
  MST_South_RebuildGremlinStructure()
  SetupPosition(target)
  return 
end
MST_South_FromGulchLab = function()
  return 
end
MST_South_LoadMuseum = function()
  if (GetGlobal("MSS_Pete_ObservatoryIntro_Played") == 0) then
    if (2 <= GetGlobal("EM2_EpisodeCheck")) then
      if (GetGlobal("EM2_EpisodeCheck") < 4) then
        FireSequence("mst_interior_museum_ai.BlackPete 01", "MSS_Pete_ObservatoryIntro", 0)
      end
    end
  end
  if (GetGlobal("MSN_SOTW_Intro_Played") == 1) then
    ForEachEntityInGroup(SetPropertyFloat, "SpiritStatue", "UsableRadius", 2)
  end
  ReplaceMusicStateOverride("MSS_IntMuseum")
  Print("Started Museum music")
  Prefab_EnterInterior_FadeIn()
  return 
end
MST_South_MuseumShopCheck = function()
  local currentSold = 0
  currentSold = GetTotalSoldCount()
  local (for index), (for limit), (for step) = 1, 3, 1
  for i = (for index), (for limit), (for step) do
    GiveQuestItems(("One_Toons_Trash_Counter" .. tostring(i)), (tonumber(GetCurrentCount(("One_Toons_Trash_Counter" .. tostring(i)))) * -1))
  end
  if (5 < currentSold) then
    GiveQuestItems("One_Toons_Trash_Counter1", 5)
  else
    GiveQuestItems("One_Toons_Trash_Counter1", tonumber(currentSold))
  end
  if (10 < currentSold) then
    GiveQuestItems("One_Toons_Trash_Counter2", 10)
  else
    GiveQuestItems("One_Toons_Trash_Counter2", tonumber(currentSold))
  end
  if (20 < currentSold) then
    GiveQuestItems("One_Toons_Trash_Counter3", 20)
  else
    GiveQuestItems("One_Toons_Trash_Counter3", tonumber(currentSold))
  end
  SetGlobal("MSS_Laralee_CollectorCount", GetTotalSoldCount())
  return 
end
MST_South_SetupMuseumAI = function()
  local data = GetPrefabData("EnterMuseum_Mickey")
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    data.InteriorToStream = "MuseumOrtensia"
  elseif (GetGlobal("MSS_Pete_ObservatoryIntro_Played") == 0) then
    if (GetGlobal("EM2_EpisodeCheck") < 4) then
      if (2 <= GetGlobal("EM2_EpisodeCheck")) then
        data.InteriorToStream = "MuseumPete"
      end
    end
  else
    data.InteriorToStream = "Museum"
  end
  return 
end
MST_South_LoadAgency = function()
  if (Quest_CheckStatus("Horaces_Assistant_Assistance", "Horaces_Assistant_Assistance_5", Quest_Completed) == false) then
    AnimVarInt("Tedworth", VAR_Mood_Type, 1)
    AnimVarInt("Tedworth", VAR_NPC_State, 9)
    SetParentEntity("mst_interior_detectiveagency.DetectiveAgency_Typewriter 02", "Tedworth")
    SetPropertyString("mst_interior_detectiveagency.DetectiveAgency_Typewriter 02", "Bone Attach Name", "skeleton:Weapon", 0)
    FireUser1("TedworthIdleTimer")
  elseif (GetGlobal("MSS_HoraceQuest_Assistant") == 2) then
    AnimVarInt("BarnacleJones", VAR_NPC_State, 9)
    AnimVarInt("BarnacleJones", VAR_Mood_Type, 1)
    SetParentEntity("mst_interior_detectiveagency.DetectiveAgency_Typewriter 02", "BarnacleJones")
    SetPropertyString("mst_interior_detectiveagency.DetectiveAgency_Typewriter 02", "Bone Attach Name", "Weapon", 0)
  elseif (GetGlobal("MSS_HoraceQuest_Assistant") == 3) then
    AnimVarInt("Clarabelle", VAR_Mood_Type, 1)
    AnimVarInt("Clarabelle", VAR_NPC_State, 9)
    AnimVarInt("SpatterFlower", VAR_Mood_Type, 1)
    AnimVarInt("SpatterFlower", VAR_NPC_State, 2)
    StopEmitters("clarabelleCow_Weapon_Locator_wateringFlowers")
    Print("MAT!!stopEmitter")
    SetParentEntity("mst_interior_detectiveagency.DetectiveAgency_Typewriter 02", "Clarabelle")
    SetPropertyString("mst_interior_detectiveagency.DetectiveAgency_Typewriter 02", "Bone Attach Name", "skeleton:Weapon", 0)
  end
  ReplaceMusicStateOverride("MSS_IntHorace")
  Print("Started Horace music")
  Prefab_EnterInterior_FadeIn()
  return 
end
MST_South_SetPatrolOswald = function(target)
  ClearNextPatrolNode(GetOswaldAI())
  OswaldSetPathAction(target)
  return 
end
MST_South_ClearPatrolOswald = function()
  ClearNextPatrolNode(GetOswaldAI())
  OswaldAbortScriptedBehavior()
  Disable("meanstreetsouth_ai.hiddenoswald_action 01.Marker(BuddyAIAction) 01")
  Wait(0.10000000149011612)
  OswaldStartFollowAction()
  return 
end
MST_South_CoOpThrowOswald = function()
  OswaldTossAction()
  ClearNextPatrolNode(GetOswaldAI())
  return 
end
MST_South_ElectricStreamOswald = function(target, receptor)
  OswaldStreamAction(receptor)
  ClearNextPatrolNode(GetOswaldAI())
  return 
end
MSS_TempGuardian_Increment = function()
  SetGlobal("MSS_GuardianCheck", (GetGlobal("MSS_GuardianCheck") + 1))
  return 
end
MSS_TempGuardian_Decrement = function()
  SetGlobal("MSS_GuardianCheck", (GetGlobal("MSS_GuardianCheck") - 1))
  return 
end
MSS_CartState = 0
MSS_CartPoolState = 0
MSS_CartCourseSet = function()
  local data = GetPrefabData("GuardianPool1")
  if (GetGlobal("MSS_CartDestroyed") == 0) then
    OswaldStreamAbort()
    if (data.GP_State == "Paint") then
      AnimGBSequence("meanstreetsouth_fx.MST_caveWallCrash_01a 01", "crash", true)
      SetPropertyBool("meanstreetsouth_fx.MST_caveWallCrash_01a 01", "Start Active", true)
      MSS_CartPoolState = 1
      if (not GetPropertyBool("TunnelCart1", "Is Painted")) then
        Wait(0.699999988079071)
        ForcePainted("TunnelCart1")
      end
      MST_South_Checkpoint(nil, "train")
    else
      AnimGBSequence("meanstreetsouth_fx.MST_caveWallCrash_01a 01", "roll_down", true)
      DoStinger("MSS_CartCrash", 2)
      SetPropertyBool("meanstreetsouth_fx.MST_caveWallCrash_01a 01", "Start Active", true)
      MSS_CartPoolState = 0
      if (data.GP_State == "Thinner") then
        if GetPropertyBool("TunnelCart1", "Is Painted") then
          Wait(1)
          ForceSketched("TunnelCart1")
        end
      end
      Wait(1.5)
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_MineCartHint", 0)
    end
  end
  return 
end
MSS_CartCheck = function(target, action)
  if (GetGlobal("MSS_CartDestroyed") == 0) then
    if (action == "enter") then
      if GetPropertyBool("TunnelCart1", "Is Painted") then
        MST_South_SetPatrolOswald("PatrolNode_CartShock")
      end
    elseif (action == "exit") then
      MST_South_ClearPatrolOswald()
    end
  end
  return 
end
MSS_CartDestroy = function(target)
  if (MSS_CartPoolState == 1) then
    if (GetGlobal("MSS_CartDestroyed") == 0) then
      SetGlobal("MSS_CartDestroyed", 1)
      DestroyEntity(target)
      DestroyEntity("TunnelCart1")
      MST_South_Checkpoint(nil, "train")
    end
  elseif (MSS_CartPoolState == 0) then
    AnimGBSequence("meanstreetsouth_fx.MST_caveWallCrash_01a 01", "roll_up")
    Wait(3)
    Prefab_OswaldElectricSwitch_ChangeState("OswaldSwitch_Tunnel", "Reset")
  end
  return 
end
MSS_ThinnerFall_BridgeThin = function(target)
  local data = GetPrefabData("GuardianPool1")
  if (data.GP_State == "Thinner") then
    Wait(0.4000000059604645)
    ForceSketched(target)
  end
  return 
end
MSS_DismissTrain = function(step)
  if (step == "one") then
    FireSequence("TrainConductor", "MSS_Conductor_DepartureAnnouncment", 1)
  elseif (step == "two") then
    MST_South_RebuildGremlinStructure()
    SetGlobal("EM2_TrainRide", 1)
    local MSS_TrainDestination = GetGlobal("MSS_TrainDestination")
    SetGlobal("MSS_TrainDestination", 0)
    if (MSS_TrainDestination == 4) then
      if (GetGlobal("EM2_EpisodeCheck") == 4) then
        if (GetGlobal("VTL_Oasis_Visit") ~= 3) then
          SetGlobal("VTL_Oasis_Visit", 3)
        end
      end
    end
    SaveCheckpoint(GetPlayer(), nil, "MickeyCheckpointMarker1", "OswaldCheckpointMarker1")
    if (MSS_TrainDestination == 2) then
      if (GetGlobal("EM2_EpisodeCheck") == 1) then
        LoadLevel(GetPlayer(), "OST_Center.Main_Visit1")
      else
        LoadLevel(GetPlayer(), "OST_Center.Main_Visit2")
        if (MSS_TrainDestination == 3) then
          LoadLevel(GetPlayer(), "NOS_BogEasy.LouisShack_V2")
        elseif (MSS_TrainDestination == 4) then
          if (GetGlobal("EM2_EpisodeCheck") == 4) then
            LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
          else
            LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
          end
        end
      end
    elseif (MSS_TrainDestination == 3) then
      LoadLevel(GetPlayer(), "NOS_BogEasy.LouisShack_V2")
    elseif (MSS_TrainDestination == 4) then
      if (GetGlobal("EM2_EpisodeCheck") == 4) then
        LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
      else
        LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
      end
    end
  end
  return 
end
MSS_SetGlobal = function(target, global, value)
  SetGlobal(global, tonumber(value))
  return 
end
MSS_RobotBridge = 0
MSS_GuardianPoolDrain_ForceThin = function(target, action)
  if (action == "thinned") then
    MSS_RobotBridge = 0
  elseif (action == "painted") then
    MSS_RobotBridge = 1
    if (GetGlobal("MSS_GuardianPool_Drain") == 0) then
      Wait(0.30000001192092896)
      ForceSketched(target)
    end
  end
  return 
end
MST_GuardianPool_UtilidorEntranceCheck = function()
  if (MSS_RobotBridge == 1) then
    MST_South_SetPatrolOswald("GremlinStructure_Pool_Node 01")
  end
  return 
end
MST_GuardianPool_UtilidorEntranceOpen = function()
  OswaldStreamAbort()
  DestroyEntity("GremlinStructure_Pool_UtilidorCheckTrigger 01")
  Enable("meanstreetsouth_art.CanyonDoor")
  AudioPostEventOn("meanstreetsouth_audio.CanyonDoor", "Play_sfx_mss_canyon_door_open")
  return 
end
MSS_GuardianPoolDrain_Stop = function()
  DeactivateFairySketch("meanstreetsouth_main.GuardianPool_DrainPlug 01")
  SetPropertyFloat("meanstreetsouth_main.GuardianPool_DrainPlug 01", "UsableRadius", 0)
  Hide("meanstreetsouth_main.GuardianPool_Drain 02")
  SetGlobal("MSS_GuardianPool_Drain", 1)
  return 
end
MSS_GuardianPoolDrain_Start = function()
  Unhide("meanstreetsouth_main.GuardianPool_Drain 02")
  SetPropertyFloat("meanstreetsouth_main.GuardianPool_DrainPlug 01", "UsableRadius", 2.299999952316284)
  SetGlobal("MSS_GuardianPool_Drain", 0)
  ForceSketched("meanstreetsouth_main.GuardianPool_Drain Toon 01")
  return 
end
MSS_FindRandomNumber = function(number)
  local randomindex = math.random(number)
  randomindex = math.random(number)
  return randomindex
end
MSS_NPCPatrolSwap = function(target, npc, node, variable, value, number)
  if (GetGlobal(variable) < tonumber(value)) then
    SetGlobal(variable, (GetGlobal(variable) + 1))
  else
    SetGlobal(variable, 0)
  end
  ClearNextPatrolNode(npc)
  TeleportToEntity(npc, node)
  Wait(2)
  SetNextPatrolNode(npc, node)
  return 
end
MSS_RepeatedAnimCheck = 0
MSS_RepeatedAnim = function(target, anim, duration)
  if (MSS_RepeatedAnimCheck == 0) then
    MSS_RepeatedAnimCheck = 1
    AnimGBReset(target)
    Wait(0.10000000149011612)
    AnimGBSequence(target, anim)
    SetPropertyBool(target, "Start Active", true)
    Wait(tonumber(duration))
    MSS_RepeatedAnimCheck = 0
  end
  return 
end
MSS_ClockMinuteHandAngle = 0
MSS_ClockHourHandAngle = 0
MSS_ClockRotating = 0
MSS_ClockPosition = 0
MSS_RotateClock = function(target, hand1, hand2, h1angle, h2angle, h1amount, h2amount)
  if (0 < GetGlobal("MSS_ClockOpened")) then
    if (MSS_ClockRotating == 0) then
      MSS_ClockRotating = 1
      _G[h1angle] = (_G[h1angle] - tonumber(h1amount))
      _G[h2angle] = (_G[h2angle] + tonumber(h2amount))
      SetRotatorMaxSpeed(hand1, 105)
      SetRotatorMaxSpeed(hand2, 165)
      StartRotateToPosition(hand1, _G[h1angle])
      StartRotateToPosition(hand2, _G[h2angle])
      AudioPostEventOn("meanstreetsouth_audio.Play_sfx_mss_clock_hands_move", "Play_sfx_mss_clock_hands_move")
      MSS_ClockPosition = (MSS_ClockPosition + 1)
      Wait(0.75)
      MSS_ClockRotating = 0
      if (MSS_ClockPosition == 36) then
        MSS_ClockPosition = 0
      end
    end
  end
  return 
end
MSS_ClockOccupied = 0
MSS_EnterClockCheck = function(target, side)
  if (side == "in") then
    MSS_ClockOccupied = (MSS_ClockOccupied + 1)
  elseif (side == "out") then
    MSS_ClockOccupied = (MSS_ClockOccupied - 1)
    if (GetGlobal("MSS_ClockOpened") == 2) then
      if (MSS_ClockOccupied == 0) then
        Reverse("meanstreetsouth_art.ClockFace")
        AudioPostEventOn("meanstreetsouth_audio.Play_sfx_mss_clock_hands_move", "Play_sfx_mss_clock_move_long")
        Disable("meanstreetsouth_scripting.ClockFace_Trigger 01")
        MSS_ClockRotating = 0
      end
    end
  end
  return 
end
MSS_StopClock = function(target, method)
  if (GetGlobal("MSS_TrainRestored") == -1) then
    if (method == "trigger") then
      if (MSS_WatchState == 0) then
        if (GetGlobal("MSS_TrainRestored") == -1) then
          FireSequence("OswaldConversationMarker", "MSS_Oswald_ClockFail")
        end
        MST_South_ClearPatrolOswald()
      elseif (MSS_WatchState == 1) then
        Disable(target)
        Disable("BuddyActionTrainToss2")
        Disable("meanstreetsouth_scripting.prefab_glidetomidairvolume 01.TriggerBase 01")
        Disable("ClockSetPatrolTrigger")
        RestrictCutSceneInput()
        OswaldStopMovingAction()
        Enable("BuddyActionClockWait")
        Disable("meanstreetsouth_ai.hiddenoswald_action 01.Marker(BuddyAIAction) 01")
        MSS_ClockRepairIGC(nil, "one")
        OswaldStartMovingAction()
        Wait(0.10000000149011612)
        MST_South_ClearPatrolOswald()
        SetGlobal("MSS_TrainRestored", 0)
        SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") + 5))
        Prefab_ChangeGuardianPoolState("GuardianPool1")
        SetGlobal("MSS_ClockOpened", 1)
        FireSequence("OswaldConversationMarker", "MSS_Oswald_ClockSuccess")
        DestroyEntity("meanstreetsouth_art.ClockWind")
        Disable("meanstreetsouth_art.ClockFan")
        Disable("BuddyActionTrainToss2")
        Disable("meanstreetsouth_scripting.prefab_glidetomidairvolume 01.TriggerBase 01")
        Disable("ClockSetPatrolTrigger")
        Disable("meanstreetsouth_ai.hiddenoswald_action 01.Marker(BuddyAIAction) 01")
      end
    else
      OswaldStartMovingAction()
      Wait(0.10000000149011612)
      MST_South_ClearPatrolOswald()
      SetGlobal("MSS_TrainRestored", 0)
      SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") + 5))
      Prefab_ChangeGuardianPoolState("GuardianPool1")
      SetGlobal("MSS_ClockOpened", 1)
      FireSequence("OswaldConversationMarker", "MSS_Oswald_ClockSuccess")
      DestroyEntity("meanstreetsouth_art.ClockWind")
      Disable("meanstreetsouth_art.ClockFan")
      Disable("BuddyActionTrainToss2")
      Disable("meanstreetsouth_scripting.prefab_glidetomidairvolume 01.TriggerBase 01")
      Disable("ClockSetPatrolTrigger")
      Disable("meanstreetsouth_ai.hiddenoswald_action 01.Marker(BuddyAIAction) 01")
    end
  end
  return 
end
MSS_ClockTossCheck = function()
  if (GetGlobal("MSS_TrainRestored") == -1) then
    FireSequence("OswaldConversationMarker", "MSS_Oswald_ClockToss", 0)
  end
  return 
end
MSS_WatchState = 0
MSS_ClockShockCheck = function(target, action)
  if (action == "patrol") then
    if (GetGlobal("MSS_TrainRestored") == -1) then
      if (MSS_WatchState == 1) then
        OswaldStreamAction("OswaldClockSwitch")
      end
    elseif (GetGlobal("MSS_TrainRestored") == -1) then
      FireSequence("OswaldConversationMarker", "MSS_Oswald_ClockFail")
      if (action == "watchOn") then
        MSS_WatchState = 1
        if (GetGlobal("MSS_TrainRestored") == -1) then
          Hide("meanstreetsouth_art.ClockWind")
          Prefab_OswaldElectricSwitch_ChangeState("OswaldClockSign", "Activate")
        end
      elseif (action == "watchOff") then
        if (MSS_ClockIGC == 0) then
          MSS_WatchState = 0
          if (GetGlobal("MSS_TrainRestored") == -1) then
            Unhide("meanstreetsouth_art.ClockWind")
            Prefab_OswaldElectricSwitch_ChangeState("OswaldClockSign", "Deactivate")
          end
        end
      end
    end
  elseif (action == "watchOn") then
    MSS_WatchState = 1
    if (GetGlobal("MSS_TrainRestored") == -1) then
      Hide("meanstreetsouth_art.ClockWind")
      Prefab_OswaldElectricSwitch_ChangeState("OswaldClockSign", "Activate")
    end
  elseif (action == "watchOff") then
    if (MSS_ClockIGC == 0) then
      MSS_WatchState = 0
      if (GetGlobal("MSS_TrainRestored") == -1) then
        Unhide("meanstreetsouth_art.ClockWind")
        Prefab_OswaldElectricSwitch_ChangeState("OswaldClockSign", "Deactivate")
      end
    end
  end
  return 
end
MSS_ClockIGC = 0
MSS_ClockRepairIGC = function(target, step)
  if (step == "one") then
    MSS_ClockIGC = 1
    StartFadeOut(0.800000011920929)
    Wait(0.800000011920929)
    Wait(0.10000000149011612)
    TeleportToEntity(GetPlayer2OrAI(), "ClockShockNode")
    GrabCamera("Clock_IGCCamera", nil, CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
    StartFadeIn(0.800000011920929)
    Wait(0.5)
    FireSequence("OswaldConversationMarker", "MSS_Oswald_ClockShock")
    Wait(1)
    Disable("BuddyActionClockWait")
    Enable("meanstreetsouth_ai.hiddenoswald_action 01.Marker(BuddyAIAction) 01")
  elseif (step == "two") then
    if (GetNumPlayers() == 1) then
      StartFadeOut(0.800000011920929)
      Wait(0.800000011920929)
      ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
      CameraReset()
      Wait(0.10000000149011612)
      StartFadeIn(0.800000011920929)
      UnrestrictCutSceneInput()
    end
    MST_South_Checkpoint(nil, "train")
  end
  return 
end
MSS_RingFireStationBell = function(target, event, anim, duration)
  if StimulusEvent_HasStimulusType(event, ST_SPIN) then
    if (GetGlobal("MSS_WaltsOpened") == 0) then
      if (MSS_ClockPosition == 6) then
        Prefab_Activate_Doors("WaltsApartmentEnterTrigger", "open")
        SetGlobal("MSS_WaltsOpened", 1)
        SetMapMarkerVisible("WaltsApartmentEnterTrigger", true)
        MST_South_Checkpoint(nil, "train")
      end
    end
    AudioPostEventOn(target, "Play_sfx_mss_firedepot_bell")
    MSS_RepeatedAnim(target, anim, duration)
  end
  return 
end
MST_South_ApartmentManage = function(target, action, toon)
  if (action == "paint") then
    Prefab_Activate_Doors("WaltsApartmentEnterTrigger", "close")
    MST_South_AvailabilityJumpsManage(target, action, toon)
  elseif (action == "thin") then
    if (GetGlobal("MSS_WaltsOpened") == 1) then
      Prefab_Activate_Doors("WaltsApartmentEnterTrigger", "open")
    end
    MST_South_AvailabilityJumpsManage(target, action, toon)
  end
  return 
end
MSS_GP_ObjectCount = 0
MSS_GP_ThinBridgeCheck = function(target, action)
  if (action == "thin") then
    ForceSketched("meanstreetsouth_main.FlowerBed_Toon 09")
    if (GetGlobal("MSS_GremlinStructure_GuardianPool") ~= 2) then
      ForEachEntityInGroup(AnimGBSequence, "GuardianPoolStructureSet", "mouth_closed")
      ForEachEntityInGroup(SetPropertyBool, "GuardianPoolStructureSet", "Start Active", true)
      Disable("meanstreetsouth_art.GremlinStructure_Pool_Trigger_DEBUG")
      SetGlobal("MSS_GremlinStructure_GuardianPool", 0)
    end
  elseif (action == "paint") then
    ForcePainted("meanstreetsouth_main.FlowerBed_Toon 09")
    if (GetGlobal("MSS_GremlinStructure_GuardianPool") ~= 2) then
      ForEachEntityInGroup(AnimGBSequence, "GuardianPoolStructureSet", "mouth_open")
      ForEachEntityInGroup(SetPropertyBool, "GuardianPoolStructureSet", "Start Active", true)
      SetGlobal("MSS_GremlinStructure_GuardianPool", 1)
    end
  elseif (action == "bridge") then
    ForceSketched(target)
  end
  return 
end
MST_South_AgencyExitCleanup = function()
  local data = GetPrefabData("EnterAgency_Mickey")
  if (GetGlobal("MSS_HoraceQuest_Note") == 3) then
    SetGlobal("MSS_HoraceQuest_Note", 4)
    SetGlobal("MSS_HoraceQuest_Assistant", 3)
    MST_South_Checkpoint(nil, "train")
  elseif (GetGlobal("MSS_HoraceQuest_Note") == 2) then
    SetGlobal("MSS_HoraceQuest_Note", 1)
  end
  if (data.InteriorToStream == "DetectiveAgencyTedworth") then
    FireUser2("TedworthIdleTimer")
  end
  MST_South_SetupAgencyAI()
  MSS_InteriorCleanup()
  return 
end
MST_South_TownHallExitCleanup = function()
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetPlayer2OrAI())
  Wait(0.20000000298023224)
  MSS_InteriorCleanup("jail")
  return 
end
MST_South_HatterExitCleanup = function()
  MSS_InteriorCleanup("hatter")
  return 
end
MSS_InteriorCleanup = function(location)
  if (GetGlobal("MSS_VisitNumber") == 1) then
    StreamInterior(nil, "Visit1_AI")
  elseif (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
    if (GetCurrentCount("BunnyChildren_MeanStreetsSouth") ~= 5) then
      StreamInterior(nil, "Visit3_AI")
    end
  else
    if (0 < GetGlobal("Autotopia_Core_Progression")) then
      StreamInterior(nil, "Visit2")
    else
      StreamInterior(nil, "Visit4_AI")
    end
    TeleportToEntity("Seth", "SethMarker")
  end
  if (location == "jail") then
    Wait(0.20000000298023224)
  end
  RemoveAllMusicStateOverride()
  Print("Returned music to auto")
  Prefab_ExitInterior_FadeIn("WaitForLoad")
  if (location == "observatory") then
    Disable("ObservatoryEnterTrigger")
    Wait(1)
    Reverse("ObservatoryLift 01")
    Enable("ObservatoryLift 01")
  end
  if (GetGlobal("MSS_GremlinStructure_Emporium") == 1) then
    ForEachEntityInGroup(StopEmitters, "GremlinEmporiumSparksFX")
  end
  if (GetGlobal("MSS_GuardianPool_Pipes") == 3) then
    AnimGBSequence("MST_southThinnerStream_01a 01", "LoopNothing")
  end
  ForEachEntityInGroup(Enable, "CullingTriggerGroup")
  if (location == "hatter") then
    MST_South_Checkpoint(nil, "train")
  end
  return 
end
MST_South_ManageAgencyToss = function(target, step)
  if (step ~= "one") then
    if (step == "two") then
      Disable("BuddyActionAgencyToss1")
      if (GetGlobal("MSS_Hatter_Underground1_Played") == 1) then
        if (GetGlobal("MSS_Pin04") == 0) then
          Enable("BuddyActionAgencyToss")
          if (target == "three") then
            Disable("BuddyActionAgencyToss")
            MST_South_Checkpoint(nil, "train")
          end
        end
      end
    elseif (target == "three") then
      Disable("BuddyActionAgencyToss")
      MST_South_Checkpoint(nil, "train")
    end
  end
  return 
end
MSS_OpenAgencyStructure = function(target, method)
  if (method == "fix") then
    Disable("BuddyActionAgencyMachine")
    OswaldStreamAbort()
    OswaldStartFollowAction()
    StopEmitters("meanstreetsouth_fx.MST_southAgencyMachineLightBulb_01b 01")
    Hide("meanstreetsouth_fx.MST_southAgencyMachineLightBulb_01b 01")
    StartEmitters("meanstreetsouth_fx.MST_southAgencyMachineLightBulb_01a 01")
    Unhide("meanstreetsouth_fx.MST_southAgencyMachineLightBulb_01a 01")
    SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") + 3))
    Prefab_ChangeGuardianPoolState("GuardianPool1")
    if (GetGlobal("MSS_GremlinStructure_Agency") == 0) then
      Unhide("MST_southAgencyMachineMovingSparks_01a 01")
      StartEmitters("MST_southAgencyMachineMovingSparks_01a 01")
      AudioPostEventOn("Play_sfx_mss_madhatter_machine_sparks_lp", "Play_sfx_mss_madhatter_spark_start")
      Wait(3)
      SetGlobal("MSS_GremlinStructure_Agency", 1)
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_Underground2")
      Wait(0.20000000298023224)
      Hide("MST_southAgencyMachineMovingSparks_01a 01")
      StopEmitters("MST_southAgencyMachineMovingSparks_01a 01")
      AudioPostEventOn("Play_sfx_mss_madhatter_machine_sparks_lp", "Play_sfx_mss_madhatter_spark_end")
    elseif (GetGlobal("MSS_GremlinStructure_Agency") == 2) then
      SetGlobal("MSS_GremlinStructure_Agency", 3)
      Unhide("MST_southAgencyMachineMovingSparks_01a 01")
      StartEmitters("MST_southAgencyMachineMovingSparks_01a 01")
      Wait(3)
      AnimGBSequence("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Fan", "rest")
      SetPropertyBool("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Fan", "Start Active", true)
      Enable("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Fan")
      enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumewait 01.TargetToSend")
      Enable("meanstreetsouth_art.MadHatter_Sign_Toon")
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_Underground4")
      Wait(0.20000000298023224)
      Hide("MST_southAgencyMachineMovingSparks_01a 01")
      StopEmitters("MST_southAgencyMachineMovingSparks_01a 01")
      AudioPostEventOn("Play_sfx_mss_madhatter_machine_sparks_lp", "Play_sfx_mss_madhatter_spark_end")
      if (method == "destroy") then
        if (GetGlobal("MSS_GremlinStructure_Agency") <= 1) then
          SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") - 3))
          Prefab_ChangeGuardianPoolState("GuardianPool1")
          AnimGBSequence("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Machine", "fall")
          SetPropertyBool("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Machine", "Start Active", true)
          StartEmitters("meanstreetsouth_fx.MST_southAgencyMachineDust_01a 01")
          Enable("meanstreetsouth_scripting.GremlinStructure_DetectiveAgency_Trigger 03")
          Disable("BuddyActionAgencyToss1")
          Enable("BuddyActionAgencyToss")
          SetPropertyFloat("meanstreetsouth_scripting.GremlinStructure_DetectiveAgency_Trigger 09", "UsableRadius", 0)
          FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_Underground3")
          Wait(3)
          StopEmitters("meanstreetsouth_fx.MST_southAgencyMachineDust_01a 01")
          Hide("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Machine")
          DestroyEntity("MadHatterCameraTrigger1")
        end
      end
    end
  elseif (method == "destroy") then
    if (GetGlobal("MSS_GremlinStructure_Agency") <= 1) then
      SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") - 3))
      Prefab_ChangeGuardianPoolState("GuardianPool1")
      AnimGBSequence("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Machine", "fall")
      SetPropertyBool("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Machine", "Start Active", true)
      StartEmitters("meanstreetsouth_fx.MST_southAgencyMachineDust_01a 01")
      Enable("meanstreetsouth_scripting.GremlinStructure_DetectiveAgency_Trigger 03")
      Disable("BuddyActionAgencyToss1")
      Enable("BuddyActionAgencyToss")
      SetPropertyFloat("meanstreetsouth_scripting.GremlinStructure_DetectiveAgency_Trigger 09", "UsableRadius", 0)
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_Underground3")
      Wait(3)
      StopEmitters("meanstreetsouth_fx.MST_southAgencyMachineDust_01a 01")
      Hide("meanstreetsouth_art.GremlinStructure_DetectiveAgency_Machine")
      DestroyEntity("MadHatterCameraTrigger1")
    end
  end
  return 
end
MSS_FuseBoxState = 0
MSS_FuseBoxRepair = function(target)
  local before = 0
  local after = 0
  after = --[[ return 2 of ]] Jigsaw_GetPercentagePainted(target)
  before = Jigsaw_GetPercentagePainted(target)
  if (GetGlobal("MSS_GremlinStructure_Agency") == 0) then
    if (after == 1) then
      MSS_FuseBoxState = 1
      StopEmitters("meanstreetsouth_fx.Sparks_AgencyMachine")
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_FuseBoxHint1")
      Wait(1)
      Prefab_OswaldElectricSwitch_ChangeState("OswaldSwitch_FuseBox", "Activate")
      if (GetGlobal("MSS_Gus_Underground2_Played") == 0) then
        if (GetGlobal("MSS_Gus_Underground4_Played") == 0) then
          Enable("BuddyActionAgencyMachine")
        end
      end
    elseif (after < 1) then
      MSS_FuseBoxState = 0
      StartEmitters("meanstreetsouth_fx.Sparks_AgencyMachine")
      Prefab_OswaldElectricSwitch_ChangeState("OswaldSwitch_FuseBox", "Deactivate")
      Disable("BuddyActionAgencyMachine")
      OswaldStreamAbort()
      OswaldStartFollowAction()
    end
  end
  return 
end
MSS_FuseBoxHintCheck = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    if (MSS_FuseBoxState == 0) then
      if (GetGlobal("MSS_GremlinStructure_Agency") == 0) then
        FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_FuseBoxHint2")
      end
    end
  end
  return 
end
MSS_UtilidorTriggerCheck = 0
MSS_OpenUtilidor = function(target, action)
  if (action == "open") then
    SetGlobal("MSS_UtilidorOpen", 1)
    SetPropertyFloat("UtilidorEntranceTrigger", "UsableRadius", 2)
  elseif (action == "close") then
    SetGlobal("MSS_UtilidorOpen", 0)
    SetPropertyFloat("UtilidorEntranceTrigger", "UsableRadius", 0)
  elseif (action == "check") then
    TeleportToEntity("MovableAgencyLuggage", "LuggageTeleportMarker")
    MSS_OpenUtilidor(nil, "open")
    Disable("LuggageCheckTrigger")
  elseif (action == "camera") then
    if (GetGlobal("MSS_VisitNumber") == 1) then
      if (MSS_UtilidorTriggerCheck == 0) then
        ActivateGremlinHint("GusHintUtilidor1")
      end
      MSS_UtilidorTriggerCheck = (MSS_UtilidorTriggerCheck + 1)
      SetCameraAttributesForPlayer("UtilidorsEntranceCamera", _activator())
    end
  elseif (action == "leave") then
    if (GetGlobal("MSS_VisitNumber") == 1) then
      MSS_UtilidorTriggerCheck = (MSS_UtilidorTriggerCheck - 1)
      ClearCameraAttributesForPlayer("UtilidorsEntranceCamera", _activator())
      if (MSS_UtilidorTriggerCheck == 0) then
        DisableGuardianHint("GusHintUtilidor1")
      end
    end
  end
  return 
end
MSS_EmporiumClampState01 = 0
MSS_EmporiumClampState02 = 0
MSS_EmporiumClampState03 = 0
MSS_EmporiumClampHit = function(target, clamp, variable)
  AnimGBSequence(clamp, "Open")
  SetPropertyBool(clamp, "Start Active", true)
  _G[variable] = 1
  FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_WarnEmporium")
  Wait(0.699999988079071)
  OswaldClearBoomerangTargets()
  if (MSS_EmporiumClampState01 == 1) then
    if (MSS_EmporiumClampState02 == 1) then
      if (MSS_EmporiumClampState03 == 1) then
        if (GetGlobal("MSS_GremlinStructure_Emporium") < 2) then
          if (GetGlobal("MSS_GremlinStructure_Emporium") == 1) then
            AnimGBSequence("GremlinStructure_Emporium_Arm", "idle")
            SetPropertyFloat("meanstreetsouth_visit2.GremlinStructure_Emporium_EntryTrigger 02", "UsableRadius", 0)
            ForEachEntityInGroup(StartEmitters, "GremlinEmporiumSparksFX")
          end
          if (GetGlobal("MSS_GremlinStructure_Emporium") == 1) then
            SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") - 12))
          elseif (GetGlobal("MSS_GremlinStructure_Emporium") == 0) then
            SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") - 6))
          end
          Prefab_ChangeGuardianPoolState("GuardianPool1")
          SetGlobal("MSS_GremlinStructure_Emporium", 2)
          AnimGBSequence("meanstreetsouth_art.GremlinStructure_Emporium_Platform", "break", true)
          Disable("PatrolNode_Oswald_Boomerang 01")
          Enable("OswaldClampJumpLocation")
          SetMapMarkerVisible("GremlinStructureExitTrigger_Emporium", false)
          DoStinger("Comment_Dest", 5)
          SetPropertyBool("meanstreetsouth_art.GremlinStructure_Emporium_Platform", "Start Active", true)
          MST_South_Checkpoint(nil, "train")
        end
      end
    end
  else
    AnimGBSequence(clamp, "Close")
    _G[variable] = 0
  end
  return 
end
MST_South_EmporiumPlatformFall = function()
  enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 20.TargetToSend")
  enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 11.TargetToSend")
  OswaldSetPathAction("GlideNode_EmporiumGremlin")
  return 
end
MSS_EmporiumClampActivate = function(target, state, clamp)
  if (state == "paint") then
    SetGlobal("MSS_EmporiumClampCount", (GetGlobal("MSS_EmporiumClampCount") - 1))
  elseif (state == "thin") then
    SetGlobal("MSS_EmporiumClampCount", (GetGlobal("MSS_EmporiumClampCount") + 1))
  end
  MST_South_EmporiumClampCheck()
  return 
end
MST_South_EmporiumClampCheck = function(target, action)
  if (GetGlobal("MSS_GremlinStructure_Emporium") < 2) then
    if (GetGlobal("MSS_EmporiumClampCount") == 3) then
      Enable("PatrolNode_Oswald_Boomerang 01")
    else
      OswaldClearBoomerangTargets()
      Disable("PatrolNode_Oswald_Boomerang 01")
    end
  end
  if (action == "enter") then
    MST_South_EmporiumBoomerangHint(target, "reset")
    if (GetGlobal("MSS_GremlinStructure_Emporium") == 2) then
      OswaldSetPathAction("GlideNode_EmporiumGremlin")
    end
  elseif (action == "exit") then
    TimerDisable("GremlinStructure_Emporium_Timer 01")
    if (GetGlobal("MSS_GremlinStructure_Emporium") == 2) then
      OswaldAbortScriptedBehavior()
    end
  end
  return 
end
MST_South_EmporiumClampHangGlide = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Wait_For_Attach)
  return 
end
MST_South_EmporiumClampTarget = function()
  OswaldClearBoomerangTargets()
  ClearNextPatrolNode(GetOswaldAI())
  QueueBrainEvent(GetOswaldAI(), BRAIN_StopWander)
  OswaldAddBoomerangTarget("meanstreetsouth_art.GremlinStructure_Emporium_Clamp 01")
  Wait(0.6000000238418579)
  OswaldAddBoomerangTarget("meanstreetsouth_art.GremlinStructure_Emporium_Clamp 02")
  Wait(0.6000000238418579)
  OswaldAddBoomerangTarget("meanstreetsouth_art.GremlinStructure_Emporium_Clamp 03")
  Wait(0.800000011920929)
  OswaldBoomerangAction()
  QueueBrainEvent(GetOswaldAI(), BRAIN_StartWander)
  return 
end
MSS_UndergroundTunnelPipes = function(target, variable, emitter, action)
  if (action == "paint") then
    SetGlobal("MSS_GuardianPool_Pipes", (GetGlobal("MSS_GuardianPool_Pipes") + 1))
    StopEmitters(emitter)
  elseif (action == "thin") then
    SetGlobal("MSS_GuardianPool_Pipes", (GetGlobal("MSS_GuardianPool_Pipes") - 1))
    StartEmitters(emitter)
  end
  if (GetGlobal("MSS_GuardianPool_Pipes") == 3) then
    AnimGBSequence("MST_southThinnerStream_01a 01", "End")
    SetPropertyBool("MST_southThinnerStream_01a 01", "Start Active", true)
    Disable("MSS_PipeThinnerFall_Trig")
    SetGlobal("MSS_GuardianPool_Drain", 1)
    AudioPostEventOn("meanstreetsouth_art.SND_PipeFlow1", "Play_sfx_PipesFlow_lp")
    AudioPostEventOn("meanstreetsouth_art.SND_PipeFlow2", "Play_sfx_PipesFlow_lp")
    AudioPostEventOn("meanstreetsouth_audio.Sound_ThinnerFall", "Stop_sfx_PipeWater_lp")
  elseif (GetGlobal("MSS_GuardianPool_Drain") == 1) then
    AnimGBSequence("MST_southThinnerStream_01a 01", "Start", true)
    SetPropertyBool("MST_southThinnerStream_01a 01", "Start Active", true)
    Enable("MSS_PipeThinnerFall_Trig")
    SetGlobal("MSS_GuardianPool_Drain", 0)
    ForceSketched("meanstreetsouth_main.GuardianPool_Drain Toon 01")
    AudioPostEventOn("meanstreetsouth_art.SND_PipeFlow1", "Stop_sfx_PipesFlow_lp")
    AudioPostEventOn("meanstreetsouth_art.SND_PipeFlow2", "Stop_sfx_PipesFlow_lp")
    AudioPostEventOn("meanstreetsouth_audio.Sound_ThinnerFall", "Play_sfx_PipeWater_lp")
  end
  return 
end
MSS_TeleportOswald = function(target, position)
  TeleportToEntity(GetOswaldAI(), position)
  ClearNextPatrolNode(GetOswaldAI())
  return 
end
MSS_CoOpThrowOswald = function()
  OswaldTossAction()
  ClearNextPatrolNode(GetOswaldAI())
  return 
end
MSS_ElectricStreamOswald = function(target, receptor)
  OswaldStreamAction(receptor)
  ClearNextPatrolNode(GetOswaldAI())
  return 
end
MSS_WaterTowerPanel01 = 0
MSS_WaterTowerPanel02 = 0
MSS_WaterTowerDestroy = function(target, variable)
  _G[variable] = 1
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  Rumble(nil, 1)
  Rumble(nil, 1, 1)
  OswaldStreamAbort()
  FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_WarnTownHall")
  if (MSS_WaterTowerPanel01 == 1) then
    if (MSS_WaterTowerPanel02 == 1) then
      if (GetGlobal("MSS_GremlinStructure_TownHall") == 1) then
        AnimGBSequence("meanstreetsouth_art.GremlinStructure_FireStation_Door 02", "close", true)
        SetPropertyFloat("meanstreetsouth_scripting.GremlinStructure_FireStation_DoorTrigger 02", "UsableRadius", 0)
        SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") - 12))
      elseif (GetGlobal("MSS_GremlinStructure_TownHall") == 0) then
        SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") - 6))
      end
      Prefab_ChangeGuardianPoolState("GuardianPool1")
      SetMapMarkerVisible("GremlinStructureExitTrigger_Station", false)
      AnimGBSequence("meanstreetsouth_art.GremlinStructure_FireStation_Door 01", "open")
      ForEachEntityInGroup(Unhide, "ScrapMetal_FireStation")
      DoStinger("Comment_Dest", 5)
      StopEmitters("meanstreetsouth_fx.MST_fireHouseSmoke_01a 01")
      StartEmitters("meanstreetsouth_fx.MST_fireHouseBroken_01a 01")
      SetGlobal("MSS_GremlinStructure_TownHall", 2)
      MST_South_Checkpoint(nil, "train")
    end
  end
  return 
end
MSS_WaterTowerReact = function(target, event, variable, patrol, switch, var2)
  local fairyTime = GetConfigVariableFloat("DefaultAbilities_Sketch_Fairy_Duration")
  if StimulusEvent_HasStimulusType(event, ST_FAIRY) then
    if (GetGlobal(variable) == 0) then
      SetGlobal(variable, 1)
      AnimGBSequence(target, "open")
      if (_G[var2] == 0) then
        MST_South_SetPatrolOswald(patrol)
        Prefab_OswaldElectricSwitch_ChangeState(switch, "Activate")
      end
      Wait(fairyTime)
      if (GetGlobal(variable) == 1) then
        AnimGBSequence(target, "close")
        if (_G[var2] == 0) then
          MST_South_ClearPatrolOswald()
          Prefab_OswaldElectricSwitch_ChangeState(switch, "Deactivate")
        end
        SetGlobal(variable, 0)
      end
    end
  elseif StimulusEvent_HasStimulusType(event, ST_THINNER) then
    if (GetGlobal(variable) == 1) then
      AnimGBSequence(target, "close")
      if (_G[var2] == 0) then
        MST_South_ClearPatrolOswald()
        Prefab_OswaldElectricSwitch_ChangeState(switch, "Deactivate")
      end
      SetGlobal(variable, 0)
    end
  end
  return 
end
MSS_GuardianPoolStructureDestroy = function(amount)
  if (amount == "1") then
    Disable("BuddyActionRobotHack1")
  elseif (amount == "10") then
    Disable("BuddyActionRobotHack2")
  end
  SetGlobal("MSS_RobotHeadHack", (GetGlobal("MSS_RobotHeadHack") + tonumber(amount)))
  FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_WarnPool")
  if (GetGlobal("MSS_RobotHeadHack") == 11) then
    if (GetGlobal("MSS_GremlinStructure_GuardianPool") == 1) then
      SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") - 12))
      AnimGBSequence("GuardianPoolStructureSet", "mouth_closed", true)
      SetPropertyBool("GuardianPoolStructureSet", "Start Active", true)
      Disable("meanstreetsouth_art.GremlinStructure_Pool_Trigger 01")
      Wait(1.600000023841858)
      ForEachEntityInGroup(Unhide, "ScrapMetal_Robot")
    elseif (GetGlobal("MSS_GremlinStructure_GuardianPool") == 0) then
      SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") - 6))
      AnimGBSequence("GuardianPoolStructureSet", "break")
      SetPropertyBool("GuardianPoolStructureSet", "Start Active", true)
      ForEachEntityInGroup(Unhide, "ScrapMetal_Robot")
    end
    Prefab_ChangeGuardianPoolState("GuardianPool1")
    SetMapMarkerVisible("GremlinStructureExitTrigger_Robot", false)
    DoStinger("Comment_Dest", 5)
    StartEmitters("RobotHeadSmokeFX2")
    StopEmitters("RobotHeadSmokeFX1")
    ForEachEntityInGroup(StopEmitters, "RobotHeadSparksFX")
    SetGlobal("MSS_GremlinStructure_GuardianPool", 2)
    MST_South_Checkpoint(nil, "train")
  end
  return 
end
MSS_GuardianPoolStructureBuddySwap = function(action)
  if (action == "original") then
    TeleportToEntity("BuddyActionRobotHack1", "RobotHeadHackMarker1")
    TeleportToEntity("BuddyActionRobotHack2", "RobotHeadHackMarker2")
  elseif (action == "swapped") then
    TeleportToEntity("BuddyActionRobotHack2", "RobotHeadHackMarker1")
    TeleportToEntity("BuddyActionRobotHack1", "RobotHeadHackMarker2")
  end
  return 
end
MST_RobotHeadWarp = 0
MSS_EnterGuardianPoolStructure = function()
  if (MST_RobotHeadWarp == 0) then
    MST_RobotHeadWarp = 1
    RestrictCutSceneInput()
    StartFadeOut(0.4000000059604645)
    Wait(0.5)
    TeleportToEntity(GetPlayer(), "meanstreetsouth_visit2.GremlinStructure_Pool_TeleportMarker 01")
    TeleportToEntity(GetPlayerOrAI(PLAYER_TWO), "meanstreetsouth_visit2.GremlinStructure_Pool_TeleportMarker 02")
    wait(0.10000000149011612)
    MST_South_EntityCullingManage(GetPlayer(), "unhide", "CullingGroup_Robot", "CullingGroup_Robot_Terrain", "CullingGroup_Robot_Geo")
    MST_South_EntityCullingManage(GetPlayerOrAI(PLAYER_TWO), "unhide", "CullingGroup_Robot", "CullingGroup_Robot_Terrain", "CullingGroup_Robot_Geo")
    MST_South_EntityCullingManage(GetPlayer(), "hide", "CullingGroup_GuardianPool", "CullingGroup_Main_VisibleSide")
    MST_South_EntityCullingManage(GetPlayer(), "hide", "CullingGroup_Underground", "CullingGroup_Underground_Terrain", "CullingGroup_Main_NPC", "CullingGroup_Main", "CullingGroup_Main_Terrain2", "CullingGroup_Main_Terrain3")
    MST_South_EntityCullingManage(GetPlayerOrAI(PLAYER_TWO), "hide", "CullingGroup_GuardianPool", "CullingGroup_Main_VisibleSide")
    MST_South_EntityCullingManage(GetPlayerOrAI(PLAYER_TWO), "hide", "CullingGroup_Underground", "CullingGroup_Underground_Terrain", "CullingGroup_Main_NPC", "CullingGroup_Main", "CullingGroup_Main_Terrain2", "CullingGroup_Main_Terrain3")
    CameraReset()
    SetCameraAttributesForPlayer("GremlinStructure_Pool_Marker(CameraOverride) 01", GetPlayer())
    SetCameraAttributesForPlayer("GremlinStructure_Pool_Marker(CameraOverride) 01", GetPlayerOrAI(PLAYER_TWO))
    FireThread(StationaryCamera_UntilPlayerMoves, nil, true, GetPlayer())
    FireThread(StationaryCamera_UntilPlayerMoves, nil, true, GetPlayerOrAI(PLAYER_TWO))
    Disable("meanstreetsouth_main.CullingTrigger 09")
    Disable("meanstreetsouth_main.CullingTrigger 11")
    Disable("meanstreetsouth_main.CullingTrigger 14")
    Wait(0.6000000238418579)
    StartFadeIn(0.4000000059604645)
    UnrestrictCutSceneInput()
    OverrideSpawnTransform(PLAYER_ONE, GetPosition("MickeyCheckpointMarker2"), GetFacing("MickeyCheckpointMarker2"))
    OverrideSpawnTransform(PLAYER_TWO, GetPosition("OswaldCheckpointMarker2"), GetFacing("OswaldCheckpointMarker2"))
    Disable("CullingTrigger8")
    ForEachEntityInGroup(Disable, "CullingTrigger3")
  end
  return 
end
MSS_MadHatterWarn = function(target, object)
  local before = 0
  local after = 0
  after = --[[ return 2 of ]] Jigsaw_GetPercentagePainted(target)
  before = Jigsaw_GetPercentagePainted(target)
  if (GetGlobal("MSS_GremlinStructure_Agency") < 2) then
    if (object == "hat") then
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_ThinSign")
    elseif (object == "wall") then
      if (after < 1) then
        if (IsAnySequencePlaying() == false) then
          FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_ThinWall")
        end
      end
    end
  end
  return 
end
MSS_V2_ForemanCheck = function(target, structure, marker, action)
  local activator = _activator()
  if (GetName(activator) == GetName(GetPlayer())) then
    if (GetGlobal("EM2_EpisodeCheck") ~= 2) then
      if (action == "enter") then
        MSS_V2_SummonForeman(target, structure, marker)
      elseif (action == "exit") then
        MSS_V2_DismissForeman(target, structure)
      end
    end
  end
  return 
end
MSS_V2_SummonForeman = function(target, structure, marker)
  local activator = _activator()
  if (GetName(activator) == GetName(GetPlayer())) then
    if (2 <= GetGlobal("MSN_VisitNumber")) then
      if (MSS_ForemanLocation ~= tonumber(structure)) then
        MSS_ForemanLocation = tonumber(structure)
        SetGlobal("MSS_GremlinStructure_Active", tonumber(structure))
        TeleportGremlinToEntity("meanstreetsouth_ai.Gremlin_Foreman", marker)
      end
    end
  end
  return 
end
MSS_V2_DismissForeman = function(target, structure)
  local activator = _activator()
  return 
end
MSS_V2_RebuildGremlinStructure = function(structure)
  if (structure == "pool") then
    SetGlobal("MSS_GremlinStructure_GuardianPool", 1)
    SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") + 6))
    Prefab_ChangeGuardianPoolState("GuardianPool1")
    AnimGBSequence("meanstreetsouth_art.GremlinStructure_Pool_Entry 02", "open", true)
    DoStinger("Comment_Rest", 5)
    SetPropertyBool("meanstreetsouth_art.GremlinStructure_Pool_Entry 02", "Start Active", true)
  elseif (structure == "townhall") then
    SetGlobal("MSS_GremlinStructure_TownHall", 1)
    SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") + 6))
    Prefab_ChangeGuardianPoolState("GuardianPool1")
    AnimGBSequence("meanstreetsouth_art.GremlinStructure_FireStation_Door 02", "open", true)
    SetMapMarkerVisible("GremlinStructureExitTrigger_Station", true)
    DoStinger("Comment_Rest", 5)
    StartEmitters("meanstreetsouth_fx.MST_fireHouseSmoke_01a 01")
    ForEachEntityInGroup(StopEmitters, "GremlinFireSparksFX")
  elseif (structure == "emporium") then
    SetGlobal("MSS_GremlinStructure_Emporium", 1)
    SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") + 6))
    Prefab_ChangeGuardianPoolState("GuardianPool1")
    Enable("meanstreetsouth_art.GremlinStructure_Emporium_Door")
    SetPropertyFloat("meanstreetsouth_visit2.GremlinStructure_Emporium_EntryTrigger 02", "UsableRadius", 2.5)
    AnimGBSequence("GremlinStructure_Emporium_Arm", "toFixed", true)
    ForEachEntityInGroup(StopEmitters, "GremlinEmporiumSparksFX")
    SetMapMarkerVisible("GremlinStructureExitTrigger_Emporium", true)
    DoStinger("Comment_Rest", 5)
  elseif (structure == "traindoor") then
    AnimGBSequence("meanstreetsouth_art.TrainTunnel_Doors", "open")
    SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") + 3))
    Prefab_ChangeGuardianPoolState("GuardianPool1")
    SetGlobal("MSS_TrainStationDoor", 1)
    DoStinger("Comment_Rest", 5)
    SetPropertyBool("meanstreetsouth_art.TrainTunnel_Doors", "Start Active", true)
  end
  MST_South_Checkpoint(nil, "train")
  return 
end
MST_South_ObservatoryIdleDetermine = function(character)
  local variable = "placeholder"
  local location = math.random(8)
  if (GetGlobal("MSS_ObservatoryItem_Falls") == 1) then
    if (location == 1) then
      if (GetGlobal("MSS_ObservatoryItem_Falls") == 1) then
        variable = "1"
      end
    elseif (location == 2) then
      if (GetGlobal("MSS_ObservatoryItem_Gulch") == 1) then
        variable = "2"
      end
    elseif (location == 3) then
      if (GetGlobal("MSS_ObservatoryItem_Lab") == 1) then
        variable = "3"
      end
    elseif (location == 4) then
      if (GetGlobal("MSS_ObservatoryItem_Alley") == 1) then
        variable = "4"
      end
    elseif (location == 5) then
      if (GetGlobal("MSS_ObservatoryItem_Fort") == 1) then
        variable = "5"
      end
    elseif (location == 6) then
      if (GetGlobal("MSS_ObservatoryItem_Float") == 1) then
        variable = "6"
      end
    elseif (location == 7) then
      if (GetGlobal("MSS_ObservatoryItem_Auto") == 1) then
        variable = "7"
      end
    elseif (location == 8) then
      if (GetGlobal("MSS_ObservatoryItem_Ride") == 1) then
        variable = "8"
      end
    end
    if (variable ~= "placeholder") then
      if (character == "laralee") then
        FireSequence("Laralee", ("MSS_Laralee_Oswald_ObservatoryItem" .. tostring(variable)), 2)
      else
        FireSequence("GremlinCopernicus", ("MSS_Copernicus_Description" .. tostring(variable)), 0)
        MST_South_ObservatoryIdleDetermine(character)
        if (character == "laralee") then
          FireSequence("Laralee", "MSS_Laralee_Oswald_CollectorQuest", 2)
        else
          FireSequence("GremlinCopernicus", "MSS_Copernicus_Description0", 0)
        end
      end
    else
      MST_South_ObservatoryIdleDetermine(character)
      if (character == "laralee") then
        FireSequence("Laralee", "MSS_Laralee_Oswald_CollectorQuest", 2)
      else
        FireSequence("GremlinCopernicus", "MSS_Copernicus_Description0", 0)
      end
    end
  end
  if (character == "laralee") then
    FireSequence("Laralee", "MSS_Laralee_Oswald_CollectorQuest", 2)
  else
    FireSequence("GremlinCopernicus", "MSS_Copernicus_Description0", 0)
  end
  return 
end
MST_South_ObservatoryUpsetCopernicus = function(character)
  local (for index), (for limit), (for step) = 2, 9, 1
  for i = (for index), (for limit), (for step) do
    if (Quest_CheckStatus("Watch_the_Skies", (("Watch_the_Skies_" .. tostring(i)) .. character), Quest_Discovered) == true) then
      Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. tostring(i)) .. character), Quest_Unavailable, false)
    end
  end
  if (character == "a") then
    SetMapMarkerVisible("WatchSkiesCopernicusQuest", false)
    SetGlobal("MSS_ObservatoryIcon_Copernicus", 1)
  elseif (character == "b") then
    SetMapMarkerVisible("WatchSkiesLaraleeQuest", false)
    SetGlobal("MSS_ObservatoryIcon_Laralee", 1)
  end
  return 
end
MST_South_ObservatoryQuestCheck = function()
  SetMapMarkerVisible("WatchSkiesCopernicusQuest", true)
  SetMapMarkerVisible("WatchSkiesLaraleeQuest", true)
  if (HasCollectible("RealWorld_Silly_Symphony_Fan") == true) then
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_2a", Quest_TurnIn, false)
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_2b", Quest_TurnIn, false)
  end
  if (HasCollectible("RealWorld_Minnie_Soda_Cap") == true) then
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_3a", Quest_TurnIn, false)
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_3b", Quest_TurnIn, false)
  end
  if (HasCollectible("RealWorld_Petes_Dragon_Lunchbox") == true) then
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_4a", Quest_TurnIn, false)
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_4b", Quest_TurnIn, false)
  end
  if (HasCollectible("RealWorld_Pirate_Sugar_Bowl") == true) then
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_5a", Quest_TurnIn, false)
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_5b", Quest_TurnIn, false)
  end
  if (HasCollectible("RealWorld_Donald_Duck_Milk_Bottle") == true) then
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_6a", Quest_TurnIn, false)
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_6b", Quest_TurnIn, false)
  end
  if (HasCollectible("RealWorld_3_Little_Pigs_Pocket_Watch") == true) then
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_7a", Quest_TurnIn, false)
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_7b", Quest_TurnIn, false)
  end
  if (HasCollectible("RealWorld_Goofy_Race_Car") == true) then
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_8a", Quest_TurnIn, false)
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_8b", Quest_TurnIn, false)
  end
  if (HasCollectible("RealWorld_Disney_Snowglobe") == true) then
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_9a", Quest_TurnIn, false)
    Quest_SetStatus("Watch_the_Skies", "Watch_the_Skies_9b", Quest_TurnIn, false)
  end
  return 
end
MST_South_ObservatoryRewardDetermine = function(character)
  if ((GetGlobal("MSS_ObservatoryItem_Laralee") + GetGlobal("MSS_ObservatoryItem_Copernicus")) == 8) then
    if (character == "copernicus") then
      GiveCollectible("Looking_at_the_Stars")
      SetGlobal("Looking_At_Stars_Pin", (GetGlobal("Looking_At_Stars_Pin") + 1))
      SetGlobal("MSS_ObservatoryIcon_Copernicus", 1)
    elseif (character == "laralee") then
      GiveCollectible("Consumate_Collector")
      SetGlobal("Consumate_Collector_Pin", (GetGlobal("Consumate_Collector_Pin") + 1))
      SetGlobal("MSS_ObservatoryIcon_Laralee", 1)
      if (character == "copernicus") then
        if (1 <= GetGlobal("MSS_ObservatoryItem_Copernicus")) then
          if (GetGlobal("MSS_ObservatoryItem_Copernicus") <= 3) then
            GiveCurrencyItem("Bronze_Pin", GetGlobal("MSS_ObservatoryItem_Copernicus"))
            if (GetGlobal("MSS_ObservatoryItem_Copernicus") == 3) then
              MST_South_ObservatoryUpsetCopernicus("b")
            end
          end
        elseif (4 <= GetGlobal("MSS_ObservatoryItem_Copernicus")) then
          if (GetGlobal("MSS_ObservatoryItem_Copernicus") <= 6) then
            GiveCurrencyItem("Bronze_Pin", GetGlobal("MSS_ObservatoryItem_Copernicus"))
          end
        elseif (GetGlobal("MSS_ObservatoryItem_Copernicus") == 7) then
          GiveCurrencyItem("Bronze_Pin", 7)
          if (character == "laralee") then
            if (GetGlobal("MSS_ObservatoryItem_Laralee") == 1) then
              AddCurrency("ScrapMetal", 25)
            elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 2) then
              AddCurrency("ScrapMetal", 50)
            elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 3) then
              MST_South_ObservatoryUpsetCopernicus("a")
              AddCurrency("ScrapMetal", 65)
            elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 4) then
              AddCurrency("ScrapMetal", 75)
            elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 5) then
              AddCurrency("ScrapMetal", 100)
            elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 6) then
              AddCurrency("ScrapMetal", 125)
            elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 7) then
              AddCurrency("ScrapMetal", 150)
            end
          end
        end
      elseif (character == "laralee") then
        if (GetGlobal("MSS_ObservatoryItem_Laralee") == 1) then
          AddCurrency("ScrapMetal", 25)
        elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 2) then
          AddCurrency("ScrapMetal", 50)
        elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 3) then
          MST_South_ObservatoryUpsetCopernicus("a")
          AddCurrency("ScrapMetal", 65)
        elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 4) then
          AddCurrency("ScrapMetal", 75)
        elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 5) then
          AddCurrency("ScrapMetal", 100)
        elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 6) then
          AddCurrency("ScrapMetal", 125)
        elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 7) then
          AddCurrency("ScrapMetal", 150)
        end
      end
    end
  elseif (character == "copernicus") then
    if (1 <= GetGlobal("MSS_ObservatoryItem_Copernicus")) then
      if (GetGlobal("MSS_ObservatoryItem_Copernicus") <= 3) then
        GiveCurrencyItem("Bronze_Pin", GetGlobal("MSS_ObservatoryItem_Copernicus"))
        if (GetGlobal("MSS_ObservatoryItem_Copernicus") == 3) then
          MST_South_ObservatoryUpsetCopernicus("b")
        end
      end
    elseif (4 <= GetGlobal("MSS_ObservatoryItem_Copernicus")) then
      if (GetGlobal("MSS_ObservatoryItem_Copernicus") <= 6) then
        GiveCurrencyItem("Bronze_Pin", GetGlobal("MSS_ObservatoryItem_Copernicus"))
      end
    elseif (GetGlobal("MSS_ObservatoryItem_Copernicus") == 7) then
      GiveCurrencyItem("Bronze_Pin", 7)
      if (character == "laralee") then
        if (GetGlobal("MSS_ObservatoryItem_Laralee") == 1) then
          AddCurrency("ScrapMetal", 25)
        elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 2) then
          AddCurrency("ScrapMetal", 50)
        elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 3) then
          MST_South_ObservatoryUpsetCopernicus("a")
          AddCurrency("ScrapMetal", 65)
        elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 4) then
          AddCurrency("ScrapMetal", 75)
        elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 5) then
          AddCurrency("ScrapMetal", 100)
        elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 6) then
          AddCurrency("ScrapMetal", 125)
        elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 7) then
          AddCurrency("ScrapMetal", 150)
        end
      end
    end
  elseif (character == "laralee") then
    if (GetGlobal("MSS_ObservatoryItem_Laralee") == 1) then
      AddCurrency("ScrapMetal", 25)
    elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 2) then
      AddCurrency("ScrapMetal", 50)
    elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 3) then
      MST_South_ObservatoryUpsetCopernicus("a")
      AddCurrency("ScrapMetal", 65)
    elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 4) then
      AddCurrency("ScrapMetal", 75)
    elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 5) then
      AddCurrency("ScrapMetal", 100)
    elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 6) then
      AddCurrency("ScrapMetal", 125)
    elseif (GetGlobal("MSS_ObservatoryItem_Laralee") == 7) then
      AddCurrency("ScrapMetal", 150)
    end
  end
  return 
end
MST_South_ObservatoryLaraleeHint = function(item)
  if (Quest_CheckStatus("Watch_the_Skies", (("Watch_the_Skies_" .. tostring(item)) .. "b"), Quest_Undiscovered) == true) then
    Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. tostring(item)) .. "b"), Quest_Discovered, true)
    Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. tostring(item)) .. "a"), Quest_Discovered, false)
    MST_South_Checkpoint(nil, "train")
  end
  return 
end
MSS_EnterTownHallRoof = function(target, trigger, action)
  if (trigger == "outside") then
    if (action == "paint") then
      Prefab_Activate_Doors("JailEnterTrigger", "close")
      Prefab_Activate_Doors("JailEnterTriggerAlt", "close")
    elseif (action == "thin") then
      Prefab_Activate_Doors("JailEnterTrigger", "open")
      Prefab_Activate_Doors("JailEnterTriggerAlt", "open")
    end
    if (GetGlobal("MSS_TownHallRoof") == 0) then
      SetPropertyInt("meanstreetsouth_art.TownHall_Inert 01", "Collision Layer", 13)
      AnimGBSequence("meanstreetsouth_art.TownHall_Inert 01", "collapse", true)
      SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") - 3))
      Prefab_ChangeGuardianPoolState("GuardianPool1")
      SetGlobal("MSS_TownHallRoof", 1)
      MST_South_Checkpoint(nil, "train")
    end
  end
  return 
end
MST_South_EmporiumBoomerangHint = function(target, state)
  if (state == "start") then
    TimerEnable("GremlinStructure_Emporium_Timer 01")
  elseif (state == "stop") then
    if (GetGlobal("MSS_GremlinStructure_Emporium") < 2) then
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_BoomerangHint")
      TimerDisable("GremlinStructure_Emporium_Timer 01")
    end
  elseif (state == "reset") then
    if (GetGlobal("MSS_Gus_BoomerangHint_Played") == 0) then
      if (GetGlobal("MSS_Gus_WarnEmporium_Played") == 1) then
        TimerReset("GremlinStructure_Emporium_Timer 01")
        Wait(0.10000000149011612)
        TimerEnable("GremlinStructure_Emporium_Timer 01")
      end
    end
  end
  return 
end
MST_South_ChangeCostume = function(costume, player)
  if (costume == "mickey") then
    RemovePlayerCostume(GetPlayer())
    SetGlobal("MSS_Mickey_Tailor", false)
  elseif (costume == "oswald") then
    RemovePlayerCostume(GetPlayer2OrAI())
  else
    GiveCollectibleNoPopup("Challenge_DessUp_Tracker")
    if (player == "mickey") then
      SetPlayerCostume(GetPlayer(), costume)
      if (costume == "Brave_Little_Tailor") then
        SetGlobal("MSS_Mickey_Tailor", true)
      else
        SetGlobal("MSS_Mickey_Tailor", false)
      end
      local oswaldAI = GetOswaldAI()
      if (oswaldAI ~= nil) then
        Wait(2)
        VocalizationComponent_QueueVocalization(oswaldAI, "react_newcostumeOtherPlayer", Vocalization_Category_Commentary, Vocalization_Priority_High, 2, true)
      end
    elseif (player == "oswald") then
      SetPlayerCostume(GetPlayer2OrAI(), costume)
      local oswaldAI, oswaldAI = GetOswaldAI(), GetPlayer2OrAI()
      if (oswaldAI ~= nil) then
        oswaldAI = Wait
        oswaldAI(2)
        oswaldAI = VocalizationComponent_QueueVocalization
        oswaldAI(oswaldAI, "react_newcostumeSelf", Vocalization_Category_Commentary, Vocalization_Priority_High, 2, true)
      end
    end
  end
  return 
end
MST_South_UpdateClothQuest_Ian = function(costume)
  if (costume == "asia") then
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_1a", Quest_TurnIn, true)
  elseif (costume == "africa") then
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_9a", Quest_TurnIn, true)
  elseif (costume == "jester") then
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_10a", Quest_TurnIn, true)
  elseif (costume == "manor") then
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_11a", Quest_TurnIn, true)
  end
  return 
end
MST_South_IncrementFlowerCostume = function(CostumeVar)
  if (CostumeVar == 1) then
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_1b", Quest_TurnIn, true)
  else
    local (for index), (for limit), (for step) = 9, 12, 1
    for i = (for index), (for limit), (for step) do
      if (CostumeVar == i) then
        Quest_SetStatus("Clothes_Make_The_Spatter", (("Clothes_Make_The_Spatter_" .. i) .. "b"), Quest_TurnIn, true)
      end
    end
  end
  return 
end
MST_South_CostumeDecrimenter = function(action)
  if (action == "save") then
    MST_South_Checkpoint(nil, "train")
  elseif HasCollectible("Costume_SpatterFlower01") then
    UseQuestItems("Costume_SpatterFlower01", 1)
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_1b", Quest_Completed, true)
  elseif HasCollectible("Costume_SpatterFlower02") then
    UseQuestItems("Costume_SpatterFlower02", 1)
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_9b", Quest_Completed, true)
  elseif HasCollectible("Costume_SpatterFlower03") then
    UseQuestItems("Costume_SpatterFlower03", 1)
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_10b", Quest_Completed, true)
  elseif HasCollectible("Costume_SpatterFlower04") then
    UseQuestItems("Costume_SpatterFlower04", 1)
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_11b", Quest_Completed, true)
  elseif HasCollectible("Costume_SpatterFlower05") then
    UseQuestItems("Costume_SpatterFlower05", 1)
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_12b", Quest_Completed, true)
  end
  return 
end
MST_South_SethIdleDetermine = function()
  Wait(0.20000000298023224)
  if (GetGlobal("MSS_Seth_HMQuest_MapPrompt_Played") == 0) then
    if (GetGlobal("EM2_Camera") == 0) then
      FireSequence("Seth", "MSS_Seth_HMQuest_MapPrompt", 0)
    end
  elseif (GetCurrentCount("Mickey_Photo") == 0) then
    if (GetCurrentCount("Oswald_Photo") == 0) then
      FireSequence("Seth", "MSS_Seth_HMQuestIdle1", 0)
    end
  elseif (GetGlobal("MSS_Seth_HMQuestFinal_New_Played") == 1) then
    FireSequence("Seth", "MSS_Seth_HMQuestIdle6", 0)
  elseif (GetGlobal("MSS_Seth_HMQuestComplete_New_Played") == 1) then
    FireSequence("Seth", "MSS_Seth_HMQuestIdle4", 0)
  elseif (GetGlobal("MSS_HiddenFlowersBusy") == 1) then
    FireSequence("Seth", "MSS_Seth_HMQuestIdle7", 0)
  elseif (GetGlobal("MSS_HiddenMickeysTurnIn") == -1) then
    if (GetGlobal("MSS_HiddenOswaldsTurnIn") == -1) then
      FireSequence("Seth", "MSS_Seth_HMQuestIdle3", 0)
    end
  else
    FireSequence("Seth", "MSS_Seth_HMQuestIdle2_New", 0)
  end
  return 
end
MST_South_HiddenHeroesRestart = function()
  if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_1a", Quest_Completed) == true) then
    if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2a", Quest_Undiscovered) == true) then
      Quest_SetStatus("Hidden_Heroes", "Hidden_Heroes_2a", Quest_Discovered, true)
    end
  elseif (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2a", Quest_Completed) == true) then
    if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3a", Quest_Undiscovered) == true) then
      Quest_SetStatus("Hidden_Heroes", "Hidden_Heroes_3a", Quest_Discovered, true)
    end
  end
  if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_1b", Quest_Completed) == true) then
    if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2b", Quest_Undiscovered) == true) then
      Quest_SetStatus("Hidden_Heroes", "Hidden_Heroes_2b", Quest_Discovered, true)
    end
  elseif (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2b", Quest_Completed) == true) then
    if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3b", Quest_Undiscovered) == true) then
      Quest_SetStatus("Hidden_Heroes", "Hidden_Heroes_3b", Quest_Discovered, true)
    end
  end
  if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2a", Quest_Discovered) == true) then
    if (5 < GetGlobal("MSS_HiddenMickeysFound")) then
      SetGlobal("MSS_HiddenMickeysTurnIn", 1)
    end
  elseif (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3a", Quest_Discovered) == true) then
    if (15 < GetGlobal("MSS_HiddenMickeysFound")) then
      SetGlobal("MSS_HiddenMickeysTurnIn", 1)
    end
  end
  if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2b", Quest_Discovered) == true) then
    if (5 < GetGlobal("MSS_HiddenOswaldsFound")) then
      SetGlobal("MSS_HiddenOswaldsTurnIn", 1)
    end
  elseif (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3b", Quest_Discovered) == true) then
    if (15 < GetGlobal("MSS_HiddenOswaldsFound")) then
      SetGlobal("MSS_HiddenOswaldsTurnIn", 1)
    end
  end
  SetGlobal("MSS_HiddenFlowersBusy", 0)
  MST_South_Checkpoint(nil, "train")
  return 
end
MST_South_HiddenHeroesRestart_SafetyNet = function()
  if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_1a", Quest_Completed) == true) then
    if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2a", Quest_Undiscovered) == true) then
      if (2 <= GetGlobal("EM2_EpisodeCheck")) then
        Quest_SetStatus("Hidden_Heroes", "Hidden_Heroes_2a", Quest_Discovered, false)
      end
    end
  elseif (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2a", Quest_Completed) == true) then
    if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3a", Quest_Undiscovered) == true) then
      if (3 <= GetGlobal("EM2_EpisodeCheck")) then
        Quest_SetStatus("Hidden_Heroes", "Hidden_Heroes_3a", Quest_Discovered, false)
      end
    end
  end
  if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_1b", Quest_Completed) == true) then
    if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2b", Quest_Undiscovered) == true) then
      if (2 <= GetGlobal("EM2_EpisodeCheck")) then
        Quest_SetStatus("Hidden_Heroes", "Hidden_Heroes_2b", Quest_Discovered, false)
      end
    end
  elseif (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2b", Quest_Completed) == true) then
    if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3b", Quest_Undiscovered) == true) then
      if (3 <= GetGlobal("EM2_EpisodeCheck")) then
        Quest_SetStatus("Hidden_Heroes", "Hidden_Heroes_3b", Quest_Discovered, false)
      end
    end
  end
  if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2a", Quest_Discovered) == true) then
    if (5 < GetGlobal("MSS_HiddenMickeysFound")) then
      SetGlobal("MSS_HiddenMickeysTurnIn", 1)
    end
  elseif (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3a", Quest_Discovered) == true) then
    if (15 < GetGlobal("MSS_HiddenMickeysFound")) then
      SetGlobal("MSS_HiddenMickeysTurnIn", 1)
    end
  end
  if (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2b", Quest_Discovered) == true) then
    if (5 < GetGlobal("MSS_HiddenOswaldsFound")) then
      SetGlobal("MSS_HiddenOswaldsTurnIn", 1)
    end
  elseif (Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3b", Quest_Discovered) == true) then
    if (15 < GetGlobal("MSS_HiddenOswaldsFound")) then
      SetGlobal("MSS_HiddenOswaldsTurnIn", 1)
    end
  end
  if Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_1a", Quest_Completed) then
    Print("Hidden_Heroes_1a=Completed")
  elseif Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_1a", Quest_Discovered) then
    Print("Hidden_Heroes_1a=Discovered")
  else
    Print("Hidden_Heroes_1a=Undiscovered")
  end
  if Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_1b", Quest_Completed) then
    Print("Hidden_Heroes_1b=Completed")
  elseif Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_1b", Quest_Discovered) then
    Print("Hidden_Heroes_1b=Discovered")
  else
    Print("Hidden_Heroes_1b=Undiscovered")
  end
  if Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2a", Quest_Completed) then
    Print("Hidden_Heroes_2a=Completed")
  elseif Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2a", Quest_Discovered) then
    Print("Hidden_Heroes_2a=Discovered")
  else
    Print("Hidden_Heroes_2a=Undiscovered")
  end
  if Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2b", Quest_Completed) then
    Print("Hidden_Heroes_2b=Completed")
  elseif Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_2b", Quest_Discovered) then
    Print("Hidden_Heroes_2b=Discovered")
  else
    Print("Hidden_Heroes_2b=Undiscovered")
  end
  if Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3a", Quest_Completed) then
    Print("Hidden_Heroes_3a=Completed")
  elseif Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3a", Quest_Discovered) then
    Print("Hidden_Heroes_3a=Discovered")
  else
    Print("Hidden_Heroes_3a=Undiscovered")
  end
  if Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3b", Quest_Completed) then
    Print("Hidden_Heroes_3b=Completed")
  elseif Quest_CheckStatus("Hidden_Heroes", "Hidden_Heroes_3b", Quest_Discovered) then
    Print("Hidden_Heroes_3b=Discovered")
  else
    Print("Hidden_Heroes_3b=Undiscovered")
  end
  Print(("MSS_HiddenMickeysFound=" .. GetGlobal("MSS_HiddenMickeysFound")))
  Print(("MSS_HiddenMickeysTurnIn=" .. GetGlobal("MSS_HiddenMickeysTurnIn")))
  Print(("MSS_HiddenOswaldsFound=" .. GetGlobal("MSS_HiddenOswaldsFound")))
  Print(("MSS_HiddenOswaldsTurnIn=" .. GetGlobal("MSS_HiddenOswaldsTurnIn")))
  return 
end
MST_South_HiddenHeroesUnavailable = function(chain)
  local (for index), (for limit), (for step) = 1, 3, 1
  for i = (for index), (for limit), (for step) do
    if (Quest_CheckStatus("Hidden_Heroes", (("Hidden_Heroes_" .. i) .. tostring(chain)), Quest_Completed) == false) then
      Quest_SetStatus("Hidden_Heroes", (("Hidden_Heroes_" .. i) .. tostring(chain)), Quest_Unavailable, false)
    end
  end
  Prefab_QuestIconManager_IconDisplayCheck("HiddenHeroesQuestManager")
  return 
end
MST_South_ManagePoolStructure = function(target, state)
  if (MSS_RunningSetup == 2) then
    if (GetGlobal("MSS_GremlinStructure_GuardianPool") < 2) then
      if (state == "neutral") then
        SetGlobal("MSS_GPTracking_02", 0)
      elseif (state == "paint") then
        SetGlobal("MSS_GPTracking_02", 1)
        ForcePainted("GuardianFallBridge")
      elseif (state == "thinner") then
        SetGlobal("MSS_GPTracking_02", -1)
        ForceSketched("GuardianFallBridge")
      end
    end
  end
  return 
end
MST_South_RebuildPoolStructure = function()
  AnimGBSequence("GuardianPoolStructureSet", "mouth_open")
  SetPropertyBool("GuardianPoolStructureSet", "Start Active", true)
  MSS_GuardianPoolStructureBuddySwap("swapped")
  SetMapMarkerVisible("GremlinStructureExitTrigger_Robot", true)
  DoStinger("Comment_Rest", 5)
  Enable("meanstreetsouth_art.GremlinStructure_Pool_Trigger 01")
  StopEmitters("RobotHeadSmokeFX1")
  ForEachEntityInGroup(StopEmitters, "RobotHeadSparksFX")
  SetGlobal("MSS_GremlinStructure_GuardianPool", 1)
  SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") + 6))
  Prefab_ChangeGuardianPoolState("GuardianPool1")
  MST_South_Checkpoint(nil, "train")
  return 
end
MST_South_MeasurePoolPlaystyle = function(value, action)
  if (action == "load") then
    SetPropertyFloat(value, "CurrentPlaystyle", GetPropertyFloat(GetRelativePrefabEntity("GuardianPool1", ".GuardianPoolVisible_Visual"), "CurrentPlaystyle"))
  else
    SetPropertyFloat("GuardianPoolMist", "CurrentPlaystyle", GetPropertyFloat(value, "CurrentPlaystyle"))
    SetPropertyFloat("MineCartWall", "CurrentPlaystyle", GetPropertyFloat(value, "CurrentPlaystyle"))
  end
  return 
end
MST_South_HiddenHeroesSetup = function()
  ForEachEntityInGroup(Enable, "PhotoGroup_HiddenHeroes")
  ForEachEntityInGroup(EnableComponent, "PhotoGroup_HiddenHeroes", "Camera Ability Target Component")
  SetGlobal("EM2_HiddenMickey001", 1)
  SetGlobal("EM2_HiddenMickey002", 1)
  SetGlobal("EM2_HiddenMickey003", 1)
  SetGlobal("EM2_HiddenOswald001", 1)
  SetGlobal("EM2_HiddenOswald002", 1)
  MST_South_Checkpoint(nil, "train")
  return 
end
MST_South_HiddenHeroesSetup_Map = function()
  SetGlobal("Map_Hero_Activate_MSS", 1)
  Prefab_HiddenHero_ActivateHintMap("HiddenHero_Mickey1")
  Prefab_HiddenHero_ActivateHintMap("HiddenHero_Mickey2")
  Prefab_HiddenHero_ActivateHintMap("HiddenHero_Mickey3")
  Prefab_HiddenHero_ActivateHintMap("HiddenHero_Oswald1")
  Prefab_HiddenHero_ActivateHintMap("HiddenHero_Oswald2")
  return 
end
MST_South_SetupAgencyAI = function()
  local data = GetPrefabData("EnterAgency_Mickey")
  if (Quest_CheckStatus("Horaces_Assistant_Assistance", "Horaces_Assistant_Assistance_5", Quest_Completed) == false) then
    data.InteriorToStream = "DetectiveAgencyTedworth"
  elseif (GetGlobal("MSS_HoraceQuest_Assistant") == 2) then
    data.InteriorToStream = "DetectiveAgencyJones"
  elseif (GetGlobal("MSS_HoraceQuest_Assistant") == 3) then
    data.InteriorToStream = "DetectiveAgencyClarabell"
  else
    data.InteriorToStream = "DetectiveAgency"
  end
  return 
end
MST_South_SetupAgencyAnimation = function(target, character)
  if (character == "horace") then
    AnimVarInt(target, VAR_NPC_State, 1)
  else
    AnimVarInt(target, VAR_NPC_State, 9)
  end
  return 
end
MST_South_ThinnerWarning = function(target, event, sequence)
  if StimulusEvent_HasStimulusType(event, ST_THINNER) then
    if (GetGlobal((sequence .. "_Played")) == 0) then
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", sequence, 0)
    end
  end
  return 
end
MST_South_SetupCityHallSpire = function()
  TeleportToEntity("mst_interior_cityhall.BlackPete 01", "PeteHallMarker")
  SetPropertyFloat("mst_interior_cityhall.BlackPete 01", "UsableRadius", 0)
  GrabCamera("TownHallIGCCamera", nil, CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
  MST_South_SetupCityHallDoor("roof")
  return 
end
MST_South_SetupCityHallDoor = function(location)
  if (GetGlobal("EM2_EpisodeCheck") == 3) then
    Unhide("GremlinPrescott")
  end
  if (GetGlobal("EM2_EpisodeCheck") == 4) then
    Hide("mst_interior_cityhall.BlackPete 01")
    DestroyEntity("CityHallSilverPin")
  end
  ReplaceMusicStateOverride("MSS_IntCityHall")
  Print("Started City Hall music")
  Prefab_EnterInterior_FadeIn()
  if (location == "roof") then
    RestrictCutSceneInput()
    Wait(1)
    SetGlobal("MSS_TownHallRoof", 2)
    local behaviorName = AI_GetActiveBehaviorName("mst_interior_cityhall.BlackPete 01")
    while (behaviorName == "InAir") do
      behaviorName = AI_GetActiveBehaviorName("mst_interior_cityhall.BlackPete 01")
      wait(0.30000001192092896)
    end
    FireSequence("mst_interior_cityhall.BlackPete 01", "MSS_Pete_EnterRoof", 1)
  end
  return 
end
MST_South_EmporiumInteriorEnter = function()
  ReplaceMusicStateOverride("MSS_IntEmp")
  Print("Started Emporium music")
  Prefab_EnterInterior_FadeIn()
  return 
end
MST_South_WaltInteriorEnter = function()
  ReplaceMusicStateOverride("MSS_IntWalt")
  Print("Started Walt Apt music")
  Prefab_EnterInterior_FadeIn()
  return 
end
MST_South_MadHatterInteriorEnter = function()
  ReplaceMusicStateOverride("MSS_IntMadHatter")
  Print("Started Mad Hatter music")
  Prefab_EnterInterior_FadeIn()
  return 
end
MST_South_FireStationHackManage = function()
  ClearNextPatrolNode(GetOswaldAI())
  ForEachEntityInGroup(Hide, "OswaldAction_FireStationHack")
  OswaldHackAction("FireStation_Hack 01")
  return 
end
MST_South_ActivateObservatory = function(target)
  if (2 <= GetGlobal("EM2_EpisodeCheck")) then
    MST_South_ClearPatrolOswald()
    Disable(target)
    Disable("meanstreetsouth_scripting.ObservatoryLift_Trigger 01")
    SetGlobal("MSS_ObservatoryHackBox", 1)
    Enable("ObservatoryLift 01")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumewait 02.TargetToSend")
    resumeJumpVolumeWait("meanstreetsouth_main.prefab_jumpvolumewait 02.TargetToSend")
    MST_South_Checkpoint(nil, "train")
  end
  return 
end
MSS_ObservatoryLiftPosition = 0
MST_South_ObservatoryHackManage = function(target, action)
  if (action == "enter") then
    Disable("meanstreetsouth_scripting.ObservatoryLift_Trigger 01")
    Wait(1)
    Enable("ObservatoryLift 01")
    if (MSS_ObservatoryLiftPosition == 0) then
      MSS_ObservatoryLiftPosition = 1
      Reverse("ObservatoryLift 01")
    end
  elseif (action == "knot") then
    if (MSS_ObservatoryLiftPosition == 2) then
      Wait(3)
      MSS_ObservatoryLiftPosition = 0
      Enable("meanstreetsouth_scripting.ObservatoryLift_Trigger 01")
    end
  else
  end
  return 
end
MSS_ObservatoryTrigger = 2
MST_South_ObservatoryDoorManage = function(target, action)
  if (action == "enter") then
    if (MSS_ObservatoryTrigger == 2) then
      Wait(0.699999988079071)
    end
    MSS_ObservatoryTrigger = 1
    Disable("ObservatoryLift 01")
    Enable("ObservatoryDoor 01")
    AudioPostEventOn(target, "Play_sfx_mss_observatory_door_open")
    Reverse("ObservatoryDoor 01")
  elseif (action == "exit") then
    MSS_ObservatoryTrigger = 0
    Disable(target)
    AudioPostEventOn(target, "Play_sfx_mss_observatory_door_open")
    Reverse("ObservatoryDoor 01")
    Wait(0.5)
    Enable("ObservatoryLift 01")
  end
  return 
end
MST_South_ObservatoryLiftManage = function(target, source)
  if (source == "knot") then
    MSS_ObservatoryLiftPosition = 2
    Enable("ObservatoryEnterTrigger")
    Wait(2)
    if (MSS_ObservatoryPosition == 0) then
      Reverse("ObservatoryLift 01")
      if (MSS_ObservatoryTrigger == 0) then
        Disable("ObservatoryEnterTrigger")
      end
    else
      SetSplineFollowerInitialSpeed("ObservatoryLift 01", 3)
      Disable("ObservatoryEnterTrigger")
    end
  else
    Disable("ObservatoryEnterTrigger")
  end
  return 
end
MSS_ObservatoryPosition = 0
MST_South_ObservatoryInteriorEnter = function()
  ReplaceMusicStateOverride("MSS_IntObserv")
  Print("Started Observatory music")
  MSS_ObservatoryPosition = 1
  SetSplineFollowerInitialSpeed("ObservatoryLift 01", 100)
  Reverse("ObservatoryLift 01")
  Enable("ObservatoryLift 01")
  Prefab_EnterInterior_FadeIn()
  return 
end
MST_South_ObservatoryInteriorExit = function()
  MSS_ObservatoryPosition = 0
  MSS_InteriorCleanup("observatory")
  return 
end
MST_South_GuardianPoolStructure_HackManage = function(target, action, amount, buddy)
  if (GetGlobal("OST_Gus_HackTraining_Start_Played") == 1) then
    if (GetGlobal("MSS_RobotHeadHack") ~= 11) then
      if (GetGlobal("MSS_RobotHeadHack") ~= tonumber(amount)) then
        if (action == "paint") then
          Disable(buddy)
          OswaldAbortScriptedBehavior()
        elseif (action == "thin") then
          Enable(buddy)
        end
      end
    end
  end
  return 
end
MST_South_RebuildGremlinStructure = function()
  if (GetGlobal("MSS_GremlinStructure_TownHall") == 3) then
    SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") + 6))
    SetGlobal("MSS_GremlinStructure_TownHall", 1)
    SetMapMarkerVisible("GremlinStructureExitTrigger_Station", true)
    AnimGBSequence("meanstreetsouth_art.GremlinStructure_FireStation_Door 02", "open", true)
    StartEmitters("meanstreetsouth_fx.MST_fireHouseSmoke_01a 01")
    ForEachEntityInGroup(StopEmitters, "GremlinFireSparksFX")
  end
  if (GetGlobal("MSS_GremlinStructure_GuardianPool") == 3) then
    SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") + 6))
    SetGlobal("MSS_GremlinStructure_GuardianPool", 1)
    SetGlobal("MSS_RobotHeadHack", 0)
    SetMapMarkerVisible("GremlinStructureExitTrigger_Robot", true)
    MSS_GuardianPoolStructureBuddySwap("swapped")
    ForEachEntityInGroup(ForcePainted, "RobotHeadToonGroup")
    ForEachEntityInGroup(Reprogram_ChangeState, "GuardianPoolHackGroup", "activate")
    AnimGBSequence("GuardianPoolStructureSet", "mouth_open")
  end
  if (GetGlobal("MSS_GremlinStructure_Emporium") == 3) then
    SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") + 6))
    SetGlobal("MSS_GremlinStructure_Emporium", 1)
    SetMapMarkerVisible("GremlinStructureExitTrigger_Emporium", true)
    Enable("meanstreetsouth_art.GremlinStructure_Emporium_Door")
    SetPropertyFloat("meanstreetsouth_visit2.GremlinStructure_Emporium_EntryTrigger 02", "UsableRadius", 2.5)
    AnimGBSequence("GremlinStructure_Emporium_Arm", "toFixed", true)
    ForEachEntityInGroup(StopEmitters, "GremlinEmporiumSparksFX")
  end
  return 
end
MST_RubblePileState = 0
MST_WaltsToonState = 0
MST_FireStationRubbleState = 0
MST_EmporiumRubbleState = 1
MST_AgencyMachineState = 1
MST_TrainRampState = 1
MST_HatterHatState = 1
MST_South_AvailabilityJumpsManage = function(target, action, variable)
  if (action == "paint") then
    _G[variable] = 1
  elseif (action == "thin") then
    _G[variable] = 0
  end
  if (variable == "MST_RubblePileState") then
    MST_South_RubblePileManageJump()
  elseif (variable == "MST_WaltsToonState") then
    MST_South_WaltsToonManageJump()
  elseif (variable == "MST_FireStationRubbleState") then
    MST_South_FireStationToonManage()
  elseif (variable == "MST_EmporiumRubbleState") then
    MST_South_EmporiumToonManageJump()
  elseif (variable == "MST_AgencyMachineState") then
    MST_South_AgencyMachineManageJump()
  elseif (variable == "MST_TrainRampState") then
    MST_South_TrainRampManageJump()
  elseif (variable == "MST_HatterHatState") then
    MST_South_HatterHatManageJump()
  end
  return 
end
MST_South_RubblePileManageJump = function()
  if (MST_RubblePileState == 0) then
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 01.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 02.TargetToSend")
  elseif (MST_RubblePileState == 1) then
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 01.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 02.TargetToSend")
  end
  return 
end
MST_South_WaltsToonManageJump = function()
  if (MST_WaltsToonState == 0) then
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 03.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 04.TargetToSend")
  elseif (MST_WaltsToonState == 1) then
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 03.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 04.TargetToSend")
  end
  return 
end
MST_South_FireStationToonManage = function()
  if (MST_FireStationRubbleState == 0) then
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 05.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 06.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 07.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 08.TargetToSend")
  elseif (MST_FireStationRubbleState == 1) then
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 05.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 06.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 07.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 08.TargetToSend")
  end
  return 
end
MST_South_EmporiumToonManageJump = function()
  if (MST_EmporiumRubbleState == 0) then
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 09.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 10.TargetToSend")
  elseif (MST_EmporiumRubbleState == 1) then
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 09.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 10.TargetToSend")
  end
  return 
end
MST_South_AgencyMachineManageJump = function()
  if (MST_AgencyMachineState == 0) then
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 13.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 14.TargetToSend")
  elseif (MST_AgencyMachineState == 1) then
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 13.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 14.TargetToSend")
  end
  return 
end
MST_FanBlade01 = 0
MST_FanBlade02 = 0
MST_South_AgencyFanManageJump = function(target, action)
  if (action == "enter") then
    if (MST_FanBlade01 == 0) then
      if (MST_FanBlade02 == 0) then
        resumeJumpVolumeWait("meanstreetsouth_main.prefab_jumpvolumewait 01.TargetToSend")
      end
    end
  elseif (action == "exit") then
    pauseJumpVolumeWait("meanstreetsouth_main.prefab_jumpvolumewait 01.TargetToSend")
  end
  return 
end
MST_South_TrainRampManageJump = function()
  if (MST_TrainRampState == 0) then
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 15.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 16.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 17.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 19.TargetToSend")
    Disable("meanstreetsouth_art.Ramp_CollisionTrigger 01")
    Disable("meanstreetsouth_scripting.TriggerBase_CameraOverride 01")
  elseif (MST_TrainRampState == 1) then
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 15.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 16.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 17.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 19.TargetToSend")
    Enable("meanstreetsouth_art.Ramp_CollisionTrigger 01")
    Enable("meanstreetsouth_scripting.TriggerBase_CameraOverride 01")
  end
  return 
end
MST_ObservatoryJump = 1
MST_South_ObservatoryLiftManageJump = function()
  if (MST_ObservatoryJump == 0) then
    MST_ObservatoryJump = 1
    resumeJumpVolumeWait("meanstreetsouth_main.prefab_jumpvolumewait 02.TargetToSend")
  elseif (MST_ObservatoryJump == 1) then
    MST_ObservatoryJump = 0
    pauseJumpVolumeWait("meanstreetsouth_main.prefab_jumpvolumewait 02.TargetToSend")
  end
  return 
end
MST_South_HatterHatManageJump = function()
  if (MST_HatterHatState == 0) then
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 18.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 25.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 21.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 22.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 23.TargetToSend")
  elseif (MST_HatterHatState == 1) then
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 18.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 25.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 21.TargetToSend")
    enableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 22.TargetToSend")
    disableJumpVolumeAvailability("meanstreetsouth_main.prefab_jumpvolumeavailability 23.TargetToSend")
  end
  return 
end
MST_South_ManageNPCs = function(target, npc, variable)
  if (variable == "autotopia") then
    if (0 < GetGlobal("Autotopia_Core_Progression")) then
      if (npc == "gilda") then
        DestroyEntity(target)
      end
    elseif (npc == "corrine") then
      DestroyEntity(target)
      if (variable == "exterior") then
        if (GetGlobal("EM2_EpisodeCheck") ~= 2) then
          if (npc == "stuffus") then
            DestroyEntity(target)
          end
        end
      end
    end
  elseif (variable == "exterior") then
    if (GetGlobal("EM2_EpisodeCheck") ~= 2) then
      if (npc == "stuffus") then
        DestroyEntity(target)
      end
    end
  end
  return 
end
MST_South_BunnyChildrenCleanup = function()
  FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_BunnyChildrenUpdate")
  return 
end
MST_South_TeleportToStartPosition = function()
  if (GetGlobal("MSN_TrainSceneFinished") == 1) then
    TeleportToEntity(GetPlayer(), "meanstreetsouth_ai.PlayerStart_Marker 01")
  end
  return 
end
MST_South_MuseumTeleport = function(target, location, oldLocation)
  RestrictCutSceneInput()
  StartFadeOut(0.800000011920929)
  Wait(0.800000011920929)
  ClearCameraAttributesForPlayer((("MuseumCameraOverride_" .. oldLocation) .. "1"), GetPlayer())
  ClearCameraAttributesForPlayer((("MuseumCameraOverride_" .. oldLocation) .. "2"), GetPlayerOrAI(PLAYER_TWO))
  wait(0.03999999910593033)
  Disable2DSetup("interior")
  TeleportToEntity(GetPlayer(), GetRelativePrefabEntity("EnterMuseum_Mickey", ".ExitBuildingPosition"), true, true)
  wait(0)
  TogglePlayerIconSubstitute(false, true)
  wait(0)
  TeleportToEntity(GetPlayer(), (tostring(location) .. "Teleport1"), true, true)
  TeleportToEntity(GetPlayer2OrAI(), (tostring(location) .. "Teleport2"), true, true)
  Wait(0.03999999910593033)
  if (location == "Statue") then
    location = "Middle"
  end
  SetPropertyEntity((("MuseumCameraOverride_" .. location) .. "1"), "SideScrollSecondaryTarget", GetPlayerOrAiCameraTarget(PLAYER_TWO))
  SetCameraAttributesForPlayer((("MuseumCameraOverride_" .. location) .. "1"), GetPlayer())
  SetConfigVariableString(GetPlayer(), "CameraFieldOfView", 0)
  wait(0.03999999910593033)
  SetCameraAttributesForPlayer((("MuseumCameraOverride_" .. location) .. "2"), GetPlayerOrAI(PLAYER_TWO))
  SetConfigVariableString(GetPlayer2OrAI(), "CameraFieldOfView", 0)
  Enable2DSetup("interior")
  EnableSplitScreen(false)
  Wait(0.10000000149011612)
  StartFadeIn(0.800000011920929)
  Wait(0.800000011920929)
  UnrestrictCutSceneInput()
  return 
end
MST_South_MuseumStatueInteract = function(target, statue)
  if (target == "reward") then
    if (statue == nil) then
      Wait(0.20000000298023224)
      ForceSpawn("MuseumStatueRewardSpawner", 1)
    else
      UnlockPinBuff(statue)
      GiveCollectibleNoPopup("Challenge_GotSpirit_Tracker")
      GiveCollectible("Challenge_StatueGarden_Tracker")
      if (statue == "pin") then
        ForEachEntityInGroup(SetPropertyFloat, "MuseumTransitionTriggerGroup", "UsableRadius", 1.5)
        MST_South_Checkpoint(nil, "train")
      elseif (GetGlobal("MSS_Spirit_QuestIntro_Played") == 0) then
        if (GetGlobal("MSN_SOTW_Intro_Played") == 0) then
          FireSequence("SpiritOfTheWasteland", "MSS_Spirit_QuestIntro", 1)
        end
      elseif (GetGlobal((("MSS_Spirit_" .. tostring(statue)) .. "TurnIn_Played")) == 0) then
        if (Quest_CheckStatus(("Spirit_" .. tostring(statue)), (("Spirit_" .. tostring(statue)) .. "_1"), Quest_Completed) == true) then
          if (_activator() == GetPlayer()) then
            TeleportToEntity("MuseumSpiritVFX", (("Statue" .. tostring(statue)) .. "Marker"))
            TeleportToEntity("MuseumStatueRewardSpawner", (("Statue" .. tostring(statue)) .. "Marker"))
            Wait(0.10000000149011612)
            FireThread(MST_South_MuseumSpiritManage, "nothing", "FadeIn")
            FireSequence("SpiritOfTheWasteland", (("MSS_Spirit_" .. tostring(statue)) .. "TurnIn"), 1)
          end
        end
      else
        FireSequence("SpiritOfTheWasteland", (("MSS_Spirit_" .. tostring(statue)) .. "Description"), 1)
      end
    end
  elseif (statue == "pin") then
    ForEachEntityInGroup(SetPropertyFloat, "MuseumTransitionTriggerGroup", "UsableRadius", 1.5)
    MST_South_Checkpoint(nil, "train")
  elseif (GetGlobal("MSS_Spirit_QuestIntro_Played") == 0) then
    if (GetGlobal("MSN_SOTW_Intro_Played") == 0) then
      FireSequence("SpiritOfTheWasteland", "MSS_Spirit_QuestIntro", 1)
    end
  elseif (GetGlobal((("MSS_Spirit_" .. tostring(statue)) .. "TurnIn_Played")) == 0) then
    if (Quest_CheckStatus(("Spirit_" .. tostring(statue)), (("Spirit_" .. tostring(statue)) .. "_1"), Quest_Completed) == true) then
      if (_activator() == GetPlayer()) then
        TeleportToEntity("MuseumSpiritVFX", (("Statue" .. tostring(statue)) .. "Marker"))
        TeleportToEntity("MuseumStatueRewardSpawner", (("Statue" .. tostring(statue)) .. "Marker"))
        Wait(0.10000000149011612)
        FireThread(MST_South_MuseumSpiritManage, "nothing", "FadeIn")
        FireSequence("SpiritOfTheWasteland", (("MSS_Spirit_" .. tostring(statue)) .. "TurnIn"), 1)
      end
    end
  else
    FireSequence("SpiritOfTheWasteland", (("MSS_Spirit_" .. tostring(statue)) .. "Description"), 1)
  end
  return 
end
MST_South_MuseumSpiritManage = function(target, action)
  if (action == "FadeOut") then
    DestroyEntity("SpiritApproachTrigger")
    local a = 1
    local (for index), (for limit), (for step) = 1, 0, -0.05000000074505806
    for a = (for index), (for limit), (for step) do
      SetR3MTConstRegAlpha("MuseumSpiritVFX", 1, a)
      Wait(0.05000000074505806)
    end
    Wait(0.009999999776482582)
    Hide("MuseumSpiritVFX")
  elseif (action == "FadeIn") then
    SetR3MTConstRegAlpha("MuseumSpiritVFX", 1, 1)
    Unhide("MuseumSpiritVFX")
    local a = 0
    local (for index), (for limit), (for step) = 0, 1, 0.05000000074505806
    for a = (for index), (for limit), (for step) do
      a = SetR3MTConstRegAlpha
      (for index) = "MuseumSpiritVFX"
      (for limit) = 1
      (for step) = a
      a((for index), (for limit), (for step))
      a = Wait
      (for index) = 0.05000000074505806
      a((for index))
    end
  elseif (action == "load") then
    if (GetGlobal("MSS_Spirit_QuestIntro_Played") == 0) then
      if (GetGlobal("MSN_SOTW_Intro_Played") == 0) then
        MST_South_MuseumSpiritManage(nil, "FadeIn")
      end
    end
  end
  return 
end
MST_SpiritHint = 0
MST_South_MuseumSpiritHint = function(trigger, step)
  if (step == "one") then
    MST_SpiritHint = 1
  elseif (step == "two") then
    if (MST_SpiritHint == 1) then
      FireSequence("Laralee", "MSS_Laralee_SpiritIntro", 0)
    end
  end
  return 
end
MST_South_HiddenHeroesReward = function(outcome)
  if (outcome == "mickey") then
    GiveCollectible("Costume_Fire_Fighter_1")
    SetGlobal("EM2_Costume_Firefighter01", 1)
  elseif (outcome == "oswald") then
    GiveCollectible("Costume_Mad_Doctor_1")
    SetGlobal("EM2_Costume_Doctor01", 1)
  end
  return 
end
MST_South_GremlinStructureDescription = function(target, structure)
  local activator = _activator()
  if (GetName(activator) == GetName(GetPlayer())) then
    if (GetGlobal("MSS_Gus_GremlinTech_Played") == 0) then
      SetGlobal("MSS_GremlinStructure_Active", tonumber(structure))
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_GremlinTech")
    elseif (structure == "1") then
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_GuardianPoolIntro", 0)
    elseif (structure == "2") then
      FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_WaterTowerIntro", 0)
    elseif (structure == "3") then
      if (1 < GetGlobal("EM2_EpisodeCheck")) then
        if (GetGlobal("NOS_BlotAlley_Ditto_Thanks_Played") == 0) then
          if (GetGlobal("MSS_Gus_DittoMissing_Played") == 0) then
            FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_DittoMissing", 0)
          end
        end
      else
        FireSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_CompactorIntro", 0)
      end
    end
  end
  return 
end
MST_South_WatchSketchTutorial = function(step)
  if (step == "one") then
    SetPropertyFloat("mst_interior_emporium_ai.Casey", "UsableRadius", 0)
    Wait(0.30000001192092896)
    RestrictCutSceneInput()
    Wait(0.10000000149011612)
    ForceSequence("meanstreetsouth_scripting.Marker(Conversation) 01", "MSS_Gus_WatchTutorial", 0)
  elseif (step == "two") then
    SetGlobal("EM2_WatchSketch", 1)
    if (GetGlobal("EM2_EpisodeCheck") < 4) then
      Enable("BuddyActionTrainToss2")
      Disable("BuddyActionTrainToss1")
      Enable("meanstreetsouth_scripting.prefab_glidetomidairvolume 01.TriggerBase 01")
      Enable("ClockSetPatrolTrigger")
    end
    PlayMovie(GetPlayer(), "PH_Training_Watch.bik")
    GiveCollectibleNoPopup("Film_PH_Watch")
    SetPropertyFloat("mst_interior_emporium_ai.Casey", "UsableRadius", 3.5)
    UnrestrictCutSceneInput()
  end
  return 
end
MST_South_TailorCostumeIntro = function()
  local costume = GetCurrentCostumeName(GetPlayer())
  if (costume == "Brave_Little_Tailor") then
    FireSequence("TheHaberdasher", "MSS_Hatter_BraveLittleTailor", 0)
  end
  return 
end
MSS_OswaldChestOneShot = function(target, action, chest)
  local data = GetPrefabData(GetRelativePrefabEntity(chest, ".Chest"))
  if (data.ChestOpened == false) then
    if (action == "paint") then
      SetPropertyBool(chest, "ActionSpotEnabled", false)
      OswaldStartFollowAction()
    elseif (action == "thin") then
      SetPropertyBool(chest, "ActionSpotEnabled", true)
    end
  end
  return 
end
MST_South_MoveHydrantFX = function(target)
  StartEmitters("BreakableHydrantFX")
  Wait(0.800000011920929)
  StopEmitters("BreakableHydrantFX")
  return 
end
MST_TrainFireworks = 0
MST_South_TrainStationFireworks = function(target, action)
  if (GetGlobal("MSS_TrainRestored") ~= -2) then
    if (0 < GetGlobal("MSS_TrainRestored")) then
      SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") - 10))
    else
      SetGlobal("MST_South_QuestHealth", (GetGlobal("MST_South_QuestHealth") - 5))
    end
    Prefab_ChangeGuardianPoolState("GuardianPool1")
    SetGlobal("MSS_TrainRestored", -2)
    SetMapMarkerVisible("WastelandLimitedQuest", false)
    Quest_SetStatus("The_Wasteland_Limited", "The_Wasteland_Limited_2", Quest_Unavailable, false)
    MST_South_Checkpoint(nil, "train")
  end
  return 
end
MST_South_AllTrainsRestored = function()
  Prefab_QuestIconManager_IconDisplayCheck("WastelandLimitedQuestManager")
  SetMapMarkerVisible("WastelandLimitedQuest", false)
  GiveCollectibleNoPopup("Challenge_Perfectionist_WastelandLimited_Tracker")
  MST_South_Checkpoint(nil, "train")
  return 
end
MST_South_GremlinStructureAnimCheck = function(target, object)
  if (object == "monkeyArm") then
    if (GetGlobal("MSS_GremlinStructure_Emporium") == 1) then
      AnimGBSequence(target, "loop")
      SetPropertyBool("GremlinStructure_Emporium_Arm", "Allow Standing", false)
    end
  elseif (GetGlobal("MSS_GremlinStructure_TownHall") == 1) then
    if (object == "fireDoor1") then
      AnimGBSequence(target, "close")
    elseif (object == "fireDoor2") then
      SetPropertyFloat("meanstreetsouth_scripting.GremlinStructure_FireStation_DoorTrigger 02", "UsableRadius", 2)
      AnimGBReset(target)
      Wait(0.10000000149011612)
      AnimGBSequence(target, "broken", true)
    end
  else
    AnimGBReset(target)
    Wait(0.10000000149011612)
    AnimGBSequence(target, "broken", true)
  end
  return 
end
MST_BalloonTrigger = 0
MST_South_FastTravelBalloon = function(target, action)
  if (action == "enter") then
    if (MST_BalloonTrigger == 0) then
      FireThread(TeleportGremlinToEntity, "GremlinFastTravel", "GremlinFastTravelMarker")
    end
    MST_BalloonTrigger = (MST_BalloonTrigger + 1)
  elseif (action == "exit") then
    MST_BalloonTrigger = (MST_BalloonTrigger - 1)
    if (MST_BalloonTrigger == 0) then
      FireThread(TeleportGremlinOut, "GremlinFastTravel")
    end
  elseif (action == "load") then
    SetGlobal("MST_UtilidorsState", 2)
    MST_South_RebuildGremlinStructure()
    StartFadeOut(0.4000000059604645)
    SaveCheckpoint(GetPlayer(), nil, "MickeyCheckpointMarker1", "OswaldCheckpointMarker1")
    Wait(0.4000000059604645)
    if (GetGlobal("MSN_VisitNumber") == 1) then
      if (GetGlobal("MSN_IntroMoviePlayed") == 0) then
        LoadLevel(GetPlayer(), "MeanStreet_North.Visit_1")
      else
        LoadLevel(GetPlayer(), "MeanStreet_North.HardLoadUndermill_V1")
        if (2 <= GetGlobal("MSN_VisitNumber")) then
          LoadLevel(GetPlayer(), "MeanStreet_North.HardLoadUndermill")
        end
      end
    elseif (2 <= GetGlobal("MSN_VisitNumber")) then
      LoadLevel(GetPlayer(), "MeanStreet_North.HardLoadUndermill")
    end
  end
  return 
end
MST_South_ResetFallingPlayer = function(target)
  local activator = _activator()
  KillAIAndRescuePlayer(activator)
  if (GetHealth(activator) == 0) then
    FreezeCamera(activator)
  end
  return 
end
MST_South_GremlinRepairAnimation = function(gremlin, event1, amount, marker1, marker2, marker3, marker4)
  SetPropertyBool(gremlin, "ForceInvulnerable", true)
  SetPropertyFloat(gremlin, "UsableRadius", 0)
  SpendCurrency("ScrapMetal", tonumber(amount))
  DisableMotion(gremlin)
  DriveMotionWithPhysics(gremlin)
  TeleportGremlinToEntity(gremlin, marker2, false, false)
  AnimVarInt(gremlin, VAR_Cutscene, 1)
  AnimEvent(gremlin, EVENT_Start_Cutscene)
  Wait(0.30000001192092896)
  FireThread(MST_South_GremlinRepairOutro, gremlin, marker1)
  Wait(0.800000011920929)
  if (event1 == "pool") then
    Wait(1)
    FireThread(MST_South_RebuildPoolStructure)
  else
    FireThread(MSS_V2_RebuildGremlinStructure, event1)
  end
  return 
end
MST_South_GremlinRepairOutro = function(gremlin, marker1)
  TeleportGremlinToEntity(gremlin, marker1)
  AnimEvent(gremlin, EVENT_Force_Idle)
  FallFromAir(gremlin)
  EnableMotion(gremlin)
  SetPropertyBool(gremlin, "ForceInvulnerable", false)
  SetPropertyFloat(gremlin, "UsableRadius", 2)
  return 
end
MST_South_MickeyCullingCheck = 0
MST_South_OswaldCullingCheck = 0
MST_South_EntityCullingManage = function(character, action, group1, group2, group3, group4, group5, group6)
  if (character == GetPlayer()) then
    Print("MST_South_EntityCullingManage -target- is a player, character is fine")
  end
  Print("MST_South_EntityCullingManage -target- is not a player, setting activator to character")
  character = _activator()
  local viewport = -1
  Print(("MST_South_EntityCullingManage - MST_South_MickeyCullingCheck=" .. MST_South_MickeyCullingCheck))
  if (character == GetPlayer()) then
    if (MST_South_MickeyCullingCheck == 0) then
      viewport = 0
    else
      return 
      if (MST_South_OswaldCullingCheck == 0) then
        viewport = 1
      else
        return 
      end
    end
  elseif (character == GetPlayer2OrAI()) then
    if (MST_South_OswaldCullingCheck == 0) then
      viewport = 1
    else
      return 
    end
  end
  Print((((((("MST_South_EntityCullingManage - " .. GetName(character)) .. " performing ") .. action) .. " on viewport ") .. viewport) .. " with groups: "), group1, group2, group3, group4, group5, group6)
  if (action == "hide") then
    ForEachEntityInGroup(SetAppCulledViewport, group1, viewport)
    if (group2 ~= nil) then
      ForEachEntityInGroup(SetAppCulledViewport, group2, viewport)
    end
    if (group3 ~= nil) then
      ForEachEntityInGroup(SetAppCulledViewport, group3, viewport)
    end
    if (group4 ~= nil) then
      ForEachEntityInGroup(SetAppCulledViewport, group4, viewport)
    end
    if (group5 ~= nil) then
      ForEachEntityInGroup(SetAppCulledViewport, group5, viewport)
    end
    if (group6 ~= nil) then
      ForEachEntityInGroup(SetAppCulledViewport, group6, viewport)
    end
  elseif (action == "unhide") then
    ForEachEntityInGroup(ClearAppCulledViewport, group1, viewport)
    if (group2 ~= nil) then
      ForEachEntityInGroup(ClearAppCulledViewport, group2, viewport)
    end
    if (group3 ~= nil) then
      ForEachEntityInGroup(ClearAppCulledViewport, group3, viewport)
    end
    if (group4 ~= nil) then
      ForEachEntityInGroup(ClearAppCulledViewport, group4, viewport)
    end
    if (group5 ~= nil) then
      ForEachEntityInGroup(ClearAppCulledViewport, group5, viewport)
    end
    if (group6 ~= nil) then
      ForEachEntityInGroup(ClearAppCulledViewport, group6, viewport)
    end
  end
  return 
end
MST_South_EntityCullingCheck = function(target, action)
  local variable = "none"
  if (_activator() == GetPlayer()) then
    variable = "MST_South_MickeyCullingCheck"
  elseif (_activator() == GetPlayer2OrAI()) then
    variable = "MST_South_OswaldCullingCheck"
  end
  if (action == "enter") then
    _G[variable] = 1
  elseif (action == "exit") then
    _G[variable] = 0
  end
  return 
end
MST_South_MickeyCullingCheckAlt = 0
MST_South_OswaldCullingCheckAlt = 0
MST_South_EntityCullingCheckAlt = function(target, action, trigger)
  local variable = "none"
  local activator = _activator()
  if (activator == GetPlayer()) then
    variable = "MST_South_MickeyCullingCheckAlt"
  elseif (activator == GetPlayer2OrAI()) then
    variable = "MST_South_OswaldCullingCheckAlt"
  end
  if (trigger == "top") then
    if (_G[variable] == 0) then
      MST_South_EntityCullingManage(activator, "hide", "CullingGroup_Robot_Terrain", "CullingGroup_Robot_Geo")
    end
  elseif (trigger == "bottom") then
    if (action == "enter") then
      _G[variable] = 1
    elseif (action == "exit") then
      _G[variable] = 0
    end
  end
  return 
end
MST_South_EpisodeTwoCameraOutro = function()
  FireThread(Prefab_Projector_SetOnlySideCamera, "ProjectorToGulchLab")
  MST_AwardAmmoUpgrades("2")
  Quest_SetStatus("Operation_Gremlin", "Operation_Gremlin_2", Quest_Discovered, false)
  FireUser1("CriticalFlowHint")
  MST_South_Checkpoint(nil, "train")
  return 
end
