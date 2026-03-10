YS_BrushPathAnimChange = function(target, state)
  local data = GetPrefabData(target)
  if (state == "1") then
    data.Anim = 1
    if (data.Painted == 1) then
      if (data.Animating == 0) then
        AnimGBSequence(target, "MoveTogether", true)
        StartEmitters(GetRelativePrefabEntity(target, ".EmitterTogether"))
        StopEmitters(GetRelativePrefabEntity(target, ".EmitterApart"))
        data.Initialized = 1
        data.Animating = 1
      end
    end
  else
    data.Anim = 0
    if (data.Painted == 1) then
      if (data.Animating == 0) then
        AnimGBSequence(target, "SpreadApart", true)
        StartEmitters(GetRelativePrefabEntity(target, ".EmitterApart"))
        StopEmitters(GetRelativePrefabEntity(target, ".EmitterTogether"))
        data.Animating = 1
      end
    end
  end
  return 
end
YS_BrushPaintPainted = function(target)
  local data = GetPrefabData(target)
  if (data.Anim == 0) then
    if (data.Initialized == 1) then
      AnimGBSequence(target, "SpreadApart", true)
      StartEmitters(GetRelativePrefabEntity(target, ".EmitterApart"))
      StopEmitters(GetRelativePrefabEntity(target, ".EmitterTogether"))
      data.Animating = 1
    end
  else
    AnimGBSequence(target, "MoveTogether", true)
    StartEmitters(GetRelativePrefabEntity(target, ".EmitterTogether"))
    StopEmitters(GetRelativePrefabEntity(target, ".EmitterApart"))
    data.Initialized = 1
    data.Animating = 1
  end
  return 
end
YS_BrushPathAnimEnded = function(target, event)
  local data = GetPrefabData(target)
  data.Animating = 0
  if (data.Anim == 0) then
    AnimGBSequence(target, "SpreadApart", true)
    StartEmitters(GetRelativePrefabEntity(target, ".EmitterApart"))
    StopEmitters(GetRelativePrefabEntity(target, ".EmitterTogether"))
  else
    AnimGBSequence(target, "MoveTogether", true)
    StartEmitters(GetRelativePrefabEntity(target, ".EmitterTogether"))
    StopEmitters(GetRelativePrefabEntity(target, ".EmitterApart"))
    data.Initialized = 1
  end
  return 
end
YS_PathPaintedThinned = function(target, state)
  local data = GetPrefabData(target)
  if (state == "paint") then
    data.Painted = 1
    if (data.Anim == 0) then
      StartEmitters(GetRelativePrefabEntity(target, ".EmitterApart"))
    else
      StartEmitters(GetRelativePrefabEntity(target, ".EmitterTogether"))
      data.Painted = 0
      StopEmitters(GetRelativePrefabEntity(target, ".EmitterTogether"))
      StopEmitters(GetRelativePrefabEntity(target, ".EmitterApart"))
    end
  else
    data.Painted = 0
    StopEmitters(GetRelativePrefabEntity(target, ".EmitterTogether"))
    StopEmitters(GetRelativePrefabEntity(target, ".EmitterApart"))
  end
  data.Animating = 0
  return 
end
YS_SpawnPaintPickup = function(target)
  local data = GetPrefabData(target)
  if (data.PickupGroupName ~= "None") then
    Prefab_SpawnItem_ItemCheck(data.PickupGroupName)
  end
  return 
end

