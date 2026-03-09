Prefab_Jugband_AlwaysSetup = function(target)
  Print("___Function: Prefab_Jugband_AlwaysSetup")
  local data = GetPrefabData(target)
  math.randomseed(os.time())
  local (for index), (for limit), (for step) = 1, 6, 1
  for x = (for index), (for limit), (for step) do
    SetR3MTConstReg(GetRelativePrefabEntity(target, (".VolumeLight0" .. tostring(x))), 1, vector4(0.10000000149011612, 0.10000000149011612, 0.10000000149011612, 1))
  end
  if (GetGlobal("NOS_BogEasy_FirstVisit") ~= 1) then
    if (GetGlobal("NOS_BogEasy_JugbandState") == 0) then
      AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Play_SFX_Jugband_Fineas")
      Print("Jugband is neutral - allow 2D music event to play and start Fineas noise")
    elseif (GetGlobal("NOS_BogEasy_JugbandState") == -1) then
      Prefab_Jugband_SetState(target, "Destroyed")
      Disable("JugbandShockMarker")
      Prefab_OswaldElectricSwitch_ChangeState("JugbandShockSwitch", "Deactivate")
      Print("Jugband is broken - allow 2D music event to play")
    elseif (GetGlobal("NOS_BogEasy_JugbandState") == 1) then
      Prefab_Jugband_SetState(target, "Fixed")
      Disable("JugbandShockMarker")
      Prefab_OswaldElectricSwitch_ChangeState("JugbandShockSwitch", "Deactivate")
      Enable("nos_bogeasy_01a_louisshackarea_audio.PlaneTrigger_JugBand_Music_A")
      Enable("nos_bogeasy_01a_louisshackarea_audio.PlaneTrigger_JugBand_Music_B")
      Enable("nos_bogeasy_01a_louisshackarea_audio.Trig_Music_JugbandState")
      Print("Jugband is fixed - enable jugband triggers")
    end
  end
  return 
end
Prefab_Jugband_SetState = function(target, _State)
  Print(("__Function: Prefab_Jugband_SetState, _State: " .. tostring(_State)))
  local data = GetPrefabData(target)
  local LeftMember = GetRelativePrefabEntity(target, ".Fat")
  local MiddleMember = GetRelativePrefabEntity(target, ".Tall")
  local RightMember = GetRelativePrefabEntity(target, ".Short")
  Print(("LeftMember: " .. tostring(GetName(LeftMember))))
  Print(("MiddleMember: " .. tostring(GetName(MiddleMember))))
  Print(("RightMember: " .. tostring(GetName(RightMember))))
  if (_State == "Fixed") then
    Print("__JUGBAND WAS FIXED!")
    data.CurrentPositions[1] = ".Fat"
    data.CurrentPositions[2] = ".Tall"
    data.CurrentPositions[3] = ".Short"
    data.VolumeLevel[1] = 6
    local (for index), (for limit), (for step) = 1, 6, 1
    for x = (for index), (for limit), (for step) do
      if (x == 1) then
        SetR3MTConstReg(GetRelativePrefabEntity(target, (".VolumeLight0" .. tostring(x))), 1, vector4(0, 1, 0, 1))
      end
      if (x == 3) then
        SetR3MTConstReg(GetRelativePrefabEntity(target, (".VolumeLight0" .. tostring(x))), 1, vector4(1, 1, 0, 1))
      end
      if (x == 5) then
        SetR3MTConstReg(GetRelativePrefabEntity(target, (".VolumeLight0" .. tostring(x))), 1, vector4(1, 0, 0, 1))
      end
    end
    data.CurrentState = "Fixed"
    Prefab_Jugband_DisplayVolume(target)
    SplineFollower_TeleportToKnot(LeftMember, GetRelativePrefabEntity(target, ".SwitchKnot1"))
    SplineFollower_TeleportToKnot(MiddleMember, GetRelativePrefabEntity(target, ".SwitchKnot2"))
    SplineFollower_TeleportToKnot(RightMember, GetRelativePrefabEntity(target, ".SwitchKnot3"))
    AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_JugBandSteam1", "Stop_sfx_JugBandSteam")
    AnimGBSequence(LeftMember, "playCorrect")
    AnimGBSequence(MiddleMember, "playCorrect")
    AnimGBSequence(RightMember, "playCorrect")
    Enable("nos_bogeasy_01a_louisshackarea_audio.PlaneTrigger_JugBand_Music_A")
    Enable("nos_bogeasy_01a_louisshackarea_audio.PlaneTrigger_JugBand_Music_B")
    StartEmitters(GetRelativePrefabEntity(target, ".MusicFX"))
  elseif (_State == "Destroyed") then
    Print("__JUGBAND WAS DESTROYED!")
    StartEmitters(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".SteamSpray1"))
    StartEmitters(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".SteamSpray2"))
    StartEmitters(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".SteamSpray3"))
    AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_JugBandSteam1", "Play_sfx_JugBandSteam")
    AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_JugBandSteam2", "Play_sfx_JugBandSteam")
    AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_JugBandSteam3", "Play_sfx_JugBandSteam")
    AnimGBSequence(LeftMember, "explode")
    AnimGBSequence(MiddleMember, "explode")
    AnimGBSequence(RightMember, "explode")
    data.CurrentState = "Broken"
    DestroyEntity("NOS_BogEasy_Ghost_Rolly")
    DestroyEntity("NOS_BogEasy_Ghost_Fineas")
  end
  return 
