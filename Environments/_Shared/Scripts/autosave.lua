LatestSave = "StartSave"
RestartThinner = 5
RestartPaint = 5
SetAutoSave = function(target)
  LatestSave = target
  Print("Checkpoint-SetAutoSave:", LatestSave)
  return 
end
SetAutoSaveAt = function(target, savePt)
  LatestSave = GetEntity(savePt)
  Print("Checkpoint-SetAutoSaveAt:", LatestSave)
  return 
end
RestartFromSave = function(target)
  local CurrentAmmo = nil
  CurrentAmmo = GetPropertyFloat(_player(), "Paint", 0)
  if (CurrentAmmo < RestartPaint) then
    SetPropertyFloat(_player(), "Paint", RestartPaint, 0)
  end
  CurrentAmmo = GetPropertyFloat(_player(), "Thinner", 0)
  if (CurrentAmmo < RestartThinner) then
    SetPropertyFloat(_player(), "Thinner", RestartThinner, 0)
  end
  MoveToEntity(target, LatestSave)
  ClearAllCameraAttributes()
  ZeroCharacterVelocity(_player())
  return 
end

