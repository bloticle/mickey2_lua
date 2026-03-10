IndelibleHintTimer = 0
OswaldNearPlug = 0
MickeyNearPlug = 0
Pipe2Activated = 0
WatchActive = 0
LargeFanStatus = 0
RedValveStatus = 0
RedPipeEngaged = 0
PipeFiveEngaged = 0
PipeTwoStatus = 0
PipeFourStatus = "unused"
PipeFourStart = 0
StairStepFallsColumnDropped = 0
streamedFromRF = 0
RF_DEBUG_Print = function(target, state)
  if (state == "paint") then
    Print("Rock Painted ALKWZZEJF")
  else
    Print("Rock Thinned ALDFKZZJH")
  end
  return 
end
RF_CheckVisitNumber = function(target)
  local data = GetPrefabData(target)
  if (GetGlobal("EM2_EpisodeCheck") < 2) then
    LevelManager_SetCurrentState("RBC_falls.EntranceV1")
  else
    LevelManager_SetCurrentState("RBC_falls.EntranceV2")
  end
  while true do
    if (not (LevelManager_HasStateFinishedStreaming() == false)) then
      break
    end
    wait(0.25)
  end
  while true do
    if (not (LevelManager_WaitingForStreamingSync() == false)) then
      break
    end
    Wait(0.05000000074505806)
  end
  SetupPosition(target)
  return 
end
RF_CheckVisitNumberReverse = function(target)
  local data = GetPrefabData(target)
  if (GetGlobal("EM2_EpisodeCheck") < 2) then
    LevelManager_SetCurrentState("RBC_falls.MachineRoomV1")
  else
    LevelManager_SetCurrentState("RBC_falls.MachineRoomV2")
    if (GetGlobal("OST_Moody_Destination") == 1) then
      LevelManager_SetZoneStatusActive("RBC_falls.MoodyGreene")
    end
  end
  while true do
    if (not (LevelManager_HasStateFinishedStreaming() == false)) then
      break
    end
    wait(0.25)
  end
  while true do
    if (not (LevelManager_WaitingForStreamingSync() == false)) then
      break
    end
    Wait(0.05000000074505806)
  end
  SetupPosition(target)
  return 
end
RF_CheckpointSave = function(target, location)
  if (location == "doors") then
    SetGlobal("RF_StreamDoorAutoOpen", 0)
    SaveCheckpoint(GetPlayer(), "RF_SetupZone", "CheckpointPoisition1", "CheckpointPoisition1_O")
  end
  if (location == "underfall") then
    SaveCheckpoint(GetPlayer(), "RF_SetupZone", "CheckpointPosition2", "CheckpointPosition2_O")
  end
  return 
end
RF_CheckpointSave_Delay = function(target, location)
  wait(1.5)
  if (location == "doors") then
    RF_CheckpointSave(nil, "doors")
  end
  if (location == "underfall") then
    RF_CheckpointSave(nil, "underfall")
  end
  return 
end
RF_RedChestEntranceSave = function()
  RF_CheckpointSave(nil, "doors")
  return 
end
RF_RedChestStreamingCorridorSave = function()
  RF_CheckpointSave(nil, "underfall")
  return 
end
RF_GremlinCheckpointSave = function()
  SetPropertyFloat("Gremlin_Omega", "UsableRadius", 0)
  FireUser3("GremlinCageLookatFancyCam")
  wait(1)
  FireThread(TeleportGremlinOut, "Gremlin_Omega")
  SaveCheckpoint(GetPlayer(), "RF_SetupZone", "CheckpointPoisition1", "CheckpointPoisition1_O")
  return 
end
RF_DECHardLoad = function()
  local Projector_Data = GetPrefabData("AngelProjectorStand")
  if (GetGlobal("RF_TempReverseDevil") == 1) then
    Print("HardLoad, Using Exit DEC AAASDDD")
    Projector_Data.MapLoad_SetupPosition = "IgnoreMe"
    Projector_Data.ExitFunction = "None"
  else
    Print("NoHardLoad, Using Exit projector ZZZXCCC")
    Projector_Data.MapLoad_SetupPosition = "True"
  end
  return 
end
RF_SetupZone = function(transition)
  Print("RF_SetupZone")
  if (transition ~= "DEC") then
    Hide("SupportCube")
  end
  if (GetGlobal("RF_CriticalPath") == 0) then
    SetGlobal("RF_CriticalPath", 1)
    Quest_SetCriticalPath("Critical_RBF", "Critical_RBF_1")
  end
  MusicPostEventOn(GetPlayer(), "Play_MX_RBF")
  RemoveAllMusicStateOverride()
  SetPlayStyleScoreBias(100)
  SetCombatIntensityBias(-100)
  Print("RBF music event started and set state to Exp_L, combat music disabled")
  AudioEffectStart("rbc_falls_01_shared_audio.Snd_2D_Amb")
  RF_PlayerHintMarkerUpdates()
  RBF_OnLoadSetupZone(transition)
  if (GetGlobal("RF_PipeIGCPlayed") == 1) then
    AudioPostEventOn("rbc_falls_machineroom.FallsPipeBlue", "LPF_sfx_RBF_RainbowFalls_Blue_Off")
    AudioPostEventOn("rbc_falls_machineroom.FallsPipeGreen", "LPF_sfx_RBF_RainbowFalls_Green_Off")
    AudioPostEventOn("rbc_falls_machineroom.FallsPipeOrange", "LPF_sfx_RBF_RainbowFalls_Orange_Off")
    AudioPostEventOn("rbc_falls_machineroom.FallsPipePurple", "LPF_sfx_RBF_RainbowFalls_Purple_Off")
    AudioPostEventOn("rbc_falls_machineroom.FallsPipeRed", "LPF_sfx_RBF_RainbowFalls_Red_Off")
  end
  wait(1)
  SetGlobal("RF_TempReverseDevil", 0)
  return 
end
RF_SetQuestUpdate = function(target, state)
  if (state == "2") then
    if (GetGlobal("RF_CriticalPath") == 1) then
      SetGlobal("RF_CriticalPath", 2)
      Quest_SetCriticalPath("Critical_RBF", "Critical_RBF_2")
    end
  elseif (state == "3") then
    if (GetGlobal("RF_CriticalPath") == 2) then
      SetGlobal("RF_CriticalPath", 3)
      Quest_SetCriticalPath("Critical_RBF", "Critical_RBF_3")
    end
  end
  return 
end
RBF_Music_Checkpoint_Main = function()
  SetPlayStyleScoreBias(100)
  Print("Set music state to Exp_L from trigger")
  return 
end
RBF_Music_Checkpoint_MachineRoom = function()
  SetPlayStyleScoreBias(-100)
  Print("Set music state to Exp_D from trigger")
  return 
end
RF_StopPathBlocking = function(target)
  Print("Unblocking door")
  ActivateNavMeshObstacle(target, false)
  return 
end
RF_MoodyMapMarker = function()
  if (GetGlobal("OST_Greene_Item1") == 1) then
    SetMapMarkerVisible("RF_MemoriesMapMarker", true)
  else
    SetMapMarkerVisible("RF_MemoriesMapMarker", false)
  end
  return 
end
RF_Visit2Start = function(transition)
  Print(transition)
  Print("Visit 2 Start!!")
  Unhide("AirBlastLift")
  Enable("AirBlastLift")
  SetRotatorMaxSpeed("LargeFanInertForWind", 720)
  SetSplineFollowerInitialSpeed("PipeFourPlatform", 3)
  SplineFollower_StopAtPosition("PipeFourPlatform", "PipeFourPlatformSK1", "PipeFourPlatformSK2", 1)
  ForEachEntityInPrefab(DestroyEntity, "Falls_Visit1Prefabs1")
  ForEachEntityInPrefab(DestroyEntity, "Falls_Visit1Prefabs2")
  ForEachEntityInPrefab(DestroyEntity, "Falls_Visit1Prefabs3")
  ForEachEntityInPrefab(DestroyEntity, "Falls_Visit1Prefabs4")
  ForEachEntityInPrefab(DestroyEntity, "Falls_Visit1Prefabs5")
  ForEachEntityInGroup(DestroyEntity, "Falls_Visit1")
  if (GetGlobal("RBF_AngelOrDevil") == 2) then
    StopEmitters("GeyserDevil")
    Hide("GeyserDevil")
    ForEachEntityInGroup(DestroyEntity, "GeyserDevilCollision")
    DestroyEntity("RBF_ThinnerGeyeserDamageTrig")
  else
    StopEmitters("GeyserAngel")
    Hide("GeyserAngel")
    DestroyEntity("GeyserAngelCollision")
  end
  local currentLevel = string.sub(tostring(LevelManager_GetCurrentState()), 11, -3)
  Print(("RF_Visit2Start: currentLevel = " .. currentLevel))
  if (currentLevel == "machineroom") then
    if (GetGlobal("OST_Moody_Destination") == 1) then
      LevelManager_SetZoneStatusActive("RBC_falls.MoodyGreene")
    end
    WaitForLevelLoad()
  end
  if (transition == "DEC") then
    Print("Did not load from checkpoint!")
    Prefab_DECFoopToob_Finish()
  end
  if (GetGlobal("OST_Moody_Destination") == 1) then
    LevelManager_SetZoneStatusActive("RBC_falls.MoodyGreene")
  end
  return 
