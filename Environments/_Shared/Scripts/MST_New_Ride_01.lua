debug_SkipS1 = false
crushForce = 1
NextSpawnIndex = 0
LastActivator = "nil"
LastSafeTarget = "mst_maddoctornewride_01a_main.DynamicProp 02"
GrabTarget = 1
ObstacleSpeed = 0
ObstacleSpeedWhenRunning = 0
TrackIsRunning = 1
tankLevel = 0
SmashLeft = true
SmashRight = true
LevelEndCutscene = false
HandSteamBusy = false
irisOpen = false
LowerFunctionRan = false
SpawnCupStep = 0
SpawnCupThreshold = 1
LowerSectionLoading = false
NewRide_TossMickey = false
NRH_ATK_Smash = 0
NRH_ATK_Zap = 1
NRH_ATK_Grab = 2
NRH_ATK_Random = 3
NewRide_Name = ".AI_NewRideHand"
NewRide_inSlamAttack = false
NewRideFinished = false
NewRide_inStunned = false
NewRide_lastTest = 0
OswaldTarget = 1
debug_Healthset = function(value)
  tankLevel = value
  NewRide_TankMonitor()
  return 
end
debug_ThinIGC = function()
  tankLevel = -40
  NewRide_TankMonitor()
  return 
end
debug_Thinwin = function()
  tankLevel = -80
  NewRide_TankMonitor()
  return 
end
debug_paintIGC = function()
  tankLevel = 40
  NewRide_TankMonitor()
  return 
end
debug_paintwin = function()
  tankLevel = 80
  NewRide_TankMonitor()
  return 
end
debug_Skip = function()
  wait(14)
  SetGlobal("Boss_NewRideStyle", 0)
  wait(2)
  NewRide_GotoLowerSection()
  return 
end
debug_SkipS2 = function()
  wait(14)
  SetGlobal("Boss_NewRideStyle", 1)
  wait(2)
  NewRide_GotoLowerSection()
  return 
end
NewRide_TestBark = function(reg_0, reg_1)
end
NewRide_SetSpiderTop = function()
  AnimEvent(SpiderBoss, EVENT_TopSection)
  AnimEvent(SpiderBoss, EVENT_DoctorReact)
  return 
end
ArcadeSetupfunc = function()
  SetGlobal("MSN_Arcade_FromArcade", 1)
  return 
end
NewRide_LevelStart = function()
  MusicPostEventOn(GetPlayer(), "Play_MX_BossNewRide")
  ReplaceMusicStateOverride("Combat_Lev1")
  Print("Started music event and stage 1 state from NewRide_LevelStart")
  SetCameraAttributesForPlayer(".CamMainTracking")
  Print("********************************level start")
  wait(0)
  if (GetGlobal("MSN_Arcade_FromArcade") == 1) then
    TimerStart(300)
  else
    Quest_SetCriticalPath("Critical_Boss3", "Critical_Boss3_1")
    NewRide_Streaming("both")
  end
  Unmute()
  TeleportToEntity(".BuildingPipes", "mst_maddoctornewride_01a_main.Buildings")
  SetCameraAttributesForPlayer(".CamMainTracking")
  Print("********************************level start 1")
  if (debug_SkipS1 == true) then
    wait(14)
    SetGlobal("Boss_NewRideStyle", 0)
    wait(2)
    NewRide_GotoLowerSection()
  else
    Print("********************************level start 2")
    ForEachEntityInGroup(Hide, "SpiderLegPhysicsGroup")
    NewRide_ClearAttackSequence(NewRide_Name)
    NewRide_AddAttackSequence(NewRide_Name, NRH_ATK_Smash)
    NewRide_AddAttackSequence(NewRide_Name, NRH_ATK_Smash)
    NewRide_AddAttackSequence(NewRide_Name, NRH_ATK_Zap)
    NewRide_SetNoofZapShots(NewRide_Name, 2)
    NewRide_AddAttackSequence(NewRide_Name, NRH_ATK_Grab)
    NewRide_SetSingleAttackDelay(NewRide_Name, 6)
    wait(1)
    SetCameraAttributesForPlayer(".CamMainTracking")
    FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 01", "MST_NewRide_UpperStart")
    NewRide_LevelStartHand()
  end
  return 
end
NewRide_LevelStartHand = function()
  Print("********************************level start Hand func 1")
  StartFadeOut(0)
  StartFadeIn(0.800000011920929)
  if (debug_SkipS1 == false) then
    SetCameraAttributesForPlayer(".CamMainTracking")
    Print("********************************level start Hand func 2")
    if (GetGlobal("VTL_Oasis_DaisyQuest_PhotoBrokeRide") == 1) then
      Enable("DaisyDocQuestMarker")
    end
    Print("********************************level start Hand func 3")
    NewRide_SetTrackRotator(NewRide_Name, ".Track")
    NewRide_SetTrackToon(NewRide_Name, 0, "mst_maddoctornewride_01a_main.TrackToon 01")
    NewRide_SetTrackToon(NewRide_Name, 1, "mst_maddoctornewride_01a_main.TrackToon 02")
    NewRide_SetTrackToon(NewRide_Name, 2, "mst_maddoctornewride_01a_main.TrackToon 03")
    NewRide_SetTrackToon(NewRide_Name, 3, "mst_maddoctornewride_01a_main.TrackToon 04")
    NewRide_SetTrackToon(NewRide_Name, 4, "mst_maddoctornewride_01a_main.TrackToon 05")
    NewRide_SetTrackToon(NewRide_Name, 5, "mst_maddoctornewride_01a_main.TrackToon 06")
    NewRide_SetTrackToon(NewRide_Name, 6, "mst_maddoctornewride_01a_main.TrackToon 07")
    NewRide_SetTrackToon(NewRide_Name, 7, "mst_maddoctornewride_01a_main.TrackToon 08")
    NewRide_SetTrackToon(NewRide_Name, 8, "mst_maddoctornewride_01a_main.TrackToon 09")
    NewRide_SetTrackToon(NewRide_Name, 9, "mst_maddoctornewride_01a_main.TrackToon 10")
    NewRide_SetLaserPointer(NewRide_Name, "mst_maddoctornewride_01a_fx.LaserAttackPointer 01")
    Print("********************************level start Hand func 4")
    wait(0.5)
    ShowHud()
    wait(0.5)
    Print("********************************PRE Saving Checkpoint")
    if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
      Print("********************************Saving Checkpoint")
      NewRide_Zone01a_SaveCheckpoint()
      SetCameraAttributesForPlayer(".CamMainTracking")
      Print("********************************Saving Checkpoint 2 *******************")
    end
    wait(2)
    ClearCameraAttributesForPlayer(".CamMainTracking")
    SetCameraAttributesForPlayer(".CamMainTracking")
    FireThread(NewRide_PerFrameUpdate)
    FireThread(NewRide_OswaldBehavior)
  end
  return 
