Prefab_BlotAlleyAirlock_AlwaysSetup = function(target)
  Print("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_AlwaysSetup")
  target = "AirlockKey_Base"
  local data = GetPrefabData(target)
  DisableMotion(target)
  local VisitNum = tonumber(string.sub(LevelManager_GetCurrentState(), 34, 34))
  local SectionNum = tonumber(string.sub(LevelManager_GetCurrentState(), 27, 27))
  ForEachEntityInGroup(DisableMotion, "BlotAlleyFireworks")
  if (VisitNum == 1) then
    Print("__BTA_Airlock: We're in visit 1! Disabling airlock 3rd area switches!")
    Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch3", "Deactivate")
    Disable("Section3_OswaldHint")
  else
    Print("__BTA_Airlock: We're in visit 2!")
    Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch3", "Activate")
    Enable("Section3_OswaldHint")
    DestroyEntity("NOS_BlotAlley_ShortcutBlockers")
  end
  if (SectionNum == 4) then
    SectionNum = 3
  end
  local SectionString = tostring(SectionNum)
  Print(("__BTA_Airlock: Will Change Airlock State To: " .. tostring(SectionString)))
  Prefab_BlotAlleyAirlock_ChangeState(target, SectionString)
  return 
end
Prefab_BlotAlleyAirlock_ChangeState = function(target, _Section)
  Print(("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_ChangeState, _Section: " .. tostring(_Section)))
  target = "AirlockKey_Base"
  local data = GetPrefabData(target)
  SetRotatorMaxSpeed("AirlockKey_Key", 180)
  local NewGlobalValue = tonumber(_Section)
  Print(("__BTA_Airlock: Setting Global To: " .. tostring(NewGlobalValue)))
  SetGlobal(data.BatteryPositionGlobal, NewGlobalValue)
  local VisitNum = tonumber(string.sub(LevelManager_GetCurrentState(), 34, 34))
  Print(("__VisitNum: " .. tostring(VisitNum)))
  if (_Section == "1") then
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section1_Door"), "open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section1_Door2"), "open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section2_Door"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section2_Door2"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section3_Door"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section3_Door2"), "close")
    Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch1", "Deactivate")
    Disable("Section1_OswaldHint")
    Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch2", "Activate")
    Enable("Section2_OswaldHint")
    if (VisitNum ~= 1) then
      Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch3", "Activate")
      Enable("Section3_OswaldHint")
    end
    data.PreviousDoorOpened = 1
    StartRotateToPosition("AirlockKey_Key", 0)
    ForEachEntityInGroup(EnableMotion, "Fireworks_Section1")
  elseif (_Section == "2") then
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section1_Door"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section1_Door2"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section2_Door"), "open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section2_Door2"), "open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section3_Door"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section3_Door2"), "close")
    Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch1", "Activate")
    Enable("Section1_OswaldHint")
    Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch2", "Deactivate")
    Disable("Section2_OswaldHint")
    if (VisitNum ~= 1) then
      Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch3", "Activate")
      Enable("Section3_OswaldHint")
    end
    data.PreviousDoorOpened = 2
    StartRotateToPosition("AirlockKey_Key", -90)
    ForEachEntityInGroup(EnableMotion, "Fireworks_Section2")
  elseif (_Section == "3") then
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section1_Door"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section1_Door2"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section2_Door"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section2_Door2"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section3_Door"), "open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section3_Door2"), "open")
    Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch1", "Activate")
    Enable("Section1_OswaldHint")
    Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch2", "Activate")
    Enable("Section2_OswaldHint")
    if (VisitNum ~= 1) then
      Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch3", "Deactivate")
      Disable("Section3_OswaldHint")
    end
    data.PreviousDoorOpened = 3
    StartRotateToPosition("AirlockKey_Key", -180)
  end
  SetRotatorMaxSpeed("AirlockKey_Key", 45)
  wait(0.5)
  Prefab_BlotAlleyAirlock_UpdateHiddenMickey(_Section)
  return 
end
Prefab_BlotAlleyAirlock_UpdateHiddenMickey = function(doornum)
  local (for index), (for limit), (for step) = 1, 3, 1
  for i = (for index), (for limit), (for step) do
    if (doornum == tostring(i)) then
      Print((("Prefab_BlotAlleyAirlock_UpdateHiddenMickey : DISabling Section" .. tostring(i)) .. "HiddenMickey"))
      DisableComponent((("Section" .. doornum) .. "HiddenMickey"), "Camera Ability Target Component")
    else
      Print(((("Prefab_BlotAlleyAirlock_UpdateHiddenMickey : Global data for #" .. tostring(i)) .. " is ") .. GetGlobal(GetPrefabData((("Section" .. tostring(i)) .. "HiddenMickey")).Global)))
      if (GetGlobal(GetPrefabData((("Section" .. tostring(i)) .. "HiddenMickey")).Global) == 1) then
        Print((("Prefab_BlotAlleyAirlock_UpdateHiddenMickey : enabling Section" .. tostring(i)) .. "HiddenMickey"))
        EnableComponent((("Section" .. tostring(i)) .. "HiddenMickey"), "Camera Ability Target Component")
        Enable((("Section" .. tostring(i)) .. "HiddenMickey"))
      end
    end
  end
  return 
