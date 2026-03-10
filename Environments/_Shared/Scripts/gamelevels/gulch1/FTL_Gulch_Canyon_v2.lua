FTL_Gulch_Intro = function(target)
  Print("!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 2")
  local totalCharsLoaded = 0
  if (GetGlobal("MSN_Quest_3Pigs_State") == 3) then
    if (GetGlobal("FTL_Fifer_Rescued_Played") == 0) then
      Print("!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 2: Loading Creative Threedom (3 Pigs) Quest")
      LevelManager_SetZoneStatusActive("FTL_Gulch.Q_Canyon_Pigs")
      totalCharsLoaded = (totalCharsLoaded + 1)
    end
  end
  if (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
    if (GetCurrentCount("BunnyChildren_DisneyGulch") ~= 5) then
      Print("!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 2: Loading Bunny Wranglers Quest")
      LevelManager_SetZoneStatusActive("FTL_Gulch.Q_Canyon_Bunny")
      totalCharsLoaded = (totalCharsLoaded + 1)
    end
  else
    LevelManager_SetZoneStatusActive("FTL_Gulch.Q_Canyon_BunnyDummy")
  end
  if (GetGlobal("FTL_Griff_FreeCage_Played") == 0) then
    Print("!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 2: Loading Gremlin Quest")
    LevelManager_SetZoneStatusActive("FTL_Gulch.Q_Canyon_Gremlin")
    totalCharsLoaded = (totalCharsLoaded + 1)
  end
  if (GetGlobal("FTL_Gulch_IntroPlayed") == 0) then
    SetGlobal("FTL_Gulch_IntroPlayed", 1)
    Enable("Trigger_SphereDetection")
    AnimGBSequence("Canyon_SphereLoader", "raise")
  end
  if IsValidHandle("TrainBall2") then
    Unhide("TrainBall2")
  end
  local FTL_Gulch_SpinningRockState = GetGlobal("FTL_Gulch_SpinningRockState")
  if (FTL_Gulch_SpinningRockState == 0) then
    AnimGBSequence("FTL_Gulch_DancingRocks_Inert", "rest")
    SetGlobal("FTL_Gulch_SpinningRockState", -1)
  end
  if (FTL_Gulch_SpinningRockState == 2) then
    if (0.75 < GetPropertyFloat(GetRelativePrefabEntity("FTL_Gulch1_GuardianPool", ".GuardianPoolVisible_Visual"), "CurrentPlaystyle")) then
      if (totalCharsLoaded < 4) then
        LevelManager_SetZoneStatusActive("FTL_Gulch.Canyon_AI_v2_BlotworxM")
        LevelManager_SetZoneStatusActive("FTL_Gulch.ASL_AI_BlotworxM_Shared")
      end
    end
  else
    local loop = 0
    while (totalCharsLoaded < 4) do
      loop = (loop + 1)
      totalCharsLoaded = (totalCharsLoaded + 1)
      if (loop == 1) then
        LevelManager_SetZoneStatusActive("FTL_Gulch.Canyon_AI_v2_BlotworxM")
        LevelManager_SetZoneStatusActive("FTL_Gulch.ASL_AI_BlotworxM_Shared")
      end
      LevelManager_SetZoneStatusActive("FTL_Gulch.Canyon_AI_v2_Dropwing")
      LevelManager_SetZoneStatusActive("FTL_Gulch.ASL_AI_Dropwings")
    end
  end
  WaitForLevelLoad()
  local _player = GetPlayer()
  _player = GetPlayer2OrAI
  _player = _player()
  _player2 = GetGlobal
  _player2 = _player2("FTL_Gulch_StartLocation")
  if (_player2 == 1) then
    _player2 = TeleportToEntity
    _player2(_player, "PM_AngelSideStart_Mickey")
    _player2 = TeleportToEntity
    _player2(_player, "PM_AngelSideStart_Oswald")
    _player2 = ClearAllCameraAttributes
    _player2()
    _player2 = GetNumPlayers
    _player2 = _player2()
    if (_player2 == 2) then
      _player2 = SetCameraAttributesForPlayer
      _player2("FTL_Gulch_IntroOverride_Angel_coopPlayer1", _player)
    else
      _player2 = SetCameraAttributesForPlayer
      _player2("FTL_Gulch_IntroOverride_Angel", _player)
    end
    _player2 = SetCameraAttributesForPlayer
    _player2("FTL_Gulch_IntroOverride_Angel_coopPlayer2", _player)
    _player2 = FireThread
    _player2(StationaryCamera_UntilPlayerMoves)
    _player2 = FireThread
    _player2(StationaryCamera_UntilPlayerMoves, nil, nil, _player)
  else
    _player2 = FireThread
    _player2(FTL_SaveCheckpoint, nil, "Devil")
    if (target == "DEC") then
      _player2 = Prefab_DECFoopToob_Finish
      _player2("FoopToob_Gulch_ToDEC")
    end
  end
  if (target ~= "Checkpoint") then
    _player2 = Print
    _player2("Started valley music from FTL_Gulch_Intro visit 2")
    _player2 = RemoveAllMusicStateOverride
    _player2()
    _player2 = MusicPostEventOn
    _player2(_player, "Play_MX_DG1_Valley")
  end
  _player2 = SetCombatIntensityBias
  _player2(-100)
  _player2 = MostRecentCheckpointCallback
  if (_player2 ~= "FTL_Gulch_Setup") then
    _player2 = Print
    _player2("MostRecentCheckpointCallback ~= FTL_Gulch_Setup")
    _player2 = "Angel"
    local saveLoc = "MostRecentCheckpointCallback ~= FTL_Gulch_Setup"
    if (target ~= "Checkpoint") then
      if (target == "DEC") then
        _player2 = "Devil"
      end
      saveLoc = FireThread
      saveLoc(FTL_SaveCheckpoint, _player2)
    else
      saveLoc = FireThread
      saveLoc(FTL_SaveCheckpoint)
    end
  end
  _player2 = FireThread
  _player2(FTL_ForceSphere2InPosition)
  return 
end
FTL_Gulch_TeleportTrainToCanyon = function()
  local toonConnectorState = FTL_Gulch_TeleportTrainToCanyon_Shared(1)
  StreamZones(nil, "Lab_v2")
  FTL_Gulch_TeleportTrainToCanyon_Shared(2, toonConnectorState)
  FTL_Gulch_LabSetup()
  UnrestrictCutSceneInput()
  return 
end
FTL_Gulch_GP_Training = function(reg_0, reg_1)
end

