NewRideOutcome = "none"
OswaldAlreadyHackedMDNR1 = 0
OswaldAlreadyHackedMDNR2 = 0
OswaldAlreadyCelebratedMDNR1 = 0
OswaldAlreadyCelebratedMDNR2 = 0
AllowHackBoxUp = 0
if (GetGlobal("Boss_NewRideStyle") == true) then
  NewRidePath = "Thinner"
else
  NewRidePath = "Paint"
end
spiderBoss_State = "none"
SpiderBoss = "SpiderBoss"
spiderBoss_IsFirstStage = true
spiderBoss_Complete = false
SpiderBoss_IsBeingShocked = false
SpiderBoss_IsInIdle = false
spiderBoss_CounterAttack = false
spiderBoss_RandomAttack = 0
spiderBoss_RandomTarget = 0
spiderBossFirstMaskPainted = 0
spiderBossFirstMaskThinned = 0
spiderBoss_IgnoreHit = true
NewRideTestHackLoop = 0
NewRideTestGuardianLoop = 0
SpiderBoss_PlayerIsOnPistons = false
spiderBoss_HasReachedTopPlatform = 0
spiderBoss_MoveToTopPlatform = 0
spiderBoss_MasksVulnerable = false
MaskStopped = 0
MaskNormal = 70
MaskAngry = 220
spiderBoss_BattleFlowStarted = false
spiderBoss_LevelStarted = true
InIGCRandomDialogBlock = 0
Thinner_Route_VAR = 0
IGC_0330a_block = 0
IGC_0330b_block = 0
IGC_0340_block = 0
IGC_0345_block = 0
IGC_0350_block = 0
NewRide_Second_visitSetup = function()
end
Observatory_setup_Func = function()
  ObservatoryItem_Activate(GetGlobal("MSS_ObservatoryItem_Ride"), "9")
  return 
end
PostIGC_0340b_DeathOfTheHandThinner = function()
  if (IGC_0340_block == 0) then
    IGC_0340_block = 1
    ForEachEntityInGroup(DestroyEntity, "Stage1ConvoTriggers")
    Print("IGC_0340b_DeathOfTheHand_Thinner start")
    FireThread(_G[GetPrefabData("mst_maddoctornewride_01a_main.grabcameraniffancy 02.HavokGBAnimation 01").EndFunction])
    LevelEndCutscene = false
    Print("IGC_0340b_DeathOfTheHand_Thinner end")
    InIGCRandomDialogBlock = 0
  end
  return 
end
PostIGC_0340a_DeathOfTheHandPaint = function()
  if (IGC_0340_block == 0) then
    IGC_0340_block = 1
    NewRide_Transition()
    ForEachEntityInGroup(DestroyEntity, "Stage1ConvoTriggers")
    Print("IGC_0340b_DeathOfTheHandPaint start")
    FireThread(_G[GetPrefabData("mst_maddoctornewride_01a_main.grabcameraniffancy 03.HavokGBAnimation 01").EndFunction])
    LevelEndCutscene = false
    Print("IGC_0340b_DeathOfTheHandPaint end")
    InIGCRandomDialogBlock = 0
  end
  return 
end
PostIGC_0330a_TowerbreakThinner = function()
  if (IGC_0330a_block == 0) then
    IGC_0330a_block = 1
    ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
    Print("IGC_0330a_TowerbreakThinner start")
    FireThread(_G[GetPrefabData("mst_maddoctornewride_01a_main.grabcameraniffancy 04.HavokGBAnimation 01").EndFunction])
    FireThread(NewRide_ResetPlayerCamera)
    LevelEndCutscene = false
    ClearCameraAttributesForPlayer(".CamMainTracking", GetPlayer())
    SetCameraAttributesForPlayer(".CamMainTracking", GetPlayer())
    NewRide_ClawIdle("mst_maddoctornewride_01a_main.AI_NewRideHand 01")
    InIGCRandomDialogBlock = 0
  end
  return 
end
PostIGC_0330b_TowerbreakPaint = function()
  if (IGC_0330b_block == 0) then
    IGC_0330b_block = 1
    ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
    Print("IGC_0330a_TowerbreakPaint start")
    FireThread(_G[GetPrefabData("mst_maddoctornewride_01a_main.grabcameraniffancy 05.HavokGBAnimation 01").EndFunction])
    FireThread(NewRide_ResetPlayerCamera)
    LevelEndCutscene = false
    ClearCameraAttributesForPlayer(".CamMainTracking", GetPlayer())
    SetCameraAttributesForPlayer(".CamMainTracking", GetPlayer())
    Print("IGC_0330a_TowerbreakPaint end")
    NewRide_ClawIdle("mst_maddoctornewride_01a_main.AI_NewRideHand 01")
    InIGCRandomDialogBlock = 0
  end
  return 
end
PostIGC_0345b_NewRideDropToStage2Thinner = function()
  if (IGC_0345_block == 0) then
    Thinner_Route_VAR = 1
    IGC_0345_block = 1
    SetPropertyBool("Stage2Cam", "InstantTransition", true)
    Print("IGC_0345b_NewRideDropToStage2Thinner START CAMERA")
    PlayIGC("IGC_0350b_Stage2IntroThinner")
    Print("IGC_0345b_NewRideDropToStage2Thinner START CAMERA 1")
    FireThread(MadDoctorSpider_Finalbattlestartblock)
    local route = GetGlobal("Boss_MechRoute")
    Unhide("mst_maddoctornewride_02a_main.S2_ThinnerPlane 02")
    FireThread(SpiderBoss_3_CheckpointLoad)
    TeleportToEntity("SpiderBoss", "mst_maddoctornewride_02a_main.S2_TopArenaMarker")
    Print("IGC_0345b_NewRideDropToStage2Thinner start")
    spiderBoss_HasReachedTopPlatform = 1
    Enable("mst_maddoctornewride_02a_main.S2_UpperDeathVolume")
    Print("IGC_0345b_NewRideDropToStage2Thinner start 2")
    spiderBoss_BattleStage = 3
    Print("IGC_0345b_NewRideDropToStage2Thinner start 3")
    FireThread(SpiderBoss_MoveToTopPlatform, route)
    Print("IGC_0345b_NewRideDropToStage2Thinner start 4")
    FireThread(AI_MadDoctorSpider_Battle2)
    Print("IGC_0345b_NewRideDropToStage2Thinner start 5")
    Print("IGC_0345b_NewRideDropToStage2Thinner start 6")
    Print("IGC_0345b_NewRideDropToStage2Thinner start 7")
    MadDoctorSpider_SetToSecondPlatform(SpiderBoss, false, GetPosition(".SpiderOriginTop"))
    Print("IGC_0345b_NewRideDropToStage2Thinner start 8")
    Enable("mst_maddoctornewride_02a_main.S2_Path 04")
    Print("IGC_0345b_NewRideDropToStage2Thinner start 9")
    Enable("mst_maddoctornewride_02a_main.S2_Path 04")
    spiderBoss_State = "low"
    Print("IGC_0345b_NewRideDropToStage2Thinner start 10")
    SetCameraAttributesForPlayer("Stage2Cam")
    ForEachEntityInGroup(Enable, "CameraVolumeStage2Group")
    Print("IGC_0345b_NewRideDropToStage2Thinner END")
    DestroyEntity("mst_maddoctornewride_02a_main.S2_ThinnerPlane 01")
    Unhide("mst_maddoctornewride_02a_main.S2_ThinnerPlane 02")
    ClearCameraAttributesForPlayer(".CamMainTracking", GetPlayer())
    SetCameraAttributesForPlayer("Stage2Cam")
    ForEachEntityInGroup(Enable, "CameraVolumeStage2Group")
    ForEachEntityInGroup(ForceSketched, "BoxingGlove")
    AI_MadDoctorSpider_SetupMasks()
  end
  return 
end
PostIGC_0345a_NewRideDropToStage2Paint = function()
  if (IGC_0345_block == 0) then
    IGC_0345_block = 1
    SetPropertyBool("Stage1Cam", "InstantTransition", true)
    Print("PostIGC_0345a_NewRideDropToStage2Paint START CAMERA")
    PlayIGC("IGC_0350a_Stage2IntroPaint")
    Print("PostIGC_0345a_NewRideDropToStage2Paint 1")
    FireThread(_G[GetPrefabData("mst_maddoctornewride_01a_main_player.CameraPaintNif.HavokGBAnimation 01").EndFunction])
    Print("PostIGC_0345a_NewRideDropToStage2Paint 2")
    Print("PostIGC_0345a_NewRideDropToStage2Paint END")
  end
  return 
