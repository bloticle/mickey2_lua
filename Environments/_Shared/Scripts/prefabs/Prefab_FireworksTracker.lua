Prefab_FireworksTracker_AlwaysSetup = function(target)
  Print("__Function: Prefab_FireworksTracker_AlwaysSetup")
  local data = GetPrefabData(target)
  Disable(data.ActionMarkerEntityGroupName)
  return 
end
Prefab_FireworksTracker_Trigger = function(target, _EnterOrExit)
  Print(("__Function: Prefab_FireworksTracker_Trigger, _EnterOrExit: " .. tostring(_EnterOrExit)))
  local data = GetPrefabData(target)
  local numElements = (#data.TrackedFireworks)
  Print(("__NumElements: " .. tostring(numElements)))
  if (_EnterOrExit == "Enter") then
    if (numElements == 1) then
      if (data.TrackedFireworks[1] == "None") then
        Print("__Adding First Firework to the list!")
        data.TrackedFireworks[reg_13] = GetName(_activator())
      end
    else
      Print("__List was not empty! Adding at next available spot")
      table.insert(data.TrackedFireworks, GetName(_activator()))
      if (_EnterOrExit == "Exit") then
        if (numElements == 1) then
          Print("__We only have one element, resetting the table!")
          data.TrackedFireworks[reg_13] = "None"
          Disable(data.ActionMarkerEntityGroupName)
        else
          Print("__List bigger than one! Removing appropriate firework!")
          for x = 1, numElements do
            if (data.TrackedFireworks[x] == GetName(_activator())) then
              Print((("__Found matching fireworks activator at: [" .. tostring(x)) .. "], will remove this one!"))
              table.remove(data.TrackedFireworks, x)
            end
          end
        end
      end
    end
  elseif (_EnterOrExit == "Exit") then
    if (numElements == 1) then
      Print("__We only have one element, resetting the table!")
      data.TrackedFireworks[reg_13] = "None"
      Disable(data.ActionMarkerEntityGroupName)
    else
      Print("__List bigger than one! Removing appropriate firework!")
      for x = 1, numElements do
        if (data.TrackedFireworks[x] == GetName(_activator())) then
          Print((("__Found matching fireworks activator at: [" .. tostring(x)) .. "], will remove this one!"))
          table.remove(data.TrackedFireworks, x)
        end
      end
    end
  end
  numElements = (#data.TrackedFireworks)
  Print("__Current Tracked Fireworks:")
  for x = 1, numElements do
    x = x
    x = "]: "
    Print(((("__Tracked Fireworks[" .. tostring(x)) .. x) .. tostring(data.TrackedFireworks[x])))
  end
  return 
end
Prefab_FireworksTracker_ShockFireworks = function(target)
  Print("__Function: Prefab_FireworksTracker_ShockFireworks")
  return 
end
Prefab_FireworksTracker_DisableCompletely = function(target)
  Print("__Function: (FIREUSER1) Prefab_FireworksTracker_DisableCompletely")
  local data = GetPrefabData(target)
  DestroyEntity(data.ActionMarkerEntityGroupName)
  DestroyEntity(GetRelativePrefabEntity(target, ".FireworksTrigger"))
  return 
end

