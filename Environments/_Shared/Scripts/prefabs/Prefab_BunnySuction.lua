Prefab_BunnySuctionDummy_AlwaysSetup = function(target)
  Print("__Function: Prefab_BunnySuctionDummy_AlwaysSetup")
  local data = GetPrefabData(target)
  if (data.PersistGlobal == "None") then
    Print("__Your persist global isnt set! Your bunny suction won't persist when it's brought in for-realzies")
  else
    local value = GetGlobal(data.PersistGlobal)
    Print(((("__Global " .. tostring(data.PersistGlobal)) .. " value: ") .. tostring(value)))
    if (value == 0) then
      ForceSketched(target)
      data.States[reg_23] = 0
      data.States[reg_24] = 0
    elseif (value == 1) then
      ForceSketched(target)
      ForcePainted("BunnySuctionDummy_SwitchBase")
      data.States[reg_23] = 0
      data.States[reg_24] = 1
    else
      if (value == 2) then
        data.States[reg_23] = 1
        data.States[reg_24] = 0
      end
      if (value == 3) then
        ForcePainted("BunnySuctionDummy_SwitchBase")
        data.States[reg_23] = 1
        data.States[reg_24] = 1
      end
    end
  end
  return 
end
Prefab_BunnySuctionDummy_StateChange = function(target, _State)
  Print(("__Function: Prefab_BunnySuctionDummy_StateChange, _State: " .. tostring(_State)))
  local data = GetPrefabData("BunnySuctionDummy")
  if (_State == "PhoneBox_Paint") then
    data.States[reg_13] = 1
  elseif (_State == "PhoneBox_Thin") then
    data.States[reg_13] = 0
  elseif (_State == "HackBox_Paint") then
    data.States[reg_17] = 1
  elseif (_State == "HackBox_Thin") then
    data.States[reg_17] = 0
  end
  if (data.States[1] == 0) then
    if (data.States[2] == 0) then
      SetGlobal(data.PersistGlobal, 0)
    end
  elseif (data.States[1] == 0) then
    if (data.States[2] == 1) then
      SetGlobal(data.PersistGlobal, 1)
    end
  elseif (data.States[1] == 1) then
    if (data.States[2] == 0) then
      SetGlobal(data.PersistGlobal, 2)
    end
  elseif (data.States[1] == 1) then
    if (data.States[2] == 1) then
      SetGlobal(data.PersistGlobal, 3)
    end
  end
  Print(((("__New data persist global " .. tostring(data.PersistGlobal)) .. " value: ") .. tostring(GetGlobal(data.PersistGlobal))))
  return 
