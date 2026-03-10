local currentRoom = "1"
Room1SwitchesTriggered = -1
Room2SwitchesTriggered = -1
UtilSouth2_Setup = function(target, Room)
  Print("UtilSouth2_Setup")
  ForEachEntityInGroup(Disable, "Trigger_Save")
  local _player = GetPlayer()
  currentRoom = Room
  if (GetNumPlayers() == 2) then
    SetCameraAttributesForPlayer((("MCO_Side" .. currentRoom) .. "_coopPlayer1"), _player)
  else
    SetCameraAttributesForPlayer(("MCO_Side" .. currentRoom), _player)
  end
  SetCameraAttributesForPlayer((("MCO_Side" .. currentRoom) .. "_coopPlayer2"), GetPlayer2OrAI())
  AudioPostEventOn(_player, "Play_sfx_msu_amb")
  AudioSetState(_player, "Utilidors_Amb", "FanRoom_Amb")
  local fromCheckpoint = true
  if (tostring(MostRecentCheckpointCallback) ~= "UtilSouth2_LoadCheckpoint") then
    fromCheckpoint = false
  end
  local ResetBridges = function(RoomNum)
    ForEachEntityInGroup(Enable, (("Room" .. RoomNum) .. "BridgeA"))
    ForEachEntityInGroup(Enable, (("Room" .. RoomNum) .. "BridgeB"))
    ForEachEntityInGroup(Enable, (("Room" .. RoomNum) .. "BridgeA_2"))
    ForEachEntityInGroup(Enable, (("Room" .. RoomNum) .. "BridgeB_2"))
    wait(0)
    ForEachEntityInGroup(InstantRotateToPosition, (("Room" .. RoomNum) .. "BridgeA"), -70)
    ForEachEntityInGroup(InstantRotateToPosition, (("Room" .. RoomNum) .. "BridgeB"), -70)
    ForEachEntityInGroup(InstantRotateToPosition, (("Room" .. RoomNum) .. "BridgeA_2"), 25)
    ForEachEntityInGroup(InstantRotateToPosition, (("Room" .. RoomNum) .. "BridgeB_2"), 25)
    wait(0)
    ForEachEntityInGroup(Disable, (("Room" .. RoomNum) .. "BridgeA"))
    ForEachEntityInGroup(Disable, (("Room" .. RoomNum) .. "BridgeB"))
    ForEachEntityInGroup(Disable, (("Room" .. RoomNum) .. "BridgeA_2"))
    ForEachEntityInGroup(Disable, (("Room" .. RoomNum) .. "BridgeB_2"))
    SetPropertyBool(("OswaldAction_ChargeSwitchInitial" .. RoomNum), "ActionSpotEnabled", true)
    local forStart = 1
    local forEnd = 3
    if (RoomNum == "2") then
      forStart = 4
      forEnd = 6
    end
    for i = forStart, forEnd do
      ForceSketched(((("mst_utilidors_01a_southroom2_scriptingside" .. RoomNum) .. ".MST_south_01a_agencyMachine_toon_02a 0") .. i))
    end
    return 
  end
  local global = tostring(GetGlobal("MST_BridgeRoomState"))
  local Room1State = string.sub(global, -1, -1)
  local Room2State = string.sub(global, -2, -2)
  if (string.len(global) == 1) then
    Room2State = "0"
  end
  local DisableGusHints = function(RoomNum)
    for i = 1, 3 do
      DisableGuardianHint(((("GusHint_PropRoom_Side" .. RoomNum) .. "_") .. tostring(i)))
    end
    EnableGuardianHint((("GusHint_PropRoom_Side" .. RoomNum) .. "_Exit"))
    ActivateNavMeshObstacle(("UtilSouth2_ExitDoor0" .. RoomNum), false)
    SetPropertyBool((("OswaldAction_Room" .. RoomNum) .. "_FromExit"), "ActionSpotEnabled", true)
    _G[(("Room" .. RoomNum) .. "SwitchesTriggered")] = 3
    local fan_dir = 1
    local forStart = 1
    local forEnd = 3
    if (RoomNum == "2") then
      forStart = 4
      forEnd = 6
      fan_dir = -1
    end
    fan_dir = "UtilSouth2_Side"
    forStart = RoomNum
    forEnd = "_Cone"
    fan_dir = ((fan_dir .. forStart) .. forEnd)
    Enable(fan_dir)
    fan_dir = "UtilSouth2_Side"
    forStart = RoomNum
    forEnd = "_Cone"
    fan_dir = ((fan_dir .. forStart) .. forEnd)
    forStart = (45 * fan_dir)
    SetRotatorMaxSpeed(fan_dir, forStart)
    fan_dir = SetRotatorMaxSpeed
    forStart = "Room"
    forEnd = RoomNum
    forStart = ((forStart .. forEnd) .. "BridgeA")
    forEnd = 50
    ForEachEntityInGroup(fan_dir, forStart, forEnd)
    fan_dir = SetRotatorMaxSpeed
    forStart = "Room"
    forEnd = RoomNum
    forStart = ((forStart .. forEnd) .. "BridgeB")
    forEnd = 50
    ForEachEntityInGroup(fan_dir, forStart, forEnd)
    fan_dir = SetRotatorMaxSpeed
    forStart = "Room"
    forEnd = RoomNum
    forStart = ((forStart .. forEnd) .. "BridgeA_2")
    forEnd = 50
    ForEachEntityInGroup(fan_dir, forStart, forEnd)
    fan_dir = SetRotatorMaxSpeed
    forStart = "Room"
    forEnd = RoomNum
    forStart = ((forStart .. forEnd) .. "BridgeB_2")
    forEnd = 50
    ForEachEntityInGroup(fan_dir, forStart, forEnd)
    fan_dir = StartRotateToPosition
    forStart = "Room"
    forEnd = RoomNum
    forStart = ((forStart .. forEnd) .. "BridgeA")
    forEnd = 0
    ForEachEntityInGroup(fan_dir, forStart, forEnd)
    fan_dir = StartRotateToPosition
    forStart = "Room"
    forEnd = RoomNum
    forStart = ((forStart .. forEnd) .. "BridgeB")
    forEnd = 0
    ForEachEntityInGroup(fan_dir, forStart, forEnd)
    fan_dir = Prefab_OswaldElectricSwitch_ChangeState
    forStart = GetRelativePrefabEntity
    forEnd = "UtilSouth2_OswaldSwitch_InitialSide"
    forEnd = (forEnd .. RoomNum)
    forStart = forStart(forEnd, ".OswaldSwitchStand")
    forEnd = "FullyCharged"
    FireThread(fan_dir, forStart, forEnd)
    fan_dir = forEnd
    forStart = 1
    for forEnd = forStart, fan_dir, forStart do
      i = "UtilSouth2_OswaldSwitch"
      i = (i .. forEnd)
      i = "FullyCharged"
      FireThread(Prefab_OswaldElectricSwitch_ChangeState, GetRelativePrefabEntity(i, ".OswaldSwitchStand"), i)
    end
    return 
  end
  if (Room1State == "1") then
    Print("UtilSouth2_Setup: Room1State == 1 or Room2State == 1")
    Disable("OswaldBlocker_BridgeRoom")
    AnimGBSequence("UtilSideAirlock1_ExitDoor01", "Anim")
  end
  if (Room1State == "1") then
    Print("UtilSouth2_Setup: Room1State == 1")
    DisableGusHints("1")
  elseif (Room1State == "0") then
    ResetBridges("1")
    if (Room == "2") then
      Print("UtilSouth2_Setup: Room1State == 0 and we are in Room 2")
      SetPropertyBool("OswaldAction_Room1_FromExit", "ActionSpotEnabled", false)
    end
  end
  if (Room2State == "1") then
    Print("UtilSouth2_Setup: Room2State == 1")
    DisableGusHints("2")
  elseif (Room2State == "0") then
    ResetBridges("2")
    if (Room == "1") then
      Print("UtilSouth2_Setup: Room2State == 0 and we are in Room 1")
      SetPropertyBool("OswaldAction_Room2_FromExit", "ActionSpotEnabled", false)
    end
  end
  if (tonumber(global) == 11) then
    for i = 1, 2 do
      SplineFollower_SetDisabled((("SF_Room" .. i) .. "_Gate1"), false)
      ActivateNavMeshObstacle((("SF_Room" .. i) .. "_Gate1"), false)
    end
    SetRotatorMaxSpeed("UtilSouth2_TreasureFlipper", 0)
    local flipper_global = GetGlobal("MSU_SouthRoom5ChestAwarded")
    InstantRotateToPosition("UtilSouth2_TreasureFlipper", flipper_global)
    Wait(3)
    local Chest = "RedChest_HandymousePin"
    if (flipper_global == 180) then
      Chest = "RedChest_EradicatorPin"
    end
    local data = GetPrefabData(Chest)
    data.ChestDisabled = "False"
  end
  if (GetGlobal("MSS_GremlinStructure_GuardianPool") ~= 1) then
    SetPropertyFloat("ToSouth_ElevatorButton", "UsableRadius", 0)
    Disable("Trigger_PneumaticTube_ToSouth")
  elseif (GetGlobal("MSS_GremlinStructure_GuardianPool") == 1) then
    SetPropertyFloat("ToSouth_ElevatorButton", "UsableRadius", 2)
    Enable("Trigger_PneumaticTube_ToSouth")
  end
  if (GetGlobal("MSN_GremlinStructure_FishHead") ~= 1) then
    SetPropertyFloat("ToNorth_ElevatorButton", "UsableRadius", 0)
    Disable("Trigger_PneumaticTube_ToNorth")
  elseif (GetGlobal("MSN_GremlinStructure_FishHead") == 1) then
    SetPropertyFloat("ToNorth_ElevatorButton", "UsableRadius", 2)
    Enable("Trigger_PneumaticTube_ToNorth")
  end
  wait(1)
  if (not fromCheckpoint) then
    if (MusicEventCount == 0) then
      Print("UtilSouth2_Setup: Started UTD music event")
      MusicPostEventOn(_player, "Play_MX_UTD")
      MusicEventCount = 1
    end
  end
  SetCombatIntensityBias(-100)
  SetPlayStyleScoreBias(-100)
  Print("UtilSouth2_Setup: Disabled combat music")
  FireThread(StationaryCamera_UntilPlayerMoves)
  FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer2OrAI())
  if (not fromCheckpoint) then
    UtilSouth2_SaveCheckPoint(target, Room)
  end
  FireThread(UtilSouth2_CheckStreaming, Room)
  if (not fromCheckpoint) then
    local currentRoomState = Room1State
    if (Room == "2") then
      currentRoomState = Room2State
    end
    if (global == "0") then
      if (GetGlobal("MST_Gus_South2_Intro_Played") == 0) then
        wait(0.5)
        FireSequence("Gus_Bridge", "MST_Gus_South2_Intro")
      end
    elseif (Room == nil) then
      if (currentRoomState == "0") then
        if (global ~= "0") then
          if (GetGlobal("MST_Gus_South2_Return_Played") == 0) then
            wait(0.5)
            FireSequence("Gus_Bridge", "MST_Gus_South2_Return")
          end
        end
      end
    end
    while true do
      if (not IsAnySequencePlaying()) then
        break
      end
      wait(0.5)
    end
    UtilSouth2_SaveCheckPoint(target, Room)
  end
  return 
