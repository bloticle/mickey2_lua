prefabTarget = ".GusBarks"
local AlwaysSetupDone = 0
Prefab_SpatterController_AlwaysSetup = function(target)
  Print("__Function: Prefab_SpatterController_AlwaysSetup")
  local data = GetPrefabData(prefabTarget)
  Hide(GetRelativePrefabEntity(target, ".Shockwave"))
  local (for index), (for limit), (for step) = 1, 19, 1
  for x = (for index), (for limit), (for step) do
    local SectionNum = 0
    local BlotlingNum = 0
    if (x == 1) then
      SectionNum = 1
      BlotlingNum = 1
    elseif (x == 2) then
      SectionNum = 1
      BlotlingNum = 2
    elseif (x == 3) then
      SectionNum = 1
      BlotlingNum = 3
    elseif (x == 4) then
      SectionNum = 1
      BlotlingNum = 4
    elseif (x == 5) then
      SectionNum = 2
      BlotlingNum = 1
    elseif (x == 6) then
      SectionNum = 2
      BlotlingNum = 2
    elseif (x == 7) then
      SectionNum = 2
      BlotlingNum = 3
    elseif (x == 8) then
      SectionNum = 3
      BlotlingNum = 1
    elseif (x == 9) then
      SectionNum = 3
      BlotlingNum = 2
    elseif (x == 10) then
      SectionNum = 3
      BlotlingNum = 3
    elseif (x == 11) then
      SectionNum = 4
      BlotlingNum = 1
    elseif (x == 12) then
      SectionNum = 4
      BlotlingNum = 2
    elseif (x == 13) then
      SectionNum = 5
      BlotlingNum = 1
    elseif (x == 14) then
      SectionNum = 5
      BlotlingNum = 2
    elseif (x == 15) then
      SectionNum = 5
      BlotlingNum = 3
    elseif (x == 16) then
      SectionNum = 5
      BlotlingNum = 4
    elseif (x == 17) then
      SectionNum = 5
      BlotlingNum = 5
    elseif (x == 18) then
      SectionNum = 5
      BlotlingNum = 6
    elseif (x == 19) then
      SectionNum = 5
      BlotlingNum = 7
    end
    local CompiledName = (((("NOS_BlotAlley_S" .. tostring(SectionNum)) .. "_B") .. tostring(BlotlingNum)) .. "State")
    data.Globals[x] = CompiledName
  end
  AlwaysSetupDone = 1
  return 
end
Prefab_SpatterController_SpatterStream = function(target, _Section, _BlotlingNum)
  Print(((("__Function: Prefab_SpatterController_SpatterStream, _Section: " .. tostring(_Section)) .. ", _BlotlingNum: ") .. tostring(_BlotlingNum)))
  local data = GetPrefabData(prefabTarget)
  while true do
    if (not (AlwaysSetupDone == 0)) then
      break
    end
    wait(0.10000000149011612)
  end
  Print("__AlwaysSetupDone!")
  local CurrentIndex = Prefab_SpatterController_SetCurrentBlotlingIndex(_Section, _BlotlingNum)
  if (GetGlobal(data.Globals[CurrentIndex]) == 1) then
    Print("__This spatter was friended!")
    SetTargetTeam(target, 3)
  elseif (GetGlobal(data.Globals[CurrentIndex]) == -5) then
    Print("__This spatter was killed!")
    DestroyEntity(target)
  end
  return 
end
Prefab_SpatterController_SetCurrentBlotlingIndex = function(_Section, _BlotlingNum)
  local data = GetPrefabData(prefabTarget)
  local CurrentIndex = -1
  if (_Section == "1") then
    CurrentIndex = 0
  elseif (_Section == "2") then
    CurrentIndex = 4
  elseif (_Section == "3") then
    CurrentIndex = 7
  elseif (_Section == "4") then
    CurrentIndex = 10
  elseif (_Section == "5") then
    CurrentIndex = 12
  end
  CurrentIndex = (CurrentIndex + tonumber(_BlotlingNum))
  return tonumber(CurrentIndex)
