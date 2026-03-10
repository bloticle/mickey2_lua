Boss_SendStimulus = function(self, validStimTypes, event, target, stimAmount)
  if IsValidHandle(target) then
    for index, stimulusType in ipairs(validStimTypes) do
      if StimulusEvent_HasStimulusType(event, stimulusType) then
        local direction = GetVelocity(target)
        direction:normalize3()
        direction = (direction * -1)
        StimulusEntity(self, stimulusType, stimAmount, GetPosition(target), target, direction)
        if (stimulusType == ST_FAIRY) then
          NotifyFairySketchHit()
        end
      end
    end
  end
  return 
end
Boss_HasCorrectStimulus = function(validStimTypes, event)
  for index, stimulusType in ipairs(validStimTypes) do
    if StimulusEvent_HasStimulusType(event, stimulusType) then
      return true
    end
  end
  return false
end
Boss_OnPlayerStimulusAlias = function(entityThatReceivedStim, event, eventType, eventAliasToFind)
  if StimulusEvent_HasStimulusType(event, eventType) then
    local mickey = GetPlayer()
    local oswald = GetPlayer2OrAI()
    if (entityThatReceivedStim == mickey) then
      local name = StimulusEvent_SourceStimulusAlias(event)
      for index, currentAlias in ipairs(eventAliasToFind) do
        if (name == currentAlias) then
          return true
        end
      end
    end
  end
  return false
end
Boss_TeleportAway = function(Target)
  TeleportToEntity(GetPlayer(), Target)
  Wait(0.10000000149011612)
  OswaldTeleportToLocationAction(GetPlayer())
  return 
end
Boss_QuitToMain = function()
  LoadLevel(GetPlayer(), "Levels/Main_Menu.level")
  return 
end

