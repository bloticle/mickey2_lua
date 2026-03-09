OsTown_Setup_Shared = function(state)
  Print("*_*_*_*_*_*_*_*_*_*@@@@ OsTown_Setup_Shared()")
  local customFadeIn = "No"
  if (state ~= nil) then
    if (state == "GagFactoryLoad") then
      customFadeIn = state
      state = "Checkpoint"
      if IsValidHandle("ProjFromMSNorth") then
        GetPrefabData("ProjFromMSNorth").MapLoad_SetupPosition = "IgnoreMe"
      end
    end
  else
    state = "Checkpoint"
    if IsValidHandle("ProjFromMSNorth") then
      GetPrefabData("ProjFromMSNorth").MapLoad_SetupPosition = "IgnoreMe"
    end
  end
  if (customFadeIn ~= "GagFactoryLoad") then
    Print("*_*_*_*_*_*_*_*_*_*@@@@ OsTown_Setup_Shared(): customFadeIn~=GagFactoryLoad - Starting FadeOut(0)")
    StartFadeOut(0)
    Wait(0)
  end
  AudioPostEventOn(GetPlayer(), "Play_sfx_amb_OST")
  local location = "Surface"
  if (LevelManager_GetCurrentState() == "ost_center.main") then
    Print("if LevelManager_GetCurrentState() == ost_center.main then")
    Bark(GetPlayer(), "Test Bark no icon or title.", 30)
    AudioSetState(GetPlayer(), "OST_Amb_State", "OST_Outside")
    if LevelManager_HasZoneFinishedStreaming("ost_center.ost_int_dec_access") then
      if IsValidHandle("SF_Grate_Layer1") then
        while true do
          if (not (LevelManager_WaitingForStreamingSync() == false)) then
            break
          end
          Wait(0.05000000074505806)
        end
        location = "DECAccess"
        AudioSetState(GetPlayer(), "OST_Amb_State", "OST_DecAccess")
      end
    elseif LevelManager_HasZoneFinishedStreaming("ost_center.ost_int_maintaccess") then
      if IsValidHandle("SF_Grate_Layer2") then
        while true do
          if (not (LevelManager_WaitingForStreamingSync() == false)) then
            break
          end
          Wait(0.05000000074505806)
        end
        location = "MaintenanceAccess"
        AudioSetState(GetPlayer(), "OST_Amb_State", "OST_MaintAccess")
      end
    elseif LevelManager_HasZoneFinishedStreaming("ost_center.ost_int_maintoverflow") then
      if IsValidHandle("SF_Grate_Layer3") then
        while true do
          if (not (LevelManager_WaitingForStreamingSync() == false)) then
            break
          end
          Wait(0.05000000074505806)
        end
        location = "MaintenanceOverflow"
        AudioSetState(GetPlayer(), "OST_Amb_State", "OST_MaintOverflow")
      end
    end
  end
  Print(("*_*_*_*_*_*_*_*_*_*@@@@ OsTown_Setup_Shared: location = " .. location))
  if (GetGlobal("OST_OswaldStatueState") < 10) then
    ForEachEntityInGroup(ForceSketched, "OST_MickeysHouse")
    Prefab_Activate_Doors("EnterInterior_Mickey", "close")
    if (10 <= GetGlobal("OST_Pump1Status")) then
      ForEachEntityInGroup(ForceSketched, "OST_OrtensiasHouse")
      ForEachEntityInGroup(ForceSketched, "OST_ClarabellesHouse")
      Prefab_Activate_Doors("EnterInterior_Ortensia", "close")
      Prefab_Activate_Doors("EnterInterior_Clarabelle", "close")
      ForEachEntityInGroup(Enable, "OST_Center_TriggerDamageBase_ThinnerSpray_OrtensiaHouse")
      ForEachEntityInGroup(Enable, "OST_Center_TriggerDamageBase_ThinnerSpray_ClaraHouse")
    end
  end
  if (0 < GetGlobal("OST_Center_PoolLowered")) then
    SetPropertyFloat("OST_Grate_Outside_Turnstile", "Activate Radius", 2)
    DestroyEntity("OST_Pool")
    ForEachEntityInGroup(DestroyEntity, "OST_Pool_Collision")
  end
  local superPlaced = false
  local pumpsPlaced = {0, 0, 0}
  local (for index), (for limit), (for step) = 1, 3, 1
  for i = (for index), (for limit), (for step) do
    local global_PumpStatus = GetGlobal((("OST_Pump" .. i) .. "Status"))
    if (global_PumpStatus == 0) then
      if (GetGlobal("OST_PumpPlaced") == 1) then
        SetHealth(("PumpMachine" .. i), 10)
        SplineFollower_SetDisabled(("PumpMachine" .. i), true)
        EnableMotion(("PumpMachine" .. i))
        Unhide(("OST_Center_FXImported_ChargedPumpMachine0" .. i))
        StartEmitters(("OST_Center_FXImported_ChargedPumpMachine0" .. i))
        AudioPostEventOn(("OST_Center_FXImported_ChargedPumpMachine0" .. i), "Play_sfx_teslacoil")
      else
        Print("Pump was SuperCharged but not placed, resetting global since the pump will have lost its Charge")
        SetGlobal((("OST_Pump" .. i) .. "Status"), -1)
        if (0 < global_PumpStatus) then
          local locNum = global_PumpStatus
          if (9 < global_PumpStatus) then
            Print(((("Pump" .. i) .. " is placed AND Super Charged: global_PumpStatus = ") .. tostring(global_PumpStatus)))
            locNum = (global_PumpStatus / 10)
            superPlaced = true
          elseif (3 < global_PumpStatus) then
            if (global_PumpStatus < 7) then
              Print(((("Pump" .. i) .. " is placed AND Charged: global_PumpStatus = ") .. tostring(global_PumpStatus)))
              locNum = (global_PumpStatus - 3)
              AnimGBSequence(("PumpMachine" .. i), "on")
              FireThread(Prefab_OswaldElectricSwitch_ChangeState, ("OST_OswaldSwitchTimersLogicTimer" .. locNum), "FullyCharged")
            end
          else
            Print((("Pump" .. i) .. " is only placed in location"))
          end
          Print(("locNum = " .. tostring(locNum)))
          pumpsPlaced[locNum] = 1
          DisableMotion(("PumpMachine" .. i))
          DisableComponent(("PumpMachine" .. i), "Usable")
          StopEmitters(("OST_Pump_ThinnerFX" .. locNum))
          Disable(("Trigger_PumpFXDamage" .. locNum))
        end
      end
    elseif (0 < global_PumpStatus) then
      local locNum = global_PumpStatus
      if (9 < global_PumpStatus) then
        Print(((("Pump" .. i) .. " is placed AND Super Charged: global_PumpStatus = ") .. tostring(global_PumpStatus)))
        locNum = (global_PumpStatus / 10)
        superPlaced = true
      elseif (3 < global_PumpStatus) then
        if (global_PumpStatus < 7) then
          Print(((("Pump" .. i) .. " is placed AND Charged: global_PumpStatus = ") .. tostring(global_PumpStatus)))
          locNum = (global_PumpStatus - 3)
          AnimGBSequence(("PumpMachine" .. i), "on")
          FireThread(Prefab_OswaldElectricSwitch_ChangeState, ("OST_OswaldSwitchTimersLogicTimer" .. locNum), "FullyCharged")
        end
      else
        Print((("Pump" .. i) .. " is only placed in location"))
      end
      Print(("locNum = " .. tostring(locNum)))
      pumpsPlaced[locNum] = 1
      DisableMotion(("PumpMachine" .. i))
      DisableComponent(("PumpMachine" .. i), "Usable")
      StopEmitters(("OST_Pump_ThinnerFX" .. locNum))
      Disable(("Trigger_PumpFXDamage" .. locNum))
    end
  end
  if superPlaced then
    Print("Super Charge Pump placed, so lets wreck some things")
    local (for index), (for limit), (for step) = 1, 3, 1
    for i = (for index), (for limit), (for step) do
      if (pumpsPlaced[i] == 0) then
        Print("Found a Pump station that doesnt have a pump on it so messing it up.")
        (for index) = i
        StopEmitters(("OST_Pump_ThinnerFX" .. (for index)))
        (for index) = i
        StartEmitters(("OST_Pump_ThinnerFXHigh" .. (for index)))
        (for index) = i
        (for index) = "Play_sfx_Geyser_lp"
        AudioPostEventOn(("ost_center_art_01.OST_center_01a_pumpPad_01a 0" .. (for index)), (for index))
        local trigger = ("Trigger_PumpFXDamage" .. i)
        (for index) = trigger
        local triggerLoc = GetPosition((for index))
        (for index) = Enable
        (for limit) = trigger
        (for index)((for limit))
        (for index) = SetTransformation
        (for limit) = trigger
        (for step) = vector4
        i = triggerLoc.x
        trigger = triggerLoc.y
        trigger = (trigger + 1.5)
        triggerLoc = triggerLoc.z
        (for step) = (for step)(i, trigger, triggerLoc)
        i = vector4
        trigger = 0
        triggerLoc = 0
        i = i(trigger, triggerLoc, 0)
        (for index)((for limit), (for step), i)
      end
    end
  end
  FireThread(OST_Setup_Sky_Props)
  FireThread(OST_Moody_Photo1_MoodysHouse, "OST_MoodysHouse")
  if (GetGlobal("OST_TrainStationFairied") == 0) then
    SetGlobal("OST_TrainStationFairied", 0)
    ForEachEntityInGroup(AnimGBSequence, "OST_Center_trainStation_Limbs", "rest")
  end
  if (10 <= GetGlobal("OST_OswaldStatueState")) then
    ForEachEntityInGroup(Disable, "Triggers_PumpFXDamage")
    local (for index), (for limit), (for step) = 1, 3, 1
    for i = (for index), (for limit), (for step) do
      StopEmitters(("OST_Pump_ThinnerFX" .. i))
      StopEmitters(("OST_Pump_ThinnerFXHigh" .. i))
    end
  end
  if (location == "Surface") then
    MusicPostEventOn(GetPlayer(), "Play_MX_OST_Center")
    if (customFadeIn ~= "GagFactoryLoad") then
      RemoveAllMusicStateOverride()
    end
    Print("Started Ostown Center music event")
  end
  FireThread(OST_AnimateBellows, "OST_center_01a_bellow")
  if (GetGlobal("EM2_TrainRide") == 1) then
    FireSequence("OST_Spirit_Shared", "Gen_Spirit_TrainOsTown")
    SetGlobal("EM2_TrainRide", 0)
  end
  if IsValidHandle("OST_TrainConductor") then
    if (GetGlobal("OST_TrainStation_Destroyed") == 3) then
      DestroyEntity("OST_TrainConductor")
    end
  end
  if (-1 < GetGlobal("OST_Moody_Destination")) then
    Hide("OST_Center_NPC_Rigger_Greene")
    Print("OsTown_Setup_Shared: Rigger Greene Hidden")
  end
  OsTown_Setup(location, customFadeIn)
  return 
end
OST_TrainStation_DestroyedFinal = function()
  SetGlobal("OST_TrainStation_Destroyed", 3)
  return 
end
OST_Center_Setup_DECAccess = function(state)
  OST_Center_CurrentCheckpointLoc = "Layer1"
  ForEachEntityInGroup(Disable, "OST_Grate_Layer1_Triggers")
  OST_Grate_Transition("CheckpointLoad", "Layer1", "1")
  FireUser1("OST_Layer1_Crusher")
  AudioPostEventOn(GetPlayer(), "Mute_OST_CenterMain")
  AudioPostEventOn(GetPlayer(), "Stop_MX_OST_Center")
  MusicPostEventOn(GetPlayer(), "Play_MX_OST_Sub")
  AudioPostEventOn(GetPlayer(), "UnMute_OST_DEC_Access")
  if (state == "DEC") then
    FireThread(Prefab_DECFoopToob_Finish, "DEC_toDEC2")
  end
  if (2 <= GetGlobal("EM2_EpisodeCheck")) then
    ForEachEntityInGroup(DestroyEntity, "OST_Layer1_Thinner")
  end
  if (GetGlobal("OST_DECAccess_RedChestStage") == 2) then
    SetPropertyBool("OswaldAction_HackBWX", "ActionSpotEnabled", true)
  end
  SetActiveFullMap("ost_center_shared.MapVolume_OST_Center_DECAccess")
  SetActiveSubMap("ost_center_shared.MapVolume_OST_Center_DECAccess")
  OsTown_Setup_Shared("DEC")
  return 
end
OST_Center_Setup_MaintenanceAccess = function()
  OST_Center_CurrentCheckpointLoc = "Layer2"
  OST_Grate_Transition("CheckpointLoad", "Layer2", "1")
  SetActiveFullMap("ost_center_shared.MapVolume_OST_Center_MaintenanceAccess")
  SetActiveSubMap("ost_center_shared.MapVolume_OST_Center_MaintenanceAccess")
  return 
end
OST_Center_Setup_MaintenanceOverflow = function()
  OST_Center_CurrentCheckpointLoc = "Layer3"
  OST_Grate_Transition("CheckpointLoad", "Layer3", "1")
  SetActiveFullMap("ost_center_shared.MapVolume_OST_Center_MaintenanceOverflow")
  SetActiveSubMap("ost_center_shared.MapVolume_OST_Center_MaintenanceOverflow")
  return 
end
OST_Center_Checkpoint = function(target, area, waitForApprentice)
  if (area ~= nil) then
    OST_Center_CurrentCheckpointLoc = area
  else
    area = "None_Specified"
  end
  Print(("Enter function: OST_Center_Checkpoint: area = " .. area))
  if (waitForApprentice == "true") then
    Wait(0.10000000149011612)
  end
  SaveCheckpoint(GetPlayer(), "OsTown_Setup_Shared", ("SaveMarker_" .. OST_Center_CurrentCheckpointLoc), (("SaveMarker_" .. OST_Center_CurrentCheckpointLoc) .. "_Oswald"))
  return 
