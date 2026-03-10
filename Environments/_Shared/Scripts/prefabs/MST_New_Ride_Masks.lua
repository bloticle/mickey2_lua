MasksUpState = 0
MasksPaintState = 3
IsThinningMask = 0
MaskRotation = 0
MasksGoingUpDown = 0
Masks_TrackPlayer = function(turret)
  SetPropertyEntity(turret, "RotateToEntity", GetPlayer(), 0)
  SetRotatorMaxSpeed(turret, 99)
  return 
end
Stop_Masks_TrackPlayer = function(turret)
  SetRotatorMaxSpeed(turret, 0)
  return 
end
MasksUp = function(target, spider)
  if (MasksGoingUpDown == 0) then
    if (GetPrefabData(spider).NearEdges == "false") then
      MasksGoingUpDown = 1
      SpiderHigh()
      MasksFacePaint(target)
      MasksGoingUpDown = 0
    end
  end
  return 
end
MasksDown = function(target, spider)
  if (MasksGoingUpDown == 0) then
    MasksGoingUpDown = 1
    SpiderLow()
    MasksFaceThinner(target)
    MasksGoingUpDown = 0
  end
  return 
end
AddMaskThinned = function(pistons, masks, spider)
  MasksPaintState = (MasksPaintState - 1)
  wait(2)
  if (MasksPaintState <= 0) then
    SetSpiderVulnerable()
  end
  return 
end
AddMaskPainted = function(pistons, masks, spider)
  MasksPaintState = (MasksPaintState + 1)
  wait(2)
  if (6 <= MasksPaintState) then
    SetSpiderVulnerable()
  end
  return 
end
MasksFacePaint = function(target)
  MaskRotation = 1
  Masks_Flip(target)
  return 
end
MasksFaceThinner = function(target)
  MaskRotation = 0
  Masks_Flip(target)
  return 
end
Masks_Flip = function(target)
  if (IsThinningMask == 0) then
    IsThinningMask = 1
    wait(1)
    if (MaskRotation == 0) then
      MaskRotation = 2
      SetPropertyEntity(GetRelativePrefabEntity(target, ".MaskRotator 01"), "RotateToEntity", GetRelativePrefabEntity(target, ".MaskOrientationMarker 05"), 0)
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".MaskRotator 01"), 99)
    elseif (MaskRotation == 1) then
      MaskRotation = 3
      SetPropertyEntity(GetRelativePrefabEntity(target, ".MaskRotator 01"), "RotateToEntity", GetRelativePrefabEntity(target, ".MaskOrientationMarker 06"), 0)
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".MaskRotator 01"), 99)
    elseif (MaskRotation == 2) then
      MaskRotation = 4
      SetPropertyEntity(GetRelativePrefabEntity(target, ".MaskRotator 01"), "RotateToEntity", GetRelativePrefabEntity(target, ".MaskOrientationMarker 03"), 0)
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".MaskRotator 01"), 99)
    elseif (MaskRotation == 3) then
      MaskRotation = 5
      SetPropertyEntity(GetRelativePrefabEntity(target, ".MaskRotator 01"), "RotateToEntity", GetRelativePrefabEntity(target, ".MaskOrientationMarker 04"), 0)
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".MaskRotator 01"), 99)
    elseif (MaskRotation == 4) then
      MaskRotation = 0
      SetPropertyEntity(GetRelativePrefabEntity(target, ".MaskRotator 01"), "RotateToEntity", GetRelativePrefabEntity(target, ".MaskOrientationMarker 01"), 0)
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".MaskRotator 01"), 99)
    elseif (MaskRotation == 5) then
      MaskRotation = 1
      SetPropertyEntity(GetRelativePrefabEntity(target, ".MaskRotator 01"), "RotateToEntity", GetRelativePrefabEntity(target, ".MaskOrientationMarker 02"), 0)
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".MaskRotator 01"), 99)
    end
    wait(0.5)
    IsThinningMask = 0
    wait(0.5)
  end
  return 
end
MasksVulnerable = function(masks)
  SetPropertyBool(GetRelativePrefabEntity(masks, ".MaskRotator 01"), "InvulnerableToPaintThinner", false)
  SetPropertyBool(GetRelativePrefabEntity(masks, ".MaskRotator 02"), "InvulnerableToPaintThinner", false)
  SetPropertyBool(GetRelativePrefabEntity(masks, ".MaskRotator 03"), "InvulnerableToPaintThinner", false)
  SetPropertyBool(GetRelativePrefabEntity(masks, ".MaskRotator 04"), "InvulnerableToPaintThinner", false)
  SetPropertyBool(GetRelativePrefabEntity(masks, ".MaskRotator 05"), "InvulnerableToPaintThinner", false)
  SetPropertyBool(GetRelativePrefabEntity(masks, ".MaskRotator 06"), "InvulnerableToPaintThinner", false)
  return 
end
MasksInvulnerable = function(masks)
  SetPropertyBool(GetRelativePrefabEntity(masks, ".MaskRotator 01"), "InvulnerableToPaintThinner", true)
  SetPropertyBool(GetRelativePrefabEntity(masks, ".MaskRotator 02"), "InvulnerableToPaintThinner", true)
  SetPropertyBool(GetRelativePrefabEntity(masks, ".MaskRotator 03"), "InvulnerableToPaintThinner", true)
  SetPropertyBool(GetRelativePrefabEntity(masks, ".MaskRotator 04"), "InvulnerableToPaintThinner", true)
  SetPropertyBool(GetRelativePrefabEntity(masks, ".MaskRotator 05"), "InvulnerableToPaintThinner", true)
  SetPropertyBool(GetRelativePrefabEntity(masks, ".MaskRotator 06"), "InvulnerableToPaintThinner", true)
  return 
end
MasksRePaint = function(masks)
  ForcePainted(GetRelativePrefabEntity(masks, ".MaskRotator 01"))
  ForcePainted(GetRelativePrefabEntity(masks, ".MaskRotator 03"))
  ForcePainted(GetRelativePrefabEntity(masks, ".MaskRotator 05"))
  ForceSketched(GetRelativePrefabEntity(masks, ".MaskRotator 02"))
  ForceSketched(GetRelativePrefabEntity(masks, ".MaskRotator 04"))
  ForceSketched(GetRelativePrefabEntity(masks, ".MaskRotator 06"))
  return 
end

