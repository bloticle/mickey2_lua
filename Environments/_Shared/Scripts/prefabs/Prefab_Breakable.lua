Prefab_Breakable_Fade = function(target)
  local data = GetPrefabData(target)
  Wait(data.FadeDelay)
  local (for index), (for limit), (for step) = 1, 0, -0.05000000074505806
  for a = (for index), (for limit), (for step) do
    SetR3MTConstRegAlpha(target, data.alphaRegister, a)
    Wait(data.FadeOutDelta)
  end
  Wait(0.10000000149011612)
  DestroyEntity(target)
  return 
end
Prefab_Breakable_dynamicKnockback = function(target)
  local player = GetPlayer()
  local land_spot = (GetPosition(target) - GetPosition(player))
  local data = GetPrefabData(target)
  if (data.removeParent == 1) then
    ClearParent(target)
  end
  EnableMotion(target)
  land_spot:normalize3()
  ApplyImpulse(target, (land_spot.x * data.horizontalKnockbackDist), data.verticalKnockbackDist, (land_spot.z * data.horizontalKnockbackDist))
  return 
end
Prefab_BreakableSetAlpha = function(target, alphaInt)
  local data = GetPrefabData(target)
  SetR3MTConstRegAlpha(target, data.alphaRegister, alphaInt)
  return 
end