end
RF_SetPipesNoCollide = function()
  SetEntitiesToNotCollide("GreenPipeCoupling", "RF_GreenPipeHandle")
  return 
end
RF_SetGeysers = function()
  if (0 < GetGlobal("RBF_AngelOrDevil")) then
    FireThread(RF_ElectricPoleMovementSignChange, "charged")
    Print("Kill geysers")
    if (GetGlobal("RBF_AngelOrDevil") == 1) then
      Print("Kill geysers angel")
      DestroyEntity("GeyserAngel")
      DestroyEntity("GeyserAngelCollision")
      if (GetGlobal("RF_ReverseDevil") == 1) then
        Print("and devil")
        DestroyEntity("GeyserDevil")
        ForEachEntityInGroup(DestroyEntity, "GeyserDevilCollision")
        DestroyEntity("RBF_ThinnerGeyeserDamageTrig")
      else
        Enable("RBF_ThinnerGeyeserDamageTrig")
        ForEachEntityInGroup(SetPropertyInt, "GeyserDevilCollision", "Collision Layer", 1)
        Print("Kill geysers devil")
        DestroyEntity("GeyserDevil")
        ForEachEntityInGroup(DestroyEntity, "GeyserDevilCollision")
        DestroyEntity("RBF_ThinnerGeyeserDamageTrig")
        if (GetGlobal("RF_ReverseAngel") == 1) then
          DestroyEntity("GeyserAngel")
          DestroyEntity("GeyserAngelCollision")
        else
          SetPropertyInt("GeyserAngelCollision", "Collision Layer", 1)
          Enable("RBF_ThinnerGeyeserDamageTrig")
          SetPropertyInt("GeyserAngelCollision", "Collision Layer", 1)
          ForEachEntityInGroup(SetPropertyInt, "GeyserDevilCollision", "Collision Layer", 1)
        end
      end
    else
      Print("Kill geysers devil")
      DestroyEntity("GeyserDevil")
      ForEachEntityInGroup(DestroyEntity, "GeyserDevilCollision")
      DestroyEntity("RBF_ThinnerGeyeserDamageTrig")
      if (GetGlobal("RF_ReverseAngel") == 1) then
        DestroyEntity("GeyserAngel")
        DestroyEntity("GeyserAngelCollision")
      else
        SetPropertyInt("GeyserAngelCollision", "Collision Layer", 1)
        Enable("RBF_ThinnerGeyeserDamageTrig")
        SetPropertyInt("GeyserAngelCollision", "Collision Layer", 1)
        ForEachEntityInGroup(SetPropertyInt, "GeyserDevilCollision", "Collision Layer", 1)
      end
    end
  else
    Enable("RBF_ThinnerGeyeserDamageTrig")
    SetPropertyInt("GeyserAngelCollision", "Collision Layer", 1)
    ForEachEntityInGroup(SetPropertyInt, "GeyserDevilCollision", "Collision Layer", 1)
  end
  return 
end
RF_RemoveIndelible = function(target)
  Print("Remove Indelible")
  SetPropertyBool(target, "Indelible", false)
  return 
end
RF_CorridorStreaming = function(target, direction)
  if (GetGlobal("EM2_EpisodeCheck") < 2) then
    LevelManager_SetCurrentState("RBC_falls.MachineRoomV1")
  else
    LevelManager_SetCurrentState("RBC_falls.MachineRoomV2")
    if (GetGlobal("OST_Moody_Destination") == 1) then
      LevelManager_SetZoneStatusActive("RBC_falls.MoodyGreene")
    end
  end
  wait(0.10000000149011612)
  RF_CheckpointSave(nil, "underfall")
  return 
end
RF_DestroyMickeyLock = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    Prefab_ToonDoorOpen("rbc_falls_01_scripting.prefab_toondoorwithinertlock 02.LeftDoorHinge")
    ActivateNavMeshObstacle(target, false)
  end
  return 
end
RF_PersistToonJunctionDoor = function(target, state)
  if (state == "thindoor") then
    SetGlobal("RF_ToonDoorsOpened", 1)
  elseif (GetGlobal("RF_ToonDoorsOpened") == 1) then
    ForEachEntityInGroup(DestroyEntity, "RF_ToonDoorLocks")
  end
  return 
end
RF_DestroyFanChamber = function(target, event)
  Print("Destroy Fan Check")
  if (GetGlobal("RF_FanDestroyed") == 0) then
    if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
      Print("FanDestroyed!")
      SetGlobal("RF_FanDestroyed", 1)
      AnimGBSequence("RF_BoulderFanFallAnim", "fall")
      ForEachEntityInGroup(StartEmitters, "RedPipeSteam")
      DestroyEntity("FanHousing")
      DestroyEntity("FanWindVolume")
      DestroyEntity("FanBase")
      DestroyEntity("PipeFireworksSpot")
      DestroyEntity("FireworksSpotEnableTrig")
      Enable("FanPathBlocker")
      FireUser1("FallRockCrushTrig")
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Large_Fan", "Stop_sfx_RBF_fan_lp_Lever")
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Large_Fan", "Stop_sfx_RBF_fan_wind")
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Large_Fan", "Play_sfx_RBF_FanHousing_Destroy")
      wait(0.25)
      ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
      DestroyEntity("LargeFanInert")
      DestroyEntity("RF_FanSign")
      RF_DestroyRedPipe()
    end
  end
  return 
end
RF_PipeRoomSetup = function()
  Disable("PipeFourFanLiftOswaldTrigger")
  Disable("PipeFourShockTrigger")
  Disable("PipeFiveShockTrigger")
  Disable("PipeTwoOswaldTriggerPaint")
  Disable("PipeTwoOswaldTriggerThinner")
  Hide("PipeFourFanLiftOswaldDecal")
  Hide("PipeFourOswaldDecal")
  Hide("PipeTwoOswaldPaintDecal")
  Hide("PipeTwoOswaldThinnerDecal")
  Hide("PipeFiveOswaldDecal")
  Hide("PipeThreeOswaldDecal")
  Disable("PipeThreeShockTrigger")
  return 
end
RF_SetupPipeColors = function(target, color, glass)
  Print(("Setting up: " .. color))
  if (color == "red") then
    SetR3MTColorReg(target, 0, vector4(0.625, 0, 0.061000000685453415, 1))
    SetR3MTColorReg(target, 1, vector4(1, 0.3580000102519989, 0.28700000047683716, 1))
  elseif (color == "orange") then
    SetR3MTColorReg(target, 0, vector4(0.7419999837875366, 0.335999995470047, 0, 1))
    SetR3MTColorReg(target, 1, vector4(1, 0.6470000147819519, 0.11800000071525574, 1))
  elseif (color == "green") then
    SetR3MTColorReg(target, 0, vector4(0, 0.44200000166893005, 0, 1))
    SetR3MTColorReg(target, 1, vector4(0.3310000002384186, 1, 0.21299999952316284, 1))
  elseif (color == "blue") then
    SetR3MTColorReg(target, 0, vector4(0, 0.4189999997615814, 0.9879999756813049, 1))
    SetR3MTColorReg(target, 1, vector4(0.7129999995231628, 0.8899999856948853, 1, 1))
  elseif (color == "purple") then
    SetR3MTColorReg(target, 0, vector4(0.42500001192092896, 0, 0.4749999940395355, 1))
    SetR3MTColorReg(target, 1, vector4(1, 0.4690000116825104, 659, 1))
  elseif (color == "bluecoupling") then
    SetR3MTConstReg(target, 1, vector4(0, 0.4189999997615814, 0.9879999756813049, 1))
  elseif (color == "neutralcoupling") then
    SetR3MTConstReg(target, 1, vector4(0.800000011920929, 0.800000011920929, 0.800000011920929, 1))
  end
  return 
end
RF_SetupPipeBucketColors = function(target, color)
  if (color == "red") then
    SetR3MTConstReg(target, 1, vector4(0.625, 0, 0.061000000685453415, 1))
  elseif (color == "orange") then
    SetR3MTConstReg(target, 1, vector4(0.7419999837875366, 0.335999995470047, 0, 1))
  elseif (color == "green") then
    SetR3MTConstReg(target, 1, vector4(0, 0.44200000166893005, 0, 1))
  elseif (color == "blue") then
    SetR3MTConstReg(target, 1, vector4(0.10100000351667404, 0.699999988079071, 1, 1))
  else
    SetR3MTConstReg(target, 1, vector4(0.42500001192092896, 0, 0.4749999940395355, 1))
  end
  return 
end
RF_PipeRoomHints = function(target)
  ForceSequence("RF_SmallWorldPete", "RF_RandomHelpBarks")
  wait(2)
  TimerReset("PipeRoomHintTimer")
  return 