end
PostIGC_0350b_Stage2IntroThinner = function()
  if (IGC_0350_block == 0) then
    IGC_0350_block = 1
    spiderBoss_LevelStarted = false
    ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
    FireThread(_G[GetPrefabData("mst_maddoctornewride_02a_main.grabcameraniffancy_camIntro1a.HavokGBAnimation 01").EndFunction])
    FireThread(NewRide_ResetPlayerCamera)
    SetPropertyBool("Stage2Cam", "InstantTransition", true)
    ClearCameraAttributesForPlayer(".CamMainTracking", GetPlayer())
    SetCameraAttributesForPlayer("Stage2Cam")
    ForEachEntityInGroup(Hide, "MADDOCGUARDIANSNEW")
    ForEachEntityInGroup(Hide, "MADDOCGUARDIANS2NEW")
    GuardianRevealing()
    ForEachEntityInGroup(Enable, "CameraVolumeStage2Group")
    MadDoctorSpider_StartFinalBattle()
    wait(3)
    FireSequence("GusConvoV2", "MST_NewRide_Spinning1")
    SetCameraAttributesForPlayer("Stage2Cam")
    InIGCRandomDialogBlock = 0
  end
  return 
end
PostIGC_0350a_Stage2IntroPaint = function()
  if (IGC_0350_block == 0) then
    IGC_0350_block = 1
    spiderBoss_LevelStarted = false
    ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
    FireThread(NewRide_ResetPlayerCamera)
    SetPropertyBool("Stage2Cam", "InstantTransition", true)
    ClearCameraAttributesForPlayer(".CamMainTracking", GetPlayer())
    SetCameraAttributesForPlayer("Stage1Cam")
    ForEachEntityInGroup(Hide, "MADDOCGUARDIANSNEW")
    ForEachEntityInGroup(Hide, "MADDOCGUARDIANS2NEW")
    GuardianRevealing()
    ForEachEntityInGroup(Enable, "CameraVolumeStage1Group")
    FireThread(MadDoctorSpider_Finalbattlestartblock)
    MadDoctorSpider_StartFinalBattle()
    wait(3)
    FireSequence("GusConvoV2", "MST_NewRide_Spinning1")
    SetCameraAttributesForPlayer("Stage1Cam")
    InIGCRandomDialogBlock = 0
  end
  return 
end
NewRide_StreamingToLower = function()
  print("NewRide_StreamingToLower **********************")
  NewRide_Streaming("lower")
  wait(0.10000000149011612)
  while true do
    if (not (LevelManager_HasStateFinishedStreaming() ~= true)) then
      break
    end
    wait(1)
  end
  while true do
    if (not (LevelManager_WaitingForStreamingSync() == false)) then
      break
    end
    Wait(0.05000000074505806)
  end
  EndIGCOnEvent(IGC_CHANNEL_2)
  return 
end
SpiderBoss_CameraHandleScript = function(target, camera)
  SetCameraAttributesForPlayer(camera, target)
  return 
end
ClawInvulnerabletoonmagic = function(target)
  ForceSketched(target)
  SetPropertyBool(target, "InvulnerableToPaintThinner", true)
  return 
end
ClawNOTInvulnerabletoonmagic = function(target)
  SetPropertyBool(target, "InvulnerableToPaintThinner", false)
  return 
end
SpiderBoss_3_CheckpointLoad = function()
  spiderBoss_BattleStage = 3
  Unhide("mst_maddoctornewride_02a_main.S2_ThinnerPlane 02")
  SplineFollower_TeleportToKnot(".ThinnerPlane 01", "MST_madDoctorNewRide_02a_Main.S2_ThinnerSpline 02")
  AnimEvent(SpiderBoss, EVENT_Force_Idle)
  Print("********************************LOADING Checkpoint 3!!!!!!!")
  Show(GetName(".MaskRotator 01"))
  Show(GetName(".MaskRotator 02"))
  Show(GetName(".MaskRotator 03"))
  Show(GetName(".MaskRotator 04"))
  Show(GetName(".MaskRotator 05"))
  Show(GetName(".MaskRotator 06"))
  MadDoctorSpider_SetToSecondPlatform(SpiderBoss, false, GetPosition(".SpiderOriginTop"))
  SetCameraAttributesForPlayer("Stage2Cam")
  ForEachEntityInGroup(Hide, "MADDOCGUARDIANSNEW")
  ForEachEntityInGroup(Hide, "MADDOCGUARDIANS2NEW")
  GuardianRevealing()
  if (GetGlobal("Boss_NewRideStyle") == 0) then
    ForEachEntityInGroup(ForcePainted, "Uptoon")
    ForEachEntityInGroup(Show, ".Guardian_Paint")
    Show("mst_maddoctornewride_02a_props.AutoPaintGuardian5")
    Show("mst_maddoctornewride_02a_props.AutoPaintGuardian6")
    Enable("mst_maddoctornewride_02a_props.AutoPaintGuardian5")
    Enable("mst_maddoctornewride_02a_props.AutoPaintGuardian6")
    FireThread(SET_TopToonGuardianRepaint_TRUE)
    Print("********************************LOADING Checkpoint 3!!!!!!! MIDDLE!!!!")
  end
  ForEachEntityInGroup(Enable, "CameraVolumeStage2Group")
  Print("********************************LOADING Checkpoint 3!!!!!!! END!")
  return 
end
AI_MadDoctorSpider_SetupMasks = function()
  MadDoctorSpider_SetMaskRotator(SpiderBoss, ".MaskRotatorMain")
  MadDoctorSpider_SetMaskEntity(SpiderBoss, 0, ".MaskShooter 01", ".MaskRotator 01", ".MaskOrientationMarker 01")
  MadDoctorSpider_SetMaskEntity(SpiderBoss, 1, ".MaskShooter 02", ".MaskRotator 02", ".MaskOrientationMarker 02")
  MadDoctorSpider_SetMaskEntity(SpiderBoss, 2, ".MaskShooter 03", ".MaskRotator 03", ".MaskOrientationMarker 03")
  MadDoctorSpider_SetMaskEntity(SpiderBoss, 3, ".MaskShooter 04", ".MaskRotator 04", ".MaskOrientationMarker 04")
  MadDoctorSpider_SetMaskEntity(SpiderBoss, 4, ".MaskShooter 05", ".MaskRotator 05", ".MaskOrientationMarker 05")
  MadDoctorSpider_SetMaskEntity(SpiderBoss, 5, ".MaskShooter 06", ".MaskRotator 06", ".MaskOrientationMarker 06")
  Enable(".MaskRotatorMain")
  return 
end
AI_MadDoctorSpider_RepaintMasks = function()
  spiderBoss_IgnoreHit = true
  ForcePainted(".MaskRotator 01")
  ForcePainted(".MaskRotator 03")
  ForcePainted(".MaskRotator 05")
  ForcePainted(".MaskRotator 05")
  ForceSketched(".MaskRotator 02")
  ForceSketched(".MaskRotator 04")
  ForceSketched(".MaskRotator 06")
  wait(0.20000000298023224)
  spiderBoss_IgnoreHit = false
  return 
end
AI_MadDoctorSpider_ShooterInit = function()
  SetPropertyEntity(".MaskShooter 01", "Shooter Target", GetPlayer(), 0)
  return 
end
SpiderBoss_SetMaskRotatorSpeed = function(speed)
  SpiderBoss_MaskAudio(speed)
  SetRotatorMaxSpeed(".MaskRotatorMain", speed)
  return 
end
MadDoctorSpider_Finalbattlestartblock = function()
  Print("Finalbattlestartblock*********************************************************************!!!!")
  MadDoctorSpider_StartFinalBattle()
  return 