end
OsTown_ToMeanStreets = function()
  UnrestrictCutSceneInput()
  LoadLevel(GetPlayer(), "MeanStreet_North.level")
  return 
end
OsTown_ToRBC = function()
  UnrestrictCutSceneInput()
  UnrestrictCutSceneInput()
  LoadLevel(GetPlayer(), "transition_02.level")
  return 
end
OST_DEC_Exit_HardLoad = function(target, visit)
  Print(("OST_DEC_Exit_HardLoad: visit = " .. visit))
  Print(("OST_DEC_Exit_HardLoad: GetGlobal(OST_Center_OpeningMoviePlayed) = " .. GetGlobal("OST_Center_OpeningMoviePlayed")))
  if (GetGlobal("OST_Center_OpeningMoviePlayed") == 0) then
    if (visit == "v1") then
      StartFadeOut(0)
      SetGlobal("DEC_Hardload", 1)
      wait(0)
    end
  end
  Print(("OST_DEC_Exit_HardLoad: GetGlobal(DEC_Hardload) = " .. GetGlobal("DEC_Hardload")))
  if (GetGlobal("DEC_Hardload") == 1) then
    Print("OST_DEC_Exit_HardLoad: DEC_Hardload == 1")
    if (visit == "v2") then
      Print("OST_DEC_Exit_HardLoad: visit == Visit 2, so disabling Projector")
      GetPrefabData("ProjFromMSNorth").MapLoad_SetupPosition = "IgnoreMe"
    elseif (GetGlobal("OST_Center_OpeningMoviePlayed") == 0) then
      Print("OST_DEC_Exit_HardLoad: OST_Center_OpeningMoviePlayed == 0, Turing off the Jump Out Anim on Foop TOOB ")
      GetPrefabData("DEC_OSTi_3D").SkipExitAnimationAndTeleport = "True"
      GetPrefabData("DEC_OSTi_3D").HardLoadExitFunction[3] = "None"
    end
    if (GetPrefabData("DEC_OSTi_3D").HardLoadExitFunction[1] ~= "Busy") then
      Print("OST_DEC_Exit_HardLoad: GetPrefabData(DEC_OSTi_3D).HardLoadExitFunction[1] ~= Busy, So Fire AWAY!")
      GetPrefabData("DEC_OSTi_3D").HardLoadExitFunction[1] = "True"
      Prefab_DECFoopToob_AlwaysSetup("DEC_OSTi_3D")
    end
  elseif (GetGlobal("EM2_TrainRide") == 1) then
    StartFadeOut(0)
    Print("OST_DEC_Exit_HardLoad: EM2_TrainRide == 1: Turning off Projector Jump Out Sequence - Firing OsTownSetup")
    if IsValidHandle("ProjFromMSNorth") then
      GetPrefabData("ProjFromMSNorth").MapLoad_SetupPosition = "IgnoreMe"
    end
    TeleportToEntity(GetPlayer(), "PM_TrainStationStart_Mickey")
    TeleportToEntity(GetPlayer2OrAI(), "PM_TrainStationStart_Oswald")
    SetCameraAttributesForPlayer("CO_TrainStart")
    FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer2OrAI())
    FireThread(StationaryCamera_UntilPlayerMoves)
    OsTown_Setup_Shared("TrainRide")
  elseif (GetGlobal("2dDirection") == 101) then
    StartFadeOut(0)
    Print("OST_DEC_Exit_HardLoad: 2dDirection == 50: Turning off Projector Jump Out Sequence - Starting us in Gag Factory")
    TeleportToEntity(GetPlayer(), GetRelativePrefabEntity("EnterInterior_GagFactory", ".ExitBuildingPosition"), true, true)
    TogglePlayerIconSubstitute(false, true)
    TeleportToEntity(GetPlayer(), "PM_StartInGF_Mickey", true, true)
    TeleportToEntity(GetPlayer2OrAI(), "PM_StartInGF_Oswald", true, true)
    GetPrefabData("ProjFromMSNorth").MapLoad_SetupPosition = "IgnoreMe"
    LevelManager_SetCurrentState("OST_Center.Main_Visit2")
    SetGlobal("2dDirection", 1)
    local data = GetPrefabData("EnterInterior_GagFactory")
    data.StartsInactive = "HardLoad"
    data.EnterFunctionParam = "NoFireThread"
    wait(0)
    Prefab_EnterInterior("EnterInterior_GagFactory")
    data.StartsInactive = "False"
    data.EnterFunctionParam = "OST_Center_EnterGagFactory"
    FireThread(OsTown_Setup_Shared, "GagFactoryLoad")
  elseif (visit == "v2") then
    GetPrefabData("ProjFromMSNorth").MapLoad_SetupPosition = "True"
  end
  return 
end
OST_Setup_Sky_Props = function()
  Print("Function Entered: OST_Setup_Sky_Props")
  ForEachEntityInGroup(Unhide, "OST_Center_DancingPillers")
  if (GetGlobal("OST_Sky_Restored_State") == 0) then
    ForEachEntityInGroup(AnimGBSequence, "OST_Center_DancingPillerPoles", "loop")
  end
  local OST_Center_DancingPillers_ToHide = (GetGlobal("OST_Sky_Restored_State") * 2)
  local (for index), (for limit), (for step) = OST_Center_DancingPillers_ToHide, 1, -2
  for i = (for index), (for limit), (for step) do
    Print(("OST_Center_DancingPillers_ToHide: " .. i))
    ForEachEntityInGroup(Hide, ("OST_Center_DancingPiller" .. tostring(i)))
  end
  return 
end
OST_AnimateBellows = function(bellows)
  AnimGBReset(bellows)
  AnimGBSequence(bellows, "up", false, 2.5)
  Enable("Bellows_TriggerRotate_Camera")
  Wait(1.600000023841858)
  Disable("Bellows_TriggerRotate_Camera")
  StartEmitters("OST_Center_OST_centerBellow_01a")
  Wait(1)
  StopEmitters("OST_Center_OST_centerBellow_01a")
  Wait(1)
  FireUser1(bellows)
  return 
end
OST_Center_RevealStatue = function()
  if (10 <= GetGlobal("OST_OswaldStatueState")) then
    ForEachEntityInGroup(Hide, "Oswald_Fountain_Pieces_Surface")
    ForEachEntityInGroup(Hide, "Oswald_Fountain_Pieces_Placed")
    if (GetGlobal("OST_OswaldStatueState") == 11) then
      Unhide("OST_statueArm_01a_Placed")
      Unhide("OST_statueArm_02a_Placed")
      Unhide("OST_MickeyHead_01a_Placed")
    elseif (GetGlobal("OST_OswaldStatueState") == 10) then
      Unhide("OST_statueArm_01a_Placed")
      Unhide("OST_statueArm_02a_Placed")
      Unhide("OST_oswaldHead_01a_Placed")
    elseif (GetGlobal("OST_OswaldStatueState") == 12) then
      Hide("StaticFootForStatue")
      ForEachEntityInGroup(Unhide, "CombinedStatue")
    else
      Print("You should never see this! The Global: OST_OswaldStatueState has been set to an invalid value!!!! FIX ME. FIX ME. FIX ME. FIX ME. ")
      SetGlobal("OST_OswaldStatueState", 10)
    end
    SetGlobal("OST_Center_OswaldStatueBuilt", 1)
    DestroyEntity("OST_Center_OST_thinnerStreams_01a")
    AudioPostEventOn("ost_center_scripting.EnterInterior_Clarabelle.EnterDoors", "Stop_sfx_Fountain_Impact_Lp")
    ForEachEntityInGroup(DestroyEntity, "OST_Center_TriggerDamageBase_ThinnerSpray_MickeysHouse")
    ForEachEntityInGroup(Disable, "OST_Center_TriggerDamageBase_ThinnerSpray_OrtensiaHouse")
    ForEachEntityInGroup(Disable, "OST_Center_TriggerDamageBase_ThinnerSpray_ClaraHouse")
    ForEachEntityInGroup(Disable, "Triggers_PumpFXDamage")
    local (for index), (for limit), (for step) = 1, 3, 1
    for i = (for index), (for limit), (for step) do
      StopEmitters(("OST_Pump_ThinnerFX" .. i))
      StopEmitters(("OST_Pump_ThinnerFXHigh" .. i))
    end
    Prefab_Activate_Doors("EnterInterior_Mickey", "open")
    Prefab_Activate_Doors("EnterInterior_Ortensia", "open")
    Prefab_Activate_Doors("EnterInterior_Clarabelle", "open")
    Enable("CameraMarker_MoodyPhoto3")
    if (GetGlobal("OST_Center_HiddenHeroesQuest_PhotoTaken") ~= 10) then
      if (GetGlobal("OST_OswaldStatueState") ~= 10) then
        if (GetGlobal("OST_OswaldStatueState") ~= 11) then
          if (GetGlobal("OST_OswaldStatueState") ~= 12) then
            SetGlobal("OST_DummyQuestFlagDoNotReference", 1)
            Enable("ThinnerStatueCameraMarker")
            AudioPostEventOn("ost_center_audio.FountainSpray", "Play_sfx_Fountain_Lp")
            AudioPostEventOn("ost_center_audio.FountainImpact", "Play_sfx_Fountain_Impact_Lp")
            if (GetGlobal("OST_Center_PoolLowered") == 2) then
              AudioPostEventOn("ost_center_scripting.EnterInterior_Clarabelle.EnterDoors", "Play_sfx_Fountain_Impact_Lp")
              AudioPostEventOn("ost_center_scripting.EnterInterior_Ortensia.EnterDoors", "Play_sfx_Fountain_Impact_Lp")
            end
          end
        end
      end
    end
  else
    AudioPostEventOn("ost_center_audio.FountainSpray", "Play_sfx_Fountain_Lp")
    AudioPostEventOn("ost_center_audio.FountainImpact", "Play_sfx_Fountain_Impact_Lp")
    if (GetGlobal("OST_Center_PoolLowered") == 2) then
      AudioPostEventOn("ost_center_scripting.EnterInterior_Clarabelle.EnterDoors", "Play_sfx_Fountain_Impact_Lp")
      AudioPostEventOn("ost_center_scripting.EnterInterior_Ortensia.EnterDoors", "Play_sfx_Fountain_Impact_Lp")
    end
  end
  return 
end
OST_Center_PhotographStatue = function()
  Print("OST_Center_PhotographStatue : taking photo")
  if (GetGlobal("OST_OswaldStatueState") == 10) then
    SetGlobal("OST_Center_HiddenHeroesQuest_PhotoTaken", 1)
  elseif (GetGlobal("OST_OswaldStatueState") == 11) then
    SetGlobal("OST_Center_HiddenHeroesQuest_PhotoTaken", 2)
  elseif (GetGlobal("OST_OswaldStatueState") == 12) then
    SetGlobal("OST_Center_HiddenHeroesQuest_PhotoTaken", 3)
  end
  OST_Center_Checkpoint(nil, "Surface", "false")
  return 
end
OST_Center_TrainStationStateCheck = function(target, state)
  Print("Entered function: OST_Center_TrainStationStateCheck")
  if (GetGlobal("OST_TrainStationState") == -1) then
    return 
  end
  if (state == "painted") then
    SetGlobal("OST_TrainStationState", (GetGlobal("OST_TrainStationState") + 1))
    if (GetGlobal("OST_TrainStationState") == 4) then
      if (GetGlobal("OST_TrainStationFairied") == 1) then
        FireUser1("OST_Center_prefab_trainstationexplosion01_EventTrigger")
      end
    end
    Print(("OST_TrainStationState: " .. GetGlobal("OST_TrainStationState")))
  elseif (state == "thinned") then
    SetGlobal("OST_TrainStationState", (GetGlobal("OST_TrainStationState") - 1))
    Print(("OST_TrainStationState: " .. GetGlobal("OST_TrainStationState")))
  end
  if (GetGlobal("OST_TrainStationState") < 0) then
    SetGlobal("OST_TrainStationState", 0)
  end
  return 
end
OST_Center_CrossingStreamsDestroy_TrainStation = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    DoStinger("Comment_Dest", 5)
    AudioPostEventOn("ost_center_audio.Snd_TrainStation_Explosion", "Play_sfx_OST_TrainStation_Explosion")
    StartEmitters("OST_Center_GBL_thinnerExplosionLarge_01a")
    ForEachEntityInGroup(DestroyEntity, "OST_Center_trainStation")
    OswaldStreamAbort()
    SetGlobal("OST_TrainStationState", -1)
    local (for index), (for limit), (for step) = 1, 4, 1
    for i = (for index), (for limit), (for step) do
      MoveToEntity("Spawner_ScrapMetal", ("PM_ScrapMetal" .. i))
      ForceSpawn("Spawner_ScrapMetal", 1)
    end
    Wait(5)
    StopEmitters("OST_Center_GBL_thinnerExplosionLarge_01a")
  end
  return 
end
OST_Center_FairyLift_TrainStation = function(target, event, piece)
  Print("Function Entered: OST_Center_FairyLift_TrainStation")
  if StimulusEvent_HasStimulusType(event, ST_FAIRY) then
    if (GetGlobal("OST_TrainStation_Destroyed") < 3) then
      Print("If Statement Entered: StimulusEvent_HasStimulusType")
      AnimGBSequence("OST_TrainStation_Top", "phase_01")
      AnimGBSequence("OST_TrainStation_Right", "phase_01")
      AnimGBSequence("OST_TrainStation_Left", "phase_01")
      SetGlobal("OST_TrainStationFairied", 1)
      if (GetGlobal("OST_TrainStationState") == 4) then
        if (GetGlobal("OST_TrainStationFairied") == 1) then
          FireUser1("OST_Center_prefab_trainstationexplosion01_EventTrigger")
        end
      end
    end
  end
  return 
