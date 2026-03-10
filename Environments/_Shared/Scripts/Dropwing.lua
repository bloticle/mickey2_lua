StimIsKilling = function(stimulusEvent)
  if StimulusEvent_HasStimulusType(stimulusEvent, ST_SPIN) then
    if (0 < StimulusEvent_EffectiveAmount(stimulusEvent, ST_SPIN)) then
      return true
    end
  end
  if StimulusEvent_HasStimulusType(stimulusEvent, ST_ELECTRIC) then
    if (0 < StimulusEvent_EffectiveAmount(stimulusEvent, ST_ELECTRIC)) then
      return true
    end
  end
  if StimulusEvent_HasStimulusType(stimulusEvent, ST_KNOCKBACK) then
    if (0 < StimulusEvent_EffectiveAmount(stimulusEvent, ST_KNOCKBACK)) then
      return true
    end
  end
  return false
end
ResolveStim = function(projectile, stimulusEvent)
  local bubbleState = GetPropertyFloat(projectile, "CurrentPlaystyle")
  local toType = nil
  if StimulusEvent_HasStimulusType(stimulusEvent, ST_PAINT) then
    if (bubbleState == 0) then
      toType = ST_PAINT
      ProjectileComponent_SetStimType(projectile, 0, toType)
      ProjectileComponent_SetStimType(projectile, 1, toType)
      ProjectileComponent_SetDecalToUse(projectile, toType)
      SetPropertyFloat(projectile, "CurrentPlaystyle", 1, 0)
    end
  elseif StimulusEvent_HasStimulusType(stimulusEvent, ST_THINNER) then
    if (bubbleState == 1) then
      toType = ST_THINNER
      ProjectileComponent_SetStimType(projectile, 0, toType)
      ProjectileComponent_SetStimType(projectile, 1, toType)
      ProjectileComponent_SetDecalToUse(projectile, toType)
      SetPropertyFloat(projectile, "CurrentPlaystyle", 0, 0)
    end
  elseif StimIsKilling(stimulusEvent) then
    ProjectileComponent_DetonateGrenade(projectile)
  end
  return 
end
AnalyzeThresholdEvent = function(thresholdEvent)
  local fromStatus = PaintThinnerThresholdEvent_GetFromStatus(thresholdEvent)
  local toStatus = PaintThinnerThresholdEvent_GetToStatus(thresholdEvent)
  local doChange = false
  local toType = nil
  if (fromStatus == PTCS_Thinner) then
    if (toStatus ~= PTCS_Paint) then
      if (toStatus ~= PTCS_OverPainted) then
        doChange = false
      end
    end
    doChange = true
    toType = ST_PAINT
  elseif (fromStatus == PTCS_Neutral) then
    if (toStatus == PTCS_Thinner) then
      doChange = false
    end
    doChange = true
    toType = ST_PAINT
  elseif (fromStatus == PTCS_Paint) then
    if (toStatus == PTCS_OverPainted) then
      doChange = false
    end
    doChange = true
    toType = ST_THINNER
  else
    if (toStatus == PTCS_Paint) then
      doChange = false
    end
    doChange = true
    toType = ST_THINNER
  end
  return doChange, toType
end
StimTypeSwitch = function(projectile, thresholdEvent)
  local doChange, toType = AnalyzeThresholdEvent(thresholdEvent)
  if doChange then
    ProjectileComponent_SetStimType(projectile, 0, toType)
    ProjectileComponent_SetDecalToUse(projectile, toType)
    if (toType == ST_PAINT) then
      SetPropertyFloat(projectile, "CurrentPlaystyle", 1, 0)
    else
      SetPropertyFloat(projectile, "CurrentPlaystyle", 0, 0)
    end
  end
  return 
