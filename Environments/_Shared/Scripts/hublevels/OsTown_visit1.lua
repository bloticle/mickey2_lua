OsTown_Setup = function(location, customFadeIn)
  Print("Enter function: OsTown_Setup: Visit 1")
  if (location == "Surface") then
    LevelManager_SetZoneStatusActive("OST_Center.Visit1_AI")
    WaitForLevelLoad()
  end
  if (GetGlobal("OST_Center_OpeningMoviePlayed") == 0) then
    PlayMovie(GetPlayer(), "PH_1_3_Prescott_Intro.bik")
    GiveCollectibleNoPopup("Film_PH1_3")
    Quest_SetCriticalPath("Critical_OsTown", "Critical_OsTown_2")
  end
  AnimVarInt("AnimatronicGoofy", VAR_Mood_Type, 1)
  AnimVarInt("AnimatronicGoofy", VAR_NPC_State, 1)
  AnimVarInt("Gremlin_Prescott", VAR_Mood_Type, 0)
  AnimVarInt("Gremlin_Prescott", VAR_NPC_State, 7)
  if (0 < GetGlobal("OST_Center_GoofysPumpSearchCount")) then
    SetNextPatrolNode("AnimatronicGoofy", ("OST_Center_PatrolNode_GoofysPumpSearch0" .. GetGlobal("OST_Center_GoofysPumpSearchCount")))
  end
  local showTutorial = 0
  if (GetGlobal("OST_Center_OpeningMoviePlayed") == 0) then
    Wait(0.10000000149011612)
    HideHud()
    Wait(0.10000000149011612)
    ForEachEntityInGroup(AnimGBSequence, "OST_Center_trainStation_Limbs", "rest")
    SetGlobal("OST_Center_OpeningMoviePlayed", 1)
    OswaldStopFollowAction()
    Wait(0.10000000149011612)
    ClearAllCameraAttributes()
    Disable("ost_center_scripting.prefab_trainstationexplosion01.ExplosionTrigger")
    Wait(0.10000000149011612)
    TeleportToEntity(GetPlayer(), "PM_PostIntro_Player1", true, true)
    TeleportToEntity(GetPlayer2OrAI(), "PM_PostIntro_Player2", true, true)
    OswaldStartFollowAction()
    Wait(0.10000000149011612)
    ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
    Wait(0.10000000149011612)
    CameraReset()
    Wait(0.10000000149011612)
    UnlockAbility(GetPlayer(), "Sketch_Fairy")
    FireUser2("OST_Center_prefab_trainstationexplosion01_EventTrigger")
    Print("OsTown_Setup V1: Train station explode!")
    OST_Center_Checkpoint(nil, "Surface")
    RestrictCutSceneInput()
    showTutorial = 1
  end
  if (customFadeIn == "DEC") then
    Prefab_DECFoopToob_Finish()
  elseif (location == "Surface") then
    StartFadeIn(1)
  else
    _G[("OST_Center_Setup_" .. location)](customFadeIn)
  end
  AudioPostEventOn("ost_center_audio.PumpCharger", "Play_sfx_PumpCharger_Lp")
  AudioPostEventOn("ost_center_audio.Sound_PipeThinner", "Play_sfx_ThinnerRiverPool")
  MultiPosSoundStart("ost_center_audio.ThinnerPool_control")
  return 
end
OST_Stream_VisitAI = function()
  LevelManager_SetZoneStatusActive("OST_Center.Visit1_AI")
  WaitForLevelLoad()
  return 
end
OST_ExitInterior = function(target)
  LevelManager_SetZoneStatusActive("OST_Center.Visit1_AI")
  WaitForLevelLoad()
  if (GetGlobal("OST_Clarabelle_Greeting_Played") == 1) then
    if (GetGlobal("OST_Gus_FoundClarabelleFlower_Played") == 0) then
      Prefab_WorldItem_Unhide("OST_ClarabelleFlower")
    end
  end
  if (-1 < GetGlobal("OST_Moody_Destination")) then
    Hide("OST_Center_NPC_Rigger_Greene")
    Print("OST_ExitInterior: Rigger Greene Hidden")
  end
  if (0 < GetGlobal("OST_Center_GoofysPumpSearchCount")) then
    SetNextPatrolNode("AnimatronicGoofy", ("OST_Center_PatrolNode_GoofysPumpSearch0" .. GetGlobal("OST_Center_GoofysPumpSearchCount")))
  end
  SetInside2DMap(false)
  OST_ExitInterior_ResumeAudio(target)
  return 
