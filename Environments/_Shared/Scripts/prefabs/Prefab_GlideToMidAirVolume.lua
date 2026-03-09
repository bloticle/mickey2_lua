Prefab_MidAirGlide = function(target)
  local data = GetPrefabData(target)
  if (data.followOnGlideEnd == "true") then
    OswaldGlideMidAir(target)
  elseif (data.followOnGlideEnd == "false") then
    OswaldGlideMidAirNoFollow(target)
    OswaldSetPathAction(target)
  else
    print("LUA ERROR *******************************************************************************************************************")
    print("LUA ERROR: Prefab_GlideToMidAirVolume prefab data override value \"followOnGlideEnd\" is something other than \"true\" or \"false\"")
    print("LUA ERROR ******************************************************************************************************************.")
  end
  return 
end
