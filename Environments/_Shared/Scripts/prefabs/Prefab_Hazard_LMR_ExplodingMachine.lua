Prefab_DetonateMachine = function(target)
  local data = GetPrefabData(target)
  if (data.ExplodingMachineState == 0) then
    data.ExplodingMachineState = 1
  end
  Enable(GetRelativePrefabEntity(target, ".DamageVolume"))
  StartEmitters(GetRelativePrefabEntity(target, ".ExplosionFX"))
  Wait(1.25)
  Disable(GetRelativePrefabEntity(target, ".DamageVolume"))
  StopEmitters(GetRelativePrefabEntity(target, ".ExplosionFX"))
  return 
end

