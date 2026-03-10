TopToonGuardianRepaint = false
thinnerHasReachedTop = false
SpiderBoss_VulnerabilityOverride = true
cutscene_busy = false
ThinnerResetBlock = 2
local MapActivator = false
ThinnerStage = 0
NewRide_SetInnerCameraAttributesForPlayer = function(target, camera)
  SetCameraAttributesForPlayer(camera, target)
  return 
end
NewRide_ClearInnerCameraAttributesForPlayer = function(target, camera)
  ClearCameraAttributesForPlayer(camera, target)
  return 
end
spiderBoss_BattleStage = 0
SpiderBoss_3_Visit2Setup = function(target)
  MusicPostEventOn(GetPlayer(), "Play_MX_BossNewRide")
  AudioPostEventOn(GetPlayer(), "Set_Volume_MX_Boss_NewRide")
  ReplaceMusicStateOverride("Combat_Lev3")
  Print("Started music event and stage 3 state from SpiderBoss_3_Visit2Setup")
  ForEachEntityInGroup(DestroyEntity, "DestroyForV2")
  AudioEffectStart("mst_maddoctornewride_02a_audio.SND_phase3_reverb")
  Print(("SpiderBoss_3_Visit2Setup : The MSN_FromTomCityProjector global value is: " .. GetGlobal("MSN_FromTomCityProjector")))
  if (GetGlobal("MSN_FromTomCityProjector") == 1) then
    Print("SpiderBoss_3_Visit2Setup : Exiting MSN projector")
    SetGlobal("MSN_FromTomCityProjector", 0)
    GetPrefabData("ProjectorToMeanStreets").MapLoad_SetupPosition = "True"
    GetPrefabData("ProjectorToAttic").MapLoad_SetupPosition = "IgnoreMe"
  else
    Print("SpiderBoss_3_Visit2Setup : Exiting Attic projector")
    GetPrefabData("ProjectorToMeanStreets").MapLoad_SetupPosition = "IgnoreMe"
    GetPrefabData("ProjectorToAttic").MapLoad_SetupPosition = "True"
  end
  return 
end
SpiderBoss_3_ObservatoryItemSave = function()
  SaveCheckpoint(GetPlayer(), LastCheckpointLoadFunction, LastCheckpointPos_Mickey, LastCheckpointPos_Oswald)
  return 
end
MadDocPicTakeQuest = function()
  SetGlobal("VTL_Oasis_DaisyQuest_PhotoBrokeRide", 1)
  return 
end
MadDocPicTakeQuestCheck = function(target)
  if (1 < GetGlobal("VTL_Oasis_DaisyQuest_PhotoBrokeRide")) then
    DestroyEntity(target)
  end
  return 
end
ThinnerReset = function()
  if (ThinnerResetBlock == 0) then
    ThinnerResetBlock = 1
    wait(1)
    SplineFollower_StopAtPosition(".ThinnerPlane 01", "MST_madDoctorNewRide_02a_Main.S2_ThinnerSpline 01", "MST_madDoctorNewRide_02a_Main.S2_ThinnerSpline 02", 0)
    SetSplineFollowerInitialSpeed(".ThinnerPlane 01", 2)
    wait(1)
    SplineFollower_StopAtPosition(".ThinnerPlane 01", "MST_madDoctorNewRide_02a_Main.S2_ThinnerSpline 01", "MST_madDoctorNewRide_02a_Main.S2_ThinnerSpline 02", 1)
    SetSplineFollowerInitialSpeed(".ThinnerPlane 01", 0.20000000298023224)
    wait(1)
    if (ThinnerResetBlock == 1) then
      ThinnerResetBlock = 0
    end
  end
  return 
end
ThinnerBlock = function()
  ThinnerResetBlock = 2
  return 
end
ThinnerRisePaint = function(target)
  ThinnerRiseThinner()
  return 
