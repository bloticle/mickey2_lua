Mech_PaintPath = 0
Mech_ThinnerPath = 1
Mech_CurrentPath = Mech_ThinnerPath
PrescottMechEntity = "AI_Mech 01"
MechDoorRight = "ftl_prescottsarena_02a_main.Stage_02_DoorRight"
MechFightCamera = "MechFightCamera"
MechThrowCamera = "MechThrowCamera"
Mech_FastFan = "PM_FanSpin"
Mech_SlowFan = "PM_FanSlow"
Mech_JunkBall = "PM_JunkBall"
PAT_Standard = 0
PAT_Clockwise = 1
PAT_CounterClockwise = 2
PAT_Forward = 3
PAT_Random = 4
PAT_ThinnerBomb = 5
PAT_Other = 6
PAT_CoolDown = 7
Mech_PaintCameraName = "ftl_prescottsarena_02a_main.grabcameraniffancy 01.HavokGBAnimation 01"
Mech_ThinnerCameraName = "ftl_prescottsarena_02a_main.grabcameraniffancy 02.HavokGBAnimation 01"
Panel1HitCounterTemp = 0
Panel2HitCounterTemp = 0
Panel3HitCounterTemp = 0
Panel4HitCounterTemp = 0
Panel5HitCounterTemp = 0
Panel6HitCounterTemp = 0
Mech_JunkTargetAim = 0
Mech_JunkTargetsCleared = 0
Mech_ThinnedArmour = 0
Mech_HeadDamage = 0
MechCurrentlySucking = false
MechCloseTriggerUsed = false
Mech_OhHereIAm = "Nowhere"
Prescotts_RedChestSave = function()
  SaveCheckpoint(GetPlayer(), LastCheckpointLoadFunction, LastCheckpointPos_Mickey, LastCheckpointPos_Oswald)
  return 
end
Mech_OnStimulus = function(self, _event)
  local event = _event
  local validStimTypes = {ST_KNOCKBACK, ST_FAIRY}
  local target = GetPropertyEntity(self, "Parent Entity", 0)
  Boss_SendStimulus(self, validStimTypes, event, target, 20)
  if StimulusEvent_HasStimulusType(event, ST_FAIRY) then
    NotifyFairySketchHit()
  end
  Mech_HitHead(self, event)
  return 
end
Mech_HitHead = function(self, _event)
  local event = _event
  local StimReceivedName = GetName(self)
  Print(("the object hit was" .. StimReceivedName))
  local HeadToonMiddle = GetChildEntityByName("AI_Mech 01", "PM_ToonFace")
  local HeadToonLeft = GetChildEntityByName("AI_Mech 01", "PM_ToonFaceLeft")
  local HeadToonRight = GetChildEntityByName("AI_Mech 01", "PM_ToonFaceRight")
  local HeadToonLeft2 = GetChildEntityByName("AI_Mech 01", "PM_ToonFaceLeft2")
  local HeadToonRight2 = GetChildEntityByName("AI_Mech 01", "PM_ToonFaceRight2")
  if StimulusEvent_HasStimulusType(event, ST_PHYSICAL) then
    if (GetPropertyBool(HeadToonMiddle, "Is Painted") == false) then
      if (GetPropertyBool(HeadToonLeft, "Is Painted") == false) then
        if (GetPropertyBool(HeadToonRight, "Is Painted") == false) then
          if (GetPropertyBool(HeadToonLeft2, "Is Painted") == false) then
            if (GetPropertyBool(HeadToonRight2, "Is Painted") == false) then
              AnimVarInt(PrescottMechEntity, VAR_HitReaction_Type, 0)
              AnimEvent(PrescottMechEntity, EVENT_Hit)
              Mech_HeadDamage = (Mech_HeadDamage + 1)
              ForEachEntityInGroup(ForceSpawn, "Mech_FaceSpawners", 1)
              if (Mech_HeadDamage < 3) then
                if (0 < Mech_HeadDamage) then
                  ForcePainted(HeadToonMiddle)
                  ForcePainted(HeadToonLeft)
                  ForcePainted(HeadToonRight)
                  ForcePainted(HeadToonLeft2)
                  ForcePainted(HeadToonRight2)
                  ForEachEntityInGroup(TimerReset, "OutsideHintTimers")
                  FireSequence("PrescottConversationMarker", ("FTL_PrescottArena_Prescott_TakingDamage" .. Mech_HeadDamage))
                end
              elseif (3 <= Mech_HeadDamage) then
                Mech_HeadDamage = -50
                wait(2)
                Mech_ThinnerEnd()
                if StimulusEvent_HasStimulusType(event, ST_PHYSICAL) then
                  AnimVarInt(PrescottMechEntity, VAR_HitReaction_Type, 1)
                  AnimEvent(PrescottMechEntity, EVENT_Hit)
                  MechOutsideGeneralHints()
                end
              end
            end
          end
        end
      end
    end
  elseif StimulusEvent_HasStimulusType(event, ST_PHYSICAL) then
    AnimVarInt(PrescottMechEntity, VAR_HitReaction_Type, 1)
    AnimEvent(PrescottMechEntity, EVENT_Hit)
    MechOutsideGeneralHints()
  end
  return 
end
Mech_SetTVState = function(activator)
  PM_SetTVState(PrescottMechEntity, activator)
  return 
end
Mech_CreateAttackSequence = function()
  PM_AddAttackSequence(PrescottMechEntity, PAT_Other)
  PM_AddAttackSequence(PrescottMechEntity, PAT_Standard)
  PM_AddAttackSequence(PrescottMechEntity, PAT_ThinnerBomb)
  PM_AddAttackSequence(PrescottMechEntity, PAT_CoolDown)
  return 
end
FTL_PrescottArena02_SaveCheckpoint = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    SetGlobal("Prescott_Boss_MechRoute", Mech_CurrentPath)
    SaveCheckpoint(GetPlayer(), "FTL_PrescottArena02_CheckpointLoad", "Stage2CheckPoint", "Stage2CheckPointOswald")
  end
  return 
