gsCG_TV_Charged = function(target)
  local data = GetPrefabData(target)
  local crayon = GetRelativePrefabEntity(target, ".centralCrayon")
  SetParentEntity(GetRelativePrefabEntity(target, ".RopeSupport2"), crayon)
  SetParentEntity(GetRelativePrefabEntity(target, ".RopeSupport2"), crayon)
  wait(1)
  SetSplineFollowerInitialSpeed(crayon, 6)
  return 
end
gsCG_BatteryCharged = function(target)
  local data = GetPrefabData(target)
  wait(1)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".centralCrayon"), 0)
  AudioPostEventOn("gremlinsubway_04a_audio.Snd_GateCrayon", "Play_sfx_dec_crayon_gate_open")
  return 
end
gsCG_initialize = function(target)
  SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".centralCrayon"), 45)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".centralCrayon"), -100)
  return 
end