end
RF_PeteCameraTug = function()
  ForceSequence("RF_SmallWorldPete", "RF_PeteGreetings")
  SetCameraAttributesForPlayer("SmallPeteCameraOverride", _activator())
  wait(3)
  ClearAllCameraAttributes(_activator(), 2)
  return 
end
RF_InvisibleTutorialFirstHint = function()
  ForceSequence("GusConversationMarker", "RF_InvisibleTutorial")
  SetCameraAttributesForPlayer("InvisibleTutorialCameraOverride", _activator())
  wait(1.2000000476837158)
  ClearAllCameraAttributes(_activator(), 2)
  return 
end
RF_IndelibleTutorialFirstHint = function()
  ForceSequence("GusConversationMarker", "RF_IndelibleTutorial")
  return 
end
RF_SetOswaldThinnerFalls = function(target, state)
  if (target == GetPlayer2OrAI()) then
    if (state == "start") then
      Print("Sketch Thinner Steps WLAEKJF")
      ForceSketched("RBF_ThinnerSteps")
    else
      Print("Paint Thinner Steps WHEJSF")
      ForcePainted("RBF_ThinnerSteps")
    end
  end
  return 
end
RF_TeeterTotterCamera = function(target)
  SetCameraAttributesForPlayer("TeeterTotterCameraOverride", target)
  return 
end
RF_HighDefaultCamera = function(target)
  local myActivator = target
  SetDefaultCameraValues(7, 40, -28, myActivator)
  SetCombatCameraValues(7, 40, -28, myActivator)
  SetTravelCameraValues(11, 40, -28, myActivator)
  return 
end
RF_NearRainbowFallsCamera = function(target)
  local myActivator = target
  SetDefaultCameraValues(11, 17, -7, myActivator)
  SetCombatCameraValues(7, 8, -1, myActivator)
  SetTravelCameraValues(11, 17, -7, myActivator)
  return 
end
RF_DefaultCamera = function(target)
  local myActivator = target
  ResetTravelCameraValues(myActivator)
  ResetCombatCameraValues(myActivator)
  ResetDefaultCameraValues(myActivator)
  return 
end
RF_UnderStairstepDefaultCamera = function(target)
  local myActivator = target
  SetTravelCameraValues(1, 8, -1, myActivator)
  SetCombatCameraValues(1, 8, -1, myActivator)
  SetDefaultCameraValues(1, 6, 0, myActivator)
  wait(0.5)
  SetTravelCameraValues(7, 8, -1, myActivator)
  SetCombatCameraValues(7, 8, -1, myActivator)
  SetDefaultCameraValues(5, 6, 0, myActivator)
  return 
end
RBF_ThinnerWaterfall = function(trigger, target, hasPlaystyle)
  Print("Prefab_ThinnerWaterfall")
  if (target == GetPlayer()) then
    Print("Prefab_ThinnerWaterfall: Player1 or Player2")
    if (GetPropertyBool(target, "Indelible") ~= true) then
      local playstyle = 0
      if (hasPlaystyle ~= nil) then
        playstyle = GetPropertyFloat(trigger, "CurrentPlaystyle")
        Print("Prefab_ThinnerWaterfall: hasPlaystyle")
      end
      Print(("Prefab_ThinnerWaterfall: playstyle: " .. playstyle))
      if (playstyle <= 0.30000001192092896) then
        Print("Prefab_ThinnerWaterfall: Player1 or Player2 are not indelible")
        if TriggeredFromAbove(trigger, target) then
          Print("Prefab_ThinnerWaterfall: From Above")
          StimulusEntity(trigger, ST_DAMAGE_LEAP, 0.033330000936985016, GetPosition(target), target)
        end
      end
    end
  end
  return 
end
RF_IndelibleInkwellHints = function()
  if (IndelibleHintTimer == 0) then
    ForceSequence("GusConversationMarker", "RF_StairSetpFallsHints")
    TimerEnable("StairStepFallsHintTimer")
    TimerReset("StairStepFallsHintTimer")
    IndelibleHintTimer = 1
  end
  return 
end
RF_IndelibleTimerFire = function()
  Print("_____________________________Resetting Timer")
  IndelibleHintTimer = 0
  TimerDisable("StairStepFallsHintTimer")
  return 
end
RBF_EnableOswaldAction = function(target, state)
  if (state == "on") then
    SetPropertyBool(target, "ActionSpotEnabled", true)
  else
    SetPropertyBool(target, "ActionSpotEnabled", false)
  end
  return 
end
RF_ImpulseDoor = function(target, state)
  Print("Impulse LAEJF")
  wait(0.10000000149011612)
  if (state == "left") then
    ApplyImpulse(target, 2000, 0, 0)
  elseif (state == "straight") then
    ApplyImpulse(target, 0, 0, 2000)
  else
    ApplyImpulse(target, -5000, 0, 0)
  end
  return 
end
playersStreaming = 0
machineStreamed = 0
RBF_StreamMachineRoom = function(target, state)
  if (machineStreamed == 0) then
    if (state == "enter") then
      playersStreaming = (playersStreaming + 1)
      if (playersStreaming == 2) then
        machineStreamed = 1
        RF_CorridorStreaming()
      end
    else
      playersStreaming = (playersStreaming - 1)
    end
  end
  return 
end
doorHandles = 0
doorUnlocked = 0
RBF_StreamDoorUnlock = function(target, state)
  Print("Streamdoor")
  if (doorUnlocked == 0) then
    if (state == "enter") then
      doorHandles = (doorHandles + 1)
      Print(doorHandles)
      if (doorHandles == 2) then
        doorUnlocked = 1
        StopAbility(GetPlayer(), "Use")
        StopAbility(GetPlayer2OrAI(), "Use")
        wait(0.10000000149011612)
        DestroyEntity("PlayerHintMarkerSnowWhiteDoor")
        SetPropertyInt("RightStreamHandle", "Collision Layer", 13)
        SetPropertyInt("LeftStreamHandle", "Collision Layer", 13)
        SetPropertyInt("LeftDoor", "Collision Layer", 13)
        SetPropertyInt("RightDoor", "Collision Layer", 13)
        SetGlobal("RF_StreamDoorAutoOpen", 1)
        SetParent("RightDoor", "RightStreamingDoor")
        SetParent("LeftDoor", "LeftStreamingDoor")
        SetParent("RightStreamHandle", "RightStreamingDoor")
        SetParent("LeftStreamHandle", "LeftStreamingDoor")
        DestroyEntity("RightHandleConstraint")
        DestroyEntity("LeftHandleConstraint")
        SetPropertyFloat("RightStreamHandle", "UsableRadius", 0)
        SetPropertyFloat("LeftStreamHandle", "UsableRadius", 0)
        UseAbilityDetach(GetPlayer2OrAI())
        OswaldStartFollowAction()
        ForEachEntityInGroup(DestroyEntity, "HandleNodes")
        SetRotatorMaxSpeed("RightStreamHandle", 90)
        SetRotatorMaxSpeed("LeftStreamHandle", 90)
        wait(1)
        while true do
          if (not (streamingdone == 0)) then
            break
          end
          wait(0.10000000149011612)
        end
        DestroyEntity("StreamHallOverrideTrig")
        ClearAllCameraAttributes()
        SetRotatorMaxSpeed("LeftStreamingDoor", 25)
        SetRotatorMaxSpeed("RightStreamingDoor", 25)
        SetPropertyInt("LeftDoor", "Collision Layer", 17)
        SetPropertyInt("RightDoor", "Collision Layer", 17)
        DoStinger("Stinger_Moment", 2)
        Print("Music - door open stinger")
      end
    else
      doorHandles = (doorHandles - 1)
    end
  end
  return 
end
RF_DisableAutoStreamDoor = function()
  Print("Disable Snow White Door Auto-Open! JJKK")
  SetGlobal("RF_StreamDoorAutoOpen", 0)
  SetGlobal("RF_TempReverseDevil", 0)
  return 
end
RF_DisableAutoStreamDoorDEC = function()
  Print("Disable Snow White Door Auto-Open! JJKK")
  Unhide("SupportCube")
  SetGlobal("RF_TempReverseDevil", 0)
  SetGlobal("RBF_ExitRBF", 1)
  SetGlobal("RF_StreamDoorAutoOpen", 0)
  return 
end
RF_DisableAutoStreamDoorProjector = function(target)
  SetGlobal("RF_StreamDoorAutoOpen", 0)
  SetGlobal("RBF_ExitRBF", 1)
  SetGlobal("RF_TempReverseDevil", 0)
  SetupPosition(target)
  return 
end
RF_StreamDoorOpenReverse = function()
  if (doorUnlocked == 0) then
    SetGlobal("RF_StreamDoorAutoOpen", 1)
    FireThread(RF_OpenStreamingDoorOnReload)
  end
  return 
