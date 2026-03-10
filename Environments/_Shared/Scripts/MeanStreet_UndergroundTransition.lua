Util_NorthDoorOpeningVar = 0
Util_SouthDoorOpeningVar = 0
Util_OswaldInterceptFlight = 0
Util_DoorVar = 0
MusicEventCount = 0
Util_AlwaysSetup = function()
  Print("########### Util_AlwaysSetup")
  StartFadeOut(0)
  Wait(0)
  Print("Util_AlwaysSetup")
  if (GetGlobal("Util_ComingFromNorth") == 1) then
    SetGlobal("Util_ComingFromNorth", 0)
    Print("#### Util_AlwaysSetup North teleport")
    TeleportToEntity(GetPlayer2OrAI(), "UtilMain_NorthCheckpointMarkerOs")
    Wait(0)
    TeleportToEntity(GetPlayer(), "UtilMain_NorthCheckpointMarker")
    Wait(0)
    SetPropertyFloat("Util_NorthExitTrigger", "UsableRadius", 3)
    Util_NorthExitTrackerVar1 = 1
    Util_NorthExitTrackerVar2 = 1
  else
    SetPropertyFloat("Util_SouthExitTrigger", "UsableRadius", 3)
    Util_SouthExitTrackerVar1 = 1
    Util_SouthExitTrackerVar2 = 1
  end
  if (GetGlobal("Util_TreasureDoor") == 0) then
    Util_DoorVar = 1
  elseif (GetGlobal("Util_TreasureDoor") == 1) then
    Disable("MSN_SouthDoorHeroSpot")
  end
  if (GetGlobal("Util_TopPipe") == 0) then
    StopEmitters("Util_FacePipeSteam01")
    StopEmitters("Util_FacePipeSteam03")
  end
  if (GetGlobal("Util_BottomPipe") == 0) then
    StopEmitters("Util_FacePipeSteam02")
    StopEmitters("Util_FacePipeSteam04")
  end
  if (GetGlobal("MSN_VisitNumber") == 1) then
    ActivateGremlinHint("Util_GusHint01")
  end
  if (GetGlobal("MST_Gus_DropwingIntro_Played") == 0) then
    Quest_SetCriticalPath("Critical_Underground", "Critical_Underground_2")
  end
  if (GetGlobal("MST_Jehosaphat_Offer_Played") == 0) then
    ForEachEntityInGroup(Hide, "Util_GremTechPlatformALL")
  elseif (GetGlobal("MST_Jehosaphat_Offer_Played") == 1) then
    ForEachEntityInGroup(Unhide, "Util_GremTechPlatformALL")
    ForEachEntityInGroup(DestroyEntity, "BalloonRide2All")
  end
  if (GetGlobal("Util_TreasureDoor") == 1) then
    SetSplineFollowerInitialSpeed("Util_TreasureDoorNif", 20)
    SplineFollower_StopAtPosition("Util_TreasureDoorNif", "Util_ClosetKnot01", "Util_ClosetKnot02", 1)
  end
  if (GetGlobal("MSU_AIScenario") == 0) then
    math.randomseed(os.time())
    SetGlobal("MSU_AIScenario", math.random(1, 3))
  end
  local global = GetGlobal("EM2_EpisodeCheck")
  local AI_global = GetGlobal("MSU_AIScenario")
  if (global == 1) then
    if (GetGlobal("MST_Gus_DropwingIntro_Played") == 1) then
      Print(("### Setup Scenario " .. tostring(AI_global)))
      if (AI_global == 1) then
        LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
        LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
        WaitForLevelLoad()
        Wait(1.2000000476837158)
        ForceSpawn("Util_Spawner_SouthDropwing", 1)
        Wait(0)
        ForceSpawn("Util_Spawner_NorthMelee", 1)
      elseif (AI_global == 2) then
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthDropwing")
        LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
        LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthDropwing")
        WaitForLevelLoad()
        Wait(1.2000000476837158)
        ForceSpawn("Util_Spawner_NorthDropwing", 1)
        Wait(0)
        ForceSpawn("Util_Spawner_SouthMelee", 1)
      elseif (AI_global == 3) then
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
        LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
        LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
        LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthDropwing")
        WaitForLevelLoad()
        Wait(1.2000000476837158)
        ForceSpawn("Util_Spawner_NorthDropwing", 1)
        Wait(0)
        ForceSpawn("Util_Spawner_SouthDropwing", 1)
        if (GetGlobal("MST_Gus_DropwingIntro_Played") == 0) then
          Print("Special 1 time intro")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
          WaitForLevelLoad()
          Wait(1.2000000476837158)
          ForceSpawn("Util_Spawner_SouthDropwing", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_NorthMelee", 1)
          Wait(0)
          Enable("TriggerGusDropwingWarning")
          if (global == 2) then
            Print(("### Setup Scenario " .. tostring((AI_global + 3))))
            if (AI_global == 1) then
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
              WaitForLevelLoad()
              Wait(1.2000000476837158)
              ForceSpawn("Util_Spawner_SouthDropwing", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_SouthMelee", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_NorthHerbie", 1)
            elseif (AI_global == 2) then
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
              WaitForLevelLoad()
              Wait(1.2000000476837158)
              ForceSpawn("Util_Spawner_NorthMelee", 2)
              Wait(0)
              ForceSpawn("Util_Spawner_SouthDropwing", 2)
            elseif (AI_global == 3) then
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthDropwing")
              WaitForLevelLoad()
              Wait(1.2000000476837158)
              ForceSpawn("Util_Spawner_SouthMelee", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_SouthDropwing", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_NorthMelee", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_NorthDropwing", 1)
              if (3 <= global) then
                Print(("### Setup Scenario " .. tostring((AI_global + 6))))
                if (AI_global == 1) then
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthDropwing")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
                  LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBruiser")
                  LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthHerbie")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
                  WaitForLevelLoad()
                  Wait(1.2000000476837158)
                  ForceSpawn("Util_Spawner_SouthBruiser", 1)
                  Wait(0)
                  ForceSpawn("Util_Spawner_NorthHerbie", 1)
                elseif (AI_global == 2) then
                  LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
                  LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
                  LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
                  LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBruiser")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
                  WaitForLevelLoad()
                  Wait(1.2000000476837158)
                  ForceSpawn("Util_Spawner_NorthBruiser", 1)
                  Wait(0)
                  ForceSpawn("Util_Spawner_NorthMelee", 1)
                  Wait(0)
                  ForceSpawn("Util_Spawner_SouthMelee", 2)
                  Wait(0)
                  ForceSpawn("Util_Spawner_SouthDropwing", 1)
                elseif (AI_global == 3) then
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
                  LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
                  LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBruiser")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
                  LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBruiser")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
                  LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
                  WaitForLevelLoad()
                  Wait(1.2000000476837158)
                  ForceSpawn("Util_Spawner_SouthBruiser", 1)
                  Wait(0)
                  ForceSpawn("Util_Spawner_SouthDropwing", 1)
                  Wait(0)
                  ForceSpawn("Util_Spawner_NorthBruiser", 1)
                end
              end
            end
          elseif (3 <= global) then
            Print(("### Setup Scenario " .. tostring((AI_global + 6))))
            if (AI_global == 1) then
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthDropwing")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBruiser")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
              WaitForLevelLoad()
              Wait(1.2000000476837158)
              ForceSpawn("Util_Spawner_SouthBruiser", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_NorthHerbie", 1)
            elseif (AI_global == 2) then
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
              WaitForLevelLoad()
              Wait(1.2000000476837158)
              ForceSpawn("Util_Spawner_NorthBruiser", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_NorthMelee", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_SouthMelee", 2)
              Wait(0)
              ForceSpawn("Util_Spawner_SouthDropwing", 1)
            elseif (AI_global == 3) then
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
              WaitForLevelLoad()
              Wait(1.2000000476837158)
              ForceSpawn("Util_Spawner_SouthBruiser", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_SouthDropwing", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_NorthBruiser", 1)
            end
          end
        end
      end
    elseif (GetGlobal("MST_Gus_DropwingIntro_Played") == 0) then
      Print("Special 1 time intro")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
      WaitForLevelLoad()
      Wait(1.2000000476837158)
      ForceSpawn("Util_Spawner_SouthDropwing", 1)
      Wait(0)
      ForceSpawn("Util_Spawner_NorthMelee", 1)
      Wait(0)
      Enable("TriggerGusDropwingWarning")
      if (global == 2) then
        Print(("### Setup Scenario " .. tostring((AI_global + 3))))
        if (AI_global == 1) then
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
          WaitForLevelLoad()
          Wait(1.2000000476837158)
          ForceSpawn("Util_Spawner_SouthDropwing", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_SouthMelee", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_NorthHerbie", 1)
        elseif (AI_global == 2) then
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
          WaitForLevelLoad()
          Wait(1.2000000476837158)
          ForceSpawn("Util_Spawner_NorthMelee", 2)
          Wait(0)
          ForceSpawn("Util_Spawner_SouthDropwing", 2)
        elseif (AI_global == 3) then
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthDropwing")
          WaitForLevelLoad()
          Wait(1.2000000476837158)
          ForceSpawn("Util_Spawner_SouthMelee", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_SouthDropwing", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_NorthMelee", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_NorthDropwing", 1)
          if (3 <= global) then
            Print(("### Setup Scenario " .. tostring((AI_global + 6))))
            if (AI_global == 1) then
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthDropwing")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBruiser")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
              WaitForLevelLoad()
              Wait(1.2000000476837158)
              ForceSpawn("Util_Spawner_SouthBruiser", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_NorthHerbie", 1)
            elseif (AI_global == 2) then
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
              WaitForLevelLoad()
              Wait(1.2000000476837158)
              ForceSpawn("Util_Spawner_NorthBruiser", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_NorthMelee", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_SouthMelee", 2)
              Wait(0)
              ForceSpawn("Util_Spawner_SouthDropwing", 1)
            elseif (AI_global == 3) then
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBruiser")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
              LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
              WaitForLevelLoad()
              Wait(1.2000000476837158)
              ForceSpawn("Util_Spawner_SouthBruiser", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_SouthDropwing", 1)
              Wait(0)
              ForceSpawn("Util_Spawner_NorthBruiser", 1)
            end
          end
        end
      elseif (3 <= global) then
        Print(("### Setup Scenario " .. tostring((AI_global + 6))))
        if (AI_global == 1) then
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthDropwing")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBruiser")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
          WaitForLevelLoad()
          Wait(1.2000000476837158)
          ForceSpawn("Util_Spawner_SouthBruiser", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_NorthHerbie", 1)
        elseif (AI_global == 2) then
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
          WaitForLevelLoad()
          Wait(1.2000000476837158)
          ForceSpawn("Util_Spawner_NorthBruiser", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_NorthMelee", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_SouthMelee", 2)
          Wait(0)
          ForceSpawn("Util_Spawner_SouthDropwing", 1)
        elseif (AI_global == 3) then
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
          WaitForLevelLoad()
          Wait(1.2000000476837158)
          ForceSpawn("Util_Spawner_SouthBruiser", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_SouthDropwing", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_NorthBruiser", 1)
        end
      end
    end
  elseif (global == 2) then
    Print(("### Setup Scenario " .. tostring((AI_global + 3))))
    if (AI_global == 1) then
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
      WaitForLevelLoad()
      Wait(1.2000000476837158)
      ForceSpawn("Util_Spawner_SouthDropwing", 1)
      Wait(0)
      ForceSpawn("Util_Spawner_SouthMelee", 1)
      Wait(0)
      ForceSpawn("Util_Spawner_NorthHerbie", 1)
    elseif (AI_global == 2) then
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
      WaitForLevelLoad()
      Wait(1.2000000476837158)
      ForceSpawn("Util_Spawner_NorthMelee", 2)
      Wait(0)
      ForceSpawn("Util_Spawner_SouthDropwing", 2)
    elseif (AI_global == 3) then
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthDropwing")
      WaitForLevelLoad()
      Wait(1.2000000476837158)
      ForceSpawn("Util_Spawner_SouthMelee", 1)
      Wait(0)
      ForceSpawn("Util_Spawner_SouthDropwing", 1)
      Wait(0)
      ForceSpawn("Util_Spawner_NorthMelee", 1)
      Wait(0)
      ForceSpawn("Util_Spawner_NorthDropwing", 1)
      if (3 <= global) then
        Print(("### Setup Scenario " .. tostring((AI_global + 6))))
        if (AI_global == 1) then
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthDropwing")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBruiser")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
          WaitForLevelLoad()
          Wait(1.2000000476837158)
          ForceSpawn("Util_Spawner_SouthBruiser", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_NorthHerbie", 1)
        elseif (AI_global == 2) then
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
          WaitForLevelLoad()
          Wait(1.2000000476837158)
          ForceSpawn("Util_Spawner_NorthBruiser", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_NorthMelee", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_SouthMelee", 2)
          Wait(0)
          ForceSpawn("Util_Spawner_SouthDropwing", 1)
        elseif (AI_global == 3) then
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBruiser")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
          LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
          WaitForLevelLoad()
          Wait(1.2000000476837158)
          ForceSpawn("Util_Spawner_SouthBruiser", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_SouthDropwing", 1)
          Wait(0)
          ForceSpawn("Util_Spawner_NorthBruiser", 1)
        end
      end
    end
  elseif (3 <= global) then
    Print(("### Setup Scenario " .. tostring((AI_global + 6))))
    if (AI_global == 1) then
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthDropwing")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBruiser")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBruiser")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
      WaitForLevelLoad()
      Wait(1.2000000476837158)
      ForceSpawn("Util_Spawner_SouthBruiser", 1)
      Wait(0)
      ForceSpawn("Util_Spawner_NorthHerbie", 1)
    elseif (AI_global == 2) then
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBlotworx")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBlotworx")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBruiser")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBruiser")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
      WaitForLevelLoad()
      Wait(1.2000000476837158)
      ForceSpawn("Util_Spawner_NorthBruiser", 1)
      Wait(0)
      ForceSpawn("Util_Spawner_NorthMelee", 1)
      Wait(0)
      ForceSpawn("Util_Spawner_SouthMelee", 2)
      Wait(0)
      ForceSpawn("Util_Spawner_SouthDropwing", 1)
    elseif (AI_global == 3) then
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthBlotworx")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthDropwing")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.SouthBlotworx")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.NorthBruiser")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusActive("MeanStreetsUtilidors.SouthBruiser")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthHerbie")
      LevelManager_SetZoneStatusUnloaded("MeanStreetsUtilidors.NorthDropwing")
      WaitForLevelLoad()
      Wait(1.2000000476837158)
      ForceSpawn("Util_Spawner_SouthBruiser", 1)
      Wait(0)
      ForceSpawn("Util_Spawner_SouthDropwing", 1)
      Wait(0)
      ForceSpawn("Util_Spawner_NorthBruiser", 1)
    end
  end
  local str_MostRecentCheckpointCallback = tostring(MostRecentCheckpointCallback)
  if (str_MostRecentCheckpointCallback ~= "UtilNorth1_LoadCheckpoint") then
    if (str_MostRecentCheckpointCallback ~= "UtilSouth2_LoadCheckpoint") then
      if (str_MostRecentCheckpointCallback ~= "UtilSouth3_LoadCheckpoint") then
        if (MusicEventCount == 0) then
          Print("Util_AlwaysSetup: Started UTD music event")
          MusicPostEventOn(GetPlayer(), "Play_MX_UTD")
          RemoveAllMusicStateOverride()
          MusicEventCount = 1
        end
      end
    end
  end
  if (GetGlobal("MSN_GremlinPartsBin1") == 2) then
    if (GetGlobal("MSN_GremlinPartsBin1") == 2) then
      SetGlobal("MSN_GremlinPartsBin1", 3)
    end
    if (GetGlobal("MSN_GremlinPartsBin2") == 2) then
      SetGlobal("MSN_GremlinPartsBin2", 3)
    end
    if (GetGlobal("MSN_GremlinPartsBin3") == 2) then
      SetGlobal("MSN_GremlinPartsBin3", 3)
    end
    if (GetGlobal("MSN_GremlinPartsBin4") == 2) then
      SetGlobal("MSN_GremlinPartsBin4", 3)
    end
    if (GetGlobal("MSN_GremlinPartsBin5") == 2) then
      SetGlobal("MSN_GremlinPartsBin5", 3)
    end
    Prefab_ScrapMetalSpawner_Launch("Util_FallingScrapSpawner")
  end
  SetCombatIntensityBias(-100)
  Print("Util_AlwaysSetup: Disabled combat music")
  StartFadeIn(0.800000011920929)
  local interior = string.sub(tostring(LevelManager_GetCurrentInterior()), 22, -1)
  if (interior ~= "vault") then
    if (interior ~= "propellerbox") then
      if (interior ~= "rotatebridges") then
        CameraReset()
      end
    end
  end
  return 
