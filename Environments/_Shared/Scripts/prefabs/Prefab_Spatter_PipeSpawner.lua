Prefab_SpatterPipe_Spawn = function(target, var_return)
  Print("!@#$!@#$!@#$!@#$!@#$!@#$!@#$!@#$!@#$ Prefab_SpatterPipe_Spawn")
  local data = GetPrefabData(target)
  local Animated_Spawner = GetRelativePrefabEntity(target, ".Animated_Spawner")
  local PipeSpawner_Spatter = GetRelativePrefabEntity(target, ".PipeSpawner_Spatter")
  local Pipe_Knob = "None"
  if (data.Animation.Knob[1] ~= "None") then
    Pipe_Knob = GetRelativePrefabEntity(target, ".Pipe_Knob")
  end
  AnimGBReset(Animated_Spawner)
  AnimGBSequence(target, data.Animation.Spawner)
  if (Pipe_Knob ~= "None") then
    AnimGBSequence(Pipe_Knob, data.Animation.Knob[1])
  end
  wait(0.10000000149011612)
  AudioPostEventOn(Animated_Spawner, "Play_sfx_Prfb_Faucet_PipeSpawner_Pipe")
  AnimGBReset(PipeSpawner_Spatter)
  wait(0.10000000149011612)
  AudioPostEventOn(Animated_Spawner, "Play_sfx_Prfb_Faucet_PipeSpawner_Handle")
  wait(0.30000001192092896)
  if (Pipe_Knob ~= "None") then
    AnimGBSequence(Pipe_Knob, data.Animation.Knob[2])
  end
  wait(0.5)
  AnimGBSequence(target, "Rest")
  wait(0.699999988079071)
  local Spawner = ""
  local Spawner_FX = GetRelativePrefabEntity(target, ".Spawner_FX")
  if (data.External_Spawner ~= "None") then
    MoveToEntity(data.External_Spawner, Spawner_FX)
    Spawner = data.External_Spawner
  else
    Spawner = GetRelativePrefabEntity(target, ".Spawner")
  end
  if (var_return == nil) then
    ForceSpawn(Spawner, 1)
    ForceSpawn(Spawner_FX, 1)
  else
    local spatter = ForceSpawn(Spawner, 1)[1]
    Print(tostring(spatter))
    Print(tostring(GetName(spatter)))
    return GetName(spatter)
  end
  return 
end

