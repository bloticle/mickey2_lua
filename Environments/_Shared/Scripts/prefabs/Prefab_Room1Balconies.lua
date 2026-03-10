Prefab_Room1Balconies_AlwaysSetup = function(target)
  Print("__Function: Prefab_Room1Balconies_AlwaysSetup")
  if (GetGlobal("NOS_BlotAlley_Bell1Rang") == 1) then
    Prefab_Room1Balconies_EnableMovement(target)
  end
  return 
end
Prefab_Room1Balconies_RetractBalcony = function(target, _Balcony)
  Print(("__Function: Prefab_Room1Balconies_RetractBalcony, _Balcony: " .. tostring(_Balcony)))
  local data = GetPrefabData(target)
  local Balcony = GetRelativePrefabEntity(target, (".Balcony" .. tostring(_Balcony)))
  local Knot1 = ""
  local Knot2 = ""
  if (_Balcony == "1") then
    if (data.ToonBalconyState[1] == 0) then
      Print("__Toon piece 1 is thinned out! Cancelling move request")
      return 
    end
    Knot1 = GetRelativePrefabEntity(target, ".Knot_Left1")
    Knot2 = GetRelativePrefabEntity(target, ".Knot_Left2")
    AudioPostEventOn("nos_blotalley_01a_audio.Snd_SlidingBalcony 01", "Play_BLA_SlidingPlatform_Wall")
  elseif (_Balcony == "2") then
    if (data.ToonBalconyState[2] == 0) then
      Print("__Toon piece 2 is thinned out! Cancelling move request")
      return 
    end
    Knot1 = GetRelativePrefabEntity(target, ".Knot_Forward1")
    Knot2 = GetRelativePrefabEntity(target, ".Knot_Forward2")
    AudioPostEventOn("nos_blotalley_01a_audio.Snd_SlidingBalcony 02", "Play_BLA_SlidingPlatform_Wall")
  elseif (_Balcony == "3") then
    Knot1 = GetRelativePrefabEntity(target, ".Knot_Backward1")
    Knot2 = GetRelativePrefabEntity(target, ".Knot_Backward2")
    AudioPostEventOn("nos_blotalley_01a_audio.Snd_SlidingBalcony 03", "Play_BLA_SlidingPlatform_Wall")
  elseif (_Balcony == "4") then
    Knot1 = GetRelativePrefabEntity(target, ".Knot_Left1")
    Knot2 = GetRelativePrefabEntity(target, ".Knot_Left2")
    AudioPostEventOn("nos_blotalley_01a_audio.Snd_SlidingBalcony 04", "Play_BLA_SlidingPlatform_Wall")
  end
  SplineFollower_SetDisabled(Balcony, false)
  SplineFollower_StopAtPosition(Balcony, Knot1, Knot2, 1)
  return 
end
Prefab_Room1Balconies_ExpandBalcony = function(target, _Balcony)
  Print(("__Function: Prefab_Room1Balconies_ExpandBalcony, _Balcony: " .. tostring(_Balcony)))
  local data = GetPrefabData(target)
  local Balcony = GetRelativePrefabEntity(target, (".Balcony" .. tostring(_Balcony)))
  local Knot1 = ""
  local Knot2 = ""
  if (_Balcony == "1") then
    if (data.ToonBalconyState[1] == 0) then
      Print("__Toon piece 1 is thinned out! Cancelling move request")
      return 
    end
    Knot1 = GetRelativePrefabEntity(target, ".Knot_Left1")
    Knot2 = GetRelativePrefabEntity(target, ".Knot_Left2")
    AudioPostEventOn("nos_blotalley_01a_audio.Snd_SlidingBalcony 01", "Play_BLA_SlidingPlatform_Wall")
  elseif (_Balcony == "2") then
    if (data.ToonBalconyState[2] == 0) then
      Print("__Toon piece 2 is thinned out! Cancelling move request")
      return 
    end
    Knot1 = GetRelativePrefabEntity(target, ".Knot_Forward1")
    Knot2 = GetRelativePrefabEntity(target, ".Knot_Forward2")
    AudioPostEventOn("nos_blotalley_01a_audio.Snd_SlidingBalcony 02", "Play_BLA_SlidingPlatform_Wall")
  elseif (_Balcony == "3") then
    Knot1 = GetRelativePrefabEntity(target, ".Knot_Backward1")
    Knot2 = GetRelativePrefabEntity(target, ".Knot_Backward2")
    AudioPostEventOn("nos_blotalley_01a_audio.Snd_SlidingBalcony 03", "Play_BLA_SlidingPlatform_Wall")
  elseif (_Balcony == "4") then
    Knot1 = GetRelativePrefabEntity(target, ".Knot_Left1")
    Knot2 = GetRelativePrefabEntity(target, ".Knot_Left2")
    AudioPostEventOn("nos_blotalley_01a_audio.Snd_SlidingBalcony 04", "Play_BLA_SlidingPlatform_Wall")
  end
  SplineFollower_SetDisabled(Balcony, false)
  SplineFollower_StopAtPosition(Balcony, Knot1, Knot2, 0)
  return 
end
Prefab_Room1Balconies_EnableMovement = function(target)
  Print("__Function: Prefab_Room1Balconies_EnableMovement")
  TimerReset(GetRelativePrefabEntity(target, ".Timer"))
  TimerEnable(GetRelativePrefabEntity(target, ".Timer"))
  DestroyEntity("Room1_OswaldShocker_Trigger")
  Disable("Room1OswaldShocker_Hint")
  AnimGBSequence("AnimatronicTreesShutter", "close")
  return 
end
Prefab_Room1Balconies_TimerTick = function(target)
  Print("__Function: Prefab_Room1Balconies_TimerTick")
  local data = GetPrefabData(target)
  if (data.PatternNum == 1) then
    data.PatternNum = 2
    Prefab_Room1Balconies_ExpandBalcony(target, "1")
    Prefab_Room1Balconies_ExpandBalcony(target, "3")
    Prefab_Room1Balconies_RetractBalcony(target, "2")
    Prefab_Room1Balconies_RetractBalcony(target, "4")
  else
    data.PatternNum = 1
    Prefab_Room1Balconies_ExpandBalcony(target, "2")
    Prefab_Room1Balconies_ExpandBalcony(target, "4")
    Prefab_Room1Balconies_RetractBalcony(target, "1")
    Prefab_Room1Balconies_RetractBalcony(target, "3")
  end
  return 
end
Prefab_Room1Balconies_StateChange = function(target, _State, _Which)
  Print(((("__Function: Prefab_Room1Balconies_StateChange, _State: " .. tostring(_State)) .. ", _Which: ") .. tostring(_Which)))
  local data = GetPrefabData(target)
  if (_State == "Painted") then
    if (GetGlobal("NOS_BlotAlley_Bell1Rang") == 1) then
      Print((("__Setting " .. tostring(GetName(target))) .. " to enabled!"))
      SplineFollower_SetDisabled(target, false)
    else
      Print("__Bell hasnt been rung! dont activate or deactivate this platform")
    end
    data.ToonBalconyState[tonumber(_Which)] = 1
  elseif (_State == "Thinned") then
    if (GetGlobal("NOS_BlotAlley_Bell1Rang") == 1) then
      Print((("__Setting " .. tostring(GetName(target))) .. " to disabled!"))
      SplineFollower_SetDisabled(target, true)
    else
      Print("__Bell hasnt been rung! dont activate or deactivate this platform")
    end
    data.ToonBalconyState[tonumber(_Which)] = 0
  end
  return 
end