end
Util_PneumaticTubesToMS = function(target, action)
  if (action == nil) then
    action = target
    SetPropertyFloat((("To" .. action) .. "_ElevatorButton"), "UsableRadius", 0)
    RestrictCutSceneInput()
    StartFadeOut(0.4000000059604645)
    wait(0.4000000059604645)
    wait(0)
    OswaldStopMovingAction()
    wait(0)
    SetPropertyInt(("PneumaticTube_To" .. action), "Collision Layer", 13)
    SetPropertyInt(("MST_Pneumatic_To" .. action), "Collision Layer", 13)
    wait(0)
    TeleportToEntity(GetPlayer(), (("PM_To" .. action) .. "_Mickey"))
    TeleportToEntity(GetPlayer2OrAI(), (("PM_To" .. action) .. "_Oswald"))
    EnableSplitScreen(false)
    GrabCamera(("MST_Pneumatic_Camera_To" .. action), nil, CAMERA_INSTANT_TRANSITION, 0)
    StartFadeIn(0.4000000059604645)
    wait(1)
    AnimGBSequence(("MST_Pneumatic_To" .. action), "Close")
    wait(1.2000000476837158)
    StartFadeOut(0.4000000059604645)
    SetGlobal("MSU_AIScenario", 0)
    SetGlobal("MSU_PneumaticTubesToMS", GetPrefabData((("To" .. action) .. "_ElevatorButton")).RoomNum)
    wait(0.4000000059604645)
    SetPropertyFloat((("To" .. action) .. "_ElevatorButton"), "UsableRadius", 2)
    EnableSplitScreen(true)
    ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
    UnrestrictCutSceneInput()
    OswaldStartMovingAction()
    local CurrentInterior = tostring(LevelManager_GetCurrentInterior())
    Print(("Util_PneumaticTubesToMS: CurrentInterior = " .. CurrentInterior))
    if (CurrentInterior == "meanstreetsutilidors.vault") then
      SaveCheckpointNoPosition(nil, "UtilNorth1_LoadCheckpoint")
    elseif (CurrentInterior == "meanstreetsutilidors.rotatebridges") then
      SaveCheckpointNoPosition(nil, "UtilSouth2_LoadCheckpoint")
    elseif (CurrentInterior == "meanstreetsutilidors.propellerbox") then
      SaveCheckpointNoPosition(nil, "UtilSouth3_LoadCheckpoint")
    end
    wait(0.30000001192092896)
    if (action == "North") then
      if (2 <= GetGlobal("MSN_VisitNumber")) then
        if (GetGlobal("MSN_VisitNumber") == 1) then
          SetGlobal("MSN_VisitNumber", 2)
        end
        LoadLevel(GetPlayer(), (("MeanStreet_" .. action) .. ".HardLoadUndermill"))
      end
    elseif (action == "North") then
      if (GetGlobal("MSN_VisitNumber") == 1) then
        LoadLevel(GetPlayer(), (("MeanStreet_" .. action) .. ".HardLoadUndermill_V1"))
      end
    elseif (action == "South") then
      LoadLevel(GetPlayer(), (("MeanStreet_" .. action) .. ".Visit1"))
      local playerNum, playerNum = 1, LoadLevel
      playerNum = _activator
      playerNum = playerNum()
      if (playerNum == GetPlayer2()) then
        playerNum = 2
      end
      playerNum = FireSequence
      playerNum("Gus", ("MST_Gus_TubeTo" .. action), playerNum)
    end
  else
    local playerNum = 1
    playerNum = _activator
    playerNum = playerNum()
    if (playerNum == GetPlayer2()) then
      playerNum = 2
    end
    playerNum = FireSequence
    playerNum("Gus", ("MST_Gus_TubeTo" .. action), playerNum)
  end
  return 
