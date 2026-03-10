OsTown_Setup = function(location, customFadeIn)
  Print("Enter function: OsTown_Setup: Visit 2")
  if (customFadeIn ~= "GagFactoryLoad") then
    Print("*_*_*_*_*_*_*_*_*_*@@@@ OsTown_Setup: Visit 2 - customFadeIn~=GagFactoryLoad - Starting FadeOut(0)")
    StartFadeOut(0)
  end
  if (GetGlobal("OST_Center_OpeningMoviePlayed") == 0) then
    if (GetGlobal("EM2_EpisodeCheck") == 1) then
      SetGlobal("EM2_EpisodeCheck", 2)
    end
    if (GetGlobal("OST_Center_PoolLowered") == 2) then
      OsTown_Setup_p2("Prescott")
    else
      OsTown_Setup_p2("Goofy")
    end
    SetGlobal("OST_Center_OpeningMoviePlayed", 1)
  end
  SetGlobal("OST_RBC_ExitState", 2)
  if (location == "Surface") then
    if (customFadeIn ~= "GagFactoryLoad") then
      LevelManager_SetZoneStatusActive("OST_Center.Visit2_AI")
      WaitForLevelLoad()
      OST_Center_UnhideBunnyChildren()
      if (GetGlobal("VTL_Oasis_ThreePigsQuest_PigsMissingAgain") == 1) then
        if (GetGlobal("OST_Center_FiddlerPig_Rescued_Played") == 0) then
          Unhide("OST_Center_PigFiddler_Outside")
        end
      end
      if (-1 < GetGlobal("OST_Moody_Destination")) then
        Hide("OST_Center_NPC_Rigger_Greene")
        Print("OsTown_Setup: Rigger Greene Hidden")
      end
    end
  end
  if IsValidHandle("ost_center_main.OST_center_01a_aiObstacle_01a 01") then
    DestroyEntity("ost_center_main.OST_center_01a_aiObstacle_01a 01")
  end
  Prefab_Activate_Doors("EnterInterior_GagFactory", "open")
  SetPropertyFloat("OST_Grate_Outside_Turnstile", "Activate Radius", 2)
  DestroyEntity("OST_Pool")
  ForEachEntityInGroup(DestroyEntity, "OST_Pool_Collision")
  if (customFadeIn == "DEC") then
    Prefab_DECFoopToob_Finish()
  elseif (location == "Surface") then
    if (customFadeIn == "TrainRide") then
      StartFadeIn(0.800000011920929)
    end
    if (tostring(MostRecentCheckpointCallback) ~= "OsTown_Setup_Shared") then
      OST_Center_Checkpoint(nil, "Surface")
    end
  else
    _G[("OST_Center_Setup_" .. location)](customFadeIn)
  end
  AudioPostEventOn("ost_center_audio.PumpCharger", "Play_sfx_PumpCharger_Lp")
  AudioPostEventOn("ost_center_audio.Sound_PipeThinner", "Play_sfx_ThinnerRiverPool")
  MultiPosSoundStart("ost_center_audio.ThinnerPool_control")
  return 
end
OsTown_Setup_p2 = function(state)
  Print(("OsTown_Setup_p2: state = " .. state))
  if (state == "Goofy") then
    local global = GetGlobal("OST_Center_OpeningMoviePlayed")
    for i = 1, 3 do
      DestroyEntity((("Pump" .. i) .. "_Location"))
      Print((("OsTown_Setup_p2: Destroying Entity = Pump" .. i) .. "_Location"))
      SetGlobal((("OST_Pump" .. i) .. "Status"), (i + 3))
      wait(0)
      DisableComponent(("PumpMachine" .. i), "Usable")
      MoveToEntity(("PumpMachine" .. i), (("ost_center_scripting.SplineKnot_PumpPad" .. i) .. "_End"))
      SetFacing(("PumpMachine" .. i), GetFacing((("Pump" .. i) .. "_Rotation")))
      DisableMotion(("PumpMachine" .. i))
      AnimGBSequence(("PumpMachine" .. i), "on")
      SetGlobal("OST_Center_PoolLowered", 1)
      FireThread(Prefab_OswaldElectricSwitch_ChangeState, ("OST_OswaldSwitchTimersLogicTimer" .. i), "FullyCharged")
    end
  elseif (state == "Prescott") then
    Disable("Pump1_Location")
    DisableComponent("PumpMachine1", "Usable")
    MoveToEntity("PumpMachine1", "Pump1_Location")
    SetFacing("PumpMachine1", GetFacing("Pump1_Rotation"))
    DisableMotion("PumpMachine1")
    SetGlobal("OST_Pump1Status", 10)
    ForEachEntityInGroup(Disable, "Pump_Locations")
    for i = 2, 3 do
      StopEmitters(("OST_Pump_ThinnerFX" .. i))
      StartEmitters(("OST_Pump_ThinnerFXHigh" .. i))
    end
  end
  return 
