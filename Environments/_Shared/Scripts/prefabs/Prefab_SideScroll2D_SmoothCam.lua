Prefab_SmoothCam_EnableTransitionTimes = function(target)
  Print(("Prefab_SmoothCam_EnableTransitionTimes function entered, called by " .. tostring(GetName(target))))
  local data = GetPrefabData(target)
  SetPropertyBool(data.MickeyFrontCamera, "InstantTransition", false)
  SetPropertyBool(GetRelativePrefabEntity(data.MickeyFrontCamera, ".Player2_Override"), "InstantTransition", false)
  if (data.IsMultiTrack == true) then
    SetPropertyBool(data.MickeyBackCamera, "InstantTransition", false)
    SetPropertyBool(GetRelativePrefabEntity(data.MickeyBackCamera, ".Player2_Override"), "InstantTransition", false)
  end
  return 
end
Prefab_SmoothCam_CustomRevive = function(target, event, instigator)
  local subEvent = ReviveEvent_GetSubEvent(event)
  if (subEvent == ReviveEvent_Respawn) then
    Print(("Prefab_SmoothCam_CustomRevive respawn calling Prefab_SmoothCam_CustomRescue for " .. GetPropertyString(instigator, "EntityGroups", 0)))
    Prefab_SmoothCam_CustomRescue(target, instigator)
  end
  return 
end
Prefab_SmoothCam_CustomRescue = function(target, instigator)
  local data = GetPrefabData(target)
  local OswaldFrontCamera = GetRelativePrefabEntity(data.MickeyFrontCamera, ".Player2_Override")
  if (data.IsMultiTrack == true) then
    local OswaldTrackObj = GetRelativePrefabEntity(data.MickeyTrackObj, ".Oswald_CameraOverrideTracks")
    local OswaldBackCamera = GetRelativePrefabEntity(data.MickeyBackCamera, ".Player2_Override")
    if (instigator == GetPlayer()) then
      Print("Prefab_SmoothCam_CustomRescue Mickey, MultiTrack")
      SetPropertyBool(data.MickeyFrontCamera, "InstantTransition", true)
      SetPropertyBool(data.MickeyBackCamera, "InstantTransition", true)
      DeactivateCameraOverrideTrack(data.MickeyTrackObj, instigator)
      ActivateCameraOverrideTrack(data.MickeyTrackObj, instigator)
      SetPropertyBool(data.MickeyFrontCamera, "InstantTransition", false)
      SetPropertyBool(data.MickeyBackCamera, "InstantTransition", false)
    else
      Print("Prefab_SmoothCam_CustomRescue Oswald, MultiTrack")
      SetPropertyBool(OswaldFrontCamera, "InstantTransition", true)
      SetPropertyBool(OswaldBackCamera, "InstantTransition", true)
      DeactivateCameraOverrideTrack(OswaldTrackObj, instigator)
      ActivateCameraOverrideTrack(OswaldTrackObj, instigator)
      SetPropertyBool(OswaldFrontCamera, "InstantTransition", false)
      SetPropertyBool(OswaldBackCamera, "InstantTransition", false)
      if (instigator == GetPlayer()) then
        Print("Prefab_SmoothCam_CustomRescue Mickey, Single Track")
        SetPropertyBool(data.MickeyFrontCamera, "InstantTransition", true)
        ClearCameraAttributesForPlayer(data.MickeyFrontCamera, instigator)
        SetCameraAttributesForPlayer(data.MickeyFrontCamera, instigator)
        SetPropertyBool(data.MickeyFrontCamera, "InstantTransition", false)
      else
        Print("Prefab_SmoothCam_CustomRescue Oswald, Single Track")
        SetPropertyBool(OswaldFrontCamera, "InstantTransition", true)
        ClearCameraAttributesForPlayer(OswaldFrontCamera, instigator)
        SetCameraAttributesForPlayer(OswaldFrontCamera, instigator)
        SetPropertyBool(OswaldFrontCamera, "InstantTransition", false)
      end
    end
  elseif (instigator == GetPlayer()) then
    Print("Prefab_SmoothCam_CustomRescue Mickey, Single Track")
    SetPropertyBool(data.MickeyFrontCamera, "InstantTransition", true)
    ClearCameraAttributesForPlayer(data.MickeyFrontCamera, instigator)
    SetCameraAttributesForPlayer(data.MickeyFrontCamera, instigator)
    SetPropertyBool(data.MickeyFrontCamera, "InstantTransition", false)
  else
    Print("Prefab_SmoothCam_CustomRescue Oswald, Single Track")
    SetPropertyBool(OswaldFrontCamera, "InstantTransition", true)
    ClearCameraAttributesForPlayer(OswaldFrontCamera, instigator)
    SetCameraAttributesForPlayer(OswaldFrontCamera, instigator)
    SetPropertyBool(OswaldFrontCamera, "InstantTransition", false)
  end
  return 
end