end
SET_TopToonGuardianRepaint_TRUE = function()
  TopToonGuardianRepaint = true
  ForcePainted("mst_maddoctornewride_02a_main.S2_UpToon 01")
  wait(0.5)
  ForcePainted("mst_maddoctornewride_02a_main.S2_UpToon 02")
  wait(0.5)
  ForcePainted("mst_maddoctornewride_02a_main.S2_UpToon 03")
  wait(0.5)
  ForcePainted("mst_maddoctornewride_02a_main.S2_UpToon 04")
  wait(0.5)
  ForcePainted("mst_maddoctornewride_02a_main.S2_UpToon 05")
  wait(0.5)
  ForcePainted("mst_maddoctornewride_02a_main.S2_UpToon 06")
  wait(0.5)
  ForcePainted("mst_maddoctornewride_02a_main.S2_UpToon 07")
  wait(0.5)
  ForcePainted("mst_maddoctornewride_02a_main.S2_UpToon 08")
  return 
end
TopToonGuardianRepaint_1 = function(self)
  if (TopToonGuardianRepaint == true) then
    SplineFollower_TeleportToKnot("mst_maddoctornewride_02a_props.AutoPaintGuardian4 00", "mst_maddoctornewride_02a_props.PaintSpline4a 00")
    Enable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 00")
    Show("mst_maddoctornewride_02a_props.AutoPaintGuardian4 00")
    wait(0.5)
    ForcePainted(self)
    wait(2)
    Disable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 00")
    Hide("mst_maddoctornewride_02a_props.AutoPaintGuardian4 00")
  end
  return 
end
TopToonGuardianRepaint_2 = function(self)
  if (TopToonGuardianRepaint == true) then
    SplineFollower_TeleportToKnot("mst_maddoctornewride_02a_props.AutoPaintGuardian4 01", "mst_maddoctornewride_02a_props.PaintSpline4a 01")
    Enable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 01")
    Show("mst_maddoctornewride_02a_props.AutoPaintGuardian4 01")
    wait(0.5)
    ForcePainted(self)
    wait(2)
    Disable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 01")
    Hide("mst_maddoctornewride_02a_props.AutoPaintGuardian4 01")
  end
  return 
end
TopToonGuardianRepaint_3 = function(self)
  if (TopToonGuardianRepaint == true) then
    SplineFollower_TeleportToKnot("mst_maddoctornewride_02a_props.AutoPaintGuardian4 02", "mst_maddoctornewride_02a_props.PaintSpline4a 02")
    Enable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 02")
    Show("mst_maddoctornewride_02a_props.AutoPaintGuardian4 02")
    wait(0.5)
    ForcePainted(self)
    wait(2)
    Disable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 02")
    Hide("mst_maddoctornewride_02a_props.AutoPaintGuardian4 02")
  end
  return 
end
TopToonGuardianRepaint_4 = function(self)
  if (TopToonGuardianRepaint == true) then
    SplineFollower_TeleportToKnot("mst_maddoctornewride_02a_props.AutoPaintGuardian4 03", "mst_maddoctornewride_02a_props.PaintSpline4a 03")
    Enable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 03")
    Show("mst_maddoctornewride_02a_props.AutoPaintGuardian4 03")
    wait(0.5)
    ForcePainted(self)
    wait(2)
    Disable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 03")
    Hide("mst_maddoctornewride_02a_props.AutoPaintGuardian4 03")
  end
  return 
end
TopToonGuardianRepaint_5 = function(self)
  if (TopToonGuardianRepaint == true) then
    SplineFollower_TeleportToKnot("mst_maddoctornewride_02a_props.AutoPaintGuardian4 04", "mst_maddoctornewride_02a_props.PaintSpline4a 04")
    Enable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 04")
    Show("mst_maddoctornewride_02a_props.AutoPaintGuardian4 04")
    wait(0.5)
    ForcePainted(self)
    wait(2)
    Disable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 04")
    Hide("mst_maddoctornewride_02a_props.AutoPaintGuardian4 04")
  end
  return 
end
TopToonGuardianRepaint_6 = function(self)
  if (TopToonGuardianRepaint == true) then
    SplineFollower_TeleportToKnot("mst_maddoctornewride_02a_props.AutoPaintGuardian4 05", "mst_maddoctornewride_02a_props.PaintSpline4a 05")
    Enable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 05")
    Show("mst_maddoctornewride_02a_props.AutoPaintGuardian4 05")
    wait(0.5)
    ForcePainted(self)
    wait(2)
    Disable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 05")
    Hide("mst_maddoctornewride_02a_props.AutoPaintGuardian4 05")
  end
  return 
