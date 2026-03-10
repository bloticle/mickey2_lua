blotworxDragon_DORMANT = 0
blotworxDragon_STAGE1 = 1
blotworxDragon_STAGE2 = 2
blotworxDragon_PRECLIMB = 3
blotworxDragon_CLIMB = 4
blotworxDragon_STAGE3 = 5
blotworxDragon_END = 6
blotworxDragon_NOSPATTER = 0
blotworxDragon_TAILSPATTER = 1
blotworxDragon_CHESTSPATTER = 2
blotworxDragon_HEADSPATTER = 3
blotworxDragon_S1_MAXARMORPIECES = 9
blotworxDragon_S1_MINARMORPIECES = -9
blotworxDragon_S2_MAXARMORPIECES = 5
blotworxDragon_S2_MINARMORPIECES = -7
blotworxDragon_S3_MAXARMORPIECES = 13
blotworxDragon_S3_MINARMORPIECES = -25
blotworxDragon_HITTYPE_PAINT = 0
blotworxDragon_HITTYPE_THINNER = 1
blotworxDragon_NO_ROUTE = 1
blotworxDragon_THINNER_ROUTE = 1
blotworxDragon_PAINTER_ROUTE = 2
blotworxDragon_DRAGONCHARACTER = "BlotworxDragon"
blotworxDragonPlayStyle = 0
StartsInactive = "False"
blotworxDragonLastSpatterKilled = blotworxDragon_NOSPATTER
blotworxDragonCurrentSpatter = blotworxDragon_NOSPATTER
blotworxDragonStageNum = blotworxDragon_DORMANT
blotworxDragonShowRockfall = false
blotworxDragonIsSpatterHit = false
blotworxDragonHitTimer = 0
blotworxDragonChamberFloorArray = {false, false, false, false, false, false, false, false, false, false, false, false}
blotworxDragonIsAbleToSlam = true
blotworxDragonIsAbleToSpin = true
blotworxDragonHasAlreadyRevealedHeadSpatter = false
blotworxDragonBoulderSpawnCount = 0
blotworxDragonBoulderSpawnCamShake = false
blotworxDragonArmorPaintedCounter = 0
blotworxDragonArmorPaintedMaxOrMin = false
blotworxDragonEnemySpawnLimit = 10
blotworxDragonRouteTaken = blotworxDragon_NO_ROUTE
blotworxDragonShouldNoticePaintStatusChange = true
blotworxDragonMickeyDeathCheck = false
blotworxDragonMickeyHealthCheckTimer = 1
blotworxDragonLastSavedCheckpoint = 0
blotworxDragonLowerBouldersDropping = false
blotworxDragonElectroShockLimit = 4
blotworxDragonElectroShockCooldown = 6
blotworxDragonElectroShockTimerLimit = 1
blotworxDragonElectroShockCounter = 0
blotworxDragonElectroShockTimer = 0
blotworxDragonCanBeElectroShocked = true
blotworxDragonElectricShockChanceAddition = 0.10000000149011612
blotworxDragonElectricShockChance = 0
blotworxDragonOswaldNodeFailureCounter = 0
blotworxDragonOswaldReachedNextNode = true
blotworxDragonOswaldHackSpawnerControl = 1
blotworxDragonOswaldHalt = true
blotworxDragonJiminySkip = false
blotworxDragonEndingChosen = blotworxDragon_NO_ROUTE
blotworxDragonCutsceneActive = false
blotworxDragon_ArmAttackStage1 = 1
blotworxDragon_ArmAttackStage3 = 2
blotworxDragon_TailAttack = 3
blotworxDragon_TailSpinAttack = 4
blotworxDragon_BoulderAttack = 5
blotworxDragon_BreatheStage1 = 6
blotworxDragon_BreatheStage2 = 7
blotworxDragon_BreatheStage3 = 8
blotworxDragon_BreatheBespoke = 9
blotworxDragon_FireOnceLocal = 0
blotworxDragon_GameType = "first"
blotworxDragonEnemySpawner1Enabled = true
blotworxDragonEnemySpawner2Enabled = true
blotworxDragonEnemySpawner3Enabled = true
LavaStage = 0
BlotworxDragon_BossWin = 0
BlotworxDragonSecondVisitSetup = 0
blotworxDragon_ThinnerTopStarted = false
if (GetGlobal("BWDragon_MusicState") == 0) then
  ReplaceMusicStateOverride("Boss_Intro")
  print("First time playing level, start intro music state")
else
  print("BWDragon_MusicState does not equal 0, let checkpoint functions pick music state")
end
AudioEffectStart("ftl_blotworxdragon_01a_main_audio.Sound_reverb")
CameraSetValueMickey = 0
CameraSetValueOswald = 0
ClearOverridesAndLoadLevel = function(levelName)
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  LoadLevel(GetPlayer(), levelName)
  return 
end
Blotworx_CameraHandleScriptMickey = function(target, camera)
  if (CameraSetValueMickey == 0) then
    CameraSetValueMickey = 1
    ClearCameraAttributes("Stage1Cam")
  end
  SetCameraAttributesForPlayer("Stage1Cam", target)
  return 
end
Blotworx_CameraHandleScriptOswald = function(target, camera)
  if (CameraSetValueOswald == 0) then
    CameraSetValueOswald = 1
    ClearCameraAttributes("Stage1Cam")
  end
  SetCameraAttributesForPlayer("Stage1Cam", target)
  return 
end
Blotworx_RezPositionChange1 = function()
  TeleportToEntity("RezSpawnPoint", "RezSpawnPosition2")
  OverrideSpawnTransform(PLAYER_ONE, GetPosition("MickeyStage1StartMarker"), GetFacing("MickeyStage1StartMarker"))
  OverrideSpawnTransform(PLAYER_TWO, GetPosition("OswaldStage1StartMarker"), GetFacing("OswaldStage1StartMarker"))
  return 
end
Blotworx_RezPositionChange2 = function()
  TeleportToEntity("RezSpawnPoint", "RezSpawnPosition1")
  OverrideSpawnTransform(PLAYER_ONE, GetPosition("MickeyStage1StartMarker"), GetFacing("MickeyStage1StartMarker"))
  OverrideSpawnTransform(PLAYER_TWO, GetPosition("OswaldStage1StartMarker"), GetFacing("OswaldStage1StartMarker"))
  return 
end
BlotworxDragonResetCameraAttributesForPlayerOnRevive = function(target, event, instigator)
  local subEvent = ReviveEvent_GetSubEvent(event)
  if (subEvent == ReviveEvent_Respawn) then
    ClearCameraAttributesForPlayer(target, instigator)
    SetCameraAttributesForPlayer(target, instigator)
  end
  return 
end
FTL_BlotworxDragon_HaltOswaldActivity = function(bShouldHalt)
  PrintLuaStack("[TMStack]")
  blotworxDragonOswaldHalt = bShouldHalt
  return 
end
FTL_BlotworxDragon_OswaldReachedPathNode = function()
  blotworxDragonOswaldReachedNextNode = true
  return 
end
FTL_BlotworxDragon_Arcade_DragonSetup = function()
  print("###### Arcade_DragonSetup")
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    SetGlobal("MSN_Arcade_FromArcade", 1)
  end
  for i = 1, 3 do
    SetGlobal(("FTL_BlotworxDragon_ReprogramSpot" .. i), 0)
    Reprogram_Difficulty_Setting(("HackPoint" .. i))
  end
  return 
end
FTL_BlotworxDragon_OswaldActivity = function()
  while true do
    while true do
      if (blotworxDragonStageNum < blotworxDragon_END) then
        if (blotworxDragonStageNum == blotworxDragon_STAGE1) then
          if (blotworxDragonOswaldHalt == false) then
            if blotworxDragonOswaldReachedNextNode then
              local shouldShock = math.random()
              if (blotworxDragonElectricShockChance <= shouldShock) then
                local chamberFloorIndex = math.random(1, 6)
                OswaldSetPathAction(("ChamberFloorPatrolNode" .. chamberFloorIndex))
                blotworxDragonOswaldReachedNextNode = false
                blotworxDragonElectricShockChance = (blotworxDragonElectricShockChance + blotworxDragonElectricShockChanceAddition)
              else
                OswaldStreamAction("DragonCollisionHead", 0.699999988079071)
                blotworxDragonElectricShockChance = 0
                if (blotworxDragonStageNum == blotworxDragon_STAGE3) then
                  if (blotworxDragonOswaldHalt == false) then
                    if (blotworxDragonOswaldHackSpawnerControl < 4) then
                      if ((blotworxDragonOswaldHackSpawnerControl * 3) <= blotworxDragonArmorPaintedCounter) then
                        while true do
                          if (GetPropertyBool(("HackPoint" .. blotworxDragonOswaldHackSpawnerControl), "Is Painted") == true) then
                            while true do
                              if (not (5 < GetXZDistanceSquaredBetweenEntities(GetPlayer2OrAI(), (("HackPoint" .. blotworxDragonOswaldHackSpawnerControl) .. "PatrolNode")))) then
                                break
                              end
                              Wait(3)
                              OswaldSetPathAction((("HackPoint" .. blotworxDragonOswaldHackSpawnerControl) .. "PatrolNode"))
                            end
                            if (GetPropertyBool(("HackPoint" .. blotworxDragonOswaldHackSpawnerControl), "Is Painted") == true) then
                              OswaldHackAction(("HackPoint" .. blotworxDragonOswaldHackSpawnerControl))
                            else
                              FireSequence("ConversationOswald", "FTL_BlotworxDragon_Oswald_RepaintReprogram")
                            end
                            Wait(6)
                          end
                          wait(3)
                        end
                        blotworxDragonOswaldHackSpawnerControl = (blotworxDragonOswaldHackSpawnerControl + 1)
                      end
                    else
                      OswaldStartFighting()
                    end
                  end
                end
              end
            end
          elseif (blotworxDragonStageNum == blotworxDragon_STAGE3) then
            if (blotworxDragonOswaldHalt == false) then
              if (blotworxDragonOswaldHackSpawnerControl < 4) then
                if ((blotworxDragonOswaldHackSpawnerControl * 3) <= blotworxDragonArmorPaintedCounter) then
                  while true do
                    if (GetPropertyBool(("HackPoint" .. blotworxDragonOswaldHackSpawnerControl), "Is Painted") == true) then
                      while true do
                        if (not (5 < GetXZDistanceSquaredBetweenEntities(GetPlayer2OrAI(), (("HackPoint" .. blotworxDragonOswaldHackSpawnerControl) .. "PatrolNode")))) then
                          break
                        end
                        Wait(3)
                        OswaldSetPathAction((("HackPoint" .. blotworxDragonOswaldHackSpawnerControl) .. "PatrolNode"))
                      end
                      if (GetPropertyBool(("HackPoint" .. blotworxDragonOswaldHackSpawnerControl), "Is Painted") == true) then
                        OswaldHackAction(("HackPoint" .. blotworxDragonOswaldHackSpawnerControl))
                      else
                        FireSequence("ConversationOswald", "FTL_BlotworxDragon_Oswald_RepaintReprogram")
                      end
                      Wait(6)
                    end
                    wait(3)
                  end
                  blotworxDragonOswaldHackSpawnerControl = (blotworxDragonOswaldHackSpawnerControl + 1)
                end
              else
                OswaldStartFighting()
              end
            end
          end
        end
        if (blotworxDragonStageNum == blotworxDragon_STAGE3) then
          if (blotworxDragonOswaldHalt == false) then
            if (blotworxDragonOswaldHackSpawnerControl < 4) then
              if ((blotworxDragonOswaldHackSpawnerControl * 3) <= blotworxDragonArmorPaintedCounter) then
                while true do
                  if (GetPropertyBool(("HackPoint" .. blotworxDragonOswaldHackSpawnerControl), "Is Painted") == true) then
                    while true do
                      if (not (5 < GetXZDistanceSquaredBetweenEntities(GetPlayer2OrAI(), (("HackPoint" .. blotworxDragonOswaldHackSpawnerControl) .. "PatrolNode")))) then
                        break
                      end
                      Wait(3)
                      OswaldSetPathAction((("HackPoint" .. blotworxDragonOswaldHackSpawnerControl) .. "PatrolNode"))
                    end
                    if (GetPropertyBool(("HackPoint" .. blotworxDragonOswaldHackSpawnerControl), "Is Painted") == true) then
                      OswaldHackAction(("HackPoint" .. blotworxDragonOswaldHackSpawnerControl))
                    else
                      FireSequence("ConversationOswald", "FTL_BlotworxDragon_Oswald_RepaintReprogram")
                    end
                    Wait(6)
                  end
                  wait(3)
                end
                blotworxDragonOswaldHackSpawnerControl = (blotworxDragonOswaldHackSpawnerControl + 1)
              end
            else
              OswaldStartFighting()
            end
          end
        end
        Wait(1)
        blotworxDragonOswaldNodeFailureCounter = (blotworxDragonOswaldNodeFailureCounter + 1)
      end
    end
    blotworxDragonOswaldReachedNextNode = true
    blotworxDragonOswaldNodeFailureCounter = 0
  end
  return 
end
FTL_BlotworxDragon_OnStimulus = function(_self, _event)
  local validStimTypes = {ST_FAIRY, ST_KNOCKBACK}
  local alias = StimulusEvent_SourceStimulusAlias(_event)
  Boss_SendStimulus(_self, validStimTypes, _event, blotworxDragon_DRAGONCHARACTER, 20)
  if blotworxDragonCanBeElectroShocked then
    blotworxDragonCanBeElectroShocked = false
    if StimulusEvent_HasStimulusType(_event, ST_ELECTRIC) then
      blotworxDragonElectroShockTimer = blotworxDragonElectroShockTimerLimit
      if (blotworxDragonElectroShockCounter == 0) then
        FireThread(FTL_BlotworxDragon_ShockTimer)
      end
      blotworxDragonElectroShockCounter = (blotworxDragonElectroShockCounter + 1)
      if (blotworxDragonElectroShockLimit <= blotworxDragonElectroShockCounter) then
        blotworxDragonElectroShockTimer = 0
        blotworxDragonElectroShockCounter = 0
        local oswaldAIEntity = GetPlayer2OrAI()
        if (oswaldAIEntity ~= nil) then
          BlotworxDragon_SetAttackTarget(blotworxDragon_DRAGONCHARACTER, oswaldAIEntity)
        end
        Wait(blotworxDragonElectroShockCooldown)
        local playerEntity = GetPlayer()
        if (playerEntity ~= nil) then
          BlotworxDragon_SetAttackTarget(blotworxDragon_DRAGONCHARACTER, playerEntity)
        end
      end
    end
    blotworxDragonCanBeElectroShocked = true
  end
  return 
end
FTL_BlotworxDragon_SpatterHit = function(_self, _event, counter)
  if StimulusEvent_HasStimulusType(_event, ST_PAINT) then
    if (StimulusEvent_SourceStimulusAlias(_event) == "Guardian") then
      if (counter == "head") then
        CounterAdd("HeadSpatterPaintLogicCounter", 100)
      elseif (counter == "chest") then
        CounterAdd("ChestSpatterPaintLogicCounter", 100)
      elseif (counter == "tail") then
        CounterAdd("TailSpatterPaintLogicCounter", 100)
        if StimulusEvent_HasStimulusType(_event, ST_THINNER) then
          if (StimulusEvent_SourceStimulusAlias(_event) == "Guardian") then
            if (counter == "head") then
              CounterAdd("HeadSpatterThinLogicCounter", 100)
            elseif (counter == "chest") then
              CounterAdd("ChestSpatterThinLogicCounter", 100)
            elseif (counter == "tail") then
              CounterAdd("TailSpatterThinLogicCounter", 100)
            end
          end
        end
      end
    end
  elseif StimulusEvent_HasStimulusType(_event, ST_THINNER) then
    if (StimulusEvent_SourceStimulusAlias(_event) == "Guardian") then
      if (counter == "head") then
        CounterAdd("HeadSpatterThinLogicCounter", 100)
      elseif (counter == "chest") then
        CounterAdd("ChestSpatterThinLogicCounter", 100)
      elseif (counter == "tail") then
        CounterAdd("TailSpatterThinLogicCounter", 100)
      end
    end
  end
  return 
