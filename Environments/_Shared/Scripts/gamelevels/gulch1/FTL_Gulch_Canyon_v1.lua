FTL_Gulch_Intro = function(target)
  Print("!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 1")
  for i = 1, 2 do
    MoveToEntity("Spawner_Spatters", ("ftl_gulch_01a_visit1_ai.PM_SpatterSpawn 0" .. i))
    ForceSpawn("Spawner_Spatters", 1)
    wait(0)
  end
  if (GetGlobal("FTL_Gulch_NearSaloon_Played") == 1) then
    Disable("ftl_gulch_01a_visit1.Trigger_GPIntro_Saloon")
  end
  if (GetGlobal("FTL_Gulch_GuardianTraining_Tower_Played") == 1) then
    Disable("ftl_gulch_01a_visit1.Trigger_GPIntro_WaterTower")
  end
  local introGlobal = GetGlobal("FTL_Gulch_IntroPlayed")
  local _player = GetPlayer()
  local _player2 = GetPlayer2OrAI()
  if (introGlobal == 0) then
    if (MostRecentCheckpointCallback == "FTL_Gulch_Setup") then
      introGlobal = "!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 1: MostRecentCheckpointCallback == FTL_Gulch_Setup  so we must have quit during the intro IGC, refiring IGC"
      Print(introGlobal)
      target = "Angel"
      introGlobal = "DEC_HardLoad"
      if (GetGlobal(introGlobal) == 1) then
        target = "DEC"
      end
    end
    introGlobal = "FTL_Gulch.IGC_Canyon_Intro"
    LevelManager_SetZoneStatusActive(introGlobal)
    WaitForLevelLoad()
    introGlobal = "Critical_Gulch1"
    _player = "Critical_Gulch1_1"
    Quest_SetCriticalPath(introGlobal, _player)
    introGlobal = "MSS_ObservatoryItem_Gulch"
    _player = "3"
    ObservatoryItem_Activate(introGlobal, _player)
    introGlobal = "TrainBall2"
    DisableMotion(introGlobal)
    introGlobal = "TrainBall2"
    _player = "FTL_Gulch1_DancingRockSpatter"
    SetParentEntity(introGlobal, _player)
    introGlobal = 3
    _player = 1
    for _player2 = 1, introGlobal, _player do
      x = "State"
      if (GetGlobal((("FTL_Gulch_Ball0" .. _player2) .. x)) == 0) then
        x = "State"
        SetGlobal((("FTL_Gulch_Ball0" .. _player2) .. x), 1)
      end
    end
    introGlobal = "TriggerLookAt_SpatterRock"
    _player = "Look At Trigger Enabled"
    _player2 = false
    SetPropertyBool(introGlobal, _player, _player2)
    if (target ~= "Checkpoint") then
      if (target == "DEC") then
        introGlobal = "IGC_0150a_Gulch1DevilIntro"
        PlayIGC(introGlobal)
      else
        introGlobal = "Projector_ToCavernsAngel"
        _player = ".ProjectorMarker"
        local Cam_Override = GetRelativePrefabEntity(introGlobal, _player)
        introGlobal = SetPropertyBool
        _player = Cam_Override
        _player2 = "InstantTransition"
        introGlobal(_player, _player2, false)
        introGlobal = SetPropertyFloat
        _player = Cam_Override
        _player2 = "TransitionTime"
        introGlobal(_player, _player2, 3)
        introGlobal = GetNumPlayers
        introGlobal = introGlobal()
        if (introGlobal == 2) then
          introGlobal = SetCameraAttributesForPlayer
          _player = "FTL_Gulch_IntroOverride_Angel_coopPlayer1"
          _player2 = _player
          introGlobal(_player, _player2)
        else
          introGlobal = SetCameraAttributesForPlayer
          _player = "FTL_Gulch_IntroOverride_Angel"
          _player2 = _player
          introGlobal(_player, _player2)
        end
        introGlobal = SetCameraAttributesForPlayer
        _player = "FTL_Gulch_IntroOverride_Angel_coopPlayer2"
        _player2 = GetPlayer2OrAI
        _player2 = _player2()
        introGlobal(_player, _player2)
        introGlobal = PlayIGC
        _player = "IGC_0150b_Gulch1AngelIntro"
        introGlobal(_player)
        introGlobal = "!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 1: Intro Played"
        Print(introGlobal)
        introGlobal = "FTL_Gulch1_DancingRockSpatter"
        if IsValidHandle(introGlobal) then
          introGlobal = "!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 1: Spatter Still Alive"
          Print(introGlobal)
          local spatter = "FTL_Gulch1_DancingRockSpatter"
          introGlobal = GetGlobal
          _player = "FTL_Gulch_SpinningRockState"
          introGlobal = introGlobal(_player)
          if (introGlobal == 0) then
            introGlobal = Print
            _player = "!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 1: Rock still moving"
            introGlobal(_player)
            introGlobal = SetParentEntity
            _player = spatter
            _player2 = "FTL_Gulch_DancingRocks_Inert"
            introGlobal(_player, _player2)
            introGlobal = Print
            _player = "FTL_Gulch_Intro cooked"
            introGlobal(_player)
            introGlobal = PlayIGC
            _player = "IGC_0150c_Gulch1SpatterOnSphere"
            introGlobal(_player)
            if (target ~= "DEC") then
              if (target ~= "Checkpoint") then
                introGlobal = function()
                  wait(0.8500000238418579)
                  wait(0)
                  PlayIGC("IGC_0150c_Gulch1SpatterOnSphere")
                  return 
                end
                _player = FireThread
                _player2 = introGlobal
                _player(_player2)
              end
            end
            introGlobal = DisableMotion
            _player = "TrainBall2"
            introGlobal(_player)
            introGlobal = SetParentEntity
            _player = "TrainBall2"
            _player2 = spatter
            introGlobal(_player, _player2)
            introGlobal = SetPropertyVector
            _player = spatter
            _player2 = "Indicator Offset"
            introGlobal(_player, _player2, vector4(0, 3, 0))
            introGlobal = SetPropertyVector
            _player = spatter
            _player2 = "Lock Offset"
            introGlobal(_player, _player2, vector4(0, 3.5, 0))
          else
            introGlobal = Print
            _player = "!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 1: Rock Stopped"
            introGlobal(_player)
            introGlobal = SetVulnerability
            _player = spatter
            _player2 = ST_ELECTRIC
            introGlobal(_player, _player2, 1)
            introGlobal = SetPropertyBool
            _player = spatter
            _player2 = "DisallowGuardianTargeting"
            introGlobal(_player, _player2, false)
            introGlobal = FireThread
            _player = FTL_Gulch_SpatterReloadCheck
            _player2 = spatter
            introGlobal(_player, _player2)
          end
        end
        introGlobal = "FTL_Gulch_Gus_SpatterTower_Played"
        if (GetGlobal(introGlobal) == 1) then
          introGlobal = "TriggerLookAt_SpatterRock"
          _player = "Look At Trigger Enabled"
          _player2 = false
          SetPropertyBool(introGlobal, _player, _player2)
          introGlobal = "FTL_Gulch_SpinningRockState"
          if (GetGlobal(introGlobal) == 0) then
            introGlobal = "TriggerLookAt_SpatterRock_Repeat"
            _player = "Look At Trigger Enabled"
            _player2 = true
            SetPropertyBool(introGlobal, _player, _player2)
          end
        end
        introGlobal = "FTL_Gulch_SpinningRockState"
        if (GetGlobal(introGlobal) ~= 0) then
          introGlobal = Disable
          _player = "DancingRock_HintTriggers"
          ForEachEntityInGroup(introGlobal, _player)
          introGlobal = "FTL_Gulch_DancingRocks_Inert"
          _player = "rest"
          AnimGBSequence(introGlobal, _player)
        end
        introGlobal = "FTL_Gulch_StartLocation"
        if (GetGlobal(introGlobal) == 1) then
          _player2 = GetPlayer2OrAI()
          introGlobal = _player
          _player = "PM_AngelSideStart_Mickey"
          TeleportToEntity(introGlobal, _player)
          introGlobal = _player2
          _player = "PM_AngelSideStart_Oswald"
          TeleportToEntity(introGlobal, _player)
          ClearAllCameraAttributes()
          if (GetNumPlayers() == 2) then
            introGlobal = "FTL_Gulch_IntroOverride_Angel_coopPlayer1"
            _player = _player
            SetCameraAttributesForPlayer(introGlobal, _player)
          else
            introGlobal = "FTL_Gulch_IntroOverride_Angel"
            _player = _player
            SetCameraAttributesForPlayer(introGlobal, _player)
          end
          introGlobal = "FTL_Gulch_IntroOverride_Angel_coopPlayer2"
          _player = _player2
          SetCameraAttributesForPlayer(introGlobal, _player)
          introGlobal = StationaryCamera_UntilPlayerMoves
          FireThread(introGlobal)
          introGlobal = StationaryCamera_UntilPlayerMoves
          _player = nil
          _player2 = nil
          FireThread(introGlobal, _player, _player2, _player2)
        else
          introGlobal = FTL_SaveCheckpoint
          _player = nil
          _player2 = "Devil"
          FireThread(introGlobal, _player, _player2)
          if (target == "DEC") then
            introGlobal = "FoopToob_Gulch_ToDEC"
            Prefab_DECFoopToob_Finish(introGlobal)
            introGlobal = "playing get on ball igc"
            Print(introGlobal)
            introGlobal = "IGC_0150c_Gulch1SpatterOnSphere"
            PlayIGC(introGlobal)
          end
        end
      end
    end
  else
    introGlobal = "!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 1: Intro Played"
    Print(introGlobal)
    introGlobal = "FTL_Gulch1_DancingRockSpatter"
    if IsValidHandle(introGlobal) then
      introGlobal = "!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 1: Spatter Still Alive"
      Print(introGlobal)
      local spatter = "FTL_Gulch1_DancingRockSpatter"
      introGlobal = GetGlobal
      _player = "FTL_Gulch_SpinningRockState"
      introGlobal = introGlobal(_player)
      if (introGlobal == 0) then
        introGlobal = Print
        _player = "!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 1: Rock still moving"
        introGlobal(_player)
        introGlobal = SetParentEntity
        _player = spatter
        _player2 = "FTL_Gulch_DancingRocks_Inert"
        introGlobal(_player, _player2)
        introGlobal = Print
        _player = "FTL_Gulch_Intro cooked"
        introGlobal(_player)
        introGlobal = PlayIGC
        _player = "IGC_0150c_Gulch1SpatterOnSphere"
        introGlobal(_player)
        if (target ~= "DEC") then
          if (target ~= "Checkpoint") then
            introGlobal = function()
              wait(0.8500000238418579)
              wait(0)
              PlayIGC("IGC_0150c_Gulch1SpatterOnSphere")
              return 
            end
            _player = FireThread
            _player2 = introGlobal
            _player(_player2)
          end
        end
        introGlobal = DisableMotion
        _player = "TrainBall2"
        introGlobal(_player)
        introGlobal = SetParentEntity
        _player = "TrainBall2"
        _player2 = spatter
        introGlobal(_player, _player2)
        introGlobal = SetPropertyVector
        _player = spatter
        _player2 = "Indicator Offset"
        introGlobal(_player, _player2, vector4(0, 3, 0))
        introGlobal = SetPropertyVector
        _player = spatter
        _player2 = "Lock Offset"
        introGlobal(_player, _player2, vector4(0, 3.5, 0))
      else
        introGlobal = Print
        _player = "!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 1: Rock Stopped"
        introGlobal(_player)
        introGlobal = SetVulnerability
        _player = spatter
        _player2 = ST_ELECTRIC
        introGlobal(_player, _player2, 1)
        introGlobal = SetPropertyBool
        _player = spatter
        _player2 = "DisallowGuardianTargeting"
        introGlobal(_player, _player2, false)
        introGlobal = FireThread
        _player = FTL_Gulch_SpatterReloadCheck
        _player2 = spatter
        introGlobal(_player, _player2)
      end
    end
    introGlobal = "FTL_Gulch_Gus_SpatterTower_Played"
    if (GetGlobal(introGlobal) == 1) then
      introGlobal = "TriggerLookAt_SpatterRock"
      _player = "Look At Trigger Enabled"
      _player2 = false
      SetPropertyBool(introGlobal, _player, _player2)
      introGlobal = "FTL_Gulch_SpinningRockState"
      if (GetGlobal(introGlobal) == 0) then
        introGlobal = "TriggerLookAt_SpatterRock_Repeat"
        _player = "Look At Trigger Enabled"
        _player2 = true
        SetPropertyBool(introGlobal, _player, _player2)
      end
    end
    introGlobal = "FTL_Gulch_SpinningRockState"
    if (GetGlobal(introGlobal) ~= 0) then
      introGlobal = Disable
      _player = "DancingRock_HintTriggers"
      ForEachEntityInGroup(introGlobal, _player)
      introGlobal = "FTL_Gulch_DancingRocks_Inert"
      _player = "rest"
      AnimGBSequence(introGlobal, _player)
    end
    introGlobal = "FTL_Gulch_StartLocation"
    if (GetGlobal(introGlobal) == 1) then
      _player2 = GetPlayer2OrAI()
      introGlobal = _player
      _player = "PM_AngelSideStart_Mickey"
      TeleportToEntity(introGlobal, _player)
      introGlobal = _player2
      _player = "PM_AngelSideStart_Oswald"
      TeleportToEntity(introGlobal, _player)
      ClearAllCameraAttributes()
      if (GetNumPlayers() == 2) then
        introGlobal = "FTL_Gulch_IntroOverride_Angel_coopPlayer1"
        _player = _player
        SetCameraAttributesForPlayer(introGlobal, _player)
      else
        introGlobal = "FTL_Gulch_IntroOverride_Angel"
        _player = _player
        SetCameraAttributesForPlayer(introGlobal, _player)
      end
      introGlobal = "FTL_Gulch_IntroOverride_Angel_coopPlayer2"
      _player = _player2
      SetCameraAttributesForPlayer(introGlobal, _player)
      introGlobal = StationaryCamera_UntilPlayerMoves
      FireThread(introGlobal)
      introGlobal = StationaryCamera_UntilPlayerMoves
      _player = nil
      _player2 = nil
      FireThread(introGlobal, _player, _player2, _player2)
    else
      introGlobal = FTL_SaveCheckpoint
      _player = nil
      _player2 = "Devil"
      FireThread(introGlobal, _player, _player2)
      if (target == "DEC") then
        introGlobal = "FoopToob_Gulch_ToDEC"
        Prefab_DECFoopToob_Finish(introGlobal)
        introGlobal = "playing get on ball igc"
        Print(introGlobal)
        introGlobal = "IGC_0150c_Gulch1SpatterOnSphere"
        PlayIGC(introGlobal)
      end
    end
  end
  if (target ~= "Checkpoint") then
    introGlobal = GetPlayer
    introGlobal = introGlobal()
    _player = "Play_MX_DG1_Valley"
    MusicPostEventOn(introGlobal, _player)
    RemoveAllMusicStateOverride()
    introGlobal = "Started valley music from FTL_Gulch_Intro visit 1"
    Print(introGlobal)
  end
  RemoveAllMusicStateOverride()
  introGlobal = -100
  SetCombatIntensityBias(introGlobal)
  if (MostRecentCheckpointCallback ~= "FTL_Gulch_Setup") then
    if (introGlobal == 0) then
      local saveLoc = "Angel"
      if (target ~= "Checkpoint") then
        if (target == "DEC") then
          saveLoc = "Devil"
        end
        introGlobal = FireThread
        _player = FTL_SaveCheckpoint
        _player2 = saveLoc
        introGlobal(_player, _player2)
      else
        introGlobal = FireThread
        _player = FTL_SaveCheckpoint
        introGlobal(_player)
      end
    end
  end
  introGlobal = FTL_ForceSphere2InPosition
  FireThread(introGlobal)
  return 