end
NewRide_SetArmLevel = function(stim)
  local tankInput = math.floor((tankLevel / 10))
  local mPaint = tankInput
  local mThinner = (-tankInput)
  if (0 < tankInput) then
    if (stim == "PAINT") then
      Show((".ArmSegmentPaint" .. mPaint))
      AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_DrsNewRideHand_armlight")
    else
      Hide((".ArmSegmentPaint" .. mPaint))
      if (tankInput < 0) then
        if (stim == "THINNER") then
          Show((".ArmSegmentThinner" .. mThinner))
          AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_DrsNewRideHand_armlight")
        else
          Hide((".ArmSegmentThinner" .. mThinner))
        end
      end
    end
  elseif (tankInput < 0) then
    if (stim == "THINNER") then
      Show((".ArmSegmentThinner" .. mThinner))
      AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_DrsNewRideHand_armlight")
    else
      Hide((".ArmSegmentThinner" .. mThinner))
    end
  end
  return 
end
NewRide_IrisStimulus = function(self, event)
  local paintOrThinnerAmount = 0.5
  if (StimulusEvent_SourceStimulusAlias(event) == "Guardian") then
    paintOrThinnerAmount = 10
  end
  if StimulusEvent_HasStimulusType(event, ST_THINNER) then
    if (HandSteamBusy == false) then
      if (irisOpen == true) then
        HandSteamBusy = true
        tankLevel = (tankLevel - paintOrThinnerAmount)
        if ((tankLevel % 10) == 0) then
          NewRide_SetArmLevel("THINNER")
        end
        NewRide_TankMonitor()
        StartEmitters("mst_maddoctornewride_01a_main.BlastConeThinner 01")
        StartEmitters("mst_maddoctornewride_01a_main.SpatterImpactFX 01")
        StartEmitters("mst_maddoctornewride_01a_main.SpatterImpactFX 02")
        HandSteamBusy = false
        if StimulusEvent_HasStimulusType(event, ST_PAINT) then
          if (HandSteamBusy == false) then
            if (irisOpen == true) then
              HandSteamBusy = true
              tankLevel = (tankLevel + paintOrThinnerAmount)
              if ((tankLevel % 10) == 0) then
                NewRide_SetArmLevel("PAINT")
              end
              NewRide_TankMonitor()
              StartEmitters("mst_maddoctornewride_01a_main.BlastConePaint 01")
              StartEmitters("mst_maddoctornewride_01a_main.SpatterImpactFX 01")
              StartEmitters("mst_maddoctornewride_01a_main.SpatterImpactFX 02")
              HandSteamBusy = false
              if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
                if (irisOpen == false) then
                  if (NewRide_ClawCanBePaintedThinned(NewRide_Name) == false) then
                    irisOpen = true
                    StartEmitters("mst_maddoctornewride_01a_main.BlastSphereElectric 01")
                    AudioPostEventOn("mst_maddoctornewride_01a_main.AI_NewRideHand 01", "Play_sfx_newRideHand_blastSphere")
                    AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 1)
                    wait(1)
                    StopEmitters("mst_maddoctornewride_01a_main.BlastSphereElectric 01")
                    wait(3)
                    if (NewRide_inStunned == false) then
                      AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 0)
                      irisOpen = false
                    end
                  end
                end
              end
            end
          end
        elseif StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
          if (irisOpen == false) then
            if (NewRide_ClawCanBePaintedThinned(NewRide_Name) == false) then
              irisOpen = true
              StartEmitters("mst_maddoctornewride_01a_main.BlastSphereElectric 01")
              AudioPostEventOn("mst_maddoctornewride_01a_main.AI_NewRideHand 01", "Play_sfx_newRideHand_blastSphere")
              AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 1)
              wait(1)
              StopEmitters("mst_maddoctornewride_01a_main.BlastSphereElectric 01")
              wait(3)
              if (NewRide_inStunned == false) then
                AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 0)
                irisOpen = false
              end
            end
          end
        end
      end
    end
  elseif StimulusEvent_HasStimulusType(event, ST_PAINT) then
    if (HandSteamBusy == false) then
      if (irisOpen == true) then
        HandSteamBusy = true
        tankLevel = (tankLevel + paintOrThinnerAmount)
        if ((tankLevel % 10) == 0) then
          NewRide_SetArmLevel("PAINT")
        end
        NewRide_TankMonitor()
        StartEmitters("mst_maddoctornewride_01a_main.BlastConePaint 01")
        StartEmitters("mst_maddoctornewride_01a_main.SpatterImpactFX 01")
        StartEmitters("mst_maddoctornewride_01a_main.SpatterImpactFX 02")
        HandSteamBusy = false
        if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
          if (irisOpen == false) then
            if (NewRide_ClawCanBePaintedThinned(NewRide_Name) == false) then
              irisOpen = true
              StartEmitters("mst_maddoctornewride_01a_main.BlastSphereElectric 01")
              AudioPostEventOn("mst_maddoctornewride_01a_main.AI_NewRideHand 01", "Play_sfx_newRideHand_blastSphere")
              AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 1)
              wait(1)
              StopEmitters("mst_maddoctornewride_01a_main.BlastSphereElectric 01")
              wait(3)
              if (NewRide_inStunned == false) then
                AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 0)
                irisOpen = false
              end
            end
          end
        end
      end
    end
  elseif StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    if (irisOpen == false) then
      if (NewRide_ClawCanBePaintedThinned(NewRide_Name) == false) then
        irisOpen = true
        StartEmitters("mst_maddoctornewride_01a_main.BlastSphereElectric 01")
        AudioPostEventOn("mst_maddoctornewride_01a_main.AI_NewRideHand 01", "Play_sfx_newRideHand_blastSphere")
        AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 1)
        wait(1)
        StopEmitters("mst_maddoctornewride_01a_main.BlastSphereElectric 01")
        wait(3)
        if (NewRide_inStunned == false) then
          AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 0)
          irisOpen = false
        end
      end
    end
  end
  return 