end
TopToonGuardianRepaint_7 = function(self)
  if (TopToonGuardianRepaint == true) then
    SplineFollower_TeleportToKnot("mst_maddoctornewride_02a_props.AutoPaintGuardian4 06", "mst_maddoctornewride_02a_props.PaintSpline4a 06")
    Enable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 06")
    Show("mst_maddoctornewride_02a_props.AutoPaintGuardian4 06")
    wait(0.5)
    ForcePainted(self)
    wait(2)
    Disable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 06")
    Hide("mst_maddoctornewride_02a_props.AutoPaintGuardian4 06")
  end
  return 
end
TopToonGuardianRepaint_8 = function(self)
  if (TopToonGuardianRepaint == true) then
    SplineFollower_TeleportToKnot("mst_maddoctornewride_02a_props.AutoPaintGuardian4 07", "mst_maddoctornewride_02a_props.PaintSpline4a 07")
    Enable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 07")
    Show("mst_maddoctornewride_02a_props.AutoPaintGuardian4 07")
    wait(0.5)
    ForcePainted(self)
    wait(2)
    Disable("mst_maddoctornewride_02a_props.AutoPaintGuardian4 07")
    Hide("mst_maddoctornewride_02a_props.AutoPaintGuardian4 07")
  end
  return 
end
ThinnerRiseThinner = function()
  local minThinnerSpeed = 0.30000001192092896
  local maxThinnerSpeed = 5
  local thinnerSpeed = 0.4000000059604645
  local thinnerHasStarted = false
  ThinnerResetBlock = 0
  ShakeCamera(30, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_newRideBoss_ThinnerRise")
  SetSplineFollowerInitialSpeed(".ThinnerPlane 01", thinnerSpeed)
  SplineFollower_StopAtPosition(".ThinnerPlane 01", "MST_madDoctorNewRide_02a_Main.S2_ThinnerSpline 01", "MST_madDoctorNewRide_02a_Main.S2_ThinnerSpline 02", 1)
  Enable("MST_madDoctorNewRide_02a_Main.S2_ThinnerPlane 01")
  ClearAllCameraAttributes()
  SetCameraAttributes("MST_madDoctorNewRide_02a_Main.Stage1Cam_Ascend")
  Print("************************************ Thinner route GUS line pre")
  if (Thinner_Route_VAR ~= 1) then
    Print("************************************ Thinner route GUS line post")
    FireSequence("GusConvoV2", "gen_gus_314")
  end
  local yVelo = 0
  while true do
    while true do
      local playerPos = GetPosition(GetPlayer())
      local distanceToThinner = (playerPos - GetPosition(".ThinnerPlane 01"))
      local yDistanceToThinner = distanceToThinner.y
      if (ThinnerResetBlock ~= 1) then
        if (12 < yDistanceToThinner) then
          if (thinnerSpeed < maxThinnerSpeed) then
            thinnerSpeed = (thinnerSpeed + 0.10000000149011612)
            SetSplineFollowerInitialSpeed(".ThinnerPlane 01", thinnerSpeed)
          end
        elseif (12 < yDistanceToThinner) then
          if (maxThinnerSpeed < thinnerSpeed) then
            thinnerSpeed = maxThinnerSpeed
            SetSplineFollowerInitialSpeed(".ThinnerPlane 01", thinnerSpeed)
          end
        elseif (5 < yDistanceToThinner) then
          SetSplineFollowerInitialSpeed(".ThinnerPlane 01", thinnerSpeed)
        elseif (1 < thinnerSpeed) then
          thinnerSpeed = (thinnerSpeed - 0.10000000149011612)
          SetSplineFollowerInitialSpeed(".ThinnerPlane 01", thinnerSpeed)
        else
          thinnerSpeed = minThinnerSpeed
          SetSplineFollowerInitialSpeed(".ThinnerPlane 01", thinnerSpeed)
        end
        local thinnerVelocity = GetVelocity(".ThinnerPlane 01")
        yVelo = thinnerVelocity.y
        if (yVelo <= 0) then
          if (thinnerHasStarted == false) then
            while true do
              wait(1)
              thinnerVelocity = GetVelocity(".ThinnerPlane 01")
              yVelo = thinnerVelocity.y
            end
            thinnerHasStarted = true
          end
        else
          wait(0.30000001192092896)
          wait(0.30000001192092896)
        end
      else
        wait(0.30000001192092896)
      end
    end
  end
  thinnerHasReachedTop = true
  SpiderBoss_StartThinnerEffects()
  Disable("MST_madDoctorNewRide_02a_Main.CavernWalls")
  return 
end
Pistons_PaintPath = function()
  FireSequence("GusConvoV2", "MST_NewRide_Oswald_025")
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_SpikeToon 01", 20)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_SpikeToon 02", 15)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 01", 6)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_ThinnerPipe 01", 5)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 02", 5)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_ThinnerPipe 02", 4)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 03", 4)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_ThinnerPipe 03", 3)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 04", 3)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 05", 2)
  Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 04")
  Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 05")
  Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 06")
  Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 07")
  wait(1)
  ForcePainted("ToonSpike 01")
  wait(1)
  ForcePainted("ToonSpike 02")
  SetGlobal("NewRideFirstStageglobal", 1)
  return 
