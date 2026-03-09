Play_Start_Grab_Audio = function(target)
  if (target == _player()) then
    AudioPostEventOn(target, "Play_sfx_mickey_grab")
  elseif (target == _player2()) then
    AudioPostEventOn(target, "Play_sfx_oswald_grab")
  end
  return 
end
Play_Stop_Grab_Audio = function(target)
  if (target == _player()) then
    AudioPostEventOn(target, "Play_sfx_mickey_letgo")
  elseif (target == _player2()) then
    AudioPostEventOn(target, "Play_sfx_oswald_letgo")
  end
  return 
end
