MT_Prescott = "ftl_prescottsarena_01a_igc.Gremlin_Prescott 01"
MT_Arena = "ftl_prescottsarena_01a_props.Stage1_Arena"
MechTurret_LoadingCheckpoint = false
MechTurret_StageNum = 0
MechTurret_CamPhase1 = "Phase1Cam"
Mech_LastDestroyedLoader = -1
MechTurret_name = "ftl_prescottsarena_01a_main.AI_MechTurret 01"
MechTurret_FillBrainStarted = false
MechTurret_NoMoreJunk = false
MT_tankIncrease = 5
MT_tankIncreaseStage2 = 4
MT_tankIncreaseStage3 = 2
MT_tankCapacity = 400
MT_tankReCapacity = 200
MT_tankSequence = 160
MT_thinnerTank = 0
MT_paintTank = 0
MT_OnTankFullCounter = 0
PathType_Thinner = ST_THINNER
PathType_Paint = ST_PAINT
PathType_None = 2
StateType_None = 0
StateType_Raised = 1
StateType_Hacked = 2
StateType_FillBrain = 3
StateType_Failed = 4
StateType_WaitForRaise = 5
StateType_Defeated = 6
MT_Tank_None = "0"
MT_Tank_Paint = "1"
MT_Tank_Thinner = "2"
MT_CurrentRoute = {MT_Tank_None, MT_Tank_None, MT_Tank_None}
MechTurret_CurrentAnimState = StateType_None
MechTurret_CurrentPath = PathType_None
FightState_Stage1Phase1 = 1
FightState_Stage1Phase2 = 2
FightState_Stage1Phase3 = 3
FightState_Stage1Complete = 4
MechTurret_CurrentFightState = FightState_Stage1Phase1
MAT_Standard = 0
MAT_Clockwise = 1
MAT_CounterClockwise = 2
MAT_Forward = 3
MAT_Random = 4
MAT_ThinnerBomb = 5
MAT_Other = 6
MAT_CoolDown = 7
MT_AttackTankValue = 330
MT_startedHack = false
MT_OswaldFreeToAttack = 0
MT_Pickups = false
MT_Health = false
MT_NumLoadersDestroyed = 0
MT_ElectricStage1 = 0
MT_ElectricStage2 = 0
MT_ElectricStage3 = 0
MT_HackNodesEnabled = false
MT_JunkBallHits = 0
MT_firedCutsceneBombs = 0
MT_PaintCutscene = 0
MechTurret_FireCutsceneThinnerBomb = function()
  local shooter = GetChildEntityByName(MechTurret_name, "MT_CutsceneShooter")
  if (shooter == nil) then
    return 
  end
  local target = vector4(0, 0, 0)
  if (MT_firedCutsceneBombs == 0) then
    target = vector4(-11.600000381469727, 0.5, 0.6000000238418579)
  elseif (MT_firedCutsceneBombs == 1) then
    target = vector4(4.300000190734863, 0.5, 9.800000190734863)
  elseif (MT_firedCutsceneBombs == 2) then
    target = vector4(4.400000095367432, 0.5, -8.699999809265137)
  end
  Shooter_SetTargetPoint(shooter, target)
  Shooter_PrepareProjectiles(shooter)
  Shooter_LaunchProjectiles(shooter)
  Shooter_ClearTargetPoint(shooter)
  MT_firedCutsceneBombs = (MT_firedCutsceneBombs + 1)
  return 
end
MechTurret_DestroyBombOnCollision = function(_self, _event)
  if (StimulusEvent_SourceStimulusAlias(_event) == "ForceField") then
    local fuseHealth = GetPropertyFloat(_self, "Fuse")
    SetPropertyFloat(_self, "Fuse", 0)
    DestroyEntity(_self)
    Wait(1)
  else
  end
  return 
