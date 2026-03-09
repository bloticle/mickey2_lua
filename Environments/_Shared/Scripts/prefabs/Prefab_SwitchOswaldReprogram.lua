OswaldReprogramThinned = function(target, thinned)
  local data = GetPrefabData(target)
  if (thinned == "true") then
    AudioPostEventOn(target, "Stop_sfx_oswald_hacking")
    if (Reprogram_GetTarget(GetPlayer2OrAI()) ~= nil) then
      if (Reprogram_GetTarget(GetPlayer2OrAI()) == GetRelativePrefabEntity(target, ".OswaldReprogramScreen")) then
        Print("OswaldReprogramThinned : the target and oswalds hack target are the same! Disableing the hack")
        if (GetPlayer2() ~= nil) then
          StopAbility(GetPlayer2(), "Hack")
        else
          OswaldAbortScriptedBehavior()
        end
      end
    end
    Hide(GetRelativePrefabEntity(target, ".OswaldReprogramGlass"))
    Hide(GetRelativePrefabEntity(target, ".OswaldReprogramSpark"))
    ForceSketched(GetRelativePrefabEntity(target, ".OswaldReprogramLights"))
    ForceSketched(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"))
    if (data.OptionalEntities[1] == "Pipe1") then
      ForceSketched(GetRelativePrefabEntity(target, ".OswaldReprogramPipe1"))
    end
    if (data.OptionalEntities[2] == "Pipe2") then
      ForceSketched(GetRelativePrefabEntity(target, ".OswaldReprogramPipe2"))
    end
    if (data.OptionalEntities[3] == "Pipe3") then
      ForceSketched(GetRelativePrefabEntity(target, ".OswaldReprogramPipe3"))
    end
    if (data.OptionalEntities[4] == "Stand") then
      ForceSketched(GetRelativePrefabEntity(target, ".OswaldReprogramStand"))
    end
    if (data.OptionalEntities[5] == "WallMount") then
      ForceSketched(GetRelativePrefabEntity(target, ".OswaldReprogramWallMount"))
    end
  else
    Unhide(GetRelativePrefabEntity(target, ".OswaldReprogramGlass"))
    Unhide(GetRelativePrefabEntity(target, ".OswaldReprogramSpark"))
    ForcePainted(GetRelativePrefabEntity(target, ".OswaldReprogramLights"))
    ForcePainted(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"))
    if (data.OptionalEntities[1] == "Pipe1") then
      ForcePainted(GetRelativePrefabEntity(target, ".OswaldReprogramPipe1"))
    end
    if (data.OptionalEntities[2] == "Pipe2") then
      ForcePainted(GetRelativePrefabEntity(target, ".OswaldReprogramPipe2"))
    end
    if (data.OptionalEntities[3] == "Pipe3") then
      ForcePainted(GetRelativePrefabEntity(target, ".OswaldReprogramPipe3"))
    end
    if (data.OptionalEntities[4] == "Stand") then
      ForcePainted(GetRelativePrefabEntity(target, ".OswaldReprogramStand"))
    end
    if (data.OptionalEntities[5] == "WallMount") then
      ForcePainted(GetRelativePrefabEntity(target, ".OswaldReprogramWallMount"))
    end
  end
  if (data.ToonStateChangeFunction[1] ~= "None") then
    local ToSend = target
    if (data.ToonStateChangeFunction[2] ~= "OptionalTarget") then
      ToSend = data.ToonStateChangeFunction[2]
    end
    local Param = thinned
    if (thinned == "true") then
      if (data.ToonStateChangeFunction[4] ~= "OptionalThinnedParam") then
        Param = data.ToonStateChangeFunction[4]
      end
    elseif (data.ToonStateChangeFunction[3] ~= "OptionalPaintedParam") then
      Param = data.ToonStateChangeFunction[3]
    end
    local GlobalName = data.PersistanceGlobal
    local GlobalValue = nil
    if (GlobalName ~= "NotSetUp") then
      GlobalValue = GetGlobal(GlobalName)
    end
    Print(("__Will FireThread: " .. tostring(data.ToonStateChangeFunction[1])))
    FireThread(_G[data.ToonStateChangeFunction[1]], ToSend, Param, GlobalName, GlobalValue)
  end
  return 
end
OswaldReprogram_HackSucces = function(target)
  local data = GetPrefabData(target)
  Reprogram_ChangeState(target, "success")
  if (data.HackSuccessFunction[1] ~= "None") then
    local ToSend = target
    if (data.HackSuccessFunction[2] ~= "OptionalTarget") then
      ToSend = data.HackSuccessFunction[2]
    end
    Print(("__Will FireThread: " .. tostring(data.HackSuccessFunction[1])))
    FireThread(_G[data.HackSuccessFunction[1]], ToSend)
  end
  return 
end
Reprogram_Difficulty_Setting = function(self)
  local data = GetPrefabData(self)
  if (data.Episode == "1") then
    SetPropertyFloat(self, "HackStageSweetSpots", 0.30000001192092896, 0)
    SetPropertyFloat(self, "HackStageSweetSpots", 0.20000000298023224, 1)
    SetPropertyFloat(self, "HackTime", 30)
  elseif (data.Episode == "2") then
    SetElementCount(self, "HackStageSweetSpots", 4)
    local (for index), (for limit), (for step) = 0, 3, 1
    for i = (for index), (for limit), (for step) do
      SetPropertyFloat(self, "HackStageSweetSpots", 0.20000000298023224, i)
    end
    SetElementCount(self, "HackStageTypes", 4)
    SetPropertyInt(self, "HackStageTypes", 1, 2)
    SetPropertyInt(self, "HackStageTypes", 5, 3)
    SetPropertyFloat(self, "HackTime", 30)
  elseif (data.Episode == "3") then
    SetElementCount(self, "HackStageSweetSpots", 4)
    SetPropertyFloat(self, "HackStageSweetSpots", 0.10000000149011612, 0)
    SetPropertyFloat(self, "HackStageSweetSpots", 0.20000000298023224, 1)
    SetPropertyFloat(self, "HackStageSweetSpots", 0.10000000149011612, 2)
    SetPropertyFloat(self, "HackStageSweetSpots", 0.20000000298023224, 3)
    SetElementCount(self, "HackStageTypes", 4)
    SetPropertyInt(self, "HackStageTypes", 1, 2)
    SetPropertyInt(self, "HackStageTypes", 5, 3)
    SetPropertyFloat(self, "HackTime", 20)
  end
  if (data.PersistanceGlobal == "NotSetUp") then
    Print("Oswald Reprogram Access: The persistance global is NOT set up. Using the hack start disabled property to set up the visual instead. Your Reprogram Box will not persisit")
    if (GetPropertyBool(self, "HackStartDisabled") == false) then
      Reprogram_ChangeState(self, "activate")
    else
      Reprogram_ChangeState(self, "off")
      if (GetGlobal(data.PersistanceGlobal) == -1) then
        Print("Oswald Reprogram Access: Global is -1 so disabling the reprogram switch")
        Reprogram_ChangeState(self, "off")
      elseif (GetGlobal(data.PersistanceGlobal) == 0) then
        Print("Oswald Reprogram Access: Global is 0 so activating the reprogram switch")
        Reprogram_ChangeState(self, "activate")
      elseif (GetGlobal(data.PersistanceGlobal) == 1) then
        Print("Oswald Reprogram Access: Global is 1 so setting the reprogram switch as used")
        Reprogram_ChangeState(self, "success")
      end
    end
  elseif (GetGlobal(data.PersistanceGlobal) == -1) then
    Print("Oswald Reprogram Access: Global is -1 so disabling the reprogram switch")
    Reprogram_ChangeState(self, "off")
  elseif (GetGlobal(data.PersistanceGlobal) == 0) then
    Print("Oswald Reprogram Access: Global is 0 so activating the reprogram switch")
    Reprogram_ChangeState(self, "activate")
  elseif (GetGlobal(data.PersistanceGlobal) == 1) then
    Print("Oswald Reprogram Access: Global is 1 so setting the reprogram switch as used")
    Reprogram_ChangeState(self, "success")
  end
  return 
end
HackStage = 0
Reprogram_DisplayControls1 = function()
  local player2 = GetPlayer2()
  if (player2 ~= nil) then
    HackStage = (HackStage + 1)
    if (HackStage == 1) then
      Wait(2.5)
    else
      Reprogram_HideControls2()
      Wait(0.5)
    end
    if (HackStage == 1) then
      Reprogram_DisplayControl(GetPlayer2(), "ReprogramControls1")
    end
  end
  return 
end
Reprogram_DisplayControls = function()
  local player2 = GetPlayer2()
  if (player2 ~= nil) then
    if (HackStage == 1) then
      Reprogram_DisplayControls2()
    end
    if (HackStage == 2) then
      Reprogram_DisplayControls1()
    else
      Reprogram_HideControlsAll()
    end
  end
  return 
end
Reprogram_DisplayControls2 = function()
  local player2 = GetPlayer2()
  if (player2 ~= nil) then
    HackStage = (HackStage + 1)
    Reprogram_HideControls1()
    Wait(0.5)
    if (HackStage == 2) then
      Reprogram_DisplayControl(GetPlayer2(), "ReprogramControls2")
    end
  end
  return 
end
Reprogram_CullControls1 = function(self)
  SetAppCulledViewport(self, 0)
  return 
end
Reprogram_CullControls2 = function(self)
  SetAppCulledViewport(self, 0)
  return 
end
Reprogram_HideControls1 = function()
  local player2 = GetPlayer2()
  if (player2 ~= nil) then
    Reprogram_HideControl(GetPlayer2(), "ReprogramControls1")
  end
  return 
end
Reprogram_HideControls2 = function()
  local player2 = GetPlayer2()
  if (player2 ~= nil) then
    Reprogram_HideControl(GetPlayer2(), "ReprogramControls2")
  end
  return 
end
Reprogram_HideControlsAll = function()
  HackStage = 0
  Reprogram_HideControls1()
  Reprogram_HideControls2()
  return 
end
Reprogram_ChangeState = function(target, state)
  local data = GetPrefabData(target)
  Print(("Reprogram_ChangeState :" .. state))
  if (state == "activate") then
    SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), 0, vector4(0.25999999046325684, 0.6499999761581421, 0))
    SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), 1, vector4(1, 0.4000000059604645, 0))
    AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), "attractLoop")
    Enable(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"))
    if (data.PersistanceGlobal == "NotSetUp") then
      Print("OswaldChangeState: The persistance global is NOT set up. Your Reprogram Box will not persisit")
    else
      Print("OswaldChangeState: Activating---setting global to 0")
      SetGlobal(data.PersistanceGlobal, 0)
      if (state == "success") then
        SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), 0, vector4(0.36000001430511475, 1, 0))
        SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), 1, vector4(0, 1, 0))
        AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), "stage3")
        DisableComponent(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), "Hack")
        Hide(GetRelativePrefabEntity(target, ".OswaldReprogramSpark"))
        if (GetPropertyBool(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), "HackOnce") == true) then
          if (data.PersistanceGlobal == "NotSetUp") then
            Print("OswaldChangeState: The persistance global is NOT set up. Your Reprogram Box will not persisit")
          else
            Print("OswaldChangeState: Activated---setting global to 1")
            SetGlobal(data.PersistanceGlobal, 1)
            wait(3)
            Reprogram_ChangeState(target, "activate")
            if (state == "off") then
              SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), 0, vector4(0.15000000596046448, 0.15000000596046448, 0.15000000596046448))
              SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), 1, vector4(0, 0, 0))
              AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), "off")
              DisableComponent(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), "Hack")
              Hide(GetRelativePrefabEntity(target, ".OswaldReprogramSpark"))
              if (data.PersistanceGlobal == "NotSetUp") then
                Print("OswaldChangeState: The persistance global is NOT set up. Your Reprogram Box will not persisit")
              else
                Print("OswaldChangeState: Deactivating---setting global to -1")
                SetGlobal(data.PersistanceGlobal, -1)
              end
            end
          end
        else
          wait(3)
          Reprogram_ChangeState(target, "activate")
          if (state == "off") then
            SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), 0, vector4(0.15000000596046448, 0.15000000596046448, 0.15000000596046448))
            SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), 1, vector4(0, 0, 0))
            AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), "off")
            DisableComponent(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), "Hack")
            Hide(GetRelativePrefabEntity(target, ".OswaldReprogramSpark"))
            if (data.PersistanceGlobal == "NotSetUp") then
              Print("OswaldChangeState: The persistance global is NOT set up. Your Reprogram Box will not persisit")
            else
              Print("OswaldChangeState: Deactivating---setting global to -1")
              SetGlobal(data.PersistanceGlobal, -1)
            end
          end
        end
      elseif (state == "off") then
        SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), 0, vector4(0.15000000596046448, 0.15000000596046448, 0.15000000596046448))
        SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), 1, vector4(0, 0, 0))
        AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), "off")
        DisableComponent(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), "Hack")
        Hide(GetRelativePrefabEntity(target, ".OswaldReprogramSpark"))
        if (data.PersistanceGlobal == "NotSetUp") then
          Print("OswaldChangeState: The persistance global is NOT set up. Your Reprogram Box will not persisit")
        else
          Print("OswaldChangeState: Deactivating---setting global to -1")
          SetGlobal(data.PersistanceGlobal, -1)
        end
      end
    end
  elseif (state == "success") then
    SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), 0, vector4(0.36000001430511475, 1, 0))
    SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), 1, vector4(0, 1, 0))
    AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), "stage3")
    DisableComponent(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), "Hack")
    Hide(GetRelativePrefabEntity(target, ".OswaldReprogramSpark"))
    if (GetPropertyBool(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), "HackOnce") == true) then
      if (data.PersistanceGlobal == "NotSetUp") then
        Print("OswaldChangeState: The persistance global is NOT set up. Your Reprogram Box will not persisit")
      else
        Print("OswaldChangeState: Activated---setting global to 1")
        SetGlobal(data.PersistanceGlobal, 1)
        wait(3)
        Reprogram_ChangeState(target, "activate")
        if (state == "off") then
          SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), 0, vector4(0.15000000596046448, 0.15000000596046448, 0.15000000596046448))
          SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), 1, vector4(0, 0, 0))
          AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), "off")
          DisableComponent(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), "Hack")
          Hide(GetRelativePrefabEntity(target, ".OswaldReprogramSpark"))
          if (data.PersistanceGlobal == "NotSetUp") then
            Print("OswaldChangeState: The persistance global is NOT set up. Your Reprogram Box will not persisit")
          else
            Print("OswaldChangeState: Deactivating---setting global to -1")
            SetGlobal(data.PersistanceGlobal, -1)
          end
        end
      end
    else
      wait(3)
      Reprogram_ChangeState(target, "activate")
      if (state == "off") then
        SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), 0, vector4(0.15000000596046448, 0.15000000596046448, 0.15000000596046448))
        SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), 1, vector4(0, 0, 0))
        AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), "off")
        DisableComponent(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), "Hack")
        Hide(GetRelativePrefabEntity(target, ".OswaldReprogramSpark"))
        if (data.PersistanceGlobal == "NotSetUp") then
          Print("OswaldChangeState: The persistance global is NOT set up. Your Reprogram Box will not persisit")
        else
          Print("OswaldChangeState: Deactivating---setting global to -1")
          SetGlobal(data.PersistanceGlobal, -1)
        end
      end
    end
  elseif (state == "off") then
    SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), 0, vector4(0.15000000596046448, 0.15000000596046448, 0.15000000596046448))
    SetR3MTColorReg(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), 1, vector4(0, 0, 0))
    AnimGBSequence(GetRelativePrefabEntity(target, ".OswaldReprogramLights"), "off")
    DisableComponent(GetRelativePrefabEntity(target, ".OswaldReprogramScreen"), "Hack")
    Hide(GetRelativePrefabEntity(target, ".OswaldReprogramSpark"))
    if (data.PersistanceGlobal == "NotSetUp") then
      Print("OswaldChangeState: The persistance global is NOT set up. Your Reprogram Box will not persisit")
    else
      Print("OswaldChangeState: Deactivating---setting global to -1")
      SetGlobal(data.PersistanceGlobal, -1)
    end
  end
  return 
end
