SouthElevatorStatus = "Up"
NorthElevatorStatus = "Down"
Util_DoorOpenCloseTracker = 0
Util_Elevator_NorthWallConnectorVar = 0
Util_Elevator_SouthWallConnectorVar = 0
Util_ElevatorVarFlip = function(target, level)
  Print("Util_ElevatorVarFlip")
  if (GetGlobal("Util_NorthElevatorStatus") == 1) then
    Util_Elevator_NorthWallConnectorVar = 1
  end
  if (GetGlobal("Util_SouthElevatorStatus") == 1) then
    Util_Elevator_SouthWallConnectorVar = 1
  end
  Util_ElevatorAlwaysSetup(target, level)
  return 
end
Util_ElevatorAlwaysSetup = function(target, level)
  Print("Util_ElevatorAlwaysSetup")
  if (level == "North") then
    if (Util_Elevator_NorthWallConnectorVar == 1) then
      SetSplineFollowerInitialSpeed("Util_North01_RightWindow", 100)
      SplineFollower_StopAtPosition("Util_North01_RightWindow", "Util_NorthRightLowerKnot", "Util_NorthRightUpperKnot", 1)
      Wait(0)
      SetSplineFollowerInitialSpeed("Util_North01_LeftWindow", 100)
      SplineFollower_StopAtPosition("Util_North01_LeftWindow", "Util_NorthLeftLowerKnot", "Util_NorthLeftUpperKnot", 1)
    end
  elseif (level == "South") then
    if (Util_Elevator_SouthWallConnectorVar == 1) then
      SetSplineFollowerInitialSpeed("Util_South01_RightWindow", 100)
      SplineFollower_StopAtPosition("Util_South01_RightWindow", "Util_SouthRightLowerKnot", "Util_SouthRightUpperKnot", 1)
      Wait(0)
      SetSplineFollowerInitialSpeed("Util_South01_LeftWindow", 100)
      SplineFollower_StopAtPosition("Util_South01_LeftWindow", "Util_SouthLeftLowerKnot", "Util_SouthLeftUpperKnot", 1)
    end
  end
  return 
end
MST_Airlock_TurnStyleUp = function(target, level)
  Print("#################### TurnstyleUp reached")
  Util_DoorOpenCloseTracker = 1
  SetPropertyFloat(("ElevatorTurnstyle" .. level), "Acceleration", 5000)
  if (GetGlobal("Util_NorthElevatorStatus") == 0) then
    SetGlobal("Util_NorthElevatorStatus", 1)
  end
  if (GetGlobal("Util_SouthElevatorStatus") == 0) then
    SetGlobal("Util_SouthElevatorStatus", 1)
  end
  ClearAllCameraAttributes()
  SetPropertyInt("ElevatorTurnstyleNorth", "AllowedDirections", "1")
  SetPropertyInt("ElevatorTurnstyleSouth", "AllowedDirections", "1")
  OswaldStartFollowAction()
  Wait(0.10000000149011612)
  SetPropertyFloat(("ElevatorTurnstyle" .. level), "Acceleration", 6)
  Wait(0.800000011920929)
  WaitForLevelLoad()
  AnimGBSequence((("Util" .. level) .. "_BlastDoor"), "Anim")
  SetPropertyFloat("Util_ElevatorExitTrigger", "UsableRadius", 2)
  if (level == "North") then
    TeleportToEntity("NorthAirLock_Closet", "NorthAirLock_OriginMarker")
  elseif (level == "South") then
    TeleportToEntity("SouthAirLock_Closet", "SouthAirLock_OriginMarker")
  end
  Enable("UtilNorthAirlock_DoorTrigger")
  AudioPostEventOn(GetPlayer(), "Stop_MX_UTD")
  return 