end
FTL_BlotworxDragon_ShockTimer = function()
  while true do
    if (not (0 < blotworxDragonElectroShockTimer)) then
      break
    end
    wait(0.25)
    blotworxDragonElectroShockTimer = (blotworxDragonElectroShockTimer - 0.25)
  end
  blotworxDragonElectroShockCounter = 0
  return 
end
FTL_BlotworxDragon_OnAnimEvent = function(_self, _event)
  local eventType = AnimEvent_Type(_event)
  if (eventType == EVENT_HopperFall01) then
    StartEmitters("CeilingDust01")
    Wait(1)
    StopEmitters("CeilingDust01")
  elseif (eventType == EVENT_HopperFall02) then
    StartEmitters("CeilingDust02")
    Wait(1)
    StopEmitters("CeilingDust02")
  elseif (eventType == EVENT_HopperFall03) then
    StartEmitters("CeilingDust03")
    Wait(1)
    StopEmitters("CeilingDust03")
  elseif (eventType == EVENT_AttackStrike) then
    Hide("DragonLeftHand")
    Hide("DragonRightHand")
    Enable("DragonAttackLeftHandTriggerObject")
    Enable("DragonAttackRightHandTriggerObject")
    wait(2.0999999046325684)
    Unhide("DragonLeftHand")
    Unhide("DragonRightHand")
    Disable("DragonAttackRightHandTriggerObject")
    Disable("DragonAttackLeftHandTriggerObject")
  end
  return 
end
BlotworxDragon_RedChestSave = function()
  SaveCheckpoint(GetPlayer(), LastCheckpointLoadFunction, LastCheckpointPos_Mickey, LastCheckpointPos_Oswald)
  return 
end
BlotworxDragon_AddToGuardianTargetEntityListFLIP = function(entity)
  BlotworxDragon_AddToGuardianTargetEntityList(blotworxDragon_DRAGONCHARACTER, entity)
  BlotworxDragon_SetGuardianPriorityToEntities(blotworxDragon_DRAGONCHARACTER)
  return 
end
BlotworxDragon_AddToGuardianTargetToonListFLIP = function(entity)
  BlotworxDragon_AddToGuardianTargetToonList(blotworxDragon_DRAGONCHARACTER, entity)
  BlotworxDragon_SetGuardianPriorityToToon(blotworxDragon_DRAGONCHARACTER)
  return 
end
BlotworxDragon_ClearGuardianMasterFunc = function()
  BlotworxDragon_ClearGuardianTargetEntityList(blotworxDragon_DRAGONCHARACTER)
  BlotworxDragon_ClearGuardianTargetToonList(blotworxDragon_DRAGONCHARACTER)
  return 
end
SkipToStage1 = function()
  blotworxDragonStageNum = blotworxDragon_STAGE1
  TeleportToEntity(GetPlayer(), "MickeyStage1StartMarker")
  TeleportToEntity(GetPlayer2OrAI(), "OswaldStage1StartMarker")
  AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_JumpToStage1)
  BlotworxDragon_StartStage1(blotworxDragon_DRAGONCHARACTER)
  SetCameraAttributesForPlayer("Stage1Cam")
  BlotworxDragon_SetAttackTarget(blotworxDragon_DRAGONCHARACTER, GetPlayer())
  return 
end
SkipToStage2 = function()
  blotworxDragonStageNum = blotworxDragon_STAGE2
  TeleportToEntity(GetPlayer(), "MickeyStage1StartMarker")
  TeleportToEntity(GetPlayer2OrAI(), "OswaldStage1StartMarker")
  AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_JumpToStage2)
  BlotworxDragon_StartStage2(blotworxDragon_DRAGONCHARACTER)
  SetCameraAttributesForPlayer("Stage1Cam")
  BlotworxDragon_SetAttackTarget(blotworxDragon_DRAGONCHARACTER, GetPlayer())
  blotworxDragonStageNum = blotworxDragon_STAGE1
  return 
end
SkipToStage3 = function()
  blotworxDragonStageNum = blotworxDragon_STAGE3
  TeleportToEntity(GetPlayer(), "Stage3Marker")
  wait(0.5)
  OswaldTeleportToMickeyAction()
  AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_JumpToStage3)
  BlotworxDragon_StartStage3(blotworxDragon_DRAGONCHARACTER)
  BlotworxDragon_SetAttackTarget(blotworxDragon_DRAGONCHARACTER, GetPlayer())
  FTL_BlotworxDragon_RaiseLava2()
  Enable("Stage3TriggerBoulderSmash")
  return 
end
FTL_BlotworxDragon_SecretPlatformArrived = function()
  ClearAllCameraAttributes()
  BlotworxDragon_SetPlayerOnSecretPlatform(blotworxDragon_DRAGONCHARACTER, true)
  print("music - reveal secret platform")
  return 
end
FTL_BlotworxDragon_SecretPlatformLeft = function()
  BlotworxDragon_SetPlayerOnSecretPlatform(blotworxDragon_DRAGONCHARACTER, false)
  return 
end
FTL_BlotworxDragon_SetUpStageArmor = function(stage)
  blotworxDragonShouldNoticePaintStatusChange = false
  if (stage == blotworxDragon_STAGE1) then
    ForEachEntityInGroup(ForcePainted, "BlotworxDragonStage1PiecesRight")
    ForEachEntityInGroup(ForceSketched, "BlotworxDragonStage1PiecesLeft")
    ForEachEntityInGroup(ForcePainted, "BlotworxDragonStage2PiecesRight")
    ForEachEntityInGroup(ForceSketched, "BlotworxDragonStage2PiecesLeft")
  elseif (stage == blotworxDragon_STAGE2) then
    ForEachEntityInGroup(ForcePainted, "BlotworxDragonStage2PiecesRight")
    ForEachEntityInGroup(ForceSketched, "BlotworxDragonStage2PiecesLeft")
  elseif (stage == blotworxDragon_PRECLIMB) then
    if (blotworxDragonRouteTaken == blotworxDragon_THINNER_ROUTE) then
      ForEachEntityInGroup(ForceSketched, "BlotworxDragonStage2PiecesRight")
      ForEachEntityInGroup(ForceSketched, "BlotworxDragonStage2PiecesLeft")
    else
      ForEachEntityInGroup(ForcePainted, "BlotworxDragonStage2PiecesRight")
      ForEachEntityInGroup(ForcePainted, "BlotworxDragonStage2PiecesLeft")
      if (stage == blotworxDragon_STAGE3) then
        ForEachEntityInGroup(ForceSketched, "BlotworxDragonArmorPiecesRight")
        ForEachEntityInGroup(ForceSketched, "BlotworxDragonArmorPiecesLeft")
      end
    end
  elseif (stage == blotworxDragon_STAGE3) then
    ForEachEntityInGroup(ForceSketched, "BlotworxDragonArmorPiecesRight")
    ForEachEntityInGroup(ForceSketched, "BlotworxDragonArmorPiecesLeft")
  end
  wait(2)
  blotworxDragonArmorPaintedCounter = 0
  blotworxDragonArmorPaintedMaxOrMin = false
  blotworxDragonShouldNoticePaintStatusChange = true
  return 
end
FTL_BlotworxDragon_HideThinned = function(entity)
  if (not GetPropertyBool(entity, "Is Painted")) then
    Hide(entity)
  end
  return 
end
FTL_BlotworxDragon_ShowThinned = function(entity)
  if (not GetPropertyBool(entity, "Is Painted")) then
    Unhide(entity)
  end
  return 
end
FTL_BlotworxDragon_OnBoulderSpawned = function(spawner)
  local boulderDropsPerVolley = GetConfigVariableFloat("BEH_BlotworxDragon_Default_Stage3BoulderDropsPerVolley")
  blotworxDragonBoulderSpawnCount = (blotworxDragonBoulderSpawnCount + 1)
  if (not blotworxDragonBoulderSpawnCamShake) then
    blotworxDragonBoulderSpawnCamShake = true
    ShakeCamera(3, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
    AudioPostEventOn(GetPlayer(), "Play_sfx_rumble_small")
  end
  if (boulderDropsPerVolley <= blotworxDragonBoulderSpawnCount) then
    local boulderWaitBetweenVolleys = GetConfigVariableFloat("BEH_BlotworxDragon_Default_Stage3BoulderWaitbetweenVolleys")
    blotworxDragonBoulderSpawnCount = 0
    blotworxDragonBoulderSpawnCamShake = false
    Disable(spawner)
    wait(boulderWaitBetweenVolleys)
    if (not (not BlotworxDragon_IsBoulderFallOccuring(blotworxDragon_DRAGONCHARACTER))) then
      Enable(spawner)
    end
  end
  return 
end
FTL_BlotworxDragon_OnDragonSpawn = function()
  print("Set the dragon shooter and shadow entities")
  BlotworxDragon_SetShooterEntity(blotworxDragon_DRAGONCHARACTER, "DragonShooter")
  BlotworxDragon_SetSpawnerEntity(blotworxDragon_DRAGONCHARACTER, "DragonBoulderSpawner")
  wait(3)
  ForEachEntityInGroup(Hide, "ArmorTargetMarker")
  ForEachEntityInGroup(Unhide, "ArmorTargetMarkerToon")
  AnimGBSequence("MainArena", "PULSE")
  StopEmitters("SpawnerExplodes1")
  StopEmitters("SpawnerExplodes2")
  StopEmitters("SpawnerExplodes3")
  return 
end
FTL_BlotworxDragon_EnableLowerBouldersDropping = function(IsEnabled)
  blotworxDragonLowerBouldersDropping = IsEnabled
  if (blotworxDragonLowerBouldersDropping == true) then
    ForEachEntityInGroup(Enable, "DragonBoulderSpawnerLower")
  else
    ForEachEntityInGroup(Disable, "DragonBoulderSpawnerLower")
  end
  FTL_BlotworxDragon_Speech_Gus009()
  return 
end
SetCameraAttributesForBothPlayers = function(camera)
  local playerHandle = GetPlayer()
  if IsValidHandle(playerHandle) then
    SetCameraAttributes(camera)
  end
  local oswaldHandle = GetPlayer2()
  if IsValidHandle(oswaldHandle) then
    SetCameraAttributesForPlayer(camera, oswaldHandle)
  end
  return 
end
FTL_BlotworxDragon_RaiseLava1 = function()
  if (blotworxDragon_GameType ~= "second") then
    SetSplineFollowerInitialSpeed("LavaPlane", 0.10000000149011612)
    SplineFollower_TeleportToKnot("LavaPlane", "LavaSpline1")
    SplineFollower_StopAtPosition("LavaPlane", "LavaSpline1", "LavaSpline2", 1)
  end
  return 
end
FTL_BlotworxDragon_RaiseLava2 = function()
  if (blotworxDragon_GameType ~= "second") then
    SetSplineFollowerInitialSpeed("LavaPlane", 2)
    SplineFollower_TeleportToKnot("LavaPlane", "LavaSpline2")
    SplineFollower_StopAtPosition("LavaPlane", "LavaSpline2", "LavaSpline3", 1)
    print("Music - raise lava 2")
  end
  return 
end
FTL_BlotworxDragon_RaiseLava2x = function()
  if (blotworxDragon_GameType ~= "second") then
    SetSplineFollowerInitialSpeed("LavaPlane", 0.30000001192092896)
    SplineFollower_StopAtPosition("LavaPlane", "LavaSpline1", "LavaSpline3", 1)
    print("Music - starting stage 3 music from Wwise event, but sould also start it here")
  end
  return 
end
FTL_BlotworxDragon_StartStage1 = function()
  ObservatoryItem_Activate("FTL_BlotworxDragon_Gus_ObservatoryItem", "4")
  FTL_BlotworxDragon_EnableCollision_Outer()
  AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_JumpToStage1)
  Wait(1.5)
  Hide("SteppingStone")
  local JiminyChest = GetEntity("JiminyChest")
  if (JiminyChest ~= nil) then
    DestroyEntity(JiminyChest)
  end
  Unhide("MainEntranceDoor")
  Hide("SubSteppingStone")
  Unhide("SubEntranceDoor")
  TeleportToEntity(GetPlayer(), "MickeyStage1StartMarker")
  TeleportToEntity(GetPlayer2OrAI(), "OswaldStage1StartMarker")
  ClearCameraAttributesForPlayer("Stage1Cam")
  SetCameraAttributesForPlayer("Stage1Cam")
  ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
  SetCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
  local spatterCollision = GetChildEntityByName(blotworxDragon_DRAGONCHARACTER, "DragonCollisionHeadSpatter")
  Hide(spatterCollision)
  StartFadeIn(0.800000011920929)
  wait(0.800000011920929)
  ShowHud()
  wait(0.25)
  ShowReticleOnly()
  FTL_BlotworxDragon_1_SaveCheckpoint()
  BlotworxDragon_StartStage1(blotworxDragon_DRAGONCHARACTER)
  FTL_BlotworxDragon_SetUpStageArmor(blotworxDragon_STAGE1)
  blotworxDragonStageNum = blotworxDragon_STAGE1
  FireThread(FTL_BlotworxDragon_OswaldActivity)
  wait(5)
  FTL_BlotworxDragon_Speech_Gus001()
  Enable("DragonBoulderSpawnerLower2")
  wait(5)
  FTL_BlotworxDragon_HaltOswaldActivity(false)
  return 
end
FTL_BlotworxDragon_Stage2StartCam = function()
  FTL_BlotworxDragon_EnableLowerBouldersDropping(false)
  SetHeading(blotworxDragon_DRAGONCHARACTER, 0)
  wait(0.10999999940395355)
  if (0 < blotworxDragonPlayStyle) then
    BlotworxDragon_StartStunnedState(blotworxDragon_DRAGONCHARACTER, EVENT_ToStage2Positive)
  elseif (blotworxDragonPlayStyle < 0) then
    BlotworxDragon_StartStunnedState(blotworxDragon_DRAGONCHARACTER, EVENT_ToStage2Negative)
  end
  return 
end
FTL_BlotworxDragon_Stage2EndCam = function()
  ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
  wait(1)
  FTL_BlotworxDragon_2_SaveCheckpoint()
  local playerHandle = GetPlayer()
  if IsValidHandle(playerHandle) then
    SetCameraAttributesForPlayer("Stage1Cam", playerHandle)
  end
  BlotworxDragon_StartStage2(blotworxDragon_DRAGONCHARACTER)
  ClearCameraAttributesForPlayer("Stage1Cam")
  SetCameraAttributesForPlayer("Stage1Cam")
  return 