end
Prefab_BlotAlleyAirlock_HandleAnimations = function(target)
  Print("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_HandleAnimations")
  local data = GetPrefabData(target)
  local NewPosition = GetGlobal(data.BatteryPositionGlobal)
  Print(("__BTA_Airlock: NewPosition: " .. tostring(NewPosition)))
  if (NewPosition == 1) then
    Print("__BTA_Airlock: OPENING DOOR 1")
    AudioPostEventOn(GetRelativePrefabEntity(target, ".Section1_Door"), "Play_sfx_BLA_DoorAirlockOpen")
    MusicPostEventOn(GetPlayer(), "Play_MX_BLA")
    AudioPostEventOn(GetPlayer(), "Play_sfx_BLA_amb")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section1_Door"), "open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section1_Door2"), "open")
    Prefab_BlotAlleyAirlock_UpdateHiddenMickey("1")
  elseif (NewPosition == 2) then
    Print("__BTA_Airlock: OPENING DOOR 2")
    MusicPostEventOn(GetPlayer(), "Play_MX_BLA")
    AudioPostEventOn(GetPlayer(), "Play_sfx_BLA_amb")
    AudioPostEventOn(GetRelativePrefabEntity(target, ".Section2_Door"), "Play_sfx_BLA_DoorAirlockOpen")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section2_Door"), "open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section2_Door2"), "open")
    Prefab_BlotAlleyAirlock_UpdateHiddenMickey("2")
  elseif (NewPosition == 3) then
    AudioPostEventOn(GetRelativePrefabEntity(target, ".Section3_Door"), "Play_sfx_BLA_DoorAirlockOpen")
    AudioPostEventOn(GetPlayer(), "Play_sfx_BLA_amb")
    MusicPostEventOn(GetPlayer(), "Play_MX_BLA")
    Print("__BTA_Airlock: OPENING DOOR 3")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section3_Door"), "open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section3_Door2"), "open")
    Prefab_BlotAlleyAirlock_UpdateHiddenMickey("3")
  elseif (NewPosition == 4) then
    Print("__BTA_Airlock: CLOSING DOOR 1")
    AudioPostEventOn(GetRelativePrefabEntity(target, ".Section1_Door"), "Play_sfx_BLA_DoorAirlockClose")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section1_Door"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section1_Door2"), "close")
    Prefab_BlotAlleyAirlock_UpdateHiddenMickey("0")
  elseif (NewPosition == 5) then
    Print("__BTA_Airlock: CLOSING DOOR 2")
    AudioPostEventOn(GetRelativePrefabEntity(target, ".Section2_Door"), "Play_sfx_BLA_DoorAirlockClose")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section2_Door"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section2_Door2"), "close")
    Prefab_BlotAlleyAirlock_UpdateHiddenMickey("0")
  elseif (NewPosition == 6) then
    AudioPostEventOn(GetRelativePrefabEntity(target, ".Section3_Door"), "Play_sfx_BLA_DoorAirlockClose")
    Print("__BTA_Airlock: CLOSING DOOR 3")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section3_Door"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Section3_Door2"), "close")
    Prefab_BlotAlleyAirlock_UpdateHiddenMickey("0")
  end
  return 
end
Prefab_BlotAlleyAirlock_Transition = function(target, _Section, _Visit, _Center)
  Print(((((("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_Transition, _Section: " .. tostring(_Section)) .. ", _Visit: ") .. tostring(_Visit)) .. ", _Center?: ") .. tostring(_Center)))
  local StateToChange = ""
  if (_Center == "Center") then
    StateToChange = ((("nos_blotalley_main.airlock_tocenter_at" .. tostring(_Section)) .. "_v") .. tostring(_Visit))
  elseif (_Center == "AirlockDoor") then
    StateToChange = ((("nos_blotalley_main.section" .. tostring(_Section)) .. "_visit") .. tostring(_Visit))
  end
  Print(("__BTA_Airlock: WILL ATTEMPT TO CHANGE TO STATE: " .. StateToChange))
  LevelManager_SetCurrentState(StateToChange)
  return 
end
Prefab_BlotAlleyAirlock_MoveGate = function(target, _GateNum, _Direction)
  Print(((("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_MoveGate, _GateNum: " .. tostring(_GateNum)) .. ", _Direction: ") .. tostring(_Direction)))
  local data = GetPrefabData(target)
  local Follower = GetRelativePrefabEntity(target, ((".Section" .. tostring(_GateNum)) .. "_GateDoor"))
  local Knot1 = GetRelativePrefabEntity(target, ((".Section" .. tostring(_GateNum)) .. "_GateDoor_Spline1"))
  local Knot2 = GetRelativePrefabEntity(target, ((".Section" .. tostring(_GateNum)) .. "_GateDoor_Spline2"))
  SplineFollower_SetDisabled(Follower, false)
  if (_Direction == "Open") then
    AudioPostEventOn(Follower, "Play_sfx_BLA_GatesUpDown")
    SplineFollower_StopAtPosition(Follower, Knot1, Knot2, 1)
  elseif (_Direction == "Close") then
    AudioPostEventOn(Follower, "Play_sfx_BLA_GatesUpDown")
    SplineFollower_StopAtPosition(Follower, Knot1, Knot2, 0)
  end
  return 
