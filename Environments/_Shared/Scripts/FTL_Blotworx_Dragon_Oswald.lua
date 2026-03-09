shockedPanel = 0
canShock = true
hitPanel = 0
dragonAttackingHandID = 0
FTL_BlotworxDragon_OswaldShockFloor = function(floorID, handID)
  local targetEntity = ("ShockTarget" .. floorID)
  local slamRepeller = "DragonImpendingSlamRepeller"
  dragonAttackingHandID = handID
  if (GetEntity(targetEntity) ~= nil) then
    if (GetPlayer2OrAI() ~= nil) then
      local targetDistance = GetDistanceBetweenEntities(GetPlayer2OrAI(), targetEntity)
      local fleeDistance = GetDistanceBetweenEntities(GetPlayer2OrAI(), slamRepeller)
      if (5 < targetDistance) then
        if (10 < fleeDistance) then
          OswaldStreamAction(targetEntity, 1)
          OswaldStartFollowAction()
        end
      end
    end
  end
  return 
end
FTL_BlotworxDragon_GetSectorData = function()
  local headingToMickey = 0
  local headingToOswald = 0
  local headingOfDragon = GetHeading("BlotworxDragon")
  if (GetPlayer() ~= nil) then
    headingToMickey = GetHeadingToTarget("BlotworxDragon", GetPlayer())
  end
  if GetPlayer2OrAI() then
    headingToOswald = GetHeadingToTarget("BlotworxDragon", GetPlayer2OrAI())
  end
  local dragonSectorIdx = BlotworxDragon_GetSectorAtFacing("BlotworxDragon", headingOfDragon)
  local mickeySectorIdx = BlotworxDragon_GetSectorAtFacing("BlotworxDragon", headingToMickey)
  local oswaldSectorIdx = BlotworxDragon_GetSectorAtFacing("BlotworxDragon", headingToOswald)
  local mickeyDragonDiff = math.abs((dragonSectorIdx - mickeySectorIdx))
  if (6 < mickeyDragonDiff) then
    mickeyDragonDiff = (12 - mickeyDragonDiff)
  end
  local oswaldDragonDiff = math.abs((dragonSectorIdx - oswaldSectorIdx))
  if (6 < oswaldDragonDiff) then
    oswaldDragonDiff = (12 - oswaldDragonDiff)
  end
  local oswaldMickeyDiff = math.abs((mickeySectorIdx - oswaldSectorIdx))
  if (6 < oswaldMickeyDiff) then
    oswaldMickeyDiff = (12 - oswaldMickeyDiff)
  end
  return dragonSectorIdx, mickeySectorIdx, oswaldSectorIdx, mickeyDragonDiff, oswaldDragonDiff, oswaldMickeyDiff
end
FTL_BlotworxDragon_FloorShock = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    if canShock then
      canShock = false
      if (target ~= nil) then
        local shockEffect = "ShockEffect"
        local targetName = GetPropertyString(target, "EntityGroups", 1)
        local targetNumber = string.sub(targetName, 13)
        local shockEffectMarker = ("ShockTarget" .. targetNumber)
        if (GetEntity(shockEffectMarker) ~= nil) then
          local shockEffectPosition = GetPosition(shockEffectMarker)
          SetTransformation(shockEffect, vector4(shockEffectPosition.x, shockEffectPosition.y, shockEffectPosition.z), vector4(0, 0, 0))
        end
        StartEmitters(shockEffect)
        shockedPanel = tonumber(targetNumber)
        FireThread(FTL_BlotworxDragon_ShockDragon)
        wait(1)
        StopEmitters(shockEffect)
        shockedPanel = 0
      end
      Wait(3)
      canShock = true
    end
  end
  return 
end
FTL_BlotworxDragon_ShockDragon = function()
  while true do
    if (shockedPanel == hitPanel) then
      BlotworxDragon_SetArmAttackBoxEnabled("BlotworxDragon", false)
      if (dragonAttackingHandID == 0) then
        BlotworxDragon_StartStunnedState("BlotworxDragon", EVENT_Stage1ShockLeftHand)
      elseif (dragonAttackingHandID == 1) then
        BlotworxDragon_StartStunnedState("BlotworxDragon", EVENT_Stage1ShockRightHand)
      elseif (dragonAttackingHandID == 2) then
        BlotworxDragon_StartStunnedState("BlotworxDragon", EVENT_Shock)
      end
      FireThread(FTL_BlotworxDragon_AttackOswaldForAWhile)
    else
      wait(0.20000000298023224)
    end
  end
  return 
end
blotworxDragonHasStartedAttackingOswald = false
FTL_BlotworxDragon_AttackOswaldForAWhile = function()
  if (not blotworxDragonHasStartedAttackingOswald) then
    blotworxDragonHasStartedAttackingOswald = true
    local player2Handle = GetPlayer2OrAI()
    if IsValidHandle(player2Handle) then
      BlotworxDragon_SetAttackTarget("BlotworxDragon", player2Handle)
    end
    Wait(15)
    local playerHandle = GetPlayer()
    if IsValidHandle(playerHandle) then
      BlotworxDragon_SetAttackTarget("BlotworxDragon", playerHandle)
    end
    blotworxDragonHasStartedAttackingOswald = false
  end
  return 
end