end
bunny_stagetracker = 0
Prefab_BunnySuction_AlwaysSetup = function(target)
  Print("__Function: Prefab_BunnySuction_AlwaysSetup")
  math.randomseed(os.time())
  local data = GetPrefabData(target)
  local stagenumber = 0
  if (data.Globals[1] == "BunnyChildren_BlotAlley") then
    stagenumber = 4
  elseif (data.Globals[1] == "BunnyChildren_DisneyGulch") then
    stagenumber = 3
  elseif (data.Globals[1] == "BunnyChildren_FloatGraveyard") then
    stagenumber = 6
  elseif (data.Globals[1] == "BunnyChildren_FortWasteland") then
    stagenumber = 7
  elseif (data.Globals[1] == "BunnyChildren_MeanStreetsSouth") then
    stagenumber = 2
  elseif (data.Globals[1] == "BunnyChildren_TrainTunnels") then
    stagenumber = 5
  else
    Print("DESIGNER ERROR. You have setup the incorrect variable for the first global to track in your override!!! Fix immediately!!!")
  end
  bunny_stagetracker = stagenumber
  if (Quest_CheckStatus("The_Bunny_Wranglers", ("The_Bunny_Wranglers_" .. tostring(stagenumber)), Quest_Discovered) ~= true) then
    if (Quest_CheckStatus("The_Bunny_Wranglers", ("The_Bunny_Wranglers_" .. tostring(stagenumber)), Quest_Completed) ~= true) then
      Quest_SetStatus("The_Bunny_Wranglers", ("The_Bunny_Wranglers_" .. tostring(stagenumber)), Quest_Discovered, false)
      Print("__Quest Started!")
    end
  end
  if (data.PersistFromDummyGlobal == "None") then
    Print("__No persistent global set from the dummy set!")
  else
    local value = GetGlobal(data.PersistFromDummyGlobal)
    Print(((("__Global " .. tostring(data.PersistFromDummyGlobal)) .. " value: ") .. tostring(value)))
    if (value == 0) then
      ForceSketched(GetRelativePrefabEntity(target, ".ToonShockCover"))
      data.States[reg_17] = 0
      data.States[reg_27] = 0
    elseif (value == 1) then
      ForceSketched(GetRelativePrefabEntity(target, ".ToonShockCover"))
      ForcePainted(data.HackboxEntityGroupName)
      data.States[reg_17] = 0
      data.States[reg_27] = 1
    elseif (value == 2) then
      data.States[reg_17] = 1
      data.States[reg_27] = 0
    elseif (value == 3) then
      ForcePainted(data.HackboxEntityGroupName)
      data.States[reg_17] = 1
      data.States[reg_27] = 1
    end
  end
  SetMapMarkerVisible(GetRelativePrefabEntity(target, ".MapMarker"), true)
  if (data.UseRespawnTrigger == "True") then
    Enable(GetRelativePrefabEntity(target, ".RespawnTrigger"))
    Enable(GetRelativePrefabEntity(target, ".RespawnTrigger2"))
  end
  local tubeGlobal, tubeGlobal = GetGlobal(data.Globals[2]), data.Globals[2]
  if (tubeGlobal == 0) then
    tubeGlobal = Reprogram_ChangeState
    tubeGlobal("BunnySuctionOswaldReprogramScreen", "activate")
    tubeGlobal = Prefab_OswaldElectricSwitch_ChangeState
    tubeGlobal("BunnySuctionOswaldShockerScreen", "Activate")
  elseif (tubeGlobal == 1) then
    tubeGlobal = Reprogram_ChangeState
    tubeGlobal("BunnySuctionOswaldReprogramScreen", "success")
    tubeGlobal = Prefab_OswaldElectricSwitch_ChangeState
    tubeGlobal("BunnySuctionOswaldShockerScreen", "Deactivate")
    tubeGlobal = Prefab_EnableBunnyVacuum
    tubeGlobal(target, "Hacked")
  elseif (tubeGlobal == -1) then
    tubeGlobal = Prefab_EnableBunnyVacuum
    tubeGlobal(target, "Shocker")
    tubeGlobal = Reprogram_ChangeState
    tubeGlobal("BunnySuctionOswaldReprogramScreen", "off")
    tubeGlobal = Prefab_OswaldElectricSwitch_ChangeState
    tubeGlobal("BunnySuctionOswaldShockerScreen", "FullyCharged")
  end
  tubeGlobal = GetCurrentCount
  tubeGlobal = tubeGlobal(data.Globals[1])
  if (tubeGlobal == 5) then
    data.CaptureFunctionFired = "True"
  end
  tubeGlobal = GetCurrentCount
  tubeGlobal = tubeGlobal(data.Globals[1])
  tubeGlobal = (5 - tubeGlobal)
  local bunnyCountGlobal = data.Globals[1]
  bunnyCountGlobal = 1
  for x = bunnyCountGlobal, tubeGlobal do
    x = Print
    x(("Spawning Bunny Number " .. x))
    x = data.SpawnMarkersToUse
    if (x >= 1) then
      x = data.SpawnMarkersToUse
    else
      x = Print
      x("__SPAWNMARKERSTOUSE overridden to invalid value! Defaulting to 1, ALL BUNNIES WILL SPAWN AT YOUR FIRST LOCATION UNTIL YOU FIX THIS")
      data.SpawnMarkersToUse = 1
    end
    x = SetPropertyEntity
    x(target, "Spawn Destinations", GetRelativePrefabEntity(target, (".BunnySpawnPosition" .. tostring(math.random(1, data.SpawnMarkersToUse)))), 0)
    x = ForceSpawn
    x(target, 1)
    x = wait
    x(0.10000000149011612)
  end
  return 