end
Pistons_ThinnerPath = function()
  if (Thinner_Route_VAR ~= 1) then
    FireSequence("GusConvoV2", "MST_NewRide_Gus_004")
  end
  Enable("MST_madDoctorNewRide_02a_Main.S2_ThinnerPlane 01")
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_GearInert 01", 7)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_GearInert 02", 10)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 01", 6)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_ThinnerPipe 01", 4)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 02", 4)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_ThinnerPipe 02", 2)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 03", 2)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_ThinnerPipe 03", 1)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 04", 1)
  SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 05", 5)
  FireThread(ThinnerRiseThinner)
  wait(4)
  ForcePainted("ThinnnerPipes1")
  StartEmitters("MST_madDoctorNewRide_02a_Main.steam 11.SteamJet_Blast")
  Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 01")
  wait(3)
  ForcePainted("ThinnnerPipes2")
  StartEmitters("MST_madDoctorNewRide_02a_Main.steam 12.SteamJet_Blast")
  Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 02")
  wait(3)
  ForcePainted("ThinnnerPipes3")
  StartEmitters("MST_madDoctorNewRide_02a_Main.steam 13.SteamJet_Blast")
  Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 03")
  wait(3)
  ForcePainted("mst_maddoctornewride_02a_main.S2_UpToon 03")
  SetGlobal("NewRideFirstStageglobal", 0)
  return 
end
SpiderBossEndStage2 = function()
  Print("MDDBF Spider Boss End stage1********************************************************")
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    if (GetGlobal("Extras_Mad_Doctor_Redemption") == 1) then
      IncreaseMaxPaintAmmo()
    elseif (GetGlobal("Extras_Mad_Doctor_Redemption") == 0) then
      IncreaseMaxThinnerAmmo()
    end
    IncreaseMaxElectricityAmmo()
    SetGlobal("EM2_EpisodeCheck", 4)
    SetGlobal("EM2_Movies_OutroMovie_Unlocked", 1)
    Print("MDDBF Spider Boss End stage 2********************************************************")
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    DoEndGame()
  elseif (GetGlobal("MSN_Arcade_FromArcade") == 1) then
    StartFadeOut(0.800000011920929)
    MST_NewRide_LoadNextLevel()
  end
  return 
end
NewRide_Map_Controller_Exit = function(Target, Direction)
  if (_activator() == GetPlayer()) then
    MapActivator = false
  else
    MapActivator = true
  end
  return 
end
NewRide_Map_Controller_Enter = function(Target, Direction)
  if (_activator() == GetPlayer()) then
    MapActivator = false
  else
    MapActivator = true
  end
  return 