end
NewRide_UpdateMovingRideSpeed = function()
  if (TrackIsRunning == 0) then
    if (math.abs(ObstacleSpeedWhenRunning) < 30) then
      ObstacleSpeed = 0
    end
  else
    if (ObstacleSpeed == 0) then
      if (ObstacleSpeedWhenRunning ~= 0) then
        AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_DrsNewRideHand_PlatTurn_Start")
      end
    end
    ObstacleSpeed = ObstacleSpeedWhenRunning
  end
  SetRotatorMaxSpeed("mst_maddoctornewride_01a_main.Track", ObstacleSpeed)
  SetRotatorMaxSpeed("mst_maddoctornewride_01a_main.Gear", ((-ObstacleSpeed) * 6))
  SetRotatorMaxSpeed("mst_maddoctornewride_01a_main.Ride", (ObstacleSpeed * 4))
  SetRotatorMaxSpeed("mst_maddoctornewride_01a_main.MasksInert", (ObstacleSpeed * 10))
  if (ObstacleSpeed == 0) then
    AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_DrsNewRideHand_PlatTurn_Stop")
  end
  if (math.abs(ObstacleSpeed) <= 10) then
    AudioPostEventOn(GetPlayer(), "Set_Track_Speed_01")
  elseif (math.abs(ObstacleSpeed) <= 15) then
    AudioPostEventOn(GetPlayer(), "Set_Track_Speed_02")
  elseif (math.abs(ObstacleSpeed) <= 20) then
    AudioPostEventOn(GetPlayer(), "Set_Track_Speed_03")
  else
    AudioPostEventOn(GetPlayer(), "Set_Track_Speed_04")
  end
  return 
end
NewRide_SetMovingRideSpeed = function(desiredSpeed)
  ObstacleSpeedWhenRunning = desiredSpeed
  NewRide_UpdateMovingRideSpeed()
  return 
end
NewRide_HeadStimulus = function(self, _event)
  local validStimTypes = {ST_KNOCKBACK, ST_ELECTRIC, ST_FAIRY, ST_DRAIN_ELECTRIC}
  local target = GetPropertyEntity(self, "Parent Entity", 0)
  Boss_SendStimulus(self, validStimTypes, _event, target, 20)
  return 
end
NewRide_CrushedByAnvil = function(self, anvil)
  local target = GetPropertyEntity(self, "Parent Entity", 0)
  RaiseCrushedByAnvilEvent(anvil, target)
  return 
end
NewRide_SendStimulus = function(self, validStimTypes, event, target)
  if IsValidHandle(target) then
    for index, stimulusType in ipairs(validStimTypes) do
      if StimulusEvent_HasStimulusType(event, stimulusType) then
        local direction = GetVelocity(target)
        direction:normalize3()
        direction = (direction * -1)
        StimulusEntity(self, stimulusType, 20, GetPosition(target), target, direction)
      end
    end
  end
  return 
end
NewRide_RingPaint = function()
  Enable("mst_maddoctornewride_01a_main.TeaCupSpawnTriggerLeft")
  Disable("mst_maddoctornewride_01a_main.TeaCupSpawnTriggerRight")
  return 
end
NewRide_RingThinner = function()
  Enable("mst_maddoctornewride_01a_main.TeaCupSpawnTriggerRight")
  Disable("mst_maddoctornewride_01a_main.TeaCupSpawnTriggerLeft")
  return 
