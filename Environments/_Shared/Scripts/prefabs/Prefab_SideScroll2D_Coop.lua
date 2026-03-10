PlayerAbility2DAimOffset = function(player, valueX, valueZ)
  valueX = tonumber(valueX)
  valueZ = tonumber(valueZ)
  if (player == GetPlayer()) then
    Set2DAimOffset(PLAYER_ONE, vector4(valueX, 0, valueZ, 0))
  else
    Set2DAimOffset(PLAYER_TWO, vector4(valueX, 0, valueZ, 0))
  end
  return 
end
setupConstraint2 = function(target)
  SetCameraAttributesForPlayer(target, GetPlayerOrAI(PLAYER_TWO))
  return 
end
SetCameraAttributesForPlayerOnRevive = function(target, event, instigator)
  local subEvent = ReviveEvent_GetSubEvent(event)
  if (subEvent == ReviveEvent_Respawn) then
    SetCameraAttributesForPlayerOnRescue(target, instigator)
  end
  return 
end
SetCameraAttributesForPlayerOnRescue = function(target, instigator)
  if (GetPropertyInt(target, "SideScrollActive") == 2) then
    ClearCameraAttributesForPlayer(target, instigator)
    SetCameraAttributesForPlayer(target, instigator)
  end
  return 
end
SetCameraAttributesForPlayerOnReviveDelayed = function(target, event, instigator)
  local subEvent = ReviveEvent_GetSubEvent(event)
  if (subEvent == ReviveEvent_Respawn) then
    if (GetPropertyInt(target, "SideScrollActive") == 2) then
      wait(4)
      ClearCameraAttributesForPlayer(target, instigator)
      SetCameraAttributesForPlayer(target, instigator)
    end
  end
  return 
end

