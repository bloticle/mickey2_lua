Prefab_BreakCage = function(target, DynamicCage)
  if (DynamicCage == nil) then
    Print("_*_*_*_*_*_*_*_*_*_*_*_* Prefab_BreakCage finds DynamicCage == nil; cleanup cage and FX")
    local data = GetPrefabData(target)
    local Gremlin = GetRelativePrefabEntity(target, ".caged_gremlin")
    OswaldStreamAbort()
    OswaldStopMovingAction()
    Prefab_OswaldCageShockState = "Off"
    ForEachEntityInPrefab(DestroyEntity, GetRelativePrefabEntity(target, ".CageOswaldHint"))
    ForEachEntityInPrefab(DestroyEntity, GetRelativePrefabEntity(target, ".CageOswaldSwitch"))
    DestroyEntity(GetRelativePrefabEntity(target, ".knockback_trigger"))
    SetMapMarkerVisible(GetRelativePrefabEntity(target, ".MapMarker"), false)
    AudioPostEventOn(GetRelativePrefabEntity(target, ".forcefield"), "Stop_sfx_gremlin_cage_forcefieldLP")
    DestroyEntity(GetRelativePrefabEntity(target, ".forcefield"))
    Print("_*_*_*_*_*_*_*_*_*_*_*_* Prefab_BreakCage finished destroying cage and FX")
    local DynamicBreakableCage = GetRelativePrefabEntity(target, ".DynamicBreakableCage")
    FireThread(Prefab_BreakCage, DynamicBreakableCage, "DynamicCage")
    data.CageDestroyed = "True"
    RestoreShadowScale(Gremlin)
    SetNPCState(Gremlin, 0)
    SetPropertyInt(Gremlin, "Collision Layer", 4)
    AIBB_SetReevaluateRequired(Gremlin, true)
    wait(0.10000000149011612)
    AnimVarInt(Gremlin, VAR_Mood_Type, MOOD_Positive)
    SetGlobal("DBC_ZoneS_TotalGremlinsFreed", (GetGlobal("DBC_ZoneS_TotalGremlinsFreed") + 1))
    SetGlobal("MSN_Markus_RescueGremlinsTracker", (GetGlobal("MSN_Markus_RescueGremlinsTracker") + 1))
    OswaldStartMovingAction()
    Print("__Prefab_BreakCage")
    if (GetGlobal(data.GlobalToCheck) == 0) then
      Print("_*_*_*_*_*_*_*_*_*_*_*_* Prefab_BreakCage finds GlobalToCheck == 0")
      Print("__Prefab_BreakCage, Firing Dialogue")
      if (data.WaitForAnyOtherDialog == "True") then
        Print("__Waiting for other dialog to finish!")
        RestrictCutSceneInput()
        while true do
          if (not (IsAnySequencePlaying() == true)) then
            break
          end
          wait(0.10000000149011612)
        end
      end
      ForceSequence(Gremlin, data.OnCageBrokenDialogue)
      if (data.WaitForAnyOtherDialog == "True") then
        UnrestrictCutSceneInput()
      end
      if (data.GremlinQuestItem ~= "nil") then
        Print(nil, "You got quest!")
        GiveCollectible(data.GremlinQuestItem)
        GiveCollectible("Challenge_WhoLeftThese_Tracker")
        if (data.GremlinQuestItem == "Gremlin_EP1_Rescued") then
          if (GetCurrentCount("Gremlin_EP1_Rescued") == 3) then
            Quest_SetStatus("Operation_Gremlin", "Operation_Gremlin_1", Quest_TurnIn, true)
          end
        elseif (data.GremlinQuestItem == "Gremlin_EP2_Rescued") then
          if (GetCurrentCount("Gremlin_EP2_Rescued") == 5) then
            Quest_SetStatus("Operation_Gremlin", "Operation_Gremlin_2", Quest_TurnIn, true)
          end
        elseif (data.GremlinQuestItem == "Gremlin_EP3_Rescued") then
          if (GetCurrentCount("Gremlin_EP3_Rescued") == 3) then
            Quest_SetStatus("Operation_Gremlin", "Operation_Gremlin_3", Quest_TurnIn, true)
          end
        end
      end
      Print("__Played sequence")
    end
    wait(0.5)
    EnableMotion(Gremlin)
    SetPropertyFloat(Gremlin, "UsableRadius", 2)
    SetVulnerability(Gremlin, ST_PAINT, 1)
    SetVulnerability(Gremlin, ST_THINNER, 1)
    SetVulnerability(Gremlin, ST_SPIN, 1)
    SetVulnerability(Gremlin, ST_KNOCKBACK, 1)
    SetPropertyBool(Gremlin, "ForceInvulnerable", false)
    SetPropertyFloat(Gremlin, "NegativeThreshold", 2.5)
    SetPropertyFloat(Gremlin, "PositiveThreshold", 2.5)
  elseif (DynamicCage == "DynamicCage") then
    Unhide(target)
    FireThread(dynamicKnockback, target)
    wait(2)
    FireThread(Prefab_GremlinDynamicCage_Breakage, target)
    wait(1)
    DestroyEntity(target)
  end
  return 
