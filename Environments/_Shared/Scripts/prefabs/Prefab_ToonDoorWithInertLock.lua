Prefab_ToonDoorOpen = function(target)
  AudioPostEventOn(GetRelativePrefabEntity(target, ".LeftToonDoor"), "Play_sfx_rbf_Door_WoodOpen")
  AudioPostEventOn(GetRelativePrefabEntity(target, ".LeftToonDoor"), "Play_sfx_rbf_ChainLock_Break")
  DestroyEntity(GetRelativePrefabEntity(target, ".InertDoorLockBackColl"))
  DestroyEntity(GetRelativePrefabEntity(target, ".InertDoorLock"))
  EnableMotion(GetRelativePrefabEntity(target, ".LeftToonDoor"))
  EnableMotion(GetRelativePrefabEntity(target, ".RightToonDoor"))
  FireUser1(GetRelativePrefabEntity(target, ".RightToonDoor"))
  FireUser1(GetRelativePrefabEntity(target, ".LeftToonDoor"))
  return 
end
Prefab_ThinToonDoor = function(target, side)
  local data = GetPrefabData(target)
  if (side == "left") then
    data.LeftDoor = "Thinned"
  else
    data.RightDoor = "Thinned"
  end
  EnableMotion(GetRelativePrefabEntity(target, ".LeftToonDoor"))
  EnableMotion(GetRelativePrefabEntity(target, ".RightToonDoor"))
  EnableMotion(GetRelativePrefabEntity(target, ".InertDoorLock"))
  DestroyEntity(GetRelativePrefabEntity(target, ".InertDoorLockBackColl"))
  return 
end
Prefab_SetupToonDoors = function(target)
  SetEntitiesToNotCollide(GetRelativePrefabEntity(target, ".LeftToonDoor"), GetRelativePrefabEntity(target, ".RightToonDoor"))
  return 
end