end
FTL_PrescottArena02_CheckpointLoad = function()
  Print("__Function: FTL_PrescottArena02_CheckpointLoad")
  ReplaceMusicStateOverride("Combat_Lev2")
  Print("Loaded music event from Mech_V2_Setup")
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    SetGlobal("EM2_EpisodeCheck", 2)
    LevelManager_SetCurrentState("FTL_PrescottsArena.Outside")
  end
  if (GetGlobal("EM2_EpisodeCheck") == 2) then
    if (GetGlobal("FTL_PrescottMech_OutsideCutscenePlayed") == 0) then
      Print("*&*&*&*&*&*&*&*&*&*&*&*&**&*&*&*&*Mech_Stage2Intro")
      AudioPostEventOn(GetPlayer(), "Stop_sfx_pcArena_amb")
      if (GetGlobal("MechStage2Paint") == 1) then
        Mech_CurrentPath = Mech_PaintPath
      else
        Mech_CurrentPath = Mech_ThinnerPath
        Print("*&*&*&*&*&*&*&*&*&*&*&*&**&*&*&*&*Mech_Stage2THINNERSIDE")
      end
      Mech_Initialise()
    else
      GetPrefabData("ThinnerEntrance").MapLoad_SetupPosition = "IgnoreMe"
      GetPrefabData("OstownProjectorMarker").MapLoad_SetupPosition = "IgnoreMe"
      GetPrefabData("PaintEntrance").MapLoad_SetupPosition = "IgnoreMe"
      ForEachEntityInGroup(AnimGBSequence, "FirePitFire", "Loop", true)
      MultiPosSoundStart("ftl_prescottsarena_02a_audio.Trigger_FireParent")
      Hide("IGCPrescott")
      Hide("IGCGus")
      if (GetGlobal("MechStage2Paint") == 1) then
        Mech_CurrentPath = Mech_PaintPath
      else
        Mech_CurrentPath = Mech_ThinnerPath
        Print("*&*&*&*&*&*&*&*&*&*&*&*&**&*&*&*&*Mech_Stage2THINNERSIDE Reload")
      end
      PM_SetPathType(PrescottMechEntity, Mech_CurrentPath)
      Mech_Initialise()
      local data = GetPrefabData("ThinnerEntrance")
      if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
        data.Interior_Stream = "FTL_FloatGraveyard.Paint_2D"
        data.TeleportToMarker = "toPrescottArenaPaint_Projector_Upper"
      end
      ForEachEntityInGroup(AnimGBSequence, "FirePitFire", "Loop", true)
      MultiPosSoundStart("ftl_prescottsarena_02a_audio.Trigger_FireParent")
      Print("__Calling Mech_V2_Setup")
    end
  else
    local data = GetPrefabData("ThinnerEntrance")
    if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
      data.Interior_Stream = "FTL_FloatGraveyard.Paint_2D"
      data.TeleportToMarker = "toPrescottArenaPaint_Projector_Upper"
    end
    ForEachEntityInGroup(AnimGBSequence, "FirePitFire", "Loop", true)
    MultiPosSoundStart("ftl_prescottsarena_02a_audio.Trigger_FireParent")
    Print("__Calling Mech_V2_Setup")
  end
  return 
end
Mech_OnDeath = function(self)
  local mickey = GetPlayer()
  local oswald = GetPlayer2OrAI()
  if (mickey == nil) then
    if (oswald == nil) then
      return 
    end
  end
  if (self == mickey) then
    PM_SetTarget(oswald)
  elseif (self == oswald) then
    PM_SetTarget(mickey)
  end
  return 
end
Mech_HasDamagedPlayer = function(self, event)
  if (self == GetPlayerAI()) then
    return 
  end
  local eventAlias = {"TurretBomb", "MechSpikes"}
  if (Boss_OnPlayerStimulusAlias(self, event, ST_KNOCKBACK, eventAlias) == true) then
    Print("Mickey got knock back stim by turret bomb or spikes")
    PM_SetHasDamagedPlayer(PrescottMechEntity)
  end
  return 
end
Mech_ShowChildEntity = function(show, entityName)
  local entity = GetChildEntityByName(PrescottMechEntity, entityName)
  if (entity ~= nil) then
    if (show == true) then
      Show(entity)
    else
      Hide(entity)
    end
  end
  return 
