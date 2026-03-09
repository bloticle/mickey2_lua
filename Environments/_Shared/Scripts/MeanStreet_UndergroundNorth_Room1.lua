local currentRoom = "1"
UtilNorth1_Setup = function(target, side)
  Print("UtilNorth1_Setup")
  ForEachEntityInGroup(Disable, "Trigger_Save")
  currentRoom = string.sub(side, -1)
  if (GetNumPlayers() == 2) then
    SetCameraAttributesForPlayer((("MCO_Side" .. currentRoom) .. "_coopPlayer1"), GetPlayer())
  else
    SetCameraAttributesForPlayer(("MCO_Side" .. currentRoom), GetPlayer())
  end
  SetCameraAttributesForPlayer((("MCO_Side" .. currentRoom) .. "_coopPlayer2"), GetPlayer2OrAI())
  AudioPostEventOn(GetPlayer(), "Play_sfx_msu_amb")
  AudioSetState(GetPlayer(), "Utilidors_Amb", "SideRoom_Amb")
  local fromCheckpoint = true
  if (tostring(MostRecentCheckpointCallback) ~= "UtilNorth1_LoadCheckpoint") then
    fromCheckpoint = false
  end
  Print(("UtilNorth1_Setup: fromCheckpoint = " .. tostring(fromCheckpoint)))
  if (GetGlobal("MSS_GremlinStructure_Emporium") ~= 1) then
    SetPropertyFloat("ToSouth_ElevatorButton", "UsableRadius", 0)
    Disable("Trigger_PneumaticTube_ToSouth")
  elseif (GetGlobal("MSS_GremlinStructure_Emporium") == 1) then
    SetPropertyFloat("ToSouth_ElevatorButton", "UsableRadius", 2)
    Enable("Trigger_PneumaticTube_ToSouth")
  end
  if (GetGlobal("MSN_GremlinStructure_Tower") ~= 1) then
    SetPropertyFloat("ToNorth_ElevatorButton", "UsableRadius", 0)
    Disable("Trigger_PneumaticTube_ToNorth")
  elseif (GetGlobal("MSN_GremlinStructure_Tower") == 1) then
    SetPropertyFloat("ToNorth_ElevatorButton", "UsableRadius", 2)
    Enable("Trigger_PneumaticTube_ToNorth")
  end
  if (MusicEventCount == 0) then
    if (not fromCheckpoint) then
      Print("UtilNorth1_Setup: Started UTD music event")
      MusicPostEventOn(GetPlayer(), "Play_MX_UTD")
      MusicEventCount = 1
    end
  end
  SetCombatIntensityBias(-100)
  SetPlayStyleScoreBias(-100)
  Print("UtilNorth1_Setup: Disabled combat music")
  Print("UtilNorth1_Setup: Gus Hint check")
  local (for index), (for limit), (for step) = 1, 2, 1
  for i = (for index), (for limit), (for step) do
    if (GetGlobal(("MSN_PTMachine0" .. i)) == -1) then
      Print((("UtilNorth1_Setup: Gus Hint check MSN_PTMachine0" .. i) .. " = -1 so enabling exit hint"))
      EnableGuardianHint(("GusHint_VaultRoomExit_Side" .. i))
      DisableGuardianHint(("GusHint_VaultRoom_Side" .. i))
      Disable("OswaldBlocker_VaultRoom")
    end
    local global = GetGlobal(("MSN_PTMachine0" .. i))
    if (global == -1) then
      AnimGBSequence("UtilSideAirlock2_ExitDoor01", "Anim")
    end
    Prefab_OswaldElectricSwitch_ChangeState(("North1_OswaldSwitch" .. i), "Deactivate")
  end
  if (GetGlobal("MSN_PTMachine01") < 0) then
    if (GetGlobal("MSN_PTMachine02") < 0) then
      local (for index), (for limit), (for step) = 1, 2, 1
      for i = (for index), (for limit), (for step) do
        (for index) = "North1_OswaldSwitch"
        (for limit) = i
        (for index) = ((for index) .. (for limit))
        (for limit) = "Deactivate"
        Prefab_OswaldElectricSwitch_ChangeState((for index), (for limit))
        (for index) = "HiddenOswaldAction_Room"
        (for limit) = i
        (for index) = ((for index) .. (for limit))
        (for limit) = "ActionSpotEnabled"
        (for step) = false
        SetPropertyBool((for index), (for limit), (for step))
        local flipper_degree = 0
        (for index) = GetGlobal
        (for limit) = "Fixer_Upper_Pin"
        (for index) = (for index)((for limit))
        if ((for index) == 1) then
          flipper_degree = 180
        end
        (for index) = InstantRotateToPosition
        (for limit) = "UtilNRoom1_TreasureFlipper"
        (for step) = flipper_degree
        (for index)((for limit), (for step))
      end
    end
  end
  if (not fromCheckpoint) then
    wait(3)
    if IsValidHandle(("TriggerLookAt_SeeVault_" .. side)) then
      Enable(("TriggerLookAt_SeeVault_" .. side))
    end
  end
  FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer(), "IgnoreY")
  FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer2OrAI(), "IgnoreY")
  FireThread(UtilNorth1_SaveCheckPoint, target, side)
  FireThread(UtilNorth1_CheckStreaming, currentRoom)
  return 
