gsCT_OswaldWaiting_Side01 = function(target)
  local data = GetPrefabData(target)
  data.OswaldWaiting = 1
  if (data.trolleyInPlay == 0) then
    if (data.MickeyWaiting == 1) then
      OswaldJumpNoFollowAction(GetRelativePrefabEntity(target, ".Oswald_PositionMarker 01"))
    end
  end
  return 
end
gsCT_OswaldGone = function(target)
  local data = GetPrefabData(target)
  if (data.Oswald_Complete == 2) then
    data.OswaldWaiting = 0
  end
  return 
end
gsCT_MickeyWaiting_Side01 = function(target)
  local data = GetPrefabData(target)
  data.MickeyWaiting = 1
  return 
end
gsCT_MickeyNotWaiting_Side01 = function(target)
  local data = GetPrefabData(target)
  data.MickeyWaiting = 0
  if (data.MickeyOnboard == 0) then
    OswaldStartFollowAction()
  end
  return 
end
gsCT_MickeyOnboard = function(target)
  local data = GetPrefabData(target)
  data.Mickey_Onboard = 1
  if (data.Oswald_Onboard == 1) then
    if (data.trolleyInPlay == 0) then
      OswaldBlastAction(GetRelativePrefabEntity(target, ".bicyclePlatform"))
    end
  end
  return 
end
gsCT_MickeyOffboard = function(target)
  local data = GetPrefabData(target)
  data.Mickey_Onboard = 0
  return 
end
gsCT_OswaldOnboard = function(target)
  local data = GetPrefabData(target)
  data.Oswald_Onboard = 1
  if (data.Mickey_Onboard == 1) then
    if (data.trolleyInPlay == 0) then
      OswaldBlastAction(GetRelativePrefabEntity(target, ".bicyclePlatform"))
    end
  end
  return 
end
gsCT_OswaldOffboard = function(target)
  local data = GetPrefabData(target)
  data.Oswald_Onboard = 0
  return 
end
gsCT_TrolleyStartUp = function(target)
  local data = GetPrefabData(target)
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".bicyclePlatform"), GetRelativePrefabEntity(target, ".SplineKnot 01"), GetRelativePrefabEntity(target, ".SplineKnot 02"), 1)
  AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), "attractLoop")
  SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.30000001192092896, 0.44999998807907104))
  SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(1, 0.4000000059604645, 0))
  return 
end
gsCT_TrolleyReturns = function(target)
  local data = GetPrefabData(target)
  AnimGBSequence(GetRelativePrefabEntity(target, ".bicyclePlatformAnim"), "idle")
  wait(0.4000000059604645)
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".bicyclePlatform"), GetRelativePrefabEntity(target, ".SplineKnot 01"), GetRelativePrefabEntity(target, ".SplineKnot 02"), 1)
  AnimGBSequence(GetRelativePrefabEntity(target, ".bicyclePlatformAnim"), "reverse")
  AudioPostEventOn(target, "Play_sfx_dec_zipline_start")
  AudioPostEventOn(target, "Play_sfx_dec_tight_rope_walk_lp")
  wait(4.5)
  AnimGBSequence(GetRelativePrefabEntity(target, ".bicyclePlatformAnim"), "idle")
  AudioPostEventOn(target, "Play_sfx_dec_zipline_stop")
  AudioPostEventOn(target, "Stop_sfx_dec_tight_rope_walk_lp")
  AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), "attractLoop")
  SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.30000001192092896, 0.44999998807907104))
  SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(1, 0.4000000059604645, 0))
  gsCT_disableCollsionOswald(target)
  data.trolleyInPlay = 0
  return 
end
gsCT_FireFunction = function(target, _FunctionName, _Delay)
  Print(((("__Function: gsCT_FireFunction, _FunctionName: " .. tostring(_FunctionName)) .. ", _Delay: ") .. tostring(_Delay)))
  wait(tonumber(_Delay))
  FireThread(_G[_FunctionName], target)
  return 
end
gsCT_TrolleyCharged = function(target, event)
  Print("__Function: gsCT_TrolleyCharged")
  local alias = StimulusEvent_SourceStimulusAlias(event)
  local data = GetPrefabData(target)
  if (alias == "ElectricBlast") then
    if (data.StartFunction[1] ~= "FunctionName") then
      if (0 <= data.StartFunction[2]) then
        if (data.StartFunction[3] == 1) then
          Print("__ONCE ONLY true! Firing once!")
          data.StartFunction[reg_16] = 2
          FireThread(gsCT_FireFunction, target, data.StartFunction[1], data.StartFunction[2])
        elseif (data.StartFunction[3] == 2) then
          Print("__This function already fired!")
        elseif (data.StartFunction[3] == 0) then
          Print("__ONCE ONLY false! Firing!")
          FireThread(gsCT_FireFunction, target, data.StartFunction[1], data.StartFunction[2])
        else
          Print("__Invalid ONCE ONLY flag! Function will not attempt to fire!")
          Print("__Invalid DELAY time! Function will not attempt to fire!")
        end
      else
        Print("__Invalid DELAY time! Function will not attempt to fire!")
      end
    end
    if (data.trolleyInPlay == 0) then
      AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), "stage3")
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(0, 0.4000000059604645, 1))
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.699999988079071, 1))
      data.trolleyInPlay = 1
      wait(0.5)
      SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".bicyclePlatform"), GetRelativePrefabEntity(target, ".SplineKnot 01"), GetRelativePrefabEntity(target, ".SplineKnot 02"), 0)
      AnimGBSequence(GetRelativePrefabEntity(target, ".bicyclePlatformAnim"), "loop")
      AudioPostEventOn(target, "Play_sfx_dec_zipline_start")
      AudioPostEventOn(target, "Play_sfx_dec_tight_rope_walk_lp")
      wait(4.5)
      AnimGBSequence(GetRelativePrefabEntity(target, ".bicyclePlatformAnim"), "idle")
      AudioPostEventOn(target, "Play_sfx_dec_zipline_stop")
      AudioPostEventOn(target, "Stop_sfx_dec_tight_rope_walk_lp")
      wait(2)
      while true do
        while true do
          wait(0.10000000149011612)
          data = GetPrefabData(target)
        end
      end
      gsCT_TrolleyReturns(target)
    end
  end
  wait(3)
  return 
end
gsCT_TestOverride = function(target)
  local data = GetPrefabData(target)
  if (data.trolleyPosition == 0) then
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".bicyclePlatform"), GetRelativePrefabEntity(target, ".SplineKnot 01"), GetRelativePrefabEntity(target, ".SplineKnot 02"), 1)
    AnimGBSequence(GetRelativePrefabEntity(target, ".bicyclePlatformAnim"), "loop")
    data.trolleyPosition = 1
    wait(5)
    AnimGBSequence(GetRelativePrefabEntity(target, ".bicyclePlatformAnim"), "idle")
  elseif (data.trolleyPosition == 1) then
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".bicyclePlatform"), GetRelativePrefabEntity(target, ".SplineKnot 01"), GetRelativePrefabEntity(target, ".SplineKnot 02"), 0)
    AnimGBSequence(GetRelativePrefabEntity(target, ".bicyclePlatformAnim"), "loop")
    data.trolleyPosition = 0
    wait(5)
    AnimGBSequence(GetRelativePrefabEntity(target, ".bicyclePlatformAnim"), "idle")
  end
  return 
end
gsCT_disableCollsionOswald = function(reg_0)
end