end
Mech_ShowMovingFan = function(show)
  Mech_ShowChildEntity(show, Mech_FastFan)
  Mech_ShowChildEntity((not show), Mech_SlowFan)
  if show then
    Print("sucking!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    Unhide("BossInhaleFX")
    AnimGBSequence("BossInhaleFX", "Start", true)
  else
    Print("NOT sucking!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    Hide("BossInhaleFX")
    AnimGBSequence("BossInhaleFX", "End")
  end
  return 
end
PrescottJunkTaunt = 0
PrescottCannonTaunt = 0
PrescottVacuumTaunt = 0
MechOutside_PrescottTaunt = function(target, taunt, variable, num)
  if (taunt == "FTL_PrescottArena_Prescott_CannonShot") then
    if (Mech_ThinnedArmour == 5) then
      num = 3
    end
  end
  if (_G[variable] < num) then
    _G[variable] = (_G[variable] + 1)
  elseif (taunt == "FTL_PrescottArena_Prescott_CannonShot") then
    if (Mech_ThinnedArmour == 5) then
      FireSequence("GusConversationMarker", "FTL_PrescottArena_Gus_HintCannonBall")
      _G[variable] = 0
    end
  elseif (IsAnySequencePlaying() == false) then
    ForEachEntityInGroup(TimerReset, "OutsideHintTimers")
    FireSequence("PrescottConversationMarker", taunt)
    _G[variable] = 0
  end
  return 
end
MechOutside_PrescottGeneralTaunt = function()
  if (IsAnySequencePlaying() == false) then
    ForEachEntityInGroup(TimerReset, "OutsideHintTimers")
    FireSequence("PrescottConversationMarker", "FTL_PrescottArena_Prescott_JunkToss")
  end
  return 
end
GusGeneralHints = 0
MechOutsideGeneralHints = function()
  local IsInCutscene = IsInGameStateCutscene()
  local IsSequencePlaying = IsAnySequencePlaying()
  print(((("[TM] MechOutsideGeneralHints IsInCutscene " .. tostring(IsInCutscene)) .. " IsSequencePlaying ") .. tostring(IsSequencePlaying)))
  if (IsInCutscene == false) then
    if (IsSequencePlaying == false) then
      if (Mech_CurrentPath == Mech_ThinnerPath) then
        GusGeneralHints = (GusGeneralHints + 1)
        FireSequence("GusConversationMarker", "FTL_PrescottArena_Gus_FaceThinHint")
      elseif (GusGeneralHints == 0) then
        FireSequence("GusConversationMarker", "FTL_PrescottArena_Gus_StageTwoHints")
        GusGeneralHints = (GusGeneralHints + 1)
      else
        FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintPanel")
        GusGeneralHints = 0
      end
      ForEachEntityInGroup(TimerReset, "OutsideHintTimers")
    end
  end
  return 
end
PM_TargetCounter = 0
PM_MickeyTarget = false
PM_OswaldTarget = false
PM_JunkTargetCounter = 0
PM_JunkMickeyTarget = false
PM_JunkOswaldTarget = false
PM_MickeyDead = false
PM_OswaldDead = false
Mech_LatentResetVacuumTrigger = function()
  wait(0.066600002348423)
  MechCloseTriggerUsed = false
  Mech_PlayerCloseSuctionEvent(nil, "checking")
  return 
end
Mech_OnAnimEvent = function(self, _event)
  local eventType = AnimEvent_Type(_event)
  if (eventType == EVENT_IsThrowingJunk) then
    Mech_PlaceJunk()
  elseif (eventType == EVENT_HasStartedThrowMoveBack) then
    Unhide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadR"))
    Unhide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyR"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadB"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyB"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadW"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyW"))
    Mech_CamChangeForThrow()
  elseif (eventType == EVENT_IsInIdle) then
    Unhide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadW"))
    Unhide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyW"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadR"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyR"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadB"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyB"))
    Mech_CamChangeForFight()
    if (Mech_JunkTargetsCleared == 0) then
      Mech_JunkTargetsCleared = 1
      Mech_AIOswald_JunkTarget("clear")
      Print("!!!!!!!!Clearing Junk Targets!!!!!!!!!!!!!!!!!!")
    end
  elseif (eventType == EVENT_IsInThinnerBombAttack) then
    Unhide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadR"))
    Unhide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyR"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadB"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyB"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadW"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyW"))
  elseif (eventType == EVENT_FireBullet) then
    wait(1.5)
    FireThread(Mech_LatentResetVacuumTrigger)
    MechOutside_PrescottTaunt(nil, "FTL_PrescottArena_Prescott_CannonShot", "PrescottCannonTaunt", 8)
    if (PM_TargetCounter == 0) then
      PM_MickeyTarget = true
      PM_OswaldTarget = false
    end
    if (PM_TargetCounter == 1) then
      PM_MickeyTarget = false
      PM_OswaldTarget = true
    end
    if (PM_MickeyTarget == true) then
      PM_SetTarget(PrescottMechEntity, GetPlayer())
      PM_TargetCounter = (PM_TargetCounter + 1)
    end
    if (PM_OswaldTarget == true) then
      PM_SetTarget(PrescottMechEntity, GetPlayer2OrAI())
      PM_TargetCounter = (PM_TargetCounter - 1)
    end
  elseif (eventType == EVENT_Start_Fan) then
    MechCurrentlySucking = true
    Mech_ShowChildEntity(false, Mech_JunkBall)
    FireThread(Mech_SucktionEventSpawnJunk, nil)
    Unhide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadR"))
    Unhide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyR"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadB"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyB"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadW"))
    Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyW"))
    MechOutside_PrescottTaunt(nil, "FTL_PrescottArena_Prescott_Vacuum", "PrescottVacuumTaunt", 0)
    Mech_ShowMovingFan(true)
  elseif (eventType == EVENT_Stop_Fan) then
    Mech_ShowMovingFan(false)
    MechCurrentlySucking = false
  elseif (eventType == EVENT_OnSlowTimeStarted) then
    Mech_ShowMovingFan(false)
  elseif (eventType == EVENT_OnSlowTimeEnded) then
    Mech_ShowMovingFan(true)
  end
  return 
end
Mech_PlaceJunk = function()
  if (Mech_JunkTargetsCleared == 1) then
    Mech_JunkTargetsCleared = 0
    ForEachEntityInGroup(Enable, "BuddyAIJunkTargetMarkerCenter")
  end
  Mech_UpdateJunkPosition()
  Mech_SpawnJunk()
  return 
end
Mech_SpawnJunk = function()
  local junkBallEntity = GetEntity("JunkBallSpawner")
  if (junkBallEntity == nil) then
    Print("Mech_SpawnJunk tried to spawn invalid entity")
    return 
  end
  Enable(junkBallEntity)
  ForceSpawn(junkBallEntity, 1)
  Disable(junkBallEntity)
  local target = GetPlayer()
  if IsValidHandle(target) then
    AudioPostEventOn(GetPlayer(), "Play_junk_ball_impact")
  end
  return 
end
Mech_UpdateJunkPosition = function(junk, shadow)
  MechOutside_PrescottTaunt(nil, "FTL_PrescottArena_Prescott_JunkToss", "PrescottJunkTaunt", 4)
  if (Mech_JunkTargetAim == 0) then
    Mech_JunkTargetAim = 1
    local target = GetPlayer()
    if IsValidHandle(target) then
      local playerPosition = GetPosition(target)
      SetTransformation("JunkBallSpawner", playerPosition, vector4(0, 0, 0))
    end
  else
    Mech_AIOswald_JunkTarget("throw")
    Print("Tossing at Oswald and firing the logic for the junk target")
    Mech_JunkTargetAim = 0
    local target, target = GetPlayer2OrAI(), "FTL_PrescottArena_Prescott_JunkToss"
    target = target
    if IsValidHandle(target) then
      target = target
      local playerPosition, playerPosition = GetPosition(target), "PrescottJunkTaunt"
      target = SetTransformation
      playerPosition = "JunkBallSpawner"
      target(playerPosition, playerPosition, vector4(0, 0, 0))
    end
  end
  return 
end
Mech_ScaleShadow = function(self)
  local (for index), (for limit), (for step) = 0, 4.300000190734863, 0.10000000149011612
  for scale = (for index), (for limit), (for step) do
    SetShadowScale(self, vector4(scale, 350, scale))
    wait(0.05000000074505806)
  end
  return 
end
Mech_CamChangeForThrow = function()
  SetCameraAttributesForPlayer(MechThrowCamera, nil)
  return 
end
Mech_CamChangeForFight = function()
  ClearCameraAttributesForPlayer(MechThrowCamera, nil)
  SetCameraAttributesForPlayer(MechFightCamera, nil)
  return 