end
OST_Center_RideTrain = function()
  SetGlobal("EM2_TrainRide", 1)
  local OST_Center_TrainDestination = GetGlobal("OST_Center_TrainDestination")
  SetGlobal("OST_Center_TrainDestination", 0)
  if (OST_Center_TrainDestination == 3) then
    if (GetGlobal("EM2_EpisodeCheck") == 4) then
      if (GetGlobal("VTL_Oasis_Visit") ~= 3) then
        SetGlobal("VTL_Oasis_Visit", 3)
      end
    end
  end
  OST_Center_Checkpoint(_player, "Surface")
  if (OST_Center_TrainDestination == 2) then
    LoadLevel(GetPlayer(), "NOS_BogEasy.LouisShack_V2")
  elseif (OST_Center_TrainDestination == 3) then
    if (GetGlobal("EM2_EpisodeCheck") == 4) then
      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
    else
      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
      if (OST_Center_TrainDestination == 4) then
        LoadLevel(GetPlayer(), "MeanStreet_South.Visit1")
      end
    end
  elseif (OST_Center_TrainDestination == 4) then
    LoadLevel(GetPlayer(), "MeanStreet_South.Visit1")
  end
  return 
end
OST_Center_SetTrainStationMapMarkerVisible = function()
  if (GetGlobal("OST_OsTown_TrainRestored") == 1) then
    if (GetGlobal("NOS_BogEasy_TrainRestored") == 1) then
      SetMapMarkerVisible("OST_Center_MapMarker_TrainStation", true)
    end
  end
  return 
end
OST_Center_LoadMeanStreetSouth = function()
  UnrestrictCutSceneInput()
  LoadLevel(GetPlayer(), "MeanStreet_South.Visit1")
  return 
end
OST_PumpSpawn = function()
  Print("+_+_+_+_+_+_+_+_+_+ OST_PumpSpawn")
  if (GetGlobal("OST_Pool_Level") == -1) then
    SetGlobal("OST_Pool_Level", 0)
  end
  return 
end
OST_GoofysPumpSearch = function(target)
  SetNextPatrolNode(target, ("OST_Center_PatrolNode_GoofysPumpSearch0" .. GetGlobal("OST_Center_GoofysPumpSearchCount")))
  return 
end
OST_LowerPool = function()
  local Pool_pos = GetPosition("OST_Pool")
  GiveCollectible("Challenge_GoFlow_Tracker")
  AudioPostEventOn(GetPlayer(), "Play_sfx_ThinnerDrain")
  ActivateGremlinHint("OST_Center_PlayerHintMarkers_Turnstile")
  local (for index), (for limit), (for step) = 1, 140, 1
  for i = (for index), (for limit), (for step) do
    SetTransformation("OST_Pool", vector4(Pool_pos.x, (Pool_pos.y - (0.009999999776482582 * i)), Pool_pos.z), vector4(0, 0, 0))
    wait(0)
  end
  DestroyEntity("OST_Pool")
  ForEachEntityInGroup(DestroyEntity, "OST_Pool_Collision")
  ForEachEntityInGroup(DestroyEntity, "OST_Center_PlayerHintMarkers_Pumps")
  SetPropertyFloat("OST_Grate_Outside_Turnstile", "Activate Radius", 2)
  local (for index), (for limit), (for step) = 1, 3, 1
  for i = (for index), (for limit), (for step) do
    (for index) = IsValidHandle
    (for limit) = "Pump"
    (for step) = i
    i = "_Location"
    (for limit) = (((for limit) .. (for step)) .. i)
    (for index) = (for index)((for limit))
    if (for index) then
      (for index) = DestroyEntity
      (for limit) = "Pump"
      (for step) = i
      i = "_Location"
      (for limit) = (((for limit) .. (for step)) .. i)
      (for index)((for limit))
    end
  end
  if (GetGlobal("OST_Center_PoolLowered") == 1) then
    SetGlobal("OST_QuestHealth", (GetGlobal("OST_QuestHealth") + 10))
  else
    SetGlobal("OST_QuestHealth", (GetGlobal("OST_QuestHealth") - 10))
  end
  SetGlobal("OST_PumpPlaced", 0)
  Quest_SetCriticalPath("Critical_OsTown", "Critical_OsTown_4")
  return 
end
OST_PumpStatus = function(target, status, loc_num)
  Print(("OST_PumpStatus() status == " .. status))
  local pump_name = GetName(target)
  local pump_num = 3
  if (pump_name == "ost_center_scripting.OST_center_01a_pumpMachine 01") then
    pump_num = 1
  elseif (pump_name == "ost_center_scripting.OST_center_01a_pumpMachine 02") then
    pump_num = 2
  end
  if (status == "Activated") then
    local Pump_health = GetHealth(target)
    if (Pump_health == 1) then
      SetPropertyBool(target, "ForceInvulnerable", true)
      AnimGBSequence(target, "on")
      DisableComponent(target, "Usable")
      SetGlobal((("OST_Pump" .. pump_num) .. "Status"), (GetGlobal((("OST_Pump" .. pump_num) .. "Status")) + 3))
      if (3 < GetGlobal("OST_Pump1Status")) then
        if (3 < GetGlobal("OST_Pump2Status")) then
          if (3 < GetGlobal("OST_Pump3Status")) then
            OST_LowerPool()
          end
        end
      end
    end
    Pump_health = string.format("%.2f", (((4 - Pump_health) / 3) * 100))
    Display(GetPlayer(), (("Pump at " .. Pump_health) .. "%"))
    Bark(GetPlayer(), (("Pump at " .. Pump_health) .. "%"))
  elseif (status == "Placed") then
    SetGlobal("OST_PumpPlaced", 1)
    if (GetHealth(target) ~= 1) then
      Disable((("Pump" .. loc_num) .. "_Location"))
      DisableMotion(target)
      AudioPostEventOn(GetPlayer(), "Play_sfx_OST_PipeDoor_Malfunction")
      MoveToEntity((("OST_Center_SplineKnot_PumpPad" .. loc_num) .. "_Start"), ("PumpMachine" .. pump_num))
      SplineFollower_TeleportToKnot(("PumpMachine" .. pump_num), (("OST_Center_SplineKnot_PumpPad" .. loc_num) .. "_Start"))
      Enable(("PumpMachine" .. pump_num))
      SetPropertyFloat(("PumpMachine" .. pump_num), "UsableRadius", 0)
      StopEmitters(("OST_Pump_ThinnerFX" .. loc_num))
      Disable(("Trigger_PumpFXDamage" .. loc_num))
      if (GetHealth(target) == 10) then
        DoStinger("Comment_Dest", 5)
        DisableComponent(target, "Usable")
        AudioPostEventOn("ost_center_audio.FountainSpray", "Play_FountainBurst")
        AudioPostEventOn("ost_center_scripting.EnterInterior_Clarabelle.EnterDoors", "Play_sfx_Fountain_Impact_Lp")
        AudioPostEventOn("ost_center_scripting.EnterInterior_Ortensia.EnterDoors", "Play_sfx_Fountain_Impact_Lp")
        ForEachEntityInGroup(SetPropertyBool, "PumpMachine", "Look At Trigger Enabled", false)
        local (for index), (for index), (for limit), (for step) = 1, 3, 1, "Look At Trigger Enabled"
        for (for step) = (for index), (for index), (for limit) do
          i = IsValidHandle
          i = i((("Pump" .. (for step)) .. "_Location"))
          if i then
            i = Disable
            i((("Pump" .. (for step)) .. "_Location"))
          end
          i = tonumber
          i = i(loc_num)
          if ((for step) ~= i) then
            i = StopEmitters
            i(("OST_Pump_ThinnerFX" .. (for step)))
            i = StartEmitters
            i(("OST_Pump_ThinnerFXHigh" .. (for step)))
            i = AudioPostEventOn
            i(("ost_center_art_01.OST_center_01a_pumpPad_01a 0" .. (for step)), "Play_sfx_Geyser_lp")
            i = "Trigger_PumpFXDamage"
            i = (i .. (for step))
            local trigger = (for step)
            trigger = GetPosition
            trigger = trigger(i)
            local triggerLoc = i
            triggerLoc = Enable
            triggerLoc(i)
            triggerLoc = SetTransformation
            triggerLoc(i, vector4(trigger.x, (trigger.y + 1.5), trigger.z), vector4(0, 0, 0))
          end
        end
        AnimGBSequence("OST_Center_OST_thinnerStreams_01a", "move")
        Wait(0.9670000076293945)
        AnimGBSequence("OST_Center_OST_thinnerStreams_01a", "door2")
        ForEachEntityInGroup(ForceSketched, "OST_OrtensiasHouse")
        ForEachEntityInGroup(ForceSketched, "OST_ClarabellesHouse")
        ForEachEntityInGroup(Enable, "OST_Center_TriggerDamageBase_ThinnerSpray_OrtensiaHouse")
        ForEachEntityInGroup(Enable, "OST_Center_TriggerDamageBase_ThinnerSpray_ClaraHouse")
        Prefab_Activate_Doors("EnterInterior_Ortensia", "close")
        Prefab_Activate_Doors("EnterInterior_Clarabelle", "close")
        StopEmitters(("OST_Center_FXImported_ChargedPumpMachine0" .. pump_num))
        Hide(("OST_Center_FXImported_ChargedPumpMachine0" .. pump_num))
        AudioPostEventOn(("OST_Center_FXImported_ChargedPumpMachine0" .. pump_num), "Stop_sfx_teslacoil")
        OST_LowerPool()
        SetGlobal((("OST_Pump" .. pump_num) .. "Status"), (10 * tonumber(loc_num)))
        SetGlobal("OST_Center_PoolLowered", 2)
        FireSequence("OST_Gus_v1", "OST_Gus_Q_PoolLoweredSuperCharge", 1)
        OST_Center_Checkpoint(_player, "Surface")
      else
        SetGlobal((("OST_Pump" .. pump_num) .. "Status"), tonumber(loc_num))
        Print(((("OST_Pump" .. pump_num) .. "Status = ") .. GetGlobal((("OST_Pump" .. pump_num) .. "Status"))))
        Prefab_OswaldElectricSwitch_ChangeState(("OswaldSwitchSign_PumpPad" .. loc_num), "Activate")
        FireSequence("AnimatronicGoofy", "OST_Goofy_PumpPlaced", 1)
        SetPropertyBool(("OswaldAction_ChargePump0" .. loc_num), "ActionSpotEnabled", true)
      end
    end
  end
  return 
end
OST_PumpCharged = function(target, loc_num)
  Print(("Function entered: OST_PumpCharged, loc_num = " .. loc_num))
  OswaldStreamAbort()
  SetPropertyBool(("OswaldAction_ChargePump0" .. loc_num), "ActionSpotEnabled", false)
  local pump_num = 1
  local (for index), (for limit), (for step) = 1, 3, 1
  for i = (for index), (for limit), (for step) do
    if (GetGlobal((("OST_Pump" .. i) .. "Status")) == tonumber(loc_num)) then
      pump_num = i
    end
  end
  AnimGBSequence(("PumpMachine" .. pump_num), "FillUp")
  AudioPostEventOn(("ost_center_scripting.FXImported_ChargedPumpMachine 0" .. pump_num), "Play_sfx_OST_Pump_Fill")
  Wait(3)
  AnimGBSequence(("PumpMachine" .. pump_num), "on")
  if (GetPrefabData("OswaldSwitchSign_PumpPad1").OswaldSwitchState == 2) then
    if (GetPrefabData("OswaldSwitchSign_PumpPad2").OswaldSwitchState == 2) then
      if (GetPrefabData("OswaldSwitchSign_PumpPad3").OswaldSwitchState == 2) then
        DoStinger("Comment_Rest", 5)
        OST_LowerPool()
        SetGlobal((("OST_Pump" .. pump_num) .. "Status"), (GetGlobal((("OST_Pump" .. pump_num) .. "Status")) + 3))
        SetGlobal("OST_Center_PoolLowered", 1)
        OST_Center_Checkpoint(_player, "Surface")
      end
    end
  else
    DestroyEntity((("Pump" .. loc_num) .. "_Location"))
    SetGlobal((("OST_Pump" .. pump_num) .. "Status"), (GetGlobal((("OST_Pump" .. pump_num) .. "Status")) + 3))
    OST_Center_Checkpoint(_player, "Surface")
  end
  return 