end
Prefab_SpatterController_PrintCurrentGlobalsValues = function()
  Print("__Function(INTERNAL): Prefab_SpatterController_PrintCurrentGlobalsValues")
  local data = GetPrefabData(prefabTarget)
  local (for index), (for limit), (for step) = 1, 19, 1
  for x = (for index), (for limit), (for step) do
    local value = GetGlobal(data.Globals[x])
    local state = ""
    if (value == 1) then
      state = "Friended"
    elseif (value == 0) then
      state = "Neutral"
    elseif (value == -1) then
      state = "Detected: Attempting to ring bell"
    elseif (value == -2) then
      state = "Detected: Rang bell successfully"
    elseif (value == -3) then
      state = "Detected: Will NEVER ring a bell"
    elseif (value == -4) then
      state = "Detected: Interrupted while trying to ring a bell"
    elseif (value == -5) then
      state = "Dead"
    end
    Print(((((("Globals[" .. tostring(x)) .. "] Value: ") .. tostring(GetGlobal(data.Globals[x]))) .. ": ") .. tostring(state)))
  end
  return 
end
Prefab_SpatterController_SpatterDetectedFunction = function(target, _Section, _BlotlingNum)
  local data = GetPrefabData(prefabTarget)
  local CurrentIndex = Prefab_SpatterController_SetCurrentBlotlingIndex(_Section, _BlotlingNum)
  SetGlobal("NOS_BlotAlley_NoSpattersDetected", 0)
  if (_Section ~= "4") then
    if (GetGlobal((("NOS_BlotAlley_Bell" .. tostring(_Section)) .. "Rang")) == 0) then
      if (GetGlobal(data.Globals[CurrentIndex]) == 0) then
        Prefab_SpatterController_TryPanicBell(target, _Section, _BlotlingNum)
      end
    end
  end
  return 