end
MST_Airlock_TurnStyleDown = function(target, level)
  Print("MST_Airlock_TurnStyleDown")
  Util_DoorOpenCloseTracker = 1
  ForEachEntityInGroup(Hide, "Util_TempMSExit")
  SetPropertyFloat(("ElevatorTurnstyle" .. level), "Acceleration", 5000)
  if (GetGlobal("Util_NorthElevatorStatus") == 1) then
    SetGlobal("Util_NorthElevatorStatus", 0)
  end
  if (GetGlobal("Util_SouthElevatorStatus") == 1) then
    SetGlobal("Util_SouthElevatorStatus", 0)
  end
  ClearAllCameraAttributes()
  SetPropertyInt(("ElevatorTurnstyle" .. level), "AllowedDirections", "0")
  Wait(0.10000000149011612)
  SetPropertyFloat(("ElevatorTurnstyle" .. level), "Acceleration", 6)
  SetPropertyFloat("Util_ElevatorExitTrigger", "UsableRadius", 0)
  OswaldStartFollowAction()
  Wait(0.800000011920929)
  WaitForLevelLoad()
  if (level == "North") then
    TeleportToEntity("NorthAirLock_Closet", "Util_ClosetStorageMarker")
    Disable("Util_NorthGearCameraTrigger")
    Enable("Util_SouthGearCameraTrigger")
  elseif (level == "South") then
    TeleportToEntity("SouthAirLock_Closet", "Util_ClosetStorageMarker")
    Enable("Util_NorthGearCameraTrigger")
    Disable("Util_SouthGearCameraTrigger")
  end
  Print("#################### TurnstyleDown PART 2 reached")
  AnimGBSequence((("Util" .. level) .. "_BlastDoor"), "Anim")
  Enable("UtilNorthAirlock_DoorTrigger")
  Enable("Util_SouthElevatorDoorTrigger")
  return 
end
MST_AirlockResetTurnstile = function(target)
  Print("########## Turnstyle Reset Bar function")
  StartRotateToPosition("ElevatorTurnstyleNorth", 0)
  Wait(2)
  StopRotateToPosition("ElevatorTurnstyleNorth", 0)
  return 
end
MSN_LoadMSNorth_Prompt = function()
  ForceSequence("Util_GusExitConvoMarker", "MST_Gus_ExitElevators", 1)
  return 
end
MSN_LoadMSSouth_Prompt = function()
  ForceSequence("Util_GusExitConvoMarker", "MST_Gus_ExitElevators02", 1)
  return 
end
MST_LoadMeanStreets = function(target, level)
  Print("#### MST_LoadMeanStreets")
  StartFadeOut(0.5)
  wait(0.75)
  WaitForLevelLoad()
  if (level == "North") then
    if (2 <= GetGlobal("MSN_VisitNumber")) then
      Print("#### MST_LoadMeanStreets CHECK 1")
      LevelManager_SetCurrentState((("MeanStreet_" .. level) .. ".Visit_2"))
      if (GetGlobal("MSN_VisitNumber") == 1) then
        Print("#### MST_LoadMeanStreets CHECK 2")
        SetGlobal("MSN_VisitNumber", 2)
      end
    end
  elseif (level == "North") then
    if (GetGlobal("MSN_VisitNumber") == 1) then
      Print("#### MST_LoadMeanStreets CHECK 3")
      LevelManager_SetCurrentState((("MeanStreet_" .. level) .. ".Visit_1"))
    end
  elseif (level == "South") then
    Print("#### MST_LoadMeanStreets CHECK 4")
    LevelManager_SetCurrentState((("MeanStreet_" .. level) .. ".Visit1"))
  end
  WaitForLevelLoad()
  Print("#### MST_LoadMeanStreets CHECK 5")
  TeleportToEntity(GetPlayer(), (("MS" .. level) .. "_UTLexit_MickeySpawn"))
  TeleportToEntity(GetPlayer2OrAI(), (("MS" .. level) .. "_UTLexit_OswaldSpawn"))
  Wait(0)
  if (level == "North") then
    Print("#### MST_LoadMeanStreets CHECK 6")
    LevelManager_SetZoneStatusUnloaded("meanstreetsutilidors.northairtoms")
  elseif (level == "South") then
    Print("#### MST_LoadMeanStreets CHECK 7")
    LevelManager_SetZoneStatusUnloaded("meanstreetsutilidors.southairtoms")
  end
  return 
