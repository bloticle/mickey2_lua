AUT_PressurePointsSealed = function(target)
  local data = GetPrefabData(target)
  if (data.Overloaded == 0) then
    data.PressurePoints = (data.PressurePoints - 1)
    if (data.PressurePoints == 0) then
      ForEachEntityInGroup(FireUser1, data.Vents)
      local dataSiphon = GetPrefabData(data.TargetSiphon)
      data.Overloaded = 1
      if (dataSiphon.TurretState == 0) then
        FireUser2(data.TargetSiphon)
      end
    end
  end
  return 
end
AUT_SiphonFX_Initialize = function(target)
  local data = GetPrefabData(target)
  if (0 < GetGlobal(data.SiphonGlobal)) then
    ForEachEntityInGroup(FireUser1, data.Vents)
  end
  return 
end