end
RF_OpenStreamingDoorOnReload = function()
  if (GetGlobal("RF_StreamDoorAutoOpen") == 1) then
    doorUnlocked = 1
    SetPropertyInt("RightStreamHandle", "Collision Layer", 13)
    SetPropertyInt("LeftStreamHandle", "Collision Layer", 13)
    SetParent("RightDoor", "RightStreamingDoor")
    SetParent("LeftDoor", "LeftStreamingDoor")
    SetParent("RightStreamHandle", "RightStreamingDoor")
    SetParent("LeftStreamHandle", "LeftStreamingDoor")
    DestroyEntity("RightHandleConstraint")
    DestroyEntity("LeftHandleConstraint")
    SetPropertyFloat("RightStreamHandle", "UsableRadius", 0)
    SetPropertyFloat("LeftStreamHandle", "UsableRadius", 0)
    ForEachEntityInGroup(DestroyEntity, "HandleNodes")
    DestroyEntity("StreamHallOverrideTrig")
    SetRotatorMaxSpeed("RightStreamHandle", 90)
    SetRotatorMaxSpeed("LeftStreamHandle", 90)
    wait(1)
    SetRotatorMaxSpeed("LeftStreamingDoor", 40)
    SetRotatorMaxSpeed("RightStreamingDoor", 40)
  end
  return 
end
streamingdone = 0
RBF_MachineStreamingDone = function()
  streamingdone = 1
  return 
end
RBF_OswaldPullHandle = function(target, side)
  if (target == GetPlayer2OrAI()) then
    Print("Oswald grabbed!!!")
    if (side == "left") then
      OswaldStopFollowAction()
      OswaldSetPathAction("LeftHandleWalkTo")
    else
      OswaldStopFollowAction()
      OswaldSetPathAction("RightHandleWalkTo")
      if (side == "left") then
        OswaldStopFollowAction()
        OswaldSetPathAction("OswaldGrabRightHandle")
      else
        OswaldStopFollowAction()
        OswaldSetPathAction("OswaldGrabLeftHandle")
      end
      teleportOswald = 1
      Enable("OswaldRecoverTrig")
      wait(0.5)
      if (teleportOswald == 1) then
        TeleportToEntity(GetOswaldAI(), "StreamRecoveryTeleport")
      end
      Disable("OswaldRecoverTrig")
    end
  else
    if (side == "left") then
      OswaldStopFollowAction()
      OswaldSetPathAction("OswaldGrabRightHandle")
    else
      OswaldStopFollowAction()
      OswaldSetPathAction("OswaldGrabLeftHandle")
    end
    teleportOswald = 1
    Enable("OswaldRecoverTrig")
    wait(0.5)
    if (teleportOswald == 1) then
      TeleportToEntity(GetOswaldAI(), "StreamRecoveryTeleport")
    end
    Disable("OswaldRecoverTrig")
  end
  return 
end
teleportOswald = 0
RBF_DisableOswaldTeleport = function()
  teleportOswald = 0
  return 
end
RF_DebugOpenSnowWhite = function()
  while true do
    if (not (LevelManager_HasStateFinishedStreaming() == false)) then
      break
    end
    wait(0.25)
  end
  while true do
    if (not (LevelManager_WaitingForStreamingSync() == false)) then
      break
    end
    Wait(0.05000000074505806)
  end
  SetPropertyInt("RightStreamHandle", "Collision Layer", 13)
  SetPropertyInt("LeftStreamHandle", "Collision Layer", 13)
  SetParent("RightDoor", "RightStreamingDoor")
  SetParent("LeftDoor", "LeftStreamingDoor")
  SetParent("RightStreamHandle", "RightStreamingDoor")
  SetParent("LeftStreamHandle", "LeftStreamingDoor")
  DestroyEntity("RightHandleConstraint")
  DestroyEntity("LeftHandleConstraint")
  SetPropertyFloat("RightStreamHandle", "UsableRadius", 0)
  SetPropertyFloat("LeftStreamHandle", "UsableRadius", 0)
  ForEachEntityInGroup(DestroyEntity, "HandleNodes")
  DestroyEntity("StreamHallOverrideTrig")
  SetRotatorMaxSpeed("RightStreamHandle", 90)
  SetRotatorMaxSpeed("LeftStreamHandle", 90)
  wait(1)
  SetRotatorMaxSpeed("LeftStreamingDoor", 40)
  SetRotatorMaxSpeed("RightStreamingDoor", 40)
  return 
end
RF_SetOswaldPipePath = function(target, state)
  if (state == "shock") then
    Enable("RF_OswaldShockPipes")
    Disable("RF_OswaldStandAtPipes")
  else
    Disable("RF_OswaldShockPipes")
    Enable("RF_OswaldStandAtPipes")
  end
  return 
end
RF_PluggedIn = function()
  ForceSequence("RF_SmallWorldPete", "RF_PeteFirstPipe")
  SetGlobal("RF_PipeRoomStatus", 1)
  RF_OswaldMoveLogic()
  TimerReset("PipeRoomHintTimer")
  wait(3)
  wait(0.5)
  ForEachEntityInGroup(StartEmitters, "PipeOneSteamJet")
  AnimGBSequence("MachineGearDoor", "open")
  wait(2)
  return 
end
RF_PlayerNearPlug = function()
  if (_activator() == _player()) then
    MickeyNearPlug = 1
    Print("Mickey Near Plug")
  else
    OswaldNearPlug = 1
    Print("Oswald Near Plug")
  end
  return 
end
RF_PlayerLeavesPlug = function()
  if (_activator() == _player()) then
    MickeyNearPlug = 0
  else
    OswaldNearPlug = 0
  end
  return 
end
RF_ApproachedFalls = function()
  if (GetGlobal("RF_ApproachFalls_Played") == 0) then
    if (GetGlobal("RF_PipeIGCPlayed") == 0) then
      FireSequence("rbc_falls_streaminghallway.GusConversationMarker", "RF_ApproachFalls")
    end
  end
  return 
end
RF_FirstPipeStarted = function()
  ForceSequence("RF_SmallWorldPete", "RF_PeteFirstPipeMoving")
  SetRotatorMaxSpeed("PipeOneGear", 720)
  FireUser1("OrangePipe")
  SetGlobal("RF_PipeRoomStatus", 2)
  RF_OswaldMoveLogic()
  TimerReset("PipeRoomHintTimer")
  wait(2)
  ForEachEntityInGroup(StopEmitters, "PipeOneSteamJet")
  ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  wait(2)
  AnimGBSequence("PressurePlateCover", "open")
  SetRotatorMaxSpeed("PipeOneGear", 0)
  Enable("Pipe2PressurePlate")
  ForEachEntityInGroup(StartEmitters, "PipeTwoSteamJet")
  return 
end
RF_PipesCameraOverrides = function(override)
  if (OswaldNearPlug == 1) then
    SetCameraAttributesForPlayer(override, GetPlayer2())
  end
  if (MickeyNearPlug == 1) then
    SetCameraAttributesForPlayer(override, GetPlayer())
  end
  return 
end
RF_PipesCameraOverridesClear = function()
  ClearAllCameraAttributes(GetPlayer(), 2)
  ClearAllCameraAttributes(GetPlayer2(), 2)
  return 
end
RF_StartPipe2 = function()
  ForceSequence("RF_SmallWorldPete", "RF_SecondPipeEngaged")
  ForEachEntityInGroup(StopEmitters, "PipeTwoSteamJet")
  SetGlobal("RF_PipeRoomStatus", 21)
  RF_OswaldMoveLogic()
  TimerReset("PipeRoomHintTimer")
  wait(2)
  FireUser1("Pipe2")
  Pipe2Activated = 1
  return 
end
RF_OswaldSwtichPipe2 = function(target, side)
  if (GetGlobal("RF_FallsPipesConnected") == 1) then
    if (side == "left") then
      RF_FixGreenPipe()
    else
      RF_DestroyPipeGreen()
    end
  end
  return 
end
RF_FanWindVolumePush = function()
  SetExternalVelocity(_activator(), vector4(-6, 0, -2.5), 0.8999999761581421)
  return 
end
RF_EnviornmentalWatchActive = function()
  if (WatchActive == 0) then
    WatchActive = 1
    Disable("FanWindVolume")
    Hide("FanWindVolume")
  end
  return 
end
RF_EnviornmentalWatchDeactive = function(target)
  DeactivateWatchSketch(target, 1)
  WatchActive = 0
  if (LargeFanStatus == 0) then
    Enable("FanWindVolume")
    Unhide("FanWindVolume")
  end
  return 
end
RF_WatchDeactivateExpire = function(target)
  WatchActive = 0
  if (LargeFanStatus == 0) then
    Enable("FanWindVolume")
    Unhide("FanWindVolume")
  end
  return 