end
Prefab_EnableBunnyVacuum = function(target, whatactivated)
  Print(((("Prefab_EnableBunnyVacuum: Activate Bunny Tube" .. GetName(target)) .. "  from the  ") .. whatactivated))
  local data = GetPrefabData(target)
  if (whatactivated == "Hacked") then
    SetGlobal(data.Globals[2], 1)
    Prefab_OswaldElectricSwitch_ChangeState("BunnySuctionOswaldShockerScreen", "Deactivate")
    OswaldStartFollowAction()
  elseif (whatactivated == "Shocker") then
    Reprogram_ChangeState("BunnySuctionOswaldReprogramScreen", "off")
    SetGlobal(data.Globals[2], -1)
  end
  SetPropertyBool("BunnySuctionAIOswaldReprogramSpot", "ActionSpotEnabled", false)
  SetPropertyBool("BunnySuctionAIOswaldShockerSpot", "ActionSpotEnabled", false)
  StartEmitters(GetRelativePrefabEntity(target, ".VacuumParticle"))
  Enable(GetRelativePrefabEntity(target, ".SuctionTrigger"))
  Enable(GetRelativePrefabEntity(target, ".SuckedUpTrigger"))
  Enable(GetRelativePrefabEntity(target, ".SuctionTrigger_Player"))
  return 
end
BunnyVacuum = function(target, bunny)
  local suckPos = GetPosition(GetRelativePrefabEntity(target, ".PneumaticTube"))
  while true do
    if (not IsValidHandle(bunny)) then
      break
    end
    local vectorToTarget = (suckPos - GetPosition(bunny))
    vectorToTarget.y = 0
    vectorToTarget:normalize3()
    SetExternalVelocity(bunny, (vectorToTarget * 7), 0.8999999761581421)
    wait(0.10000000149011612)
  end
  return 
end
BunniesInSuction = function(target)
  FireThread(BunnyVacuum, target, _activator())
  local bunny = _activator()
  if (GetPropertyEntity(bunny, "Parent Entity", 0) == GetPlayer()) then
    ClearParent(bunny)
  end
  GoToEntity(bunny, GetRelativePrefabEntity(target, ".PneumaticTubeEscape"))
  local data = GetPrefabData(target)
  if (data.BunniesInSuction == 0) then
    local spawner = GetRelativePrefabEntity(target, ".Spawner_FX")
    SetPropertyInt(spawner, "Index To Spawn", 0)
    ForceSpawn(spawner, 1)
    AudioPostEventOn(spawner, "Play_sfx_MS_BunnyVac_Start")
  end
  data.BunniesInSuction = (data.BunniesInSuction + 1)
  return 
end
DetachBunnies = function(player)
  local numChildren = GetElementCount(player, "Child Entities")
  for index = 0, numChildren do
    local child = GetChildEntityByIndex(player, index)
    if IsCharacter(child) then
      ClearParent(child)
    end
  end
  return 
end
BunniesLeaveSuction = function(target)
  local data = GetPrefabData(target)
  data.BunniesInSuction = (data.BunniesInSuction - 1)
  if (data.BunniesInSuction < 1) then
    data.BunniesInSuction = 0
    Disable(GetRelativePrefabEntity(target, ".Spawner_FX"))
    ForEachEntityInGroup(DestroyEntity, ".VacuumParticle")
    AudioPostEventOn(GetRelativePrefabEntity(target, ".Spawner_FX"), "Play_sfx_MS_BunnyVac_Stop")
  end
  if (GetCurrentCount(data.Globals[1]) == 5) then
    if (data.AllCaptureFunction ~= "None") then
      if (data.CaptureFunctionFired == "False") then
        data.CaptureFunctionFired = "True"
        SetMapMarkerVisible(GetRelativePrefabEntity(target, ".MapMarker"), false)
        FireThread(_G[data.AllCaptureFunction])
      end
    end
  end
  return 