end
DropwingSideSwitch = function(dropwing, thresholdEvent)
  local doChange, toType = AnalyzeThresholdEvent(thresholdEvent)
  if doChange then
    local weapon = GetChildEntityByName(dropwing, "DropWingBubbleWeapon")
    if (toType == ST_PAINT) then
      local paintBubble = GetPropertyString(weapon, "Templates To Spawn", 3)
      SetPropertyString(weapon, "Templates To Spawn", paintBubble, 0)
      local paintBubbleSmall = GetPropertyString(weapon, "Templates To Spawn", 5)
      SetPropertyString(weapon, "Templates To Spawn", paintBubbleSmall, 1)
    else
      local thinnerBubble, thinnerBubble = GetPropertyString(weapon, "Templates To Spawn", 2), "Templates To Spawn"
      thinnerBubble = weapon
      SetPropertyString(thinnerBubble, "Templates To Spawn", thinnerBubble, 0)
      thinnerBubble = weapon
      local thinnerBubbleSmall, thinnerBubbleSmall = GetPropertyString(thinnerBubble, "Templates To Spawn", 4), "Templates To Spawn"
      thinnerBubble = SetPropertyString
      thinnerBubbleSmall = weapon
      thinnerBubble(thinnerBubbleSmall, "Templates To Spawn", thinnerBubbleSmall, 1)
    end
  end
  return 
end
HideGroundBubble = function(bubble)
  SetAppCulledOnNode(bubble, "air", false)
  SetAppCulledOnNode(bubble, "landed", true)
  return 
end
HideAirBubble = function(bubble)
  SetAppCulledOnNode(bubble, "air", true)
  SetAppCulledOnNode(bubble, "landed", false)
  ResetAllTimeControllers(bubble)
  return 
end
Grabbed_Player1 = 0
Grabbed_Player2 = 0
Dropwing_DisplayGrabControls = function(state)
  Print("______________Dropwing_DisplayGrabControls")
  if (state == "start") then
    Print("______________Dropwing_DisplayGrabControls:START")
    Wait(0.8999999761581421)
    if (GetPropertyEntity(GetPlayer(), "Parent Entity", 0) ~= nil) then
      if (Grabbed_Player1 == 0) then
        Grabbed_Player1 = 1
        StartEmitterByName(_self(), "DropwingShakeIcon")
        Print("______________Dropwing_DisplayGrabControls:START:GRAB")
      end
    elseif (GetPropertyEntity(GetPlayer2(), "Parent Entity", 0) ~= nil) then
      if (Grabbed_Player2 == 0) then
        Grabbed_Player2 = 1
        StartEmitterByName(_self(), "DropwingShakeIcon")
        if (state == "end") then
          Print("______________Dropwing_DisplayGrabControls:END")
          Wait(1)
          if (GetPropertyEntity(GetPlayer(), "Parent Entity", 0) == nil) then
            if (Grabbed_Player1 == 1) then
              Grabbed_Player1 = 0
              StopEmitterByName(_self(), "DropwingShakeIcon")
              Print("______________Dropwing_DisplayGrabControls:END:GRAB")
            end
          elseif (GetPropertyEntity(GetPlayer2(), "Parent Entity", 0) == nil) then
            if (Grabbed_Player2 == 1) then
              Grabbed_Player2 = 0
              StopEmitterByName(_self(), "DropwingShakeIcon")
            end
          end
        end
      end
    end
  elseif (state == "end") then
    Print("______________Dropwing_DisplayGrabControls:END")
    Wait(1)
    if (GetPropertyEntity(GetPlayer(), "Parent Entity", 0) == nil) then
      if (Grabbed_Player1 == 1) then
        Grabbed_Player1 = 0
        StopEmitterByName(_self(), "DropwingShakeIcon")
        Print("______________Dropwing_DisplayGrabControls:END:GRAB")
      end
    elseif (GetPropertyEntity(GetPlayer2(), "Parent Entity", 0) == nil) then
      if (Grabbed_Player2 == 1) then
        Grabbed_Player2 = 0
        StopEmitterByName(_self(), "DropwingShakeIcon")
      end
    end
  end
  return 
end
Dropwing_CullControls = function(self)
  if (Grabbed_Player1 == 1) then
    SetAppCulledViewport(self, 1)
  elseif (Grabbed_Player2 == 1) then
    SetAppCulledViewport(self, 0)
  end
  return 
end

