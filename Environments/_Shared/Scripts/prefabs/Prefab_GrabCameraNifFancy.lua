Prefab_GrabCameraNifFancy = function(target)
  local data = GetPrefabData(target)
  if (data.IGCP == "None") then
    RestrictCutSceneInput()
    print(target)
    print((data.IGCP .. "Prefab Initial function"))
    if (data.PauseAllAI == "true") then
      PauseAllAI()
    end
  end
  local CameraAnim = GetRelativePrefabEntity(target, ".CameraAnimNif")
  FireThread(GrabCameraNifFancy, target, CameraAnim)
  return 
end
GrabCameraNifFancy = function(target, cameraAnim)
  local data = GetPrefabData(target)
  local fadeInTime = data.FadeInTime
  local fadeOutTime = data.FadeOutTime
  print(target, cameraAnim)
  local animDuration = AnimGBSequenceGetSequenceDuration(cameraAnim, data.AnimSequenceName)
  if (data.IGCP == "None") then
    print((data.IGCP .. "Prefab Second function 1"))
    if (0 < fadeInTime) then
      print("Fade Out!")
      StartFadeOut(fadeInTime)
      wait(fadeInTime)
    else
      print("Hide Hud!")
      HideHud()
    end
    if (data.DisablePlayerAudio == "true") then
      AudioPostEventOn(GetPlayer(), "Mute_Mickey")
    end
    print(animDuration)
    AnimGBReset(cameraAnim)
    SetLetterbox(1)
    if (0 < fadeInTime) then
      wait(0.20000000298023224)
      StartFadeInNoHUD()
    end
    GrabCameraNif(cameraAnim, nil, CAMERA_INSTANT_TRANSITION, 0)
    AnimGBReset(cameraAnim)
  end
  if (0 < data.WaitStart) then
    wait(data.WaitStart)
  end
  if (data.StartFunction ~= "None") then
    FireThread(_G[data.StartFunction])
  end
  if (data.IGCP ~= "None") then
    print((data.IGCP .. "Prefab Second function IGCP"))
    PlayIGC(data.IGCP)
  elseif (data.IGCP == "None") then
    print((data.IGCP .. "Prefab Second function None"))
    AnimGBReset(cameraAnim)
    AnimGBSequence(cameraAnim, data.AnimSequenceName)
    wait((animDuration - fadeInTime))
    if (0 < data.WaitEnd) then
      wait(data.WaitEnd)
    end
    if (0 < fadeOutTime) then
      StartFadeOut(fadeOutTime)
    end
    wait(fadeOutTime)
    SetLetterbox(0)
    if (0 < fadeOutTime) then
      print("Fade In!")
      StartFadeIn()
    else
      print("Show Hud!")
      ShowHud()
    end
    if (data.EndFunction ~= "None") then
      FireThread(_G[data.EndFunction])
    end
    if (data.PauseAllAI == "true") then
      UnpauseAllAI()
    end
    ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
    AudioPostEventOn(GetPlayer(), "Unmute_Mickey")
    UnrestrictCutSceneInput()
    print((data.IGCP .. "Prefab Second function END"))
  end
  return 
end
