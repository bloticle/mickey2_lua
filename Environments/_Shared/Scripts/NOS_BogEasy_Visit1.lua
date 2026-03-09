local musicevent = 0
NOS_BogEasy_AlwaysSetup = function(target)
  Print("___Function: NOS_BogEasy_AlwaysSetup")
  Print("___Bog Easy First Visit Setup Function")
  Print("__Setting Global to First Visit")
  SetGlobal("NOS_BogEasy_FirstVisit", 1)
  Print("__Getting FirstVisitProgress Global")
  local v1Progress = GetGlobal("NOS_BogEasy_FirstVisitProgress")
  Print(("__v1Progress Value: " .. v1Progress))
  if (0 < GetGlobal("NOS_BogEasy_MetairieFoddersLeft")) then
    Disable("NOS_BogEasy_EnterInterior_ShantyShop")
  end
  Disable("NOS_BogEasy_EnterInterior_Forge")
  local doTeleport = true
  if (v1Progress == 0) then
    NOS_BogEasy_Visit1_OpeningIGC(target, "0")
    SetGlobal("NOS_BogEasy_FirstVisitProgress", 1)
    Quest_SetCriticalPath("Critical_BogEasy", "Critical_BogEasy_3")
    doTeleport = false
  end
  if (doTeleport == true) then
    if (LevelManager_GetCurrentState() == "nos_bogeasy.shantytown_v1") then
      Print("__We're in shanty town!")
      if (GetGlobal("NOS_BogEasy_ShantyTown_CheckpointLocation") == 0) then
        Print("__We're at the projector!")
      elseif (GetGlobal("NOS_BogEasy_ShantyTown_CheckpointLocation") == 1) then
        Print("__We're at the shanty shop!")
      end
    end
  end
  return 
end
NOS_BogEasy_Visit1_OpeningIGC = function(target, _Section)
  Print(("__Function: NOS_BogEasy_Visit1_OpeningIGC, _Section: " .. tostring(_Section)))
  if (_Section == "0") then
    if (musicevent == 0) then
      MusicPostEventOn(GetPlayer(), "Play_MX_BOG")
      ReplaceMusicStateOverride("Boss_Intro")
      musicevent = 1
      Print("Started music event and set state to Boss_Intro")
    end
    Print("__Playing IGC")
    PlayIGC("IGC_NOS_Shanty_Intro")
    wait(0.800000011920929)
    wait(1.8600000143051147)
    wait(6.340000152587891)
    ReplaceMusicStateOverride("None")
    Print("IGC music starts, level music stops")
    wait(3)
    Print("music hook 2 - rest of IGC music can go here with a delay")
    wait(9.5)
    wait(3)
    wait(1)
    wait(0.5)
    wait(1.3300000429153442)
    wait(3.0999999046325684)
    wait(0.800000011920929)
  elseif (musicevent == 0) then
    MusicPostEventOn(GetPlayer(), "Play_MX_BOG")
    musicevent = 1
    Print("Started music event from NOS_BogEasy_Visit1_OpeningIGC")
  end
  return 
end
PostIGC_NOS_Shanty_Intro = function(target)
  Print("__Function: PostIGC_NOS_Shanty_Intro")
  Prefab_BeetleworxSpawner_Base_Doors("ShantyTownBwxSpawner", "Close")
  DestroyEntity("MetairieIGC_Crawler")
  DestroyEntity("MetairieIGC")
  TeleportToEntity("NOS_BogEasy_Pedestrian_Metairie", "MetairieGoTo")
  SetPropertyFloat("NOS_BogEasy_Pedestrian_Metairie", "UsableRadius", 0)
  Unhide("NOS_BogEasy_Pedestrian_Metairie")
  Prefab_BeetleworxSpawner_Base_Activate("ShantyTownBwxSpawner")
  TeleportToEntity("MetairieFodder1", "MetairieIGC_CrawlerEndPoint")
  RemoveAllMusicStateOverride()
  NOS_BogEasy_TeleportPlayersToMSSProjectorLocation("CHECKPOINT_Projector_MeanStreet")
  NOS_BogEasy_SaveCheckpoint("CHECKPOINT_Projector_MeanStreet")
  Print("resume level music")
  return 