end
OST_SuperChargePump = function(target, state)
  Print(("Function Entered: OST_SuperChargePump  " .. state))
  if (state == "On") then
    Print("Turning on Oswald action marker so charging can happen.")
    Disable("Pump_Charger")
    local pump_name = GetName(target)
    OST_Pump_Charging = 3
    if (pump_name == "ost_center_scripting.OST_center_01a_pumpMachine 01") then
      OST_Pump_Charging = 1
    elseif (pump_name == "ost_center_scripting.OST_center_01a_pumpMachine 02") then
      OST_Pump_Charging = 2
    end
    if (GetGlobal((("OST_Pump" .. OST_Pump_Charging) .. "Status")) ~= 0) then
      Print("Status check passed, so I am moving the pump.")
      GetPrefabData("OswaldSwitch_ChargePumps").OswaldSwitchState = 0
      SetVulnerability(target, ST_FAIRY, 0)
      DisableMotion(target)
      MoveToEntity("OST_Center_SplineKnot_PumpPad4_Start", target)
      SplineFollower_TeleportToKnot(target, "OST_Center_SplineKnot_PumpPad4_Start")
      SplineFollower_SetDisabled(target, false)
      Enable("ost_center_scripting_hiddenoswald_action_ElectricBeam_Supercharger_Marker_BuddyAIAction01")
    end
  elseif (state == "From_Lever") then
    Disable("ost_center_scripting_hiddenoswald_action_ElectricBeam_Supercharger_Marker_BuddyAIAction01")
    OswaldStreamAbort()
    AudioPostEventOn("ost_center_audio.PumpCharger", "Play_sfx_PumpCharger_Charging")
    GetPrefabData("OswaldSwitch_ChargePumps").OswaldSwitchState = 2
    SetHealth(("PumpMachine" .. OST_Pump_Charging), 10)
    SetGlobal((("OST_Pump" .. OST_Pump_Charging) .. "Status"), 0)
    SplineFollower_SetDisabled(("PumpMachine" .. OST_Pump_Charging), true)
    EnableMotion(("PumpMachine" .. OST_Pump_Charging))
    SetVulnerability(("PumpMachine" .. OST_Pump_Charging), ST_FAIRY, 1)
    FireSequence("Gremlin_Prescott", "OST_Prescott_SuperChargeWearsOff", 1)
    Pump_ChargedTime = 30
    if (not GetPropertyBool(("OST_Center_FXImported_ChargedPumpMachine0" .. OST_Pump_Charging), "StartEmittersEnabled")) then
      local Pump_Num, Pump_Num = OST_Pump_Charging, ("OST_Center_FXImported_ChargedPumpMachine0" .. OST_Pump_Charging)
      Pump_Num = Unhide
      Pump_Num(("OST_Center_FXImported_ChargedPumpMachine0" .. OST_Pump_Charging))
      Pump_Num = StartEmitters
      Pump_Num(("OST_Center_FXImported_ChargedPumpMachine0" .. OST_Pump_Charging))
      Pump_Num = AudioPostEventOn
      Pump_Num(("OST_Center_FXImported_ChargedPumpMachine0" .. OST_Pump_Charging), "Play_sfx_teslacoil")
      while true do
        Pump_Num = Pump_ChargedTime
        if (not (Pump_Num ~= 0)) then
          break
        end
        Pump_Num = wait
        Pump_Num(1)
        Pump_Num = Pump_ChargedTime
        Pump_Num = (Pump_Num - 1)
        Pump_ChargedTime = Pump_Num
      end
      Pump_Num = StopEmitters
      Pump_Num(("OST_Center_FXImported_ChargedPumpMachine0" .. OST_Pump_Charging))
      Pump_Num = Hide
      Pump_Num(("OST_Center_FXImported_ChargedPumpMachine0" .. OST_Pump_Charging))
      Pump_Num = AudioPostEventOn
      Pump_Num(("OST_Center_FXImported_ChargedPumpMachine0" .. OST_Pump_Charging), "Stop_sfx_teslacoil")
      Pump_Num = GetGlobal
      Pump_Num = Pump_Num((("OST_Pump" .. OST_Pump_Charging) .. "Status"))
      if (Pump_Num == 0) then
        Pump_Num = FireSequence
        Pump_Num("Gremlin_Prescott", "OST_Prescott_SuperChargeWearsOff", 1)
        Pump_Num = SetHealth
        Pump_Num(("PumpMachine" .. OST_Pump_Charging), 4)
        Pump_Num = SetGlobal
        Pump_Num((("OST_Pump" .. OST_Pump_Charging) .. "Status"), -1)
        Pump_Num = GetPrefabData
        Pump_Num = Pump_Num("OswaldSwitch_ChargePumps")
        Pump_Num.OswaldSwitchState = 1
        Pump_Num = Prefab_ActivateSwitchTimerReset
        Pump_Num("OswaldSwitch_ChargePumps")
        Pump_Num = Print
        Pump_Num("Re-enabling the trigger.")
        Pump_Num = Enable
        Pump_Num("Pump_Charger")
      end
    end
  end
  return 
end
OST_ClarabelleHouseToGarden_Check = function(dir)
  if (GetPrefabData(_self()).ExitFunction == "OST_ExitInterior") then
    FireThread(_G[(("Prefab_" .. dir) .. "Interior")], "EnterInterior_Clarabelle")
  else
    FireThread(_G[(("Prefab_" .. dir) .. "Interior")], "EnterInterior_ClarabelleFromGarden")
  end
  return 
end
OST_ClarabelleHouse = function()
  ReplaceMusicStateOverride("OST_IntClarabelle")
  if (GetGlobal("MSS_HoraceQuest_Assistant") ~= 3) then
    if (0 < GetGlobal("MSS_HoraceQuest_Note")) then
      Unhide("SpatterNPC_Flower")
      Hide("ClarabelleCow_Cake")
      Unhide("ClarabelleCow_WateringCan")
    elseif (GetGlobal("MSS_Horace_AssistantIntro_New_Played") == 1) then
      Unhide("SpatterNPC_Crying")
      AnimVarInt("SpatterNPC_Crying", VAR_NPC_State, 1)
      Hide("ClarabelleCow_Cake")
      Hide("SpatterNPC_Crying")
      Hide("ClarabelleCow_WateringCan")
      Hide("SpatterNPC_Flower")
    end
  else
    Hide("ClarabelleCow_Cake")
    Hide("SpatterNPC_Crying")
    Hide("ClarabelleCow_WateringCan")
    Hide("SpatterNPC_Flower")
  end
  Prefab_EnterInterior_FadeIn()
  if (GetGlobal("OST_Clarabelle_Q_SpatterGathering_Played") == 0) then
    if (2 < GetGlobal("OST_Clarabelle_SpatterQuestState")) then
      wait(1)
      ForceSequence("ClarabelleCow", "OST_Clarabelle_Q_SpatterGathering")
    end
  end
  return 
end
OST_Center_RevealFlowerSpatter = function()
  RestrictCutSceneInput()
  ForceInterruptSequence("ClarabelleCow_Cake", "OST_Center_Clarabelle_HoraceQuest")
  StartFadeOut(0.800000011920929)
  Wait(0.800000011920929)
  Hide("SpatterNPC_Crying")
  AnimVarInt("SpatterNPC_Crying", VAR_NPC_State, 0)
  Unhide("SpatterNPC_Flower")
  Hide("ClarabelleCow_Cake")
  Unhide("ClarabelleCow_WateringCan")
  Wait(0.800000011920929)
  StartFadeIn(0.800000011920929)
  UnrestrictCutSceneInput()
  OST_Center_Checkpoint("none", "Surface", "true")
  return 
end
OST_Center_EnterOrtensiasHouse = function()
  local OST_BunnyQuest_Count = GetGlobal("OST_BunnyQuest_Count")
  local bunnyCount = math.floor((OST_BunnyQuest_Count / 5))
  Print(("bunnyCount = " .. bunnyCount))
  if (2 <= GetGlobal("EM2_EpisodeCheck")) then
    Unhide("OST_Center_Ortensia")
  end
  if (bunnyCount == -1) then
    AnimVarInt("OST_Center_Ortensia", VAR_Mood_Type, 0)
  end
  while (0 < bunnyCount) do
    MoveToEntity("Spawner_BunnyChildren", ("ost_center_01a_ortensiashouse_ai.PM_BunnyChild 0" .. bunnyCount))
    AnimVarInt(ForceSpawn("Spawner_BunnyChildren", 1)[1], VAR_NPC_State, 1)
    bunnyCount = (bunnyCount - 1)
    wait(0)
  end
  if (GetGlobal("VTL_Oasis_ThreePigsQuest_PigsMissingAgain") == 1) then
    if (GetGlobal("OST_Center_FiddlerPig_Rescued_Played") == 0) then
      Unhide("OST_Center_PigFiddler_Outside")
    end
  end
  local OSTBunny = OST_BunnyQuest_Count
  local MSNBunny = GetGlobal("MSN_BunnyQuest_Count")
  local BunnyTotal = (OSTBunny + MSNBunny)
  SetGlobal("MSN_BunnyTotal", BunnyTotal)
  ReplaceMusicStateOverride("OST_IntOrtensia")
  Prefab_EnterInterior_FadeIn()
  return 
end
OST_BunnyChildrenBrain = function()
  Print("#### OST_BunnyChildrenBrain")
  local OST_BunnyQuest_Count = GetGlobal("OST_BunnyQuest_Count")
  Print(("#### OST_BunnyQuest_Count is " .. GetGlobal("OST_BunnyQuest_Count")))
  Print(("#### OST_BunnyRewardGiven is " .. GetGlobal("OST_BunnyRewardGiven")))
  if (GetGlobal("OST_BunnyRewardGiven") == 1) then
    if (5 <= OST_BunnyQuest_Count) then
      SetGlobal("OST_BunnyRewardGiven", 2)
    end
  end
  Wait(0)
  if (GetGlobal("OST_BunnyRewardGiven02") == 1) then
    if (10 <= OST_BunnyQuest_Count) then
      SetGlobal("OST_BunnyRewardGiven02", 2)
    end
  end
  Wait(0)
  if (GetGlobal("OST_BunnyRewardGiven03") == 1) then
    if (15 <= OST_BunnyQuest_Count) then
      GiveCurrencyItem("Bronze_Pin", 1)
      SetGlobal("OST_BunnyRewardGiven03", 2)
    end
  end
  Wait(0)
  if (GetGlobal("OST_BunnyRewardGiven04") == 1) then
    if (20 <= OST_BunnyQuest_Count) then
      GiveCurrencyItem("Bronze_Pin", 2)
      SetGlobal("OST_BunnyRewardGiven04", 2)
    end
  end
  Wait(0)
  if (GetGlobal("OST_BunnyRewardGiven05") == 1) then
    if (25 <= OST_BunnyQuest_Count) then
      GiveCurrencyItem("Bronze_Pin", 3)
      SetGlobal("OST_BunnyRewardGiven05", 2)
    end
  end
  Wait(0)
  if (GetGlobal("OST_BunnyRewardGiven06") == 1) then
    if (30 <= OST_BunnyQuest_Count) then
      GiveCurrencyItem("Gold_Pin", 1)
      SetGlobal("OST_BunnyRewardGiven06", 2)
    end
  end
  OST_Center_Checkpoint("none", "Surface", "true")
  if (30 <= GetGlobal("MSN_BunnyTotal")) then
    if (20 <= OST_BunnyQuest_Count) then
      if (HasCollectible("Not_Quite_101") == false) then
        ForceSequence("OST_Center_Ortensia", "OST_Ortensia_NotQuite101_Pin")
      end
    end
  elseif (30 <= GetGlobal("MSN_BunnyTotal")) then
    if (OST_BunnyQuest_Count < 20) then
      if (OST_BunnyQuest_Count < 20) then
        if (GetGlobal("MSN_BunnyQuest_Count") < 20) then
          if (not Quest_CheckStatus("The_Bunny_Wranglers", "The_Bunny_Wranglers_10a", Quest_Unavailable)) then
            Quest_SetStatus("The_Bunny_Wranglers", "The_Bunny_Wranglers_10a", Quest_Unavailable, false)
            Quest_SetStatus("The_Bunny_Wranglers", "The_Bunny_Wranglers_10b", Quest_Unavailable, false)
            GiveCollectible("Challenge_Perfectionist_BunnyWrangler_Tracker")
          end
        end
      end
      ForceSequence("OST_Center_Ortensia", "OST_Ortensia_BunnyChildrenComplete")
    end
  end
  return 
end
OST_BunnyReward_PreBrain = function()
  local OST_BunnyQuest_Count = GetGlobal("OST_BunnyQuest_Count")
  if (5 <= OST_BunnyQuest_Count) then
    if (OST_BunnyQuest_Count < 10) then
      if (GetGlobal("OST_BunnyRewardGiven") == 0) then
        SetGlobal("OST_BunnyRewardGiven", 1)
      end
    end
  elseif (10 <= OST_BunnyQuest_Count) then
    if (OST_BunnyQuest_Count < 15) then
      if (GetGlobal("OST_BunnyRewardGiven02") == 0) then
        SetGlobal("OST_BunnyRewardGiven02", 1)
        if (GetGlobal("OST_BunnyRewardGiven") == 0) then
          SetGlobal("OST_BunnyRewardGiven", 1)
        end
      end
    end
  elseif (15 <= OST_BunnyQuest_Count) then
    if (OST_BunnyQuest_Count < 20) then
      if (GetGlobal("OST_BunnyRewardGiven03") == 0) then
        SetGlobal("OST_BunnyRewardGiven03", 1)
        if (GetGlobal("OST_BunnyRewardGiven") == 0) then
          SetGlobal("OST_BunnyRewardGiven", 1)
        end
        if (GetGlobal("OST_BunnyRewardGiven02") == 0) then
          SetGlobal("OST_BunnyRewardGiven02", 1)
        end
      end
    end
  elseif (20 <= OST_BunnyQuest_Count) then
    if (OST_BunnyQuest_Count < 25) then
      if (GetGlobal("OST_BunnyRewardGiven04") == 0) then
        SetGlobal("OST_BunnyRewardGiven04", 1)
        if (GetGlobal("OST_BunnyRewardGiven") == 0) then
          SetGlobal("OST_BunnyRewardGiven", 1)
        end
        if (GetGlobal("OST_BunnyRewardGiven02") == 0) then
          SetGlobal("OST_BunnyRewardGiven02", 1)
        end
        if (GetGlobal("OST_BunnyRewardGiven03") == 0) then
          SetGlobal("OST_BunnyRewardGiven03", 1)
        end
      end
    end
  elseif (25 <= OST_BunnyQuest_Count) then
    if (OST_BunnyQuest_Count < 30) then
      if (GetGlobal("OST_BunnyRewardGiven05") == 0) then
        SetGlobal("OST_BunnyRewardGiven05", 1)
        if (GetGlobal("OST_BunnyRewardGiven") == 0) then
          SetGlobal("OST_BunnyRewardGiven", 1)
        end
        if (GetGlobal("OST_BunnyRewardGiven02") == 0) then
          SetGlobal("OST_BunnyRewardGiven02", 1)
        end
        if (GetGlobal("OST_BunnyRewardGiven03") == 0) then
          SetGlobal("OST_BunnyRewardGiven03", 1)
        end
        if (GetGlobal("OST_BunnyRewardGiven04") == 0) then
          SetGlobal("OST_BunnyRewardGiven04", 1)
        end
      end
    end
  elseif (30 <= OST_BunnyQuest_Count) then
    if (GetGlobal("OST_BunnyRewardGiven06") == 0) then
      SetGlobal("OST_BunnyRewardGiven06", 1)
      if (GetGlobal("OST_BunnyRewardGiven") == 0) then
        SetGlobal("OST_BunnyRewardGiven", 1)
      end
      if (GetGlobal("OST_BunnyRewardGiven02") == 0) then
        SetGlobal("OST_BunnyRewardGiven02", 1)
      end
      if (GetGlobal("OST_BunnyRewardGiven03") == 0) then
        SetGlobal("OST_BunnyRewardGiven03", 1)
      end
      if (GetGlobal("OST_BunnyRewardGiven04") == 0) then
        SetGlobal("OST_BunnyRewardGiven04", 1)
      end
      if (GetGlobal("OST_BunnyRewardGiven05") == 0) then
        SetGlobal("OST_BunnyRewardGiven05", 1)
      end
    end
  end
  Print(("#### PreBrain OST_BunnyQuest_Count is " .. OST_BunnyQuest_Count))
  Print(("#### PreBrain OST_BunnyRewardGiven is " .. GetGlobal("OST_BunnyRewardGiven")))
  ForceSequence("OST_Center_Ortensia", "OST_Ortensia_BunnyRewardMaster")
  return 