end
FTL_BlotworxDragon_StartStage2Thinner = function()
  FTL_BlotworxDragon_KillHeadSpatter()
  ClearCameraAttributes("HeadSpatterCam")
  if (blotworxDragonStageNum == blotworxDragon_STAGE1) then
    StartFadeOut(0.33000001311302185)
    Wait(0.33000001311302185)
    blotworxDragonStageNum = blotworxDragon_STAGE2
    FTL_BlotworxDragon_SetUpStageArmor(blotworxDragon_STAGE2)
    blotworxDragonPlayStyle = (blotworxDragonPlayStyle - 1)
    AudioPostEventOn(GetPlayer(), "Set_State_MX_BossDragon_HeadSpatterDeath_Thinner")
    print("Music - head spatter death IGC thinner - start stage 2 music")
    PlayIGC("IGC_0170b_SpatterInHead_ResolveThinner")
    wait(0.5)
    FireThread(FTL_BlotworxDragon_Stage2StartCam)
    Enable("DragonBoulderSpawnerLower2")
    wait(5)
    FTL_BlotworxDragon_HaltOswaldActivity(false)
  end
  return 
end
PostIGC_0170b_SpatterInHead_ResolveThinner = function()
  FireThread(FTL_BlotworxDragon_Stage2EndCam)
  BlotworxDragon_ClearGuardianMasterFunc()
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage2PiecesLeft")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage2PiecesRight")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, " BlotworxDragonStage2Pieces")
  return 
end
FTL_BlotworxDragon_StartStage2Painter = function()
  FTL_BlotworxDragon_KillHeadSpatter()
  ClearCameraAttributes("HeadSpatterCam")
  if (blotworxDragonStageNum == blotworxDragon_STAGE1) then
    StartFadeOut(0.33000001311302185)
    Wait(0.33000001311302185)
    blotworxDragonStageNum = blotworxDragon_STAGE2
    FTL_BlotworxDragon_SetUpStageArmor(blotworxDragon_STAGE2)
    blotworxDragonPlayStyle = (blotworxDragonPlayStyle + 1)
    AudioPostEventOn(GetPlayer(), "Set_State_MX_BossDragon_HeadSpatterDeath_Paint")
    print("Music - head spatter death IGC paint - start stage 2 music")
    PlayIGC("IGC_0170a_SpatterInHead_ResolvePaint")
    wait(0.5)
    FireThread(FTL_BlotworxDragon_Stage2StartCam)
    Enable("DragonBoulderSpawnerLower2")
    wait(5)
    FTL_BlotworxDragon_HaltOswaldActivity(false)
  end
  return 
end
PostIGC_0170a_SpatterInHead_ResolvePaint = function()
  BlotworxDragon_ClearGuardianMasterFunc()
  FireThread(FTL_BlotworxDragon_Stage2EndCam)
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage2PiecesLeft")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage2PiecesRight")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, " BlotworxDragonStage2Pieces")
  return 
end
FTL_BlotworxDragon_StartClimbUpThinner = function()
  if (blotworxDragonStageNum == blotworxDragon_STAGE2) then
    StartFadeOut(0.33000001311302185)
    Wait(0.33000001311302185)
    FTL_BlotworxDragon_HaltOswaldActivity(true)
    blotworxDragonStageNum = blotworxDragon_PRECLIMB
    blotworxDragonPlayStyle = (blotworxDragonPlayStyle - 1)
    BlotworxDragon_SetSprayEffectsEnabled(blotworxDragon_DRAGONCHARACTER, false)
    AudioPostEventOn(GetPlayer(), "Set_State_MX_BossDragon_TailSpatterDeath_Thinner")
    print("Music - tail spatter death IGC (thinner) - start stage 3 music ")
    PlayIGC("IGC_0175b_SpatterInBack_ResolveThinner")
    wait(0.5)
    AnimGBSequence("SideThinnerPathPlatform", "Move", true)
    FireThread(FTL_BlotworxDragon_StartClimbUpThinnerCam)
    FTL_BlotworxDragon_DisableCollision_Outer()
  end
  wait(4)
  FTL_BlotworxDragon_Speech_Gus004()
  return 
end
PostIGC_0175b_SpatterInBack_ResolveThinner = function()
  FireThread(FTL_BlotworxDragon_EndClimbUpThinnerCam)
  ForEachEntityInGroup(DestroyEntity, "Stage1RespawnCam")
  ForEachEntityInGroup(DestroyEntity, "MickeyStage1StartMarker")
  ForEachEntityInGroup(DestroyEntity, "OswaldStage1StartMarker")
  OswaldStartFollowAction()
  BlotworxDragon_ClearGuardianMasterFunc()
  return 
end
FTL_BlotworxDragon_StartClimbUpThinnerCam = function()
  BlotworxDragon_StartPreClimbStage(blotworxDragon_DRAGONCHARACTER)
  SetHeading(blotworxDragon_DRAGONCHARACTER, 0)
  wait(0.10999999940395355)
  FTL_Player_TeleportAway_Thin()
  FTL_BlotworxDragon_KillTailSpatter()
  AnimGBSequence("LowerPiping2", "collapse")
  ForEachEntityInGroup(AnimGBSequence, "ChamberFloor", "cutscene")
  BlotworxDragon_StartStunnedState(blotworxDragon_DRAGONCHARACTER, EVENT_ToStage3Negative)
  wait(2)
  ForEachEntityInGroup(SetRotatorMaxSpeed, "ChamberFloor", 1.5)
  ForEachEntityInGroup(StartRotateToPosition, "ChamberFloor", -6)
  wait(4)
  BlotworxDragon_SetSprayEffectsEnabled(blotworxDragon_DRAGONCHARACTER, true)
  Wait(1.5)
  BlotworxDragon_SetSprayEffectsEnabled(blotworxDragon_DRAGONCHARACTER, false)
  return 
end
FTL_BlotworxDragon_EndClimbUpThinnerCam = function()
  ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
  ClearAllCameraAttributes()
  CameraReset()
  ClearCameraAttributes("Stage1Cam")
  wait(1)
  ShakeCamera(2, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  AudioPostEventOn(GetPlayer(), "Play_sfx_lavarise")
  FTL_BlotworxDragon_RaiseLava1()
  FTL_BlotworxDragon_3_SaveCheckpoint()
  blotworxDragonRouteTaken = blotworxDragon_THINNER_ROUTE
  SetPropertyBool("ToonPiping", "ForceInvulnerable", false)
  wait(5)
  FTL_BlotworxDragon_RaiseLava2x()
  BlotWorxDragon_Lava_Stage1()
  FTL_BlotworxDragon_TriggerStage3b()
  return 
end
FTL_BlotworxDragon_StartClimbUpPainter = function()
  if (blotworxDragonStageNum == blotworxDragon_STAGE2) then
    StartFadeOut(0.33000001311302185)
    Wait(0.33000001311302185)
    FTL_BlotworxDragon_HaltOswaldActivity(true)
    blotworxDragonStageNum = blotworxDragon_PRECLIMB
    blotworxDragonPlayStyle = (blotworxDragonPlayStyle + 1)
    BlotworxDragon_SetSprayEffectsEnabled(blotworxDragon_DRAGONCHARACTER, false)
    AudioPostEventOn(GetPlayer(), "Set_State_MX_BossDragon_TailSpatterDeath_Paint")
    print("Music - tail spatter death IGC (paint) - start stage 3 music ")
    PlayIGC("IGC_0175a_SpatterInBack_ResolvePaint")
    wait(0.5)
    AnimGBSequence("SideThinnerPathPlatform", "Move", true)
    FireThread(FTL_BlotworxDragon_StartClimbUpPainterCam)
    FTL_BlotworxDragon_DisableCollision_Outer()
  end
  wait(4)
  FTL_BlotworxDragon_Speech_Gus004()
  return 
end
PostIGC_0175a_SpatterInBack_ResolvePaint = function()
  FireThread(FTL_BlotworxDragon_EndClimbUpPainterCam)
  ForEachEntityInGroup(DestroyEntity, "Stage1RespawnCam")
  ForEachEntityInGroup(DestroyEntity, "MickeyStage1StartMarker")
  ForEachEntityInGroup(DestroyEntity, "OswaldStage1StartMarker")
  OswaldStartFollowAction()
  BlotworxDragon_ClearGuardianMasterFunc()
  return 
end
FTL_BlotworxDragon_StartClimbUpPainterCam = function()
  BlotworxDragon_StartPreClimbStage(blotworxDragon_DRAGONCHARACTER)
  SetHeading(blotworxDragon_DRAGONCHARACTER, 0)
  wait(0.10999999940395355)
  FTL_Player_TeleportAway_Paint()
  FTL_BlotworxDragon_KillTailSpatter()
  AnimGBSequence("DestroyableWall", "Collapse")
  ForEachEntityInGroup(AnimGBSequence, "ChamberFloor", "cutscene")
  BlotworxDragon_StartStunnedState(blotworxDragon_DRAGONCHARACTER, EVENT_ToStage3_Positive)
  wait(2)
  ForEachEntityInGroup(SetRotatorMaxSpeed, "ChamberFloor", 1.5)
  ForEachEntityInGroup(StartRotateToPosition, "ChamberFloor", -6)
  return 
end
FTL_BlotworxDragon_EndClimbUpPainterCam = function()
  ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
  Hide("DestroyableWall")
  Unhide("GroundRubble1")
  ClearAllCameraAttributes()
  ClearCameraAttributes("Stage1Cam")
  ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer())
  ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
  CameraReset()
  wait(1)
  ShakeCamera(2, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  AudioPostEventOn(GetPlayer(), "Play_sfx_lavarise")
  FTL_BlotworxDragon_RaiseLava1()
  Enable("ThinStairsTrigger")
  BlotworxDragon_StartPreClimbStage(blotworxDragon_DRAGONCHARACTER)
  FTL_BlotworxDragon_4_SaveCheckpoint()
  blotworxDragonRouteTaken = blotworxDragon_PAINTER_ROUTE
  SetPropertyBool("ToonPiping", "ForceInvulnerable", false)
  OverrideSpawnTransform(PLAYER_ONE, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.PaintRouteSafety"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.PaintRouteSafety"))
  OverrideSpawnTransform(PLAYER_TWO, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.PaintRouteSafetyOswald"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.PaintRouteSafetyOswald"))
  OswaldStartFollowAction()
  ClearAllCameraAttributes()
  ClearCameraAttributes("Stage1Cam")
  ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer())
  ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
  return 
end
FTL_BlotworxDragon_ThinStairs = function()
  if (blotworxDragon_GameType ~= "second") then
    Disable("ThinStairsTrigger")
    BlotworxDragon_StartPaintClimbStage(blotworxDragon_DRAGONCHARACTER)
    AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_JumpToStage2_5_Pos)
    local dragonHeading = (GetHeading(blotworxDragon_DRAGONCHARACTER) * 57.3248405456543)
    while true do
      while true do
        wait(0.10000000149011612)
        dragonHeading = (GetHeading(blotworxDragon_DRAGONCHARACTER) * 57.3248405456543)
      end
    end
    BlotworxDragon_StartStunnedState(blotworxDragon_DRAGONCHARACTER, EVENT_Start_ThinStairs)
    Disable("DragonBoulderSpawnerLower2")
    wait(3.5999999046325684)
    BlotworxDragon_SetSprayEffectsEnabled(blotworxDragon_DRAGONCHARACTER, true)
    wait(1)
    wait(0.75)
    wait(0.75)
    ForceSketched("ToonStairway3")
    wait(0.5)
    ForceSketched("ToonStairway4")
    wait(0.5)
    ForceSketched("ToonStairway5")
    wait(0.5)
    BlotworxDragon_SetSprayEffectsEnabled(blotworxDragon_DRAGONCHARACTER, false)
    Wait(1)
    blotworxDragonStageNum = blotworxDragon_CLIMB
    blotworxDragonShowRockfall = true
    BlotworxDragon_StartPaintClimbStage(blotworxDragon_DRAGONCHARACTER)
  end
  return 
end
FTL_BlotworxDragon_ThinnerRoutePipingThinned = function()
  local animDuration = AnimGBSequenceGetSequenceDuration("ThinnerRoutePiping", "COLLAPSE")
  ForceSketched("ftl_blotworxdragon_01a_main.ToonPipe")
  ForEachEntityInGroup(StopEmitters, "SteamJetThinnerPath")
  Show("SteamJetThinnerPath_knockback")
  Disable("SteamJetThinnerPath_trigger")
  if (GetPropertyInt("ThinnerRoutePiping", "Active Sequence ID") ~= 2) then
    Print("__Collapsing thinner route piping!")
    AnimGBSequence("ThinnerRoutePiping", "COLLAPSE")
  end
  Enable("GreenPipeThinnerStim")
  AudioPostEventOn(GetPlayer(), "Play_sfx_thinroute_pltfmsmash")
  wait((animDuration * 0.25))
  ForEachEntityInGroup(StopEmitters, "SteamJetThinnerPath_knockback")
  Disable("SteamJetThinnerPath_trigger 02")
  wait((animDuration * 0.75))
  AnimGBSequence("ThinnerRoutePiping", "ENDstate")
  return 
end
FTL_BlotworxDragon_ThinnerRoutePipingMakeSureItsFIXED = function()
  Enable("GreenPipeThinnerStim")
  ForceSketched("ftl_blotworxdragon_01a_main.ToonPipe")
  ForEachEntityInGroup(StopEmitters, "SteamJetThinnerPath")
  Disable("SteamJetThinnerPath_trigger")
  ForEachEntityInGroup(StopEmitters, "SteamJetThinnerPath_knockback")
  Disable("SteamJetThinnerPath_trigger 02")
  AnimGBSequence("ThinnerRoutePiping", "ENDstate")
  return 
end
FTL_BlotworxDragon_TriggerStage3b = function()
  blotworxDragon_FireOnceLocal = 1
  if (blotworxDragonStageNum == blotworxDragon_PRECLIMB) then
    blotworxDragonStageNum = blotworxDragon_CLIMB
    BlotworxDragon_StartThinnerClimbStage(blotworxDragon_DRAGONCHARACTER)
  end
  return 