end
NOS_BogEasy_MetairieV1Streamed = function(target)
  Print("__Function: NOS_BogEasy_MetairieV1Streamed")
  local MachineState = GetGlobal("NOS_BogEasy_Spawner_ShantyTown_State")
  if (MachineState == -1) then
    Hide(target)
    DisableMotion(target)
  elseif (MachineState == 0) then
    TeleportToEntity(target, "MetairieGoTo")
    SetPropertyFloat(target, "UsableRadius", 0)
    DisableMotion(target)
  elseif (MachineState == 1) then
    if (GetGlobal("NOS_Gus_MetairieHelped_Played") == 0) then
      TeleportToEntity(target, "MetairieGoTo")
      wait(2)
      if (GetGlobal("NOS_BogEasy_Spawner_ShantyTown_State") == 1) then
        NOS_BogEasy_Visit1_ShantyMachineDisabled(nil, "Disabled")
      elseif (GetGlobal("NOS_BogEasy_Spawner_ShantyTown_State") == 2) then
        NOS_BogEasy_Visit1_ShantyMachineDisabled(nil, "Hacked")
        TeleportToEntity(target, "MetairieAfterPatrolNode")
        SetPropertyFloat(target, "UsableRadius", 2)
        EnableMotion(target)
      end
    else
      TeleportToEntity(target, "MetairieAfterPatrolNode")
      SetPropertyFloat(target, "UsableRadius", 2)
      EnableMotion(target)
    end
  end
  return 
end
NOS_BogEasy_Visit1_MetairieRunToShop = function(target)
  Print("__Function: NOS_BogEasy_Visit1_MetairieRunToShop")
  EnableMotion(target)
  SetNextPatrolNode(target, "MetairieGoTo")
  wait(0.5)
  AnimGBSequence("NOS_BogEasy_ShantyShopDoor", "open")
  wait(3)
  AnimGBSequence("NOS_BogEasy_ShantyShopDoor", "close")
  ClearNextPatrolNode("MetairieFodder1")
  DisableMotion("NOS_BogEasy_Pedestrian_Metairie")
  SetPropertyFloat("NOS_BogEasy_Pedestrian_Metairie", "PatrolSpeed", 1)
  TeleportToEntity("NOS_BogEasy_Pedestrian_Metairie", "MetairieGoTo")
  ClearNextPatrolNode(target)
  return 
end
NOS_BogEasy_Visit1_DestroyFodder = function(target)
  Print("___Function: NOS_BogEasy_DestroyFodder")
  Print(("__Activator: " .. GetName(_activator())))
  Kill(_activator())
  return 
end
NOS_BogEasy_Visit1_ShantyMachineDisabled = function(target, _State)
  Print(("__Function: NOS_BogEasy_Visit1_ShantyMachineDisabled, _State: " .. tostring(_State)))
  while true do
    if (not IsAnySequencePlaying()) then
      break
    end
    Print("__Waiting for other sequences to stop")
    wait(0.10000000149011612)
  end
  Unhide("NOS_BogEasy_Pedestrian_Metairie")
  ForceSequence("NOS_BogEasy_Gus", "NOS_Gus_MetairieHelped")
  SetGlobal("NOS_Gus_MetairieHelped_Played", 1)
  EnableMotion("NOS_BogEasy_Pedestrian_Metairie")
  ClearNextPatrolNode("NOS_BogEasy_Pedestrian_Metairie")
  wait(0.10000000149011612)
  AnimGBSequence("NOS_BogEasy_ShantyShopDoor", "open")
  SetNextPatrolNode("NOS_BogEasy_Pedestrian_Metairie", "MetairieAfterPatrolNode")
  SetPropertyFloat("NOS_BogEasy_Pedestrian_Metairie", "UsableRadius", 2)
  if (_State == "Hacked") then
    NOS_BogEasy_PrebuildMagicShop(target)
  end
  NOS_BogEasy_HandleHintNodes(nil, "ShantyShop")
  return 