end
Prefab_BlotAlleyAirlock_SwitchStimmed = function(target, _SwitchNum, _StartOrStop)
  Print(((("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_SwitchStimmed, _SwitchNum: " .. tostring(_SwitchNum)) .. ", _StartOrStop: ") .. tostring(_StartOrStop)))
  target = "AirlockKey_Base"
  local data = GetPrefabData(target)
  if (_StartOrStop == "Start") then
    Prefab_BlotAlleyAirlock_MoveGate(target, _SwitchNum, "Open")
    if (data.OnSplineTrack[1] == "False") then
      if (data.OnConstraintTrack[1] == "False") then
        Print("__BTA_Airlock: WE'RE IN THE CENTER, SWITCHING TO A CONSTRAINT TRACK")
        data.OnConstraintTrack[1] = "True"
        data.OnConstraintTrack[2] = tonumber(_SwitchNum)
        Prefab_BlotAlleyAirlock_ChangeTriggerState(target, _SwitchNum)
        wait(0.5)
        Prefab_BlotAlleyAirlock_SwitchKeyTracks(target, _SwitchNum)
      else
        Print("__BTA_Airlock: WE WERE ALREADY ON THE CONSTRAINT TRACK, ONLY RE-ENABLING TRIGGERS")
        Prefab_BlotAlleyAirlock_ChangeTriggerState(target, _SwitchNum)
        if (data.OnSplineTrack[1] == "True") then
          if (data.OnSplineTrack[2] == tonumber(_SwitchNum)) then
            Print((("__BTA_Airlock: STIM STOPPED ON SWITCH: " .. tostring(_SwitchNum)) .. ", GATE WILL NOT RAISE, MAKE SURE IT RAISES WHEN THE KEY REACHES THE CENTER POINT AGAIN"))
          else
            Prefab_BlotAlleyAirlock_MoveGate(target, _SwitchNum, "Close")
            Print("__BTA_Airlock: ENABLING ONLY CENTER TRIGGER, WE QUIT STIMMING THE GATE WHILE THE KEY WAS ON A CONSTRAINT")
            Prefab_BlotAlleyAirlock_ChangeTriggerState(target, "Center")
            Enable(GetRelativePrefabEntity(target, ".CenterTrigger"))
            Prefab_BlotAlleyAirlock_MoveGate(target, _SwitchNum, "Close")
          end
        else
          Print("__BTA_Airlock: ENABLING ONLY CENTER TRIGGER, WE QUIT STIMMING THE GATE WHILE THE KEY WAS ON A CONSTRAINT")
          Prefab_BlotAlleyAirlock_ChangeTriggerState(target, "Center")
          Enable(GetRelativePrefabEntity(target, ".CenterTrigger"))
          Prefab_BlotAlleyAirlock_MoveGate(target, _SwitchNum, "Close")
        end
      end
    end
  elseif (data.OnSplineTrack[1] == "True") then
    if (data.OnSplineTrack[2] == tonumber(_SwitchNum)) then
      Print((("__BTA_Airlock: STIM STOPPED ON SWITCH: " .. tostring(_SwitchNum)) .. ", GATE WILL NOT RAISE, MAKE SURE IT RAISES WHEN THE KEY REACHES THE CENTER POINT AGAIN"))
    else
      Prefab_BlotAlleyAirlock_MoveGate(target, _SwitchNum, "Close")
      Print("__BTA_Airlock: ENABLING ONLY CENTER TRIGGER, WE QUIT STIMMING THE GATE WHILE THE KEY WAS ON A CONSTRAINT")
      Prefab_BlotAlleyAirlock_ChangeTriggerState(target, "Center")
      Enable(GetRelativePrefabEntity(target, ".CenterTrigger"))
      Prefab_BlotAlleyAirlock_MoveGate(target, _SwitchNum, "Close")
    end
  else
    Print("__BTA_Airlock: ENABLING ONLY CENTER TRIGGER, WE QUIT STIMMING THE GATE WHILE THE KEY WAS ON A CONSTRAINT")
    Prefab_BlotAlleyAirlock_ChangeTriggerState(target, "Center")
    Enable(GetRelativePrefabEntity(target, ".CenterTrigger"))
    Prefab_BlotAlleyAirlock_MoveGate(target, _SwitchNum, "Close")
  end
  return 
end
Prefab_BlotAlleyAirlock_SwitchKeyTracks = function(target, _TrackNum)
  Print(("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_SwitchKeyTracks, _TrackNum: " .. tostring(_TrackNum)))
  local data = GetPrefabData(target)
  DisableMotion("AirlockKey_Base")
  local (for index), (for limit), (for step) = 1, 3, 1
  for x = (for index), (for limit), (for step) do
    SetConstraintEntities(("Constraint" .. tostring(x)), nil, nil)
  end
  Print(("__BTA_Airlock: Setting Key to new constraint track: " .. tostring(_TrackNum)))
  TeleportToEntity("AirlockKey_Base", ("Constraint" .. tostring(_TrackNum)))
  local Rotation, Rotation = 0, _TrackNum
  Rotation = 0
  local BoneDirection, BoneDirection = vector4(0, 0, Rotation, 0), 0
  if (_TrackNum == "1") then
    Rotation = 0
    Rotation = 0
    BoneDirection = 0
    BoneDirection = vector4(-1, Rotation, BoneDirection, 0)
  elseif (_TrackNum == "2") then
    Rotation = -90
    Rotation = 0
    BoneDirection = 1
    BoneDirection = vector4(0, Rotation, BoneDirection, 0)
  elseif (_TrackNum == "3") then
    Rotation = -180
    Rotation = 0
    BoneDirection = 0
    BoneDirection = vector4(1, Rotation, BoneDirection, 0)
  end
  Rotation = 45
  SetRotatorMaxSpeed("AirlockKey_Key", Rotation)
  Rotation = Rotation
  StartRotateToPosition("AirlockKey_Key", Rotation)
  Rotation = target
  BoneDirection = Rotation
  FireThread(Prefab_BlotAlleyAirlock_KeyRotating, Rotation, BoneDirection)
  wait(0.10000000149011612)
  Rotation = tostring
  BoneDirection = _TrackNum
  Rotation = Rotation(BoneDirection)
  Rotation = "AirlockKey_Base"
  BoneDirection = nil
  SetConstraintEntities(("Constraint" .. Rotation), Rotation, BoneDirection)
  EnableMotion("AirlockKey_Base")
  Rotation = "GrabbableBoneDirections"
  BoneDirection = BoneDirection
  SetPropertyVector("AirlockKey_Base", Rotation, BoneDirection, 0)
  Rotation = "UsableEffectOffset"
  BoneDirection = BoneDirection
  SetPropertyVector("AirlockKey_Base", Rotation, BoneDirection)
  Rotation = "UsableRadius"
  BoneDirection = 2
  SetPropertyFloat("AirlockKey_Base", Rotation, BoneDirection)
  return 
end
Prefab_BlotAlleyAirlock_KeyRotating = function(target, _Degrees)
  Print(("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_KeyTurning, _Degrees: " .. tostring(_Degrees)))
  local SoundTime = 0
  if (_Degrees ~= 0) then
    SoundTime = ((tonumber(_Degrees) / 45) * -1)
    Print((("__BTA_Airlock: Will wait to stop sound for: " .. tostring(SoundTime)) .. " seconds!"))
  else
    Print("__BTA_Airlock: key will not turn! will play no sound")
  end
  if (SoundTime ~= 0) then
    Print("__BTA_Airlock: starting sound!")
    wait(SoundTime)
    Print("__BTA_Airlock: stopping sound!")
  end
  return 
