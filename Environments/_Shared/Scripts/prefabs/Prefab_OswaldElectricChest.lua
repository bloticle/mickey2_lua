BlueChestSpawnedChild = "none"
BlueChestCurrentPrefab = "none"
Prefab_Oswald_Open_Chest = function(target)
  local ShockerName = target
  local data = GetPrefabData(ShockerName)
  Print("Oswald shocker is opening a chest.")
  Print(GetName(ShockerName))
  Print(GetName(target))
  OswaldStreamAbort()
  Prefab_Open_Chest(target)
  return 
end
OswaldChestDisable = function(target)
  local data = GetPrefabData(target)
  Print("Trying to diable chest.")
  Print(data.TreasureMarker)
  local chest = GetRelativePrefabEntity(target, ".Chest")
  Print(chest)
  local subdata = GetPrefabData(chest)
  Print(subdata.TreasureMarker)
  if (subdata.TreasureMarker == ".OswaldChest") then
    Print("Action Spot is now disabled.")
    local OswaldActionSpot = GetRelativePrefabEntity(target, ".OswaldChest_ActionSpot")
    SetPropertyBool(OswaldActionSpot, "ActionSpotEnabled", false)
  end
  return 
end
Prefab_OswaldChestSetupCheck = function(target)
  local chest = GetRelativePrefabEntity(target, ".Chest")
  local subdata = GetPrefabData(chest)
  Print(("Prefab_OswaldChestSetupCheck: The global for the chest is currently set at : " .. GetGlobal(subdata.GlobalToCheck)))
  if (GetGlobal(subdata.GlobalToCheck) == 1) then
    Prefab_OswaldElectricSwitch_ChangeState(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), "FullyCharged")
  end
  return 
end
Prefab_OswaldChestItemPickup = function(target)
  local PrefabName = target
  Print("PrefabName: ")
  local data = GetPrefabData(PrefabName)
  if (data.Collectible == "Bronze_Pin") then
    GiveCurrencyItem("Bronze_Pin", 1)
  elseif (data.Collectible == "Silver_Pin") then
    GiveCurrencyItem("Silver_Pin", 1)
  elseif (data.Collectible == "Gold_Pin") then
    GiveCurrencyItem("Gold_Pin", 1)
  else
    GiveCollectible(data.Collectible)
  end
  if (data.GlobalToCheck ~= "None") then
    SetGlobal(data.GlobalToCheck, (GetGlobal(data.GlobalToCheck) + 1))
  end
  if (data.CostumeGlobal ~= "none") then
    if (GetGlobal(data.CostumeGlobal) < 1) then
      SetGlobal(data.CostumeGlobal, 1)
    end
  end
  Wait(0)
  if (data.EndFunction ~= "none") then
    Print("*********************** Oswald_Open_Chest(): data.EndFunction != none")
    if (data.EndFunctionParam2 ~= "None") then
      FireThread(_G[data.EndFunction], data.EndFunctionParam1, data.EndFunctionParam2)
    elseif (data.EndFunctionParam1 ~= "None") then
      FireThread(_G[data.EndFunction], data.EndFunctionParam1)
    else
      FireThread(_G[data.EndFunction])
    end
  end
  return 
end
Prefab_Oswald_LaunchItem = function(target)
  Print("************************************* - LaunchingItem")
  local LaunchDirection = (GetPosition(GetRelativePrefabEntity(target, ".Patrol_Node")) - GetPosition(target))
  LaunchDirection:normalize3()
  ApplyImpulse(target, 0, 5, 0)
  Disable(GetRelativePrefabEntity(target, ".OL_Trigger"))
  Prefab_OswaldRumble_LeaveTrigger(target, GetPlayer2())
  Wait(1)
  DestroyEntity(target)
  Print("************************************* - DestroyEntity(target)")
  return 
end
Prefab_OswaldShocker_OswaldStream = function(target)
  ClearNextPatrolNode(GetPlayer2OrAI())
  Wait(0.25)
  OswaldStreamAction(GetRelativePrefabEntity(target, ".OswaldSwitchTimersLogicTimer"))
  return 
end
Prefab_MickeyNearOswaldBlueChest = function(target, direction)
  Print("In the action trigger")
  Print("This is the target: ")
  Print(target)
  Print("This is the direction: ")
  Print(direction)
  local chest = GetRelativePrefabEntity(target, ".OswaldChest")
  local chestPrefab = GetPrefabData(chest)
  if (chestPrefab.ChestOpened ~= true) then
    Print("Trying to get the chest open.")
    if (direction == "in") then
      Print("Made it in!")
      ClearNextPatrolNode(GetPlayer2OrAI())
      Wait(0.25)
      OswaldStreamAction(GetRelativePrefabEntity(target, ".OswaldSwitchTimersLogicTimer"))
    elseif (direction == "out") then
      OswaldStreamAbort()
      Print("Chest already opened.  Doing nothing.")
    end
  else
    Print("Chest already opened.  Doing nothing.")
  end
  return 
end
