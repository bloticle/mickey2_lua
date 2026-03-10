Prefab_SparkDelayAtStart = function(target)
  local data = GetPrefabData(target)
  wait(data.StartDelay)
  TimerEnable(GetRelativePrefabEntity(target, ".SparkTimer"))
  return 
end
Prefab_SparkCycle = function(target)
  local data = GetPrefabData(target)
  if (GetPropertyBool(GetRelativePrefabEntity(target, ".SparksFX"), "StartEmittersEnabled") == false) then
    if (data.WarningSpark == "true") then
      StartEmitters(GetRelativePrefabEntity(target, ".SparksWarningFX"))
      wait(0.75)
    end
    SetPropertyBool(GetRelativePrefabEntity(target, ".SparksFX"), "StartEmittersEnabled", true)
    StartEmitters(GetRelativePrefabEntity(target, ".SparksFX"))
    wait(0.20000000298023224)
    Enable(GetRelativePrefabEntity(target, ".SparksTrigger"))
    SetPropertyFloat(GetRelativePrefabEntity(target, ".SparkTimer"), "TimerInterval", data.TimeOn)
  elseif (GetPropertyBool(GetRelativePrefabEntity(target, ".SparksFX"), "StartEmittersEnabled") == true) then
    SetPropertyBool(GetRelativePrefabEntity(target, ".SparksFX"), "StartEmittersEnabled", false)
    Disable(GetRelativePrefabEntity(target, ".SparksTrigger"))
    StopEmitters(GetRelativePrefabEntity(target, ".SparksFX"))
    if (data.TimedWarning ~= "false") then
      StopEmitters(GetRelativePrefabEntity(target, ".SparksWarningFX"))
    end
    SetPropertyFloat(GetRelativePrefabEntity(target, ".SparkTimer"), "TimerInterval", data.TimeOff)
  end
  return 
end
Prefab_SparkKnockback = function(target)
  local data = GetPrefabData(target)
  if (data.Knockback == "true") then
    StimulusEntityWithAliasInEntityDirectionInRadius(GetRelativePrefabEntity(target, ".SparksTrigger"), ST_KNOCKBACK, data.KnockbackAmount, 0, _activator(), GetRelativePrefabEntity(target, ".SparksKnockbackMarker"), "")
  end
  return 
end