end
RF_PressurePlateFanChange = function(target, state)
  if (LargeFanStatus == 0) then
    if (state == "start") then
      SetPropertyFloat("LargeFanInert", "Acceleration", 270)
      SetRotatorMaxSpeed("LargeFanInert", 0)
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_FanDisable_Lever", "Play_sfx_RBF_PowerCordPluggedIn")
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Large_Fan", "Stop_sfx_RBF_fan_lp_Lever")
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Large_Fan", "Stop_sfx_RBF_fan_wind")
      wait(0.4000000059604645)
      Disable("FanWindVolume")
      Hide("FanWindVolume")
    else
      SetPropertyFloat("LargeFanInert", "Acceleration", 45)
      SetRotatorMaxSpeed("LargeFanInert", 270)
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_FanDisable_Lever", "Play_sfx_RBF_PowerCordPluggedIn")
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Large_Fan", "Play_sfx_RBF_fan_lp_Lever")
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Large_Fan", "Play_sfx_RBF_fan_wind")
      wait(1.5)
      Enable("FanWindVolume")
      Unhide("FanWindVolume")
    end
  end
  return 
end
RF_PipeFourPlatformRaise = function()
  Unhide("AirBlastLift")
  Enable("AirBlastLift")
  SetSplineFollowerInitialSpeed("PipeFourPlatform", 3)
  SplineFollower_StopAtPosition("PipeFourPlatform", "PipeFourPlatformSK1", "PipeFourPlatformSK2", 1)
  SetRotatorMaxSpeed("LargeFanInertForWind", 720)
  return 
end
grabbiingturnstile = false
RF_PipeFiveStart = function(target)
  grabbiingturnstile = true
  if (PipeFiveEngaged == 0) then
    SetCameraAttributesForPlayer("FinalPipeTurnstileCameraOverride", _activator())
    AudioPostEventOn("rbc_falls_01_shared_audio.Snd_ElectricPole_Top", "Play_sfx_RBF_PowerSubstationActivate")
  end
  while true do
    if (not (grabbiingturnstile == true)) then
      break
    end
    if (not (PipeFiveEngaged == 0)) then
      break
    end
    local TurnstileDirection = (GetHeading(target) * 57.3248405456543)
    if (TurnstileDirection < 0) then
      TurnstileDirection = ((180 - (TurnstileDirection * -1)) + 180)
    end
    TurnstileDirection = (TurnstileDirection / 360)
    SetSplineFollowerInitialSpeed("PipeFiveElectricPoleRod", 5.5)
    SplineFollower_StopAtPosition("PipeFiveElectricPoleRod", "PipeFiveElectricPoleSK1Rod", "PipeFiveElectricPoleSK2Rod", TurnstileDirection)
    wait(0)
  end
  return 
end
RF_PipeFiveDrop = function()
  grabbiingturnstile = false
  ClearCameraAttributesForPlayer("FinalPipeTurnstileCameraOverride", _activator(), 1)
  return 
end
RF_PipeFiveEngage = function()
  Disable("PipeFiveShockTrigger")
  SetPropertyFloat("FinalPipeTurnstile", "Activate Radius", 0)
  StartEmitters("FinalPipeSparks")
  TimerDisable("PipeRoomHintTimer")
  PipeFiveEngaged = 1
  AnimGBSequence("PipeFiveElectricPole", "expand")
  local temppipefour = 0
  if (PipeFourStatus == "broken") then
    temppipefour = 1
  end
  if (2 <= ((LargeFanStatus + PipeTwoStatus) + temppipefour)) then
    wait(2)
    ForceSequence("RF_SmallWorldPete", "RF_FifthPipeStartThinner")
    SetGlobal("RF_PipeRoomStatus", 7)
    DoStinger("Comment_Dest", 5)
    Disable("PipeFiveShockTrigger")
    Hide("PipeFiveOswaldDecal")
    ShakeCamera(4, 5, 0.75, 0.75, 0.029999999329447746, 0.029999999329447746)
    wait(1)
    StopEmitters("GeyserDevil")
    Hide("GeyserDevil")
    ForEachEntityInGroup(DestroyEntity, "GeyserDevilCollision")
    DestroyEntity("RBF_ThinnerGeyeserDamageTrig")
    SetGlobal("RBF_AngelOrDevil", 2)
    RF_PlayerHintMarkerUpdates()
    ClearAllCameraAttributes()
  else
    wait(2)
    ForceSequence("RF_SmallWorldPete", "RF_FifthPipeStartPaint")
    StopEmitters("GeyserAngel")
    Hide("GeyserAngel")
    SetGlobal("RF_PipeRoomStatus", 6)
    DoStinger("Comment_Rest", 5)
    Disable("PipeFiveShockTrigger")
    Hide("PipeFiveOswaldDecal")
    wait(1)
    DestroyEntity("GeyserAngelCollision")
    SetGlobal("RBF_AngelOrDevil", 1)
    RF_PlayerHintMarkerUpdates()
    ClearAllCameraAttributes()
  end
  SetGlobal("RF_CompletedV1", 1)
  return 
end
RF_PaintGeyserCameraSet = function()
  SetCameraAttributesForPlayer("PaintGeyserCameraOverride", _activator())
  return 
end
RF_PaintGeyserCameraRelease = function()
  ClearAllCameraAttributes(_activator(), 2)
  return 
end
RF_GrelinOmegaFixGeyser = function()
end
RF_OswaldMoveNearFanLift = function()
  OswaldSetPathAction("FanPlatformOswaldPatrolNode")
  Enable("PipeFourFanLiftOswaldTrigger")
  Unhide("PipeFourFanLiftOswaldDecal")
  return 
end
RFPipeTwoColorChange = function()
end
RF_StairstepFallsColumnDrop = function()
  local data = GetPrefabData("ThinnerStepFallsChest")
  StairStepFallsColumnDropped = 1
  AudioPostEventOn(GetPlayer(), "Play_sfx_rbf_thinnerPathColumnFall")
  AnimGBSequence("FallingColumnCapInert", "fall")
  AnimGBSequence("FallingColumnInert", "fall")
  ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  Rumble(nil, 1)
  Rumble(nil, 1, 1)
  return 
end
RF_ThinBridge = function(target)
  if (StairStepFallsColumnDropped == 1) then
    ForceSketched(target)
  end
  return 
end
RF_ThinCrystal = function(target)
  ForceSketched(target)
  return 
end
RF_V2Encyclopedia = function()
  if (GetGlobal("RBF_AngelOrDevil") == 2) then
    SetGlobal("MSN_Adelle_RainbowFallsVar", 1)
  else
    SetGlobal("MSN_Adelle_RainbowFallsVar", 2)
  end
  Print(GetGlobal("MSN_Adelle_RainbowFallsVar"))
  Print(GetGlobal("MSN_Adelle_Optimal_RainbowFalls_Shot01"))
  return 
end
RF_MemoriesPhotoSuccess = function()
  if (GetGlobal("RF_MoodyPhotoTaken") == 0) then
    Print("Photo success")
    SetGlobal("RF_MoodyPhotoTaken", 1)
    SetMapMarkerVisible("RF_MemoriesMapMarker", false)
    ForceSequence("GusConversationMarker", "RF_RiggerPhotoSuccess")
  end
  return 
end
RF_GremlinToonState = function(target, state)
  if (state == "painted") then
    SetGlobal("RF_GremlinToonPainted", 1)
  else
    SetGlobal("RF_GremlinToonPainted", 0)
  end
  return 
end
RF_SetupGremlinCageDevice = function(target)
  if (GetGlobal("RF_GremlinToonPainted") == 0) then
    Prefab_ChangeFieldState("HavokGremlinCage", "On")
  else
    Prefab_ChangeFieldState("HavokGremlinCage", "Off")
  end
  return 
end
RF_BlockFalls = function(target, var)
  FireUser1(target)
  return 
end
RF_BlockFalls2 = function(target)
  for i = 1, 0, -0.05000000074505806 do
    SetR3MTColorReg(target, 1, vector4(0, 0, 0, i))
    wait(0.05000000074505806)
  end
  return 
end
RF_ExtendArms = function(target, anim)
  AnimGBSequence(target, anim, true)
  return 
end
RedPipe = 0
OrangePipe = 0
GreenPipe = 0
BluePipe = 0
PurplePipe = 0
FanOpeningDestroyed = 0
RF_FillFXPipes = function(target, color)
  for x = 4, 1, -1 do
    AnimGBSequence(((color .. tostring(x)) .. "FX"), "Fill", true)
    wait(0.20000000298023224)
  end
  return 
