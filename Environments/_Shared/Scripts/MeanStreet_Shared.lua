MSN_NorthUtilGlobalflip = function()
  SetGlobal("Util_ComingFromNorth", 1)
  SetGlobal("MST_GremlinStructure_Entered", 0)
  Wait(0)
  FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_UndergroundPrompt", 1)
  return 
end
MST_AccessUtilidors = function(target, value)
  SetGlobal("MST_GremlinStructure_Entered", value)
  Wait(0.10000000149011612)
  FireSequence("EM2_MSTN_GusConvoTrigger", "MSN_Gus_UndergroundPrompt", 1)
  return 
end
MST_EnterUtilidors = function(target)
  StartFadeOut(0.5)
  Wait(0.5)
  SetGlobal("MSN_GusHintVar", 0)
  if (1 <= GetGlobal("MSN_Quest_3Pigs_State")) then
    if (1 <= GetGlobal("RF_CompletedV1")) then
      SetGlobal("MSN_HideFiferOrNot", 1)
    end
  end
  SetGlobal("MST_UtilidorsState", 1)
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  RestrictCutSceneInput()
  local global = GetGlobal("MST_GremlinStructure_Entered")
  local part = ""
  if (global < 4) then
    if (-4 < global) then
      if (global == 1) then
        part = "RotateBridges"
      end
      if (global == 2) then
        part = "PropellerBox"
      end
      if (global == 3) then
        part = "Vault"
      end
      if (global == 0) then
        if (2 <= GetGlobal("EM2_EpisodeCheck")) then
          if (GetGlobal("MSN_VisitNumber") == 1) then
            SetGlobal("MSN_VisitNumber", 2)
          end
        end
        part = "NorthAirLock"
      end
    end
  else
    if (global == 4) then
      part = "RotateBridges"
    end
    if (global == 5) then
      part = "PropellerBox"
    end
    if (global == 6) then
      part = "Vault"
    end
    if (global == 7) then
      if (GetGlobal("MSS_VisitNumber") == 1) then
        SetGlobal("MSS_VisitNumber", 2)
      end
      part = "SouthAirLock"
    end
    FireThread(MST_South_RebuildGremlinStructure)
    SetGlobal("MST_UtilidorsState", 1)
  end
  AudioPostEventOn(GetPlayer(), "Stop_MX_MSS")
  AudioPostEventOn(GetPlayer(), "Stop_MX_MSN")
  SaveCheckpointNoPosition(GetPlayer())
  wait(1.25)
  Print(("Part number is " .. part))
  Print(("Global number is " .. global))
  UnrestrictCutSceneInput()
  if (global == 7) then
    if (GetGlobal("EM2_EpisodeCheck") == 1) then
      LoadLevel(GetPlayer(), "MeanStreetsUtilidors.TransitionEp1")
    elseif (GetGlobal("EM2_EpisodeCheck") == 2) then
      LoadLevel(GetPlayer(), "MeanStreetsUtilidors.TransitionEp2")
    elseif (3 <= GetGlobal("EM2_EpisodeCheck")) then
      LoadLevel(GetPlayer(), "MeanStreetsUtilidors.TransitionEp3")
      LoadLevel(GetPlayer(), (("MeanStreetsUtilidors." .. part) .. "_HardLoad"))
    end
  end
  LoadLevel(GetPlayer(), (("MeanStreetsUtilidors." .. part) .. "_HardLoad"))
  return 
end
MST_AwardAmmoUpgrades = function(episode)
  if (episode == "2") then
    if (GetGlobal("FriendlyDragonPin_Redeemed") == 1) then
      GiveCollectible("Friendly_Dragon")
      GiveCollectible("Paint_Upgrade_Dragon")
    elseif (GetGlobal("RingofFirePin_Destroyed") == 1) then
      GiveCollectible("Ring_of_fire")
      GiveCollectible("Thinner_Upgrade_Dragon")
    end
    GiveCollectible("Electric_Upgrade_Dragon")
    SetGlobal("EM2_UpgradesCollected", 1)
    MST_South_Checkpoint(nil, "train")
  elseif (episode == "3") then
    if (GetGlobal("SecondChancePin_Redeemed") == 1) then
      GiveCollectible("Paint_Upgrade_Prescott")
    elseif (GetGlobal("NapComplexPin_Destroyed") == 1) then
      GiveCollectible("Thinner_Upgrade_Prescott")
    end
    GiveCollectible("Electric_Upgrade_Prescott")
    SetGlobal("EM2_UpgradesCollected", 2)
    MST_South_Checkpoint(nil, "train")
  elseif (episode == "4") then
    if (GetGlobal("Extras_Mad_Doctor_Redemption") == 1) then
      GiveCollectible("Trust_the_Mad_Doctor")
      GiveCollectible("Paint_Upgrade_MadDoc")
    elseif (GetGlobal("Extras_Mad_Doctor_Redemption") == 0) then
      GiveCollectible("Down_with_the_Mad_Doctor")
      GiveCollectible("Thinner_Upgrade_MadDoc")
    end
    GiveCollectible("Electric_Upgrade_MadDoc")
    SetGlobal("EM2_UpgradesCollected", 3)
    SaveCheckpoint(GetPlayer(), "MSN_LoadCheckPoint", "EM2_NorthStartMarker", "EM2_NorthStartMarkerOswald")
  end
  return 