end
Prefab_SpatterController_TryPanicBell = function(target, _Section, _BlotlingNum)
  local data = GetPrefabData(prefabTarget)
  local CurrentIndex = Prefab_SpatterController_SetCurrentBlotlingIndex(_Section, _BlotlingNum)
  local PanicBark = 0
  if (_Section == "1") then
    if (_BlotlingNum == "1") then
      SetGlobal(data.Globals[CurrentIndex], -1)
      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
    else
      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
      if (_Section == "2") then
        if (_BlotlingNum ~= "3") then
          if (_BlotlingNum == "1") then
            if (GetGlobal(data.Globals[6]) ~= -1) then
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
              if (_BlotlingNum == "2") then
                if (GetGlobal(data.Globals[5]) ~= -1) then
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                  if (_Section == "3") then
                    if (_BlotlingNum ~= "3") then
                      if (_BlotlingNum == "1") then
                        if (GetGlobal(data.Globals[9]) == -1) then
                          Print("__The other spatter (2) is heading towards the bell! Not sending this one")
                          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                        else
                          SetGlobal(data.Globals[CurrentIndex], -1)
                          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                          if (_BlotlingNum == "2") then
                            if (GetGlobal(data.Globals[8]) == -1) then
                              Print("__The other spatter (1) is heading towards the bell! Not sending this one")
                              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                            else
                              SetGlobal(data.Globals[CurrentIndex], -1)
                              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                              if (_Section == "5") then
                                if (_BlotlingNum == "1") then
                                  SetGlobal(data.Globals[CurrentIndex], -1)
                                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                                else
                                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                                end
                              end
                            end
                          end
                        end
                      elseif (_BlotlingNum == "2") then
                        if (GetGlobal(data.Globals[8]) == -1) then
                          Print("__The other spatter (1) is heading towards the bell! Not sending this one")
                          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                        else
                          SetGlobal(data.Globals[CurrentIndex], -1)
                          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                          if (_Section == "5") then
                            if (_BlotlingNum == "1") then
                              SetGlobal(data.Globals[CurrentIndex], -1)
                              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                            else
                              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                            end
                          end
                        end
                      end
                    else
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                      if (_Section == "5") then
                        if (_BlotlingNum == "1") then
                          SetGlobal(data.Globals[CurrentIndex], -1)
                          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                        else
                          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                        end
                      end
                    end
                  elseif (_Section == "5") then
                    if (_BlotlingNum == "1") then
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                    else
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    end
                  end
                end
              end
            end
          elseif (_BlotlingNum == "2") then
            if (GetGlobal(data.Globals[5]) ~= -1) then
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
              if (_Section == "3") then
                if (_BlotlingNum ~= "3") then
                  if (_BlotlingNum == "1") then
                    if (GetGlobal(data.Globals[9]) == -1) then
                      Print("__The other spatter (2) is heading towards the bell! Not sending this one")
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    else
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                      if (_BlotlingNum == "2") then
                        if (GetGlobal(data.Globals[8]) == -1) then
                          Print("__The other spatter (1) is heading towards the bell! Not sending this one")
                          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                        else
                          SetGlobal(data.Globals[CurrentIndex], -1)
                          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                          if (_Section == "5") then
                            if (_BlotlingNum == "1") then
                              SetGlobal(data.Globals[CurrentIndex], -1)
                              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                            else
                              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                            end
                          end
                        end
                      end
                    end
                  elseif (_BlotlingNum == "2") then
                    if (GetGlobal(data.Globals[8]) == -1) then
                      Print("__The other spatter (1) is heading towards the bell! Not sending this one")
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    else
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                      if (_Section == "5") then
                        if (_BlotlingNum == "1") then
                          SetGlobal(data.Globals[CurrentIndex], -1)
                          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                        else
                          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                        end
                      end
                    end
                  end
                else
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                  if (_Section == "5") then
                    if (_BlotlingNum == "1") then
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                    else
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    end
                  end
                end
              elseif (_Section == "5") then
                if (_BlotlingNum == "1") then
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                else
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                end
              end
            end
          end
        else
          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
          if (_Section == "3") then
            if (_BlotlingNum ~= "3") then
              if (_BlotlingNum == "1") then
                if (GetGlobal(data.Globals[9]) == -1) then
                  Print("__The other spatter (2) is heading towards the bell! Not sending this one")
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                else
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                  if (_BlotlingNum == "2") then
                    if (GetGlobal(data.Globals[8]) == -1) then
                      Print("__The other spatter (1) is heading towards the bell! Not sending this one")
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    else
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                      if (_Section == "5") then
                        if (_BlotlingNum == "1") then
                          SetGlobal(data.Globals[CurrentIndex], -1)
                          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                        else
                          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                        end
                      end
                    end
                  end
                end
              elseif (_BlotlingNum == "2") then
                if (GetGlobal(data.Globals[8]) == -1) then
                  Print("__The other spatter (1) is heading towards the bell! Not sending this one")
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                else
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                  if (_Section == "5") then
                    if (_BlotlingNum == "1") then
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                    else
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    end
                  end
                end
              end
            else
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
              if (_Section == "5") then
                if (_BlotlingNum == "1") then
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                else
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                end
              end
            end
          elseif (_Section == "5") then
            if (_BlotlingNum == "1") then
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
            else
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
            end
          end
        end
      elseif (_Section == "3") then
        if (_BlotlingNum ~= "3") then
          if (_BlotlingNum == "1") then
            if (GetGlobal(data.Globals[9]) == -1) then
              Print("__The other spatter (2) is heading towards the bell! Not sending this one")
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
            else
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
              if (_BlotlingNum == "2") then
                if (GetGlobal(data.Globals[8]) == -1) then
                  Print("__The other spatter (1) is heading towards the bell! Not sending this one")
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                else
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                  if (_Section == "5") then
                    if (_BlotlingNum == "1") then
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                    else
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    end
                  end
                end
              end
            end
          elseif (_BlotlingNum == "2") then
            if (GetGlobal(data.Globals[8]) == -1) then
              Print("__The other spatter (1) is heading towards the bell! Not sending this one")
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
            else
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
              if (_Section == "5") then
                if (_BlotlingNum == "1") then
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                else
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                end
              end
            end
          end
        else
          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
          if (_Section == "5") then
            if (_BlotlingNum == "1") then
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
            else
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
            end
          end
        end
      elseif (_Section == "5") then
        if (_BlotlingNum == "1") then
          SetGlobal(data.Globals[CurrentIndex], -1)
          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
        else
          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
        end
      end
    end
  elseif (_Section == "2") then
    if (_BlotlingNum ~= "3") then
      if (_BlotlingNum == "1") then
        if (GetGlobal(data.Globals[6]) ~= -1) then
          SetGlobal(data.Globals[CurrentIndex], -1)
          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
          if (_BlotlingNum == "2") then
            if (GetGlobal(data.Globals[5]) ~= -1) then
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
              if (_Section == "3") then
                if (_BlotlingNum ~= "3") then
                  if (_BlotlingNum == "1") then
                    if (GetGlobal(data.Globals[9]) == -1) then
                      Print("__The other spatter (2) is heading towards the bell! Not sending this one")
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    else
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                      if (_BlotlingNum == "2") then
                        if (GetGlobal(data.Globals[8]) == -1) then
                          Print("__The other spatter (1) is heading towards the bell! Not sending this one")
                          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                        else
                          SetGlobal(data.Globals[CurrentIndex], -1)
                          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                          if (_Section == "5") then
                            if (_BlotlingNum == "1") then
                              SetGlobal(data.Globals[CurrentIndex], -1)
                              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                            else
                              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                            end
                          end
                        end
                      end
                    end
                  elseif (_BlotlingNum == "2") then
                    if (GetGlobal(data.Globals[8]) == -1) then
                      Print("__The other spatter (1) is heading towards the bell! Not sending this one")
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    else
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                      if (_Section == "5") then
                        if (_BlotlingNum == "1") then
                          SetGlobal(data.Globals[CurrentIndex], -1)
                          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                        else
                          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                        end
                      end
                    end
                  end
                else
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                  if (_Section == "5") then
                    if (_BlotlingNum == "1") then
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                    else
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    end
                  end
                end
              elseif (_Section == "5") then
                if (_BlotlingNum == "1") then
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                else
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                end
              end
            end
          end
        end
      elseif (_BlotlingNum == "2") then
        if (GetGlobal(data.Globals[5]) ~= -1) then
          SetGlobal(data.Globals[CurrentIndex], -1)
          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
          if (_Section == "3") then
            if (_BlotlingNum ~= "3") then
              if (_BlotlingNum == "1") then
                if (GetGlobal(data.Globals[9]) == -1) then
                  Print("__The other spatter (2) is heading towards the bell! Not sending this one")
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                else
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                  if (_BlotlingNum == "2") then
                    if (GetGlobal(data.Globals[8]) == -1) then
                      Print("__The other spatter (1) is heading towards the bell! Not sending this one")
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    else
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                      if (_Section == "5") then
                        if (_BlotlingNum == "1") then
                          SetGlobal(data.Globals[CurrentIndex], -1)
                          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                        else
                          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                        end
                      end
                    end
                  end
                end
              elseif (_BlotlingNum == "2") then
                if (GetGlobal(data.Globals[8]) == -1) then
                  Print("__The other spatter (1) is heading towards the bell! Not sending this one")
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                else
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                  if (_Section == "5") then
                    if (_BlotlingNum == "1") then
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                    else
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    end
                  end
                end
              end
            else
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
              if (_Section == "5") then
                if (_BlotlingNum == "1") then
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                else
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                end
              end
            end
          elseif (_Section == "5") then
            if (_BlotlingNum == "1") then
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
            else
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
            end
          end
        end
      end
    else
      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
      if (_Section == "3") then
        if (_BlotlingNum ~= "3") then
          if (_BlotlingNum == "1") then
            if (GetGlobal(data.Globals[9]) == -1) then
              Print("__The other spatter (2) is heading towards the bell! Not sending this one")
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
            else
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
              if (_BlotlingNum == "2") then
                if (GetGlobal(data.Globals[8]) == -1) then
                  Print("__The other spatter (1) is heading towards the bell! Not sending this one")
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                else
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                  if (_Section == "5") then
                    if (_BlotlingNum == "1") then
                      SetGlobal(data.Globals[CurrentIndex], -1)
                      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                    else
                      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                    end
                  end
                end
              end
            end
          elseif (_BlotlingNum == "2") then
            if (GetGlobal(data.Globals[8]) == -1) then
              Print("__The other spatter (1) is heading towards the bell! Not sending this one")
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
            else
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
              if (_Section == "5") then
                if (_BlotlingNum == "1") then
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                else
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                end
              end
            end
          end
        else
          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
          if (_Section == "5") then
            if (_BlotlingNum == "1") then
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
            else
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
            end
          end
        end
      elseif (_Section == "5") then
        if (_BlotlingNum == "1") then
          SetGlobal(data.Globals[CurrentIndex], -1)
          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
        else
          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
        end
      end
    end
  elseif (_Section == "3") then
    if (_BlotlingNum ~= "3") then
      if (_BlotlingNum == "1") then
        if (GetGlobal(data.Globals[9]) == -1) then
          Print("__The other spatter (2) is heading towards the bell! Not sending this one")
          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
        else
          SetGlobal(data.Globals[CurrentIndex], -1)
          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
          if (_BlotlingNum == "2") then
            if (GetGlobal(data.Globals[8]) == -1) then
              Print("__The other spatter (1) is heading towards the bell! Not sending this one")
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
            else
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
              if (_Section == "5") then
                if (_BlotlingNum == "1") then
                  SetGlobal(data.Globals[CurrentIndex], -1)
                  Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
                else
                  Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
                end
              end
            end
          end
        end
      elseif (_BlotlingNum == "2") then
        if (GetGlobal(data.Globals[8]) == -1) then
          Print("__The other spatter (1) is heading towards the bell! Not sending this one")
          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
        else
          SetGlobal(data.Globals[CurrentIndex], -1)
          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
          if (_Section == "5") then
            if (_BlotlingNum == "1") then
              SetGlobal(data.Globals[CurrentIndex], -1)
              Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
            else
              Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
            end
          end
        end
      end
    else
      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
      if (_Section == "5") then
        if (_BlotlingNum == "1") then
          SetGlobal(data.Globals[CurrentIndex], -1)
          Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
        else
          Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
        end
      end
    end
  elseif (_Section == "5") then
    if (_BlotlingNum == "1") then
      SetGlobal(data.Globals[CurrentIndex], -1)
      Prefab_SpatterController_SendSpatterToBell(target, _Section, _BlotlingNum)
    else
      Prefab_SpatterController_CancelBellRequest(target, _Section, _BlotlingNum)
    end
  end
  return 
