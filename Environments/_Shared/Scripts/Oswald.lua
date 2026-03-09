OswaldActionSpotEnableSetup = function(target)
  local data = GetPrefabData(target)
  local toots = data.StartEnabled
  Print(("BUDDYACTION: Start Enabled = " .. toots))
  if (data.StartEnabled ~= "Ignore") then
    if (data.StartEnabled == "true") then
      SetPropertyBool(target, "ActionSpotEnabled", true)
    else
      SetPropertyBool(target, "ActionSpotEnabled", false)
    end
  end
  return 
end
OswaldActionSpotSetup = function(target)
  local data = GetPrefabData(target)
  Print("BUDDYACTION: Initialize Setup")
  if (data.TossOswald == "true") then
    SetPropertyBool(target, "TakeNoAction", true)
    if (data.ThoughtBubblePalette == "OswaldGlideThoughtBubble") then
      SetPropertyString(target, "ThoughtBubblePalette", data.ThoughtBubblePalette, 0)
    else
      SetPropertyString(target, "ThoughtBubblePalette", "OswaldTossOswaldThoughtBubble", 0)
      if (data.RequirePermission == "false") then
        SetPropertyString(target, "ThoughtBubblePalette", "", 0)
      else
        SetPropertyString(target, "ThoughtBubblePalette", data.ThoughtBubblePalette, 0)
        SetPropertyString(target, "MickeyThoughtBubblePalette", "OswaldCallForHelpThoughtBubble", 0)
      end
    end
  elseif (data.RequirePermission == "false") then
    SetPropertyString(target, "ThoughtBubblePalette", "", 0)
  else
    SetPropertyString(target, "ThoughtBubblePalette", data.ThoughtBubblePalette, 0)
    SetPropertyString(target, "MickeyThoughtBubblePalette", "OswaldCallForHelpThoughtBubble", 0)
  end
  return 
end
OswaldActionSpotStart = function(target)
  local data = GetPrefabData(target)
  if (data.FunctionName ~= "None") then
    local parameter1 = nil
    if (data.FunctionParam1 == "target") then
      parameter1 = target
    elseif (data.FunctionParam1 ~= "None") then
      parameter1 = data.FunctionParam1
    end
    if (data.FunctionParam3 ~= "None") then
      FireThread(_G[data.FunctionName], parameter1, data.FunctionParam2, data.FunctionParam3)
    elseif (data.FunctionParam3 == "None") then
      if (data.FunctionParam2 ~= "None") then
        FireThread(_G[data.FunctionName], parameter1, data.FunctionParam2)
      end
    elseif (data.FunctionParam2 == "None") then
      if (data.FunctionParam1 ~= "None") then
        FireThread(_G[data.FunctionName], parameter1)
      end
    else
      FireThread(_G[data.FunctionName])
    end
  end
  return 
end
OswaldStartFollowAction = function()
  ClearNextPatrolNode(GetOswaldAI())
  OswaldStartMovingAction()
  return 
end
OswaldStopFollowAction = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_StopFollowEntity)
  return 
end
OswaldStopMovingAction = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_StopFollowEntity)
  QueueBrainEvent(GetOswaldAI(), BRAIN_StopWander)
  return 
end
OswaldStartMovingAction = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_StartFollowEntity)
  QueueBrainEvent(GetOswaldAI(), BRAIN_StartWander)
  return 
end
OswaldSetPathAction = function(pathnode)
  QueueBrainEvent(GetOswaldAI(), BRAIN_StopFollowEntity)
  SetNextPatrolNode(GetOswaldAI(), pathnode)
  return 
end
OswaldBlastAction = function(target)
  QueueBrainEvent(GetOswaldAI(), BRAIN_ElectricBlast, vector4(0, 0, 0, 0), target)
  return 
