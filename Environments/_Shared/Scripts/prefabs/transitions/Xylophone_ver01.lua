gsXy_StartUp_Xylophone_ver01 = function(target)
  Print("__Function: gsXy_StartUp_Xylophone_ver01")
  for x = 1, 5 do
    StartRotateToPosition(GetRelativePrefabEntity(target, (".Xylophone_0" .. tostring(x))), 0)
    StartRotateToPosition(GetRelativePrefabEntity(target, (".Hammer" .. tostring(x))), 0)
  end
  if (0 < (#GetPrefabData(target).XylophonePatterns)) then
    SetPropertyFloat(GetRelativePrefabEntity(target, ".cycle01_timer"), "TimerInterval", GetPrefabData(target).TimerStep)
    TimerEnable(GetRelativePrefabEntity(target, ".cycle01_timer"))
  end
  return 
end
gsXy_HitStep = function(target, _Step)
  local data = GetPrefabData(target)
  local NumberStep = tonumber(_Step)
  if (data.BarLoop[NumberStep] == 0) then
    local hammer = GetRelativePrefabEntity(target, (".Hammer" .. tostring(_Step)))
    local toon = GetRelativePrefabEntity(target, (".Xylophone_0" .. tostring(_Step)))
    SetRotatorMaxSpeed(hammer, 15)
    SetPropertyFloat(hammer, "Acceleration", 15)
    StartRotateToPosition(hammer, 15)
    AudioPostEventOn(toon, "Play_sfx_dec_mallet_beater_drop_short")
    wait(0.5)
    SetRotatorMaxSpeed(hammer, 270)
    SetPropertyFloat(hammer, "Acceleration", 270)
    StartRotateToPosition(hammer, -60)
    AudioPostEventOn(toon, "Play_sfx_dec_mallet_beater_drop_long")
    if (data.BarToon[NumberStep] == 0) then
      local bar_spin = -60
      data.BarLoop[NumberStep] = 1
      while true do
        if (data.BarLoop[NumberStep] == 1) then
          wait(0.3330000042915344)
          bar_spin = (bar_spin - 90)
          if (bar_spin <= -420) then
            bar_spin = -60
            if (data.BarToon[NumberStep] == 1) then
              data.BarLoop[NumberStep] = 0
            end
          end
          StartRotateToPosition(hammer, bar_spin)
        end
      end
    elseif (data.BarToon[NumberStep] == 1) then
      wait(0.30000001192092896)
      AudioPostEventOn(toon, "Play_sfx_dec_mallet_tone")
      StartRotateToPosition(hammer, 0)
    end
  end
  return 
end
gsXy_CycleHits = function(target)
  local data = GetPrefabData(target)
  local ParentTableSize = (#data.XylophonePatterns)
  if (math.mod(ParentTableSize, 2) == 0) then
    Print("__** YOU HAVE TOO MANY ARGUMENTS, RETURNING. MAKE SURE THE FORMAT IS {{FIRSTPATTERN}, TIME1, {SECONDPATTERN}, TIME2, {LAST PATTERN }} ETC **__")
    return 
  end
  for x = 1, ParentTableSize do
    if (math.mod(x, 2) == 0) then
      wait(data.XylophonePatterns[x])
    else
      local ChildTableSize = (#data.XylophonePatterns[x])
      for y = 1, ChildTableSize do
        FireThread(gsXy_HitStep, target, tostring(data.XylophonePatterns[x][y]))
      end
    end
  end
  return 
end
gsXy_BarStateChange = function(target, _Bar, _State)
  Print(((("__Function: gsXy_BarStateChange, _Bar: " .. tostring(_Bar)) .. ", _State: ") .. tostring(_State)))
  GetPrefabData(target).BarToon[tonumber(_Bar)] = tonumber(_State)
  Print(((("__Bar " .. tostring(_Bar)) .. " State changed to: ") .. tostring(_State)))
  return 
end