end
Prefab_Jugband_SwitchPressed = function(target, _event)
  Print("__Function: Prefab_Jugband_SwitchPressed")
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 1) then
    FireSequence("NOS_BogEasy_Gus", "NOS_Gus_JugbandBroken")
    return 
  end
  if StimulusEvent_HasStimulusType(_event, ST_SPIN) then
    local data = GetPrefabData(target)
    if (data.CurrentState == "Stopped") then
      data.CurrentState = "Moving"
      if (data.FineasAnimating == 0) then
        Print("__Set Fineas to animate!")
        FireThread(Prefab_Jugband_FineasAnimation, target)
      end
      Prefab_OswaldElectricSwitch_ChangeState("JugbandShockSwitch", "Deactivate")
      Disable("JugbandShockMarker")
      AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Snd_JugBand_Switch", "Play_sfx_JugBandRotate")
      if (data.SwitchSide == "Right") then
        SplineKnotComponent_SetBranchProbability(GetRelativePrefabEntity(target, ".SwitchKnot5"), 1)
        AnimGBSequence(GetRelativePrefabEntity(target, ".Switch"), "right")
      else
        SplineKnotComponent_SetBranchProbability(GetRelativePrefabEntity(target, ".SwitchKnot5"), 0)
        AnimGBSequence(GetRelativePrefabEntity(target, ".Switch"), "left")
      end
      local LeftMember = GetRelativePrefabEntity(target, data.CurrentPositions[1])
      local MiddleMember = GetRelativePrefabEntity(target, data.CurrentPositions[2])
      local RightMember = GetRelativePrefabEntity(target, data.CurrentPositions[3])
      data.CurrentMoveDisabler = GetName(RightMember)
      Print(("__Gator To Disable SplineFollowers: " .. tostring(data.CurrentMoveDisabler)))
      Print("__Before Move Values__")
      Print((((((("__[" .. tostring(data.CurrentPositions[1])) .. "] [") .. tostring(data.CurrentPositions[2])) .. "] [") .. tostring(data.CurrentPositions[3])) .. "]"))
      local FlipFlop = data.CurrentPositions[3]
      if (data.SwitchSide == "Right") then
        data.CurrentPositions[3] = data.CurrentPositions[2]
        data.CurrentPositions[2] = FlipFlop
      else
        data.CurrentPositions[3] = data.CurrentPositions[2]
        data.CurrentPositions[2] = data.CurrentPositions[1]
        data.CurrentPositions[1] = FlipFlop
      end
      Print("__After Move Values__")
      Print((((((("__[" .. tostring(data.CurrentPositions[1])) .. "] [") .. tostring(data.CurrentPositions[2])) .. "] [") .. tostring(data.CurrentPositions[3])) .. "]"))
      if (data.SwitchSide == "Right") then
        SplineFollower_SetDisabled(MiddleMember, false)
        SplineFollower_SetDisabled(RightMember, false)
        SplineFollower_StopAtPosition(MiddleMember, GetRelativePrefabEntity(target, ".SwitchKnot2"), GetRelativePrefabEntity(target, ".SwitchKnot3"), 1)
        SplineFollower_StopAtPosition(RightMember, GetRelativePrefabEntity(target, ".SwitchKnot3"), GetRelativePrefabEntity(target, ".SwitchKnot2"), 1)
      else
        SplineFollower_SetDisabled(LeftMember, false)
        SplineFollower_SetDisabled(MiddleMember, false)
        SplineFollower_SetDisabled(RightMember, false)
        SplineFollower_StopAtPosition(LeftMember, GetRelativePrefabEntity(target, ".SwitchKnot1"), GetRelativePrefabEntity(target, ".SwitchKnot2"), 1)
        SplineFollower_StopAtPosition(MiddleMember, GetRelativePrefabEntity(target, ".SwitchKnot2"), GetRelativePrefabEntity(target, ".SwitchKnot3"), 1)
        SplineFollower_StopAtPosition(RightMember, GetRelativePrefabEntity(target, ".SwitchKnot3"), GetRelativePrefabEntity(target, ".SwitchKnot1"), 1)
      end
      if (data.CurrentPositions[1] == ".Fat") then
        if (data.CurrentPositions[2] == ".Tall") then
          if (data.CurrentPositions[3] == ".Short") then
            SetGlobal("NOS_BogEasy_JugbandPlayersState", 1)
          end
        end
      else
        SetGlobal("NOS_BogEasy_JugbandPlayersState", 0)
      end
      Print(("NOS_BogEasy_JugbandPlayersState: " .. tostring(GetGlobal("NOS_BogEasy_JugbandPlayersState"))))
      Print(("NOS_BogEasy_JugbandToonState: " .. tostring(GetGlobal("NOS_BogEasy_JugbandToonState"))))
    end
  end
  return 
