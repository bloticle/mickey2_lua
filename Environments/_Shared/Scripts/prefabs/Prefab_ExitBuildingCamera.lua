local DoorActivator = false
Prefab_EnterInterior_Ask = function(target, dir)
  if (IsAnySequencePlaying() == false) then
    if (_activator() == GetPlayer()) then
      DoorActivator = false
    else
      DoorActivator = true
    end
    if (dir == "Enter") then
      local data = GetPrefabData(target)
      if (data.StartsInactive == "False") then
        if (data.BeforeStreamHappensFunction ~= "None") then
          _G[data.BeforeStreamHappensFunction]()
        end
        Prefab_EnterInterior(target)
      else
        Print("__Starts inactive was false! This door should be deactive!")
        if (dir == "Exit") then
          Prefab_ExitInterior(target)
        end
      end
    elseif (dir == "Exit") then
      Prefab_ExitInterior(target)
    end
  end
  return 
end
Prefab_EnterInterior = function(target)
  Print("+_+_+_+_+_+_+_+_+ Prefab_EnterInterior()")
  local data = GetPrefabData(target)
  if (data.StartsInactive ~= "HardLoad") then
    AudioPostEventOn(GetPlayer(), "Play_sfx_Door_Wood_InteriorOpen")
    RestrictCutSceneInput()
    TogglePlayerIconSubstitute(DoorActivator, true)
    StartFadeOut(0.699999988079071)
    wait(0.699999988079071)
    if (data.InteriorToStream ~= "None") then
      if (data.StreamTime == "DuringFade") then
        StreamInterior(nil, data.InteriorToStream)
      end
    end
    ReplaceMusicStateOverride("IntFadeOut")
    Print("Interior music fade out")
    AudioPostEventOn(GetPlayer(), "Set_Volume_Enter_Interior")
    if (data.Stop3DMusicBeforeFade ~= "Music_Event") then
      Print(("__Will stop 3d music event: " .. tostring(data.Stop3DMusicBeforeFade)))
      AudioPostEventOn(GetPlayer(), data.Stop3DMusicBeforeFade)
    end
    wait(0.699999988079071)
    if (data.InteriorToStream ~= "None") then
      if (data.StreamTime == "AfterFade") then
        StreamInterior(nil, data.InteriorToStream)
      end
    end
    WaitForLevelLoad()
    wait(0.009999999776482582)
    TeleportToEntity(GetPlayer(), GetRelativePrefabEntity(target, ".EnterBuildingPosition_Player2"), true, true)
    TeleportToEntity(GetPlayer2OrAI(), GetRelativePrefabEntity(target, ".EnterBuildingPosition"), true, true)
    wait(0.009999999776482582)
    local oswaldFacing = GetFacing(GetPlayer())
    OverrideSpawnTransform(PLAYER_TWO, GetPosition(GetRelativePrefabEntity(target, ".EnterBuildingPosition_Player2")), oswaldFacing)
  end
  CameraReset()
  wait(0.009999999776482582)
  if (data.is3DInterior == "False") then
    local Cam_Override1, Cam_Override1 = GetRelativePrefabEntity(target, ".ExitBuildingOverride1"), target
    Cam_Override1 = GetRelativePrefabEntity
    Cam_Override1 = Cam_Override1(target, ".ExitBuildingOverride2")
    local Cam_Override2 = target
    Cam_Override2 = SetPropertyInt
    Cam_Override2(Cam_Override1, "HintEntityActive", 1)
    Cam_Override2 = SetPropertyInt
    Cam_Override2(Cam_Override1, "SideScrollActive", 2)
    Cam_Override2 = SetPropertyInt
    Cam_Override2(Cam_Override1, "HintEntityActive", 1)
    Cam_Override2 = SetPropertyInt
    Cam_Override2(Cam_Override1, "SideScrollActive", 2)
    Cam_Override2 = SetPropertyEntity
    Cam_Override2(Cam_Override1, "SideScrollSecondaryTarget", GetPlayerOrAiCameraTarget(PLAYER_TWO))
    Cam_Override2 = SetCameraAttributesForPlayer
    Cam_Override2(Cam_Override1, GetPlayer())
    Cam_Override2 = SetConfigVariableString
    Cam_Override2(GetPlayer(), "CameraFieldOfView", 0)
    Cam_Override2 = Wait
    Cam_Override2(0.03999999910593033)
    Cam_Override2 = SetPropertyEntity
    Cam_Override2(Cam_Override1, "SideScrollSecondaryTarget", GetPlayerOrAiCameraTarget(PLAYER_ONE))
    Cam_Override2 = SetCameraAttributesForPlayer
    Cam_Override2(Cam_Override1, GetPlayerOrAI(PLAYER_TWO))
    Cam_Override2 = SetConfigVariableString
    Cam_Override2(GetPlayer2OrAI(), "CameraFieldOfView", 0)
    Cam_Override2 = Enable2DSetup
    Cam_Override2("interior")
    Cam_Override2 = EnableSplitScreen
    Cam_Override2(false)
  end
  if (data.EnterFunction ~= "None") then
    Print((("+_+_+_+_+_+_+_+_+ Prefab_EnterInterior() EnterFunction = " .. data.EnterFunction) .. " IF THE SCREEN REMAINS BLACK, YOU FORGOT Prefab_EnterInterior_FadeIn()"))
    if (data.EnterFunctionParam ~= "None") then
      if (data.EnterFunctionParam == "NoFireThread") then
        Print("+_+_+_+_+_+_+_+_+ Prefab_EnterInterior() EnterFunctionParam == NoFireThread so this is a continuous Thread.")
        _G[data.EnterFunction](target, data.ExitFunctionParam)
      else
        Print(("+_+_+_+_+_+_+_+_+ Prefab_EnterInterior() - Firing EnterFunction with extra param: " .. tostring(data.EnterFunctionParam)))
        FireThread(_G[data.EnterFunction], target, data.ExitFunctionParam)
        FireThread(_G[data.EnterFunction], target)
        Prefab_EnterInterior_FadeIn()
      end
    else
      FireThread(_G[data.EnterFunction], target)
      Prefab_EnterInterior_FadeIn()
    end
  else
    Prefab_EnterInterior_FadeIn()
  end
  TimerReset(GetRelativePrefabEntity(target, ".SpeechTimer"))
  TimerEnable(GetRelativePrefabEntity(target, ".SpeechTimer"))
  return 