end
FTL_Gulch_Intro_SpatterSwap = function()
  Print("FTL_Gulch_Intro_SpatterSwap")
  DestroyEntity("ftl_gulch_01a_visit1.Intro_DancingRock_TrainSphere")
  DestroyEntity("ftl_gulch_01a_visit1.Intro_DancingRock_Spatter")
  AnimGBSequence("FTL_Gulch_DancingRocks_Inert", "rest")
  local spatter = "FTL_Gulch1_DancingRockSpatter"
  SetParentEntity(spatter, "FTL_Gulch_DancingRocks_Inert")
  Unhide(spatter)
  Unhide("TrainBall2")
  AnimGBSequence("FTL_Gulch_DancingRocks_Inert", "spin", true)
  AudioPostEventOn(GetEntity("ftl_gulch_01a_canyon_scripting.DancingRocks_Inert"), "Play_sfx_dg1_spinning_rock_lp")
  return 
end
PostIGC_0150a_Gulch1DevilIntro = function()
  Print("PostIGCCleanup")
  SetGlobal("FTL_Gulch_IntroPlayed", 1)
  SetPropertyBool("TriggerLookAt_SpatterRock", "Look At Trigger Enabled", true)
  LevelManager_SetZoneStatusUnloaded("FTL_Gulch.IGC_Canyon_Intro")
  EnableSplitScreen(false)
  EnableSplitScreen(true)
  Prefab_DECFoopToob_Finish()
  FTL_SaveCheckpoint("Devil")
  return 
