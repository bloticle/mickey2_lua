Prefab_UtilidorOpenDoor = function(target)
  SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".Door"), 20)
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".Door"), GetRelativePrefabEntity(target, ".TopSK"), GetRelativePrefabEntity(target, ".BottomSK"), 1)
  return 
end
Prefab_UtilidorCloseDoor = function(target)
  SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".Door"), 20)
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".Door"), GetRelativePrefabEntity(target, ".TopSK"), GetRelativePrefabEntity(target, ".BottomSK"), 0)
  return 
end

