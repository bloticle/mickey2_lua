local currentRoom = "1"
UtilSouth3_Intro = function(target, Room)
  Print(("UtilSouth3_Intro(): Room = " .. Room))
  ForEachEntityInGroup(Disable, "Trigger_Save")
  currentRoom = Room
  if (GetNumPlayers() == 2) then
    SetCameraAttributesForPlayer((("MCO_Side" .. currentRoom) .. "_coopPlayer1"), GetPlayer())
  else
    SetCameraAttributesForPlayer(("MCO_Side" .. currentRoom), GetPlayer())
  end
  SetCameraAttributesForPlayer((("MCO_Side" .. currentRoom) .. "_coopPlayer2"), GetPlayer2OrAI())
  AudioPostEventOn(GetPlayer(), "Play_sfx_msu_amb")
  AudioSetState(GetPlayer(), "Utilidors_Amb", "SideRoom_Amb")
  AudioPostEventOn("mst_utilidors_01a_southroom3_scripting.gremlintech_floatingplatform 01.Snd_Platform", "Play_sfx_msu_MovingPlatform_SetUtil")
  local (for index), (for limit), (for step) = 1, 2, 1
  for i = (for index), (for limit), (for step) do
    if (GetPropertyBool((("mst_utilidors_01a_southroom3_scripting.rotatinggear_smallplatform 0" .. i) .. ".Gear_Toon"), "Is Painted") == false) then
      SetRotatorMaxSpeed((("mst_utilidors_01a_southroom3_scripting.rotatinggear_smallplatform 0" .. i) .. ".Gear_Toon"), 0)
      SetRotatorMaxSpeed(("mst_utilidors_01a_southroom3_art.DBC_gremlinGear_01a_Inert 0" .. i), 0)
    end
    local PropBox = ("UtilSouth3_PropBox" .. i)
    local global = GetGlobal((("Util_WidgetRoom" .. i) .. "State"))
    if (global ~= 2) then
      if (global == 0) then
        MoveToEntity(PropBox, GetRelativePrefabEntity(PropBox, ".PropellerBoxMarker"))
        FireThread(UtilSouthRoom3_ReplaceBox, "UtilSouth3_PropBox", i, "Setup")
      elseif (global == 1) then
        local triggerEasy = GetRelativePrefabEntity(PropBox, ".PropellerBoxReceptorTriggerEasy")
        Disable(triggerEasy)
        MoveToEntity(PropBox, triggerEasy)
        DestroyEntity(triggerEasy)
      end
      Hide(("RedChest_Room" .. i))
    else
      AnimGBSequence(("UtilSouth3_ExitDoor" .. i), "Anim")
      SplineFollower_SetDisabled("Util_MainHallVaultExitDoor", false)
      Disable("OswaldBlocker_WidgetRoom")
      GetPrefabData(("RedChest_Room" .. i)).ChestDisabled = "False"
      local box, box = GetRelativePrefabEntity(PropBox, ".PropellerBoxReceptorTriggerEasy"), PropBox
      box = Disable
      box(box)
      if (global == 2) then
        box = GetRelativePrefabEntity
        box = box(PropBox, ".PropellerBoxReceptorTriggerHard")
        box = box
        box = Disable
        box(box)
      end
      box = DisableComponent
      box(PropBox, "Usable")
      box = SetVulnerability
      box(PropBox, ST_ELECTRIC, 0)
      box = SetVulnerability
      box(PropBox, ST_SPIN, 0)
      box = GetPrefabData
      box = box(PropBox)
      box.IsLocked = true
      box = MoveToEntity
      box(PropBox, box)
      box = FireUser1
      box(PropBox)
    end
  end
  if (GetGlobal("MSS_GremlinStructure_TownHall") ~= 1) then
    SetPropertyFloat("ToSouth_ElevatorButton", "UsableRadius", 0)
    Disable("Trigger_PneumaticTube_ToSouth")
  elseif (GetGlobal("MSS_GremlinStructure_TownHall") == 1) then
    SetPropertyFloat("ToSouth_ElevatorButton", "UsableRadius", 2)
    Enable("Trigger_PneumaticTube_ToSouth")
  end
  if (GetGlobal("MSN_GremlinStructure_WindMill") ~= 1) then
    SetPropertyFloat("ToNorth_ElevatorButton", "UsableRadius", 0)
    Disable("Trigger_PneumaticTube_ToNorth")
  elseif (GetGlobal("MSN_GremlinStructure_WindMill") == 1) then
    SetPropertyFloat("ToNorth_ElevatorButton", "UsableRadius", 2)
    Enable("Trigger_PneumaticTube_ToNorth")
  end
  local fromCheckpoint = true
  if (tostring(MostRecentCheckpointCallback) ~= "UtilSouth3_LoadCheckpoint") then
    fromCheckpoint = false
  end
  if (not fromCheckpoint) then
    local introDialogue = function()
      wait(2)
      if (GetGlobal("MST_Gus_South3_Intro_Played") == 0) then
        FireSequence("PropRoom_Gus", "MST_Gus_South3_Intro")
      elseif (GetGlobal("MST_Gus_South3Return_Played") == 0) then
        FireSequence("PropRoom_Gus", "MST_Gus_South3Return")
      end
      return 
    end
    FireThread(introDialogue)
    if (MusicEventCount == 0) then
      Print("UtilSouth3_Intro: Started UTD music event")
      MusicPostEventOn(GetPlayer(), "Play_MX_UTD")
      MusicEventCount = 1
    end
  end
  SetCombatIntensityBias(-100)
  SetPlayStyleScoreBias(-100)
  Print("UtilSouth3_Intro: Disabled combat music")
  FireThread(StationaryCamera_UntilPlayerMoves)
  FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer2OrAI())
  if (fromCheckpoint == false) then
    UtilSouth3_SaveCheckPoint(target, Room)
  end
  FireThread(UtilSouth3_CheckStreaming, Room)
  return 
