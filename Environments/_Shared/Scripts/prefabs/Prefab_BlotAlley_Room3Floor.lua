Prefab_BlotAlleyRoom3Floor_AlwaysSetup = function(target)
  Print("__Function: Prefab_BlotAlleyRoom3Floor_AlwaysSetup")
  Hide(GetRelativePrefabEntity(target, ".Sweeper"))
  return 
end
Prefab_BlotAlleyRoom3Floor_TimerTick = function(target)
  Print("__Function: NOS_BlotAlleyRoom3Floor_TimerTick")
  local data = GetPrefabData(target)
  target = "Room3SweeperTimer"
  local Sweeper = GetRelativePrefabEntity(target, ".Sweeper")
  data.CurrentShutter = (data.CurrentShutter + 1)
  if (data.CurrentShutter == 7) then
    data.CurrentShutter = 1
  end
  TeleportToEntity(Sweeper, GetRelativePrefabEntity(target, (".SweeperMarker" .. tostring(data.CurrentShutter))))
  Unhide(Sweeper)
  AnimGBSequence(GetRelativePrefabEntity(target, (".Shutter" .. tostring(data.CurrentShutter))), "open")
  wait(6.5)
  while true do
    if (not (GetPrefabData("Room3SweeperTimer").SweeperStimmed == 1)) then
      break
    end
    wait(1)
  end
  AnimGBSequence(GetRelativePrefabEntity(target, (".Shutter" .. tostring(data.CurrentShutter))), "close")
  wait(0.5)
  Hide(Sweeper)
  return 
end
Prefab_BlotAlleyRoom3Floor_SweeperStimmed = function(target, _event)
  if (GetPrefabData("Room3SweeperTimer").SweeperStimmed == 0) then
    if StimulusEvent_HasStimulusType(_event, ST_FAIRY) then
      Print("__Function: Prefab_BlotAlleyRoom3Floor_SweeperStimmed")
      Print("__Disabling timer until stim is done!")
      GetPrefabData("Room3SweeperTimer").SweeperStimmed = 1
      TimerDisable("Room3SweeperTimer")
      local WaitTime = 24
      if HasCollectible("SketchUpgrade_Sketch_Fairy") then
        Print("__Player has fairy upgrade!")
        WaitTime = 48
      end
      Print((("__Will Wait " .. tostring(WaitTime)) .. " seconds before re-enabling this timer"))
      wait(WaitTime)
      TimerEnable("Room3SweeperTimer")
      GetPrefabData("Room3SweeperTimer").SweeperStimmed = 0
    end
  end
  return 
end
Prefab_BlotAlleyRoom3Floor_FloorPieceThinned = function(target, _Thinned, _WhichPiece)
  Print(((("__Function: Prefab_BlotAlleyRoom3Floor_FloorPieceThinned, _Thinned: " .. tostring(_Thinned)) .. "_WhichPiece: ") .. tostring(_WhichPiece)))
  local data = GetPrefabData(target)
  if (_Thinned == "0") then
    data.ToonState[tonumber(_WhichPiece)] = 0
  elseif (_Thinned == "1") then
    data.ToonState[tonumber(_WhichPiece)] = 1
  end
  if (data.ToonState[1] == 0) then
    if (data.ToonState[4] == 0) then
      if (data.FloorState[1] == 1) then
        FireThread(Prefab_BlotAlleyRoom3Floor_DropFloorPiece, GetRelativePrefabEntity(target, ".FloorPiece1"), GetRelativePrefabEntity(target, ".FloorPiece1_SinkFX"))
        data.FloorState[reg_18] = 0
      end
    end
  end
  if (data.ToonState[1] == 0) then
    if (data.ToonState[3] == 0) then
      if (data.FloorState[2] == 1) then
        FireThread(Prefab_BlotAlleyRoom3Floor_DropFloorPiece, GetRelativePrefabEntity(target, ".FloorPiece2"), GetRelativePrefabEntity(target, ".FloorPiece2_SinkFX"))
        data.FloorState[reg_33] = 0
      end
    end
  end
  if (data.ToonState[2] == 0) then
    if (data.ToonState[3] == 0) then
      if (data.FloorState[3] == 1) then
        FireThread(Prefab_BlotAlleyRoom3Floor_DropFloorPiece, GetRelativePrefabEntity(target, ".FloorPiece3"), GetRelativePrefabEntity(target, ".FloorPiece3_SinkFX"))
        data.FloorState[reg_32] = 0
      end
    end
  end
  if (data.ToonState[2] == 0) then
    if (data.ToonState[4] == 0) then
      if (data.FloorState[4] == 1) then
        FireThread(Prefab_BlotAlleyRoom3Floor_DropFloorPiece, GetRelativePrefabEntity(target, ".FloorPiece4"), GetRelativePrefabEntity(target, ".FloorPiece4_SinkFX"))
        data.FloorState[reg_19] = 0
      end
    end
  end
  return 
end
Prefab_BlotAlleyRoom3Floor_DropFloorPiece = function(target, _FX)
  Print("__Function: Prefab_BlotAlleyRoom3Floor_DropFloorPiece")
  SetGlobal("NOS_BlotAlley_FloorDropped", 1)
  ActivateNavMeshObstacle(target, true)
  AnimGBSequence(target, "fall")
  AudioPostEventOn(_FX, "Play_sfx_BLA_Courtyard_CaveIn")
  AudioPostEventOn(_FX, "Play_sfx_BLA_ThinFloor_LP")
  StartEmitters(_FX)
  wait(6.5)
  StopEmitters(_FX)
  wait(4)
  DestroyEntity(target)
  return 
end
Prefab_BlotAlleyRoom3Floor_EnableFloorTargetsToAI = function(target)
  Print("__Function: Prefab_BlotAlleyRoom3Floor_EnableFloorTargetsToAI")
  for x = 1, 4 do
    AIHintEnable(GetRelativePrefabEntity("Room3Floor_FloorOnly", (".ToonPiece" .. tostring(x))), true)
  end
  Prefab_BlotAlleyRoom3Floor_TimerTick(target)
  TimerReset(target)
  TimerEnable(target)
  return 
end

