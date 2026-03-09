Prefab_GuardianPool_Setup = function(target)
  local data = GetPrefabData(target)
  Print(("*_*_*_*_*_*_* Prefab_GuardianPool_Setup: " .. data.GP_PaintedObjects[1]))
  local OneShotEmpty = false
  local JigsawEmpty = false
  local QuestEmpty = false
  local EmptyWeights = 0
  if (data.GP_PaintedObjects[1] == "Global") then
    Print("*_*_*_*_*_*_* Prefab_GuardianPool_Setup: You forgot to name the GP Global. Guardian Pool may not function correctly. SETTING OneShot Weight to 0")
    data.GP_Weights[1] = 0
    OneShotEmpty = true
    EmptyWeights = (EmptyWeights + 1)
  elseif (GetGlobal(data.GP_PaintedObjects[1]) == -1) then
    SetGlobal(data.GP_PaintedObjects[1], data.GP_PaintedObjects[2])
  end
  if (data.GP_Jigsaw[1] == "EntityGroupName") then
    Print("*_*_*_*_*_*_* Prefab_GuardianPool_Setup: Jigsaw Entity Group Name not set up. Assuming No Jigsaw")
    data.GP_Weights[2] = 0
    JigsawEmpty = true
    EmptyWeights = (EmptyWeights + 1)
  end
  if (data.GP_QuestGlobal[1] == "None") then
    Print("*_*_*_*_*_*_* Prefab_GuardianPool_Setup: Quest Global not Setup. Assuming No Quest Global or Non Toon Objects")
    data.GP_Weights[3] = 0
    QuestEmpty = true
    EmptyWeights = (EmptyWeights + 1)
  end
  local total_weight = ((data.GP_Weights[1] + data.GP_Weights[2]) + data.GP_Weights[3])
  Print(((((("*_*_*_*_*_*_* Prefab_GuardianPool_Setup: data.GP_Weights[1] = " .. data.GP_Weights[1]) .. " & data.GP_Weights[2] = ") .. data.GP_Weights[2]) .. " & data.GP_Weights[3] = ") .. data.GP_Weights[3]))
  Print(("*_*_*_*_*_*_* Prefab_GuardianPool_Setup: total_weight = " .. total_weight))
  if QuestEmpty then
    if JigsawEmpty then
      if OneShotEmpty then
        Print("*_*_*_*_*_*_* Prefab_GuardianPool_Setup: All Required Fields are actually empty so your Weight will be 33 for Each, please fill them out!")
      end
    end
  end
  if (total_weight ~= 100) then
    if (0 < EmptyWeights) then
      Print("*_*_*_*_*_*_* Prefab_GuardianPool_Setup: total_weight ~= 100: So Dividing up the Missing Weight!")
      local MissingWeight = ((100 - total_weight) / (3 - EmptyWeights))
      if (not OneShotEmpty) then
        data.GP_Weights[1] = (data.GP_Weights[1] + MissingWeight)
      end
      if (not JigsawEmpty) then
        data.GP_Weights[2] = (data.GP_Weights[2] + MissingWeight)
      end
      if (not QuestEmpty) then
        data.GP_Weights[3] = (data.GP_Weights[3] + MissingWeight)
      end
      Print(((((("*_*_*_*_*_*_* Prefab_GuardianPool_Setup: NEW WEIGHTS: data.GP_Weights[1] = " .. data.GP_Weights[1]) .. " & data.GP_Weights[2] = ") .. data.GP_Weights[2]) .. " & data.GP_Weights[3] = ") .. data.GP_Weights[3]))
    end
  end
  Print(("*_*_*_*_*_*_* Prefab_GuardianPool_Setup: Checking Jump Volumes for " .. data.GuardianNames))
  data.GP_JumpVolume[3] = "Valid"
  data.GP_JumpVolume[4] = "Valid"
  local (for index), (for index), (for limit), (for step) = 1, 2, 1, " & data.GP_Weights[2] = "
  for (for step) = (for index), (for index), (for limit) do
    i = IsValidHandle
    i = i(data.GP_JumpVolume[(for step)])
    if i then
      i = Print
      i(((("*_*_*_*_*_*_* Prefab_GuardianPool_Setup: " .. data.GP_JumpVolume[(for step)]) .. " exisits for ") .. data.GuardianNames))
    else
      i = Print
      i((((("*_*_*_*_*_*_* Prefab_GuardianPool_Setup: " .. data.GP_JumpVolume[(for step)]) .. " does not exisit for ") .. data.GuardianNames) .. ". Will Skip setting when state changes"))
      i = data.GP_JumpVolume
      i[(for step)] = "Skip"
    end
  end
  data.GP_State = "Startup"
  Prefab_ChangeGuardianPoolState(target)
  return 