end
UtilSouth2_CheckStreaming = function(Room)
  local door = ("UtilSouth2_ExitDoor0" .. Room)
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
UtilSouth2_SaveCheckPoint = function(target, side_Num)
  if (side_Num == nil) then
    side_Num = currentRoom
  end
  SaveCheckpoint(GetPlayer(), "UtilSouth2_LoadCheckpoint", ("CP_MickeySpawn" .. side_Num), ("CP_OswaldSpawn" .. side_Num))
  return 
end
UtilSouth2_LoadCheckpoint = function()
  Print("UtilSouth2_LoadCheckpoint")
  ForEachEntityInGroup(Enable, "Trigger_Save")
  return 
end
UtilSouth2_ShootBox = function(target, Box_Num)
  if (Box_Num == nil) then
    Box_Num = target
  end
  local switch = ("UtilSouth2_OswaldSwitch" .. Box_Num)
  if (GetPrefabData(switch).OswaldSwitchState ~= 2) then
    OswaldStreamAction(switch)
  end
  return 
end
UtilSouth2_OswaldShockSwitch = function(target, Switch_Num, off, OswaldSwitch)
  Print("&_______________________& UtilSouth2_OswaldShockSwitch")
  if (off ~= "On") then
    Print("&_______________________& UtilSouth2_OswaldShockSwitch: off ~= nil")
    local before, JigsawPercentage = 0, 0
    JigsawPercentage = --[[ return 2 of ]] Jigsaw_GetPercentagePainted(target)
    before = Jigsaw_GetPercentagePainted(target)
    if (JigsawPercentage ~= 1) then
      if (before == 1) then
        if (GetPrefabData(("UtilSouth2_OswaldSwitch" .. Switch_Num)).OswaldSwitchState ~= 2) then
          Print("&_______________________& UtilSouth2_OswaldShockSwitch: Aborting Oswald Stream")
          OswaldStreamAbort()
          SetPropertyBool(("OswaldAction_ChargeSwitch" .. Switch_Num), "ActionSpotEnabled", false)
          Prefab_OswaldElectricSwitch_ChangeState(OswaldSwitch, "Deactivate")
        end
      end
    end
  elseif (GetPrefabData(("UtilSouth2_OswaldSwitch" .. Switch_Num)).OswaldSwitchState ~= 2) then
    Print((("&_______________________& UtilSouth2_OswaldShockSwitch: OswaldAction_ChargeSwitch" .. Switch_Num) .. " Enabled"))
    SetPropertyBool(("OswaldAction_ChargeSwitch" .. Switch_Num), "ActionSpotEnabled", true)
    Prefab_OswaldElectricSwitch_ChangeState(OswaldSwitch, "Activate")
  end
  return 