end
Mech_V2_hardloadonlyFromFloatyard = function()
  TogglePlayerIconSubstitute(false, false)
  StartFadeOut(0)
  if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
    GetPrefabData("ThinnerEntrance").MapLoad_SetupPosition = "IgnoreMe"
    GetPrefabData("OstownProjectorMarker").MapLoad_SetupPosition = "IgnoreMe"
    GetPrefabData("PaintEntrance").MapLoad_SetupPosition = "True"
  else
    GetPrefabData("ThinnerEntrance").MapLoad_SetupPosition = "True"
    GetPrefabData("OstownProjectorMarker").MapLoad_SetupPosition = "IgnoreMe"
    GetPrefabData("PaintEntrance").MapLoad_SetupPosition = "IgnoreMe"
  end
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    SetGlobal("EM2_EpisodeCheck", 3)
  end
  Mech_V2_Setup()
  return 
end
Mech_V2_hardloadonlyFromOstown = function()
  TogglePlayerIconSubstitute(false, false)
  StartFadeOut(0)
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    SetGlobal("EM2_EpisodeCheck", 3)
  end
  SetRotatorMaxSpeed("OstownExitDoor", 720)
  GetPrefabData("ThinnerEntrance").MapLoad_SetupPosition = "IgnoreMe"
  GetPrefabData("PaintEntrance").MapLoad_SetupPosition = "IgnoreMe"
  GetPrefabData("OstownProjectorMarker").MapLoad_SetupPosition = "True"
  Mech_V2_Setup()
  return 
end
Mech_V2_Setup = function()
  Print("__Function: Mech_V2_Setup")
  local (for index), (for limit), (for step) = 1, 6, 1
  for i = (for index), (for limit), (for step) do
    Hide(("PanelA" .. i))
    Hide(("PanelB" .. i))
    Hide(("PanelC" .. i))
    Hide((("Panel" .. i) .. "Glow"))
    Hide((("Panel" .. i) .. "GlowFIN"))
  end
  Hide("PanelShockEffect2")
  Hide("PanelShockEffect5")
  Hide("PanelShockEffect6")
  AudioPostEventOn("PanelShockEffect2", "Stop_mboss_panel_electrified")
  AudioPostEventOn("PanelShockEffect5", "Stop_mboss_panel_electrified")
  AudioPostEventOn("PanelShockEffect6", "Stop_mboss_panel_electrified")
  DestroyEntity("CloseSuctionTrigger")
  local (for index), (for limit), (for step) = 1, 6, 1
  for value = (for index), (for limit), (for step) do
    (for index) = GetGlobal
    (for limit) = "FTL_Panel"
    (for step) = value
    value = "HitCounter"
    (for limit) = (((for limit) .. (for step)) .. value)
    (for index) = (for index)((for limit))
    if ((for index) == 0) then
      (for index) = Unhide
      (for limit) = "PanelA"
      (for step) = value
      (for limit) = ((for limit) .. (for step))
      (for index)((for limit))
    else
      (for index) = GetGlobal
      (for limit) = "FTL_Panel"
      (for step) = value
      value = "HitCounter"
      (for limit) = (((for limit) .. (for step)) .. value)
      (for index) = (for index)((for limit))
      if ((for index) == 1) then
        (for index) = Unhide
        (for limit) = "PanelB"
        (for step) = value
        (for limit) = ((for limit) .. (for step))
        (for index)((for limit))
      else
        (for index) = GetGlobal
        (for limit) = "FTL_Panel"
        (for step) = value
        value = "HitCounter"
        (for limit) = (((for limit) .. (for step)) .. value)
        (for index) = (for index)((for limit))
        if ((for index) == 2) then
          (for index) = Unhide
          (for limit) = "PanelC"
          (for step) = value
          (for limit) = ((for limit) .. (for step))
          (for index)((for limit))
        else
          (for index) = GetGlobal
          (for limit) = "FTL_Panel"
          (for step) = value
          value = "HitCounter"
          (for limit) = (((for limit) .. (for step)) .. value)
          (for index) = (for index)((for limit))
          if (3 <= (for index)) then
            if (value == "1") then
              (for index) = TeleportToEntity
              (for limit) = "CogGroup"
              (for step) = value
              (for limit) = ((for limit) .. (for step))
              (for step) = "PM_CogTeleport_"
              value = value
              (for step) = ((for step) .. value)
              (for index)((for limit), (for step))
            end
            if (value == "2") then
              (for index) = StartEmitters
              (for limit) = "PanelShockEffect"
              (for step) = value
              (for limit) = ((for limit) .. (for step))
              (for index)((for limit))
              (for index) = Unhide
              (for limit) = "PanelShockEffect"
              (for step) = value
              (for limit) = ((for limit) .. (for step))
              (for index)((for limit))
              (for index) = AudioPostEventOn
              (for limit) = "PanelShockEffect"
              (for step) = value
              (for limit) = ((for limit) .. (for step))
              (for step) = "Play_mboss_panel_electrified"
              (for index)((for limit), (for step))
            end
          end
        end
      end
    end
  end
  if (GetGlobal("FTL_PrescottMechCheck") == 1) then
    AnimGBSequence("MechDoors", "Open", true)
  else
    AnimGBSequence("MechDoors", "OpenBreathe")
  end
  Hide("AI_Mech 01")
  Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadB"))
  Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyB"))
  Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadR"))
  Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyR"))
  Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadW"))
  Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyW"))
  ForEachEntityInGroup(AnimGBSequence, "PM_ColorChange", "PULSE")
  SetRotatorMaxSpeed("OstownExitDoor", 720)
  if (Mech_OhHereIAm ~= "Nowhere") then
    SetCameraAttributesForPlayer((Mech_OhHereIAm .. "RescueCamMickey"), GetPlayer())
    SetCameraAttributesForPlayer((Mech_OhHereIAm .. "RescueCamOswald"), GetPlayer2OrAI())
    FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer())
    FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer2OrAI())
  end
  MusicPostEventOn(GetPlayer(), "Play_MX_BossPrescott")
  ReplaceMusicStateOverride("Combat_Lev2")
  Print("Loaded music event from Mech_V2_Setup")
  return 
end
Mech_V2_DoorFreakOut = function()
  local currentanim = GetPropertyInt("MechDoors", "Active Sequence ID")
  wait(1.2000000476837158)
  if (currentanim == 1) then
    AnimGBSequence("MechDoors", "Close", true)
  elseif (currentanim == 4) then
    AnimGBSequence("MechDoors", "Open", true)
  end
  return 
