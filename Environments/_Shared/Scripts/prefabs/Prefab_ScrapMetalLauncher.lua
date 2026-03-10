Prefab_ScrapMetalSpawner_AlwaysSetup = function(target)
  Print("__Function: Prefab_ScrapMetalSpawner_AlwaysSetup")
  math.randomseed(os.time())
  return 
end
Prefab_ScrapMetalSpawner_Launch = function(target)
  Print("__Function: Prefab_ScrapMetalSpawner_Launch")
  local data = GetPrefabData(target)
  Print((("__Will Launch: " .. tostring(data.NumPiecesToLaunch)) .. " pieces of junk!"))
  local Distances = {0, 0, 0, 0}
  Distances[reg_14] = (GetPosition(GetRelativePrefabEntity(target, ".LaunchLocation")) - GetPosition(target)):normalize3()
  for x = 1, 3 do
    Distances[(x + 1)] = (GetPosition(GetRelativePrefabEntity(target, ".LaunchLocation")) - GetPosition(GetRelativePrefabEntity(target, (".LaunchPosition" .. tostring(x))))):normalize3()
  end
  for x = 1, 4 do
    if (x == 1) then
      x = Distances[1]
      Print(("__Normalized Distance from spawner to target: " .. tostring(x)))
    else
      x = (x - 1)
      x = " to target: "
      Print(((("__Normalized Distance from marker: " .. tostring(x)) .. x) .. tostring(Distances[x])))
    end
  end
  local ImpulseX = 0
  local ImpulseY = 0
  local ImpulseZ = 0
  local randomized = 0
  for x = 1, data.NumPiecesToLaunch do
    ImpulseX = ForceSpawn
    ImpulseY = target
    ImpulseZ = 1
    ImpulseX = ImpulseX(ImpulseY, ImpulseZ)
    ImpulseY = 1
    ImpulseZ = data.MarkersToUse
    if (ImpulseZ ~= 0) then
      ImpulseZ = math
      ImpulseZ = ImpulseZ.random
      randomized = 1
      ImpulseZ = ImpulseZ(randomized, data.MarkersToUse)
      randomized = TeleportToEntity
      x = ".LaunchPosition"
      Spawned = tostring
      IndexDistance = ImpulseZ
      Spawned = Spawned(IndexDistance)
      x = (x .. Spawned)
      randomized(target, GetRelativePrefabEntity(target, x))
      ImpulseY = ImpulseZ
    end
    ImpulseZ = math
    ImpulseZ = ImpulseZ.random
    randomized = data.RandomizerLimits
    randomized = randomized[1]
    randomized = randomized[1]
    ImpulseZ = ImpulseZ(randomized, data.RandomizerLimits[1][2])
    randomized = data.ImpulseValue
    ImpulseZ = (ImpulseZ * randomized)
    randomized = Distances[ImpulseY]
    randomized = randomized.x
    ImpulseX = (ImpulseZ * randomized)
    ImpulseZ = math
    ImpulseZ = ImpulseZ.random
    randomized = data.RandomizerLimits
    randomized = randomized[2]
    randomized = randomized[1]
    ImpulseZ = ImpulseZ(randomized, data.RandomizerLimits[2][2])
    randomized = data.ImpulseValue
    ImpulseZ = (ImpulseZ * randomized)
    randomized = Distances[ImpulseY]
    randomized = randomized.y
    ImpulseY = (ImpulseZ * randomized)
    ImpulseZ = math
    ImpulseZ = ImpulseZ.random
    randomized = data.RandomizerLimits
    randomized = randomized[3]
    randomized = randomized[1]
    ImpulseZ = ImpulseZ(randomized, data.RandomizerLimits[3][2])
    randomized = data.ImpulseValue
    ImpulseZ = (ImpulseZ * randomized)
    randomized = Distances[ImpulseY]
    randomized = randomized.z
    ImpulseZ = (ImpulseZ * randomized)
    ImpulseZ = Print
    randomized = "ImpulseX: "
    x = ImpulseY
    x = ", ImpulseZ: "
    Spawned = tostring
    IndexDistance = ImpulseZ
    Spawned = Spawned(IndexDistance)
    randomized = (((((randomized .. tostring(ImpulseX)) .. ", ImpulseY: ") .. tostring(x)) .. x) .. Spawned)
    ImpulseZ(randomized)
    ImpulseZ = ApplyImpulse
    randomized = ImpulseX[1]
    ImpulseZ(randomized, ImpulseX, ImpulseY, ImpulseZ)
    ImpulseZ = wait
    randomized = 0.05000000074505806
    ImpulseZ(randomized)
  end
  return 
end