end
Prefab_BlotAlleyAirlock_PatrolNodeReached = function(target, _PatrolNum)
  Print(("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_PatrolNodeReached, _PatrolNum: " .. tostring(_PatrolNum)))
  Print(("__BTA_Airlock: Oswald reached a node! Shocking Switch: " .. tostring(_PatrolNum)))
  FireThread(OswaldStreamAction, ("Airlock_Switch" .. tostring(_PatrolNum)))
  return 
end
Prefab_BlotAlleyAirlock_MoveToOpenDoor = function(target, _DoorNum)
  Print(("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_MoveToOpenDoor, _DoorNum: " .. tostring(_DoorNum)))
  local data = GetPrefabData(target)
  OverrideSpawnTransform(PLAYER_TWO, GetPosition("TempRespawnMarker"), GetFacing("TempRespawnMarker"))
  Disable(target)
  Enable(GetRelativePrefabEntity(target, ".CenterTrigger"))
  data.OnSplineTrack[1] = "True"
  data.OnSplineTrack[2] = tonumber(_DoorNum)
  data.OnConstraintTrack[1] = "False"
  local OldGlobal = GetGlobal(data.BatteryPositionGlobal)
  SetGlobal(data.BatteryPositionGlobal, (OldGlobal + 3))
  Prefab_BlotAlleyAirlock_HandleFireworks(target, tonumber(OldGlobal), "StreamOut")
  Prefab_BlotAlleyAirlock_HandleAnimations(target)
  if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
    Print("__First Visit! Will not attempt to destroy RV Spatters")
  elseif GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") then
    if (string.sub(LevelManager_GetCurrentState(), -5, -1) == "noian") then
      Print("__We're in NoIan! Dont attempt to kill off spatters!")
    end
  else
    Print(("__Will kill off spatters in section: " .. tostring(OldGlobal)))
    Prefab_RVAIPicker_DestroySpatters("NOS_BlotAlley_RVAIPicker_Spawner", tostring(OldGlobal))
  end
  SetGlobal(data.BatteryPositionGlobal, (tonumber(_DoorNum) + 3))
  Print(("__BTA_Airlock: New Door Position: " .. tostring(GetGlobal(data.BatteryPositionGlobal))))
  FireThread(Prefab_BlotAlleyAirlock_HandleCenterStateSwitch, target, _DoorNum)
  OswaldStreamAbort()
  Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch1", "Deactivate")
  Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch2", "Deactivate")
  Prefab_OswaldElectricSwitch_ChangeState("Airlock_Switch3", "Deactivate")
  Disable("Section1_OswaldHint")
  Disable("Section2_OswaldHint")
  Disable("Section3_OswaldHint")
  Print("__BTA_Airlock: Clearing all constraints!")
  SetPropertyFloat("AirlockKey_Base", "UsableRadius", 0)
  StopAbility(GetPlayer(), "Use")
  StopAbility(GetPlayer2OrAI(), "Use")
  DisableMotion("AirlockKey_Base")
  local (for index), (for limit), (for step) = 1, 3, 1
  for x = (for index), (for limit), (for step) do
    SetConstraintEntities(("Constraint" .. tostring(x)), nil, nil)
  end
  Print("__BTA_Airlock: Enabling Spline follower!")
  EnableComponent("AirlockKey_Base", "SplineFollower")
  wait(0.10000000149011612)
  TeleportToEntity(GetRelativePrefabEntity(target, ((".Knot_Door" .. tostring(_DoorNum)) .. "_1")), GetRelativePrefabEntity(target, (".KnotTeleportMarker_Track" .. tostring(_DoorNum))))
  SplineFollower_TeleportToKnot("AirlockKey_Base", GetRelativePrefabEntity(target, ((".Knot_Door" .. tostring(_DoorNum)) .. "_1")))
  wait(0.10000000149011612)
  Print("__BTA_Airlock: StopAtPosition")
  local Knot1, Knot1 = GetRelativePrefabEntity(target, ((".Knot_Door" .. tostring(_DoorNum)) .. "_1")), "_1"
  Knot1 = tostring
  Knot1 = Knot1(_DoorNum)
  local Knot2, Knot2 = GetRelativePrefabEntity(target, ((".Knot_Door" .. Knot1) .. "_2")), "_2"
  Knot1 = "Fadeout_sfx_BLA_amb"
  AudioPostEventOn(GetPlayer(), Knot1)
  Knot1 = "Fadeout_MX_BLA"
  AudioPostEventOn(GetPlayer(), Knot1)
  Knot1 = Knot1
  Knot2 = Knot2
  SplineFollower_StopAtPosition("AirlockKey_Base", Knot1, Knot2, 1)
  Knot1 = false
  SplineFollower_SetDisabled("AirlockKey_Base", Knot1)
  Knot1 = target
  Knot2 = ".DustFX_Forward"
  StartEmitters(GetRelativePrefabEntity(Knot1, Knot2))
  return 