end
Mech_HidePanels = function()
  local (for index), (for limit), (for step) = 1, 6, 1
  for i = (for index), (for limit), (for step) do
    Hide(("PanelB" .. i))
    Hide(("PanelC" .. i))
    Hide((("Panel" .. i) .. "Glow"))
    Hide((("Panel" .. i) .. "GlowFIN"))
  end
  Hide("PanelShockEffect2")
  Hide("PanelShockEffect5")
  Hide("PanelShockEffect6")
  AudioPostEventOn("PanelShockEffect2", "Stop_mboss_panel_electrified")
  AudioPostEventOn("PanelShockEffect5", "Stop_mboss_panel_electrified")
  AudioPostEventOn("PanelShockEffect6", "Stop_mboss_panel_electrified")
  Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadB"))
  Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyB"))
  Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadR"))
  Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyR"))
  Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowHeadW"))
  Hide(GetChildEntityByName(PrescottMechEntity, "MechGlowBodyW"))
  return 
end
Mech_PanelSwap = function(target, value)
  if (GetGlobal((("FTL_Panel" .. value) .. "HitCounter")) < 4) then
    Print(("Mech_PanelSwap: The activator is : " .. GetPropertyString(_activator(), "EntityGroups", 0)))
    if (GetPropertyString(_activator(), "EntityGroups", 0) == "Anvil") then
      if HasCollectible("SketchUpgrade_Sketch_Anvil") then
        SetGlobal((("FTL_Panel" .. value) .. "HitCounter"), 3)
      end
    else
      SetGlobal((("FTL_Panel" .. value) .. "HitCounter"), (GetGlobal((("FTL_Panel" .. value) .. "HitCounter")) + 1))
    end
    AudioPostEventOn(GetPlayer(), "Play_mboss_panel_smash")
    if (GetGlobal((("FTL_Panel" .. value) .. "HitCounter")) == 1) then
      ForEachEntityInGroup(TimerReset, "OutsideHintTimers")
      FireSequence("GusConversationMarker", "FTL_PrescottArena_Gus_PanelBreak")
      Hide(("ftl_prescottsarena_02a_main.Stage_02_PanelA 0" .. value))
      Show(("ftl_prescottsarena_02a_main.Stage_02_PanelB 0" .. value))
    elseif (GetGlobal((("FTL_Panel" .. value) .. "HitCounter")) == 2) then
      Hide(("ftl_prescottsarena_02a_main.Stage_02_PanelB 0" .. value))
      Show(("ftl_prescottsarena_02a_main.Stage_02_PanelC 0" .. value))
    elseif (GetGlobal((("FTL_Panel" .. value) .. "HitCounter")) == 3) then
      if (GetGlobal("EM2_EpisodeCheck") == 3) then
        Hide(("ftl_prescottsarena_02a_main.Stage_02_PanelA 0" .. value))
        Hide(("ftl_prescottsarena_02a_main.Stage_02_PanelB 0" .. value))
        Hide(("ftl_prescottsarena_02a_main.Stage_02_PanelC 0" .. value))
        Show((("Panel" .. value) .. "Glow"))
        if (value == "1") then
          TeleportToEntity(("CogGroup" .. value), ("PM_CogTeleport_" .. value))
        end
        if (value == "2") then
          StartEmitters(("PanelShockEffect" .. value))
          Unhide(("PanelShockEffect" .. value))
          AudioPostEventOn(("PanelShockEffect" .. value), "Play_mboss_panel_electrified")
        end
        SetGlobal((("FTL_Panel" .. value) .. "HitCounter"), 4)
      end
    elseif (GetGlobal((("FTL_Panel" .. value) .. "HitCounter")) == 3) then
      Hide(("ftl_prescottsarena_02a_main.Stage_02_PanelA 0" .. value))
      Hide(("ftl_prescottsarena_02a_main.Stage_02_PanelB 0" .. value))
      Hide(("ftl_prescottsarena_02a_main.Stage_02_PanelC 0" .. value))
      Show((("Panel" .. value) .. "Glow"))
      if (value == "1") then
        TeleportToEntity(("CogGroup" .. value), ("PM_CogTeleport_" .. value))
        SetPropertyBool((("Gear" .. value) .. "LookatTrigger"), "Look At Trigger Enabled", true)
        wait(1)
        ForEachEntityInGroup(TimerReset, "OutsideHintTimers")
        FireSequence("GusConversationMarker", "FTL_PrescottArena_Gus_GearHint")
      end
      if (value == "2") then
        SetSplineFollowerInitialSpeed((("Shocker" .. value) .. "SplineFollower"), 0.5)
        Print(("ENABLING THE BUDDY ACTION SPOT NUMBER : " .. value))
        FireThread(Mech_PanelSwapActivateOswald, value)
      end
      SetGlobal((("FTL_Panel" .. value) .. "HitCounter"), 4)
    end
  end
  return 
end
Mech_PanelSwapActivateOswald = function(value)
  wait(2)
  Enable(("BuddyAIMarker" .. value))
  return 
end
Mech_CutsceneEnd = function()
  Hide("IGCPrescott")
  Hide("IGCGus")
  EnableSplitScreen(true)
  PM_CutsceneEnded(PrescottMechEntity)
  UnpauseAllAI()
  return 
end
MechTurret_StartLevelThinner = function(target)
  StartFadeOut(0)
  if (GetGlobal("FTL_PrescottMech_OutsideCutscenePlayed") == 0) then
    SetPropertyFloat(GetRelativePrefabEntity("ThinnerEntrance", ".ProjectorScreen"), "UsableRadius", 0)
    SetPropertyFloat(GetRelativePrefabEntity("PaintEntrance", ".ProjectorScreen"), "UsableRadius", 0)
    GetPrefabData("ThinnerEntrance").ToFlyThrough = "True"
  end
  GetPrefabData("ThinnerEntrance").MapLoad_SetupPosition = "True"
  GetPrefabData("PaintEntrance").MapLoad_SetupPosition = "IgnoreMe"
  GetPrefabData("OstownProjectorMarker").MapLoad_SetupPosition = "IgnoreMe"
  return 
end
MechTurret_FloatyardProjectorCheck = function()
  wait(0.10000000149011612)
  if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
    ForEachEntityInPrefab(Hide, "ThinnerEntrance")
  else
    ForEachEntityInPrefab(Hide, "PaintEntrance")
  end
  return 
end
Mech_IntroCutsceneSetup = function()
  MusicPostEventOn(GetPlayer(), "Play_MX_BossPrescott")
  ReplaceMusicStateOverride("Combat_Lev2")
  Print("Started music event from Mech_IntroCutsceneSetup")
  AnimGBSequence("ftl_prescottsarena_02a_main.DoorRight", "Open")
  wait(1)
  if (GetGlobal("EM2_EpisodeCheck") == 2) then
    if (Mech_CurrentPath == Mech_PaintPath) then
      DoStinger("Stinger_MiniBoss", 2)
      PlayIGC("IGC_0280a_PrescottIntroStage2Paint")
    elseif (Mech_CurrentPath == Mech_ThinnerPath) then
      if (GetGlobal("FTL_FloatGraveyard_FireworksState02") ~= 2) then
        DoStinger("Stinger_Moment", 2)
        PlayIGC("IGC_0280b_PrescottIntroStage2Thinner")
      else
        DoStinger("Stinger_Reveal1", 2)
        PlayIGC("IGC_0280c_PrescottIntroStage2Projector")
      end
    end
  end
  return 
