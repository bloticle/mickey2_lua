PlayInkWellFlakeEffectAudio = function(target, event)
  local audioName = ""
  local effectType = InkWellFlakeEvent_GetEffectType(event)
  if (effectType == IWAT_Invisible) then
    audioName = "Play_sfx_invisible_flakeOff"
  elseif (effectType == IWAT_Indelible) then
    audioName = "Play_sfx_indelible_flakeOff"
  end
  local numFrames = InkWellFlakeEvent_GetNumberOfFrames(event)
  if (1 < numFrames) then
    audioName = (audioName .. "_LG")
  end
  AudioPostEventOn(target, audioName)
  return 
end
SendInvisibleStartAudioEvent = function(target)
  if (target == _player()) then
    AudioPostEventOn(target, "Play_sfx_Mickey_invisible")
  elseif (target == _player2()) then
    AudioPostEventOn(target, "Play_sfx_Oswald_invisible")
  end
  return 
end
SendInvisibleEndAudioEvent = function(target)
  if (target == _player()) then
    AudioPostEventOn(target, "Play_sfx_Mickey_invisibleStop")
  elseif (target == _player2()) then
    AudioPostEventOn(target, "Play_sfx_Oswald_invisibleStop")
  end
  return 
end
SendIndelibleStartAudioEvent = function(target)
  if (target == _player()) then
    AudioPostEventOn(target, "Play_sfx_Mickey_indelible")
  elseif (target == _player2()) then
    AudioPostEventOn(target, "Play_sfx_Oswald_indelible")
  end
  return 
end
SendIndelibleEndAudioEvent = function(target)
  if (target == _player()) then
    AudioPostEventOn(target, "Play_sfx_Mickey_indelibleStop")
  elseif (target == _player2()) then
    AudioPostEventOn(target, "Play_sfx_Oswald_indelibleStop")
  end
  return 
end

