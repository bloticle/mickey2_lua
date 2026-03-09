gsCh_StartUp = function(target)
  local data = GetPrefabData(target)
  if (data.TVOnly == "False") then
    StartRotateToPosition(GetRelativePrefabEntity(_self(), ".leftArm"), 0)
    StartRotateToPosition(GetRelativePrefabEntity(_self(), ".rightArm"), 0)
    local data = GetPrefabData(_self())
    if (GetGlobal(data.BallGlobal) ~= 0) then
      local ballHandle = gs_BallManager(target, GetGlobal(data.BallGlobal))
      local databall = GetPrefabData(ballHandle)
      local ballEntity = GetRelativePrefabEntity(ballHandle, ".tmp_physicsBall_01a 01")
      SetPropertyFloat(ballEntity, "UsableRadius", 0)
      DisableMotion(ballEntity)
      MoveToEntity(ballEntity, GetRelativePrefabEntity(_self(), ".Ball_Marker(Rotatable) 01"))
      SetPropertyBool(GetRelativePrefabEntity(ballEntity, ".tmp_physicsBall_01a 01"), "Is Mover", true)
      SetParentEntity(GetRelativePrefabEntity(ballEntity, ".tmp_physicsBall_01a 01"), GetRelativePrefabEntity(_self(), ".Ball_Marker(Rotatable) 01"))
      MoveToEntity(GetRelativePrefabEntity(_self(), ".rightArm"), GetRelativePrefabEntity(_self(), ".SplineKnot 04"))
      MoveToEntity(GetRelativePrefabEntity(_self(), ".leftArm"), GetRelativePrefabEntity(_self(), ".SplineKnot 04"))
      StartEmitters(GetRelativePrefabEntity(_self(), ".ChargeSparks"))
      AudioPostEventOn(GetRelativePrefabEntity(_self(), ".Snd_ChargingPlatform"), "Play_sfx_dec_charge_station_beam_lp")
      FireUser2(data.TargetNode)
    elseif (data.TV_Persists == true) then
      if (data.TV_Global ~= "None") then
        if (GetGlobal(data.TV_Global) == 1) then
          FireUser1(data.TargetNode)
        end
      else
        Print((("DESIGN ERROR: TV_Persists is true but TV_Global is None, charge machine: " .. tostring(GetName(target))) .. " will NOT persist!"))
        Print("__Override set to only respond to a TV. Deleting unneccessary stuff!")
        DestroyEntity(GetRelativePrefabEntity(target, ".Ball_Marker(Rotatable) 01"))
        Disable(GetRelativePrefabEntity(target, ".Trigger 02"))
        if (data.TVOnlyPoweredCheckGlobal ~= "None") then
          if (GetGlobal(data.TVOnlyPoweredCheckGlobal) == 1) then
            Print("__THIS PAD HAS POWER!")
          end
        else
          Print("__NO GLOBAL SPECIFIED!")
        end
        DestroyEntity(target)
      end
    end
  else
    Print("__Override set to only respond to a TV. Deleting unneccessary stuff!")
    DestroyEntity(GetRelativePrefabEntity(target, ".Ball_Marker(Rotatable) 01"))
    Disable(GetRelativePrefabEntity(target, ".Trigger 02"))
    if (data.TVOnlyPoweredCheckGlobal ~= "None") then
      if (GetGlobal(data.TVOnlyPoweredCheckGlobal) == 1) then
        Print("__THIS PAD HAS POWER!")
      end
    else
      Print("__NO GLOBAL SPECIFIED!")
    end
    DestroyEntity(target)
  end
  return 
end
gsCh_AttachBallandPowerUp = function(ball)
  local databall = GetPrefabData(ball)
  local data = GetPrefabData(_self())
  local ballGlobalName = data.BallGlobal
  if (GetGlobal(data.BallGlobal) == 0) then
    SetGlobal(data.BallGlobal, tonumber(databall.BallIdent))
    local ballEntity = GetRelativePrefabEntity(ball, ".tmp_physicsBall_01a 01")
    local sKnotInit = GetRelativePrefabEntity(_self(), ".SplineKnot 01")
    DisableMotion(ballEntity)
    MoveToEntity(sKnotInit, ballEntity)
    SplineFollower_TeleportToKnot(ballEntity, sKnotInit)
    Enable(ballEntity)
    SetPropertyFloat(ballEntity, "UsableRadius", 0)
    wait(0.5)
    AudioPostEventOn(GetRelativePrefabEntity(ball, ".tmp_physicsBall_01a 01"), "Play_sfx_dec_charge_station_power_on")
    SetPropertyBool(GetRelativePrefabEntity(ball, ".tmp_physicsBall_01a 01"), "Is Mover", true)
    SetParentEntity(GetRelativePrefabEntity(ball, ".tmp_physicsBall_01a 01"), GetRelativePrefabEntity(_self(), ".Ball_Marker(Rotatable) 01"))
    wait(0.10000000149011612)
    FireThread(gsCh_SparksActivate, _self())
    SplineFollower_SetDisabled(GetRelativePrefabEntity(_self(), ".leftArm"), false)
    SplineFollower_SetDisabled(GetRelativePrefabEntity(_self(), ".rightArm"), false)
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(_self(), ".leftArm"), 0.20000000298023224)
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(_self(), ".rightArm"), 0.20000000298023224)
    wait(0.5)
    SplineFollower_SetDisabled(ballEntity, true)
    FireUser2(data.TargetNode)
    wait(1)
    SplineFollower_SetDisabled(GetRelativePrefabEntity(_self(), ".leftArm"), true)
    SplineFollower_SetDisabled(GetRelativePrefabEntity(_self(), ".rightArm"), true)
  end
  return 