end
MadDoctorSpider_StartFinalBattle = function()
  Print("MDDBF START FINAL BATTLE 1*********************************************************************!!!!")
  if (spiderBoss_LevelStarted == false) then
    spiderBoss_LevelStarted = true
    Print("MDDBF START FINAL BATTLE 2*********************************************************************!!!!")
    ForcePainted(".MaskRotator 01")
    ForcePainted(".MaskRotator 03")
    ForcePainted(".MaskRotator 05")
    ForcePainted(".MaskRotator 02")
    ForcePainted(".MaskRotator 04")
    ForcePainted(".MaskRotator 06")
    StopEmitterByName(SpiderBoss, "MaskHit")
    AnimEvent(GetPlayer(), EVENT_Force_Idle)
    AnimEvent(GetPlayer2OrAI(), EVENT_Force_Idle)
    if (NewRidePath == "Thinner") then
      ForEachEntityInGroup(ForceSketched, ".lowerToon")
      SetCameraAttributesForPlayer("Stage2Cam")
      ForEachEntityInGroup(Enable, "CameraVolumeStage2Group")
    else
      ForEachEntityInGroup(ForcePainted, ".lowerToon")
      SetCameraAttributesForPlayer("Stage1Cam")
      ForEachEntityInGroup(Enable, "CameraVolumeStage1Group")
    end
    AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_Boss_NewRide_Amb")
    AudioPostEventOn(GetPlayer(), "Stop_DEM2_BGS_newride_trans_airloop")
    AudioPostEventOn(GetPlayer(), "Stop_DEM2_BGS_newride_trans_airloop")
    SpiderBoss_StartThinnerEffects()
    AI_MadDoctorSpider_SetupMasks()
    AI_MadDoctorSpider_ShooterInit()
    AnimEvent(SpiderBoss, EVENT_Force_Idle)
    if (NewRidePath == "Thinner") then
      SetCameraAttributesForPlayer("Stage2Cam")
      ForEachEntityInGroup(Enable, "CameraVolumeStage2Group")
    else
      SetCameraAttributesForPlayer("Stage1Cam")
      ForEachEntityInGroup(Enable, "CameraVolumeStage1Group")
    end
    Print("MDDBF START FINAL BATTLE PISTONS OFF 1 !!!!*********************************************************************!!!!")
    PistonsOff(".PistonInert 01")
    PistonsOff(".PistonInert 01_2")
    Print("MDDBF START FINAL BATTLE PISTONS OFF 2 !!!!*********************************************************************!!!!")
    if (NewRidePath == "Thinner") then
      Print("MDDBF START FINAL BATTLE THINNER PATH !!!!*********************************************************************!!!!")
      spiderBoss_State = "low"
      SetCameraAttributesForPlayer("Stage2Cam")
      ForEachEntityInGroup(Enable, "CameraVolumeStage1Group")
    else
      Print("MDDBF START FINAL BATTLE PAINT PATH !!!!*********************************************************************!!!!")
      spiderBoss_State = "low"
      SetCameraAttributesForPlayer("Stage1Cam")
      ForEachEntityInGroup(Enable, "CameraVolumeStage1Group")
    end
    AI_MadDoctorSpider_RepaintMasks()
    Print("MDDBF START FINAL BATTLE Cutscene END 1 !!!!*********************************************************************!!!!")
    SpiderBoss_CutsceneEnd()
    while true do
      wait(1)
    end
    wait(1)
    SpiderBoss_CutsceneEnd()
    Print("MDDBF START FINAL BATTLE CUSCENE END 2 !!!!*********************************************************************!!!!")
    if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
      if (NewRidePath == "Thinner") then
        SpiderBoss_3_SaveCheckpoint()
        SetCameraAttributesForPlayer("Stage2Cam")
        ForEachEntityInGroup(Enable, "CameraVolumeStage2Group")
      else
        SpiderBoss_1_SaveCheckpoint()
        SetCameraAttributesForPlayer("Stage1Cam")
        ForEachEntityInGroup(Enable, "CameraVolumeStage1Group")
      end
    end
    DestroyEntity("mst_maddoctornewride_01a_streaming.StreamingWalls")
    DestroyEntity("mst_maddoctornewride_01a_main_player.HandFake")
    DestroyEntity("mst_maddoctornewride_01a_streaming.StreamingSection")
    Print("MDDBF START FINAL BATTLE END!!!!*********************************************************************!!!!")
    if (NewRidePath == "Paint") then
      AI_MadDoctorSpider_BattleFlow()
    end
  end
  return 