end
UtilNorth1_CheckStreaming = function(Room)
  local door = ("UtilNorth1_ExitDoor0" .. Room)
  if (GetPropertyInt(door, "Active Sequence ID") == 1) then
    AnimGBSetIdle(door, true)
    while true do
      if (not (LevelManager_HasStateFinishedStreaming() == false)) then
        break
      end
      wait(0.20000000298023224)
    end
    while true do
      if (not (LevelManager_WaitingForStreamingSync() == false)) then
        break
      end
      Wait(0.05000000074505806)
    end
    AnimGBSetIdle(door, false)
  end
  return 
end
Room1Filled = function(target, Room)
  ForEachEntityInGroup(Disable, "Trigger_Save")
  AnimGBSequence("UtilSideAirlock2_ExitDoor01", "Anim")
  Disable("OswaldBlocker_VaultRoom")
  AnimGBSequence(("UtilNorth1_ExitDoor0" .. Room), "Anim")
  AudioPostEventOn("mst_utilidors_01a_northroom1_audio.Play_sfx_msu_bar_gates_open", "Play_sfx_msu_vault_doors_open")
  if (Room == "1") then
    AnimGBSequence("Util_MickeyVaultDoor", "Open")
  elseif (Room == "2") then
    AnimGBSequence("Util_OswaldVaultDoor", "Open")
  end
  EnableGuardianHint(("GusHint_VaultRoomExit_Side" .. Room))
  DestroyEntity(("GusHint_VaultRoom_Side" .. Room))
  Room1PrizeCheck(Room)
  return 
end
local PrizeStingerVar = 0
Room1PrizeCheck = function(Room)
  local OpenBars = function(flipper_degree)
    SetRotatorMaxSpeed("UtilNRoom1_TreasureFlipper", 30)
    StartRotateToPosition("UtilNRoom1_TreasureFlipper", flipper_degree)
    Wait(3)
    local Chest = "RedChest_DemolitionPin"
    if (flipper_degree == 180) then
      Chest = "RedChest_FixerUpperPin"
    end
    local data = GetPrefabData(Chest)
    data.ChestDisabled = "False"
    SetSplineFollowerInitialSpeed("UtilNorth1_MickeyVaultBars", 0.699999988079071)
    SplineFollower_StopAtPosition("UtilNorth1_MickeyVaultBars", "UtilNorth1_MickeyVaultBarKnot01", "UtilNorth1_MickeyVaultBarKnot02", 1)
    AudioPostEventOn("mst_utilidors_01a_northroom1_audio.Play_sfx_msu_bar_gates_open", "Play_sfx_msu_bar_gates_open")
    if (PrizeStingerVar == 0) then
      DoStinger("UTD_StingerRoomPrize", 2)
      PrizeStingerVar = 1
    end
    SetSplineFollowerInitialSpeed("UtilNorth1_OswaldVaultBars", 0.699999988079071)
    AudioPostEventOn("UtilNorth1_OswaldVaultBars", "Play_sfx_msu_bar_gates_open")
    SplineFollower_StopAtPosition("UtilNorth1_OswaldVaultBars", "SK_OswaldVaultBarDoor1", "SK_OswaldVaultBarDoor2", 1)
    UtilNorth1_SaveCheckPoint(nil, currentRoom)
    return 
  end
  local Room1_global = GetGlobal("MSN_PTMachine01")
  local Room2_global = GetGlobal("MSN_PTMachine02")
  if (Room1_global ~= -1) then
  end
  if (Room1_global == -1) then
    if (Room2_global == -1) then
      OpenBars(180)
      SetGlobal("Util_QuestHealth", (GetGlobal("Util_QuestHealth") + 30))
    end
  else
    OpenBars(0)
    SetGlobal("Util_QuestHealth", (GetGlobal("Util_QuestHealth") - 30))
    if (Room1_global == -1) then
      if (Room1_global == -2) then
        AnimGBSequence("UtilNorth1_ExitDoor02", "Anim")
        local result1 = math.random(1, 2)
        if (result1 == 1) then
          OpenBars(0)
        elseif (result1 == 2) then
          OpenBars(180)
        end
      end
    end
  end
  if (GetGlobal("MSN_PTMachine01") < 0) then
    if (GetGlobal("MSN_PTMachine02") < 0) then
      local (for index), (for index), (for limit) = 1, 2, 1
      for (for step) = (for index), (for index), (for limit) do
        i = Prefab_OswaldElectricSwitch_ChangeState
        i(("North1_OswaldSwitch" .. (for step)), "Deactivate")
        i = SetPropertyBool
        i(("HiddenOswaldAction_Room" .. (for step)), "ActionSpotEnabled", false)
      end
    end
  elseif (GetGlobal(("MSN_PTMachine0" .. Room)) < 0) then
    wait(3)
    Prefab_OswaldElectricSwitch_ChangeState(("North1_OswaldSwitch" .. Room), "Activate")
    SetPropertyBool(("HiddenOswaldAction_Room" .. Room), "ActionSpotEnabled", true)
  end
  UtilNorth1_GusSeesTreasure()
  return 
