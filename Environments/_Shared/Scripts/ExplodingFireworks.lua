ExplodingFireworks_Detonate = function(target, event)
  local child = GetChildEntityByIndex(target, 0)
  if (not (not StimulusEvent_HasStimulusType(event, ST_ELECTRIC))) then
    if (0 < GetHealth(target)) then
      SetHealth(target, 0)
      SetPropertyFloat(target, "UsableRadius", 0)
      AudioPostEventOn(GetPlayer(), "Play_sfx_fireworxBucket_explode")
      AnimGBSequence(target, "Active")
      Unhide(child)
      StartEmitters(child)
      SetPropertyBool(target, "ActionSpotEnabled", false)
      Wait(0.800000011920929)
      OswaldStreamAbort()
      Wait(2.4000000953674316)
      ClearParent(child)
      Wait(3.4000000953674316)
      DestroyEntity(child)
    end
  end
  return 
end
ExplodingFireworks_DestroyEnemy = function(activator, event)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    local AITypeString = GetPropertyString(_self(), "AIType")
    if (string.find(AITypeString, "Blotworx") ~= nil) then
      if (0 < GetHealth(_self())) then
        SetHealth(_self(), 0)
        RaiseCrushedByAnvilEvent(activator, _self())
      end
    end
    if (string.find(AITypeString, "SpatterMelee") ~= nil) then
      Kill(_self())
    end
  end
  return 
end

