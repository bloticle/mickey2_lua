Prefab_ToonGearElectricityMachine_SwitchCheck = function(target, state)
  Print("Function: Prefab_ToonGearElectricityMachine_SwitchCheck")
  local data = GetPrefabData(target)
  local painted_gears = 0
  if (state == "Thinned") then
    FireUser2(data.ObjectToActivate)
    ForEachEntityInPrefab(SetRotatorMaxSpeed, GetRelativePrefabEntity(target, ".Gears"), 0)
  else
    for i = 1, 3 do
      if GetPropertyBool(GetRelativePrefabEntity(target, (".Gear" .. tostring(i))), "Is Painted") then
        painted_gears = (painted_gears + 1)
      end
    end
    if (painted_gears == 3) then
      ForEachEntityInPrefab(SetRotatorMaxSpeed, GetRelativePrefabEntity(target, ".Gears"), 30)
      if (data.JustGears == false) then
        wait(2)
        OswaldStreamAbort()
        Prefab_OswaldElectricSwitch_ChangeState("ToonGearElectricityMachineOswaldSwitchTimersLogicTimer", "Deactivate")
        SetPropertyBool("ToonGearElectricMachineHiddenOswald", "ActionSpotEnabled", false)
        DestroyEntity("ToonGearElectricMachineHiddenOswald")
        local gear1, gear1 = GetRelativePrefabEntity(target, ".GearCover1"), ".Gears"
        local gear2 = GetRelativePrefabEntity(target, ".GearCover2")
        gear1 = 720
        SetRotatorMaxSpeed(gear1, gear1)
        gear1 = 720
        SetRotatorMaxSpeed(gear2, gear1)
        gear1 = 0
        StartRotateToPosition(gear1, gear1)
        gear1 = 0
        StartRotateToPosition(gear2, gear1)
        wait(1)
      end
      FireUser1(data.ObjectToActivate)
    end
  end
  return 
end
Prefab_MoveGearDoorCovers = function(target, direction)
  if (direction == "Open") then
    local gear1 = GetRelativePrefabEntity(target, ".GearCover1")
    local gear2 = GetRelativePrefabEntity(target, ".GearCover2")
    SetRotatorMaxSpeed(gear1, 720)
    SetRotatorMaxSpeed(gear2, 720)
    StartRotateToPosition(gear1, 90)
    StartRotateToPosition(gear2, -90)
    ForEachEntityInPrefab(SetPropertyBool, GetRelativePrefabEntity(target, ".Gears"), "InvulnerableToPaintThinner", false)
  elseif (direction == "Close") then
    StartRotateToPosition(GetRelativePrefabEntity(target, ".GearCover1"), 0)
    StartRotateToPosition(GetRelativePrefabEntity(target, ".GearCover2"), 0)
    ForEachEntityInPrefab(SetPropertyBool, GetRelativePrefabEntity(target, ".Gears"), "InvulnerableToPaintThinner", true)
  end
  return 
end

