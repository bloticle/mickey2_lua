AddItemSpark = function(target)
  local data = GetPrefabData(target)
  Print(("***************************** - AddItemSpark() Current count: " .. GetGlobal("PowerSparks")))
  SetGlobal(data.Global[1], 1)
  FireSequence(target, "MSS_GusPickedUpSpark")
  AudioPostEventOn(GetPlayer(), "Play_sfx_Pickup_PowerSpark")
  return 
end
DestroyItemSpark = function(target)
  local data = GetPrefabData(target)
  if (data.Global[1] ~= "None") then
    if (GetGlobal(data.Global[1]) == 1) then
      Print((("***************************** - DestroyItemSpark() - " .. data.Global[1]) .. " already picked up"))
      Print(("Destroying " .. GetGlobal(data.Global[1])))
      DestroyEntity(GetRelativePrefabEntity(target, ".WorldPickupEffect"))
      DestroyEntity(GetRelativePrefabEntity(target, ".WorldPickupAnim"))
      DestroyEntity(target)
    end
  end
  return 
end
Prefab_WorldItem_CP_Check = function(target)
  Print("***************************** - Prefab_WorldItem_CP_Check")
  local data = GetPrefabData(target)
  if (GetGlobal(data.Global[1]) == 1) then
    DestroyItemSpark(target)
  else
    AudioPostEventOn(target, "Play_sfx_QuestItem_Amb")
  end
  if (data.UseGlobalNotCollectibleOnCPReload == "false") then
    if HasCollectible(data.Collectible[2]) then
      if (data.Collectible[1] == "ConceptArt") then
        DestroyEntity(target)
      end
    end
  end
  if (data.StartHidden == "True") then
    Hide(GetRelativePrefabEntity(target, ".WorldPickupEffect"))
    Hide(target)
  end
  return 
end
Prefab_WorldItem_Pickup = function(target)
  Print("***************************** - Prefab_WorldItem_Pickup")
  local data = GetPrefabData(target)
  if (data.Global[2] == "Solo") then
    SetGlobal(data.Global[1], 1)
  elseif (data.Global[2] == "Incremental") then
    IncrementGlobal(data.Global[1])
  elseif (data.Global[2] ~= "None") then
    SetGlobal(data.Global[1], tonumber(data.Global[2]))
  end
  local playerNum = 1
  if (_activator() == GetPlayer2()) then
    playerNum = 2
  end
  if (data.Sequence[1] ~= "None") then
    ForceSequence(data.Sequence[1], data.Sequence[2], playerNum)
  end
  if (data.Collectible[1] ~= "None") then
    Print(((("__Collectible: " .. tostring(data.Collectible[2])) .. " will be given as type: ") .. tostring(data.Collectible[1])))
    if (data.Collectible[1] == "QuestItem") then
      if (data.CollectibleBanner == "True") then
        GiveCollectible(data.Collectible[2])
      else
        Print("__CollectibleBanner overridden to false!")
        GiveCollectibleNoPopup(data.Collectible[2])
        if (data.Collectible[1] == "ConceptArt") then
          if (data.CollectibleBanner == "True") then
            GiveCollectible(data.Collectible[2])
          else
            Print("__CollectibleBanner overridden to false!")
            GiveCollectibleNoPopup(data.Collectible[2])
          end
        end
      end
    elseif (data.Collectible[1] == "ConceptArt") then
      if (data.CollectibleBanner == "True") then
        GiveCollectible(data.Collectible[2])
      else
        Print("__CollectibleBanner overridden to false!")
        GiveCollectibleNoPopup(data.Collectible[2])
      end
    end
  end
  DestroyEntity(GetRelativePrefabEntity(target, ".WorldPickupEffect"))
  AudioPostEventOn(target, "Stop_sfx_QuestItem_Amb")
  AudioPostEventOn(target, "Play_sfx_ui_quest_item_received")
  if (data.EndFunction ~= "None") then
    if (data.EndFunctionParam1 == "None") then
      FireThread(_G[data.EndFunction])
    else
      FireThread(_G[data.EndFunction], tostring(data.EndFunctionParam1))
    end
  end
  return 
end
Prefab_WorldItem_Unhide = function(target)
  Print("***************************** - Prefab_WorldItem_Unhide")
  Unhide(target)
  Unhide(GetRelativePrefabEntity(target, ".WorldPickupEffect"))
  return 
end
