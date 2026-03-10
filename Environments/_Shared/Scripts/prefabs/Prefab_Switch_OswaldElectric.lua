Prefab_ActivateSwitch = function(target, event)
  local data = GetPrefabData(target)
  local alias = StimulusEvent_SourceStimulusAlias(event)
  Print("_+_+_+_+_+_+_+_+_+_+_ Prefab_ActivateSwitch() function entered")
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    Print("_+_+_+_+_+_+_+_+_+_+_ Prefab_ActivateSwitch() stim is electric")
    if (data.OswaldSwitchState == 0) then
      if (alias == "ElectricBlast") then
        if (data.RequiresConstantCharge == "False") then
          local timer = GetRelativePrefabEntity(target, ".OswaldSwitchTimersLogicTimer")
          data.OswaldLightState = 3
          SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(0, 0, 1))
          SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.699999988079071, 1))
          AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), ("stage" .. data.OswaldLightState), true, 0.009999999776482582)
          Prefab_ActivateSwitchTimerReset(timer)
        end
      else
        TimerEnable(GetRelativePrefabEntity(target, ".OswaldSwitchTimersLogicTimer"))
        data.OswaldSwitchState = 1
        if (data.GlobalToCheck ~= "none") then
          SetGlobal(data.GlobalToCheck, tonumber(data.OswaldSwitchState))
        end
        Print(("_+_+_+_+_+_+_+_+_+_+_ Prefab_ActivateSwitch: OswaldSwitchState = " .. data.OswaldSwitchState))
        if (data.RequiresConstantCharge ~= "False") then
          FireUser2(GetRelativePrefabEntity(target, ".OswaldSwitchSign"))
          FireThread(Prefab_OswaldSwitch_ConstantStreamLightsLoop, target)
          Print("_+_+_+_+_+_+_+_+_+_+_ Firing User2 event on receiving stim")
        elseif (data.RequiresConstantCharge == "False") then
          if (data.NoLever == "False") then
            FireThread(Prefab_OswaldSwitch_LightSequence, target)
          end
        elseif (data.RequiresConstantCharge ~= "True") then
          if (data.NoLever ~= "False") then
            SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(0, 0.4000000059604645, 1))
            AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), "stage3")
            data.OswaldLightState = 3
            Prefab_ActivateSwitchEndPositionCheck(target)
          end
        end
      end
    end
  end
  TimerReset(GetRelativePrefabEntity(target, ".OswaldSwitchTimersLogicTimer"))
  return 
end
Prefab_OswaldSwitch_ConstantStreamLightsLoop = function(target)
  local data = GetPrefabData(target)
  while true do
    if (not (data.OswaldSwitchState == 1)) then
      break
    end
    for i = 1, 3 do
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(0, 0, (i * 0.3199999928474426)))
      AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), ("stage" .. i))
      wait(0.6000000238418579)
      Print(("Prefab_OswaldSwitch_ConstantStreamLightsLoop Moving up" .. i))
      if (data.OswaldSwitchState ~= 1) then
        return 
      end
    end
  end
  return 
end
Prefab_OswaldSwitch_LightSequence = function(target)
  Print("_+_+_+_+_+_+_+_+_+_+_ Prefab_ActivateSwitch: Starting lights anims ")
  local data = GetPrefabData(target)
  local endcheck = false
  while true do
    while true do
      if (data.OswaldSwitchState == 1) then
        SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(0, 1, 0.10000000149011612))
        AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), ("stage" .. data.OswaldLightState), endcheck)
        data.OswaldLightState = (data.OswaldLightState + 1)
        if (3 <= data.OswaldLightState) then
          endcheck = true
          data.OswaldLightState = 3
          SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.699999988079071, 1))
        end
        if (5 <= data.OswaldSwitchSpeed) then
          Print("#### WARNING: OSWALD ELECTRIC SWITCH - YOUR TIME WAS TOO LONG. PLEASE FIX BY REDUCING THE TIME OVERRIDE")
        end
        wait(tonumber(data.OswaldSwitchSpeed))
      end
    end
  end
  return 