end
Prefab_BlotAlleyAirlock_HandleCenterStateSwitch = function(target, _DoorNum)
  Print(("__Function: Prefab_BlotAlleyAirlock_HandleCenterStateSwitch, _DoorNum: " .. tostring(_DoorNum)))
  wait(1)
  if (_DoorNum == "1") then
    if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
      Prefab_BlotAlleyAirlock_Transition(target, "s1", "1", "Center")
    elseif GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") then
      if (string.sub(LevelManager_GetCurrentState(), -5, -1) == "noian") then
        Prefab_BlotAlleyAirlock_Transition(target, "s1", "2_noian", "Center")
      end
    else
      Prefab_BlotAlleyAirlock_Transition(target, "s1", "2_ian", "Center")
      if (_DoorNum == "2") then
        if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
          Prefab_BlotAlleyAirlock_Transition(target, "s2", "1", "Center")
        elseif (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 1) then
          if (string.sub(LevelManager_GetCurrentState(), -5, -1) == "noian") then
            Prefab_BlotAlleyAirlock_Transition(target, "s2", "2_noian", "Center")
          end
        else
          Prefab_BlotAlleyAirlock_Transition(target, "s2", "2_ian", "Center")
          if (_DoorNum == "3") then
            if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
              Prefab_BlotAlleyAirlock_Transition(target, "s4", "1", "Center")
            elseif (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 1) then
              if (string.sub(LevelManager_GetCurrentState(), -5, -1) == "noian") then
                Prefab_BlotAlleyAirlock_Transition(target, "s4", "2_noian", "Center")
              end
            else
              Prefab_BlotAlleyAirlock_Transition(target, "s4", "2_ian", "Center")
            end
          end
        end
      elseif (_DoorNum == "3") then
        if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
          Prefab_BlotAlleyAirlock_Transition(target, "s4", "1", "Center")
        elseif (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 1) then
          if (string.sub(LevelManager_GetCurrentState(), -5, -1) == "noian") then
            Prefab_BlotAlleyAirlock_Transition(target, "s4", "2_noian", "Center")
          end
        else
          Prefab_BlotAlleyAirlock_Transition(target, "s4", "2_ian", "Center")
        end
      end
    end
  elseif (_DoorNum == "2") then
    if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
      Prefab_BlotAlleyAirlock_Transition(target, "s2", "1", "Center")
    elseif (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 1) then
      if (string.sub(LevelManager_GetCurrentState(), -5, -1) == "noian") then
        Prefab_BlotAlleyAirlock_Transition(target, "s2", "2_noian", "Center")
      end
    else
      Prefab_BlotAlleyAirlock_Transition(target, "s2", "2_ian", "Center")
      if (_DoorNum == "3") then
        if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
          Prefab_BlotAlleyAirlock_Transition(target, "s4", "1", "Center")
        elseif (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 1) then
          if (string.sub(LevelManager_GetCurrentState(), -5, -1) == "noian") then
            Prefab_BlotAlleyAirlock_Transition(target, "s4", "2_noian", "Center")
          end
        else
          Prefab_BlotAlleyAirlock_Transition(target, "s4", "2_ian", "Center")
        end
      end
    end
  elseif (_DoorNum == "3") then
    if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
      Prefab_BlotAlleyAirlock_Transition(target, "s4", "1", "Center")
    elseif (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 1) then
      if (string.sub(LevelManager_GetCurrentState(), -5, -1) == "noian") then
        Prefab_BlotAlleyAirlock_Transition(target, "s4", "2_noian", "Center")
      end
    else
      Prefab_BlotAlleyAirlock_Transition(target, "s4", "2_ian", "Center")
    end
  end
  return 