end
PostIGC_0280a_PrescottIntroStage2Paint = function()
  Mech_ShowChildEntity(false, Mech_SlowFan)
  PostIntroIGCCleanup()
  return 
end
PostIGC_0280c_PrescottIntroStage2Projector = function()
  Quest_SetCriticalPath("Critical_Boss2", "Critical_Boss2_1")
  Print("PostIGC_0280c_PrescottIntroStage2Projector: HidingTheJunkBalls!")
  Mech_ShowChildEntity(false, Mech_JunkBall)
  Mech_OhHereIAm = "Nowhere"
  PostIntroIGCCleanup()
  UnrestrictCutSceneInput()
  return 
end
PostIGC_0280b_PrescottIntroStage2Thinner = function()
  Print("PostIGC_0280b_PrescottIntroStage2Thinner: HidingTheJunkBalls!")
  Mech_ShowChildEntity(false, Mech_JunkBall)
  PostIntroIGCCleanup()
  return 
end
PostIntroIGCCleanup = function()
  SetCameraAttributes(MechFightCamera)
  Mech_CutsceneEnd()
  TimerEnable("GeneralHintTimer")
  TimerEnable("PrescottTauntTimer")
  PM_OnLevelLoaded(PrescottMechEntity, false, 4, -1)
  FTL_PrescottArena02_SaveCheckpoint()
  return 
end
PostIGC_0295a_EndBossFight_Paint = function()
  Mech_Powerhouse()
  return 
end
PostIGC_0295b_EndBossFight_Thinner = function()
  Mech_Powerhouse()
  return 
end
Mech_Initialise = function()
  FireThread(Mech_DeactivateProjectors)
  if (GetGlobal("MSN_Arcade_FromArcade") ~= 0) then
    if (2 <= GetGlobal("MechTurret_PickedRoutePaint")) then
      Mech_CurrentPath = Mech_PaintPath
    else
      Mech_CurrentPath = Mech_ThinnerPath
      Print("Arcade Thinner Path")
    end
    ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
    EnableSplitScreen(true)
    StartFadeIn(0.5)
    SetGlobal("FTL_PrescottMech_OutsideCutscenePlayed", 1)
    Print("Mech_Initialise: Teleporting Mickey in the arcade mode!")
    TeleportToEntity(GetPlayer(), "Stage2CheckPoint")
    OswaldTeleportToMickeyAction()
  end
  PM_SetPathType(PrescottMechEntity, Mech_CurrentPath)
  Mech_CreateAttackSequence()
  if (GetGlobal("MechCannonLoadersKilled") ~= 1) then
    PM_SetCanThrowThinnerBombs(PrescottMechEntity, true)
  else
    PM_SetCanThrowThinnerBombs(PrescottMechEntity, false)
  end
  Mech_ShowChildEntity(false, Mech_FastFan)
  if (Mech_CurrentPath == Mech_PaintPath) then
    Mech_ShowChildEntity(false, Mech_SlowFan)
  elseif (Mech_CurrentPath == Mech_ThinnerPath) then
    Print("Mech_Initialise: HidingTheJunkBalls!")
    Mech_ShowChildEntity(false, Mech_JunkBall)
  end
  Mech_HidePanels()
  if (GetGlobal("FTL_PrescottMech_OutsideCutscenePlayed") == 0) then
    SetGlobal("FTL_PrescottMech_OutsideCutscenePlayed", 1)
    Mech_IntroCutsceneSetup()
  else
    AnimGBSequence("ftl_prescottsarena_02a_main.DoorRight", "OpenBreathe")
    TeleportToEntity(GetPlayer(), "Stage2CheckPoint")
    OswaldTeleportToMickeyAction()
    TimerEnable("GeneralHintTimer")
    TimerEnable("PrescottTauntTimer")
    PM_OnLevelLoaded(PrescottMechEntity, false, 4, -1)
  end
  ForEachEntityInGroup(AnimGBSequence, "PM_ColorChange", "PULSE")
  if (GetGlobal("MSN_Arcade_FromArcade") ~= 0) then
    local (for index), (for limit), (for step) = 1, 6, 1
    for value = (for index), (for limit), (for step) do
      _G[(("Panel" .. value) .. "HitCounterTemp")] = GetGlobal((("FTL_Panel" .. value) .. "HitCounter"))
      SetGlobal((("FTL_Panel" .. value) .. "HitCounter"), 0)
    end
    Mech_CutsceneEnd()
  end
  return 
end
Mech_PaintedCogs = 0
MaxNumberofCogsorArmour = 3
Mech_RemovedArmour = function(target)
  if GetPropertyBool(target, "Is Painted") then
    Mech_ThinnedArmour = (Mech_ThinnedArmour - 1)
  else
    Mech_ThinnedArmour = (Mech_ThinnedArmour + 1)
    Mech_SpawnDebris()
  end
  if (Mech_ThinnedArmour == 5) then
    FireSequence("GusConversationMarker", "FTL_PrescottArena_Gus_HintCannonBall")
  end
  return 
end
BeenZapped2 = 0
BeenZapped5 = 0
BeenZapped6 = 0
StartCogs = function(target, variable)
  _G[("BeenZapped" .. variable)] = 1
  if GetPropertyBool((("Shocker" .. variable) .. "Cog"), "Is Painted") then
    SetRotatorMaxSpeed((("Shocker" .. variable) .. "Cog"), 60)
  else
    ForEachEntityInGroup(TimerReset, "OutsideHintTimers")
    FireSequence("OswaldConversationMarker", "FTL_PrescottArena_Oswald_HintGears")
  end
  Hide((("Panel" .. variable) .. "Glow"))
  Show((("Panel" .. variable) .. "GlowFIN"))
  StartEmitters(("PanelShockEffect" .. variable))
  Show(("PanelShockEffect" .. variable))
  AudioPostEventOn(("PanelShockEffect" .. variable), "Play_mboss_panel_electrified")
  Disable(("BuddyAIMarker" .. variable))
  FireThread(Mech_CogsArePainted)
  wait(1.2000000476837158)
  OswaldStreamAbort()
  return 