end
OST_Center_EnterMoodysHouse = function()
  if (-1 < GetGlobal("OST_Moody_Destination")) then
    Hide("OST_Center_NPC_Moody")
  end
  ReplaceMusicStateOverride("OST_IntMoody")
  Prefab_EnterInterior_FadeIn()
  return 
end
OST_ExitMoodysHouse = function()
  local streamAI = false
  if (GetGlobal("OST_Moody_Photo1") == 1) then
    if (GetGlobal("OST_Gus_Q_RestoreMemory_Played") == 0) then
      GetPrefabData("EnterInterior_Moody").SkipExitFade = "True"
      wait(0)
      LevelManager_SetZoneStatusActive("OST_Center.Ost_int_GusAndRigger")
    end
  else
    GetPrefabData("EnterInterior_Moody").SkipExitFade = "False"
    wait(0)
    streamAI = true
  end
  OST_ExitMoodysHouse_VisitSetup(streamAI)
  Prefab_ExitInterior_FadeIn("cats", "EnterInterior_Moody")
  OST_ExitInterior_ResumeAudio("EnterInterior_Moody")
  if (GetGlobal("OST_Moody_Photo1") == 1) then
    if (GetGlobal("OST_Gus_Q_RestoreMemory_Played") == 0) then
      FireUser1("ExitMoodysGrabCameraFancy")
      TeleportGremlinToEntity("Cutscene_Gus", "GusTeleportInLocation")
      DisableComponent("Cutscene_Gus", "Usable")
      FireSequence("OST_Gus_Shared", "OST_Gus_Q_RestoreMemory", 1)
      OST_Moody_Photo1_MoodysHouse("OST_MoodysHouse")
    end
  end
  return 
end
OST_SetupClarabelleGarden = function(target)
  local player1_pos = GetRelativePrefabEntity("EnterInterior_ClarabelleFromGarden", ".ExitBuildingPosition")
  local player2_pos = GetRelativePrefabEntity("EnterInterior_ClarabelleFromGarden", ".ExitBuildingPosition_Player2")
  TeleportToEntity(GetPlayer(), player1_pos, true, true)
  TeleportToEntity(GetPlayer2OrAI(), player2_pos, true, true)
  wait(0.009999999776482582)
  LevelManager_SetZoneStatusActive("OST_Center.OST_int_ClarabellesGardn")
  WaitForLevelLoad()
  Wait(1)
  if (0 < GetGlobal("OST_Center_Clarabelle_CostumeCount")) then
    ForceSpawn("Spawner_ClarabellesGarden", GetGlobal("OST_Center_Clarabelle_CostumeCount"))
  else
    FireSequence("OST_Gus_Shared", "OST_Gus_ClarabellesGarden", 1)
  end
  RemoveAllMusicStateOverride()
  SetActiveFullMap("ost_center_shared.MapVolume_OST_Center_Main_ClarabellesGarden")
  SetActiveSubMap(nil)
  SetInside2DMap(false)
  SetCameraAttributesForPlayer("ClarabelleGarden_Override")
  OverrideSpawnTransform(PLAYER_ONE, GetPosition(player1_pos), GetFacing(player1_pos))
  OverrideSpawnTransform(PLAYER_TWO, GetPosition(player2_pos), GetFacing(player2_pos))
  Prefab_EnterInterior_FadeIn()
  return 
end
OST_EnterClarabellesFromGarden = function()
  ReplaceMusicStateOverride("OST_IntClarabelle")
  if (GetGlobal("MSS_HoraceQuest_Assistant") ~= 3) then
    if (0 < GetGlobal("MSS_HoraceQuest_Note")) then
      Unhide("SpatterNPC_Flower")
      Hide("ClarabelleCow_Cake")
      Unhide("ClarabelleCow_WateringCan")
    elseif (Quest_CheckStatus("Horaces_Assistant_Assistance", "Horaces_Assistant_Assistance_5", Quest_Completed) == true) then
      Unhide("SpatterNPC_Crying")
      AnimVarInt("SpatterNPC_Crying", VAR_NPC_State, 1)
      Hide("ClarabelleCow_Cake")
      Hide("SpatterNPC_Crying")
      Hide("ClarabelleCow_WateringCan")
      Hide("SpatterNPC_Flower")
    end
  else
    Hide("ClarabelleCow_Cake")
    Hide("SpatterNPC_Crying")
    Hide("ClarabelleCow_WateringCan")
    Hide("SpatterNPC_Flower")
  end
  SetActiveFullMap("ost_center_shared.MapVolume_OST_Center_Main")
  SetInside2DMap(true)
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  Prefab_EnterInterior_FadeIn()
  return 
