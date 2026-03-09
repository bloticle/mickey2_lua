Prefab_SetHintTimer = function(target)
  local data = GetPrefabData(target)
  SetPropertyFloat(target, "TimerInterval", data.TimeBetweenHints)
  return 
end
Prefab_EnableRepeatingHint = function(target)
  local data = GetPrefabData(target)
  TimerEnable(GetRelativePrefabEntity(target, ".LogicTimer"))
  data.CurrentlyActive = true
  if (data.FireSequenceOnTimerActivated == true) then
    Prefab_RepeatHint(target)
  end
  return 
end
Prefab_DisableRepeatingHint = function(target)
  local data = GetPrefabData(target)
  TimerDisable(GetRelativePrefabEntity(target, ".LogicTimer"))
  TimerReset(GetRelativePrefabEntity(target, ".LogicTimer"))
  data.CurrentlyActive = false
  return 
end
Prefab_RepeatHint = function(target)
  local data = GetPrefabData(target)
  FireThread(Prefab_FireHint, target)
  Prefab_AdjustReapeatingHintTimer(target)
  return 
end
Prefab_FireHint = function(target)
  local data = GetPrefabData(target)
  if (data.CurrentlyActive == true) then
    if (IsAnySequencePlaying() == false) then
      if (data.Sequence[1] == "UsePrefabMarker") then
        if (data.ForcedSequence == false) then
          FireSequence(GetRelativePrefabEntity(target, ".ConversationMarker"), data.Sequence[2])
        elseif (data.ForcedSequence == true) then
          ForceSequence(GetRelativePrefabEntity(target, ".ConversationMarker"), data.Sequence[2])
          if (data.ForcedSequence == false) then
            FireSequence(data.Sequence[1], data.Sequence[2])
          elseif (data.ForcedSequence == true) then
            ForceSequence(data.Sequence[1], data.Sequence[2])
          end
        end
      elseif (data.ForcedSequence == false) then
        FireSequence(data.Sequence[1], data.Sequence[2])
      elseif (data.ForcedSequence == true) then
        ForceSequence(data.Sequence[1], data.Sequence[2])
      end
    end
  end
  return 
end
Prefab_AdjustReapeatingHintTimer = function(target)
  local data = GetPrefabData(target)
  if (0 < data.IncreaseHintTimeAfterHintBy) then
    data.TimeBetweenHints = (data.TimeBetweenHints + data.IncreaseHintTimeAfterHintBy)
    if (data.MaximumTimeBetweenHints < data.TimeBetweenHints) then
      data.TimeBetweenHints = data.MaximumTimeBetweenHints
    end
    SetPropertyFloat(GetRelativePrefabEntity(target, ".LogicTimer"), "TimerInterval", data.TimeBetweenHints)
  end
  TimerDisable(GetRelativePrefabEntity(target, ".LogicTimer"))
  TimerReset(GetRelativePrefabEntity(target, ".LogicTimer"))
  if (data.CurrentlyActive == true) then
    TimerEnable(GetRelativePrefabEntity(target, ".LogicTimer"))
  end
  Print(GetPropertyFloat(GetRelativePrefabEntity(target, ".LogicTimer"), "TimerInterval"))
  return 
end
