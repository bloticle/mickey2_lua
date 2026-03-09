Prefab_DevilMouthLower = function(target)
  Unhide("DevilMouthRisingPlatform")
  local data = GetPrefabData(target)
  local DevilMouth = GetRelativePrefabEntity(target, ".DevilMouth")
  SetSplineFollowerInitialSpeed(DevilMouth, 1.100000023841858)
  SplineFollower_StopAtPosition(DevilMouth, GetRelativePrefabEntity(target, ".RisingDevilMouthSKTop"), GetRelativePrefabEntity(target, ".RisingDevilMouthSKBottom"), 1)
  DoStinger("RBC_Devil_Mouth", 2)
  AudioPostEventOn(GetRelativePrefabEntity(target, ".DevilMouth"), "Play_sfx_DemonMouthOpening")
  if (data.MouthOpened == false) then
    ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
    Rumble(nil, 1)
    Rumble(nil, 1, 1)
    ForEachEntityInGroup(StartEmitters, "DevilFaceDust")
  end
  wait(0.5)
  SetPropertyFloat(GetRelativePrefabEntity(target, ".TurningColumn"), "Activate Radius", 0)
  return 
end
Prefab_DevilMouthOpened = function(target)
  local data = GetPrefabData(target)
  if (data.MouthOpened == false) then
    data.MouthOpened = true
    Print("Devil Mouth Fully Opened")
    wait(0.5)
    ShakeCamera(3, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
    Rumble(nil, 2)
    Rumble(nil, 2, 1)
    SetGlobal("RBC_DevilMouthSetup", 1)
    RBC_SaveCheckpoint()
  end
  return 
end
Prefab_DevilMouthSetupCheck = function(target)
  Print("Prefab_DevilMouthSetup: ")
  if (GetGlobal("RBC_DevilMouthSetup") == 1) then
    Print("Prefab_DevilMouthSetup: Setting up the mouth to be open")
    SetSplineFollowerInitialSpeed("DevilMouthRisingPlatform", 100)
    local data = GetPrefabData(target)
    data.MouthOpened = true
    local DevilMouth = GetRelativePrefabEntity(target, ".DevilMouth")
    Disable(GetRelativePrefabEntity(target, ".DevilMouthTrigger"))
    DestroyEntity("FallingDevilNose")
    SetSplineFollowerInitialSpeed(DevilMouth, 15)
    SplineFollower_StopAtPosition(DevilMouth, GetRelativePrefabEntity(target, ".RisingDevilMouthSKTop"), GetRelativePrefabEntity(target, ".RisingDevilMouthSKBottom"), 1)
    Wait(0.5)
    Unhide("DevilMouthRisingPlatform")
  end
  return 
end