end
Prefab_ActivateSwitchTimerReset = function(target)
  local data = GetPrefabData(target)
  Print("_+_+_+_+_+_+_+_+_+_+_ Prefab_ActivateSwitchTimerReset()")
  TimerDisable(GetRelativePrefabEntity(target, ".OswaldSwitchTimersLogicTimer"))
  local lever = GetRelativePrefabEntity(target, ".OswaldSwitchLever")
  if (data.OswaldSwitchState == 1) then
    data.OswaldLightState = 1
    SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(1, 0, 0))
    AnimGBSequence(lever, "attractLoop")
    data.OswaldSwitchState = 0
    if (data.GlobalToCheck ~= "none") then
      SetGlobal(data.GlobalToCheck, tonumber(data.OswaldSwitchState))
    end
    if (data.RequiresConstantCharge ~= "False") then
      FireUser3(GetRelativePrefabEntity(target, ".OswaldSwitchSign"))
      Print("_+_+_+_+_+_+_+_+_+_+_ Firing User3 event on no longer receiving stim")
    end
  end
  Print(("_+_+_+_+_+_+_+_+_+_+_ Prefab_ActivateSwitchTimerReset: OswaldSwitchState = " .. data.OswaldSwitchState))
  return 
end
Prefab_ActivateSwitchEndPositionCheck = function(target)
  local data = GetPrefabData(target)
  Print("_+_+_+_+_+_+_+_+_+_+_ Prefab_ActivateSwitchEndPositionCheck()")
  if (data.RequiresConstantCharge == "False") then
    if (data.OswaldLightState == 3) then
      TimerDisable(GetRelativePrefabEntity(target, ".OswaldSwitchTimersLogicTimer"))
      data.OswaldSwitchState = 2
      if (data.GlobalToCheck ~= "none") then
        SetGlobal(data.GlobalToCheck, tonumber(data.OswaldSwitchState))
      end
      if (data.SuccessFunction == "None") then
        Print("_+_+_+_+_+_+_+_+_+_+_ Prefab_ActivateSwitchEndPositionCheck() SuccessFunction is None, so FireUser1 on .OswaldSwitchSign")
        FireUser1(GetRelativePrefabEntity(target, ".OswaldSwitchSign"))
      else
        Print("_+_+_+_+_+_+_+_+_+_+_ Prefab_ActivateSwitchEndPositionCheck() SuccessFunction exists")
        if (data.SuccessTarget == "None") then
          Print(("_+_+_+_+_+_+_+_+_+_+_ Prefab_ActivateSwitchEndPositionCheck() SuccessTarget is None, so FireThread " .. tostring(data.SuccessFunction)))
          FireThread(_G[data.SuccessFunction], target)
        else
          Print(((("_+_+_+_+_+_+_+_+_+_+_ Prefab_ActivateSwitchEndPositionCheck() SuccessTarget exists, so FireThread " .. tostring(data.SuccessFunction)) .. " on ") .. tostring(data.SuccessTarget)))
          FireThread(_G[data.SuccessFunction], data.SuccessTarget)
        end
      end
    end
  end
  return 