end
Prefab_GP_ChangeActivatorSpeed = function(target, state)
  local activator = _activator()
  local activator_CL = GetPropertyInt(activator, "Collision Layer")
  if (activator ~= GetPlayer()) then
    if (activator ~= GetPlayer2OrAI()) then
      local isPlayer = false
    end
  end
  local isPlayer = true
  if (GetPrefabData(target).GP_State == "Neutral") then
    if (state == "slow") then
      if (activator_CL ~= 2) then
        if (activator_CL ~= 1) then
          if isPlayer then
            SetRunSpeed(activator, 2)
          else
            SetPropertyFloat(activator, "Max Move Speed", 2)
            if (activator_CL == 2) then
              SetPropertyFloat(activator, "Mass", (GetPropertyFloat(activator, "Mass") * 3))
              local Indelible = false
              if isPlayer then
                Indelible = GetPropertyBool(activator, "Indelible")
              end
              if (activator_CL ~= 2) then
                if (activator_CL ~= 1) then
                  if (not Indelible) then
                    if isPlayer then
                      RestoreRunSpeed(activator)
                    else
                      SetPropertyFloat(activator, "Max Move Speed", 5)
                      if (activator_CL == 2) then
                        SetPropertyFloat(activator, "Mass", (GetPropertyFloat(activator, "Mass") / 3))
                      end
                    end
                  end
                end
              elseif (activator_CL == 2) then
                SetPropertyFloat(activator, "Mass", (GetPropertyFloat(activator, "Mass") / 3))
              end
            end
          end
        end
      elseif (activator_CL == 2) then
        SetPropertyFloat(activator, "Mass", (GetPropertyFloat(activator, "Mass") * 3))
        local Indelible = false
        if isPlayer then
          Indelible = GetPropertyBool(activator, "Indelible")
        end
        if (activator_CL ~= 2) then
          if (activator_CL ~= 1) then
            if (not Indelible) then
              if isPlayer then
                RestoreRunSpeed(activator)
              else
                SetPropertyFloat(activator, "Max Move Speed", 5)
                if (activator_CL == 2) then
                  SetPropertyFloat(activator, "Mass", (GetPropertyFloat(activator, "Mass") / 3))
                end
              end
            end
          end
        elseif (activator_CL == 2) then
          SetPropertyFloat(activator, "Mass", (GetPropertyFloat(activator, "Mass") / 3))
        end
      end
    end
  else
    local Indelible = false
    if isPlayer then
      Indelible = GetPropertyBool(activator, "Indelible")
    end
    if (activator_CL ~= 2) then
      if (activator_CL ~= 1) then
        if (not Indelible) then
          if isPlayer then
            RestoreRunSpeed(activator)
          else
            SetPropertyFloat(activator, "Max Move Speed", 5)
            if (activator_CL == 2) then
              SetPropertyFloat(activator, "Mass", (GetPropertyFloat(activator, "Mass") / 3))
            end
          end
        end
      end
    elseif (activator_CL == 2) then
      SetPropertyFloat(activator, "Mass", (GetPropertyFloat(activator, "Mass") / 3))
    end
  end
  return 