end
Prefab_SpatterController_SendSpatterToBell = function(target, _Section, _BlotlingNum)
  Print(((("__Function: Prefab_SpatterController_SendSpatterToBell, _Section: " .. _Section) .. " _BlotlingNum: ") .. _BlotlingNum))
  local data = GetPrefabData(prefabTarget)
  GoToEntity(target, GetRelativePrefabEntity(prefabTarget, ((".Room" .. tostring(_Section)) .. "_PanicBellSpatterTarget")), 3)
  FireSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_Detected_PanicBell")
  return 
end
Prefab_SpatterController_CancelBellRequest = function(target, _Section, _BlotlingNum)
  Print(((("__Function: Prefab_SpatterController_CancelBellRequest, _Section: " .. _Section) .. " _BlotlingNum: ") .. _BlotlingNum))
  local data = GetPrefabData(prefabTarget)
  local CurrentIndex = Prefab_SpatterController_SetCurrentBlotlingIndex(_Section, _BlotlingNum)
  if (_Section == "2") then
    if (_BlotlingNum ~= "3") then
      SetGlobal(data.Globals[CurrentIndex], -4)
    else
      SetGlobal(data.Globals[CurrentIndex], -3)
    end
  end
  SetGlobal(data.Globals[CurrentIndex], -3)
  if (_Section ~= "5") then
    Prefab_SpatterController_GusUpdateBark(target, "Detected")
  end
  return 