end
AI_MadDoctorSpider_BattleFlow = function()
  Print("MDDBF BATTLE FLOW START!!!!*********************************************************************!!!!")
  if (spiderBoss_BattleFlowStarted == false) then
    Print("MDDBF BATTLE FLOW START 1 !!!!*********************************************************************!!!!")
    spiderBoss_BattleFlowStarted = true
    if (NewRidePath ~= "Thinner") then
      Print("MDDBF BATTLE FLOW START PAINT NOT THINNER!!!!*********************************************************************!!!!")
      MadDoctorSpider_SetToFirstPlatform(SpiderBoss, false)
    end
    Print("MDDBF BATTLE FLOW START 2 !!!!*********************************************************************!!!!")
    SetPropertyBool("Stage1Cam", "InstantTransition", false)
    SetPropertyBool("Stage2Cam", "InstantTransition", false)
    AI_MadDoctorSpider_AttackController()
    ClearAllCameraAttributes()
    Print("MDDBF BATTLE FLOW START 3 !!!!*********************************************************************!!!!")
    SpiderBoss_HackingInProgress()
    SpiderBoss_GuardiansInProgress()
    Print("MDDBF BATTLE FLOW START 4 !!!!*********************************************************************!!!!")
    SpiderBoss_CutsceneEnd()
    if (3 > MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
      local paintPath = false
    end
    local paintPath = true
    local route = ST_THINNER
    Print("MDDBF BATTLE FLOW START 5 !!!!*********************************************************************!!!!")
    if (paintPath == true) then
      Print("MDDBF BATTLE FLOW START PAINT !!!!*********************************************************************!!!!")
      route = ST_PAINT
    end
    SetGlobal("Boss_MechRoute", route)
    if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
      SpiderBoss_2_SaveCheckpoint()
    end
    spiderBoss_State = "none"
    Print("MDDBF BATTLE FLOW START 6 !!!!*********************************************************************!!!!")
    while true do
      wait(1)
    end
    SpiderBoss_MoveToTopPlatform(route)
    Print("MDDBF BATTLE FLOW START 7 !!!!*********************************************************************!!!!")
    AI_MadDoctorSpider_Battle2()
  end
  return 
end
NewRide_ResetPlayerCamera = function()
  wait(1)
  ClearCameraAttributesForPlayer(".CamMainTracking")
  SetCameraAttributesForPlayer(".CamMainTracking")
  return 
end
AI_MadDoctorSpider_RandomTauntDialog = function()
  wait(4)
  if (InIGCRandomDialogBlock == 0) then
    FireSequence("MickeyConvoTransition", "MST_NewRide_Doctor_Random")
  end
  return 
end
AI_MadDoctorSpider_Battle2 = function()
  Print("MDDBF MADDoctor Spider BATTLE2 START !!!!*********************************************************************!!!!")
  spiderBoss_IsFirstStage = false
  while true do
    while true do
      wait(1)
    end
  end
  Print("MDDBF MADDoctor Spider BATTLE2 1 !!!!*********************************************************************!!!!")
  wait(3)
  spiderBoss_State = "low"
  Enable("mst_maddoctornewride_02a_main.S2_Path 04")
  AI_MadDoctorSpider_AttackController()
  Print("MDDBF MADDoctor Spider BATTLE2 2 !!!!*********************************************************************!!!!")
  ClearAllCameraAttributes()
  SpiderBoss_HackingInProgress()
  SpiderBoss_GuardiansInProgress()
  ClearAllCameraAttributes()
  NewRideTestHackLoop = 0
  Print("MDDBF MADDoctor Spider BATTLE2 3 !!!!*********************************************************************!!!!")
  spiderBoss_Complete = true
  NewRide_Awards()
  if (NewRideOutcome == "paint") then
    SetGlobal("Extras_Mad_Doctor_Redemption", 1)
    Print("MAD DOC REDEEMED PAINT********************************************************")
    Print(GetGlobal("Extras_Mad_Doctor_Redemption"))
  elseif (NewRideOutcome == "thinner") then
    SetGlobal("Extras_Mad_Doctor_Redemption", 0)
    Print(GetGlobal("Extras_Mad_Doctor_Redemption"))
    Print("MAD DOC REDEEMED THINNER********************************************************")
  end
  Print("MDDBF Spider boss end stage2********************************************************")
  SpiderBossEndStage2()
  return 
end
AI_MadDoctorSpider_AttackController = function()
  spiderBoss_IgnoreHit = false
  MadDoctorSpider_EnableTracking(SpiderBoss)
  MadDoctorSpider_SetLowMode(SpiderBoss)
  MadDoctorSpider_EnableMaskShooter(SpiderBoss, true)
  FireThread(AI_MadDoctorSpider_OswaldAttacks)
  FireThread(SpiderBoss_ShockReaction_Low)
  while true do
    if (SpiderBoss_IsBeingShocked == false) then
      SpiderBoss_SetMaskRotatorSpeed(MaskNormal)
    end
    if (spiderBoss_HasReachedTopPlatform == 0) then
      spiderBoss_RandomAttack = math.random(10)
    else
      spiderBoss_RandomAttack = math.random(11)
    end
    AI_SpiderBoss_LowModeAttacks()
    if (not (spiderBoss_State ~= "stunned")) then
      break
    end
  end
  return 
end
SpiderBoss_EnterStunnedState = function()
  if (spiderBoss_HasReachedTopPlatform == 0) then
    Disable("mst_maddoctornewride_02a_main.TriggerLowerPistonsLvlStart")
    Disable("mst_maddoctornewride_02a_main.TriggerLowerPistonsUp 01")
  else
    Disable("mst_maddoctornewride_02a_main.TriggerSaveCheckpoint_Top")
    Disable("mst_maddoctornewride_02a_main.TriggerTopPistonsUp")
  end
  MadDoctorSpider_EnableMaskShooter(SpiderBoss, false)
  while true do
    wait(1)
    if (not (SpiderBoss_IsCutsceneFinished ~= true)) then
      break
    end
  end
  ClearAllCameraAttributes()
  return 
end
SpiderBoss_HackingInProgress = function()
  local hackReminder = 0
  Print("MDDBF Hacking in progress START********************************************************")
  Print(spiderBoss_State)
  Print(spiderBoss_HasReachedTopPlatform)
  if (spiderBoss_HasReachedTopPlatform == 0) then
    Enable(".NRH_SpiderHackPoint")
  else
    Enable(".NRH_SpiderHackPoint2")
  end
  wait(10)
  Print("MDDBF Hacking in progress START 3********************************************************")
  if (spiderBoss_HasReachedTopPlatform == 0) then
    if (OswaldAlreadyHackedMDNR1 == 0) then
      OswaldAlreadyHackedMDNR1 = 1
      Print("MDDBF Hacking in progress START 4S********************************************************")
      OswaldHackAction(".NRH_SpiderHackPoint")
      Print("MDDBF Hacking in progress START 4E********************************************************")
    end
  elseif (OswaldAlreadyHackedMDNR2 == 0) then
    OswaldAlreadyHackedMDNR2 = 1
    Print("MDDBF Hacking in progress START 5S********************************************************")
    OswaldHackAction(".NRH_SpiderHackPoint2")
    Print("MDDBF Hacking in progress START 5E********************************************************")
  end
  NewRideTestHackLoop = 0
  return 
end
NewRide_OswaldHackMagic = function(target)
  Print("********************************OSWALD HACKING START")
  if (spiderBoss_HasReachedTopPlatform == 0) then
    OswaldAlreadyHackedMDNR1 = 1
    Print("MDDBF Hacking in progress START 4S********************************************************")
    OswaldHackAction(".NRH_SpiderHackPoint")
    Print("MDDBF Hacking in progress START 4E********************************************************")
  else
    OswaldAlreadyHackedMDNR2 = 1
    Print("MDDBF Hacking in progress START 5S********************************************************")
    OswaldHackAction(".NRH_SpiderHackPoint2")
    Print("MDDBF Hacking in progress START 5E********************************************************")
  end
  Print("********************************OSWALD HACKING END")
  return 
end
stage2camerasetup = function(player)
  Print("MDDBF Set Stage 2 Camera********************************************************")
  SetCameraAttributesForPlayer("mst_maddoctornewride_02a_main.Stage2Cam", player)
  NewRide_Thinner_Stage_End("mst_maddoctornewride_02a_main.Marker(Rotatable) 10", "mst_maddoctornewride_02a_main.Marker(Rotatable) 09")
  return 
end
Clearstage2camera = function(player)
  Print("MDDBF Clear Stage 2 Camera********************************************************")
  ClearCameraAttributesForPlayer("mst_maddoctornewride_02a_main.Stage2Cam", player)
  return 
end
Stage2CameraRevive = function(target, event, instigator)
  local subEvent = ReviveEvent_GetSubEvent(event)
  if (subEvent == ReviveEvent_Respawn) then
    Print(("Stage2CameraRevive respawn for " .. GetPropertyString(instigator, "EntityGroups", 0)))
    Print(("Stage2CameraRevive LastCheckpointPos_Mickey is " .. LastCheckpointPos_Mickey))
    if (LastCheckpointPos_Mickey == "Checkpoint_1") then
      SetCameraAttributesForPlayer("Stage1Cam", instigator)
    elseif (LastCheckpointPos_Mickey == "Checkpoint_3") then
      SetCameraAttributesForPlayer("Stage2Cam", instigator)
    end
  end
  return 
end
SpiderBoss_Revive = function()
  NewRideTestHackLoop = 0
  AnimEvent(SpiderBoss, EVENT_StunRecover)
  AI_MadDoctorSpider_RepaintMasks()
  while true do
    wait(1)
  end
  if (spiderBoss_HasReachedTopPlatform == 0) then
    Enable("mst_maddoctornewride_02a_main.TriggerLowerPistonsLvlStart")
    Enable("mst_maddoctornewride_02a_main.TriggerLowerPistonsUp 01")
  else
    Enable("mst_maddoctornewride_02a_main.TriggerSaveCheckpoint_Top")
    Enable("mst_maddoctornewride_02a_main.TriggerTopPistonsUp")
  end
  SetPropertyInt("SpiderBoss", "Knockback Max Stim", 5)
  AI_MadDoctorSpider_AttackController()
  Enable(".NRH_SpiderHackPoint")
  Enable(".NRH_SpiderHackPoint2")
  if (spiderBoss_HasReachedTopPlatform == 0) then
    OswaldJumpNoFollowAction(".HackLocationMarker")
  else
    OswaldJumpNoFollowAction(".HackLocationMarker_Top")
  end
  SpiderBoss_EnterStunnedState()
  return 
end
NewRide_HackSuccess = function()
  spiderBoss_State = "hacked"
  wait(2)
  Print("MDDBF Hacking Success! START********************************************************")
  Print(spiderBoss_State)
  Print(spiderBoss_HasReachedTopPlatform)
  if (spiderBoss_HasReachedTopPlatform == 0) then
    if (OswaldAlreadyCelebratedMDNR1 == 0) then
      Print("MDDBF Hacking Success! 1S********************************************************")
      OswaldAlreadyCelebratedMDNR1 = 1
      AnimGBSequence("mst_maddoctornewride_02a_main.S2_LowerDoor0002", "open")
      FireSequence("OswaldConvoV2", "MST_NewRide_Oswald_021")
      AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_GuardianDoor_Start")
      Print("MDDBF DISABLING MARKER SUCCESS********************************************************")
      Disable("OswaldMarker1")
      wait(3.5)
      ForEachEntityInGroup(SplineFollower_SetDisabled, "MADDOCGUARDIANS", true)
      ForEachEntityInGroup(SetParentEntity, "MADDOCGUARDIANS", "mst_maddoctornewride_02a_main.NonPhysicalSplinefollowerRotator 03")
      ForEachEntityInGroup(AnimGBSequence, "MADDOCGUARDIANSNEW", "attack", true)
      Enable("mst_maddoctornewride_02a_main.NonPhysicalSplinefollowerRotator 03")
      wait(1)
      AudioPostEventOn(GetPlayer(), "Stop_DEM2_BGS_GuardianDoor")
      Print("MDDBF Hacking Success! 1E********************************************************")
      ClearAllCameraAttributes("Stage1Cam")
    end
  elseif (spiderBoss_HasReachedTopPlatform == 1) then
    if (OswaldAlreadyCelebratedMDNR2 == 0) then
      OswaldAlreadyCelebratedMDNR2 = 1
      Print("MDDBF Hacking Success! 2S********************************************************")
      AnimGBSequence("mst_maddoctornewride_02a_main.S2_UpperDoor", "open")
      FireSequence("OswaldConvoV2", "MST_NewRide_Oswald_021")
      AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_GuardianDoor_Start")
      Disable("OswaldMarker2")
      wait(3.5)
      ForEachEntityInGroup(SplineFollower_SetDisabled, "MADDOCGUARDIANS2", true)
      ForEachEntityInGroup(SetParentEntity, "MADDOCGUARDIANS2", "mst_maddoctornewride_02a_main.NonPhysicalSplinefollowerRotator 04")
      ForEachEntityInGroup(AnimGBSequence, "MADDOCGUARDIANS2NEW", "attack", true)
      Enable("mst_maddoctornewride_02a_main.NonPhysicalSplinefollowerRotator 04")
      wait(1)
      if (3 < MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
        FireUser1(".HighPaintGuardianSpawner")
      else
        FireUser1(".HighThinnerGuardianSpawner")
      end
      AudioPostEventOn(GetPlayer(), "Stop_DEM2_BGS_GuardianDoor")
      Print("MDDBF Hacking Success! 2E********************************************************")
    end
  end
  Print("MDDBF Hacking Success! END********************************************************")
  return 
end
GuardianAttckAgainstBoss1 = function()
  ForEachEntityInGroup(AnimGBSequence, "MADDOCGUARDIANSNEW", "attack2", true)
  return 
end
GuardianAttckAgainstBoss1Destroy = function()
  ForEachEntityInGroup(DestroyEntity, "MADDOCGUARDIANSNEW")
  return 
end
GuardianAttckAgainstBoss2Destroy = function()
  ForEachEntityInGroup(DestroyEntity, "MADDOCGUARDIANSNEW2")
  return 
end
GuardianAttckAgainstBoss2 = function()
  ForEachEntityInGroup(AnimGBSequence, "MADDOCGUARDIANSNEW2", "attack2", true)
  return 
end
SpiderBoss_HackingSuccessful = function()
  Print("MDDBF Hacking Successful START********************************************************")
  Print(spiderBoss_State)
  Print(spiderBoss_HasReachedTopPlatform)
  if (spiderBoss_HasReachedTopPlatform == 0) then
    if (AllowHackBoxUp == 0) then
      AllowHackBoxUp = 1
      Print("MDDBF Hacking Successful 1S********************************************************")
      Enable("mst_maddoctornewride_02a_main.NonPhysicalSplinefollowerRotator 01")
      Reverse("mst_maddoctornewride_02a_main.NonPhysicalSplinefollowerRotator 01")
      AllowHackBoxUp = 1
      Print("MDDBF Hacking Successful 1E********************************************************")
    end
  else
    Print("MDDBF Hacking Successful 2S********************************************************")
    if (AllowHackBoxUp == 0) then
      AllowHackBoxUp = 1
      Enable("mst_maddoctornewride_02a_main.NonPhysicalSplinefollowerRotator 02")
      Reverse("mst_maddoctornewride_02a_main.NonPhysicalSplinefollowerRotator 02")
      Print("MDDBF Hacking Successful 2E********************************************************")
    end
  end
  Print("MDDBF Hacking Successful END********************************************************")
  return 
end
SpiderBoss_GuardiansInProgress = function()
  local distanceFromGuardians = 0
  NewRideTestGuardianLoop = 0
  while true do
    if (130 <= NewRideTestGuardianLoop) then
      Print("REVIVE!!!")
      FireSequence("GusConvoV2", "MST_NewRide_Gus_001")
      if (spiderBoss_HasReachedTopPlatform == 0) then
        if (AllowHackBoxUp == 1) then
          AllowHackBoxUp = 0
          Reverse("mst_maddoctornewride_02a_main.NonPhysicalSplinefollowerRotator 01")
          StopAbility(GetPlayer2OrAI(), "Hack")
          Print("MDDBF DISABLING MARKER REVIVE********************************************************")
          Disable("OswaldMarker1")
          ForEachEntityInGroup(Enable, "CameraVolumeStage1Group")
        end
      elseif (AllowHackBoxUp == 1) then
        AllowHackBoxUp = 0
        Reverse("mst_maddoctornewride_02a_main.NonPhysicalSplinefollowerRotator 02")
        StopAbility(GetPlayer2OrAI(), "Hack")
        Disable("OswaldMarker2")
        ForEachEntityInGroup(Enable, "CameraVolumeStage2Group")
      end
      spiderBoss_State = "low"
      SpiderBoss_Revive_Guardians()
    elseif (NewRideTestGuardianLoop == 120) then
      Print("WAKING UP!!!")
      AnimEvent(SpiderBoss, EVENT_StunIdle)
      NewRideTestGuardianLoop = (NewRideTestGuardianLoop + 1)
    else
      wait(1)
      NewRideTestGuardianLoop = (NewRideTestGuardianLoop + 1)
    end
    if (not (spiderBoss_State ~= "guardianed_paint")) then
      break
    end
  end
  Print("WAKING UP!!!")
  spiderBoss_State = "none"
  AllowHackBoxUp = 0
  NewRideTestGuardianLoop = 0
  return 
end
GuardianRevealing = function()
  if (spiderBoss_HasReachedTopPlatform == 0) then
    if (3 < MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
      if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 4) then
        Hide("STAGE1THIN1")
        Hide("STAGE1THIN2")
        Hide("STAGE1THIN3")
        Show("STAGE1PAINT1")
        Hide("STAGE1PAINT2")
        Hide("STAGE1PAINT3")
      elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 5) then
        Show("STAGE1PAINT2")
        Hide("STAGE1PAINT3")
      elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 6) then
        Show("STAGE1PAINT3")
        if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 2) then
          Hide("STAGE1PAINT1")
          Hide("STAGE1PAINT2")
          Hide("STAGE1PAINT3")
          Show("STAGE1THIN1")
          Hide("STAGE1THIN2")
          Hide("STAGE1THIN3")
        elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 1) then
          Show("STAGE1THIN2")
          Hide("STAGE1THIN3")
        elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 0) then
          Show("STAGE1THIN3")
          if (3 < MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
            if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 4) then
              Hide("STAGE2THIN1")
              Hide("STAGE2THIN2")
              Hide("STAGE2THIN3")
              Show("STAGE2PAINT1")
              Hide("STAGE2PAINT2")
              Hide("STAGE2PAINT3")
            elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 5) then
              Show("STAGE2PAINT2")
              Hide("STAGE2PAINT3")
            elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 6) then
              Show("STAGE2PAINT3")
              if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 2) then
                Hide("STAGE2PAINT1")
                Hide("STAGE2PAINT2")
                Hide("STAGE2PAINT3")
                Show("STAGE2THIN1")
                Hide("STAGE2THIN2")
                Hide("STAGE2THIN3")
              elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 1) then
                Show("STAGE2THIN2")
                Hide("STAGE2THIN3")
              elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 0) then
                Show("STAGE2THIN3")
              end
            end
          elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 2) then
            Hide("STAGE2PAINT1")
            Hide("STAGE2PAINT2")
            Hide("STAGE2PAINT3")
            Show("STAGE2THIN1")
            Hide("STAGE2THIN2")
            Hide("STAGE2THIN3")
          elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 1) then
            Show("STAGE2THIN2")
            Hide("STAGE2THIN3")
          elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 0) then
            Show("STAGE2THIN3")
          end
        end
      end
    elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 2) then
      Hide("STAGE1PAINT1")
      Hide("STAGE1PAINT2")
      Hide("STAGE1PAINT3")
      Show("STAGE1THIN1")
      Hide("STAGE1THIN2")
      Hide("STAGE1THIN3")
    elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 1) then
      Show("STAGE1THIN2")
      Hide("STAGE1THIN3")
    elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 0) then
      Show("STAGE1THIN3")
      if (3 < MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
        if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 4) then
          Hide("STAGE2THIN1")
          Hide("STAGE2THIN2")
          Hide("STAGE2THIN3")
          Show("STAGE2PAINT1")
          Hide("STAGE2PAINT2")
          Hide("STAGE2PAINT3")
        elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 5) then
          Show("STAGE2PAINT2")
          Hide("STAGE2PAINT3")
        elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 6) then
          Show("STAGE2PAINT3")
          if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 2) then
            Hide("STAGE2PAINT1")
            Hide("STAGE2PAINT2")
            Hide("STAGE2PAINT3")
            Show("STAGE2THIN1")
            Hide("STAGE2THIN2")
            Hide("STAGE2THIN3")
          elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 1) then
            Show("STAGE2THIN2")
            Hide("STAGE2THIN3")
          elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 0) then
            Show("STAGE2THIN3")
          end
        end
      elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 2) then
        Hide("STAGE2PAINT1")
        Hide("STAGE2PAINT2")
        Hide("STAGE2PAINT3")
        Show("STAGE2THIN1")
        Hide("STAGE2THIN2")
        Hide("STAGE2THIN3")
      elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 1) then
        Show("STAGE2THIN2")
        Hide("STAGE2THIN3")
      elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 0) then
        Show("STAGE2THIN3")
      end
    end
  elseif (3 < MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
    if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 4) then
      Hide("STAGE2THIN1")
      Hide("STAGE2THIN2")
      Hide("STAGE2THIN3")
      Show("STAGE2PAINT1")
      Hide("STAGE2PAINT2")
      Hide("STAGE2PAINT3")
    elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 5) then
      Show("STAGE2PAINT2")
      Hide("STAGE2PAINT3")
    elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 6) then
      Show("STAGE2PAINT3")
      if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 2) then
        Hide("STAGE2PAINT1")
        Hide("STAGE2PAINT2")
        Hide("STAGE2PAINT3")
        Show("STAGE2THIN1")
        Hide("STAGE2THIN2")
        Hide("STAGE2THIN3")
      elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 1) then
        Show("STAGE2THIN2")
        Hide("STAGE2THIN3")
      elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 0) then
        Show("STAGE2THIN3")
      end
    end
  elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 2) then
    Hide("STAGE2PAINT1")
    Hide("STAGE2PAINT2")
    Hide("STAGE2PAINT3")
    Show("STAGE2THIN1")
    Hide("STAGE2THIN2")
    Hide("STAGE2THIN3")
  elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 1) then
    Show("STAGE2THIN2")
    Hide("STAGE2THIN3")
  elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 0) then
    Show("STAGE2THIN3")
  end
  return 
