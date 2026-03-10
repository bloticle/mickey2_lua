CAMERA_INSTANT_TRANSITION = 0
CAMERA_LERP_TRANSITION = 1
CAMERA_SAMEPLACE_TRANSITION = 2
CAMERA_EASING_TRANSITION = 3
StartCDC = function(cam1, cam1look)
  RestrictCutSceneInput()
  GrabCamera(cam1, cam1look, CAMERA_LERP_TRANSITION, 0.5)
  Enable(cam1)
  Enable(cam1look)
  return 
end
GrabCam2 = function(cam2, cam2look)
  wait(3)
  GrabCamera(cam2, cam2look, CAMERA_INSTANT_TRANSITION, 0.5)
  Enable(cam2)
  wait(1)
  AnimEvent(cam2look, EVENT_Start_Jump)
  wait(2)
  EndCDC()
  return 
end
EndCDC = function()
  UnrestrictCutSceneInput()
  ReleaseCamera(CAMERA_LERP_TRANSITION, 0.5)
  return 
end

