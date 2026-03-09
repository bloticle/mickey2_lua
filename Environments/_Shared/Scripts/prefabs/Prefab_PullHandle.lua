Prefab_PullHandle_ResetHandle = function(target)
  local impulseDir = GetFacing(GetRelativePrefabEntity(target, ".Constraint"))
  Print("Prefab_PullHandle----------------Apply Impulse Now")
  Print(("x= " .. impulseDir.x))
  Print(("z= " .. impulseDir.z))
  impulseDir.x = (impulseDir.x * -2000)
  impulseDir.z = (impulseDir.z * -2000)
  ApplyImpulse(target, impulseDir.x, 0, impulseDir.z)
  return 
end