end
canGuardianStim = true
SpiderBoss_GuardianAttack2 = function(target, event)
  Print("GuardianAttack2 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
  Print(canGuardianStim)
  Print(spiderBoss_State)
  if (canGuardianStim == true) then
    if (spiderBoss_State == "hacked") then
      canGuardianStim = false
      if (3 < MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
        Print(MadDoctorSpider_GetPaintedMaskCount(SpiderBoss))
        Print("SETTING BOSS STATE PAINT********************************************************")
        ForEachEntityInGroup(DestroyEntity, "MADDOCGUARDIANS")
        spiderBoss_State = "guardianed_paint"
        NewRideOutcome = "paint"
        SetGlobal("Boss_NewRideStyle", false)
        Print("SETTING BOSS STATE PAINT 2********************************************************")
        if (spiderBoss_HasReachedTopPlatform == 0) then
          FireSequence("GusConvoV2", "MST_NewRide_Gus_013")
          SpiderBoss_MoveToTopPlatform(ST_PAINT)
        end
      elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) < 4) then
        Print(MadDoctorSpider_GetPaintedMaskCount(SpiderBoss))
        Print("SETTING BOSS STATE THINNER********************************************************")
        ForEachEntityInGroup(DestroyEntity, "MADDOCGUARDIANS")
        spiderBoss_State = "guardianed_thinner"
        NewRideOutcome = "thinner"
        SetGlobal("Boss_NewRideStyle", true)
        Print("SETTING BOSS STATE THNNER 2********************************************************")
        if (spiderBoss_HasReachedTopPlatform == 0) then
          SpiderBoss_MoveToTopPlatform(ST_THINNER)
        end
      end
      canGuardianStim = true
      SetPropertyInt("SpiderBoss", "Knockback Max Stim", 5)
    end
  end
  return 