end
OST_Stream_VisitAI = function()
  LevelManager_SetZoneStatusActive("OST_Center.Visit2_AI")
  WaitForLevelLoad()
  return 
end
OST_ExitInterior = function(target)
  LevelManager_SetZoneStatusActive("OST_Center.Visit2_AI")
  WaitForLevelLoad()
  OST_Center_UnhideBunnyChildren()
  if (GetGlobal("VTL_Oasis_ThreePigsQuest_PigsMissingAgain") == 1) then
    if (GetGlobal("OST_Center_FiddlerPig_Rescued_Played") == 0) then
      Unhide("OST_Center_PigFiddler_Outside")
    end
  end
  if (-1 < GetGlobal("OST_Moody_Destination")) then
    Hide("OST_Center_NPC_Rigger_Greene")
    Print("OST_ExitInterior: Rigger Greene Hidden")
  end
  SetInside2DMap(false)
  OST_ExitInterior_ResumeAudio(target)
  return 
end
OST_ExitMoodysHouse_VisitSetup = function(streamAI)
  Print("Function entered: OST_ExitMoodysHouse_VisitSetup, Visit2")
  if streamAI then
    LevelManager_SetZoneStatusActive("OST_Center.Visit2_AI")
    WaitForLevelLoad()
  end
  OST_Center_UnhideBunnyChildren()
  if (-1 < GetGlobal("OST_Moody_Destination")) then
    Hide("OST_Center_NPC_Rigger_Greene")
    Print("OST_ExitMoodysHouse_VisitSetup: Rigger Greene Hidden")
  end
  if (GetGlobal("VTL_Oasis_ThreePigsQuest_PigsMissingAgain") == 1) then
    if (GetGlobal("OST_Center_FiddlerPig_Rescued_Played") == 0) then
      Unhide("OST_Center_PigFiddler_Outside")
    end
  end
  return 
end
OST_ExitMoodysCleanup = function()
  TeleportGremlinOut("Cutscene_Gus")
  StartFadeOut(0.5)
  wait(0.5)
  FireUser3("ExitMoodysGrabCameraFancy2")
  LevelManager_SetZoneStatusActive("OST_Center.Visit2_AI")
  WaitForLevelLoad()
  StartFadeIn(0.5)
  UnrestrictCutSceneInput()
  return 
end
OST_Spawn_GF_Gremlin = function()
  Prefab_EnterInterior_FadeIn("True")
  if (GetGlobal("OST_Clarabelle_Greeting_Played") == 1) then
    if (GetGlobal("OST_Gus_FoundClarabelleFlower_Played") == 0) then
      Prefab_WorldItem_Unhide("OST_ClarabelleFlower")
    end
  end
  return 
end
OST_TEMP_MoveOswald = function(target, switch)
  OswaldStreamAbort()
  OswaldSetPathAction(switch)
  return 
