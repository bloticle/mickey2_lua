NOS_SpittingFrog_AlwaysSetup = function(target)
  Print("__Function: NOS_SpittingFrog_AlwaysSetup")
  local data = GetPrefabData(target)
  wait(0.10000000149011612)
  if (GetGlobal(data.Global) == -1) then
    Print("__This frog has been permanently disabled!")
    Disable(GetRelativePrefabEntity(target, ".Shooter"))
    Unhide(GetRelativePrefabEntity(target, ".ShockReactFX"))
    StartEmitters(GetRelativePrefabEntity(target, ".ShockReactFX"))
    AudioPostEventOn(target, "Play_sfx_FrogSpitters_Shocked")
    Disable(("SpittingFrog_OswaldAction" .. tostring(string.sub(GetPropertyString(GetRelativePrefabEntity(target, ".Frog"), "EntityGroups", 1), -1, -1))))
    data.FrogState = "PermaDisabled"
  elseif (GetGlobal(data.Global) == 1) then
    Print("__This frog's toon is thinned!")
    Disable(GetRelativePrefabEntity(target, ".Shooter"))
    Disable(("SpittingFrog_OswaldAction" .. tostring(string.sub(GetPropertyString(GetRelativePrefabEntity(target, ".Frog"), "EntityGroups", 1), -1, -1))))
    data.FrogState = "Idle"
  else
    Print("__This frog's toon is painted!")
  end
  Print(("__New Frog State: " .. tostring(data.FrogState)))
  return 
end
SpittingFrog_DisableShooter = function(target, event)
  local data = GetPrefabData(target)
  if (GetGlobal(data.Global) ~= -1) then
    if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
      if (data.FrogState ~= "Shocked") then
        data.FrogState = "Shocked"
        Disable(("SpittingFrog_OswaldAction" .. tostring(string.sub(GetPropertyString(GetRelativePrefabEntity(target, ".Frog"), "EntityGroups", 1), -1, -1))))
        Disable(GetRelativePrefabEntity(target, ".Shooter"))
        Unhide(GetRelativePrefabEntity(target, ".ShockReactFX"))
        StartEmitters(GetRelativePrefabEntity(target, ".ShockReactFX"))
        AudioPostEventOn(target, "Play_sfx_FrogSpitters_Shocked")
        TimerEnable(GetRelativePrefabEntity(target, ".ReEnableTimer"))
        wait(1)
        OswaldStreamAbort()
      end
    end
  end
  Print(("__New Frog State: " .. tostring(data.FrogState)))
  return 
end
SpittingFrog_EnableShooter = function(target)
  Print("__Function: SpittingFrog_EnableShooter")
  local data = GetPrefabData(target)
  TimerDisable(target)
  TimerReset(target)
  StopEmitters(GetRelativePrefabEntity(target, ".ShockReactFX"))
  Hide(GetRelativePrefabEntity(target, ".ShockReactFX"))
  AudioPostEventOn(target, "Stop_sfx_FrogSpitters_Shocked")
  Enable(("SpittingFrog_OswaldAction" .. tostring(string.sub(GetPropertyString(GetRelativePrefabEntity(target, ".Frog"), "EntityGroups", 1), -1, -1))))
  if (GetGlobal(data.Global) == 0) then
    if (data.FrogState == "Shocked") then
      Enable(GetRelativePrefabEntity(target, ".Shooter"))
      data.FrogState = "Shooting"
    end
  elseif (data.FrogState ~= "PermaDisabled") then
    data.FrogState = "Idle"
  end
  Print(("__New Frog State: " .. tostring(data.FrogState)))
  return 
end
SpittingFrog_ToonDockStateChanged = function(target, _DockPiece, _State)
  Print(("__Function: SpittingFrog_ToonDockStateChanged, _DockPiece: " .. tostring(_DockPiece)))
  local data = GetPrefabData(("SpittingFrog" .. tostring(_DockPiece)))
  if (GetGlobal(data.Global) ~= -1) then
    if (_State == "Thinned") then
      if (data.FrogState == "Shooting") then
        Disable(GetRelativePrefabEntity(("SpittingFrog" .. tostring(_DockPiece)), ".Shooter"))
        data.FrogState = "Idle"
      end
      SetGlobal(data.Global, 1)
    elseif (_State == "Painted") then
      if (data.FrogState == "Idle") then
        Enable(GetRelativePrefabEntity(("SpittingFrog" .. tostring(_DockPiece)), ".Shooter"))
        data.FrogState = "Shooting"
      end
      SetGlobal(data.Global, 0)
    end
  end
  Print(("__New Frog State: " .. tostring(data.FrogState)))
  return 
end
SpittingFrog_DisablePermanently = function(target)
  Print("__Function: SpittingFrog_DisablePermanently")
  Disable(GetRelativePrefabEntity(target, ".Shooter"))
  TimerDisable(GetRelativePrefabEntity(target, ".ReEnableTimer"))
  Unhide(GetRelativePrefabEntity(target, ".ShockReactFX"))
  StartEmitters(GetRelativePrefabEntity(target, ".ShockReactFX"))
  AudioPostEventOn(target, "Play_sfx_FrogSpitters_Shocked")
  SetGlobal(GetPrefabData(target).Global, -1)
  GetPrefabData(target).FrogState = "PermaDisabled"
  Disable(("SpittingFrog_OswaldAction" .. tostring(string.sub(GetPropertyString(GetRelativePrefabEntity(target, ".Frog"), "EntityGroups", 1), -1, -1))))
  Print(("__New Frog State: " .. tostring(GetPrefabData(target).FrogState)))
  return 
end