end
local PrizeStingerVar = 0
UtilSouth2_SwitchTriggered = function(target, Switch_Num)
  Print("&_______________________& UtilSouth2_SwitchTriggered")
  local side_Num = 1
  local marker = Switch_Num
  if (string.sub(Switch_Num, 1, -2) == "Initial") then
    side_Num = tonumber(string.sub(Switch_Num, -1))
    marker = "Initial"
  elseif (4 <= tonumber(Switch_Num)) then
    side_Num = 2
    marker = (Switch_Num - 2)
  end
  local fan_dir = 1
  if (side_Num == 2) then
    fan_dir = -1
  end
  local RoomSwitchesTriggered = _G[(("Room" .. side_Num) .. "SwitchesTriggered")]
  SetPropertyBool(("OswaldAction_ChargeSwitch" .. Switch_Num), "ActionSpotEnabled", false)
  if (marker ~= "Initial") then
    DisableGuardianHint(((("GusHint_PropRoom_Side" .. side_Num) .. "_") .. marker))
  end
  if (RoomSwitchesTriggered == -1) then
    _G[(("Room" .. side_Num) .. "SwitchesTriggered")] = 0
    Enable((("UtilSouth2_Side" .. side_Num) .. "_Cone"))
    ForEachEntityInGroup(Enable, (("Room" .. side_Num) .. "BridgeA"))
    ForEachEntityInGroup(Enable, (("Room" .. side_Num) .. "BridgeB"))
    ForEachEntityInGroup(Enable, (("Room" .. side_Num) .. "BridgeA_2"))
    ForEachEntityInGroup(Enable, (("Room" .. side_Num) .. "BridgeB_2"))
    ForEachEntityInGroup(StartRotateToPosition, (("Room" .. side_Num) .. "BridgeA"), -70)
    ForEachEntityInGroup(StartRotateToPosition, (("Room" .. side_Num) .. "BridgeB"), -70)
    ForEachEntityInGroup(StartRotateToPosition, (("Room" .. side_Num) .. "BridgeA_2"), 25)
    ForEachEntityInGroup(StartRotateToPosition, (("Room" .. side_Num) .. "BridgeB_2"), 25)
    FireUser1((("UtilSouth2_Side" .. side_Num) .. "_Cone"))
    OswaldStreamAbort()
  else
    Print(((("&_______________________& UtilSouth2_SwitchTriggered: Destroying Entity - GusHint_PropRoom_Side" .. side_Num) .. "_") .. marker))
    local before, JigsawPercentage = 0, 0
    if (marker ~= "Initial") then
      JigsawPercentage = --[[ return 2 of ]] Jigsaw_GetPercentagePainted(((("mst_utilidors_01a_southroom2_scriptingside" .. side_Num) .. ".MST_south_01a_agencyMachine_toon_02a 0") .. Switch_Num))
      before = Jigsaw_GetPercentagePainted(((("mst_utilidors_01a_southroom2_scriptingside" .. side_Num) .. ".MST_south_01a_agencyMachine_toon_02a 0") .. Switch_Num))
    else
      JigsawPercentage = 1
    end
    if (JigsawPercentage == 1) then
      Print("&_______________________& UtilSouth2_SwitchTriggered: Painted")
    else
      Print("&_______________________& UtilSouth2_SwitchTriggered: Thinned")
      Prefab_ActivateSwitchTimerReset(("UtilSouth2_OswaldSwitch" .. Switch_Num))
    end
    _G[(("Room" .. side_Num) .. "SwitchesTriggered")] = (_G[(("Room" .. side_Num) .. "SwitchesTriggered")] + 1)
    RoomSwitchesTriggered = _G[(("Room" .. side_Num) .. "SwitchesTriggered")]
    Print(("&_______________________& UtilSouth2_SwitchTriggered: RoomSwitchesTriggered = " .. RoomSwitchesTriggered))
    if (RoomSwitchesTriggered == 1) then
      EnableGuardianHint(((("GusHint_PropRoom_Side" .. side_Num) .. "_") .. tostring((RoomSwitchesTriggered + 1))))
      ForEachEntityInGroup(SetRotatorMaxSpeed, (("Room" .. side_Num) .. "BridgeA"), 35)
      ForEachEntityInGroup(SetRotatorMaxSpeed, (("Room" .. side_Num) .. "BridgeB"), 35)
      SetRotatorMaxSpeed((("UtilSouth2_Side" .. side_Num) .. "_Cone"), (15 * fan_dir))
    elseif (RoomSwitchesTriggered == 2) then
      EnableGuardianHint(((("GusHint_PropRoom_Side" .. side_Num) .. "_") .. tostring((RoomSwitchesTriggered + 1))))
      ForEachEntityInGroup(SetRotatorMaxSpeed, (("Room" .. side_Num) .. "BridgeA"), 40)
      ForEachEntityInGroup(SetRotatorMaxSpeed, (("Room" .. side_Num) .. "BridgeB"), 40)
      ForEachEntityInGroup(SetRotatorMaxSpeed, (("Room" .. side_Num) .. "BridgeA_2"), 40)
      ForEachEntityInGroup(SetRotatorMaxSpeed, (("Room" .. side_Num) .. "BridgeB_2"), 40)
      SetRotatorMaxSpeed((("UtilSouth2_Side" .. side_Num) .. "_Cone"), (30 * fan_dir))
    elseif (RoomSwitchesTriggered == 3) then
      SetRotatorMaxSpeed((("UtilSouth2_Side" .. side_Num) .. "_Cone"), (45 * fan_dir))
      ForEachEntityInGroup(SetRotatorMaxSpeed, (("Room" .. side_Num) .. "BridgeA"), 50)
      ForEachEntityInGroup(SetRotatorMaxSpeed, (("Room" .. side_Num) .. "BridgeB"), 50)
      ForEachEntityInGroup(SetRotatorMaxSpeed, (("Room" .. side_Num) .. "BridgeA_2"), 50)
      ForEachEntityInGroup(SetRotatorMaxSpeed, (("Room" .. side_Num) .. "BridgeB_2"), 50)
      ForEachEntityInGroup(StartRotateToPosition, (("Room" .. side_Num) .. "BridgeA"), 0)
      ForEachEntityInGroup(StartRotateToPosition, (("Room" .. side_Num) .. "BridgeB"), 0)
      AnimGBSequence(("UtilSouth2_ExitDoor0" .. side_Num), "Anim")
      ActivateNavMeshObstacle(("UtilSouth2_ExitDoor0" .. side_Num), false)
      AnimGBSequence("UtilSideAirlock1_ExitDoor01", "Anim")
      Disable("OswaldBlocker_BridgeRoom")
      local global = GetGlobal("MST_BridgeRoomState")
      if (side_Num == 1) then
        SetGlobal("MST_BridgeRoomState", (global + 1))
      else
        SetGlobal("MST_BridgeRoomState", (global + 10))
      end
      EnableGuardianHint((("GusHint_PropRoom_Side" .. side_Num) .. "_Exit"))
      FireSequence("Gus_Bridge", "MST_Gus_EnabledPower")
      if (GetGlobal("MST_BridgeRoomState") == 11) then
        for i = 1, 2 do
          SplineFollower_SetDisabled((("SF_Room" .. i) .. "_Gate1"), false)
          ActivateNavMeshObstacle((("SF_Room" .. i) .. "_Gate1"), false)
        end
        if (PrizeStingerVar == 0) then
          DoStinger("UTD_StingerRoomPrize", 2)
          PrizeStingerVar = 1
        end
        local crazyrandom, crazyrandom = math.random(), "SwitchesTriggered"
        Print(("The random number is : " .. crazyrandom))
        if (0.5 < crazyrandom) then
          SetGlobal("MSU_SouthRoom5ChestAwarded", 180)
        end
        SetRotatorMaxSpeed("UtilSouth2_TreasureFlipper", 30)
        crazyrandom = "MSU_SouthRoom5ChestAwarded"
        StartRotateToPosition("UtilSouth2_TreasureFlipper", GetGlobal(crazyrandom))
        Wait(3)
        local Chest = "RedChest_HandymousePin"
        local GlobalChange = 15
        crazyrandom = "MSU_SouthRoom5ChestAwarded"
        if (GetGlobal(crazyrandom) == 180) then
          Chest = "RedChest_EradicatorPin"
          GlobalChange = -15
        end
        crazyrandom = "Util_QuestHealth"
        Chest = GetGlobal
        GlobalChange = "Util_QuestHealth"
        Chest = Chest(GlobalChange)
        Chest = (Chest + GlobalChange)
        SetGlobal(crazyrandom, Chest)
        crazyrandom = Chest
        local data = GetPrefabData(crazyrandom)
        data.ChestDisabled = "False"
      end
      UtilSouth2_SaveCheckPoint(nil, currentRoom)
    end
  end
  OswaldStreamAbort()
  return 
