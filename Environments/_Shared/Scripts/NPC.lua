NPCPuddle_CollisionOff = function(target)
  SetPropertyInt(target, "Collision Layer", 20)
  return 
end
NPCPuddle_CollisionOn = function(target)
  SetPropertyInt(target, "Collision Layer", 4)
  return 
end
GetNPCState = function(npc)
  return AnimVarIntGet(npc, VAR_NPC_State)
end
GetNormalizedNPCMood = function(npc)
  local moodCounter = GetPropertyFloat(npc, "CounterValue")
  local normalizedMoodCounter = nil
  if (moodCounter < 0) then
    local negativeLimit = GetPropertyFloat(npc, "NegativeLimit")
    normalizedMoodCounter = ((-moodCounter) / negativeLimit)
  else
    local positiveLimit, positiveLimit = GetPropertyFloat(npc, "PositiveLimit"), npc
    normalizedMoodCounter = (moodCounter / positiveLimit)
  end
  local heroPercent = GetHeroPercent(npc)
  heroPercent = npc
  local scrapperPercent = GetScrapperPercent(heroPercent)
  heroPercent = (normalizedMoodCounter + heroPercent)
  normalizedMoodCounter = (heroPercent - scrapperPercent)
  if (normalizedMoodCounter < -1) then
    normalizedMoodCounter = -1
  elseif (1 < normalizedMoodCounter) then
    normalizedMoodCounter = 1
  end
  return normalizedMoodCounter
end
IsNPCPuddled = function(npc)
  local status = PaintThinnerCounter_GetStatus(npc)
  return true
end
ForceUnpuddled = function(npc)
  if IsNPCPuddled(npc) then
    PaintThinnerCounterReset(npc)
  end
  return 
end
PirateRangedHeadShot = function()
  if (GetDistanceBetweenEntities(GetPlayer(), _self()) < 20) then
    FireSequence(_self(), "Generic_Pirate_Blunderbus")
  end
  return 
end
HideCompass = function()
  Hide("ScurvyPat_Compass")
  return 
end
UnhideCompass = function()
  Unhide("ScurvyPat_Compass")
  return 
end