end
NewRide_TankMonitor = function()
  local thinnerAmount = (1 - (tankLevel / -80))
  local paintAmount = (1 - (tankLevel / 80))
  AnimVarFloat(".AI_NewRideHand", VAR_PaintFilled, paintAmount)
  AnimVarFloat(".AI_NewRideHand", VAR_ThinnerFilled, thinnerAmount)
  if (tankLevel <= -25) then
    if (-30 < tankLevel) then
      if (NewRide_lastTest ~= -25) then
        NewRide_lastTest = -25
        NewRide_RingThinner()
      end
    end
  elseif (tankLevel <= -30) then
    if (-40 < tankLevel) then
      if (NewRide_lastTest ~= -30) then
        NewRide_lastTest = -30
        NewRide_SetMovingRideSpeed(5)
        NewRide_ForceBreakStun(NewRide_Name)
      end
    end
  elseif (tankLevel <= -40) then
    if (-60 < tankLevel) then
      if (NewRide_lastTest ~= -40) then
        NewRide_lastTest = -40
        NewRide_ForceBreakGrab(NewRide_Name)
        if (SmashLeft == true) then
          SmashLeft = false
          InIGCRandomDialogBlock = 1
          FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 01", "MST_NewRide_Gus_007")
          NewRide_SetMovingRideSpeed(0)
          Prefab_GrabCameraNifFancy("mst_maddoctornewride_01a_main.grabcameraniffancy 04.HavokGBAnimation 01")
          NewRide_SetSingleAttackDelay(NewRide_Name, 2)
        end
        wait(20)
        NewRide_SetMovingRideSpeed(10)
        NextSpawnIndex = 2
      end
    end
  elseif (tankLevel <= -60) then
    if (-80 < tankLevel) then
      if (NewRide_lastTest ~= -60) then
        NewRide_lastTest = -60
        NextSpawnIndex = 3
        NewRide_SetMovingRideSpeed(15)
        NewRide_ForceBreakStun(NewRide_Name)
        FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 01", "gen_gus_312")
      end
    end
  elseif (tankLevel <= -80) then
    if (NewRide_lastTest ~= -80) then
      NewRide_lastTest = -80
      NewRide_ForceBreakGrab(NewRide_Name)
      NewRide_SetMovingRideSpeed(20)
      ForEachEntityInGroup(Unhide, "SpiderLegPhysicsGroup")
      FireSequence("GusConvoV1", "gen_gus_310")
      InIGCRandomDialogBlock = 1
      NewRideFinished = true
      NewRide_SetMovingRideSpeed(0)
      FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 01", "MST_NewRide_Gus_009")
      NewRidePath = "Thinner"
      ForEachEntityInGroup(Hide, ".ThinnerEffectS1")
      Prefab_GrabCameraNifFancy("mst_maddoctornewride_01a_main.grabcameraniffancy 02.HavokGBAnimation 01")
      wait(0.800000011920929)
      ForEachEntityInGroup(ForcePainted, "TrackToon")
      ForEachEntityInGroup(DestroyEntity, "TeaCupChild")
    end
  elseif (25 <= tankLevel) then
    if (tankLevel < 30) then
      if (NewRide_lastTest ~= 25) then
        NewRide_lastTest = 25
        NewRide_RingPaint()
      end
    end
  elseif (30 <= tankLevel) then
    if (tankLevel < 40) then
      if (NewRide_lastTest ~= 30) then
        NewRide_lastTest = 30
        NewRide_SetMovingRideSpeed(-5)
        NewRide_ForceBreakStun(NewRide_Name)
        NextSpawnIndex = 2
      end
    end
  elseif (40 <= tankLevel) then
    if (tankLevel < 60) then
      if (NewRide_lastTest ~= 40) then
        NewRide_lastTest = 40
        NewRide_ForceBreakGrab(NewRide_Name)
        if (SmashRight == true) then
          SmashRight = false
          InIGCRandomDialogBlock = 1
          NewRide_SetMovingRideSpeed(0)
          Prefab_GrabCameraNifFancy("mst_maddoctornewride_01a_main.grabcameraniffancy 05.HavokGBAnimation 01")
          NewRide_SetSingleAttackDelay(NewRide_Name, 2)
        end
        wait(20)
        NewRide_SetMovingRideSpeed(-10)
        NextSpawnIndex = 2
      end
    end
  elseif (60 <= tankLevel) then
    if (tankLevel < 80) then
      if (NewRide_lastTest ~= 60) then
        NewRide_lastTest = 60
        NextSpawnIndex = 4
        NewRide_SetMovingRideSpeed(-15)
        NewRide_ForceBreakStun(NewRide_Name)
        FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 01", "gen_gus_312")
      end
    end
  elseif (80 <= tankLevel) then
    if (NewRide_lastTest ~= 80) then
      NewRide_lastTest = 80
      NewRide_ForceBreakGrab(NewRide_Name)
      NewRide_SetMovingRideSpeed(-20)
      ForEachEntityInGroup(Unhide, "SpiderLegPhysicsGroup")
      NewRideFinished = true
      InIGCRandomDialogBlock = 1
      FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 01", "MST_NewRide_Gus_009")
      NewRide_SetMovingRideSpeed(0)
      NewRidePath = "Paint"
      ForEachEntityInGroup(Hide, ".ThinnerEffectS1")
      Prefab_GrabCameraNifFancy("mst_maddoctornewride_01a_main.grabcameraniffancy 03.HavokGBAnimation 01")
      wait(0.800000011920929)
      ForEachEntityInGroup(ForcePainted, "TrackToon")
      ForEachEntityInGroup(DestroyEntity, "TeaCupChild")
    end
  end
  return 
end
NewRide_StopTrack = function()
  SetRotatorMaxSpeed("mst_maddoctornewride_01a_main.Track", 0)
  return 
end
NewRide_DestroyThinnerWall = function()
  LevelEndCutscene = true
  NewRide_SetMovingRideSpeed(0)
  wait(2)
  SetRotatorMaxSpeed("mst_maddoctornewride_01a_main.MasksInert", -300)
  wait(6.300000190734863)
  ForceSpawn(".PaintSmashSpawner", 1)
  NewRide_EnableLeftSteam()
  wait(6)
  Hide(".WallSmashThinner")
  return 
end
NewRide_DestroyPaintWall = function()
  LevelEndCutscene = true
  Show("mst_maddoctornewride_01a_main.HealthLarge_w_pickup_TronPete 02")
  NewRide_SetMovingRideSpeed(0)
  wait(2)
  SetRotatorMaxSpeed("mst_maddoctornewride_01a_main.MasksInert", 300)
  wait(6)
  DestroyEntity("mst_maddoctornewride_01a_main.SteamDoorUpperCollision")
  NewRide_TossMickey = true
  return 
end
NewRide_EnableLeftSteam = function()
  StartEmitters("mst_maddoctornewride_01a_fx.SteamJet04")
  StartEmitters("mst_maddoctornewride_01a_fx.SteamJet03")
  StartEmitters("mst_maddoctornewride_01a_fx.SteamJet02")
  Enable("mst_maddoctornewride_01a_main.SteamTriggerLeft")
  return 
end
NewRide_DisableLeftSteam = function()
  StopEmitters("mst_maddoctornewride_01a_fx.SteamJet04")
  StopEmitters("mst_maddoctornewride_01a_fx.SteamJet03")
  StopEmitters("mst_maddoctornewride_01a_fx.SteamJet02")
  Disable("mst_maddoctornewride_01a_main.SteamTriggerLeft")
  return 
end
NewRide_DamageThrowBack = function(trigger, target)
  local direction = GetVelocity(target)
  direction:normalize3()
  direction = (direction * -1)
  StimulusEntity(trigger, ST_KNOCKBACK, 30, GetPosition(target), target, direction)
  return 
end
NewRide_SpawnThinner = function(self)
  local spawn_index = 1
  if (GetNumPlayers() == 2) then
    spawn_index = math.random(1, 2)
  end
  SetPropertyInt(self, "Index To Spawn", spawn_index)
  ForceSpawn(self, 1)
  return 
end
NewRide_SpawnPaint = function(self)
  SetPropertyInt(self, "Index To Spawn", 0)
  ForceSpawn(self, 1)
  return 