end
UtilSouth3_CheckStreaming = function(Room)
  local door = ("UtilSouth3_ExitDoor" .. Room)
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
UtilSouth3_SaveCheckPoint = function(target, Room)
  if (Room == nil) then
    Room = currentRoom
  end
  SaveCheckpoint(GetPlayer(), "UtilSouth3_LoadCheckpoint", ("CP_MickeySpawn" .. Room), ("CP_OswaldSpawn" .. Room))
  return 
end
UtilSouth3_LoadCheckpoint = function()
  ForEachEntityInGroup(Enable, "Trigger_Save")
  Print("Started UTD music state and disabled combat music from UtilSouth3 checkpoint")
  return 
end
SteamState = function(target, num, state)
  if (state == "Fire") then
    StartEmitters(("SteamSpray" .. num))
    ForEachEntityInGroup(Enable, ("SteamTrigger" .. num))
    wait(2.5)
    StopEmitters(("SteamSpray" .. num))
    ForEachEntityInGroup(Disable, ("SteamTrigger" .. num))
  elseif (state == "Off") then
    StopEmitters(("SteamSpray" .. num))
    ForEachEntityInGroup(Disable, ("SteamTrigger" .. num))
    TimerDisable(("SteamTimer" .. num))
    TimerReset(("SteamTimer" .. num))
  elseif (state == "Push") then
    Print("Steam Triggered")
    OswaldStreamAbort()
    local BulletDir = (GetPosition(target) - GetPosition(("SteamSpray" .. num)))
    BulletDir:normalize3()
    BulletDir = (BulletDir * 2000)
    ApplyImpulse(target, BulletDir.x, 0, BulletDir.z)
  end
  return 
