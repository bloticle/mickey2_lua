MechExitCamera = "Cam_lookathole"
MechDefencePhase2Stop = 0
Mech_LookAtExit = function()
  ClearAllCameraAttributes()
  SetCameraAttributesForPlayer(MechExitCamera, nil)
  return 
end
Mech_Stream = function()
  OswaldStartFollowAction()
  Mech_LookAtExit()
  AudioPostEventOn(GetPlayer(), "Play_mboss_trans_forcefield_loop")
  ShakeCamera(5, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  while true do
    if (not (LevelManager_HasStateFinishedStreaming() == false)) then
      break
    end
    wait(0.25)
  end
  while true do
    if (not (LevelManager_WaitingForStreamingSync() == false)) then
      break
    end
    Wait(0.05000000074505806)
  end
  Show("LightBeam")
  AudioPostEventOn(GetPlayer(), "Play_mboss_trans_forcefield_stop")
  wait(1)
  Print("In Stream, Disabling all oswald patrol nodes")
  DestroyEntity("ReprogramDoor1Node")
  Disable("BuddyAIHintLoc7")
  ForEachEntityInGroup(Disable, "AllOswaldPatrolNodes")
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    StartFadeOut(0.5)
    AudioPostEventOn(GetPlayer(), "Play_mboss_TransitionFadeOutFX")
    wait(0.5)
    LevelManager_SetCurrentState("FTL_PrescottsArena.Outside")
    WaitForLevelLoad()
    UnrestrictCutSceneInput()
    EnableSplitScreen(true)
    AudioPostEventOn(GetPlayer(), "Play_mboss_TransitionFadeInFX")
    FTL_PrescottArena02_CheckpointLoad()
  end
  return 
end
MechTurret_SpawnJunk = function()
  local (for index), (for limit), (for step) = 1, 6, 1
  for num = (for index), (for limit), (for step) do
    ForEachEntityInGroup(ForceSpawn, ("InsideSpawnerGroup1 " .. num), 1)
    Wait(0.10000000149011612)
    ForEachEntityInGroup(ForceSpawn, ("InsideSpawnerGroup2 " .. num), 1)
    Wait(0.10000000149011612)
    ForEachEntityInGroup(ForceSpawn, ("InsideSpawnerGroup3 " .. num), 1)
    Wait(0.10000000149011612)
  end
  return 
end
Floor_SpawnDirection = ""
MechTurret_SpawnFloorToon = function(target, stim)
  local Floor_Position = GetPosition(target)
  Floor_Position.y = (Floor_Position.y + 1)
  Floor_SpawnDirection = (GetPosition(GetPlayer()) - GetPosition(target))
  Floor_SpawnDirection:normalize3()
  Floor_SpawnDirection.y = 2
  local MechTurret_SpawnFloor = function(stim)
    if IsValidHandle(PickupSpawner) then
      SetTransformation(PickupSpawner, Floor_Position, vector4(0, 0, 0))
      if (stim == "Paint") then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 4, 0)
      elseif (stim == "Thin") then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 5, 0)
      end
      local spawnedItems = ForceSpawn(PickupSpawner, 1)
      local velocity = (Floor_SpawnDirection * 3.200000047683716)
      ApplyImpulse(spawnedItems[1], velocity.x, velocity.y, velocity.z)
      local ammo = GetChildEntityByName(spawnedItems[1], "Ammo_Paint")
      if (IsValidHandle(ammo) == false) then
        ammo = GetChildEntityByName(spawnedItems[1], "Ammo_Thinner")
      end
      local NIF = GetChildEntityByName(ammo, "Ammo_Paint_Nif")
      if (IsValidHandle(NIF) == false) then
        NIF = GetChildEntityByName(ammo, "Ammo_Thinner_Parentable")
      end
      if IsValidHandle(NIF) then
        SetPropertyFloat(NIF, "Bone Scale Multiplier", 0, 0)
        SetPropertyFloat(NIF, "Lifetime", 30, 0)
        SetPropertyBool(NIF, "Shrink Over Lifetime", true, 0)
        PlayerPickup_SetPendingActivation(NIF, 2)
      end
    end
    return 
  end
  SetGlobal("Prefab_JigsawRewardChance", (GetGlobal("Prefab_JigsawRewardChance") + 1))
  local i = 0
  i = ((GetGlobal("Prefab_JigsawRewardChance") / 4) * math.random(1, 100))
  if (75 < i) then
    SetGlobal("Prefab_JigsawRewardChance", 0)
    MechTurret_SpawnFloor(stim)
  end
  return 
end
TempMechTimerCheck = true
TEMP_TimerForArcadeMech = function()
  while true do
    if (not TempMechTimerCheck) then
      break
    end
    IncrementGlobal("MSN_Arcade_TimerPrescott")
    wait(1)
  end
  return 
end
