SteamJetPlusDamageSetup = function(FX)
  local DamVolume = GetRelativePrefabEntity(FX, ".DamVolume")
  local data = GetPrefabData(FX)
  if (0 < data.WarningTime) then
    SetVisualScale(FX, data.SmallScale)
  end
  if (data.StartEnabled == true) then
    FireUser1(FX)
  end
  return 
end
SteamJetPlusDamage = function(FX)
  local DamVolume = GetRelativePrefabEntity(FX, ".DamVolume")
  local data = GetPrefabData(FX)
  if (data.InterruptActive == 0) then
    StartEmitters(FX)
    if (0 < data.WarningTime) then
      Wait(data.WarningTime)
      SetVisualScale(FX, data.LargeScale)
    end
    Unhide(DamVolume)
    AudioPostEventOn(FX, "Play_sfx_ThinnerJetSpray")
  end
  if (0 < data.Cycletime) then
    wait(data.Cycletime)
    StopEmitters(FX)
    Wait(0.5)
    Hide(DamVolume)
    if (0 < data.WarningTime) then
      SetVisualScale(FX, data.SmallScale)
    end
    AudioPostEventOn(FX, "Stop_sfx_ThinnerJetSpray")
    wait((data.Cycletime + data.WarningTime))
    if (data.InterruptActive == 0) then
      FireUser1(FX)
    end
  end
  return 
end
SjD_ShutdownSteamJet = function(FX)
  local data = GetPrefabData(FX)
  data.InterruptActive = 1
  AudioPostEventOn(FX, "Stop_sfx_ThinnerJetSpray")
  return 
end
SjD_ActivateSteamJet = function(FX)
  local data = GetPrefabData(FX)
  data.InterruptActive = 0
  SteamJetPlusDamage(FX)
  return 
end