end
MS_BeginTrainRide = function()
  RestrictCutSceneInput()
  StartFadeOut(0.4000000059604645)
  wait(0.4000000059604645)
  TeleportToEntity(GetPlayer(), "meanstreetnorth_main.TrainRideExitMarker")
  SetCameraAttributes("meanstreetnorth_main.TrainCameraMarker")
  SetSplineFollowerInitialSpeed("meanstreetnorth_main.Traincar", 2)
  StartFadeIn(0.4000000059604645)
  wait(25)
  StartFadeOut(0.4000000059604645)
  wait(0.4000000059604645)
  SetSplineFollowerInitialSpeed("meanstreetnorth_main.Traincar", 0)
  SplineFollower_TeleportToKnot("meanstreetnorth_main.Traincar", "meanstreetnorth_main.SplineKnot 02")
  CameraReset()
  StartFadeIn(0.4000000059604645)
  wait(0.4000000059604645)
  UnrestrictCutSceneInput()
  return 
end
Gallery_FindRandomNumber = function(number)
  local randomindex = math.random(number)
  randomindex = math.random(number)
  return randomindex
end
Gallery_RandomIndex = function(number)
  local spawnvar = 0
  if (10 < Gallery_FindRandomNumber(number)) then
    spawnvar = 1
  end
  return spawnvar
end
Gallery_RandomMultiSpawn = function(number)
  local times_tospawn = 1
  if (95 < Gallery_FindRandomNumber(number)) then
    times_tospawn = 2
  end
  return times_tospawn
end
TempGameStart = function()
  if (GetGlobal("PA_GameActive") == 0) then
    SetGlobal("PA_GameActive", 1)
    Gallery_SpawnCubes()
  end
  return 
end
TempGameEnd = function()
  SetGlobal("PA_GameActive", 0)
  return 
end
Gallery_StartGame = function()
  StartFadeOut(0.4000000059604645)
  wait(0.4000000059604645)
  TeleportToEntity(GetPlayer(), "gamegallery.GamePlayerMarker")
  DisableMovementInput(GetPlayer())
  wait(0.10000000149011612)
  StartFadeIn(0.4000000059604645)
  wait(5)
  TimerStart(45)
  TimerEnable("gamegallery.GalleryGameTimer")
  SetGlobal("PA_GameActive", 1)
  Gallery_SpawnCubes()
  return 
end
Gallery_EndGame = function()
  RestrictCutSceneInput()
  SetGlobal("PA_GameActive", 0)
  ForceSequence("gamegallery.Paulie", "MSS_PaulieEndGame")
  wait(4)
  StartFadeOut(0.4000000059604645)
  wait(0.4000000059604645)
  SetCameraAttributes("meanstreetnorth_main.GameGalleryOverride")
  StartFadeIn(0.4000000059604645)
  EnableMovementInput(GetPlayer())
  return 
end
Gallery_SpawnCubes = function()
  if (GetGlobal("PA_GameActive") == 1) then
    SetPropertyInt("gamegallery.CubeSpawner", "Index To Spawn", Gallery_RandomIndex(20))
    ForceSpawn("gamegallery.CubeSpawner", 1)
    wait(1.25)
    SetPropertyInt("gamegallery.CubeSpawner2", "Index To Spawn", Gallery_RandomIndex(20))
    ForceSpawn("gamegallery.CubeSpawner2", 1)
    wait(1.25)
    Gallery_SpawnCubes()
  end
  return 
end
ScoreCube = function(cube, goal)
  local groupname = GetPropertyString(cube, "EntityGroups", 0)
  if (goal == "up") then
    if (groupname == "gamegallery.FriendCube") then
      SetGlobal("PA_GalleryScore", (GetGlobal("PA_GalleryScore") + 1), true)
    end
    if (groupname == "gamegallery.EnemyCube") then
      SetGlobal("PA_GalleryScore", (GetGlobal("PA_GalleryScore") - 1), true)
    end
  end
  if (goal == "down") then
    if (groupname == "gamegallery.FriendCube") then
      SetGlobal("PA_GalleryScore", (GetGlobal("PA_GalleryScore") - 1), true)
    end
    if (groupname == "gamegallery.EnemyCube") then
      SetGlobal("PA_GalleryScore", (GetGlobal("PA_GalleryScore") + 1), true)
    end
  end
  Print(GetGlobal("PA_GalleryScore"))
  DestroyEntity(cube)
  return 
end
EM2_MS_SitTest = function(target)
  AnimEvent(target, "EVENT_Start_WatchTV")
  return 
end
EM2_MS_Beetles01 = 0
EM2_MS_BeetleworxGroup01 = function()
  ForEachEntityInGroup(Unhide, "EM2_MS_MetalGroup1")
  EM2_MS_Beetles01 = 1
  return 
end
EM2_MS_BeetleworxGroup02 = function()
  ForEachEntityInGroup(Unhide, "EM2_MS_MetalGroup2")
  EM2_MS_Beetles01 = 2
  return 
end