end
Prefab_SpatterController_TryAbortBell = function(target, _Section, _BlotlingNum)
  Print(((("__Function: Prefab_SpatterController_TryAbortBell, _Section: " .. _Section) .. " _BlotlingNum: ") .. _BlotlingNum))
  local data = GetPrefabData(prefabTarget)
  local CurrentIndex = Prefab_SpatterController_SetCurrentBlotlingIndex(_Section, _BlotlingNum)
  if (GetGlobal(data.Globals[CurrentIndex]) == -1) then
    AbortScriptedGoto(target)
    SetGlobal(data.Globals[CurrentIndex], -4)
    ForceSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_BellInterrupted")
  end
  return 
end
Prefab_SpatterController_BellRung = function(target, _event, _Section, _BlotlingNum)
  Print(((("__Function: Prefab_SpatterController_BellRung, _Section: " .. _Section) .. " _BlotlingNum: ") .. _BlotlingNum))
  local data = GetPrefabData(prefabTarget)
  if (data.BellRinging[tonumber(_Section)] == 0) then
    local source = 0
    if (_event ~= "0") then
      source = 1
    end
    if (source == 1) then
      Print("__We got here through a stim!")
      if StimulusEvent_HasStimulusType(_event, ST_SPIN) then
        if (_BlotlingNum == "-1") then
          FireSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_MickeyHitBell")
        end
      else
        return 
        Prefab_SpatterController_TryAbortBell(target, _Section, _BlotlingNum)
        return 
        local CurrentIndex = Prefab_SpatterController_SetCurrentBlotlingIndex(_Section, _BlotlingNum)
        SetGlobal(data.Globals[CurrentIndex], -2)
        ForceSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_RangBell")
      end
    else
      local MarkerPosition = GetPosition(GetRelativePrefabEntity(prefabTarget, ((".Room" .. tostring(_Section)) .. "_PanicBellSpatterTarget")))
      local EntityPosition = GetPosition(target)
      local DeltaXDistance = (MarkerPosition.x - EntityPosition.x)
      local DeltaZDistance = (MarkerPosition.z - EntityPosition.z)
      if (DeltaXDistance >= 1.2000000476837158) then
        Prefab_SpatterController_TryAbortBell(target, _Section, _BlotlingNum)
        return 
      end
      local CurrentIndex = Prefab_SpatterController_SetCurrentBlotlingIndex(_Section, _BlotlingNum)
      SetGlobal(data.Globals[CurrentIndex], -2)
      ForceSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_RangBell")
    end
    local Bell = GetRelativePrefabEntity(prefabTarget, ((".Room" .. tostring(_Section)) .. "_PanicBell"))
    local Shockwave = GetRelativePrefabEntity(prefabTarget, ".Shockwave")
    TeleportToEntity(Shockwave, Bell)
    AnimGBSequence(Bell, "on")
    data.BellRinging[tonumber(_Section)] = 1
    AudioPostEventOn(GetPlayer(), "Play_sfx_Bell")
    wait(0.009999999776482582)
    StartEmitters(Shockwave)
    Unhide(Shockwave)
    wait(2)
    Bell = _Section
    Bell = "Rang"
    if (GetGlobal((("NOS_BlotAlley_Bell" .. tostring(Bell)) .. Bell)) == 0) then
      Bell = _Section
      Bell = "Rang"
      SetGlobal((("NOS_BlotAlley_Bell" .. tostring(Bell)) .. Bell), 1)
      if (_Section == "1") then
        if IsValidHandle("Problem1_Spatter2") then
          ClearNextPatrolNode("Problem1_Spatter2")
          SetNextPatrolNode("Problem1_Spatter2", "Spatter2_PanicNode")
        end
        Prefab_Room1Balconies_EnableMovement("Room1Balconies")
        NOS_BlotAlley_OswaldHintManipulator(nil, "Bell1Rung")
      elseif (_Section == "2") then
        Unhide("Room2_Sweeper")
        AnimGBSequence("Room2_SweeperPanicDoor", "open")
        Enable("Room2_SweeperTrigger_Player")
        Enable("Room2_SweeperTrigger_Sweeper")
        ClearNextPatrolNode("Room2_Sweeper")
        wait(0.10000000149011612)
        SetNextPatrolNode("Room2_Sweeper", "Room2_SweeperSpawnPatrolNode")
      elseif (_Section == "3") then
        FireUser1("Room3SweeperTimer")
        Enable("CO_Room3")
      elseif (_Section == "5") then
        Unhide("Room5_Sweeper1")
        Disable("Room5Door_PlayerKillTrigger")
        AnimGBSequence("NOS_BlotAlley_Room5Door", "open")
        GoToEntity("Room5_Sweeper1", "Problem5_SlobberNode")
        wait(1)
        AnimGBSequence("NOS_BlotAlley_Room5Door", "close")
        wait(0.5)
        Enable("Room5Door_PlayerKillTrigger")
        Print("__This bell has been rung before! There will be no consequence to ringing it again")
      end
    else
      Print("__This bell has been rung before! There will be no consequence to ringing it again")
    end
    AnimGBSequence(Bell, "rest")
    data.BellRinging[tonumber(_Section)] = 0
    StopEmitters(Shockwave)
    Hide(Shockwave)
  else
    Print("__This bell is ringing RIGHT MEOW!")
  end
  return 