end
MechTurret_ShakeCamera = function()
  ShakeCamera(3, 7, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  if (MechTurret_NoMoreJunk == false) then
    MechTurret_SpawnJunk()
  end
  return 
end
MechTurret_ShakeCameraTransition = function()
  AudioPostEventOn(GetPlayer(), "Play_sfx_pcArena_rumble_loop")
  ShakeCamera(20, 7, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  return 
end
MT_MickeyDead = 0
MechTurret_OnPlayerDeath = function()
  if (GetNumPlayers() == 2) then
    MT_MickeyDead = 1
    MT_SetTarget(MechTurret_name, GetPlayer2OrAI())
  end
  return 
end
OswaldTarget = false
MickeyTarget = true
TargetCounter = 0
ThinnerBombCounter = 0
MechTurret_OnAnimEvent = function(_self, _event)
  local eventType = AnimEvent_Type(_event)
  if (eventType == EVENT_HopperDropped) then
    MechTurret_DetachLoader(_self)
  elseif (eventType == EVENT_FireBulletCS) then
    MechTurret_FireCutsceneThinnerBomb()
  else
    if (eventType == EVENT_DrainTankPaint) then
      if (eventType == EVENT_DrainTankPaint) then
        FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintPaintDrain")
      else
        FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintThinnerDrain")
      end
      if (MechTurret_CurrentAnimState ~= StateType_FillBrain) then
        MechTurret_CurrentAnimState = StateType_None
        MechTurret_SubstractTank()
        MT_HackNodesEnabled = false
      end
    end
    if (eventType == EVENT_IsInReloadStart) then
      if (IsAnySequencePlaying() == false) then
        FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintReload")
      end
    elseif (eventType ~= EVENT_IsInReloadFinished) then
      if (eventType == EVENT_IsInHack) then
        if (MT_HackNodesEnabled == false) then
          MT_HackNodesEnabled = true
          if (MT_ElectricStage1 == 1) then
            MechTurret_ElectricFloorDefenceStop()
          end
          Print("In Hack, Disabling all oswald patrol nodes")
          ForEachEntityInGroup(Disable, "AllOswaldPatrolNodes")
          wait(0.20000000298023224)
          FireSequence("GusConversationMarker", "FTL_PrescottArena_Gus_StageOneHack")
          MechTurret_CurrentAnimState = StateType_Raised
          Print("Music - mech raised to expose hack point")
          local hack = "MechTurretHackPoint"
          FireUser1(hack)
          Print("Enabling Hack nodes")
          Enable("BuddyAIHintLoc7")
        end
      elseif (eventType == EVENT_IsInBreathe) then
        if (MechTurret_CurrentAnimState == StateType_FillBrain) then
          MechTurret_CurrentAnimState = StateType_None
          MechTurret_BossCam()
          MechTurret_SetNextFightState()
          if (MT_ElectricStage1 == 0) then
            MechTurret_ElectricFloorDefenceStart()
          end
          TargetCounter = 0
          if (MechTurret_CurrentFightState ~= FightState_Stage1Complete) then
            MechTurret_SaveCheckpoint()
          end
          if (MechTurret_CurrentFightState ~= FightState_Stage1Phase2) then
            MT_CutsceneEnded(MechTurret_name)
            if (MechTurret_CurrentFightState == FightState_Stage1Complete) then
              MechTurret_Phase3End()
            end
          end
        end
      elseif (eventType == EVENT_IsInTaunt) then
        MechTurret_OnPlayerDeath()
      elseif (eventType == EVENT_IsInFillBrain) then
        MechTurret_CurrentAnimState = StateType_FillBrain
      elseif (eventType == EVENT_Attack) then
        FireThread(MechTurretCannonTaunt)
        MechTurretCannonTaunt()
        TargetCounter = MT_GetTurretRandom(MechTurret_name, 0, 2)
        if (TargetCounter == 0) then
          MickeyTarget = true
          OswaldTarget = false
        elseif (TargetCounter == 1) then
          MickeyTarget = false
          OswaldTarget = true
        end
        if (GetNumPlayers() == 1) then
          if (MickeyTarget == true) then
            MT_SetTarget(MechTurret_name, GetPlayer())
            TargetCounter = (TargetCounter + 1)
          elseif (OswaldTarget == true) then
            MT_SetTarget(MechTurret_name, GetPlayer2OrAI())
            TargetCounter = (TargetCounter - 1)
          end
        end
        if (GetNumPlayers() == 2) then
          if (MT_MickeyDead == 1) then
            MT_SetTarget(MechTurret_name, GetPlayer2OrAI())
            TargetCounter = 1
          end
          if (MickeyTarget == true) then
            MT_SetTarget(MechTurret_name, GetPlayer())
            TargetCounter = (TargetCounter + 1)
          elseif (OswaldTarget == true) then
            MT_SetTarget(MechTurret_name, GetPlayer2OrAI())
            TargetCounter = (TargetCounter - 1)
            if (eventType == EVENT_ThinnerBombAttack) then
              if (ThinnerBombCounter < 5) then
                ThinnerBombCounter = (ThinnerBombCounter + 1)
                MT_SetTarget(MechTurret_name, ("ThinnerTarget" .. tostring(ThinnerBombCounter)))
              elseif (ThinnerBombCounter == 5) then
                MT_SetTarget(MechTurret_name, "ThinnerTarget6")
                ThinnerBombCounter = 0
                if (eventType == EVENT_Start_DrainTank) then
                  MechTurret_ShakeCamera()
                  MechTurret_SetCapsuleColour(MechTurret_CurrentFightState, MechTurret_CurrentPath)
                else
                end
              end
            elseif (eventType == EVENT_Start_DrainTank) then
              MechTurret_ShakeCamera()
              MechTurret_SetCapsuleColour(MechTurret_CurrentFightState, MechTurret_CurrentPath)
            else
            end
          end
        end
      elseif (eventType == EVENT_ThinnerBombAttack) then
        if (ThinnerBombCounter < 5) then
          ThinnerBombCounter = (ThinnerBombCounter + 1)
          MT_SetTarget(MechTurret_name, ("ThinnerTarget" .. tostring(ThinnerBombCounter)))
        elseif (ThinnerBombCounter == 5) then
          MT_SetTarget(MechTurret_name, "ThinnerTarget6")
          ThinnerBombCounter = 0
          if (eventType == EVENT_Start_DrainTank) then
            MechTurret_ShakeCamera()
            MechTurret_SetCapsuleColour(MechTurret_CurrentFightState, MechTurret_CurrentPath)
          else
          end
        end
      elseif (eventType == EVENT_Start_DrainTank) then
        MechTurret_ShakeCamera()
        MechTurret_SetCapsuleColour(MechTurret_CurrentFightState, MechTurret_CurrentPath)
      else
      end
    end
  end
  return 
end
MechTurret_SetCapsuleColour = function(fightState, path)
  ForEachEntityInGroup(StartEmitters, ("DamageEffectsState" .. fightState))
  if (path == PathType_Paint) then
    Wait(1)
    AnimGBSequence(("CapsuleBlue0" .. fightState), ("FillBlueFilling" .. fightState))
    AudioPostEventOn(GetPlayer(), ("Play_DEM2_BGS_MechCannon_boss_VO_Phase_0" .. fightState))
    Wait(4)
    AnimGBSequence(("CapsuleBlue0" .. fightState), ("FillBlueFull" .. fightState))
  else
    AnimGBSequence(("CapsuleGreen0" .. fightState), "FillGreenFilling2")
    AudioPostEventOn(GetPlayer(), ("Play_DEM2_BGS_MechCannon_boss_VO_Phase_0" .. fightState))
    Wait(4)
    AnimGBSequence(("CapsuleGreen0" .. fightState), "FillGreenFull2")
  end
  return 
end
MechTurret_DetachLoader = function(self)
  if (Mech_LastDestroyedLoader ~= -1) then
    local drumName = "nil"
    local loadername = "nil"
    if (Mech_LastDestroyedLoader == 0) then
      drumName = "MT_LoaderDrum01"
      loadername = "MT_HopperBaseOneCollision"
    elseif (Mech_LastDestroyedLoader == 1) then
      drumName = "MT_LoaderDrum02"
      loadername = "MT_HopperBaseTwoCollision"
    elseif (Mech_LastDestroyedLoader == 2) then
      drumName = "MT_LoaderDrum03"
      loadername = "MT_HopperBaseThreeCollision"
    end
    local collisionEntity = GetChildEntityByName(self, loadername)
    local childEntity = GetChildEntityByName(self, drumName)
    SetPropertyEntity(childEntity, "Parent Entity", nil)
    SetPropertyString(childEntity, "Bone Attach Name", "", 0)
    SetPropertyVector(collisionEntity, "Bone Attach Offset", vector4(0, 0, 0), 0)
    AudioPostEventOn(GetPlayer(), "Play_MechCannon_HopperLand")
    Mech_LastDestroyedLoader = -1
  end
  return 
end
MechTurret_DestroyLoader = function(loader, index)
  local turret = GetPropertyEntity(loader, "Parent Entity", 0)
  Mech_LastDestroyedLoader = tonumber(index)
  SetGlobal(("FTL_PrescottMechTurretLoaderToon" .. tostring((Mech_LastDestroyedLoader + 1))), 1)
  MT_NumLoadersDestroyed = (MT_NumLoadersDestroyed + 1)
  if (MT_NumLoadersDestroyed == 3) then
    SetGlobal("MechCannonLoadersKilled", 1)
  end
  MT_OnLoaderDestroyed(turret, index)
  return 
end
MechTurret_WeakPointStim = function(self, _event)
  if (_activator() == _player()) then
    if (MechTurret_CurrentAnimState == StateType_None) then
      local currentPath = PathType_None
      if StimulusEvent_HasStimulusType(_event, ST_PAINT) then
        currentPath = PathType_Paint
      elseif StimulusEvent_HasStimulusType(_event, ST_THINNER) then
        currentPath = PathType_Thinner
      else
        return 
      end
      MechTurret_UpdateTank(currentPath)
      if (MT_paintTank == MT_tankCapacity) then
        MechTurret_OnTankFull(currentPath)
      end
    end
  end
  return 
end
MechTurret_FillBrainPaintCutscene = function()
  if (MechTurret_CurrentFightState == FightState_Stage1Phase1) then
    MechTurret_BossCamUp()
    MechTurret_Phase1End()
    MT_CurrentRoute[FightState_Stage1Phase1] = MT_Tank_Paint
    wait(2)
    FireSequence("GusConversationMarker", "FTL_PrescottArena_Gus_StageOneTanksFull")
  elseif (MechTurret_CurrentFightState == FightState_Stage1Phase2) then
    MechTurret_BossCamUp()
    MT_CurrentRoute[FightState_Stage1Phase2] = MT_Tank_Paint
    FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintFinalHit")
  elseif (MechTurret_CurrentFightState == FightState_Stage1Phase3) then
    MechTurret_NoMoreJunk = true
    FireUser1("Phase3FancyCam")
    FireThread(MechTurret_PhaseThreeSafeTeleport)
    MT_CurrentRoute[FightState_Stage1Phase3] = MT_Tank_Paint
    FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintTurretDone")
    ReplaceMusicStateOverride("Stinger_Success")
    Print("Music - turret defeated")
  else
    return 
  end
  SetGlobal("MechTurret_PickedRoutePaint", (GetGlobal("MechTurret_PickedRoutePaint") + 1))
  ForEachEntityInGroup(Hide, "Gremlins")
  return 
end
MechTurret_FillBrainThinnerCutscene = function()
  if (MechTurret_CurrentFightState == FightState_Stage1Phase1) then
    MechTurret_BossCamUp()
    MechTurret_Phase1End()
    MT_CurrentRoute[FightState_Stage1Phase1] = MT_Tank_Thinner
    wait(2)
    FireSequence("GusConversationMarker", "FTL_PrescottArena_Gus_StageOneTanksFull")
  elseif (MechTurret_CurrentFightState == FightState_Stage1Phase2) then
    MechTurret_BossCamUp()
    MT_CurrentRoute[FightState_Stage1Phase2] = MT_Tank_Thinner
    FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintFinalHit")
  elseif (MechTurret_CurrentFightState == FightState_Stage1Phase3) then
    MechTurret_NoMoreJunk = true
    FireUser1("Phase3FancyCam")
    FireThread(MechTurret_PhaseThreeSafeTeleport)
    MT_CurrentRoute[FightState_Stage1Phase3] = MT_Tank_Thinner
    FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintTurretDone")
    ReplaceMusicStateOverride("Stinger_Success")
    Print("Music - turret defeated")
  else
    return 
  end
  ForEachEntityInGroup(Hide, "Gremlins")
  Print("Music - fill cannon with thinner cutscene")
  return 
end
MechTurret_PhaseThreeSafeTeleport = function()
  wait(0.30000001192092896)
  TeleportToEntity(GetPlayer(), "Phase3EndMickeyMarker")
  TeleportToEntity(GetPlayer2OrAI(), "Phase3EndOswaldMarker")
  return 
end
MechTurret_StartFillBrainCutscene = function()
  if (MechTurret_CurrentPath == PathType_None) then
    return 
  end
  if (MechTurret_CurrentFightState ~= FightState_Stage1Phase1) then
    local isInCutscene = false
  end
  local isInCutscene = true
  MT_StartFillBrainState(MechTurret_name, isInCutscene)
  MT_HackNodesEnabled = false
  MT_paintTank = 0
  MT_thinnerTank = 0
  MT_OnTankFullCounter = 0
  if (MechTurret_CurrentPath == PathType_Paint) then
    MechTurret_FillBrainPaintCutscene()
    MechTurret_ParticleEffectBrainController(MechTurret_CurrentPath)
  else
    MechTurret_FillBrainThinnerCutscene()
    MechTurret_ParticleEffectBrainController(MechTurret_CurrentPath)
  end
  local hack = "MechTurretHackPoint"
  FireUser2(hack)
  Disable("BuddyAIHintLoc7")
  Print("Fill Brain Cutscene, Enabling all oswald patrol nodes")
  ForEachEntityInGroup(Enable, "AllOswaldPatrolNodes")
  Print("Music - StartFillBrainCutscene")
  return 
end
MechTurret_HackSuccess = function(self)
  MT_OswaldHackSuccess(MechTurret_name)
  AnimGBSequence("MechTurretReprogramLights", "Stage3")
  if (MechTurret_CurrentFightState ~= FightState_Stage1Complete) then
    if (MechTurret_CurrentAnimState == StateType_Raised) then
      MechTurret_CurrentAnimState = StateType_Hacked
      MechTurret_StartFillBrainCutscene()
    end
  end
  MT_HackNodesEnabled = false
  OswaldStartFollowAction()
  return 
end
MechTurret_Stimulus = function(self, _event)
  Print(("MechTurret_Stimulus: SourceAlias = " .. tostring(StimulusEvent_SourceStimulusAlias(_event))))
  Print(("MechTurret_Stimulus: GroupName = " .. GetPropertyString(_activator(), "EntityGroups", 0)))
  if StimulusEvent_HasStimulusType(_event, ST_PHYSICAL) then
    if (StimulusEvent_SourceStimulusAlias(_event) == "PrescottJunkAmmo") then
      if (MechTurret_CurrentAnimState ~= StateType_Raised) then
        MT_JunkBallHits = (MT_JunkBallHits + 1)
        if (MT_JunkBallHits < 3) then
          AnimEvent(MechTurret_name, EVENT_Hit)
        elseif (3 <= MT_JunkBallHits) then
          FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintFillTanks")
          MT_SetStunnedState(MechTurret_name)
          MT_JunkBallHits = 0
        end
      end
    end
  end
  if StimulusEvent_HasStimulusType(_event, ST_FAIRY) then
    NotifyFairySketchHit()
    MechTurret_ElectricFloorDefenceStop()
    MechTurret_ShakeCamera()
    Wait(5)
    MechTurret_ElectricFloorDefenceStart()
  end
  return 
end
MechTurret_AnvilHit = function()
  FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintFillTanks")
  MechTurret_ElectricFloorDefenceStop()
  Wait(5)
  MechTurret_ElectricFloorDefenceStart()
  return 
end
MechTurret_SubstractTank = function()
  FireThread(MechTurret_ElectricFloorDefenceStart)
  MT_OswaldHackFail(MechTurret_name)
  if (0 < MT_paintTank) then
    MT_paintTank = MT_tankReCapacity
  elseif (0 < MT_thinnerTank) then
    MT_thinnerTank = MT_tankReCapacity
  end
  Disable("BuddyAIHintLoc7")
  ForEachEntityInGroup(Enable, "AllOswaldPatrolNodes")
  MT_HackNodesEnabled = false
  AnimVarFloat(MechTurret_name, VAR_PaintFilled, (MT_paintTank / MT_tankCapacity))
  AnimVarFloat(MechTurret_name, VAR_ThinnerFilled, (MT_thinnerTank / MT_tankCapacity))
  return 
end
MechTurret_UpdateTank = function(stimType)
  local funnelColor = GetChildEntityByName(MechTurret_name, "MT_Funnel")
  if (stimType == PathType_Thinner) then
    SetR3MTConstReg(funnelColor, 0, vector4(0, 1, 0, 1))
    if (MechTurret_CurrentFightState == FightState_Stage1Phase1) then
      MT_thinnerTank = (MT_thinnerTank + MT_tankIncrease)
      if (0 < MT_paintTank) then
        MT_paintTank = (MT_paintTank - MT_tankIncrease)
      end
    elseif (MechTurret_CurrentFightState == FightState_Stage1Phase2) then
      MT_thinnerTank = (MT_thinnerTank + MT_tankIncreaseStage2)
      if (0 < MT_paintTank) then
        MT_paintTank = (MT_paintTank - MT_tankIncreaseStage2)
      end
    elseif (MechTurret_CurrentFightState == FightState_Stage1Phase3) then
      MT_thinnerTank = (MT_thinnerTank + MT_tankIncreaseStage3)
      if (0 < MT_paintTank) then
        MT_paintTank = (MT_paintTank - MT_tankIncreaseStage3)
        SetR3MTConstReg(funnelColor, 0, vector4(0, 0, 1, 1))
        if (MechTurret_CurrentFightState == FightState_Stage1Phase1) then
          MT_paintTank = (MT_paintTank + MT_tankIncrease)
        elseif (MechTurret_CurrentFightState == FightState_Stage1Phase2) then
          MT_paintTank = (MT_paintTank + MT_tankIncreaseStage2)
        elseif (MechTurret_CurrentFightState == FightState_Stage1Phase3) then
          MT_paintTank = (MT_paintTank + MT_tankIncreaseStage3)
        end
        if (0 < MT_thinnerTank) then
          if (MechTurret_CurrentFightState == FightState_Stage1Phase1) then
            MT_thinnerTank = (MT_thinnerTank - MT_tankIncrease)
          elseif (MechTurret_CurrentFightState == FightState_Stage1Phase2) then
            MT_thinnerTank = (MT_thinnerTank - MT_tankIncreaseStage2)
          elseif (MechTurret_CurrentFightState == FightState_Stage1Phase3) then
            MT_thinnerTank = (MT_thinnerTank - MT_tankIncreaseStage3)
          end
        end
      end
    end
  else
    SetR3MTConstReg(funnelColor, 0, vector4(0, 0, 1, 1))
    if (MechTurret_CurrentFightState == FightState_Stage1Phase1) then
      MT_paintTank = (MT_paintTank + MT_tankIncrease)
    elseif (MechTurret_CurrentFightState == FightState_Stage1Phase2) then
      MT_paintTank = (MT_paintTank + MT_tankIncreaseStage2)
    elseif (MechTurret_CurrentFightState == FightState_Stage1Phase3) then
      MT_paintTank = (MT_paintTank + MT_tankIncreaseStage3)
    end
    if (0 < MT_thinnerTank) then
      if (MechTurret_CurrentFightState == FightState_Stage1Phase1) then
        MT_thinnerTank = (MT_thinnerTank - MT_tankIncrease)
      elseif (MechTurret_CurrentFightState == FightState_Stage1Phase2) then
        MT_thinnerTank = (MT_thinnerTank - MT_tankIncreaseStage2)
      elseif (MechTurret_CurrentFightState == FightState_Stage1Phase3) then
        MT_thinnerTank = (MT_thinnerTank - MT_tankIncreaseStage3)
      end
    end
  end
  AnimVarFloat(MechTurret_name, VAR_PaintFilled, (MT_paintTank / MT_tankCapacity))
  AnimVarFloat(MechTurret_name, VAR_ThinnerFilled, (MT_thinnerTank / MT_tankCapacity))
  return 
end
MechTurret_SetNextFightState = function()
  if (MechTurret_CurrentFightState == FightState_Stage1Phase1) then
    MechTurret_CurrentFightState = FightState_Stage1Phase2
  elseif (MechTurret_CurrentFightState == FightState_Stage1Phase2) then
    MechTurret_CurrentFightState = FightState_Stage1Phase3
  elseif (MechTurret_CurrentFightState == FightState_Stage1Phase3) then
    MechTurret_CurrentFightState = FightState_Stage1Complete
  end
  return 
end
MechTurret_OnTankFull = function(currentPath)
  if (MechTurret_CurrentAnimState == StateType_None) then
    MechTurret_CurrentPath = currentPath
    MT_StartHackedState(MechTurret_name, currentPath)
    MechTurret_CurrentAnimState = StateType_WaitForRaise
  end
  return 
end
MechTurret_ArrivedAtPatrolNode = function(number)
  if (MechTurret_CurrentAnimState == StateType_Raised) then
    local hack = "MechTurretHackPoint"
    OswaldHackAction(hack)
  else
    local nextnode, nextnode = MT_GetTurretRandom(MechTurret_name, 1, 7), MechTurret_name
    nextnode = Print
    nextnode("Reached Node, Disabling all oswald patrol nodes")
    nextnode = ForEachEntityInGroup
    nextnode(Disable, "AllOswaldPatrolNodes")
    nextnode = Print
    nextnode((" The random number is : " .. nextnode))
    nextnode = OswaldStopFollowAction
    nextnode()
    nextnode = OswaldOverrideTeleportDistance
    nextnode(nil, 100)
    nextnode = Enable
    nextnode(("BuddyAIHintLoc" .. nextnode))
  end
  return 
end
MechStage1Hints = 0
MechTurretStageoneHints = function(target)
  if (MechStage1Hints == 0) then
    MechStage1Hints = 1
    if (IsAnySequencePlaying() == false) then
      FireSequence("GusConversationMarker", "FTL_PrescottArena_Gus_StageOneHints")
    end
  else
    MechStage1Hints = 0
    FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintFillTanks")
  end
  return 
end
MechCannonTaunt = 16
MechTurretCannonTaunt = function()
  if (MechCannonTaunt < 16) then
    MechCannonTaunt = (MechCannonTaunt + 1)
    Print(("MechTurretCannonTaunt : Current Mech taunt value is :" .. MechCannonTaunt))
  else
    if (IsAnySequencePlaying() == false) then
      FireSequence("GusConversationMarker", "FTL_PrescottArena_Gus_HintCannonBall")
    end
    Print("MechTurretCannonTaunt : resetting Mech taunt value to 0")
    MechCannonTaunt = 0
  end
  return 
end
MechTurretStageOneForceField = function(target)
  FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintForceField")
  SetPropertyBool("ElectricFloorLookatTrigger", "Look At Trigger Enabled", true)
  return 
end
MechTurret_PickedRoute = function()
  ClearAllCameraAttributes()
  AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_MechCannon_boss_VO_Phase_End")
  if (MechTurret_CurrentFightState == FightState_Stage1Complete) then
    TimerDisable("StageOneHintLogicTimer")
    if (2 <= GetGlobal("MechTurret_PickedRoutePaint")) then
      if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
        SetGlobal("MechStage2Paint", 1)
      end
      ClearAllCameraAttributes()
      OswaldClearOverrideTeleportDistance()
      OswaldClearOverrideDistances()
      OswaldStartFollowAction()
      Mech_Stream()
    else
      ClearAllCameraAttributes()
      OswaldClearOverrideTeleportDistance()
      OswaldClearOverrideDistances()
      OswaldStartFollowAction()
      Mech_Stream()
    end
  end
  return 
end
MechTurret_BossCam = function()
  ClearCameraAttributes("CannonBossCamUp")
  SetCameraAttributesForPlayer("CannonBossCam", nil)
  return 
end
MechTurret_BossCamUp = function()
  SetCameraAttributesForPlayer("CannonBossCamUp", nil)
  return 
end
MechTurret_ParticleEffectBrainController = function(MechTurret_CurrentPath)
  if (MechTurret_CurrentPath == PathType_Paint) then
    StartEmitters("ftl_prescottsarena_01a_fx.HitPaintLarge")
    Wait(3)
    StopEmitters("ftl_prescottsarena_01a_fx.HitPaintLarge")
  else
    StartEmitters("ftl_prescottsarena_01a_fx.HitThinnerLarge")
    Wait(3)
    StopEmitters("ftl_prescottsarena_01a_fx.HitThinnerLarge")
  end
  return 
end
MechTurret_GremlinShowBeforeCutscene = function()
  Unhide(MT_Prescott)
  return 
end
MechTurret_Phase1Start = function()
  MechTurret_GremlinShowBeforeCutscene()
  return 
end
MechTurret_Phase1End = function()
  EnableSplitScreen(true)
  ClearAllCameraAttributes()
  MechTurret_BossCam()
  Wait(3)
  MT_CutsceneEnded(MechTurret_name)
  return 
end
Phase3EndFlag = true
MechTurret_Phase3End = function()
  if Phase3EndFlag then
    Phase3EndFlag = false
    LevelManager_SetCurrentState("FTL_PrescottsArena.Transition")
    MechTurret_PickedRoute()
    MechTurret_CurrentAnimState = StateType_Defeated
  end
  return 
end
MechTurret_Initialise = function()
  Hide("LightBeam")
  AnimGBSequence("Door1Animation", "B")
  AnimGBSequence("Door2Animation", "B")
  MechTurretStageoneHints(nil)
  TimerEnable("StageOneHintLogicTimer")
  local (for index), (for limit), (for step) = 1, 3, 1
  for i = (for index), (for limit), (for step) do
    local collisionEntity = GetChildEntityByName(MechTurret_name, ("MT_LoaderArms0" .. i))
    if (GetGlobal(("FTL_PrescottMechTurretLoaderToon" .. i)) == 1) then
      Print(("MechTurret_Initialise : Disabling loder number " .. i))
      ForceSketched(collisionEntity)
    end
  end
  if (GetGlobal("FTL_PrescottMechTurretDoorReprogram") == 1) then
    Disable("ReprogramDoor1Node")
    AnimGBSequence("ReprogramDoor1", "restOpen")
    SetPropertyBool("ReprogramDoor1TriggerLookat", "Look At Trigger Enabled", false)
  end
  local hack = "MechTurretHackPoint"
  FireUser2(hack)
  FireThread(MechTurret_ElectricFloorDefenceStart)
  MechTurret_BossCam()
  SetPropertyBool("ElectricFloorLookatTrigger", "Look At Trigger Enabled", true)
  return 
end
MechTurret_Stage1 = function()
  MechTurret_Initialise()
  ClearAllCameraAttributes()
  MT_CutsceneEnded(MechTurret_name)
  MechTurret_SaveCheckpoint()
  MechTurret_BossCam()
  if (GetGlobal("MSN_Arcade_FromArcade") == 2) then
    StartFadeIn(0.800000011920929)
    wait(0.800000011920929)
    ShowHud()
  end
  ReplaceMusicStateOverride("Combat_Lev1")
  Print("Started stage 1 music from MechTurret_Stage1")
  AudioEffectStart("ftl_prescottsarena_01a_audio.Sound_Reverb")
  return 
end
MechTurret_StartAttackSequence = function()
  MT_AddAttackSequence(MechTurret_name, MAT_CoolDown)
  MT_AddAttackSequence(MechTurret_name, MAT_Standard)
  MT_AddAttackSequence(MechTurret_name, MAT_CoolDown)
  MT_AddAttackSequence(MechTurret_name, MAT_ThinnerBomb)
  return 
end
FTL_Prescott_PaintNoIntro = false
MechTurret_StartLevelPaint = function(target)
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    SetGlobal("EM2_EpisodeCheck", 2)
  end
  local playIGC = false
  if (target ~= nil) then
    if (GetName(target) ~= "ftl_prescottsarena_01a_main.seq_projectorPaint.ProjectorMarker") then
      if (FTL_Prescott_PaintNoIntro == false) then
        GetPrefabData("PaintEntrance").MapLoad_SetupPosition = "True"
        FTL_Prescott_PaintNoIntro = true
      end
      GetPrefabData("PaintEntrance").ToFlyThrough = "True"
      OnMapLoad_ProjectorSetup("PaintEntrance")
      LevelManager_SetCurrentState("FTL_PrescottsArena.Inside")
    else
      playIGC = true
      StartFadeOut(0)
      playIGC = true
    end
  else
    StartFadeOut(0)
    playIGC = true
  end
  if playIGC then
    MT_PaintCutscene = 1
    if (1 < GetGlobal("TRT_DestroyedDioramas")) then
      Print("MechTurret_StartLevelPaint: Playing IGC B on level load")
      PlayIGC("IGC_0260b_PrescottIntroBossFight")
    else
      Print("MechTurret_StartLevelPaint: Playing IGC A on level load")
      PlayIGC("IGC_0260a_PrescottIntroBossFight")
    end
  end
  return 
end
MechTurret_ArcadeStart = function()
  Print("Should See me ONCE ONLY")
  SetGlobal("MSN_Arcade_FromArcade", 2)
  SetGlobal("MechTurret_PickedRoutePaint", 0)
  ForEachEntityInGroup(Hide, "Gremlins")
  local MechState = 15
  local MechSeqIndex = -1
  local fightPhase = (MechTurret_CurrentFightState - 1)
  MechTurret_BossCam()
  MT_thinnerTank = 0
  MT_paintTank = 0
  Disable("Door1ReprogramScreen")
  DestroyEntity("ReprogramDoor1TriggerLookat")
  DestroyEntity("ReprogramDoor1Node")
  ForEachEntityInGroup(Enable, "AllOswaldPatrolNodes")
  MechTurret_StartAttackSequence()
  MT_StartIntroCutscene(MechTurret_name, ST_PAINT)
  Print("STAGE ONE STARTING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
  MechTurret_Stage1()
  FireThread(TEMP_TimerForArcadeMech)
  return 
end
MechTurret_SaveCheckpoint = function()
  SetGlobal("Boss_MechPhase", MechTurret_CurrentFightState)
  local MechGlobalRoute = ((MT_CurrentRoute[FightState_Stage1Phase1] .. MT_CurrentRoute[FightState_Stage1Phase2]) .. MT_CurrentRoute[FightState_Stage1Phase3])
  SetGlobal("Prescott_Boss_MechRoute", MechGlobalRoute)
  SaveCheckpoint(GetPlayer(), "MechTurret_LoadCheckpoint", "ftl_prescottsarena_01a_main.Stage1_Start", "ftl_prescottsarena_01a_main.Stage1_StartOswald")
  return 
end
MechTurret_LoadCheckpoint = function()
  ReplaceMusicStateOverride("Combat_Lev1")
  Print("Started stage 1 music from MechTurret_Stage1")
  ForEachEntityInGroup(Hide, "Gremlins")
  local MechState = 15
  local MechSeqIndex = -1
  MechTurret_CurrentFightState = GetGlobal("Boss_MechPhase")
  local MechRoute = GetGlobal("Prescott_Boss_MechRoute")
  if (MechTurret_CurrentFightState == FightState_Stage1Complete) then
    Print("You should not get to this state. The checkpoint saved in an invalid state! Setting the fight state to three")
    Print("You should not get to this state. The checkpoint saved in an invalid state! Setting the fight state to three")
    MechTurret_CurrentFightState = FightState_Stage1Phase3
  end
  local fightPhase = (MechTurret_CurrentFightState - 1)
  Print("Load Checkpoint, enabling all oswald nodes")
  ForEachEntityInGroup(Enable, "AllOswaldPatrolNodes")
  MechTurret_BossCam()
  MT_thinnerTank = 0
  MT_paintTank = 0
  AnimVarFloat(MechTurret_name, VAR_PaintFilled, 0)
  AnimVarFloat(MechTurret_name, VAR_ThinnerFilled, 0)
  UnpauseAllAI()
  MechTurret_Initialise()
  FireThread(MechTurret_StartAttackSequence)
  MT_OnLevelLoaded(MechTurret_name, false, MechState, MechSeqIndex, fightPhase)
  local (for index), (for limit), (for step) = 1, string.len(MechRoute), 1
  for index = (for index), (for limit), (for step) do
    local char = string.sub(MechRoute, index, index)
    MT_CurrentRoute[index] = tonumber(char)
    if (index == 3) then
      if (MT_CurrentRoute[index] ~= 0) then
        Print("You should not get to this state. The checkpoint saved in an invalid state! Setting the last set of tanks to 0")
        MT_CurrentRoute[3] = 0
      end
    end
    if (char ~= MT_Tank_None) then
      if (tonumber(MT_CurrentRoute[index]) == 1) then
        AnimGBSequence(("CapsuleBlue0" .. index), ("FillBlueFull" .. index))
      else
        AnimGBSequence(("CapsuleGreen0" .. index), "FillGreenFull2")
      end
    end
  end
  return 
end
PostIGC_0260a_PrescottIntroBossFight = function()
  ForEachEntityInGroup(Enable, "AllOswaldPatrolNodes")
  Projector_To_IGC_Cleanup()
  MechTurret_StartAttackSequence()
  MT_StartIntroCutscene(MechTurret_name, ST_PAINT)
  Print("STAGE ONE STARTING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
  Quest_SetCriticalPath("Critical_Boss2", "Critical_Boss2_1")
  MechTurret_Stage1()
  return 
end
PostIGC_0260b_PrescottIntroBossFight = function()
  ForEachEntityInGroup(Enable, "AllOswaldPatrolNodes")
  Projector_To_IGC_Cleanup()
  MechTurret_StartAttackSequence()
  MT_StartIntroCutscene(MechTurret_name, ST_PAINT)
  Print("STAGE ONE STARTING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
  Quest_SetCriticalPath("Critical_Boss2", "Critical_Boss2_1")
  MechTurret_Stage1()
  return 
end
MechTurret_2DTransitionSetup = function(target)
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    SetGlobal("EM2_EpisodeCheck", 2)
  end
  if (3 <= GetGlobal("EM2_EpisodeCheck")) then
    LevelManager_SetCurrentState("FTL_PrescottsArena.OutsideV2")
    local data = GetPrefabData("ThinnerEntrance")
    if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
      data.Interior_Stream = "FTL_FloatGraveyard.Paint_2D"
      data.TeleportToMarker = "toPrescottArenaPaint_Projector_Upper"
    end
  elseif (GetPrefabData(target).ExitFunction == "FTL_PrescottArena02_CheckpointLoad") then
    LevelManager_SetCurrentState("FTL_PrescottsArena.Outside")
  else
    LevelManager_SetCurrentState("FTL_PrescottsArena.Inside")
  end
  WaitForLevelLoad()
  if (GetGlobal("EM2_EpisodeCheck") == 2) then
    GetPrefabData(target).ToFlyThrough = "True"
  end
  SetupPosition()
  return 
end
FloorTurningOff = 0
MechTurret_ElectricFloorDefenceStart = function()
  wait(0.20000000298023224)
  if (MechTurret_CurrentFightState == FightState_Stage1Phase1) then
    MT_ElectricStage1 = 1
    local (for index), (for limit), (for step) = 1, 12, 1
    for num = (for index), (for limit), (for step) do
      if (FloorTurningOff == 1) then
        return 
      end
      Unhide(("FloorElectricityGroupC " .. num))
      Enable(("FloorElectricityGroupC " .. num))
      StartEmitters(("FloorElectricityGroupC " .. num))
      SetPropertyFloat(("FloorElectricityGroupC " .. num), "StimulusPerSecondList", 100, 0)
      SetPropertyFloat(("FloorElectricityGroupC " .. num), "StimulusPerSecondList", 1, 1)
      wait(0.10000000149011612)
    end
  end
  if (MechTurret_CurrentFightState == FightState_Stage1Phase2) then
    MT_ElectricStage2 = 1
    local (for index), (for limit), (for step) = 1, 18, 1
    for num = (for index), (for limit), (for step) do
      (for index) = FloorTurningOff
      if ((for index) == 1) then
        return 
      end
      (for index) = Unhide
      (for limit) = "FloorElectricityGroupC "
      (for step) = num
      (for limit) = ((for limit) .. (for step))
      (for index)((for limit))
      (for index) = Enable
      (for limit) = "FloorElectricityGroupC "
      (for step) = num
      (for limit) = ((for limit) .. (for step))
      (for index)((for limit))
      (for index) = StartEmitters
      (for limit) = "FloorElectricityGroupC "
      (for step) = num
      (for limit) = ((for limit) .. (for step))
      (for index)((for limit))
      (for index) = SetPropertyFloat
      (for limit) = "FloorElectricityGroupC "
      (for step) = num
      (for limit) = ((for limit) .. (for step))
      (for step) = "StimulusPerSecondList"
      num = 100
      (for index)((for limit), (for step), num, 0)
      (for index) = SetPropertyFloat
      (for limit) = "FloorElectricityGroupC "
      (for step) = num
      (for limit) = ((for limit) .. (for step))
      (for step) = "StimulusPerSecondList"
      num = 1
      (for index)((for limit), (for step), num, 1)
      if (12 < num) then
        (for index) = wait
        (for limit) = 0.10000000149011612
        (for index)((for limit))
      end
      (for index) = wait
      (for limit) = 0.10000000149011612
      (for index)((for limit))
    end
  elseif (MechTurret_CurrentFightState == FightState_Stage1Phase3) then
    MT_ElectricStage3 = 1
    local (for index), (for limit), (for step) = 1, 24, 1
    for num = (for index), (for limit), (for step) do
      if (FloorTurningOff == 1) then
        return 
      end
      Unhide(("FloorElectricityGroupC " .. num))
      Enable(("FloorElectricityGroupC " .. num))
      StartEmitters(("FloorElectricityGroupC " .. num))
      (for index) = 0
      SetPropertyFloat(("FloorElectricityGroupC " .. num), "StimulusPerSecondList", 100, (for index))
      (for index) = 1
      SetPropertyFloat(("FloorElectricityGroupC " .. num), "StimulusPerSecondList", 1, (for index))
      if (12 < num) then
        wait(0.10000000149011612)
      end
      wait(0.10000000149011612)
    end
  end
  return 
end
MechTurret_ElectricFloorDefenceStop = function()
  FloorTurningOff = 1
  if (MechTurret_CurrentFightState == FightState_Stage1Phase1) then
    MT_ElectricStage1 = 0
    local (for index), (for limit), (for step) = 12, 1, -1
    for num = (for index), (for limit), (for step) do
      StopEmitters(("FloorElectricityGroupC " .. num))
      Disable(("FloorElectricityGroupC " .. num))
      Hide(("FloorElectricityGroupC " .. num))
      SetPropertyFloat(("FloorElectricityGroupC " .. num), "StimulusPerSecondList", 0, 0)
      SetPropertyFloat(("FloorElectricityGroupC " .. num), "StimulusPerSecondList", 0, 1)
      wait(0.10000000149011612)
    end
  end
  if (MechTurret_CurrentFightState == FightState_Stage1Phase2) then
    MT_ElectricStage2 = 0
    local (for index), (for limit), (for step) = 18, 1, -1
    for num = (for index), (for limit), (for step) do
      (for index) = StopEmitters
      (for limit) = "FloorElectricityGroupC "
      (for step) = num
      (for limit) = ((for limit) .. (for step))
      (for index)((for limit))
      (for index) = Disable
      (for limit) = "FloorElectricityGroupC "
      (for step) = num
      (for limit) = ((for limit) .. (for step))
      (for index)((for limit))
      (for index) = Hide
      (for limit) = "FloorElectricityGroupC "
      (for step) = num
      (for limit) = ((for limit) .. (for step))
      (for index)((for limit))
      (for index) = SetPropertyFloat
      (for limit) = "FloorElectricityGroupC "
      (for step) = num
      (for limit) = ((for limit) .. (for step))
      (for step) = "StimulusPerSecondList"
      num = 0
      (for index)((for limit), (for step), num, 0)
      (for index) = SetPropertyFloat
      (for limit) = "FloorElectricityGroupC "
      (for step) = num
      (for limit) = ((for limit) .. (for step))
      (for step) = "StimulusPerSecondList"
      num = 0
      (for index)((for limit), (for step), num, 1)
      (for index) = wait
      (for limit) = 0.10000000149011612
      (for index)((for limit))
    end
  elseif (MechTurret_CurrentFightState == FightState_Stage1Phase3) then
    MT_ElectricStage3 = 0
    local (for index), (for limit), (for step) = 24, 1, -1
    for num = (for index), (for limit), (for step) do
      StopEmitters(("FloorElectricityGroupC " .. num))
      Disable(("FloorElectricityGroupC " .. num))
      Hide(("FloorElectricityGroupC " .. num))
      (for index) = 0
      SetPropertyFloat(("FloorElectricityGroupC " .. num), "StimulusPerSecondList", 0, (for index))
      (for index) = 1
      SetPropertyFloat(("FloorElectricityGroupC " .. num), "StimulusPerSecondList", 0, (for index))
      wait(0.10000000149011612)
    end
  end
  FloorTurningOff = 0
  return 
end
MechTurret_ElectricFloorSetup = function()
  SetPropertyFloat("ForceFieldExitA", "StimulusPerSecondList", 100, 0)
  SetPropertyFloat("ForceFieldExitA", "StimulusPerSecondList", 1, 1)
  StartEmitters("ForceFieldExitA")
  local (for index), (for limit), (for step) = 1, 24, 1
  for num = (for index), (for limit), (for step) do
    StopEmitters(("FloorElectricityGroupC " .. num))
    Disable(("FloorElectricityGroupC " .. num))
    Hide(("FloorElectricityGroupC " .. num))
    SetPropertyFloat(("FloorElectricityGroupC " .. num), "StimulusPerSecondList", 0, 0)
    SetPropertyFloat(("FloorElectricityGroupC " .. num), "StimulusPerSecondList", 0, 1)
  end
  return 
end
MechTurret_JunkBallSpeed = function(target, speed)
  local shooter = GetChildEntityByName(MechTurret_name, "MT_JunkShooter")
  SetPropertyFloat(shooter, "Shooter Speed", speed)
  return 
end