end
OST_Center_EnterGagFactory = function()
  if (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingOccupant") ~= 2) then
    Hide("OST_Center_PedestrianMaleDog_Bertrand")
  end
  if (3 <= GetGlobal("EM2_EpisodeCheck")) then
    Prefab_Projector_ChangeState("GagFactory_Projector", "Activate")
  end
  ReplaceMusicStateOverride("OST_IntGagFactory")
  Prefab_EnterInterior_FadeIn()
  return 
end
OST_Center_EnterMickeysHouse = function()
  if (GetGlobal("OST_Center_PracticalPig_Rescued_Played") == 0) then
    Unhide("OST_Center_PigPractical")
  end
  ReplaceMusicStateOverride("OST_IntMickey")
  OST_Center_TelephoneDialogue_Setup()
  Prefab_EnterInterior_FadeIn()
  return 
end
local HUBs = {"MeanStreetNorth", "MeanStreetSouth", "BogEasy", "OsTown", "Ventureland"}
local Complete_HUBs = 0
OST_Center_TelephoneDialogue_Setup = function()
  Print("****OST_Center_TelephoneDialogue_Setup")
  HUBs = {"MeanStreetNorth", "MeanStreetSouth", "BogEasy", "OsTown", "Ventureland"}
  Complete_HUBs = 0
  local (for index), (for limit), (for step) = 5, 1, -1
  for i = (for index), (for limit), (for step) do
    if (GetCurrentCount(("PhoneBox_" .. HUBs[i])) == 3) then
      Print((("****OST_Center_TelephoneDialogue_Setup: PhoneBox_" .. HUBs[i]) .. " == 3 so removing it from the HUB table"))
      Complete_HUBs = (Complete_HUBs + 1)
      table.remove(HUBs, i)
    end
  end
  local n, n = (#HUBs), "OsTown"
  while (2 < n) do
    local k, k = math.random(n), "Ventureland"
    n = HUBs
    n = n[k]
    k = HUBs
    k = k[n]
    HUBs[k] = k
    HUBs[n] = n
    n = (n - 1)
  end
  n = (#HUBs)
  local (for index), (for limit), (for step) = 1, n, 1
  for n = (for index), (for limit), (for step) do
    (for index) = "****OST_Center_TelephoneDialogue_Setup: HUBs["
    (for limit) = n
    (for step) = "] = "
    i = HUBs
    i = i[n]
    (for index) = ((((for index) .. (for limit)) .. (for step)) .. i)
    Print((for index))
  end
  Print(("****OST_Center_TelephoneDialogue_Setup: Complete_HUBs = " .. Complete_HUBs))
  if (Complete_HUBs == 1) then
    Complete_HUBs = "OneHub"
  elseif (Complete_HUBs == 2) then
    Complete_HUBs = "TwoHubs"
  elseif (Complete_HUBs == 3) then
    Complete_HUBs = "ThreeHubs"
  elseif (Complete_HUBs == 4) then
    Complete_HUBs = "FourHubs"
  elseif (Complete_HUBs == 5) then
    Complete_HUBs = "AllConnected"
  else
    Complete_HUBs = "GeneralReminder"
  end
  Print(("****OST_Center_TelephoneDialogue_Setup: Complete_HUBs = " .. Complete_HUBs))
  return 
end
OST_Center_TelephoneDialogue = function()
  local playerNum = 1
  if (_activator() == GetPlayer2()) then
    playerNum = 2
  end
  Print("OST_Center_TelephoneDialogue")
  local ThreePigsQuest_Global = GetGlobal("VTL_Oasis_ThreePigsQuest_OsTownPhone")
  if (ThreePigsQuest_Global == 0) then
    ForceSequence("TalkingPhone", "OST_Center_Telephone_Visit1Chatter")
  else
    if (ThreePigsQuest_Global < 2) then
      ForceSequence("TalkingPhone", "OST_Center_ThreePigsQuest")
    elseif (Complete_HUBs == "AllConnected") then
      if (GetGlobal("OST_Center_Telephone_PreemptiveFix_Played") == 0) then
        if (GetGlobal("OST_Center_Telephone_OneHub_Played") == 0) then
          if (GetGlobal("OST_Center_Telephone_TwoHubs_Played") == 0) then
            if (GetGlobal("OST_Center_Telephone_ThreeHubs_Played") == 0) then
              if (GetGlobal("OST_Center_Telephone_FourHubs_Played") == 0) then
                if (GetGlobal("OST_Center_Telephone_AllConnected_Played") == 0) then
                  if (GetGlobal("OST_Center_Telephone_GeneralReminder_Played") == 0) then
                    ForceSequence("TalkingPhone", "OST_Center_Telephone_PreemptiveFix")
                  end
                end
              end
            end
          end
        end
      end
    else
      if (GetGlobal("OST_Center_Telephone_PreemptiveFix_Played") == 1) then
        ForceSequence("TalkingPhone", "OST_Center_Telephone_NoQuestChatterIntro")
        while true do
          if (not IsSequencePlaying("TalkingPhone", "OST_Center_Telephone_NoQuestChatterIntro")) then
            break
          end
          wait(0.20000000298023224)
        end
        ForceSequence("TalkingPhone", "OST_Center_Telephone_NoQuestChatter")
      end
      if (Complete_HUBs == "GeneralReminder") then
        ForceSequence("TalkingPhone", "OST_Center_Telephone_NoQuestChatterIntro")
        while true do
          if (not IsSequencePlaying("TalkingPhone", "OST_Center_Telephone_NoQuestChatterIntro")) then
            break
          end
          wait(0.20000000298023224)
        end
      end
      ForceSequence("TalkingPhone", ("OST_Center_Telephone_" .. Complete_HUBs))
      if (Complete_HUBs ~= "AllConnected") then
        while true do
          if (not IsSequencePlaying("TalkingPhone", ("OST_Center_Telephone_" .. Complete_HUBs))) then
            break
          end
          wait(0.20000000298023224)
        end
        ForceSequence("TalkingPhone", (("OST_Center_Telephone_" .. HUBs[1]) .. "Hint"))
        local HUBs_len = (#HUBs)
        if (1 < HUBs_len) then
          local played = HUBs[1]
          table.remove(HUBs, 1)
          table.insert(HUBs, played)
        end
      end
    end
    Print("OST_Center_TelephoneDialogue: Finished")
  end
  return 
end
OST_ExitInterior_ResumeAudio = function(target)
  local data = GetPrefabData(target)
  if (data.InteriorToStream == "OST_int_MoodysHouse") then
    RemoveAllMusicStateOverride()
  elseif (data.InteriorToStream == "OST_int_ClarabellesHouse") then
    if (data.ExitFunction == "OST_ExitInterior") then
      RemoveAllMusicStateOverride()
    end
  elseif (data.InteriorToStream == "OST_int_GagFactory_v2") then
    RemoveAllMusicStateOverride()
  elseif (data.InteriorToStream == "OST_int_MickeysHouse") then
    RemoveAllMusicStateOverride()
  elseif (data.InteriorToStream == "OST_int_OrtensiasHouse") then
    RemoveAllMusicStateOverride()
  end
  if (data.InteriorToStream ~= "OST_int_MoodysHouse") then
    Prefab_ExitInterior_FadeIn("True")
  end
  return 
end
OST_ForceThinned = function(target, location, door, event)
  Print(((("Function entered: OST_ForceThinned, location = " .. location) .. ", door = ") .. door))
  if (GetGlobal("OST_Center_OswaldStatueBuilt") == 0) then
    if (location == "MickeysHouse") then
      Wait(0.4000000059604645)
      ForceSketched(target)
    else
      if (location == "OrtensiasHouse") then
        if (10 <= GetGlobal("OST_Pump1Status")) then
          Wait(0.4000000059604645)
          ForceSketched(target)
        end
        if (door == "OrtensiasDoor") then
          Prefab_Activate_Doors("EnterInterior_Ortensia", "open")
        elseif (door == "ClarabellesDoor") then
          Prefab_Activate_Doors("EnterInterior_Clarabelle", "open")
        elseif (door == "NotADoor") then
          Prefab_SpawnItem_Jigsaw(target, event)
          if (location == "Car") then
            if (GetGlobal("OST_Center_PoolLowered") == 0) then
              Wait(0.4000000059604645)
              ForceSketched(target)
              if (door == "MickeysDoor") then
                Prefab_Activate_Doors("EnterInterior_Mickey", "open")
              elseif (door == "OrtensiasDoor") then
                Prefab_Activate_Doors("EnterInterior_Ortensia", "open")
              elseif (door == "ClarabellesDoor") then
                Prefab_Activate_Doors("EnterInterior_Clarabelle", "open")
              elseif (door == "NotADoor") then
                Prefab_SpawnItem_Jigsaw(target, event)
              end
            end
          end
        end
      end
      if (location == "Car") then
        if (GetGlobal("OST_Center_PoolLowered") == 0) then
          Wait(0.4000000059604645)
          ForceSketched(target)
          if (door == "MickeysDoor") then
            Prefab_Activate_Doors("EnterInterior_Mickey", "open")
          elseif (door == "OrtensiasDoor") then
            Prefab_Activate_Doors("EnterInterior_Ortensia", "open")
          elseif (door == "ClarabellesDoor") then
            Prefab_Activate_Doors("EnterInterior_Clarabelle", "open")
          elseif (door == "NotADoor") then
            Prefab_SpawnItem_Jigsaw(target, event)
          end
        end
      end
    end
  elseif (door == "MickeysDoor") then
    Prefab_Activate_Doors("EnterInterior_Mickey", "open")
  elseif (door == "OrtensiasDoor") then
    Prefab_Activate_Doors("EnterInterior_Ortensia", "open")
  elseif (door == "ClarabellesDoor") then
    Prefab_Activate_Doors("EnterInterior_Clarabelle", "open")
  elseif (door == "NotADoor") then
    Prefab_SpawnItem_Jigsaw(target, event)
  end
  return 
end
OST_Center_GrateTravel = function(target, grate)
  local turnstileRotation = 0
  local startingRotationPosition = 0
  local numOfRotations = 6.2831854820251465
  if (grate ~= "Layer1") then
    if (grate ~= "Layer2") then
    end
  else
    startingRotationPosition = 9.42477798461914
    numOfRotations = 18.84955596923828
  end
  if (grate == "Layer2") then
    if (0 < GetGlobal("OST_DEC_Layer2_State")) then
      startingRotationPosition = 13.006193161010742
      numOfRotations = 18.84955596923828
    end
  end
  startingRotationPosition = (startingRotationPosition - GetTotalRotation(target))
  SplineFollower_SetDisabled(("SF_Grate_" .. grate), false)
  OST_grateBeingHeld = true
  ForEachEntityInGroup(Enable, (("OST_Grate_" .. grate) .. "_Triggers"))
  while true do
    if (not OST_grateBeingHeld) then
      break
    end
    turnstileRotation = (GetTotalRotation(target) + startingRotationPosition)
    OST_gratePosition = (turnstileRotation / numOfRotations)
    if (1 < OST_gratePosition) then
      OST_gratePosition = 1
    elseif (OST_gratePosition < 0) then
      OST_gratePosition = 0
    end
    SplineFollower_StopAtPosition(("SF_Grate_" .. grate), ("SK1_OST_Grate_" .. grate), ("SK2_OST_Grate_" .. grate), OST_gratePosition)
    Wait(0)
  end
  return 
end
OST_Center_GrateReleased = function(target, grate)
  if (OST_grateBeingHeld == false) then
    Print("OST_Center_GrateReleased OST_grateBehindHeld = false")
    Print(("OST_Center_GrateReleased OST_GrateDirection = " .. OST_GrateDirection))
    SplineFollower_StopAtPosition(("SF_Grate_" .. grate), ("SK1_OST_Grate_" .. grate), ("SK2_OST_Grate_" .. grate), OST_GrateDirection)
    AudioPostEventOn(GetPlayer(), "Play_sfx_GrateElevator_Intro")
    return 
  end
  local waitTime = 0
  AudioPostEventOn(GetPlayer(), "Play_sfx_GrateElevator_Intro")
  SetPropertyFloat(target, "Activate Radius", 0)
  OST_grateBeingHeld = false
  if (grate ~= "Outside") then
    Hide((grate .. "_UpArrow"))
  end
  if (grate ~= "Layer3") then
    Hide((grate .. "_DownArrow"))
  end
  if (grate ~= "Layer1") then
    if (grate ~= "Layer2") then
    end
  else
    waitTime = (10 * math.abs((OST_gratePosition - 0.5)))
    OST_gratePosition = 0.5
  end
  if (grate == "Layer2") then
    if (0 < GetGlobal("OST_DEC_Layer2_State")) then
      waitTime = (10 * math.abs((OST_gratePosition - 0.6899999976158142)))
      OST_gratePosition = 0.6899999976158142
    end
  else
    waitTime = (10 * OST_gratePosition)
    OST_gratePosition = 0
  end
  SplineFollower_StopAtPosition(("SF_Grate_" .. grate), ("SK1_OST_Grate_" .. grate), ("SK2_OST_Grate_" .. grate), OST_gratePosition)
  Print(("Wait time = " .. tostring(waitTime)))
  Wait(waitTime)
  AudioPostEventOn(GetPlayer(), "Play_sfx_GrateElevatorShort_End")
  SetPropertyFloat(target, "Activate Radius", 2)
  QueueBrainEvent(GetOswaldAI(), BRAIN_Unpause)
  return 
end
OST_GrateUsed = function(target, grate, dir)
  Print("Function OST_GrateUsed")
  RestrictCutSceneInput()
  OswaldStopFollowAction()
  AI_SetDisabled(GetOswaldAI(), true)
  SplineFollower_SetDisabled(target, false)
  local spline_pos = dir
  if (dir == nil) then
    Print((("Function OST_GrateUsed: grate = " .. grate) .. " & No dir Passed"))
    if (OST_GrateDirection == "Down") then
      if (grate == "Layer2") then
        spline_pos = 1
      else
        spline_pos = 0.75
        if (OST_GrateDirection == "Up") then
          spline_pos = 0.25
        end
      end
    elseif (OST_GrateDirection == "Up") then
      spline_pos = 0.25
    end
    Print((("OST_Grate_Transition() Enabling " .. grate) .. " Triggers"))
    ForEachEntityInGroup(Enable, (("OST_Grate_" .. grate) .. "_Triggers"))
  elseif (dir == "Turnstile") then
    Print("OST_GrateUsed dir == Turnstile")
    AI_SetDisabled(GetOswaldAI(), false)
    ReleaseCamera(CAMERA_LERP_TRANSITION, 1, GetPlayer())
    spline_pos = 0.5
    wait(0.20000000298023224)
    UnrestrictCutSceneInput()
    UnrestrictCutSceneInput()
  else
    if (grate ~= "Outside") then
    end
    Print((("Function OST_GrateUsed: Enabling " .. grate) .. " Triggers"))
    ForEachEntityInGroup(Enable, (("OST_Grate_" .. grate) .. "_Triggers"))
  end
  SplineFollower_StopAtPosition(target, ("SK1_OST_Grate_" .. grate), ("SK2_OST_Grate_" .. grate), spline_pos)
  return 
end
OST_Grate_Transition = function(target, grate, starting_knot, ...)
  Print(("OST_Grate_Transition OST_GrateDirection = " .. OST_GrateDirection))
  if (GetPropertyInt("OST_Door_To_RBC", "Active Sequence ID") == 3) then
    DestroyEntity("ost_center_01b_ostowndecaccess.PlayerHintMarkers_HackTraining")
  end
  if (starting_knot == "2") then
    Print(("OST_Grate_Transition starting_knot = " .. starting_knot))
    OST_GrateDirection = 0
  else
    Print(("OST_Grate_Transition starting_knot = " .. starting_knot))
    OST_GrateDirection = 1
  end
  Print(("OST_Grate_Transition OST_GrateDirection = " .. OST_GrateDirection))
  local OST_DEC_Layer2_State = GetGlobal("OST_DEC_Layer2_State")
  local pos = ((0.25 * tonumber(starting_knot)) + ((tonumber(starting_knot) - 1) * 0.25))
  local pos2 = 0.5
  if (grate == "Outside") then
    pos = 0.25
    pos2 = 0
  elseif (grate == "Layer2") then
    if (0 < OST_DEC_Layer2_State) then
      pos2 = 0.6899999976158142
    end
  end
  local Layer1IntroPlaying = false
  local OST_Center_Play_sfx_GrateElevator_End = function(grate)
    local waitTime = 2.5999999046325684
    if (grate == "Layer2") then
      if (0 < OST_DEC_Layer2_State) then
        waitTime = 4.5
      end
    end
    Wait(waitTime)
    AudioPostEventOn(GetPlayer(), "Play_sfx_GrateElevator_End")
    return 
  end
  if (target == "CheckpointLoad") then
    SetPropertyFloat(("SK1_OST_Grate_" .. grate), "MainPathTime", 0.10000000149011612, 0)
    SplineFollower_SetDisabled(("SF_Grate_" .. grate), false)
    SplineFollower_StopAtPosition(("SF_Grate_" .. grate), ("SK1_OST_Grate_" .. grate), ("SK2_OST_Grate_" .. grate), pos2)
    Wait(0.10000000149011612)
    SetPropertyFloat(("SK1_OST_Grate_" .. grate), "MainPathTime", 10, 0)
    if (grate == "Layer3") then
      FireUser1("OST_Layer3_Crusher")
      FireUser3("OST_Layer3_Crusher")
      FireUser4("OST_Layer3_Crusher")
    end
  else
    OST_grateBeingHeld = false
    local _player = GetPlayer()
    StopAbility(_player, "CoopMove")
    StopAbility(GetPlayer2OrAI(), "CoopMove")
    RestrictCutSceneInput()
    local args = {}
    local cam_dir = "Up"
    local cam_num = 1
    if (starting_knot ~= nil) then
      if (starting_knot == "1") then
        cam_dir = "Down"
      end
    end
    if (args[1] ~= "Object") then
      Print("OST_Grate_Transition args[1] = None")
      EnableSplitScreen(false)
      GrabCamera((((("OST_Grate_Cam_To" .. grate) .. "_") .. cam_dir) .. cam_num), nil, CAMERA_LERP_TRANSITION, 0, _player)
      cam_num = (cam_num + 1)
      wait(1.75)
      StartFadeOut(0.800000011920929)
      wait(0.8999999761581421)
      TeleportToEntity(_player, "OST_Grate_Outside_Player1", true, true)
      TeleportToEntity(GetPlayer2OrAI(), "OST_Grate_Outside_Player2", true, true)
      Wait(0.10000000149011612)
      if (grate == "Outside") then
        AudioEffectStop("ost_center_audio.Snd_reverb")
        if (GetGlobal("EM2_EpisodeCheck") == 1) then
          LevelManager_SetCurrentState("OST_Center.Main_Visit1")
          LevelManager_SetZoneStatusActive("OST_Center.Visit1_AI")
        else
          LevelManager_SetCurrentState("OST_Center.Main_Visit2")
          LevelManager_SetZoneStatusActive("OST_Center.Visit2_AI")
          LevelManager_SetCurrentState("OST_Center.Main")
          if (grate == "Layer1") then
            LevelManager_SetZoneStatusActive("OST_Center.OST_int_DEC_Access")
          elseif (grate == "Layer2") then
            LevelManager_SetZoneStatusActive("OST_Center.OST_int_MaintAccess")
          elseif (grate == "Layer3") then
            LevelManager_SetCurrentState("OST_Center.Main")
            LevelManager_SetZoneStatusActive("OST_Center.OST_int_MaintOverflow")
          end
        end
      else
        LevelManager_SetCurrentState("OST_Center.Main")
        if (grate == "Layer1") then
          LevelManager_SetZoneStatusActive("OST_Center.OST_int_DEC_Access")
        elseif (grate == "Layer2") then
          LevelManager_SetZoneStatusActive("OST_Center.OST_int_MaintAccess")
        elseif (grate == "Layer3") then
          LevelManager_SetCurrentState("OST_Center.Main")
          LevelManager_SetZoneStatusActive("OST_Center.OST_int_MaintOverflow")
        end
      end
      WaitForLevelLoad()
      if (grate == "Layer1") then
        AudioEffectStart("ost_center_audio.Snd_reverb")
        FireUser1("OST_Layer1_Crusher")
        AudioPostEventOn(_player, "Mute_OST_CenterMain")
        AudioSetState(_player, "OST_Amb_State", "OST_DecAccess")
        if (2 <= GetGlobal("EM2_EpisodeCheck")) then
          ForEachEntityInGroup(DestroyEntity, "OST_Layer1_Thinner")
          if (GetPropertyInt("OST_Door_To_RBC", "Active Sequence ID") == 0) then
            AnimGBSequence("OST_Door_To_RBC", "RestOpen")
            DestroyEntity("OswaldAction_HackDECAccess")
          end
        end
        SetActiveFullMap("ost_center_shared.MapVolume_OST_Center_DECAccess")
        SetActiveSubMap("ost_center_shared.MapVolume_OST_Center_DECAccess")
      elseif (grate == "Layer2") then
        wait(0.10000000149011612)
        AudioSetState(GetPlayer(), "OST_Amb_State", "OST_MaintAccess")
        AudioPostEventOn("ost_center_01c_maintenanceaccess.OST_pipeMachineDoor_01a_inert 01", "Play_sfx_suction_lp")
        if (0 < OST_DEC_Layer2_State) then
          FireThread(OST_Layer2_RoomChangeState)
        elseif (OST_DEC_Layer2_State == -1) then
          SetGlobal("OST_DEC_Layer2_State", 0)
          InstantRotateToPosition("OST_Zone03_OneShot1", -60)
          InstantRotateToPosition("OST_Zone03_OneShot2", -110)
        end
        SetActiveFullMap("ost_center_shared.MapVolume_OST_Center_MaintenanceAccess")
        SetActiveSubMap("ost_center_shared.MapVolume_OST_Center_MaintenanceAccess")
      elseif (grate == "Layer3") then
        AudioSetState(_player, "OST_Amb_State", "OST_MaintOverflow")
        AudioPostEventOn("ost_center_01d_maintenanceoverflow_audio.Sound_ThinnerSwirl1", "Play_sfx_ThinnerSwirl")
        AudioPostEventOn("ost_center_01d_maintenanceoverflow_audio.Sound_ThinnerSwirl2", "Play_sfx_ThinnerSwirl")
        AudioPostEventOn("ost_center_01d_maintenanceoverflow_audio.Sound_OverflowSuctionTube", "Play_sfx_suction_lp")
        ForEachEntityInGroup(SetPropertyBool, "Layer3_Thinner_Shooters", "Shooter Start Disabled", false)
        FireUser1("OST_Layer3_Crusher")
        FireUser3("OST_Layer3_Crusher")
        FireUser4("OST_Layer3_Crusher")
        if (GetGlobal("OST_Center_MickeyBridgeKnockedDown") == 0) then
          AnimGBSequence("OST_Layer3_OswaldPath_Platform", "rest")
        end
        SetActiveFullMap("ost_center_shared.MapVolume_OST_Center_MaintenanceOverflow")
        SetActiveSubMap("ost_center_shared.MapVolume_OST_Center_MaintenanceOverflow")
      elseif (grate == "Outside") then
        ForEachEntityInGroup(DestroyEntity, "OST_Pool")
        if (-1 < GetGlobal("OST_Moody_Destination")) then
          Hide("OST_Center_NPC_Rigger_Greene")
          Print("OST_Grate_Transition: Rigger Greene Hidden")
        end
        if IsValidHandle("OST_TrainConductor") then
          if (GetGlobal("OST_TrainStation_Destroyed") == 3) then
            DestroyEntity("OST_TrainConductor")
          end
        end
        SetActiveFullMap("ost_center_shared.MapVolume_OST_Center_Main")
        SetActiveSubMap("ost_center_shared.MapVolume_OST_Center_Main_East")
      end
      SetPropertyFloat((("OST_Grate_" .. grate) .. "_Turnstile"), "Activate Radius", 0)
      SetPropertyFloat(("SK1_OST_Grate_" .. grate), "MainPathTime", 0.10000000149011612, 0)
      SplineFollower_SetDisabled(("SF_Grate_" .. grate), false)
      SplineFollower_StopAtPosition(("SF_Grate_" .. grate), ("SK1_OST_Grate_" .. grate), ("SK2_OST_Grate_" .. grate), pos)
      FireThread(OST_Center_Play_sfx_GrateElevator_End, grate)
      Print((("OST_Grate_Transition() Disabling " .. grate) .. " Triggers"))
      ForEachEntityInGroup(Disable, (("OST_Grate_" .. grate) .. "_Triggers"))
      Wait(1)
      TeleportToEntity(_player, (("OST_Grate_" .. grate) .. "_Player1"), true, true)
      TeleportToEntity(GetPlayer2OrAI(), (("OST_Grate_" .. grate) .. "_Player2"), true, true)
      wait(0)
      CameraReset()
      wait(0.10000000149011612)
      SetPropertyFloat(("SK1_OST_Grate_" .. grate), "MainPathTime", 10, 0)
      OST_GrateUsed(("SF_Grate_" .. grate), grate, pos2)
      GrabCamera((((("OST_Grate_Cam_To" .. grate) .. "_") .. cam_dir) .. cam_num), nil, CAMERA_LERP_TRANSITION, 0)
      if (grate == "Layer1") then
        if (cam_dir ~= "Up") then
          if (cam_dir == "Down") then
            if (GetGlobal("OST_DrainCount") == 0) then
              AudioPostEventOn(_player, "Play_sfx_ThinnerDrainMaintAccess")
              SetGlobal("OST_DrainCount", 1)
            end
            AudioPostEventOn(_player, "Stop_MX_OST_Center")
            MusicPostEventOn(_player, "Play_MX_OST_Sub")
            Print("Stopped OST Center music event, started OST Sub music event")
            AudioPostEventOn(_player, "UnMute_OST_DEC_Access")
            if (grate == "Layer2") then
              if (cam_dir == "Up") then
                AudioPostEventOn(_player, "Play_sfx_GrateElevator_End")
              elseif (cam_dir == "Down") then
                if (grate ~= "Layer3") then
                  if (grate == "Outside") then
                    AudioPostEventOn(_player, "Stop_MX_OST_Sub")
                    MusicPostEventOn(_player, "Play_MX_OST_Center")
                    Print("Stopped OST Sub1 music event, started OST Center music event")
                    AudioPostEventOn(_player, "UnMute_OST_CenterMain")
                    AudioPostEventOn(_player, "Mute_OST_DEC_Access")
                  end
                end
              end
            elseif (grate ~= "Layer3") then
              if (grate == "Outside") then
                AudioPostEventOn(_player, "Stop_MX_OST_Sub")
                MusicPostEventOn(_player, "Play_MX_OST_Center")
                Print("Stopped OST Sub1 music event, started OST Center music event")
                AudioPostEventOn(_player, "UnMute_OST_CenterMain")
                AudioPostEventOn(_player, "Mute_OST_DEC_Access")
              end
            end
          end
        end
      elseif (grate == "Layer2") then
        if (cam_dir == "Up") then
          AudioPostEventOn(_player, "Play_sfx_GrateElevator_End")
        elseif (cam_dir == "Down") then
          if (grate ~= "Layer3") then
            if (grate == "Outside") then
              AudioPostEventOn(_player, "Stop_MX_OST_Sub")
              MusicPostEventOn(_player, "Play_MX_OST_Center")
              Print("Stopped OST Sub1 music event, started OST Center music event")
              AudioPostEventOn(_player, "UnMute_OST_CenterMain")
              AudioPostEventOn(_player, "Mute_OST_DEC_Access")
            end
          end
        end
      elseif (grate ~= "Layer3") then
        if (grate == "Outside") then
          AudioPostEventOn(_player, "Stop_MX_OST_Sub")
          MusicPostEventOn(_player, "Play_MX_OST_Center")
          Print("Stopped OST Sub1 music event, started OST Center music event")
          AudioPostEventOn(_player, "UnMute_OST_CenterMain")
          AudioPostEventOn(_player, "Mute_OST_DEC_Access")
        end
      end
      if (grate == "Layer1") then
        if (GetGlobal("OST_Gus_DECAccessEntrance_Played") == 0) then
          GrabCamera("OST_DEC_Intro_Heads", nil, CAMERA_LERP_TRANSITION, 0)
        end
      end
      StartFadeIn()
      Wait(1)
      local skipWait = false
      if (grate == "Layer1") then
        if (GetGlobal("OST_Gus_DECAccessEntrance_Played") == 0) then
          FireSequence("OST_Gus_Shared", "OST_Gus_DECAccessEntrance", 1)
          wait(0.75)
          GrabCamera((((("OST_Grate_Cam_To" .. grate) .. "_") .. cam_dir) .. cam_num), nil, CAMERA_LERP_TRANSITION, 5)
          while true do
            if (not IsAnySequencePlaying()) then
              break
            end
            wait(0.20000000298023224)
          end
          skipWait = true
        end
      elseif (grate ~= "Layer2") then
        if (grate == "Layer3") then
          FireSequence("OST_Gus_v2", "OST_Gus_MaintenanceOverflowEntrance", 1)
        end
      end
      if (not skipWait) then
        wait(2)
      end
      if (GetGlobal("OST_Gus_HackTraining_Start_Played") == 0) then
        if (grate == "Layer1") then
          if (GetPropertyInt("OST_Door_To_RBC", "Active Sequence ID") ~= 3) then
            FireSequence("OST_Center_Marker_Conversation_GusHackTraining", "OST_Gus_HackTraining_Start", 1)
            GrabCamera("OST_DEC_Access_Intro", nil, CAMERA_LERP_TRANSITION, 2)
            while true do
              if (not IsAnySequencePlaying()) then
                break
              end
              wait(0.20000000298023224)
            end
          end
        end
      end
      GrabCamera((((("OST_Grate_Cam_To" .. grate) .. "_") .. cam_dir) .. cam_num), _player, CAMERA_LERP_TRANSITION, 2)
      wait(1.5)
      ForEachEntityInGroup(DestroyEntity, "SF_Grate_ThinnerDrain")
      AI_SetDisabled(GetOswaldAI(), false)
      OswaldStartFollowAction()
      QueueBrainEvent(GetOswaldAI(), BRAIN_Unpause)
      UnrestrictCutSceneInput()
      UnrestrictCutSceneInput()
      ReleaseCamera(CAMERA_SAMEPLACE_TRANSITION, 1, _player)
      ReleaseCamera(CAMERA_SAMEPLACE_TRANSITION, 1, GetPlayer2OrAI())
      EnableSplitScreen(true)
      SetPropertyFloat((("OST_Grate_" .. grate) .. "_Turnstile"), "Activate Radius", 2)
      if (grate == "Layer1") then
        if (GetGlobal("OST_DECAccess_RedChestStage") == 2) then
          SetPropertyBool("OswaldAction_HackBWX", "ActionSpotEnabled", true)
        end
        OST_Center_Checkpoint(_player, "Layer1")
      elseif (grate == "Layer2") then
        OST_Center_Checkpoint(_player, "Layer2")
      elseif (grate == "Layer3") then
        OST_Center_Checkpoint(_player, "Layer3")
      elseif (grate == "Outside") then
        OST_Center_Checkpoint(_player, "Surface")
      end
    end
  end
  return 
end
OST_CrusherCheck = function(target, anim, wait_time)
  if (GetPropertyFloat(target, "Mass") ~= 100) then
    AnimGBReset(target)
    AnimGBSequence(target, anim)
    if (anim == "down") then
      Enable("Trigger_AIAvoidance")
    else
    end
  end
  wait((wait_time / 2))
  if (anim == "down") then
    Disable("Trigger_AIAvoidance")
  else
  end
  wait((wait_time / 2))
  FireUser1(target)
  return 
end
OST_PneumaticTubes = function(target)
  Print(("Entered function: OST_PneumaticTubes, Target: " .. GetName(target)))
  local startSplineFollow = function(piece, splineknot)
    DisableMotion(piece)
    MoveToEntity(splineknot, piece)
    AudioPostEventOn(GetPlayer(), "Play_sfx_PneumaticPipeStatueGrab")
    AudioPostEventOn(GetPlayer(), "Stop_sfx_StatuePieceDrag")
    SplineFollower_TeleportToKnot(piece, splineknot)
    Enable(piece)
    SetPropertyFloat(piece, "UsableRadius", 0)
    return 
  end
  if (GetName(target) == "ost_center_01c_maintenanceaccess.OST_statueArm_01a") then
    Print("Statue piece taken up to surface: OST_statueArm_01_Dynamic")
    startSplineFollow(target, "ost_center_01c_maintenanceaccess.SplineKnot_TubeStart")
    Unhide("OST_statueArm_01_Dynamic_Surface")
    SetGlobal("OST_Center_Statue_Arm1", 1)
  end
  if (GetName(target) == "ost_center_01c_maintenanceaccess.OST_statueArm_02a") then
    Print("Statue piece taken up to surface: OST_statueArm_02_Dynamic")
    startSplineFollow(target, "ost_center_01c_maintenanceaccess.SplineKnot_TubeStart")
    Unhide("OST_statueArm_02_Dynamic_Surface")
    SetGlobal("OST_Center_Statue_Arm2", 1)
  end
  if (GetName(target) == "ost_center_01d_maintenanceoverflow.OST_statueMickeyHead_01a") then
    Print("Statue piece taken up to surface: Oswald_Fountain_MickeyHead")
    startSplineFollow(target, "ost_center_01d_maintenanceoverflow.SplineKnot_TubeStart")
    Unhide("Oswald_Fountain_MickeyHead_Surface")
    SetGlobal("OST_Center_Statue_MickeyHead", 1)
  end
  if (GetName(target) == "ost_center_01d_maintenanceoverflow.OST_statueOswaldHead_01a") then
    Print("Statue piece taken up to surface: Oswald_Fountain_OswaldHead")
    startSplineFollow(target, "ost_center_01d_maintenanceoverflow.SplineKnot_TubeStart")
    Unhide("Oswald_Fountain_OswaldHead_Surface")
    SetGlobal("OST_Center_Statue_OswaldHead", 1)
  end
  OST_GoofyQuestTracker()
  return 
end
OST_GoofyQuestTracker = function(target, checkPointArea)
  if (GetGlobal("OST_Center_Statue_Arm1") == 1) then
    if (Quest_CheckStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_2", Quest_Discovered) == true) then
      Quest_SetStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_2", Quest_Completed, true)
    end
  end
  if (GetGlobal("OST_Center_Statue_Arm2") == 1) then
    if (Quest_CheckStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_3", Quest_Discovered) == true) then
      Quest_SetStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_3", Quest_Completed, true)
    end
  end
  if (GetGlobal("OST_Center_Statue_MickeyHead") == 1) then
    if (Quest_CheckStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_4", Quest_Discovered) == true) then
      Quest_SetStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_4", Quest_Completed, true)
    end
  end
  if Quest_CheckStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_2", Quest_Completed) then
    if Quest_CheckStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_3", Quest_Completed) then
      if Quest_CheckStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_4", Quest_Completed) then
        if Quest_CheckStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_1a", Quest_Discovered) then
          if (GetGlobal("OST_Center_Statue_OswaldHead") == 1) then
            Quest_SetStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_1a", Quest_TurnIn, true)
          end
        end
      end
    end
  end
  if Quest_CheckStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_2", Quest_Completed) then
    if Quest_CheckStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_3", Quest_Completed) then
      if Quest_CheckStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_4", Quest_Completed) then
        if Quest_CheckStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_1b", Quest_Discovered) then
          if (GetGlobal("OST_Center_Statue_MickeyHead") == 1) then
            Quest_SetStatus("Goofys_Fountain_Mishap", "Goofys_Fountain_Mishap_1b", Quest_TurnIn, true)
          end
        end
      end
    end
  end
  if (checkPointArea ~= nil) then
    OST_Center_Checkpoint(nil, checkPointArea)
  end
  return 
end
OST_Layer1_HackTraining = function()
  if (GetPropertyInt("OST_Door_To_RBC", "Active Sequence ID") ~= 3) then
    DestroyEntity("OswaldAction_HackDECAccess")
    AnimGBSequence("OST_Door_To_RBC", "open")
    FireSequence("OST_Center_Marker_Conversation_GusHackTraining", "OST_Gus_HackTraining_Complete", 0)
    OST_Center_Checkpoint(nil, "Layer1")
  end
  return 
end
OST_Layer1_BWXFodderTraining = function(target, state)
  if (state == "Hacked") then
    SetNextPatrolNode(target, "ost_center_01b_ostowndecaccess.PatrolNode_BWXHack02")
    SetPropertyBool("OswaldAction_HackBWX", "ActionSpotEnabled", false)
  elseif (state == "AtNode") then
    SetRotatorMaxSpeed("BWX_Fodder_Valve", 600)
    DestroyEntity("OST_Layer1_Chest_Thinner_Trigger")
    ForEachEntityInGroup(StopEmitters, "OST_Layer1_Chest_ThinnerFX_Left")
    ForEachEntityInGroup(StopEmitters, "OST_Layer1_Chest_ThinnerFX_Right")
    SetGlobal("OST_DECAccess_RedChestStage", 3)
    AudioPostEventOn("ost_center_01b_ostowndecaccess_audio.Steam", "Stop_sfx_Steam_Lp")
    wait(1)
    SetRotatorMaxSpeed("BWX_Fodder_Valve", 0)
    ForEachEntityInGroup(DestroyEntity, "OST_Layer1_Chest_ThinnerFX_Left")
    ForEachEntityInGroup(DestroyEntity, "OST_Layer1_Chest_ThinnerFX_Right")
  end
  return 
end
TEST_OST_RescueDynamicItem = function(target)
  MoveToEntity(target, "Position_FallenDynamic")
  return 
end
OST_Moody_Photo1_MoodysHouse = function(target)
  Print("Entered function: OST_Moody_Photo1_MoodysHouse")
  local before, OST_MoodysHouseAfter = 0, 0
  OST_MoodysHouseAfter = --[[ return 2 of ]] Jigsaw_GetPercentagePainted(target)
  before = Jigsaw_GetPercentagePainted(target)
  Print(("OST_MoodysHouseAfter = " .. OST_MoodysHouseAfter))
  if (OST_MoodysHouseAfter == 1) then
    if (GetGlobal("OST_Moody_Photo1") == 1) then
      Enable("CameraMarker_MoodyPhoto1")
      Print("Enabled photo marker: CameraMarker_MoodyPhoto1")
    end
  elseif (OST_MoodysHouseAfter < 1) then
    Disable("CameraMarker_MoodyPhoto1")
  end
  return 
end
OST_Moody_Photo5_TimerCheck = function()
  if (70 < GetGlobal("OST_ZoneHealth")) then
    Enable("CameraMarker_MoodyPhoto5")
  else
    Disable("CameraMarker_MoodyPhoto5")
  end
  return 
end
OST_HiddenHero_GiantJigsawMickey = function(target)
  Print("Entered function: OST_HiddenHero_GiantJigsawMickey")
  local before, OST_GiantJigsawMickeyAfter = 0, 0
  OST_GiantJigsawMickeyAfter = --[[ return 2 of ]] Jigsaw_GetPercentagePainted(target)
  before = Jigsaw_GetPercentagePainted(target)
  OST_GiantJigsawMickeyAfter = (OST_GiantJigsawMickeyAfter * 10)
  OST_GiantJigsawMickeyAfter = math.floor((OST_GiantJigsawMickeyAfter + 0.5))
  Print(("OST_GiantJigsawMickeyAfter = " .. OST_GiantJigsawMickeyAfter))
  if (OST_GiantJigsawMickeyAfter == 3) then
    if (GetGlobal("MSS_HiddenHeroesQuest") == 1) then
      Enable("ost_center_scripting_photo_hiddenhero_04_HH_PhotoMarker")
    else
      Disable("ost_center_scripting_photo_hiddenhero_04_HH_PhotoMarker")
    end
  end
  Disable("ost_center_scripting_photo_hiddenhero_04_HH_PhotoMarker")
  return 
end
OST_Center_PigFiddleFound = function()
  if (Quest_CheckStatus("Creative_Threedom", "Creative_Threedom_6a", Quest_Discovered) == true) then
    FireSequence("OST_Gus_v2", "OST_Gus_FoundFiddle")
  else
    FireSequence("OST_Gus_v2", "Gus_FoundObject")
  end
  OST_Center_Checkpoint(nil, "Layer3", "true")
  return 
end
OST_Center_GetPlayerCheck = function()
  if (GetNumPlayers() == 1) then
    SetGlobal("EM2_NumberPlayers", 1)
  else
    SetGlobal("EM2_NumberPlayers", 2)
  end
  return 
end
OST_Center_SetGlobal = function(target, global, value)
  SetGlobal(global, tonumber(value))
  return 
end
OST_Center_IncrementGlobal = function(target, global, value)
  SetGlobal(global, (GetGlobal(global) + tonumber(value)))
  return 
end
OST_PrintActivator = function(target)
  Print("Function: OST_PrintActivator")
  Print(("Activator: " .. tostring(GetName(target))))
  return 
end
DEBUG_OST_RadialMenuTeleport = function(target, grate)
  if (grate == "Layer1") then
    LevelManager_SetCurrentState("OST_Center.Main")
    LevelManager_SetZoneStatusActive("OST_Center.OST_int_DEC_Access")
  elseif (grate == "Layer2") then
    LevelManager_SetCurrentState("OST_Center.Main")
    LevelManager_SetZoneStatusActive("OST_Center.OST_int_MaintAccess")
  elseif (grate == "Layer3") then
    LevelManager_SetCurrentState("OST_Center.Main")
    LevelManager_SetZoneStatusActive("OST_Center.OST_int_MaintOverflow")
  end
  return 
end
OST_Center_TEMP_OswaldTeleportThenAction = function(functionname, functionparameter1, positionmarker)
  if (positionmarker == nil) then
    OswaldTeleportToMickeyAction()
  else
    OswaldTeleportToLocationAction(positionmarker)
  end
  FireThread(_G[functionname], functionparameter1)
  return 
end
GoingDownMusicVar = 0
OST_Center_Music_GoingDown = function()
  if (GoingDownMusicVar == 0) then
    DoStinger("Stinger_Moment", 7)
    GoingDownMusicVar = 1
  end
  return 
end
Pump_ChargedTime = 0
OST_Pump_Charging = 0
OST_PoolLevel = 0
OST_GrateDirection = 0
OST_Center_CurrentCheckpointLoc = "Surface"
OST_grateBeingHeld = false
OST_gratePosition = 0
OST_TumblingJump1 = 0
OST_TumblingJump2 = 0
OST_Maintenance_TumblingJumps = function(target, whichJump, state)
  if (whichJump == "1") then
    if (state == "on") then
      OST_TumblingJump1 = 1
      enableJumpVolumeAvailability("TumblingJump1_target")
      if (OST_TumblingJump2 == 1) then
        enableJumpVolumeAvailability("TumblingJump3_target")
      end
    elseif (state == "off") then
      OST_TumblingJump1 = 0
      disableJumpVolumeAvailability("TumblingJump1_target")
      disableJumpVolumeAvailability("TumblingJump3_target")
      if (whichJump == "2") then
        if (state == "on") then
          OST_TumblingJump2 = 1
          enableJumpVolumeAvailability("TumblingJump2_target")
          if (OST_TumblingJump1 == 1) then
            enableJumpVolumeAvailability("TumblingJump3_target")
          end
        elseif (state == "off") then
          OST_TumblingJump2 = 0
          disableJumpVolumeAvailability("TumblingJump2_target")
          disableJumpVolumeAvailability("TumblingJump3_target")
        end
      end
    end
  elseif (whichJump == "2") then
    if (state == "on") then
      OST_TumblingJump2 = 1
      enableJumpVolumeAvailability("TumblingJump2_target")
      if (OST_TumblingJump1 == 1) then
        enableJumpVolumeAvailability("TumblingJump3_target")
      end
    elseif (state == "off") then
      OST_TumblingJump2 = 0
      disableJumpVolumeAvailability("TumblingJump2_target")
      disableJumpVolumeAvailability("TumblingJump3_target")
    end
  end
  return 
end
MST_South_CostumeDecrimenter = function(action)
  if (action == "save") then
    OST_Center_Checkpoint("none", "Surface", "true")
  elseif HasCollectible("Costume_SpatterFlower01") then
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_1b", Quest_Completed, true)
    UseQuestItems("Costume_SpatterFlower01", 1)
  elseif HasCollectible("Costume_SpatterFlower02") then
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_9b", Quest_Completed, true)
    UseQuestItems("Costume_SpatterFlower02", 1)
  elseif HasCollectible("Costume_SpatterFlower03") then
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_10b", Quest_Completed, true)
    UseQuestItems("Costume_SpatterFlower03", 1)
  elseif HasCollectible("Costume_SpatterFlower04") then
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_11b", Quest_Completed, true)
    UseQuestItems("Costume_SpatterFlower04", 1)
  elseif HasCollectible("Costume_SpatterFlower05") then
    Quest_SetStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_12b", Quest_Completed, true)
    UseQuestItems("Costume_SpatterFlower05", 1)
  end
  return 
end
OST_EndMemoriesQuestNodes = function(npc, node)
  Print("End Memories Quest")
  if (npc == "moody") then
    Print("End Moody nodes")
    if (Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_4a", Quest_Completed) ~= true) then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_4a", Quest_Unavailable, false)
    end
    if (Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_3a", Quest_Completed) ~= true) then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_3a", Quest_Unavailable, false)
    end
    if (Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_2a", Quest_Completed) ~= true) then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_2a", Quest_Unavailable, false)
    end
    if (Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_1a", Quest_Completed) ~= true) then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_1a", Quest_Unavailable, false)
    end
    if (node <= "4") then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_5b", Quest_Unavailable, false)
    end
    if (node <= "3") then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_4b", Quest_Unavailable, false)
    end
    if (node <= "2") then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_3b", Quest_Unavailable, false)
    end
    if (node == "1") then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_2b", Quest_Unavailable, false)
    end
    OST_Center_Checkpoint("none", "Surface", "true")
  elseif (npc == "greene") then
    Print("End Green node")
    if (Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_5b", Quest_Completed) ~= true) then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_5b", Quest_Unavailable, false)
    end
    if (Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_4b", Quest_Completed) ~= true) then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_4b", Quest_Unavailable, false)
    end
    if (Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_3b", Quest_Completed) ~= true) then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_3b", Quest_Unavailable, false)
    end
    if (Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_2b", Quest_Completed) ~= true) then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_2b", Quest_Unavailable, false)
    end
    if (Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_1b", Quest_Completed) ~= true) then
      Quest_SetStatus("Thanks_Memories", "Thanks_Memories_1b", Quest_Unavailable, false)
    end
    OST_Center_Checkpoint("none", "Surface", "true")
  end
  return 
end
OST_StatueHeadRescueTrigger = function(target)
  Print(("__Function: OST_StatueHeadRescueTrigger, target: " .. tostring(GetName(_activator()))))
  local toTeleport = "Oswald"
  if (GetName(_activator()) == "ost_center_01d_maintenanceoverflow.OST_statueMickeyHead_01a") then
    Print("__mickey head teleporting to default location!")
    toTeleport = "Mickey"
  else
    Print("__oswald head teleporting to default location!")
  end
  TeleportToEntity(_activator(), (("OST_statue" .. tostring(toTeleport)) .. "Head_TeleportMarker"))
  return 
end
OST_StationConductorDestroy = function(target)
  if (GetGlobal("OST_TrainStation_Destroyed") == 3) then
    DestroyEntity(target)
  end
  return 
end
OST_ToPrescottsArena = function(target)
  DecrementAbilityDisabled(GetPlayer(), "Toss")
  DecrementAbilityDisabled(GetPlayer2OrAI(), "Toss")
  SetupPosition(target)
  return 
end
OST_Center_ResetFallingPlayer = function(target)
  local activator = _activator()
  KillAIAndRescuePlayer(activator)
  if (GetHealth(activator) == 0) then
    FreezeCamera(activator)
  end
  return 
end