end
RF_AllPipesConnectIGC = function()
  if (GetGlobal("RF_PipeIGCPlayed") == 0) then
    SetGlobal("RF_PipeIGCPlayed", 1)
    SetGlobal("RF_RedPipeStatus", 1)
    DestroyEntity("RF_OswaldStandAtPipes")
    DestroyEntity("RF_OswaldShockPipes")
    DestroyEntity("RF_OswaldNearFallsMoveTrig")
    OswaldStreamAbort()
    StopAbility(GetPlayer(), "Use")
    Prefab_OswaldElectricSwitch_ChangeState("RF_PipeArmActivatorSwitch", "Deactivate")
    SetGlobal("RF_FallsPipesConnected", 1)
    StopAbility(GetPlayer(), "Use")
    SetPropertyFloat("RF_FallsMachineHandle", "UsableRadius", 0)
    SetCameraAttributesForPlayer("GreenFallsCam1", GetPlayer())
    ShakeCamera(5, 1.2999999523162842, 0.4000000059604645, 0.4000000059604645, 0.009999999776482582, 0.009999999776482582)
    Unhide("RedPaintRight")
    RestrictCutSceneInput()
    EnableSplitScreen(false)
    wait(0.5)
    FireUser1("BluePipe")
    wait(0.5)
    FireUser1("RedPipe")
    wait(1.2000000476837158)
    FireUser1("GreenPipe")
    wait(0.8999999761581421)
    FireUser1("PurplePipe")
    wait(0.4000000059604645)
    FireUser1("OrangePipe")
    wait(5)
    SetSplineFollowerInitialSpeed("RF_GremlinPlatform", 3.5)
    ForEachEntityInGroup(StartEmitters, "SteamJets")
    AnimGBSequence("PurpleWallPipeFX", "FillUp", true)
    AnimGBSequence("OrangeWallPipeFX", "FillUp", true)
    ForceSequence("RF_SmallWorldPete", "RF_PipesConnected")
    ClearCameraAttributesForPlayer("GreenFallsCam1", GetPlayer())
    SetCameraAttributesForPlayer("PeteFallsCam2", GetPlayer())
  end
  return 
end
RF_PersistFallsPipes = function()
  if (0 < GetGlobal("RF_PipeIGCPlayed")) then
    AnimGBSequence("FallsRed", "RestInterrupted")
    AnimGBSequence("FallsOrange", "RestInterrupted")
    AnimGBSequence("FallsBlue", "RestInterrupted")
    AnimGBSequence("FallsGreen", "RestInterrupted")
    AnimGBSequence("FallsPurple", "RestInterrupted")
  end
  return 
end
RF_PeteCloseup = function()
  SetCameraAttributesForPlayer("PeteFallsCam1", GetPlayer())
  ClearCameraAttributesForPlayer("PeteFallsCam2", GetPlayer())
  return 
end
RF_EndAllPipesConnectIGC = function()
  wait(0.10000000149011612)
  ForceSequence("RF_SmallWorldPete", "RF_PipesLeaking")
  SetCameraAttributesForPlayer("GreenFallsCam2", GetPlayer())
  ClearCameraAttributesForPlayer("PeteFallsCam1", GetPlayer())
  wait(2)
  StartEmitters("SwingPipeSpillPaintFX")
  AudioPostEventOn("rbc_falls_01_shared_audio.Snd_BluePipe", "Play_sfx_RBF_RainbowPipe_Blue")
  wait(3)
  SetCameraAttributesForPlayer("OrangeFallsCam1", GetPlayer())
  ClearCameraAttributesForPlayer("GreenFallsCam2", GetPlayer())
  FireThread(RF_PipeFourPlatformRaise)
  wait(3)
  StartEmitters("PaintSpray")
  AudioPostEventOn("rbc_falls_01_shared_audio.Snd_GreenPipe", "Play_sfx_RBF_RainbowPipe_Green")
  Enable("RF_TopPipeDamageTrig")
  wait(3)
  SetCameraAttributesForPlayer("PurpleFallsCam1", GetPlayer())
  ClearCameraAttributesForPlayer("OrangeFallsCam1", GetPlayer())
  wait(3)
  StartEmitters("LavaSplash")
  wait(0.30000001192092896)
  StartEmitters("RBF_RedPaintSpill")
  AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Pipe_Valve", "Play_sfx_RBF_RainbowPipe_Red")
  wait(3)
  ClearCameraAttributesForPlayer("PurpleFallsCam1", GetPlayer())
  EnableSplitScreen(true)
  TimerEnable("PipeHintTimer")
  DestroyEntity("RF_PipesHandleOswaldSwitchDetectTrig")
  RF_PlayerHintMarkerUpdates()
  UnrestrictCutSceneInput()
  SaveCheckpoint(GetPlayer(), "RF_SetupZone", "CheckpointPosition2", "CheckpointPosition2_O")
  return 
end
RF_FixRedPipe = function()
  SetRotatorMaxSpeed("RedPipeValve", 360)
  AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Pipe_Valve", "Play_sfx_RBF_GearRotating")
  if (GetGlobal("RF_RedPipeStatus") == 1) then
    TimerDisable("PipeHintTimer")
    ForceSequence("RF_SmallWorldPete", "RF_FixRedPipe")
    SetGlobal("RF_RedPipeStatus", 2)
    RF_PlayerHintMarkerUpdates()
    StopEmitters("RBF_RedPaintSpill")
    AnimGBSequence("RedWallPipeFX", "FillUp", true)
    AnimGBSequence("RedPaintRight", "Fill")
    AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Pipe_Valve", "LPF_sfx_RBF_RainbowPipe_Red_Off")
    FireThread(RF_CheckPipeStatus)
    wait(0.699999988079071)
    AnimGBSequence("RedPaintRight", "Full")
  end
  wait(1)
  SetRotatorMaxSpeed("RedPipeValve", 0)
  AudioPostEventOn("rbc_falls_01_shared_audio.Snd_Pipe_Valve", "Stop_sfx_RBF_GearRotating")
  return 
end
RF_DestroyRedPipe = function()
  TimerDisable("PipeHintTimer")
  SetGlobal("RF_FanDestroyed", 1)
  if (0 < GetGlobal("RF_RedPipeStatus")) then
    ForceSequence("RF_SmallWorldPete", "RF_DestroyRedPipe")
    wait(3)
    TimerReset("PipeHintTimer")
    TimerEnable("PipeHintTimer")
    Print("Check Red Destroyed")
    RF_CheckPipeStatus()
  end
  return 
end
RF_PersistSwingPipe = function()
  if (GetGlobal("RF_GreenPipeStatus") == 2) then
    SetR3MTColorReg("SwingPipeFillFX", 0, vector4(0, 0.4189999997615814, 0.9879999756813049, 1))
    SetR3MTConstReg("SwingPipeFillFX", 1, vector4(0.3199999928474426, 0.6830000281333923, 1, 1))
    TeleportToEntity("Pipe2", "SwingPipePositionPaint")
    DisableMotion("RF_GreenPipeHandle")
    wait(0.30000001192092896)
    TeleportToEntity("SwingPipeFillFX", "SwingPipePositionPaintFX")
  elseif (2 < GetGlobal("RF_GreenPipeStatus")) then
    TeleportToEntity("Pipe2", "SwingPipePositionNeutral")
    SetRotatorMaxSpeed("RF_NeutralPipeLatch", 180)
    SetR3MTColorReg("SwingPipeFillFX", 0, vector4(0.5680000185966492, 0.6000000238418579, 0.6309999823570251, 0.8999999761581421))
    SetR3MTConstReg("SwingPipeFillFX", 1, vector4(0.7009999752044678, 0.7919999957084656, 0.9480000138282776, 1))
    wait(0.30000001192092896)
    TeleportToEntity("SwingPipeFillFX", "SwingPipePositionNeutralFX")
  end
  return 
end
RF_FixGreenPipe = function()
  if (GetGlobal("RF_GreenPipeStatus") < 2) then
    TimerDisable("PipeHintTimer")
    SetGlobal("RF_GreenPipeStatus", 2)
    RF_PlayerHintMarkerUpdates()
    FireUser2("Pipe2")
    StopEmitters("SwingPipeSpillPaintFX")
    DestroyEntity("SwingPipeSpillPaintFXCutoff")
    SetR3MTColorReg("SwingPipeFillFX", 0, vector4(0, 0.4189999997615814, 0.9879999756813049, 1))
    SetR3MTConstReg("SwingPipeFillFX", 1, vector4(0.3199999928474426, 0.6830000281333923, 1, 1))
    SetPropertyFloat("RF_GreenPipeHandle", "UsableRadius", 0)
    AnimGBSequence("SwingPipeFillFX", "Fill", true)
    DisableMotion("RF_GreenPipeHandle")
    RF_SetRotatingFloorSpeed("1")
    AudioPostEventOn("rbc_falls_01_shared_audio.Snd_MainFloor_Grate", "Play_sfx_RBF_SubstationStartOn")
    ForceSequence("RF_SmallWorldPete", "RF_FixGreenPipe")
    wait(4)
    RF_CheckPipeStatus()
  end
  return 
end
RF_CutoffPipeFX = function(target, position)
  if (0 < GetGlobal("RF_PipeIGCPlayed")) then
    if (position == "start") then
      StartEmitters("SwingPipeSpillPaintFXCutoff")
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_BluePipe", "LPF_sfx_RBF_RainbowPipe_Blue_Off")
      StopEmitters("SwingPipeSpillPaintFX")
    else
      StopEmitters("SwingPipeSpillPaintFXCutoff")
      StartEmitters("SwingPipeSpillPaintFX")
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_BluePipe", "Play_sfx_RBF_RainbowPipe_Blue")
    end
  end
  return 