end
OST_Layer2_SpunValves = 0
OST_Layer2_Pipes = 0
local OST_Center_ValvesComplete = {false, false, false}
OST_Layer2_RoomCheck = function(target, state, ...)
  local args = {}
  Print(("OST_Layer2_RoomCheck: state = " .. state))
  if (state == "Valve") then
    local valvenum = args[1]
    SetRotatorMaxSpeed(target, 450)
    if (GetGlobal("OST_DEC_Layer2_State") == 1) then
      SetGlobal("OST_DEC_Layer2_State", 3)
    end
    local pos = GetPosition("Layer2_Thinner")
    local LowerThinner = function(rumble, spline_pos, thinnerdistance, shake)
      Print("OST_Layer2_RoomCheck: LowerThinner()")
      Rumble(GetPlayer(), rumble)
      Rumble(nil, rumble, 1)
      if shake then
        ShakeCamera(1, 5, 0.10000000149011612, 2, 0.02500000037252903, 0.02500000037252903)
      end
      for i = 1, thinnerdistance do
        SetTransformation("Layer2_Thinner", vector4(pos.x, (pos.y - (0.009999999776482582 * i)), pos.z), vector4(0, 0, 0))
        wait(0)
      end
      Print("OST_Layer2_RoomCheck: LowerThinner() DONE")
      return 
    end
    if (OST_Center_ValvesComplete[tonumber(valvenum)] == false) then
      OST_Center_ValvesComplete[tonumber(valvenum)] = true
      Print((("OST_Layer2_RoomCheck: OST_Center_ValvesComplete[" .. valvenum) .. "] == false"))
      if (valvenum == "1") then
        SetGlobal("OST_Center_FirstValveSpun", 1)
        Enable("SF_RaisingPlatform1")
        AudioPostEventOn(GetPlayer(), "Play_sfx_ThinnerDrain0200")
        FireThread(LowerThinner, 0.33000001311302185, 0.5600000023841858, 200, true)
      elseif (valvenum == "2") then
        SetGlobal("OST_Center_SecondValveSpun", 1)
        SplineKnotComponent_SetBranchProbability("SK4_OST_Layer2_Platform1", 1)
        Enable("SF_RaisingPlatform2")
        AudioPostEventOn(GetPlayer(), "Play_sfx_ThinnerDrain0200")
        FireThread(LowerThinner, 0.6600000262260437, 0.6100000143051147, 200, true)
      elseif (valvenum == "3") then
        if (GetGlobal("OST_DEC_Layer2_State") == 0) then
          SetGlobal("OST_DEC_Layer2_State", 2)
        end
        ShakeCamera(1.5, 5, 0.10000000149011612, 2, 0.10000000149011612, 0.10000000149011612)
        AudioPostEventOn(GetPlayer(), "Play_sfx_ThinnerDrain0600")
        FireThread(OST_Layer2_RoomChangeState, "Thinner")
        LowerThinner(1.5, 0.6100000143051147, 0, false)
      end
      StartEmitters((("Layer2_Pipe" .. valvenum) .. "_ThinnerFX1"))
      Enable((("OST_Layer2_Valve" .. valvenum) .. "_TriggerDamage1"))
      AudioPostEventOn(("ost_center_01c_maintenanceaccess_audio.Sound_Steam" .. valvenum), "Play_sfx_Steam_SS")
    end
    Wait(0.5)
    SetRotatorMaxSpeed(target, 0)
  elseif (state == "Damage") then
    Rumble(GetPlayer(), 0.33000001311302185)
    Rumble(nil, 0.33000001311302185, 1)
    ShakeCamera(1, 5, 0.10000000149011612, 2, 0.02500000037252903, 0.02500000037252903)
    SetRotatorMaxSpeed(target, 450)
    wait(1.25)
    if (GetHealth(target) == 1) then
      SetRotatorMaxSpeed(target, 0)
    end
  elseif (state == "Thinned") then
    OST_Layer2_Pipes = (OST_Layer2_Pipes - 1)
    Print(OST_Layer2_Pipes)
    if (OST_Layer2_Pipes < 6) then
      AnimGBSequence("OST_Layer2_PipeConnectedDoor", "close")
      SetPropertyBool("OswaldAction_Toss", "ActionSpotEnabled", false)
    end
  else
    Print("_******************************** OST_Layer2_PipeCheck()")
    OST_Layer2_Pipes = (OST_Layer2_Pipes + 1)
    Print(OST_Layer2_Pipes)
    if (OST_Layer2_Pipes == 6) then
      AnimGBSequence("OST_Layer2_PipeConnectedDoor", "open")
      SetPropertyBool("OswaldAction_Toss", "ActionSpotEnabled", true)
    end
    if (args[1] ~= nil) then
      if (GetPropertyFloat(("SF_Raising" .. args[1]), "Mass") == 100) then
        SetPropertyFloat(("SF_Raising" .. args[1]), "Mass", 10)
      end
      FireUser2(("SF_Raising" .. args[1]))
    end
  end
  return 
end
OST_Layer2_PipeStateChange = function(target, state)
  if (state == "Painted") then
    Enable("SF_RaisingPlatform1")
    enableJumpVolumeAvailability("OST_Center_prefab_jumpvolmovingplatform_firstPlatform_TargetToSend")
    SetSplineFollowerInitialSpeed("SF_RaisingPlatform1", 2)
    SplineKnotComponent_SetBranchProbability("SK2_OST_Layer2_Platform1", 1)
    if (GetGlobal("OST_DEC_Layer2_State") == 0) then
      if (GetGlobal("OST_Center_SecondValveSpun") == 0) then
        SetPropertyFloat("SK4_OST_Layer2_Platform1", "HoldTime", 3)
        SplineKnotComponent_SetBranchProbability("SK4_OST_Layer2_Platform1", 0)
      end
    end
  elseif (state == "Thinned") then
    if (GetGlobal("OST_Center_FirstValveSpun") == 0) then
      Disable("SF_RaisingPlatform1")
    else
      disableJumpVolumeAvailability("OST_Center_prefab_jumpvolmovingplatform_firstPlatform_TargetToSend")
    end
    SetSplineFollowerInitialSpeed("SF_RaisingPlatform1", 4)
    SplineKnotComponent_SetBranchProbability("SK2_OST_Layer2_Platform1", 0)
    SetPropertyFloat("SK4_OST_Layer2_Platform1", "HoldTime", 0)
    SplineKnotComponent_SetBranchProbability("SK4_OST_Layer2_Platform1", 1)
  end
  return 