end
PaintedCogGroup1 = 0
PaintedCogGroup3 = 0
PaintedCogGroup4 = 0
HasCutscenePlayed1 = 0
Mech_CogsArePainted = function()
  if (HasCutscenePlayed1 == 0) then
    if (not GetPropertyBool("CogGroup1", "Is Painted")) then
      if (not GetPropertyBool("CogGroup3", "Is Painted")) then
      end
    end
    HasCutscenePlayed1 = 1
    PauseAllAI()
    PM_StartPaintedCogCutscene(PrescottMechEntity)
    AnimGBSequence("ftl_prescottsarena_02a_main.DoorRight", "Paint")
    Prefab_GrabCameraNifFancy("ftl_prescottsarena_02a_main.grabcameraniffancy 05.HavokGBAnimation 01")
    EnableSplitScreen(false)
  elseif GetPropertyBool("CogGroup1", "Is Painted") then
    if GetPropertyBool("CogGroup3", "Is Painted") then
      if GetPropertyBool("CogGroup4", "Is Painted") then
        if (BeenZapped2 == 1) then
          if (BeenZapped5 == 1) then
            if (BeenZapped6 == 1) then
              if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
                wait(2)
                GiveCollectible("Second_Chance")
                GiveCollectible("Challenge_TheBiggerTheyAre_Tracker")
                SetGlobal("SecondChancePin_Redeemed", 1)
                SetGlobal("Extras_Prescotts_Mech_Paint", 1)
                MechDead = 1
                PM_SetPathType(PrescottMechEntity, Mech_CurrentPath)
                SetGlobal("FTL_PrescottMechCheck", 1)
                IncreaseMaxPaintAmmo()
                IncreaseMaxElectricityAmmo()
                Hide("BossInhaleFX")
                DoStinger("Exp_D_3D")
                PlayIGC("IGC_0295a_EndBossFight_Paint")
              else
                local (for index), (for limit), (for step) = 1, 6, 1
                for value = (for index), (for limit), (for step) do
                  SetGlobal((("FTL_Panel" .. value) .. "HitCounter"), _G[(("Panel" .. value) .. "HitCounterTemp")])
                end
                SetGlobal("MSN_Arcade_FromArcade", 2)
                TempMechTimerCheck = false
                wait(1)
                LoadLevel(GetPlayer(), "MeanStreet_North.Visit_2")
              end
            end
          end
        end
      end
    end
  end
  return 
end
Mech_PaintCog = function(self, value)
  if (GetGlobal((("FTL_Panel" .. value) .. "HitCounter")) == 4) then
    if (GetGlobal("EM2_EpisodeCheck") == 2) then
      Hide((("Panel" .. value) .. "Glow"))
      Show((("Panel" .. value) .. "GlowFIN"))
      if (BeenZapped2 ~= 1) then
        if (BeenZapped5 ~= 1) then
        end
      end
      SetRotatorMaxSpeed(("CogGroup" .. value), 60)
      FireSequence("GusConversationMarker", "FTL_PrescottArena_Gus_ShockerHint")
      ForEachEntityInGroup(TimerReset, "OutsideHintTimers")
      ClearCameraAttributesForPlayer(("MechToonGearCamera" .. value), nil)
      SetPropertyBool((("Gear" .. value) .. "LookatTrigger"), "Look At Trigger Enabled", false)
      Mech_CogsArePainted()
    end
  end
  return 
end
Mech_ThinCog = function(self, value)
  if (GetGlobal((("FTL_Panel" .. value) .. "HitCounter")) == 4) then
    if (GetGlobal("EM2_EpisodeCheck") == 2) then
      Show((("Panel" .. value) .. "Glow"))
      Hide((("Panel" .. value) .. "GlowFIN"))
      SetRotatorMaxSpeed(("CogGroup" .. value), 0)
      SetPropertyBool((("Gear" .. value) .. "LookatTrigger"), "Look At Trigger Enabled", true)
    end
  end
  return 
end
MechCutsceneEnd = 0
MechDead = 0
Mech_ThinnerEnd = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    GiveCollectible("Napoleon_Complex")
    GiveCollectible("Challenge_TheBiggerTheyAre_Tracker")
    wait(1)
    SetGlobal("NapComplexPin_Destroyed", 1)
    MechDead = 1
    Hide("BossInhaleFX")
    AnimGBSequence("BossInhaleFX", "End")
    PM_SetPathType(PrescottMechEntity, Mech_CurrentPath)
    SetGlobal("FTL_PrescottMechCheck", 2)
    IncreaseMaxThinnerAmmo()
    IncreaseMaxElectricityAmmo()
    Hide("BossInhaleFX")
    DoStinger("Exp_L_3D")
    PlayIGC("IGC_0295b_EndBossFight_Thinner")
  else
    local (for index), (for limit), (for step) = 1, 6, 1
    for value = (for index), (for limit), (for step) do
      SetGlobal((("FTL_Panel" .. value) .. "HitCounter"), _G[(("Panel" .. value) .. "HitCounterTemp")])
    end
    SetGlobal("MSN_Arcade_FromArcade", 2)
    TempMechTimerCheck = false
    wait(1)
    LoadLevel(GetPlayer(), "MeanStreet_North.Visit_2")
  end
  return 
end
Mech_Powerhouse = function()
  SetGlobal("EM2_EpisodeCheck", 3)
  GiveCollectibleNoPopup("Film_PH2_3")
  wait(1)
  AudioPostEventOn(GetPlayer(), "Stop_MX_BossPrescott_ALL")
  PlayMovie(GetPlayer(), "PH_2_3_Prescott_Defeated.bik")
  LoadLevel(GetPlayer(), "MeanStreet_South.Visit1")
  return 
end
Mech_EndLevel = function(target)
  if (GetGlobal("2dDirection") ~= 100) then
    SetGlobal("2dDirection", 101)
  end
  SetupPosition(target)
  return 
end
Mech_OnFanStimulus = function(self, event)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    bark(nil, "you've stopped my FAN!")
    PM_SetShockedState(PrescottMechEntity)
  end
  return 
end
Mech_SpawnDebris = function()
  ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  return 
end
Mech_JunkBallReward = 0
Mech_JunkBallSpawnedReward = function(target)
  if (Mech_JunkBallReward < 4) then
    Mech_JunkBallReward = (Mech_JunkBallReward + 1)
  else
    SetPropertyInt(target, "DynamicRewards", 2, 0)
    Mech_JunkBallReward = 0
  end
  return 