end
Prefab_Jugband_FineasAnimation = function(target)
  Print("__Function: Prefab_Jugband_FineasAnimation")
  local data = GetPrefabData(target)
  Print("__Fineas starting animation timer")
  data.FineasAnimating = 1
  AnimVarInt("NOS_BogEasy_Ghost_Fineas", VAR_Cutscene, 6)
  AnimEvent("NOS_BogEasy_Ghost_Fineas", EVENT_Start_Cutscene)
  wait(2)
  Unhide("NOS_BogEasy_Ghost_Fineas")
  wait(7)
  Hide("NOS_BogEasy_Ghost_Fineas")
  AnimEvent("NOS_BogEasy_Ghost_Fineas", EVENT_Force_Idle)
  Print("__Fineas finishing animation timer")
  data.FineasAnimating = 0
  return 
end
Prefab_Jugband_RedisableFollowers = function(target)
  Print(("___Function: Prefab_Jugband_RedisableFollowers, target(activator) == " .. GetName(target)))
  local data = GetPrefabData(target)
  if (GetName(target) == data.CurrentMoveDisabler) then
    Print("__Disabling all gators!")
    SplineFollower_SetDisabled(GetRelativePrefabEntity(target, ".Fat"), true)
    SplineFollower_SetDisabled(GetRelativePrefabEntity(target, ".Short"), true)
    SplineFollower_SetDisabled(GetRelativePrefabEntity(target, ".Tall"), true)
    AnimGBSequence(GetRelativePrefabEntity(target, ".Switch"), "rest")
    data.CurrentState = "Stopped"
    Prefab_OswaldElectricSwitch_ChangeState("JugbandShockSwitch", "Activate")
    Enable("JugbandShockMarker")
  end
  return 