end
SetDestroyPipeFX = function(target)
  SetR3MTColorReg(target, 0, vector4(0.800000011920929, 0.800000011920929, 0.800000011920929, 1))
  SetR3MTConstReg(target, 0, vector4(0.800000011920929, 0.800000011920929, 0.800000011920929, 1))
  return 
end
RF_DestroyPipeGreen = function()
  if (GetGlobal("RF_GreenPipeStatus") < 3) then
    TimerDisable("PipeHintTimer")
    SetGlobal("RF_GreenPipeStatus", 3)
    SetRotatorMaxSpeed("RF_NeutralPipeLatch", 180)
    wait(0.25)
    DestroyEntity("BlueMovingPipeCoupling")
    StopEmitters("SwingPipeSpillNeutralFX")
    ForEachEntityInGroup(StartEmitters, "BluePipeSteam")
    SetR3MTColorReg("SwingPipeFillFX", 0, vector4(0.5680000185966492, 0.6000000238418579, 0.6309999823570251, 0.8999999761581421))
    SetR3MTConstReg("SwingPipeFillFX", 1, vector4(0.7009999752044678, 0.7919999957084656, 0.9480000138282776, 1))
    AnimGBSequence("SwingPipeFillFX", "Fill", true)
    RF_PlayerHintMarkerUpdates()
    FireUser3("Pipe2")
    StopEmitters("ThinnerSprayPipe")
    DisableMotion("RF_BluePipeHandle")
    RF_SetRotatingFloorSpeed("1")
    AudioPostEventOn("rbc_falls_01_shared_audio.Snd_MainFloor_Grate", "Play_sfx_RBF_SubstationStartOn")
    ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
    if (0 < GetGlobal("RF_PipeIGCPlayed")) then
      ForceSequence("RF_SmallWorldPete", "RF_DestroyGreenPipe")
      wait(4)
      RF_CheckPipeStatus()
    end
  end
  return 
end
RF_FixBluePipe = function()
  if (GetGlobal("RF_BluePipeStatus") < 2) then
    TimerDisable("PipeHintTimer")
    SetGlobal("RF_BluePipeStatus", 2)
    RF_PlayerHintMarkerUpdates()
    StopEmitters("PaintSpray")
    DestroyEntity("RF_TopPipeDamageTrig")
    AnimGBSequence("GreenWallPipeFX", "FillUp", true)
    AudioPostEventOn("rbc_falls_01_shared_audio.Snd_GreenPipe", "LPF_sfx_RBF_RainbowPipe_Green_Off")
    ForceSequence("RF_SmallWorldPete", "RF_FixBluePipe")
    wait(4)
    RF_CheckPipeStatus()
  end
  return 
end
RF_DestroyBluePipe = function(target)
  AnimGBSequence("RF_BloulderFallBluePipe", "fall")
  AudioPostEventOn("rbc_falls_01_shared_audio.Snd_GreenPipe", "LPF_sfx_RBF_RainbowPipe_Green_Off")
  StopEmitters("PaintSpray")
  TimerDisable("PipeHintTimer")
  SetPropertyFloat("BluePipeHandlebar", "UsableRadius", 0)
  DestroyEntity("RBF_BluePipeConstraint")
  DisableMotion("BluePipeHandlebar")
  DestroyEntity("RF_TopPipeDamageTrig")
  ForEachEntityInGroup(StartEmitters, "GreenPipeSteam")
  if (GetGlobal("RF_BluePipeStatus") < 2) then
    SetGlobal("RF_BluePipeStatus", 3)
    if (GetGlobal("RF_PipeIGCPlayed") == 1) then
      RF_PlayerHintMarkerUpdates()
      ForceSequence("RF_SmallWorldPete", "RF_DestroyBluePipe")
      wait(4)
      RF_CheckPipeStatus()
    end
  end
  return 
end
RBF_DoorHandleReturn = function(target, side)
  local impulseDir = GetFacing(target)
  Print(side)
  if (side == "left") then
    impulseDir.x = (impulseDir.x * -200)
    impulseDir.z = (impulseDir.z * 200)
    ApplyImpulse(target, impulseDir.x, 0, impulseDir.z)
  else
    impulseDir.x = (impulseDir.x * 200)
    impulseDir.z = (impulseDir.z * -200)
    ApplyImpulse(target, impulseDir.x, 0, impulseDir.z)
  end
  return 
end
RF_SetRotatingFloorSpeed = function(speed)
  if (0 < GetGlobal("RF_PipeIGCPlayed")) then
    AudioPostEventOn("rbc_falls_01_shared_audio.Snd_MainFloor_Grate", "Play_sfx_RBF_PowerSubstationActivate")
    if (speed == "1") then
      ForEachEntityInGroup(SetRotatorMaxSpeed, "MainFloorGrate", 10)
    elseif (speed == "2") then
      ForEachEntityInGroup(SetRotatorMaxSpeed, "MainFloorGrate", 20)
    end
  end
  return 
end
RF_PipeStatusPersistFailsafe = function()
  if (1 < GetGlobal("RF_RedPipeStatus")) then
    if (1 < GetGlobal("RF_GreenPipeStatus")) then
      if (1 < GetGlobal("RF_BluePipeStatus")) then
        if (GetGlobal("RF_CenterPanelOpen") == 0) then
          AnimGBSequence("PipeFiveMachineCap", "open")
          SetGlobal("RF_CenterPanelOpen", 1)
          Enable("RF_OswaldStandNearMachine")
          SetPropertyFloat("CenterMachineHandle", "UsableRadius", 4)
        end
      end
    end
  end
  return 
end
RF_CheckPipeStatus = function()
  Print("CheckPipeStatus")
  if (GetGlobal("RF_CompletedV1") == 0) then
    if (1 < GetGlobal("RF_RedPipeStatus")) then
      if (1 < GetGlobal("RF_GreenPipeStatus")) then
        if (1 < GetGlobal("RF_BluePipeStatus")) then
          while true do
            if (not IsAnySequencePlaying()) then
              break
            end
            wait(0.20000000298023224)
          end
          SetGlobal("RF_CenterPanelOpen", 1)
          Enable("RF_OswaldStandNearMachine")
          ForceSequence("RF_SmallWorldPete", "RF_AllPipesFixed")
          SetPropertyFloat("CenterMachineHandle", "UsableRadius", 4)
          wait(0.5)
          while true do
            if (not IsAnySequencePlaying()) then
              break
            end
            wait(0.20000000298023224)
          end
          AnimGBSequence("PipeFiveMachineCap", "open")
        end
      end
    end
    FireThread(RF_RestartHintTimer)
  end
  SaveCheckpoint(GetPlayer(), "RF_SetupZone", "CheckpointPosition2", "CheckpointPosition2_O")
  return 
end
RF_SetMidHandleUsable = function()
  if (GetGlobal("RF_CenterPanelOpen") == 1) then
    SetPropertyFloat("CenterMachineHandle", "UsableRadius", 4)
  end
  return 
end
RF_RestartHintTimer = function()
  wait(4)
  TimerReset("PipeHintTimer")
  TimerEnable("PipeHintTimer")
  return 
end
RF_ElectricPoleMovement = function(target, state)
  Print("Pipe five handle")
  if (GetGlobal("RBF_AngelOrDevil") == 0) then
    if (IGCStarted == 0) then
      if (state == "out") then
        Disable("RF_OswaldStandNearMachine")
        Enable("RF_OswaldStreamCoreNode")
        RF_ElectricPoleMovementSignChange("on")
        SetSplineFollowerInitialSpeed("PipeFiveElectricPole", 2)
        SetSplineFollowerInitialSpeed("PipeFiveElectricPoleRod", 2)
        AudioPostEventOn("PipeFiveElectricPole", "Play_sfx_rbf_MachineTop_Up")
        Print("sfx Up")
        SplineFollower_StopAtPosition("PipeFiveElectricPole", "PipeFiveElectricPoleSK1", "PipeFiveElectricPoleSK2", 1)
        SplineFollower_StopAtPosition("PipeFiveElectricPoleRod", "PipeFiveElectricPoleSK1Rod", "PipeFiveElectricPoleSK1RodB", 1)
      else
        OswaldAbortScriptedBehavior()
        Enable("RF_OswaldStandNearMachine")
        Disable("RF_OswaldStreamCoreNode")
        RF_ElectricPoleMovementSignChange("off")
        AudioPostEventOn("PipeFiveElectricPole", "Play_sfx_rbf_MachineTop_Down")
        Print("sfx Down")
        SplineFollower_StopAtPosition("PipeFiveElectricPole", "PipeFiveElectricPoleSK1", "PipeFiveElectricPoleSK2", 0)
        SplineFollower_StopAtPosition("PipeFiveElectricPoleRod", "PipeFiveElectricPoleSK1Rod", "PipeFiveElectricPoleSK1RodB", 0)
      end
    end
  end
  return 