end
NOS_BogEasy_Visit1_MetairieOutOfBuilding = function(target)
  Print("__Function: NOS_BogEasy_Visit1_MetairieOutOfBuilding")
  if (InDoorTrigger[3] == 0) then
    AnimGBSequence("NOS_BogEasy_ShantyShopDoor", "close")
  end
  ClearNextPatrolNode("NOS_BogEasy_Pedestrian_Metairie")
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  NOS_BogEasy_SaveCheckpoint("CHECKPOINT_Projector_MeanStreet")
  return 
end
NOS_BogEasy_Visit1_LouisShackMachineDisabled = function(target, _State)
  Print(("__Function: NOS_BogEasy_Visit1_LouisShackMachineDisabled, _State: " .. tostring(_State)))
  if (_State == "Hacked") then
    NOS_BogEasy_PrebuildMagicShop(target)
  end
  NOS_BogEasy_HandleHintNodes(nil, "Airlock")
  return 
end
NOS_BogEasy_Visit1_OldTownMachineDisabled = function(target, _State)
  Print(("__Function: NOS_BogEasy_Visit1_OldTownMachineDisabled, _State: " .. tostring(_State)))
  if (_State == "Hacked") then
    NOS_BogEasy_PrebuildMagicShop(target)
    if (GetGlobal("NOS_BogEasy_FirstVisitProgress") == 4) then
      Print("__We've already broken the wall! dont send!")
    else
      TimerEnable("BwxToPatrolTimer")
      ClearNextPatrolNode("OldTownFodder1")
      wait(0.10000000149011612)
      SetPropertyFloat("OldTownFodder1", "PatrolSpeed", 3)
      SetNextPatrolNode("OldTownFodder1", "SpinnerCloseMarker")
      ClearNextPatrolNode("OldTownFodder2")
      SetNextPatrolNode("OldTownFodder2", "IanInitialNode")
      if (_State == "DisableAndDeath") then
        StartEmitters("OldTownBwxLightSparks")
      end
    end
  elseif (_State == "DisableAndDeath") then
    StartEmitters("OldTownBwxLightSparks")
  end
  return 
end
NOS_BogEasy_ResendBwxToPatrol = function(target)
  Print("__Function: NOS_BogEasy_ResendBwxToPatrol")
  SetNextPatrolNode("OldTownFodder1", "SpinnerCloseMarker")
  return 
end
NOS_BogEasy_PrebuildMagicShop = function(target)
  Print("__Function: NOS_BogEasy_PrebuildMagicShop")
  SetGlobal("NOS_BogEasy_MagicShop_VisitOnePrebuild", (GetGlobal("NOS_BogEasy_MagicShop_VisitOnePrebuild") + 1))
  Print(("NOS_BogEasy_MagicShop_VisitOnePrebuild CHANGED: " .. tostring(GetGlobal("NOS_BogEasy_MagicShop_VisitOnePrebuild"))))
  return 
end
NOS_BogEasy_Visit1_SpinnerBreakWall = function(target)
  Print("__Function: NOS_BogEasy_Visit1_SpinnerBreakWall")
  SetGlobal("NOS_BogEasy_FirstVisitProgress", 4)
  TimerDisable("BwxToPatrolTimer")
  FireUser1("BlotAlleyWall_FireworksTrigger")
  AnimEvent("OldTownFodder1", EVENT_WalkAttack_Start)
  wait(1.600000023841858)
  AnimGBSequence("NOS_BogEasy_BlotAlleyWall", "break")
  StartEmitters("BlotAlleyWallCrumble")
  wait(0.20000000298023224)
  DestroyEntity("FireworksSign_BlotAlleyWall")
  FireThread(NOS_BogEasy_WallDownSequence, target)
  wait(1.7999999523162842)
  StopEmitters("BlotAlleyWallCrumble")
  wait(0.5)
  DestroyEntity("NOS_BogEasy_BlotAlleyWall")
  ClearNextPatrolNode("OldTownFodder1")
  Quest_SetCriticalPath("Critical_BogEasy", "Critical_BogEasy_4")
  DisableGuardianHint("GusHintMarker_OldTown")
  NOS_BogEasy_HandleHintNodes(nil, "BTAProjector")
  NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
  return 