end
local MembersAnimating = 0
Prefab_Jugband_StartTimer = function(target)
  Print("__Function: Prefab_Jugband_StartTimer")
  local data = GetPrefabData("NOS_BogEasy_Jugband")
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 1) then
    FireSequence("NOS_BogEasy_Gus", "NOS_Gus_JugbandBroken")
    wait(1)
    OswaldStreamAbort()
    return 
  end
  if (data.CurrentState == "Stopped") then
    data.CurrentState = "Volume"
    TimerReset(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".VolumeTimer"))
    TimerEnable(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".VolumeTimer"))
    if (GetGlobal("NOS_BogEasy_JugbandToonState") == 1) then
      if (GetGlobal("NOS_BogEasy_JugbandPlayersState") == 1) then
        AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".Fat"), "playCorrect")
        AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".Short"), "playCorrect")
        AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".Tall"), "playCorrect")
        AudioPostEventOn(GetPlayer(), "Stop_MX_BOG")
        AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Stop_SFX_Jugband_Fineas")
        MusicPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Windup_MX_BOG_Jugband_Good")
      end
    elseif (MembersAnimating == 0) then
      MembersAnimating = 1
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".Fat"), "playWrong")
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".Short"), "playWrong")
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".Tall"), "playWrong")
      AudioPostEventOn(GetPlayer(), "Stop_MX_BOG")
      AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Play_MX_BOG_Jugband_Bad")
      wait(6)
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".Fat"), "rest")
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".Short"), "rest")
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".Tall"), "rest")
      MembersAnimating = 0
    end
  end
  return 
end
Prefab_Jugband_IncreaseVolume = function(target)
  Print("__Function: Prefab_Jugband_IncreaseVolume")
  local data = GetPrefabData("NOS_BogEasy_Jugband")
  data.VolumeLevel[2] = "Climbing"
  StartEmitters(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".MusicFX"))
  data.VolumeLevel[1] = (data.VolumeLevel[1] + 1)
  if (data.VolumeLevel[1] == 7) then
    data.VolumeLevel[1] = 6
  end
  Prefab_Jugband_DisplayVolume(target)
  if (data.CurrentState ~= "Broken") then
    if (data.VolumeLevel[1] == 6) then
      if (GetGlobal("NOS_BogEasy_JugbandToonState") == 1) then
        if (GetGlobal("NOS_BogEasy_JugbandPlayersState") == 1) then
          if (data.CurrentState ~= "Fixed") then
            if (IsAnySequencePlaying() == false) then
              data.CurrentState = "Fixed"
              SetGlobal("NOS_BogEasy_JugbandState", 1)
              AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Stop_SFX_Jugband_Fineas")
              Enable("nos_bogeasy_01a_louisshackarea_audio.PlaneTrigger_JugBand_Music_A")
              Enable("nos_bogeasy_01a_louisshackarea_audio.PlaneTrigger_JugBand_Music_B")
              OswaldStreamAbort()
              Disable("JugbandShockMarker")
              Prefab_OswaldElectricSwitch_ChangeState("JugbandShockSwitch", "Deactivate")
              NOS_BogEasy_ReturnVisit_OutOfToon_FineasAppear("NOS_BogEasy_Ghost_Fineas")
            end
          end
        end
      end
    elseif (data.VolumeLevel[1] == 1) then
      Print("__Firing Sequence!")
      while true do
        if (not (IsAnySequencePlaying() == true)) then
          break
        end
        wait(0.10000000149011612)
      end
      ForceSequence("NOS_BogEasy_Oswald", "NOS_Oswald_Jugband")
      if (GetGlobal("NOS_BogEasy_JugbandPlayersState") == 0) then
        OswaldStreamAbort()
      end
    end
  end
  return 
