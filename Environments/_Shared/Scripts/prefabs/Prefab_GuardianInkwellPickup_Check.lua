Prefab_GuardianInkwellPickup_Check = function(target, param1)
  local data = GetPrefabData(target)
  if (param1 == "Painted") then
    if (data.PoolTarget ~= "None") then
      if (Prefab_GuardianPoolObject ~= nil) then
        FireThread(Prefab_GuardianPoolObject, target, param1)
      end
    end
    if (data.InkWellTarget ~= "None") then
      if (Prefab_InkWellObject ~= nil) then
        FireThread(Prefab_InkWellObject, target, param1)
      end
    end
  end
  if StimulusEvent_HasStimulusType(param1, ST_SPIN) then
    if (data.isPickupObject == "True") then
      if (Prefab_SpawnItem_Check ~= nil) then
        Prefab_SpawnItem_Check(target, param1)
      end
    end
  end
  return 
end
