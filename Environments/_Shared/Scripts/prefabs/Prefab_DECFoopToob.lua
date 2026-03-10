ActiveToobData = ""
HardLoadDefaultTable = {"EntranceDirection", "StatesToStream[1]", "ExitCameraOverride", "Functions[2]", "DECMarkers[1]", "StatesToStream[2]"}
CheckpointCallback = false
Prefab_DECFoopToob_AlwaysSetup = function(target)
  Print(("__FOOPTOOB: Function: Prefab_DECFoopToob_AlwaysSetup, ToobName(Activation): " .. tostring(GetName(target))))
  local data = GetPrefabData(target)
  local Direction = GetGlobal("2dDirection")
  local EnteredBut2D = false
  if (data.HardLoadExitFunction[1] ~= "True") then
  end
  Print(((("__FOOPTOOB: HardLoadExitFunction[1] = " .. data.HardLoadExitFunction[1]) .. " && Direction = ") .. Direction))
  SetPropertyFloat(GetRelativePrefabEntity(target, ".Activation"), "UsableRadius", 0)
  if (tostring(data.HardLoadExitFunction[2]) == tostring(MostRecentCheckpointCallback)) then
    if (CheckpointCallback == true) then
      Print("__FOOPTOOB: 2D CheckpointCallback was specified! The screen should already be faded out")
    else
      Print(((("__FOOPTOOB: Exit Function and Load Callback: " .. tostring(data.HardLoadExitFunction[2])) .. " MATCHES MostRecentCheckpointCallback in GlobalScripts: ") .. tostring(MostRecentCheckpointCallback)))
      Print("__FOOPTOOB: THIS MEANS WE HAVE ENTERED THIS ZONE BEFORE, SKIPPING EXIT FUNCTION AND ANIMATIONS -- YOUR EXIT FUNCTION OVERRIDE SHOULD AND MUST BE YOUR LOAD CALLBACK FOR THIS TO WORK PROPERLY!!")
      SetPropertyFloat(GetRelativePrefabEntity(target, ".Activation"), "UsableRadius", 2)
    end
    if (data.HardLoadExitFunction[3] ~= "ExitCameraOverride") then
      Print("__FOOPTOOB: We're in a 2D Space! Setup constraints anyway!")
      EnteredBut2D = true
    else
      return 
      Print(((("__FOOPTOOB: Exit Function and Load Callback: " .. tostring(data.HardLoadExitFunction[2])) .. " DOES NOT MATCH MostRecentCheckpointCallback in GlobalScripts: ") .. tostring(MostRecentCheckpointCallback)))
      Print("__FOOPTOOB: THIS MEANS WE HAVE NOT ENTERED THIS ZONE BEFORE, FIRING EXIT FUNCTION AND ANIMATIONS -- YOUR EXIT FUNCTION OVERRIDE SHOULD AND MUST BE YOUR LOAD CALLBACK FOR THIS TO WORK PROPERLY!!")
    end
  end
  if (EnteredBut2D == false) then
    Print(((("__FOOPTOOB: Exit Function and Load Callback: " .. tostring(data.HardLoadExitFunction[2])) .. " DOES NOT MATCH MostRecentCheckpointCallback in GlobalScripts: ") .. tostring(MostRecentCheckpointCallback)))
    Print("__FOOPTOOB: THIS MEANS WE HAVE NOT ENTERED THIS ZONE BEFORE, FIRING EXIT FUNCTION AND ANIMATIONS -- YOUR EXIT FUNCTION OVERRIDE SHOULD AND MUST BE YOUR LOAD CALLBACK FOR THIS TO WORK PROPERLY!!")
  end
  data.HardLoadExitFunction[reg_18] = "Busy"
  SetGlobal("DEC_Hardload", false)
  local CheckpointMarkerName = GetPropertyString(GetRelativePrefabEntity(target, ".TeleportMarker"), "EntityGroups", 1)
  if (data.HardLoadExitFunction[3] ~= "ExitCameraOverride") then
    Print(("__FOOPTOOB: SAVING CHECKPOINT (2D) FUNCTION: Prefab_DECFoopToob_2DLoadCallback AND POSITION: " .. tostring(CheckpointMarkerName)))
    SaveCheckpoint(GetPlayer(), tostring("Prefab_DECFoopToob_2DLoadCallback"), CheckpointMarkerName)
  else
    Print(((("__FOOPTOOB: SAVING CHECKPOINT FUNCTION: " .. tostring(data.HardLoadExitFunction[2])) .. " AND POSITION: ") .. tostring(CheckpointMarkerName)))
    SaveCheckpoint(GetPlayer(), tostring(data.HardLoadExitFunction[2]), CheckpointMarkerName)
  end
  if (Direction == 1) then
    Print("__FOOPTOOB: 2dDirection Global set to enter level from the LAUNCHER load side!")
  else
    Print("__FOOPTOOB: 2dDirection Global set to enter level from the REVERSE side, teleporting players there!")
    TeleportToEntity(GetPlayer(), CheckpointMarkerName)
    local OldPosition = GetPosition(CheckpointMarkerName)
    SetPositionFloat(CheckpointMarkerName, (OldPosition.x + 0.5), OldPosition.y, OldPosition.z)
    TeleportToEntity(GetPlayer2OrAI(), CheckpointMarkerName)
    SetPositionFloat(CheckpointMarkerName, OldPosition.x, OldPosition.y, OldPosition.z)
  end
  EnableSplitScreen(true)
  if (data.HardLoadExitFunction[3] == "ExitCameraOverride") then
    Print("__FOOPTOOB: Should be exiting to a 3D zone here from hard load as no 2D constraint is overridden in HardLoadExitFunction[3]!")
    SetPropertyFloat(GetRelativePrefabEntity(target, ".Activation"), "UsableRadius", 0)
    RestrictCutSceneInput()
    SetVerticalSplit(true)
    ActiveToobData = GetPrefabData(target)
    HardLoadDefaultTable[reg_18] = data.EntranceDirection
    HardLoadDefaultTable[reg_32] = data.StatesToStream[1]
    HardLoadDefaultTable[reg_44] = data.ExitCameraOverride
    HardLoadDefaultTable[reg_105] = data.Functions[2]
    HardLoadDefaultTable[reg_107] = data.DECMarkers[1]
    HardLoadDefaultTable[reg_109] = data.StatesToStream[2]
    ActiveToobData.EntranceDirection = "3D"
    ActiveToobData.StatesToStream[reg_18] = "3D"
    ActiveToobData.ExitCameraOverride = "HARDLOAD"
    ActiveToobData.Functions[reg_32] = data.HardLoadExitFunction[2]
    local EntityGroupName, EntityGroupName = GetPropertyString(GetRelativePrefabEntity(target, ".TeleportMarker"), "EntityGroups", 1), GetRelativePrefabEntity(target, ".TeleportMarker")
    EntityGroupName = Print
    EntityGroupName("__FOOPTOOB: If the next print is nil, did you forget to add a unique name to your TeleportMarker?")
    EntityGroupName = Print
    EntityGroupName((("__FOOPTOOB: Calling Prefab_DECFoopToob_Exit with param: " .. tostring(EntityGroupName)) .. "!"))
    EntityGroupName = ActiveToobData
    EntityGroupName = EntityGroupName.DECMarkers
    EntityGroupName[reg_18] = EntityGroupName
    EntityGroupName = SetInside2DMap
    EntityGroupName(false)
    EntityGroupName = Prefab_DECFoopToob_Exit
    EntityGroupName(EntityGroupName)
  end
  Print(("__FOOPTOOB: Should be exiting to a 2D zone here from hard load, constraint override name: " .. tostring(data.HardLoadExitFunction[3])))
  SetInside2DMap(true)
  SetHorizontalSplit(true)
  if (CheckpointCallback == true) then
    Print("__FOOPTOOB: Reloading from checkpoint, the screen should already be black so we dont need another one!")
  else
    Print("__FOOPTOOB: Coming into this 2D zone from a hardload (not checkpoint), fade the screen out!")
    StartFadeOut(0)
  end
  if (data.MusicEvent[1] == "No_Music") then
    Print("__FOOPTOOB: MusicEvent[1] defined as No_Music! Nothing will play!")
    ResetMusicEvent()
  elseif (data.MusicEvent[1] ~= "Starting_Music") then
    Print(("__FOOPTOOB: MusicEvent[1] Defined! Will play event: " .. tostring(data.MusicEvent[1])))
    MusicPostEventOn(GetPlayer(), ("Play_" .. data.MusicEvent[1]))
  else
    Print("__FOOPTOOB: MusicEvent[1] defined as Starting_Music! This is the default! Is this intended?")
  end
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
  SetCameraAttributesForPlayer(data.HardLoadExitFunction[3], GetPlayer())
  setupConstraint2(GetRelativePrefabEntity(data.HardLoadExitFunction[3], ".Player2_Override"))
  wait(0.10000000149011612)
  Print("__FOOPTOOB: DEACTIVATING ACTIVATION TRIGGER FOR THIS FOOPTOOB")
  if (data.HARDLOAD[1] == "True") then
    Print("__FOOPTOOB: HARD LOAD OVERRIDE SET, WILL ACTIVATE THIS TRIGGER INSTEAD WHEN THE PLAYER MOVES")
    FireThread(Prefab_DECFoopToob_WaitUntilPlayerMoves, GetRelativePrefabEntity(target, ".Activation"), data.ActivationAxisIgnoreFor2D, GetPlayer())
    FireThread(Prefab_DECFoopToob_WaitUntilPlayerMoves, GetRelativePrefabEntity(target, ".Activation"), data.ActivationAxisIgnoreFor2D, GetPlayer2OrAI())
  else
    SetPropertyFloat(GetRelativePrefabEntity(target, ".Activation"), "UsableRadius", 0)
  end
  if (data.HardLoadExitFunction[4] == "ExitToob") then
    Print("__FOOPTOOB WARNING: ACTIVATION ON 2D EXIT TRIGGER WILL NOT WORK PROPERLY (YOU WILL NOT BE ABLE TO EXIT THE OTHER SIDE OF YOUR DEC). Override HardLoadExitFunction[4]!")
  else
    Print(("__FOOPTOOB: Will activate trigger on exit toob: " .. tostring(data.HardLoadExitFunction[4])))
    FireThread(Prefab_DECFoopToob_WaitUntilPlayerMoves, data.HardLoadExitFunction[4], data.ActivationAxisIgnoreFor2D, GetPlayer())
    FireThread(Prefab_DECFoopToob_WaitUntilPlayerMoves, data.HardLoadExitFunction[4], data.ActivationAxisIgnoreFor2D, GetPlayer2OrAI())
  end
  if (data.HardLoadExitFunction[2] == "ExitFunction") then
    Print("__FOOPTOOB: EXIT FUNCTION NOT DEFINED ON HARD LOAD, CALLING FINISH")
    Prefab_DECFoopToob_Finish(target)
  else
    Print(("__FOOPTOOB: CALLING EXIT ON HARD LOAD FUNCTION: " .. tostring(data.HardLoadExitFunction[2])))
    FireThread(_G[data.HardLoadExitFunction[2]], "DEC")
  end
  data.HardLoadExitFunction[reg_18] = "False"
  return 