end
Prefab_OswaldElectricSwitch_ChangeState = function(target, state)
  local data = GetPrefabData(target)
  local lever = GetRelativePrefabEntity(target, ".OswaldSwitchLever")
  Print(("_+_+_+_+_+_+_+_+_+_+_ Prefab_OswaldElectricSwitch_ChangeState(): state = " .. state))
  if (state == "Activate") then
    if (data.OswaldSwitchState ~= 2) then
      data.OswaldSwitchState = 0
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.30000001192092896, 0.44999998807907104))
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(1, 0.4000000059604645, 0))
      AnimGBSequence(lever, "attractLoop")
      if (data.GlobalToCheck ~= "none") then
        SetGlobal(data.GlobalToCheck, tonumber(data.OswaldSwitchState))
      end
    end
  elseif (state == "Deactivate") then
    if (data.OswaldSwitchState == 0) then
      if (data.OswaldSwitchState == 1) then
        data.OswaldLightState = 1
      end
      data.OswaldSwitchState = -1
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0.15000000596046448, 0.15000000596046448, 0.15000000596046448))
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(0, 0, 0))
      AnimGBSequence(lever, "off")
      if (data.GlobalToCheck ~= "none") then
        SetGlobal(data.GlobalToCheck, tonumber(data.OswaldSwitchState))
        if (state == "Reset") then
          data.OswaldLightState = 1
          SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.30000001192092896, 0.44999998807907104))
          SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(1, 0.4000000059604645, 0))
          AnimGBSequence(lever, "attractLoop")
          data.OswaldSwitchState = 0
          if (data.GlobalToCheck ~= "none") then
            SetGlobal(data.GlobalToCheck, tonumber(data.OswaldSwitchState))
          end
        elseif (state == "FullyCharged") then
          data.OswaldSwitchState = 2
          if (data.GlobalToCheck ~= "none") then
            SetGlobal(data.GlobalToCheck, tonumber(data.OswaldSwitchState))
          end
          data.OswaldLightState = 3
          SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.699999988079071, 1))
          SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(0, 0, 1))
          AnimGBSequence(lever, "stage3")
        elseif (state == "Setup") then
          if (data.GlobalToCheck ~= "none") then
            data.OswaldSwitchState = GetGlobal(data.GlobalToCheck)
          end
          if (data.OswaldSwitchState == -1) then
            SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0.15000000596046448, 0.15000000596046448, 0.15000000596046448))
            SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(0, 0, 0))
            AnimGBSequence(lever, "off")
          elseif (data.OswaldSwitchState == 0) then
            SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.30000001192092896, 0.44999998807907104))
            SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(1, 0.4000000059604645, 0))
            AnimGBSequence(lever, "attractLoop")
          elseif (data.OswaldSwitchState == 2) then
            SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.699999988079071, 1))
            SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(0, 0, 1))
            AnimGBSequence(lever, "stage3")
          end
        end
      end
    end
  elseif (state == "Reset") then
    data.OswaldLightState = 1
    SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.30000001192092896, 0.44999998807907104))
    SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(1, 0.4000000059604645, 0))
    AnimGBSequence(lever, "attractLoop")
    data.OswaldSwitchState = 0
    if (data.GlobalToCheck ~= "none") then
      SetGlobal(data.GlobalToCheck, tonumber(data.OswaldSwitchState))
    end
  elseif (state == "FullyCharged") then
    data.OswaldSwitchState = 2
    if (data.GlobalToCheck ~= "none") then
      SetGlobal(data.GlobalToCheck, tonumber(data.OswaldSwitchState))
    end
    data.OswaldLightState = 3
    SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.699999988079071, 1))
    SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(0, 0, 1))
    AnimGBSequence(lever, "stage3")
  elseif (state == "Setup") then
    if (data.GlobalToCheck ~= "none") then
      data.OswaldSwitchState = GetGlobal(data.GlobalToCheck)
    end
    if (data.OswaldSwitchState == -1) then
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0.15000000596046448, 0.15000000596046448, 0.15000000596046448))
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(0, 0, 0))
      AnimGBSequence(lever, "off")
    elseif (data.OswaldSwitchState == 0) then
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.30000001192092896, 0.44999998807907104))
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(1, 0.4000000059604645, 0))
      AnimGBSequence(lever, "attractLoop")
    elseif (data.OswaldSwitchState == 2) then
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchSign"), 0, vector4(0, 0.699999988079071, 1))
      SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldSwitchLever"), 1, vector4(0, 0, 1))
      AnimGBSequence(lever, "stage3")
    end
  end
  return 
end