end
MSN_LoadUtilidors_NorthElevator = function()
  SetGlobal("MSN_GusHintVar", 0)
  NorthElevatorStatus = "Up"
  Print("########## North Elevator Level Load")
  StartFadeOut(0.5)
  wait(0.75)
  LevelManager_SetCurrentState("MeanStreetsUtilidors.StreamNorthAirLock")
  StreamInterior(nil, "NorthAirLock")
  WaitForLevelLoad()
  Print("########## North Elevator Level Load Teleporting")
  TeleportToEntity(GetPlayer(), "UtilNorthAirlock_MickeyStart")
  TeleportToEntity(GetPlayer2OrAI(), "UtilNorthAirlock_OswaldStart")
  SetPropertyInt("ElevatorTurnstyleNorth", "AllowedDirections", "0")
  CameraReset()
  wait(0.009999999776482582)
  StartFadeIn(0.5)
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    LevelManager_SetCurrentState("MeanStreetsUtilidors.TransitionEp1")
  elseif (GetGlobal("EM2_EpisodeCheck") == 2) then
    LevelManager_SetCurrentState("MeanStreetsUtilidors.TransitionEp2")
  elseif (3 <= GetGlobal("EM2_EpisodeCheck")) then
    LevelManager_SetCurrentState("MeanStreetsUtilidors.TransitionEp3")
  end
  return 
end
Util_SetElevators_Down = function()
  SetGlobal("Util_NorthElevatorStatus", 0)
  SetGlobal("Util_SouthElevatorStatus", 0)
  SetPropertyInt("ElevatorTurnstyleNorth", "AllowedDirections", "1")
  SetPropertyInt("ElevatorTurnstyleSouth", "AllowedDirections", "1")
  Util_DoorOpenCloseTracker = 1
  return 
end
Util_SetElevators_Up = function()
  SetGlobal("Util_NorthElevatorStatus", 1)
  SetGlobal("Util_SouthElevatorStatus", 1)
  SetPropertyInt("ElevatorTurnstyleNorth", "AllowedDirections", "0")
  SetPropertyInt("ElevatorTurnstyleSouth", "AllowedDirections", "0")
  return 
end
Util_LoadMainHall = function()
  local global = GetGlobal("MST_GremlinStructure_Entered")
  Print(("Util_LoadMainHall: global = " .. global))
  if (global == 0) then
    local CurrentState = tostring(LevelManager_GetCurrentState())
    Print(((("Util_LoadMainHall: global = " .. global) .. "  LevelManager_GetCurrentState()  = ") .. CurrentState))
    if (CurrentState == "meanstreetsutilidors.rotatebridges_hardload") then
      global = 1
    elseif (CurrentState == "meanstreetsutilidors.propellerbox_hardload") then
      global = 2
    elseif (CurrentState == "meanstreetsutilidors.vault_hardload") then
      global = 3
    end
  end
  if (global ~= -10) then
    StartFadeOut(0)
  end
  if (3 < GetGlobal("EM2_EpisodeCheck")) then
    LevelManager_SetCurrentState("MeanStreetsUtilidors.TransitionEp3")
  else
    LevelManager_SetCurrentState(("MeanStreetsUtilidors.TransitionEp" .. GetGlobal("EM2_EpisodeCheck")))
  end
  if (global ~= -10) then
    OswaldStopMovingAction()
    PlayerPlace(global)
    CameraReset()
    if (global ~= 7) then
      if (global ~= 0) then
        ForEachEntityInGroup(Enable, "Trigger_Save")
      end
    else
      OswaldStartMovingAction()
    end
  end
  return 
end
PlayerPlace = function(global)
  Print(("PlayerPlace: global = " .. global))
  if (global == 0) then
    TeleportToEntity(GetPlayer(), "MickeyNorthAirlock")
    TeleportToEntity(GetPlayer2OrAI(), "OswaldNorthAirlock")
  elseif (global == 7) then
    TeleportToEntity(GetPlayer(), "MickeySouthAirlock")
    TeleportToEntity(GetPlayer2OrAI(), "OswaldSouthAirlock")
  elseif (4 <= global) then
    TeleportToEntity(GetPlayer(), "MickeySpawn1")
    TeleportToEntity(GetPlayer2OrAI(), "OswaldSpawn1")
  elseif (global < 4) then
    TeleportToEntity(GetPlayer(), "MickeySpawn2")
    TeleportToEntity(GetPlayer2OrAI(), "OswaldSpawn2")
  end
  SetGlobal("MST_GremlinStructure_Entered", -10)
  return 
end