end
Prefab_DECFoopToob_2DLoadCallback = function(target)
  Print("__Function: Prefab_DECFoopToob_2DLoadCallback")
  StartFadeOut(0)
  CheckpointCallback = true
  return 
end
Prefab_DECFoopToob_CheckDisabledByDefault = function(target)
  Print("FOOPTOOB: Function: Prefab_DECFoopToob_CheckDisabledByDefault")
  local data = GetPrefabData(target)
  if (data.StartsDeactive3D == "True") then
    Print("__FOOPTOOB: 3DStartsDeactive is TRUE! Will deactivate activation on this toob. MAKE SURE YOU CALL Prefab_DECFoopToob_ChangeState when you want it to activate again!")
    Print("__FOOPTOOB: If this is toob is 2D or you're popping out of this toob, Activation will get re-enabled! Make sure you're not popping out of this toob right now!")
    SetPropertyFloat(GetRelativePrefabEntity(target, ".Activation"), "UsableRadius", 0)
  end
  return 
end
Prefab_DECFoopToob_ChangeState = function(target, _State)
  Print(("__FOOPTOOB: Function: Prefab_DECFoopToob_ChangeState, _State: " .. tostring(_State)))
  Print(((("__FOOPTOOB: Changing Toob " .. tostring(GetName(target))) .. ", to: ") .. tostring(_State)))
  if (_State == "Activate") then
    SetPropertyFloat(GetRelativePrefabEntity(target, ".Activation"), "UsableRadius", 2)
  elseif (_State == "Deactivate") then
    SetPropertyFloat(GetRelativePrefabEntity(target, ".Activation"), "UsableRadius", 0)
  else
    Print("__FOOPTOOB: State passed in is invalid! Should be either Activate or Deactivate!")
  end
  return 
