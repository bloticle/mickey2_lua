Prefab_ObservatoryItemSetup = function(target)
  local data = GetPrefabData(target)
  local global = GetGlobal(data.GlobalToCheck)
  if (1 < global) then
    Print("+_+_+_+_+_+_+_+ Prefab_ObservatoryItemSetup: Hiding observatory object")
    Hide(GetRelativePrefabEntity(target, ".ObservatoryItemPickup"))
  end
  if (1 <= global) then
    if (2 <= global) then
      SetMapMarkerVisible(GetRelativePrefabEntity(target, ".ObservatoryItemMarker"), false)
    end
    if (data.SetupFunction == "None") then
      Print("+_+_+_+_+_+_+_+ Prefab_ObservatoryItemSetup: No setup function for the Observatory object has been defined")
    else
      Print("+_+_+_+_+_+_+_+ Prefab_ObservatoryItemSetup: Setting up observatory object")
      FireThread(_G[data.SetupFunction])
      local marker = GetRelativePrefabEntity(target, ".ObservatoryItemMarker")
      local StageID = tostring(GetPropertyString(marker, "MapMarkerQuestStageID"))
      Print(("+_+_+_+_+_+_+_+ Prefab_ObservatoryItemSetup: StageID = " .. StageID))
      if (GetGlobal("MSS_ObservatoryItem_Copernicus") < GetGlobal("MSS_ObservatoryItem_Laralee")) then
        Print((("+_+_+_+_+_+_+_+ Prefab_ObservatoryItemSetup: Player has perfered Laralee more than Copernicus so StageID = " .. StageID) .. "b"))
        SetPropertyString(marker, "MapMarkerQuestStageID", (StageID .. "b"), 0)
      else
        Print((("+_+_+_+_+_+_+_+ Prefab_ObservatoryItemSetup: Player has perfered Copernicus more than Laralee, or they are equal, so StageID = " .. StageID) .. "a"))
        SetPropertyString(marker, "MapMarkerQuestStageID", (StageID .. "a"), 0)
      end
    end
  else
    local marker = GetRelativePrefabEntity(target, ".ObservatoryItemMarker")
    local StageID = tostring(GetPropertyString(marker, "MapMarkerQuestStageID"))
    Print(("+_+_+_+_+_+_+_+ Prefab_ObservatoryItemSetup: StageID = " .. StageID))
    if (GetGlobal("MSS_ObservatoryItem_Copernicus") < GetGlobal("MSS_ObservatoryItem_Laralee")) then
      Print((("+_+_+_+_+_+_+_+ Prefab_ObservatoryItemSetup: Player has perfered Laralee more than Copernicus so StageID = " .. StageID) .. "b"))
      SetPropertyString(marker, "MapMarkerQuestStageID", (StageID .. "b"), 0)
    else
      Print((("+_+_+_+_+_+_+_+ Prefab_ObservatoryItemSetup: Player has perfered Copernicus more than Laralee, or they are equal, so StageID = " .. StageID) .. "a"))
      SetPropertyString(marker, "MapMarkerQuestStageID", (StageID .. "a"), 0)
    end
  end
  return 
end
Prefab_ObservatoryItemCollect = function(target)
  local data = GetPrefabData(target)
  Print("+_+_+_+_+_+_+_+ Prefab_ObservatoryItem: Observatory object collected, user defined variable set to 2")
  SetGlobal(data.GlobalToCheck, 2)
  SetMapMarkerVisible(GetRelativePrefabEntity(target, ".ObservatoryItemMarker"), false)
  if (data.CollectibleItem ~= "None") then
    GiveCollectible(data.CollectibleItem)
  else
    Print("+_+_+_+_+_+_+_+ Prefab_ObservatoryItem: Observatory object was not defined. Designer needs to declare the CollectibleItem override.")
  end
  if (Quest_CheckStatus("Watch_the_Skies", "Watch_the_Skies_11", Quest_Discovered) == true) then
    FireSequence(GetRelativePrefabEntity(target, ".ObservatoryItemMarker"), data.ActiveSequence)
  else
    FireSequence(GetRelativePrefabEntity(target, ".ObservatoryItemMarker"), "Global_Gus_ObservatoryItem")
    Wait(0.5)
    if (data.CheckpointFunction[1] == "function") then
      Print("***************************** - Prefab_ObservatoryItem: No checkpoint function declared. Not saving!")
    elseif (data.CheckpointFunction[2] == "parameter1") then
      FireThread(_G[data.CheckpointFunction[1]])
    elseif (data.CheckpointFunction[3] == "parameter2") then
      FireThread(_G[data.CheckpointFunction[1]], data.CheckpointFunction[2])
    else
      FireThread(_G[data.CheckpointFunction[1]], data.CheckpointFunction[2], data.CheckpointFunction[3])
    end
  end
  return 
end
Prefab_ObservatoryItemActivate = function(reg_0)
end
Prefab_ObservatoryItemQuestUpdate = function(item, target)
  target = _self()
  local data = GetPrefabData(target)
  if (3 <= GetGlobal("MSS_ObservatoryItem_Laralee")) then
    Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. tostring(item)) .. "b"), Quest_TurnIn, true)
  elseif (3 <= GetGlobal("MSS_ObservatoryItem_Copernicus")) then
    Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. tostring(item)) .. "a"), Quest_TurnIn, true)
  else
    Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. tostring(item)) .. "a"), Quest_TurnIn, true)
    Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. tostring(item)) .. "b"), Quest_TurnIn, false)
  end
  Wait(0.5)
  if (data.CheckpointFunction[1] == "function") then
    Print("***************************** - Prefab_ObservatoryItem: No checkpoint function declared. Not saving!")
  elseif (data.CheckpointFunction[2] == "parameter1") then
    FireThread(_G[data.CheckpointFunction[1]])
  elseif (data.CheckpointFunction[3] == "parameter2") then
    FireThread(_G[data.CheckpointFunction[1]], data.CheckpointFunction[2])
  else
    FireThread(_G[data.CheckpointFunction[1]], data.CheckpointFunction[2], data.CheckpointFunction[3])
  end
  return 
end

