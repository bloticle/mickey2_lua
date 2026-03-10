Prefab_BlueSlidingPipeTriggered = function(target)
  local data = GetPrefabData(target)
  DisableMotion(GetRelativePrefabEntity(target, ".BluePipeHandle"))
  SetPropertyFloat(GetRelativePrefabEntity(target, ".BluePipeHandle"), "UsableRadius", 0)
  FireThread(_G[data.FunctionToFire])
  return 
end

