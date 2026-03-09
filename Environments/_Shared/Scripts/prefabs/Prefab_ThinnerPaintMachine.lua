ThinnerPaintMachine_Initialize = function(target)
  Print("************ - ThinnerPaintMachine_Initialize")
  local data = GetPrefabData(target)
  if (data.GlobalToCheck == "None") then
    Print("***************************** You forgot to set up your Pump to have a Global to CHECK!!!!")
  else
    local global = GetGlobal(data.GlobalToCheck)
    if (global < 0) then
      Print("************ - ThinnerPaintMachine_Initialize - Global < 0")
      if (global == -2) then
        data.Thinner_Amount = 4
        AnimGBSequence(GetRelativePrefabEntity(target, ".ThinnerTank"), "Rest4")
        StartEmitters(GetRelativePrefabEntity(target, ".Smoke"))
        Enable(GetRelativePrefabEntity(target, ".SteamTriggerDamage"))
      elseif (global == -1) then
        data.Paint_Amount = 4
        AnimGBSequence(GetRelativePrefabEntity(target, ".PaintTank"), "Rest4")
      end
      data.MachineBusy = false
      AudioPostEventOn(GetRelativePrefabEntity(target, ".Nozzle"), "Stop_sfx_pump_amb")
    else
      Print("************ - ThinnerPaintMachine_Initialize - Global => 0")
      Print(("************ - ThinnerPaintMachine_Initialize - global = " .. global))
      if (global == 0) then
        Print(("************ - ThinnerPaintMachine_Initialize - data.GlobalToCheck = " .. data.GlobalToCheck))
        SetGlobal(data.GlobalToCheck, 22)
        global = 22
      end
      local thinner_pos = string.sub(tostring(global), -1)
      local paint_pos = string.sub(tostring(global), -2, -2)
      AnimGBSequence(GetRelativePrefabEntity(target, ".PaintTank"), ("Rest" .. paint_pos))
      AnimGBSequence(GetRelativePrefabEntity(target, ".ThinnerTank"), ("Rest" .. thinner_pos))
    end
  end
  wait(1)
  Print("************ - ThinnerPaintMachine_Initialize: data.MachineBusy Check")
  if data.MachineBusy then
    Print("************ - ThinnerPaintMachine_Initialize: data.MachineBusy == true")
    StartEmitters(GetRelativePrefabEntity(target, ".Smoke"))
    Enable(GetRelativePrefabEntity(target, ".SteamTriggerDamage"))
  end
  return 
end
ThinnerPaintMachine = function(nozzle, stim)
  local data = GetPrefabData(nozzle)
  local global = data.GlobalToCheck
  Print("+*+*+*+*+*+*+*+*+*+*+*+*+*+*+   ThinnerPaintMachine STIM!!!!")
  if (data.MachineBusy == false) then
    data.MachineBusy = true
    if (0 <= GetGlobal(global)) then
      local paintdirection = "stop"
      local thinnerdirection = "stop"
      local MachineNozzle = GetRelativePrefabEntity(nozzle, ".Nozzle")
      local PaintTank = GetRelativePrefabEntity(nozzle, ".PaintTank")
      local ThinnerTank = GetRelativePrefabEntity(nozzle, ".ThinnerTank")
      local PumpMachine = GetRelativePrefabEntity(nozzle, ".PumpMachine")
      AnimGBReset(MachineNozzle)
      AnimGBSequence(MachineNozzle, "Hit")
      AudioPostEventOn(MachineNozzle, "Play_sfx_paintnozzle")
      Wait(0.25)
      AnimGBReset(PumpMachine)
      AnimGBSequence(PumpMachine, "Hit")
      AudioPostEventOn(PumpMachine, "Play_sfx_machinebase_warp")
      Wait(0.20000000298023224)
      if (3 < (data.Paint_Amount + data.Thinner_Amount)) then
        if (tonumber(stim) == 1) then
          if (0 < data.Thinner_Amount) then
            data.Thinner_Amount = (data.Thinner_Amount - 1)
            thinnerdirection = "down"
          end
          paintdirection = "up"
          data.Paint_Amount = (data.Paint_Amount + 1)
        elseif (tonumber(stim) == 2) then
          if (0 < data.Paint_Amount) then
            paintdirection = "down"
            data.Paint_Amount = (data.Paint_Amount - 1)
          end
          data.Thinner_Amount = (data.Thinner_Amount + 1)
          thinnerdirection = "up"
        end
        SetGlobal(global, ((data.Paint_Amount * 10) + data.Thinner_Amount))
      end
      if (paintdirection == "up") then
        AnimGBSequence(PaintTank, (((data.Paint_Amount - 1) .. "To") .. data.Paint_Amount))
        AudioPostEventOn(PaintTank, (("Play_sfx_pump" .. data.Paint_Amount) .. "of4_paint"))
        if (thinnerdirection == "down") then
          AnimGBSequence(ThinnerTank, (((data.Thinner_Amount + 1) .. "To") .. data.Thinner_Amount))
          AudioPostEventOn(ThinnerTank, (("Play_sfx_pump" .. data.Thinner_Amount) .. "of4_thnnrdn"))
        end
      elseif (thinnerdirection == "up") then
        AnimGBSequence(ThinnerTank, (((data.Thinner_Amount - 1) .. "To") .. data.Thinner_Amount))
        AudioPostEventOn(ThinnerTank, (("Play_sfx_pump" .. data.Thinner_Amount) .. "of4_thnnr"))
        if (paintdirection == "down") then
          AnimGBSequence(PaintTank, (((data.Paint_Amount + 1) .. "To") .. data.Paint_Amount))
          AudioPostEventOn(PaintTank, (("Play_sfx_pump" .. data.Paint_Amount) .. "of4_paintdn"))
        end
      end
      if (data.Paint_Amount == 4) then
        SetGlobal(data.GlobalToCheck, -1)
        Wait(0.20000000298023224)
        FireUser1(MachineNozzle)
        AudioPostEventOn(MachineNozzle, "Play_sfx_fix_pump")
        AudioPostEventOn(MachineNozzle, "Play_sfx_Prefab_PumpMachine_Done")
      end
      if (data.Thinner_Amount == 4) then
        SetGlobal(data.GlobalToCheck, -2)
        Wait(0.20000000298023224)
        AudioPostEventOn(MachineNozzle, "Stop_sfx_pump_amb")
        wait(0.800000011920929)
        StartEmitters(GetRelativePrefabEntity(nozzle, ".Smoke"))
        Enable(GetRelativePrefabEntity(nozzle, ".SteamTriggerDamage"))
        FireUser2(MachineNozzle)
      end
      wait(0.6499999761581421)
    elseif (data.GlobalToCheck == "None") then
      Print("***************************** ThinnerPaintMachine: You forgot to set up your Pump to have a Global to CHECK!!!!")
    end
    data.MachineBusy = false
  end
  return 