end
CurrStatusP1 = "off"
CurrStatusP2 = "off"
Prefab_GP_PaintRestore = function(target, status)
  local activator = _activator()
  if (activator == GetPlayer()) then
    CurrStatusP1 = status
  elseif (activator == GetPlayer2OrAI()) then
    CurrStatusP2 = status
  end
  if (GetPrefabData(target).GP_State == "Paint") then
    if (status == "on") then
      if (activator == GetPlayer()) then
        while true do
          if (CurrStatusP1 == "on") then
            local currentHealthP1 = GetHealth(GetPlayer())
            if (currentHealthP1 ~= 0) then
              SetHealth(GetPlayer(), (currentHealthP1 + 1))
              if (currentHealthP1 < GetPropertyInt(GetPlayer(), "MaxHealth", 0)) then
                AudioPostEventOn(GetPlayer(), "Play_sfx_Heart_Pickup")
              end
            end
            wait(0.5)
          end
        end
      elseif (activator == GetPlayer2OrAI()) then
        while true do
          if (not (CurrStatusP2 == "on")) then
            break
          end
          local currentHealthP2, currentHealthP2 = GetHealth(GetPlayer2OrAI()), GetPlayer2OrAI()
          if (currentHealthP2 ~= 0) then
            currentHealthP2 = SetHealth
            currentHealthP2(GetPlayer2OrAI(), (currentHealthP2 + 1))
            currentHealthP2 = GetPropertyInt
            currentHealthP2 = currentHealthP2(GetPlayer2OrAI(), "MaxHealth", 0)
            if (currentHealthP2 < currentHealthP2) then
              currentHealthP2 = AudioPostEventOn
              currentHealthP2(GetPlayer(), "Play_sfx_Heart_Pickup")
            end
          end
          currentHealthP2 = wait
          currentHealthP2(0.5)
        end
      end
    end
  end
  return 
end
Prefab_GuardianPoolObject = function(target, state)
  local data = GetPrefabData(target)
  if (data.PoolTarget == "None") then
    Print("*_*_*_*_*_*_* Prefab_GuardianPoolObject: You did not set up the pool target name for the Guardian Pool Object Prefab")
  else
    local pooldata = GetPrefabData(data.PoolTarget)
    if (state == "Thinned") then
      SetGlobal(pooldata.GP_PaintedObjects[1], (GetGlobal(pooldata.GP_PaintedObjects[1]) - 1))
    elseif (state == "Painted") then
      SetGlobal(pooldata.GP_PaintedObjects[1], (GetGlobal(pooldata.GP_PaintedObjects[1]) + 1))
    end
    Print(((("*_*_*_*_*_*_* Prefab_GuardianPoolObject: " .. pooldata.GP_PaintedObjects[1]) .. " = ") .. GetGlobal(pooldata.GP_PaintedObjects[1])))
    Prefab_ChangeGuardianPoolState(data.PoolTarget)
  end
  return 
end
Prefab_GuardianPool_NonToonObject = function(guardianpool, state)
  Print(("The state of a Guardian Pool associated object is changing!  Should affect the state of this Guardian Pool: " .. guardianpool))
  local pooldata = GetPrefabData(guardianpool)
  if (state == "Broken") then
    SetGlobal(pooldata.GP_PaintedObjects[1], (GetGlobal(pooldata.GP_PaintedObjects[1]) - 1))
  elseif (state == "Fixed") then
    SetGlobal(pooldata.GP_PaintedObjects[1], (GetGlobal(pooldata.GP_PaintedObjects[1]) + 1))
  end
  Print(((("*_*_*_*_*_*_* Prefab_GuardianPoolObject: " .. pooldata.GP_PaintedObjects[1]) .. " = ") .. GetGlobal(pooldata.GP_PaintedObjects[1])))
  Prefab_ChangeGuardianPoolState(guardianpool)
  return 
