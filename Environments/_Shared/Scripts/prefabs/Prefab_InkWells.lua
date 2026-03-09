Prefab_InkWell_Setup = function(target)
  Print("*_*_*_*_*_*_* Prefab_InkWell_Setup")
  local data = GetPrefabData(target)
  local paintedpercentage = 0
  if (data.IW_PaintedObjects[1] == "Global") then
    Print("*_*_*_*_*_*_* Prefab_InkWell_Setup: You forgot to set the global. The inkwell will not work correctly")
  else
    if (data.IW_PaintedObjects[1] == "Debug") then
      if (data.InkWellState == "Invisible") then
        paintedpercentage = 70
      elseif (data.InkWellState == "Indelible") then
        paintedpercentage = 30
        if (GetGlobal(data.IW_PaintedObjects[1]) == -1) then
          SetGlobal(data.IW_PaintedObjects[1], data.IW_PaintedObjects[2])
        end
        paintedpercentage = Prefab_GetInkWell_PaintedPercentage(data)
      end
    else
      if (GetGlobal(data.IW_PaintedObjects[1]) == -1) then
        SetGlobal(data.IW_PaintedObjects[1], data.IW_PaintedObjects[2])
      end
      paintedpercentage = Prefab_GetInkWell_PaintedPercentage(data)
    end
    if (66 < paintedpercentage) then
      if (66 < paintedpercentage) then
        Print((("*_*_*_*_*_*_* Prefab_InkWell_Setup: " .. data.IW_PaintedObjects[1]) .. ": Changing Inkwell to Invisible state"))
        data.InkWellState = "Invisible"
        SetPropertyFloat(target, "CurrentPlaystyle", 1)
      elseif (paintedpercentage < 33) then
        Print((("*_*_*_*_*_*_* Prefab_InkWell_Setup: " .. data.IW_PaintedObjects[1]) .. ": Changing Inkwell to Indelible state"))
        data.InkWellState = "Indelible"
        SetPropertyFloat(target, "CurrentPlaystyle", 0)
      else
        SetPropertyFloat(target, "CurrentPlaystyle", 0.5)
      end
      Enable(GetRelativePrefabEntity(target, ".InkwellTrigger"))
      SetPropertyFloat(target, "PlaystyleSpeed", 100)
      AnimGBSequence(target, "RestFull")
      Wait(0.10000000149011612)
    end
    Print((("*_*_*_*_*_*_* Prefab_InkWell_Setup: " .. data.IW_PaintedObjects[1]) .. ": Changing Inkwell to Dry state"))
    data.InkWellState = "Dry"
    AnimGBSequence(target, "RestEmpty")
    Disable(GetRelativePrefabEntity(target, ".InkwellTrigger"))
    Wait(0.10000000149011612)
    SetPropertyFloat(target, "PlaystyleSpeed", 0)
  end
  return 
end
Prefab_InkWell_TriggerTouch = function(target, player)
  local data = GetPrefabData(target)
  if (data.Ammo_Amount[1] == "Invisible") then
    Print((("*_*_*_*_*_*_* Prefab_InkWell_TriggerTouch- " .. data.IW_PaintedObjects[1]) .. ": Ammo_Amount not properly set, changing to defaults of 10"))
    data.Ammo_Amount[1] = 10
    data.Ammo_Amount[2] = 10
  end
  if (data.InkWellState == "Invisible") then
    Disable(target)
    Prefab_InkWell_StartTransition(target, "Invisible", player)
  elseif (data.InkWellState == "Indelible") then
    Disable(target)
    Prefab_InkWell_StartTransition(target, "Indelible", player)
  elseif (data.InkWellState == "Dry") then
    Print((("*_*_*_*_*_*_* Prefab_InkWell_TriggerTouch- " .. data.IW_PaintedObjects[1]) .. ": The Inkwell is dry, nothing happens"))
  else
    Print((("*_*_*_*_*_*_* Prefab_InkWell_TriggerTouch- " .. data.IW_PaintedObjects[1]) .. ": Not a valid inkwell state"))
  end
  return 