end
OST_Layer2_StartPipeFX = function(target, FX_num)
  for i = 1, 4 do
    StopEmitters(((("Layer2_Pipe" .. FX_num) .. "_ThinnerFX") .. i))
    local next_FX = i
    if (i ~= 4) then
      next_FX = (i + 1)
    end
    StartEmitters(((("Layer2_Pipe" .. FX_num) .. "_ThinnerFX") .. next_FX))
    Enable(((("OST_Layer2_Valve" .. FX_num) .. "_TriggerDamage") .. next_FX))
    wait(2)
    if (OST_Layer2_SpunValves ~= 4) then
    end
  end
  return 
end
OST_Layer2_RoomChangeState = function(state)
  Enable("SF_RaisingPlatform2")
  SplineKnotComponent_SetBranchProbability("SK4_OST_Layer2_Platform1", 1)
  if IsValidHandle("OST_Center_OST_Grate_Layer2_Trigger_ReverseTurnstile") then
    DestroyEntity("OST_Center_OST_Grate_Layer2_Trigger_ReverseTurnstile")
  end
  SplineFollower_StopAtPosition("SF_Grate_Layer2", "SK1_OST_Grate_Layer2", "SK2_OST_Grate_Layer2", 0.6899999976158142)
  local LowerThinner = function(lowerDistance)
    local pos = GetPosition("Layer2_Thinner")
    Enable("OST_Center_TriggerBase_TurnstileAIObstacle")
    for i = 1, lowerDistance do
      SetTransformation("Layer2_Thinner", vector4(pos.x, (pos.y - (0.05000000074505806 * i)), pos.z), vector4(0, 0, 0))
      wait(0)
    end
    return 
  end
  enableJumpVolumeAvailability("tumblerJumpDown_target")
  enableJumpVolumeAvailability("OST_Center_prefab_jumpvolmovingplatform_firstPlatform_TargetToSend")
  if (state == "Paint") then
    DoStinger("Comment_Rest", 22)
    AudioPostEventOn(GetPlayer(), "Play_sfx_ThinnerDrain1000")
    LowerThinner(1000)
  elseif (state == "Thinner") then
    DoStinger("Comment_Dest", 22)
    LowerThinner(320)
    AnimGBSequence("OST_Layer2_BWX_SpawnerDoor", "open")
    Enable("Spawner_Blotworx")
    LowerThinner(280)
    ForEachEntityInGroup(DestroyEntity, "Layer2_Thinner_Collision")
    DestroyEntity("Layer2_Thinner")
    while true do
      if (not IsValidHandle("Layer2_Thinner_Collision")) then
        break
      end
      wait(0.20000000298023224)
    end
    GoToEntity("OST_Center_RangedBlotworx", "OST_Center_Marker_BlotworkGoTo")
  end
  OST_Center_Checkpoint(nil, "Layer2")
  return 
end
OST_Layer2_OswaldHack = function()
  DestroyEntity("OswaldAction_ReprogramBox")
  local door_AnimID = GetPropertyInt("OST_Layer2_TerminalGate", "Active Sequence ID")
  if (door_AnimID == 0) then
    AnimGBSequence("OST_Layer2_TerminalGate", "open")
    ActivateNavMeshObstacle("OST_Layer2_TerminalGate", false)
  end
  if (GetGlobal("OST_DEC_Layer2_State") == 0) then
    SetGlobal("OST_DEC_Layer2_State", 1)
  elseif (GetGlobal("OST_DEC_Layer2_State") == 2) then
    SetGlobal("OST_DEC_Layer2_State", 4)
  end
  OST_Layer2_RoomChangeState("Paint")
  return 
