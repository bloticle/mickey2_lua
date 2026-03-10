NOS_BogEasy_MagicShop_AlwaysSetup = function(target)
  Print("__Function: NOS_BogEasy_MagicShop_AlwaysSetup")
  Hide(GetRelativePrefabEntity(target, ".Middle"))
  Hide(GetRelativePrefabEntity(target, ".Top"))
  Hide(GetRelativePrefabEntity(target, ".Toon"))
  Hide(GetRelativePrefabEntity(target, ".Door"))
  SetPropertyFloat("NOS_BogEasy_EnterInterior_MagicShop", "UsableRadius", 0)
  Disable("NOS_BogEasy_MagicShopDoor_OpenTrigger")
  local PrebuildSparksFreed = true
  if (GetGlobal("NOS_Sparks_OnCageBroken_Played") == -1) then
    Print("__SPARKS HAS NOT BEEN FREED YET! Will disable trigger!")
    PrebuildSparksFreed = false
  end
  if (-1 < GetGlobal("NOS_BogEasy_MagicShop_VisitOnePrebuild")) then
    Print("__First stream of the magic shop! Applying prebuild!")
    Print(("__Old BuildingProgressValue: " .. tostring(GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress"))))
    SetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress", (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress") + GetGlobal("NOS_BogEasy_MagicShop_VisitOnePrebuild")))
    Print(("__New BuildingProgressValue: " .. tostring(GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress"))))
    if (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress") == 3) then
      Print("__We already started the quest! Cap this out at 2!")
      SetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress", 2)
    end
    if (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress") == 0) then
      SetGlobal("NOS_BogEasy_SparksBuildingCharge", 0)
      Print("__Sparks will charge 100 scrap metal to repair the building!")
    elseif (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress") == 1) then
      SetGlobal("NOS_BogEasy_SparksBuildingCharge", 1)
      Print("__Sparks will charge 50 scrap metal to repair the building!")
    end
    if (GetGlobal("NOS_BogEasy_MagicShop_VisitOnePrebuild") == 3) then
      SetGlobal("NOS_BogEasy_MagicShop_VisitOnePrebuild", -2)
    else
      SetGlobal("NOS_BogEasy_MagicShop_VisitOnePrebuild", -1)
      Print("__Prebuild has been run! Will not run again!")
    end
  else
    Print("__Prebuild has been run! Will not run again!")
  end
  if (GetGlobal("NOS_BogEasy_MagicShopEligibleForUpgrade") == 2) then
    Print("__Building will upgrade as it was eligible and the zone was left!")
    SetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress", 2)
    SetGlobal("NOS_BogEasy_MagicShopEligibleForUpgrade", 0)
  end
  local BuildingProgress = GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress")
  Print(("__BuildingProgress: " .. tostring(GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingProgress"))))
  local PhotoSpotCheck = true
  if (BuildingProgress == -1) then
    Disable(GetRelativePrefabEntity(target, ".GremlinTrigger"))
  elseif (BuildingProgress ~= 0) then
    if (BuildingProgress == 1) then
      Hide(GetRelativePrefabEntity(target, ".Base"))
      Unhide(GetRelativePrefabEntity(target, ".Middle"))
    elseif (BuildingProgress == 2) then
      Hide(GetRelativePrefabEntity(target, ".Base"))
      Unhide(GetRelativePrefabEntity(target, ".Top"))
      Unhide(GetRelativePrefabEntity(target, ".Toon"))
      Unhide(GetRelativePrefabEntity(target, ".Door"))
      SetPropertyFloat("NOS_BogEasy_EnterInterior_MagicShop", "UsableRadius", 3)
      SetMapMarkerVisible("NOS_BogEasy_EnterInterior_MagicShop", true)
      Enable("NOS_BogEasy_MagicShopDoor_OpenTrigger")
      PhotoSpotCheck = false
    end
  end
  if (HasCollectible("House_Deed") == true) then
    Disable(GetRelativePrefabEntity(target, ".GremlinTrigger"))
  end
  if (PhotoSpotCheck == true) then
    wait(0.5)
    while true do
      if (not (GetPrefabData("MagicShopPhotoMarker").CheckpointFunction[1] == "Setup")) then
        break
      end
      wait(0.10000000149011612)
    end
    Print("__Disabling this spot because the building isnt built!")
    Disable(GetRelativePrefabEntity("MagicShopPhotoMarker", ".PhotoMarker"))
    DisableComponent(GetRelativePrefabEntity("MagicShopPhotoMarker", ".PhotoMarker"), "Camera Ability Target Component")
  end
  return 
end
NOS_BogEasy_MagicShop_GremlinTrigger = function(target, _State)
  Print(("__Function: NOS_BogEasy_MagicShop_TriggerEntered, _State: " .. tostring(_State)))
  if (GetGlobal("NOS_Sparks_OnCageBroken_Played") == 0) then
    FireSequence("NOS_BogEasy_Gus", "NOS_Gus_SparksBuildingHint")
  elseif (GetGlobal("NOS_BogEasy_DonaldQuest_Sparks") ~= 0) then
    if (_State == "In") then
      TeleportGremlinToEntity("NOS_BogEasy_GremlinSparks", GetRelativePrefabEntity(target, ".GremlinTeleportLocation"))
      SetGlobal("NOS_BogEasy_SparksLocation", 1)
    elseif (_State == "Out") then
      TeleportGremlinToEntity("NOS_BogEasy_GremlinSparks", "GremlinSparks_HouseMarker")
    end
  end
  return 
end
NOS_BogEasy_MagicShop_Upgrade = function(target)
  Print("__Function: NOS_BogEasy_MagicShop_Upgrade")
  SetGlobal("NOS_BogEasy_MagicShopEligibleForUpgrade", 1)
  Disable(GetRelativePrefabEntity(target, ".GremlinTrigger"))
  wait(2)
  FireSequence("NOS_BogEasy_Gus", "NOS_Gus_RemindAboutModBuilding")
  NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
  return 
end

