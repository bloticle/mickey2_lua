Prefab_FireworksDispenserTriggered = function(target)
  local spawner = GetRelativePrefabEntity(target, ".Spawner")
  local doors = GetRelativePrefabEntity(target, ".Doors")
  local handle = GetRelativePrefabEntity(target, ".HandleToGrab")
  local data = GetPrefabData(target)
  if (data.DispenserActive == "True") then
    data.DispenserActive = "False"
    ForceSpawn(spawner, 1)
    AudioPostEventOn(doors, "Play_sfx_gbl_fireworks_door_open")
    AnimGBSequence(doors, "open")
    wait(1.5)
    SetPropertyFloat(handle, "UsableRadius", 0)
  end
  return 
end
Prefab_FireworksMachineDetonate = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    if (0 < GetHealth(target)) then
      local number = "notnil"
      local position = 0
      while (number ~= nil) do
        number = GetPropertyString(target, "EntityGroups", position)
        if (number ~= nil) then
          position = (position + 1)
        end
        position = (position - 1)
      end
      Print((("Position # :" .. position) .. " is valid"))
      local FireworksPrefab = GetPropertyString(target, "EntityGroups", position)
      Print(("The fireworks prefab that I came from is :" .. FireworksPrefab))
      FireworksPrefab = string.sub(FireworksPrefab, 1, -2)
      Print(("The fireworks prefab that I came from after sub is :" .. FireworksPrefab))
      local data = GetPrefabData(FireworksPrefab)
      local doors = GetRelativePrefabEntity(FireworksPrefab, ".Doors")
      local handle = GetRelativePrefabEntity(FireworksPrefab, ".HandleToGrab")
      Print(((("Mickey is in the trigger : " .. data.MickeyInTrigger) .. "Oswald is in the trigger ") .. data.OswaldInTrigger))
      wait(3)
      while true do
        if (data.MickeyInTrigger == "True") then
          wait(0.10000000149011612)
        end
      end
      AudioPostEventOn(doors, "Play_sfx_gbl_fireworks_door_close")
      AnimGBSequence(doors, "close", true)
      data.DispenserActive = "True"
      if (data.HandleUsableRadiusOverride ~= -1) then
        SetPropertyFloat(handle, "UsableRadius", tonumber(data.HandleUsableRadiusOverride))
      else
        SetPropertyFloat(handle, "UsableRadius", 3)
      end
    end
  end
  return 
end
Prefab_PlayersInTrigger = function(target, direction)
  local data = GetPrefabData(target)
  if (GetName(_activator()) == GetName(GetPlayer())) then
    data.MickeyInTrigger = direction
  end
  if (GetName(_activator()) == GetName(GetPlayer2OrAI())) then
    data.OswaldInTrigger = direction
  end
  Print(((("Prefab_PlayersInTrigger : Mickey is in the trigger : " .. data.MickeyInTrigger) .. "Oswald is in the trigger ") .. data.OswaldInTrigger))
  return 
end
Prefab_Fireworks_ResetHandle = function(target)
  local impulseDir = GetFacing(target)
  local doors = GetRelativePrefabEntity(target, ".Doors")
  impulseDir.x = (impulseDir.x * -200)
  impulseDir.z = (impulseDir.z * -200)
  SetPropertyInt(doors, "Collision Layer", 31)
  ApplyImpulse(target, impulseDir.x, 0, impulseDir.z)
  Wait(1)
  SetPropertyInt(doors, "Collision Layer", 2)
  return 
end
Prefab_FireworksMachineForceReset = function(target)
  local data = GetPrefabData(target)
  local doors = GetRelativePrefabEntity(target, ".Doors")
  local handle = GetRelativePrefabEntity(target, ".HandleToGrab")
  Print(((("Mickey is in the trigger : " .. data.MickeyInTrigger) .. "Oswald is in the trigger ") .. data.OswaldInTrigger))
  wait(3)
  while true do
    if (data.MickeyInTrigger == "True") then
      wait(0.10000000149011612)
    end
  end
  AudioPostEventOn(doors, "Play_sfx_gbl_fireworks_door_close")
  AnimGBSequence(doors, "close", true)
  data.DispenserActive = "True"
  if (data.HandleUsableRadiusOverride ~= -1) then
    SetPropertyFloat(handle, "UsableRadius", tonumber(data.HandleUsableRadiusOverride))
  else
    SetPropertyFloat(handle, "UsableRadius", 3)
  end
  return 
end
Prefab_GetUniqueFireworksSetup = function(target)
  local dispenser = GetName(target)
  Print(("The name of this fireworks dispenser is :" .. dispenser))
  SetPropertyString(GetRelativePrefabEntity(target, ".Spawner"), "Spawn Group", (dispenser .. "1"), 0)
  local spawnergroup = GetPropertyString(GetRelativePrefabEntity(target, ".Spawner"), "Spawn Group", 0)
  Print(("The name of this fireworks spawnergroup is :" .. spawnergroup))
  spawnergroup = string.sub(spawnergroup, 1, -2)
  Print(("The name of this fireworks spawnergroup after string sub is:" .. spawnergroup))
  return 
end
Prefab_ClearFireworksFromScene = function(target)
  local number = "notnil"
  local position = 0
  while (number ~= nil) do
    number = GetPropertyString(target, "EntityGroups", position)
    if (number ~= nil) then
      position = (position + 1)
    end
    position = (position - 1)
  end
  Print((("Position # :" .. position) .. " is valid"))
  local FireworksPrefab = GetPropertyString(target, "EntityGroups", position)
  Print(("The fireworks prefab that I came from is :" .. FireworksPrefab))
  FireworksPrefab = string.sub(FireworksPrefab, 1, -2)
  Print(("The fireworks prefab that I came from after sub is :" .. FireworksPrefab))
  local data = GetPrefabData(FireworksPrefab)
  local doors = GetRelativePrefabEntity(FireworksPrefab, ".Doors")
  local handle = GetRelativePrefabEntity(FireworksPrefab, ".HandleToGrab")
  DestroyEntity(target)
  Print(((("Mickey is in the trigger : " .. data.MickeyInTrigger) .. "Oswald is in the trigger ") .. data.OswaldInTrigger))
  wait(3)
  while true do
    if (data.MickeyInTrigger == "True") then
      wait(0.10000000149011612)
    end
  end
  AudioPostEventOn(doors, "Play_sfx_gbl_fireworks_door_close")
  AnimGBSequence(doors, "close", true)
  data.DispenserActive = "True"
  if (data.HandleUsableRadiusOverride ~= -1) then
    SetPropertyFloat(handle, "UsableRadius", tonumber(data.HandleUsableRadiusOverride))
  else
    SetPropertyFloat(handle, "UsableRadius", 3)
  end
  return 
end
Prefab_KillInsidePlayers = function(target)
  local data = GetPrefabData(target)
  if (data.MickeyInTrigger == "True") then
    SetPlayerUnrevivable(GetPlayer())
    Kill(GetPlayer())
  end
  if (data.OswaldInTrigger == "True") then
    SetPlayerUnrevivable(GetPlayer2OrAI())
    Kill(GetPlayer2OrAI())
  end
  return 
end
