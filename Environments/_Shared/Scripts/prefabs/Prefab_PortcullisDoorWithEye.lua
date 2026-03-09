seenMickey = 0
seenOswald = 0
MickeyInTrigger = 0
OswaldInTrigger = 0
_G.CurrentActivator = _player()
Prefab_OpenPortcullisSetup = function(target)
  Hide(GetRelativePrefabEntity(target, ".LightCone"))
  return 
end
Prefab_OpenPortcullis = function(target)
  Print("Opening the doors!!!")
  if (_activator() == GetPlayer()) then
    seenMickey = 0
    MickeyInTrigger = 0
  else
    seenOswald = 0
    OswaldInTrigger = 0
  end
  local numberSeen = 0
  if (seenMickey == 1) then
    if (GetPropertyBool(GetPlayer(), "Invisible") == false) then
      numberSeen = (numberSeen + 1)
    end
  end
  if (seenOswald == 1) then
    if (GetPropertyBool(GetPlayerOrAI(PLAYER_TWO), "Invisible") == false) then
      numberSeen = (numberSeen + 1)
    end
  end
  if (numberSeen == 0) then
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".Portcullis"), GetRelativePrefabEntity(target, ".PortcullisSK1"), GetRelativePrefabEntity(target, ".PortcullisSK2"), 1)
    AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Alarm", "Stop_sfx_RBF_alarm_lp")
    Hide(GetRelativePrefabEntity(target, ".LightCone"))
  end
  return 
end
Prefab_ClosePortcullisCheck = function(target)
  if (_activator() == _player()) then
    MickeyInTrigger = 1
    Print("I See Mickey")
  else
    Print("I See Oswald")
    OswaldInTrigger = 1
  end
  CurrentActivator = _activator()
  Print("Made it here")
  Prefab_ClosePortcullis(target, _activator())
  Print("Made it here too")
  return 
end
Prefab_ClosePortcullis = function(target, activatedby)
  if (activatedby == GetPlayer()) then
    seenMickey = 1
  elseif (activatedby == GetPlayer2OrAI()) then
    seenOswald = 1
  end
  Print(((("Mickey: " .. seenMickey) .. " Mickey invisible currently returns ") .. tostring(GetPropertyBool(GetPlayer(), "Invisible"))))
  Print(((("Oswald: " .. seenOswald) .. " Oswald invisible currently returns ") .. tostring(GetPropertyBool(GetPlayerOrAI(PLAYER_TWO), "Invisible"))))
  if (GetPropertyBool(activatedby, "Invisible") == false) then
    Print("I see you!")
    AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Alarm", "Play_sfx_RBF_alarm_lp")
    if (activatedby ~= GetOswaldAI()) then
      FireThread(Prefab_BarkWhenCaught, target)
    end
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".Portcullis"), GetRelativePrefabEntity(target, ".PortcullisSK1"), GetRelativePrefabEntity(target, ".PortcullisSK2"), 0)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".RobotEye"), "RotateToEntityDistance", 30)
    SetPropertyEntity(GetRelativePrefabEntity(target, ".RobotEye"), "RotateToEntity", activatedby, 0)
    SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".RobotEye"), 20)
    Unhide(GetRelativePrefabEntity(target, ".LightCone"))
    TimerReset("ConveyorBeltLogicTimerMarker")
    TimerEnable("ConveyorBeltLogicTimerMarker")
  else
    Print("Where are you? I can hear you , but I can't see you!!!!")
    SetPropertyFloat(GetRelativePrefabEntity(target, ".RobotEye"), "RotateToEntityDistance", 0)
  end
  return 
end
Prefab_BarkWhenCaught = function(target)
  local data = GetPrefabData(target)
  if (data.SequenceWhenCaught == "NotSetUp") then
    Print("You forgot to give the prefab something to say!")
  elseif (data.PassedTheEye == false) then
    FireSequence(GetRelativePrefabEntity(target, ".ConversationMarker"), data.SequenceWhenCaught, 1)
  end
  return 
end
Prefab_LoseInvisibility = function(target, character)
  Print("Prefab_LoseInvisibility: Player lost invisibility")
  if (character == GetPlayer()) then
    Print(("Mickey lost invisible: Mickey in trigger currently = " .. MickeyInTrigger))
    if (MickeyInTrigger == 1) then
      CurrentActivator = GetPlayer()
      Prefab_ClosePortcullis("EyeTrigger", character)
    end
  elseif (character == GetPlayer2OrAI()) then
    Print("Oswald lost invisible")
    if (OswaldInTrigger == 1) then
      CurrentActivator = GetPlayer2OrAI()
      Prefab_ClosePortcullis("EyeTrigger", character)
    end
  end
  return 
end
Prefab_MoveConveyor = function(target)
  if (seenMickey ~= 1) then
  end
  SetSplineFollowerInitialSpeed("HallwayCrusherFloor", 3)
  SplineFollower_StopAtPosition("HallwayCrusherFloor", "HallwayElectricSK1", "HallwayElectricSK2", 1)
  AudioPostEventOn("rbc_falls_01_shared_audio.Snd_FloorGrinders", "Play_sfx_rbf_wood_floor_open")
  ActivateNavMeshObstacle("HallwayCrusherFloor", true)
  SetSplineFollowerInitialSpeed("HallwayCrusherFloor", 12)
  SplineFollower_StopAtPosition("HallwayCrusherFloor", "HallwayElectricSK1", "HallwayElectricSK2", 0)
  AudioPostEventOn("rbc_falls_01_shared_audio.Snd_FloorGrinders", "Play_sfx_rbf_wood_floor_close")
  ActivateNavMeshObstacle("HallwayCrusherFloor", false)
  TimerDisable(target)
  return 
end
Prefab_PassedTheEyeNow = function(target)
  GetPrefabData(target).PassedTheEye = true
  return 
end