end
BunnySuckedUp = function(target)
  local spawner = GetRelativePrefabEntity(target, ".Spawner_FX")
  local data = GetPrefabData(target)
  Print("BunnySuckedUp")
  Print("For reference, here is the bunny_stagetracker number:")
  Print(bunny_stagetracker)
  SetPropertyInt(spawner, "Index To Spawn", 1)
  ForceSpawn(spawner, 1)
  DestroyEntity(_activator())
  local data = GetPrefabData(target)
  GiveCollectible(data.Globals[1])
  BunniesLeaveSuction(target)
  if (GetGlobal(data.Globals[2]) == -1) then
    Print("Going to Paulie.")
    IncrementGlobal("MSN_BunnyQuest_Count")
    Print("Number sent to Paulie")
    Print(GetGlobal(("Bunny_Paulie_" .. bunny_stagetracker)))
    IncrementGlobal(("Bunny_Paulie_" .. bunny_stagetracker))
    Print("And now it's...")
    Print(GetGlobal(("Bunny_Paulie_" .. bunny_stagetracker)))
  elseif (GetGlobal(data.Globals[2]) == 1) then
    Print("Going to Ortensia")
    IncrementGlobal("OST_BunnyQuest_Count")
    Print("Number sent to Ortensia")
    Print(GetGlobal(("Bunny_Ortensia_" .. bunny_stagetracker)))
    IncrementGlobal(("Bunny_Ortensia_" .. bunny_stagetracker))
    Print("And now it's...")
    Print(GetGlobal(("Bunny_Ortensia_" .. bunny_stagetracker)))
  end
  SetGlobal("OST_BunnyQuest_TotalBunniesCollected", (GetGlobal("OST_BunnyQuest_TotalBunniesCollected") + 1))
  return 
end
Prefab_BunnySuction_BunnyEnteredTrigger = function(target)
  Print("__Function: Prefab_BunnySuction_BunnyEnteredTrigger")
  local data = GetPrefabData(target)
  if (data.SpawnMarkersToUse < 1) then
    Print("__SPAWNMARKERSTOUSE overridden to invalid value! Defaulting to 1, ALL BUNNIES WILL RE-APPEAR AT YOUR FIRST LOCATION UNTIL YOU FIX THIS")
    data.SpawnMarkersToUse = 1
  end
  TeleportToEntity(_activator(), GetRelativePrefabEntity(target, (".BunnySpawnPosition" .. tostring(math.random(1, data.SpawnMarkersToUse)))))
  return 
end
Prefab_BunnySuction_EnableOswaldSpot = function(target, spot)
  local data = GetPrefabData("BunnySuctionTube")
  if (GetGlobal(data.Globals[2]) == 0) then
    if GetPropertyBool(target, "Is Painted") then
      if (spot == "BunnySuctionAIOswaldReprogramSpot") then
        SetPropertyBool(spot, "ActionSpotEnabled", true)
      end
    elseif (GetPropertyBool(target, "Is Painted") ~= true) then
      if (spot == "BunnySuctionAIOswaldReprogramSpot") then
        SetPropertyBool(spot, "ActionSpotEnabled", false)
      end
    elseif GetPropertyBool(target, "Is Painted") then
      if (spot == "BunnySuctionAIOswaldShockerSpot") then
        SetPropertyBool(spot, "ActionSpotEnabled", false)
      end
    elseif (GetPropertyBool(target, "Is Painted") ~= true) then
      if (spot == "BunnySuctionAIOswaldShockerSpot") then
        SetPropertyBool(spot, "ActionSpotEnabled", true)
      end
    end
  end
  return 
end
Prefab_BunnySuctionToon_StateChange = function(target, _State)
  Print(("__Function: Prefab_BunnySuctionDummy_StateChange, _State: " .. tostring(_State)))
  local data = GetPrefabData("BunnySuctionTube")
  if (_State == "PhoneBox_Paint") then
    data.States[reg_13] = 1
  elseif (_State == "PhoneBox_Thin") then
    data.States[reg_13] = 0
  elseif (_State == "HackBox_Paint") then
    data.States[reg_17] = 1
  elseif (_State == "HackBox_Thin") then
    data.States[reg_17] = 0
  end
  if (data.States[1] == 0) then
    if (data.States[2] == 0) then
      SetGlobal(data.PersistFromDummyGlobal, 0)
    end
  elseif (data.States[1] == 0) then
    if (data.States[2] == 1) then
      SetGlobal(data.PersistFromDummyGlobal, 1)
    end
  elseif (data.States[1] == 1) then
    if (data.States[2] == 0) then
      SetGlobal(data.PersistFromDummyGlobal, 2)
    end
  elseif (data.States[1] == 1) then
    if (data.States[2] == 1) then
      SetGlobal(data.PersistFromDummyGlobal, 3)
    end
  end
  Print(((("__New data persist global " .. tostring(data.PersistFromDummyGlobal)) .. " value: ") .. tostring(GetGlobal(data.PersistFromDummyGlobal))))
  return 
end
Prefab_testerman = function()
  Bark(nil, "Rocking in the free world")
  return 
end