end
gsCh_SparksActivate = function(target)
  local SparksOn = 0
  local data = GetPrefabData(target)
  StartEmitters(GetRelativePrefabEntity(target, ".ChargeSparks"))
  AudioPostEventOn(GetRelativePrefabEntity(target, ".Snd_ChargingPlatform"), "Play_sfx_dec_charge_station_beam_lp")
  Unhide(GetRelativePrefabEntity(target, ".sparks_01"))
  Unhide(GetRelativePrefabEntity(target, ".sparks_02"))
  Unhide(GetRelativePrefabEntity(target, ".sparks_03"))
  while (SparksOn < 3) do
    if (SparksOn == 0) then
      StartEmitters(GetRelativePrefabEntity(target, ".sparks_01"))
      SplineFollower_SetDisabled(GetRelativePrefabEntity(target, ".sparks_01"), false)
    elseif (SparksOn == 1) then
      StartEmitters(GetRelativePrefabEntity(target, ".sparks_02"))
      SplineFollower_SetDisabled(GetRelativePrefabEntity(target, ".sparks_02"), false)
    elseif (SparksOn == 2) then
      StartEmitters(GetRelativePrefabEntity(target, ".sparks_03"))
      SplineFollower_SetDisabled(GetRelativePrefabEntity(target, ".sparks_03"), false)
    end
    SparksOn = (SparksOn + 1)
    wait(data.sparkTiming)
  end
  return 
end
gsCh_SparksTeleport = function(target)
  SplineFollower_TeleportToKnot(target, GetRelativePrefabEntity(target, ".SplineKnot 05"))
  return 
end
gsCh_TVonPlatform = function(target)
  local data = GetPrefabData(target)
  if (data.TVOnly == "False") then
    FireUser1(data.TargetNode)
    if (data.TV_Persists == true) then
      if (data.TV_Global ~= "None") then
        SetGlobal(data.TV_Global, 1)
      else
        Print((("DESIGN ERROR: TV_Persists is true but TV_Global is None, charge machine: " .. tostring(GetName(target))) .. " will NOT persist!"))
        if (data.TVOnlyFunctions[1] ~= "EnteredFunction") then
          Print(("__Firing Function: " .. tostring(data.TVOnlyFunctions[1])))
          Disable(GetRelativePrefabEntity(target, ".Trigger 02"))
          FireThread(_G[data.TVOnlyFunctions[1]])
        end
      end
    end
  elseif (data.TVOnlyFunctions[1] ~= "EnteredFunction") then
    Print(("__Firing Function: " .. tostring(data.TVOnlyFunctions[1])))
    Disable(GetRelativePrefabEntity(target, ".Trigger 02"))
    FireThread(_G[data.TVOnlyFunctions[1]])
  end
  return 
end
gsCh_TVtimeOut = function(target)
  local data = GetPrefabData(target)
  if (data.TVOnly == "False") then
    FireUser3(data.TargetNode)
  elseif (data.TVOnlyFunctions[2] ~= "ExitedFunction") then
    Print(("__Firing Function: " .. tostring(data.TVOnlyFunctions[2])))
    FireThread(_G[data.TVOnlyFunctions[2]])
  else
    Print("__No exit function specified, is this intended? (the answer is probably yes if your TV should be permanent)")
  end
  return 
end
gsCh_TVOnly_AllowTVPlacement = function(target)
  Print("__Function: gsCh_TVOnly_AllowTVPlacement")
  Print(("__Enabling Trigger: " .. tostring(GetName(target))))
  Enable(target)
  return 
end
gsCh_TVOnly_DisallowTVPlacement = function(target)
  Print("__Function: gsCh_TVOnly_AllowTVPlacement")
  Print(("__Disabling Trigger: " .. tostring(GetName(target))))
  Enable(target)
  return 
end