end
local TeleportRoom2Spatters = false
Prefab_BlotAlleyAirlock_MoveToCenter = function(target, _DoorNum)
  Print(("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_MoveToCenter, _DoorNum: " .. tostring(_DoorNum)))
  local data = GetPrefabData(target)
  StopEmitters(GetRelativePrefabEntity(target, ".DustFX_Forward"))
  local DoorToOpen = _DoorNum
  if (_DoorNum == "3") then
    DoorToOpen = "4"
  end
  data.Streaming = 1
  Print(("__BTA_Airlock: DID WE COME FROM A DEACTIVE ZONE? PREVIOUS DOOR: " .. tostring(data.PreviousDoorOpened)))
  if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
    local CurrentState = string.sub(LevelManager_GetCurrentState(), -5)
    Print(("__BTA_Airlock: FIRST VISIT in STATE: " .. tostring(CurrentState)))
    if (data.PreviousDoorOpened ~= 1) then
    end
    Print("__BTA_Airlock: WE'RE GOING FROM A DEACTIVE STATE TO THE SAME ACTIVE STATE, NO STREAM TIME WILL HAPPEN!")
    data.Streaming = 0
  else
    local CurrentState, CurrentState = "", "NOS_BlotAlley_VisitNum"
    CurrentState = GetGlobal
    CurrentState = CurrentState("NOS_BlotAlley_IanAngrySecondVisit")
    if (CurrentState == 1) then
      CurrentState = string
      CurrentState = CurrentState.sub
      CurrentState = CurrentState(LevelManager_GetCurrentState(), -5, -1)
      if (CurrentState == "noian") then
        CurrentState = string
        CurrentState = CurrentState.sub
        CurrentState = CurrentState(LevelManager_GetCurrentState(), -11, -7)
        CurrentState = CurrentState
      end
    else
      CurrentState = string
      CurrentState = CurrentState.sub
      CurrentState = CurrentState(LevelManager_GetCurrentState(), -9, -5)
      CurrentState = CurrentState
    end
    CurrentState = Print
    CurrentState(("__BTA_Airlock: SECOND VISIT in STATE: " .. tostring(CurrentState)))
    CurrentState = data.PreviousDoorOpened
    if (CurrentState ~= 1) then
      CurrentState = data.PreviousDoorOpened
      if (CurrentState ~= 2) then
        CurrentState = data.PreviousDoorOpened
      end
    end
    CurrentState = Print
    CurrentState("__BTA_Airlock: WE'RE GOING FROM A DEACTIVE STATE TO THE SAME ACTIVE STATE, NO STREAM TIME WILL HAPPEN!")
    data.Streaming = 0
  end
  data.PreviousDoorOpened = tonumber(_DoorNum)
  Print(("__BTA_Airlock: SETTING PREVIOUS DOOR OPEN TO: " .. tostring(data.PreviousDoorOpened)))
  if (GetGlobal("NOS_BlotAlley_VisitNum") == 1) then
    if (_DoorNum == "1") then
      Prefab_BlotAlleyAirlock_Transition(target, "1", "1", "AirlockDoor")
    elseif (_DoorNum == "2") then
      Prefab_BlotAlleyAirlock_Transition(target, "2", "1_noian", "AirlockDoor")
      if (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 1) then
        if (string.sub(LevelManager_GetCurrentState(), -5, -1) == "noian") then
          Prefab_BlotAlleyAirlock_Transition(target, DoorToOpen, "2_noian", "AirlockDoor")
        end
      else
        Prefab_BlotAlleyAirlock_Transition(target, DoorToOpen, "2_ian", "AirlockDoor")
      end
    end
  elseif (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 1) then
    if (string.sub(LevelManager_GetCurrentState(), -5, -1) == "noian") then
      Prefab_BlotAlleyAirlock_Transition(target, DoorToOpen, "2_noian", "AirlockDoor")
    end
  else
    Prefab_BlotAlleyAirlock_Transition(target, DoorToOpen, "2_ian", "AirlockDoor")
  end
  SetGlobal(data.BatteryPositionGlobal, tonumber(_DoorNum))
  if (LevelManager_GetCurrentState() == "nos_blotalley_main.section2_visit1_noian") then
    TeleportRoom2Spatters = true
  end
  AudioPostEventOn("nos_blotalley_01a_propsscripting.Airlock.Key", "Play_sfx_BLA_LockFidget")
  AnimGBSequence(GetRelativePrefabEntity(target, ".Key"), "turnStart")
  AnimGBSequence(GetRelativePrefabEntity(target, ((".Section" .. tostring(_DoorNum)) .. "_Door")), "turnStart")
  AnimGBSequence(GetRelativePrefabEntity(target, ((".Section" .. tostring(_DoorNum)) .. "_Door2")), "turnStart")
  wait(0.6600000262260437)
  AnimGBSequence(GetRelativePrefabEntity(target, ".Key"), "fidget")
  AnimGBSequence(GetRelativePrefabEntity(target, ((".Section" .. tostring(_DoorNum)) .. "_Door")), "fidget")
  AnimGBSequence(GetRelativePrefabEntity(target, ((".Section" .. tostring(_DoorNum)) .. "_Door2")), "fidget")
  if (data.Streaming == 0) then
    wait(2.5)
  else
    local Zone, Zone = "nos_blotalley_main.", "fidget"
    if (DoorToOpen == "1") then
      Zone = "section1_shared_props"
      Zone = (Zone .. Zone)
    elseif (DoorToOpen == "2") then
      Zone = "section2_shared"
      Zone = (Zone .. Zone)
    elseif (DoorToOpen == "4") then
      Zone = "section4_shared"
      Zone = (Zone .. Zone)
    end
    Zone = "__BTA_Airlock: WAITING FOR STREAMING TO FINISH, WILL WAIT FOR ZONE: "
    Zone = (Zone .. tostring(Zone))
    Print(Zone)
    while true do
      Zone = Zone
      if (not (LevelManager_HasZoneFinishedStreaming(Zone) == false)) then
        break
      end
      Zone = 0.20000000298023224
      wait(Zone)
    end
    while true do
      if (not (LevelManager_WaitingForStreamingSync() == false)) then
        break
      end
      Zone = 0.05000000074505806
      Wait(Zone)
    end
  end
  Print("__BTA_Airlock: STREAMING DONE")
  data.Streaming = 0
  if (LevelManager_GetCurrentState() == "nos_blotalley_main.section4_visit2_ian") then
    Print("__In return visit!")
    if (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
      Print("__Quest started! Will use real bunny suction!")
      LevelManager_SetZoneStatusActive("nos_blotalley_main.bunnysuction_real")
    else
      Print("__Quest not started! Will use dummy bunny suction!")
      LevelManager_SetZoneStatusActive("nos_blotalley_main.bunnysuction_dummy")
      Print("__In visit 1 or not section 4! Dont do anything!")
    end
  end
  Print("__In visit 1 or not section 4! Dont do anything!")
  Prefab_BlotAlleyAirlock_HandleFireworks(target, tonumber(_DoorNum), "StreamIn")
  AudioPostEventOn("nos_blotalley_01a_propsscripting.Airlock.Key", "Play_sfx_BLA_LockOpen")
  AnimGBSequence(GetRelativePrefabEntity(target, ".Key"), "turnEnd")
  AnimGBSequence(GetRelativePrefabEntity(target, ((".Section" .. tostring(_DoorNum)) .. "_Door")), "turnEnd")
  AnimGBSequence(GetRelativePrefabEntity(target, ((".Section" .. tostring(_DoorNum)) .. "_Door2")), "turnEnd")
  wait(0.6600000262260437)
  wait(1.659999966621399)
  AnimGBSequence(GetRelativePrefabEntity(target, ".Key"), "reverse")
  AnimGBSequence(GetRelativePrefabEntity(target, ((".Section" .. tostring(_DoorNum)) .. "_Door")), "reverse")
  AnimGBSequence(GetRelativePrefabEntity(target, ((".Section" .. tostring(_DoorNum)) .. "_Door2")), "reverse")
  wait(1.659999966621399)
  if (LevelManager_GetCurrentState() == "nos_blotalley_main.section2_visit1_noian") then
    Print("__BTA_Airlock: Going to Section 2 in visit 1! Enable spatters and gus hint!")
    TeleportToEntity("Problem3_Spatter1", "Room3_Spatter1_StreamTeleportPosition")
    TeleportToEntity("Problem3_Spatter2", "Room3_Spatter2_StreamTeleportPosition")
    NOS_BlotAlley_HandleHintNodes(nil, "Building")
    ForEachEntityInGroup(EnableMotion, "AI_Section3")
    ForEachEntityInGroup(AI_RegisterForSensor, "AI_Section3", "SeeEnemy")
    ForEachEntityInGroup(AI_RegisterForSensor, "AI_Section3", "SeePlayer")
    ForEachEntityInGroup(AI_RegisterForSensor, "AI_Section3", "HearEnemyFootsteps")
    SetNextPatrolNode("Problem3_Spatter1", "Problem3_SpatterPatrolNode1")
    SetNextPatrolNode("Problem3_Spatter2", "Problem3_SpatterPatrolNode4")
  end
  local FromKnot, FromKnot = GetRelativePrefabEntity(target, ((".Knot_Door" .. tostring(_DoorNum)) .. "_1")), tostring(_DoorNum)
  FromKnot = ".Knot_Door"
  FromKnot = ((FromKnot .. tostring(_DoorNum)) .. "_2")
  local ToKnot, ToKnot = GetRelativePrefabEntity(target, FromKnot), tostring(_DoorNum)
  FromKnot = FromKnot
  ToKnot = "Constraint2"
  TeleportToEntity(FromKnot, ToKnot)
  FromKnot = "AirlockKey_Base"
  ToKnot = FromKnot
  SplineFollower_StopAtPosition(FromKnot, ToKnot, ToKnot, 0)
  FromKnot = GetRelativePrefabEntity
  ToKnot = target
  FromKnot = FromKnot(ToKnot, ".DustFX_Backward")
  StartEmitters(FromKnot)
  FromKnot = 1
  wait(FromKnot)
  FromKnot = Prefab_BlotAlleyAirlock_HandleAnimations
  ToKnot = target
  FireThread(FromKnot, ToKnot)
  FromKnot = PLAYER_TWO
  ClearOverrideSpawnTransform(FromKnot)
  FromKnot = "CHECKPOINT_Section"
  ToKnot = tostring
  ToKnot = ToKnot(DoorToOpen)
  FromKnot = ((FromKnot .. ToKnot) .. "_Airlock")
  NOS_BlotAlley_SaveCheckpoint(FromKnot)
  return 
end
Prefab_BlotAlleyAirlock_KeyReachedCenter = function(target)
  Print("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_KeyReachedCenter")
  local data = GetPrefabData(target)
  Disable(target)
  Prefab_BlotAlleyAirlock_ChangeTriggerState(target, "Center")
  DisableMotion("AirlockKey_Base")
  TeleportToEntity("AirlockKey_Base", "Constraint2")
  DisableComponent("AirlockKey_Base", "SplineFollower")
  if (data.OnSplineTrack[1] == "True") then
    Prefab_BlotAlleyAirlock_MoveGate(target, tostring(data.OnSplineTrack[2]), "Close")
  end
  local VisitNum = tonumber(string.sub(LevelManager_GetCurrentState(), 34, 34))
  Print((("__BTA_Airlock: We just opened door: " .. tostring(data.OnSplineTrack[2])) .. "! Re-enable all switches and hints except that one!"))
  local (for index), (for limit), (for step) = 1, 3, 1
  for x = (for index), (for limit), (for step) do
    if (data.OnSplineTrack[2] == x) then
      Prefab_OswaldElectricSwitch_ChangeState(("Airlock_Switch" .. tostring(x)), "Deactivate")
      Disable((("Section" .. tostring(x)) .. "_OswaldHint"))
    elseif (x == 3) then
      if (VisitNum == 1) then
        Print("__BTA_Airlock: Got to activating switch 3 and it's first visit! Dont activate it!")
      end
    else
      Prefab_OswaldElectricSwitch_ChangeState(("Airlock_Switch" .. tostring(x)), "Activate")
      Enable((("Section" .. tostring(x)) .. "_OswaldHint"))
    end
  end
  data.OnSplineTrack[1] = "False"
  data.OnConstraintTrack[1] = "False"
  SetPropertyFloat("AirlockKey_Base", "UsableRadius", 0)
  StopEmitters(GetRelativePrefabEntity(target, ".DustFX_Backward"))
  return 
end
Prefab_BlotAlleyAirlock_ChangeTriggerState = function(target, _State)
  Print(("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_ChangeTriggerState, _State: " .. tostring(_State)))
  if (_State == "Center") then
    Print("__BTA_Airlock: Disabling Everything!")
    ForEachEntityInGroup(Disable, "Section1Triggers")
    ForEachEntityInGroup(Disable, "Section2Triggers")
    ForEachEntityInGroup(Disable, "Section3Triggers")
  elseif (_State == "1") then
    Print("__BTA_Airlock: Enabling Section1Triggers")
    ForEachEntityInGroup(Enable, "Section1Triggers")
    ForEachEntityInGroup(Disable, "Section2Triggers")
    ForEachEntityInGroup(Disable, "Section3Triggers")
  elseif (_State == "2") then
    Print("__BTA_Airlock: Enabling Section2Triggers")
    ForEachEntityInGroup(Disable, "Section1Triggers")
    ForEachEntityInGroup(Enable, "Section2Triggers")
    ForEachEntityInGroup(Disable, "Section3Triggers")
  elseif (_State == "3") then
    Print("__BTA_Airlock: Enabling Section3Triggers")
    ForEachEntityInGroup(Disable, "Section1Triggers")
    ForEachEntityInGroup(Disable, "Section2Triggers")
    ForEachEntityInGroup(Enable, "Section3Triggers")
  end
  return 
end
Prefab_BlotAlleyAirlock_KeyTriggerEvent = function(target, _DoorNum)
  Print(("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_KeyTriggerEvent, _Num: " .. tostring(_DoorNum)))
  local data = GetPrefabData(target)
  Prefab_BlotAlleyAirlock_MoveToCenter(target, _DoorNum)
  return 
end
Prefab_BlotAlleyAirlock_FireworksAirlockTrigger = function(target, _Direction, _DoorNum)
  Print(((("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_FireworksAirlockTrigger, _Direction: " .. tostring(_Direction)) .. ", _DoorNum: ") .. tostring(_DoorNum)))
  local data = GetPrefabData("AirlockKey_Base")
  local numElements = (#data.FireworksList)
  local FireworksSectionNum = "-1"
  if (_DoorNum ~= "-1") then
    FireworksSectionNum = string.sub(GetPropertyString(_activator(), "EntityGroups", 1), -1, -1)
  end
  Print(("__BTA_Airlock: FireworksSectionNum: " .. tostring(FireworksSectionNum)))
  if (_Direction == "Enter") then
    Print("__BTA_Airlock: Fireworks entered trigger, will add this to the list")
    if (numElements == 1) then
      if (data.FireworksList[1] == "None") then
        Print("__BTA_Airlock: List was empty! Adding to [1]")
        data.FireworksList[1] = GetName(_activator())
      end
    else
      Print("__BTA_Airlock: List was not empty! adding to next available slot")
      table.insert(data.FireworksList, GetName(_activator()))
      if (_Direction == "Exit") then
        Print("__BTA_Airlock: Fireworks left trigger, will remove this from the list")
        if (numElements == 1) then
          Print("__BTA_Airlock: We only have one element, resetting the table!")
          data.FireworksList[1] = "None"
        else
          local (for index), (for limit), (for step) = 1, numElements, 1
          for x = (for index), (for limit), (for step) do
            if (data.FireworksList[x] == GetName(_activator())) then
              Print((("__BTA_Airlock: Found matching fireworks activator at: [" .. tostring(x)) .. "], will remove this one!"))
              table.remove(data.FireworksList, x)
            end
          end
        end
        if (_DoorNum ~= "-1") then
          if (FireworksSectionNum ~= _DoorNum) then
            Print(("__BTA_Airlock: Fireworks Section num doesnt match the current door it's exiting! Changing to Section: " .. tostring(_DoorNum)))
            SetPropertyString(_activator(), "EntityGroups", ("Fireworks_Section" .. tostring(_DoorNum)), 1)
            Print(("__BTA_Airlock: New EntityGroup for this firework: " .. tostring(GetPropertyString(_activator(), "EntityGroups", 1))))
          end
        else
          Print("__BTA_Airlock: _DoorNum was -1! This firework was destroyed")
        end
      end
    end
  elseif (_Direction == "Exit") then
    Print("__BTA_Airlock: Fireworks left trigger, will remove this from the list")
    if (numElements == 1) then
      Print("__BTA_Airlock: We only have one element, resetting the table!")
      data.FireworksList[1] = "None"
    else
      local (for index), (for limit), (for step) = 1, numElements, 1
      for x = (for index), (for limit), (for step) do
        if (data.FireworksList[x] == GetName(_activator())) then
          Print((("__BTA_Airlock: Found matching fireworks activator at: [" .. tostring(x)) .. "], will remove this one!"))
          table.remove(data.FireworksList, x)
        end
      end
    end
    if (_DoorNum ~= "-1") then
      if (FireworksSectionNum ~= _DoorNum) then
        Print(("__BTA_Airlock: Fireworks Section num doesnt match the current door it's exiting! Changing to Section: " .. tostring(_DoorNum)))
        SetPropertyString(_activator(), "EntityGroups", ("Fireworks_Section" .. tostring(_DoorNum)), 1)
        Print(("__BTA_Airlock: New EntityGroup for this firework: " .. tostring(GetPropertyString(_activator(), "EntityGroups", 1))))
      end
    else
      Print("__BTA_Airlock: _DoorNum was -1! This firework was destroyed")
    end
  end
  numElements = (#data.FireworksList)
  Print("__BTA_Airlock: Current Tracked Fireworks:")
  local (for index), (for limit), (for step) = 1, numElements, 1
  for x = (for index), (for limit), (for step) do
    (for index) = Print
    (for limit) = "__BTA_Airlock: Tracked Fireworks["
    (for step) = tostring
    x = x
    (for step) = (for step)(x)
    x = "]: "
    (for limit) = ((((for limit) .. (for step)) .. x) .. tostring(data.FireworksList[x]))
    (for index)((for limit))
  end
  return 
end
Prefab_BlotAlleyAirlock_FireworksDestroyed = function(target)
  Print("__BTA_Airlock: Prefab_BlotAlleyAirlock_FireworksDestroyed")
  Prefab_BlotAlleyAirlock_FireworksAirlockTrigger(target, "Exit", "-1")
  return 
end
Prefab_BlotAlleyAirlock_HandleFireworks = function(target, _Section, _State)
  Print(((("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_HandleFireworks, _Section: " .. tostring(_Section)) .. ", _State: ") .. tostring(_State)))
  ForEachEntityInGroup(Prefab_BlotAlleyAirlock_CheckFireworks, ("Fireworks_Section" .. tostring(_Section)), _State)
  return 
end
Prefab_BlotAlleyAirlock_CheckFireworks = function(target, _State)
  Print(("__BTA_Airlock: Function: Prefab_BlotAlleyAirlock_CheckFireworks, target: " .. tostring(GetName(target))))
  local data = GetPrefabData("AirlockKey_Base")
  local numElements = (#data.FireworksList)
  local (for index), (for limit), (for step) = 1, numElements, 1
  for x = (for index), (for limit), (for step) do
    if (GetName(target) == data.FireworksList[x]) then
      Print("__BTA_Airlock: We're part of the fireworks list! Don't do anything")
    elseif (_State == "StreamOut") then
      Print("__BTA_Airlock: Will disable this firework!")
      DisableMotion(target)
    else
      Print("__BTA_Airlock: Will enable this firework!")
      EnableMotion(target)
    end
  end
  return 
end
Prefab_BlotAlleyAirlock_ResetHandle = function(target)
  Print("__BTA_Airlock: Prefab_BlotAlleyAirlock_ResetHandle")
  local data = GetPrefabData(target)
  if (data.OnConstraintTrack[1] == "True") then
    Print("__We were on the constraint track! Push backwards!")
    local impulseDir = vector4(0, 0, 0, 0)
    if (data.OnConstraintTrack[2] == 1) then
      impulseDir.x = -200000
    elseif (data.OnConstraintTrack[2] == 2) then
      impulseDir.z = 200000
    elseif (data.OnConstraintTrack[2] == 3) then
      impulseDir.x = 200000
    end
    Print(((("__Applying Impulse in Direction: [X]: " .. tostring(impulseDir.x)) .. ", [Z]: ") .. tostring(impulseDir.z)))
    ApplyImpulse(target, impulseDir.x, 0, impulseDir.z)
  end
  return 
end
Prefab_BlotAlleyAirlock_Room3SpattersStreamed = function(target, _Which)
  Print(("__Function: Prefab_BlotAlleyAirlock_Room3SpattersStreamed, _Which: " .. tostring(_Which)))
  local data = GetPrefabData("AirlockKey_Base")
  if (TeleportRoom2Spatters == true) then
    Print("__We're streaming! Do the teleport!")
    TeleportRoom2Spatters = false
    DisableMotion(target)
    AI_UnregisterForSensor(target, "SeeEnemy")
    AI_UnregisterForSensor(target, "SeePlayer")
    AI_UnregisterForSensor(target, "HearEnemyFootsteps")
    ClearNextPatrolNode(target)
    TeleportToEntity(target, (("Room3_Spatter" .. tostring(_Which)) .. "_StreamTeleportPosition"))
  end
  return 
end
