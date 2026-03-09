AUT_testMetal = function()
  GiveScrapMetal(25)
  Display(GetPlayer(), "25 SCRAP FOR YOU!", 2)
  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* 25 SCRAP FOR YOU!")
  return 
end
AUT_v2_HardLoad = function()
  Print("*_**_*_*_**_**_*_*_**_*_*_**_*_**_*_*_**_*_*_* Second visit debug scripts activated! Setting variables")
  SetGlobal("Autotopia_Core_Progression", 1)
  SetGlobal("EM2_EpisodeCheck", 4)
  SetGlobal("Autotopia_Siphon01", 2)
  SetGlobal("Autotopia_Siphon02", 2)
  SetGlobal("Autotopia_Siphon03", 2)
  SetGlobal("Autotopia_Core_State", 2)
  SetGlobal("AUT_QuestHealth", 0)
  AddCurrency("ScrapMetal", 100)
  AUT_Zone_Loaded(GetPlayer(), "A")
  AUT_Setup_ZoneA_Geysers()
  AUT_SetupZoneA_Tower()
  AUT_SetupGuardianPool("AUT_GuardianPoolArea01")
  AUT_EnterAutotopia()
  return 
end
AUT_DumpMenu_HardLoad_v2 = function()
  StreamZones(GetPlayer(), "Main_Visit2.part")
  AUT_SaveCheckpoint("Projector")
  return 
end
local AUT_GildaUnrestrictFlag = 0
local AUT_StuffusShowsCarFlag = 0
CameraDebug01 = function()
  MoveToEntity("GildaRacer", "GildaCarPositionMarker 01")
  SetCameraAttributesForPlayer("GildaRace_Marker(CameraOverride) 01", nil)
  MoveToEntity("Gilda", "GildaPositionMarker 01")
  return 
end
CameraDebug02 = function()
  SetCameraAttributesForPlayer("GildaRace_Marker(CameraOverride) 02", nil)
  return 
end
GildaReturnTest01 = function()
  SplineFollower_TeleportToKnot("GildaRace_SplineFollower 01", "tcy_autotopia_02a_race.SplineKnot 17")
  MoveToEntity("GildaRacer", "tcy_autotopia_02a_race.SplineKnot 17")
  SetParent("GildaRacer", "GildaRace_SplineFollower 01")
  MoveToEntity("Gilda", "GildaRacer_PositionMarker 01")
  SetParent("Gilda", "GildaRace_SplineFollower 01")
  wait(0.10000000149011612)
  SetSplineFollowerInitialSpeed("GildaRace_SplineFollower 01", 16)
  SetPropertyInt("Gilda", "Collision Layer", 13)
  DisableMotion("Gilda")
  DriveMotionWithPhysics("Gilda")
  AI_SetDisabled("Gilda", true)
  return 
end
AUT_GildaIntroCam = function(target, sknot, camera, beat)
  FireUser1(camera)
  wait(beat)
  SplineFollower_TeleportToKnot("GildaRace_SplineFollower 01", sknot)
  MoveToEntity("GildaRacer", sknot)
  SetParent("GildaRacer", "GildaRace_SplineFollower 01")
  ZeroCharacterVelocity("Gilda")
  local targetPos = GetPosition("GildaRacer_PositionMarker 01")
  SetTransformation("Gilda", vector4(targetPos.x, targetPos.y, targetPos.z), vector4(0, 0, 0))
  SetParent("Gilda", "GildaRace_SplineFollower 01")
  AudioPostEventOn(GetPlayer(), ("Play_sfx_" .. camera))
  SetPropertyInt("Gilda", "Collision Layer", 13)
  DisableMotion("Gilda")
  DriveMotionWithPhysics("Gilda")
  AI_SetDisabled("Gilda", true)
  wait(0.10000000149011612)
  SetSplineFollowerInitialSpeed("GildaRace_SplineFollower 01", 18)
  return 
end
Setup_TimeTrial_debug = function()
  SetGlobal("Autotopia_Core_State", 1)
  SetGlobal("Autotopia_Core_Progression", 2)
  SetGlobal("Autotopia_Garage_Opened", 1)
  SetGlobal("EM2_EpisodeCheck", 4)
  SetGlobal("Autotopia_Siphon01", 1)
  SetGlobal("Autotopia_Siphon02", 1)
  SetGlobal("Autotopia_Siphon03", 1)
  return 
end
Setup_Derby_debug = function()
  SetGlobal("Autotopia_Core_State", 2)
  SetGlobal("Autotopia_Core_Progression", 3)
  SetGlobal("Autotopia_Garage_Opened", 1)
  SetGlobal("EM2_EpisodeCheck", 4)
  SetGlobal("Autotopia_Siphon01", 2)
  SetGlobal("Autotopia_Siphon02", 2)
  SetGlobal("Autotopia_Siphon03", 2)
  return 
end
AUT_PiratesStreamed = function()
  if (GetGlobal("OST_Moody_Destination") ~= 5) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* nuking pirates!!")
    DestroyEntity("Moody")
    DestroyEntity("Rigger Greene")
  end
  return 
end
AUT_CarIgnition = 0
AUT_PlayerInCar = 0
VehicleSetup = function(hCharacterHandle, szVehicleName, szMarkerName, isAIPlayer)
  SetPropertyInt(hCharacterHandle, "Collision Layer", 13)
  DisableMotion(hCharacterHandle)
  DriveMotionWithPhysics(hCharacterHandle)
  MoveToEntity(hCharacterHandle, szVehicleName)
  ZeroCharacterVelocity(hCharacterHandle)
  SetParentEntity(hCharacterHandle, szVehicleName)
  IncrementAllAbilitiesDisabled(hCharacterHandle)
  if (isAIPlayer == true) then
    Print("**************WTF just go into your proper animation!*************")
    AI_SetDisabled(hCharacterHandle, true)
    AnimEvent(hCharacterHandle, EVENT_Start_Driving_Shotgun_Idle)
  else
    AnimEvent(hCharacterHandle, EVENT_Start_Driving_Idle)
  end
  return 
end
VehicleShutdown = function(hCharacterHandle, szVehicleName, isAIPlayer)
  EnableMotion(hCharacterHandle)
  ClearParent(hCharacterHandle)
  ResetCharacterVelocityAndRotation(hCharacterHandle)
  FallFromAir(hCharacterHandle)
  DecrementAllAbilitiesDisabled(hCharacterHandle)
  if (isAIPlayer == true) then
    SetPropertyInt(hCharacterHandle, "Collision Layer", 30)
    AI_SetDisabled(hCharacterHandle, false)
  else
    SetPropertyInt(hCharacterHandle, "Collision Layer", 3)
  end
  AnimEvent(hCharacterHandle, EVENT_Force_Idle)
  return 
end
atCar_Ignition = function()
  AUT_PlayerInCar = 1
  HideReticleOnly()
  SetTrackRunnerTriggerEnabled(false)
  wait(0.10000000149011612)
  local mickey_player = GetPlayer()
  local oswald = GetPlayerOrAI(PLAYER_TWO)
  local bIsOwaldAHuman = (not IsPlayerAIControlled(PLAYER_TWO))
  VehicleSetup(mickey_player, "PhysMotor01", "PositionMarker 01", false)
  if (bIsOwaldAHuman == true) then
    VehicleSetup(oswald, "PhysMotor02", "PositionMarker 02", false)
  else
    VehicleSetup(oswald, "PhysMotor01", "PositionMarker 01", true)
    MoveToEntity("PhysMotor02", "PlayerCars_SafeLoc 02")
  end
  HidePlayerTool(PLAYER_ONE)
  HidePlayerTool(PLAYER_TWO)
  wait(0.10000000149011612)
  StartDriving("PhysMotor01", PLAYER_ONE)
  if (bIsOwaldAHuman == true) then
    StartDriving("PhysMotor02", PLAYER_TWO)
  end
  StartEmitters("CarExhaust")
  Unhide("CarNitro")
  StartEmitters("CarExhaust 02")
  Unhide("CarNitro 02")
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* atCar_Ignition calls StartFadeIn!")
  StartFadeIn(0.5)
  return 