end
Prefab_LoadCheckpoint_GremlinCage = function(target)
  local data = GetPrefabData(target)
  local gremlin = GetRelativePrefabEntity(target, ".caged_gremlin")
  if (data.GlobalToCheck ~= "None") then
    if (GetGlobal(data.GlobalToCheck) == 0) then
      SetShadowScale(gremlin, vector4(0, 0, 0))
      SetPropertyFloat(gremlin, "UsableRadius", 0)
      SetPropertyInt(gremlin, "Collision Layer", 7)
      SetPropertyFloat(gremlin, "NegativeThreshold", 4)
      SetPropertyFloat(gremlin, "PositiveThreshold", 4)
    elseif (GetGlobal(data.GlobalToCheck) == 1) then
      Print("********************** Prefab_LoadCheckpoint_GremlinCage: GlobalToCheck == 1")
      SetPropertyFloat(gremlin, "NegativeThreshold", 4)
      SetPropertyFloat(gremlin, "PositiveThreshold", 4)
      SetMapMarkerVisible(GetRelativePrefabEntity(target, ".MapMarker"), false)
      if (data.KeepGremlinOnReload == false) then
        Print("********************** Prefab_LoadCheckpoint_GremlinCage: DestroyEntity Gremlin")
        DestroyEntity(gremlin)
        ForEachEntityInPrefab(DestroyEntity, GetRelativePrefabEntity(target, ".CageOswaldHint"))
        ForEachEntityInPrefab(DestroyEntity, GetRelativePrefabEntity(target, ".CageOswaldSwitch"))
        DestroyEntity(GetRelativePrefabEntity(target, ".knockback_trigger"))
        SetMapMarkerVisible(GetRelativePrefabEntity(target, ".MapMarker"), false)
        AudioPostEventOn(GetRelativePrefabEntity(target, ".forcefield"), "Stop_sfx_gremlin_cage_forcefieldLP")
        DestroyEntity(GetRelativePrefabEntity(target, ".forcefield"))
        DestroyEntity(GetRelativePrefabEntity(target, ".breakable_cage"))
        Print("_*_*_*_*_*_*_*_*_*_*_*_* Prefab_LoadCheckpoint_GremlinCage finished destroying cage and FX")
      end
    end
  end
  return 
end
Prefab_GremlinDialogue = function(target)
  local data = GetPrefabData(target)
  if ((not data.InCageDialogue) == "None") then
    if (data.DialogueBusy == "False") then
      data.DialogueBusy = "True"
      if (data.CageDestroyed == "True") then
        if (data.AllowFreedDialogue == "True") then
          ForceSequence(target, data.FreedDialogue)
        elseif (data.AllowFreedDialogue == "False") then
          ForceSequence(target, data.OnCageBrokenDialogue)
        end
      end
      wait(4)
      data.DialogueBusy = "False"
    end
  end
  return 
end
Prefab_Gremlin_AllowFreedDialogue = function(target)
  GetPrefabData(target).AllowFreedDialogue = "True"
  return 
end
Prefab_GremlinDynamicCage_Breakage = function(target)
  local a = 1
  local (for index), (for limit), (for step) = 1, 0, -0.05000000074505806
  for a = (for index), (for limit), (for step) do
    SetR3MTConstRegAlpha(target, 3, a)
    Wait(0.05000000074505806)
  end
  return 
end
dynamicKnockback = function(target)
  EnableMotion(target)
  local player = GetPlayer()
  local land_spot = (GetPosition(target) - GetPosition(player))
  land_spot:normalize3()
  ApplyImpulse(target, (land_spot.x * 10000), 0, (land_spot.z * 10000))
  return 
end
Prefab_ChangeFieldState = function(target, state)
  local forcefield = GetRelativePrefabEntity(target, ".forcefield")
  if (state == "On") then
    Unhide(forcefield)
    StartEmitters(forcefield)
    AudioPostEventOn(forcefield, "Play_sfx_gremlin_cage_forcefieldLP")
    Enable(GetRelativePrefabEntity(target, ".knockback_trigger"))
    SetVulnerability(GetRelativePrefabEntity(target, ".breakable_cage"), ST_BREAKABLE, 0)
  elseif (state == "Off") then
    StopEmitters(forcefield)
    AudioPostEventOn(forcefield, "Stop_sfx_gremlin_cage_forcefieldLP")
    Hide(forcefield)
    Disable(GetRelativePrefabEntity(target, ".knockback_trigger"))
    SetVulnerability(GetRelativePrefabEntity(target, ".breakable_cage"), ST_BREAKABLE, 1)
  end
  return 
end
Prefab_OswaldCageShockState = false
Prefab_BuddyAI_OswaldShock = function(target)
  local endCheck = false
  if (Prefab_OswaldCageShockState == false) then
    endCheck = true
    Prefab_OswaldCageShockState = true
    OswaldStreamAction("Cage_Timer")
    wait(6)
    OswaldStreamAbort()
  end
  if Prefab_OswaldCageShockState then
    if endCheck then
      Prefab_OswaldCageShockState = false
    end
  end
  return 
end
Prefab_Check_Oswald_Spin_BreakCage = function(self, event)
  if DamageEvent_HasStimulusType(event, ST_SPIN) then
    if (DamageEvent_Source(event) == GetPlayer()) then
      Print("Mickey hit me!")
      Kill(self)
    end
  else
    Print("Oswald hit me!")
  end
  return 
end
