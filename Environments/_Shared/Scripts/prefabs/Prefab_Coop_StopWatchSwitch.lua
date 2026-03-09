Prefab_Coop_StopWatchSwitch = function(target, Dir)
  Print(("Prefab_Coop_StopWatchSwitch: " .. Dir))
  if (Dir == "Setup") then
    local handle = GetRelativePrefabEntity(target, ".Handle")
    SetEntitiesToNotCollide(handle, target)
    SetEntitiesToNotCollide(handle, GetRelativePrefabEntity(target, ".OswaldSwitchStand"))
    SetEntitiesToNotCollide(handle, GetRelativePrefabEntity(target, ".OswaldSwitchLever"))
    SetEntitiesToNotCollide(handle, GetRelativePrefabEntity(target, ".OswaldSwitchSign"))
    local PN_ElectricStream = GetRelativePrefabEntity(target, ".PN_ElectricStream")
    GetPrefabData(PN_ElectricStream).FunctionParam1 = target
    SetPropertyBool(PN_ElectricStream, "ActionSpotEnabled", false)
    local stand = GetRelativePrefabEntity(target, ".OswaldSwitchStand")
    GetPrefabData(stand).FunctionParam1 = target
    GetPrefabData(GetRelativePrefabEntity(target, ".Handle")).stand = stand
    Print((("Prefab_Coop_StopWatchSwitch: " .. Dir) .. " Done"))
  elseif (Dir == "Shock") then
    if (GetPrefabData(target).BusyStreaming == false) then
      OswaldStreamAction(GetRelativePrefabEntity(target, ".OswaldSwitchTimersLogicTimer"))
    else
      SetPropertyBool(GetRelativePrefabEntity(target, ".PN_ElectricStream"), "ActionSpotEnabled", false)
      if (Dir == "HandleRelease") then
        local impulseDir, impulseDir = GetFacing(target), false
        impulseDir.x = (impulseDir.x * -200)
        impulseDir.z = (impulseDir.z * -200)
        impulseDir = impulseDir.x
        ApplyImpulse(target, impulseDir, 0, impulseDir.z)
        local stand, stand = GetPrefabData(target).stand, 0
        impulseDir = stand
        if (GetPrefabData(impulseDir).OswaldSwitchState ~= 2) then
          impulseDir = stand
          stand = "Reset"
          Prefab_OswaldElectricSwitch_ChangeState(impulseDir, stand)
          impulseDir = stand
          stand = "Deactivate"
          Prefab_OswaldElectricSwitch_ChangeState(impulseDir, stand)
        end
      elseif (Dir == "AnimGBEnded") then
        local anim_num = GetPropertyInt(target, "Active Sequence ID")
        anim_num = anim_num
        Print(((("Prefab_Coop_StopWatchSwitch: " .. Dir) .. " anim_num = ") .. anim_num))
        local data = GetPrefabData(target)
        if (anim_num == 1) then
          data.WatchState = "Open"
        elseif (anim_num == 2) then
          AnimGBSequence(target, "Rest")
          data.WatchState = "Closed"
        end
        anim_num = data.TriggerState
        FireThread(Prefab_Coop_StopWatchSwitch, target, anim_num)
      else
        local data = GetPrefabData(target)
        Print(("Prefab_Coop_StopWatchSwitch: data.WatchState = " .. data.WatchState))
        data.TriggerState = Dir
        if (data.WatchState ~= "Opening") then
          if (data.WatchState ~= "Closing") then
            Print("Prefab_Coop_StopWatchSwitch: data.WatchState != Opening or Closing")
            if (Dir == "In") then
              if (data.WatchState ~= "Open") then
                data.WatchState = "Opening"
              end
              AnimGBSequence(GetRelativePrefabEntity(target, ".Stopwatch"), "Open", true)
              local stand = GetRelativePrefabEntity(target, ".OswaldSwitchStand")
              if (GetPrefabData(stand).OswaldSwitchState ~= 2) then
                SetPropertyBool(GetRelativePrefabEntity(target, ".PN_ElectricStream"), "ActionSpotEnabled", true)
                Prefab_OswaldElectricSwitch_ChangeState(stand, "Activate")
              end
            elseif (Dir == "Out") then
              if (data.WatchState ~= "Closed") then
                data.WatchState = "Closing"
                OswaldStreamAbort()
                AnimGBSequence(GetRelativePrefabEntity(target, ".Stopwatch"), "close", true)
              end
              local stand = GetRelativePrefabEntity(target, ".OswaldSwitchStand")
              if (GetPrefabData(stand).OswaldSwitchState ~= 2) then
                SetPropertyBool(GetRelativePrefabEntity(target, ".PN_ElectricStream"), "ActionSpotEnabled", false)
                Prefab_OswaldElectricSwitch_ChangeState(stand, "Reset")
                Prefab_OswaldElectricSwitch_ChangeState(stand, "Deactivate")
              end
            end
          end
        end
      end
    end
  elseif (Dir == "HandleRelease") then
    local impulseDir = GetFacing(target)
    impulseDir.x = (impulseDir.x * -200)
    impulseDir.z = (impulseDir.z * -200)
    impulseDir = impulseDir.x
    ApplyImpulse(target, impulseDir, 0, impulseDir.z)
    local stand, stand = GetPrefabData(target).stand, 0
    impulseDir = stand
    if (GetPrefabData(impulseDir).OswaldSwitchState ~= 2) then
      impulseDir = stand
      stand = "Reset"
      Prefab_OswaldElectricSwitch_ChangeState(impulseDir, stand)
      impulseDir = stand
      stand = "Deactivate"
      Prefab_OswaldElectricSwitch_ChangeState(impulseDir, stand)
    end
  elseif (Dir == "AnimGBEnded") then
    local anim_num = GetPropertyInt(target, "Active Sequence ID")
    anim_num = anim_num
    Print(((("Prefab_Coop_StopWatchSwitch: " .. Dir) .. " anim_num = ") .. anim_num))
    local data = GetPrefabData(target)
    if (anim_num == 1) then
      data.WatchState = "Open"
    elseif (anim_num == 2) then
      AnimGBSequence(target, "Rest")
      data.WatchState = "Closed"
    end
    anim_num = data.TriggerState
    FireThread(Prefab_Coop_StopWatchSwitch, target, anim_num)
  else
    local data = GetPrefabData(target)
    Print(("Prefab_Coop_StopWatchSwitch: data.WatchState = " .. data.WatchState))
    data.TriggerState = Dir
    if (data.WatchState ~= "Opening") then
      if (data.WatchState ~= "Closing") then
        Print("Prefab_Coop_StopWatchSwitch: data.WatchState != Opening or Closing")
        if (Dir == "In") then
          if (data.WatchState ~= "Open") then
            data.WatchState = "Opening"
          end
          AnimGBSequence(GetRelativePrefabEntity(target, ".Stopwatch"), "Open", true)
          local stand = GetRelativePrefabEntity(target, ".OswaldSwitchStand")
          if (GetPrefabData(stand).OswaldSwitchState ~= 2) then
            SetPropertyBool(GetRelativePrefabEntity(target, ".PN_ElectricStream"), "ActionSpotEnabled", true)
            Prefab_OswaldElectricSwitch_ChangeState(stand, "Activate")
          end
        elseif (Dir == "Out") then
          if (data.WatchState ~= "Closed") then
            data.WatchState = "Closing"
            OswaldStreamAbort()
            AnimGBSequence(GetRelativePrefabEntity(target, ".Stopwatch"), "close", true)
          end
          local stand = GetRelativePrefabEntity(target, ".OswaldSwitchStand")
          if (GetPrefabData(stand).OswaldSwitchState ~= 2) then
            SetPropertyBool(GetRelativePrefabEntity(target, ".PN_ElectricStream"), "ActionSpotEnabled", false)
            Prefab_OswaldElectricSwitch_ChangeState(stand, "Reset")
            Prefab_OswaldElectricSwitch_ChangeState(stand, "Deactivate")
          end
        end
      end
    end
  end
  return 
end