end
NOS_BogEasy_WallDownSequence = function(target)
  Print("__Function: NOS_BogEasy_WallDownSequence")
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  FireSequence("NOS_BogEasy_Gus", "NOS_Gus_WallDown")
  return 
end
NOS_BogEasy_BwxDoorStimmed = function(target, _event)
  Print("__Function: NOS_BogEasy_BwxDoorStimmed")
  if StimulusEvent_HasStimulusType(_event, ST_CROSSED_STREAM) then
    SetGlobal("NOS_BogEasy_FirstVisitProgress", 4)
    AnimGBSequence("NOS_BogEasy_BlotAlleyWall", "break")
    StartEmitters("BlotAlleyWallCrumble")
    FireUser1("BlotAlleyWall_FireworksTrigger")
    wait(0.20000000298023224)
    DestroyEntity("FireworksSign_BlotAlleyWall")
    wait(1.7999999523162842)
    StopEmitters("BlotAlleyWallCrumble")
    wait(0.5)
    DestroyEntity("NOS_BogEasy_BlotAlleyWall")
    FireThread(NOS_BogEasy_WallDownSequence, target)
    Quest_SetCriticalPath("Critical_BogEasy", "Critical_BogEasy_4")
    DisableGuardianHint("GusHintMarker_OldTown")
    NOS_BogEasy_HandleHintNodes(nil, "BTAProjector")
    NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
  end
  return 
end
NOS_BogEasy_Visit1_FodderDestroyed = function(target, _WhoseFodder, _WhichFodder)
  Print(((("___Function: NOS_BogEasy_Visit1_FodderDestroyed, _WhoseFodder: " .. _WhoseFodder) .. ", _WhichFodder: ") .. tostring(_WhichFodder)))
  if (_WhoseFodder == "Tom") then
    SetGlobal("NOS_BogEasy_TomFoddersLeft", (GetGlobal("NOS_BogEasy_TomFoddersLeft") - 1))
    if (GetGlobal("NOS_BogEasy_TomFoddersLeft") == 0) then
      ForceSequence("NOS_BogEasy_Gus", "NOS_Gus_Visit1_HoppersHandled")
    end
  end
  return 
end
NOS_BogEasy_Visit1_TomBarks = function(target, _Event)
  Print(("___Function: NOS_BogEasy_Visit1_StopBoatAtDocks, _Event: " .. _Event))
  if (_Event == "First") then
    ForceSequence("NOS_BogEasy_Pedestrian_TrainConductorTom_V1", "NOS_Tom_Panic")
    Disable(target)
  elseif (_Event == "Second") then
    ForceSequence("NOS_BogEasy_Pedestrian_TrainConductorTom_V1", "NOS_Tom_Panic2")
  end
  return 
end
NOS_BogEasy_Visit1_IanStreamed = function(target)
  Print("__Function: NOS_BogEasy_Visit1_IanStreamed")
  Print("__DISABLING IAN MOTION__")
  DisableMotion(target)
  Print(("__NOS_BogEasy_FirstVisitProgress: " .. tostring(GetGlobal("NOS_BogEasy_FirstVisitProgress"))))
  if (GetGlobal("NOS_BogEasy_FirstVisitProgress") ~= 2) then
    if (3 <= GetGlobal("NOS_BogEasy_FirstVisitProgress")) then
      DestroyEntity("IanBarkTrigger 01")
      DestroyEntity("IanBarkTrigger 01_2")
      DestroyEntity("IanBarkTrigger 02")
      DestroyEntity("IanBarkTrigger 02_2")
      DestroyEntity("IanBarkTrigger 03")
      DestroyEntity(target)
      if (3 < GetGlobal("NOS_BogEasy_FirstVisitProgress")) then
        DestroyEntity("NOS_BogEasy_BlotAlleyWall")
      end
    else
      Print("__how are we in here? Not at proper place in first visit")
    end
  end
  return 
