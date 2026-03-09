local tempDeathFallSpeed = 0
local tempHardFallSpeed = 0
local bounceHeight = 0
local tempTrackIndex = 0
local tempTrackM, tempTrackO = nil, nil
BounceToPlane = function(teleLoc)
  local data = GetPrefabData(teleLoc)
  tempTrackM = GetEntity(data.cameraTrackMickey)
  tempTrackO = GetEntity(data.cameraTrackOswald)
  tempTrackIndex = data.trackIndexToSwapTo
  if (_activator() == GetPlayer()) then
    BounceMickeyToPlane(tempTrackM, teleLoc, tempTrackIndex)
  elseif (_activator() == GetPlayerOrAI(PLAYER_TWO)) then
    BounceOswaldToPlane(tempTrackO, GetRelativePrefabEntity(teleLoc, ".TeleLocOswald"), tempTrackIndex)
  end
  return 
end
local MickeyBusy = 0
BounceMickeyToPlane = function(trackObj, teleLoc, trackIndex)
  Print("BounceMickeyToPlane function entered")
  if (MickeyBusy == 0) then
    MickeyBusy = 1
    Print("BounceMickeyToPlane Mickey now busy")
    Prefab_MultiTrack_DisableControls(trackObj, GetPlayer())
    local data = GetPrefabData(teleLoc)
    bounceHeight = data.bounceHeight
    if (data.SkipDisableConstraint == false) then
      DisableSideScrollConstraint(trackObj, GetPlayer())
    end
    wait(data.ImpulseDelay)
    Print(("BounceMickeyToPlane applying Y impulse of " .. tostring(data.bounceHeight)))
    ApplyImpulse(GetPlayer(), 0, bounceHeight, 0)
    ActivateBounceAnim(teleLoc)
    wait(data.teleportDelay)
    if (data.SkipTeleport == false) then
      TeleportToEntity(GetPlayer(), teleLoc)
    else
      Print("BounceMickeyToPlane skipping teleport since SkipTeleport is true")
    end
    if (data.DelayTrackSwap == false) then
      DeactivateCameraOverrideTrack(trackObj, GetPlayer())
      ActivateCameraOverrideTrack(trackObj, GetPlayer(), trackIndex)
    end
    tempDeathFallSpeed = GetPropertyFloat(GetPlayer(), "MinDeathFallSpeed")
    tempHardFallSpeed = GetPropertyFloat(GetPlayer(), "MinHardFallSpeed")
    SetPropertyFloat(GetPlayer(), "MinDeathFallSpeed", 999)
    SetPropertyFloat(GetPlayer(), "MinHardFallSpeed", 999)
    if (0 < data.FlyUpTime) then
      wait(data.FlyUpTime)
      Print("BounceMickeyToPlane FlyUpTime > 0 so calling Prefab_MultiTrack_EnableControls for Mickey")
      Prefab_MultiTrack_EnableControls(trackObj, GetPlayer())
    end
    wait(data.fallDelay)
    SetPropertyFloat(GetPlayer(), "MinDeathFallSpeed", tempDeathFallSpeed)
    SetPropertyFloat(GetPlayer(), "MinHardFallSpeed", tempHardFallSpeed)
    if (data.DelayTrackSwap == true) then
      ActivateCameraOverrideTrack(trackObj, GetPlayer(), trackIndex)
    end
    if (data.FlyUpTime == -1) then
      Print("BounceMickeyToPlane FlyUpTime is -1 so calling Prefab_MultiTrack_EnableControls for Mickey")
      Prefab_MultiTrack_EnableControls(trackObj, GetPlayer())
    end
    if (data.EnableToss == true) then
      Prefab_MultiTrack_EnableToss(trackObj)
    end
    MickeyBusy = 0
    Print(("BounceMickeyToPlane no longer busy, MickeyBusy = " .. tostring(MickeyBusy)))
  end
  return 