end
Prefab_SpatterController_Room5FirstSweeperDeath = function(target)
  Print("__Function: Prefab_SpatterController_Room5FirstSweeperDeath")
  Disable("Room5Door_PlayerKillTrigger")
  AnimGBSequence("NOS_BlotAlley_Room5Door", "open")
  Unhide("Room5_Sweeper2")
  GoToEntity("Room5_Sweeper2", "Problem5_SlobberNode")
  wait(1)
  AnimGBSequence("NOS_BlotAlley_Room5Door", "close")
  wait(0.5)
  Enable("Room5Door_PlayerKillTrigger")
  return 
end
Prefab_SpatterController_SpatterTeamChange = function(target, _Section, _BlotlingNum)
  local data = GetPrefabData(prefabTarget)
  local CurrentIndex = Prefab_SpatterController_SetCurrentBlotlingIndex(_Section, _BlotlingNum)
  if (GetCurrentTeam(target) == 2) then
    Prefab_SpatterController_GusUpdateBark(target, "Thinned")
  elseif (GetCurrentTeam(target) == 3) then
    if (GetGlobal(data.Globals[CurrentIndex]) ~= 1) then
      SetGlobal(data.Globals[CurrentIndex], 1)
      Prefab_SpatterController_GusUpdateBark(target, "Painted")
    end
  end
  return 