end
NewRide_Thinner_Stage_controller = function(MarkerMickey, MarkerOswald, Stage)
  Print("********************************NewRide_Thinner_Stage START")
  local StageNum = tonumber(Stage)
  local Mick = MarkerMickey
  local Os = MarkerOswald
  Print(ThinnerStage)
  if (ThinnerStage < StageNum) then
    Print("********************************NewRide_Thinner_Stage Mid")
    ThinnerStage = StageNum
    Print(ThinnerStage)
    OverrideSpawnTransform(PLAYER_ONE, GetPosition(MarkerMickey), GetFacing(MarkerMickey))
    OverrideSpawnTransform(PLAYER_TWO, GetPosition(MarkerOswald), GetFacing(MarkerOswald))
    Print("********************************NewRide_Thinner_Stage Mid 2")
    if (ThinnerStage < 2) then
      while true do
        OverrideSpawnTransform(PLAYER_ONE, GetPosition(Mick), GetFacing(Mick))
        OverrideSpawnTransform(PLAYER_TWO, GetPosition(Os), GetFacing(Os))
        wait(0.10000000149011612)
      end
    end
  end
  Print("********************************NewRide_Thinner_Stage End")
  return 
end
NewRide_Thinner_Stage_End = function(MarkerMickey, MarkerOswald)
  if (ThinnerStage < 6) then
    ThinnerStage = 6
    OverrideSpawnTransform(PLAYER_ONE, GetPosition(MarkerMickey), GetFacing(MarkerMickey))
    OverrideSpawnTransform(PLAYER_TWO, GetPosition(MarkerOswald), GetFacing(MarkerOswald))
  end
  return 
end
DoEndGame2 = function()
end
MST_NewRide_LoadNextLevel = function(target)
  FireUser1("MadDocObservatoryPickup")
  SetGlobal("MSN_ProectorState", 4)
  SetupPosition(target)
  return 
end
MST_NewRide_LoadAttic = function(target)
  FireUser1("MadDocObservatoryPickup")
  SetupPosition(target)
  return 
end
SpiderBoss_OpenLowerDoor = function()
  SetSplineFollowerInitialSpeed("mst_maddoctornewride_02a_main.S2_LowerDoor", 1)
  SplineFollower_StopAtPosition("mst_maddoctornewride_02a_main.S2_LowerDoor", "mst_maddoctornewride_02a_main.S2_LowerDoor_Spline1b", "mst_maddoctornewride_02a_main.S2_LowerDoor_Spline1a", 1)
  return 
end
SpiderBoss_OpenUpperDoor = function()
  SetSplineFollowerInitialSpeed("mst_maddoctornewride_02a_main.S2_UpperDoor", 1)
  SplineFollower_StopAtPosition("mst_maddoctornewride_02a_main.S2_UpperDoor", "mst_maddoctornewride_02a_main.S2_UpperDoor_Spline1b", "mst_maddoctornewride_02a_main.S2_UpperDoor_Spline1a", 1)
  wait(4)
  return 
end
SpiderBoss_1_SaveCheckpoint = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    SaveCheckpoint(GetPlayer(), "SpiderBoss_1_CheckpointLoad", "Checkpoint_1")
  end
  return 
end
SpiderBoss_2_SaveCheckpoint = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    SaveCheckpoint(GetPlayer(), "SpiderBoss_2_CheckpointLoad", "Checkpoint_2")
  end
  return 
end
SpiderBoss_3_SaveCheckpoint = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    SaveCheckpoint(GetPlayer(), "SpiderBoss_3_CheckpointLoad", "Checkpoint_3")
  end
  return 
end
SpiderBoss_Visit2_SaveCheckpoint = function()
  FireUser1("MadDocObservatoryPickup")
  SaveCheckpoint(GetPlayer(), "SpiderBoss_Visit2_CheckpointLoad", "Checkpoint_1")
  ForEachEntityInGroup(Enable, "CameraVolumeStage1Group")
  ForEachEntityInGroup(Enable, "CameraVolumeStage2Group")
  return 
end
SpiderBoss_Visit2_CheckpointLoad = function()
  Print("SpiderBoss_Visit2_CheckpointLoad : Destroying the marker")
  DestroyEntity("PM_LauncherSetup")
  GetPrefabData("ProjectorToMeanStreets").MapLoad_SetupPosition = "IgnoreMe"
  GetPrefabData("ProjectorToAttic").MapLoad_SetupPosition = "IgnoreMe"
  ForEachEntityInGroup(DestroyEntity, "DestroyForV2")
  return 