end
local AboutToAskOswaldToStream = false
OswaldStreamAction = function(target, timeout)
  if (AboutToAskOswaldToStream == false) then
    if (AI_GetActiveBehaviorName(GetOswaldAI()) ~= "ScriptedElectricStream") then
      AboutToAskOswaldToStream = true
      QueueBrainEvent(GetOswaldAI(), BRAIN_StopFollowEntity)
      QueueBrainEvent(GetOswaldAI(), BRAIN_ElectricStreamStart, vector4(0, 0, 0, 0), target)
      Wait(0)
      Wait(0)
      AboutToAskOswaldToStream = false
      if (AI_GetActiveBehaviorName(GetOswaldAI()) ~= "ScriptedElectricStream") then
        OswaldStreamAbort()
        return 
      end
      if (timeout ~= nil) then
        timeout = tonumber(timeout)
      else
        timeout = 10
      end
      if (timeout == -1) then
        return 
      end
      local endTime = (GetElapsedTime() + timeout)
      local brokeEarly = false
      local brokeEarlyBecauseOfATossed = false
      while true do
        while true do
          if (GetElapsedTime() < endTime) then
            Wait(0)
            local behaviorName = AI_GetActiveBehaviorName(GetOswaldAI())
          end
        end
        if (behaviorName == "InputDrivenGlide") then
          brokeEarlyBecauseOfATossed = true
        end
        brokeEarly = true
      end
      if (brokeEarly ~= true) then
        OswaldStreamAbort()
      elseif (brokeEarlyBecauseOfATossed == true) then
        OswaldStartFollowAction()
      end
    end
  end
  return 
end
OswaldStreamPause = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_ElectricStreamStop)
  return 
end
OswaldStreamAbort = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_ElectricStreamStop)
  OswaldStartFollowAction()
  return 
end
OswaldGlideAction = function(end_target)
  local data = GetPrefabData(end_target)
  AudioPostEventOn(GetPlayer(), "Play_vox_Oswald_effort")
  Wait(1)
  if (data.GlidePathPoint1 ~= "none") then
    QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Follow_Path)
  else
    QueueBrainEvent(GetOswaldAI(), BRAIN_Glide, GetPosition(end_target))
  end
  OswaldStartFollowAction()
  return 
end
OswaldGlideAndWaitAction = function(end_target)
  local data = GetPrefabData(end_target)
  AudioPostEventOn(GetPlayer(), "Play_vox_Oswald_effort")
  Wait(1)
  if (data.GlidePathPoint1 ~= "none") then
    QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Follow_Path_Wait_For_Attach)
  else
    QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Wait_For_Attach, GetPosition(end_target))
  end
  Enable(GetRelativePrefabEntity(end_target, ".CameraTrigger"))
  OswaldStartFollowAction()
  Wait(7)
  Disable(GetRelativePrefabEntity(end_target, ".CameraTrigger"))
  return 
end
OswaldGlideActionCheck = function(end_target)
  local data = GetPrefabData(end_target)
  ClearNextPatrolNode(GetOswaldAI())
  OswaldStopFollowAction()
  OswaldClearGlideTargetsAction()
  local (for index), (for limit), (for step) = 1, 8, 1
  for i = (for index), (for limit), (for step) do
    local temp = ("GlidePathPoint" .. i)
    if (data[temp] ~= "none") then
      OswaldAddGlideTargetAction(data[temp])
    end
  end
  if (data.WaitForMickey == "false") then
    OswaldGlideAction(end_target)
  elseif (data.WaitForMickey == "true") then
    OswaldGlideAndWaitAction(end_target)
  end
  return 
end
OswaldFollowGlidePathAction = function()
  AudioPostEventOn(GetPlayer(), "Play_vox_Oswald_effort")
  Wait(1)
  QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Follow_Path)
  OswaldStartFollowAction()
  return 
end
OswaldAddGlideTargetAction = function(target)
  QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Add_Target, GetPosition(target))
  return 
end
OswaldClearGlideTargetsAction = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Clear_Targets)
  return 
