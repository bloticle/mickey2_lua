Prefab_PlayLeavesEffect = function(target)
  Print("Tree was touched")
  StartEmitters(GetRelativePrefabEntity(target, ".Leaves"))
  wait(2)
  StopEmitters(GetRelativePrefabEntity(target, ".Leaves"))
  return 
end