end
FTL_BlotworxDragon_TriggerStage3c = function(target, side)
  if (blotworxDragon_GameType ~= "second") then
    if (blotworxDragonStageNum <= 4) then
      if (side == "thinner") then
        blotworxDragon_ThinnerTopStarted = true
        PlayIGC("IGC_0177b_TopLevel_StartThinner")
        ClearAllCameraAttributes()
        Enable("Stage3CamTrigger")
        FTL_BlotworxDragon_TopCamera(GetPlayer())
        FTL_BlotworxDragon_TopCamera(GetPlayer2OrAI())
      elseif (side == "paint") then
        PlayIGC("IGC_0177a_TopLevel_StartPaint")
        ClearAllCameraAttributes()
        Enable("Stage3CamTrigger")
        FTL_BlotworxDragon_TopCamera(GetPlayer())
        FTL_BlotworxDragon_TopCamera(GetPlayer2OrAI())
      end
      BlotWorxDragon_Lava_Stage4()
      Unhide("RockfallAnim")
      AnimGBSequence("RockfallAnim", "COLLAPSE")
      ForceSketched("ToonStairway1")
      ForceSketched("ToonStairway2")
      ForceSketched("ToonStairway3")
      ForceSketched("ToonStairway4")
      ForceSketched("ToonStairway5")
      ForEachEntityInGroup(SetPropertyBool, "Pillars", "InvulnerableToPaintThinner", false)
      if (blotworxDragonStageNum <= 4) then
        Enable("TriggerBoulderSmash")
        if (side == "thinner") then
          OverrideSpawnTransform(PLAYER_ONE, GetPosition("MickeyStage3ThinnerRescueMarker"), GetFacing("MickeyStage3ThinnerRescueMarker"))
          OverrideSpawnTransform(PLAYER_TWO, GetPosition("OswaldStage3ThinnerRescueMarker"), GetFacing("OswaldStage3ThinnerRescueMarker"))
        elseif (side == "paint") then
          OverrideSpawnTransform(PLAYER_ONE, GetPosition("MickeyStage3RescueMarker"), GetFacing("MickeyStage3RescueMarker"))
          OverrideSpawnTransform(PLAYER_TWO, GetPosition("OswaldStage3RescueMarker"), GetFacing("OswaldStage3RescueMarker"))
        end
        blotworxDragonStageNum = blotworxDragon_STAGE3
        FTL_BlotworxDragon_RaiseLava2()
        if (blotworxDragonShowRockfall == true) then
          Unhide("RockfallAnim")
          AnimGBSequence("RockfallAnim", "COLLAPSE")
          AudioPostEventOn(GetPlayer(), "Play_sfx_exp_rumble_stage3")
          ShakeCamera(3, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
        end
        Enable("Stage3TriggerBoulderSmash")
        ForEachEntityInGroup(SetPropertyBool, "Pillars", "ForceInvulnerable", false)
        StartEmitterByNameFireForget(blotworxDragon_DRAGONCHARACTER, "DragonGiantThinnerSplash")
        FTL_BlotworxDragon_SetUpStageArmor(blotworxDragon_STAGE3)
      end
    end
  end
  return 
end
PostIGC_0177a_TopLevel_StartPaint = function()
  FTL_BlotworxDragon_TriggerStage3cCleanup()
  BlotworxDragon_ClearGuardianMasterFunc()
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage3PiecesRight")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage3PiecesLeft")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage3Pieces")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "Pillars")
  ClearAllCameraAttributes()
  Enable("Stage3CamTrigger")
  FTL_BlotworxDragon_TopCamera(GetPlayer())
  FTL_BlotworxDragon_TopCamera(GetPlayer2OrAI())
  return 
end
PostIGC_0177b_TopLevel_StartThinner = function()
  FTL_BlotworxDragon_TriggerStage3cCleanup()
  BlotworxDragon_ClearGuardianMasterFunc()
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage3PiecesRight")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage3PiecesLeft")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage3Pieces")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "Pillars")
  ClearAllCameraAttributes()
  Enable("Stage3CamTrigger")
  FTL_BlotworxDragon_TopCamera(GetPlayer())
  FTL_BlotworxDragon_TopCamera(GetPlayer2OrAI())
  return 
end
FTL_BlotworxDragon_TriggerStage3cCleanup = function()
  FTL_BlotworxDragon_SpawnController()
  AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_JumpToStage3)
  SetHeading(blotworxDragon_DRAGONCHARACTER, 0)
  FireThread(StartDragonStage)
  Enable("DragonBoulderSpawner2")
  FTL_BlotworxDragon_HaltOswaldActivity(false)
  FTL_BlotworxDragon_5_SaveCheckpoint()
  ClearAllCameraAttributes()
  Enable("Stage3CamTrigger")
  return 
end
GetSafeChamberFloorGroupID = function(ID)
  if (ID < 1) then
    ID = (ID + 12)
  elseif (12 < ID) then
    ID = (ID - 12)
  end
  return ID
end
PlayWobbleAnim = function(ID)
  if (not blotworxDragonChamberFloorArray[(ID - 1)]) then
    blotworxDragonChamberFloorArray[(ID - 1)] = true
    local groupname = ("ChamberFloor" .. ID)
    AnimGBReset(groupname)
    AnimGBSequence(groupname, "BigWobble")
  end
  return 
end
WobbleFlooring = function(ID, offset, intensity)
  if (0 < offset) then
    PlayWobbleAnim(GetSafeChamberFloorGroupID((ID + offset)))
    PlayWobbleAnim(GetSafeChamberFloorGroupID((ID - offset)))
  else
    PlayWobbleAnim(ID)
  end
  if (0 < intensity) then
    wait(0.10000000149011612)
    WobbleFlooring(ID, (offset + 1), (intensity - 1))
  end
  if (0 < offset) then
    blotworxDragonChamberFloorArray[(GetSafeChamberFloorGroupID((ID + offset)) - 1)] = false
    blotworxDragonChamberFloorArray[(GetSafeChamberFloorGroupID((ID - offset)) - 1)] = false
  else
    blotworxDragonChamberFloorArray[(ID - 1)] = false
  end
  return 
end
DragonAttackSlamCollision = function(activator, intensity, handID)
  local groupName = GetPropertyString(activator, "EntityGroups", 0)
  if blotworxDragonIsAbleToSlam then
    if (groupName == "ChamberFloor") then
      blotworxDragonIsAbleToSlam = false
      local innerGroupName = GetPropertyString(activator, "EntityGroups", 1)
      for floorID = 1, 12 do
        if (innerGroupName == ("ChamberFloor" .. floorID)) then
          local dragonAttackLimbID = tonumber(handID)
          WobbleFlooring(floorID, 0, tonumber(intensity))
          FireThread(FTL_BlotworxDragon_OswaldShockFloor, floorID, dragonAttackLimbID)
          hitPanel = floorID
        else
        end
      end
      wait(3)
      blotworxDragonIsAbleToSlam = true
      hitPanel = 0
    end
  end
  return 
end
FTL_BlotworxDragon_TailSpinCollision = function(activator)
  local groupName = GetPropertyString(activator, "EntityGroups", 0)
  if blotworxDragonIsAbleToSpin then
    if (groupName == "ChamberFloor") then
      blotworxDragonIsAbleToSpin = false
      AnimGBSequence(activator, "spin")
      local duration = AnimGBSequenceGetSequenceDuration(activator, "spin")
      wait(duration)
      blotworxDragonIsAbleToSpin = true
    end
  end
  return 
end
FTL_BlotworxDragon_Ending = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    FTL_BlotworxDragon_KillControllers()
    TeleportToEntity(GetPlayer(), "Stage3Marker")
    TeleportToEntity(GetPlayer2OrAI(), "Stage3MarkerOswald")
    FTL_BlotworxDragon_6_SaveCheckpoint()
  end
  FTL_BlotworxDragon_ActivateEndCutscene()
  return 
end
FTL_BlotworxDragon_PainterRoutePlatformCollapse = function(platform)
  AnimGBSequence(platform, "Collapse")
  AudioPostEventOn(GetPlayer(), "Play_sfx_rockfall_platformfall")
  wait(0.5)
  SetPropertyInt(platform, "Collision Layer", 13)
  return 
end
FTL_TailSpatterCollisionThinner = function()
  CounterAdd("TailSpatterThinLogicCounter", 1)
  return 
end
FTL_CollisionPainterTest = function()
  CounterAdd("TailSpatterPaintLogicCounter", 1)
  return 
end
FTL_Player_TeleportAway_Paint = function()
  TeleportToEntity(GetPlayer(), "PaintRouteMarker")
  wait(0.5)
  OswaldTeleportToMickeyAction()
  return 
end
FTL_Player_TeleportAway_Thin = function()
  TeleportToEntity(GetPlayer(), "ThinRouteMarker")
  wait(0.5)
  OswaldTeleportToMickeyAction()
  return 
end
FTL_TeleportToCorrectMarker = function()
  if (FTL_BlotworxDragon_StartClimbUpPainter() == true) then
    FTL_Player_TeleportAway_Paint()
  elseif (FTL_BlotworxDragon_StartClimbUpThinner() == true) then
    FTL_Player_TeleportAway_Thin()
  end
  return 
end
FTL_BlotworxDragon_ProjToMeanStreetsLoad = function(projector)
  UnrestrictCutSceneInput()
  OswaldStartMovingAction()
  if (GetConfigVariableBool("InDemoMode") == true) then
    ClearOverridesAndLoadLevel("mainmenu.start")
  else
    SetGlobal("MST_UtilidorsState", 0)
    if (GetGlobal("2dDirection") == 100) then
      SetupPosition(projector)
    else
      ClearOverridesAndLoadLevel("MeanStreet_South.Visit1")
    end
  end
  return 
end
SetSpatterPhase = function(phase)
  blotworxDragonCurrentSpatter = tonumber(phase)
  BlotworxDragon_SetSpatterPhase(blotworxDragon_DRAGONCHARACTER, blotworxDragonCurrentSpatter)
  return 
end
FTL_BlotworxDragon_StartTailSpatterPhase = function()
  FTL_BlotworxDragon_HaltOswaldActivity(true)
  Disable("DragonBoulderSpawnerLower2")
  BlotworxDragon_StartStunnedState(blotworxDragon_DRAGONCHARACTER, EVENT_RevealHeadSpatterCS)
  wait(1)
  AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_RevealTailSpatter)
  print("Music - RevealTailSpatter")
  local spatterCollision = GetChildEntityByName(blotworxDragon_DRAGONCHARACTER, "DragonCollisionTailSpatter")
  Unhide(spatterCollision)
  SetSpatterPhase(blotworxDragon_TAILSPATTER)
  ForEachEntityInGroup(Hide, "ArmorTargetMarkerToon")
  ForEachEntityInGroup(Unhide, "ArmorTargetMarkerSpatterTail")
  BlotworxDragon_AddToGuardianTargetEntityList(blotworxDragon_DRAGONCHARACTER, spatterCollision)
  BlotworxDragon_SetGuardianPriorityToEntities(blotworxDragon_DRAGONCHARACTER)
  Wait(2)
  FTL_BlotworxDragon_EnableLowerBouldersDropping(true)
  SetPropertyBool(spatterCollision, "InvulnerableToPaintThinner", false)
  return 
end
FTL_BlotworxDragon_StartChestSpatterPhase = function()
  BlotworxDragon_StartStunnedState(blotworxDragon_DRAGONCHARACTER, EVENT_SketchAnvil)
  wait(1)
  AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_RevealChestSpatter)
  print("Music - RevealChestSpatter")
  local spatterCollision = GetChildEntityByName(blotworxDragon_DRAGONCHARACTER, "DragonCollisionChestSpatter")
  Unhide(spatterCollision)
  BlotworxDragon_AddToGuardianTargetEntityList(blotworxDragon_DRAGONCHARACTER, "DragonCollisionChestSpatter")
  BlotworxDragon_SetGuardianPriorityToEntities(blotworxDragon_DRAGONCHARACTER)
  SetSpatterPhase(blotworxDragon_CHESTSPATTER)
  ForEachEntityInGroup(Hide, "ArmorTargetMarkerToon")
  ForEachEntityInGroup(Unhide, "ArmorTargetMarkerSpatterChest")
  SetPropertyBool(spatterCollision, "InvulnerableToPaintThinner", false)
  return 
end
FTL_RevealHeadSpatterEndCutscene = function()
  ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
  AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_HeadSpatterRevealed)
  wait(2)
  SetCameraAttributes("HeadSpatterCam")
  FTL_BlotworxDragon_EnableLowerBouldersDropping(true)
  ForEachEntityInGroup(Hide, "ArmorTargetMarkerToon")
  ForEachEntityInGroup(Unhide, "ArmorTargetMarkerSpatterHead")
  EnableMotion(blotworxDragon_DRAGONCHARACTER)
  local spatterCollision = GetChildEntityByName(blotworxDragon_DRAGONCHARACTER, "DragonCollisionHeadSpatter")
  Unhide(spatterCollision)
  BlotworxDragon_AddToGuardianTargetEntityList(blotworxDragon_DRAGONCHARACTER, spatterCollision)
  BlotworxDragon_SetGuardianPriorityToEntities(blotworxDragon_DRAGONCHARACTER)
  SetPropertyBool(spatterCollision, "InvulnerableToPaintThinner", false)
  return 
end
FTL_BlotworxDragon_StartHeadSpatterPhase = function()
  FTL_BlotworxDragon_HaltOswaldActivity(true)
  if (not blotworxDragonHasAlreadyRevealedHeadSpatter) then
    StartFadeOut(0.33000001311302185)
    Wait(0.33000001311302185)
    Disable("DragonBoulderSpawnerLower2")
    blotworxDragonHasAlreadyRevealedHeadSpatter = true
    PlayIGC("IGC_0165_SpatterInHead_Reveal")
    BlotworxDragon_StartDormantStage(blotworxDragon_DRAGONCHARACTER)
    wait(0.10999999940395355)
    DoStinger("Stinger_Unique1", 2)
    print("Music - Reveal Head Spatter IGC")
  else
    AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_RevealHeadSpatter)
  end
  SetSpatterPhase(blotworxDragon_HEADSPATTER)
  return 
end
PostIGC_0165_SpatterInHead_Reveal = function()
  FireThread(FTL_RevealHeadSpatterEndCutscene)
  BlotworxDragon_ClearGuardianMasterFunc()
  BlotworxDragon_AddToGuardianTargetEntityList(blotworxDragon_DRAGONCHARACTER, "DragonCollisionHeadSpatter")
  BlotworxDragon_SetGuardianPriorityToEntities(blotworxDragon_DRAGONCHARACTER)
  return 
end
PostIGC_0160b_DragonIntroBackDoor = function()
  BlotworxDragon_ClearGuardianMasterFunc()
  ForEachEntityInGroup(DestroyEntity, "Stage1RespawnCam")
  ClearAllCameraAttributes()
  ClearCameraAttributes("Stage1Cam")
  ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer())
  ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
  ClearCutSceneStack()
  return 
end
PostIGC_0160a_DragonIntroFrontDoor = function()
  BlotworxDragon_ClearGuardianMasterFunc()
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage1PiecesLeft")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage1PiecesRight")
  ClearCameraAttributes("Stage1Cam")
  ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
  SetCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
  return 
end
FTL_BlotworxDragon_HideTailSpatter = function()
  FTL_BlotworxDragon_StopSpatterHit()
  AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_HideTailSpatter)
  local spatterCollision = GetChildEntityByName(blotworxDragon_DRAGONCHARACTER, "DragonCollisionTailSpatter")
  Hide(spatterCollision)
  SetSpatterPhase(blotworxDragon_NOSPATTER)
  FTL_BlotworxDragon_EnableLowerBouldersDropping(false)
  return 
end
FTL_BlotworxDragon_HideChestSpatter = function()
  FTL_BlotworxDragon_StopSpatterHit()
  AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_HideChestSpatter)
  local spatterCollision = GetChildEntityByName(blotworxDragon_DRAGONCHARACTER, "DragonCollisionChestSpatter")
  Hide(spatterCollision)
  SetSpatterPhase(blotworxDragon_NOSPATTER)
  return 
end
FTL_BlotworxDragon_HideHeadSpatter = function()
  FTL_BlotworxDragon_StopSpatterHit()
  AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_HideHeadSpatter)
  local spatterCollision = GetChildEntityByName(blotworxDragon_DRAGONCHARACTER, "DragonCollisionHeadSpatter")
  Hide(spatterCollision)
  SetSpatterPhase(blotworxDragon_NOSPATTER)
  return 
end
FTL_BlotworxDragon_FriendArmsCutscene = function()
  TeleportToEntity(GetPlayer(), "EndGameMarker")
  wait(0.25)
  OswaldTeleportToMickeyAction()
  BlotworxDragon_StartPreClimbStage(blotworxDragon_DRAGONCHARACTER)
  SetHeading(blotworxDragon_DRAGONCHARACTER, 0)
  wait(0.10999999940395355)
  Unhide("FriendlyDeathBoulderAnim")
  BlotworxDragon_StartStunnedState(blotworxDragon_DRAGONCHARACTER, EVENT_SpatterChestFriend)
  blotworxDragonEndingChosen = blotworxDragon_PAINTER_ROUTE
  return 
