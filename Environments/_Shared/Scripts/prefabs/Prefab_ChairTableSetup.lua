Prefab_ChairTableSetup_AlwaysSetup = function(target)
  Print("__Function: Prefab_ChairTableSetup_AlwaysSetup")
  if (GetGlobal("NOS_BlotAlley_AdBoxesSolved") == 1) then
    Print("__Ad Boards Solved!")
    AnimGBSequence(GetRelativePrefabEntity(target, ".BellAdBox"), "Bell_noBell")
    AnimGBSequence(GetRelativePrefabEntity(target, ".SquareAdBox"), "Ped_Ghost")
    Disable("BellOswaldAction")
    Disable("SquareOswaldAction")
    Disable(GetRelativePrefabEntity(target, ".BellBox_Trigger"))
    Disable(GetRelativePrefabEntity(target, ".SquareBox_Trigger"))
    AnimGBSequence("TableChairRewardDoor", "open")
    Disable("AdBoxCameraTrigger")
  end
  return 
end
Prefab_ChairTableSetup_Trigger = function(target, _Which, _Direction)
  Print(((("__Function: Prefab_ChairTableSetup_Trigger, _Which: " .. tostring(_Which)) .. ", _Direction: ") .. tostring(_Direction)))
  if (_Direction == "Enter") then
    if (GetName(_activator()) == GetName(GetPlayer())) then
      if (_Which == "Bell") then
        Enable("SquareOswaldAction")
        Disable("BellOswaldAction")
      elseif (_Which == "Square") then
        Enable("BellOswaldAction")
        Disable("SquareOswaldAction")
        if (_Direction == "Exit") then
          if (GetName(_activator()) == GetName(GetPlayer())) then
            Disable("SquareOswaldAction")
            Disable("BellOswaldAction")
          end
        end
      end
    end
  elseif (_Direction == "Exit") then
    if (GetName(_activator()) == GetName(GetPlayer())) then
      Disable("SquareOswaldAction")
      Disable("BellOswaldAction")
    end
  end
  return 
end
Prefab_ChairTableSetup_AdBoardSpun = function(target, _event, _Which)
  Print(("__Function: Prefab_ChairTableSetup_AdBoardSpun, _Which: " .. tostring(_Which)))
  local data = GetPrefabData("AdBoxSetup")
  local toFireThread = 0
  if StimulusEvent_HasStimulusType(_event, ST_SPIN) then
    if (GetGlobal("NOS_BlotAlley_AdBoxesSolved") == 0) then
      OswaldSpinAction()
      if (_Which == "Bell") then
        if (data.AdBoxesBusy[1] == 0) then
          data.AdBoxesBusy[1] = 1
          data.AdBoxOrientation[1] = 1
          AnimGBSequence(GetRelativePrefabEntity(target, ".BellAdBox"), "noBell_Bell")
          toFireThread = 1
        end
      elseif (data.AdBoxesBusy[2] == 0) then
        data.AdBoxesBusy[2] = 1
        data.AdBoxOrientation[2] = 1
        AnimGBSequence(GetRelativePrefabEntity(target, ".SquareAdBox"), "Ghost_Ped")
        toFireThread = 1
      end
    end
  end
  if (toFireThread == 1) then
    FireThread(Prefab_ChairTableSetup_SpinBackwards, target, _Which)
    Prefab_ChairTableSetup_CheckComplete(target)
  end
  return 
end
Prefab_ChairTableSetup_SpinBackwards = function(target, _Which)
  Print(("__Function: Prefab_ChairTableSetup_SpinBackwards, _Which: " .. tostring(_Which)))
  local data = GetPrefabData(target)
  wait(1)
  if (GetGlobal("NOS_BlotAlley_AdBoxesSolved") == 0) then
    if (_Which == "Bell") then
      data.AdBoxOrientation[1] = 0
      AnimGBSequence(GetRelativePrefabEntity(target, ".BellAdBox"), "Bell_noBell")
    elseif (_Which == "Square") then
      data.AdBoxOrientation[2] = 0
      AnimGBSequence(GetRelativePrefabEntity(target, ".SquareAdBox"), "Ped_Ghost")
    end
    wait(1)
    if (_Which == "Bell") then
      data.AdBoxesBusy[1] = 0
    elseif (_Which == "Square") then
      data.AdBoxesBusy[2] = 0
    end
  end
  return 
end
Prefab_ChairTableSetup_CheckComplete = function(target)
  Print("__Function: Prefab_ChairTableSetup_CheckComplete")
  target = "AdBoxSetup"
  local data = GetPrefabData(target)
  if (data.AdBoxOrientation[1] == 1) then
    if (data.AdBoxOrientation[2] == 1) then
      Print("__REWARD!")
      AnimGBSequence("TableChairRewardDoor", "open")
      SetGlobal("NOS_BlotAlley_AdBoxesSolved", 1)
      Disable("BellOswaldAction")
      Disable("SquareOswaldAction")
      Disable(GetRelativePrefabEntity(target, ".BellBox_Trigger"))
      Disable(GetRelativePrefabEntity(target, ".SquareBox_Trigger"))
      NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Section2_Airlock")
      Disable("AdBoxCameraTrigger")
    end
  else
    Print("__Requirement Not Met")
  end
  return 
end
