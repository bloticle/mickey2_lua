Prefab_1WayTeleport = function(target)
  local data = GetPrefabData(target)
  RestrictCutSceneInput()
  StartFadeOut(0.4000000059604645)
  wait(0.4000000059604645)
  if (data.teleportwho == "activator") then
    TeleportToEntity(_activator(), GetRelativePrefabEntity(target, ".OneWayTeleportDestination"))
  elseif (data.teleportwho == "both") then
    TeleportToEntity(GetPlayer(), GetRelativePrefabEntity(target, ".OneWayTeleportDestination"))
    TeleportToEntity(GetPlayer2OrAI(), GetRelativePrefabEntity(target, ".OneWayTeleportDestinationOswald"))
  end
  wait(0)
  if (data.camerareset == "true") then
    CameraReset()
  end
  StartFadeIn(0.4000000059604645)
  wait(0.4000000059604645)
  UnrestrictCutSceneInput()
  return 
end