end
Bridge1InnerBlades = 1
Bridge2InnerBlades = 1
Bridge1OuterBladesUp = false
Bridge2OuterBladesUp = false
UtilSouth2_BridgeToggle = function(target, room_Num)
  Print(("UtilSouth2_BridgeToggle: room_Num = " .. room_Num))
  local outAngle = -50
  local RoomSwitchesTriggered = _G[(("Room" .. room_Num) .. "SwitchesTriggered")]
  if (RoomSwitchesTriggered == 1) then
    outAngle = -32
  elseif (RoomSwitchesTriggered == 2) then
    outAngle = -16
  elseif (RoomSwitchesTriggered == 3) then
    outAngle = 0
  end
  local BladeState = _G[(("Bridge" .. room_Num) .. "InnerBlades")]
  local BladesUp = "A"
  if (BladeState == 0) then
    ForEachEntityInGroup(StartRotateToPosition, (("Room" .. room_Num) .. "BridgeB"), -70)
    ForEachEntityInGroup(StartRotateToPosition, (("Room" .. room_Num) .. "BridgeB_2"), 25)
    ForEachEntityInGroup(StartRotateToPosition, (("Room" .. room_Num) .. "BridgeA"), 0)
    ForEachEntityInGroup(StartRotateToPosition, (("Room" .. room_Num) .. "BridgeA_2"), outAngle)
  elseif (BladeState == 2) then
    BladesUp = "B"
    ForEachEntityInGroup(StartRotateToPosition, (("Room" .. room_Num) .. "BridgeB"), 0)
    ForEachEntityInGroup(StartRotateToPosition, (("Room" .. room_Num) .. "BridgeB_2"), outAngle)
    ForEachEntityInGroup(StartRotateToPosition, (("Room" .. room_Num) .. "BridgeA"), -70)
    ForEachEntityInGroup(StartRotateToPosition, (("Room" .. room_Num) .. "BridgeA_2"), 25)
    BladeState = -2
  end
  _G[(("Bridge" .. room_Num) .. "InnerBlades")] = (BladeState + 1)
  wait(3)
  RoomSwitchesTriggered = _G[(("Room" .. room_Num) .. "SwitchesTriggered")]
  if (RoomSwitchesTriggered == 1) then
    local innerAngle = -40
    local outerAngle = 0
    if (RoomSwitchesTriggered == 1) then
      innerAngle = -70
      outerAngle = -20
    end
    if _G[(("Bridge" .. room_Num) .. "OuterBladesUp")] then
      ForEachEntityInGroup(StartRotateToPosition, (((("Room" .. room_Num) .. "Bridge") .. BladesUp) .. "_2"), outerAngle)
      _G[(("Bridge" .. room_Num) .. "OuterBladesUp")] = false
    else
      ForEachEntityInGroup(StartRotateToPosition, (((("Room" .. room_Num) .. "Bridge") .. BladesUp) .. "_2"), innerAngle)
      _G[(("Bridge" .. room_Num) .. "OuterBladesUp")] = true
    end
  end
  if (RoomSwitchesTriggered ~= 3) then
    FireUser1(target)
  else
    Print((("UtilSouth2_BridgeToggle: room_Num = " .. room_Num) .. " RoomSwitchesTriggered == 3: Goodbye"))
  end
  return 