end
UtilSouthRoom3_ReplaceBox = function(target, Room_num, Setup)
  if (Setup == nil) then
    Disable(target)
  else
    target = (target .. Room_num)
  end
  Print("######## UtilSouthRoom3_ReplaceBox")
  local PropBox = GetRelativePrefabEntity(target, ".PropellerBox")
  local SF_BoxReturn = (("BoxReturn" .. Room_num) .. "_SF")
  MoveToEntity(PropBox, GetRelativePrefabEntity(PropBox, ".PropellerBoxMarker"))
  if GetPrefabData(PropBox).PropellerActive then
    PropellerBox_Drop(PropBox)
  end
  DisableMotion(PropBox)
  wait(0.25)
  if (Setup == nil) then
    Enable(target)
  end
  EnableMotion(PropBox)
  SetParentEntity(PropBox, SF_BoxReturn)
  Wait(1)
  SetSplineFollowerInitialSpeed(SF_BoxReturn, 4.199999809265137)
  local SK1 = (("BoxReturn" .. Room_num) .. "_SK1")
  local SK2 = (("BoxReturn" .. Room_num) .. "_SK2")
  SplineFollower_StopAtPosition(SF_BoxReturn, SK1, SK2, 1)
  local Dispenser = (("BoxReturn" .. Room_num) .. "_Dispenser")
  if (GetPropertyInt(Dispenser, "Active Sequence ID") ~= 1) then
    AnimGBSequence(Dispenser, "rise")
  elseif (GetPropertyInt(Dispenser, "Active Sequence ID") == 1) then
    AnimGBSequence(Dispenser, "rise2")
  end
  Wait(0.75)
  ClearParent(PropBox)
  SetSplineFollowerInitialSpeed(SF_BoxReturn, 16)
  SplineFollower_StopAtPosition(SF_BoxReturn, SK1, SK2, 0)
  return 
end
UtilSouth3_PowerFan = function(target, obj, action)
  Print(("UtilSouth3_PowerFan: Powering " .. obj))
  if (obj == "Fan") then
    local fan = "mst_utilidors_01a_southroom3_art.MST_fan_02a_inert 01"
    Print(((("UtilSouth3_PowerFan: Powering " .. obj) .. " & State = ") .. action))
    if (action == "On") then
      SetPropertyInt(fan, "MaxRotationDegrees", 0)
      SetPropertyInt(fan, "MinRotationDegrees", 0)
      SetRotatorMaxSpeed(fan, 60)
    elseif (action == "Off") then
      SetRotatorMaxSpeed(fan, 0)
      if (obj == "FloatingPlatform") then
        local FloatingPlatform, FloatingPlatform = "PropRoom_FloatingPlatform", SetRotatorMaxSpeed
        if (action == "On") then
          FloatingPlatform = SetSplineFollowerInitialSpeed
          FloatingPlatform(FloatingPlatform, 3)
        elseif (action == "Off") then
          FloatingPlatform = SetSplineFollowerInitialSpeed
          FloatingPlatform(FloatingPlatform, 0)
        end
      end
    end
  elseif (obj == "FloatingPlatform") then
    local FloatingPlatform, FloatingPlatform = "PropRoom_FloatingPlatform", ("UtilSouth3_PowerFan: Powering " .. obj)
    if (action == "On") then
      FloatingPlatform = SetSplineFollowerInitialSpeed
      FloatingPlatform(FloatingPlatform, 3)
    elseif (action == "Off") then
      FloatingPlatform = SetSplineFollowerInitialSpeed
      FloatingPlatform(FloatingPlatform, 0)
    end
  end
  return 
end
local PrizeStingerVar = 0
UtilSouth3_OpenDoor = function(State, door_Num)
  DestroyEntity(("PlayerHintMarkers_Room" .. door_Num))
  if (State == "Hard") then
    SetGlobal("Util_QuestHealth", (GetGlobal("Util_QuestHealth") + 10))
    SetGlobal((("Util_WidgetRoom" .. door_Num) .. "State"), 2)
    if (PrizeStingerVar == 0) then
      DoStinger("UTD_StingerRoomPrize", 2)
      PrizeStingerVar = 1
      local chest = ("RedChest_Room" .. door_Num)
      Unhide(chest)
      GetPrefabData(chest).ChestDisabled = "False"
    end
  else
    SetGlobal((("Util_WidgetRoom" .. door_Num) .. "State"), 1)
  end
  AnimGBSequence(("UtilSouth3_ExitDoor" .. door_Num), "Anim")
  ActivateNavMeshObstacle(("UtilSouth3_ExitDoor" .. door_Num), false)
  SplineFollower_SetDisabled("Util_MainHallVaultExitDoor", false)
  Disable("OswaldBlocker_WidgetRoom")
  UtilSouth3_SaveCheckPoint(nil, door_Num)
  return 
end
local ResCamEnabled = true
UtilSouth3_KillAIAndRescuePlayer = function(_activator)
  if (1 < GetHealth(_activator)) then
    ClearAllCameraAttributes(_activator)
  end
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
  return 
end
UtilSouth3_DisableResCam = function()
  ResCamEnabled = false
  return 
end