end
Prefab_DECFoopToob_SaveCheckpoint = function(target)
  Print(((("__FOOPTOOB: Function: Prefab_DECFoopToob_SaveCheckpoint, SAVING FUNCTION: " .. tostring(ActiveToobData.Functions[2])) .. " AND POSITION: ") .. tostring(ActiveToobData.DECMarkers[1])))
  SaveCheckpoint(GetPlayer(), tostring(ActiveToobData.Functions[2]), ActiveToobData.DECMarkers[1])
  return 
end
Prefab_DECFoopToob_SaveCheckpointEnter = function(target)
  local data = GetPrefabData(target)
  local CheckpointMarkerName = GetPropertyString(GetRelativePrefabEntity(target, ".TeleportMarker"), "EntityGroups", 1)
  Print(((("__FOOPTOOB: Function: Prefab_DECFoopToob_SaveCheckpointEnter, SAVING FUNCTION: " .. tostring(data.HardLoadExitFunction[2])) .. " AND POSITION: ") .. tostring(CheckpointMarkerName)))
  SaveCheckpoint(GetPlayer(), tostring(data.HardLoadExitFunction[2]), CheckpointMarkerName)
  return 
end
Prefab_DECFoopToob_Activation = function(target)
  Print("__FOOPTOOB: Functon: Prefab_DECFoopToob_Activation")
  local data = GetPrefabData(target)
  if (data.EnterSequence == "SequenceName") then
    Print("__FOOPTOOB WARNING: Your sequence name isn't overridden! Make sure conversation component on TeleportMarker and EnterSequence override are set!")
    return 
  else
    ForceSequence(GetRelativePrefabEntity(target, ".TeleportMarker"), data.EnterSequence)
  end
  return 