end
PostIGC_0150b_Gulch1AngelIntro = function()
  Print("PostIGCCleanup")
  SetGlobal("FTL_Gulch_IntroPlayed", 1)
  SetPropertyBool("TriggerLookAt_SpatterRock", "Look At Trigger Enabled", true)
  LevelManager_SetZoneStatusUnloaded("FTL_Gulch.IGC_Canyon_Intro")
  FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer2OrAI())
  FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer())
  wait(3)
  UnrestrictCutSceneInput()
  FTL_SaveCheckpoint("Angel")
  return 
end
FTL_Gulch_GP_Training = function(target, state)
  Print(("FTL_Gulch_GP_Training: state = " .. state))
  if (_activator() ~= GetOswaldAI()) then
    Print("FTL_Gulch_GP_Training: Hey Atleast we arent Oswald")
    if (state == "River") then
      if (GetGlobal("FTL_Gulch_Gus_GuardianTraining_Played") == 0) then
        if (_activator() == GetPlayer()) then
          ForceSequence("Gus_v1", "FTL_Gulch_Gus_GuardianTraining")
        end
      end
    elseif (state == "Saloon") then
      if (GetGlobal("FTL_Gulch_NearSaloon_Played") == 0) then
        FireSequence("Gus_v1", "FTL_Gulch_NearSaloon")
        SetCameraAttributesForPlayer("CO_SaloonGuardianPool", _activator())
        wait(5)
        ClearCameraAttributesForPlayer("CO_SaloonGuardianPool", _activator(), 2)
      end
    elseif (state == "WaterTower") then
      if (GetGlobal("FTL_Gulch_GuardianTraining_Tower_Played") == 0) then
        FireSequence("Gus_v1", "FTL_Gulch_GuardianTraining_Tower")
        SetCameraAttributesForPlayer("CO_TrappedTowerGuardians", _activator())
        wait(5)
        ClearCameraAttributesForPlayer("CO_TrappedTowerGuardians", _activator(), 2)
      end
    end
  end
  return 