end
FTL_BlotworxDragon_DetachArmsCutscene = function()
  TeleportToEntity(GetPlayer(), "EndGameMarker")
  wait(0.25)
  OswaldTeleportToMickeyAction()
  BlotworxDragon_StartPreClimbStage(blotworxDragon_DRAGONCHARACTER)
  SetHeading(blotworxDragon_DRAGONCHARACTER, 0)
  wait(0.10999999940395355)
  BlotworxDragon_StartStunnedState(blotworxDragon_DRAGONCHARACTER, EVENT_SpatterChestDeath)
  blotworxDragonEndingChosen = blotworxDragon_THINNER_ROUTE
  return 
end
FTL_BlotworxDragon_DetachArmsCutsceneEnd = function()
  AnimVarFloat(blotworxDragon_DRAGONCHARACTER, VAR_DetachedArms, 1)
  return 
end
FTL_BlotworxDragon_KillTailSpatter = function()
  FTL_BlotworxDragon_StopSpatterHit()
  blotworxDragonLastSpatterKilled = blotworxDragon_TAILSPATTER
  local spatterCollision = GetChildEntityByName(blotworxDragon_DRAGONCHARACTER, "DragonCollisionTailSpatter")
  Hide(spatterCollision)
  SetSpatterPhase(blotworxDragon_NOSPATTER)
  ForEachEntityInGroup(Hide, "ArmorTargetMarkerSpatterTail")
  ForEachEntityInGroup(Unhide, "ArmorTargetMarkerToon")
  FTL_BlotworxDragon_EnableLowerBouldersDropping(false)
  return 
end
FTL_BlotworxDragon_KillChestSpatter = function(self, hitType)
  local hitTypeID = tonumber(hitType)
  FTL_BlotworxDragon_StopSpatterHit()
  if (hitTypeID == blotworxDragon_HITTYPE_PAINT) then
    if (BlotworxDragon_BossWin == 0) then
      BlotworxDragon_BossWin = 1
      StartFadeOut(0.33000001311302185)
      Wait(0.33000001311302185)
      ReplaceMusicStateOverride("BWD_DefeatChest_Paint")
      print("Music - Kill chest spatter IGC - paint")
      PlayIGC("IGC_0190a_SpatterInChest_ResolvePaint")
      wait(0.5)
      FireThread(FTL_BlotworxDragon_FriendArmsCutscene)
      AnimVarFloat(blotworxDragon_DRAGONCHARACTER, VAR_S3_BreatheType, 1)
      blotworxDragonPlayStyle = (blotworxDragonPlayStyle + 1)
      if (GetConfigVariableBool("InDemoMode") == false) then
        IncreaseMaxElectricityAmmo()
        SetGlobal("Boss_DragonComplete", "paint")
      end
      AudioPostEventOn(GetPlayer(), "Play_sfx_DEM2_BwDragon_Downed")
    end
    if (GetConfigVariableBool("InDemoMode") == false) then
      SetGlobal("FriendlyDragonPin_Redeemed", 1)
      IncreaseMaxPaintAmmo()
    end
    GiveCollectible("Challenge_DragonDefeat_Tracker")
  elseif (hitTypeID == blotworxDragon_HITTYPE_THINNER) then
    if (BlotworxDragon_BossWin == 0) then
      BlotworxDragon_BossWin = 1
      StartFadeOut(0.33000001311302185)
      Wait(0.33000001311302185)
      ReplaceMusicStateOverride("BWD_DefeatChest_Thinner")
      print("Music - Kill chest spatter IGC - thinner")
      PlayIGC("IGC_0190b_SpatterInChest_ResolveThinner")
      wait(0.5)
      blotworxDragonPlayStyle = (blotworxDragonPlayStyle + 1)
      FireThread(FTL_BlotworxDragon_DetachArmsCutscene)
      if (GetConfigVariableBool("InDemoMode") == false) then
        IncreaseMaxElectricityAmmo()
        SetGlobal("Boss_DragonComplete", "thinner")
      end
    end
    if (GetConfigVariableBool("InDemoMode") == false) then
      IncreaseMaxThinnerAmmo()
      SetGlobal("RingofFirePin_Destroyed", 1)
    end
    GiveCollectible("Challenge_DragonDefeat_Tracker")
  end
  local spatterCollision = GetChildEntityByName(blotworxDragon_DRAGONCHARACTER, "DragonCollisionChestSpatter")
  Hide(spatterCollision)
  blotworxDragonLastSpatterKilled = blotworxDragon_CHESTSPATTER
  SetSpatterPhase(blotworxDragon_NOSPATTER)
  ForEachEntityInGroup(Hide, "ArmorTargetMarkerSpatterChest")
  ForEachEntityInGroup(Unhide, "ArmorTargetMarkerToon")
  FTL_BlotworxDragon_KillControllers()
  return 
end
PostIGC_0190a_SpatterInChest_ResolvePaint = function()
  SetGlobal("FTL_BlotworxDragon_EndCinematic", 1)
  FireThread(FTL_BlotworxDragon_Ending)
  BlotworxDragon_ClearGuardianMasterFunc()
  return 
end
PostIGC_0190b_SpatterInChest_ResolveThinner = function()
  SetGlobal("FTL_BlotworxDragon_EndCinematic", 0)
  FireThread(FTL_BlotworxDragon_Ending)
  BlotworxDragon_ClearGuardianMasterFunc()
  return 
end
FTL_BlotworxDragon_KillHeadSpatter = function()
  FTL_BlotworxDragon_StopSpatterHit()
  local spatterCollision = GetChildEntityByName(blotworxDragon_DRAGONCHARACTER, "DragonCollisionHeadSpatter")
  Hide(spatterCollision)
  blotworxDragonLastSpatterKilled = blotworxDragon_HEADSPATTER
  SetSpatterPhase(blotworxDragon_NOSPATTER)
  ForEachEntityInGroup(Hide, "ArmorTargetMarkerSpatterHead")
  ForEachEntityInGroup(Unhide, "ArmorTargetMarkerToon")
  return 
end
FTL_BlotworxDragon_StartSpatterHit = function(entity, hitType)
  local hitTypeID = tonumber(hitType)
  blotworxDragonHitTimer = 0.75
  if (not blotworxDragonIsSpatterHit) then
    blotworxDragonIsSpatterHit = true
    if (blotworxDragonCurrentSpatter == blotworxDragon_TAILSPATTER) then
      if (hitTypeID == blotworxDragon_HITTYPE_PAINT) then
        StopEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonTailSpatterParticleThinner")
        StartEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonTailSpatterParticlePaint")
      elseif (hitTypeID == blotworxDragon_HITTYPE_THINNER) then
        StopEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonTailSpatterParticlePaint")
        StartEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonTailSpatterParticleThinner")
      end
      AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_Start_SpatterHit)
    elseif (blotworxDragonCurrentSpatter == blotworxDragon_CHESTSPATTER) then
      if (hitTypeID == blotworxDragon_HITTYPE_PAINT) then
        StopEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonChestSpatterParticleThinner")
        StartEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonChestSpatterParticlePaint")
      elseif (hitTypeID == blotworxDragon_HITTYPE_THINNER) then
        StopEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonChestSpatterParticlePaint")
        StartEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonChestSpatterParticleThinner")
      end
      AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_Start_ChestSpatterHit)
    elseif (blotworxDragonCurrentSpatter == blotworxDragon_HEADSPATTER) then
      if (hitTypeID == blotworxDragon_HITTYPE_PAINT) then
        StopEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonHeadSpatterParticleThinner")
        StartEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonHeadSpatterParticlePaint")
      elseif (hitTypeID == blotworxDragon_HITTYPE_THINNER) then
        StopEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonHeadSpatterParticlePaint")
        StartEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonHeadSpatterParticleThinner")
      end
      AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_Start_HeadSpatterHit)
    end
  end
  return 
end
FTL_BlotworxDragon_UpdateSpatterHit = function()
  if (0 < blotworxDragonHitTimer) then
    if blotworxDragonIsSpatterHit then
      blotworxDragonHitTimer = (blotworxDragonHitTimer - 0.25)
      if (blotworxDragonHitTimer <= 0) then
        FTL_BlotworxDragon_StopSpatterHit()
      end
    end
  end
  return 
end
FTL_BlotworxDragon_StopSpatterHit = function()
  if blotworxDragonIsSpatterHit then
    blotworxDragonIsSpatterHit = false
    blotworxDragonHitTimer = 0
    AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_Stop_SpatterHit)
    StopEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonHeadSpatterParticleThinner")
    StopEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonHeadSpatterParticlePaint")
    StopEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonTailSpatterParticleThinner")
    StopEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonTailSpatterParticlePaint")
    StopEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonChestSpatterParticleThinner")
    StopEmitterByName(blotworxDragon_DRAGONCHARACTER, "DragonChestSpatterParticlePaint")
    wait(0.5)
  end
  return 
end
blotworxDragonArmorPieceChainCounter = 0
blotworxDragonSpawnEvery = 1
FTL_BlotworxDragon_OnArmorPieceFullyPainted = function(armorPiece)
  StartEmitterByNameFireForget(armorPiece, "DragonArmorParticlePaint")
  if (not blotworxDragonShouldNoticePaintStatusChange) then
    return 
  end
  blotworxDragonArmorPieceChainCounter = (blotworxDragonArmorPieceChainCounter + 1)
  if (blotworxDragonSpawnEvery <= blotworxDragonArmorPieceChainCounter) then
    if (blotworxDragonStageNum ~= blotworxDragon_STAGE3) then
      TeleportToEntity("DragonPickupSpawn", GetPlayer())
      ForceSpawn("DragonPickupSpawn", 1)
      blotworxDragonArmorPieceChainCounter = 0
    end
  end
  blotworxDragonArmorPaintedCounter = (blotworxDragonArmorPaintedCounter + 1)
  ShakeCamera(1.2000000476837158, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  if (blotworxDragonStageNum == blotworxDragon_STAGE1) then
    if (blotworxDragonArmorPaintedMaxOrMin == true) then
      if (blotworxDragonArmorPaintedCounter < blotworxDragon_S1_MAXARMORPIECES) then
        FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
      end
    elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S1_MAXARMORPIECES) then
      FTL_BlotworxDragon_OnMaxArmorPiecesChain()
      if (blotworxDragonStageNum == blotworxDragon_STAGE2) then
        if (blotworxDragonArmorPaintedMaxOrMin == true) then
          if (blotworxDragonArmorPaintedCounter < blotworxDragon_S2_MAXARMORPIECES) then
            FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
          end
        elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S2_MAXARMORPIECES) then
          FTL_BlotworxDragon_OnMaxArmorPiecesChain()
          if (blotworxDragonStageNum == blotworxDragon_STAGE3) then
            if (blotworxDragonArmorPaintedMaxOrMin == true) then
              if (blotworxDragonArmorPaintedCounter < blotworxDragon_S3_MAXARMORPIECES) then
                FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
              end
            elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S3_MAXARMORPIECES) then
              FTL_BlotworxDragon_OnMaxArmorPiecesChain()
            end
          end
        end
      elseif (blotworxDragonStageNum == blotworxDragon_STAGE3) then
        if (blotworxDragonArmorPaintedMaxOrMin == true) then
          if (blotworxDragonArmorPaintedCounter < blotworxDragon_S3_MAXARMORPIECES) then
            FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
          end
        elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S3_MAXARMORPIECES) then
          FTL_BlotworxDragon_OnMaxArmorPiecesChain()
        end
      end
    end
  elseif (blotworxDragonStageNum == blotworxDragon_STAGE2) then
    if (blotworxDragonArmorPaintedMaxOrMin == true) then
      if (blotworxDragonArmorPaintedCounter < blotworxDragon_S2_MAXARMORPIECES) then
        FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
      end
    elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S2_MAXARMORPIECES) then
      FTL_BlotworxDragon_OnMaxArmorPiecesChain()
      if (blotworxDragonStageNum == blotworxDragon_STAGE3) then
        if (blotworxDragonArmorPaintedMaxOrMin == true) then
          if (blotworxDragonArmorPaintedCounter < blotworxDragon_S3_MAXARMORPIECES) then
            FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
          end
        elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S3_MAXARMORPIECES) then
          FTL_BlotworxDragon_OnMaxArmorPiecesChain()
        end
      end
    end
  elseif (blotworxDragonStageNum == blotworxDragon_STAGE3) then
    if (blotworxDragonArmorPaintedMaxOrMin == true) then
      if (blotworxDragonArmorPaintedCounter < blotworxDragon_S3_MAXARMORPIECES) then
        FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
      end
    elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S3_MAXARMORPIECES) then
      FTL_BlotworxDragon_OnMaxArmorPiecesChain()
    end
  end
  return 
end
FTL_BlotworxDragon_OnArmorPieceFullyThinned = function(armorPiece)
  StartEmitterByNameFireForget(armorPiece, "DragonArmorParticleThinner")
  if (not blotworxDragonShouldNoticePaintStatusChange) then
    return 
  end
  blotworxDragonArmorPieceChainCounter = (blotworxDragonArmorPieceChainCounter + 1)
  if (blotworxDragonSpawnEvery <= blotworxDragonArmorPieceChainCounter) then
    ForceSpawn("DragonPickupSpawn", 1)
    blotworxDragonArmorPieceChainCounter = 0
  end
  blotworxDragonArmorPaintedCounter = (blotworxDragonArmorPaintedCounter - 1)
  ShakeCamera(1.2000000476837158, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  if (blotworxDragonStageNum == blotworxDragon_STAGE1) then
    if (blotworxDragonArmorPaintedMaxOrMin == true) then
      if (blotworxDragon_S1_MINARMORPIECES < blotworxDragonArmorPaintedCounter) then
        FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
      end
    elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S1_MINARMORPIECES) then
      FTL_BlotworxDragon_OnMinArmorPiecesChain()
      if (blotworxDragonStageNum == blotworxDragon_STAGE2) then
        if (blotworxDragonArmorPaintedMaxOrMin == true) then
          if (blotworxDragon_S2_MINARMORPIECES < blotworxDragonArmorPaintedCounter) then
            FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
          end
        elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S2_MINARMORPIECES) then
          FTL_BlotworxDragon_OnMinArmorPiecesChain()
          if (blotworxDragonStageNum == blotworxDragon_STAGE3) then
            if (blotworxDragonArmorPaintedMaxOrMin == true) then
              if (blotworxDragon_S3_MINARMORPIECES < blotworxDragonArmorPaintedCounter) then
                FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
              end
            elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S3_MINARMORPIECES) then
              FTL_BlotworxDragon_OnMinArmorPiecesChain()
            end
          end
        end
      elseif (blotworxDragonStageNum == blotworxDragon_STAGE3) then
        if (blotworxDragonArmorPaintedMaxOrMin == true) then
          if (blotworxDragon_S3_MINARMORPIECES < blotworxDragonArmorPaintedCounter) then
            FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
          end
        elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S3_MINARMORPIECES) then
          FTL_BlotworxDragon_OnMinArmorPiecesChain()
        end
      end
    end
  elseif (blotworxDragonStageNum == blotworxDragon_STAGE2) then
    if (blotworxDragonArmorPaintedMaxOrMin == true) then
      if (blotworxDragon_S2_MINARMORPIECES < blotworxDragonArmorPaintedCounter) then
        FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
      end
    elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S2_MINARMORPIECES) then
      FTL_BlotworxDragon_OnMinArmorPiecesChain()
      if (blotworxDragonStageNum == blotworxDragon_STAGE3) then
        if (blotworxDragonArmorPaintedMaxOrMin == true) then
          if (blotworxDragon_S3_MINARMORPIECES < blotworxDragonArmorPaintedCounter) then
            FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
          end
        elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S3_MINARMORPIECES) then
          FTL_BlotworxDragon_OnMinArmorPiecesChain()
        end
      end
    end
  elseif (blotworxDragonStageNum == blotworxDragon_STAGE3) then
    if (blotworxDragonArmorPaintedMaxOrMin == true) then
      if (blotworxDragon_S3_MINARMORPIECES < blotworxDragonArmorPaintedCounter) then
        FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain()
      end
    elseif (blotworxDragonArmorPaintedCounter == blotworxDragon_S3_MINARMORPIECES) then
      FTL_BlotworxDragon_OnMinArmorPiecesChain()
    end
  end
  return 
