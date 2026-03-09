Setup_2DCoopMultiTrack = function(target)
  Print("********Setup_2DCoopMultiTrack")
  local data = GetPrefabData(target)
  local tempTrackIndex = data.startTrackMickey
  ActivateCameraOverrideTrack(target, GetPlayer(), tempTrackIndex)
  tempTrackIndex = data.startTrackOswald
  ActivateCameraOverrideTrack(GetRelativePrefabEntity(target, ".Oswald_CameraOverrideTracks"), GetPlayerOrAI(PLAYER_TWO), tempTrackIndex)
  return 
end
ActivateCameraOverrideTrackOnRevive = function(target, event, instigator)
  local subEvent = ReviveEvent_GetSubEvent(event)
  if (subEvent == ReviveEvent_Respawn) then
    ActivateCameraOverrideTrackOnRescue(target, instigator)
  end
  return 
end
ActivateCameraOverrideTrackOnRescue = function(target, instigator)
  DeactivateCameraOverrideTrack(target, instigator)
  ActivateCameraOverrideTrack(target, instigator)
  return 
end
SetMickeyPlane = function(target, trackIndex)
  if (0 < GetHealth(GetPlayer())) then
    trackIndex = tonumber(trackIndex)
    DeactivateCameraOverrideTrack(target, GetPlayer())
    ActivateCameraOverrideTrack(target, GetPlayer(), trackIndex)
  end
  return 
end
SetOswaldPlane = function(target, trackIndex)
  if (0 < GetHealth(GetPlayerOrAI(PLAYER_TWO))) then
    trackIndex = tonumber(trackIndex)
    DeactivateCameraOverrideTrack(target, GetPlayerOrAI(PLAYER_TWO))
    ActivateCameraOverrideTrack(target, GetPlayerOrAI(PLAYER_TWO), trackIndex)
  end
  return 
end
SetMickeyPlaneWithTeleport = function(target, trackIndex, teleLoc, mvSkipDisableConstraint)
  if (0 < GetHealth(GetPlayer())) then
    trackIndex = tonumber(trackIndex)
    Print(("SetMickeyPlaneWithTeleport has mvSkipDisableConstraint = " .. tostring(mvSkipDisableConstraint)))
    if (mvSkipDisableConstraint ~= "true") then
      DisableSideScrollConstraint(target, GetPlayer())
    end
    TeleportToEntity(GetPlayer(), teleLoc)
    DeactivateCameraOverrideTrack(target, GetPlayer())
    ActivateCameraOverrideTrack(target, GetPlayer(), trackIndex)
  end
  return 
end
SetOswaldPlaneWithTeleport = function(target, trackIndex, teleLoc, mvSkipDisableConstraint)
  if (0 < GetHealth(GetPlayerOrAI(PLAYER_TWO))) then
    trackIndex = tonumber(trackIndex)
    Print(("SetOswaldPlaneWithTeleport has mvSkipDisableConstraint = " .. tostring(mvSkipDisableConstraint)))
    if (mvSkipDisableConstraint ~= "true") then
      DisableSideScrollConstraint(target, GetPlayerOrAI(PLAYER_TWO))
    end
    TeleportToEntity(GetPlayerOrAI(PLAYER_TWO), teleLoc)
    DeactivateCameraOverrideTrack(target, GetPlayerOrAI(PLAYER_TWO))
    ActivateCameraOverrideTrack(target, GetPlayerOrAI(PLAYER_TWO), trackIndex)
  end
  return 
end
Prefab_MultiTrack_DisableControls = function(target, character)
  Print("Prefab_MultiTrack_DisableControls function entered")
  local data = GetPrefabData(target)
  if (character == GetPlayer()) then
    if (data.MickeyControls == true) then
      data.MickeyControls = false
      IncrementAllAbilitiesDisabled(GetPlayer())
      DisableMovementInput(GetPlayer())
      Print("Prefab_MultiTrack_DisableControls disabled movement and abilities for Mickey")
    end
  elseif (data.OswaldControls == true) then
    data.OswaldControls = false
    DisableToggleSecondPlayer(true)
    IncrementAllAbilitiesDisabled(GetPlayerOrAI(PLAYER_TWO))
    DisableMovementInput(GetPlayerOrAI(PLAYER_TWO))
    Print("Prefab_MultiTrack_DisableControls disabled toggle, movement, and abilities for Oswald")
  end
  return 
end
Prefab_MultiTrack_EnableControls = function(target, character)
  Print("Prefab_MultiTrack_EnableControls function entered")
  local data = GetPrefabData(target)
  if (character == GetPlayer()) then
    if (data.MickeyControls == false) then
      data.MickeyControls = true
      EnableMovementInput(GetPlayer())
      DecrementAllAbilitiesDisabled(GetPlayer())
      Print("Prefab_MultiTrack_EnableControls enabled movement and abilities for Mickey")
    end
  elseif (data.OswaldControls == false) then
    data.OswaldControls = true
    EnableMovementInput(GetPlayerOrAI(PLAYER_TWO))
    DecrementAllAbilitiesDisabled(GetPlayerOrAI(PLAYER_TWO))
    DisableToggleSecondPlayer(false)
    Print("Prefab_MultiTrack_EnableControls enabled toggle, movement, and abilities for Oswald")
  end
  return 
end
Prefab_MultiTrack_DisableTossCheck = function(target)
  Print("Prefab_MultiTrack_DisableTossCheck function entered")
  while true do
    wait(0)
  end
  Print(("Prefab_MultiTrack_DisableTossCheck 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
  if (string.sub(tostring(GetGlobal("2dDirection")), -2, -2) ~= string.sub(tostring(GetGlobal("2dDirection")), -1, -1)) then
    Print("Prefab_MultiTrack_DisableTossCheck calling Prefab_MultiTrack_DisableToss since Mickey and Oswald on different tracks")
    Prefab_MultiTrack_DisableToss(target)
  end
  return 
end
Prefab_MultiTrack_DisableToss = function(target)
  Print("Prefab_MultiTrack_DisableToss function entered")
  local data = GetPrefabData(target)
  if (data.TossAbilityActive == true) then
    data.TossAbilityActive = false
    IncrementAbilityDisabled(GetPlayer(), "Toss")
    Print("Prefab_MultiTrack_DisableToss disabled Toss ability")
  end
  return 
end
Prefab_MultiTrack_EnableToss = function(target)
  Print("Prefab_MultiTrack_EnableToss function entered")
  local data = GetPrefabData(target)
  if (data.TossAbilityActive == false) then
    data.TossAbilityActive = true
    DecrementAbilityDisabled(GetPlayer(), "Toss")
    Print("Prefab_MultiTrack_EnableToss enabled Toss ability")
  end
  return 
end