end
OswaldTossAction = function()
  ClearNextPatrolNode(GetOswaldAI())
  QueueBrainEvent(GetOswaldAI(), BRAIN_StopFollowEntity)
  QueueBrainEvent(GetOswaldAI(), BRAIN_Tosser)
  Wait(0)
  Wait(0)
  if (AI_GetActiveBehaviorName(GetOswaldAI()) ~= "ScriptedTosser") then
    OswaldTossAbort()
    ClearThought(GetPlayer())
    return 
  end
  while true do
    if (not (AI_GetActiveBehaviorName(GetOswaldAI()) == "ScriptedTosser")) then
      break
    end
    Wait(0.25)
  end
  OswaldStartFollowAction()
  return 
end
OswaldTossAbort = function()
  ClearThought(GetPlayer())
  QueueBrainEvent(GetOswaldAI(), BRAIN_Toss_Abort)
  OswaldStartFollowAction()
  return 
end
OswaldSpinAction = function(target)
  QueueBrainEvent(GetOswaldAI(), BRAIN_Spin, vector4(0, 0, 0, 0), target)
  return 
end
OswaldAddBoomerangTarget = function(target)
  if (GetPropertyFloat(target, "Target Value", 0) ~= nil) then
    QueueBrainEvent(GetOswaldAI(), BRAIN_Boomerang_Add_Target, vector4(0, 0, 0, 0), target)
  else
    local numChildren = GetElementCount(target, "Child Entities")
    local (for index), (for limit), (for step) = 0, numChildren, 1
    for index = (for index), (for limit), (for step) do
      local child = GetChildEntityByIndex(target, index)
      if (GetPropertyFloat(child, "Target Value", 0) ~= nil) then
        QueueBrainEvent(GetOswaldAI(), BRAIN_Boomerang_Add_Target, vector4(0, 0, 0, 0), child)
        index = numChildren
      end
    end
  end
  return 
end
OswaldBoomerangAction = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_StopFollowEntity)
  QueueBrainEvent(GetOswaldAI(), BRAIN_Boomerang, vector4(0, 0, 0, 0))
  OswaldStartFollowAction()
  return 
end
OswaldSingleTargetBoomerangAction = function(target)
  QueueBrainEvent(GetOswaldAI(), BRAIN_Boomerang_Clear_Targets)
  OswaldAddBoomerangTarget(target)
  OswaldBoomerangAction()
  return 
end
OswaldClearBoomerangTargets = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_Boomerang_Clear_Targets)
  return 
end
OswaldTeleportToMickeyAction = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_StopFollowEntity)
  local pos, res = nil, nil
  pos = --[[ return 2 of ]] FindOswaldTeleportEntity(GetOswaldAI(), GetPlayer(), 5)
  res = FindOswaldTeleportEntity(GetOswaldAI(), GetPlayer(), 5)
  if res then
    QueueBrainEvent(GetOswaldAI(), BRAIN_Teleport, pos)
  end
  OswaldStartFollowAction()
  return 
end
OswaldTeleportToLocationAction = function(target)
  QueueBrainEvent(GetOswaldAI(), BRAIN_StopFollowEntity)
  local pos, res = nil, nil
  pos = --[[ return 2 of ]] FindOswaldTeleportEntity(GetOswaldAI(), target, 5)
  res = FindOswaldTeleportEntity(GetOswaldAI(), target, 5)
  if res then
    QueueBrainEvent(GetOswaldAI(), BRAIN_Teleport, pos)
  end
  OswaldStartFollowAction()
  return 
end
OswaldJumpAction = function(target)
  ClearNextPatrolNode(GetOswaldAI())
  QueueBrainEvent(GetOswaldAI(), BRAIN_Jump, GetPosition(target))
  OswaldStartFollowAction()
  return 
end
OswaldJumpNoFollowAction = function(target)
  ClearNextPatrolNode(GetOswaldAI())
  QueueBrainEvent(GetOswaldAI(), BRAIN_Jump, GetPosition(target))
  return 