end
MST_Utilidors_OpenTreasureDoor = function()
  Enable("mst_utilidors_01a_transition_scripting.TreasureDoorHack")
  ForEachEntityInGroup(StopEmitters, "SteamJets")
  wait(1)
  OswaldHackAction("mst_utilidors_01a_transition_scripting.TreasureDoorHack")
  return 
end
MST_Utilidors_CloseTreasureDoor = function()
  Disable("mst_utilidors_01a_transition_scripting.TreasureDoorHack")
  ForEachEntityInGroup(StartEmitters, "SteamJets")
  return 
end
MST_Utilidors_AtSouthSide = true
MST_Utilidors_TriggerBalloonRide = function()
  SetSplineFollowerInitialSpeed("BalloonRide2", 3)
  return 
end
MST_Utilidors_TeleportGremlin = function()
  wait(1)
  if (MST_Utilidors_AtSouthSide == true) then
    TeleportGremlinToEntity("GremlinJehosaphat", "mst_utilidors_01a_transition_scripting.PositionMarkerGremlinSouth")
  elseif (MST_Utilidors_AtSouthSide == false) then
    TeleportGremlinToEntity("GremlinJehosaphat", "mst_utilidors_01a_transition_scripting.PositionMarkerGremlinNorth")
  end
  return 