end
FTL_Gulch_RaiseSphereLoader = function(param)
  Print("FTL_Gulch_RaiseSphereLoader")
  if (param == "fromApprentice") then
    Print(("FTL_Gulch_RaiseSphereLoader: fromApprentice = " .. param))
  elseif (GetPropertyInt("Canyon_SphereLoader", "Active Sequence ID") == 0) then
    if (GetGlobal("FTL_Gulch_SphereTraining_Played") == 0) then
      Print("FTL_Gulch_RaiseSphereLoader: Player Grabbed Sphere")
      ForceSequence("Gus_v1", "FTL_Gulch_SphereTraining")
    end
  end
  return 
end
FTL_Gulch_TeleportTrainToCanyon = function()
  DestroyEntity("GusHint_TrainBall1")
  DestroyEntity("GusHint_TrainBall2")
  DestroyEntity("GusHint_TrainBall3")
  local toonConnectorState = FTL_Gulch_TeleportTrainToCanyon_Shared(1)
  StreamZones(nil, "Lab_v1")
  FTL_Gulch_TeleportTrainToCanyon_Shared(2, toonConnectorState)
  FTL_Gulch_LabSetup()
  UnrestrictCutSceneInput()
  return 
end
FTL_Gulch_SpatterReloadCheck = function(spatter)
  Print("FTL_Gulch_SpatterReloadCheck")
  wait(5)
  Print("FTL_Gulch_SpatterReloadCheck: Enabling Motion")
  EnableMotion(spatter)
  return 
end