end
SpiderBoss_Revive_Guardians = function()
  NewRideTestGuardianLoop = 0
  SpiderBoss_Revive()
  SpiderBoss_HackingInProgress()
  SpiderBoss_HackingSuccessful()
  if (spiderBoss_HasReachedTopPlatform == 0) then
    Enable(".GuardianTriggerTarget")
    if (3 <= MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
      GuardianController_SetTarget(".Guardian_Paint", ".GuardianTriggerTarget")
    else
      GuardianController_SetTarget(".Guardian_Thinner", ".GuardianTriggerTarget")
      Enable(".GuardianTriggerTarget_Top")
      if (3 <= MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
        GuardianController_SetTarget(".Guardian_Paint", ".GuardianTriggerTarget_Top")
      else
        GuardianController_SetTarget(".Guardian_Thinner", ".GuardianTriggerTarget_Top")
      end
    end
  else
    Enable(".GuardianTriggerTarget_Top")
    if (3 <= MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
      GuardianController_SetTarget(".Guardian_Paint", ".GuardianTriggerTarget_Top")
    else
      GuardianController_SetTarget(".Guardian_Thinner", ".GuardianTriggerTarget_Top")
    end
  end
  Enable("mst_maddoctornewride_02a_main.TriggerSaveCheckpoint_Top")
  return 
end
SpiderBoss_MoveToTopPlatform = function(path)
  if (spiderBoss_MoveToTopPlatform == 0) then
    spiderBoss_MoveToTopPlatform = 1
    SpiderBoss_IsCutsceneFinished = false
    MadDoctorSpider_SetToSecondPlatform(SpiderBoss, true, GetPosition(".SpiderOriginTop"))
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_PistonToon 01", 25)
    SetSplineFollowerInitialSpeed("MST_madDoctorNewRide_02a_Main.S2_PistonToon 02", 25)
    Enable("mst_maddoctornewride_02a_main.TriggerTopPistonsUp")
    Enable("mst_maddoctornewride_02a_main.TriggerSaveCheckpoint_Top")
    if (path == ST_PAINT) then
      spiderBoss_PistonsActive = true
      PistonsOff(".PistonInert 01")
      wait(2)
      PistonsStep(".PistonInert 01")
      Enable("MST_madDoctorNewRide_02a_Main.TriggerPaintPath")
      SpiderBoss_Toon_SpawnETicket("mst_maddoctornewride_02a_main.S2_PistonPickup.Spawner 01")
    else
      Pistons_ThinnerPath()
    end
    print("After path selection")
    while true do
      wait(1)
    end
    OswaldStartFollowAction()
    spiderBoss_State = "low"
    AI_MadDoctorSpider_RepaintMasks()
  end
  return 
end
AI_MadDoctorSpider_InstantAttack = function()
  while true do
    local distance = MadDoctorSpider_GetDistanceToTarget(SpiderBoss)
    if (distance < 6) then
      if (MadDoctorSpider_GetCurrentState(SpiderBoss) ~= "LeftRingAttack") then
        if (MadDoctorSpider_GetCurrentState(SpiderBoss) ~= "RightRingAttack") then
          MadDoctorSpider_StartShockwaveAttack(SpiderBoss)
          wait(2)
          SpiderBoss_CameraShake_Medium()
          wait(3)
        end
      end
    else
      wait(0.20000000298023224)
    end
  end
  return 
end
SpiderBoss_MaskFullyPainted = function()
  FireThread(GuardianRevealing)
  Print("MASKFULLYPAINTED START")
  if (spiderBoss_IgnoreHit == false) then
    Print("MASKFULLY PAINTED START 1")
    if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 6) then
      if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 6) then
        FireSequence("GusConvoV2", "MST_NewRide_Gus_008")
      end
      Print("MASKFULLY PAINTED all masks done")
      SpiderBoss_AllMasksDone()
    end
    if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 4) then
      FireSequence("GusConvoV2", "MST_NewRide_Gus_010")
    end
    Print("MASKFULLY PAINTED Hit Response")
    SpiderBoss_HitResponse("paint")
  end
  return 
end
SpiderBoss_MaskFullyThinned = function()
  FireThread(GuardianRevealing)
  Print("MASKFULLY Thinned START")
  if (spiderBoss_IgnoreHit == false) then
    Print("MASKFULLY Thinned START 1")
    if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 6) then
      if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 0) then
        FireSequence("GusConvoV2", "MST_NewRide_Gus_009")
      end
      Print("MASKFULLY Thinned ALL MASKS DONE")
      SpiderBoss_AllMasksDone()
    end
    if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 2) then
      FireSequence("GusConvoV2", "MST_NewRide_Gus_011")
    end
    Print("MASKFULLY Thinned HIT RESPONSE")
    SpiderBoss_HitResponse("thinner")
  end
  return 
end
SpiderBoss_AllMasksDone = function()
  SpiderBoss_IsCutsceneFinished = false
  spiderBoss_State = "stunned"
  SpiderBoss_SetMaskRotatorSpeed((MaskAngry + 100))
  MadDoctorSpider_DisableTracking(SpiderBoss)
  MadDoctorSpider_EnableMaskShooter(SpiderBoss, false)
  if (spiderBoss_HasReachedTopPlatform == 0) then
    SpiderBoss_HackingSuccessful()
    TeleportToEntity("SpiderBoss", ".SpiderOrigin")
    MadDoctorSpider_SetVulnerableMode(SpiderBoss, true)
    Print("MDDBF ENABLING MARKER********************************************************")
    Enable("OswaldMarker1")
    Disable("CameraVolumeStage1")
    ClearAllCameraAttributes()
  else
    SpiderBoss_HackingSuccessful()
    TeleportToEntity("SpiderBoss", ".SpiderOriginTop")
    MadDoctorSpider_SetVulnerableMode(SpiderBoss, false)
    Enable("OswaldMarker2")
    Disable("CameraVolumeStage2")
    ClearAllCameraAttributes()
  end
  SetPropertyInt("SpiderBoss", "Knockback Max Stim", 1)
  wait(6)
  SpiderBoss_SetMaskRotatorSpeed(MaskStopped)
  return 
end
SpiderBoss_HitResponse = function(weapon)
  StartEmitterByName(SpiderBoss, "MaskHit")
  AnimEvent(SpiderBoss, EVENT_Hit)
  if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 1) then
    MaskNormal = 200
  elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 2) then
    MaskNormal = 100
  elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 4) then
    MaskNormal = 100
  elseif (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) == 5) then
    MaskNormal = 200
  else
    MaskNormal = 70
  end
  SpiderBoss_SetMaskRotatorSpeed(MaskNormal)
  if (weapon == "paint") then
    print("paint response/dialogue")
  else
    print("thinner response/dialogue")
  end
  wait(2)
  StopEmitterByName(SpiderBoss, "MaskHit")
  return 
end
SpiderBoss_HasReachedTopPlatform = function()
  if (spiderBoss_HasReachedTopPlatform == 0) then
    local Oswald = GetPlayer2OrAI()
    if IsValidHandle(Oswald) then
      MoveToEntity(Oswald, ".Checkpoint_3")
    else
      print("Oswald is missing.")
    end
    spiderBoss_HasReachedTopPlatform = 1
    Enable("mst_maddoctornewride_02a_main.S2_UpperDeathVolume")
    SpiderBoss_3_SaveCheckpoint()
  end
  return 
end
AI_MadDoctorSpider_OswaldAttacks = function()
  local oswaldPistonPathfinder = 0
  local oswaldChangePlatform = 0
  local currentPlatform = "string"
  local nextPlatform = "string"
  wait(8)
  if IsValidHandle(GetPlayer2OrAI()) then
    OswaldStopFighting()
    while true do
      if (spiderBoss_State == "low") then
        if (MadDoctorSpider_GetCurrentState(SpiderBoss) ~= "RightRingAttack") then
          spiderBoss_RandomTarget = 1
          OswaldStreamAction(".NRH_SpiderBody", 5)
          OswaldStreamAbort()
          wait(10)
          spiderBoss_RandomTarget = 0
        end
      end
      wait(1)
    end
    OswaldStreamAbort()
  end
  return 
