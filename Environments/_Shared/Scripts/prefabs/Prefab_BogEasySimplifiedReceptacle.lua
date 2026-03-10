Prefab_SimplifiedReceptacle_AlwaysSetup = function(target)
  Print("__Function: Prefab_SimplifiedReceptacle_AlwaysSetup")
  local data = GetPrefabData(target)
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 1) then
    Prefab_OswaldElectricSwitch_ChangeState("TrainStation_ReceptacleSwitch", "Deactivate")
    Disable("TrainQuestOswaldHint")
  else
    Prefab_OswaldElectricSwitch_ChangeState("TrainStation_ReceptacleSwitch", "Activate")
    Enable("TrainQuestOswaldHint")
  end
  local State = GetGlobal(data.PoweredGlobal)
  if (State ~= -1) then
    if (State == 1) then
      Prefab_OswaldElectricSwitch_ChangeState("TrainStation_ReceptacleSwitch", "Deactivate")
      Disable("TrainQuestOswaldHint")
    end
  end
  return 
end
Prefab_SimplifiedReceptacle_TVEntered = function(target)
  Print("__Function: Prefab_SimplifiedReceptacle_TVEntered")
  local data = GetPrefabData(target)
  SetGlobal(data.PoweredGlobal, 1)
  AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_TrainStation", "Play_sfx_BE_TrainStation_Fixed")
  ForceSequence("NOS_BogEasy_Gus", "NOS_Gus_TrainQuest_TVPowered")
  Prefab_OswaldElectricSwitch_ChangeState("TrainStation_ReceptacleSwitch", "Deactivate")
  Disable("TrainQuestOswaldHint")
  OswaldStreamAbort()
  return 
end
Prefab_SimplifiedReceptacle_OswaldShock = function(target, _State)
  Print(("__Function: Prefab_SimplifiedReceptacle_OswaldShock, _State: " .. tostring(_State)))
  local data = GetPrefabData("TrainReceptacle")
  if (_State == "On") then
    if (GetGlobal(data.PoweredGlobal) == -1) then
      SetGlobal(data.PoweredGlobal, 0)
      AnimGBSequence("TrainReceptacle", "open")
      AudioPostEventOn("TrainReceptacle", "Play_sfx_be_charge_station_up")
      wait(0.5)
      Enable(GetRelativePrefabEntity("TrainReceptacle", ".TVTrigger"))
    else
      Print("__Receptacle already fixed, not reactivating")
      if (_State == "Off") then
        if (GetGlobal(data.PoweredGlobal) == 1) then
          Print("__Fixed! Joy!")
        else
          SetGlobal(data.PoweredGlobal, -1)
        end
        Disable(GetRelativePrefabEntity("TrainReceptacle", ".TVTrigger"))
        AnimGBSequence("TrainReceptacle", "close")
        AudioPostEventOn("TrainReceptacle", "Play_sfx_be_charge_station_down")
      end
    end
  elseif (_State == "Off") then
    if (GetGlobal(data.PoweredGlobal) == 1) then
      Print("__Fixed! Joy!")
    else
      SetGlobal(data.PoweredGlobal, -1)
    end
    Disable(GetRelativePrefabEntity("TrainReceptacle", ".TVTrigger"))
    AnimGBSequence("TrainReceptacle", "close")
    AudioPostEventOn("TrainReceptacle", "Play_sfx_be_charge_station_down")
  end
  return 
end
Prefab_SimplifiedReceptacle_ShockSwitch = function(target)
  Print("__Function: Prefab_SimplifiedReceptacle_ShockSwitch")
  OswaldStreamAction("TrainStation_ReceptacleSwitch")
  return 
end