end
SpiderBoss_Visit2_AlwaysFired = function()
  if (GetGlobal("NewRideFirstStageglobal") == 1) then
    spiderBoss_PistonsActive = true
    PistonsOff(".PistonInert 01")
    wait(2)
    PistonsStep(".PistonInert 01")
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_SpikeToon 01", 20)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_SpikeToon 02", 15)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 01", 6)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_ThinnerPipe 01", 5)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 02", 5)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_ThinnerPipe 02", 4)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 03", 4)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_ThinnerPipe 03", 3)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 04", 3)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 05", 2)
    Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 04")
    Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 05")
    Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 06")
    Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 07")
    wait(1)
    ForcePainted("ToonSpike 01")
    wait(1)
    ForcePainted("ToonSpike 02")
  else
    Enable("MST_madDoctorNewRide_02a_Main.S2_ThinnerPlane 01")
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_GearInert 01", 7)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_GearInert 02", 10)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 01", 6)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_ThinnerPipe 01", 4)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 02", 4)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_ThinnerPipe 02", 2)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 03", 2)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_ThinnerPipe 03", 1)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 04", 1)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_Path 05", 5)
    wait(4)
    ForcePainted("ThinnnerPipes1")
    StartEmitters("MST_madDoctorNewRide_02a_Main.steam 11.SteamJet_Blast")
    Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 01")
    wait(3)
    ForcePainted("ThinnnerPipes2")
    StartEmitters("MST_madDoctorNewRide_02a_Main.steam 12.SteamJet_Blast")
    Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 02")
    wait(3)
    ForcePainted("ThinnnerPipes3")
    StartEmitters("MST_madDoctorNewRide_02a_Main.steam 13.SteamJet_Blast")
    Enable("MST_madDoctorNewRide_02a_Main.S2_TriggerSteam 03")
    wait(3)
    ForcePainted("mst_maddoctornewride_02a_main.S2_UpToon 03")
  end
  FireUser1(".LowPaintGuardianSpawner")
  FireUser1(".LowThinnerGuardianSpawner")
  FireUser1(".HighPaintGuardianSpawner")
  FireUser1(".HighThinnerGuardianSpawner")
  wait(3)
  GuardianRevealing()
  return 
end
SpiderBoss_PostLoad = function()
  if (0 < spiderBoss_BattleStage) then
    AI_MadDoctorSpider_RepaintMasks()
    AI_MadDoctorSpider_SetupMasks()
    AnimEvent(SpiderBoss, EVENT_Boss_Start)
    if (spiderBoss_BattleStage == 1) then
      if (NewRidePath ~= "Thinner") then
        AI_MadDoctorSpider_BattleFlow()
      end
    else
      TeleportToEntity("SpiderBoss", ".SpiderOriginTop")
      if (spiderBoss_BattleStage == 2) then
        if (NewRidePath ~= "Thinner") then
          local route = GetGlobal("Boss_MechRoute")
          SpiderBoss_MoveToTopPlatform(route)
        end
      else
        MadDoctorSpider_SetVulnerableMode(SpiderBoss, false)
        SpiderBoss_HasReachedTopPlatform()
      end
      AI_MadDoctorSpider_Battle2()
    end
    spiderBoss_BattleStage = 0
  end
  return 
end
SpiderBoss_1_CheckpointLoad = function()
  spiderBoss_BattleStage = 1
  TeleportToEntity("SpiderBoss", ".SpiderOrigin")
  AnimEvent(SpiderBoss, EVENT_Force_Idle)
  Print("********************************LOADING Checkpoint 1!!!!!!!")
  Show(GetName(".MaskRotator 01"))
  Show(GetName(".MaskRotator 02"))
  Show(GetName(".MaskRotator 03"))
  Show(GetName(".MaskRotator 04"))
  Show(GetName(".MaskRotator 05"))
  Show(GetName(".MaskRotator 06"))
  SetCameraAttributesForPlayer("Stage1Cam")
  ForEachEntityInGroup(Enable, "CameraVolumeStage1Group")
  Print("********************************LOADING Checkpoint 1!!!!!!!END")
  return 