end
FTL_BlotworxDragon_OnBrokenMaxOrMinArmorPiecesChain = function()
  blotworxDragonArmorPaintedMaxOrMin = false
  if (blotworxDragonStageNum ~= blotworxDragon_STAGE1) then
    if (blotworxDragonStageNum ~= blotworxDragon_STAGE2) then
    end
  end
  return 
end
FTL_BlotworxDragon_OnMaxArmorPiecesChain = function()
  blotworxDragonArmorPaintedMaxOrMin = true
  if (blotworxDragonStageNum == blotworxDragon_STAGE1) then
    wait(1)
    FTL_BlotworxDragon_StartHeadSpatterPhase()
  elseif (blotworxDragonStageNum == blotworxDragon_STAGE2) then
    wait(1)
    FTL_BlotworxDragon_StartTailSpatterPhase()
  elseif (blotworxDragonStageNum == blotworxDragon_STAGE3) then
    wait(1)
    FTL_BlotworxDragon_StartChestSpatterPhase()
  end
  return 
end
FTL_BlotworxDragon_OnMinArmorPiecesChain = function()
  blotworxDragonArmorPaintedMaxOrMin = true
  if (blotworxDragonStageNum == blotworxDragon_STAGE1) then
    FTL_BlotworxDragon_StartHeadSpatterPhase()
  elseif (blotworxDragonStageNum == blotworxDragon_STAGE2) then
    FTL_BlotworxDragon_StartTailSpatterPhase()
  elseif (blotworxDragonStageNum == blotworxDragon_STAGE3) then
    FTL_BlotworxDragon_StartChestSpatterPhase()
  end
  return 
end
FTL_BlotworxDragon_DisableEnemySpawner1 = function()
  if blotworxDragonEnemySpawner1Enabled then
    blotworxDragonEnemySpawner1Enabled = false
    Disable("Spawner1")
    StartEmitters("ConsoleExplode1")
    Wait(1)
    StopEmitters("ConsoleExplode1")
    StartEmitters("SpawnerExplodes1")
    Kill("Enemies1")
  end
  return 
end
FTL_BlotworxDragon_DisableEnemySpawner2 = function()
  if blotworxDragonEnemySpawner2Enabled then
    blotworxDragonEnemySpawner2Enabled = false
    Disable("Spawner2")
    StartEmitters("ConsoleExplode2")
    Wait(1)
    StopEmitters("ConsoleExplode2")
    StartEmitters("SpawnerExplodes2")
    Kill("Enemies2")
  end
  return 
end
FTL_BlotworxDragon_DisableEnemySpawner3 = function()
  if blotworxDragonEnemySpawner3Enabled then
    blotworxDragonEnemySpawner3Enabled = false
    Disable("Spawner3")
    Wait(1)
    StartEmitters("SpawnerExplodes3")
    Kill("Enemies3")
  end
  return 
end
FTL_BlotworxDragon_IsSpawnerActive = function(spawnerID)
  if (spawnerID == 1) then
    if blotworxDragonEnemySpawner1Enabled then
      return true
    end
  elseif (spawnerID == 2) then
    if blotworxDragonEnemySpawner2Enabled then
      return true
    end
  elseif (spawnerID == 3) then
    if blotworxDragonEnemySpawner3Enabled then
      return true
    end
  else
    return false
  end
  return 
end
FTL_BlotworxDragon_SpawnController = function()
  UnpauseAllAI()
  print(GetGlobal("FTL_BlotworxDragon_ReprogramSpot1"))
  print(GetGlobal("FTL_BlotworxDragon_ReprogramSpot2"))
  print(GetGlobal("FTL_BlotworxDragon_ReprogramSpot3"))
  for i = 1, 3 do
    if (GetGlobal(("FTL_BlotworxDragon_ReprogramSpot" .. i)) == 0) then
      Enable(("Spawner" .. i))
      print(GetGlobal(("FTL_BlotworxDragon_ReprogramSpot" .. i)))
    end
  end
  return 
end
FTL_BlotworxDragon_KillControllers = function()
  blotworxDragonStageNum = blotworxDragon_END
  FTL_BlotworxDragon_DisableEnemySpawner1()
  FTL_BlotworxDragon_DisableEnemySpawner2()
  FTL_BlotworxDragon_DisableEnemySpawner3()
  ForEachEntityInGroup(Kill, "Enemies1")
  ForEachEntityInGroup(Kill, "Enemies2")
  ForEachEntityInGroup(Kill, "Enemies3")
  return 
end
FTL_BlotworxDragon_DisableControllers = function()
  if blotworxDragonEnemySpawner1Enabled then
    PauseAllAI()
    Disable("Spawner1")
  end
  if blotworxDragonEnemySpawner2Enabled then
    PauseAllAI()
    Disable("Spawner2")
  end
  if blotworxDragonEnemySpawner3Enabled then
    PauseAllAI()
    Disable("Spawner3")
  end
  return 
end
FTL_Dragon_2DTransitionSetup = function(exitProjector)
  LevelManager_SetCurrentState("FTL_BlotworxDragon.Main")
  WaitForLevelLoad()
  DestroyEntity("TriggerStartChoice")
  SetupPosition()
  wait(5)
  LevelManager_SetZoneStatusUnloaded("FTL_Gulch.TRAN_OldMill")
  LevelManager_SetZoneStatusUnloaded("FTL_Gulch.TRAN_OldMill2")
  return 
end
FTL_BlotworxDragon_ActivateEndCutscene = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 1) then
    StartFadeOut(0.800000011920929)
    Wait(0.800000011920929)
    ClearOverridesAndLoadLevel("MeanStreet_North.Visit_2")
    return 
  end
  if (GetConfigVariableBool("InDemoMode") == true) then
    StartFadeOut(0)
    PlayMovie(GetPlayer(), "DemoEnd_Wii_long.bik")
    ClearOverridesAndLoadLevel("mainmenu.start")
    StartFadeIn(0)
  else
    SetGlobal("EM2_EpisodeCheck", 2)
    StartFadeOut(0.800000011920929)
    Wait(0.800000011920929)
    if (blotworxDragonEndingChosen == blotworxDragon_THINNER_ROUTE) then
      SetGlobal("Extras_Petes_Dragon_Paint", 0)
      PlayMovie(GetPlayer(), "PH_1_4_Thinner.bik")
    elseif (blotworxDragonEndingChosen == blotworxDragon_PAINTER_ROUTE) then
      SetGlobal("Extras_Petes_Dragon_Paint", 1)
      PlayMovie(GetPlayer(), "PH_1_4_Paint.bik")
    end
    PlayMovie(GetPlayer(), "PH_1_4_End.bik")
    SetGlobal("EM2_Movies_BwxDragonMovie_Unlocked", 1)
    SetGlobal("MST_UtilidorsState", 0)
    ClearOverridesAndLoadLevel("MeanStreet_South.Visit1")
  end
  return 
end
FTL_BlotworxDragon_ActivateEndCutsceneReloadCheckpoint = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 1) then
    StartFadeOut(0)
    Wait(0)
    ClearOverridesAndLoadLevel("MeanStreet_North.Visit_2")
    return 
  end
  if (GetConfigVariableBool("InDemoMode") == true) then
    StartFadeIn(0)
    PlayMovie(GetPlayer(), "DemoEnd_Wii_long.bik")
    ClearOverridesAndLoadLevel("mainmenu.start")
  else
    SetGlobal("EM2_EpisodeCheck", 2)
    StartFadeOut(0)
    Wait(0)
    if (GetGlobal("FTL_BlotworxDragon_EndCinematic") == 0) then
      SetGlobal("Extras_Petes_Dragon_Paint", 0)
      PlayMovie(GetPlayer(), "PH_1_4_Thinner.bik")
    elseif (GetGlobal("FTL_BlotworxDragon_EndCinematic") == 1) then
      SetGlobal("Extras_Petes_Dragon_Paint", 1)
      PlayMovie(GetPlayer(), "PH_1_4_Paint.bik")
    end
    PlayMovie(GetPlayer(), "PH_1_4_End.bik")
    SetGlobal("EM2_Movies_BwxDragonMovie_Unlocked", 1)
    EnableSplitScreen(true)
    ClearOverridesAndLoadLevel("MeanStreet_South.Visit1")
  end
  return 
end
FTL_BlotworxDragon_ChooseEntrance = function(target)
  local global = GetGlobal("FTL_Gulch_ProjectorExit")
  DestroyEntity(target)
  if (GetGlobal("MSN_Arcade_FromArcade") == 1) then
    Print("FTL_BlotworxDragon_ChooseEntrance(): Coming from Old Mill 1")
    GetPrefabData("StartProjectorMarker").MapLoad_SetupPosition = "True"
    OnMapLoad_ProjectorSetup("StartProjectorMarker")
  end
  if (global == 4) then
    Print("FTL_BlotworxDragon_ChooseEntrance(): Coming from Old Mill 2")
    GetPrefabData("AlternateProjectorMarker").MapLoad_SetupPosition = "True"
    OnMapLoad_ProjectorSetup("AlternateProjectorMarker")
  elseif (global == 10) then
    Print("FTL_BlotworxDragon_ChooseEntrance(): Coming from Mean Street South")
    GetPrefabData("BWD_End_Projector").MapLoad_SetupPosition = "True"
    OnMapLoad_ProjectorSetup("BWD_End_Projector")
  elseif (global == 0) then
    Print("FTL_BlotworxDragon_ChooseEntrance(): Loading from the Launcher")
    GetPrefabData("StartProjectorMarker").MapLoad_SetupPosition = "True"
    OnMapLoad_ProjectorSetup("StartProjectorMarker")
  end
  SetGlobal("FTL_Gulch_ProjectorExit", -1)
  return 
end
FTL_BlotworxDragon_ResetLava1 = function(self, event)
  local mickey = GetPlayer()
  local PlayerCurrentHealth = GetPropertyInt(mickey, "Health", 0)
  if (PlayerCurrentHealth <= 0) then
    SplineFollower_TeleportToKnot("LavaPlane", "LavaSpline1")
    wait(3)
    FTL_BlotworxDragon_RaiseLava1()
  end
  return 
end
FTL_BlotworxDragon_ResetLavaToPlane2 = function()
  SplineFollower_TeleportToKnot("LavaPlane", "LavaSpline2")
  wait(3)
  FTL_BlotworxDragon_RaiseLava2()
  return 
end
FTL_BlotworxDragon_IntroIGC = function(target, entrance)
  Disable("AlternateEntranceTrigger")
  Disable("MainEntranceTrigger")
  if (entrance == "main") then
    StimulusEntity(GetPlayer(), ST_PAINT, 5, GetPosition(GetPlayer2OrAI()), GetPlayer2OrAI())
    wait(0.5)
    StimulusEntity(GetPlayer(), ST_PAINT, 5, GetPosition(GetPlayer2OrAI()), GetPlayer2OrAI())
    PlayIGC("IGC_0160a_DragonIntroFrontDoor")
    StimulusEntity(GetPlayer(), ST_PAINT, 5, GetPosition(GetPlayer2OrAI()), GetPlayer2OrAI())
  elseif (entrance == "alternate") then
    StimulusEntity(GetPlayer(), ST_PAINT, 5, GetPosition(GetPlayer2OrAI()), GetPlayer2OrAI())
    wait(0.5)
    StimulusEntity(GetPlayer(), ST_PAINT, 5, GetPosition(GetPlayer2OrAI()), GetPlayer2OrAI())
    PlayIGC("IGC_0160b_DragonIntroBackDoor")
    wait(0.5)
    AnimGBSequence("SideThinnerPathPlatform", "Move", true)
    StimulusEntity(GetPlayer(), ST_PAINT, 5, GetPosition(GetPlayer2OrAI()), GetPlayer2OrAI())
  end
  return 
end
FTL_BlotworxDragon_CeilingCollapse = function()
  if (BlotworxDragon_BossWin == 0) then
    BlotworxDragon_BossWin = 1
    if (blotworxDragon_GameType ~= "second") then
      FTL_BlotworxDragon_KillControllers()
      if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
        if (GetConfigVariableBool("InDemoMode") == false) then
          IncreaseMaxThinnerAmmo()
          IncreaseMaxElectricityAmmo()
          if (HasCollectible("Ring_of_fire") == false) then
            GiveCollectible("Challenge_DragonDefeat_Tracker")
          end
          SetGlobal("RingofFirePin_Destroyed", 1)
          SetGlobal("Boss_DragonComplete", "thinner")
        end
      end
      StartFadeOut(0.33000001311302185)
      Wait(0.33000001311302185)
      ReplaceMusicStateOverride("Boss_Win")
      print("Music - Ceiling Collapse")
      PlayIGC("IGC_0185_TopLevel_ThinRemainingSupports")
      wait(0.5)
      blotworxDragonEndingChosen = blotworxDragon_THINNER_ROUTE
      FireThread(FTL_BlotworxDragon_CeilingCollapseCutscene)
    end
  end
  return 
end
BlotWorxDragon_Lava_Stage1 = function()
  Print("********************************BlotWorxDragon_Lava_Stage1 START")
  Print(LavaStage)
  if (blotworxDragonRouteTaken == blotworxDragon_THINNER_ROUTE) then
    if (LavaStage < 1) then
      Print("********************************BlotWorxDragon_Lava_Stage1 Mid")
      LavaStage = 1
      OverrideSpawnTransform(PLAYER_ONE, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ThinRouteSafety"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ThinRouteSafety"))
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ThinRouteSafetyOswald"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ThinRouteSafetyOswald"))
      Print("********************************BlotWorxDragon_Lava_Stage1 Mid 2")
    end
  end
  Print("********************************BlotWorxDragon_Lava_Stage1 End")
  return 
end
BlotWorxDragon_Lava_Stage2 = function()
  Print("********************************BlotWorxDragon_Lava_Stage2 START")
  Print(LavaStage)
  if (blotworxDragonRouteTaken == blotworxDragon_THINNER_ROUTE) then
    if (LavaStage < 2) then
      Print("********************************BlotWorxDragon_Lava_Stage2 Mid")
      LavaStage = 2
      OverrideSpawnTransform(PLAYER_ONE, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ThinRouteSafety 01"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ThinRouteSafety 01"))
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ThinRouteSafetyOswald 01"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ThinRouteSafetyOswald 01"))
      Print("********************************BlotWorxDragon_Lava_Stage2 Mid 2")
    end
  end
  Print("********************************BlotWorxDragon_Lava_Stage2 End")
  return 
