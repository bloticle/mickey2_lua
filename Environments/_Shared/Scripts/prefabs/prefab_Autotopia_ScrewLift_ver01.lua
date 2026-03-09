TCY_MoveGeyser = function(target)
  local data = GetPrefabData(target)
  local lift = GetRelativePrefabEntity(target, ".GuardianPool_Geyser 01")
  SplineFollower_SetDisabled(lift, false)
  if (data.GeyserPos == 1) then
    data.GeyserPos = 0
    SplineFollower_StopAtPosition(lift, GetRelativePrefabEntity(target, ".Geyser_SplineKnot 01"), GetRelativePrefabEntity(target, ".Geyser_SplineKnot 02"), 0)
    AudioPostEventOn(GetRelativePrefabEntity(target, ".Sound_GeyserSpout"), "Play_sfx_AUT_GeyserSpout_LP")
    Print("Geyser Audio Start")
  elseif (data.GeyserPos == 0) then
    data.GeyserPos = 1
    SplineFollower_StopAtPosition(lift, GetRelativePrefabEntity(target, ".Geyser_SplineKnot 01"), GetRelativePrefabEntity(target, ".Geyser_SplineKnot 02"), 1)
    AudioPostEventOn(GetRelativePrefabEntity(target, ".Sound_GeyserSpout"), "Stop_sfx_AUT_GeyserSpout_LP")
    Print("Geyser Audio Stop")
  end
  wait(4)
  SplineFollower_SetDisabled(lift, true)
  return 
end
TCY_ShowGeyser = function(target)
  local data = GetPrefabData(target)
  local lift = GetRelativePrefabEntity(target, ".GuardianPool_Geyser 01")
  local (for index), (for limit), (for step) = 0, 1, 0.02500000037252903
  for a = (for index), (for limit), (for step) do
    SetVisualScale(lift, a)
    Wait(0.05000000074505806)
  end
  return 
end
TCY_GeyserPoolChanged = function(target)
  local data = GetPrefabData(target)
  local lift = GetRelativePrefabEntity(target, ".GuardianPool_Geyser 01")
  Disable(lift)
  Wait(0)
  Enable(lift)
  local PoolNif = GetRelativePrefabEntity(data.targetPool, ".GuardianPoolVisible_Visual")
  local CurrentPlaystyle = GetPropertyFloat(PoolNif, "CurrentPlaystyle")
  SetPropertyFloat(lift, "CurrentPlaystyle", CurrentPlaystyle)
  Print((("*_**_*_**_*_**_*_*_**_*_*_*_*_*_**_*_*_**_*_*_*_*_*_**_* CURRENT PLAYSTYLE IS " .. CurrentPlaystyle) .. " "))
  if (0.8999999761581421 < CurrentPlaystyle) then
    SetPropertyInt(lift, "StimulusTypeList", 1, 0)
    SetPropertyInt(lift, "StimulusTypeList", 1, 3)
    SetPropertyInt(lift, "StimulusTypeList", 1, 4)
    SetPropertyFloat(lift, "StimulusPerSecondList", 100, 0)
    SetPropertyFloat(lift, "StimulusPerSecondList", 1, 3)
    SetPropertyFloat(lift, "StimulusPerSecondList", 1, 4)
  elseif (CurrentPlaystyle <= 0.8999999761581421) then
    if (0.10000000149011612 <= CurrentPlaystyle) then
      SetPropertyFloat(lift, "StimulusPerSecondList", 0, 0)
      SetPropertyFloat(lift, "StimulusPerSecondList", 0, 1)
      SetPropertyFloat(lift, "StimulusPerSecondList", 0, 2)
      SetPropertyFloat(lift, "StimulusPerSecondList", 0, 3)
      SetPropertyFloat(lift, "StimulusPerSecondList", 0, 4)
    end
  elseif (CurrentPlaystyle < 0.10000000149011612) then
    SetPropertyFloat(lift, "StimulusPerSecondList", 1, 1)
    SetPropertyFloat(lift, "StimulusPerSecondList", 1, 2)
    SetPropertyInt(lift, "StimulusTypeList", 0, 0)
    SetPropertyInt(lift, "StimulusTypeList", 0, 3)
    SetPropertyInt(lift, "StimulusTypeList", 0, 4)
    SetPropertyFloat(lift, "StimulusPerSecondList", 100, 0)
    SetPropertyFloat(lift, "StimulusPerSecondList", 1, 3)
    SetPropertyFloat(lift, "StimulusPerSecondList", 1, 4)
  end
  return 
end
TCY_GeyserStartup = function(target)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* TCY_GeyserStartup called!")
  local data = GetPrefabData(target)
  local lift = GetRelativePrefabEntity(target, ".GuardianPool_Geyser 01")
  if (data.GeyserActive == 1) then
    TimerEnable(GetRelativePrefabEntity(target, ".GuardianPool_Geyser_LogicTimerMarker 01"))
  elseif (data.GeyserPos == 1) then
    SplineFollower_StopAtPosition(lift, GetRelativePrefabEntity(target, ".Geyser_SplineKnot 01"), GetRelativePrefabEntity(target, ".Geyser_SplineKnot 02"), 1)
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* TCY_GeyserStartup is moving Geyser up to position 1!")
  else
    SplineFollower_StopAtPosition(lift, GetRelativePrefabEntity(target, ".Geyser_SplineKnot 01"), GetRelativePrefabEntity(target, ".Geyser_SplineKnot 02"), 0)
    SetVisualScale(lift, 0.009999999776482582)
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* TCY_GeyserStartup is moving Geyser down to position 0!")
  end
  return 
end
TCY_GeyserLaunch_Extended = function(target)
  local data = GetPrefabData(target)
  local lift = GetRelativePrefabEntity(target, ".GuardianPool_Geyser 01")
  local sknot1 = GetRelativePrefabEntity(target, ".Geyser_SplineKnot 01")
  local sknot2 = GetRelativePrefabEntity(target, ".Geyser_SplineKnot 02")
  data.GeyserPos = 1
  SetSplineFollowerInitialSpeed(lift, 10)
  SplineFollower_StopAtPosition(lift, sknot1, sknot2, 1)
  SplineFollower_TeleportToKnot(lift, sknot2)
  SplineFollower_SetDisabled(lift, true)
  SetVisualScale(lift, 1)
  Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* TCY_GeyserLaunch_Extended called for " .. target) .. "!!"))
  return 
end
