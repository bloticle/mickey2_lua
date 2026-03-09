Prefab_SetUp_HiddenHeroPhoto = function(target)
  local data = GetPrefabData(target)
  Print(("***************************** - Prefab_SetUp_HiddenHeroPhoto: " .. data.Global))
  SetPropertyString(target, "QuestFlag", data.Global)
  local CheckpointFunctionParam = data.CheckpointFunction[1]
  data.CheckpointFunction[1] = "Setup"
  if (1 <= GetGlobal("MSS_HiddenHeroesQuest")) then
    if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
      if (GetGlobal(data.Global) < 2) then
        EnableComponent(target, "Camera Ability Target Component")
        Enable(target)
        if (GetGlobal(data.Global) == 0) then
          SetGlobal(data.Global, 1)
        end
      end
    end
  else
    DisableComponent(target, "Camera Ability Target Component")
  end
  data.CheckpointFunction[1] = CheckpointFunctionParam
  return 
end
HiddenHero_CurrentMarker = ""
Prefab_Found_HiddenHeroPhoto = function(target)
  local data = GetPrefabData(target)
  local convo = GetRelativePrefabEntity(target, ".ConversationMarker")
  Print(("***************************** - Prefab_Found_HiddenHeroPhoto: " .. data.Global))
  Print(("***************************** - Destroying Entity: " .. data.Global))
  HiddenHero_CurrentMarker = data
  if (data.Hero == "None") then
    Print((("***************************** - Prefab_Found_HiddenHeroPhoto: " .. data.Hero) .. "!!  Picture type not defined!!"))
  elseif (data.Hero == "Mickey") then
    SetGlobal("MSS_HiddenMickeysFound", (GetGlobal("MSS_HiddenMickeysFound") + 1))
    SetGlobal("MSS_HiddenMickeysTotal", (GetGlobal("MSS_HiddenMickeysTotal") + 1))
    ClearParent(GetRelativePrefabEntity(target, ".MickeyFoundMarker"))
    SetMapMarkerVisible(GetRelativePrefabEntity(target, ".MickeyFoundMarker"), true)
    SetMapMarkerVisible(GetRelativePrefabEntity(target, ".PhotoMarker"), false)
    ForceSequence(convo, "EM2_Gus_HiddenMickeyFound")
  elseif (data.Hero == "Oswald") then
    SetGlobal("MSS_HiddenOswaldsFound", (GetGlobal("MSS_HiddenOswaldsFound") + 1))
    SetGlobal("MSS_HiddenOswaldsTotal", (GetGlobal("MSS_HiddenOswaldsTotal") + 1))
    ClearParent(GetRelativePrefabEntity(target, ".OswaldFoundMarker"))
    SetMapMarkerVisible(GetRelativePrefabEntity(target, ".OswaldFoundMarker"), true)
    SetMapMarkerVisible(GetRelativePrefabEntity(target, ".PhotoMarker"), false)
    ForceSequence(convo, "EM2_Gus_HiddenOswaldFound")
  end
  Wait(0.10000000149011612)
  SetGlobal(data.Global, 2)
  DisableComponent(target, "Camera Ability Target Component")
  Print(("***************************** - Photo marker destroyed: " .. tostring(target)))
  return 
end
Prefab_UpdateQuest_HiddenHeroPhoto = function(hero)
  local data = HiddenHero_CurrentMarker
  if (hero == "Mickey") then
    if (GetCurrentCount("Mickey_Photo_EpisodeOne") < 10) then
      GiveCollectible("Mickey_Photo_EpisodeOne")
    elseif (GetCurrentCount("Mickey_Photo_EpisodeTwo") < 10) then
      GiveCollectible("Mickey_Photo_EpisodeTwo")
    elseif (GetCurrentCount("Mickey_Photo_EpisodeThree") < 10) then
      GiveCollectible("Mickey_Photo_EpisodeThree")
    end
    GiveCollectibleNoPopup("Mickey_Photo")
  elseif (hero == "Oswald") then
    if (GetCurrentCount("Oswald_Photo_EpisodeOne") < 7) then
      GiveCollectible("Oswald_Photo_EpisodeOne")
    elseif (GetCurrentCount("Oswald_Photo_EpisodeTwo") < 7) then
      GiveCollectible("Oswald_Photo_EpisodeTwo")
    elseif (GetCurrentCount("Oswald_Photo_EpisodeThree") < 7) then
      GiveCollectible("Oswald_Photo_EpisodeThree")
    end
    GiveCollectibleNoPopup("Oswald_Photo")
  end
  if (data.ZoneGlobal == "TrackingGlobal") then
    Print("*************Hidden Hero ERROR: You need to specify a global on the Zone Global override!!!")
  else
    SetGlobal(data.ZoneGlobal, (GetGlobal(data.ZoneGlobal) - 1))
  end
  if (GetGlobal("MSN_CameraTutorial") == 0) then
    SetGlobal("MSN_CameraTutorial", 1)
  end
  return 
end
Prefab_SaveCheckpoint_HiddenHeroPhoto = function(target)
  target = _self()
  local data = GetPrefabData(target)
  if (data.CheckpointFunction[1] == "function") then
    Print("***************************** - Prefab_HiddenHeroPhoto: No checkpoint function declared. Not saving!")
  else
    FireThread(_G[data.CheckpointFunction[1]], data.CheckpointFunction[2], data.CheckpointFunction[3])
  end
  return 
end
Prefab_HiddenHero_ActivateHintMap = function(target)
  local data = GetPrefabData(target)
  if (data.HintMapGlobal ~= "StoreGlobal") then
    if (0 < GetGlobal(data.HintMapGlobal)) then
      if (GetGlobal(data.Global) < 2) then
        SetMapMarkerVisible(GetRelativePrefabEntity(target, ".PhotoMarker"), true)
      end
    end
  end
  if (1 < GetGlobal(data.Global)) then
    if (data.Hero == "Mickey") then
      SetMapMarkerVisible(GetRelativePrefabEntity(target, ".MickeyFoundMarker"), true)
      SetMapMarkerVisible(GetRelativePrefabEntity(target, ".PhotoMarker"), false)
    else
      SetMapMarkerVisible(GetRelativePrefabEntity(target, ".OswaldFoundMarker"), true)
      SetMapMarkerVisible(GetRelativePrefabEntity(target, ".PhotoMarker"), false)
    end
  end
  return 
end