end
Prefab_Jugband_DecreaseVolume = function(target)
  Print("__Function: Prefab_Jugband_DecreaseVolume")
  local data = GetPrefabData("NOS_BogEasy_Jugband")
  TimerDisable(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".VolumeTimer"))
  if (data.CurrentState ~= "Fixed") then
    data.VolumeLevel[2] = "Falling"
    if (GetGlobal("NOS_BogEasy_JugbandPlayersState") == 1) then
      AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Winddown_MX_BOG_Jugband_Good")
      MusicPostEventOn(GetPlayer(), "Fadein_MX_Bog")
      MusicPostEventOn(GetPlayer(), "Play_MX_BOG")
      AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Play_SFX_Jugband_Fineas")
    else
      AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Stop_MX_BOG_Jugband_Bad")
      MusicPostEventOn(GetPlayer(), "Fadein_MX_Bog")
      MusicPostEventOn(GetPlayer(), "Play_MX_BOG")
    end
    while true do
      if (not (data.VolumeLevel[1] ~= 0)) then
        break
      end
      if (data.VolumeLevel[2] == "Climbing") then
        return 
      end
      data.VolumeLevel[1] = (data.VolumeLevel[1] - 1)
      wait(0.30000001192092896)
      Prefab_Jugband_DisplayVolume(target)
    end
    StopEmitters(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".MusicFX"))
    if (data.CurrentState ~= "Broken") then
      GetPrefabData("NOS_BogEasy_Jugband").CurrentState = "Stopped"
      if (GetGlobal("NOS_BogEasy_JugbandToonState") == 1) then
        if (GetGlobal("NOS_BogEasy_JugbandPlayersState") == 1) then
          AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".Fat"), "rest")
          AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".Short"), "rest")
          AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".Tall"), "rest")
        end
      else
        Print("__Jugband not fixed! Not stopping anims!")
        Print("__State is FIXED: Leaving volume at max!")
      end
    end
  else
    Print("__State is FIXED: Leaving volume at max!")
  end
  return 
end
Prefab_Jugband_DisplayVolume = function(target)
  Print("__Function: Prefab_Jugband_DisplayVolume")
  target = "NOS_BogEasy_Jugband"
  local data = GetPrefabData(target)
  Print(("__Volume Level: " .. tostring(data.VolumeLevel[1])))
  local (for index), (for limit), (for step) = 1, 6, 1
  for x = (for index), (for limit), (for step) do
    if (x <= data.VolumeLevel[1]) then
      if (x == 1) then
        SetR3MTConstReg(GetRelativePrefabEntity(target, (".VolumeLight0" .. tostring(x))), 1, vector4(0, 1, 0, 1))
      end
      if (x == 3) then
        SetR3MTConstReg(GetRelativePrefabEntity(target, (".VolumeLight0" .. tostring(x))), 1, vector4(1, 1, 0, 1))
      end
      if (x == 5) then
        SetR3MTConstReg(GetRelativePrefabEntity(target, (".VolumeLight0" .. tostring(x))), 1, vector4(1, 0, 0, 1))
        SetR3MTConstReg(GetRelativePrefabEntity(target, (".VolumeLight0" .. tostring(x))), 1, vector4(0.10000000149011612, 0.10000000149011612, 0.10000000149011612, 1))
      end
    else
      SetR3MTConstReg(GetRelativePrefabEntity(target, (".VolumeLight0" .. tostring(x))), 1, vector4(0.10000000149011612, 0.10000000149011612, 0.10000000149011612, 1))
    end
  end
  return 