end
Prefab_EnterInterior_FadeIn = function(NoHUD)
  wait(0.5)
  Print("Start Fade In")
  if (NoHUD == nil) then
    StartFadeInNoHUD(0.4000000059604645)
  else
    StartFadeIn(0.4000000059604645)
  end
  AudioPostEventOn(GetPlayer(), "Play_sfx_Door_Wood_InteriorClose")
  wait(0.5)
  UnrestrictCutSceneInput()
  return 
end
Prefab_ExitInterior = function(exitprefab)
  local data = GetPrefabData(exitprefab)
  TimerDisable(GetRelativePrefabEntity(exitprefab, ".SpeechTimer"))
  RestrictCutSceneInput()
  AudioPostEventOn(GetPlayer(), "Play_sfx_Door_Wood_InteriorOpen")
  StartFadeOut(0.5)
  ReplaceMusicStateOverride("IntFadeOut")
  Print("Interior music fade out")
  TogglePlayerIconSubstitute(false, false)
  if (data.CameraFadeAfterLevelLoad == "True") then
    wait(0.5)
  end
  AudioPostEventOn(GetPlayer(), "Reset_Volume_Exit_Interior")
  if (data.CameraFadeAfterLevelLoad == "False") then
    wait(0.5)
    FireThread(Prefab_Exit_Building_Camera, exitprefab)
    wait(0.30000001192092896)
  end
  if (data.InteriorToStream ~= "None") then
    local levelName = LevelManager_GetCurrentLevelName()
    ExittedBuildingInteriorLoaded = ((levelName .. ".") .. data.InteriorToStream)
  end
  if (data.is3DInterior == "False") then
    Disable2DSetup("interior")
  end
  EnableSplitScreen(true)
  if (data.ExitFunction ~= "None") then
    Print((("+_+_+_+_+_+_+_+_+ Prefab_ExitInterior() ExitFunction = " .. data.ExitFunction) .. " IF THE SCREEN REMAINS BLACK, YOU FORGOT Prefab_ExitInterior_FadeIn()"))
    if (data.ExitFunctionParam ~= "None") then
      Print(("__Firing ExitFunction with extra param: " .. tostring(data.ExitFunctionParam)))
      FireThread(_G[data.ExitFunction], exitprefab, data.ExitFunctionParam)
    else
      FireThread(_G[data.ExitFunction], exitprefab)
      Prefab_ExitInterior_FadeIn()
    end
  else
    Prefab_ExitInterior_FadeIn()
  end
  return 