end
OST_Layer2_RaisePlatforms = function(target, platform, state, ...)
  local args = {}
  local OST_Layer2_EnablePlatformTrigger = function(mass, wait_time)
    SetPropertyFloat(("SF_Raising" .. platform), "Mass", mass)
    Enable(("SF_Trigger_Raising" .. platform))
    wait(wait_time)
    Disable(("SF_Trigger_Raising" .. platform))
    return 
  end
  local pos = 0
  if (OST_Layer2_SpunValves == 4) then
    local platform_num = string.sub(platform, -1)
    pos = ((8 - (tonumber(platform_num) * 2)) / 10)
    SplineFollower_StopAtPosition(("SF_Raising" .. platform), ("SK1_OST_Layer2_" .. platform), ("SK2_OST_Layer2_" .. platform), pos)
    for i = 1, 4 do
      StartEmitters(((("Layer2_Pipe" .. platform_num) .. "_ThinnerFX") .. i))
      Enable(((("OST_Layer2_Valve" .. platform_num) .. "_TriggerDamage") .. i))
    end
    return 
  end
  SplineFollower_SetDisabled(("SF_Raising" .. platform), false)
  if (state == "Raise") then
    if (GetPropertyFloat(("SK1_OST_Layer2_" .. platform), "MainPathTime") == 2) then
      pos = 0.9200000166893005
    end
    FireThread(OST_Layer2_StartPipeFX, nil, string.sub(platform, -1))
    pos = ((8 - OST_Layer2_SpunValves) / 10)
    SplineFollower_StopAtPosition(("SF_Raising" .. platform), ("SK1_OST_Layer2_" .. platform), ("SK2_OST_Layer2_" .. platform), pos)
  end
  if (state == "Lower") then
    if (platform == "Platform3") then
      SplineFollower_StopAtPosition(("SF_Raising" .. platform), ("SK1_OST_Layer2_" .. platform), ("SK2_OST_Layer2_" .. platform), 0.22499999403953552)
    else
      SplineFollower_StopAtPosition(("SF_Raising" .. platform), ("SK1_OST_Layer2_" .. platform), ("SK2_OST_Layer2_" .. platform), 0)
      if (state == "Reset") then
        pos = 0.574999988079071
        if (GetPropertyFloat(("SF_Raising" .. platform), "Mass") == 10) then
          pos = 0
        end
        if (GetPropertyFloat(("SK1_OST_Layer2_" .. platform), "MainPathTime") ~= 2) then
          if (GetPropertyFloat(("SK1_OST_Layer2_" .. platform), "MainPathTime") ~= 6) then
            if (OST_Layer2_SpunValves == 1) then
              pos = 0.41999998688697815
            else
              pos = 0.25
            end
          end
        end
        SplineFollower_StopAtPosition(("SF_Raising" .. platform), ("SK1_OST_Layer2_" .. platform), ("SK2_OST_Layer2_" .. platform), pos)
      end
    end
  elseif (state == "Reset") then
    pos = 0.574999988079071
    if (GetPropertyFloat(("SF_Raising" .. platform), "Mass") == 10) then
      pos = 0
    end
    if (GetPropertyFloat(("SK1_OST_Layer2_" .. platform), "MainPathTime") ~= 2) then
      if (GetPropertyFloat(("SK1_OST_Layer2_" .. platform), "MainPathTime") ~= 6) then
        if (OST_Layer2_SpunValves == 1) then
          pos = 0.41999998688697815
        else
          pos = 0.25
        end
      end
    end
    SplineFollower_StopAtPosition(("SF_Raising" .. platform), ("SK1_OST_Layer2_" .. platform), ("SK2_OST_Layer2_" .. platform), pos)
  end
  if (args[1] ~= nil) then
    if (state == "Raise") then
      if (state == "Raise") then
        if (GetPropertyFloat(("SK1_OST_Layer2_" .. platform), "MainPathTime") == 2) then
          wait(5.5)
          if (platform == "Platform2") then
            wait(3)
          end
        end
        wait(0.5)
        SetPropertyFloat(("SK1_OST_Layer2_" .. platform), "MainPathTime", 5, 0)
      elseif (state == "NoPower") then
        wait(1)
        FireUser1(("SF_Raising" .. platform))
      end
      OST_Layer2_EnablePlatformTrigger(0.15000000596046448, 1.25)
      OST_Layer2_EnablePlatformTrigger(0.4000000059604645, 1.875)
      OST_Layer2_EnablePlatformTrigger(0.75, 0.625)
    end
    if (state == "Reset") then
      if (GetPropertyFloat(("SK1_OST_Layer2_" .. platform), "MainPathTime") == 2) then
        wait(3.25)
        if (GetPropertyFloat(("SK1_OST_Layer2_" .. platform), "MainPathTime") == 6) then
          wait(1.5)
        end
      end
      wait(5.5)
      SetPropertyFloat(("SK1_OST_Layer2_" .. platform), "MainPathTime", 5, 0)
    end
    if (state == "Raise") then
      FireUser1(("SF_Raising" .. platform))
    elseif (state == "Reset") then
      FireUser2(("SF_Raising" .. platform))
    end
  end
  return 