end
SpiderBoss_2_CheckpointLoad = function()
  spiderBoss_BattleStage = 2
  AnimEvent(SpiderBoss, EVENT_Force_Idle)
  Print("********************************LOADING Checkpoint 2!!!!!!!")
  Show(GetName(".MaskRotator 01"))
  Show(GetName(".MaskRotator 02"))
  Show(GetName(".MaskRotator 03"))
  Show(GetName(".MaskRotator 04"))
  Show(GetName(".MaskRotator 05"))
  Show(GetName(".MaskRotator 06"))
  MadDoctorSpider_SetToSecondPlatform(SpiderBoss, false, GetPosition(".SpiderOriginTop"))
  if (GetGlobal("Boss_NewRideStyle") == 0) then
    ForEachEntityInGroup(ForcePainted, "Uptoon")
    ForEachEntityInGroup(Show, ".Guardian_Paint")
    Show("mst_maddoctornewride_02a_props.AutoPaintGuardian5")
    Show("mst_maddoctornewride_02a_props.AutoPaintGuardian6")
    Enable("mst_maddoctornewride_02a_props.AutoPaintGuardian5")
    Enable("mst_maddoctornewride_02a_props.AutoPaintGuardian6")
    Print("********************************LOADING Checkpoint 2!!!!!!! MIDDLE!!!!")
    FireThread(SET_TopToonGuardianRepaint_TRUE)
  end
  ForEachEntityInGroup(Disable, "CameraVolumeStage1Group")
  Print("********************************LOADING Checkpoint 2!!!!!!! END")
  return 
end
SpiderBoss_Toon_SpawnAmmo = function(target)
  local PlayerCurrentPaint = GetAmmo("Paint")
  local PlayerMaxPaint = GetAmmoMax("Paint")
  local PlayerCurrentThinner = GetAmmo("Thinner")
  local PlayerMaxThinner = GetAmmoMax("Thinner")
  local PlayerThinnerPercentage = (PlayerCurrentThinner / PlayerMaxThinner)
  local PlayerPaintPercentage = (PlayerCurrentPaint / PlayerMaxPaint)
  if (PlayerThinnerPercentage <= 0.5) then
    if (PlayerPaintPercentage <= 0.5) then
      SetPropertyInt(target, "Index To Spawn", 4)
      ForceSpawn(target, 1)
    end
  elseif (PlayerPaintPercentage <= 0.75) then
    SetPropertyInt(target, "Index To Spawn", 3)
    ForceSpawn(target, 1)
  elseif (PlayerThinnerPercentage <= 0.75) then
    SetPropertyInt(target, "Index To Spawn", 5)
    ForceSpawn(target, 1)
  end
  return 
end
SpiderBoss_Toon_SpawnHealth = function(target)
  local MickeyCurrentHealth = GetPropertyInt(GetPlayer(), "Health", 0)
  local MickeyMaxHealth = GetPropertyInt(GetPlayer(), "MaxHealth", 0)
  local MickeyHealthPercentage = (MickeyCurrentHealth / MickeyMaxHealth)
  local oswald = GetPlayer2OrAI()
  if IsValidHandle(oswald) then
    local OswaldCurrentHealth = GetPropertyInt(oswald, "Health", 0)
  else
    local OswaldCurrentHealth = 5
  end
  local OswaldHealthPercentage = (MickeyCurrentHealth / MickeyMaxHealth)
  if (MickeyHealthPercentage <= 0.30000001192092896) then
    OswaldHealthPercentage = 10
    SetPropertyInt(target, "Index To Spawn", OswaldHealthPercentage)
    ForceSpawn(target, 1)
  end
  if (MickeyHealthPercentage <= 0.6000000238418579) then
    OswaldHealthPercentage = 11
    SetPropertyInt(target, "Index To Spawn", OswaldHealthPercentage)
    ForceSpawn(target, 1)
  end
  return 
end
SpiderBoss_BoxingGloveStopper2 = function(target)
  SplineKnotComponent_SetBranchProbability("mst_maddoctornewride_02a_main.S2_PistonToonSpline 02b", 1)
  return 