end
ExittedBuildingInteriorLoaded = ""
Prefab_ExitInterior_FadeIn = function(WaitLevelLoad, exitprefab)
  LevelManager_SetZoneStatusUnloaded(tostring(ExittedBuildingInteriorLoaded))
  if (WaitLevelLoad ~= nil) then
    WaitForLevelLoad()
    wait(0)
  end
  AudioPostEventOn(GetPlayer(), "Play_sfx_Door_Wood_InteriorClose")
  if (exitprefab ~= nil) then
    local data = GetPrefabData(exitprefab)
    if (data.CameraFadeAfterLevelLoad == "True") then
      FireThread(Prefab_Exit_Building_Camera, exitprefab)
      wait(0.30000001192092896)
    end
    Print(("__SkipExitFade: " .. tostring(data.SkipExitFade)))
    if (data.SkipExitFade == "True") then
      return 
    else
      StartFadeIn()
      wait(0.5)
      UnrestrictCutSceneInput()
      StartFadeIn()
      wait(0.5)
      UnrestrictCutSceneInput()
    end
  else
    StartFadeIn()
    wait(0.5)
    UnrestrictCutSceneInput()
  end
  return 
end
Prefab_Exit_Building_Camera = function(target)
  local data = GetPrefabData(target)
  wait(0.009999999776482582)
  ClearAllCameraAttributes(nil, 0)
  wait(0.009999999776482582)
  if (data.TeleportPlayer == "True") then
    TeleportToEntity(GetPlayer(), GetRelativePrefabEntity(target, ".ExitBuildingPosition"), true, true)
    TeleportToEntity(GetPlayer2OrAI(), GetRelativePrefabEntity(target, ".ExitBuildingPosition_Player2"), true, true)
    local oswaldFacing = GetFacing(GetPlayer())
    OverrideSpawnTransform(PLAYER_TWO, GetPosition(GetRelativePrefabEntity(target, ".ExitBuildingPosition_Player2")), oswaldFacing)
  end
  Wait(0.009999999776482582)
  CameraReset()
  Wait(0.009999999776482582)
  CameraReset()
  ClearOverrideSpawnTransform(PLAYER_TWO)
  local Cam_Override1, Cam_Override1 = GetRelativePrefabEntity(target, ".ExitBuildingOverride1"), target
  Cam_Override1 = GetRelativePrefabEntity
  Cam_Override1 = Cam_Override1(target, ".ExitBuildingOverride2")
  local Cam_Override2 = target
  Cam_Override2 = data.is3DInterior
  if (Cam_Override2 == "False") then
    Cam_Override2 = SetPropertyInt
    Cam_Override2(Cam_Override1, "SideScrollActive", 1)
    Cam_Override2 = SetPropertyInt
    Cam_Override2(Cam_Override1, "HintEntityActive", 2)
    Cam_Override2 = SetPropertyInt
    Cam_Override2(Cam_Override1, "SideScrollActive", 1)
    Cam_Override2 = SetPropertyInt
    Cam_Override2(Cam_Override1, "HintEntityActive", 2)
  end
  Cam_Override2 = Print
  Cam_Override2("+_+_+_+_+_+_+_+_+ Prefab_Exit_Building_Camera() Setting prefab exit building camera")
  Cam_Override2 = SetCameraAttributesForPlayer
  Cam_Override2(Cam_Override1, GetPlayer())
  Cam_Override2 = SetCameraAttributesForPlayer
  Cam_Override2(Cam_Override1, GetPlayer2OrAI())
  Cam_Override2 = data.StationaryCamera_UntilPlayerMoves
  if (Cam_Override2 == "True") then
    Cam_Override2 = FireThread
    Cam_Override2(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer())
    Cam_Override2 = GetPlayer2
    Cam_Override2 = Cam_Override2()
    if (Cam_Override2 ~= nil) then
      Cam_Override2 = FireThread
      Cam_Override2(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer2())
    else
      Cam_Override2 = FireThread
      Cam_Override2(StationaryCamera_UntilPlayerMoves, nil, nil, GetOswaldAI())
    end
  end
  return 
