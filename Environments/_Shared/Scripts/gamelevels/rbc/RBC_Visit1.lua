RBC_Caverns_Visit_Setup = function(target, location)
  Print(("RBC_Caverns_Visit_Setup - VISIT 1 " .. location))
  MusicPostEventOn(GetPlayer(), "Play_MX_RBC")
  RemoveAllMusicStateOverride()
  Print("Started RBC music event")
  if (location == "Angel") then
    SetPlayStyleScoreBias(100)
    SetCombatIntensityBias(-100)
    LevelManager_SetZoneStatusActive("RBC_falls.CavernsMazeMelee")
    Print("Set RBC Angel music state, disabled combat music")
    MultiPosSoundStart("rbc_caverns_01a_audio.angel_falls_falls_Parent")
    AudioEffectStart("rbc_caverns_01a_audio.SND_reverb")
    Print("Angel side amb sfx fired")
    if (GetGlobal("RBC_AngelSideIntro") == 0) then
      Quest_SetCriticalPath("Critical_RBC", "Critical_RBC_2b")
      RBC_AngelFallsFlyby()
    end
  elseif (location == "Devil") then
    SetPlayStyleScoreBias(-100)
    SetCombatIntensityBias(-100)
    LevelManager_SetZoneStatusUnloaded("RBC_falls.CavernsTheBlob")
    LevelManager_SetZoneStatusActive("RBC_falls.CavernsMazeMelee")
    Print("Set RBC Devil music state, disabled combat music")
    MultiPosSoundStart("rbc_caverns_01a_audio.lava_ambiance_Parent")
    AudioEffectStart("rbc_caverns_01a_audio.SND_reverb")
    Print("Devil side amb sfx fired")
    SetPlayStyleScoreBias(100)
    SetCombatIntensityBias(-100)
    Print("Set RBC Devil music state, disabled combat music")
    ForEachEntityInGroup(Enable, "RC_DevilFallsEnemies")
    if (GetGlobal("EM2_EpisodeCheck") == 1) then
      Quest_SetCriticalPath("Critical_RBC", "Critical_RBC_2a")
      RBC_DevilFallsFlyby()
    end
    UnrestrictCutSceneInput()
    Prefab_DECFoopToob_Finish()
  end
  if (target ~= nil) then
    RBC_SaveCheckpoint()
  end
  return 
end
RBC_AngelFallsFlyby = function()
  if (GetGlobal("RBC_AngelSideIntro") == 0) then
    local camera = "RBC_IGC_Cameras_Intro"
    DoStinger("RBC_Angel_Flyby", 2)
    ActivateGremlinHint("RBC_GusHintAngel")
    ForEachEntityInGroup(Enable, "RC_AngelFallsEnemies")
    wait(0.5)
    GrabCameraNif(camera, nil, 0, 0)
    AnimGBReset(camera)
    AnimGBSequence(camera, "RBC_Cam_IntroAngel")
    EnableSplitScreen(false)
    wait(0)
    StartFadeInNoHUD(0.5)
    wait(7)
    StartFadeOut(1)
    wait(1.25)
    ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
    if (GetGlobal("2dDirection") == 1) then
      Projector_To_IGC_Cleanup("Projector_tofallsangel", "noSCUPM")
      MoveToEntity(GetPlayer(), "RBC_AngelStartMickeyMoveTo")
      MoveToEntity(GetPlayer2OrAI(), "RBC_AngelStartOswaldMoveTo")
    else
      Projector_To_IGC_Cleanup("Projector_ToGulch1Angel", "noSCUPM")
    end
    EnableSplitScreen(true)
    CameraReset()
    StartFadeIn(1)
    ShowHud()
    SetGlobal("RBC_AngelSideIntro", 1)
    Wait(0)
    RBC_SaveCheckpoint(nil, "AngelStart")
  end
  return 
end
RBC_DevilFallsFlyby = function()
  if (GetGlobal("RBC_DevilSideIntro") == 0) then
    local camera = "RBC_IGC_Cameras_Intro"
    DoStinger("RBC_Devil_Flyby", 2)
    ActivateGremlinHint("RBC_GusHintDevil")
    wait(0.5)
    GrabCameraNif(camera, nil, 0, 0)
    AnimGBReset(camera)
    AnimGBSequence(camera, "RBC_Cam_IntroDevil")
    wait(0)
    EnableSplitScreen(false)
    StartFadeInNoHUD(0.5)
    wait(4)
    FireThread(RBC_StartDevilEyes)
    wait(2)
    StartFadeOut(1)
    wait(1)
    ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
    CameraReset()
    EnableSplitScreen(true)
    StartFadeIn(1)
    ShowHud()
    SetGlobal("RBC_DevilSideIntro", 1)
    Wait(0)
    Enable("FoopToob_ToRBCavernsActivator")
    RBC_SaveCheckpoint(nil, "DevilStart")
  end
  return 
end
RBC_BlobSpawn = function()
  LevelManager_SetZoneStatusActive("RBC_falls.CavernsTheBlob")
  return 
end
RBC_LoadMazeMelee = function()
  LevelManager_SetZoneStatusActive("RBC_falls.CavernsMazeMelee")
  return 
end
RBC_DevilCritPathUpdate = function()
end