end
Prefab_GetGuardianPool_PaintedPercentage = function(data)
  local n = ((#data.GP_Jigsaw) - 1)
  local OneShotPercentage = tonumber(data.GP_Weights[1])
  local JigsawWeightPercentage = (tonumber(data.GP_Weights[2]) / 100)
  local QuestWeightPercentage = tonumber(data.GP_Weights[3])
  local OneShotValue = 0
  local QuestValue = 0
  local JigsawValue = 0
  local before, JigsawPercentage = 0, 0
  if (data.GP_Jigsaw[1] ~= "EntityGroupName") then
    if (n ~= 0) then
      local (for index), (for limit), (for step) = 1, n, 1
      for i = (for index), (for limit), (for step) do
        JigsawPercentage = --[[ return 2 of ]] Jigsaw_GetPercentagePainted((data.GP_Jigsaw[1] .. i))
        before = Jigsaw_GetPercentagePainted((data.GP_Jigsaw[1] .. i))
        JigsawValue = (JigsawValue + (JigsawPercentage * data.GP_Jigsaw[(i + 1)]))
      end
    end
  end
  Print(((("*_*_*_*_*_*_* Prefab_GetGuardianPool_PaintedPercentage for " .. data.GuardianNames) .. ": JigsawValue = ") .. JigsawValue))
  if (data.GP_QuestGlobal[1] ~= "None") then
    QuestValue = (GetGlobal(data.GP_QuestGlobal[1]) / tonumber(data.GP_QuestGlobal[2]))
  end
  Print(((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState for " .. data.GuardianNames) .. ": QuestValue = ") .. QuestValue))
  local paintedpercentage, paintedpercentage = ((((GetGlobal(data.GP_PaintedObjects[1]) / data.GP_TotalObjects) * OneShotPercentage) + (JigsawValue * JigsawWeightPercentage)) + (QuestValue * QuestWeightPercentage)), QuestValue
  paintedpercentage = ": Current Painted percentage = "
  Print(((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState- " .. data.GP_PaintedObjects[1]) .. paintedpercentage) .. paintedpercentage))
  return paintedpercentage
end
Prefab_ChangeGuardianPoolState = function(target)
  local data = GetPrefabData(target)
  local GuardianPoolVisual = GetRelativePrefabEntity(target, ".GuardianPoolVisible_Visual")
  local GuardianPoolStim = GetRelativePrefabEntity(target, ".GuardianPoolVisible_Stim")
  local GuardianPoolStimThinner = GetRelativePrefabEntity(target, ".GuardianPoolVisible_StimThinner")
  local timer = GetRelativePrefabEntity(target, ".Timer_SpawnGuardians")
  local GuardianSpawner = GetRelativePrefabEntity(target, ".GuardianSpawner")
  local paintedpercentage = Prefab_GetGuardianPool_PaintedPercentage(data)
  local switchPaint = data.GP_PaintThreshold
  local switchThin = data.GP_ThinThreshold
  local switchPaintStim = 65.5
  local switchThinStim = 34.5
  local varMickSpeed = GetPlayer()
  local varOswaldSpeed = GetPlayer2OrAI()
  if (data.GP_TotalObjects == 0) then
    Print(("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState:You forgot to set the total value on the guardian pool prefab for " .. data.GuardianNames))
  end
  local state_new = "Paint"
  local state_old = "Thinner"
  Print(((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState for " .. data.GuardianNames) .. ": paintedpercentage =") .. tostring(paintedpercentage)))
  Print(((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState for " .. data.GuardianNames) .. ": switchPaint =") .. tostring(switchPaint)))
  Print(((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState for " .. data.GuardianNames) .. ": switchThin =") .. tostring(switchThin)))
  Print(((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState for " .. data.GuardianNames) .. ": data.GP_State =") .. tostring(data.GP_State)))
  if (switchPaintStim < paintedpercentage) then
    FireUser1(GetRelativePrefabEntity(target, ".InputOutputMarker"))
  elseif (paintedpercentage < switchThinStim) then
    state_new = "Thinner"
    state_old = "Paint"
    FireUser2(GetRelativePrefabEntity(target, ".InputOutputMarker"))
  end
  local isStartup = ""
  local ToggleJumpVolumes = function()
    local jumpVolumeToDisable = data.GP_JumpVolume[1]
    local jumpVolumeToEnable = data.GP_JumpVolume[2]
    if (state_new == "Thinner") then
      jumpVolumeToEnable = data.GP_JumpVolume[1]
      jumpVolumeToDisable = data.GP_JumpVolume[2]
    end
    if (jumpVolumeToEnable ~= "Skip") then
      Print(((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState for " .. data.GuardianNames) .. ": enabling jumpVolumes ") .. jumpVolumeToEnable))
      ForEachEntityInGroup(enableJumpVolumeAvailability, jumpVolumeToEnable)
    else
      Print((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState for " .. data.GuardianNames) .. ": skipping enabling of jumpVolumes See Setup Print Above"))
    end
    if (jumpVolumeToDisable ~= "Skip") then
      Print(((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState for " .. data.GuardianNames) .. ": Disabling jumpVolumes ") .. jumpVolumeToDisable))
      ForEachEntityInGroup(disableJumpVolumeAvailability, jumpVolumeToDisable)
    else
      Print((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState for " .. data.GuardianNames) .. ": skipping enabling of jumpVolumes See Setup Print Above"))
    end
    return 
  end
  if (switchPaintStim < paintedpercentage) then
    if (data.GP_State ~= state_new) then
      Print((((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState for " .. data.GuardianNames) .. ": Changing Guardian Pool to ") .. state_new) .. " state"))
      isStartup = data.GP_State
      data.GP_State = state_new
      if (switchPaintStim < paintedpercentage) then
        Hide(GuardianPoolStimThinner)
        Unhide(GuardianPoolStim)
        Disable(GuardianPoolStimThinner)
        DisableComponent(GuardianPoolStimThinner, "Physics Trigger Damage Component")
        Wait(0.25)
        EnableComponent(GuardianPoolStim, "Physics Trigger Damage Component")
        Enable(GuardianPoolStim)
        SetPropertyFloat(GuardianPoolVisual, "CurrentPlaystyle", 1)
        SetPropertyInt(GuardianPoolStim, "StimulusTypeList", 1, 0)
        SetPropertyInt(GuardianPoolStim, "StimulusTypeList", 1, 5)
        SetPropertyInt(GuardianPoolStim, "StimulusTypeList", 1, 6)
      else
        Hide(GuardianPoolStim)
        Unhide(GuardianPoolStimThinner)
        Disable(GuardianPoolStim)
        DisableComponent(GuardianPoolStim, "Physics Trigger Damage Component")
        Wait(0.25)
        EnableComponent(GuardianPoolStimThinner, "Physics Trigger Damage Component")
        Enable(GuardianPoolStimThinner)
        SetPropertyFloat(GuardianPoolVisual, "CurrentPlaystyle", 0)
      end
      ToggleJumpVolumes()
      SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 100, 0)
      SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 10, 5)
      SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 10, 6)
    end
  end
  if (data.GP_State ~= "Neutral") then
    Print((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState for " .. data.GuardianNames) .. ": Changing Guardian Pool to Neutral state"))
    FireUser3(GetRelativePrefabEntity(target, ".InputOutputMarker"))
    data.GP_State = "Neutral"
    Hide(GuardianPoolStimThinner)
    Disable(GuardianPoolStimThinner)
    Unhide(GuardianPoolStim)
    SetPropertyFloat(GuardianPoolVisual, "CurrentPlaystyle", data.NeutralShade)
    ToggleJumpVolumes()
    Disable(GuardianPoolStim)
    DisableComponent(GuardianPoolStim, "Physics Trigger Damage Component")
    Wait(0.25)
    EnableComponent(GuardianPoolStim, "Physics Trigger Damage Component")
    Enable(GuardianPoolStim)
    SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 0, 0)
    SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 0, 1)
    SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 0, 2)
    SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 0, 3)
    SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 0, 4)
    SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 0, 5)
    SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 0, 6)
  end
  if (switchPaint < paintedpercentage) then
    SetPropertyInt(GuardianSpawner, "Index To Spawn", 0)
  elseif (paintedpercentage < switchThin) then
    SetPropertyInt(GuardianSpawner, "Index To Spawn", 1)
  end
  if (switchPaint < paintedpercentage) then
    if (isStartup == "Startup") then
      wait((math.random(15, 50) / 100))
    end
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 01"), "MainPathTime", 0)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 01"), "BranchPathChance", 0)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 03"), "BranchPathChance", 0.4000000059604645)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 04"), "BranchPathChance", 0.6499999761581421)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 05"), "BranchPathChance", 0.4000000059604645)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 06"), "BranchPathChance", 0.4000000059604645)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 07"), "BranchPathChance", 0.4000000059604645)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 08"), "BranchPathChance", 0.33000001311302185)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 09"), "BranchPathChance", 0)
    TimerReset(timer)
    TimerEnable(timer)
    TimerForceFire(timer)
    Print((("*_*_*_*_*_*_* Prefab_ChangeGuardianPoolState for " .. data.GuardianNames) .. ": Spawning Guardians"))
  end
  if (paintedpercentage >= switchPaint) then
  end
  TimerDisable(timer)
  if (paintedpercentage < switchPaintStim) then
    TimerDisable(timer)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 01"), "MainPathTime", 100)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 01"), "BranchPathChance", 1)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 03"), "BranchPathChance", 0)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 04"), "BranchPathChance", 0)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 05"), "BranchPathChance", 1)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 06"), "BranchPathChance", 1)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 07"), "BranchPathChance", 0)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 08"), "BranchPathChance", 1)
    SetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 09"), "BranchPathChance", 1)
  end
  if (data.Function_OnObjectChange ~= "None") then
    FireThread(_G[data.Function_OnObjectChange], GuardianPoolVisual)
  end
  Print(("CurrentPlaystyle = " .. (paintedpercentage / 100)))
  return 
end
Prefab_Timer_SpawnGuardian = function(target)
  local data = GetPrefabData(target)
  local player = GetPlayer()
  Print("*_*_*_*_*_*_* Prefab_Timer_SpawnGuardian: Timer Fired")
  if (data.PoolGuardians < 3) then
    if (data.PoolGuardians ~= 0) then
      wait((math.random(15, 50) / 100))
    end
    data.PoolGuardians = (data.PoolGuardians + 1)
    ForceSpawn(GetRelativePrefabEntity(target, ".GuardianSpawner"), 1)
    Print("*_*_*_*_*_*_* Prefab_Timer_SpawnGuardian: Spawning Guardian")
  end
  if (GetPrefabData(target).PoolGuardians == 3) then
    TimerDisable(GetRelativePrefabEntity(target, ".Timer_SpawnGuardians"))
  end
  return 
end
Prefab_DestroyGaurdian = function(target, type)
  local player = GetPlayer()
  if (type == "SplineCheck") then
    if (GetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 03"), "BranchPathChance") == 0) then
      Reverse(_activator())
      Print("*_*_*_*_*_*_* Prefab_DestroyGaurdian: REVERSING GUARDIAN")
    end
  elseif (type == "SplineKnot1Check") then
    if (GetPropertyFloat(GetRelativePrefabEntity(target, ".GuardianPoolSK 03"), "BranchPathChance") == 0) then
      DestroyEntity(_activator())
      Print("*_*_*_*_*_*_* Prefab_DestroyGaurdian: DESTROYING GUARDIAN")
      local data = GetPrefabData(target)
      data.PoolGuardians = (data.PoolGuardians - 1)
    end
  else
    if (GetHeroPercent(player) == 1) then
    end
    DestroyEntity(target)
  end
  return 
end
Prefab_GiveGuardian = function(target, type)
  local data = GetPrefabData(target)
  local player = GetPlayer()
  if (GetHeroPercent(player) == 1) then
  end
  if (data.PoolGuardians == 3) then
    local timer = GetRelativePrefabEntity(target, ".Timer_SpawnGuardians")
    TimerReset(timer)
    TimerEnable(timer)
  end
  data.PoolGuardians = (data.PoolGuardians - 1)
  Print((("*_*_*_*_*_*_* Prefab_GiveGuardian: Collecting " .. type) .. " Guardian"))
  if (type == "Thinner") then
    AddThinnerGuardian()
  elseif (type == "Paint") then
    AddPaintGuardian()
  end
  return 
end
Prefab_SpawnGuardians_OnStart = function(target)
  local data = GetPrefabData(target)
  if (data.SpawnOnLoad == "True") then
    Prefab_SpawnGuardians(target)
  end
  return 
end
Prefab_SpawnGuardians = function(target)
  local data = GetPrefabData(target)
  local GuardianSpawner = GetRelativePrefabEntity(target, ".GuardianSpawner")
  if (data.GuardianType == "Paint") then
    SetPropertyInt(GuardianSpawner, "Index To Spawn", 0)
  elseif (data.GuardianType == "Thinner") then
    SetPropertyInt(GuardianSpawner, "Index To Spawn", 1)
  end
  if (1 < data.GuardianCount) then
    local (for index), (for limit), (for step) = 1, data.GuardianCount, 1
    for i = (for index), (for limit), (for step) do
      Print("FOR LOOP SPAWN")
      ForceSpawn(GetRelativePrefabEntity(target, ".GuardianSpawner"), 1)
      Wait(2)
    end
  elseif (data.GuardianCount == 1) then
    Print("SPAWN ONLY 1")
    ForceSpawn(GetRelativePrefabEntity(target, ".GuardianSpawner"), 1)
  end
  return 
end
Prefab_GenericGiveGuardian = function(target, type)
  local data = GetPrefabData(target)
  local player = GetPlayer()
  if (GetHeroPercent(player) == 1) then
  end
  Print((("*_*_*_*_*_*_* Prefab_GiveGuardian: Collecting " .. type) .. " Guardian"))
  if (type == "Thinner") then
    AddThinnerGuardian()
  elseif (type == "Paint") then
    AddPaintGuardian()
  end
  DestroyEntity(target)
  return 
end
