local AlwaysSetupCalled = false
Prefab_FireworksManager_AlwaysSetup = function(target)
  Print("__Function: Prefab_FireworksManager_AlwaysSetup")
  local data = GetPrefabData(target)
  ForEachEntityInGroup(DisableMotion, data.FireworkAvailableAreas[1])
  AlwaysSetupCalled = true
  return 
end
Prefab_FireworksManager_SetCurrentZone = function(target, _Zone)
  Print(("__Function: Prefab_FireworksManager_SetCurrentZone, _Zone: " .. tostring(_Zone)))
  while true do
    if (not (AlwaysSetupCalled == false)) then
      break
    end
    Print("__AlwaysSetupCalled is false! Shouldnt be setting a state until everything is disabled")
    wait(0.20000000298023224)
  end
  local data = GetPrefabData(target)
  Print((("__Will set all fireworks in zone " .. tostring(_Zone)) .. " as Enabled!"))
  if (_Zone == "A") then
    ForEachEntityInGroup(EnableMotion, data.FireworkAvailableAreas[2])
  elseif (_Zone == "B") then
    ForEachEntityInGroup(EnableMotion, data.FireworkAvailableAreas[3])
  end
  return 
end
Prefab_FireworksManager_StreamZoneOut = function(target, _Zone)
  Print(("__Function: Prefab_FireworksManager_StreamZoneOut, _Zone: " .. tostring(_Zone)))
  local data = GetPrefabData(target)
  if (_Zone == "A") then
    ForEachEntityInGroup(Prefab_FireworksManager_CheckFireworks, tostring(data.FireworkAvailableAreas[2]), target, "StreamOut")
  elseif (_Zone == "B") then
    ForEachEntityInGroup(Prefab_FireworksManager_CheckFireworks, tostring(data.FireworkAvailableAreas[3]), target, "StreamOut")
  end
  return 
end
Prefab_FireworksManager_StreamZoneIn = function(target, _Zone)
  Print(("__Function: Prefab_FireworksManager_StreamZoneIn, _Zone: " .. tostring(_Zone)))
  local data = GetPrefabData(target)
  if (_Zone == "A") then
    ForEachEntityInGroup(Prefab_FireworksManager_CheckFireworks, tostring(data.FireworkAvailableAreas[2]), target, "StreamIn")
  elseif (_Zone == "B") then
    ForEachEntityInGroup(Prefab_FireworksManager_CheckFireworks, tostring(data.FireworkAvailableAreas[3]), target, "StreamIn")
  end
  return 
end
Prefab_FireworksManager_CheckFireworks = function(Entity, PrefabTarget, _Status)
  Print(("__Function: Prefab_FireworksManager_ChangeZone, _Status: " .. tostring(_Status)))
  local data = GetPrefabData(PrefabTarget)
  Print(("__Target checking against list: " .. tostring(GetName(Entity))))
  local numElements = (#data.TrackedFireworks)
  for x = 1, numElements do
    if (GetName(Entity) == data.TrackedFireworks[x]) then
      Print("__We're part of the fireworks list! Don't do anything...we're in the airlock!")
    elseif (_Status == "StreamOut") then
      Print("__Will disable this firework!")
      DisableMotion(Entity)
    else
      Print("__Will enable this firework!")
      EnableMotion(Entity)
    end
  end
  return 
end
Prefab_FireworksManager_FireworksTrigger = function(target, _Direction, _TriggerNum)
  Print(((("__Function: Prefab_FireworksManager_FireworksTrigger, _Direction: " .. tostring(_Direction)) .. ", _TriggerNum: ") .. tostring(_TriggerNum)))
  local data = GetPrefabData(target)
  local numElements = (#data.TrackedFireworks)
  local FireworksSection = "-1"
  if (_TriggerNum ~= "-1") then
    FireworksSection = GetPropertyString(_activator(), "EntityGroups", 1)
  end
  Print(("__FireworksSection: " .. tostring(FireworksSection)))
  if (_Direction == "Enter") then
    Print("__Fireworks entered trigger, will add this to the list")
    if (numElements == 1) then
      if (data.TrackedFireworks[1] == "None") then
        Print("__ List was empty! Adding to [1]")
        data.TrackedFireworks[reg_20] = GetName(_activator())
      end
    else
      Print("__ List was not empty! adding to next available slot")
      table.insert(data.TrackedFireworks, GetName(_activator()))
      if (_Direction == "Exit") then
        Print("__Fireworks left trigger, will remove this from the list")
        if (numElements == 1) then
          Print("__We only have one element, resetting the table!")
          data.TrackedFireworks[reg_20] = "None"
        else
          for x = 1, numElements do
            if (data.TrackedFireworks[x] == GetName(_activator())) then
              Print((("__BTA_Airlock: Found matching fireworks activator at: [" .. tostring(x)) .. "], will remove this one!"))
              table.remove(data.TrackedFireworks, x)
            end
          end
        end
        if (_TriggerNum ~= "-1") then
          if (FireworksSection ~= data.FireworkAvailableAreas[tonumber(_TriggerNum)]) then
            Print(("__BTA_Airlock: Fireworks Section num doesnt match the current door it's exiting! Changing to Section: " .. tostring(data.FireworkAvailableAreas[tonumber(_TriggerNum)])))
            SetPropertyString(_activator(), "EntityGroups", tostring(data.FireworkAvailableAreas[tonumber(_TriggerNum)]), 1)
            Print(("__BTA_Airlock: New EntityGroup for this firework: " .. tostring(GetPropertyString(_activator(), "EntityGroups", 1))))
          end
        else
          Print("__BTA_Airlock: _DoorNum was -1! This firework was destroyed")
        end
      end
    end
  elseif (_Direction == "Exit") then
    Print("__Fireworks left trigger, will remove this from the list")
    if (numElements == 1) then
      Print("__We only have one element, resetting the table!")
      data.TrackedFireworks[reg_20] = "None"
    else
      for x = 1, numElements do
        if (data.TrackedFireworks[x] == GetName(_activator())) then
          Print((("__BTA_Airlock: Found matching fireworks activator at: [" .. tostring(x)) .. "], will remove this one!"))
          table.remove(data.TrackedFireworks, x)
        end
      end
    end
    if (_TriggerNum ~= "-1") then
      if (FireworksSection ~= data.FireworkAvailableAreas[tonumber(_TriggerNum)]) then
        Print(("__BTA_Airlock: Fireworks Section num doesnt match the current door it's exiting! Changing to Section: " .. tostring(data.FireworkAvailableAreas[tonumber(_TriggerNum)])))
        SetPropertyString(_activator(), "EntityGroups", tostring(data.FireworkAvailableAreas[tonumber(_TriggerNum)]), 1)
        Print(("__BTA_Airlock: New EntityGroup for this firework: " .. tostring(GetPropertyString(_activator(), "EntityGroups", 1))))
      end
    else
      Print("__BTA_Airlock: _DoorNum was -1! This firework was destroyed")
    end
  end
  numElements = (#data.TrackedFireworks)
  Print("__BTA_Airlock: Current Tracked Fireworks:")
  for x = 1, numElements do
    x = x
    x = "]: "
    Print(((("__BTA_Airlock: Tracked Fireworks[" .. tostring(x)) .. x) .. tostring(data.TrackedFireworks[x])))
  end
  return 
end
Prefab_FireworksManager_FireworksDestroyed = function(target)
  Print("__BTA_Airlock: Prefab_BlotAlleyAirlock_FireworksDestroyed")
  Prefab_FireworksManager_FireworksTrigger(".Airlock_SideA_Trigger", "Exit", "-1")
  return 
end

