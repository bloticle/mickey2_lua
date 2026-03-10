PropellerBox_Lift = function(target, event)
  local data = GetPrefabData(target)
  if (data.IsLocked == false) then
    if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
      if (data.PropellerActive == false) then
        Print("^^^_________________^^^ PropellerBox_Lift: Electricity Activated")
        data.PropellerActive = true
        Enable(GetRelativePrefabEntity(target, ".Propellor"))
        TimerStart(30, 15, 8)
        local timerstate = "Ticking"
        local PropBox = GetRelativePrefabEntity(target, ".PropellerBox")
        while (timerstate == "Ticking") do
          ActivateFairySketch(PropBox)
          wait(0.30000001192092896)
          timerstate = TimerGetState()
        end
        FireThread(PropellerBox_Drop, target)
      else
        TimerSetTime(30)
        if StimulusEvent_HasStimulusType(event, ST_SPIN) then
          OswaldStreamAction(target, GetPrefabData(target).OswaldStreamTime)
        elseif StimulusEvent_HasStimulusType(event, ST_THINNER) then
          PropellerBox_Drop(target)
        end
      end
    elseif StimulusEvent_HasStimulusType(event, ST_SPIN) then
      OswaldStreamAction(target, GetPrefabData(target).OswaldStreamTime)
    elseif StimulusEvent_HasStimulusType(event, ST_THINNER) then
      PropellerBox_Drop(target)
    end
  end
  return 
end
PropellerBox_Drop = function(target)
  local data = GetPrefabData(target)
  Print("^^^_________________^^^ PropellerBox_Drop")
  TimerSetTime(0)
  TimerStop()
  if (data.PropellerActive == true) then
    Disable(GetRelativePrefabEntity(target, ".Propellor"))
    DeactivateFairySketch(GetRelativePrefabEntity(target, ".PropellerBox"))
    data.PropellerActive = false
  end
  return 
end
PropellorBox_Placed = function(target, loc)
  if (loc ~= "SplineFinished") then
    local knot = GetRelativePrefabEntity(target, ((".SK_" .. loc) .. "_1"))
    TeleportToEntity(knot, target)
    local SplineF = GetRelativePrefabEntity(target, (".SF_" .. loc))
    SplineFollower_TeleportToKnot(SplineF, knot)
    SetPhysicsVelocity(target, 0, 0, 0)
    DisableComponent(target, "Usable")
    wait(0)
    DisableMotion(target)
    wait(0)
    SetParentEntity(target, SplineF)
    SplineFollower_SetDisabled(SplineF, false)
    local data = GetPrefabData(target)
    if (loc == "Hard") then
      if IsValidHandle(GetRelativePrefabEntity(target, ".PropellerBoxReceptorTriggerEasy")) then
        DestroyEntity(GetRelativePrefabEntity(target, ".PropellerBoxReceptorTriggerEasy"))
      end
      data.IsLocked = true
    end
    Disable(GetRelativePrefabEntity(target, ".Propellor"))
    DeactivateFairySketch(target)
    data.PropellerActive = false
    SetVulnerability(target, ST_ELECTRIC, 0)
    SetVulnerability(target, ST_SPIN, 0)
    wait(0)
    TimerSetTime(0)
    TimerStop()
    if (data.Function ~= "None") then
      if (data.Function_Param2 ~= "None") then
        _G[data.Function](loc, data.Function_Param2)
      else
        _G[data.Function](loc)
      end
    end
    DestroyEntity(GetRelativePrefabEntity(target, (".PropellerBoxReceptorTrigger" .. loc)))
  else
    SplineFollower_SetDisabled(GetRelativePrefabEntity(target, ".SF_Easy"), true)
    wait(1)
    SetPhysicsVelocity(target, 0, 0, 0)
    ClearParent(target)
    EnableMotion(target)
    wait(0.10000000149011612)
    SetPhysicsVelocity(target, 0, 0, 0)
    TimerSetTime(0)
    TimerStop()
    EnableComponent(target, "Usable")
  end
  return 
end
playerInBoxSpot = 0
PropellorBox_PlayerInBlockSpot = function(target, state)
  if (state == "in") then
    playerInBoxSpot = 1
  else
    playerInBoxSpot = 0
  end
  return 
end
PropellorBox_PlayerBlock = function(target)
  if (playerInBoxSpot == 1) then
    SetPropertyInt(target, "Collision Layer", 13)
  end
  return 
end