end
MST_Utilidors_OswaldBeginGlide02 = function()
  OswaldTossAction()
  return 
end
MST_Utilidors_OswaldBeginGlide01 = function()
  OswaldSetPathAction("Util_OswaldGlideStart01")
  return 
end
UtilTransition_GusRescue = function()
  if (GetGlobal("Util_GremlinFreed") == 0) then
    if (GetGlobal("MST_Gus_RescueGremlins_Played") == 0) then
      FireSequence("Util_Transition_Gus", "MST_Gus_RescueGremlins")
    end
  end
  return 
end
Util_FreeTheGremlin = function(state)
  if (state == "Intro") then
    FireUser1("Util_GremCamStarter")
    wait(0.4000000059604645)
    OswaldStopMovingAction()
    MoveToEntity(GetPlayer(), "PM_FreedGremlin_MickeyPos")
    MoveToEntity(GetPlayer2OrAI(), "PM_FreedGremlin_OswaldPos")
  elseif (state == "StartBalloons") then
    FireThread(MST_Utilidors_TriggerBalloonRide)
    GrabCamera("mst_utilidors_01a_transition_scripting.FreeGremlinCam02.FancyCameraEnd 01", nil, CAMERA_LERP_TRANSITION, 8)
  elseif (state == "Outro") then
    Util_TeleportScrumpetOut()
    FireUser3("Util_GremCamStarter")
  end
  return 
end
UtilMain_Central_CP = 0
Util_NorthSaveTracker = 0
Util_SouthSaveTracker = 0
Util_ClothSave = function()
  UtilMain_Central_CP = 1
  SaveCheckpoint(GetPlayer(), "UtilMain_LoadCheckpoint", "UtilMain_SouthCheckpointMarker")
  Wait(5)
  UtilMain_Central_CP = 0
  return 
end
UtilMain_SouthCentralCheckPoint = function()
  Util_SouthSaveTracker = 1
  if (UtilMain_Central_CP == 0) then
    UtilMain_Central_CP = 1
    if (Util_SouthSaveTracker == 1) then
      if (Util_NorthSaveTracker == 1) then
        SaveCheckpoint(GetPlayer(), "UtilMain_LoadCheckpoint", "UtilMain_SouthCheckpointMarker02")
      end
    else
      SaveCheckpoint(GetPlayer(), "UtilMain_LoadCheckpoint", "UtilMain_SouthCheckpointMarker")
    end
    Wait(5)
    UtilMain_Central_CP = 0
  end
  return 
end
UtilMain_NorthCentralCheckPoint = function()
  if (GetGlobal("MSN_UndergroundCP_3") == 0) then
    Quest_SetCriticalPath("Critical_Underground", "Critical_Underground_3")
    SetGlobal("MSN_UndergroundCP_3", 1)
  end
  Util_NorthSaveTracker = 1
  if (UtilMain_Central_CP == 0) then
    UtilMain_Central_CP = 1
    if (Util_SouthSaveTracker == 1) then
      if (Util_NorthSaveTracker == 1) then
        SaveCheckpoint(GetPlayer(), "UtilMain_LoadCheckpoint", "UtilMain_NorthCheckpointMarker02")
      end
    else
      SaveCheckpoint(GetPlayer(), "UtilMain_LoadCheckpoint", "UtilMain_NorthCheckpointMarker")
    end
    Wait(5)
    UtilMain_Central_CP = 0
  end
  return 
