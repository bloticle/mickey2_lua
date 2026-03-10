Prefab_ClockPlatform_CheckStop = function(target)
  local data = GetPrefabData(target)
  if (data.StopAtStart == "false") then
    Reverse(target)
  end
  return 
end
Prefab_ClockPlatform_DisablePlatform = function(target)
  local data = GetPrefabData(target)
  data.StopAtStart = "true"
  return 
end