end
AUT_GetOut_ofCar = function()
  Print((((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GetOut_ofCar called! (button to exit the car was pressed); AUT_PlayerInCar == " .. AUT_PlayerInCar) .. "; AUT_Race_PracticeFlag == ") .. GetGlobal("AUT_Race_PracticeFlag")) .. "!"))
  if (AUT_PlayerInCar == 1) then
    if (GetGlobal("AUT_Race_PracticeFlag") ~= 1) then
      AUT_PlayerInCar = 2
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GetOut_ofCar fires sequence AUT_Gus_ExitCar!")
      ForceSequence("Marker(Conversation) Gus 01", "AUT_Gus_ExitCar")
    end
  elseif (AUT_PlayerInCar == 1) then
    if (GetGlobal("AUT_Race_PracticeFlag") == 1) then
      AUT_PlayerInCar = 2
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GetOut_ofCar fires sequence AUT_v2_Gus_DonePractice!")
      ForceSequence("Marker(Conversation) Gus 01", "AUT_v2_Gus_DonePractice")
    end
  end
  return 
end
AUT_ExitCar_CleanUp = function()
  FireThread(AUT_Cleanup_Thread)
  return 
end
AUT_Cleanup_Thread = function()
  wait(1)
  AUT_PlayerInCar = 1
  return 
end
AUT_GetOut_Confirm = function()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GetOut_Confirm called!")
  local CurrentLevel = LevelManager_GetCurrentState()
  Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GetOut_Confirm finds CurrentLevel is " .. CurrentLevel) .. "!"))
  if (CurrentLevel == "tcy_autotopia_visit1.visit2_derbyactive") then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GetOut_Confirm finds CurrentLevel is actual race!! Will load back to AUTv2 proper. Calling StartFadeOut")
    StartFadeOut(0.5)
    wait(0.5)
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GetOut_Confirm calls AUT_EjectPlayers!")
    AUT_EjectPlayers()
    SetGlobal("AUT_Race_PracticeFlag", 3)
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GetOut_Confirm sets AUT_Race_PracticeFlag = 3!")
    if (GetGlobal("Autotopia_Core_Progression") == 3) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GetOut_Confirm finds Autotopia_Core_Progression == 3; LOADS TCY_autotopia_visit1.SectionA_derby!")
      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
    else
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_GetOut_Confirm finds Autotopia_Core_Progression ~= 3; LOADS TCY_autotopia_visit1.SectionA_trial!")
      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
    end
  end
  return 
end
AUT_EndPractice_Confirm = function()
  StartFadeOut(0.5)
  AUT_PlayerInCar = 1
  wait(0.5)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_EndPractice_Confirm called; calls StartFadeOut; calls AUT_EjectPlayers")
  AUT_EjectPlayers()
  MoveToEntity(GetPlayer(), "PlayerRaceLinePositionMarker 01")
  MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "PlayerRaceLinePositionMarker 07")
  SetGlobal("AUT_Race_PracticeFlag", 0)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_EndPractice_Confirm sets AUT_Race_PracticeFlag = 0; fires sequence AUT_Stuffus_StartRace")
  RestrictCutSceneInput()
  AUT_MoveAI_OswaldToStuffus()
  StartFadeIn(0.5)
  wait(0.5)
  ForceSequence("Stuffus", "AUT_Stuffus_RaceContinue", 1)
  return 
end
AUT_VehicleExit = function()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_VehicleExit called!")
  if (1 < GetGlobal("Autotopia_Core_Progression")) then
    AUT_HornShutDown()
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_VehicleExit calls StartFadeOut!")
    StartFadeOut(0.5)
    wait(0.5)
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_VehicleExit calls AUT_EjectPlayers!")
    AUT_EjectPlayers()
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_VehicleExit calls StartFadeIn!")
    StartFadeIn(0.5)
    ClearCameraAttributesForPlayer("RaceCamera_Marker(CameraOverride) 01", nil)
    MoveToEntity(GetPlayer(), "ExitVehicle_PlayerPositionMarker 01")
    MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "ExitVehicle_PlayerPositionMarker 02")
    AUT_RestorePlayerCars()
    if (AUT_RaceActive == 0) then
      if (GetGlobal("Autotopia_Core_State") == 1) then
        StreamZones(GetPlayer(), "SectionA_trial.part")
      else
        StreamZones(GetPlayer(), "SectionA_derby.part")
      end
      FireUser1("exitVehicleCam")
    end
  end
  return 
end
AUT_EjectPlayers = function()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_EjectPlayers called!")
  Hide("CarNitro")
  Hide("CarNitro 02")
  local mickey_player = GetPlayer()
  local oswald = GetPlayerOrAI(PLAYER_TWO)
  local bIsOwaldAHuman = (not IsPlayerAIControlled(PLAYER_TWO))
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_EjectPlayers calls VehicleShutdown - Mickey")
  VehicleShutdown(mickey_player, "PhysMotor01", false)
  if (bIsOwaldAHuman == true) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_EjectPlayers calls VehicleShutdown - Oswald Player - Vehicle 02")
    VehicleShutdown(oswald, "PhysMotor02", false)
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_EjectPlayers calls VehicleShutdown - Oswald AI - Vehicle 01")
    VehicleShutdown(oswald, "PhysMotor01", true)
  end
  UnhidePlayerTool(PLAYER_ONE)
  UnhidePlayerTool(PLAYER_TWO)
  SetTrackRunnerTriggerEnabled(true)
  wait(0.10000000149011612)
  StopDriving("PhysMotor01")
  if (bIsOwaldAHuman == true) then
    StopDriving("PhysMotor02")
  end
  AUT_PlayerInCar = 0
  StopEmitters("CarExhaust")
  StopEmitters("CarExhaust 02")
  return 
end
AUT_QuickEject = function()
  AUT_EjectPlayers()
  ClearCameraAttributesForPlayer("RaceCamera_Marker(CameraOverride) 01", nil)
  MoveToEntity(GetPlayer(), "ExitVehicle_PlayerPositionMarker 01")
  MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "ExitVehicle_PlayerPositionMarker 02")
  AUT_RestorePlayerCars()
  if (atCar_HornOn == 1) then
    atCar_HornOn = 0
    AudioPostEventOn(GetPlayer(), "Stop_SFX_Veh_Mickey_Horn")
  end
  return 
end
AUT_GetTires = function()
  local tireAmt = (GetGlobal("Autotopia_CarTireTot") + 1)
  SetGlobal("Autotopia_CarTireTot", tireAmt)
  SaveCheckpointNoPosition(nil, "AUT_AlwaysSetup")
  return 
end
AUT_GetEngine = function()
  SetGlobal("Autotopia_QuestEngine", 1)
  return 
end
AUT_StuffusFixAutotopia = function(target, phase)
  if (phase == 1) then
    StartFadeOut(0.5)
    RestrictCutSceneInput()
    SetGlobal("Autotopia_PlayerCar", 0)
    if (GetGlobal("Autotopia_Core_State") == 1) then
      StreamZones(GetPlayer(), "SectionE_trial.part")
    elseif (GetGlobal("Autotopia_Core_State") == 2) then
      StreamZones(GetPlayer(), "SectionE_derby.part")
      if (phase == "2") then
        if (GetGlobal("Autotopia_Core_Progression") == 1) then
          if (GetGlobal("Autotopia_Core_State") == 2) then
            Unhide("StuffusFixesTarget")
          end
          FireUser1("Stuffus_FixRace_Camera")
          wait(1.5)
          MoveToEntity("Stuffus", "Stuffus_FixRace_PositionMarker 01")
          AnimVarInt("Stuffus", VAR_Cutscene, 1)
          AnimEvent("Stuffus", EVENT_Start_Cutscene)
          AUT_Zone_Loaded(GetPlayer(), "E")
          ForceSequence("Stuffus", "AUT_Stuffus_FixedAutotopia")
        end
      elseif (phase == 3) then
        TeleportGremlinToEntity("Stuffus", "StuffusToGarage_PositionMarker 01")
        AUT_SaveCheckpoint("Garage")
      elseif (phase == 4) then
        if (GetGlobal("Autotopia_Core_State") == 2) then
          Hide("StuffusFixesTarget")
        end
      else
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_StuffusFixAutotopia() CALLED but could not activate!")
      end
    end
  elseif (phase == "2") then
    if (GetGlobal("Autotopia_Core_Progression") == 1) then
      if (GetGlobal("Autotopia_Core_State") == 2) then
        Unhide("StuffusFixesTarget")
      end
      FireUser1("Stuffus_FixRace_Camera")
      wait(1.5)
      MoveToEntity("Stuffus", "Stuffus_FixRace_PositionMarker 01")
      AnimVarInt("Stuffus", VAR_Cutscene, 1)
      AnimEvent("Stuffus", EVENT_Start_Cutscene)
      AUT_Zone_Loaded(GetPlayer(), "E")
      ForceSequence("Stuffus", "AUT_Stuffus_FixedAutotopia")
    end
  elseif (phase == 3) then
    TeleportGremlinToEntity("Stuffus", "StuffusToGarage_PositionMarker 01")
    AUT_SaveCheckpoint("Garage")
  elseif (phase == 4) then
    if (GetGlobal("Autotopia_Core_State") == 2) then
      Hide("StuffusFixesTarget")
    end
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_StuffusFixAutotopia() CALLED but could not activate!")
  end
  return 
end
AUT_PlayIntroSetup = 0
AUT_StuffusRepairCarCheck = function()
  SetGlobal("AUT_LogicCheck", AUT_StuffusShowsCarFlag)
  if (AUT_StuffusShowsCarFlag == 0) then
    AUT_StuffusShowsCarFlag = 1
  end
  return 
end
AUT_StuffusRepairCar = function()
  StartFadeOut(0.5)
  wait(0.5)
  local wrench = GetChildEntityByName("Stuffus", "GremlinWrench")
  MoveToEntity("PhysMotor01", "StuffusCutscene_CarPositionMarker 01")
  MoveToEntity("PhysMotor02", "StuffusCutscene_CarPositionMarker 02")
  MoveToEntity("Stuffus", "tcy_autotopia_02a.StuffusFixCar_PositionMarker 01")
  AnimVarInt("Stuffus", VAR_Cutscene, 1)
  AnimEvent("Stuffus", EVENT_Start_Cutscene)
  FireUser1("GremlinRepairsCarsCam01")
  wait(7)
  StartFadeOut(0.5)
  wait(0.5)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_StuffusRepairCar fires UnrestrictCutSceneInput()")
  UnrestrictCutSceneInput()
  EnableSplitScreen(true)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_StuffusRepairCar fires AUT_LoadRace()")
  AUT_LoadRace()
  return 
end
AUT_StreamRace = function()
  if (GetGlobal("Autotopia_Core_Progression") == 3) then
    StreamZones(GetPlayer(), "Visit2_DerbyActive.part")
  else
    StreamZones(GetPlayer(), "Visit2_TrialActive.part")
  end
  return 
end
AUT_LoadRace = function()
  local CurrentLevel = LevelManager_GetCurrentState()
  Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LoadRace called; CurrentLevel is set as: " .. CurrentLevel) .. " "))
  if (CurrentLevel == "tcy_autotopia_visit1.visit2_derbyactive") then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LoadRace finds we are already in a race zone; calling AUT_RaceStreamed")
    AUT_RaceStreamed("SlowFade")
  end
  if (GetGlobal("Autotopia_Core_Progression") == 3) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LoadRace finds we are not in a race zone; Autotopia_Core_Progression == 3; Load into Derby!")
    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Visit2_DerbyActive")
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LoadRace finds we are not in a race zone; Autotopia_Core_Progression ~= 3; Load into Trial!")
    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Visit2_TrialActive")
  end
  return 
end
AUT_RaceStreamed = function(skipVal)
  if (skipVal ~= "SlowFade") then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RaceStreamed called by OnMapLoadOrStream, immediate FadeOut!")
    StartFadeOut(0)
    MusicPostEventOn(GetPlayer(), "Play_MX_AUT")
    RemoveAllMusicStateOverride()
    Print("Started AUT music event from AUT_RaceStreamed")
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RaceStreamed called by LUA script, Slow FadeOut!")
    StartFadeOut(0.5)
    wait(0.5)
  end
  if (GetGlobal("Autotopia_Core_State") == 1) then
    SetPropertyFloat("ControlTowerGeyser1", "CurrentPlaystyle", 1)
    SetPropertyFloat("ControlTowerGeyser2", "CurrentPlaystyle", 1)
    SetPropertyFloat("ControlTowerGeyser3", "CurrentPlaystyle", 1)
    SetPropertyFloat("ControlTowerGeyser4", "CurrentPlaystyle", 1)
  end
  Print((((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RaceStreamed called; AUT_Race_PracticeFlag ==  " .. GetGlobal("AUT_Race_PracticeFlag")) .. "; Autotopia_RaceState ==  ") .. GetGlobal("Autotopia_RaceState")) .. "!!"))
  if (GetGlobal("AUT_Race_PracticeFlag") == 1) then
    if (GetGlobal("Autotopia_RaceState") ~= -1) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RaceStreamed finds Autotopia_RaceState ~= -1; calls StartFadeOut(0.5); calls UnrestrictCutSceneInput to allow for practice.")
      UnrestrictCutSceneInput()
    end
  end
  if (GetGlobal("Autotopia_RaceState") == -1) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RaceStreamed called! Autotopia_RaceState == -1 or AUT_Race_PracticeFlag == 1, defaulting to initial practice, setting AUT_Race_PracticeFlag to 1")
    SetGlobal("AUT_Race_PracticeFlag", 1)
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RaceStreamed calls AUT_RacesFire")
    AUT_RacesFire()
  end
  local IntroPhase = (GetGlobal("Autotopia_RaceState") + 1)
  Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RaceStreamed in standard racing mode, Autotopia_RaceState is set to " .. IntroPhase) .. ". Calling AUT_ShowGildaIntro"))
  MoveToEntity("PhysMotor01", "PlayerCars_SafeLoc 01")
  MoveToEntity("PhysMotor02", "PlayerCars_SafeLoc 02")
  AUT_ShowGildaIntro(IntroPhase)
  return 
end
AUT_RacesFire = function()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RacesFire called!")
  if (LevelManager_GetCurrentState() == "tcy_autotopia_visit1.visit2_derbyactive") then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RacesFire setting up derby (in visit2_derbyactive state)!")
    GiveQuestItems("Auto_Derby_Target", (-GetCurrentCount("Auto_Derby_Target")))
    ForEachEntityInGroup(Hide, "Derby01Obstacle")
    ForEachEntityInGroup(Hide, "Derby02Obstacle")
    ForEachEntityInGroup(Hide, "Derby03Obstacle")
    ForEachEntityInGroup(Hide, "Derby04Obstacle")
  end
  if (GetGlobal("Autotopia_RaceState") == -1) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RacesFire detects that Autotopia_RaceState == -1 or AUT_Race_PracticeFlag == 1; starting up car Practice")
    AUT_CarIgnition = 1
    AUT_PlayIntroSetup = 2
    TeleportGremlinToEntity("Stuffus", "StuffusRaceLinePositionMarker 01")
    MoveToEntity("TrophyCar", "Trophy_CarMarker(Rotatable) 01")
    SetParent("TrophyCar", "Trophy_CarMarker(Rotatable) 01")
    Hide("TrophyCar")
    SetGlobal("Autotopia_PlayerCar", 1)
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RacesFire calling AUT_InitiateRace!")
    AUT_InitiateRace()
  end
  if (GetGlobal("Autotopia_RaceState") == 0) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RacesFire detects that Autotopia_RaceState == 0; starting up first race! AUT_Ready_toRace - forward")
    AUT_Ready_toRace("forward")
  elseif (GetGlobal("Autotopia_RaceState") == 1) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RacesFire detects that Autotopia_RaceState == 1; starting up second race! AUT_Ready_toRace - forward")
    AUT_Ready_toRace("forward")
  elseif (GetGlobal("Autotopia_RaceState") == 2) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RacesFire detects that Autotopia_RaceState == 0; starting up third race! AUT_Ready_toRace - reverse")
    AUT_Ready_toRace("reverse")
  elseif (GetGlobal("Autotopia_RaceState") == 3) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RacesFire detects that Autotopia_RaceState == 0; setting up practice finale race! AUT_Ready_toRace - reverse")
    AUT_Ready_toRace("reverse")
  end
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RacesFire calls StartFadeIn(0.5)")
  StartFadeIn(0.5)
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
  if (AUT_GildaUnrestrictFlag == 1) then
    AUT_GildaUnrestrictFlag = 0
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_RacesFire calls UnrestrictCutsceneInput()")
    UnrestrictCutSceneInput()
  end
  wait(0.5)
  if (AUT_PlayIntroSetup == 2) then
    AUT_PlayIntroSetup = 0
    Wait(0.10000000149011612)
    FireSequence("Marker(Conversation) Gus 01", "Tutorial_Driving1Training")
  end
  return 
end
AUT_MoveAI_OswaldToStuffus = function()
  local bIsOwaldAHuman = (not IsPlayerAIControlled(PLAYER_TWO))
  if (bIsOwaldAHuman == false) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_MoveAI_OswaldToStuffus finds Oswald is AI controlled!")
    MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "PlayerRaceLinePositionMarker 07")
  end
  return 
end
AUT_InitiateRace = function()
  MoveToEntity("PhysMotor01", "tcy_autotopia_02a.RaceStart_AutoPositionMarkerFwd 01")
  local bIsOwaldAHuman = (not IsPlayerAIControlled(PLAYER_TWO))
  if (bIsOwaldAHuman == true) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_InitiateRace finds Oswald is player controlled!")
    MoveToEntity("PhysMotor02", "tcy_autotopia_02a.RaceStart_AutoPositionMarkerFwd 02")
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_InitiateRace finds Oswald is AI controlled!")
    MoveToEntity("PhysMotor02", "GildaCarPositionMarker 06")
  end
  wait(0.009999999776482582)
  atCar_Ignition()
  return 
end
AUT_Ready_toRace = function(direction)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_Ready_toRace called!")
  wait(4)
  SetCameraAttributesForPlayer("RaceCamera_Marker(CameraOverride) 01", nil)
  MoveToEntity("GildaRacer", "GildaCarPositionMarker 03")
  Unhide("Gilda")
  SetParent("GildaRacer", "GildaCarPositionMarker 03")
  MoveToEntity("Gilda", "GildaCarPositionMarker 04")
  OswaldStopFollowAction()
  local bIsOwaldAHuman = (not IsPlayerAIControlled(PLAYER_TWO))
  if bIsOwaldAHuman then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_Ready_toRace finds Oswald is player controlled!")
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_Ready_toRace finds Oswald is AI controlled!")
  end
  if (direction == "forward") then
    MoveToEntity("PhysMotor01", "tcy_autotopia_02a.RaceStart_AutoPositionMarkerFwd 01")
    if (bIsOwaldAHuman == true) then
      MoveToEntity("PhysMotor02", "tcy_autotopia_02a.RaceStart_AutoPositionMarkerFwd 02")
    end
  else
    MoveToEntity("PhysMotor01", "tcy_autotopia_02a.RaceStart_AutoPositionMarkerBck 01")
    if (bIsOwaldAHuman == true) then
      MoveToEntity("PhysMotor02", "tcy_autotopia_02a.RaceStart_AutoPositionMarkerBck 02")
    end
  end
  if (bIsOwaldAHuman == false) then
    MoveToEntity("PhysMotor02", "GildaCarPositionMarker 06")
  end
  atCar_Ignition()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_Ready_toRace calls RestrictCutSceneInput()!")
  RestrictCutSceneInput()
  AUT_LastRaceTag = 1
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_Ready_toRace fires sequence AUT_Stuffus_RaceCountDown!")
  ForceSequence("Stuffus", "AUT_Stuffus_RaceCountDown")
  if (GetGlobal("AUT_Stuffus_RepairOffered") == 0) then
    if (GetGlobal("Autotopia_Garage_Opened") == 2) then
      SetGlobal("AUT_Stuffus_RepairOffered", 1)
    end
  end
  return 
end
AUT_LastRaceTag = 1
AUT_PlayerHitsLap = function(target, carIdent)
  Print(GetPlayer(), (((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsLap called - Autotopia_RaceState set to " .. GetGlobal("Autotopia_RaceState")) .. ". AUT_RaceActive set to ") .. AUT_RaceActive) .. ". "))
  if (AUT_RaceActive < 7) then
    if (GetGlobal("Autotopia_RaceState") == 0) then
      if (AUT_LastRaceTag == 2) then
        if (AUT_RaceActive == 1) then
          if (GetGlobal("Autotopia_Core_Progression") == 3) then
            ForEachEntityInGroup(Unhide, "Derby02Obstacle")
            AUT_RaceActive = 2
            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsLap unhides Derby Obstacles for Race 01 - Lap 01; AUT_RaceActive = 2")
          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsLap calls AUT_TimeTrialFinish for Race 01 - Lap 01 complete!")
            AUT_TimeTrialFinish(carIdent)
            if (AUT_RaceActive == 2) then
              if (GetGlobal("Autotopia_Core_Progression") == 3) then
                ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsLap unhides Derby Obstacles for Race 01 - Lap 02; AUT_RaceActive remains 2")
                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                  ForceSpawn("RaceNitroSpawner 02", 1)
                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsLap unhides Nitro Boosts for Race 01 - Lap 02; AUT_RaceActive remains 2")
                  if (AUT_RaceActive < 7) then
                    if (GetGlobal("Autotopia_RaceState") == 1) then
                      if (AUT_LastRaceTag == 2) then
                        if (AUT_RaceActive == 1) then
                          if (GetGlobal("Autotopia_Core_Progression") == 3) then
                            ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                              ForceSpawn("RaceNitroSpawner 02", 1)
                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                Display(GetPlayer(), "One more lap!!", 2)
                                AUT_RaceActive = 2
                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                  if (AUT_RaceActive == 2) then
                                    if (GetGlobal("Autotopia_Core_Progression") ~= 3) then
                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                        AUT_TimeTrialFinish(carIdent)
                                        if (AUT_RaceActive < 7) then
                                          if (GetGlobal("Autotopia_RaceState") == 2) then
                                            if (AUT_LastRaceTag == 3) then
                                              if (AUT_RaceActive == 1) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      Display(GetPlayer(), "One more lap!!", 2)
                                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                                      end
                                                      AUT_RaceActive = 2
                                                      if (AUT_RaceActive == 2) then
                                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                          AUT_TimeTrialFinish(carIdent)
                                                          if (AUT_RaceActive < 7) then
                                                            if (GetGlobal("Autotopia_RaceState") == 3) then
                                                              if (AUT_LastRaceTag == 3) then
                                                                if (AUT_RaceActive == 1) then
                                                                  if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                                    ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                        Display(GetPlayer(), "One more lap!!", 2)
                                                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                                                        end
                                                                        AUT_RaceActive = 2
                                                                        if (AUT_RaceActive == 2) then
                                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                            AUT_TimeTrialFinish(carIdent)
                                                                            if (AUT_RaceActive ~= 7) then
                                                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                            end
                                                                          end
                                                                        end
                                                                      end
                                                                    end
                                                                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                    Display(GetPlayer(), "One more lap!!", 2)
                                                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                                                    end
                                                                    AUT_RaceActive = 2
                                                                    if (AUT_RaceActive == 2) then
                                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                        AUT_TimeTrialFinish(carIdent)
                                                                        if (AUT_RaceActive ~= 7) then
                                                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                elseif (AUT_RaceActive == 2) then
                                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                    AUT_TimeTrialFinish(carIdent)
                                                                    if (AUT_RaceActive ~= 7) then
                                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          elseif (AUT_RaceActive ~= 7) then
                                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  Display(GetPlayer(), "One more lap!!", 2)
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                  end
                                                  AUT_RaceActive = 2
                                                  if (AUT_RaceActive == 2) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      AUT_TimeTrialFinish(carIdent)
                                                      if (AUT_RaceActive < 7) then
                                                        if (GetGlobal("Autotopia_RaceState") == 3) then
                                                          if (AUT_LastRaceTag == 3) then
                                                            if (AUT_RaceActive == 1) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                                ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                    Display(GetPlayer(), "One more lap!!", 2)
                                                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                                                    end
                                                                    AUT_RaceActive = 2
                                                                    if (AUT_RaceActive == 2) then
                                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                        AUT_TimeTrialFinish(carIdent)
                                                                        if (AUT_RaceActive ~= 7) then
                                                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                Display(GetPlayer(), "One more lap!!", 2)
                                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                                end
                                                                AUT_RaceActive = 2
                                                                if (AUT_RaceActive == 2) then
                                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                    AUT_TimeTrialFinish(carIdent)
                                                                    if (AUT_RaceActive ~= 7) then
                                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            elseif (AUT_RaceActive == 2) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                AUT_TimeTrialFinish(carIdent)
                                                                if (AUT_RaceActive ~= 7) then
                                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      elseif (AUT_RaceActive ~= 7) then
                                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                      end
                                                    end
                                                  end
                                                end
                                              elseif (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive < 7) then
                                                    if (GetGlobal("Autotopia_RaceState") == 3) then
                                                      if (AUT_LastRaceTag == 3) then
                                                        if (AUT_RaceActive == 1) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                            ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                Display(GetPlayer(), "One more lap!!", 2)
                                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                                end
                                                                AUT_RaceActive = 2
                                                                if (AUT_RaceActive == 2) then
                                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                    AUT_TimeTrialFinish(carIdent)
                                                                    if (AUT_RaceActive ~= 7) then
                                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            Display(GetPlayer(), "One more lap!!", 2)
                                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                                            end
                                                            AUT_RaceActive = 2
                                                            if (AUT_RaceActive == 2) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                AUT_TimeTrialFinish(carIdent)
                                                                if (AUT_RaceActive ~= 7) then
                                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                end
                                                              end
                                                            end
                                                          end
                                                        elseif (AUT_RaceActive == 2) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            AUT_TimeTrialFinish(carIdent)
                                                            if (AUT_RaceActive ~= 7) then
                                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  elseif (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        elseif (AUT_RaceActive < 7) then
                                          if (GetGlobal("Autotopia_RaceState") == 3) then
                                            if (AUT_LastRaceTag == 3) then
                                              if (AUT_RaceActive == 1) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                  ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      Display(GetPlayer(), "One more lap!!", 2)
                                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                                      end
                                                      AUT_RaceActive = 2
                                                      if (AUT_RaceActive == 2) then
                                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                          AUT_TimeTrialFinish(carIdent)
                                                          if (AUT_RaceActive ~= 7) then
                                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  Display(GetPlayer(), "One more lap!!", 2)
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                  end
                                                  AUT_RaceActive = 2
                                                  if (AUT_RaceActive == 2) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      AUT_TimeTrialFinish(carIdent)
                                                      if (AUT_RaceActive ~= 7) then
                                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                      end
                                                    end
                                                  end
                                                end
                                              elseif (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        elseif (AUT_RaceActive ~= 7) then
                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            Display(GetPlayer(), "One more lap!!", 2)
                            AUT_RaceActive = 2
                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                              ForceSpawn("RaceNitroSpawner 02", 1)
                              if (AUT_RaceActive == 2) then
                                if (GetGlobal("Autotopia_Core_Progression") ~= 3) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    AUT_TimeTrialFinish(carIdent)
                                    if (AUT_RaceActive < 7) then
                                      if (GetGlobal("Autotopia_RaceState") == 2) then
                                        if (AUT_LastRaceTag == 3) then
                                          if (AUT_RaceActive == 1) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  Display(GetPlayer(), "One more lap!!", 2)
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                  end
                                                  AUT_RaceActive = 2
                                                  if (AUT_RaceActive == 2) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      AUT_TimeTrialFinish(carIdent)
                                                      if (AUT_RaceActive < 7) then
                                                        if (GetGlobal("Autotopia_RaceState") == 3) then
                                                          if (AUT_LastRaceTag == 3) then
                                                            if (AUT_RaceActive == 1) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                                ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                    Display(GetPlayer(), "One more lap!!", 2)
                                                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                                                    end
                                                                    AUT_RaceActive = 2
                                                                    if (AUT_RaceActive == 2) then
                                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                        AUT_TimeTrialFinish(carIdent)
                                                                        if (AUT_RaceActive ~= 7) then
                                                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                Display(GetPlayer(), "One more lap!!", 2)
                                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                                end
                                                                AUT_RaceActive = 2
                                                                if (AUT_RaceActive == 2) then
                                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                    AUT_TimeTrialFinish(carIdent)
                                                                    if (AUT_RaceActive ~= 7) then
                                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            elseif (AUT_RaceActive == 2) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                AUT_TimeTrialFinish(carIdent)
                                                                if (AUT_RaceActive ~= 7) then
                                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      elseif (AUT_RaceActive ~= 7) then
                                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              Display(GetPlayer(), "One more lap!!", 2)
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                              end
                                              AUT_RaceActive = 2
                                              if (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive < 7) then
                                                    if (GetGlobal("Autotopia_RaceState") == 3) then
                                                      if (AUT_LastRaceTag == 3) then
                                                        if (AUT_RaceActive == 1) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                            ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                Display(GetPlayer(), "One more lap!!", 2)
                                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                                end
                                                                AUT_RaceActive = 2
                                                                if (AUT_RaceActive == 2) then
                                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                    AUT_TimeTrialFinish(carIdent)
                                                                    if (AUT_RaceActive ~= 7) then
                                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            Display(GetPlayer(), "One more lap!!", 2)
                                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                                            end
                                                            AUT_RaceActive = 2
                                                            if (AUT_RaceActive == 2) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                AUT_TimeTrialFinish(carIdent)
                                                                if (AUT_RaceActive ~= 7) then
                                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                end
                                                              end
                                                            end
                                                          end
                                                        elseif (AUT_RaceActive == 2) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            AUT_TimeTrialFinish(carIdent)
                                                            if (AUT_RaceActive ~= 7) then
                                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  elseif (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          elseif (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive < 7) then
                                                if (GetGlobal("Autotopia_RaceState") == 3) then
                                                  if (AUT_LastRaceTag == 3) then
                                                    if (AUT_RaceActive == 1) then
                                                      if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                        ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            Display(GetPlayer(), "One more lap!!", 2)
                                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                                            end
                                                            AUT_RaceActive = 2
                                                            if (AUT_RaceActive == 2) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                AUT_TimeTrialFinish(carIdent)
                                                                if (AUT_RaceActive ~= 7) then
                                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                        Display(GetPlayer(), "One more lap!!", 2)
                                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                                        end
                                                        AUT_RaceActive = 2
                                                        if (AUT_RaceActive == 2) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            AUT_TimeTrialFinish(carIdent)
                                                            if (AUT_RaceActive ~= 7) then
                                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                            end
                                                          end
                                                        end
                                                      end
                                                    elseif (AUT_RaceActive == 2) then
                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                        AUT_TimeTrialFinish(carIdent)
                                                        if (AUT_RaceActive ~= 7) then
                                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              elseif (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      end
                                    elseif (AUT_RaceActive < 7) then
                                      if (GetGlobal("Autotopia_RaceState") == 3) then
                                        if (AUT_LastRaceTag == 3) then
                                          if (AUT_RaceActive == 1) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                              ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  Display(GetPlayer(), "One more lap!!", 2)
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                  end
                                                  AUT_RaceActive = 2
                                                  if (AUT_RaceActive == 2) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      AUT_TimeTrialFinish(carIdent)
                                                      if (AUT_RaceActive ~= 7) then
                                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              Display(GetPlayer(), "One more lap!!", 2)
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                              end
                                              AUT_RaceActive = 2
                                              if (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          elseif (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      end
                                    elseif (AUT_RaceActive ~= 7) then
                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                    end
                                  end
                                end
                              end
                            end
                          end
                        elseif (AUT_RaceActive == 2) then
                          if (GetGlobal("Autotopia_Core_Progression") ~= 3) then
                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                              AUT_TimeTrialFinish(carIdent)
                              if (AUT_RaceActive < 7) then
                                if (GetGlobal("Autotopia_RaceState") == 2) then
                                  if (AUT_LastRaceTag == 3) then
                                    if (AUT_RaceActive == 1) then
                                      if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                            Display(GetPlayer(), "One more lap!!", 2)
                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                            end
                                            AUT_RaceActive = 2
                                            if (AUT_RaceActive == 2) then
                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                AUT_TimeTrialFinish(carIdent)
                                                if (AUT_RaceActive < 7) then
                                                  if (GetGlobal("Autotopia_RaceState") == 3) then
                                                    if (AUT_LastRaceTag == 3) then
                                                      if (AUT_RaceActive == 1) then
                                                        if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                          ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                              Display(GetPlayer(), "One more lap!!", 2)
                                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                                              end
                                                              AUT_RaceActive = 2
                                                              if (AUT_RaceActive == 2) then
                                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                  AUT_TimeTrialFinish(carIdent)
                                                                  if (AUT_RaceActive ~= 7) then
                                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          end
                                                        elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                          Display(GetPlayer(), "One more lap!!", 2)
                                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                                          end
                                                          AUT_RaceActive = 2
                                                          if (AUT_RaceActive == 2) then
                                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                              AUT_TimeTrialFinish(carIdent)
                                                              if (AUT_RaceActive ~= 7) then
                                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                              end
                                                            end
                                                          end
                                                        end
                                                      elseif (AUT_RaceActive == 2) then
                                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                          AUT_TimeTrialFinish(carIdent)
                                                          if (AUT_RaceActive ~= 7) then
                                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                elseif (AUT_RaceActive ~= 7) then
                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                end
                                              end
                                            end
                                          end
                                        end
                                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                        Display(GetPlayer(), "One more lap!!", 2)
                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                        end
                                        AUT_RaceActive = 2
                                        if (AUT_RaceActive == 2) then
                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                            AUT_TimeTrialFinish(carIdent)
                                            if (AUT_RaceActive < 7) then
                                              if (GetGlobal("Autotopia_RaceState") == 3) then
                                                if (AUT_LastRaceTag == 3) then
                                                  if (AUT_RaceActive == 1) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                      ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                          Display(GetPlayer(), "One more lap!!", 2)
                                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                                          end
                                                          AUT_RaceActive = 2
                                                          if (AUT_RaceActive == 2) then
                                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                              AUT_TimeTrialFinish(carIdent)
                                                              if (AUT_RaceActive ~= 7) then
                                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      Display(GetPlayer(), "One more lap!!", 2)
                                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                                      end
                                                      AUT_RaceActive = 2
                                                      if (AUT_RaceActive == 2) then
                                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                          AUT_TimeTrialFinish(carIdent)
                                                          if (AUT_RaceActive ~= 7) then
                                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                          end
                                                        end
                                                      end
                                                    end
                                                  elseif (AUT_RaceActive == 2) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      AUT_TimeTrialFinish(carIdent)
                                                      if (AUT_RaceActive ~= 7) then
                                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            elseif (AUT_RaceActive ~= 7) then
                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                            end
                                          end
                                        end
                                      end
                                    elseif (AUT_RaceActive == 2) then
                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                        AUT_TimeTrialFinish(carIdent)
                                        if (AUT_RaceActive < 7) then
                                          if (GetGlobal("Autotopia_RaceState") == 3) then
                                            if (AUT_LastRaceTag == 3) then
                                              if (AUT_RaceActive == 1) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                  ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      Display(GetPlayer(), "One more lap!!", 2)
                                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                                      end
                                                      AUT_RaceActive = 2
                                                      if (AUT_RaceActive == 2) then
                                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                          AUT_TimeTrialFinish(carIdent)
                                                          if (AUT_RaceActive ~= 7) then
                                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  Display(GetPlayer(), "One more lap!!", 2)
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                  end
                                                  AUT_RaceActive = 2
                                                  if (AUT_RaceActive == 2) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      AUT_TimeTrialFinish(carIdent)
                                                      if (AUT_RaceActive ~= 7) then
                                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                      end
                                                    end
                                                  end
                                                end
                                              elseif (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        elseif (AUT_RaceActive ~= 7) then
                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                        end
                                      end
                                    end
                                  end
                                end
                              elseif (AUT_RaceActive < 7) then
                                if (GetGlobal("Autotopia_RaceState") == 3) then
                                  if (AUT_LastRaceTag == 3) then
                                    if (AUT_RaceActive == 1) then
                                      if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                        ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                            Display(GetPlayer(), "One more lap!!", 2)
                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                            end
                                            AUT_RaceActive = 2
                                            if (AUT_RaceActive == 2) then
                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                AUT_TimeTrialFinish(carIdent)
                                                if (AUT_RaceActive ~= 7) then
                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                end
                                              end
                                            end
                                          end
                                        end
                                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                        Display(GetPlayer(), "One more lap!!", 2)
                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                        end
                                        AUT_RaceActive = 2
                                        if (AUT_RaceActive == 2) then
                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                            AUT_TimeTrialFinish(carIdent)
                                            if (AUT_RaceActive ~= 7) then
                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                            end
                                          end
                                        end
                                      end
                                    elseif (AUT_RaceActive == 2) then
                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                        AUT_TimeTrialFinish(carIdent)
                                        if (AUT_RaceActive ~= 7) then
                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                        end
                                      end
                                    end
                                  end
                                end
                              elseif (AUT_RaceActive ~= 7) then
                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                              end
                            end
                          end
                        end
                      end
                    end
                  elseif (AUT_RaceActive < 7) then
                    if (GetGlobal("Autotopia_RaceState") == 2) then
                      if (AUT_LastRaceTag == 3) then
                        if (AUT_RaceActive == 1) then
                          if (GetGlobal("Autotopia_Core_Progression") == 3) then
                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                              ForceSpawn("RaceNitroSpawner 02", 1)
                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                Display(GetPlayer(), "One more lap!!", 2)
                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                end
                                AUT_RaceActive = 2
                                if (AUT_RaceActive == 2) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    AUT_TimeTrialFinish(carIdent)
                                    if (AUT_RaceActive < 7) then
                                      if (GetGlobal("Autotopia_RaceState") == 3) then
                                        if (AUT_LastRaceTag == 3) then
                                          if (AUT_RaceActive == 1) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                              ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  Display(GetPlayer(), "One more lap!!", 2)
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                  end
                                                  AUT_RaceActive = 2
                                                  if (AUT_RaceActive == 2) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      AUT_TimeTrialFinish(carIdent)
                                                      if (AUT_RaceActive ~= 7) then
                                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              Display(GetPlayer(), "One more lap!!", 2)
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                              end
                                              AUT_RaceActive = 2
                                              if (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          elseif (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      end
                                    elseif (AUT_RaceActive ~= 7) then
                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                    end
                                  end
                                end
                              end
                            end
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            Display(GetPlayer(), "One more lap!!", 2)
                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                              ForceSpawn("RaceNitroSpawner 02", 1)
                            end
                            AUT_RaceActive = 2
                            if (AUT_RaceActive == 2) then
                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                AUT_TimeTrialFinish(carIdent)
                                if (AUT_RaceActive < 7) then
                                  if (GetGlobal("Autotopia_RaceState") == 3) then
                                    if (AUT_LastRaceTag == 3) then
                                      if (AUT_RaceActive == 1) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                          ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              Display(GetPlayer(), "One more lap!!", 2)
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                              end
                                              AUT_RaceActive = 2
                                              if (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          Display(GetPlayer(), "One more lap!!", 2)
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                          end
                                          AUT_RaceActive = 2
                                          if (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      elseif (AUT_RaceActive == 2) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          AUT_TimeTrialFinish(carIdent)
                                          if (AUT_RaceActive ~= 7) then
                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                          end
                                        end
                                      end
                                    end
                                  end
                                elseif (AUT_RaceActive ~= 7) then
                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                end
                              end
                            end
                          end
                        elseif (AUT_RaceActive == 2) then
                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                            AUT_TimeTrialFinish(carIdent)
                            if (AUT_RaceActive < 7) then
                              if (GetGlobal("Autotopia_RaceState") == 3) then
                                if (AUT_LastRaceTag == 3) then
                                  if (AUT_RaceActive == 1) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                      ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          Display(GetPlayer(), "One more lap!!", 2)
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                          end
                                          AUT_RaceActive = 2
                                          if (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      end
                                    elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      Display(GetPlayer(), "One more lap!!", 2)
                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                      end
                                      AUT_RaceActive = 2
                                      if (AUT_RaceActive == 2) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          AUT_TimeTrialFinish(carIdent)
                                          if (AUT_RaceActive ~= 7) then
                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                          end
                                        end
                                      end
                                    end
                                  elseif (AUT_RaceActive == 2) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      AUT_TimeTrialFinish(carIdent)
                                      if (AUT_RaceActive ~= 7) then
                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                      end
                                    end
                                  end
                                end
                              end
                            elseif (AUT_RaceActive ~= 7) then
                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                            end
                          end
                        end
                      end
                    end
                  elseif (AUT_RaceActive < 7) then
                    if (GetGlobal("Autotopia_RaceState") == 3) then
                      if (AUT_LastRaceTag == 3) then
                        if (AUT_RaceActive == 1) then
                          if (GetGlobal("Autotopia_Core_Progression") == 3) then
                            ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                              ForceSpawn("RaceNitroSpawner 02", 1)
                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                Display(GetPlayer(), "One more lap!!", 2)
                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                end
                                AUT_RaceActive = 2
                                if (AUT_RaceActive == 2) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    AUT_TimeTrialFinish(carIdent)
                                    if (AUT_RaceActive ~= 7) then
                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                    end
                                  end
                                end
                              end
                            end
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            Display(GetPlayer(), "One more lap!!", 2)
                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                              ForceSpawn("RaceNitroSpawner 02", 1)
                            end
                            AUT_RaceActive = 2
                            if (AUT_RaceActive == 2) then
                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                AUT_TimeTrialFinish(carIdent)
                                if (AUT_RaceActive ~= 7) then
                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                end
                              end
                            end
                          end
                        elseif (AUT_RaceActive == 2) then
                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                            AUT_TimeTrialFinish(carIdent)
                            if (AUT_RaceActive ~= 7) then
                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                            end
                          end
                        end
                      end
                    end
                  elseif (AUT_RaceActive ~= 7) then
                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                  end
                end
              end
            end
          end
        elseif (AUT_RaceActive == 2) then
          if (GetGlobal("Autotopia_Core_Progression") == 3) then
            ForEachEntityInGroup(Unhide, "Derby03Obstacle")
            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsLap unhides Derby Obstacles for Race 01 - Lap 02; AUT_RaceActive remains 2")
            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
              ForceSpawn("RaceNitroSpawner 02", 1)
              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsLap unhides Nitro Boosts for Race 01 - Lap 02; AUT_RaceActive remains 2")
              if (AUT_RaceActive < 7) then
                if (GetGlobal("Autotopia_RaceState") == 1) then
                  if (AUT_LastRaceTag == 2) then
                    if (AUT_RaceActive == 1) then
                      if (GetGlobal("Autotopia_Core_Progression") == 3) then
                        ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                          ForceSpawn("RaceNitroSpawner 02", 1)
                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                            Display(GetPlayer(), "One more lap!!", 2)
                            AUT_RaceActive = 2
                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                              ForceSpawn("RaceNitroSpawner 02", 1)
                              if (AUT_RaceActive == 2) then
                                if (GetGlobal("Autotopia_Core_Progression") ~= 3) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    AUT_TimeTrialFinish(carIdent)
                                    if (AUT_RaceActive < 7) then
                                      if (GetGlobal("Autotopia_RaceState") == 2) then
                                        if (AUT_LastRaceTag == 3) then
                                          if (AUT_RaceActive == 1) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  Display(GetPlayer(), "One more lap!!", 2)
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                  end
                                                  AUT_RaceActive = 2
                                                  if (AUT_RaceActive == 2) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      AUT_TimeTrialFinish(carIdent)
                                                      if (AUT_RaceActive < 7) then
                                                        if (GetGlobal("Autotopia_RaceState") == 3) then
                                                          if (AUT_LastRaceTag == 3) then
                                                            if (AUT_RaceActive == 1) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                                ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                    Display(GetPlayer(), "One more lap!!", 2)
                                                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                                                    end
                                                                    AUT_RaceActive = 2
                                                                    if (AUT_RaceActive == 2) then
                                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                        AUT_TimeTrialFinish(carIdent)
                                                                        if (AUT_RaceActive ~= 7) then
                                                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                Display(GetPlayer(), "One more lap!!", 2)
                                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                                end
                                                                AUT_RaceActive = 2
                                                                if (AUT_RaceActive == 2) then
                                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                    AUT_TimeTrialFinish(carIdent)
                                                                    if (AUT_RaceActive ~= 7) then
                                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            elseif (AUT_RaceActive == 2) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                AUT_TimeTrialFinish(carIdent)
                                                                if (AUT_RaceActive ~= 7) then
                                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      elseif (AUT_RaceActive ~= 7) then
                                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              Display(GetPlayer(), "One more lap!!", 2)
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                              end
                                              AUT_RaceActive = 2
                                              if (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive < 7) then
                                                    if (GetGlobal("Autotopia_RaceState") == 3) then
                                                      if (AUT_LastRaceTag == 3) then
                                                        if (AUT_RaceActive == 1) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                            ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                Display(GetPlayer(), "One more lap!!", 2)
                                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                                end
                                                                AUT_RaceActive = 2
                                                                if (AUT_RaceActive == 2) then
                                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                    AUT_TimeTrialFinish(carIdent)
                                                                    if (AUT_RaceActive ~= 7) then
                                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            Display(GetPlayer(), "One more lap!!", 2)
                                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                                            end
                                                            AUT_RaceActive = 2
                                                            if (AUT_RaceActive == 2) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                AUT_TimeTrialFinish(carIdent)
                                                                if (AUT_RaceActive ~= 7) then
                                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                end
                                                              end
                                                            end
                                                          end
                                                        elseif (AUT_RaceActive == 2) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            AUT_TimeTrialFinish(carIdent)
                                                            if (AUT_RaceActive ~= 7) then
                                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  elseif (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          elseif (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive < 7) then
                                                if (GetGlobal("Autotopia_RaceState") == 3) then
                                                  if (AUT_LastRaceTag == 3) then
                                                    if (AUT_RaceActive == 1) then
                                                      if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                        ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            Display(GetPlayer(), "One more lap!!", 2)
                                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                                            end
                                                            AUT_RaceActive = 2
                                                            if (AUT_RaceActive == 2) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                AUT_TimeTrialFinish(carIdent)
                                                                if (AUT_RaceActive ~= 7) then
                                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                        Display(GetPlayer(), "One more lap!!", 2)
                                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                                        end
                                                        AUT_RaceActive = 2
                                                        if (AUT_RaceActive == 2) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            AUT_TimeTrialFinish(carIdent)
                                                            if (AUT_RaceActive ~= 7) then
                                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                            end
                                                          end
                                                        end
                                                      end
                                                    elseif (AUT_RaceActive == 2) then
                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                        AUT_TimeTrialFinish(carIdent)
                                                        if (AUT_RaceActive ~= 7) then
                                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              elseif (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      end
                                    elseif (AUT_RaceActive < 7) then
                                      if (GetGlobal("Autotopia_RaceState") == 3) then
                                        if (AUT_LastRaceTag == 3) then
                                          if (AUT_RaceActive == 1) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                              ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  Display(GetPlayer(), "One more lap!!", 2)
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                  end
                                                  AUT_RaceActive = 2
                                                  if (AUT_RaceActive == 2) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      AUT_TimeTrialFinish(carIdent)
                                                      if (AUT_RaceActive ~= 7) then
                                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              Display(GetPlayer(), "One more lap!!", 2)
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                              end
                                              AUT_RaceActive = 2
                                              if (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          elseif (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      end
                                    elseif (AUT_RaceActive ~= 7) then
                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        Display(GetPlayer(), "One more lap!!", 2)
                        AUT_RaceActive = 2
                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                          ForceSpawn("RaceNitroSpawner 02", 1)
                          if (AUT_RaceActive == 2) then
                            if (GetGlobal("Autotopia_Core_Progression") ~= 3) then
                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                AUT_TimeTrialFinish(carIdent)
                                if (AUT_RaceActive < 7) then
                                  if (GetGlobal("Autotopia_RaceState") == 2) then
                                    if (AUT_LastRaceTag == 3) then
                                      if (AUT_RaceActive == 1) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              Display(GetPlayer(), "One more lap!!", 2)
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                              end
                                              AUT_RaceActive = 2
                                              if (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive < 7) then
                                                    if (GetGlobal("Autotopia_RaceState") == 3) then
                                                      if (AUT_LastRaceTag == 3) then
                                                        if (AUT_RaceActive == 1) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                            ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                Display(GetPlayer(), "One more lap!!", 2)
                                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                                end
                                                                AUT_RaceActive = 2
                                                                if (AUT_RaceActive == 2) then
                                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                    AUT_TimeTrialFinish(carIdent)
                                                                    if (AUT_RaceActive ~= 7) then
                                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            Display(GetPlayer(), "One more lap!!", 2)
                                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                                            end
                                                            AUT_RaceActive = 2
                                                            if (AUT_RaceActive == 2) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                AUT_TimeTrialFinish(carIdent)
                                                                if (AUT_RaceActive ~= 7) then
                                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                end
                                                              end
                                                            end
                                                          end
                                                        elseif (AUT_RaceActive == 2) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            AUT_TimeTrialFinish(carIdent)
                                                            if (AUT_RaceActive ~= 7) then
                                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  elseif (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          Display(GetPlayer(), "One more lap!!", 2)
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                          end
                                          AUT_RaceActive = 2
                                          if (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive < 7) then
                                                if (GetGlobal("Autotopia_RaceState") == 3) then
                                                  if (AUT_LastRaceTag == 3) then
                                                    if (AUT_RaceActive == 1) then
                                                      if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                        ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            Display(GetPlayer(), "One more lap!!", 2)
                                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                                            end
                                                            AUT_RaceActive = 2
                                                            if (AUT_RaceActive == 2) then
                                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                                AUT_TimeTrialFinish(carIdent)
                                                                if (AUT_RaceActive ~= 7) then
                                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                        Display(GetPlayer(), "One more lap!!", 2)
                                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                                        end
                                                        AUT_RaceActive = 2
                                                        if (AUT_RaceActive == 2) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            AUT_TimeTrialFinish(carIdent)
                                                            if (AUT_RaceActive ~= 7) then
                                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                            end
                                                          end
                                                        end
                                                      end
                                                    elseif (AUT_RaceActive == 2) then
                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                        AUT_TimeTrialFinish(carIdent)
                                                        if (AUT_RaceActive ~= 7) then
                                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              elseif (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      elseif (AUT_RaceActive == 2) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          AUT_TimeTrialFinish(carIdent)
                                          if (AUT_RaceActive < 7) then
                                            if (GetGlobal("Autotopia_RaceState") == 3) then
                                              if (AUT_LastRaceTag == 3) then
                                                if (AUT_RaceActive == 1) then
                                                  if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                    ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                        Display(GetPlayer(), "One more lap!!", 2)
                                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                                        end
                                                        AUT_RaceActive = 2
                                                        if (AUT_RaceActive == 2) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            AUT_TimeTrialFinish(carIdent)
                                                            if (AUT_RaceActive ~= 7) then
                                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                    Display(GetPlayer(), "One more lap!!", 2)
                                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                                    end
                                                    AUT_RaceActive = 2
                                                    if (AUT_RaceActive == 2) then
                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                        AUT_TimeTrialFinish(carIdent)
                                                        if (AUT_RaceActive ~= 7) then
                                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                        end
                                                      end
                                                    end
                                                  end
                                                elseif (AUT_RaceActive == 2) then
                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                    AUT_TimeTrialFinish(carIdent)
                                                    if (AUT_RaceActive ~= 7) then
                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          elseif (AUT_RaceActive ~= 7) then
                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                          end
                                        end
                                      end
                                    end
                                  end
                                elseif (AUT_RaceActive < 7) then
                                  if (GetGlobal("Autotopia_RaceState") == 3) then
                                    if (AUT_LastRaceTag == 3) then
                                      if (AUT_RaceActive == 1) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                          ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              Display(GetPlayer(), "One more lap!!", 2)
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                              end
                                              AUT_RaceActive = 2
                                              if (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          Display(GetPlayer(), "One more lap!!", 2)
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                          end
                                          AUT_RaceActive = 2
                                          if (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      elseif (AUT_RaceActive == 2) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          AUT_TimeTrialFinish(carIdent)
                                          if (AUT_RaceActive ~= 7) then
                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                          end
                                        end
                                      end
                                    end
                                  end
                                elseif (AUT_RaceActive ~= 7) then
                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                end
                              end
                            end
                          end
                        end
                      end
                    elseif (AUT_RaceActive == 2) then
                      if (GetGlobal("Autotopia_Core_Progression") ~= 3) then
                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                          AUT_TimeTrialFinish(carIdent)
                          if (AUT_RaceActive < 7) then
                            if (GetGlobal("Autotopia_RaceState") == 2) then
                              if (AUT_LastRaceTag == 3) then
                                if (AUT_RaceActive == 1) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                        Display(GetPlayer(), "One more lap!!", 2)
                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                        end
                                        AUT_RaceActive = 2
                                        if (AUT_RaceActive == 2) then
                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                            AUT_TimeTrialFinish(carIdent)
                                            if (AUT_RaceActive < 7) then
                                              if (GetGlobal("Autotopia_RaceState") == 3) then
                                                if (AUT_LastRaceTag == 3) then
                                                  if (AUT_RaceActive == 1) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                      ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                          Display(GetPlayer(), "One more lap!!", 2)
                                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                                          end
                                                          AUT_RaceActive = 2
                                                          if (AUT_RaceActive == 2) then
                                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                              AUT_TimeTrialFinish(carIdent)
                                                              if (AUT_RaceActive ~= 7) then
                                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      Display(GetPlayer(), "One more lap!!", 2)
                                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                                      end
                                                      AUT_RaceActive = 2
                                                      if (AUT_RaceActive == 2) then
                                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                          AUT_TimeTrialFinish(carIdent)
                                                          if (AUT_RaceActive ~= 7) then
                                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                          end
                                                        end
                                                      end
                                                    end
                                                  elseif (AUT_RaceActive == 2) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      AUT_TimeTrialFinish(carIdent)
                                                      if (AUT_RaceActive ~= 7) then
                                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            elseif (AUT_RaceActive ~= 7) then
                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                            end
                                          end
                                        end
                                      end
                                    end
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    Display(GetPlayer(), "One more lap!!", 2)
                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                    end
                                    AUT_RaceActive = 2
                                    if (AUT_RaceActive == 2) then
                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                        AUT_TimeTrialFinish(carIdent)
                                        if (AUT_RaceActive < 7) then
                                          if (GetGlobal("Autotopia_RaceState") == 3) then
                                            if (AUT_LastRaceTag == 3) then
                                              if (AUT_RaceActive == 1) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                  ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      Display(GetPlayer(), "One more lap!!", 2)
                                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                                      end
                                                      AUT_RaceActive = 2
                                                      if (AUT_RaceActive == 2) then
                                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                          AUT_TimeTrialFinish(carIdent)
                                                          if (AUT_RaceActive ~= 7) then
                                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  Display(GetPlayer(), "One more lap!!", 2)
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                  end
                                                  AUT_RaceActive = 2
                                                  if (AUT_RaceActive == 2) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      AUT_TimeTrialFinish(carIdent)
                                                      if (AUT_RaceActive ~= 7) then
                                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                      end
                                                    end
                                                  end
                                                end
                                              elseif (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        elseif (AUT_RaceActive ~= 7) then
                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                        end
                                      end
                                    end
                                  end
                                elseif (AUT_RaceActive == 2) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    AUT_TimeTrialFinish(carIdent)
                                    if (AUT_RaceActive < 7) then
                                      if (GetGlobal("Autotopia_RaceState") == 3) then
                                        if (AUT_LastRaceTag == 3) then
                                          if (AUT_RaceActive == 1) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                              ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  Display(GetPlayer(), "One more lap!!", 2)
                                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                                  end
                                                  AUT_RaceActive = 2
                                                  if (AUT_RaceActive == 2) then
                                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                      AUT_TimeTrialFinish(carIdent)
                                                      if (AUT_RaceActive ~= 7) then
                                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              Display(GetPlayer(), "One more lap!!", 2)
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                              end
                                              AUT_RaceActive = 2
                                              if (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          elseif (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      end
                                    elseif (AUT_RaceActive ~= 7) then
                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                    end
                                  end
                                end
                              end
                            end
                          elseif (AUT_RaceActive < 7) then
                            if (GetGlobal("Autotopia_RaceState") == 3) then
                              if (AUT_LastRaceTag == 3) then
                                if (AUT_RaceActive == 1) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                    ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                        Display(GetPlayer(), "One more lap!!", 2)
                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                        end
                                        AUT_RaceActive = 2
                                        if (AUT_RaceActive == 2) then
                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                            AUT_TimeTrialFinish(carIdent)
                                            if (AUT_RaceActive ~= 7) then
                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                            end
                                          end
                                        end
                                      end
                                    end
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    Display(GetPlayer(), "One more lap!!", 2)
                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                    end
                                    AUT_RaceActive = 2
                                    if (AUT_RaceActive == 2) then
                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                        AUT_TimeTrialFinish(carIdent)
                                        if (AUT_RaceActive ~= 7) then
                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                        end
                                      end
                                    end
                                  end
                                elseif (AUT_RaceActive == 2) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    AUT_TimeTrialFinish(carIdent)
                                    if (AUT_RaceActive ~= 7) then
                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                    end
                                  end
                                end
                              end
                            end
                          elseif (AUT_RaceActive ~= 7) then
                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                          end
                        end
                      end
                    end
                  end
                end
              elseif (AUT_RaceActive < 7) then
                if (GetGlobal("Autotopia_RaceState") == 2) then
                  if (AUT_LastRaceTag == 3) then
                    if (AUT_RaceActive == 1) then
                      if (GetGlobal("Autotopia_Core_Progression") == 3) then
                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                          ForceSpawn("RaceNitroSpawner 02", 1)
                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                            Display(GetPlayer(), "One more lap!!", 2)
                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                              ForceSpawn("RaceNitroSpawner 02", 1)
                            end
                            AUT_RaceActive = 2
                            if (AUT_RaceActive == 2) then
                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                AUT_TimeTrialFinish(carIdent)
                                if (AUT_RaceActive < 7) then
                                  if (GetGlobal("Autotopia_RaceState") == 3) then
                                    if (AUT_LastRaceTag == 3) then
                                      if (AUT_RaceActive == 1) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                          ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              Display(GetPlayer(), "One more lap!!", 2)
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                              end
                                              AUT_RaceActive = 2
                                              if (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          Display(GetPlayer(), "One more lap!!", 2)
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                          end
                                          AUT_RaceActive = 2
                                          if (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      elseif (AUT_RaceActive == 2) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          AUT_TimeTrialFinish(carIdent)
                                          if (AUT_RaceActive ~= 7) then
                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                          end
                                        end
                                      end
                                    end
                                  end
                                elseif (AUT_RaceActive ~= 7) then
                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                end
                              end
                            end
                          end
                        end
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        Display(GetPlayer(), "One more lap!!", 2)
                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                          ForceSpawn("RaceNitroSpawner 02", 1)
                        end
                        AUT_RaceActive = 2
                        if (AUT_RaceActive == 2) then
                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                            AUT_TimeTrialFinish(carIdent)
                            if (AUT_RaceActive < 7) then
                              if (GetGlobal("Autotopia_RaceState") == 3) then
                                if (AUT_LastRaceTag == 3) then
                                  if (AUT_RaceActive == 1) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                      ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          Display(GetPlayer(), "One more lap!!", 2)
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                          end
                                          AUT_RaceActive = 2
                                          if (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      end
                                    elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      Display(GetPlayer(), "One more lap!!", 2)
                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                      end
                                      AUT_RaceActive = 2
                                      if (AUT_RaceActive == 2) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          AUT_TimeTrialFinish(carIdent)
                                          if (AUT_RaceActive ~= 7) then
                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                          end
                                        end
                                      end
                                    end
                                  elseif (AUT_RaceActive == 2) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      AUT_TimeTrialFinish(carIdent)
                                      if (AUT_RaceActive ~= 7) then
                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                      end
                                    end
                                  end
                                end
                              end
                            elseif (AUT_RaceActive ~= 7) then
                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                            end
                          end
                        end
                      end
                    elseif (AUT_RaceActive == 2) then
                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                        AUT_TimeTrialFinish(carIdent)
                        if (AUT_RaceActive < 7) then
                          if (GetGlobal("Autotopia_RaceState") == 3) then
                            if (AUT_LastRaceTag == 3) then
                              if (AUT_RaceActive == 1) then
                                if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                  ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      Display(GetPlayer(), "One more lap!!", 2)
                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                      end
                                      AUT_RaceActive = 2
                                      if (AUT_RaceActive == 2) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          AUT_TimeTrialFinish(carIdent)
                                          if (AUT_RaceActive ~= 7) then
                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                          end
                                        end
                                      end
                                    end
                                  end
                                elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  Display(GetPlayer(), "One more lap!!", 2)
                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                  end
                                  AUT_RaceActive = 2
                                  if (AUT_RaceActive == 2) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      AUT_TimeTrialFinish(carIdent)
                                      if (AUT_RaceActive ~= 7) then
                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                      end
                                    end
                                  end
                                end
                              elseif (AUT_RaceActive == 2) then
                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  AUT_TimeTrialFinish(carIdent)
                                  if (AUT_RaceActive ~= 7) then
                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                  end
                                end
                              end
                            end
                          end
                        elseif (AUT_RaceActive ~= 7) then
                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                        end
                      end
                    end
                  end
                end
              elseif (AUT_RaceActive < 7) then
                if (GetGlobal("Autotopia_RaceState") == 3) then
                  if (AUT_LastRaceTag == 3) then
                    if (AUT_RaceActive == 1) then
                      if (GetGlobal("Autotopia_Core_Progression") == 3) then
                        ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                          ForceSpawn("RaceNitroSpawner 02", 1)
                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                            Display(GetPlayer(), "One more lap!!", 2)
                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                              ForceSpawn("RaceNitroSpawner 02", 1)
                            end
                            AUT_RaceActive = 2
                            if (AUT_RaceActive == 2) then
                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                AUT_TimeTrialFinish(carIdent)
                                if (AUT_RaceActive ~= 7) then
                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                end
                              end
                            end
                          end
                        end
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        Display(GetPlayer(), "One more lap!!", 2)
                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                          ForceSpawn("RaceNitroSpawner 02", 1)
                        end
                        AUT_RaceActive = 2
                        if (AUT_RaceActive == 2) then
                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                            AUT_TimeTrialFinish(carIdent)
                            if (AUT_RaceActive ~= 7) then
                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                            end
                          end
                        end
                      end
                    elseif (AUT_RaceActive == 2) then
                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                        AUT_TimeTrialFinish(carIdent)
                        if (AUT_RaceActive ~= 7) then
                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                        end
                      end
                    end
                  end
                end
              elseif (AUT_RaceActive ~= 7) then
                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
              end
            end
          end
        end
      end
    end
  elseif (AUT_RaceActive < 7) then
    if (GetGlobal("Autotopia_RaceState") == 1) then
      if (AUT_LastRaceTag == 2) then
        if (AUT_RaceActive == 1) then
          if (GetGlobal("Autotopia_Core_Progression") == 3) then
            ForEachEntityInGroup(Unhide, "Derby03Obstacle")
            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
              ForceSpawn("RaceNitroSpawner 02", 1)
              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                Display(GetPlayer(), "One more lap!!", 2)
                AUT_RaceActive = 2
                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                  ForceSpawn("RaceNitroSpawner 02", 1)
                  if (AUT_RaceActive == 2) then
                    if (GetGlobal("Autotopia_Core_Progression") ~= 3) then
                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                        AUT_TimeTrialFinish(carIdent)
                        if (AUT_RaceActive < 7) then
                          if (GetGlobal("Autotopia_RaceState") == 2) then
                            if (AUT_LastRaceTag == 3) then
                              if (AUT_RaceActive == 1) then
                                if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      Display(GetPlayer(), "One more lap!!", 2)
                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                      end
                                      AUT_RaceActive = 2
                                      if (AUT_RaceActive == 2) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          AUT_TimeTrialFinish(carIdent)
                                          if (AUT_RaceActive < 7) then
                                            if (GetGlobal("Autotopia_RaceState") == 3) then
                                              if (AUT_LastRaceTag == 3) then
                                                if (AUT_RaceActive == 1) then
                                                  if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                    ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                        Display(GetPlayer(), "One more lap!!", 2)
                                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                                        end
                                                        AUT_RaceActive = 2
                                                        if (AUT_RaceActive == 2) then
                                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                            AUT_TimeTrialFinish(carIdent)
                                                            if (AUT_RaceActive ~= 7) then
                                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                    Display(GetPlayer(), "One more lap!!", 2)
                                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                                    end
                                                    AUT_RaceActive = 2
                                                    if (AUT_RaceActive == 2) then
                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                        AUT_TimeTrialFinish(carIdent)
                                                        if (AUT_RaceActive ~= 7) then
                                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                        end
                                                      end
                                                    end
                                                  end
                                                elseif (AUT_RaceActive == 2) then
                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                    AUT_TimeTrialFinish(carIdent)
                                                    if (AUT_RaceActive ~= 7) then
                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          elseif (AUT_RaceActive ~= 7) then
                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                          end
                                        end
                                      end
                                    end
                                  end
                                elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  Display(GetPlayer(), "One more lap!!", 2)
                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                  end
                                  AUT_RaceActive = 2
                                  if (AUT_RaceActive == 2) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      AUT_TimeTrialFinish(carIdent)
                                      if (AUT_RaceActive < 7) then
                                        if (GetGlobal("Autotopia_RaceState") == 3) then
                                          if (AUT_LastRaceTag == 3) then
                                            if (AUT_RaceActive == 1) then
                                              if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                    Display(GetPlayer(), "One more lap!!", 2)
                                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                                    end
                                                    AUT_RaceActive = 2
                                                    if (AUT_RaceActive == 2) then
                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                        AUT_TimeTrialFinish(carIdent)
                                                        if (AUT_RaceActive ~= 7) then
                                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                Display(GetPlayer(), "One more lap!!", 2)
                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                end
                                                AUT_RaceActive = 2
                                                if (AUT_RaceActive == 2) then
                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                    AUT_TimeTrialFinish(carIdent)
                                                    if (AUT_RaceActive ~= 7) then
                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                    end
                                                  end
                                                end
                                              end
                                            elseif (AUT_RaceActive == 2) then
                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                AUT_TimeTrialFinish(carIdent)
                                                if (AUT_RaceActive ~= 7) then
                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                end
                                              end
                                            end
                                          end
                                        end
                                      elseif (AUT_RaceActive ~= 7) then
                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                      end
                                    end
                                  end
                                end
                              elseif (AUT_RaceActive == 2) then
                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  AUT_TimeTrialFinish(carIdent)
                                  if (AUT_RaceActive < 7) then
                                    if (GetGlobal("Autotopia_RaceState") == 3) then
                                      if (AUT_LastRaceTag == 3) then
                                        if (AUT_RaceActive == 1) then
                                          if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                            ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                Display(GetPlayer(), "One more lap!!", 2)
                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                end
                                                AUT_RaceActive = 2
                                                if (AUT_RaceActive == 2) then
                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                    AUT_TimeTrialFinish(carIdent)
                                                    if (AUT_RaceActive ~= 7) then
                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                            Display(GetPlayer(), "One more lap!!", 2)
                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                            end
                                            AUT_RaceActive = 2
                                            if (AUT_RaceActive == 2) then
                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                AUT_TimeTrialFinish(carIdent)
                                                if (AUT_RaceActive ~= 7) then
                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                end
                                              end
                                            end
                                          end
                                        elseif (AUT_RaceActive == 2) then
                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                            AUT_TimeTrialFinish(carIdent)
                                            if (AUT_RaceActive ~= 7) then
                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                            end
                                          end
                                        end
                                      end
                                    end
                                  elseif (AUT_RaceActive ~= 7) then
                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                  end
                                end
                              end
                            end
                          end
                        elseif (AUT_RaceActive < 7) then
                          if (GetGlobal("Autotopia_RaceState") == 3) then
                            if (AUT_LastRaceTag == 3) then
                              if (AUT_RaceActive == 1) then
                                if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                  ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      Display(GetPlayer(), "One more lap!!", 2)
                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                      end
                                      AUT_RaceActive = 2
                                      if (AUT_RaceActive == 2) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          AUT_TimeTrialFinish(carIdent)
                                          if (AUT_RaceActive ~= 7) then
                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                          end
                                        end
                                      end
                                    end
                                  end
                                elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  Display(GetPlayer(), "One more lap!!", 2)
                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                  end
                                  AUT_RaceActive = 2
                                  if (AUT_RaceActive == 2) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      AUT_TimeTrialFinish(carIdent)
                                      if (AUT_RaceActive ~= 7) then
                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                      end
                                    end
                                  end
                                end
                              elseif (AUT_RaceActive == 2) then
                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  AUT_TimeTrialFinish(carIdent)
                                  if (AUT_RaceActive ~= 7) then
                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                  end
                                end
                              end
                            end
                          end
                        elseif (AUT_RaceActive ~= 7) then
                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                        end
                      end
                    end
                  end
                end
              end
            end
          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
            Display(GetPlayer(), "One more lap!!", 2)
            AUT_RaceActive = 2
            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
              ForceSpawn("RaceNitroSpawner 02", 1)
              if (AUT_RaceActive == 2) then
                if (GetGlobal("Autotopia_Core_Progression") ~= 3) then
                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                    AUT_TimeTrialFinish(carIdent)
                    if (AUT_RaceActive < 7) then
                      if (GetGlobal("Autotopia_RaceState") == 2) then
                        if (AUT_LastRaceTag == 3) then
                          if (AUT_RaceActive == 1) then
                            if (GetGlobal("Autotopia_Core_Progression") == 3) then
                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                ForceSpawn("RaceNitroSpawner 02", 1)
                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  Display(GetPlayer(), "One more lap!!", 2)
                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                  end
                                  AUT_RaceActive = 2
                                  if (AUT_RaceActive == 2) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      AUT_TimeTrialFinish(carIdent)
                                      if (AUT_RaceActive < 7) then
                                        if (GetGlobal("Autotopia_RaceState") == 3) then
                                          if (AUT_LastRaceTag == 3) then
                                            if (AUT_RaceActive == 1) then
                                              if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                                ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                    Display(GetPlayer(), "One more lap!!", 2)
                                                    if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                      ForceSpawn("RaceNitroSpawner 02", 1)
                                                    end
                                                    AUT_RaceActive = 2
                                                    if (AUT_RaceActive == 2) then
                                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                        AUT_TimeTrialFinish(carIdent)
                                                        if (AUT_RaceActive ~= 7) then
                                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                Display(GetPlayer(), "One more lap!!", 2)
                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                end
                                                AUT_RaceActive = 2
                                                if (AUT_RaceActive == 2) then
                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                    AUT_TimeTrialFinish(carIdent)
                                                    if (AUT_RaceActive ~= 7) then
                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                    end
                                                  end
                                                end
                                              end
                                            elseif (AUT_RaceActive == 2) then
                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                AUT_TimeTrialFinish(carIdent)
                                                if (AUT_RaceActive ~= 7) then
                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                end
                                              end
                                            end
                                          end
                                        end
                                      elseif (AUT_RaceActive ~= 7) then
                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                      end
                                    end
                                  end
                                end
                              end
                            elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                              Display(GetPlayer(), "One more lap!!", 2)
                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                ForceSpawn("RaceNitroSpawner 02", 1)
                              end
                              AUT_RaceActive = 2
                              if (AUT_RaceActive == 2) then
                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  AUT_TimeTrialFinish(carIdent)
                                  if (AUT_RaceActive < 7) then
                                    if (GetGlobal("Autotopia_RaceState") == 3) then
                                      if (AUT_LastRaceTag == 3) then
                                        if (AUT_RaceActive == 1) then
                                          if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                            ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                Display(GetPlayer(), "One more lap!!", 2)
                                                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                  ForceSpawn("RaceNitroSpawner 02", 1)
                                                end
                                                AUT_RaceActive = 2
                                                if (AUT_RaceActive == 2) then
                                                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                    AUT_TimeTrialFinish(carIdent)
                                                    if (AUT_RaceActive ~= 7) then
                                                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                            Display(GetPlayer(), "One more lap!!", 2)
                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                            end
                                            AUT_RaceActive = 2
                                            if (AUT_RaceActive == 2) then
                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                AUT_TimeTrialFinish(carIdent)
                                                if (AUT_RaceActive ~= 7) then
                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                end
                                              end
                                            end
                                          end
                                        elseif (AUT_RaceActive == 2) then
                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                            AUT_TimeTrialFinish(carIdent)
                                            if (AUT_RaceActive ~= 7) then
                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                            end
                                          end
                                        end
                                      end
                                    end
                                  elseif (AUT_RaceActive ~= 7) then
                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                  end
                                end
                              end
                            end
                          elseif (AUT_RaceActive == 2) then
                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                              AUT_TimeTrialFinish(carIdent)
                              if (AUT_RaceActive < 7) then
                                if (GetGlobal("Autotopia_RaceState") == 3) then
                                  if (AUT_LastRaceTag == 3) then
                                    if (AUT_RaceActive == 1) then
                                      if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                        ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                            Display(GetPlayer(), "One more lap!!", 2)
                                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                              ForceSpawn("RaceNitroSpawner 02", 1)
                                            end
                                            AUT_RaceActive = 2
                                            if (AUT_RaceActive == 2) then
                                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                AUT_TimeTrialFinish(carIdent)
                                                if (AUT_RaceActive ~= 7) then
                                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                end
                                              end
                                            end
                                          end
                                        end
                                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                        Display(GetPlayer(), "One more lap!!", 2)
                                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                          ForceSpawn("RaceNitroSpawner 02", 1)
                                        end
                                        AUT_RaceActive = 2
                                        if (AUT_RaceActive == 2) then
                                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                            AUT_TimeTrialFinish(carIdent)
                                            if (AUT_RaceActive ~= 7) then
                                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                            end
                                          end
                                        end
                                      end
                                    elseif (AUT_RaceActive == 2) then
                                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                        AUT_TimeTrialFinish(carIdent)
                                        if (AUT_RaceActive ~= 7) then
                                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                        end
                                      end
                                    end
                                  end
                                end
                              elseif (AUT_RaceActive ~= 7) then
                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                              end
                            end
                          end
                        end
                      end
                    elseif (AUT_RaceActive < 7) then
                      if (GetGlobal("Autotopia_RaceState") == 3) then
                        if (AUT_LastRaceTag == 3) then
                          if (AUT_RaceActive == 1) then
                            if (GetGlobal("Autotopia_Core_Progression") == 3) then
                              ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                ForceSpawn("RaceNitroSpawner 02", 1)
                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  Display(GetPlayer(), "One more lap!!", 2)
                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                  end
                                  AUT_RaceActive = 2
                                  if (AUT_RaceActive == 2) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      AUT_TimeTrialFinish(carIdent)
                                      if (AUT_RaceActive ~= 7) then
                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                      end
                                    end
                                  end
                                end
                              end
                            elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                              Display(GetPlayer(), "One more lap!!", 2)
                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                ForceSpawn("RaceNitroSpawner 02", 1)
                              end
                              AUT_RaceActive = 2
                              if (AUT_RaceActive == 2) then
                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  AUT_TimeTrialFinish(carIdent)
                                  if (AUT_RaceActive ~= 7) then
                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                  end
                                end
                              end
                            end
                          elseif (AUT_RaceActive == 2) then
                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                              AUT_TimeTrialFinish(carIdent)
                              if (AUT_RaceActive ~= 7) then
                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                              end
                            end
                          end
                        end
                      end
                    elseif (AUT_RaceActive ~= 7) then
                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                    end
                  end
                end
              end
            end
          end
        elseif (AUT_RaceActive == 2) then
          if (GetGlobal("Autotopia_Core_Progression") ~= 3) then
            if (GetGlobal("Autotopia_Core_Progression") == 2) then
              AUT_TimeTrialFinish(carIdent)
              if (AUT_RaceActive < 7) then
                if (GetGlobal("Autotopia_RaceState") == 2) then
                  if (AUT_LastRaceTag == 3) then
                    if (AUT_RaceActive == 1) then
                      if (GetGlobal("Autotopia_Core_Progression") == 3) then
                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                          ForceSpawn("RaceNitroSpawner 02", 1)
                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                            Display(GetPlayer(), "One more lap!!", 2)
                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                              ForceSpawn("RaceNitroSpawner 02", 1)
                            end
                            AUT_RaceActive = 2
                            if (AUT_RaceActive == 2) then
                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                AUT_TimeTrialFinish(carIdent)
                                if (AUT_RaceActive < 7) then
                                  if (GetGlobal("Autotopia_RaceState") == 3) then
                                    if (AUT_LastRaceTag == 3) then
                                      if (AUT_RaceActive == 1) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                          ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              Display(GetPlayer(), "One more lap!!", 2)
                                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                                ForceSpawn("RaceNitroSpawner 02", 1)
                                              end
                                              AUT_RaceActive = 2
                                              if (AUT_RaceActive == 2) then
                                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                                  AUT_TimeTrialFinish(carIdent)
                                                  if (AUT_RaceActive ~= 7) then
                                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          Display(GetPlayer(), "One more lap!!", 2)
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                          end
                                          AUT_RaceActive = 2
                                          if (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      elseif (AUT_RaceActive == 2) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          AUT_TimeTrialFinish(carIdent)
                                          if (AUT_RaceActive ~= 7) then
                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                          end
                                        end
                                      end
                                    end
                                  end
                                elseif (AUT_RaceActive ~= 7) then
                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                end
                              end
                            end
                          end
                        end
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        Display(GetPlayer(), "One more lap!!", 2)
                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                          ForceSpawn("RaceNitroSpawner 02", 1)
                        end
                        AUT_RaceActive = 2
                        if (AUT_RaceActive == 2) then
                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                            AUT_TimeTrialFinish(carIdent)
                            if (AUT_RaceActive < 7) then
                              if (GetGlobal("Autotopia_RaceState") == 3) then
                                if (AUT_LastRaceTag == 3) then
                                  if (AUT_RaceActive == 1) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                      ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          Display(GetPlayer(), "One more lap!!", 2)
                                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                            ForceSpawn("RaceNitroSpawner 02", 1)
                                          end
                                          AUT_RaceActive = 2
                                          if (AUT_RaceActive == 2) then
                                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                              AUT_TimeTrialFinish(carIdent)
                                              if (AUT_RaceActive ~= 7) then
                                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                              end
                                            end
                                          end
                                        end
                                      end
                                    elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      Display(GetPlayer(), "One more lap!!", 2)
                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                      end
                                      AUT_RaceActive = 2
                                      if (AUT_RaceActive == 2) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          AUT_TimeTrialFinish(carIdent)
                                          if (AUT_RaceActive ~= 7) then
                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                          end
                                        end
                                      end
                                    end
                                  elseif (AUT_RaceActive == 2) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      AUT_TimeTrialFinish(carIdent)
                                      if (AUT_RaceActive ~= 7) then
                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                      end
                                    end
                                  end
                                end
                              end
                            elseif (AUT_RaceActive ~= 7) then
                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                            end
                          end
                        end
                      end
                    elseif (AUT_RaceActive == 2) then
                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                        AUT_TimeTrialFinish(carIdent)
                        if (AUT_RaceActive < 7) then
                          if (GetGlobal("Autotopia_RaceState") == 3) then
                            if (AUT_LastRaceTag == 3) then
                              if (AUT_RaceActive == 1) then
                                if (GetGlobal("Autotopia_Core_Progression") == 3) then
                                  ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      Display(GetPlayer(), "One more lap!!", 2)
                                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                        ForceSpawn("RaceNitroSpawner 02", 1)
                                      end
                                      AUT_RaceActive = 2
                                      if (AUT_RaceActive == 2) then
                                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                          AUT_TimeTrialFinish(carIdent)
                                          if (AUT_RaceActive ~= 7) then
                                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                          end
                                        end
                                      end
                                    end
                                  end
                                elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  Display(GetPlayer(), "One more lap!!", 2)
                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                  end
                                  AUT_RaceActive = 2
                                  if (AUT_RaceActive == 2) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      AUT_TimeTrialFinish(carIdent)
                                      if (AUT_RaceActive ~= 7) then
                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                      end
                                    end
                                  end
                                end
                              elseif (AUT_RaceActive == 2) then
                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  AUT_TimeTrialFinish(carIdent)
                                  if (AUT_RaceActive ~= 7) then
                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                  end
                                end
                              end
                            end
                          end
                        elseif (AUT_RaceActive ~= 7) then
                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                        end
                      end
                    end
                  end
                end
              elseif (AUT_RaceActive < 7) then
                if (GetGlobal("Autotopia_RaceState") == 3) then
                  if (AUT_LastRaceTag == 3) then
                    if (AUT_RaceActive == 1) then
                      if (GetGlobal("Autotopia_Core_Progression") == 3) then
                        ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                          ForceSpawn("RaceNitroSpawner 02", 1)
                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                            Display(GetPlayer(), "One more lap!!", 2)
                            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                              ForceSpawn("RaceNitroSpawner 02", 1)
                            end
                            AUT_RaceActive = 2
                            if (AUT_RaceActive == 2) then
                              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                AUT_TimeTrialFinish(carIdent)
                                if (AUT_RaceActive ~= 7) then
                                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                end
                              end
                            end
                          end
                        end
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        Display(GetPlayer(), "One more lap!!", 2)
                        if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                          ForceSpawn("RaceNitroSpawner 02", 1)
                        end
                        AUT_RaceActive = 2
                        if (AUT_RaceActive == 2) then
                          if (GetGlobal("Autotopia_Core_Progression") == 2) then
                            AUT_TimeTrialFinish(carIdent)
                            if (AUT_RaceActive ~= 7) then
                              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                            end
                          end
                        end
                      end
                    elseif (AUT_RaceActive == 2) then
                      if (GetGlobal("Autotopia_Core_Progression") == 2) then
                        AUT_TimeTrialFinish(carIdent)
                        if (AUT_RaceActive ~= 7) then
                          Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                        end
                      end
                    end
                  end
                end
              elseif (AUT_RaceActive ~= 7) then
                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
              end
            end
          end
        end
      end
    end
  elseif (AUT_RaceActive < 7) then
    if (GetGlobal("Autotopia_RaceState") == 2) then
      if (AUT_LastRaceTag == 3) then
        if (AUT_RaceActive == 1) then
          if (GetGlobal("Autotopia_Core_Progression") == 3) then
            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
              ForceSpawn("RaceNitroSpawner 02", 1)
              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                Display(GetPlayer(), "One more lap!!", 2)
                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                  ForceSpawn("RaceNitroSpawner 02", 1)
                end
                AUT_RaceActive = 2
                if (AUT_RaceActive == 2) then
                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                    AUT_TimeTrialFinish(carIdent)
                    if (AUT_RaceActive < 7) then
                      if (GetGlobal("Autotopia_RaceState") == 3) then
                        if (AUT_LastRaceTag == 3) then
                          if (AUT_RaceActive == 1) then
                            if (GetGlobal("Autotopia_Core_Progression") == 3) then
                              ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                ForceSpawn("RaceNitroSpawner 02", 1)
                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  Display(GetPlayer(), "One more lap!!", 2)
                                  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                    ForceSpawn("RaceNitroSpawner 02", 1)
                                  end
                                  AUT_RaceActive = 2
                                  if (AUT_RaceActive == 2) then
                                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                      AUT_TimeTrialFinish(carIdent)
                                      if (AUT_RaceActive ~= 7) then
                                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                      end
                                    end
                                  end
                                end
                              end
                            elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                              Display(GetPlayer(), "One more lap!!", 2)
                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                ForceSpawn("RaceNitroSpawner 02", 1)
                              end
                              AUT_RaceActive = 2
                              if (AUT_RaceActive == 2) then
                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  AUT_TimeTrialFinish(carIdent)
                                  if (AUT_RaceActive ~= 7) then
                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                  end
                                end
                              end
                            end
                          elseif (AUT_RaceActive == 2) then
                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                              AUT_TimeTrialFinish(carIdent)
                              if (AUT_RaceActive ~= 7) then
                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                              end
                            end
                          end
                        end
                      end
                    elseif (AUT_RaceActive ~= 7) then
                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                    end
                  end
                end
              end
            end
          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
            Display(GetPlayer(), "One more lap!!", 2)
            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
              ForceSpawn("RaceNitroSpawner 02", 1)
            end
            AUT_RaceActive = 2
            if (AUT_RaceActive == 2) then
              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                AUT_TimeTrialFinish(carIdent)
                if (AUT_RaceActive < 7) then
                  if (GetGlobal("Autotopia_RaceState") == 3) then
                    if (AUT_LastRaceTag == 3) then
                      if (AUT_RaceActive == 1) then
                        if (GetGlobal("Autotopia_Core_Progression") == 3) then
                          ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                            ForceSpawn("RaceNitroSpawner 02", 1)
                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                              Display(GetPlayer(), "One more lap!!", 2)
                              if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                                ForceSpawn("RaceNitroSpawner 02", 1)
                              end
                              AUT_RaceActive = 2
                              if (AUT_RaceActive == 2) then
                                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                                  AUT_TimeTrialFinish(carIdent)
                                  if (AUT_RaceActive ~= 7) then
                                    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                                  end
                                end
                              end
                            end
                          end
                        elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                          Display(GetPlayer(), "One more lap!!", 2)
                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                            ForceSpawn("RaceNitroSpawner 02", 1)
                          end
                          AUT_RaceActive = 2
                          if (AUT_RaceActive == 2) then
                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                              AUT_TimeTrialFinish(carIdent)
                              if (AUT_RaceActive ~= 7) then
                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                              end
                            end
                          end
                        end
                      elseif (AUT_RaceActive == 2) then
                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                          AUT_TimeTrialFinish(carIdent)
                          if (AUT_RaceActive ~= 7) then
                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                          end
                        end
                      end
                    end
                  end
                elseif (AUT_RaceActive ~= 7) then
                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                end
              end
            end
          end
        elseif (AUT_RaceActive == 2) then
          if (GetGlobal("Autotopia_Core_Progression") == 2) then
            AUT_TimeTrialFinish(carIdent)
            if (AUT_RaceActive < 7) then
              if (GetGlobal("Autotopia_RaceState") == 3) then
                if (AUT_LastRaceTag == 3) then
                  if (AUT_RaceActive == 1) then
                    if (GetGlobal("Autotopia_Core_Progression") == 3) then
                      ForEachEntityInGroup(Unhide, "Derby03Obstacle")
                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                        ForceSpawn("RaceNitroSpawner 02", 1)
                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                          Display(GetPlayer(), "One more lap!!", 2)
                          if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                            ForceSpawn("RaceNitroSpawner 02", 1)
                          end
                          AUT_RaceActive = 2
                          if (AUT_RaceActive == 2) then
                            if (GetGlobal("Autotopia_Core_Progression") == 2) then
                              AUT_TimeTrialFinish(carIdent)
                              if (AUT_RaceActive ~= 7) then
                                Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                              end
                            end
                          end
                        end
                      end
                    elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                      Display(GetPlayer(), "One more lap!!", 2)
                      if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                        ForceSpawn("RaceNitroSpawner 02", 1)
                      end
                      AUT_RaceActive = 2
                      if (AUT_RaceActive == 2) then
                        if (GetGlobal("Autotopia_Core_Progression") == 2) then
                          AUT_TimeTrialFinish(carIdent)
                          if (AUT_RaceActive ~= 7) then
                            Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                          end
                        end
                      end
                    end
                  elseif (AUT_RaceActive == 2) then
                    if (GetGlobal("Autotopia_Core_Progression") == 2) then
                      AUT_TimeTrialFinish(carIdent)
                      if (AUT_RaceActive ~= 7) then
                        Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                      end
                    end
                  end
                end
              end
            elseif (AUT_RaceActive ~= 7) then
              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
            end
          end
        end
      end
    end
  elseif (AUT_RaceActive < 7) then
    if (GetGlobal("Autotopia_RaceState") == 3) then
      if (AUT_LastRaceTag == 3) then
        if (AUT_RaceActive == 1) then
          if (GetGlobal("Autotopia_Core_Progression") == 3) then
            ForEachEntityInGroup(Unhide, "Derby03Obstacle")
            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
              ForceSpawn("RaceNitroSpawner 02", 1)
              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                Display(GetPlayer(), "One more lap!!", 2)
                if (GetGlobal("Autotopia_Garage_Opened") == 1) then
                  ForceSpawn("RaceNitroSpawner 02", 1)
                end
                AUT_RaceActive = 2
                if (AUT_RaceActive == 2) then
                  if (GetGlobal("Autotopia_Core_Progression") == 2) then
                    AUT_TimeTrialFinish(carIdent)
                    if (AUT_RaceActive ~= 7) then
                      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                    end
                  end
                end
              end
            end
          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
            Display(GetPlayer(), "One more lap!!", 2)
            if (GetGlobal("Autotopia_Garage_Opened") == 1) then
              ForceSpawn("RaceNitroSpawner 02", 1)
            end
            AUT_RaceActive = 2
            if (AUT_RaceActive == 2) then
              if (GetGlobal("Autotopia_Core_Progression") == 2) then
                AUT_TimeTrialFinish(carIdent)
                if (AUT_RaceActive ~= 7) then
                  Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
                end
              end
            end
          end
        elseif (AUT_RaceActive == 2) then
          if (GetGlobal("Autotopia_Core_Progression") == 2) then
            AUT_TimeTrialFinish(carIdent)
            if (AUT_RaceActive ~= 7) then
              Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
            end
          end
        end
      end
    end
  elseif (AUT_RaceActive ~= 7) then
    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON START LINE")
  end
  AUT_LastRaceTag = 1
  Print(GetPlayer(), (("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_AUT_LastRaceTag set to " .. AUT_LastRaceTag) .. " "))
  return 
end
AUT_PlayerHitsArea02 = function()
  Print(GetPlayer(), (((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsArea02 called - Autotopia_RaceState set to " .. GetGlobal("Autotopia_RaceState")) .. ". AUT_RaceActive set to ") .. AUT_RaceActive) .. ". "))
  if (AUT_RaceActive < 7) then
    if (GetGlobal("Autotopia_RaceState") == 0) then
      if (AUT_LastRaceTag == 3) then
        AUT_LastRaceTag = 2
        Print(GetPlayer(), (("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsArea02 called - AUT_LastRaceTag set to " .. AUT_LastRaceTag) .. " "))
      end
    end
  elseif (AUT_RaceActive < 7) then
    if (GetGlobal("Autotopia_RaceState") == 1) then
      if (AUT_LastRaceTag == 3) then
        AUT_LastRaceTag = 2
        Print(GetPlayer(), (("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsArea02 called - AUT_LastRaceTag set to " .. AUT_LastRaceTag) .. " "))
      end
    end
  elseif (AUT_RaceActive < 7) then
    if (GetGlobal("Autotopia_RaceState") == 2) then
      if (AUT_LastRaceTag == 1) then
        AUT_LastRaceTag = 2
        Print(GetPlayer(), (("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsArea02 called - AUT_LastRaceTag set to " .. AUT_LastRaceTag) .. " "))
      end
    end
  elseif (AUT_RaceActive < 7) then
    if (GetGlobal("Autotopia_RaceState") == 3) then
      if (AUT_LastRaceTag == 1) then
        AUT_LastRaceTag = 2
        Print(GetPlayer(), (("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsArea02 called - AUT_LastRaceTag set to " .. AUT_LastRaceTag) .. " "))
      end
    end
  else
    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsArea02 called - FAILED PASS CHECK")
  end
  return 
end
AUT_PlayerHitsArea03 = function()
  Print(GetPlayer(), (((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_PlayerHitsArea03 called - Autotopia_RaceState set to " .. GetGlobal("Autotopia_RaceState")) .. ". AUT_RaceActive set to ") .. AUT_RaceActive) .. ". "))
  if (AUT_RaceActive < 7) then
    if (GetGlobal("Autotopia_RaceState") == 0) then
      if (AUT_LastRaceTag == 1) then
        AUT_LastRaceTag = 3
        Print(GetPlayer(), (("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_AUT_LastRaceTag set to " .. AUT_LastRaceTag) .. " "))
      end
    end
  elseif (AUT_RaceActive < 7) then
    if (GetGlobal("Autotopia_RaceState") == 1) then
      if (AUT_LastRaceTag == 1) then
        AUT_LastRaceTag = 3
        Print(GetPlayer(), (("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_AUT_LastRaceTag set to " .. AUT_LastRaceTag) .. " "))
      end
    end
  elseif (AUT_RaceActive < 7) then
    if (GetGlobal("Autotopia_RaceState") == 2) then
      if (AUT_LastRaceTag == 2) then
        AUT_LastRaceTag = 3
        Print(GetPlayer(), (("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_AUT_LastRaceTag set to " .. AUT_LastRaceTag) .. " "))
      end
    end
  elseif (AUT_RaceActive < 7) then
    if (GetGlobal("Autotopia_RaceState") == 3) then
      if (AUT_LastRaceTag == 2) then
        AUT_LastRaceTag = 3
        Print(GetPlayer(), (("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_AUT_LastRaceTag set to " .. AUT_LastRaceTag) .. " "))
      end
    end
  else
    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_FAILED PASS CHECK ON THIRD ZONE")
  end
  return 
end
AUT_LaunchRace = function()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls UnrestrictCutSceneInput()")
  UnrestrictCutSceneInput()
  Wait(0.10000000149011612)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace called! AUT_RaceActive = 1")
  AUT_RaceActive = 1
  if (GetGlobal("Autotopia_RaceState") == 0) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 0; Fire First Race!")
    if (GetGlobal("Autotopia_Core_Progression") == 2) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
      AUT_TimeTrial_Start(50, 20, 10, 0)
    elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
      AUT_DerbyStart(80, 20, 10, 1)
      if (GetGlobal("Autotopia_RaceState") == 1) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 1; Fire Second Race")
        if (GetGlobal("Autotopia_Core_Progression") == 2) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
          AUT_TimeTrial_Start(105, 20, 10, 0)
        elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
          AUT_DerbyStart(70, 20, 10, 2)
          if (GetGlobal("Autotopia_RaceState") == 2) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 2; Fire Third Race")
            if (GetGlobal("Autotopia_Core_Progression") == 2) then
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
              AUT_TimeTrial_Start(95, 20, 10, 1)
            elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
              AUT_DerbyStart(60, 20, 10, 4)
              if (GetGlobal("Autotopia_RaceState") == 3) then
                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 3; Fire Practice Race Finale")
                if (GetGlobal("Autotopia_Core_Progression") == 2) then
                  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
                  AUT_TimeTrial_Start(80, 20, 10, 1)
                elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
                  AUT_DerbyStart(60, 20, 10, 4)
                end
              end
            end
          elseif (GetGlobal("Autotopia_RaceState") == 3) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 3; Fire Practice Race Finale")
            if (GetGlobal("Autotopia_Core_Progression") == 2) then
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
              AUT_TimeTrial_Start(80, 20, 10, 1)
            elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
              AUT_DerbyStart(60, 20, 10, 4)
            end
          end
        end
      elseif (GetGlobal("Autotopia_RaceState") == 2) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 2; Fire Third Race")
        if (GetGlobal("Autotopia_Core_Progression") == 2) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
          AUT_TimeTrial_Start(95, 20, 10, 1)
        elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
          AUT_DerbyStart(60, 20, 10, 4)
          if (GetGlobal("Autotopia_RaceState") == 3) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 3; Fire Practice Race Finale")
            if (GetGlobal("Autotopia_Core_Progression") == 2) then
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
              AUT_TimeTrial_Start(80, 20, 10, 1)
            elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
              AUT_DerbyStart(60, 20, 10, 4)
            end
          end
        end
      elseif (GetGlobal("Autotopia_RaceState") == 3) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 3; Fire Practice Race Finale")
        if (GetGlobal("Autotopia_Core_Progression") == 2) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
          AUT_TimeTrial_Start(80, 20, 10, 1)
        elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
          AUT_DerbyStart(60, 20, 10, 4)
        end
      end
    end
  elseif (GetGlobal("Autotopia_RaceState") == 1) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 1; Fire Second Race")
    if (GetGlobal("Autotopia_Core_Progression") == 2) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
      AUT_TimeTrial_Start(105, 20, 10, 0)
    elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
      AUT_DerbyStart(70, 20, 10, 2)
      if (GetGlobal("Autotopia_RaceState") == 2) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 2; Fire Third Race")
        if (GetGlobal("Autotopia_Core_Progression") == 2) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
          AUT_TimeTrial_Start(95, 20, 10, 1)
        elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
          AUT_DerbyStart(60, 20, 10, 4)
          if (GetGlobal("Autotopia_RaceState") == 3) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 3; Fire Practice Race Finale")
            if (GetGlobal("Autotopia_Core_Progression") == 2) then
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
              AUT_TimeTrial_Start(80, 20, 10, 1)
            elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
              AUT_DerbyStart(60, 20, 10, 4)
            end
          end
        end
      elseif (GetGlobal("Autotopia_RaceState") == 3) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 3; Fire Practice Race Finale")
        if (GetGlobal("Autotopia_Core_Progression") == 2) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
          AUT_TimeTrial_Start(80, 20, 10, 1)
        elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
          AUT_DerbyStart(60, 20, 10, 4)
        end
      end
    end
  elseif (GetGlobal("Autotopia_RaceState") == 2) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 2; Fire Third Race")
    if (GetGlobal("Autotopia_Core_Progression") == 2) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
      AUT_TimeTrial_Start(95, 20, 10, 1)
    elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
      AUT_DerbyStart(60, 20, 10, 4)
      if (GetGlobal("Autotopia_RaceState") == 3) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 3; Fire Practice Race Finale")
        if (GetGlobal("Autotopia_Core_Progression") == 2) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
          AUT_TimeTrial_Start(80, 20, 10, 1)
        elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
          AUT_DerbyStart(60, 20, 10, 4)
        end
      end
    end
  elseif (GetGlobal("Autotopia_RaceState") == 3) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace finds Autotopia_RaceState == 3; Fire Practice Race Finale")
    if (GetGlobal("Autotopia_Core_Progression") == 2) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_TimeTrial_Start")
      AUT_TimeTrial_Start(80, 20, 10, 1)
    elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_LaunchRace calls AUT_DerbyStart")
      AUT_DerbyStart(60, 20, 10, 4)
    end
  end
  return 
end
AUT_Derby01_IntroPlayed = 0
AUT_ShowGildaIntro = function(RaceNum)
  Print((((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_ShowGildaIntro called! RaceNum value is " .. RaceNum) .. " and Autotopia_GildaQualified == ") .. GetGlobal("Autotopia_GildaQualified")) .. "!!"))
  if (GetGlobal("Autotopia_GildaQualified") ~= 1) then
    DoStinger("Stinger_Moment", 1)
    SetGlobal("Autotopia_GildaQualified", 1)
    AUT_RaceActive = 0
    if (GetGlobal("Autotopia_Core_Progression") == 3) then
      ForEachEntityInGroup(Unhide, "Derby01Obstacle")
      ForEachEntityInGroup(Unhide, "Derby02Obstacle")
      ForEachEntityInGroup(Unhide, "Derby03Obstacle")
      ForEachEntityInGroup(Unhide, "Derby04Obstacle")
    end
    AUT_GildaIntroCam(GetPlayer(), "tcy_autotopia_02a_race.SplineKnot 21", "GildaRaceIntroCam01", 0.5)
    wait(4.5)
    if (RaceNum == 1) then
      AUT_GildaIntroCam(GetPlayer(), "tcy_autotopia_02a_race.SplineKnot 24", "GildaRaceIntroCam02", 0.5)
      wait(4.5)
      if (GetGlobal("Autotopia_Core_Progression") == 3) then
        ForceSequence("Gilda Marker(Conversation) 01", "AUT_v2_DerbyLaunch01")
      else
        ForceSequence("Gilda Marker(Conversation) 01", "AUT_v2_TrialLaunch01")
        AUT_GildaIntroCam(GetPlayer(), "tcy_autotopia_02a_race.SplineKnot 07", "GildaRaceIntroCam03", 0.5)
        wait(4.5)
        if (GetGlobal("Autotopia_Core_Progression") == 3) then
          ForceSequence("Gilda Marker(Conversation) 01", "AUT_v2_DerbyLaunch02")
        else
          ForceSequence("Gilda Marker(Conversation) 01", "AUT_v2_TrialLaunch02")
          AUT_RacesFire()
        end
      end
    end
    AUT_GildaIntroCam(GetPlayer(), "tcy_autotopia_02a_race.SplineKnot 07", "GildaRaceIntroCam03", 0.5)
    wait(4.5)
    if (GetGlobal("Autotopia_Core_Progression") == 3) then
      ForceSequence("Gilda Marker(Conversation) 01", "AUT_v2_DerbyLaunch02")
    else
      ForceSequence("Gilda Marker(Conversation) 01", "AUT_v2_TrialLaunch02")
      AUT_RacesFire()
    end
  else
    AUT_RacesFire()
  end
  return 
end
GildaReset = function()
  wait(1)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* GildaReset calls StartFadeOut")
  StartFadeOut(0.5)
  wait(0.5)
  SetSplineFollowerInitialSpeed("GildaRace_SplineFollower 01", 0)
  SetPropertyInt("Gilda", "Collision Layer", 4)
  EnableMotion("Gilda")
  AI_SetDisabled("Gilda", false)
  ClearParent("Gilda")
  ZeroCharacterVelocity("Gilda")
  MoveToEntity("Gilda", "GildaCarPositionMarker 05")
  EnableSplitScreen(true)
  AUT_GildaUnrestrictFlag = 1
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* GildaReset calls AUT_RacesFire")
  if (GetGlobal("Autotopia_Core_Progression") == 3) then
    ForEachEntityInGroup(Hide, "Derby01Obstacle")
    ForEachEntityInGroup(Hide, "Derby02Obstacle")
    ForEachEntityInGroup(Hide, "Derby03Obstacle")
    ForEachEntityInGroup(Hide, "Derby04Obstacle")
  end
  AUT_RacesFire()
  return 
end
AUT_MovePlayerCarToStart = function()
  MoveToEntity("PhysMotor01", "tcy_autotopia_02a.RaceStart_AutoPositionMarkerFwd 01")
  return 
end
AUT_Timer_Music = function()
  local TimeLeft = TimerGetTime()
  if (TimeLeft < 20) then
    if (19 < TimeLeft) then
      ReplaceMusicStateOverride("AUT_Race2")
      Print("Switched to med intensity race music")
    end
  elseif (TimeLeft < 10) then
    if (9 < TimeLeft) then
      ReplaceMusicStateOverride("AUT_Race3")
      Print("Switched to high intensity race music")
    end
  end
  return 
end
AUT_DerbyStart = function(tmax, tmid, tmin, obstacles)
  Print("*_**_*_**_**_*_*_**_*_*_**_*_*_*_**_*_*_*_* DERBY BEGINS!")
  ReplaceMusicStateOverride("AUT_Race1")
  Print("Started derby music")
  LoadQuestItemTexture("Auto_Derby_Target")
  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
    ForceSpawn("RaceNitroSpawner 01", 1)
  end
  if (0 < obstacles) then
    ForEachEntityInGroup(Unhide, "Derby01Obstacle")
  end
  if (1 < obstacles) then
    ForEachEntityInGroup(Unhide, "Derby02Obstacle")
  end
  if (2 < obstacles) then
    ForEachEntityInGroup(Unhide, "Derby03Obstacle")
  end
  if (3 < obstacles) then
    ForEachEntityInGroup(Unhide, "Derby04Obstacle")
  end
  TimerStart(tmax, tmid, tmin)
  local timerstate = "Ticking"
  while (timerstate == "Ticking") do
    wait(0.30000001192092896)
    timerstate = TimerGetState()
    AUT_Timer_Music()
  end
  AUT_RaceActive = 0
  ForEachEntityInGroup(Hide, "Derby01Obstacle")
  ForEachEntityInGroup(Hide, "Derby02Obstacle")
  ForEachEntityInGroup(Hide, "Derby03Obstacle")
  ForEachEntityInGroup(Hide, "Derby04Obstacle")
  ForceInterruptSequence("Marker(Conversation) Gus 01", "AUT_Gus_ExitCar")
  AUT_DerbyFinish()
  return 
end
AUT_Derby_SmashItem = function(target, plyr)
  Hide(target)
  SetPropertyEntity("DerbyTargetBreak_Spawner 01", "Spawn Destinations", target, 0)
  ForceSpawn("DerbyTargetBreak_Spawner 01", 1)
  if (plyr == "one") then
    AudioPostEventOn("PhysMotor01", "Play_sfx_breakable_targets")
  elseif (plyr == "two") then
    AudioPostEventOn("PhysMotor02", "Play_sfx_breakable_targets")
  end
  if (0 < AUT_RaceActive) then
    GiveCollectible("Auto_Derby_Target")
    AUT_Derby_TotalScore = (AUT_Derby_TotalScore + 1)
    Print(GetPlayer(), (("Score Total " .. AUT_Derby_TotalScore) .. " "), 2)
  end
  return 
end
AUT_Spawned_SmashEffects = function(target)
  ApplyImpulseFromCenter(target, 10000)
  Wait(2)
  local (for index), (for limit), (for step) = 1, 0, -0.05000000074505806
  for a = (for index), (for limit), (for step) do
    SetR3MTConstRegAlpha(target, 3, a)
    Wait(0.05000000074505806)
  end
  Wait(0.10000000149011612)
  DestroyEntity(target)
  return 
end
AUT_Derby_TotalScore = 0
AUT_DerbyFinish = function()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_DerbyFinish called! Firing AUT_TrophyRewardsIntro")
  AUT_TrophyRewardsIntro()
  ForEachEntityInGroup(DestroyEntity, "RaceNitroPickup")
  if (GetGlobal("Autotopia_RaceState") == 0) then
    if (19 < AUT_Derby_TotalScore) then
      RaceWinMusic()
      Print("Win derby music")
      ForceSequence("Stuffus", "AUT_Stuffus_DerbyWon")
      MoveToEntity(GetPlayer(), "Trophy_PositionMarker 01")
      MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 02")
      MoveToEntity("Gilda", "Trophy_PositionMarker 03")
      SetGlobal("Autotopia_GildaQualified", 0)
      AUT_RaceActive = 7
    else
      RaceLoseMusic()
      Print("Lose derby music")
      ForceSequence("Stuffus", "AUT_Stuffus_DerbyLost")
      MoveToEntity(GetPlayer(), "Trophy_PositionMarker 02")
      MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 03")
      MoveToEntity("Gilda", "Trophy_PositionMarker 01")
    end
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_DerbyFinish gives Challenge_RaceAutotopia_Tracker for completing a race.")
    GiveCollectible("Challenge_RaceAutotopia_Tracker")
  elseif (GetGlobal("Autotopia_RaceState") == 1) then
    if (29 < AUT_Derby_TotalScore) then
      ForceSequence("Stuffus", "AUT_Stuffus_DerbyWon")
      MoveToEntity(GetPlayer(), "Trophy_PositionMarker 01")
      MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 02")
      MoveToEntity("Gilda", "Trophy_PositionMarker 03")
      SetGlobal("Autotopia_GildaQualified", 0)
      AUT_RaceActive = 7
    else
      ForceSequence("Stuffus", "AUT_Stuffus_DerbyLost")
      MoveToEntity(GetPlayer(), "Trophy_PositionMarker 02")
      MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 03")
      MoveToEntity("Gilda", "Trophy_PositionMarker 01")
      if (GetGlobal("Autotopia_RaceState") == 2) then
        if (44 < AUT_Derby_TotalScore) then
          ForceSequence("Stuffus", "AUT_Stuffus_DerbyWon")
          MoveToEntity(GetPlayer(), "Trophy_PositionMarker 01")
          MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 02")
          MoveToEntity("Gilda", "Trophy_PositionMarker 03")
          SetGlobal("Autotopia_GildaQualified", 0)
          AUT_RaceActive = 7
        else
          ForceSequence("Stuffus", "AUT_Stuffus_DerbyLost")
          MoveToEntity(GetPlayer(), "Trophy_PositionMarker 02")
          MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 03")
          MoveToEntity("Gilda", "Trophy_PositionMarker 01")
          if (GetGlobal("Autotopia_RaceState") == 3) then
            if (44 < AUT_Derby_TotalScore) then
              ForceSequence("Stuffus", "AUT_Stuffus_DerbyWon")
              MoveToEntity(GetPlayer(), "Trophy_PositionMarker 01")
              MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 02")
              MoveToEntity("Gilda", "Trophy_PositionMarker 03")
              SetGlobal("Autotopia_GildaQualified", 0)
              AUT_RaceActive = 7
            else
              ForceSequence("Stuffus", "AUT_Stuffus_DerbyLost")
              MoveToEntity(GetPlayer(), "Trophy_PositionMarker 02")
              MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 03")
              MoveToEntity("Gilda", "Trophy_PositionMarker 01")
            end
          end
        end
      elseif (GetGlobal("Autotopia_RaceState") == 3) then
        if (44 < AUT_Derby_TotalScore) then
          ForceSequence("Stuffus", "AUT_Stuffus_DerbyWon")
          MoveToEntity(GetPlayer(), "Trophy_PositionMarker 01")
          MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 02")
          MoveToEntity("Gilda", "Trophy_PositionMarker 03")
          SetGlobal("Autotopia_GildaQualified", 0)
          AUT_RaceActive = 7
        else
          ForceSequence("Stuffus", "AUT_Stuffus_DerbyLost")
          MoveToEntity(GetPlayer(), "Trophy_PositionMarker 02")
          MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 03")
          MoveToEntity("Gilda", "Trophy_PositionMarker 01")
        end
      end
    end
  elseif (GetGlobal("Autotopia_RaceState") == 2) then
    if (44 < AUT_Derby_TotalScore) then
      ForceSequence("Stuffus", "AUT_Stuffus_DerbyWon")
      MoveToEntity(GetPlayer(), "Trophy_PositionMarker 01")
      MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 02")
      MoveToEntity("Gilda", "Trophy_PositionMarker 03")
      SetGlobal("Autotopia_GildaQualified", 0)
      AUT_RaceActive = 7
    else
      ForceSequence("Stuffus", "AUT_Stuffus_DerbyLost")
      MoveToEntity(GetPlayer(), "Trophy_PositionMarker 02")
      MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 03")
      MoveToEntity("Gilda", "Trophy_PositionMarker 01")
      if (GetGlobal("Autotopia_RaceState") == 3) then
        if (44 < AUT_Derby_TotalScore) then
          ForceSequence("Stuffus", "AUT_Stuffus_DerbyWon")
          MoveToEntity(GetPlayer(), "Trophy_PositionMarker 01")
          MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 02")
          MoveToEntity("Gilda", "Trophy_PositionMarker 03")
          SetGlobal("Autotopia_GildaQualified", 0)
          AUT_RaceActive = 7
        else
          ForceSequence("Stuffus", "AUT_Stuffus_DerbyLost")
          MoveToEntity(GetPlayer(), "Trophy_PositionMarker 02")
          MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 03")
          MoveToEntity("Gilda", "Trophy_PositionMarker 01")
        end
      end
    end
  elseif (GetGlobal("Autotopia_RaceState") == 3) then
    if (44 < AUT_Derby_TotalScore) then
      ForceSequence("Stuffus", "AUT_Stuffus_DerbyWon")
      MoveToEntity(GetPlayer(), "Trophy_PositionMarker 01")
      MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 02")
      MoveToEntity("Gilda", "Trophy_PositionMarker 03")
      SetGlobal("Autotopia_GildaQualified", 0)
      AUT_RaceActive = 7
    else
      ForceSequence("Stuffus", "AUT_Stuffus_DerbyLost")
      MoveToEntity(GetPlayer(), "Trophy_PositionMarker 02")
      MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 03")
      MoveToEntity("Gilda", "Trophy_PositionMarker 01")
    end
  end
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_DerbyFinish calls StartFadeIn 0.5")
  StartFadeIn(0.5)
  wait(5)
  return 
end
AUT_TimerInterrupt = 0
AUT_TimeTrial_Start = function(tmax, tmid, tmin, dir)
  ReplaceMusicStateOverride("AUT_Race1")
  Print("Started time trial music")
  StartEmitters("fx_guardian_race 01")
  ForEachEntityInGroup(AUT_StartPaintHazard, "racePumpPipes")
  if (dir == 1) then
    Reverse("fx_guardian_race 01")
  end
  local ghostSpd = 0
  local ghostDst = 552
  if (60 < tmax) then
    ghostDst = 1124
  end
  ghostSpd = (ghostDst / (tmax - 1))
  SetSplineFollowerInitialSpeed("fx_guardian_race 01", ghostSpd)
  SplineFollower_TeleportToKnot("fx_guardian_race 01", "SplineKnot 49")
  if (GetGlobal("Autotopia_Garage_Opened") == 1) then
    ForceSpawn("RaceNitroSpawner 01", 1)
  end
  TimerStart(tmax, tmid, tmin)
  local timerstate = "Ticking"
  while (timerstate == "Ticking") do
    wait(0.30000001192092896)
    timerstate = TimerGetState()
    AUT_Timer_Music()
  end
  if (dir == 1) then
    Reverse("fx_guardian_race 01")
  end
  AUT_TimerInterrupt = 0
  AUT_TimeTrialOver()
  return 
end
AUT_TimeTrialOver = function()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TimeTrialOver called!")
  if (AUT_RaceActive ~= 7) then
    AUT_RaceActive = 7
    ForceInterruptSequence("Marker(Conversation) Gus 01", "AUT_Gus_ExitCar")
    if (AUT_TimerInterrupt == 0) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TimeTrialOver called! AUT_TimerInterrupt == 0; Race was lost.")
      RaceLoseMusic()
      Print("Lose time trial music")
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TimeTrialOver calls AUT_TrophyRewardsIntro.")
      AUT_TrophyRewardsIntro()
      ForEachEntityInGroup(DestroyEntity, "RaceNitroPickup")
      MoveToEntity(GetPlayer(), "Trophy_PositionMarker 02")
      MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 03")
      MoveToEntity("Gilda", "Trophy_PositionMarker 01")
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TimeTrialOver calls AUT_MovePlayerCarToStart.")
      AUT_MovePlayerCarToStart()
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TimeTrialOver now firing sequence AUT_Stuffus_TimeTrialLost.")
      StartFadeIn(0.5)
      ForceSequence("Stuffus", "AUT_Stuffus_TimeTrialLost")
    else
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TimeTrialOver called! AUT_TimerInterrupt was NOT zero, skipping finale.")
    end
    StopEmitters("fx_guardian_race 01")
    ForEachEntityInGroup(AUT_ShutdownPaintHazard, "racePumpPipes")
    AUT_TimerInterrupt = 0
  end
  return 
end
AUT_TimeTrialFinish = function(carIdent)
  if (AUT_RaceActive ~= 7) then
    AUT_RaceActive = 7
    ForceInterruptSequence("Marker(Conversation) Gus 01", "AUT_Gus_ExitCar")
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TimeTrialFinish called; race was won! AUT_TimeTrialFinish calls AUT_TrophyRewardsIntro")
    AUT_TrophyRewardsIntro()
    ForEachEntityInGroup(DestroyEntity, "RaceNitroPickup")
    TimerPause()
    local TimeLeft = TimerGetTime()
    AUT_Trial_TimeLeft = (TimeLeft * 2)
    RaceWinMusic()
    Print("Win time trial music")
    if (carIdent == "1") then
      MoveToEntity(GetPlayer(), "Trophy_PositionMarker 01")
      MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 02")
    else
      MoveToEntity(GetPlayer(), "Trophy_PositionMarker 02")
      MoveToEntity(GetPlayerOrAI(PLAYER_TWO), "Trophy_PositionMarker 01")
    end
    MoveToEntity("Gilda", "Trophy_PositionMarker 03")
    AUT_MovePlayerCarToStart()
    ForceSequence("Stuffus", "AUT_Stuffus_TimeTrialWon")
    SetGlobal("Autotopia_GildaQualified", 0)
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TimeTrialFinish calls StartFadeIn 0.5")
    StartFadeIn(0.5)
    wait(5)
    AUT_TimerInterrupt = 1
    TimerStop()
  end
  return 
end
AUT_TrophyRewardsIntro = function()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TrophyRewardsIntro called! Calling StartFadeOut")
  StartFadeOut(0.5)
  wait(0.5)
  AUT_QuickEject()
  Unhide("TrophyCar")
  SetRotatorMaxSpeed("Trophy_CarMarker(Rotatable) 01", 30)
  SetCameraAttributesForPlayer("Trophy_CameraMarker(CameraOverride) 01", nil)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TrophyRewardsIntro calls RestrictCutSceneInput()!")
  RestrictCutSceneInput()
  return 
end
AUT_TrophyRewardsReset = function()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TrophyRewardsReset called; firing sequence AUT_Stuffus_RaceContinue!")
  wait(0.10000000149011612)
  ForceSequence("Stuffus", "AUT_Stuffus_RaceContinue")
  return 
end
AUT_TrophyRewardsShutdown = function()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TrophyRewardsShutdown called (from sequence AUT_Stuffus_RaceContinue)!")
  ClearCameraAttributesForPlayer("Trophy_CameraMarker(CameraOverride) 01", nil)
  Hide("TrophyCar")
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TrophyRewardsShutdown calls UnrestrictCutSceneInput()!")
  UnrestrictCutSceneInput()
  SplineFollower_TeleportToKnot("GildaRace_SplineFollower 01", "tcy_autotopia_02a.SplineKnot 18")
  MoveToEntity("GildaRacer", "GildaRace_SplineFollower 01")
  SetParent("GildaRacer", "GildaRace_SplineFollower 01")
  SetSplineFollowerInitialSpeed("GildaRace_SplineFollower 01", 22)
  Hide("Gilda")
  SetRotatorMaxSpeed("Trophy_CarMarker(Rotatable) 01", 0)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TrophyRewardsShutdown calls AUT_RestorePlayerCars!")
  AUT_RestorePlayerCars()
  AUT_TimerInterrupt = 0
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TrophyRewardsShutdown calls StartFadeIn!")
  StartFadeIn(0.5)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_TrophyRewardsShutdown calls AUT_GetOut_Confirm!")
  AUT_GetOut_Confirm()
  return 
end
AUT_DerbyPayOut = function()
  local MetalPayout = math.floor((AUT_Derby_TotalScore * 1.5))
  AddCurrency("ScrapMetal", MetalPayout)
  AUT_Derby_TotalScore = 0
  GiveQuestItems("Auto_Derby_Target", (-GetCurrentCount("Auto_Derby_Target")))
  return 
end
AUT_Trial_TimeLeft = 0
AUT_TrialPayOut = function()
  local CashPayout = math.floor((AUT_Trial_TimeLeft * 5))
  AddCurrency("ETicket", CashPayout)
  AUT_Trial_TimeLeft = 0
  AUT_TimerInterrupt = 0
  return 
end
AUT_RestorePlayerCars = function()
  MoveToEntity("PhysMotor01", "ExitVehicle_CarPositionMarker 01")
  MoveToEntity("PhysMotor02", "ExitVehicle_CarPositionMarker 02")
  return 
end
atCar_HornOn = 0
atCar_RadioOn = 0
AUT_HornShutDown = function()
  if (atCar_HornOn == 1) then
    atCar_HornOn = 0
    AudioPostEventOn(GetPlayer(), "Stop_SFX_Veh_Mickey_Horn")
  end
  return 
end
atCar_Horn = function(target, y_in)
  if (0 < y_in) then
    if (atCar_HornOn == 0) then
      if (AUT_PlayerInCar == 1) then
        atCar_HornOn = 1
        AudioPostEventOn(GetPlayer(), "Play_SFX_Veh_Mickey_Horn")
      end
    end
  elseif (y_in < 0) then
    if (atCar_RadioOn == 0) then
      if (AUT_PlayerInCar == 1) then
        atCar_RadioOn = 1
        AudioPostEventOn(GetPlayer(), "Play_SFX_Veh_Radio_On")
        AddMusicStateOverride("Radio")
      end
    end
  elseif (y_in == 0) then
    if (atCar_RadioOn == 1) then
      if (AUT_PlayerInCar == 1) then
        atCar_RadioOn = 2
      end
    end
  elseif (y_in < 0) then
    if (atCar_RadioOn == 2) then
      if (AUT_PlayerInCar == 1) then
        atCar_RadioOn = 3
        AudioPostEventOn(GetPlayer(), "Play_SFX_Veh_Radio_Off")
        RemoveMusicStateOverride("Radio")
      end
    end
  elseif (y_in == 0) then
    if (atCar_RadioOn == 3) then
      if (AUT_PlayerInCar == 1) then
        atCar_RadioOn = 0
      end
    end
  end
  if (y_in == 0) then
    if (atCar_HornOn == 1) then
      if (AUT_PlayerInCar == 1) then
        atCar_HornOn = 0
        AudioPostEventOn(GetPlayer(), "Stop_SFX_Veh_Mickey_Horn")
      end
    end
  end
  return 
end
atCar_BrakeLight = function(target, plyrnum)
  if (plyrnum == "1") then
    if (AUT_PlayerInCar == 1) then
      if (AUT_CarIgnition == 1) then
        AnimGBSequence("BrakeLights 01", "On")
      end
    end
  elseif (AUT_PlayerInCar == 1) then
    if (AUT_CarIgnition == 1) then
      AnimGBSequence("BrakeLights 02", "On")
    end
  end
  return 
end
atCar_ReleaseBrake = function(target, plyrnum)
  if (plyrnum == "1") then
    if (AUT_PlayerInCar == 1) then
      if (AUT_CarIgnition == 1) then
        AnimGBSequence("BrakeLights 01", "Off")
      end
    end
  elseif (AUT_PlayerInCar == 1) then
    if (AUT_CarIgnition == 1) then
      AnimGBSequence("BrakeLights 02", "Off")
    end
  end
  return 
end
AUT_CarHitsBooster = function(target, playernum)
  Hide(_self())
  if (playernum == "1") then
    VehicleDrag("PhysMotor01", false)
    VehicleNitro("PhysMotor01")
    AnimGBSequence("CarNitro", "NitroBoost")
    FireThread(AUT_KillNitroFlames, 1)
  elseif (playernum == "2") then
    VehicleDrag("PhysMotor02", false)
    VehicleNitro("PhysMotor02")
    AnimGBSequence("CarNitro 02", "NitroBoost")
    FireThread(AUT_KillNitroFlames, 2)
  end
  Print(GetPlayer(), "**************************************************************************** PLAYER USES BOOOOOOOOOOOOOOOOOOST!!!!")
  AudioPostEventOn(GetPlayer(), "Play_SFX_Veh_Mickey_Turbo")
  Print("SFX Turbo boost")
  return 
end
AUT_FirstNitroGrabbed = 0
AUT_CarNitroPickup = function(target)
  if (GetCurrentCount("Racing_NitroPickup") < 3) then
    GiveQuestItems("Racing_NitroPickup", 1)
    Hide(_self())
    if (AUT_FirstNitroGrabbed == 0) then
      AUT_FirstNitroGrabbed = 1
      FireSequence("Marker(Conversation) Gus 01", "Tutorial_Driving3Training")
    end
  end
  return 
end
AUT_FireCarNitro = function(target, playernum)
  if (0 < GetCurrentCount("Racing_NitroPickup")) then
    if (AUT_PlayerInCar == 1) then
      if (playernum == "1") then
        VehicleDrag("PhysMotor01", false)
        VehicleNitro("PhysMotor01")
        AnimGBSequence("CarNitro", "NitroBoost")
        FireThread(AUT_KillNitroFlames, 1)
      elseif (playernum == "2") then
        VehicleDrag("PhysMotor02", false)
        VehicleNitro("PhysMotor02")
        AnimGBSequence("CarNitro 02", "NitroBoost")
        FireThread(AUT_KillNitroFlames, 2)
      end
      Print(GetPlayer(), "**************************************************************************** PLAYER USES BOOOOOOOOOOOOOOOOOOST!!!!")
      AudioPostEventOn(GetPlayer(), "Play_SFX_Veh_Mickey_Turbo")
      Print("SFX Turbo boost")
      GiveQuestItems("Racing_NitroPickup", -1)
    end
  elseif (AUT_PlayerInCar == 1) then
    Display(GetPlayer(), "No boosts remaining!!", 2)
  end
  return 
end
AUT_KillNitroFlames = function(carnum)
  wait(3)
  if (carnum == 1) then
    AnimGBSequence("CarNitro", "NitroIdle")
  else
    AnimGBSequence("CarNitro 02", "NitroIdle")
  end
  return 
end
AUT_CarHitsPaintHazard = function(target, carTag)
  if (GetGlobal("Autotopia_Core_Progression") == 2) then
    if (carTag == "1") then
      VehicleDrag("PhysMotor01", true)
      StartEmitters("Vehicle_inkExhaust_01a 01")
      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* SLOW PLAYER 01 DOWN")
      wait(3)
      VehicleDrag("PhysMotor01", false)
      StopEmitters("Vehicle_inkExhaust_01a 01")
    else
      VehicleDrag("PhysMotor02", true)
      StartEmitters("Vehicle_inkExhaust_01a 02")
      Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* SLOW PLAYER 02 DOWN")
      wait(3)
      VehicleDrag("PhysMotor02", false)
      StopEmitters("Vehicle_inkExhaust_01a 02")
    end
  end
  return 
end
AUT_StartPaintHazard = function(target)
  local data = GetPrefabData(target)
  Unhide(GetRelativePrefabEntity(target, ".paint"))
  return 
end
AUT_ShutdownPaintHazard = function(target)
  local data = GetPrefabData(target)
  Hide(GetRelativePrefabEntity(target, ".paint"))
  return 
end
AUT_DaisyQuest_Machine = function(target, event, obj)
  local score = GetPictureScoreFromEvent(event)
  Print(((("Photo " .. obj) .. " ") .. tostring(score)))
  if (score == 1) then
    FireSequence("Marker(Conversation) Gus 01", "AUT_v2_DaisyQuestPhoto")
  end
  return 
end
AUT_MagicHatQuest_GildaPhotoCheckOnLoad = function()
  if (GetGlobal("AUT_GildaPictureTaken") == 1) then
    ForEachEntityInGroup(DestroyEntity, "GildaCameraPosition Marker (Camera Ability) 01")
  end
  return 
end
AUT_MagicHatQuest_GildaPhoto = function(target, event, obj)
  local score = GetPictureScoreFromEvent(event)
  Print(((("Photo " .. obj) .. " ") .. tostring(score)))
  if (score == 1) then
    ForEachEntityInGroup(DestroyEntity, "GildaCameraPosition Marker (Camera Ability) 01")
    FireSequence("Marker(Conversation) Gus 01", "AUT_v2_MagicHatPhoto")
  end
  return 
end
RaceWinMusic = function()
  ReplaceMusicStateOverride("Boss_Win")
  wait(2)
  RemoveAllMusicStateOverride()
  return 
end
RaceLoseMusic = function()
  ReplaceMusicStateOverride("Boss_Lose")
  wait(2)
  RemoveAllMusicStateOverride()
  return 
end
