PrefabGeyserMove = function(target)
  local data = GetPrefabData(target)
  if (data.GeyserDirection == "Up") then
    data.GeyserDirection = "Down"
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PaintGeyser"), 3)
    AudioPostEventOn(GetRelativePrefabEntity(target, ".PaintGeyser"), "Play_sfx_AUT_GeyserSpout_LP")
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PaintGeyser"), GetRelativePrefabEntity(target, ".PaintGeyserSK2"), GetRelativePrefabEntity(target, ".PaintGeyserSK1"), 1)
  else
    data.GeyserDirection = "Up"
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PaintGeyser"), 3)
    AudioPostEventOn(GetRelativePrefabEntity(target, ".PaintGeyser"), "Stop_sfx_AUT_GeyserSpout_LP")
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PaintGeyser"), GetRelativePrefabEntity(target, ".PaintGeyserSK2"), GetRelativePrefabEntity(target, ".PaintGeyserSK1"), 0)
  end
  return 
end
PrefabStabilizeGeyser = function(reg_0)
  return 
end
