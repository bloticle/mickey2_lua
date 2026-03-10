Prefab_HandleShocked = function(target, event)
  local data = GetPrefabData(target)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    if (data.SwitchActive == "true") then
      data.SwitchActive = "false"
      FireThread(_G[data.ShockFunction], target)
    end
  end
  return 
end
Prefab_StartGrabCamera = function(target)
  GrabCamera(GetRelativePrefabEntity(target, ".GrabCamera"), nil, CAMERA_LERP_TRANSITION, 0.5)
  return 
end
Prefab_ReleaseGrabCamera = function(target)
  ReleaseCamera(CAMERA_SAMEPLACE_TRANSITION, 0.5)
  return 
end
Prefab_PowerNodeUp = function(target)
  Prefab_OswaldElectricSwitch_ChangeState("RF_PipeArmActivatorSwitch", "Activate")
  SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".SplineFollower"), 2)
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".SplineFollower"), GetRelativePrefabEntity(target, ".BoxKnot1"), GetRelativePrefabEntity(target, ".BoxKnot2"), 1)
  return 
end
Prefab_PowerNodeDown = function(target)
  Prefab_OswaldElectricSwitch_ChangeState("RF_PipeArmActivatorSwitch", "Deactivate")
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".SplineFollower"), GetRelativePrefabEntity(target, ".BoxKnot1"), GetRelativePrefabEntity(target, ".BoxKnot2"), 0)
  return 
end
Prefab_DisableFallsElectricNode = function()
  Prefab_OswaldElectricSwitch_ChangeState("RF_PipeArmActivatorSwitch", "Deactivate")
  return 
end
fallsHandleOut = 0
Prefab_TrigReleaseFallsHandle = function(target, state)
  if (state == "paint") then
    fallsHandleOut = 1
  else
    fallsHandleOut = 0
  end
  return 
end
Prefab_GrabbedExtendedFallsHandle = function()
  if (fallsHandleOut == 1) then
    if (GetGlobal("RF_PipeIGCPlayed") == 0) then
      Prefab_OswaldElectricSwitch_ChangeState("RF_PipeArmActivatorSwitch", "Activate")
    end
  end
  return 
end
Prefab_StartHandleCam = function(target)
  Print("setcam")
  SetCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".HandleCameraOverride"), _activator())
  return 
end
Prefab_EndHandleCam = function(target)
  Print("endcam")
  ClearCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".HandleCameraOverride"), _activator(), 1)
  return 
end

