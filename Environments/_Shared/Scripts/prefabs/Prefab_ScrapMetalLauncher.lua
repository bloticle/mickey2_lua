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
  Distances[1] = (GetPosition(GetRelativePrefabEntity(target, ".LaunchLocation")) - GetPosition(target)):normalize3()
  local (for index), (for limit), (for step) = 1, 3, 1
  for x = (for index), (for limit), (for step) do
    Distances[(x + 1)] = (GetPosition(GetRelativePrefabEntity(target, ".LaunchLocation")) - GetPosition(GetRelativePrefabEntity(target, (".LaunchPosition" .. tostring(x))))):normalize3()
  end
  local (for index), (for limit), (for step) = 1, 4, 1
  for x = (for index), (for limit), (for step) do
    if (x == 1) then
      (for index) = Print
      (for limit) = "__Normalized Distance from spawner to target: "
      (for step) = tostring
      x = Distances[1]
      (for step) = (for step)(x)
      (for limit) = ((for limit) .. (for step))
      (for index)((for limit))
    else
      (for index) = Print
      (for limit) = "__Normalized Distance from marker: "
      (for step) = tostring
      x = (x - 1)
      (for step) = (for step)(x)
      x = " to target: "
      (for limit) = ((((for limit) .. (for step)) .. x) .. tostring(Distances[x]))
      (for index)((for limit))
    end
  end
  local ImpulseX = 0
  local ImpulseY = 0
  local ImpulseZ = 0
  local randomized = 0
  local (for index), (for limit), (for step) = 1, data.NumPiecesToLaunch, 1
  for x = (for index), (for limit), (for step) do
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
      (for index) = data.MarkersToUse
      ImpulseZ = ImpulseZ(randomized, (for index))
      randomized = TeleportToEntity
      (for index) = target
      (for limit) = GetRelativePrefabEntity
      (for step) = target
      x = ".LaunchPosition"
      Spawned = tostring
      IndexDistance = ImpulseZ
      Spawned = Spawned(IndexDistance)
      x = (x .. Spawned)
      (for limit) = (for limit)((for step), x)
      randomized((for index), (for limit))
      ImpulseY = ImpulseZ
    end
    ImpulseZ = math
    ImpulseZ = ImpulseZ.random
    randomized = data.RandomizerLimits
    randomized = randomized[1]
    randomized = randomized[1]
    (for index) = data.RandomizerLimits
    (for index) = (for index)[1]
    (for index) = (for index)[2]
    ImpulseZ = ImpulseZ(randomized, (for index))
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
    (for index) = data.RandomizerLimits
    (for index) = (for index)[2]
    (for index) = (for index)[2]
    ImpulseZ = ImpulseZ(randomized, (for index))
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
    (for index) = data.RandomizerLimits
    (for index) = (for index)[3]
    (for index) = (for index)[2]
    ImpulseZ = ImpulseZ(randomized, (for index))
    randomized = data.ImpulseValue
    ImpulseZ = (ImpulseZ * randomized)
    randomized = Distances[ImpulseY]
    randomized = randomized.z
    ImpulseZ = (ImpulseZ * randomized)
    ImpulseZ = Print
    randomized = "ImpulseX: "
    (for index) = tostring
    (for limit) = ImpulseX
    (for index) = (for index)((for limit))
    (for limit) = ", ImpulseY: "
    (for step) = tostring
    x = ImpulseY
    (for step) = (for step)(x)
    x = ", ImpulseZ: "
    Spawned = tostring
    IndexDistance = ImpulseZ
    Spawned = Spawned(IndexDistance)
    randomized = (((((randomized .. (for index)) .. (for limit)) .. (for step)) .. x) .. Spawned)
    ImpulseZ(randomized)
    ImpulseZ = ApplyImpulse
    randomized = ImpulseX[1]
    (for index) = ImpulseX
    (for limit) = ImpulseY
    (for step) = ImpulseZ
    ImpulseZ(randomized, (for index), (for limit), (for step))
    ImpulseZ = wait
    randomized = 0.05000000074505806
    ImpulseZ(randomized)
  end
  return 
end