end
Spider_OnAnimEvent = function(self, _event)
  local eventType = AnimEvent_Type(_event)
  local headingDiff = MadDoctorSpider_GetHeadingToTarget(SpiderBoss)
  if (eventType == EVENT_EnableAttackStrike) then
    print("EVENT_ENABLEATTACKSTRIKE")
    if (spiderBoss_CounterAttack == true) then
      MadDoctorSpider_AbortAttack(self)
    end
    if (-60 < headingDiff) then
      if (headingDiff < 60) then
        MadDoctorSpider_ConfirmAttack(self)
      end
    elseif (-120 < headingDiff) then
      if (headingDiff < 120) then
        MadDoctorSpider_ConfirmTurnThenAttack(self)
      end
    else
      MadDoctorSpider_AbortAttack(self)
      if (eventType == EVENT_IsInAttack) then
        SpiderBoss_IsInIdle = false
      elseif (eventType == EVENT_IsInIdle) then
        SpiderBoss_IsInIdle = true
      elseif (eventType == EVENT_CamShake_Light) then
        SpiderBoss_CameraShake_Light()
      elseif (eventType == EVENT_CamShake_Medium) then
        SpiderBoss_CameraShake_Medium()
      elseif (eventType == EVENT_CamShake_Heavy) then
        SpiderBoss_CameraShake_Heavy()
      elseif (eventType == EVENT_IsReady) then
        SpiderBoss_PostLoad()
      end
    end
  elseif (eventType == EVENT_IsInAttack) then
    SpiderBoss_IsInIdle = false
  elseif (eventType == EVENT_IsInIdle) then
    SpiderBoss_IsInIdle = true
  elseif (eventType == EVENT_CamShake_Light) then
    SpiderBoss_CameraShake_Light()
  elseif (eventType == EVENT_CamShake_Medium) then
    SpiderBoss_CameraShake_Medium()
  elseif (eventType == EVENT_CamShake_Heavy) then
    SpiderBoss_CameraShake_Heavy()
  elseif (eventType == EVENT_IsReady) then
    SpiderBoss_PostLoad()
  end
  return 
end
SpiderBoss_PlayerOnPistons = function()
  SpiderBoss_PlayerIsOnPistons = true
  return 
end
SpiderBoss_PlayerNotOnPistons = function()
  SpiderBoss_PlayerIsOnPistons = false
  return 
end
SpiderBoss_CameraShake_Light = function()
  ShakeCamera(1, 2, 0.019999999552965164, 1, 0.009999999776482582, 0.009999999776482582)
  return 
end
SpiderBoss_CameraShake_Medium = function()
  ShakeCamera(1.5, 8, 0.05000000074505806, 2, 0.019999999552965164, 0.009999999776482582)
  if (spiderBoss_HasReachedTopPlatform == 0) then
    ForceSpawn("PickupBouldersSpawner", 1)
  else
    ForceSpawn("PickupBouldersSpawnerTop", 1)
  end
  return 
end
SpiderBoss_CameraShake_Heavy = function()
  ShakeCamera(2, 20, 0.05000000074505806, 3, 0.009999999776482582, 0.029999999329447746)
  if (spiderBoss_HasReachedTopPlatform == 0) then
    ForceSpawn("PickupBouldersSpawner", 3)
  else
    ForceSpawn("PickupBouldersSpawnerTop", 3)
  end
  return 