end
Prefab_SpatterController_SpatterDeath = function(target, _Section, _BlotlingNum)
  local data = GetPrefabData(prefabTarget)
  local CurrentIndex = Prefab_SpatterController_SetCurrentBlotlingIndex(_Section, _BlotlingNum)
  SetGlobal(data.Globals[CurrentIndex], -5)
  Prefab_SpatterController_GusUpdateBark(target, "Thinned")
  return 
end
Prefab_SpatterController_GusUpdateBark = function(target, _Update)
  if (_Update == "Detected") then
    SetGlobal("NOS_BlotAlley_GusIanUpdate", 0)
  elseif (_Update == "Thinned") then
    SetGlobal("NOS_BlotAlley_GusIanUpdate", 0)
  elseif (_Update == "Painted") then
    SetGlobal("NOS_BlotAlley_GusIanUpdate", math.random(1, 2))
  end
  wait(0)
  ForceSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_AirlockStatusUpdate")
  return 
end
Prefab_SpatterController_GusAirlockMood = function(target)
  Print("__Function: Prefab_SpatterController_GusAirlockMood")
  local data = GetPrefabData(prefabTarget)
  Prefab_SpatterController_PrintCurrentGlobalsValues()
  local Friended = 0
  local Thinned = 0
  local (for index), (for limit), (for step) = 1, 6, 1
  for x = (for index), (for limit), (for step) do
    local value = GetGlobal(data.Globals[x])
    if (value == 1) then
      Friended = (Friended + 1)
    elseif (value == -5) then
      Thinned = (Thinned + 1)
    end
  end
  local ThinnedPercentage = ((Thinned / 6) * 100)
  local FriendPercentage = ((Friended / 6) * 100)
  local BellsRangPercentage = (((GetGlobal("NOS_BlotAlley_Bell1Rang") + GetGlobal("NOS_BlotAlley_Bell2Rang")) / 2) * 100)
  if (66 < ThinnedPercentage) then
    ThinnedPercentage = -1
    SetGlobal("NOS_BlotAlley_IanMood", ThinnedPercentage)
  elseif (66 < FriendPercentage) then
    ThinnedPercentage = 2
    SetGlobal("NOS_BlotAlley_IanMood", ThinnedPercentage)
  elseif (50 <= BellsRangPercentage) then
    ThinnedPercentage = 0
    SetGlobal("NOS_BlotAlley_IanMood", ThinnedPercentage)
  else
    ThinnedPercentage = 1
    SetGlobal("NOS_BlotAlley_IanMood", ThinnedPercentage)
  end
  ThinnedPercentage = "NOS_BlotAlley_Gus_AirlockStatusUpdate"
  ForceSequence("NOS_BlotAlley_Gus", ThinnedPercentage)
  return 