end
Prefab_InkWell_StartTransition = function(target, inktype, player)
  local data = GetPrefabData(target)
  local damageLeap_trigger = GetRelativePrefabEntity(target, ".InkwellLeapTrigger")
  local damageLeap_fx = GetRelativePrefabEntity(target, ".FXSpawner")
  local inkwell_decoration = GetRelativePrefabEntity(target, ".InkWellDecoration")
  local timeDilationFactor = 1
  local playerHandle = player
  local playerTwo = false
  if (GetTimeDilationFactor() < 0.9990000128746033) then
    timeDilationFactor = 0
  end
  if (playerHandle ~= GetPlayer()) then
    playerTwo = true
  end
  DisableMovementInput(playerHandle)
  IncrementAllAbilitiesDisabled(playerHandle)
  SetEntitiesToNotCollide(playerHandle, inkwell_decoration)
  SetInkWellAmmo(inktype, data.Ammo_Amount[1], playerHandle)
  if (inktype == "Invisible") then
    SetPropertyInt(damageLeap_fx, "Index To Spawn", 0, 0)
    AudioPostEventOn(target, "Play_sfx_invisible_chargeUp")
  else
    SetPropertyInt(damageLeap_fx, "Index To Spawn", 3, 0)
    AudioPostEventOn(target, "Play_sfx_indelible_chargeUp")
  end
  ForceSpawn(damageLeap_fx, 1)
  Wait((0.8500000238418579 * timeDilationFactor))
  if (inktype == "Invisible") then
    SetPropertyInt(damageLeap_fx, "Index To Spawn", 2, 0)
    AudioPostEventOn(target, "Play_sfx_invisible_eject")
  else
    SetPropertyInt(damageLeap_fx, "Index To Spawn", 4, 0)
    AudioPostEventOn(target, "Play_sfx_indelible_eject")
  end
  ForceSpawn(damageLeap_fx, 1)
  Wait((0.15000000596046448 * timeDilationFactor))
  if (playerTwo == true) then
    playerHandle = GetPlayer2OrAI()
  end
  DecrementAllAbilitiesDisabled(playerHandle)
  Entity_StartAbility(_activator(), inktype)
  Enable(damageLeap_trigger)
  local land_spot = (GetPosition(damageLeap_fx) - GetPosition(playerHandle))
  local (for index), (for limit), (for step) = 1, 5, 1
  for i = (for index), (for limit), (for step) do
    Wait((0.10000000149011612 * timeDilationFactor))
    ApplyImpulse(playerHandle, (land_spot.x * 200), 0, (land_spot.z * 200))
  end
  Wait((0.5 * timeDilationFactor))
  Disable(damageLeap_trigger)
  Enable(target)
  ResetEntityFromNoCollide(inkwell_decoration)
  if (playerTwo == true) then
    playerHandle = GetPlayer2OrAI()
  end
  EnableMovementInput(playerHandle)
  return 
end
Prefab_InkWellObject = function(target, state)
  local inkwell = GetPrefabData(target).InkWellTarget
  if (inkwell == "None") then
    Print("*_*_*_*_*_*_* Prefab_InkWellObject: No InkWellTarget specified on Inkwell Object")
  else
    local inkwell_data = GetPrefabData(inkwell)
    if (state == "Thinned") then
      SetGlobal(inkwell_data.IW_PaintedObjects[1], (GetGlobal(inkwell_data.IW_PaintedObjects[1]) - 1))
    elseif (state == "Painted") then
      SetGlobal(inkwell_data.IW_PaintedObjects[1], (GetGlobal(inkwell_data.IW_PaintedObjects[1]) + 1))
    end
    Print(((("*_*_*_*_*_*_* Prefab_InkWellObject: " .. inkwell_data.IW_PaintedObjects[1]) .. " = ") .. GetGlobal(inkwell_data.IW_PaintedObjects[1])))
    Prefab_ChangeInkWellState(inkwell)
  end
  return 