end
UtilNorth1_GusSeesTreasure = function()
  if (not GetGlobal("MST_Gus_North1_SeesTreasure_Played")) then
    FireSequence("UtilNorth1_GusConvoMarker", "MST_Gus_North1_SeesTreasure")
  end
  return 
end
MST_NorthRoom1_ResetPump = function(target, Room)
  OswaldStreamAbort()
  SetPropertyBool(("HiddenOswaldAction_Room" .. Room), "ActionSpotEnabled", false)
  Prefab_OswaldElectricSwitch_ChangeState(("North1_OswaldSwitch" .. Room), "Reset")
  Prefab_OswaldElectricSwitch_ChangeState(("North1_OswaldSwitch" .. Room), "Deactivate")
  wait(0.20000000298023224)
  local door = "Util_MickeyVaultDoor"
  if (Room == "2") then
    door = "Util_OswaldVaultDoor"
  end
  if (GetPropertyInt(door, "Active Sequence ID") == 1) then
    AnimGBSequence(door, "close", true)
    AudioPostEventOn("mst_utilidors_01a_northroom1_audio.Play_sfx_msu_bar_gates_open", "Play_sfx_msu_hallway_door_open")
  end
  wait(0.6499999761581421)
  Print("MST_NorthRoom1_ResetPump: Door Closing")
  Enable(("Trigger_PlayerVaultCheck_Room" .. Room))
  wait(0.5)
  Print("MST_NorthRoom1_ResetPump: Door Closed")
  Disable(("Trigger_PlayerVaultCheck_Room" .. Room))
  FireThread(ThinnerPaintMachine_Reset, (("mst_utilidors_01a_northroom1_scripting.thinnerpaintmachine 0" .. Room) .. ".Nozzle"))
  return 
end
Util_North1_GusVaultIntro = function(target)
  DestroyEntity(target)
  if (GetGlobal("MST_Gus_North1_SeesVault_Played") == 0) then
    FireSequence("UtilNorth1_GusConvoMarker", "MST_Gus_North1_SeesVault")
  elseif (GetGlobal("MST_Gus_North1_SeesVault_Played") == 1) then
    FireSequence("UtilNorth1_GusConvoMarker", "MST_Gus_North1_SecondVault")
  end
  return 
end
UtilNorth1_SaveCheckPoint = function(target, side)
  wait(0.20000000298023224)
  if (side == nil) then
    side = currentRoom
  else
    side = string.sub(side, -1)
  end
  SaveCheckpoint(GetPlayer(), "UtilNorth1_LoadCheckpoint", (("UtilNorth1_Vault_" .. side) .. "_Mickey"), (("UtilNorth1_Vault_" .. side) .. "_Oswald"))
  return 
end
UtilNorth1_LoadCheckpoint = function()
  ForEachEntityInGroup(Enable, "Trigger_Save")
  return 
end
