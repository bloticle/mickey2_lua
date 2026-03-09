RBC_Caverns_Visit_Setup = function(target, location)
  Print((("RBC_Caverns_Visit_Setup - VISIT 2 " .. location) .. " Side"))
  MusicPostEventOn(GetPlayer(), "Play_MX_RBC")
  RemoveAllMusicStateOverride()
  Print("Started RBC music event")
  if (location == "Angel") then
    LevelManager_SetZoneStatusUnloaded("RBC_falls.CavernsBruiser")
    LevelManager_SetZoneStatusActive("RBC_falls.AngelVisit2Enemies")
    WaitForLevelLoad()
    SetPlayStyleScoreBias(100)
    SetCombatIntensityBias(-100)
    Print("Set RBC Angel music state, disabled combat music")
    MultiPosSoundStart("rbc_caverns_01a_audio.angel_falls_falls_Parent")
    AudioEffectStart("rbc_caverns_01a_audio.SND_reverb")
    Print("Angel side amb sfx fired")
  else
    LevelManager_SetZoneStatusUnloaded("RBC_falls.AngelVisit2Enemies")
    LevelManager_SetZoneStatusActive("RBC_falls.CavernsBruiser")
    SetPlayStyleScoreBias(-100)
    SetCombatIntensityBias(-100)
    Print("Set RBC Devil music state, disabled combat music")
    SetPlayStyleScoreBias(100)
    SetCombatIntensityBias(-100)
    Print("Set RBC Devil music state, disabled combat music")
    MultiPosSoundStart("rbc_caverns_01a_audio.lava_ambiance_Parent")
    AudioEffectStart("rbc_caverns_01a_audio.SND_reverb")
    Print("Devil side amb sfx fired")
    UnrestrictCutSceneInput()
    Prefab_DECFoopToob_Finish()
  end
  if (target ~= nil) then
    RBC_SaveCheckpoint()
  end
  return 
end
RBC_LoadBruiser = function()
  LevelManager_SetZoneStatusActive("RBC_falls.CavernsBruiser")
  return 
end