end
NewRide_SetLastSpawned = function(self)
  wait(0.009999999776482582)
  local ObjectPosition = GetPosition(LastActivator)
  SetPositionFloat(self, ObjectPosition.x, (ObjectPosition.y + 0.05000000074505806), ObjectPosition.z)
  SetParentEntity(self, LastActivator)
  return 
end
NewRide_SwapTeaCup = function(self, activator)
  Print("********************************MDDBF TEACUP SPAWNER START")
  local groupName = GetPropertyString(activator, "EntityGroups", 0)
  if (groupName == "TeaCupParent") then
    Print("********************************MDDBF TEACUP SPAWNER 1")
    local numChildren = GetElementCount(activator, "Child Entities")
    Print("********************************MDDBF TEACUP SPAWNER 2")
    for i = 0, numChildren do
      Print("********************************MDDBF TEACUP SPAWNER 3")
      local childEntity = GetChildEntityByIndex(activator, i)
      ClearParent(childEntity)
      DestroyEntity(childEntity)
      Print("********************************MDDBF TEACUP SPAWNER 4")
    end
    Print("********************************MDDBF TEACUP SPAWNER 5")
    if (SpawnCupStep == SpawnCupThreshold) then
      Print("********************************MDDBF TEACUP SPAWNER 6")
      SpawnCupStep = 0
      local LastActivatorX = GetName(activator)
      LastActivator = tostring(LastActivatorX)
      SetPropertyInt(self, "Index To Spawn", NextSpawnIndex)
      ForceSpawn(self, 1)
      Print("********************************MDDBF TEACUP SPAWNER 7")
      if (NextSpawnIndex == 0) then
        NextSpawnIndex = 1
        Print("********************************MDDBF TEACUP SPAWNER 8")
      else
        NextSpawnIndex = 0
        Print("********************************MDDBF TEACUP SPAWNER 9")
      end
      Print("********************************MDDBF TEACUP SPAWNER 10")
    else
      SpawnCupStep = (SpawnCupStep + 1)
      Print("********************************MDDBF TEACUP SPAWNER 11")
    end
    Print("********************************MDDBF TEACUP SPAWNER 12")
  end
  Print("********************************MDDBF TEACUP SPAWNER 13")
  return 
end
NewRide_Zone01a_SaveCheckpoint = function()
  if (GetGlobal("MSN_Arcade_FromArcade") == 0) then
    SaveCheckpoint(GetPlayer(), "NRH_Zone01a_CheckpointLoad", "SpawnTarget_M")
    Print("SAVED CHECKPOINT")
  end
  return 
end
NewRide_Zone01a_CheckpointLoad = function()
end
NewRide_DeathByThinner = function()
  Print("Death by thinner START")
  SetGlobal("Boss_NewRideStyle", true)
  NewRide_EnableStreamingStuff()
  Hide("mst_maddoctornewride_01a_main.ThinnerPool 01")
  Show("mst_maddoctornewride_01a_main.ThinnerPoolWhirl")
  wait(6)
  SetSplineFollowerInitialSpeed("mst_maddoctornewride_01a_main.ThinnerPoolWhirl", 1)
  Print("Death by thinner END")
  return 
end
NewRide_DeathByPaint = function()
  Print("Death by Paint Start")
  SetGlobal("Boss_NewRideStyle", false)
  NewRide_EnableStreamingStuff()
  SetRotatorMaxSpeed("mst_maddoctornewride_01a_main.MasksInert", 300)
  wait(10)
  SetSplineFollowerInitialSpeed("mst_maddoctornewride_01a_main.ThinnerPoolWhirl", 1)
  Print("Death by Paint END")
  return 
end
NewRide_EnableStreamingStuff = function()
  Print("NewRide_EnableStreamingStuff START")
  ForEachEntityInGroup(DestroyEntity, "Stage1ConvoTriggers")
  Show(GetName(".MaskRotator 01"))
  Show(GetName(".MaskRotator 02"))
  Show(GetName(".MaskRotator 03"))
  Show(GetName(".MaskRotator 04"))
  Show(GetName(".MaskRotator 05"))
  Show(GetName(".MaskRotator 06"))
  Enable(GetName(".MaskRotator 01"))
  Enable(GetName(".MaskRotator 02"))
  Enable(GetName(".MaskRotator 03"))
  Enable(GetName(".MaskRotator 04"))
  Enable(GetName(".MaskRotator 05"))
  Enable(GetName(".MaskRotator 06"))
  Enable(GetName(".NRH_SpiderHeadTrigger"))
  Enable(GetName(".NRH_SpiderLeg1Tip_Trigger"))
  Enable(GetName(".NRH_SpiderLeg2Tip_Trigger"))
  Enable(GetName(".NRH_SpiderLeg3Tip_Trigger"))
  Enable(GetName(".NRH_SpiderLeg4Tip_Trigger"))
  Enable(GetName(".NRH_SpiderLeg5Tip_Trigger"))
  Enable(GetName(".NRH_SpiderLeg6Tip_Trigger"))
  Enable("mst_maddoctornewride_01a_main_player.mst_maddoctorspider_v3 01.AI_MadDoctorSpider 01")
  Show("mst_maddoctornewride_01a_streaming.StreamingWalls")
  StartEmitters("mst_maddoctornewride_01a_streaming.StreamingSection")
  Hide(".MasksInert")
  NewRide_MoveToNextSafeLocation()
  LowerSectionLoading = true
  Disable("mst_maddoctornewride_01a_main.TriggerOswald 01")
  Disable("mst_maddoctornewride_01a_main.TriggerOswald 02")
  Disable("mst_maddoctornewride_01a_main.TriggerOswald 03")
  Disable("mst_maddoctornewride_01a_main.TriggerOswald 04")
  Print("NewRide_EnableStreamingStuff END")
  return 
end
NewRide_SetSpawnTarget = function(activator)
  local LastSafeTargetX = GetName(activator)
  LastSafeTarget = tostring(LastSafeTargetX)
  return 