end
UtilMain_LoadCheckpoint = function()
  Print("##### CP TEST #####")
  SetPlayStyleScoreBias(0)
  Print("Loaded into UTD main checkpoint - reset PlayStyleScoreBias so no music plays")
  return 
end
UtilSideLock_North_OswaldToNode02 = function()
  OswaldSetPathAction("UtilSideLock_North_OswaldNode02")
  return 
end
UtilSideLock_North_OswaldToNode01 = function()
  OswaldSetPathAction("UtilSideLock_North_OswaldNode01")
  return 
end
Util_OswaldStartFollow = function()
  OswaldStartFollowAction()
  return 
end
UtilNorthsideLock_GearVar01 = 0
UtilNorthsideLock_GearVar02 = 0
UtilNorthSideLock_GearSpin02 = function()
  OswaldSpinAction("UtilNorthSideLock_Gear01")
  UtilNorthsideLock_GearVar02 = 1
  SetRotatorMaxSpeed("UtilNorthSideLock_Gear02", 350)
  UtilNorthSideLock_GearMaster()
  return 
end
UtilNorthSideLock_GearSpin01 = function()
  OswaldSpinAction("UtilNorthSideLock_Gear02")
  UtilNorthsideLock_GearVar01 = 1
  SetRotatorMaxSpeed("UtilNorthSideLock_Gear01", 350)
  UtilNorthSideLock_GearMaster()
  return 
end
UtilNorthSideLock_GearMaster = function()
  if (UtilNorthsideLock_GearVar01 == 1) then
    if (UtilNorthsideLock_GearVar02 == 1) then
      AnimGBSequence("UtilSideAirlock1_ExitDoor01", "Anim")
      Disable("UtilNorthSideLock_Gear02")
      Disable("UtilNorthSideLock_Gear01")
      ForEachEntityInGroup(AnimGBSequence, "UtilSouthDoorAll", "ReverseAnim")
      UtilMain_NorthCentralCheckPoint()
      UtilNorthsideLock_GearVar01 = 2
      UtilNorthsideLock_GearVar01 = 2
    end
  end
  Wait(0.5)
  SetRotatorMaxSpeed("UtilNorthSideLock_Gear02", 0)
  SetRotatorMaxSpeed("UtilNorthSideLock_Gear01", 0)
  if (UtilNorthsideLock_GearVar01 ~= 2) then
    UtilNorthsideLock_GearVar01 = 0
    UtilNorthsideLock_GearVar02 = 0
  end
  return 
end
UtilNorthElevator_Gear01Var = 0
UtilNorthElevator_Gear02Var = 0
UtilNorthElevator_Gear02Check = function()
  Util_DoorOpenCloseTracker = 1
  if (Util_AllowOswaldToSpin == 1) then
    OswaldSpinAction("UtilNorthElevator_Gear02")
  end
  if (UtilNorthElevator_Gear02Var == 0) then
    UtilNorthElevator_Gear02Var = 1
    UtilNorthElevator_GearDoorMaster()
  end
  return 
end
UtilNorthElevator_Gear01Check = function()
  Util_DoorOpenCloseTracker = 1
  if (Util_AllowOswaldToSpin == 1) then
    OswaldSpinAction("UtilNorthElevator_Gear01")
  end
  if (UtilNorthElevator_Gear01Var == 0) then
    UtilNorthElevator_Gear01Var = 1
    UtilNorthElevator_GearDoorMaster()
  end
  return 
end
UtilNorthElevator_Gear02Reset = function()
  UtilNorthElevator_Gear02Var = 0
  return 
end
UtilNorthElevator_Gear01Reset = function()
  UtilNorthElevator_Gear01Var = 0
  return 
end
UtilNorthElevator_GearDoorMaster = function()
  if (GetGlobal("MST_Jehosaphat_Offer_Played") == 0) then
    FireSequence("Util_Transition_Gus", "MST_Gus_RescueRepeat")
  end
  if (Util_NorthDoorOpeningVar == 0) then
    Print("Util_NorthDoorOpeningVar is 0")
    if (UtilNorthElevator_Gear01Var == 1) then
      if (UtilNorthElevator_Gear02Var == 1) then
        Print("### North gears spun check")
        Util_NorthDoorOpeningVar = 1
        Util_SouthDoorOpeningVar = 0
        Util_AllowOswaldToSpin = 0
        WaitForLevelLoad()
        StreamInterior(nil, "NorthAirLock")
        WaitForLevelLoad()
        Disable("Util_NorthGearCameraTrigger")
        ClearCameraAttributes("MSN_NorthGearCamera")
        Enable("Util_SouthGearCameraTrigger")
        AnimGBSequence("UtilNorth_BlastDoor", "Anim")
        AnimGBSequence("UtilSouth_BlastDoor", "ReverseAnim")
        Disable("UtilNorth_GearTrigger01")
        Disable("UtilNorth_GearTrigger02")
        Enable("UtilSouthElevator_Gear01")
        Enable("UtilSouthElevator_Gear02")
        Enable("UtilSouth_GearTrigger01")
        Enable("UtilSouth_GearTrigger02")
      end
    end
    Wait(0.5)
    UtilNorthElevator_Gear01Var = 0
    UtilNorthElevator_Gear02Var = 0
  end
  return 
end
UtilSouthElevator_Gear01Var = 0
UtilSouthElevator_Gear02Var = 0
Util_AllowOswaldToSpin = 0
Util_OswaldIsAllowedSpin = function()
  Util_AllowOswaldToSpin = 1
  return 
end
Util_OswaldNotAllowedToSpin = function()
  Util_AllowOswaldToSpin = 0
  return 
end
UtilSouthElevator_Gear02Check = function()
  Util_DoorOpenCloseTracker = 1
  Print("####### UtilSouthElevator_Gear02Check")
  if (Util_AllowOswaldToSpin == 1) then
    OswaldSpinAction("UtilSouthElevator_Gear02")
  end
  if (UtilSouthElevator_Gear02Var == 0) then
    UtilSouthElevator_Gear02Var = 1
    UtilSouthElevator_GearDoorMaster()
  end
  return 
end
UtilSouthElevator_Gear01Check = function()
  Util_DoorOpenCloseTracker = 1
  Print("####### UtilSouthElevator_Gear01Check")
  if (Util_AllowOswaldToSpin == 1) then
    OswaldSpinAction("UtilSouthElevator_Gear01")
  end
  if (UtilSouthElevator_Gear01Var == 0) then
    UtilSouthElevator_Gear01Var = 1
    UtilSouthElevator_GearDoorMaster()
  end
  return 