end
BlotWorxDragon_Lava_Stage3 = function()
  Print("********************************BlotWorxDragon_Lava_Stage3 START")
  Print(LavaStage)
  if (blotworxDragonRouteTaken == blotworxDragon_THINNER_ROUTE) then
    if (LavaStage < 3) then
      Print("********************************BlotWorxDragon_Lava_Stage3 Mid")
      LavaStage = 3
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.MickeyStage3ThinnerRescueMarker"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.MickeyStage3ThinnerRescueMarker"))
      OverrideSpawnTransform(PLAYER_ONE, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.OswaldStage3ThinnerRescueMarker"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.OswaldStage3ThinnerRescueMarker"))
      Print("********************************BlotWorxDragon_Lava_Stage3 Mid 2")
    end
  end
  Print("********************************BlotWorxDragon_Lava_Stage2 End")
  return 
end
BlotWorxDragon_Lava_Stage4 = function()
  Print("********************************BlotWorxDragon_Lava_Stage4 START")
  Print(LavaStage)
  LavaStage = 4
  return 
end
PostIGC_0185_TopLevel_ThinRemainingSupports = function()
  SetGlobal("FTL_BlotworxDragon_EndCinematic", 0)
  FireThread(FTL_BlotworxDragon_Ending)
  BlotworxDragon_ClearGuardianMasterFunc()
  return 
end
FTL_BlotworxDragon_CeilingCollapseCutscene = function()
  FTL_BlotworxDragon_KillControllers()
  TeleportToEntity(GetPlayer(), "EndGameMarker")
  wait(0.25)
  OswaldTeleportToMickeyAction()
  BlotworxDragon_StartPreClimbStage(blotworxDragon_DRAGONCHARACTER)
  SetHeading(blotworxDragon_DRAGONCHARACTER, 0)
  Wait(0.10999999940395355)
  BlotworxDragon_StartStunnedState(blotworxDragon_DRAGONCHARACTER, EVENT_CeilingCollapse)
  AnimGBSequence("CeilingCollapseAnim", "CeilingCollapseCsne")
  return 
end
blotworxDragon_HasPlayedFirstPillarThinnedCutscene = false
FTL_FirstPillarThinnedCutscene = function()
  if (blotworxDragon_GameType ~= "second") then
    if (not blotworxDragon_HasPlayedFirstPillarThinnedCutscene) then
      StartFadeOut(0.33000001311302185)
      Wait(0.33000001311302185)
      SetPositionFloat(blotworxDragon_DRAGONCHARACTER, 0, 0, 0)
      blotworxDragon_HasPlayedFirstPillarThinnedCutscene = true
      FTL_BlotworxDragon_DisableControllers()
      blotworxDragonCutsceneActive = true
      PlayIGC("IGC_0180_TopLevel_ThinFirstSupport")
      wait(0.5)
      ClearAllCameraAttributes()
      ClearCameraAttributes("Stage1Cam")
      ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer())
      ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
      TeleportToEntity(GetPlayer(), "Stage3Marker")
      TeleportToEntity(GetPlayer2OrAI(), "Stage3MarkerOswald")
      OverrideSpawnTransform(PLAYER_ONE, GetPosition("MickeyStage3RescueMarker"), GetFacing("Stage3Marker"))
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("OswaldStage3RescueMarker"), GetFacing("Stage3MarkerOswald"))
      FireThread(FTL_BlotworxDragon_PillarCollapseCutscene)
      if (blotworxDragonStageNum == 0) then
        FTL_BlotworxDragon_TriggerStage3cCleanup()
      end
      if (blotworxDragonStageNum <= 4) then
        Enable("TriggerBoulderSmash")
        FTL_BlotworxDragon_RaiseLava2()
        if (blotworxDragonShowRockfall == true) then
          Unhide("RockfallAnim")
          AnimGBSequence("RockfallAnim", "COLLAPSE")
          AudioPostEventOn(GetPlayer(), "Play_sfx_exp_rumble_stage3")
          ShakeCamera(3, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
        end
        Enable("Stage3TriggerBoulderSmash")
        ForEachEntityInGroup(SetPropertyBool, "Pillars", "ForceInvulnerable", false)
        StartEmitterByNameFireForget(blotworxDragon_DRAGONCHARACTER, "DragonGiantThinnerSplash")
        FTL_BlotworxDragon_SetUpStageArmor(blotworxDragon_STAGE3)
        Enable("DragonBoulderSpawner2")
      end
      while true do
        wait(0.5)
      end
      FTL_BlotworxDragon_HaltOswaldActivity(false)
      if (blotworxDragonStageNum <= 4) then
        blotworxDragonStageNum = blotworxDragon_STAGE3
        BlotworxDragon_StartStage3(blotworxDragon_DRAGONCHARACTER)
      end
    else
      ShakeCamera(2, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
      AudioPostEventOn(GetPlayer(), "Play_sfx_rumble_small")
    end
  end
  FTL_BlotworxDragon_TopCamera(GetPlayer())
  FTL_BlotworxDragon_TopCamera(GetPlayer2OrAI())
  return 
end
PostIGC_0180_TopLevel_ThinFirstSupport = function()
  UnpauseAllAI()
  FTL_BlotworxDragon_SpawnController()
  BlotworxDragon_ClearGuardianMasterFunc()
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage3PiecesRight")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage3PiecesLeft")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "BlotworxDragonStage3Pieces")
  ForEachEntityInGroup(BlotworxDragon_AddToGuardianTargetToonListFLIP, "Pillars")
  blotworxDragonCutsceneActive = false
  return 
end
FTL_BlotworxDragon_PillarCollapseCutscene = function()
  BlotworxDragon_StartStunnedState(blotworxDragon_DRAGONCHARACTER, EVENT_SketchAnvil)
  AnimGBSequence("CeilingCollapseAnim", "PillarCollapseShake")
  AudioPostEventOn(GetPlayer(), "Play_sfx_cam_ceilingfall")
  FTL_BlotworxDragon_Speech_Gus006()
  Wait(3.200000047683716)
  FTL_BlotworxDragon_Speech_Mickey004()
  return 
end
FTL_BlotworxDragon_1_SaveCheckpoint = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    if (blotworxDragon_GameType == "first") then
      SaveCheckpoint(nil, "FTL_BlotworxDragon_1_CheckpointLoad", "MickeyStage1StartMarker", "OswaldStage1StartMarker")
      blotworxDragonLastSavedCheckpoint = 1
    end
  end
  return 
end
FTL_BlotworxDragon_2_SaveCheckpoint = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    if (blotworxDragon_GameType == "first") then
      SaveCheckpoint(nil, "FTL_BlotworxDragon_2_CheckpointLoad", "MickeyStage1StartMarker", "OswaldStage1StartMarker")
      blotworxDragonLastSavedCheckpoint = 2
    end
  end
  return 
end
FTL_BlotworxDragon_3_SaveCheckpoint = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    if (blotworxDragon_GameType == "first") then
      SaveCheckpoint(nil, "FTL_BlotworxDragon_3_CheckpointLoad", "ThinRouteSafety", "ThinRouteSafetyOswald")
      blotworxDragonLastSavedCheckpoint = 3
    end
  end
  return 
end
FTL_BlotworxDragon_4_SaveCheckpoint = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    if (blotworxDragon_GameType == "first") then
      SaveCheckpoint(nil, "FTL_BlotworxDragon_4_CheckpointLoad", "PaintRouteSafety", "PaintRouteSafetyOswald")
      blotworxDragonLastSavedCheckpoint = 4
    end
  end
  return 
end
FTL_BlotworxDragon_5_SaveCheckpoint = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    if (blotworxDragon_GameType == "first") then
      SaveCheckpoint(nil, "FTL_BlotworxDragon_5_CheckpointLoad", "Stage3Marker", "Stage3MarkerOswald")
      blotworxDragonLastSavedCheckpoint = 5
    end
  end
  return 
end
FTL_BlotworxDragon_6_SaveCheckpoint = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    if (blotworxDragon_GameType == "first") then
      SaveCheckpoint(nil, "FTL_BlotworxDragon_6_CheckpointLoad", "Stage3Marker", "Stage3MarkerOswald")
      blotworxDragonLastSavedCheckpoint = 6
    end
  end
  return 
end
PathSafetyNet2 = function()
  OverrideSpawnTransform(PLAYER_ONE, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ThinRouteSafety 01"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ThinRouteSafety 01"))
  OverrideSpawnTransform(PLAYER_TWO, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ThinRouteSafetyOswald 01"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ThinRouteSafetyOswald 01"))
  return 
end
StartDragonStage = function()
  Print(("StartDragonStage: The stage is currently on blotworxDragonStageNum = " .. blotworxDragonStageNum))
  Wait(1)
  if (blotworxDragonStageNum == blotworxDragon_STAGE1) then
    BlotworxDragon_StartStage1(blotworxDragon_DRAGONCHARACTER)
    Wait(1)
    BlotworxDragon_StartStage1(blotworxDragon_DRAGONCHARACTER)
  elseif (blotworxDragonStageNum == blotworxDragon_STAGE2) then
    BlotworxDragon_StartStage2(blotworxDragon_DRAGONCHARACTER)
    Wait(1)
    BlotworxDragon_StartStage2(blotworxDragon_DRAGONCHARACTER)
  elseif (blotworxDragonStageNum == blotworxDragon_PRECLIMB) then
    BlotworxDragon_StartPreClimbStage(blotworxDragon_DRAGONCHARACTER)
    Wait(1)
    BlotworxDragon_StartPreClimbStage(blotworxDragon_DRAGONCHARACTER)
  elseif (blotworxDragonStageNum == blotworxDragon_STAGE3) then
    BlotworxDragon_StartStage3(blotworxDragon_DRAGONCHARACTER)
    Wait(1)
    BlotworxDragon_StartStage3(blotworxDragon_DRAGONCHARACTER)
  end
  return 
end
FTL_BlotworxDragon_1_CheckpointLoad = function()
  if (GetGlobal("FriendlyDragonPin_Redeemed") ~= 1) then
    if (GetGlobal("RingofFirePin_Destroyed") ~= 1) then
      if (blotworxDragon_GameType ~= "second") then
        local data = GetPrefabData("AlternateProjectorMarker")
        data.StartsInactive = true
        Prefab_Projector_ChangeState("StartProjectorMarker", "Deactivate")
        Prefab_Projector_ChangeState("AlternateProjectorMarker", "Deactivate")
        ClearCameraAttributes("Stage1Cam")
        SetPropertyBool("ToonPiping", "ForceInvulnerable", true)
        ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer())
        ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
        SetCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
        FTL_BlotworxDragon_EnableCollision_Outer()
        BlotworxDragon_SetAttackTarget(blotworxDragon_DRAGONCHARACTER, GetPlayer())
        blotworxDragonStageNum = blotworxDragon_STAGE1
        AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_JumpToStage1)
        FireThread(StartDragonStage)
        Enable("DragonBoulderSpawnerLower2")
        Hide("SubSteppingStone")
      end
    end
  elseif (GetGlobal("FriendlyDragonPin_Redeemed") == 1) then
    TeleportToEntity(GetPlayer(), "MickeyStage1StartMarker")
    TeleportToEntity(GetPlayer2OrAI(), "OswaldStage1StartMarker")
  end
  ReplaceMusicStateOverride("Combat_Lev1")
  print("Music - start music state from checkpoint 1")
  Wait(1)
  FTL_BlotworxDragon_InitialiseLevelCheckpoint()
  return 
end
FTL_BlotworxDragon_2_CheckpointLoad = function()
  Disable("AlternateEntranceTrigger")
  Disable("MainEntranceTrigger")
  if (GetGlobal("FriendlyDragonPin_Redeemed") ~= 1) then
    if (GetGlobal("RingofFirePin_Destroyed") ~= 1) then
      if (blotworxDragon_GameType ~= "second") then
        SetCameraAttributesForPlayer("Stage1Cam")
        ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer())
        ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
        FTL_BlotworxDragon_EnableCollision_Outer()
        BlotworxDragon_SetAttackTarget(blotworxDragon_DRAGONCHARACTER, GetPlayer())
        blotworxDragonStageNum = blotworxDragon_STAGE2
        AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_JumpToStage2)
        FireThread(StartDragonStage)
        SetPropertyBool("ToonPiping", "ForceInvulnerable", true)
        print("Music - start music state from checkpoint 2")
        Enable("DragonBoulderSpawnerLower2")
        Hide("SubSteppingStone")
      end
    end
  elseif (GetGlobal("FriendlyDragonPin_Redeemed") == 1) then
    TeleportToEntity(GetPlayer(), "MickeyStage1StartMarker")
    TeleportToEntity(GetPlayer2OrAI(), "OswaldStage1StartMarker")
  end
  ReplaceMusicStateOverride("Combat_Lev2")
  Wait(1)
  FTL_BlotworxDragon_InitialiseLevelCheckpoint()
  return 
end
FTL_BlotworxDragon_3_CheckpointLoad = function()
  ForEachEntityInGroup(DestroyEntity, "Stage1RespawnCam")
  Disable("AlternateEntranceTrigger")
  Disable("MainEntranceTrigger")
  if (GetGlobal("FriendlyDragonPin_Redeemed") ~= 1) then
    if (GetGlobal("RingofFirePin_Destroyed") ~= 1) then
      if (blotworxDragon_GameType ~= "second") then
        SetHeading(blotworxDragon_DRAGONCHARACTER, 0)
        FTL_BlotworxDragon_RaiseLava1()
        AnimGBSequence("LowerPiping2", "END")
        blotworxDragonStageNum = blotworxDragon_PRECLIMB
        blotworxDragonRouteTaken = blotworxDragon_THINNER_ROUTE
        FTL_BlotworxDragon_SetUpStageArmor(blotworxDragon_PRECLIMB)
        AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_JumpToStage2_5_Neg)
        FTL_BlotworxDragon_DisableCollision_Outer()
        FireThread(StartDragonStage)
        OverrideSpawnTransform(PLAYER_ONE, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ShockPositionMarker11 03"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ShockPositionMarker11 03"))
        OverrideSpawnTransform(PLAYER_TWO, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ShockPositionMarker11 03"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.ShockPositionMarker11 03"))
        Hide("SubSteppingStone")
        Wait(1)
      end
    end
  elseif (GetGlobal("FriendlyDragonPin_Redeemed") == 1) then
    TeleportToEntity(GetPlayer(), "MickeyStage1StartMarker")
    TeleportToEntity(GetPlayer2OrAI(), "OswaldStage1StartMarker")
  end
  ReplaceMusicStateOverride("Combat_Lev2")
  print("Music - start music state from checkpoint 3")
  FTL_BlotworxDragon_InitialiseLevelCheckpoint()
  FTL_BlotworxDragon_RaiseLava2x()
  return 
