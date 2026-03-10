ShouldCallShake = true
Prefab_RaiseBridge = function(target)
  local data = GetPrefabData(target)
  data.TotalPressurePlatesState = (data.TotalPressurePlatesState + 1)
  SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".ToonSword1"), 45)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".ToonSword1"), 84)
  if (data.TotalPressurePlatesState ~= 2) then
    ShouldCallShake = true
  end
  return 
end
Prefab_LowerBridge = function(target)
  local data = GetPrefabData(target)
  data.TotalPressurePlatesState = (data.TotalPressurePlatesState - 1)
  if (data.TotalPressurePlatesState == 0) then
    ShouldCallShake = false
    SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".ToonSword1"), 180)
    StartRotateToPosition(GetRelativePrefabEntity(target, ".ToonSword1"), 0)
  end
  return 
end
Prefab_SwordBridgeRumbleandShake = function(target)
  if (ShouldCallShake == true) then
    ShouldCallShake = false
    Rumble(nil, 1.2000000476837158)
    Rumble(nil, 1.2000000476837158, 1)
    ShakeCamera(2, 25, 0.05000000074505806, 4, 0.02500000037252903, 0.02500000037252903)
    AudioPostEventOn(GetRelativePrefabEntity(target, ".ToonSword1"), "Play_sfx_rbc_Sword_Snap")
  end
  return 
end