end
Prefab_SpatterController_IanProgressCheck = function(target)
  local data = GetPrefabData(prefabTarget)
  Prefab_SpatterController_PrintCurrentGlobalsValues()
  local Friended = 0
  local Thinned = 0
  local (for index), (for limit), (for step) = 1, 17, 1
  for x = (for index), (for limit), (for step) do
    if (x ~= 7) then
      if (x ~= 10) then
        local value = GetGlobal(data.Globals[x])
        if (value == 1) then
          Friended = (Friended + 1)
        elseif (value == -5) then
          Thinned = (Thinned + 1)
        end
      end
    end
  end
  local ThinnedPercentage = ((Thinned / 15) * 100)
  local FriendPercentage = ((Friended / 15) * 100)
  local BellsRangPercentage = (((((GetGlobal("NOS_BlotAlley_Bell1Rang") + GetGlobal("NOS_BlotAlley_Bell2Rang")) + GetGlobal("NOS_BlotAlley_Bell3Rang")) + GetGlobal("NOS_BlotAlley_Bell5Rang")) / 4) * 100)
  ThinnedPercentage = tostring
  FriendPercentage = ThinnedPercentage
  ThinnedPercentage = ThinnedPercentage(FriendPercentage)
  Print(("__ThinnedPercentage: " .. ThinnedPercentage))
  ThinnedPercentage = tostring
  FriendPercentage = FriendPercentage
  ThinnedPercentage = ThinnedPercentage(FriendPercentage)
  Print(("__FriendPercentage: " .. ThinnedPercentage))
  ThinnedPercentage = tostring
  FriendPercentage = BellsRangPercentage
  ThinnedPercentage = ThinnedPercentage(FriendPercentage)
  Print(("__BellsRangPercentage: " .. ThinnedPercentage))
  if (GetGlobal("NOS_BlotAlley_NoSpattersDetected") == 1) then
    ThinnedPercentage = 1
    SetGlobal("NOS_BlotAlley_IanMood", ThinnedPercentage)
  elseif (66 < ThinnedPercentage) then
    ThinnedPercentage = -1
    SetGlobal("NOS_BlotAlley_IanMood", ThinnedPercentage)
  elseif (66 < FriendPercentage) then
    ThinnedPercentage = 1
    SetGlobal("NOS_BlotAlley_IanMood", ThinnedPercentage)
  elseif (50 <= BellsRangPercentage) then
    ThinnedPercentage = -1
    SetGlobal("NOS_BlotAlley_IanMood", ThinnedPercentage)
  else
    ThinnedPercentage = 0
    SetGlobal("NOS_BlotAlley_IanMood", ThinnedPercentage)
  end
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  ThinnedPercentage = "NOS_BlotAlley_Ian_Airlock3"
  ForceSequence("NOS_BlotAlley_Ian", ThinnedPercentage)
  return 
end
