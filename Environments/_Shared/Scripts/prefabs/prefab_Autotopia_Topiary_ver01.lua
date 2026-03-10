AUT_TreeThinned = function(target)
  local data = GetPrefabData(target)
  EnableMotion(GetRelativePrefabEntity(target, ".TCY_topiarieFruit_01a_toon 01"))
  EnableMotion(GetRelativePrefabEntity(target, ".TCY_topiarieFruit_01a_toon 02"))
  EnableMotion(GetRelativePrefabEntity(target, ".TCY_topiarieFruit_01a_toon 03"))
  return 
end
AUT_TreeLoaded = function(target)
  local data = GetPrefabData(target)
  if (GetPropertyBool(GetRelativePrefabEntity(target, ".TCY_tree_01a_toon 01"), "Is Painted", 0) == false) then
    EnableMotion(GetRelativePrefabEntity(target, ".TCY_topiarieFruit_01a_toon 01"))
    EnableMotion(GetRelativePrefabEntity(target, ".TCY_topiarieFruit_01a_toon 02"))
    EnableMotion(GetRelativePrefabEntity(target, ".TCY_topiarieFruit_01a_toon 03"))
  end
  return 
end

