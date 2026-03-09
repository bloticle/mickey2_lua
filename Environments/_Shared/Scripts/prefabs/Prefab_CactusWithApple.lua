Prefab_CactusDropApple = function(target)
  local data = GetPrefabData(target)
  SetPropertyInt(target, "Collision Layer", 5)
  if (data.AppleDropped == "False") then
    data.AppleDropped = "True"
    EnableMotion(data.AppleName)
    ApplyImpulse(data.AppleName, 0, -1, 0)
    AudioPostEventOn(target, "Play_sfx_dg1_cactus_apple_drop")
    while true do
      if (not (IsValidHandle(data.AppleName) == true)) then
        break
      end
      wait(15)
    end
    if (data.AppleDropped == "True") then
      if GetPropertyBool(target, "Is Painted") then
        prefab_CactusAppleSpawned(GetRelativePrefabEntity(target, ".AppleSpawner"))
      end
    end
  end
  return 
end
prefab_CactusAppleSpawned = function(target, setup)
  local data = GetPrefabData(target)
  if (setup ~= nil) then
    local initialwait = tonumber(string.sub(GetName(target), -14, -14))
    wait((initialwait * 0.20000000298023224))
  end
  if GetPropertyBool(GetRelativePrefabEntity(target, ".ToonCactus"), "Is Painted") then
    local apple, apple = ForceSpawn(target, 1)[1], target
    data.AppleName = apple
    data.AppleDropped = "False"
    apple = AudioPostEventOn
    apple(target, "Play_sfx_dg1_cactus_apple_spawn")
    apple = 1
    local (for index), (for limit) = 10, 1
    for (for step) = apple, (for index), (for limit) do
      i = SetVisualScale
      i(apple, (0 + ((for step) * 0.10000000149011612)))
      i = wait
      i(0)
    end
  end
  return 
end
Prefab_CactusGrowApple = function(target)
  SetPropertyInt(target, "Collision Layer", 10)
  if (GetName(GetPrefabData(target).AppleName) == nil) then
    wait(1)
    prefab_CactusAppleSpawned(GetRelativePrefabEntity(target, ".AppleSpawner"))
  end
  return 
end
Prefab_CactusBreakApple = function(target)
  Print("Prefab_CactusBreakApple")
  AudioPostEventOn(target, "Play_sfx_dg1_cactus_apple_break")
  DestroyEntity(target)
  Print("Prefab_CactusBreakApple: Done")
  return 
end