end
NewRide_UpdateSpawnTarget = function(target_m, target_o)
  while true do
    local ObjectPosition = GetPosition(LastSafeTarget)
    SetParentEntity(GetPropertyString(target_m, "EntityGroups", 0), LastSafeTarget)
    SetParentEntity(GetPropertyString(target_o, "EntityGroups", 0), LastSafeTarget)
    if (ObstacleSpeed <= 0) then
      SetPositionFloat(GetPropertyString(target_m, "EntityGroups", 0), (ObjectPosition.x - 3.5), (ObjectPosition.y + 0.10000000149011612), ObjectPosition.z)
      SetPositionFloat(GetPropertyString(target_o, "EntityGroups", 0), (ObjectPosition.x - 4.5), (ObjectPosition.y + 0.10000000149011612), ObjectPosition.z)
    else
      SetPositionFloat(GetPropertyString(target_m, "EntityGroups", 0), (ObjectPosition.x - 3.5), (ObjectPosition.y + 0.10000000149011612), ObjectPosition.z)
      SetPositionFloat(GetPropertyString(target_o, "EntityGroups", 0), (ObjectPosition.x - 4.5), (ObjectPosition.y + 0.10000000149011612), ObjectPosition.z)
    end
    wait(0.25)
  end
  return 
end
NewRide_MoveToNextSafeLocation = function()
  TeleportToEntity(GetPlayer(), "SpawnTarget_M")
  TeleportToEntity(GetOswaldAI(), "SpawnTarget_O")
  ClearCameraAttributesForPlayer(".CamMainTracking")
  SetCameraAttributesForPlayer(".CamMainTracking")
  return 
end
NewRide_SafeRespawn = function(activator)
  TeleportToEntity(activator, "SpawnTarget_M")
  return 
end
NewRide_GotoLowerSection = function()
  AudioEffectStart("mst_maddoctornewride_02a_audio.SND_phase3_reverb")
  Print("Goto Lower Section Start")
  LowerFunctionRan = true
  Disable("mst_maddoctornewride_01a_main.SafeRespawnTrigger 01")
  Disable("mst_maddoctornewride_01a_main.SafeRespawnTrigger 02")
  LowerSectionLoading = true
  AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_newride_trans_airloop")
  QueueBrainEvent(GetOswaldAI(), BRAIN_AbortScriptedBehavior)
  TeleportToEntity(GetPlayer(), ".Falling_PositionMarkerMickey")
  TeleportToEntity(GetOswaldAI(), ".Falling_PositionMarkerOswald")
  TeleportToEntity("SpiderBoss", ".SpiderStartTarget")
  if (GetGlobal("Boss_NewRideStyle") == 1) then
    Print("Goto Lower Section Mid Thinner")
    NewRidePath = "Thinner"
    Prefab_GrabCameraNifFancy(".ThinnerStreamingCam")
  else
    Show("mst_maddoctornewride_01a_main_player.HandFake")
    Prefab_GrabCameraNifFancy(".PaintStreamingCam")
    Print("Goto Lower Section mid paint")
  end
  AudioPostEventOn(GetPlayer(), "Stop_DEM2_BGS_newride_trans_airloop")
  Show(GetName(".MaskRotator 01"))
  Show(GetName(".MaskRotator 02"))
  Show(GetName(".MaskRotator 03"))
  Show(GetName(".MaskRotator 04"))
  Show(GetName(".MaskRotator 05"))
  Show(GetName(".MaskRotator 06"))
  Print("Goto Lower Section end")
  ForEachEntityInGroup(DestroyEntity, "Stage1ConvoTriggers")
  return 
end
NewRide_FallShake = function()
  ShakeCamera(30, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  return 
end
NewRide_OswaldBehavior = function()
  OswaldStopFighting()
  while true do
    wait(8)
    if (8 < math.abs(ObstacleSpeed)) then
      if (ObstacleSpeed < 0) then
        OswaldStreamAction("mst_maddoctornewride_01a_main.switch_oswaldelectric 01.OswaldSwitchTimersLogicTimer", 3)
      else
        OswaldStreamAction("mst_maddoctornewride_01a_main.switch_oswaldelectric 02.OswaldSwitchTimersLogicTimer", 3)
      end
      wait(3)
    elseif (irisOpen == false) then
      if (LevelEndCutscene == false) then
        OswaldStreamAction("mst_maddoctornewride_01a_main.HandThrowback", 3)
        wait(3)
      end
    end
    OswaldStreamAbort()
  end
  return 
end
HandIsVulnerableOrGrabbing = function(hand)
  if (NewRide_ClawHoldingCharacter(hand) == true) then
    return true
  end
  return false
end
NewRide_SetGrabCam = function()
  local hand = "mst_maddoctornewride_01a_main.AI_NewRideHand 01"
  while true do
    while true do
      wait(0.25)
      if (not (NewRide_ClawHoldingCharacter(hand) ~= true)) then
        break
      end
    end
    if (GrabTarget == 2) then
      ClearCameraAttributesForPlayer(".CamMainTracking", GetPlayer2OrAI())
      SetCameraAttributesForPlayer(".CamGrab", GetPlayer2OrAI())
    else
      ClearCameraAttributesForPlayer(".CamMainTracking", GetPlayer())
      SetCameraAttributesForPlayer(".CamGrab", GetPlayer())
    end
    while true do
      wait(0.25)
      if (not (NewRide_ClawHoldingCharacter(hand) ~= false)) then
        break
      end
    end
    wait(2)
    if (GrabTarget == 2) then
      ClearCameraAttributesForPlayer(".CamGrab", GetPlayer2OrAI())
      SetCameraAttributesForPlayer(".CamMainTracking", GetPlayer2OrAI())
    else
      ClearCameraAttributesForPlayer(".CamGrab", GetPlayer())
      SetCameraAttributesForPlayer(".CamMainTracking", GetPlayer())
    end
    wait(0.009999999776482582)
  end
  return 
end
ZapProjectileCollided = function(projectileEntity)
  AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_DrsNewRideHand_atck_zap_land")
  local stimDamage = 1
  local targetPos = GetPosition(projectileEntity)
  local stimRadius = 1.5
  StimulusSphereWithAlias(NewRide_Name, ST_PHYSICAL, stimDamage, targetPos, stimRadius, "BossAttackStimulus")
  StimulusSphereWithAlias(NewRide_Name, ST_KNOCKBACK, stimDamage, targetPos, stimRadius, "BossAttackStimulus")
  return 
end
NewRide_UpdateShadow = function()
  local handBoss = "mst_maddoctornewride_01a_main.AI_NewRideHand 01"
  local trackPosition = GetPosition(".Track")
  local irisPosition = NewRide_GetIrisPosition(handBoss)
  local dy = (irisPosition.y - trackPosition.y)
  local lowHeight = 1
  local highHeight = 5
  local lowScale = 4
  local highScale = 2
  local shadowScale = lowScale
  if (highHeight < dy) then
    shadowScale = highScale
  elseif (lowHeight < dy) then
    shadowScale = (lowScale + (((highScale - lowScale) * (dy - lowHeight)) / (highHeight - lowHeight)))
  end
  local shadowScaleVec = vector4(shadowScale, shadowScale, shadowScale)
  SetShadowScale(handBoss, shadowScaleVec)
  return 
end
NewRide_PerFrameUpdate = function()
  while true do
    wait(0.029999999329447746)
    NewRide_UpdateShadow()
    if NewRide_ClawCanBePaintedThinned(NewRide_Name) then
      AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 1)
    end
  end
  return 