end
local OswaldBusy = 0
BounceOswaldToPlane = function(trackObj, teleLoc, trackIndex)
  Print("BounceOswaldToPlane function entered")
  if (OswaldBusy == 0) then
    OswaldBusy = 1
    Print("BounceOswaldToPlane Oswald now busy")
    Prefab_MultiTrack_DisableControls(trackObj, GetPlayerOrAI(PLAYER_TWO))
    local data = GetPrefabData(teleLoc)
    bounceHeight = data.bounceHeight
    if (data.SkipDisableConstraint == false) then
      DisableSideScrollConstraint(trackObj, GetPlayerOrAI(PLAYER_TWO))
    end
    wait(data.ImpulseDelay)
    Print(("BounceOswaldToPlane applying Y impulse of " .. tostring(data.bounceHeight)))
    ApplyImpulse(GetPlayerOrAI(PLAYER_TWO), 0, bounceHeight, 0)
    ActivateBounceAnim(teleLoc)
    wait(data.teleportDelay)
    if (data.SkipTeleport == false) then
      TeleportToEntity(GetPlayerOrAI(PLAYER_TWO), teleLoc)
    else
      Print("BounceOswaldToPlane skipping teleport since SkipTeleport is true")
    end
    if (data.DelayTrackSwap == false) then
      DeactivateCameraOverrideTrack(trackObj, GetPlayerOrAI(PLAYER_TWO))
      ActivateCameraOverrideTrack(trackObj, GetPlayerOrAI(PLAYER_TWO), trackIndex)
    end
    tempDeathFallSpeed = GetPropertyFloat(GetPlayerOrAI(PLAYER_TWO), "MinDeathFallSpeed")
    tempHardFallSpeed = GetPropertyFloat(GetPlayerOrAI(PLAYER_TWO), "MinHardFallSpeed")
    SetPropertyFloat(GetPlayerOrAI(PLAYER_TWO), "MinDeathFallSpeed", 999)
    SetPropertyFloat(GetPlayerOrAI(PLAYER_TWO), "MinHardFallSpeed", 999)
    if (0 < data.FlyUpTime) then
      wait(data.FlyUpTime)
      Print("BounceOswaldToPlane FlyUpTime > 0 so calling Prefab_MultiTrack_EnableControls for Oswald")
      Prefab_MultiTrack_EnableControls(trackObj, GetPlayerOrAI(PLAYER_TWO))
    end
    wait(data.fallDelay)
    SetPropertyFloat(GetPlayerOrAI(PLAYER_TWO), "MinDeathFallSpeed", tempDeathFallSpeed)
    SetPropertyFloat(GetPlayerOrAI(PLAYER_TWO), "MinHardFallSpeed", tempHardFallSpeed)
    if (data.DelayTrackSwap == true) then
      ActivateCameraOverrideTrack(trackObj, GetPlayerOrAI(PLAYER_TWO), trackIndex)
    end
    if (data.FlyUpTime == -1) then
      Print("BounceOswaldToPlane FlyUpTime is -1 so calling Prefab_MultiTrack_EnableControls for Oswald")
      Prefab_MultiTrack_EnableControls(trackObj, GetPlayerOrAI(PLAYER_TWO))
    end
    if (data.EnableToss == true) then
      Prefab_MultiTrack_EnableToss(trackObj)
    end
    OswaldBusy = 0
    Print(("BounceOswaldToPlane no longer busy, OswaldBusy = " .. tostring(OswaldBusy)))
  end
  return 
end
ActivateBounceAnim = function(target)
  local data = GetPrefabData(target)
  if (data.SkipSpingPad == false) then
    wait(0.15000000596046448)
    AnimGBSequence(GetRelativePrefabEntity(target, ".SpringPad 01"), "launch")
    wait(0.6000000238418579)
    AnimGBSequence(GetRelativePrefabEntity(target, ".SpringPad 01"), "idle")
  end
  return 
end