end
UtilSouthElevator_Gear02Reset = function()
  UtilSouthElevator_Gear02Var = 0
  return 
end
UtilSouthElevator_Gear01Reset = function()
  UtilSouthElevator_Gear01Var = 0
  return 
end
UtilSouthElevator_GearDoorMaster = function()
  Print("###### UtilSouthElevator_GearDoorMaster")
  if (Util_SouthDoorOpeningVar == 0) then
    Print("Util_SouthDoorOpeningVar is zero")
    if (UtilSouthElevator_Gear01Var == 1) then
      if (UtilSouthElevator_Gear02Var == 1) then
        Print("##### South gears checked")
        Util_NorthDoorOpeningVar = 0
        Util_SouthDoorOpeningVar = 1
        Util_AllowOswaldToSpin = 0
        WaitForLevelLoad()
        StreamInterior(nil, "SouthAirLock")
        WaitForLevelLoad()
        ClearCameraAttributes("MSN_SouthGearCamera")
        Disable("Util_SouthGearCameraTrigger")
        Enable("Util_NorthGearCameraTrigger")
        ForEachEntityInGroup(SetRotatorMaxSpeed, "UtilSouth_LevelArrow", 120)
        ForEachEntityInGroup(StartRotateToPosition, "UtilSouth_LevelArrow", 180)
        Print("###### UtilSouthElevator_GearDoorMaster PASSED")
        AnimGBSequence("UtilSouth_BlastDoor", "Anim")
        AnimGBSequence("UtilNorth_BlastDoor", "ReverseAnim")
        Disable("UtilSouth_GearTrigger01")
        Disable("UtilSouth_GearTrigger02")
        Enable("UtilNorthElevator_Gear01")
        Enable("UtilNorthElevator_Gear02")
        Enable("UtilNorth_GearTrigger01")
        Enable("UtilNorth_GearTrigger02")
      end
    end
    Wait(0.5)
    UtilSouthElevator_Gear01Var = 0
    UtilSouthElevator_Gear02Var = 0
  end
  return 
end
UtilNorth_GotoGear01 = function()
  OswaldSetPathAction("UtilNorth_OswaldNode01")
  return 
end
UtilNorth_GotoGear02 = function()
  OswaldSetPathAction("UtilNorth_OswaldNode02")
  return 
end
UtilSouth_GotoGear01 = function()
  OswaldSetPathAction("UtilSouth_OswaldNode01")
  return 
end
UtilSouth_GotoGear02 = function()
  OswaldSetPathAction("UtilSouth_OswaldNode02")
  return 
end
UtilTrans_OpenNorthExitdoor = function()
  AnimGBSequence("UtilSideAirlock2_ExitDoor01", "Anim")
  return 
end
UtilTrans_CloseNorthExitDoor = function()
  AnimGBSequence("UtilSideAirlock2_ExitDoor01", "ReverseAnim")
  return 
end
Util_OswaldGlideSpot2 = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_NoSupport, GetPosition("Util_OswaldGlideNode02"))
  return 
end
Util_Balloon01_OswaldStandNear = function()
  OswaldOverrideFollowingDistance(GetOswaldAI(), 1.5)
  return 
end
Util_Balloon01_OswaldStandClear = function()
  OswaldClearOverrideFollowingDistance()
  return 
end
Util_GusDropWingWarning = function()
  if (GetGlobal("MST_Gus_DropwingIntro_Played") == 0) then
    Wait(0.10000000149011612)
    FireSequence("Util_Transition_Gus", "MST_Gus_DropwingIntro")
  end
  return 
end
Util_VaultExitOpen = function()
  SetSplineFollowerInitialSpeed("Util_MainHallVaultExitDoor", 3)
  SplineFollower_StopAtPosition("Util_MainHallVaultExitDoor", "Util_VaultDoorKnot01", "Util_VaultDoorKnot02", 1)
  Disable("MSN_NorthHiddenOswaldSpot")
  return 
end
Util_VaultExitClose = function()
  SetSplineFollowerInitialSpeed("Util_MainHallVaultExitDoor", 5)
  SplineFollower_StopAtPosition("Util_MainHallVaultExitDoor", "Util_VaultDoorKnot01", "Util_VaultDoorKnot02", 0)
  Enable("MSN_NorthHiddenOswaldSpot")
  return 
end
Util_TeleportScrumpetOut = function()
  FireThread(TeleportGremlinOut, "GremlinJehosaphat")
  FireThread(UtilMain_NorthCentralCheckPoint)
  return 
end
Util_ChargePayment = function()
  SpendCurrency("ETicket", 50)
  return 
end
Util_DelBalloon = function()
  ForEachEntityInGroup(DestroyEntity, "BalloonRide2All")
  return 
end
Util_SpinDoorGear = function(target)
  SetRotatorMaxSpeed(target, 350)
  Wait(1.5)
  SetRotatorMaxSpeed(target, 0)
  return 
end
Util_SpinDoorGear02 = function(target)
  SetRotatorMaxSpeed(target, 350)
  Wait(1.5)
  SetRotatorMaxSpeed(target, 0)
  return 
end
Util_OswaldGlideWait = function()
  Print("Util_OswaldGlideWait")
  if (GetGlobal("MST_Gus_CoopGlideTutorial_Played") == 0) then
    Print("Util_OswaldGlideWait played")
    ForceSequence("Util_GusExitConvoMarker", "MST_Gus_CoopGlideTutorial")
  end
  return 
end
Util_DeathCamera = function()
  FreezeCamera()
  return 