end
OST_Layer2_RaisePlatform_Shake = function(target, platform)
  Print("******** OST_Layer2_RaisePlatform_Shake for the hell of it")
  local Controller_rumble = GetPropertyFloat(("SF_Raising" .. platform), "Mass")
  if (Controller_rumble == 100) then
    Controller_rumble = 0.5
    ShakeCamera(1.5, 5, 0.10000000149011612, 2, 0.10000000149011612, 0.10000000149011612)
  elseif (Controller_rumble == 0.15000000596046448) then
    ShakeCamera(0.5, 5, 0.10000000149011612, 0.5, 0.004999999888241291, 0.004999999888241291)
  elseif (Controller_rumble == 0.4000000059604645) then
    ShakeCamera(0.75, 5, 0.10000000149011612, 2, 0.019999999552965164, 0.019999999552965164)
  elseif (Controller_rumble == 0.75) then
    ShakeCamera(1.5, 5, 0.10000000149011612, 2, 0.05000000074505806, 0.05000000074505806)
  end
  Disable(target)
  Rumble(GetPlayer(), Controller_rumble)
  Rumble(nil, Controller_rumble, 1)
  return 
end
door_AnimState = "closed"
OST_Layer2_Gate_StimulusCheck = function(target, gate, state)
  if (gate == "Terminal") then
    if (GetPropertyFloat(target, "Mass") ~= 100) then
      if (state == "Powered") then
        while true do
          if (not (door_AnimState == "closing")) then
            break
          end
          Wait(0.10000000149011612)
        end
        AnimGBSequence(target, "open")
        ActivateNavMeshObstacle(target, false)
        door_AnimState = "opening"
        Print(("Powered start, door_AnimState = " .. door_AnimState))
        Wait(1.600000023841858)
        door_AnimState = "open"
        Print(("Powered end, door_AnimState = " .. door_AnimState))
      elseif (state == "NoPower") then
        while true do
          if (not (door_AnimState == "opening")) then
            break
          end
          Wait(0.10000000149011612)
        end
        if (GetPropertyFloat(target, "Mass") == 100) then
          return 
        end
        AnimGBSequence(target, "close")
        ActivateNavMeshObstacle(target, true)
        door_AnimState = "closing"
        Print(("NoPower start, door_AnimState = " .. door_AnimState))
        SetPropertyBool("OswaldAction_ReprogramBox", "ActionSpotEnabled", false)
        Wait(1.7999999523162842)
        door_AnimState = "closed"
        Print(("NoPower end, door_AnimState = " .. door_AnimState))
      elseif (state == "PressurePlate") then
        while true do
          if (not (door_AnimState == "closing")) then
            break
          end
          Wait(0.10000000149011612)
        end
        SetPropertyFloat(target, "Mass", 100)
        SetPropertyBool("OswaldAction_ReprogramBox", "ActionSpotEnabled", true)
        Prefab_OswaldElectricSwitch_ChangeState("OST_Center_Switch_TerminalGate_OswaldSwitchSign", "Deactivate")
        FireUser1("Layer2_ReprogramBox")
        AnimGBSequence(target, "open")
        ActivateNavMeshObstacle(target, false)
        door_AnimState = "opening"
        Print(("PressurePlate start, door_AnimState = " .. door_AnimState))
        OswaldStreamAbort()
        DestroyEntity("Layer2_Oswald_OpenDoor")
        Wait(1.600000023841858)
        door_AnimState = "open"
        Print(("PressurePlate end, door_AnimState = " .. door_AnimState))
        if (gate == "BoomarmrangDoor") then
          SetRotatorMaxSpeed("Layer2_Valve_OpenRedChestDoor", 450)
          AnimGBSequence(target, "open")
          wait(3)
          SetRotatorMaxSpeed("Layer2_Valve_OpenRedChestDoor", 0)
        end
      end
    end
  elseif (gate == "BoomarmrangDoor") then
    SetRotatorMaxSpeed("Layer2_Valve_OpenRedChestDoor", 450)
    AnimGBSequence(target, "open")
    wait(3)
    SetRotatorMaxSpeed("Layer2_Valve_OpenRedChestDoor", 0)
  end
  return 