end
Prefab_DECFoopToob_Enter = function(target)
  OswaldStopFollowAction()
  target = _self()
  local data = GetPrefabData(target)
  Print(("__FOOPTOOB: Function: Prefab_DECFoopToob_Enter -- CALLED FROM SEQUENCE: " .. tostring(data.EnterSequence)))
  Print("__FOOPTOOB: Changing EnterSequence to InUse!")
  data.EnterSequence = "InUse"
  local camera = GetRelativePrefabEntity(target, ".EnterCamera")
  if (data.StatesToStream[1] == "2D") then
    camera = GetRelativePrefabEntity(target, ".EnterCamera3D")
  end
  local marker = GetRelativePrefabEntity(target, ".TeleportMarker")
  local activation = GetRelativePrefabEntity(target, ".Activation")
  local _player = GetPlayer()
  local _player2 = GetPlayer2OrAI()
  PauseAllAI()
  SetPropertyFloat(activation, "UsableRadius", 0)
  AnimGBSetIdle(camera, false)
  RestrictCutSceneInput()
  StartFadeOut(0.25)
  MostRecentCheckpointCallback = "None"
  if (data.Functions[1] ~= "EnterToobFunction") then
    Print(("__FOOPTOOB: Firing Function on FoobToop Enter: " .. tostring(data.Functions[1])))
    if (data.WaitForEnterFunction == "True") then
      Print("__FOOPTOOB: WAITING FOR ENTER FUNCTION TO COMPLETE BEFORE CONTINUINING. THIS SHOULD ONLY BE SET IF YOUR STREAMING HAS BEEN SET UP BY YOU IN YOUR OWN SCRIPT!!")
      _G[data.Functions[1]]()
    else
      FireThread(_G[data.Functions[1]])
    end
  end
  if (data.EpisodeCheck[1] == "True") then
    Print("__FOOPTOOB: Using EpisodeCheck override! (set [1] to False if you don't need this!)")
    local Global = GetGlobal(data.EpisodeCheckGlobal)
    if (tonumber(data.EpisodeCheck[2]) <= Global) then
      if (data.HARDLOAD == "False") then
        Print((((((("__FOOPTOOB: GLOBAL " .. tostring(data.EpisodeCheckGlobal)) .. " VALUE: ") .. tostring(Global)) .. " GREATER/EQUAL TO VALUE SPECIFIED IN EPISODECHECK[2]: ") .. tostring(data.EpisodeCheck[2])) .. ", REPLACING NEXT3DSTATE"))
        local Old3D = data.StatesToStream[3]
        data.StatesToStream[reg_83] = data.EpisodeCheck[3]
        Print(((("__FOOPTOOB: OLD 3D: " .. tostring(Old3D)) .. ", NEW 3D: ") .. tostring(data.StatesToStream[3])))
      else
        Print((((((("__FOOPTOOB: GLOBAL " .. tostring(data.EpisodeCheckGlobal)) .. " VALUE: ") .. tostring(Global)) .. " GREATER/EQUAL TO VALUE SPECIFIED IN EPISODECHECK[2]: ") .. tostring(data.EpisodeCheck[2])) .. ", REPLACING HARDLOAD[2]"))
        local OldHardLoad, OldHardLoad = data.HARDLOAD[2], (((((("__FOOPTOOB: GLOBAL " .. tostring(data.EpisodeCheckGlobal)) .. " VALUE: ") .. tostring(Global)) .. " GREATER/EQUAL TO VALUE SPECIFIED IN EPISODECHECK[2]: ") .. tostring(data.EpisodeCheck[2])) .. ", REPLACING HARDLOAD[2]")
        OldHardLoad = data.HARDLOAD
        OldHardLoad[reg_76] = data.EpisodeCheck[3]
        OldHardLoad = Print
        OldHardLoad(((("__FOOPTOOB: OLD HARDLOAD: " .. tostring(OldHardLoad)) .. ", NEW HARDLOAD: ") .. tostring(data.HARDLOAD[2])))
      end
    end
  end
  ActiveToobData = GetPrefabData(target)
  wait(0)
  wait(0.75)
  EnableSplitScreen(false)
  SetDrawSilhouettes(false)
  DisableGuardianSystem()
  data.MarkerAngle = 180
  Print(("__FOOPTOOB: Facing of Marker: " .. tostring(GetFacing(marker))))
  InstantRotateToPosition(marker, data.MarkerAngle)
  wait(0)
  _player2 = GetPlayer2OrAI()
  Print(("__FOOPTOOB: Marker Angle On Enter: " .. tostring(data.MarkerAngle)))
  Print(("__FOOPTOOB: New Facing of Marker: " .. tostring(GetFacing(marker))))
  local OriginalPosition, OriginalPosition = GetPosition(marker), GetFacing(marker)
  OriginalPosition = marker
  TeleportToEntity(_player, OriginalPosition)
  OriginalPosition = "Collision Layer"
  SetPropertyInt(_player, OriginalPosition, 19)
  OriginalPosition = "Collision Layer"
  SetPropertyInt(_player2, OriginalPosition, 19)
  OriginalPosition = marker
  TeleportToEntity(_player2, OriginalPosition)
  OriginalPosition = nil
  GrabCameraNif(camera, OriginalPosition, CAMERA_LERP_TRANSITION, 0)
  AnimGBReset(camera)
  if (data.StatesToStream[1] == "3D") then
    OriginalPosition = "camera_projectorIn"
    AnimGBSequence(camera, OriginalPosition)
  elseif (data.StatesToStream[1] == "2D") then
    OriginalPosition = "camera"
    AnimGBSequence(camera, OriginalPosition)
  end
  if (data.StatesToStream[1] == "3D") then
    Print("__FOOPTOOB: Will play GOING TO 3D Animation!")
    OriginalPosition = EVENT_Special_0
    AnimEvent(_player, OriginalPosition)
    OriginalPosition = EVENT_Special_0
    AnimEvent(_player2, OriginalPosition)
  elseif (data.StatesToStream[1] == "2D") then
    Print("__FOOPTOOB: Will play GOING TO 2D Animation!")
    OriginalPosition = EVENT_Special_4
    AnimEvent(_player, OriginalPosition)
    OriginalPosition = EVENT_Special_4
    AnimEvent(_player2, OriginalPosition)
    OriginalPosition = target
    OriginalPosition = "JumpIn"
    AnimGBSequence(GetRelativePrefabEntity(OriginalPosition, ".Manhole"), OriginalPosition)
  else
    OriginalPosition = tostring
    OriginalPosition = OriginalPosition(data.StatesToStream[1])
    Print((("__FOOPTOOB WARNING: INVALID [1] FOR STATESTOSTREAM OVERRIDE: " .. OriginalPosition) .. ", SHOULD BE EITHER 2D OR 3D. NO ANIMATIONS WILL PLAY!"))
  end
  OriginalPosition = "Invisible"
  SetPropertyBool(_player, OriginalPosition, false)
  OriginalPosition = "Invisible"
  SetPropertyBool(_player2, OriginalPosition, false)
  wait(0.4000000059604645)
  StartFadeInNoHUD()
  Wait(0.05000000074505806)
  Unhide(_player)
  Unhide(GetPlayer2OrAI())
  wait(3)
  Hide(_player)
  Hide(GetPlayer2OrAI())
  wait(0.4000000059604645)
  StartFadeOut(0.25)
  wait(0.5)
  Unhide(_player)
  Unhide(GetPlayer2OrAI())
  if (data.MusicEvent[1] == "No_Music") then
    Print("__FOOPTOOB: MusicEvent[1] defined as No_Music. This toob will stop nothing!")
  elseif (data.MusicEvent[1] ~= "Starting_Music") then
    local Music_array = (#data.MusicEvent)
    if (1 < Music_array) then
      if (data.MusicEvent[2] == "Other_Music") then
        Music_array = (Music_array - 1)
      end
    end
    OriginalPosition = "__FOOPTOOB: MusicEvents Defined! Will Stop "
    Music_array = tostring
    Music_array = Music_array(Music_array)
    OriginalPosition = ((OriginalPosition .. Music_array) .. " events! Listed next")
    Print(OriginalPosition)
    OriginalPosition = Music_array
    Music_array = 1
    for i = 1, OriginalPosition, Music_array do
      i = tostring
      i = i(i)
      Print(((("__FOOPTOOB: Stopping MusicEvent[" .. i) .. "]: ") .. tostring(data.MusicEvent[i])))
      i = "Stop_"
      i = (i .. data.MusicEvent[i])
      AudioPostEventOn(_player, i)
    end
  else
    Print("__FOOPTOOB: MusicEvent[1] defined as Starting_Music! This is the default! Is this intended?")
  end
  if (data.HARDLOAD[1] == "False") then
    if (data.StatesToStream[1] == "2D") then
      Print("__FOOPTOOB: 2D interior set to stream!")
      if (data.StatesToStream[2] == "NextState") then
        Print("__FOOPTOOB WARNING: NO INTERIOR SET TO STREAM INTO A 2D LEVEL, CRASH IMMINENT")
      else
        OriginalPosition = tostring
        OriginalPosition = OriginalPosition(data.StatesToStream[2])
        Print(("__FOOPTOOB: Streaming Interior: " .. OriginalPosition))
        OriginalPosition = data.StatesToStream
        OriginalPosition = OriginalPosition[2]
        StreamInterior(nil, OriginalPosition)
        if (data.StatesToStream[1] == "3D") then
          Print("__FOOPTOOB: 3D zone set to stream!")
          if (data.StatesToStream[3] == "Next3DState") then
            Print("__FOOPTOOB WARNING: NO STATE SPECIFIED TO STREAM INTO A 3D LEVEL, CRASH IMMINENT")
          else
            OriginalPosition = tostring
            OriginalPosition = OriginalPosition(data.StatesToStream[3])
            Print(("__FOOPTOOB: 3D 'Stream' Selected (this shouldn't actaully be a stream since your 3D zone should be loaded and deactivated).  Swapping state to: " .. OriginalPosition))
            LevelManager_SetCurrentState(data.StatesToStream[3])
            Print("__FOOPTOOB WARNING: INVALID [1] FOR STATESTOSTREAM OVERRIDE. SHOULD BE EITHER 2D OR 3D")
          end
        else
          Print("__FOOPTOOB WARNING: INVALID [1] FOR STATESTOSTREAM OVERRIDE. SHOULD BE EITHER 2D OR 3D")
        end
      end
    elseif (data.StatesToStream[1] == "3D") then
      Print("__FOOPTOOB: 3D zone set to stream!")
      if (data.StatesToStream[3] == "Next3DState") then
        Print("__FOOPTOOB WARNING: NO STATE SPECIFIED TO STREAM INTO A 3D LEVEL, CRASH IMMINENT")
      else
        OriginalPosition = tostring
        OriginalPosition = OriginalPosition(data.StatesToStream[3])
        Print(("__FOOPTOOB: 3D 'Stream' Selected (this shouldn't actaully be a stream since your 3D zone should be loaded and deactivated).  Swapping state to: " .. OriginalPosition))
        LevelManager_SetCurrentState(data.StatesToStream[3])
        Print("__FOOPTOOB WARNING: INVALID [1] FOR STATESTOSTREAM OVERRIDE. SHOULD BE EITHER 2D OR 3D")
      end
    else
      Print("__FOOPTOOB WARNING: INVALID [1] FOR STATESTOSTREAM OVERRIDE. SHOULD BE EITHER 2D OR 3D")
    end
    WaitForLevelLoad()
    UnpauseAllAI()
    EnableSplitScreen(true)
    wait(0.5)
    OriginalPosition = tostring
    OriginalPosition = OriginalPosition(data.DECMarkers[1])
    Print(("__FOOPTOOB: Will exit to Toob Marker: " .. OriginalPosition))
    Prefab_DECFoopToob_Exit(data.DECMarkers[1])
    OriginalPosition = "UsableRadius"
    SetPropertyFloat(activation, OriginalPosition, 2)
  else
    OriginalPosition = tostring
    OriginalPosition = OriginalPosition(data.HARDLOAD[2])
    Print((("__FOOPTOOB: THIS FOOP TOOB WILL HARD LOAD INTO LEVEL: " .. OriginalPosition) .. ", MAKE SURE TO SET THE HARDLOAD OVERRIDE TO FALSE WHEN YOU WANT THIS TO STREAM"))
    Print("__FOOPTOOB: THE SCREEN SHOULD NOT FADE OUT")
    OriginalPosition = true
    SetGlobal("DEC_Hardload", OriginalPosition)
    if (data.ReverseTravel == "True") then
      Print("__FOOPTOOB: ReverseTravel override set to TRUE on this Toob! When you exit out of the toob on the other side (if it's from a HardLoad), expect it to be at the exit!")
      OriginalPosition = 0
      SetGlobal("2dDirection", OriginalPosition)
    else
      Print("__FOOPTOOB: ReverseTravel override set to FALSE on this Toob! When you exit out of the toob on the other side (if it's from a HardLoad), expect it to be at the entrance!")
      OriginalPosition = 1
      SetGlobal("2dDirection", OriginalPosition)
    end
    if (data.HARDLOAD[2] == "2DTransitionLevelAndZoneName") then
      Print("__FOOPTOOB WARNING: 2D TRANSITION LEVEL AND ZONE NAME NOT SET! THIS HARD LOAD WILL FAIL!")
    end
    UnrestrictCutSceneInput()
    UnpauseAllAI()
    StartFadeIn(0)
    OriginalPosition = 0
    ReleaseCamera(CAMERA_INSTANT_TRANSITION, OriginalPosition)
    Prefab_DECFoopToob_SaveCheckpointEnter(target)
    OriginalPosition = tostring
    OriginalPosition = OriginalPosition(data.HARDLOAD[2])
    LoadLevel(nil, OriginalPosition)
  end
  return 
end
Prefab_DECFoopToob_Exit = function(target)
  wait(1)
  local data = GetPrefabData(target)
  Print(("__FOOPTOOB: Function: Prefab_DECFoopToob_Exit, called from FoopToob: (IF THIS NONFATALS, your DECMarkers[1] override wasn't filled out properly!): " .. tostring(target)))
  local camera = GetRelativePrefabEntity(target, ".ExitCamera")
  local marker = GetRelativePrefabEntity(target, ".TeleportMarker")
  local activation = GetRelativePrefabEntity(target, ".Activation")
  local _player = GetPlayer()
  local _player2 = GetPlayer2OrAI()
  if (data.MusicEvent[1] == "No_Music") then
    Print("__FOOPTOOB: MusicEvent[1] defined as No_Music! Nothing will play!")
    ResetMusicEvent()
  elseif (data.MusicEvent[1] ~= "Starting_Music") then
    Print(("__FOOPTOOB: MusicEvent[1] Defined! Will play event: " .. tostring(data.MusicEvent[1])))
    MusicPostEventOn(_player, ("Play_" .. data.MusicEvent[1]))
  else
    Print("__FOOPTOOB: MusicEvent[1] defined as Starting_Music! This is the default! Is this intended?")
  end
  PauseAllAI()
  if (ActiveToobData.EntranceDirection == "Left") then
    Print("__FOOPTOOB: Override set to enter a DEC! If you're supposed to be going to a 3D section here, reset the EntranceDirection override back to 3D!")
    SetLedgeGrabEnabled(_player, false)
    SetLedgeGrabEnabled(_player2, false)
    if (ActiveToobData.EntranceDirection == "Left") then
      Print("__FOOPTOOB: EntranceDirection Override set to left! Should be entering a DEC from the left side here!")
      InstantRotateToPosition(target, 90)
    elseif (ActiveToobData.EntranceDirection == "Right") then
      Print("__FOOPTOOB: EntranceDirection Override set to right! Should be entering a DEC from the right side here!")
      InstantRotateToPosition(target, -90)
    end
    TeleportToEntity(_player, target)
    TeleportToEntity(_player2, target)
    SetInside2DMap(true)
  end
  Print("__FOOPTOOB: Override set to enter a 3D zone! If you're supposed to be going to a DEC here, override EntranceDirection to either Left or Right!")
  SetInside2DMap(false)
  SetDrawSilhouettes(false)
  EnableSplitScreen(false)
  AnimGBSetIdle(camera, false)
  Hide(_player)
  Hide(_player2)
  SetLedgeGrabEnabled(_player, true)
  SetLedgeGrabEnabled(_player2, true)
  StartFadeOut(0)
  Wait(0)
  wait(0.10000000149011612)
  data.MarkerAngle = 0
  InstantRotateToPosition(target, data.MarkerAngle)
  if (ActiveToobData.ExitCameraOverride == "HARDLOAD") then
    Print("__FOOPTOOB: Exit's been called from a hardload! Will not attempt to clear camera attributes!")
    ActiveToobData.ExitCameraOverride = data.HardLoadExitFunction[3]
    ActiveToobData.StatesToStream[reg_93] = "HARDLOAD"
  else
    Print(("__FOOPTOOB: Exit's been called from a stream! Will clear camera attributes from override: " .. tostring(data.ExitCameraOverride)))
    ClearCameraAttributesForPlayer(data.ExitCameraOverride, _player)
    ClearCameraAttributesForPlayer(data.ExitCameraOverride, GetPlayer2OrAI())
  end
  wait(0.10000000149011612)
  if (data.SkipExitAnimationAndTeleport[2] == "Teleport") then
    TeleportToEntity(_player, marker)
    OswaldStopFollowAction()
    TeleportToEntity(GetPlayer2OrAI(), marker)
    wait(1)
    OswaldStartFollowAction()
  else
    Print("__FOOPTOOB: Teleport is overridden to something besides the default! Mickey and Oswald WILL NOT TELEPORT!")
  end
  if (data.SkipExitAnimationAndTeleport[1] == "Animation") then
    GrabCameraNif(camera, nil, CAMERA_LERP_TRANSITION, 0)
    AnimGBReset(camera)
    AnimGBSequence(camera, "camera", false, 100)
    wait(0.10000000149011612)
    Unhide(_player)
    Unhide(GetPlayer2OrAI())
    wait(0.10000000149011612)
    Hide(_player)
    Hide(GetPlayer2OrAI())
    wait(0)
    StartFadeInNoHUD(0.25)
    wait(0.25)
    AnimGBSequence(camera, "camera")
    AnimGBReset(camera)
    AnimEvent(_player, EVENT_Special_3)
    AnimEvent(GetPlayer2OrAI(), EVENT_Special_3)
    AnimGBSequence(GetRelativePrefabEntity(target, ".Manhole"), "JumpOut")
    wait(0.5)
    Unhide(_player)
    Unhide(GetPlayer2OrAI())
    wait(4.5)
    StartFadeOut(0.25)
    wait(0.25)
    if (data.SkipExitAnimationAndTeleport[2] == "Teleport") then
      Print(((((("__FOOPTOOB: Will offset Mickey and Oswald from the marker in WORLD SPACE OFFSETS -- X: " .. tostring(data.ExitTeleportOffsets[1])) .. ", Y: ") .. tostring(data.ExitTeleportOffsets[2])) .. ", Z: ") .. tostring(data.ExitTeleportOffsets[3])))
      Print("__FOOPTOOB: This teleport is EQUAL DISTANCE MIRRORED from both sides of the marker (default of .25 in the Z puts them .5 meters apart, .25 in each direction), so if Mickey or Oswald appear inside geometry, try tweaking the ExitTeleportOffsets override")
      local MickeyPosition = GetPosition(marker)
      local OswaldPosition = GetPosition(marker)
      MickeyPosition.x = (MickeyPosition.x + (data.ExitTeleportOffsets[1] * data.ExitTeleportOffsets[4]))
      MickeyPosition.y = (MickeyPosition.y + (data.ExitTeleportOffsets[2] * data.ExitTeleportOffsets[4]))
      MickeyPosition.z = (MickeyPosition.z + (data.ExitTeleportOffsets[3] * data.ExitTeleportOffsets[4]))
      OswaldPosition.x = (OswaldPosition.x - (data.ExitTeleportOffsets[1] * data.ExitTeleportOffsets[4]))
      OswaldPosition.y = (OswaldPosition.y - (data.ExitTeleportOffsets[2] * data.ExitTeleportOffsets[4]))
      OswaldPosition.z = (OswaldPosition.z - (data.ExitTeleportOffsets[3] * data.ExitTeleportOffsets[4]))
      Print(("__FOOPTOOB: Marker Position: " .. tostring(GetPosition(marker))))
      Print(("__FOOPTOOB: Mickey new Position: " .. tostring(MickeyPosition)))
      Print(("__FOOPTOOB: Oswald new Position: " .. tostring(OswaldPosition)))
      local MarkerFacing = GetFacing(marker)
      SetFacing(marker, vector4(0, 0, 0))
      SetTransformation(marker, vector4(MickeyPosition.x, MickeyPosition.y, MickeyPosition.z), vector4(0, 0, 0))
      TeleportToEntity(_player, marker)
      SetParentEntity(marker, _player)
      SetFacing(_player, MarkerFacing)
      ClearParent(marker)
      SetFacing(marker, MarkerFacing)
      _player2 = GetPlayer2OrAI()
      SetFacing(marker, vector4(0, 0, 0))
      SetTransformation(marker, vector4(OswaldPosition.x, OswaldPosition.y, OswaldPosition.z), vector4(0, 0, 0))
      TeleportToEntity(_player2, marker)
      SetParentEntity(marker, _player2)
      SetFacing(_player2, MarkerFacing)
      ClearParent(marker)
      SetFacing(marker, MarkerFacing)
    else
      Print("__FOOPTOOB: Teleport is overridden to something else, so skip the offsets teleport!")
      Print("__FOOPTOOB WARNING: SkipExitAnimationAndTeleport == TRUE! YOUR SCREEN WILL NOT FADE IN IF YOUR EXIT FUNCTION DOESN'T DO IT!")
      Unhide(_player)
      Unhide(GetPlayer2OrAI())
    end
  else
    Print("__FOOPTOOB WARNING: SkipExitAnimationAndTeleport == TRUE! YOUR SCREEN WILL NOT FADE IN IF YOUR EXIT FUNCTION DOESN'T DO IT!")
    Unhide(_player)
    Unhide(GetPlayer2OrAI())
  end
  SetDrawSilhouettes(true)
  EnableGuardianSystem()
  EnableSplitScreen(true)
  wait(0.009999999776482582)
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
  CameraReset()
  wait(0.009999999776482582)
  if (ActiveToobData.StatesToStream[2] == "HARDLOAD") then
    Print("__FOOPTOOB: Coming from hardload! will not save an extra checkpoint!")
  else
    Print("__FOOPTOOB: Saving Checkpoint!")
    Prefab_DECFoopToob_SaveCheckpoint(ActiveToobData)
  end
  if (ActiveToobData.Functions[2] ~= "ExitToobFunction") then
    Print(("__FOOPTOOB: Firing ExitToobFunction: " .. tostring(ActiveToobData.Functions[2])))
    Print("__FOOPTOOB WARNING: EXIT FUNCTION MUST CONTAIN Prefab_DECFoopToob_Finish AS THE LAST LINE OR YOUR SCREEN WILL NEVER FADE IN")
    FireThread(_G[ActiveToobData.Functions[2]], "DEC")
  else
    Print("__FOOPTOOB: No ExitToobFunction specified! Calling Prefab_DECFoopToob_Finish automatically!")
    Prefab_DECFoopToob_Finish(target)
  end
  return 
end
Prefab_DECFoopToob_Finish = function(target)
  OswaldStartFollowAction()
  if (ActiveToobData == "") then
    Print("__FOOPTOOB: ActiveToobData Not Defined. If you're exiting to 3D and see this message, something has gone horribly wrong. Fading screen in!")
    if (CheckpointCallback == true) then
      Print("__FOOPTOOB: ActiveToobData Not Defined AND coming from a checkpoint! No fade in needed. If you're exiting to 3D and see this message, something has gone horribly wrong. Fading screen in!")
      CheckpointCallback = false
    else
      Print("__FOOPTOOB: ActiveToobData Not Defined. If you're exiting to 3D and see this message, something has gone horribly wrong. Fading screen in!")
      StartFadeIn(0.800000011920929)
    end
    return 
  end
  local data = ActiveToobData
  Print(("__FOOPTOOB Function: Prefab_DECFoopToob_Finish called while Mickey is at Toob (ExitToob): " .. tostring(data.DECMarkers[1])))
  local camera = GetRelativePrefabEntity(data.DECMarkers[1], ".ExitCamera")
  local _player = GetPlayer()
  local _player2 = GetPlayer2OrAI()
  SetPropertyInt(_player, "Collision Layer", 3)
  if (GetNumPlayers() == 2) then
    SetPropertyInt(_player2, "Collision Layer", 3)
  else
    SetPropertyInt(_player2, "Collision Layer", 30)
  end
  EnableMotion_Player(_player)
  EnableMotion_Player(_player2)
  AnimGBSetIdle(camera, true)
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
  if (data.DECMarkers[1] == "EnterToob") then
    Print("__FOOPTOOB WARNING: Attempting to configure DEC Activators failed! One of your overrides isnt set, you'll either be stuck in this DEC or be able to go backwards!")
    Print("__FOOPTOOB WARNING: DECActivators[1] should be your entrance toob (to deactivate). [2] is your exit back to 3D (to activate)")
    Print("__FOOPTOOB WARNING: If you are exiting to 3D, [2] on your EXIT TOOB should == 3D")
  end
  if (data.StatesToStream[1] == "2D") then
    Print("__FOOPTOOB: Entering 2D Area")
    Print(("__FOOPTOOB: DEACTIVATING ENTRANCE TOOB: " .. tostring(data.DECMarkers[1])))
    Print(("__FOOPTOOB: ACTIVATING EXIT TOOB: " .. tostring(data.DECMarkers[2])))
    SetPropertyFloat(GetRelativePrefabEntity(data.DECMarkers[1], ".Activation"), "UsableRadius", 0)
    SetPropertyFloat(GetRelativePrefabEntity(data.DECMarkers[2], ".Activation"), "UsableRadius", 2)
  elseif (data.StatesToStream[1] == "3D") then
    Print("__FOOPTOOB: Entering 3D Area, Enabling Activator for backwards travel AFTER PLAYER MOVES")
    FireThread(Prefab_DECFoopToob_WaitUntilPlayerMoves, GetRelativePrefabEntity(data.DECMarkers[1], ".Activation"), "None", GetPlayer())
    FireThread(Prefab_DECFoopToob_WaitUntilPlayerMoves, GetRelativePrefabEntity(data.DECMarkers[1], ".Activation"), "None", GetPlayer2OrAI())
  end
  Print(("__FOOPTOOB: data.ExitCameraOverride: " .. tostring(data.ExitCameraOverride)))
  if (data.ExitCameraOverride ~= "None") then
    if (data.ExitCameraOverride ~= "ExitCameraOverride") then
      Print(("__FOOPTOOB: Exiting to 2D camera override: " .. tostring(data.ExitCameraOverride)))
      SetCameraAttributesForPlayer(data.ExitCameraOverride, _player)
      setupConstraint2(GetRelativePrefabEntity(data.ExitCameraOverride, ".Player2_Override"))
    else
      Print("__FOOPTOOB: Exiting to 3D camera override, Setting hint entity!")
      SetPropertyInt(data.DECMarkers[1], "SideScrollActive", 1)
      SetPropertyInt(data.DECMarkers[1], "HintEntityActive", 2)
      SetCameraAttributesForPlayer(data.DECMarkers[1], GetPlayer())
      SetCameraAttributesForPlayer(data.DECMarkers[1], GetPlayer2OrAI())
    end
  end
  if (data.StatesToStream[2] == "HARDLOAD") then
    Print("__FOOPTOOB: We came into finish from a hardload! will not attempt to change states")
    Print(("__FOOPTOOB: Resetting Prefab Data to defaults for Toob: " .. data.DECMarkers[1]))
    data.EntranceDirection = HardLoadDefaultTable[1]
    data.StatesToStream[reg_25] = HardLoadDefaultTable[2]
    data.ExitCameraOverride = HardLoadDefaultTable[3]
    data.Functions[reg_44] = HardLoadDefaultTable[4]
    data.DECMarkers[reg_25] = HardLoadDefaultTable[5]
    data.StatesToStream[reg_44] = HardLoadDefaultTable[6]
    Print("__FOOPTOOB: Overridden Values for hardload now returned to:")
    Print(("__FOOPTOOB: EntranceDirection: " .. tostring(data.EntranceDirection)))
    Print(("__FOOPTOOB: StatesToStream[1]: " .. tostring(data.StatesToStream[1])))
    Print(("__FOOPTOOB: ExitCameraOverride: " .. tostring(data.ExitCameraOverride)))
    Print(("__FOOPTOOB: Functions[2]: " .. tostring(data.Functions[2])))
    Print(("__FOOPTOOB: DECMarkers[1]: " .. tostring(data.DECMarkers[1])))
    Print(("__FOOPTOOB: StatesToStream[2]: " .. tostring(data.StatesToStream[2])))
  else
    Print(("__FOOPTOOB: Transition finished, swapping to state: " .. tostring(data.StatesToStream[3])))
    LevelManager_SetCurrentState(data.StatesToStream[3])
    if (data.StatesToStream[1] == "3D") then
      Print(("__FOOPTOOB: Transition to 3D Level, DEACTIVATING 2D ZONE: " .. tostring(data.StatesToStream[2])))
      LevelManager_SetZoneStatusDeactive(data.StatesToStream[2])
    end
  end
  local len_Finish_Skip = (#data.Finish_Skip)
  local skipFade = false
  local skipUnpauseAI = false
  if (data.Finish_Skip[1] ~= "None") then
    for i = 1, len_Finish_Skip do
      if (data.Finish_Skip[i] == "Fade") then
        Print("__FOOPTOOB: Skipping FadeIn")
        skipFade = true
      elseif (data.Finish_Skip[i] == "UnpauseAI") then
        skipUnpauseAI = true
        Print("__FOOPTOOB: Skipping UnpauseAllAI")
      end
    end
  end
  if (skipFade == false) then
    wait(0.800000011920929)
    StartFadeIn(0.800000011920929)
    Print("__FOOPTOOB: FadeIn")
  end
  if (skipUnpauseAI == false) then
    Print("__FOOPTOOB: UnpauseAllAI")
    UnpauseAllAI()
  end
  UnrestrictCutSceneInput()
  Print("__FOOPTOOB Function: Prefab_DECFoopToob_Finish Finished")
  return 
end
Prefab_DECFoopToob_WaitUntilPlayerMoves = function(target, _AxisToIgnore, _player)
  local data = GetPrefabData(target)
  local Activation = GetRelativePrefabEntity(target, ".Activation")
  local GetName_Activation = tostring(GetName(Activation))
  Print(("__FOOPTOOB: Function: Prefab_DECFoopToob_WaitUntilPlayerMoves, Will Activate ActivationTrigger: " .. GetName_Activation))
  local RefreshOswaldHandle = false
  if (GetName(_player) == GetName(GetPlayer2OrAI())) then
    Print("__FOOPTOOB: This activation was for Oswald! Will refresh player handle each iteration")
    RefreshOswaldHandle = true
  end
  local OriginalPlayerPosition = GetPosition(_player)
  Print(("__FOOPTOOB: Original Player Position: " .. tostring(OriginalPlayerPosition)))
  if (_AxisToIgnore == "None") then
    Print("__FOOPTOOB: Will not ignore axis! This should be for 3D")
    Print(("__FOOPTOOB: Waiting for player movement to activate Trigger: " .. GetName_Activation))
    while true do
      while true do
        if (SCUPM_GetPosition(GetPosition(_player), OriginalPlayerPosition) < 0.10000000149011612) then
          wait(0.5)
        end
      end
      _player = GetPlayer2OrAI()
    end
  else
    Print((("__FOOPTOOB: Will ignore Axis: " .. tostring(_AxisToIgnore)) .. ", this should be for 2D"))
    Print(("__FOOPTOOB: Waiting for player movement to activate Trigger: " .. GetName_Activation))
    while true do
      while true do
        if (Prefab_DECFoopToob_GetPositionDifferenceIgnoreAxis(GetPosition(_player), OriginalPlayerPosition, _AxisToIgnore) < 0.10000000149011612) then
          wait(0.5)
        end
      end
      _player = GetPlayer2OrAI()
    end
  end
  Print((("__FOOPTOOB: Player moved! Activation Trigger: " .. GetName_Activation) .. " ENABLED"))
  if (data.EnterSequence == "InUse") then
    Print("__FOOPTOOB: This toob is InUse! Will not enable this trigger!")
  else
    SetPropertyFloat(Activation, "UsableRadius", 2)
  end
  ClearCameraAttributesForPlayer(GetRelativePrefabEntity(target, ".TeleportMarker"), _player, 2)
  return 
end
Prefab_DECFoopToob_GetPositionDifferenceIgnoreAxis = function(position1, position2, _AxisToIgnore)
  if (_AxisToIgnore == "X") then
    position1.x = 0
    position2.x = 0
  elseif (_AxisToIgnore == "Z") then
    position1.z = 0
    position2.z = 0
  end
  local diff = (position1 - position2)
  return diff:length2()
end