end
Prefab_Jugband_NozzleStimmed = function(target)
  Print("__Function: Prefab_Jugband_NozzleStimmed")
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 1) then
    FireSequence("NOS_BogEasy_Gus", "NOS_Gus_JugbandBroken")
    return 
  end
  local data = GetPrefabData("NOS_BogEasy_Jugband")
  if (GetGlobal("NOS_BogEasy_JugbandState") == 0) then
    FireSequence("NOS_BogEasy_Oswald", "NOS_Oswald_JugbandThinner")
  elseif (GetGlobal("NOS_BogEasy_JugbandState") == 1) then
    if (Quest_CheckStatus("Out_Of_Toon", "Out_Of_Toon_2a", Quest_Completed) ~= true) then
      if (GetGlobal("NOS_Rolly_OutOfToon_JugbandPart2Warning_Played") == 0) then
        FireSequence("NOS_BogEasy_Ghost_Rolly", "NOS_Rolly_OutOfToon_JugbandPart2Warning")
      end
    end
  end
  if (data.NozzleHits == 3) then
    TimerReset(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".SteamTimer"))
    TimerEnable(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".SteamTimer"))
  end
  if (0 < data.NozzleHits) then
    StartEmitters(GetRelativePrefabEntity("NOS_BogEasy_Jugband", (".SteamSpray" .. tostring(data.NozzleHits))))
    AudioPostEventOn(("nos_bogeasy_01a_louisshackarea_audio.Sound_JugBandSteam" .. tostring(data.NozzleHits)), "Play_sfx_JugBandSteam")
    data.NozzleHits = (data.NozzleHits - 1)
  end
  if (data.NozzleHits == 0) then
    if (data.CurrentState ~= "Broken") then
      StopEmitters(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".MusicFX"))
      data.CurrentState = "Broken"
      TimerDisable(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".SteamTimer"))
      TimerDisable(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".VolumeTimer"))
      Disable("JugbandShockMarker")
      Prefab_OswaldElectricSwitch_ChangeState("JugbandShockSwitch", "Deactivate")
      AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Stop_SFX_Jugband_Fineas")
      AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Stop_MX_BOG_Jugband_Good")
      AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Play_MX_BOG_Jugband_Die")
      MusicPostEventOn(GetPlayer(), "Fadein_MX_Bog")
      MusicPostEventOn(GetPlayer(), "Play_MX_BOG")
      Disable("nos_bogeasy_01a_louisshackarea_audio.PlaneTrigger_JugBand_Music_A")
      Disable("nos_bogeasy_01a_louisshackarea_audio.PlaneTrigger_JugBand_Music_B")
      if (GetGlobal("NOS_BogEasy_JugbandState") == 0) then
        SetGlobal("NOS_BogEasy_JugbandState", -1)
        NOS_BogEasy_ReturnVisit_OutOfToon_FineasAppear("NOS_BogEasy_Ghost_Fineas")
      elseif (GetGlobal("NOS_BogEasy_JugbandState") == 1) then
        if (Quest_CheckStatus("Out_Of_Toon", "Out_Of_Toon_2a", Quest_Completed) ~= true) then
          ForceUnpuddled("NOS_BogEasy_Ghost_Rolly")
          ForceUnpuddled("NOS_BogEasy_Ghost_Fineas")
          SetPropertyInt("NOS_BogEasy_Ghost_Rolly", "Collision Layer", 25)
          SetPropertyInt("NOS_BogEasy_Ghost_Fineas", "Collision Layer", 25)
          wait(2)
          SetPropertyInt("NOS_BogEasy_Ghost_Rolly", "Collision Layer", 25)
          SetPropertyInt("NOS_BogEasy_Ghost_Fineas", "Collision Layer", 25)
          ForceSequence("NOS_BogEasy_Ghost_Rolly", "NOS_Rolly_OutOfToon_JugbandDestroyed")
        end
      elseif (GetGlobal("NOS_BogEasy_JugbandState") == 1) then
        if (Quest_CheckStatus("Out_Of_Toon", "Out_Of_Toon_2a", Quest_Completed) == true) then
          SetGlobal("NOS_BogEasy_JugbandState", -1)
          Prefab_Jugband_ShowerScrap("NOS_BogEasy_Jugband")
          NOS_BogEasy_SaveCheckpoint("CHECKPOINT_ShantyShop_LouisShack")
        end
      end
    end
  end
  return 
end
Prefab_Jugband_Explosion = function(target, _Member)
  Print(("__Function: Prefab_Jugband_Explosion, _Member: " .. tostring(_Member)))
  AnimGBSequence(GetRelativePrefabEntity(target, tostring(_Member)), "explode")
  StartEmitters(GetRelativePrefabEntity(target, (tostring(_Member) .. "Explosion")))
  AudioPostEventOn(GetRelativePrefabEntity(target, (tostring(_Member) .. "Explosion")), "Play_sfx_JugBandExplode")
  wait(2)
  StopEmitters(GetRelativePrefabEntity(target, (tostring(_Member) .. "Explosion")))
  return 