end
Util_SouthOswaldBouncerVar = 0
Util_SouthMickeyBouncerVar = 0
Util_NorthOswaldBouncerVar = 0
Util_NorthMickeyBouncerVar = 0
Util_Bouncer = function(target, side)
  Print("##### BOUNCER HIT")
  if (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
    Print("##########$$$$$$$$$$$$$ OSWALD ENTERED BOUNCER TRIGGER")
    if (side == "South") then
      Util_SouthOswaldBouncerVar = 1
      Util_BouncerMaster(target, side)
    elseif (side == "North") then
      Util_NorthOswaldBouncerVar = 1
      Util_BouncerMaster(target, side)
      if (GetName(_activator()) == GetName(GetPlayer())) then
        Print("##########$$$$$$$$$$$$$ Mickey ENTERED BOUNCER TRIGGER")
        if (side == "South") then
          Util_SouthMickeyBouncerVar = 1
          Util_BouncerMaster(target, side)
        elseif (side == "North") then
          Util_NorthMickeyBouncerVar = 1
          Util_BouncerMaster(target, side)
        end
      end
    end
  elseif (GetName(_activator()) == GetName(GetPlayer())) then
    Print("##########$$$$$$$$$$$$$ Mickey ENTERED BOUNCER TRIGGER")
    if (side == "South") then
      Util_SouthMickeyBouncerVar = 1
      Util_BouncerMaster(target, side)
    elseif (side == "North") then
      Util_NorthMickeyBouncerVar = 1
      Util_BouncerMaster(target, side)
    end
  end
  return 
end
Util_Bouncer_Reset = function(target, side)
  Print("##### BOUNCER RESET HIT")
  if (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
    Print("##########$$$$$$$$$$$$$ OSWALD EXITED BOUNCER RESET TRIGGER")
    if (side == "South") then
      Util_SouthOswaldBouncerVar = 0
    elseif (side == "North") then
      Util_NorthOswaldBouncerVar = 0
      if (GetName(_activator()) == GetName(GetPlayer())) then
        Print("##########$$$$$$$$$$$$$ Mickey EXITED BOUNCER RESET TRIGGER")
        if (side == "South") then
          Util_SouthMickeyBouncerVar = 0
        elseif (side == "North") then
          Util_NorthMickeyBouncerVar = 0
        end
      end
    end
  elseif (GetName(_activator()) == GetName(GetPlayer())) then
    Print("##########$$$$$$$$$$$$$ Mickey EXITED BOUNCER RESET TRIGGER")
    if (side == "South") then
      Util_SouthMickeyBouncerVar = 0
    elseif (side == "North") then
      Util_NorthMickeyBouncerVar = 0
    end
  end
  return 
end
Util_BouncerMaster = function(target, side)
  Print(("###################### Bouncer Side " .. side))
  if (side == "South") then
    if (Util_SouthOswaldBouncerVar == 1) then
      if (Util_SouthMickeyBouncerVar == 1) then
        Print("#### BOUNCER STREAM SOUTH")
        SetSplineFollowerInitialSpeed("Util_MainHallVaultExitDoor", 30)
        SplineFollower_StopAtPosition("Util_MainHallVaultExitDoor", "Util_VaultDoorKnot01", "Util_VaultDoorKnot02", 0)
        AnimGBSequence("UtilSideAirlock2_ExitDoor01", "ReverseAnim")
        AnimGBSequence("UtilSideAirlock1_ExitDoor01", "ReverseAnim")
        Wait(2)
        StreamInterior(nil, "SouthAirLock")
      end
    end
  elseif (side == "North") then
    if (Util_NorthOswaldBouncerVar == 1) then
      if (Util_NorthMickeyBouncerVar == 1) then
        Print("#### BOUNCER STREAM NORTH")
        SetSplineFollowerInitialSpeed("Util_MainHallVaultExitDoor", 30)
        SplineFollower_StopAtPosition("Util_MainHallVaultExitDoor", "Util_VaultDoorKnot01", "Util_VaultDoorKnot02", 0)
        AnimGBSequence("UtilSideAirlock2_ExitDoor01", "ReverseAnim")
        AnimGBSequence("UtilSideAirlock1_ExitDoor01", "ReverseAnim")
        Wait(2)
        StreamInterior(nil, "NorthAirLock")
      end
    end
  end
  return 
end
Util_HardLoad_South = function()
  if (2 <= GetGlobal("EM2_EpisodeCheck")) then
    if (GetGlobal("MSN_VisitNumber") == 1) then
      SetGlobal("MSN_VisitNumber", 2)
    end
  end
  SetGlobal("MSU_AIScenario", 0)
  SetGlobal("MSN_GusHintVar", 0)
  StartFadeOut(0.800000011920929)
  SaveCheckpoint(GetPlayer(), "UtilMain_LoadCheckpoint", "UtilMain_SouthCheckpointMarker")
  Wait(1)
  UnrestrictCutSceneInput()
  LoadLevel(GetPlayer(), "MeanStreet_South.Visit1")
  return 
end
Util_HardLoadNorthStart = function()
  ForceSequence("Util_Transition_Gus", "MST_Gus_ExitElevators")
  return 
end
Util_HardLoadSouthStart = function()
  ForceSequence("Util_Transition_Gus", "MST_Gus_ExitElevators02")
  return 
end
Util_HardLoad_North = function()
  if (2 <= GetGlobal("EM2_EpisodeCheck")) then
    if (GetGlobal("MSN_VisitNumber") == 1) then
      SetGlobal("MSN_VisitNumber", 2)
    end
  end
  SetGlobal("MSU_AIScenario", 0)
  SetGlobal("MSN_GusHintVar", 0)
  RestrictCutSceneInput()
  StartFadeOut(0.800000011920929)
  SaveCheckpoint(GetPlayer(), "UtilMain_LoadCheckpoint", "UtilMain_NorthCheckpointMarker", "UtilMain_NorthCheckpointMarkerOs")
  Wait(1)
  UnrestrictCutSceneInput()
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
  return 
end
Util_PauseAI = function()
  PauseAllAI()
  return 
end
Util_UnpauseAI = function()
  UnpauseAllAI()
  ShowHud()
  return 
end
Util_SouthGlideKicker = function()
  if (GetGlobal("MSN_UndergroundGlide") == 0) then
    FireSequence("Util_Transition_Gus", "Generic_Gus_Maybeglide")
    SetGlobal("MSN_UndergroundGlide", 1)
  end
  Disable("Util_SouthPreGlide")
  Enable("Util_SouthSecondGlide")
  return 
end
Util_NorthGlideKicker = function()
  Disable("MSN_NorthPreGlide")
  Enable("Util_NorthGlide")
  return 
end
Util_SouthGlideStart = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Wait_For_Attach, GetPosition("Util_NorthGlide"))
  return 
end
Util_TopPipePainted = function()
  SetGlobal("Util_TopPipe", 0)
  Util_CloseCloset()
  return 
end
Util_BottomPipePainted = function()
  SetGlobal("Util_BottomPipe", 0)
  Util_CloseCloset()
  return 
end
Util_PipeMaster = function()
  if (GetGlobal("Util_TopPipe") == 1) then
    if (GetGlobal("Util_BottomPipe") == 1) then
      Disable("MSN_SouthDoorHeroSpot")
      Util_DoorVar = 0
      SetGlobal("Util_TreasureDoor", 1)
      SetSplineFollowerInitialSpeed("Util_TreasureDoorNif", 1)
      SplineFollower_StopAtPosition("Util_TreasureDoorNif", "Util_ClosetKnot01", "Util_ClosetKnot02", 1)
    end
  end
  return 
end
Util_BottomPipeThinned = function()
  SetGlobal("Util_BottomPipe", 1)
  Wait(0)
  Util_PipeMaster()
  return 
end
Util_TopPipeThinned = function()
  SetGlobal("Util_TopPipe", 1)
  Wait(0)
  Util_PipeMaster()
  return 
end
Util_CloseCloset = function()
  if (Util_DoorVar == 0) then
    Util_DoorVar = 1
    SetGlobal("Util_TreasureDoor", 0)
    SetSplineFollowerInitialSpeed("Util_TreasureDoorNif", 2)
    SplineFollower_StopAtPosition("Util_TreasureDoorNif", "Util_ClosetKnot01", "Util_ClosetKnot02", 0)
    Enable("Util_ClosetKBTrigger")
    Wait(3)
    Disable("Util_ClosetKBTrigger")
    Enable("MSN_SouthDoorHeroSpot")
  end
  return 
end
Util_ClosetKnockback = function(target)
  Print("################ Touched KB Trigger")
  StimulusEntityWithAliasInEntityDirectionInRadius("Util_ClosetKBTrigger", ST_KNOCKBACK, 10, 0, target, "Util_ClosetMarker", "")
  return 
end
Util_NorthExitTrackerVar1 = 0
Util_NorthExitTrackerVar2 = 0
Util_Player1NorthExitCheck = function()
  if (GetNumPlayers() == 2) then
    Util_NorthExitTrackerVar1 = 1
    UtilNorthExitMaster()
  else
    SetPropertyFloat("Util_NorthExitTrigger", "UsableRadius", 3)
  end
  return 
end
Util_Player2NorthExitCheck = function()
  if (GetNumPlayers() == 2) then
    Util_NorthExitTrackerVar2 = 1
    UtilNorthExitMaster()
  else
    SetPropertyFloat("Util_NorthExitTrigger", "UsableRadius", 3)
  end
  return 
end
UtilPlayer2NorthExit_Leave = function()
  SetPropertyFloat("Util_NorthExitTrigger", "UsableRadius", 0)
  Util_NorthExitTrackerVar2 = 0
  return 
end
UtilPlayer1NorthExit_Leave = function()
  SetPropertyFloat("Util_NorthExitTrigger", "UsableRadius", 0)
  Util_NorthExitTrackerVar1 = 0
  return 
end
UtilNorthExitMaster = function()
  if (Util_NorthExitTrackerVar1 == 1) then
    if (Util_NorthExitTrackerVar2 == 1) then
      SetPropertyFloat("Util_NorthExitTrigger", "UsableRadius", 3)
    end
  elseif (Util_NorthExitTrackerVar1 == 1) then
    if (Util_NorthExitTrackerVar2 == 0) then
      ForceSequence("Util_MickeyExitDialogue", "Util_Mickey_BeckonExit")
    end
  elseif (Util_NorthExitTrackerVar1 == 0) then
    if (Util_NorthExitTrackerVar2 == 1) then
      ForceSequence("Util_OswaldExitDialogue", "Util_Oswald_BeckonExit")
    end
  end
  return 
end
Util_SouthExitTrackerVar1 = 0
Util_SouthExitTrackerVar2 = 0
Util_Player1SouthExitCheck = function()
  if (GetNumPlayers() == 2) then
    Util_SouthExitTrackerVar1 = 1
    UtilSouthExitMaster()
  else
    SetPropertyFloat("Util_SouthExitTrigger", "UsableRadius", 3)
  end
  return 
end
Util_Player2SouthExitCheck = function()
  if (GetNumPlayers() == 2) then
    Util_SouthExitTrackerVar2 = 1
    UtilSouthExitMaster()
  else
    SetPropertyFloat("Util_SouthExitTrigger", "UsableRadius", 3)
  end
  return 
end
UtilPlayer2SouthExit_Leave = function()
  SetPropertyFloat("Util_SouthExitTrigger", "UsableRadius", 0)
  Util_SouthExitTrackerVar2 = 0
  return 
end
UtilPlayer1SouthExit_Leave = function()
  SetPropertyFloat("Util_SouthExitTrigger", "UsableRadius", 0)
  Util_SouthExitTrackerVar1 = 0
  return 
end
UtilSouthExitMaster = function()
  if (Util_SouthExitTrackerVar1 == 1) then
    if (Util_SouthExitTrackerVar2 == 1) then
      SetPropertyFloat("Util_SouthExitTrigger", "UsableRadius", 3)
    end
  elseif (Util_SouthExitTrackerVar1 == 1) then
    if (Util_SouthExitTrackerVar2 == 0) then
      ForceSequence("Util_MickeyExitDialogue", "Util_Mickey_BeckonExit")
    end
  elseif (Util_SouthExitTrackerVar1 == 0) then
    if (Util_SouthExitTrackerVar2 == 1) then
      ForceSequence("Util_OswaldExitDialogue", "Util_Oswald_BeckonExit")
    end
  end
  return 
end
Util_ResetFallingPlayer = function(target)
  KillAIAndRescuePlayer(_activator())
  return 
end
Util_ChestSaveNoPosition = function()
  SaveCheckpointNoPosition(nil, "UtilMain_LoadCheckpoint")
  return 
end
Util_DisableGremlinMapMarker = function()
  SetMapMarkerVisible(GetRelativePrefabEntity("GremlinJehosaphat", ".MapMarker"), false)
  return 
end
MST_Utilidors_CoOpTossManage = function(target, action)
  Print("***MST_Utilidors_CoOpTossManage")
  if (action == "paint") then
    Enable("MST_Utilidors_SideTossMarker")
    ForEachEntityInGroup(Unhide, "HiddenOswald_CoOpToss01")
  elseif (action == "thin") then
    Disable("MST_Utilidors_SideTossMarker")
    ForEachEntityInGroup(Hide, "HiddenOswald_CoOpToss01")
  end
  return 
end