end
MechShakeCam = function()
  ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  return 
end
Mech_AIOswald_JunkTarget = function(command)
  if (command == "throw") then
    ForEachEntityInGroup(Enable, "BuddyAIJunkTargetMarkerCenter")
    local (for index), (for limit), (for step) = 1, 6, 1
    for value = (for index), (for limit), (for step) do
      Disable(("BuddyAIJunkTargetMarker" .. value))
    end
  end
  if (command == "clear") then
    ForEachEntityInGroup(Disable, "BuddyAIJunkTargetMarkerCenter")
    local (for index), (for limit), (for step) = 1, 6, 1
    for value = (for index), (for limit), (for step) do
      (for index) = Disable
      (for limit) = "BuddyAIJunkTargetMarker"
      (for step) = value
      (for limit) = ((for limit) .. (for step))
      (for index)((for limit))
    end
  end
  local MickeyPanelDistance = 100
  local TotalLeftPanels = 0
  local ShortestPanelDistanceNum = 0
  if (command == "decoy") then
    ForEachEntityInGroup(Disable, "BuddyAIJunkTargetMarkerCenter")
    local (for index), (for limit), (for step) = 1, 6, 1
    for value = (for index), (for limit), (for step) do
      MickeyPanelDistance = "FTL_Panel"
      TotalLeftPanels = value
      ShortestPanelDistanceNum = "HitCounter"
      MickeyPanelDistance = ((MickeyPanelDistance .. TotalLeftPanels) .. ShortestPanelDistanceNum)
      if (GetGlobal(MickeyPanelDistance) < 4) then
        MickeyPanelDistance = "BuddyAIJunkTargetMarker"
        TotalLeftPanels = value
        MickeyPanelDistance = (MickeyPanelDistance .. TotalLeftPanels)
        Enable(MickeyPanelDistance)
        TotalLeftPanels = (TotalLeftPanels + 1)
        MickeyPanelDistance = "BuddyAIJunkTargetMarker"
        TotalLeftPanels = value
        MickeyPanelDistance = (MickeyPanelDistance .. TotalLeftPanels)
        TotalLeftPanels = GetPlayer
        TotalLeftPanels = TotalLeftPanels()
        if (GetDistanceBetweenEntities(MickeyPanelDistance, TotalLeftPanels) < MickeyPanelDistance) then
          MickeyPanelDistance = "BuddyAIJunkTargetMarker"
          TotalLeftPanels = value
          MickeyPanelDistance = (MickeyPanelDistance .. TotalLeftPanels)
          TotalLeftPanels = GetPlayer
          TotalLeftPanels = TotalLeftPanels()
          MickeyPanelDistance = GetDistanceBetweenEntities(MickeyPanelDistance, TotalLeftPanels)
          ShortestPanelDistanceNum = value
        end
        MickeyPanelDistance = "The panel distance is: "
        TotalLeftPanels = MickeyPanelDistance
        MickeyPanelDistance = (MickeyPanelDistance .. TotalLeftPanels)
        Print(MickeyPanelDistance)
      end
    end
    if (1 < TotalLeftPanels) then
      Disable(("BuddyAIJunkTargetMarker" .. ShortestPanelDistanceNum))
    end
  end
  return 
end
MechSuctionTrigger = 0
Mech_PlayerCloseSuctionEvent = function(target, direction)
  if (direction == "in") then
    MechSuctionTrigger = (MechSuctionTrigger + 1)
  elseif (direction == "out") then
    MechSuctionTrigger = (MechSuctionTrigger - 1)
  end
  Print(((((("Mech_PlayerCloseSuctionEvent :" .. GetGlobal("MechStage2Paint")) .. " in trigger ") .. MechSuctionTrigger) .. " Direction ") .. direction))
  if (GetGlobal("MechStage2Paint") ~= 1) then
    if (1 <= MechSuctionTrigger) then
      if (MechCloseTriggerUsed == false) then
        MechCloseTriggerUsed = true
        PM_SetVacuumState(PrescottMechEntity)
      end
    end
  end
  return 
end
Mech_SucktionEventSpawnJunk = function(target)
  while true do
    if (not (MechCurrentlySucking == true)) then
      break
    end
    local (for index), (for limit), (for step) = 1, 5, 1
    for i = (for index), (for limit), (for step) do
      ForceSpawn(("SuctionDebrisSpawner" .. i), 1)
      wait(0.5)
    end
    wait(0.5)
  end
  return 
end
Mech_SuctionItemImpulse = function(target)
  ApplyImpulse(target, 0, 900, 0)
  return 
end
Mech_SuctionItemImpulse2 = function(target)
  local (for index), (for limit), (for step) = 1, 100, 1
  for i = (for index), (for limit), (for step) do
    if (MechCurrentlySucking == false) then
      return 
    end
    ApplyImpulse(target, -100, (math.random() * 100), (math.random(-1, 1) * 40))
    wait(0.10000000149011612)
  end
  return 
end
Mech_DeactivateProjectors = function()
  Print("Mech_DeactivateProjectors : Deactivating the projectors")
  Prefab_Projector_ChangeState("ThinnerEntrance", "Deactivate")
  Prefab_Projector_ChangeState("PaintEntrance", "Deactivate")
  Prefab_Projector_ChangeState("OstownProjectorMarker", "Deactivate")
  return 
end
Mech_WhereAMI = function(target, value)
  Mech_OhHereIAm = value
  return 
end
Mech_Outside_KillAIAndRescuePlayer = function(_activator)
  KillAIAndRescuePlayer(_activator)
  if (GetHealth(_activator) == 0) then
    FreezeCamera(_activator)
  end
  while true do
    if (not (GetHealth(_activator) == 0)) then
      break
    end
    wait(0)
  end
  if (LevelManager_GetCurrentState() == "ftl_prescottsarena.outside") then
    Print("Mech_Outside_KillAIAndRescuePlayer: in the first fight, setting the boss cam")
    Mech_CamChangeForFight()
    return 
  end
  if (Mech_OhHereIAm == "Nowhere") then
    return 
  end
  if (_activator == GetPlayer()) then
    if (_activator == GetPlayer()) then
      SetCameraAttributesForPlayer((Mech_OhHereIAm .. "RescueCamMickey"), _activator)
    else
      SetCameraAttributesForPlayer((Mech_OhHereIAm .. "RescueCamOswald"), _activator)
    end
    FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, _activator)
  end
  return 
end
