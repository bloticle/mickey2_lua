Prefab_EnterTube = function(target, side, state)
  Print(("Prefab_CheckTube: state = " .. state))
  local data = GetPrefabData(target)
  if (state == "Enter") then
    data[(side .. "Active")] = 1
  else
    data[(side .. "Active")] = 0
  end
  Prefab_CheckTube(target)
  return 
end
Prefab_CheckTube = function(target)
  Print("Prefab_CheckTube")
  local data = GetPrefabData(target)
  Print(data.LeftActive)
  Print(data.RightActive)
  Print(data.AIOswaldNearby)
  if (data.LeftActive == 1) then
    if (data.RightActive == 1) then
      Print("Prefab_CheckTube: Tubefunction")
      FireUser1(GetRelativePrefabEntity(target, ".ScriptTrigger"))
    end
  elseif (data.LeftActive == 1) then
    if (GetNumPlayers() == 1) then
      Print("Prefab_CheckTube: Tubefunction")
      FireUser1(GetRelativePrefabEntity(target, ".ScriptTrigger"))
    end
  end
  return 
end
Prefab_TransportAIOswald = function(target, state)
  local data = GetPrefabData(target)
  if (state == "enter") then
    data.AIOswaldNearby = 1
  else
    data.AIOswaldNearby = 0
  end
  Print(data.AIOswaldNearby)
  Prefab_CheckTube(target)
  return 
end
