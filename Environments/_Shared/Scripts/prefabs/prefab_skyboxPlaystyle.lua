prefab_skybox_intialize = function(skybox)
  local data = GetPrefabData(skybox)
  SetPlayStyleVariable(data.LevelHealth)
  return 
end
prefab_healthManager_intialize = function(manager)
  local data = GetPrefabData(manager)
  local jigsawTime = 0
  local OneShotTime = 0
  if (data.SB_Jigsaw ~= "default") then
    jigsawTime = (((#data.SB_Jigsaw) - 1) * 0.10000000149011612)
  end
  if (data.SB_OneShots ~= "default") then
    OneShotTime = (data.SB_OneShots[2] * 0.10000000149011612)
  end
  local loopTime = (jigsawTime + OneShotTime)
  if (10 < loopTime) then
    SetPropertyFloat(manager, "TimerInterval", (loopTime + 2))
  end
  if (GetGlobal(data.ZoneGlobal) == 0) then
    local init_global = prefab_healthManager_getHealth(manager, "setup")
    if (0 < init_global) then
      Print(((("*_*_*_*_*_*_* prefab_healthManager_intialize - WARNING: data.ZoneGlobal is 0! Did you set " .. data.ZoneGlobal) .. " to a correct initial Value? It should be ") .. tostring(init_global)))
    end
  end
  return 
end
prefab_healthManager_getHealth = function(manager, setup)
  local data = GetPrefabData(manager)
  local JigsawWeightPercentage = 0
  local n = ((#data.SB_Jigsaw) - 1)
  local OneShotPercentage = 0.5
  local OneShotsPainted = 0
  local OneShotsTotal = 0
  local before, JigsawPercentage = 0, 0
  local zoneStreamedOut = false
  if (data.SB_Jigsaw ~= "default") then
    if (n ~= 0) then
      for i = 1, n do
        if IsValidHandle((data.SB_Jigsaw[1] .. i)) then
          JigsawPercentage = --[[ return 2 of ]] Jigsaw_GetPercentagePainted((data.SB_Jigsaw[1] .. i))
          before = Jigsaw_GetPercentagePainted((data.SB_Jigsaw[1] .. i))
          JigsawWeightPercentage = (JigsawWeightPercentage + (JigsawPercentage * data.SB_Jigsaw[(i + 1)]))
          Wait(0.10000000149011612)
        else
          zoneStreamedOut = true
          Print(((("*_*_*_*_*_*_* prefab_healthManager_getHealth: WARNING! Jigsaw Entity Group Name: " .. data.SB_Jigsaw[1]) .. i) .. " no longer Exists. Assuming it Streamed out. Aborting prefab_healthManager_getHealth"))
        end
      end
    end
  end
  if (zoneStreamedOut == true) then
    return 
  end
  if (data.SB_OneShots == "default") then
    OneShotPercentage = 0
  elseif (data.SB_OneShots[2] ~= 0) then
    for i = 1, data.SB_OneShots[2] do
      if IsValidHandle((data.SB_OneShots[1] .. i)) then
        i = 0
        if GetPropertyBool((data.SB_OneShots[1] .. i), "Is Painted", i) then
          OneShotsPainted = (OneShotsPainted + 1)
        end
        Wait(0.10000000149011612)
      else
        zoneStreamedOut = true
        i = i
        Print(((("*_*_*_*_*_*_* prefab_healthManager_getHealth: WARNING! One Shot Entity Group Name: " .. data.SB_OneShots[1]) .. i) .. " no longer Exists. Assuming it Streamed out. Aborting prefab_healthManager_getHealth"))
      end
    end
  end
  if (data.GuardianPoolToUpdate ~= "None") then
    local poolData = GetPrefabData(data.GuardianPoolToUpdate)
    if (poolData.GP_PaintedObjects[2] ~= OneShotsPainted) then
      poolData.GP_PaintedObjects[reg_25] = OneShotsPainted
      SetGlobal(poolData.GP_PaintedObjects[1], OneShotsPainted)
    end
    FireThread(Prefab_ChangeGuardianPoolState, data.GuardianPoolToUpdate)
  end
  if (zoneStreamedOut == true) then
    return 
  end
  if (data.SB_OneShots ~= "default") then
    OneShotsTotal = ((OneShotsPainted / data.SB_OneShots[2]) * 100)
  end
  if (data.SB_OneShots[3] ~= nil) then
    if (data.SB_OneShots[3] ~= 0) then
      OneShotPercentage = data.SB_OneShots[3]
    end
  end
  JigsawWeightPercentage = (JigsawWeightPercentage * (1 - OneShotPercentage))
  local paintedpercentage = ((OneShotsTotal * OneShotPercentage) + JigsawWeightPercentage)
  local zoneFinal = (paintedpercentage * (data.ToonWeight / 100))
  Print(("*_*_*_*_*_*_* prefab_healthManager_getHealth - Current Area Health = " .. zoneFinal))
  SetGlobal(data.ZoneGlobal, zoneFinal)
  if (setup ~= nil) then
    return zoneFinal
  end
  local dataSkybox = GetPrefabData(data.skybox)
  local n = (#dataSkybox.ToonGlobals)
  local totHealth = GetGlobal(dataSkybox.QuestGlobal)
  if (n ~= 0) then
    for i = 1, n do
      paintedpercentage = dataSkybox.ToonGlobals
      paintedpercentage = paintedpercentage[i]
      zoneFinal = GetGlobal
      dataSkybox = paintedpercentage
      zoneFinal = zoneFinal(dataSkybox)
      totHealth = (totHealth + zoneFinal)
      zoneFinal = Wait
      dataSkybox = 0.10000000149011612
      zoneFinal(dataSkybox)
    end
  end
  Print(("*_*_*_*_*_*_* prefab_healthManager_getHealth - Current World Health = " .. totHealth))
  if (100 < totHealth) then
    Print("*_*_*_*_*_*_* prefab_healthManager_getHealth - WARNING: Total Zone Health is Greater than 100, Did you set up your ToonWeight Correctly?")
  end
  SetGlobal(dataSkybox.LevelHealth, totHealth)
  return 
end
prefab_skybox_updateTotal = function(reg_0)
end

