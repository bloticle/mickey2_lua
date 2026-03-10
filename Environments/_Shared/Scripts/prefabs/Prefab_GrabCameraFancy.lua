Prefab_GrabCameraFancy = function(target)
  local data = GetPrefabData(target)
  if (data.NoRevive == false) then
    Print("**************  GrabCameraFancy  Reviving ")
    StartScriptedIGC()
  end
  if (data.IGCP == "None") then
    if (data.shotOrder == "first") then
      RestrictCutSceneInput()
    end
    if (data.pauseAllAI == "true") then
      PauseAllAI()
    end
    local lookAt = nil
    if (data.LookAtActor_Usage ~= "none") then
      lookAt = GetRelativePrefabEntity(target, ".CameraLookAt")
    end
    local CameraStart = GetRelativePrefabEntity(target, ".CameraStart")
    local CameraEnd = GetRelativePrefabEntity(target, ".CameraEnd")
    if (data.Camera_ReverseOrder == "true") then
      CameraStart = GetRelativePrefabEntity(target, ".CameraEnd")
      CameraEnd = GetRelativePrefabEntity(target, ".CameraStart")
    end
    if (data.hasDialogue[1] == "EntityName") then
      GrabCameraFancy(target, CameraStart, CameraEnd, lookAt)
    else
      FireThread(GrabCameraFancy, target, CameraStart, CameraEnd, lookAt)
      wait(((data.fadeInTime * 2) + 0.5))
      if (data.hasDialogue[3] ~= nil) then
        ForceSequence(data.hasDialogue[1], data.hasDialogue[2], 1)
      else
        FireSequence(data.hasDialogue[1], data.hasDialogue[2], 1)
      end
    end
  end
  return 
end
GrabCameraFancy = function(target, cameraStart, cameraEnd, cameraLookAt)
  local data = GetPrefabData(target)
  local transitionTime = data.transitionTime
  local fadeInTime = data.fadeInTime
  local fadeOutTime = data.fadeOutTime
  if (data.IGCP == "None") then
    if (0 < fadeInTime) then
      if (data.SkipInitialFadeOut == "false") then
        StartFadeOut(fadeInTime)
        wait(fadeInTime)
      end
    else
      HideHud()
    end
    if (not data.AllowSplitScreen) then
      EnableSplitScreen(false)
    end
    if (data.shotOrder ~= "last") then
      if (data.shotOrder ~= "only") then
        if (data.EndFunction ~= "None") then
          FireThread(_G[data.EndFunction])
        end
      end
    end
    if (data.DisablePlayerAudio == "true") then
      AudioPostEventOn(GetPlayer(), "Mute_Mickey")
    end
    local firstLookAt = nil
    if (data.LookAtActor_Usage == "always") then
      firstLookAt = cameraLookAt
    end
    GrabCamera(cameraStart, firstLookAt, CAMERA_LERP_TRANSITION, 0)
    if (not data.SkipLetterBox) then
      SetLetterbox(1)
    end
    if (0 < fadeInTime) then
      wait(0.20000000298023224)
      StartFadeInNoHUD()
    end
  end
  if (0 < data.waitStart) then
    wait(data.waitStart)
  end
  if (data.IGCP == "None") then
    GrabCamera(cameraEnd, cameraLookAt, CAMERA_LERP_TRANSITION, transitionTime)
    wait((transitionTime - fadeInTime))
    if (0 < data.waitEnd) then
      wait(data.waitEnd)
    end
    if (data.SkipFireUser2 == "false") then
      FireUser2(GetRelativePrefabEntity(target, ".CameraLookAt"))
    end
    if (data.shotOrder == "last") then
      if (0 < fadeOutTime) then
        StartFadeOut(fadeOutTime)
      end
      wait(fadeOutTime)
      Prefab_FancyCamRelease(target)
      if (0 < fadeOutTime) then
        if (data.ReturnHUD_OnRelease == "true") then
          StartFadeIn()
        end
      elseif (0 < fadeOutTime) then
        if (data.ReturnHUD_OnRelease == "false") then
          StartFadeInNoHUD()
        end
      else
        ShowHud()
      end
      if (data.EndFunction ~= "None") then
        FireThread(_G[data.EndFunction])
      end
      UnrestrictCutSceneInput()
      if (data.pauseAllAI == "true") then
        UnpauseAllAI()
      end
    end
    AudioPostEventOn(GetPlayer(), "Unmute_Mickey")
  end
  return 
end
Prefab_GrabCameraFancyOnlyFade = function(target)
  local data = GetPrefabData(target)
  if (data.IGCP == "None") then
    if (0 < data.fadeOutTime) then
      StartFadeOut(data.fadeOutTime)
      wait(data.fadeOutTime)
    else
      HideHud()
    end
    if (data.ReturnHUD_OnUser4 == "false") then
      if (data.shotOrder == "mid_norelease") then
        wait(0.20000000298023224)
      end
      StartFadeInNoHUD()
    elseif (data.ReturnHUD_OnUser4 == "true") then
      Prefab_FancyCamRelease(target)
      StartFadeIn()
      ShowHud()
    end
    UnpauseAllAI()
  end
  return 
end
Prefab_GrabCameraFancy_FadeRelease = function(target)
  local data = GetPrefabData(target)
  if (data.IGCP == "None") then
    StartFadeOut(data.fadeOutTime)
    wait(data.fadeOutTime)
    ReleaseCamera(CAMERA_EASING_TRANSITION, 0)
    Prefab_FancyCamRelease(target)
    StartFadeIn()
    ShowHud()
    UnpauseAllAI()
    UnrestrictCutSceneInput()
  end
  return 
end
Prefab_GrabCameraFancy_Release_NoFading = function(waitTime, SkipLetterBox)
  ReleaseCamera(CAMERA_EASING_TRANSITION, waitTime)
  if (wait ~= nil) then
    wait(waitTime)
  end
  EnableSplitScreen(true)
  if (SkipLetterBox ~= nil) then
    SetLetterbox(0)
  end
  SetCharacterInConversation(GetPlayer(), 0)
  ShowHud()
  UnpauseAllAI()
  UnrestrictCutSceneInput()
  return 
end
Prefab_FancyCamRelease = function(target)
  local data = GetPrefabData(target)
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
  EnableSplitScreen(true)
  SetCharacterInConversation(GetPlayer(), 0)
  if (not data.SkipLetterBox) then
    SetLetterbox(0)
  end
  if (FlythroughProjector == "") then
    Print("************************************* - FlythroughProjector == nothing")
  else
    Print("************************************* - FlythroughProjector == something")
    SetCameraAttributesForPlayer(FlythroughProjector, GetPlayer())
    if (1 < GetNumPlayers()) then
      SetCameraAttributesForPlayer(FlythroughProjector, GetPlayer2())
    end
    FlythroughProjector = ""
  end
  return 
end
FlythroughProjector = ""
Prefab_FlythroughProjector = function(target)
  Print("************************************* - Prefab_FlythroughProjector Started")
  FlythroughProjector = GetRelativePrefabEntity(target, ".ProjectorMarker")
  Print("************************************* - Prefab_FlythroughProjector Finished")
  return 
end
Prefab_FlythroughProjector_Reset = function(target)
  Print("************************************* - Prefab_FlythroughProjector_Reset")
  FlythroughProjector = ""
  return 
end