end
SpiderBoss_BoxingGloveStopper1 = function(target)
  SplineKnotComponent_SetBranchProbability("mst_maddoctornewride_02a_main.S2_PistonToonSpline 01b", 1)
  return 
end
SpiderBoss_Toon_SpawnETicket = function(target)
  SetPropertyInt(target, "Index To Spawn", 8)
  ForceSpawn(target, 1)
  return 
end
SpiderBoss_IsCutsceneRunning = false
SpiderBoss_IsCutsceneFinished = false
SpiderBoss_CutsceneStart = function()
  print("-----------CUTSCENE STARTS------------")
  SpiderBoss_IsCutsceneRunning = true
  SpiderBoss_IsCutsceneFinished = false
  return 
end
SpiderBoss_CutsceneEnd = function()
  print("+++++++++++CUTSCENE ENDS++++++++++++++")
  SpiderBoss_IsCutsceneRunning = false
  SpiderBoss_IsCutsceneFinished = true
  ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
  FireThread(NewRide_ResetPlayerCamera)
  ClearCameraAttributesForPlayer(".CamMainTracking")
  UnrestrictCutSceneInput()
  return 
end
SpiderBoss_KillAndRespawn = function(target)
  if (spiderBoss_HasReachedTopPlatform == 0) then
    MoveToEntity(target, ".Checkpoint_1")
  else
    MoveToEntity(target, ".Checkpoint_3")
  end
  return 
end
SpiderBoss_StartThinnerEffects = function()
  local fXCount = 1
  local fXCountBubbleON = 1
  local fXCountBubbleOFF = 1
  local fXCountHugeON = 1
  local fXCountHugeOFF = 1
  local fXCountLargeON = 1
  local fXCountLargeOFF = 1
  local fXEnable = " 0"
  local fXDisable = "Top 0"
  if (thinnerHasReachedTop == false) then
    fXEnable = " 0"
    fXDisable = "Top 0"
    fXCountBubbleON = 4
    fXCountBubbleOFF = 5
    fXCountHugeON = 5
    fXCountHugeOFF = 8
    fXCountLargeON = 6
    fXCountLargeOFF = 7
  else
    fXEnable = "Top 0"
    fXDisable = " 0"
    fXCountBubbleON = 5
    fXCountBubbleOFF = 4
    fXCountHugeON = 8
    fXCountHugeOFF = 5
    fXCountLargeON = 7
    fXCountLargeOFF = 6
  end
  while true do
    Enable((("mst_maddoctornewride_02a_fx.ThinnerBubble" .. fXEnable) .. fXCount))
    fXCount = (fXCount + 1)
  end
  fXCount = 1
  while true do
    Enable((("mst_maddoctornewride_02a_fx.ThinnerSplashesHuge" .. fXEnable) .. fXCount))
    fXCount = (fXCount + 1)
  end
  fXCount = 1
  while true do
    Enable((("mst_maddoctornewride_02a_fx.ThinnerSplashesLarge" .. fXEnable) .. fXCount))
    fXCount = (fXCount + 1)
  end
  fXCount = 1
  while true do
    Disable((("mst_maddoctornewride_02a_fx.ThinnerBubble" .. fXDisable) .. fXCount))
    fXCount = (fXCount + 1)
  end
  fXCount = 1
  while true do
    Disable((("mst_maddoctornewride_02a_fx.ThinnerSplashesHuge" .. fXDisable) .. fXCount))
    fXCount = (fXCount + 1)
  end
  fXCount = 1
  while true do
    Disable((("mst_maddoctornewride_02a_fx.ThinnerSplashesLarge" .. fXDisable) .. fXCount))
    fXCount = (fXCount + 1)
  end
  return 
end
NewRide_FindOswald = function()
  local oswald = GetPlayer2OrAI()
  while true do
    wait(0.10000000149011612)
    oswald = GetPlayer2OrAI()
    if (not IsValidHandle(oswald)) then
      while true do
        wait(10)
        SpiderBoss_VulnerabilityOverride = true
        oswald = GetPlayer2OrAI()
      end
      SpiderBoss_VulnerabilityOverride = false
    end
  end
  print("end")
  return 
end