end
NOS_BogEasy_CheckOldTownSpawnerWall = function(target)
  Print("__Function: NOS_BogEasy_CheckOldTownSpawnerWall")
  local data = GetPrefabData(target)
  if (GetGlobal("NOS_BogEasy_Spawner_OldTown_State") == 2) then
    if (GetGlobal("NOS_BogEasy_FirstVisitProgress") ~= 4) then
      while true do
        if (not (data.BeetleworxNumSpawned[1] == 0)) then
          break
        end
        wait(0.10000000149011612)
      end
      Print((("__Will Send: " .. tostring("OldTownFodder1")) .. " to the wall!"))
      TimerEnable("BwxToPatrolTimer")
      ClearNextPatrolNode("OldTownFodder1")
      wait(0.10000000149011612)
      SetPropertyFloat("OldTownFodder1", "PatrolSpeed", 3)
      SetNextPatrolNode("OldTownFodder1", "SpinnerCloseMarker")
    end
  end
  return 
end
local Section2Done = true
NOS_BogEasy_Visit1_IanBark = function(target, _Section)
  Print(("___Function: NOS_BogEasy_Visit1_IanBark, _Section: " .. tostring(_Section)))
  if (_Section == "0") then
    ForceSequence("NOS_BogEasy_Ghost_Ian", "NOS_Ian_Beckon")
  elseif (_Section == "1") then
    UnpauseAllAI()
    while true do
      if (not (IsAnySequencePlaying() == true)) then
        break
      end
      wait(0.20000000298023224)
    end
    Section2Done = false
    AnimVarInt("NOS_BogEasy_Ghost_Ian", VAR_Cutscene, 1)
    AnimEvent("NOS_BogEasy_Ghost_Ian", EVENT_Start_Cutscene)
    wait(4)
    Hide("NOS_BogEasy_Ghost_Ian")
    TeleportToEntity("NOS_BogEasy_Ghost_Ian", "IanInitialNode")
    Unhide("NOS_BogEasy_Ghost_Ian")
    EnableMotion("NOS_BogEasy_Ghost_Ian")
    AnimEvent("NOS_BogEasy_Ghost_Ian", EVENT_Force_Idle)
    wait(0.10000000149011612)
    ClearNextPatrolNode("NOS_BogEasy_Ghost_Ian")
    wait(0.10000000149011612)
    SetNextPatrolNode("NOS_BogEasy_Ghost_Ian", "IanInitialNode")
    Section2Done = true
  elseif (_Section == "2") then
    ForEachEntityInGroup(DestroyEntity, "IanBarkTriggers")
    NOS_BogEasy_HandleHintNodes(nil, "OldTown")
    while true do
      if (not (IsAnySequencePlaying() == true)) then
        break
      end
      wait(0.20000000298023224)
    end
    while true do
      if (not (Section2Done == false)) then
        break
      end
      Print("__Section2 Not done!")
      wait(0.10000000149011612)
    end
    Print("__Section2 done!")
    ForceSequence("NOS_BogEasy_Gus", "NOS_Gus_IanThroughWall")
  elseif (_Section == "3") then
    UnpauseAllAI()
    ClearNextPatrolNode("NOS_BogEasy_Ghost_Ian")
    wait(0.10000000149011612)
    SetNextPatrolNode("NOS_BogEasy_Ghost_Ian", "IanInitialNode2")
  elseif (_Section == "4") then
    Hide("NOS_BogEasy_Ghost_Ian")
  elseif (_Section == "5") then
    SetGlobal("NOS_BogEasy_FirstVisitProgress", 3)
    NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
  elseif (_Section == "6") then
    AnimVarInt("NOS_BogEasy_Ghost_Ian", VAR_Cutscene, 2)
    AnimEvent("NOS_BogEasy_Ghost_Ian", EVENT_Start_Cutscene)
    wait(2)
    Hide("NOS_BogEasy_Ghost_Ian")
    TeleportToEntity("NOS_BogEasy_Ghost_Ian", "IanFirstPositionMarker")
    AnimEvent("NOS_BogEasy_Ghost_Ian", EVENT_Force_Idle)
    Unhide("NOS_BogEasy_Ghost_Ian")
    DisableMotion("NOS_BogEasy_Ghost_Ian")
  end
  return 
end
Blitz_Culling = function(reg_0, reg_1)
  return 
end