end
Prefab_Jugband_ShowerScrap = function(target)
  Print("__Function: Prefab_Jugband_ShowerScrap")
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  AudioPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_JugBandSteam2", "Play_sfx_BE_JugbandDestroyed")
  FireThread(Prefab_Jugband_Explosion, target, ".Fat")
  FireUser1("JugbandScrapSpawner")
  wait(0.20000000298023224)
  FireThread(Prefab_Jugband_Explosion, target, ".Short")
  wait(0.20000000298023224)
  FireThread(Prefab_Jugband_Explosion, target, ".Tall")
  wait(0.20000000298023224)
  SetGlobal("NOS_QuestHealth", (GetGlobal("NOS_QuestHealth") - 15))
  return 
end
Prefab_Jugband_SteamTimerTick = function(target)
  Print("__Function: Prefab_SteamTimer_Tick")
  local data = GetPrefabData(target)
  if (data.NozzleHits < 3) then
    data.NozzleHits = (data.NozzleHits + 1)
    StopEmitters(GetRelativePrefabEntity("NOS_BogEasy_Jugband", (".SteamSpray" .. tostring(data.NozzleHits))))
    AudioPostEventOn(("nos_bogeasy_01a_louisshackarea_audio.Sound_JugBandSteam" .. tostring(data.NozzleHits)), "Stop_sfx_JugBandSteam")
  end
  if (data.NozzleHits == 3) then
    TimerDisable(GetRelativePrefabEntity("NOS_BogEasy_Jugband", ".SteamTimer"))
  end
  return 
end
Prefab_Jugband_InstrumentJigsawStateChanged = function(target)
  Print("__Function: Prefab_Jugband_InstrumentJigsawStateChanged")
  local PreviousPercentage, Percentage = Jigsaw_GetPercentagePainted(target)
  local data = GetPrefabData(target)
  if (Percentage == 1) then
    SetGlobal("NOS_BogEasy_JugbandToonState", 1)
    if (data.CurrentPositions[1] == ".Fat") then
      if (data.CurrentPositions[2] == ".Tall") then
        if (data.CurrentPositions[3] == ".Short") then
          SetGlobal("NOS_BogEasy_JugbandPlayersState", 1)
        end
      end
    end
  else
    SetGlobal("NOS_BogEasy_JugbandToonState", 0)
    SetGlobal("NOS_BogEasy_JugbandPlayersState", 0)
  end
  Print(("NOS_BogEasy_JugbandPlayersState: " .. tostring(GetGlobal("NOS_BogEasy_JugbandPlayersState"))))
  Print(("NOS_BogEasy_JugbandToonState: " .. tostring(GetGlobal("NOS_BogEasy_JugbandToonState"))))
  return 
end
Prefab_Jugband_OswaldAIShockVolume = function(target)
  Print("__Function: Prefab_Jugband_OswaldAIShockVolume")
  if (GetGlobal("NOS_BogEasy_JugbandState") == 0) then
    OswaldStreamAction("JugbandShockSwitch")
  else
    ForceSequence("NOS_BogEasy_Oswald", "NOS_Oswald_JugbandAlreadyPowered")
  end
  return 
end
Prefab_Jugband_SwitchTriggerEntered = function(target, _Side, _Entered)
  Print(((("__Function: Prefab_Jugband_SwitchTriggerEntered, _Side: " .. tostring(_Side)) .. ", _Entered: ") .. tostring(_Entered)))
  GetPrefabData(target).SwitchSide = tostring(_Side)
  return 
end
Prefab_Jugband_TriggerEntered = function(target, _Num)
  Print(("__Function: Prefab_Jugband_TriggerEntered, _Num: " .. tostring(_Num)))
  StimulusEntityWithAliasInEntityDirectionInRadius(target, ST_KNOCKBACK, 1, 0, _activator(), GetRelativePrefabEntity(target, (".SprayMarker" .. tostring(_Num))), "")
  return 
end
Prefab_Jugband_Camera = function(target, _Camera)
  Print(("__Function: Prefab_Jugband_Camera, _Camera: " .. tostring(_Camera)))
  if (_Camera == "Rolly") then
    Disable("JugbandCameraOverride")
  elseif (_Camera == "Fineas") then
    Enable("JugbandCameraOverride")
  elseif (_Camera == "Clear") then
    Disable("JugbandCameraOverride")
  end
  return 
end
