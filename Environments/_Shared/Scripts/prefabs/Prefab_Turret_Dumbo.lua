Prefab_TurretDumboFire = function(target)
  local anim = GetRelativePrefabEntity(target, ".Turret_Anim")
  local data = GetPrefabData(target)
  local door = nil
  if (data.Door == "Internal") then
    door = GetRelativePrefabEntity(target, ".Turret_Door")
  else
    door = data.Door
  end
  if (data.CurrentlyFiring == false) then
    AudioPostEventOn(target, "Play_DumboShooter_CoverOpen")
    if IsValidHandle(door) then
      StartRotateToPosition(door, 0)
      SetRotatorMaxSpeed(door, 90)
    end
  end
  wait(1)
  if IsValidHandle(door) then
    AnimGBSequence(anim, "Anim")
  end
  AudioPostEventOn(target, "Play_sfx_DG2_ElephantShooter01")
  local array_length = 0
  if IsValidHandle(door) then
    if (data.Disable.AssocJumpVolumes[1] ~= "None") then
      local array_length = (#data.Disable.AssocJumpVolumes)
      for i = 1, array_length do
        if IsValidHandle(data.Disable.AssocJumpVolumes[i]) then
          enableJumpVolumeAvailability(data.Disable.AssocJumpVolumes[i])
        end
      end
    end
    if (data.Disable.OswaldAction[1] ~= "None") then
      local array_length = (#data.Disable.OswaldAction)
      for i = 1, array_length do
        array_length = IsValidHandle
        array_length = array_length(data.Disable.OswaldAction[i])
        if array_length then
          array_length = SetPropertyBool
          array_length(data.Disable.OswaldAction[i], "ActionSpotEnabled", true)
        end
      end
    end
  end
  wait(3)
  if IsValidHandle(target) then
    data.CurrentlyFiring = true
    local shooter = GetRelativePrefabEntity(target, ".Turret_Shooter")
    Shooter_PrepareProjectiles(shooter)
    Shooter_LaunchProjectiles(shooter)
    wait(0.5)
    if (GetPropertyBool(GetRelativePrefabEntity(target, ".BackBlocker"), "Is Painted") == false) then
      data.CurrentlyFiring = false
    end
  end
  AnimGBSequence(anim, "Rest")
  wait(2.5)
  if IsValidHandle(target) then
    if (GetPropertyBool(GetRelativePrefabEntity(target, ".BackBlocker"), "Is Painted") == false) then
      AudioPostEventOn(target, "Play_DumboShooter_CoverClose")
      if IsValidHandle(door) then
        if (data.Disable.OswaldAction[1] ~= "None") then
          local array_length = (#data.Disable.OswaldAction)
          for i = 1, array_length do
            if IsValidHandle(data.Disable.OswaldAction[i]) then
              SetPropertyBool(data.Disable.OswaldAction[i], "ActionSpotEnabled", false)
            end
          end
        end
        SetRotatorMaxSpeed(door, 90)
        StartRotateToPosition(door, -90)
      end
      wait(0.5)
      if IsValidHandle(door) then
        if (data.Disable.AssocJumpVolumes[1] ~= "None") then
          local array_length = (#data.Disable.AssocJumpVolumes)
          for i = 1, array_length do
            if IsValidHandle(data.Disable.AssocJumpVolumes[i]) then
              disableJumpVolumeAvailability(data.Disable.AssocJumpVolumes[i])
            end
          end
        end
      end
      wait(3.75)
    end
    if IsValidHandle(door) then
      if IsHidden(anim) then
        Unhide(anim)
      end
    elseif (IsHidden(anim) == false) then
      Hide(anim)
    end
    if IsValidHandle(target) then
      FireUser1(target)
    end
  end
  return 
end
Prefab_TurretDumboBlockerCheck = function(reg_0)
end

