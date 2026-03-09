gsSB_CycleTimer = function(target)
  local data = GetPrefabData(target)
  local FullCycle = 0
  if (3 < data.PatternIntervals) then
    FullCycle = ((FullCycle + data.Interval04) + 1.399999976158142)
  end
  if (2 < data.PatternIntervals) then
    FullCycle = ((FullCycle + data.Interval03) + 1.399999976158142)
  end
  if (1 < data.PatternIntervals) then
    FullCycle = ((FullCycle + data.Interval02) + 1.399999976158142)
  end
  if (0 < data.PatternIntervals) then
    FullCycle = ((FullCycle + data.Interval01) + 1.399999976158142)
  end
  local boot = GetRelativePrefabEntity(target, ".boot")
  while true do
    if (not IsValidHandle(boot)) then
      break
    end
    FireThread(gsSB_BootStomp, target)
    wait(FullCycle)
  end
  return 
end
gsSB_BootStomp = function(target)
  local data = GetPrefabData(target)
  local countdown = data.PatternIntervals
  local boot = GetRelativePrefabEntity(target, ".boot")
  local boot_FX = GetRelativePrefabEntity(target, ".bootwarning")
  local knot1 = GetRelativePrefabEntity(target, ".BootSplineKnot 01")
  local knot2 = GetRelativePrefabEntity(target, ".BootSplineKnot 02")
  while (0 < countdown) do
    if (not IsValidHandle(boot)) then
      break
    end
    StartEmitters(boot_FX)
    wait(0.5)
    SetSplineFollowerInitialSpeed(boot, 4)
    SplineFollower_StopAtPosition(boot, knot1, knot2, 0.699999988079071)
    wait(0.5)
    SetSplineFollowerInitialSpeed(boot, 12)
    SplineFollower_StopAtPosition(boot, knot1, knot2, 0)
    AudioPostEventOn(GetRelativePrefabEntity(target, ".Oswald_PlaneTrigger 01"), "Play_sfx_dec_hydrolic_boots_stomp")
    StopEmitters(boot_FX)
    wait(0.4000000059604645)
    if IsValidHandle(boot) then
      FireThread(gsSB_BootReset, boot, knot1, knot2)
    end
    if (countdown == 4) then
      if (data.OswaldGoInt == 4) then
        if (0 < data.OswaldWaiting) then
          gsSB_Oswald_Pass(target)
        end
      end
      wait(data.Interval04)
    elseif (countdown == 3) then
      if (data.OswaldGoInt == 3) then
        if (0 < data.OswaldWaiting) then
          gsSB_Oswald_Pass(target)
        end
      end
      wait(data.Interval03)
    elseif (countdown == 2) then
      if (data.OswaldGoInt == 2) then
        if (0 < data.OswaldWaiting) then
          gsSB_Oswald_Pass(target)
        end
      end
      wait(data.Interval02)
    elseif (countdown == 1) then
      if (data.OswaldGoInt == 1) then
        if (0 < data.OswaldWaiting) then
          gsSB_Oswald_Pass(target)
        end
      end
      wait(data.Interval01)
    end
    countdown = (countdown - 1)
  end
  return 
end
gsSB_BootReset = function(boot, knot1, knot2)
  local dataBall = GetPrefabData(boot)
  SetSplineFollowerInitialSpeed(boot, 12)
  SplineFollower_StopAtPosition(boot, knot1, knot2, 1)
  return 
end
gsSB_Oswald_AtBootLeft = function(target)
  local data = GetPrefabData(target)
  data.OswaldWaiting = 1
  Print("**************************************************************** OSWALD AT LEFT OF BOOT")
  return 
end
gsSB_Oswald_AtBootRght = function(target)
  local data = GetPrefabData(target)
  data.OswaldWaiting = 2
  Print("**************************************************************** OSWALD AT RIGHT OF BOOT")
  return 
end
gsSB_Oswald_Gone = function(target)
  local data = GetPrefabData(target)
  data.OswaldWaiting = 0
  Print("**************************************************************** OSWALD IS CLEAR OF BOOT")
  return 
end
gsSB_Oswald_Pass = function(target)
  local data = GetPrefabData(target)
  if (data.OswaldWaiting == 1) then
    OswaldIgnoreObstaclesAction(GetRelativePrefabEntity(target, ".Oswald_PositionMarker 02"))
  elseif (data.OswaldWaiting == 2) then
    OswaldIgnoreObstaclesAction(GetRelativePrefabEntity(target, ".Oswald_PositionMarker 01"))
  elseif (data.OswaldWaiting == 99) then
    if (data.OswaldGoFireUserTarget ~= "None") then
      FireUser1(data.OswaldGoFireUserTarget)
    end
  end
  Print("**************************************************************** OSWALD GO")
  return 
end