end
OST_Layer3_HallFXPattern = function(target, group)
  Enable(("OST_Layer3_CrusherHall_ThinnerTrigger" .. group))
  ForEachEntityInGroup(StartEmitters, (("OST_Layer3_CrusherHall_ThinnerFX" .. group) .. "_Left"))
  AudioPostEventOn("ost_center_01d_maintenanceoverflow_audio.Sound_SteamBlastLeft", "Play_sfx_Steam_Lp_01")
  wait(1.5)
  ForEachEntityInGroup(StopEmitters, (("OST_Layer3_CrusherHall_ThinnerFX" .. group) .. "_Left"))
  AudioPostEventOn("ost_center_01d_maintenanceoverflow_audio.Sound_SteamBlastLeft", "Stop_sfx_Steam_Lp_01")
  ForEachEntityInGroup(StartEmitters, (("OST_Layer3_CrusherHall_ThinnerFX" .. group) .. "_Right"))
  AudioPostEventOn("ost_center_01d_maintenanceoverflow_audio.Sound_SteamBlastRight", "Play_sfx_Steam_Lp_01")
  wait(1.5)
  ForEachEntityInGroup(StartEmitters, (("OST_Layer3_CrusherHall_ThinnerFX" .. group) .. "_Left"))
  AudioPostEventOn("ost_center_01d_maintenanceoverflow_audio.Sound_SteamBlastLeft", "Play_sfx_Steam_Lp_01")
  wait(2)
  ForEachEntityInGroup(StopEmitters, (("OST_Layer3_CrusherHall_ThinnerFX" .. group) .. "_Left"))
  AudioPostEventOn("ost_center_01d_maintenanceoverflow_audio.Sound_SteamBlastLeft", "Stop_sfx_Steam_Lp_01")
  ForEachEntityInGroup(StopEmitters, (("OST_Layer3_CrusherHall_ThinnerFX" .. group) .. "_Right"))
  AudioPostEventOn("ost_center_01d_maintenanceoverflow_audio.Sound_SteamBlastRight", "Stop_sfx_Steam_Lp_01")
  Disable(("OST_Layer3_CrusherHall_ThinnerTrigger" .. group))
  wait(2)
  _G[("FireUser" .. (tonumber(group) + 2))](target)
  return 
end
pressurePlatesHeld = 0
OST_Layer3_RoomStateCheck = function(target, state)
  Print(("OST_Layer3_RoomStateCheck state, target: " .. tostring(GetName(target))))
  if (state == "OswaldTargetHit") then
    if (GetPropertyFloat("OST_Layer3_OswaldPath_Platform", "Mass") == 1) then
      SetPropertyFloat("OST_Layer3_OswaldPath_Platform", "Mass", 2)
    elseif (GetPropertyFloat("OST_Layer3_OswaldPath_Platform", "Mass") == 2) then
      AnimGBSequence("OST_Layer3_OswaldPath_Platform", "down")
      if (state == "OswaldDoor_Switch") then
        AnimGBSequence("OST_Layer3_OswaldPath_ExitDoor", "open")
        ActivateNavMeshObstacle("OST_Layer3_OswaldPath_ExitDoor", false)
        DestroyEntity("OST_Center_hiddenoswald_action_electricBeamOswaldDoor_Marker_BuddyAIAction_01")
      elseif (state == "OswaldPath_Hack") then
        AnimGBSequence("OST_Layer3_OswaldPath_EnterDoor", "up")
      elseif (state == "Mickey_PP_On") then
        pressurePlatesHeld = (pressurePlatesHeld + 1)
        if (0 < pressurePlatesHeld) then
          AnimGBSequence("OST_Layer3_MickeyPath_Door", "up")
          ActivateNavMeshObstacle("OST_Layer3_MickeyPath_Door", false)
        end
      elseif (state == "Mickey_PP_Off") then
        pressurePlatesHeld = (pressurePlatesHeld - 1)
        if (pressurePlatesHeld == 0) then
          AnimGBSequence("OST_Layer3_MickeyPath_Door", "down")
          ActivateNavMeshObstacle("OST_Layer3_MickeyPath_Door", true)
        end
      elseif (state == "PlaceMickeyHead") then
        Print("State == PlaceMickeyHead")
        DisableMotion(target)
        MoveToEntity(target, "OST_L3_MickeyHeadRotator")
        SetParentEntity(target, "OST_L3_MickeyHeadRotator")
        SetRotatorMaxSpeed("OST_L3_MickeyHeadRotator", 30)
        StartRotateToPosition("OST_L3_MickeyHeadRotator", 90)
      end
    end
  elseif (state == "OswaldDoor_Switch") then
    AnimGBSequence("OST_Layer3_OswaldPath_ExitDoor", "open")
    ActivateNavMeshObstacle("OST_Layer3_OswaldPath_ExitDoor", false)
    DestroyEntity("OST_Center_hiddenoswald_action_electricBeamOswaldDoor_Marker_BuddyAIAction_01")
  elseif (state == "OswaldPath_Hack") then
    AnimGBSequence("OST_Layer3_OswaldPath_EnterDoor", "up")
  elseif (state == "Mickey_PP_On") then
    pressurePlatesHeld = (pressurePlatesHeld + 1)
    if (0 < pressurePlatesHeld) then
      AnimGBSequence("OST_Layer3_MickeyPath_Door", "up")
      ActivateNavMeshObstacle("OST_Layer3_MickeyPath_Door", false)
    end
  elseif (state == "Mickey_PP_Off") then
    pressurePlatesHeld = (pressurePlatesHeld - 1)
    if (pressurePlatesHeld == 0) then
      AnimGBSequence("OST_Layer3_MickeyPath_Door", "down")
      ActivateNavMeshObstacle("OST_Layer3_MickeyPath_Door", true)
    end
  elseif (state == "PlaceMickeyHead") then
    Print("State == PlaceMickeyHead")
    DisableMotion(target)
    MoveToEntity(target, "OST_L3_MickeyHeadRotator")
    SetParentEntity(target, "OST_L3_MickeyHeadRotator")
    SetRotatorMaxSpeed("OST_L3_MickeyHeadRotator", 30)
    StartRotateToPosition("OST_L3_MickeyHeadRotator", 90)
  end
  return 