end
AI_SpiderBoss_LowModeAttacks = function()
  local distance = MadDoctorSpider_GetDistanceToTarget(SpiderBoss)
  local headingDiff = MadDoctorSpider_GetHeadingToTarget(SpiderBoss)
  if (spiderBoss_HasReachedTopPlatform == 0) then
    print("MDDBF FIRST STAGE BEHAVIORS **********************************************")
    if (SpiderBoss_IsBeingShocked == false) then
      SpiderBoss_SetMaskRotatorSpeed(MaskNormal)
    end
    if (spiderBoss_CounterAttack == true) then
      spiderBoss_CounterAttack = false
    else
      if (spiderBoss_RandomTarget == 1) then
        MadDoctorSpider_TargetOswald(SpiderBoss, true)
      else
        MadDoctorSpider_TargetOswald(SpiderBoss, false)
      end
      if (MadDoctorSpider_GetDistanceToTarget(SpiderBoss) < 7) then
        FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
        MadDoctorSpider_StartShockwaveAttack(SpiderBoss)
      elseif (headingDiff <= 45) then
        if (-45 <= headingDiff) then
          if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) < 3) then
            if (spiderBoss_RandomAttack == 1) then
              spiderBoss_RandomAttack = 8
            end
            MadDoctorSpider_SetShooterInterval(SpiderBoss, 5)
            MadDoctorSpider_SetShooterAccuracy(SpiderBoss, 45, 0, 0.20000000298023224)
          elseif (3 < MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
            if (spiderBoss_RandomAttack == 4) then
              spiderBoss_RandomAttack = 3
            end
            MadDoctorSpider_SetShooterInterval(SpiderBoss, 1.5)
            MadDoctorSpider_SetShooterAccuracy(SpiderBoss, 45, 0, 0)
          else
            MadDoctorSpider_SetShooterInterval(SpiderBoss, 3)
            MadDoctorSpider_SetShooterAccuracy(SpiderBoss, 45, 0, 0.10000000149011612)
          end
          if (spiderBoss_RandomAttack <= 2) then
            FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
            MadDoctorSpider_StartSquashAttack(SpiderBoss)
          elseif (spiderBoss_RandomAttack <= 4) then
            FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
            MadDoctorSpider_StartLegAttack(SpiderBoss)
          elseif (spiderBoss_RandomAttack <= 7) then
            FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
            MadDoctorSpider_StartChargeAttack(SpiderBoss)
          else
            FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
            SpiderBoss_SetMaskRotatorSpeed(MaskAngry)
            MadDoctorSpider_StartRightRingAttack(SpiderBoss)
            if (45 < headingDiff) then
              MadDoctorSpider_StartJumpTurn(SpiderBoss, (headingDiff + 10))
            elseif (headingDiff < -45) then
              MadDoctorSpider_StartJumpTurn(SpiderBoss, (headingDiff - 10))
            else
              FireSequence("MadDocConvoV2", "MST_NewRide_Doctor_005")
              MadDoctorSpider_StartSquashAttack(SpiderBoss)
            end
          end
        end
      elseif (45 < headingDiff) then
        MadDoctorSpider_StartJumpTurn(SpiderBoss, (headingDiff + 10))
      elseif (headingDiff < -45) then
        MadDoctorSpider_StartJumpTurn(SpiderBoss, (headingDiff - 10))
      else
        FireSequence("MadDocConvoV2", "MST_NewRide_Doctor_005")
        MadDoctorSpider_StartSquashAttack(SpiderBoss)
      end
      wait(1)
      while true do
        wait(0.10000000149011612)
      end
      print("MDDBF SECOND STAGE BEHAVIORS **********************************************")
      if (SpiderBoss_IsBeingShocked == false) then
        SpiderBoss_SetMaskRotatorSpeed(MaskNormal)
      end
      if (spiderBoss_CounterAttack == true) then
        spiderBoss_CounterAttack = false
      else
        if (spiderBoss_RandomTarget == 1) then
          MadDoctorSpider_TargetOswald(SpiderBoss, true)
        else
          MadDoctorSpider_TargetOswald(SpiderBoss, false)
        end
        if (MadDoctorSpider_GetDistanceToTarget(SpiderBoss) < 7) then
          FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
          MadDoctorSpider_StartShockwaveAttack(SpiderBoss)
        elseif (headingDiff <= 45) then
          if (-45 <= headingDiff) then
            if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) < 3) then
              if (spiderBoss_RandomAttack == 1) then
                spiderBoss_RandomAttack = 8
              end
              MadDoctorSpider_SetShooterInterval(SpiderBoss, 3)
              MadDoctorSpider_SetShooterAccuracy(SpiderBoss, 45, 0, 0.20000000298023224)
            elseif (3 < MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
              if (spiderBoss_RandomAttack == 4) then
                spiderBoss_RandomAttack = 3
              end
              MadDoctorSpider_SetShooterInterval(SpiderBoss, 0.699999988079071)
              MadDoctorSpider_SetShooterAccuracy(SpiderBoss, 45, 0, 0)
            else
              MadDoctorSpider_SetShooterInterval(SpiderBoss, 1.5)
              MadDoctorSpider_SetShooterAccuracy(SpiderBoss, 45, 0, 0.10000000149011612)
            end
            if (spiderBoss_RandomAttack <= 2) then
              MadDoctorSpider_StartSquashAttack(SpiderBoss)
              FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
            elseif (spiderBoss_RandomAttack <= 4) then
              MadDoctorSpider_StartLegAttack(SpiderBoss)
              FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
            elseif (spiderBoss_RandomAttack <= 7) then
              MadDoctorSpider_StartChargeAttack(SpiderBoss)
              FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
            else
              SpiderBoss_SetMaskRotatorSpeed(MaskAngry)
              FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
              MadDoctorSpider_StartRightRingAttack(SpiderBoss)
              if (45 < headingDiff) then
                MadDoctorSpider_StartJumpTurn(SpiderBoss, (headingDiff + 10))
              elseif (headingDiff < -45) then
                MadDoctorSpider_StartJumpTurn(SpiderBoss, (headingDiff - 10))
              else
                FireSequence("MadDocConvoV2", "MST_NewRide_Doctor_005")
                MadDoctorSpider_StartSquashAttack(SpiderBoss)
              end
            end
          end
        elseif (45 < headingDiff) then
          MadDoctorSpider_StartJumpTurn(SpiderBoss, (headingDiff + 10))
        elseif (headingDiff < -45) then
          MadDoctorSpider_StartJumpTurn(SpiderBoss, (headingDiff - 10))
        else
          FireSequence("MadDocConvoV2", "MST_NewRide_Doctor_005")
          MadDoctorSpider_StartSquashAttack(SpiderBoss)
        end
        wait(1)
        while true do
          wait(0.10000000149011612)
          if (not (SpiderBoss_IsInIdle ~= true)) then
            break
          end
          if (not (spiderBoss_State == "low")) then
            break
          end
        end
      end
    end
  else
    print("MDDBF SECOND STAGE BEHAVIORS **********************************************")
    if (SpiderBoss_IsBeingShocked == false) then
      SpiderBoss_SetMaskRotatorSpeed(MaskNormal)
    end
    if (spiderBoss_CounterAttack == true) then
      spiderBoss_CounterAttack = false
    else
      if (spiderBoss_RandomTarget == 1) then
        MadDoctorSpider_TargetOswald(SpiderBoss, true)
      else
        MadDoctorSpider_TargetOswald(SpiderBoss, false)
      end
      if (MadDoctorSpider_GetDistanceToTarget(SpiderBoss) < 7) then
        FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
        MadDoctorSpider_StartShockwaveAttack(SpiderBoss)
      elseif (headingDiff <= 45) then
        if (-45 <= headingDiff) then
          if (MadDoctorSpider_GetPaintedMaskCount(SpiderBoss) < 3) then
            if (spiderBoss_RandomAttack == 1) then
              spiderBoss_RandomAttack = 8
            end
            MadDoctorSpider_SetShooterInterval(SpiderBoss, 3)
            MadDoctorSpider_SetShooterAccuracy(SpiderBoss, 45, 0, 0.20000000298023224)
          elseif (3 < MadDoctorSpider_GetPaintedMaskCount(SpiderBoss)) then
            if (spiderBoss_RandomAttack == 4) then
              spiderBoss_RandomAttack = 3
            end
            MadDoctorSpider_SetShooterInterval(SpiderBoss, 0.699999988079071)
            MadDoctorSpider_SetShooterAccuracy(SpiderBoss, 45, 0, 0)
          else
            MadDoctorSpider_SetShooterInterval(SpiderBoss, 1.5)
            MadDoctorSpider_SetShooterAccuracy(SpiderBoss, 45, 0, 0.10000000149011612)
          end
          if (spiderBoss_RandomAttack <= 2) then
            MadDoctorSpider_StartSquashAttack(SpiderBoss)
            FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
          elseif (spiderBoss_RandomAttack <= 4) then
            MadDoctorSpider_StartLegAttack(SpiderBoss)
            FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
          elseif (spiderBoss_RandomAttack <= 7) then
            MadDoctorSpider_StartChargeAttack(SpiderBoss)
            FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
          else
            SpiderBoss_SetMaskRotatorSpeed(MaskAngry)
            FireSequence("GusConvoV2", "MST_NewRide_Gus_005")
            MadDoctorSpider_StartRightRingAttack(SpiderBoss)
            if (45 < headingDiff) then
              MadDoctorSpider_StartJumpTurn(SpiderBoss, (headingDiff + 10))
            elseif (headingDiff < -45) then
              MadDoctorSpider_StartJumpTurn(SpiderBoss, (headingDiff - 10))
            else
              FireSequence("MadDocConvoV2", "MST_NewRide_Doctor_005")
              MadDoctorSpider_StartSquashAttack(SpiderBoss)
            end
          end
        end
      elseif (45 < headingDiff) then
        MadDoctorSpider_StartJumpTurn(SpiderBoss, (headingDiff + 10))
      elseif (headingDiff < -45) then
        MadDoctorSpider_StartJumpTurn(SpiderBoss, (headingDiff - 10))
      else
        FireSequence("MadDocConvoV2", "MST_NewRide_Doctor_005")
        MadDoctorSpider_StartSquashAttack(SpiderBoss)
      end
      wait(1)
      while true do
        wait(0.10000000149011612)
        if (not (SpiderBoss_IsInIdle ~= true)) then
          break
        end
        if (not (spiderBoss_State == "low")) then
          break
        end
      end
    end
  end
  return 
end
SpiderBoss_ShockReaction_Low = function()
  while true do
    if (SpiderBoss_IsBeingShocked == true) then
      SpiderBoss_SetMaskRotatorSpeed(MaskStopped)
      wait(3)
      SpiderBoss_IsBeingShocked = false
    end
    wait(0.5)
  end
  return 
end
SpiderBoss_TriggerThinnerAttack = function()
  local currentMask = MadDoctorSpider_GetCurrentMaskID(SpiderBoss)
  MadDoctorSpider_EnableMaskShooter(SpiderBoss, true)
  return 
end
canStim = true
Spider_OnStimulus = function(self, _event)
  if (canStim == true) then
    canStim = false
    if StimulusEvent_HasStimulusType(_event, ST_ELECTRIC) then
      SpiderBoss_IsBeingShocked = true
    elseif StimulusEvent_HasStimulusType(_event, ST_FAIRY) then
      Spider_FairyStimulus(self)
    elseif StimulusEvent_HasStimulusType(_event, ST_KNOCKBACK) then
      if (StimulusEvent_SourceStimulusAlias(_event) == "Anvil") then
        Spider_AnvilStimulus(self)
      end
    end
    canStim = true
  end
  return 
end
Spider_FairyStimulus = function(self)
  if (spiderBoss_State == "hacked") then
    return 
  end
  spiderBoss_State = "fairied"
  MadDoctorSpider_AbortAttack(SpiderBoss)
  MadDoctorSpider_SetFairied(SpiderBoss)
  MadDoctorSpider_DisableTracking(SpiderBoss)
  NotifyFairySketchHit()
  wait(4)
  return 
end
Spider_AnvilStimulus = function(self)
  if (spiderBoss_State == "hacked") then
    return 
  end
  spiderBoss_State = "anvilled"
  MadDoctorSpider_AbortAttack(SpiderBoss)
  MadDoctorSpider_SetAnvilled(SpiderBoss)
  MadDoctorSpider_DisableTracking(SpiderBoss)
  wait(4)
  return 
end
NewRide_Streaming = function(state)
  if (state == "both") then
    StreamZones(GetPlayer(), "both")
  elseif (state == "lower") then
    StreamZones(GetPlayer(), "lower")
  end
  return 
end
NewRide_Awards = function()
  print("MDDBF AWARD START********************************************************")
  if (NewRideOutcome == "paint") then
    GiveCollectible("Challenge_MustBeThisTall_Tracker")
    SetGlobal("TrustMadDocPin_Redeemed", 1)
    SetGlobal("Boss_SpiderStyle", false)
    print("MDDBF AWARD redeemed 1********************************************************")
    print(GetGlobal("Boss_SpiderStyle"))
  else
    GiveCollectible("Challenge_MustBeThisTall_Tracker")
    SetGlobal("DownWithDocPin_Destroyed", 1)
    SetGlobal("Boss_SpiderStyle", true)
    print("MDDBF AWARD Destroyed********************************************************")
    print(GetGlobal("Boss_SpiderStyle"))
  end
  print("MDDBF AWARD End********************************************************")
  return 
end
NewRide_Transition = function()
end
local masksStopped = true
SpiderBoss_MaskAudio = function(speed)
  print(("SpiderBoss_MaskAudio " .. speed))
  if (speed == 0) then
    print("Stopping masks sound")
    AudioPostEventOn("mst_maddoctornewride_01a_main_player.mst_maddoctorspider_v3 01.AI_MadDoctorSpider 01", "Stop_sfx_NRB_mask_spin_lp")
    masksStopped = true
  else
    if (masksStopped == true) then
      print("Starting masks sound")
      AudioPostEventOn("mst_maddoctornewride_01a_main_player.mst_maddoctorspider_v3 01.AI_MadDoctorSpider 01", "Play_sfx_NRB_mask_spin_lp")
      masksStopped = false
    end
    if (speed <= 60) then
      print("Masks sound LOW")
      AudioPostEventOn("mst_maddoctornewride_01a_main_player.mst_maddoctorspider_v3 01.AI_MadDoctorSpider 01", "Set_Mask_Speed_Low")
    elseif (60 < speed) then
      if (speed <= 100) then
        print("Masks sound MED")
        AudioPostEventOn("mst_maddoctornewride_01a_main_player.mst_maddoctorspider_v3 01.AI_MadDoctorSpider 01", "Set_Mask_Speed_Med")
      end
    else
      print("Masks sound HIGH")
      AudioPostEventOn("mst_maddoctornewride_01a_main_player.mst_maddoctorspider_v3 01.AI_MadDoctorSpider 01", "Set_Mask_Speed_High")
    end
  end
  return 
end

