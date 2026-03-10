Prefab_MultiSizePottedPlant_AlwaysSetup = function(target)
  Print("__Function: Prefab_MultiSizePottedPlant_AlwaysSetup")
  local data = GetPrefabData(target)
  local Active = ""
  local Base = GetRelativePrefabEntity(target, ".Base")
  if (Prefab_MultiSizePottedPlant_ConvertGlobalToTableIndex(target) == 0) then
    Print("__PottedPlant: This plant hasn't been initialized once yet! Will initialize!")
    Prefab_MultiSizePottedPlant_SetPlantToPersist(target)
    if (data.PlantSize == "Small") then
      Active = GetRelativePrefabEntity(target, ".PlantSmall")
    elseif (data.PlantSize == "Medium") then
      Active = GetRelativePrefabEntity(target, ".PlantMedium")
    elseif (data.PlantSize == "Tall") then
      Active = GetRelativePrefabEntity(target, ".PlantTall")
    else
    end
    if (data.StartPainted[1] == 1) then
      ForcePainted(Base)
      data.State[reg_29] = 1
      Prefab_MultiSizePottedPlant_CameraOverrideState(target, "On")
    else
      ForceSketched(Base)
      data.State[reg_29] = 0
      Prefab_MultiSizePottedPlant_CameraOverrideState(target, "Off")
    end
    if (Active ~= "") then
      if (data.StartPainted[2] == 1) then
        ForcePainted(Active)
        data.State[reg_42] = 1
        Prefab_MultiSizePottedPlant_CameraOverrideState(target, "Off")
      else
        ForceSketched(Active)
        data.State[reg_42] = 0
        Print("__PottedPlant: This plant has initialized before! Using persistant data")
      end
    end
  else
    Print("__PottedPlant: This plant has initialized before! Using persistant data")
  end
  if (data.UseCameraOverride == "False") then
    DestroyEntity(GetRelativePrefabEntity(target, ".CameraOverride"))
    DestroyEntity(GetRelativePrefabEntity(target, ".CameraControlPoint"))
  end
  return 
end
Prefab_MultiSizePottedPlant_ConvertGlobalToTableIndex = function(target)
  Print("__PottedPlant: Function: Prefab_MultiSizePottedPlant_ConvertGlobalToTableIndex")
  local GlobalToSplit = GetPrefabData(target).PlantLoadedGlobal[1]
  local IndexToReturn = (tonumber(GetPrefabData(target).PlantLoadedGlobal[2]) + 1)
  Print(("__PottedPlant: Global to split: " .. tostring(GlobalToSplit)))
  Print(("__PottedPlant: Will return index: " .. tostring(IndexToReturn)))
  local GlobalAsString = tostring(GetGlobal(GlobalToSplit))
  for x = 2, 5 do
    if (x == IndexToReturn) then
      local State = tonumber(string.sub(GlobalAsString, x, x))
      Print(("__PottedPlant: Returning Value: " .. tostring(State)))
      return State
    end
  end
  return 
end
Prefab_MultiSizePottedPlant_SetPlantToPersist = function(target)
  Print("__PottedPlant: Function: Prefab_MultiSizePottedPlant_SetPlantToPersist")
  local GlobalToSplit = GetPrefabData(target).PlantLoadedGlobal[1]
  local IndexToSet = (tonumber(GetPrefabData(target).PlantLoadedGlobal[2]) + 1)
  Print(("__PottedPlant: Global to persist: " .. tostring(GlobalToSplit)))
  Print(("__PottedPlant: Will set index: " .. tostring(IndexToSet)))
  Print(("__PottedPlant: Old String Value: " .. tostring(GetGlobal(GlobalToSplit))))
  local GlobalAsString = tostring(GetGlobal(GlobalToSplit))
  local NewString = "1"
  for x = 2, 5 do
    local ToSet = "0"
    if (x == IndexToSet) then
      ToSet = "1"
    else
      ToSet = string.sub(GlobalAsString, x, x)
    end
    NewString = (NewString .. ToSet)
  end
  Print(("__PottedPlant: New String Value: " .. tostring(NewString)))
  SetGlobal(GlobalToSplit, tonumber(NewString))
  Print(("__PottedPlant: New Global Value: " .. tostring(GetGlobal(GlobalToSplit))))
  return 
end
Prefab_MultiSizePottedPlant_StateChanged = function(target, _State)
  Print(("__Function: Prefab_MultiSizePottedPlant_StateChanged, _State: " .. tostring(_State)))
  local data = GetPrefabData(target)
  if (_State == "PlantPainted") then
    Prefab_MultiSizePottedPlant_CameraOverrideState(target, "Off")
    data.State[reg_16] = 1
  elseif (_State == "PlantThinned") then
    if (data.State[1] == 1) then
      Prefab_MultiSizePottedPlant_CameraOverrideState(target, "On")
    else
      Prefab_MultiSizePottedPlant_CameraOverrideState(target, "Off")
    end
    data.State[reg_16] = 0
  elseif (_State == "PotPainted") then
    if (data.State[2] == 0) then
      Prefab_MultiSizePottedPlant_CameraOverrideState(target, "On")
    else
      Prefab_MultiSizePottedPlant_CameraOverrideState(target, "Off")
    end
    data.State[reg_17] = 1
  elseif (_State == "PotThinned") then
    Prefab_MultiSizePottedPlant_CameraOverrideState(target, "Off")
    data.State[reg_17] = 0
  end
  if (data.InkWellTarget ~= "None") then
    if (_State == "PotPainted") then
      Prefab_InkWellObject(target, "Painted")
    end
    if (_State == "PotThinned") then
      Prefab_InkWellObject(target, "Thinned")
    end
  end
  if (data.PoolTarget ~= "None") then
    if (_State == "PotPainted") then
      Prefab_GuardianPoolObject(target, "Painted")
    end
    if (_State == "PotThinned") then
      Prefab_GuardianPoolObject(target, "Thinned")
    end
  end
  return 
end
Prefab_MultiSizePottedPlant_CameraOverrideState = function(target, _On)
  Print(("__Function: Prefab_MultiSizePottedPlant_CameraOverrideState, _On: " .. tostring(_On)))
  local data = GetPrefabData(target)
  if (data.UseCameraOverride == "True") then
    if (_On == "On") then
      Enable(GetRelativePrefabEntity(target, ".CameraOverride"))
    elseif (_On == "Off") then
      Disable(GetRelativePrefabEntity(target, ".CameraOverride"))
    end
  end
  return 
end