end
Prefab_GetInkWell_PaintedPercentage = function(data)
  local JigsawWeightPercentage = 0
  local n = ((#data.Inkwell_Jigsaw) - 1)
  local OneShotPercentage = 100
  local before, JigsawPercentage = 0, 0
  if (data.Inkwell_Jigsaw[1] == "EntityGroupName") then
    Print("*_*_*_*_*_*_* Prefab_GetInkWell_PaintedPercentage: Jigsaw Entity Group Name not set up. Assuming No Jigsaw")
  elseif (n ~= 0) then
    local (for index), (for limit), (for step) = 1, n, 1
    for i = (for index), (for limit), (for step) do
      JigsawPercentage = --[[ return 2 of ]] Jigsaw_GetPercentagePainted((data.Inkwell_Jigsaw[1] .. i))
      before = Jigsaw_GetPercentagePainted((data.Inkwell_Jigsaw[1] .. i))
      JigsawWeightPercentage = (JigsawWeightPercentage + (JigsawPercentage * data.Inkwell_Jigsaw[(i + 1)]))
      OneShotPercentage = (OneShotPercentage - data.Inkwell_Jigsaw[(i + 1)])
      Print(((("*_*_*_*_*_*_* Prefab_GetInkWell_PaintedPercentage: " .. i) .. ") JigsawWeightPercentage = ") .. JigsawWeightPercentage))
    end
  end
  Print(("*_*_*_*_*_*_* Prefab_ChangeInkWellState - OneShotPercentage = " .. OneShotPercentage))
  if (OneShotPercentage < 0) then
    Print("*_*_*_*_*_*_* Prefab_ChangeInkWellState- Designer Error! Your Jigsaw Weight is more than 100%!!!")
    Bark(nil, "Your Jigsaw Weight is more than 100%!!!")
  end
  local paintedpercentage = (((GetGlobal(data.IW_PaintedObjects[1]) / data.IW_TotalObjects) * OneShotPercentage) + JigsawWeightPercentage)
  paintedpercentage = ": Current Painted percentage = "
  Print(((("*_*_*_*_*_*_* Prefab_ChangeInkWellState- " .. data.IW_PaintedObjects[1]) .. paintedpercentage) .. paintedpercentage))
  return paintedpercentage
end
Prefab_ChangeInkWellState = function(target)
  local data = GetPrefabData(target)
  local old_state = data.InkWellState
  if (data.IW_TotalObjects == 0) then
    Print((("*_*_*_*_*_*_* Prefab_ChangeInkWellState- " .. data.IW_PaintedObjects[1]) .. ": You forgot to set the total value on the inkwell prefab"))
  end
  local paintedpercentage = Prefab_GetInkWell_PaintedPercentage(data)
  if (66 < paintedpercentage) then
    if (data.CurrentlyChanging == "false") then
      data.CurrentlyChanging = "true"
      if (old_state == "Dry") then
        SetPropertyFloat(target, "PlaystyleSpeed", 100)
        if (66 < paintedpercentage) then
          Print((("*_*_*_*_*_*_* Prefab_ChangeInkWellState- " .. data.IW_PaintedObjects[1]) .. ": Changing to Invisible State"))
          data.InkWellState = "Invisible"
          AudioPostEventOn(target, "Play_sfx_inkwell_invisible")
          FireUser1(GetRelativePrefabEntity(target, ".InkWell"))
          SetPropertyFloat(target, "CurrentPlaystyle", 1)
        elseif (paintedpercentage < 33) then
          Print((("*_*_*_*_*_*_* Prefab_ChangeInkWellState- " .. data.IW_PaintedObjects[1]) .. ": Changing to Indelible State"))
          data.InkWellState = "Indelible"
          AudioPostEventOn(target, "Play_sfx_inkwell_indelible")
          FireUser2(GetRelativePrefabEntity(target, ".InkWell"))
          SetPropertyFloat(target, "CurrentPlaystyle", 0)
        else
          SetPropertyFloat(target, "CurrentPlaystyle", 0.5)
        end
        local current_state = data.InkWellState
        Wait(0.10000000149011612)
        SetPropertyFloat(target, "PlaystyleSpeed", 0)
        AnimGBSequence(target, "FillUp", true)
        AudioPostEventOn(target, "Play_sfx_Inkwell_Filling")
        wait(1)
        if (current_state == data.InkWellState) then
          Enable(GetRelativePrefabEntity(target, ".InkwellTrigger"))
        end
      else
        if (66 >= paintedpercentage) then
        end
        data.InkWellState = "Dry"
        Disable(GetRelativePrefabEntity(target, ".InkwellTrigger"))
        FireUser3(GetRelativePrefabEntity(target, ".InkWell"))
        AudioPostEventOn(target, "Play_sfx_inkwell_neutral")
        AnimGBSequence(target, "EmptyOut", true)
        data.CurrentlyChanging = "false"
        if (data.CurrentlyChanging == "false") then
          data.CurrentlyChanging = "true"
          Print((("*_*_*_*_*_*_* Prefab_ChangeInkWellState- " .. data.IW_PaintedObjects[1]) .. ": Changing to Dry State"))
          data.InkWellState = "Dry"
          if (old_state ~= "Dry") then
            Disable(GetRelativePrefabEntity(target, ".InkwellTrigger"))
            FireUser3(GetRelativePrefabEntity(target, ".InkWell"))
            AudioPostEventOn(target, "Play_sfx_inkwell_neutral")
            AnimGBSequence(target, "EmptyOut", true)
          else
            data.CurrentlyChanging = "false"
          end
        end
      end
    end
  end
  if (data.CurrentlyChanging == "false") then
    data.CurrentlyChanging = "true"
    Print((("*_*_*_*_*_*_* Prefab_ChangeInkWellState- " .. data.IW_PaintedObjects[1]) .. ": Changing to Dry State"))
    data.InkWellState = "Dry"
    if (old_state ~= "Dry") then
      Disable(GetRelativePrefabEntity(target, ".InkwellTrigger"))
      FireUser3(GetRelativePrefabEntity(target, ".InkWell"))
      AudioPostEventOn(target, "Play_sfx_inkwell_neutral")
      AnimGBSequence(target, "EmptyOut", true)
    else
      data.CurrentlyChanging = "false"
    end
  end
  return 
end
Prefab_EndInkAnimLogicCheck = function(target)
  local data = GetPrefabData(target)
  local old_state = data.InkWellState
  if (data.IW_TotalObjects == 0) then
    Print((("*_*_*_*_*_*_* Prefab_ChangeInkWellState- " .. data.IW_PaintedObjects[1]) .. ": You forgot to set the total value on the inkwell prefab"))
  end
  local paintedpercentage = Prefab_GetInkWell_PaintedPercentage(data)
  if (66 >= paintedpercentage) then
  end
  data.CurrentlyChanging = "false"
  AnimGBSequence(target, "RestFull")
  data.CurrentlyChanging = "false"
  Prefab_ChangeInkWellState(target)
  return 
end
Prefab_GuardianInkwellPlaystyleTest = function(target, event)
  local data = GetPrefabData(target)
  local oldPlaystyle = PlaystyleEvent_OldPlaystyle(event)
  local newPlaystyle = PlaystyleEvent_NewPlaystyle(event)
  if (newPlaystyle == Mickey_PaintPlaystyle) then
    SetPropertyFloat(target, "PlaystyleSpeed", 0)
    AnimGBSequence(target, "EmptyOut")
    Wait(3)
    SetPropertyFloat(target, "PlaystyleSpeed", 1)
    Wait(3)
    AnimGBSequence(target, "FillUp", true)
    Wait(3)
    AnimGBSequence(target, "RestFull")
  end
  return 
end
Prefab_GuardianInkwellPlaystyleSetup = function(target)
  local currentPlaystyle = Playstyle_GetCurrentPlaystyle
  if (currentPlaystyle == Mickey_PaintPlaystyle) then
    AnimGBSequence(target, "RestFull")
  end
  return 
end