end
FTL_BlotworxDragon_4_CheckpointLoad = function()
  Disable("AlternateEntranceTrigger")
  Disable("MainEntranceTrigger")
  if (GetGlobal("FriendlyDragonPin_Redeemed") ~= 1) then
    if (GetGlobal("RingofFirePin_Destroyed") ~= 1) then
      if (blotworxDragon_GameType ~= "second") then
        SetHeading(blotworxDragon_DRAGONCHARACTER, 0)
        FTL_BlotworxDragon_RaiseLava1()
        OverrideSpawnTransform(PLAYER_ONE, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.PaintRouteSafety"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.PaintRouteSafety"))
        OverrideSpawnTransform(PLAYER_TWO, GetPosition("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.PaintRouteSafetyOswald"), GetFacing("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.PaintRouteSafetyOswald"))
        Enable("ThinStairsTrigger")
        ForEachEntityInGroup(AnimGBSequence, "ChamberFloor", "end")
        ForEachEntityInGroup(SetRotatorMaxSpeed, "ChamberFloor", 10)
        ForEachEntityInGroup(StartRotateToPosition, "ChamberFloor", -6)
        AnimGBSequence("DestroyableWall", "end")
        Hide("DestroyableWall")
        OswaldSetPathAction("ClimbStageStartPatrolNode")
        SetCameraAttributesForPlayer("PaintClimbCam")
        blotworxDragonStageNum = blotworxDragon_PRECLIMB
        blotworxDragonRouteTaken = blotworxDragon_PAINTER_ROUTE
        FTL_BlotworxDragon_SetUpStageArmor(blotworxDragon_PRECLIMB)
        FTL_BlotworxDragon_DisableCollision_Outer()
        AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_JumpToStage2_5_Pos)
        Unhide("GroundRubble1")
        FireThread(FTL_BlotworxDragon_ThinStairs)
        Hide("SubSteppingStone")
      end
    end
  elseif (GetGlobal("FriendlyDragonPin_Redeemed") == 1) then
    TeleportToEntity(GetPlayer(), "MickeyStage1StartMarker")
    TeleportToEntity(GetPlayer2OrAI(), "OswaldStage1StartMarker")
  end
  ReplaceMusicStateOverride("Combat_Lev2")
  print("Music - start music state from checkpoint 4")
  Wait(1)
  FTL_BlotworxDragon_InitialiseLevelCheckpoint()
  return 
end
FTL_BlotworxDragon_5_CheckpointLoad = function()
  ForEachEntityInGroup(SetPropertyBool, "Pillars", "InvulnerableToPaintThinner", false)
  blotworxDragon_FireOnceLocal = 1
  Disable("AlternateEntranceTrigger")
  Disable("MainEntranceTrigger")
  if (GetGlobal("FriendlyDragonPin_Redeemed") ~= 1) then
    if (GetGlobal("RingofFirePin_Destroyed") ~= 1) then
      if (blotworxDragon_GameType ~= "second") then
        SetCameraAttributesForPlayer("Stage3Cam")
        Enable("Stage3CamTrigger")
        FTL_BlotworxDragon_RaiseLava2()
        BlotworxDragon_SetAttackTarget(blotworxDragon_DRAGONCHARACTER, GetPlayer())
        blotworxDragonStageNum = blotworxDragon_STAGE3
        Enable("Stage3TriggerBoulderSmash")
        Enable("TriggerBoulderSmash")
        FTL_BlotworxDragon_DisableCollision_Outer()
        AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_JumpToStage3)
        FTL_BlotworxDragon_SetUpStageArmor(blotworxDragon_STAGE3)
        Unhide("RockfallAnim")
        AnimGBSequence("RockfallAnim", "COLLAPSE")
        FTL_BlotworxDragon_SpawnController()
        FireThread(StartDragonStage)
      end
    end
  elseif (GetGlobal("FriendlyDragonPin_Redeemed") == 1) then
    TeleportToEntity(GetPlayer(), "MickeyStage1StartMarker")
    TeleportToEntity(GetPlayer2OrAI(), "OswaldStage1StartMarker")
  end
  ReplaceMusicStateOverride("Combat_Lev3")
  print("Music - start music state from checkpoint 5")
  ClearAllCameraAttributes()
  Enable("Stage3CamTrigger")
  FTL_BlotworxDragon_TopCamera(GetPlayer())
  FTL_BlotworxDragon_TopCamera(GetPlayer2OrAI())
  Wait(1)
  FTL_BlotworxDragon_InitialiseLevelCheckpoint()
  return 
end
FTL_BlotworxDragon_6_CheckpointLoad = function()
  blotworxDragon_FireOnceLocal = 1
  print("Music - start music state from checkpoint 6")
  FTL_BlotworxDragon_ActivateEndCutsceneReloadCheckpoint()
  FTL_BlotworxDragon_InitialiseLevelCheckpoint()
  return 
end
FTL_BlotworxDragon_InitialiseLevelCheckpoint = function()
  FireThread(FTL_BlotworxDragon_OswaldActivity)
  Disable("AlternateEntranceTrigger")
  DestroyEntity("TriggerStartChoice")
  Disable("MainEntranceTrigger")
  ForEachEntityInGroup(Hide, "ArmorTargetMarker")
  ForEachEntityInGroup(Unhide, "ArmorTargetMarkerToon")
  Hide("SteppingStone")
  local JiminyChest = GetEntity("JiminyChest")
  if (JiminyChest ~= nil) then
    DestroyEntity(JiminyChest)
  end
  Unhide("MainEntranceDoor")
  Unhide("SubEntranceDoor")
  return 
end
FTL_BlotworxDragon_OuchBox = function(trigger, target)
  local direction = GetVelocity(target)
  direction:normalize3()
  direction = (direction * -1)
  StimulusEntity(trigger, ST_KNOCKBACK, 20, GetPosition(target), target, direction)
  return 
end
FTL_BlotworxDragon_EnableSplit = function()
  ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
  blotworxDragonCutsceneActive = false
  return 
end
FTL_BlotworxDragon_DisableCollision_Outer = function()
  Hide("HiddenCollision 02")
  return 
end
FTL_BlotworxDragon_EnableCollision_Outer = function()
  Unhide("HiddenCollision 02")
  return 
end
FTL_BlotworxDragon_Speech_Gus001 = function()
  FireSequence("ConversationGus", "FTL_BlotworxDragon_Gus_ArmorToon")
  return 
end
FTL_BlotworxDragon_Speech_Gus004 = function()
  FireSequence("ConversationGus", "FTL_BlotworxDragon_Gus_DragonWarning")
  return 
end
FTL_BlotworxDragon_Speech_Gus006 = function()
  FireSequence("ConversationGus", "FTL_BlotworxDragon_Gus_AreaUnstable")
  return 
end
FTL_BlotworxDragon_Speech_Mickey004 = function()
  FireSequence("ConversationMickey", "FTL_BlotworxDragon_Mickey_CeilingWarning")
  return 
end
FTL_BlotworxDragon_Speech_Gus009 = function()
  FireSequence("ConversationGus", "FTL_BlotworxDragon_Gus_ProjectilesIncoming")
  return 
end
FTL_BlotworxDragon_SecondVisit = function()
  local completionStyle = GetGlobal("Boss_DragonComplete")
  if (completionStyle == "thinner") then
    FTL_BlotworxDragon_ThinnerRoutePipingMakeSureItsFIXED()
  else
    ForEachEntityInGroup(AnimGBSequence, "ChamberFloor", "end")
  end
  if (GetPropertyBool("ToonPiping", "Is Painted") == false) then
    FTL_BlotworxDragon_ThinnerRoutePipingMakeSureItsFIXED()
    ForEachEntityInGroup(StopEmitters, "SteamJetThinnerPath")
    ForEachEntityInGroup(DestroyEntity, "SteamJetThinnerPath")
    Show("SteamJetThinnerPath_knockback")
    Disable("SteamJetThinnerPath_trigger")
    Enable("GreenPipeThinnerStim")
    ForEachEntityInGroup(StopEmitters, "SteamJetThinnerPath_knockback")
    Disable("SteamJetThinnerPath_trigger 02")
  end
  BlotWorxDragon_Lava_Stage4()
  blotworxDragon_GameType = "second"
  SaveCheckpoint(nil, "FTL_BlotworxDragon_ProjExitMain", "MickeyStage1StartMarker", "OswaldStage1StartMarker")
  DestroyEntity("ftl_blotworxdragon_01a_main.ftl_blotworxdragon_01a_mainlayer 01.LogicCounterMarker 01")
  if (completionStyle == "thinner") then
    AnimGBSequence("LowerPiping2", "END")
  else
    AnimGBSequence("DestroyableWall", "end")
    Unhide("GroundRubble1")
    Hide("DestroyableWall")
    ForEachEntityInGroup(ForcePainted, "ToonStairway")
    if (GetGlobal("FriendlyDragonPin_Redeemed") ~= 1) then
      if (GetGlobal("RingofFirePin_Destroyed") ~= 1) then
        if (blotworxDragon_GameType == "second") then
          SetGlobal("FriendlyDragonPin_Redeemed", 1)
        end
      end
    end
  end
  for i = 1, 3 do
    SetGlobal(("FTL_BlotworxDragon_ReprogramSpot" .. i), 1)
    Reprogram_Difficulty_Setting(("HackPoint" .. i))
  end
  FTL_BlotworxDragon_DisableCollision_Outer()
  Prefab_Projector_ChangeState("BWD_End_Projector", "Activate")
  ForEachEntityInGroup(DestroyEntity, "Stage1RespawnCam")
  ForEachEntityInGroup(DestroyEntity, "DestroyForV2")
  ClearAllCameraAttributes()
  Unhide("SubSteppingStone")
  return 
end
FTL_BlotworxDragon_JiminyAdvance = function()
  blotworxDragonJiminySkip = true
  RestrictCutSceneInput()
  FTL_BlotworxDragon_4_SaveCheckpoint()
  Disable("AlternateEntranceTrigger")
  Disable("MainEntranceTrigger")
  ForEachEntityInGroup(Hide, "ArmorTargetMarker")
  ForEachEntityInGroup(Unhide, "ArmorTargetMarkerToon")
  Hide("SteppingStone")
  local JiminyChest = GetEntity("JiminyChest")
  if (JiminyChest ~= nil) then
    DestroyEntity(JiminyChest)
  end
  Unhide("MainEntranceDoor")
  Hide("SubSteppingStone")
  Unhide("SubEntranceDoor")
  blotworxDragonStageNum = blotworxDragon_STAGE2
  AnimEvent(blotworxDragon_DRAGONCHARACTER, EVENT_JumpToStage2)
  TeleportToEntity(GetPlayer(), "PaintRouteMarker")
  TeleportToEntity(GetPlayer2OrAI(), "PaintRouteMarkerOswald")
  blotworxDragonRouteTaken = blotworxDragon_THINNER_ROUTE
  SetHeading(blotworxDragon_DRAGONCHARACTER, 0)
  blotworxDragonRouteTaken = blotworxDragon_PAINTER_ROUTE
  FTL_BlotworxDragon_SetUpStageArmor(blotworxDragon_PRECLIMB)
  FTL_BlotworxDragon_DisableCollision_Outer()
  Hide("DestroyableWall")
  Unhide("GroundRubble1")
  ClearAllCameraAttributes()
  Enable("ThinStairsTrigger")
  StartFadeIn(0.800000011920929)
  FTL_BlotworxDragon_DisableCollision_Outer()
  OswaldSetPathAction("ClimbStageStartPatrolNode")
  Print("FTL_BlotworxDragon_JiminyAdvance: Starting the dragon on stage 2. Lets see if this works")
  BlotworxDragon_StartStage2(blotworxDragon_DRAGONCHARACTER)
  EnableSplitScreen(true)
  wait(0.800000011920929)
  ShowHud()
  wait(0.25)
  BlotworxDragon_StartStage2(blotworxDragon_DRAGONCHARACTER)
  blotworxDragonStageNum = blotworxDragon_PRECLIMB
  ShowReticleOnly()
  UnrestrictCutSceneInput()
  CameraReset()
  wait(5)
  ShakeCamera(2, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  wait(2)
  AudioPostEventOn(GetPlayer(), "Play_sfx_lavarise")
  FTL_BlotworxDragon_RaiseLava1()
  FireThread(FTL_BlotworxDragon_OswaldActivity)
  return 
end
G3_FTL_BulbSwitch = function(reg_0, reg_1)
end
FTL_BlotworxDragon_TopCamera = function(activator)
  Wait(0.30000001192092896)
  ClearCameraAttributesForPlayer("Stage3CamFree", activator)
  SetCameraAttributesForPlayer("Stage3CamFree", activator)
  return 
end
FTL_BlotworxDragon_KillStupidProjectorSetup = function()
  local data = GetPrefabData("AlternateProjectorMarker")
  data.StartsInactive = true
  Prefab_Projector_ChangeState("StartProjectorMarker", "Deactivate")
  Prefab_Projector_ChangeState("AlternateProjectorMarker", "Deactivate")
  return 
end
FTL_BlotworxDragon_ProjExit = function(target)
  wait(0.10000000149011612)
  if (GetGlobal("FriendlyDragonPin_Redeemed") ~= 1) then
    if (GetGlobal("RingofFirePin_Destroyed") ~= 1) then
      if (blotworxDragon_GameType ~= "second") then
        local data = GetPrefabData(target)
        Quest_SetCriticalPath("Critical_Boss1", "Critical_Boss1_1")
        SetPropertyBool("ToonPiping", "ForceInvulnerable", true)
        FTL_BlotworxDragon_DisableCollision_Outer()
        DestroyEntity("TriggerStartChoice")
        SetPositionFloat(blotworxDragon_DRAGONCHARACTER, 0, -20, 0)
        data.StartsInactive = true
        Prefab_Projector_ChangeState("StartProjectorMarker", "Deactivate")
        Prefab_Projector_ChangeState("AlternateProjectorMarker", "Deactivate")
        if (GetConfigVariableBool("InDemoMode") == true) then
          UnlockAllAbilities()
          DecrementAbilityDisabled(GetPlayer(), "camera")
          Prefab_Projector_ChangeState("StartProjectorMarker", "Deactivate")
        end
        if (GetGlobal("MSN_Arcade_FromArcade") == 1) then
          Prefab_Projector_ChangeState("StartProjectorMarker", "Deactivate")
        end
        local position = "main"
        if (GetPropertyString(target, "EntityGroups", 1) == "BWD_End_Projector") then
          position = "top"
        elseif (GetPropertyString(target, "EntityGroups", 1) == "AlternateProjectorMarker") then
          position = "alternate"
        elseif (position == "main") then
          FTL_BlotworxDragon_IntroIGC(target, position)
        end
        if (position ~= "top") then
          ClearAllCameraAttributes()
          SetCameraAttributesForPlayer("ftl_blotworxdragon_01a_main.Marker(CameraOverride) 01")
        end
      end
    end
  end
  if (completionStyle == "thinner") then
    AnimGBSequence("LowerPiping2", "END")
    FTL_BlotworxDragon_ThinnerRoutePipingMakeSureItsFIXED()
    ClearAllCameraAttributes()
    ClearCameraAttributes("Stage1Cam")
    ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer())
    ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
  elseif (completionStyle == "paint") then
    ForEachEntityInGroup(AnimGBSequence, "ChamberFloor", "end")
    ClearAllCameraAttributes()
    ClearCameraAttributes("Stage1Cam")
    ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer())
    ClearCameraAttributesForPlayer("Stage1Cam", GetPlayer2OrAI())
  end
  if (GetPropertyBool("ToonPiping", "Is Painted") == false) then
    FTL_BlotworxDragon_ThinnerRoutePipingMakeSureItsFIXED()
  end
  return 
end
FTL_BlotworxDragon_LoadGulch = function()
  UnrestrictCutSceneInput()
  ClearOverridesAndLoadLevel("FTL_Gulch.TRAN_toMadDocLab")
  return 
end
FTL_BlotworxDragon_LoadGulchAlt = function()
  UnrestrictCutSceneInput()
  ClearOverridesAndLoadLevel("FTL_Gulch.TRAN_toMadDocLabSho")
  return 
end