end
OST_BubbleBurstToonThinner = function()
  local BurstTime = 0
  local CrazyBubbles = 0
  while true do
    while true do
      BurstTime = math.random(3, 5)
      CrazyBubbles = math.random(1, 3)
      Print(((("OST_BubbleBurstToonThinner: BurstTime :" .. BurstTime) .. " and bubble number: ") .. CrazyBubbles))
      StartEmitters(("ThinnerBubble" .. CrazyBubbles))
      wait(6)
      Print("OST_BubbleBurstToonThinner: Thinning toon")
      ForEachEntityInGroup(ForceSketched, ("ToonBridge" .. CrazyBubbles))
      wait(1)
      StopEmitters(("ThinnerBubble" .. CrazyBubbles))
      wait(BurstTime)
    end
    return 
  end
  return 
end
OST_Layer3_bridgeSupportCount = 0
OST_Layer3_LowerMickeyBridge = function(target)
  OST_Layer3_bridgeSupportCount = (OST_Layer3_bridgeSupportCount + 1)
  if (OST_Layer3_bridgeSupportCount == 2) then
    Disable("OST_Center_hiddenoswald_action_boomarmerangMickeyBridge01_Marker_BuddyAIAction_02")
    AnimGBSequence(target, "fall")
    Wait(0.6000000238418579)
    StartEmitters("OST_Center_hutSplash_03a_mickeyBridge")
    ActivateNavMeshObstacle(target, false)
    Enable("OST_Center_hiddenoswald_action_tossMickeyBridge_Marker_BuddyAIAction_01")
    SetGlobal("OST_Center_MickeyBridgeKnockedDown", 1)
    Wait(4)
    StopEmitters("OST_Center_hutSplash_03a_mickeyBridge")
  else
    Disable("OST_Center_hiddenoswald_action_boomarmerangMickeyBridge01_Marker_BuddyAIAction_01")
    Wait(1)
    Enable("OST_Center_hiddenoswald_action_boomarmerangMickeyBridge01_Marker_BuddyAIAction_02")
  end
  return 
end
OST_Center_UnhideBunnyChildren = function()
  Print("Function entered: OST_Center_UnhideBunnyChildren")
  if (10 <= GetGlobal("OST_BunnyQuest_Count")) then
    for i = 1, 3 do
      MoveToEntity("Spawner_BunnyChildrenOutside", ("PM_BunnyChildOutside" .. i))
      AnimVarInt(ForceSpawn("Spawner_BunnyChildrenOutside", 1)[1], VAR_NPC_State, 1)
    end
    Enable("CameraMarker_MoodyPhoto2")
  end
  return 
end

