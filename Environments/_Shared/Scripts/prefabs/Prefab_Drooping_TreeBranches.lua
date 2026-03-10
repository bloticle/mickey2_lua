Prefab_Drooping_TreeBranches = function(target, state)
  if (state == "Down") then
    ForEachEntityInPrefab(Reverse, target)
    FireThread(Prefab_Drooping_TreeBranches, GetRelativePrefabEntity(target, ".FX"), "FX")
  elseif (state == "Up") then
    ForEachEntityInPrefab(Reverse, target)
  elseif (state == "FX") then
    if (not GetPropertyBool(target, "StartEmittersEnabled")) then
      StartEmitters(target)
      wait(1.75)
      StopEmitters(target)
    end
  end
  return 
end

