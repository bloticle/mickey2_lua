Prefab_DualCameraItemStateSwitch = function(target, override, state)
  local data = GetPrefabData(target)
  local player = "1"
  if (_activator() ~= GetPlayer()) then
    player = "2"
  end
  if (override == "TriggersActive") then
    data[override] = state
  else
    data[(tostring(override) .. player)] = state
  end
  if (override == "MainTrigger_Player") then
    if (state == "false") then
      if (data.ReleaseTimeOverride ~= -1) then
        if data.PrintDebug then
          Print((("ReleaseTimeOverridden to: " .. tostring(data.ReleaseTimeOverride)) .. " seconds! will wait that long instead of the default 1.5"))
        end
        wait(tonumber(data.ReleaseTimeOverride))
      else
        wait(1.5)
      end
    end
  end
  Prefab_DualCameraStateCheck(target)
  return 
end
Prefab_DualCameraStateCheck = function(target)
  local data = GetPrefabData(target)
  if (data.TriggersActive == "true") then
    local _activator = _activator()
    local player = "1"
    if (_activator ~= GetPlayer()) then
      player = "2"
    end
    if data.PrintDebug then
      Print(((((((("Prefab_DualCameraStateCheck: For Player" .. player) .. " - MainTrigger = ") .. data[("MainTrigger_Player" .. player)]) .. "  LeftTrigger : ") .. data[("LeftTrigger_Player" .. player)]) .. "  RightTrigger : ") .. data[("RightTrigger_Player" .. player)]))
    end
    if (data[("MainTrigger_Player" .. player)] == "true") then
      if (data[("LeftTrigger_Player" .. player)] == "true") then
        if data.PrintDebug then
          Print(("Prefab_DualCameraStateCheck: Setting Left Camera for Player" .. player))
        end
        SetCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".LeftCameraOverride"), _activator)
        ClearCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".RightCameraOverride"), _activator)
      elseif (data[("RightTrigger_Player" .. player)] == "true") then
        if data.PrintDebug then
          Print(("Prefab_DualCameraStateCheck: Setting Right Camera for Player" .. player))
        end
        SetCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".RightCameraOverride"), _activator)
        ClearCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".LeftCameraOverride"), _activator)
      elseif (not data.ClearOnlyOnTriggerEmpty) then
        if data.PrintDebug then
          Print(("Prefab_DualCameraStateCheck: ClearOnlyOnTriggerEmpty = false for Player" .. player))
        end
        ClearCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".LeftCameraOverride"), _activator)
        ClearCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".RightCameraOverride"), _activator)
        if (data[("MainTrigger_Player" .. player)] == "false") then
          if data.PrintDebug then
            Print("Prefab_DualCameraStateCheck: Clearing the Cameras")
          end
          ClearCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".LeftCameraOverride"), _activator)
          ClearCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".RightCameraOverride"), _activator)
        end
      end
    elseif (data[("MainTrigger_Player" .. player)] == "false") then
      if data.PrintDebug then
        Print("Prefab_DualCameraStateCheck: Clearing the Cameras")
      end
      ClearCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".LeftCameraOverride"), _activator)
      ClearCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".RightCameraOverride"), _activator)
    end
  end
  return 
end