end
UtilSouth2_SaveCheckPoint = function(target, side_Num)
  if (side_Num == nil) then
    side_Num = currentRoom
  end
  SaveCheckpoint(GetPlayer(), "UtilSouth2_LoadCheckpoint", ("CP_MickeySpawn" .. side_Num), ("CP_OswaldSpawn" .. side_Num))
  return 
end
UtilSouth2_LoadCheckpoint = function()
  ForEachEntityInGroup(Enable, "Trigger_Save")
  return 
end
local ResCamEnabled = true
UtilSouth2_KillAIAndRescuePlayer = function(_activator)
  KillAIAndRescuePlayer(_activator)
  if (0 < GetHealth(_activator)) then
    if ResCamEnabled then
      if (_activator == GetPlayer()) then
        if (GetNumPlayers() == 2) then
          SetCameraAttributesForPlayer((("MCO_Side" .. currentRoom) .. "_coopPlayer1"), _activator)
        else
          SetCameraAttributesForPlayer(("MCO_Side" .. currentRoom), _activator)
          if (_activator == GetPlayer2OrAI()) then
            SetCameraAttributesForPlayer((("MCO_Side" .. currentRoom) .. "_coopPlayer2"), _activator)
          end
        end
      elseif (_activator == GetPlayer2OrAI()) then
        SetCameraAttributesForPlayer((("MCO_Side" .. currentRoom) .. "_coopPlayer2"), _activator)
      end
      StationaryCamera_UntilPlayerMoves(nil, nil, _activator)
    end
  end
  if (GetHealth(_activator) == 0) then
    FreezeCamera(_activator)
  end
  return 
end
UtilSouth2_DisableResCam = function()
  ResCamEnabled = false
  return 
end