end
OST_ExitMoodysHouse_VisitSetup = function(streamAI)
  Print("Function entered: OST_ExitMoodysHouse_VisitSetup, Visit1")
  if streamAI then
    LevelManager_SetZoneStatusActive("OST_Center.Visit1_AI")
  end
  if (-1 < GetGlobal("OST_Moody_Destination")) then
    Hide("OST_Center_NPC_Rigger_Greene")
    Print("OST_ExitMoodysHouse_VisitSetup: Rigger Greene Hidden")
  end
  if (GetGlobal("OST_Clarabelle_Greeting_Played") == 1) then
    if (GetGlobal("OST_Gus_FoundClarabelleFlower_Played") == 0) then
      Prefab_WorldItem_Unhide("OST_ClarabelleFlower")
    end
  end
  if (0 < GetGlobal("OST_Center_GoofysPumpSearchCount")) then
    SetNextPatrolNode("AnimatronicGoofy", ("OST_Center_PatrolNode_GoofysPumpSearch0" .. GetGlobal("OST_Center_GoofysPumpSearchCount")))
  end
  return 
end
OST_ExitMoodysCleanup = function()
  TeleportGremlinOut("Cutscene_Gus")
  StartFadeOut(0.5)
  wait(0.5)
  FireUser3("ExitMoodysGrabCameraFancy2")
  LevelManager_SetZoneStatusActive("OST_Center.Visit1_AI")
  WaitForLevelLoad()
  StartFadeIn(0.5)
  UnrestrictCutSceneInput()
  return 
end
OST_Spawn_GF_Gremlin = function(skip)
  if (skip ~= nil) then
    if (skip ~= "skip") then
      Prefab_EnterInterior_FadeIn("True")
    end
  end
  return 
end
OST_SetupPrescott = function()
  if (GetGlobal("OST_Prescott_Intro_Played") == 0) then
    AnimVarInt("Gremlin_Prescott", VAR_Mood_Type, MOOD_Positive)
    AnimVarInt("Gremlin_Prescott", VAR_NPC_State, 6)
  end
  return 
end
OST_Intro_CameraHint = function()
  GrabCamera("Cam_Prescott_Intro1", nil, CAMERA_LERP_TRANSITION, 0)
  wait(0.5)
  GrabCamera("Cam_Prescott_Intro2", nil, CAMERA_LERP_TRANSITION, 1)
  return 
end
OST_LowerPool_Prescott = function()
  OST_LowerPool()
  return 
end
OST_Prescott_SetupItem = function()
  ForcePainted("Prescott_Object_ToonBox")
  Prefab_WorldItem_Unhide("Pickup_PrescottItem")
  return 
end
OST_DEBUG_GF_Teleport = function(target)
  MoveToEntity("Oswald", target)
  return 
end
OST_MickeyNear_FairyHint = function(target, phase)
  if (phase == "fairyUsed") then
    DestroyEntity("ost_center_scripting.Pump_FairyHint_TriggerBase 02")
    Hide("FairyHint_GBL_OverheadIndicatorButtonPlus_01a 01")
    ClearParent("FairyHint_GBL_OverheadIndicatorButtonPlus_01a 01")
    return 
  end
  if IsValidHandle("ost_center_scripting.Pump_FairyHint_TriggerBase 02") then
    if (GetGlobal("OST_Pump1Status") == -1) then
      if (_activator() == _player()) then
        local mickey = GetPlayer()
        if (phase == "enter") then
          local targetPos = GetPosition(mickey)
          SetTransformation("FairyHint_GBL_OverheadIndicatorButtonPlus_01a 01", vector4(targetPos.x, (targetPos.y + 1.5), targetPos.z), vector4(0, 0, 0))
          SetParentEntity("FairyHint_GBL_OverheadIndicatorButtonPlus_01a 01", mickey)
          Unhide("FairyHint_GBL_OverheadIndicatorButtonPlus_01a 01")
        elseif (phase == "exit") then
          Hide("FairyHint_GBL_OverheadIndicatorButtonPlus_01a 01")
          ClearParent("FairyHint_GBL_OverheadIndicatorButtonPlus_01a 01")
        end
      end
    end
  end
  return 
end
OST_PumpCheck = function(target, pump)
  pump = tonumber(pump)
  local pumpvar = ("OST_ThinnerPump" .. tostring(pump))
  for i = 1, 3 do
    if (pump == i) then
      if (GetGlobal(pumpvar) == 0) then
        SetGlobal(pumpvar, 1)
        SetGlobal("OST_ThinnerPumpDiscovered", pump)
        FireSequence("ost_center_visit1_ai.NPC_AnimatronicGoofy 01", "OST_Goofy_PumpFound", 0)
      end
    else
    end
  end
  return 
end

