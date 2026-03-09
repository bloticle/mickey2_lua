Prefab_DualSwitches_Hit = function(target, lever)
  local data = GetPrefabData(target)
  local leverState = ""
  local otherLever = ""
  if (lever == "1") then
    leverState = data.Lever01State
    otherLever = GetRelativePrefabEntity(target, ".Lever02")
  else
    leverState = data.Lever02State
    otherLever = GetRelativePrefabEntity(target, ".Lever01")
  end
  if (leverState == 0) then
    if (data.Trigger01State == 1) then
      if (data.Trigger02State == 1) then
        OswaldSpinAction(otherLever)
      end
    end
    Reverse(target)
    SetRotatorMaxSpeed(target, data.ForwardSpeed)
    wait(0.125)
    if (leverState == 0) then
      if (GetPropertyFloat(target, "Max Speed") ~= 0) then
        Reverse(target)
        SetRotatorMaxSpeed(target, data.ReverseSpeed)
        Print("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Both levers not in position, reversing direction")
      end
    else
      SetRotatorMaxSpeed(target, 0)
      Print("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Lever has already reached its end position")
    end
  else
    Print("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Lever has already reached its end position")
  end
  return 
end
Prefab_DualSwitches_ReachPosition = function(target, lever)
  local data = GetPrefabData(target)
  if (GetPropertyFloat(target, "Max Speed") == data.ForwardSpeed) then
    SetVulnerability(target, ST_SPIN, 0)
    SetRotatorMaxSpeed(target, 0)
    AudioPostEventOn(GetPlayer(), "Play_sfx_FGY_dualSwitch_stop")
    if (lever == "1") then
      data.Lever01State = 1
    else
      data.Lever02State = 1
    end
    Wait(0.30000001192092896)
    if (data.Lever01State == 1) then
      if (data.Lever02State == 1) then
        if (data.SuccessState == 0) then
          data.SuccessState = 1
          if (data.SuccessFunction == "None") then
            Print("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: No success function declared")
          else
            if (data.FunctionParam1 == "None") then
              FireThread(_G[data.SuccessFunction])
              Print(("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Firing Success Function " .. tostring(data.SuccessFunction)))
            else
              FireThread(_G[data.SuccessFunction], data.FunctionParam1)
              Print((((("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Firing Success Function " .. tostring(data.SuccessFunction)) .. "(") .. tostring(data.FunctionParam1)) .. ")"))
            end
            Disable(GetRelativePrefabEntity(target, ".Node01"))
            Disable(GetRelativePrefabEntity(target, ".Node02"))
            Reverse(target)
            SetRotatorMaxSpeed(target, data.ReverseSpeed)
            Wait(0.30000001192092896)
            SetVulnerability(target, ST_SPIN, 1)
            if (lever == "1") then
              data.Lever01State = 0
            else
              data.Lever02State = 0
            end
            data.SuccessState = 0
            if (GetPropertyFloat(target, "Max Speed") == 800) then
              SetRotatorMaxSpeed(target, data.ForwardSpeed)
              SetVulnerability(target, ST_SPIN, 1)
              AudioPostEventOn(GetPlayer(), "Play_sfx_FGY_dualSwitch_stop")
            else
              Print("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Lever returned to original position")
            end
          end
        end
      end
    else
      Reverse(target)
      SetRotatorMaxSpeed(target, data.ReverseSpeed)
      Wait(0.30000001192092896)
      SetVulnerability(target, ST_SPIN, 1)
      if (lever == "1") then
        data.Lever01State = 0
      else
        data.Lever02State = 0
      end
      data.SuccessState = 0
      if (GetPropertyFloat(target, "Max Speed") == 800) then
        SetRotatorMaxSpeed(target, data.ForwardSpeed)
        SetVulnerability(target, ST_SPIN, 1)
        AudioPostEventOn(GetPlayer(), "Play_sfx_FGY_dualSwitch_stop")
      else
        Print("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Lever returned to original position")
      end
    end
  elseif (GetPropertyFloat(target, "Max Speed") == 800) then
    SetRotatorMaxSpeed(target, data.ForwardSpeed)
    SetVulnerability(target, ST_SPIN, 1)
    AudioPostEventOn(GetPlayer(), "Play_sfx_FGY_dualSwitch_stop")
  else
    Print("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Lever returned to original position")
  end
  return 
end
Prefab_DualSwitches_ChangeState = function(target, state)
  local data = GetPrefabData(target)
  Print("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Prefab_DualSwitches_ChangeState fired")
  if (state == "Reset") then
    Print("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Switches are being reset")
    data.SuccessState = 0
    if (data.Lever01State == 1) then
      data.Lever01State = 0
      Reverse(GetRelativePrefabEntity(target, ".Lever01"))
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".Lever01"), 800)
    end
    if (data.Lever02State == 1) then
      data.Lever02State = 0
      Reverse(GetRelativePrefabEntity(target, ".Lever02"))
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".Lever02"), 800)
    end
  elseif (state == "Reverse") then
    Print("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Switches are being reversed")
    data.SuccessState = 0
    if (data.Lever01State == 1) then
      data.Lever01State = 0
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".Lever01"), data.ForwardSpeed)
    else
      Reverse(GetRelativePrefabEntity(target, ".Lever01"))
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".Lever01"), 800)
    end
    if (data.Lever02State == 1) then
      data.Lever02State = 0
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".Lever02"), data.ForwardSpeed)
    else
      Reverse(GetRelativePrefabEntity(target, ".Lever02"))
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".Lever02"), 800)
    end
  end
  return 
end
Prefab_DualSwitches_SetPath = function(target, action, node)
  local data = GetPrefabData(target)
  local activator = _activator()
  if (action == "enter") then
    if (node == "1") then
      data.Trigger01State = (data.Trigger01State + 1)
    else
      data.Trigger02State = (data.Trigger02State + 1)
    end
    if (GetName(activator) == GetName(GetPlayer())) then
      Enable(GetRelativePrefabEntity(target, (".Node0" .. tostring(node))))
    end
  elseif (action == "exit") then
    if (node == "1") then
      data.Trigger01State = (data.Trigger01State - 1)
    else
      data.Trigger02State = (data.Trigger02State - 1)
    end
    if (GetName(activator) == GetName(GetPlayer())) then
      Disable(GetRelativePrefabEntity(target, (".Node0" .. tostring(node))))
    end
  end
  return 
end
Prefab_DualSwitches_DebugInfo = function(target)
  local data = GetPrefabData(target)
  Print(("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Lever 1 speed = " .. tostring(GetPropertyFloat(GetRelativePrefabEntity(target, ".Lever01"), "Max Speed"))))
  Print(("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Lever 2 speed = " .. tostring(GetPropertyFloat(GetRelativePrefabEntity(target, ".Lever02"), "Max Speed"))))
  Print(("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Lever 1 state = " .. tostring(data.Lever01State)))
  Print(("+_+_+_+_+_+_+_+_+_+ DualSwitches_AutoReverse_Prefab: Lever 2 state = " .. tostring(data.Lever02State)))
  return 
end