end
RF_ElectricPoleMovementSignChange = function(state)
  if (state == "on") then
    SetR3MTColorReg("FakeSwitchSign", 0, vector4(0, 0.30000001192092896, 0.44999998807907104))
  elseif (state == "charged") then
    SetR3MTColorReg("FakeSwitchSign", 0, vector4(0, 0.699999988079071, 1))
  else
    SetR3MTColorReg("FakeSwitchSign", 0, vector4(0.15000000596046448, 0.15000000596046448, 0.15000000596046448))
  end
  return 
end
RF_DisableProjector = function()
  if (GetGlobal("RBF_AngelOrDevil") == 0) then
    Prefab_Projector_ChangeState("AngelProjectorStand", "Deactivate")
  else
    Prefab_Projector_ChangeState("AngelProjectorStand", "Activate")
  end
  return 
end
IGCStarted = 0
RF_RoomCompleteIGC = function()
  if (GetGlobal("RBF_AngelOrDevil") == 0) then
    IGCStarted = 1
    DestroyEntity("RF_OswaldStandNearMachine")
    DestroyEntity("RF_OswaldStreamCoreNode")
    OswaldStreamAbort()
    local destruction = 0
    FireThread(RF_ElectricPoleMovementSignChange, "charged")
    GiveCollectible("Challenge_ProjectorCorrector_Tracker")
    SetPropertyFloat("CenterMachineHandle", "UsableRadius", 0)
    StopAbility(GetPlayer(), "Use")
    StopAbility(GetPlayer2OrAI(), "Use")
    Disable("PipeFiveShockTrigger")
    StartEmitters("FinalPipeSparks")
    SetGlobal("RF_CompletedV1", 1)
    if (GetGlobal("RF_FanDestroyed") == 1) then
      destruction = (destruction + 1)
    end
    if (GetGlobal("RF_GreenPipeStatus") == 3) then
      destruction = (destruction + 1)
    end
    if (GetGlobal("RF_BluePipeStatus") == 3) then
      destruction = (destruction + 1)
    end
    ForceInterruptSequence("RF_SmallWorldPete", "RF_AllPipesFixed")
    Print(destruction)
    DestroyEntity("PlayerHintMarkerMachineRoomLastStep")
    ForEachEntityInGroup(SetRotatorMaxSpeed, "MainFloorGrate", 0)
    Wait(0.25)
    if (destruction < 2) then
      Print("Good IGC")
      PlayIGC("IGC_0140a_AfterTheMachine")
      Prefab_Projector_ChangeState("AngelProjectorStand", "Activate")
      DestroyEntity("GeyserAngel")
      DestroyEntity("RF_FooptubeExitMapMarker")
      DestroyEntity("GeyserAngelCollision")
      SetGlobal("RBF_AngelOrDevil", 1)
      SplineFollower_StopAtPosition("PipeFiveElectricPoleRod", "PipeFiveElectricPoleSK1RodB", "PipeFiveElectricPoleSK2Rod", 2)
    else
      Print("Bad IGC")
      PlayIGC("IGC_0140b_AfterTheMachine")
      DestroyEntity("GeyserDevil")
      DestroyEntity("RF_ProjectorExitMapMarker")
      DestroyEntity("RBF_ThinnerGeyeserDamageTrig")
      ForEachEntityInGroup(DestroyEntity, "GeyserDevilCollision")
      SetGlobal("RBF_AngelOrDevil", 2)
      SetPropertyFloat("DECUsable", "UsableRadius", 2)
      SplineFollower_StopAtPosition("PipeFiveElectricPoleRod", "PipeFiveElectricPoleSK1RodB", "PipeFiveElectricPoleSK2Rod", 2)
    end
  end
  return 
end
RBF_ExpandCore = function()
  Print("Expand core!!! PIRHGLN")
  AnimGBSequence("PipeFiveElectricPole", "expand")
  return 
end
PostIGC_0140a_AfterTheMachine = function(igcName)
  FireUser1("projectorExplanationFancyCam")
  return 
end
RF_EnableProjectorHint = function()
  EnableGuardianHint("PlayerHintMarkerExitProjector")
  SaveCheckpoint(GetPlayer(), "RF_SetupZone", "CheckpointPosition2", "CheckpointPosition2_O")
  return 
end
PostIGC_0140b_AfterTheMachine = function(igcName)
  EnableGuardianHint("PlayerHintMarkerExitFooptube")
  SaveCheckpoint(GetPlayer(), "RF_SetupZone", "CheckpointPosition2", "CheckpointPosition2_O")
  return 
end
RF_ShutOffDEC = function(target)
  wait(1)
  if (GetGlobal("RBF_AngelOrDevil") == 0) then
    SetPropertyFloat(target, "UsableRadius", 0)
  end
  if (GetGlobal("RBF_AngelOrDevil") == 2) then
    SetPropertyFloat("DECUsable", "UsableRadius", 2)
  end
  SetPropertyFloat("DECUsable", "UsableRadius", 0)
  return 
end
MickeyCurrentLocation = "none"
RF_ChangeMickeysCurrentLocation = function(target, location)
  MickeyCurrentLocation = location
  return 
end
RF_PipeHints = function()
  Print(("RF_PipeHints: The Current location for Mickey is: " .. MickeyCurrentLocation))
  if (GetGlobal("RF_GreenPipeStatus") < 2) then
    if (MickeyCurrentLocation == "Green") then
      ForceSequence("RF_SmallWorldPete", "RF_BluePipeHint")
    end
  elseif (GetGlobal("RF_RedPipeStatus") < 2) then
    if (MickeyCurrentLocation == "Red") then
      ForceSequence("RF_SmallWorldPete", "RF_RedPipeHint")
    end
  elseif (GetGlobal("RF_BluePipeStatus") < 2) then
    if (MickeyCurrentLocation == "Blue") then
      ForceSequence("RF_SmallWorldPete", "RF_GreenPipeHint")
    end
  elseif (GetGlobal("RF_GreenPipeStatus") < 2) then
    ForceSequence("RF_SmallWorldPete", "RF_BluePipeHint")
  elseif (GetGlobal("RF_RedPipeStatus") < 2) then
    ForceSequence("RF_SmallWorldPete", "RF_RedPipeHint")
  elseif (GetGlobal("RF_BluePipeStatus") < 2) then
    ForceSequence("RF_SmallWorldPete", "RF_GreenPipeHint")
  end
  return 
end
RF_PlayerHintMarkerUpdates = function()
  DisableGuardianHint("PlayerHintMarkersMachineRoom")
  if (GetGlobal("RF_PipeIGCPlayed") == 0) then
    EnableGuardianHint("PlayerHintMarkerMachineRoomStepOne")
  elseif (GetGlobal("RF_GreenPipeStatus") < 2) then
    EnableGuardianHint("PlayerHintMarkerMachineRoomGreenPipe")
  elseif (GetGlobal("RF_RedPipeStatus") < 2) then
    EnableGuardianHint("PlayerHintMarkerMachineRoomRedPipe")
  elseif (GetGlobal("RF_BluePipeStatus") < 2) then
    EnableGuardianHint("PlayerHintMarkerMachineRoomBluePipe")
  elseif (GetGlobal("RBF_AngelOrDevil") == 0) then
    EnableGuardianHint("PlayerHintMarkerMachineRoomLastStep")
  end
  return 
end
BluePipeToonStimStimHit = 0
RF_BluePipeBoulderWarning = function(target, _event)
  if StimulusEvent_HasStimulusType(_event, ST_THINNER) then
    if (GetGlobal("RF_BluePipeStatus") < 2) then
      if (BluePipeToonStimStimHit == 0) then
        BluePipeToonStimStimHit = 1
        FireSequence("GusConversationMarker", "RF_BluePipeThinnerWarning")
        while true do
          if (not (IsAnySequencePlaying() == true)) then
            break
          end
          wait(0.25)
        end
        wait(5)
        BluePipeToonStimStimHit = 0
      end
    end
  end
  return 
end
RF_FireworksExplodingOswaldDisable = function(target, event, entity)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    SetPropertyBool(entity, "ActionSpotEnabled", false)
    OswaldStreamAbort()
  end
  return 
end
FirstTimeInvisibleTutPlayed = false
FirstTimeIndelibleTutPlayed = 0
RF_PlayerLostInvisibilityTutorialVO = function(target)
  if (IsAnySequencePlaying() == false) then
    FireSequence("GusConversationMarker", "RF_InvisibleFirstTime")
  end
  return 
end
RF_PlayerGainedInvisible = function(target)
  wait(0.20000000298023224)
  if (GetPrefabData("InvisibleInkwellTrigger").InkWellState == "Invisible") then
    FireSequence("GusConversationMarker", "RF_InvisibleFirstTime")
    DestroyEntity(target)
  end
  return 
end
RF_PlayerGainedIndelibe = function(target)
  FirstTimeIndelibleTutPlayed = (FirstTimeIndelibleTutPlayed + 1)
  if (FirstTimeIndelibleTutPlayed == 1) then
    FireSequence("GusConversationMarker", "RF_IndelibleFirstTime")
  elseif (3 < FirstTimeIndelibleTutPlayed) then
    FirstTimeIndelibleTutPlayed = 0
  end
  return 
end

