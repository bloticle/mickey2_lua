Prefab_ThinnerWaterfall = function(trigger, target, hasPlaystyle, useVisual)
  if (target == GetPlayer()) then
    if (GetPropertyBool(target, "Indelible") ~= true) then
      local playstyle = 0
      if (hasPlaystyle ~= nil) then
        if (useVisual == nil) then
          playstyle = GetPropertyFloat(trigger, "CurrentPlaystyle")
        else
          playstyle = GetPropertyFloat(GetRelativePrefabEntity(trigger, ".GuardianPoolVisible_Visual"), "CurrentPlaystyle")
        end
      end
      local varPainted = GetPropertyBool(trigger, "Is Painted")
      local varReal = GetPropertyBool(trigger, "Is Real")
      if (playstyle <= 0.30000001192092896) then
        if (not (not varPainted)) then
          local PlaySound = function()
            local player = "mickey"
            if (target == GetPlayer2OrAI()) then
              player = "oswald"
            end
            if (GetPrefabData(trigger)[(player .. "hit")] == false) then
              GetPrefabData(trigger)[(player .. "hit")] = true
              AudioPostEventOn(target, (("Play_vocal_" .. player) .. "_pipdeath"))
              wait(1)
              GetPrefabData(trigger)[(player .. "hit")] = false
            end
            return 
          end
          if TriggeredFromAbove(trigger, target) then
            if (CanDamageLeapFromThinnerWaterfall(target) == true) then
              StimulusEntity(trigger, ST_DAMAGE_LEAP, 0.033330000936985016, GetPosition(target), target)
              if varPainted then
                if (varReal == false) then
                  FireThread(PlaySound)
                end
              end
            end
          else
            local returnContactPosition = GetNotTriggeredFromAboveContactPosition(trigger)
            local direction = GetCalculatedDirectionForThinnerWaterfalls(target, returnContactPosition)
            StimulusEntity(trigger, ST_KNOCKBACK, 20, GetPosition(target), target, direction)
            if varPainted then
              if (varReal == false) then
                FireThread(PlaySound)
              end
            end
          end
        end
      end
    end
  end
  return 
end
Prefab_SurfaceDamage = function(trigger, activator)
  if (activator == GetPlayer()) then
    if (GetPropertyBool(activator, "Indelible") ~= true) then
      if TriggeredFromAbove(trigger, activator) then
        SetCameraDamageLeapValues(activator, GetPrefabData(trigger).CameraDamageLeapActive, GetPrefabData(trigger).CameraHeight, GetPrefabData(trigger).CameraDistance)
        StimulusEntity(trigger, ST_DAMAGE_LEAP, GetPrefabData(trigger).DamageLeapPower, GetPosition(activator), activator)
      else
        local direction = GetPreviousPhysicsVelocity(activator)
        direction:normalize3()
        direction = (direction * -1)
        StimulusEntity(trigger, ST_KNOCKBACK, GetPrefabData(trigger).KnockbackPower, GetPosition(activator), activator, direction)
      end
    end
  end
  return 
end