end
NewRide_OnAnimEvent = function(self, _event)
  local eventType = AnimEvent_Type(_event)
  OswaldTarget = math.random(1, 2)
  if (NewRideFinished == false) then
    if (eventType == EVENT_StartTrack) then
      TrackIsRunning = 1
      NewRide_UpdateMovingRideSpeed()
    elseif (eventType == EVENT_StopTrack) then
      TrackIsRunning = 0
      NewRide_UpdateMovingRideSpeed()
    elseif (eventType == EVENT_SlamAttack) then
      NewRide_inSlamAttack = true
      FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 02", "MST_NewRide_Doctor_005")
      if (GetNumPlayers() == 2) then
        if (OswaldTarget == 2) then
          NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
        else
          NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
          if (eventType == EVENT_IsInStunned) then
            if (eventType == EVENT_ZapAttack) then
              FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 01", "MST_NewRide_Gus_003")
            end
            NewRide_inStunned = true
            irisOpen = true
            AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 1)
            if (GetNumPlayers() == 2) then
              if (OswaldTarget == 2) then
                NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
              else
                NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
                if (eventType == EVENT_IsInIdle) then
                  NewRide_inStunned = false
                  irisOpen = false
                  AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 0)
                else
                  if (eventType == EVENT_GrabAttack) then
                    NewRide_inSlamAttack = false
                    FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 01", "MST_NewRide_Gus_002")
                    if (GetNumPlayers() == 2) then
                      if (OswaldTarget == 2) then
                        NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
                        GrabTarget = 2
                      else
                        NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
                        GrabTarget = 1
                        if (eventType == EVENT_Start_AttackMelee) then
                          local target = NewRide_GetHeldCharacter(self)
                          StimulusEntity(self, ST_PHYSICAL, crushForce, GetPosition(target), target)
                          if (GetNumPlayers() == 2) then
                            if (OswaldTarget == 2) then
                              NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
                            else
                              NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
                            end
                          end
                        end
                      end
                    end
                  end
                  if (eventType == EVENT_Start_AttackMelee) then
                    local target = NewRide_GetHeldCharacter(self)
                    StimulusEntity(self, ST_PHYSICAL, crushForce, GetPosition(target), target)
                    if (GetNumPlayers() == 2) then
                      if (OswaldTarget == 2) then
                        NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
                      else
                        NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
                      end
                    end
                  end
                end
              end
            end
          end
          if (eventType == EVENT_IsInIdle) then
            NewRide_inStunned = false
            irisOpen = false
            AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 0)
          else
            if (eventType == EVENT_GrabAttack) then
              NewRide_inSlamAttack = false
              FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 01", "MST_NewRide_Gus_002")
              if (GetNumPlayers() == 2) then
                if (OswaldTarget == 2) then
                  NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
                  GrabTarget = 2
                else
                  NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
                  GrabTarget = 1
                  if (eventType == EVENT_Start_AttackMelee) then
                    local target = NewRide_GetHeldCharacter(self)
                    StimulusEntity(self, ST_PHYSICAL, crushForce, GetPosition(target), target)
                    if (GetNumPlayers() == 2) then
                      if (OswaldTarget == 2) then
                        NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
                      else
                        NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
                      end
                    end
                  end
                end
              end
            end
            if (eventType == EVENT_Start_AttackMelee) then
              local target = NewRide_GetHeldCharacter(self)
              StimulusEntity(self, ST_PHYSICAL, crushForce, GetPosition(target), target)
              if (GetNumPlayers() == 2) then
                if (OswaldTarget == 2) then
                  NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
                else
                  NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
                end
              end
            end
          end
        end
      end
    else
      if (eventType == EVENT_IsInStunned) then
        if (eventType == EVENT_ZapAttack) then
          FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 01", "MST_NewRide_Gus_003")
        end
        NewRide_inStunned = true
        irisOpen = true
        AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 1)
        if (GetNumPlayers() == 2) then
          if (OswaldTarget == 2) then
            NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
          else
            NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
            if (eventType == EVENT_IsInIdle) then
              NewRide_inStunned = false
              irisOpen = false
              AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 0)
            else
              if (eventType == EVENT_GrabAttack) then
                NewRide_inSlamAttack = false
                FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 01", "MST_NewRide_Gus_002")
                if (GetNumPlayers() == 2) then
                  if (OswaldTarget == 2) then
                    NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
                    GrabTarget = 2
                  else
                    NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
                    GrabTarget = 1
                    if (eventType == EVENT_Start_AttackMelee) then
                      local target = NewRide_GetHeldCharacter(self)
                      StimulusEntity(self, ST_PHYSICAL, crushForce, GetPosition(target), target)
                      if (GetNumPlayers() == 2) then
                        if (OswaldTarget == 2) then
                          NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
                        else
                          NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
                        end
                      end
                    end
                  end
                end
              end
              if (eventType == EVENT_Start_AttackMelee) then
                local target = NewRide_GetHeldCharacter(self)
                StimulusEntity(self, ST_PHYSICAL, crushForce, GetPosition(target), target)
                if (GetNumPlayers() == 2) then
                  if (OswaldTarget == 2) then
                    NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
                  else
                    NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
                  end
                end
              end
            end
          end
        end
      end
      if (eventType == EVENT_IsInIdle) then
        NewRide_inStunned = false
        irisOpen = false
        AnimVarFloat(".AI_NewRideHand", VAR_IrisOpen, 0)
      else
        if (eventType == EVENT_GrabAttack) then
          NewRide_inSlamAttack = false
          FireSequence("mst_maddoctornewride_01a_main.TriggerBase_Conversation 01", "MST_NewRide_Gus_002")
          if (GetNumPlayers() == 2) then
            if (OswaldTarget == 2) then
              NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
              GrabTarget = 2
            else
              NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
              GrabTarget = 1
              if (eventType == EVENT_Start_AttackMelee) then
                local target = NewRide_GetHeldCharacter(self)
                StimulusEntity(self, ST_PHYSICAL, crushForce, GetPosition(target), target)
                if (GetNumPlayers() == 2) then
                  if (OswaldTarget == 2) then
                    NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
                  else
                    NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
                  end
                end
              end
            end
          end
        end
        if (eventType == EVENT_Start_AttackMelee) then
          local target = NewRide_GetHeldCharacter(self)
          StimulusEntity(self, ST_PHYSICAL, crushForce, GetPosition(target), target)
          if (GetNumPlayers() == 2) then
            if (OswaldTarget == 2) then
              NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", true)
            else
              NewRide_TargetOswald("mst_maddoctornewride_01a_main.AI_NewRideHand 01", false)
            end
          end
        end
      end
    end
    if (NewRide_inSlamAttack ~= true) then
      local enableDamageTrigger, enableDamageTrigger = false, 1
    end
    local enableDamageTrigger, enableDamageTrigger = true, 1
    enableDamageTrigger = NewRide_EnableDamageTrigger
    enableDamageTrigger(enableDamageTrigger)
  end
  return 