end
Prefab_Animate_Doors = function(target, action)
  local data = GetPrefabData(target)
  local door = GetRelativePrefabEntity(target, ".EnterDoors")
  if (data.DoorState == "open") then
    if (data.EnterDoors[1] ~= "OpenAnim") then
      if (data.StartsInactive == "False") then
        if (data.AnimRunning == 0) then
          Print("+_+_+_+_+_+_+_+_+ Prefab_Exit_Building_Camera() Opening the prefab doors")
          data.AnimRunning = 1
          AnimGBSequence(door, data.EnterDoors[1], true)
          wait(1)
          data.AnimRunning = 0
        end
      end
    end
  else
    Print("+_+_+_+_+_+_+_+_+ Prefab_Exit_Building_Camera(): Opening - Door if Check not successful")
  end
  if (data.DoorState == "close") then
    if (data.EnterDoors[2] ~= "CloseAnim") then
      if (data.StartsInactive == "False") then
        if (data.AnimRunning == 0) then
          if (data.PeopleNearDoor == 0) then
            Print("+_+_+_+_+_+_+_+_+ Prefab_Exit_Building_Camera() Closing the prefab doors")
            data.AnimRunning = 1
            AnimGBSequence(door, data.EnterDoors[2], true)
            wait(1)
            data.AnimRunning = 0
          end
        end
      end
    end
  else
    Print("+_+_+_+_+_+_+_+_+ Prefab_Exit_Building_Camera(): Closing - Door if Check not successful")
  end
  return 
end
Prefab_DoorState_Increment = function(target)
  local data = GetPrefabData(target)
  if (data.PeopleNearDoor == 0) then
    Print("__People near door!")
    data.PeopleNearDoor = 1
    data.DoorState = "open"
  end
  return 
end
Prefab_DoorState_Decrement = function(target)
  local data = GetPrefabData(target)
  Print("__People gone from door!")
  data.PeopleNearDoor = 0
  data.DoorState = "close"
  Prefab_Animate_Doors(target)
  return 
end
Prefab_Reset_DoorState = function(reg_0)
end
Prefab_Activate_Doors = function(target, action)
  local data = GetPrefabData(target)
  local enterUsableRadius = GetRelativePrefabEntity(target, ".EnterInterior")
  if (action == "open") then
    data.StartsInactive = "False"
    SetPropertyFloat(enterUsableRadius, "UsableRadius", data.EnterDistance)
  elseif (action == "close") then
    data.StartsInactive = "True"
    SetPropertyFloat(enterUsableRadius, "UsableRadius", 0)
  end
  return 
end
Prefab_StartInactiveCheck = function(target)
  local data = GetPrefabData(target)
  local enterUsableRadius = GetRelativePrefabEntity(target, ".EnterInterior")
  if (GetPropertyFloat(enterUsableRadius, "UsableRadius") == 0) then
    data.StartsInactive = "True"
  elseif (0 < GetPropertyFloat(enterUsableRadius, "UsableRadius")) then
    data.StartsInactive = "False"
  end
  return 
end
Prefab_ExitInterior_CheckDialogPlaying = function(target)
  local data = GetPrefabData(target)
  if (IsAnySequencePlaying() == true) then
    if (data.TriggerUsableRadius == -1) then
      Print("Trigger Setting to 0!")
      data.TriggerUsableRadius = tonumber(GetPropertyFloat(GetRelativePrefabEntity(target, ".ExitInterior"), "UsableRadius"))
      SetPropertyFloat(GetRelativePrefabEntity(target, ".ExitInterior"), "UsableRadius", 0)
    end
  elseif (data.TriggerUsableRadius ~= -1) then
    Print((("Trigger Setting to " .. data.TriggerUsableRadius) .. "!"))
    SetPropertyFloat(GetRelativePrefabEntity(target, ".ExitInterior"), "UsableRadius", data.TriggerUsableRadius)
    data.TriggerUsableRadius = -1
  end
  return 
end