end
ThinnerPaintMachine_Reset = function(target)
  local data = GetPrefabData(target)
  local PaintTank = GetRelativePrefabEntity(target, ".PaintTank")
  local ThinnerTank = GetRelativePrefabEntity(target, ".ThinnerTank")
  StopEmitters(GetRelativePrefabEntity(target, ".Smoke"))
  Disable(GetRelativePrefabEntity(target, ".SteamTriggerDamage"))
  local paintdirection = 0
  local audio_modifier = ""
  if (2 < data.Thinner_Amount) then
    paintdirection = 1
  elseif (2 < data.Paint_Amount) then
    paintdirection = -1
  end
  while true do
    if (not (data.Thinner_Amount ~= 2)) then
      break
    end
    if (not (data.Paint_Amount ~= 2)) then
      break
    end
    if (data.Paint_Amount ~= 2) then
      AnimGBSequence(PaintTank, ((data.Paint_Amount .. "To") .. (data.Paint_Amount + paintdirection)))
      AudioPostEventOn(PaintTank, "Play_sfx_pump2of4_paintdn")
      data.Paint_Amount = (data.Paint_Amount + paintdirection)
    end
    if (data.Thinner_Amount ~= 2) then
      AnimGBSequence(ThinnerTank, ((data.Thinner_Amount .. "To") .. (data.Thinner_Amount + (-paintdirection))))
      AudioPostEventOn(ThinnerTank, "Play_sfx_pump2of4_thnnrdn")
      data.Thinner_Amount = (data.Thinner_Amount + (-paintdirection))
    end
    wait(0.5)
  end
  AnimGBSequence(PaintTank, "Rest2")
  AnimGBSequence(ThinnerTank, "Rest2")
  AnimGBReset(PaintTank)
  AnimGBReset(ThinnerTank)
  AudioPostEventOn(GetRelativePrefabEntity(target, ".Nozzle"), "Play_sfx_pump_amb2of4")
  data.Paint_Amount = 2
  data.Thinner_Amount = 2
  SetGlobal(data.GlobalToCheck, 22)
  data.MachineBusy = false
  return 
end
ThinnerPaintMachine_SetState = function(target, state)
  local data = GetPrefabData(target)
  if (state == "On") then
    data.MachineBusy = false
    StopEmitters(GetRelativePrefabEntity(target, ".Smoke"))
    Disable(GetRelativePrefabEntity(target, ".SteamTriggerDamage"))
  elseif (state == "Off") then
    data.MachineBusy = true
    AudioPostEventOn(GetRelativePrefabEntity(target, ".Nozzle"), "Stop_sfx_pump_amb")
    StartEmitters(GetRelativePrefabEntity(target, ".Smoke"))
    Enable(GetRelativePrefabEntity(target, ".SteamTriggerDamage"))
  end
  return 
end