end
NewRide_ForceSketched = function(target)
  ForceSketched(target)
  SetPropertyBool(target, "InvulnerableToPaintThinner", true)
  return 
end
NewRide_EnableDamageTrigger = function(enabled)
  local damageTrigger = GetChildEntityByName(NewRide_Name, "NRH_HeadTrigger")
  if (enabled == true) then
    EnableComponent(damageTrigger, "Physics Trigger Damage Component")
  else
    DisableComponent(damageTrigger, "Physics Trigger Damage Component")
  end
  return 
end
NewRide_ZapStopTrack = function(self)
  OswaldStreamAbort()
  wait(0.009999999776482582)
  OswaldJumpAction("mst_maddoctornewride_01a_main.SpawnTarget_O")
  local lastRunningSpeed = ObstacleSpeedWhenRunning
  NewRide_SetMovingRideSpeed(0)
  Enable("mst_maddoctornewride_01a_fx.ZapPoint 01")
  Enable("mst_maddoctornewride_01a_fx.ZapPoint 02")
  wait(6)
  Disable("mst_maddoctornewride_01a_fx.ZapPoint 01")
  Disable("mst_maddoctornewride_01a_fx.ZapPoint 02")
  NewRide_SetMovingRideSpeed(lastRunningSpeed)
  return 
end
NewRide_ForceTrackRotateLeft = function(self)
  Disable(self)
  SetRotatorMaxSpeed("mst_maddoctornewride_01a_main.Track", 40)
  AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_DrsNewRideHand_PlatTurn_Start")
  AudioPostEventOn(GetPlayer(), "Set_Track_Speed_04")
  wait(3)
  SetRotatorMaxSpeed("mst_maddoctornewride_01a_main.Track", ObstacleSpeedWhenRunning)
  AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_DrsNewRideHand_PlatTurn_Stop")
  Enable(self)
  return 
end
NewRide_ForceTrackRotateRight = function(self)
  Disable(self)
  SetRotatorMaxSpeed("mst_maddoctornewride_01a_main.Track", -40)
  AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_DrsNewRideHand_PlatTurn_Start")
  AudioPostEventOn(GetPlayer(), "Set_Track_Speed_04")
  wait(3)
  SetRotatorMaxSpeed("mst_maddoctornewride_01a_main.Track", ObstacleSpeedWhenRunning)
  AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_DrsNewRideHand_PlatTurn_Stop")
  Enable(self)
  return 
end
NewRide_DestroyThinProp = function(activator)
  if (GetPropertyBool(activator, "Is Painted") == true) then
    Print("************************WE ARE THINNING!!!!!")
    ForceSketched(activator)
    SetPropertyBool(activator, "InvulnerableToPaintThinner", true)
    Kill(tostring(GetName(activator)))
  end
  return 
end
NewRide_RestoreProp = function(activator)
  SetPropertyBool(activator, "InvulnerableToPaintThinner", false)
  return 
end
NewRide_2DTransitionSetup = function(method)
  Print("NewRide_2DTransitionSetup")
  if (GetGlobal("MSN_Arcade_FromArcade") == 1) then
    LevelManager_SetCurrentState("MST_NewRide.ArcadeUpper")
  else
    LevelManager_SetCurrentState("MST_NewRide.state0")
  end
  WaitForLevelLoad()
  ShowHud()
  TeleportToEntity(GetPlayer(), "mst_maddoctornewride_01a_main.grabcamerafancy 01.FancyCameraStart 01")
  TeleportToEntity(GetPlayer2OrAI(), "mst_maddoctornewride_01a_main.prefab_jumpvolumes 01.JumpVolume 02")
  if (method ~= "IGC") then
    SetLedgeGrabEnabled(GetPlayer(), true)
    SetLedgeGrabEnabled(GetPlayer2OrAI(), true)
    EnableMotion_Player(GetPlayer())
    EnableMotion_Player(GetPlayer2())
    UnrestrictCutSceneInput()
  end
  return 
end

