Prefab_EarthQuake_Event = function(target)
  local data = GetPrefabData(target)
  local fallingobject = GetRelativePrefabEntity(target, ".FallingObject")
  if (data.DropObject == "True") then
    Print("^^^^^^^^^Setting Speed to  =", data.FallingSpeed)
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".FallingObject"), data.FallingSpeed)
  end
  if (data.CameraShake == "True") then
    ShakeCamera(data.CameraShakeTime, data.CameraShakeFrequency, data.CameraShakeCenter, data.CameraShakeSharpness, data.CameraShakeVertical, data.CameraShakeHorizontal)
  end
  if (data.CameraLookAtObject == "True") then
    StartCameraPivotSnap(GetRelativePrefabEntity(target, ".FallingObject"), 0.05000000074505806, 0.05000000074505806, true, false)
  end
  FireUser1(target)
  return 
end
Prefab_EarthQuake_Setup = function(target)
  local data = GetPrefabData(target)
  local fallingobject = GetRelativePrefabEntity(target, ".FallingObject")
  if (data.DropObject == "False") then
    Print("^^^^^^^^^Hiding Object")
    Hide(fallingobject)
  end
  return 
end
Prefab_RandomEarthQuake_Setup = function(target)
  local data = GetPrefabData(target)
  SetPropertyFloat(GetRelativePrefabEntity(target, ".EarthquakeTimer"), "MinRandomInterval", data.RandomRange[1])
  SetPropertyFloat(GetRelativePrefabEntity(target, ".EarthquakeTimer"), "MaxRandomInterval", data.RandomRange[2])
  TimerReset(GetRelativePrefabEntity(target, ".EarthquakeTimer"))
  return 
end
Prefab_RandomEarthQuake_Event = function(target)
  local data = GetPrefabData(target)
  if (GetGlobal("EM2_EpisodeCheck") < 3) then
    if (GetActiveCameraTypeForPlayer(GetPlayer()) == Camera_Pass_Type_MainGame) then
      FireUser1(GetRelativePrefabEntity(target, ".EarthquakeTimer"))
      Rumble(nil, data.RumbleTime)
      Rumble(nil, data.RumbleTime, 1)
      AudioPostEventOn(GetPlayer(), "Play_sfx_EarthquakeCamShake")
      if (data.CameraShake[1] ~= "default") then
        ShakeCamera(tonumber(data.CameraShake[2]), tonumber(data.CameraShake[3]), tonumber(data.CameraShake[4]), tonumber(data.CameraShake[5]), tonumber(data.CameraShake[6]), tonumber(data.CameraShake[7]))
      else
        ShakeCamera(1.2999999523162842, 7, 0.5, 0.4000000059604645, 0.009999999776482582, 0.0020000000949949026)
      end
      if (data.SpawnDebris ~= "False") then
        SetTransformation(GetRelativePrefabEntity(target, ".DebrisSpawner"), GetPosition(GetPlayer()), vector4(0, 0, 0))
        ForceSpawn(GetRelativePrefabEntity(target, ".DebrisSpawner"), 1)
      end
      if (data.Voice == "True") then
        if (IsAnySequencePlaying() == false) then
          FireSequence(GetRelativePrefabEntity(target, ".EarthQuakeMickeyReact"), "Generic_Mickey_EarthquakeReact")
        end
      end
    end
  end
  return 
end