end
OswaldIgnoreObstaclesAction = function(target)
  local movementSpeed = 5
  local minDistance = 2
  QueueBrainEvent(GetOswaldAI(), BRAIN_BlindMove, vector4(0, 0, 0, 0), target, vector4(movementSpeed, minDistance, 0, 0))
  OswaldStartFollowAction()
  return 
end
OswaldIgnoreObstaclesAction2D = function(target)
  local movementSpeed = 5
  local minDistance = 0.20000000298023224
  QueueBrainEvent(GetOswaldAI(), BRAIN_BlindMove, vector4(0, 0, 0, 0), target, vector4(movementSpeed, minDistance, 0, 0))
  OswaldStartFollowAction()
  return 
end
OswaldIgnoreObstaclesNoFollowAction = function(target)
  local movementSpeed = 5
  local minDistance = 2
  QueueBrainEvent(GetOswaldAI(), BRAIN_BlindMove, vector4(0, 0, 0, 0), target, vector4(movementSpeed, minDistance, 0, 0))
  return 
end
OswaldHackAction = function(target)
  local hackTime = 4
  if GetPropertyBool(target, "Is Painted") then
    QueueBrainEvent(GetOswaldAI(), BRAIN_Hack, vector4(hackTime, 0, 0, 0), target)
  end
  return 
end
OswaldToMickeyDistance = function()
  return GetDistanceBetweenEntities(GetOswaldAI(), GetPlayer())
end
OswaldToMickeyXZDistance = function()
  return GetXZDistanceBetweenEntities(GetOswaldAI(), GetPlayer())
end
OswaldAbortScriptedBehavior = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_AbortScriptedBehavior)
  StopAbility(GetPlayer2OrAI(), "Hack")
  return 
end
OswaldCallForHelp = function()
  local callForHelpTime = 5
  QueueBrainEvent(GetOswaldAI(), BRAIN_OswaldCallForHelp, vector4(callForHelpTime, 0, 0, 0))
  return 
end
OswaldOverrideFollowingDistance = function(target, followDistance)
  followDistance = tonumber(followDistance)
  QueueBrainEvent(GetOswaldAI(), BRAIN_SetFollowDistanceOverride, vector4(followDistance, 0, 0, 0))
  return 
end
OswaldClearOverrideFollowingDistance = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_ClearFollowDistanceOverride, vector4(1, 0, 0, 0))
  return 
end
OswaldOverrideTeleportDistance = function(target, teleportDistance)
  teleportDistance = tonumber(teleportDistance)
  QueueBrainEvent(GetOswaldAI(), BRAIN_SetFollowDistanceOverride, vector4(0, teleportDistance, 0, 0))
  return 
end
OswaldOverrideFollowAndTeleportDistance = function(target, followDistance, teleportDistance)
  teleportDistance = tonumber(teleportDistance)
  followDistance = tonumber(followDistance)
  QueueBrainEvent(GetOswaldAI(), BRAIN_SetFollowDistanceOverride, vector4(followDistance, teleportDistance, 0, 0))
  return 
end
OswaldClearOverrideTeleportDistance = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_ClearFollowDistanceOverride, vector4(0, 1, 0, 0))
  return 
end
OswaldClearOverrideDistances = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_ClearFollowDistanceOverride, vector4(1, 1, 0, 0))
  return 
end
OswaldGlideMidAir = function(target)
  QueueBrainEvent(GetOswaldAI(), BRAIN_StopFollowEntity)
  QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_NoSupport, GetPosition(target))
  QueueBrainEvent(GetOswaldAI(), BRAIN_StartFollowEntity)
  return 
end
OswaldGlideMidAirNoFollow = function(target)
  QueueBrainEvent(GetOswaldAI(), BRAIN_StopFollowEntity)
  QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_NoSupport, GetPosition(target))
  return 
end
OswaldToggleFighting = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_ToggleFighting)
  return 
end
OswaldStopFighting = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_StopFighting)
  return 
end
OswaldStartFighting = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_StartFighting)
  return 
end
