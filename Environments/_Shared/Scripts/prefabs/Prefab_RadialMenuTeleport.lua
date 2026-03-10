Prefab_RadialTeleportToLocation = function(markerNumber)
  local data = GetPrefabData("RadialTeleportPrefab")
  local streamRequired = data[("Stream" .. markerNumber)]
  local waitforload = data[("StreamRequiredForMarker" .. markerNumber)]
  FireUser2(GetRelativePrefabEntity("RadialTeleportPrefab", (".RadialTeleportMarker" .. markerNumber)))
  if (streamRequired ~= "none") then
    wait(0.009999999776482582)
    WaitForLevelLoad()
  end
  if (waitforload == true) then
    WaitForLevelLoad()
  end
  TeleportToEntity(GetPlayer(), GetRelativePrefabEntity("RadialTeleportPrefab", (".RadialTeleportMarker" .. markerNumber)))
  FireUser1(GetRelativePrefabEntity("RadialTeleportPrefab", (".RadialTeleportMarker" .. markerNumber)))
  return 
end
Prefab_StreamBeforeTeleport = function(target, markerNumber)
  local data = GetPrefabData("RadialTeleportPrefab")
  local streamRequired = data[("Stream" .. markerNumber)]
  if (streamRequired ~= "none") then
    StreamZones(GetPlayer(), streamRequired)
  end
  return 
end

