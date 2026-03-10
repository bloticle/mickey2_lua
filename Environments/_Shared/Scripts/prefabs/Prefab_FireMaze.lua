Prefab_Firemaze_Setup = function(target)
  local data = GetPrefabData(target)
  local rotator = GetRelativePrefabEntity(target, ".FireMazeMainColumn")
  local Firemaze_setup = function(direction)
    if (data[("FireMaze" .. direction)] == "On") then
      if (GetGlobal(data.FireMazeTurnedOffGlobal) == 0) then
        Enable(GetRelativePrefabEntity(target, (".FireMazeDamageVolume" .. direction)))
      end
    elseif (data[("FireMaze" .. direction)] == "On") then
      if (GetGlobal(data.FireMazeTurnedOffGlobal) == 1) then
        Disable(GetRelativePrefabEntity(target, (".FireMazeDamageVolume" .. direction)))
      end
    end
    return 
  end
  if (data.GlobalToCheck ~= "none") then
    data.CurrentAngle = GetGlobal(data.GlobalToCheck)
    SetRotatorMaxSpeed(rotator, 400)
    StartRotateToPosition(rotator, GetGlobal(data.GlobalToCheck))
  end
  Firemaze_setup("North")
  Firemaze_setup("South")
  Firemaze_setup("East")
  Firemaze_setup("West")
  if (GetGlobal(data.FireMazeTurnedOffGlobal) == 1) then
    AnimGBSequence(GetRelativePrefabEntity(target, ".FireMazeMainColumn"), "Off")
    ForEachEntityInGroup(AnimGBSequence, "AdditionalFirePoles", "Off")
    ForEachEntityInGroup(Disable, "AdditionalDamageVolumes")
  end
  return 
end
Prefab_FireMazeRotateColumn = function(target, state)
  local rotator = GetRelativePrefabEntity(target, ".FireMazeMainColumn")
  local data = GetPrefabData(target)
  if (state == nil) then
    data.CurrentAngle = (data.CurrentAngle + data.AmountToTurn)
  else
    data.CurrentAngle = (data.CurrentAngle + (data.AmountToTurn * -1))
  end
  SetRotatorMaxSpeed(rotator, (data.AmountToTurn / 2))
  StartRotateToPosition(rotator, data.CurrentAngle)
  AudioPostEventOn(rotator, "Play_sfx_rbc_devil_screens")
  SetGlobal(data.GlobalToCheck, data.CurrentAngle)
  local ToggleFireMaze = function(direction, enable)
    if (data[("FireMaze" .. direction)] == "On") then
      if enable then
        Enable(GetRelativePrefabEntity(target, (".FireMazeDamageVolume" .. direction)))
        AudioPostEventOn(rotator, "Play_sfx_rbc_LavaCurtain_Engage")
        Print("SFX Curtain Engage")
      else
        Disable(GetRelativePrefabEntity(target, (".FireMazeDamageVolume" .. direction)))
        AudioPostEventOn(rotator, "Play_sfx_rbc_LavaCurtain_Disengage")
        Print("SFX Curtain Disengage")
      end
    end
    return 
  end
  if (GetGlobal(data.FireMazeTurnedOffGlobal) == 0) then
    ToggleFireMaze("North", false)
    ToggleFireMaze("South", false)
    ToggleFireMaze("East", false)
    ToggleFireMaze("West", false)
    AnimGBSequence(rotator, "End")
    wait(1.3329999446868896)
    AnimGBSequence(rotator, "Start")
    wait(0.6660000085830688)
    AnimGBSequence(rotator, "Loop")
    ToggleFireMaze("North", true)
    ToggleFireMaze("South", true)
    ToggleFireMaze("East", true)
    ToggleFireMaze("West", true)
  end
  return 
end
Prefab_FireMazeChangeState = function(target, state)
  local data = GetPrefabData(target)
  local FireMazeOffOn = function(direction, enable)
    if (data[("FireMaze" .. direction)] == "On") then
      if enable then
        Enable(GetRelativePrefabEntity(target, (".FireMazeDamageVolume" .. direction)))
      else
        Disable(GetRelativePrefabEntity(target, (".FireMazeDamageVolume" .. direction)))
      end
    end
    return 
  end
  if (state == "off") then
    SetGlobal(data.FireMazeTurnedOffGlobal, 1)
    AnimGBSequence(GetRelativePrefabEntity(target, ".FireMazeMainColumn"), "End")
    FireMazeOffOn("North", false)
    FireMazeOffOn("South", false)
    FireMazeOffOn("East", false)
    FireMazeOffOn("West", false)
    AudioPostEventOn("rbc_caverns_01a_audio.lava_ambiance_Parent", "Set_sfx_rbc_lava_ambLP_LowPassOn")
    ForEachEntityInGroup(AnimGBSequence, "AdditionalFirePoles", "End")
    ForEachEntityInGroup(Disable, "AdditionalDamageVolumes")
  elseif (state == "on") then
    SetGlobal(data.FireMazeTurnedOffGlobal, 0)
    AnimGBSequence(GetRelativePrefabEntity(target, ".FireMazeMainColumn"), "Start")
    ForEachEntityInGroup(AnimGBSequence, "AdditionalFirePoles", "Start")
    wait(0.6660000085830688)
    ForEachEntityInGroup(Enable, "AdditionalDamageVolumes")
    FireMazeOffOn("North", true)
    FireMazeOffOn("South", true)
    FireMazeOffOn("East", true)
    FireMazeOffOn("West", true)
    AudioPostEventOn("rbc_caverns_01a_audio.lava_ambiance_Parent", "Set_sfx_rbc_lava_ambLP_LowPassOff")
    AnimGBSequence(GetRelativePrefabEntity(target, ".FireMazeMainColumn"), "Loop")
    ForEachEntityInGroup(AnimGBSequence, "AdditionalFirePoles", "Loop")
  end
  return 
end

