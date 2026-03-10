local FTL_CheckpointLoaded = false
local FTL_CurrentCheckpointLocation = "Docks"
FTL_Fort_Setup = function(method)
  Print("*_*_*_*_*_*_*_*_*_*_*_* FTL_Fort_Setup()")
  if (method == nil) then
    method = "Checkpoint"
  end
  if (method ~= "setupTurrets") then
    if (FTL_CheckpointLoaded == false) then
      Print("*_*_*_*_*_*_*_*_*_*_*_* FTL_Fort_Setup() FTL_CheckpointLoaded == false")
      FTL_CheckpointLoaded = true
      DestroyEntity("Trigger_Setup_Launcher")
      math.randomseed(os.time())
      StartFadeOut(0)
      MoveClockHands("FortOuter", "Setup")
      MoveClockHands("FortInner", "Setup")
      MoveClockHands("ClockInner", "Setup")
      MoveClockHands("ClockOuter", "Setup")
      if (LevelManager_GetCurrentInterior() == "ftl_fort01a.int_fortjail") then
        LevelManager_SetZoneStatusUnloaded("ftl_fort01a.int_fortjail")
      end
      if (GetGlobal("FTL_Ian_FortIntro_Played") == 1) then
        FireThread(FTL_Fort_Setup, "setupTurrets")
      end
      local currentLevel = string.sub(tostring(LevelManager_GetCurrentState()), 16, 19)
      Print(("FTL_Fort_Setup: currentLevel = " .. currentLevel))
      if (currentLevel == "dock") then
        if GetPropertyBool("FWL_Docks_OneShots7", "Is Painted") then
          enableJumpVolumeAvailability("JV_InertBoot_toWashBoard")
        end
        if GetPropertyBool("FWL_Docks_OneShots8", "Is Painted") then
          enableJumpVolumeAvailability("JV_Washboard_ToSaw")
        end
        if (GetGlobal("FTL_ClockHandState") == 100) then
          SetPropertyFloat("Trigger_PlaceClockHands", "UseDelay", 1.5)
        end
        if (tostring(MostRecentCheckpointCallback) == "FTL_Fort_Setup") then
          if IsValidHandle("Trigger_SetProjectorCamera") then
            Enable("Trigger_SetProjectorCamera")
          end
        end
        local global = GetGlobal("FTL_Fort_SpatterState")
        if (global == 1) then
          SetMapMarkerVisible("MapMarker_FortProjector", true)
        elseif (global ~= 10) then
          SetMapMarkerVisible("MapMarker_FoopToob", true)
        end
        if (GetPropertyInt("FTL_CliffDoor", "Active Sequence ID") == 3) then
          Prefab_OswaldElectricSwitch_ChangeState(GetRelativePrefabEntity("CliffDoorOuter_Watch", ".OswaldSwitchStand"), "FullyCharged")
        end
        if (GetPropertyInt("FTL_ClockDoor", "Active Sequence ID") == 2) then
          if IsValidHandle("ClockDoor_Watch") then
            Prefab_OswaldElectricSwitch_ChangeState(GetRelativePrefabEntity("ClockDoor_Watch", ".OswaldSwitchStand"), "FullyCharged")
          end
          Disable("Trigger_PlaceClockHands")
          if (GetGlobal("FTL_ClockHandState") ~= 100) then
            SetPropertyFloat("Trigger_PlaceClockHands_DoorOpen", "UsableRadius", 2)
          end
        end
      elseif (currentLevel == "fort") then
        local global, global = GetGlobal("FTL_Fort_SpatterState"), "FTL_Fort_SpatterState"
        global = GetGlobal
        global = global("FTL_Fort_SpatterCostume")
        if (global == 0) then
          if (global == 1) then
            global = GetPrefabData
            global = global("Spatter_Costume_Restored")
            global.StartHidden = "False"
          elseif (global == 2) then
            global = GetPrefabData
            global = global("Spatter_Costume_Tattered")
            global.StartHidden = "False"
          end
        end
        if (global ~= 10) then
          global = 1
          for i = global, 2 do
            i = FireThread
            i(Prefab_OswaldElectricSwitch_ChangeState, ("Fort_OswaldSwitch" .. i), "FullyCharged")
          end
        else
          global = IsValidHandle
          global = global("ftl_fort_01a_visit1.GusHint_CorePath_5")
          if global then
            global = DestroyEntity
            global("ftl_fort_01a_visit1.GusHint_CorePath_5")
          end
        end
        if (global ~= 1) then
          global = Prefab_Projector_ChangeState
          global("Projector_ToFloatShortcut", "Deactivate")
        end
        global = GetPropertyBool
        global = global("FWL_Fort_OneShots28", "Is Painted")
        if global then
          global = FireThread
          global(FTL_Fort_TooggleJumpAvailability, nil, "TrunkPainted")
        else
          global = FireThread
          global(FTL_Fort_TooggleJumpAvailability, nil, "TrunkThinned")
        end
        global = GetPropertyInt
        global = global("FTL_FortDoor", "Active Sequence ID")
        if (global == 2) then
          global = Prefab_OswaldElectricSwitch_ChangeState
          global(GetRelativePrefabEntity("FortDoorOuter_Watch", ".OswaldSwitchStand"), "FullyCharged")
          global = Prefab_OswaldElectricSwitch_ChangeState
          global(GetRelativePrefabEntity("FortDoorInner_Watch", ".OswaldSwitchStand"), "FullyCharged")
        end
      end
      if (not (not Quest_CheckStatus("A_Friend_In_Deed", "A_Friend_In_Deed_4b", Quest_Discovered))) then
        SetMapMarkerVisible("MapMarker_MetairieBear", true)
        Enable("PM_Photo_Metairie_Bear")
      end
      if Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_3b", Quest_Discovered) then
        SetMapMarkerVisible("MapMarker_GreeneItem", true)
        Enable("PM_Photo_Clock")
      end
      if (GetGlobal("FTL_Fort_ForestClearingState") == 1) then
        if IsValidHandle("FTL_fortBrokenWall") then
          DestroyEntity("FTL_fortBrokenWall")
        end
      end
      FireThread(FTL_Fort_Visit_Setup, method, currentLevel)
    end
  elseif (method == "setupTurrets") then
    for i = 1, 3 do
      FireUser1(("turret_dumbo 0" .. i))
      wait(1.5)
      if (i == 1) then
        GetPrefabData(("turret_dumbo 0" .. i)).CurrentlyFiring = true
      end
    end
    if (GetGlobal("FTL_Fort_DumboRepaired") == 1) then
      FireUser1("turret_dumbo 04")
    elseif IsValidHandle("fortDumbo4_Door") then
      Print("rotating Door")
      InstantRotateToPosition("fortDumbo4_Door", -90)
    end
  end
  return 
end
FTL_Fort_Setup_Launcher = function()
  Print("FTL_Fort_Setup_Launcher")
  if (string.sub(tostring(LevelManager_GetCurrentState()), 14, 14) == "1") then
    if (GetGlobal("FTL_Ian_FortIntro_Played") == 0) then
      Print("FTL_Fort_Setup_Launcher: Hey look we are in Visit 1 and loading from the Launcher! So lets change the Projector to be set up correctly.")
      local data = GetPrefabData("Projector_ToTrainTunnels")
      data.SkipJumpOutAnim = true
      data.SkipSideCameraRelease = true
      data.ToFlyThrough = "True"
    end
  else
    local currentLevel, currentLevel = string.sub(tostring(LevelManager_GetCurrentState()), 16, 19), tostring(LevelManager_GetCurrentState())
    if (currentLevel == "dock") then
      currentLevel = AnimGBSequence
      currentLevel("FTL_FortDoor", "Closed")
      currentLevel = ForEachEntityInGroup
      currentLevel(Enable, "OswaldBlocker_FortDoor")
      currentLevel = string
      currentLevel = currentLevel.sub
      currentLevel = currentLevel(tostring(LevelManager_GetCurrentState()), 24, 27)
      if (currentLevel == "tree") then
        currentLevel = MoveClockHands
        currentLevel("ClockOuter", "Unhide")
        currentLevel = Hide
        currentLevel("FTL_ClockOuter_clockHourHand_DoorOpen")
        currentLevel = Hide
        currentLevel("FTL_ClockOuter_clockSecondHand_DoorOpen")
        currentLevel = AnimGBSequence
        currentLevel("FTL_ClockDoor", "Rest")
        currentLevel = Enable
        currentLevel("OswaldBlocker_ClockDoor")
        currentLevel = ForEachEntityInGroup
        currentLevel(AnimGBSequence, "FTL_TreeDoors", "Rest")
        currentLevel = Enable
        currentLevel("OswaldBlocker_TreeDoors")
        currentLevel = AnimGBSequence
        currentLevel("FTL_CliffDoor", "rest open")
        currentLevel = ForEachEntityInGroup
        currentLevel(Disable, "OswaldBlocker_CliffDoor")
      end
    elseif (currentLevel == "fort") then
      currentLevel = GetGlobal
      currentLevel = currentLevel("DEC_Hardload")
      if (currentLevel == 1) then
        currentLevel = GetPrefabData
        currentLevel = currentLevel("Projector_ToFloatShortcut")
        local Projector_Data = "Projector_ToFloatShortcut"
        currentLevel.MapLoad_SetupPosition = "IgnoreMe"
        currentLevel.ExitFunction = "None"
        Projector_Data = IsValidHandle
        Projector_Data = Projector_Data("FTL_fort_OutroRockfaceRubble")
        if Projector_Data then
          Projector_Data = DestroyEntity
          Projector_Data("FTL_fort_OutroRockfaceRubble")
        end
        Projector_Data = GetPrefabData
        Projector_Data = Projector_Data("DEC_toFloat3D")
        local DEC_Data = "DEC_toFloat3D"
        DEC_Data = Projector_Data.HardLoadExitFunction
        DEC_Data = DEC_Data[1]
        if (DEC_Data ~= "Busy") then
          DEC_Data = Projector_Data.HardLoadExitFunction
          DEC_Data[reg_72] = "Reverse"
          DEC_Data = Prefab_DECFoopToob_AlwaysSetup
          DEC_Data("DEC_toFloat3D")
        end
      end
    end
  end
  return 
end
FTL_Fort_SetProjectorCamera = function()
  local _player = GetPlayer()
  local _player2 = GetPlayer2OrAI()
  if (GetNumPlayers() == 2) then
    SetCameraAttributesForPlayer("FTL_Fort_IntroOverride_coopPlayer1", _player)
  else
    SetCameraAttributesForPlayer("Projector_ToTrainTunnels", _player)
  end
  SetCameraAttributesForPlayer("FTL_Fort_IntroOverride_coopPlayer2", _player2)
  FireThread(StationaryCamera_UntilPlayerMoves)
  FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, _player2)
  return 
end
TRT_LoadGulch = function(exitProjector)
  Print("TRT_LoadGulch")
  local data = GetPrefabData(exitProjector)
  local visit = 2
  local global = GetGlobal("EM2_EpisodeCheck")
  Print(("TRT_LoadGulch: Episode " .. global))
  if (global == 2) then
    visit = 1
    if (global == 1) then
      SetGlobal("EM2_EpisodeCheck", 2)
    end
  end
  if (data.TeleportToMarker == "Projector_ToFloatShortcut") then
    LevelManager_SetCurrentState((("FTL_Fort01a.V" .. tostring(visit)) .. "_Fort_ALTunnel"))
  elseif (data.Interior_Stream == "TRT_TrainTunnels.Transition2D") then
    LevelManager_SetCurrentState((("FTL_Fort01a.V" .. tostring(visit)) .. "_Docks_ALTrees"))
  end
  if (GetGlobal("FTL_Ian_FortIntro_Played") == 0) then
    LevelManager_SetZoneStatusActive("FTL_Fort01a.V1_NPCs")
    LevelManager_SetZoneStatusActive("FTL_Fort01a.V1_Ian")
  end
  WaitForLevelLoad()
  if (GetGlobal("FTL_Ian_FortIntro_Played") == 0) then
    local data = GetPrefabData("Projector_ToTrainTunnels")
    data.ToFlyThrough = "True"
    data.SkipJumpOutAnim = true
  end
  DestroyEntity("Trigger_Setup_Launcher")
  SetupPosition()
  return 
end
FTL_SetCheckpointLocation = function(target, location)
  if (location ~= nil) then
    FTL_CurrentCheckpointLocation = location
  end
  return 
end
FTL_SaveCheckpoint = function(location)
  wait(0.20000000298023224)
  if (location ~= nil) then
    if (location ~= "parameter1") then
      FTL_CurrentCheckpointLocation = location
    end
  end
  Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* FTL_SaveCheckpoint saving to Save_" .. FTL_CurrentCheckpointLocation) .. "_MickeyStart"))
  SaveCheckpoint(nil, "FTL_Fort_Setup", (("Save_" .. FTL_CurrentCheckpointLocation) .. "_MickeyStart"), (("Save_" .. FTL_CurrentCheckpointLocation) .. "_OswaldStart"))
  return 
end
FTL_Fort_ExitJail = function()
  RemoveAllMusicStateOverride()
  Prefab_ExitInterior_FadeIn()
  return 
end
FTL_Fort_ArtDebugTeleporting = function(target)
  local zone = string.sub(GetName(target), -1, -1)
  if (zone == 1) then
    FTL_Fort_AirlockStreaming_Visit("Dock")
  end
  if (zone == 3) then
    FTL_Fort_AirlockStreaming_Visit("Fort")
  end
  return 
end
FTL_Fort_GusHints = function()
  if (GetGlobal("FTL_Gus_SlobberTraining_Played") == 1) then
    if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
      if IsValidHandle("Slobber") then
        ForceSequence("Gus_v1", "FTL_Gus_SlobberHints")
      end
    end
  else
    ForceSequence("Gus_v1", "FTL_Gus_PlayerDirectionHints")
  end
  return 
end
FTL_Fort_FakeDumbo = function(target, state)
  if (state == "Fixed") then
    ForceSequence("Gus", "FTL_Gus_FixDumboCannon")
    SetGlobal("FTL_Fort_DumboRepaired", 1)
    FireUser1("turret_dumbo 04")
    AnimGBSequence("ftl_fort_01c_scripting.Fake_Dumbo", "Anim")
    wait(1.5)
    DestroyEntity("ftl_fort_01c_scripting.Fake_Dumbo")
  elseif (state == "Loop") then
    if (GetGlobal("FTL_Fort_DumboRepaired") == 0) then
      AnimGBSequence(target, "Anim")
      wait(0.75)
      if (GetGlobal("FTL_Fort_DumboRepaired") == 0) then
        AnimGBSequence(target, "Rest")
        wait(0.75)
        if (GetGlobal("FTL_Fort_DumboRepaired") == 0) then
          FireThread(FTL_Fort_FakeDumbo, target, "Loop")
        end
      end
    end
  end
  return 
end
FTL_Fort_ClockHandCheck = function(target, state)
  Print("FTL_Fort_ClockHandCheck")
  local global = GetGlobal("FTL_ClockHandState")
  if (state == nil) then
    Print("FTL_Fort_ClockHandCheck state == nil -- Player Pushed the Button!")
  elseif (state == "DoorOpen") then
    Print("FTL_Fort_ClockHandCheck state == DoorOpen -- So we are just placing the Hands.")
  end
  Print(("FTL_Fort_ClockHandCheck: global = " .. global))
  if (global ~= 100) then
    Print("FTL_Fort_ClockHandCheck: global ~= 100 so lets put those Hands to Work.")
    local MoveHands = function(hand)
      if IsHidden(hand) then
        Print((("FTL_Fort_ClockHandCheck: " .. hand) .. " is hidden"))
        UseQuestItems("Clock_Hand", 1)
        if (state == "DoorOpen") then
          hand = (hand .. "_DoorOpen")
        end
        Unhide(hand)
      end
      return 
    end
    if (0 < GetCurrentCount("Clock_Hand")) then
      if (GetGlobal("FTL_ClockHandState_Hour") == 1) then
        if (tonumber(string.sub(tostring(global), -1, -1)) ~= 1) then
          Print("FTL_Fort_ClockHandCheck: FTL_ClockHandState_Hour = 1")
          global = (global + 1)
          MoveHands("FTL_ClockOuter_clockHourHand")
        end
      end
    end
    if (0 < GetCurrentCount("Clock_Hand")) then
      if (GetGlobal("FTL_ClockHandState_Second") == 1) then
        if (tonumber(string.sub(tostring(global), -2, -2)) ~= 1) then
          Print("FTL_Fort_ClockHandCheck: FTL_ClockHandState_Second == 2")
          global = (global + 10)
          MoveHands("FTL_ClockOuter_clockSecondHand")
        end
      end
    end
    SetGlobal("FTL_ClockHandState", global)
    wait(0)
    ForceSequence("Gus", "FTL_Gus_ClockFace")
    Print(("FTL_Fort_ClockHandCheck: global = " .. global))
    if (GetGlobal("FTL_ClockHandState") == 11) then
      SetGlobal("FTL_ClockHandState", 100)
      SetPropertyFloat("Trigger_PlaceClockHands_DoorOpen", "UsableRadius", 0)
    end
  end
  if (state == nil) then
    if (GetGlobal("FTL_ClockHandState") == 100) then
      Disable(target)
      if IsValidHandle("GusHint_ClockDoor") then
        DestroyEntity("GusHint_ClockDoor")
      end
      MoveClockHands("ClockInner", "Hide")
      MoveClockHands("ClockOuter", "Activate")
      MoveClockHands("FortInner", "Unhide")
      AnimGBSequence("FTL_FortDoor", "Closed")
      AnimGBSequence("FTL_CliffDoor", "close")
      FTL_Fort_AirlockStreaming("ClockDoor")
      MoveClockHands("ClockOuter", "Hide")
      Prefab_OswaldElectricSwitch_ChangeState(GetRelativePrefabEntity("CliffDoorOuter_Watch", ".OswaldSwitchStand"), "Reset")
      Prefab_OswaldElectricSwitch_ChangeState(GetRelativePrefabEntity("ClockDoor_Watch", ".OswaldSwitchStand"), "FullyCharged")
      while true do
        if (not IsHidden("FTL_ClockOuter_clockHourHand")) then
          Print("FTL_Fort_ClockHandCheck: state = HideHands: All Hands are Hidden, opening the Door")
          wait(0.20000000298023224)
        end
      end
      AnimGBSequence("FTL_ClockDoor", "Anim", true)
      ForEachEntityInGroup(Enable, "OswaldBlocker_FortDoor")
      ForEachEntityInGroup(Enable, "OswaldBlocker_CliffDoor")
      Disable("OswaldBlocker_ClockDoor")
      while true do
        if (not (GetPropertyString("FTL_ClockDoor", "Sequence Names", GetPropertyInt("FTL_ClockDoor", "Active Sequence ID")) ~= "rest open")) then
          break
        end
        wait(0.20000000298023224)
      end
      FireThread(FTL_Fort_AirlockStreaming, "ClockDoorOutside", "Save")
    end
  end
  return 
end
FTL_Fort_AcquireClockPiece = function()
  ActivateGremlinHint("GusHint_ClockDoor")
  FTL_SaveCheckpoint("Docks")
  return 
end
FTL_Fort_FallenTreeCheck = function(target, tree_num)
  AnimGBSequence(("FTL_Fort_FallenTree_Up" .. tree_num), "fall")
  local global = GetGlobal("FTL_Fort_ForestClearingState")
  Print(("FTL_Fort_FallenTreeCheck -- Global = " .. global))
  ForEachEntityInGroup(enableJumpVolumeAvailability, ("JV_ToTree" .. tree_num))
  if (tree_num == "3") then
    if (global == 0) then
      SetGlobal("FTL_Fort_ForestClearingState", 1)
      SetGlobal("FWL_QuestHealth", 10)
      ForceSequence("Gus", "FTL_Gus_TreeFall")
      AnimGBSequence("FTL_fortBrokenWall", "Anim", true)
      StartEmitters("ftl_fort_01c_art.FTL_fortTreeWallCrash_01a 01")
      DoStinger("Stinger_Moment", 2)
      Print("Tree crash fort stinger music")
      wait(1)
      Unhide("ftl_fort_01c_art.FTL_fortTreeWallCrash_01a 01")
      wait(1)
      StopEmitters("ftl_fort_01c_art.FTL_fortTreeWallCrash_01a 01")
    end
  end
  return 
end
FTL_Fort_TooggleJumpAvailability = function(target, toon_Name)
  if (toon_Name == "BabeNose_Thinned") then
    SetUserEdgeDisabled("Environments/_Design/Frontierland/Fort/FTL_fort_01c.gsa", "Toon_ToBabeToon", true)
    SetUserEdgeDisabled("Environments/_Design/Frontierland/Fort/FTL_fort_01c.gsa", "Toon_ToBabeInert", false)
  elseif (toon_Name == "BabeNose_Painted") then
    SetUserEdgeDisabled("Environments/_Design/Frontierland/Fort/FTL_fort_01c.gsa", "Toon_ToBabeInert", true)
    SetUserEdgeDisabled("Environments/_Design/Frontierland/Fort/FTL_fort_01c.gsa", "Toon_ToBabeToon", false)
  elseif (toon_Name == "TrunkPainted") then
    SetUserEdgeDisabled("Environments/_Design/Frontierland/Fort/FTL_fort_01c.gsa", "ToonJump_Lower", true)
    SetUserEdgeDisabled("Environments/_Design/Frontierland/Fort/FTL_fort_01c.gsa", "ToonJump_Upper", false)
  elseif (toon_Name == "TrunkThinned") then
    SetUserEdgeDisabled("Environments/_Design/Frontierland/Fort/FTL_fort_01c.gsa", "ToonJump_Upper", true)
    SetUserEdgeDisabled("Environments/_Design/Frontierland/Fort/FTL_fort_01c.gsa", "ToonJump_Lower", false)
  end
  return 
end
FTL_Gulch_GP_Change = function(target)
  local ThinnerFalls = "FTL_Fort_ThinnerFalls"
  SetPropertyFloat(ThinnerFalls, "CurrentPlaystyle", GetPropertyFloat(target, "CurrentPlaystyle"))
  local state = GetPrefabData(target).GP_State
  Print(("FTL_Gulch_GP_Change: " .. state))
  if (state == "Neutral") then
    ForEachEntityInGroup(Disable, "Trigger_Guardian_AIObstacle")
    SetPropertyFloat(ThinnerFalls, "StimulusPerSecondList", 0, 0)
    SetPropertyFloat(ThinnerFalls, "StimulusPerSecondList", 0, 1)
    SetPropertyFloat(ThinnerFalls, "StimulusPerSecondList", 0, 2)
    SetPropertyFloat(ThinnerFalls, "StimulusPerSecondList", 0, 4)
    SetPropertyInt(ThinnerFalls, "Collision Layer", 13)
  end
  if (state == "Thinner") then
    ForEachEntityInGroup(Enable, "Trigger_Guardian_AIObstacle")
    SetPropertyInt(ThinnerFalls, "Collision Layer", 1)
    SetPropertyFloat(ThinnerFalls, "StimulusPerSecondList", 1, 0)
    SetPropertyFloat(ThinnerFalls, "StimulusPerSecondList", 100000, 1)
    SetPropertyFloat(ThinnerFalls, "StimulusPerSecondList", 1000, 2)
    SetPropertyFloat(ThinnerFalls, "StimulusPerSecondList", 1, 4)
  end
  return 
end
FTL_Fort_ShakyExit = function(state, CheckpointCheck)
  if (state == "Pipe") then
    FireUser3("IGC_ShakyClosePipe1")
    TeleportGremlinOut("Gremlin_Shaky")
    wait(0.30000001192092896)
    DestroyEntity("Gremlin_Shaky")
  elseif (state == "FixPipe") then
    FireUser1("IGC_ShakyClosePipe1")
    local gremlin = "Gremlin_Shaky"
    Hide(gremlin)
    TeleportGremlinIn(gremlin, "FTL_Shaky_CloseSpatterPipe", false)
    AnimVarInt(gremlin, VAR_Cutscene, 1)
    AnimEvent(gremlin, EVENT_Start_Cutscene)
  elseif (state == "Freed") then
    FireThread(TeleportGremlinToEntity, "Gremlin_Shaky", "FTL_Shaky_FortWall")
    FireUser1("IGC_GremlinToFort")
    wait(4)
    FireUser3("IGC_GremlinToFort")
    wait(0.5)
    Enable("Gremlin_WallLookTrigger")
    MoveToEntity("Gremlin_WallLookTrigger", GetPlayer())
    SetCharacterInConversation(GetPlayer(), 0)
    FTL_SaveCheckpoint()
  elseif (CheckpointCheck ~= nil) then
    if (GetGlobal("FTL_Shaky_Freed_Played") == 1) then
      if (GetGlobal("FTL_Shaky_PipeDisable_Played") == 1) then
        Print("unload Gremlin")
        LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.Q_RescueGremlin")
      end
      Print("Teleporting Shaky")
      local gremlin, gremlin = "Gremlin_Shaky", "Teleporting Shaky"
      gremlin = Hide
      gremlin(gremlin)
      gremlin = wait
      gremlin(1)
      gremlin = IsValidHandle
      gremlin = gremlin("Gremlin_Shaky")
      if gremlin then
        gremlin = TeleportGremlinIn
        gremlin(gremlin, "FTL_Shaky_FortWall", false)
        gremlin = SetNPCState
        gremlin(gremlin, 0)
        gremlin = AnimVarInt
        gremlin(gremlin, VAR_Mood_Type, MOOD_Positive)
        gremlin = SetVulnerability
        gremlin(gremlin, ST_PAINT, 1)
        gremlin = SetVulnerability
        gremlin(gremlin, ST_THINNER, 1)
        gremlin = SetVulnerability
        gremlin(gremlin, ST_SPIN, 1)
        gremlin = SetVulnerability
        gremlin(gremlin, ST_KNOCKBACK, 1)
        gremlin = SetPropertyBool
        gremlin(gremlin, "ForceInvulnerable", false)
        gremlin = SetPropertyFloat
        gremlin(gremlin, "NegativeThreshold", 2.5)
        gremlin = SetPropertyFloat
        gremlin(gremlin, "PositiveThreshold", 2.5)
      end
    end
  end
  return 
end
FTL_Fort_CoopAction = function(target, action, location)
  if (action == "Glide") then
    SetNextPatrolNode(GetOswaldAI(), ("PN_CoopGlide_" .. location))
  elseif (action == "Toss") then
    Print("FTL_Fort_CoopToss -- booga")
    if (GetPrefabData(target).MickeyInTrigger == true) then
      if (_activator() == GetOswaldAI()) then
        Print("FTL_Fort_CoopToss - toss")
        OswaldTossAction()
      end
    else
      SetNextPatrolNode(GetOswaldAI(), "PN_CoopTossFront")
      Print("FTL_Fort_CoopToss - goto")
      if (action == "Blast") then
        if (GetGlobal("FTL_Gus_MachineBroken_Played") == 0) then
          OswaldBlastAction(target)
          wait(1)
          OswaldStartFollowAction()
        end
      elseif (action == "BottleCap_Glide") then
        QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Wait_For_Attach, GetPosition(target))
        OswaldStartFollowAction()
      end
    end
  elseif (action == "Blast") then
    if (GetGlobal("FTL_Gus_MachineBroken_Played") == 0) then
      OswaldBlastAction(target)
      wait(1)
      OswaldStartFollowAction()
    end
  elseif (action == "BottleCap_Glide") then
    QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Wait_For_Attach, GetPosition(target))
    OswaldStartFollowAction()
  end
  return 
end
FTL_Fort_CapturedBunnies = function()
  FireSequence("Gus_v2", "FTL_Gus_CaptureBunnies")
  return 
end
FTL_Fort_Photo_Taken = function(global, _event, obj)
  local event = _event
  if (event ~= nil) then
    local displayText = false
    if (GetGlobal((("FTL_Gus_" .. obj) .. "Photo_Played")) == 0) then
      if (obj == "Metairie") then
        if (not (not Quest_CheckStatus("A_Friend_In_Deed", "A_Friend_In_Deed_4b", Quest_Discovered))) then
          displayText = true
        end
        Disable("PM_Photo_Metairie_Bear")
        SetMapMarkerVisible("MapMarker_MetairieBear", false)
      elseif (obj == "Memories") then
        if Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_3b", Quest_Discovered) then
          displayText = true
        end
        Disable("PM_Photo_Bell")
        SetMapMarkerVisible("MapMarker_GreeneItem", false)
      elseif (obj == "ScoreCheck") then
        local score = GetPictureScoreFromEvent(event)
        Print(((("Photo " .. obj) .. " ") .. tostring(score)))
        if (score < 1) then
          if (0.4000000059604645 < score) then
            FireSequence("Gus", "Global_Gus_PhotoNotQuite")
          end
        end
      end
      if displayText then
        FireSequence("Gus", (("FTL_Gus_" .. obj) .. "Photo"))
      end
    end
  else
    Print(("Photo: " .. global))
    if (global == "MSN_Adelle_Gulch2FortVar") then
      if (GetGlobal("FTL_Fort_DumboRepaired") == 0) then
        SetGlobal(global, 1)
      else
        SetGlobal(global, 2)
        if (global == "MSN_Adelle_Gulch2ForestVar") then
          if (0 < GetGlobal("FTL_Fort_ForestClearingState")) then
            SetGlobal(global, 1)
          else
            SetGlobal(global, 2)
          end
        end
      end
    elseif (global == "MSN_Adelle_Gulch2ForestVar") then
      if (0 < GetGlobal("FTL_Fort_ForestClearingState")) then
        SetGlobal(global, 1)
      else
        SetGlobal(global, 2)
      end
    end
  end
  return 
end
FTL_Fort_LoadDEC = function()
  WaitForLevelLoad()
  wait(0.20000000298023224)
  local _player = GetPlayer()
  local _player2 = GetPlayer2OrAI()
  TeleportToEntity(_player, "PM_DEC_MickeyStart")
  TeleportToEntity(_player2, "PM_DEC_OswaldStart")
  EnableMotion_Player(_player)
  EnableMotion_Player(_player2)
  wait(0.10000000149011612)
  CameraReset()
  wait(0.10000000149011612)
  gs05_StartUp()
  StartFadeIn(0.4000000059604645)
  wait(0.4000000059604645)
  UnrestrictCutSceneInput()
  wait(1)
  StreamZones(GetPlayer(), "Tran_ToFloat")
  return 
end
MoveClockHands = function(loc, action)
  Print(((("MoveClockHands: loc = " .. loc) .. " & action = ") .. action))
  local RepositionHands = function(hand, offset)
    Print(("MoveClockHands: RepositionHands: hand = " .. hand))
    local MoveHands = function(hand, setup_action)
      Print(("MoveClockHands: RepositionHands: MoveHands hand = " .. hand))
      local percentage = (1 - offset)
      if (setup_action == nil) then
        if (action == "Hide") then
          Print("MoveClockHands: RepositionHands: MoveHands: action = Hide or Setup AND setup_action == nil")
          percentage = 0.5
        end
      end
      SplineFollower_SetDisabled(hand, false)
      SetSplineFollowerInitialSpeed(hand, 0.5)
      SplineFollower_StopAtPosition(hand, (("SK_" .. loc) .. "_1"), (("SK_" .. loc) .. "_2"), percentage)
      return 
    end
    local ClockOuterCheck = function(hand)
      if (loc == "ClockOuter") then
        Print(("MoveClockHands: RepositionHands: ClockOuterCheck(): hand = " .. hand))
        local global = GetGlobal("FTL_ClockHandState")
        local hand_string = string.sub(hand, -5)
        if (global == 100) then
          Print("MoveClockHands: RepositionHands: ClockOuterCheck(): FTL_ClockHandState == 100 so returning true")
          return true
        elseif (tonumber(string.sub(tostring(global), -1, -1)) ~= 1) then
          if (hand_string == "rHand") then
            Print("MoveClockHands: RepositionHands: ClockOuterCheck(): false")
            return false
          end
        elseif (tonumber(string.sub(tostring(global), -2, -2)) ~= 1) then
          if (hand_string == "dHand") then
            Print("MoveClockHands: RepositionHands: ClockOuterCheck(): false")
            return false
          end
        else
          Print("MoveClockHands: RepositionHands: ClockOuterCheck(): true")
          return true
        end
      else
        return true
      end
      return 
    end
    if (action == "Unhide") then
      if IsHidden(hand) then
        if ClockOuterCheck(hand) then
          Print(("MoveClockHands: RepositionHands: Unhiding " .. tostring(hand)))
          Unhide(hand)
          MoveHands(hand)
        end
      end
    elseif (action == "Activate") then
      if (not IsHidden(hand)) then
        Print(("MoveClockHands: RepositionHands: Activating " .. tostring(hand)))
        Enable(hand)
        AudioPostEventOn("ftl_fort_01b_audio.Sound_Marker_Clock", "Play_sfx_DG2_ClockSpin")
        Print("clock sndfx start")
      end
    elseif (action == "Hide") then
      if (not IsHidden(hand)) then
        if ClockOuterCheck(hand) then
          Print(("MoveClockHands: RepositionHands: Hiding " .. tostring(hand)))
          AudioPostEventOn("ftl_fort_01b_audio.Sound_Marker_Clock", "Stop_sfx_DG2_ClockSpin")
          Print("clock sndfx stop")
          Disable(hand)
          wait(0.25)
          MoveHands(hand)
          wait(0.25)
          Hide(hand)
        end
      end
    elseif (action == "Setup") then
      if ClockOuterCheck(hand) then
        Print("MoveClockHands: RepositionHands: action == Setup")
        if IsHidden(hand) then
          MoveHands(hand)
        end
      end
    end
    return 
  end
  FireThread(RepositionHands, (("FTL_" .. loc) .. "_clockHourHand"), 0)
  FireThread(RepositionHands, (("FTL_" .. loc) .. "_clockMinuteHand"), 0)
  FireThread(RepositionHands, (("FTL_" .. loc) .. "_clockSecondHand"), 0.10000000149011612)
  return 
end
FTL_Fort_PullHandles = function(target, mech_Name, Dir)
  if (mech_Name == nil) then
    local mech_Name = GetPrefabData(target).Door
    if (GetPrefabData((mech_Name .. "_Watch")).BusyStreaming == false) then
      GetPrefabData((mech_Name .. "_Watch")).BusyStreaming = true
      DeactivateWatchSketch(GetPlayer(), 1)
      DestroyEntity("Watch")
      local CloseAirlockDoorsAndStream = function(doorToClose, AirlockToStream, doorToOpen, startingLevelString)
        Print(("FTL_Fort_PullHandles: CloseAirlockDoorsAndStream - doorToClose = " .. doorToClose))
        if (doorToClose == "FTL_CliffDoor") then
          ForEachEntityInGroup(StartEmitters, "FX_CliffDoorOpening")
        end
        if (mech_Name ~= "CliffDoorOuter") then
          if (doorToClose == "FTL_CliffDoor") then
            ForEachEntityInGroup(AnimGBSequence, doorToClose, "close", true, 0.4000000059604645)
          else
            ForEachEntityInGroup(AnimGBSequence, doorToClose, "close", true)
          end
          if (doorToClose == "FTL_TreeDoors") then
            doorToClose = "FTL_TreeDoor1"
          end
          while true do
            if (not (GetPropertyInt(doorToClose, "Active Sequence ID") ~= 0)) then
              break
            end
            if (not (startingLevelString == nil)) then
              break
            end
            wait(0.20000000298023224)
          end
        end
        ForEachEntityInGroup(Enable, ("OswaldBlocker_" .. string.sub(doorToClose, 5, -1)))
        Print(("Enabling OswaldBlocker_" .. string.sub(doorToClose, 5, -1)))
        local fx = (("FX_" .. string.sub(doorToOpen, 5, -1)) .. "Opening")
        if (doorToOpen == "FTL_CliffDoor") then
          if (doorToClose == "FTL_CliffDoor") then
            ForEachEntityInGroup(StopEmitters, "FX_CliffDoorOpening")
          end
          ForEachEntityInGroup(StartEmitters, fx)
        end
        Print(("FTL_Fort_PullHandles: CloseAirlockDoorsAndStream - AirlockToStream = " .. AirlockToStream))
        FTL_Fort_AirlockStreaming(AirlockToStream)
        local OpenDoor = function()
          wait(1)
          Print(("FTL_Fort_PullHandles: CloseAirlockDoorsAndStream - doorToOpen = " .. doorToOpen))
          ForEachEntityInGroup(AnimGBSequence, doorToOpen, "Anim", true)
          if (doorToOpen == "FTL_CliffDoor") then
            ForEachEntityInGroup(StopEmitters, fx)
          end
          ForEachEntityInGroup(Disable, ("OswaldBlocker_" .. string.sub(doorToOpen, 5, -1)))
          Print(("Disabling OswaldBlocker_" .. string.sub(doorToOpen, 5, -1)))
          return 
        end
        FireThread(OpenDoor)
        return 
      end
      local LevelString = tostring(LevelManager_GetCurrentState())
      local SetCriticalPath = function(state)
        if (string.sub(LevelString, 22, 22) == "1") then
          local questState = state
          if (GetGlobal("FTL_Fort_SpatterCombat") ~= 10) then
            questState = "2"
          end
          Quest_SetCriticalPath("Critical_Gulch2", ("Critical_Gulch2_" .. questState))
        end
        return 
      end
      local startingLevelString = string.sub(LevelString, 16, 19)
      local doorName = string.sub(mech_Name, 1, -6)
      local doorToOpen = "None"
      if (mech_Name == "FortDoorInner") then
        if (GetGlobal("FTL_Fort_SpatterCombat") ~= 1) then
          AnimGBSequence("FTL_ClockDoor", "Rest")
          local handsToHide = "FortOuter"
          local handsToActivate = "FortInner"
          if (mech_Name == "FortDoorOuter") then
            handsToHide = "FortInner"
            handsToActivate = "FortOuter"
            SetCriticalPath("4b")
          else
            SetCriticalPath("1")
          end
          MoveClockHands(handsToHide, "Hide")
          MoveClockHands(handsToActivate, "Activate")
          Enable("OswaldBlocker_TreeDoors")
          Enable("OswaldBlocker_ClockDoor")
          FTL_Fort_AirlockStreaming(mech_Name)
          local stand = GetRelativePrefabEntity("FortDoorOuter_Watch", ".OswaldSwitchStand")
          if (mech_Name == "FortDoorOuter") then
            stand = GetRelativePrefabEntity("FortDoorInner_Watch", ".OswaldSwitchStand")
          end
          Prefab_OswaldElectricSwitch_ChangeState(stand, "FullyCharged")
          ForEachEntityInGroup(Disable, "OswaldBlocker_FortDoor")
          FireThread(MoveClockHands, "ClockInner", "Unhide")
          MoveClockHands(handsToActivate, "Hide")
          doorToOpen = "FTL_FortDoor"
          AnimGBSequence("FTL_FortDoor", "Open", true)
          stand = GetRelativePrefabEntity("ClockDoor_Watch", ".OswaldSwitchStand")
          Prefab_OswaldElectricSwitch_ChangeState(stand, "Reset")
          Prefab_OswaldElectricSwitch_ChangeState(stand, "Deactivate")
        end
      end
      if (mech_Name == "ClockDoor") then
        if (startingLevelString == "dock") then
          doorName = (mech_Name .. "Outside")
          Print(((("FTL_Fort_AirlockStreaming(" .. tostring(mech_Name)) .. "): coming from Docks to Tunnel Airlock so changing the Save Location = ") .. doorName))
          SetCriticalPath("4b")
        else
          doorName = mech_Name
          SetCriticalPath("3")
        end
        AnimGBSequence("FTL_FortDoor", "Closed")
        Print(("FTL_Fort_PullHandles: levelString = " .. startingLevelString))
        MoveClockHands("ClockOuter", "Hide")
        MoveClockHands("ClockInner", "Activate")
        CloseAirlockDoorsAndStream("FTL_CliffDoor", mech_Name, "FTL_ClockDoor", startingLevelString)
        doorToOpen = "FTL_ClockDoor"
        FireThread(MoveClockHands, "FortInner", "Unhide")
        MoveClockHands("ClockInner", "Hide")
      elseif (mech_Name == "CliffDoorInner") then
        if (GetPropertyInt("FTL_TreeDoor1", "Active Sequence ID") == 0) then
          MoveClockHands("ClockOuter", "Hide")
          CloseAirlockDoorsAndStream("FTL_CliffDoor", "TreeDoorInner", "FTL_TreeDoors")
          doorToOpen = "FTL_TreeDoor1"
          FireThread(MoveClockHands, "FortOuter", "Unhide")
          doorName = "TreeDoor"
          SetCriticalPath("4b")
        end
      elseif (mech_Name == "CliffDoorInner") then
        if (GetPropertyInt("FTL_CliffDoor", "Active Sequence ID") ~= 3) then
          MoveClockHands("FortInner", "Hide")
          AnimGBSequence("FTL_ClockDoor", "close", true)
          FireThread(MoveClockHands, "ClockOuter", "Unhide")
          CloseAirlockDoorsAndStream("FTL_TreeDoors", mech_Name, "FTL_CliffDoor")
          ForEachEntityInGroup(AnimGBSequence, "FTL_TreeDoors", "Rest")
          doorToOpen = "FTL_CliffDoor"
          Prefab_OswaldElectricSwitch_ChangeState(GetRelativePrefabEntity("CliffDoorOuter_Watch", ".OswaldSwitchStand"), "FullyCharged")
          SetCriticalPath("3")
        end
      end
      OswaldStartFollowAction()
      GetPrefabData((mech_Name .. "_Watch")).BusyStreaming = false
      if (mech_Name == "ClockDoor") then
        local stand = GetRelativePrefabEntity(target, ".OswaldSwitchStand")
        if (mech_Name == "ClockDoor") then
          stand = ".OswaldSwitchStand"
          stand = GetRelativePrefabEntity("FortDoorInner_Watch", stand)
        elseif (mech_Name == "FortDoorInner") then
          stand = ".OswaldSwitchStand"
          stand = GetRelativePrefabEntity("ClockDoor_Watch", stand)
        end
        stand = "Reset"
        Prefab_OswaldElectricSwitch_ChangeState(stand, stand)
        stand = "Deactivate"
        Prefab_OswaldElectricSwitch_ChangeState(stand, stand)
      end
      if (doorToOpen ~= "None") then
        while true do
          if (not (GetPropertyString(doorToOpen, "Sequence Names", GetPropertyInt(doorToOpen, "Active Sequence ID")) ~= "rest open")) then
            break
          end
          wait(0.20000000298023224)
        end
        FireThread(FTL_Fort_AirlockStreaming, doorName, "Save")
      end
    end
  elseif (mech_Name == "Machine") then
    if (Dir == "In") then
      if (GetGlobal("FTL_Fort_SpatterState") == 10) then
        if (GetPrefabData("FortDoorOuter_Watch").BusyStreaming == false) then
          SetNextPatrolNode(GetOswaldAI(), "ftl_fort_01c_scripting.PN_Machine")
          if (GetGlobal("FTL_Gus_MachineIntro_Played") == 0) then
            ForceSequence("Gus_v1", "FTL_Gus_MachineIntro")
          end
          for i = 1, 4 do
            if IsValidHandle(("ftl_fort_01a_visit1.GusHint_CorePath_" .. i)) then
              DestroyEntity(("ftl_fort_01a_visit1.GusHint_CorePath_" .. i))
            end
          end
        elseif (IsAnySequencePlaying() == false) then
          ForceSequence("Gus_v1", "FTL_Gus_MachineIntro")
          ForceSequence("Gus", "FTL_Gus_MoveAlong")
        end
      else
        ForceSequence("Gus", "FTL_Gus_MoveAlong")
      end
      SplineFollower_SetDisabled("Fort_MachineDoor_SF1", false)
      SplineFollower_SetDisabled("Fort_MachineDoor_SF2", false)
      SplineFollower_StopAtPosition("Fort_MachineDoor_SF1", "Fort_MachineDoor_SF1_SK1", "Fort_MachineDoor_SF1_SK2", 1)
      SplineFollower_StopAtPosition("Fort_MachineDoor_SF2", "Fort_MachineDoor_SF2_SK1", "Fort_MachineDoor_SF2_SK2", 1)
      AudioPostEventOn("ftl_fort_01c_audio.Sound_FortMachineDoor", "Play_sfx_DG2_Fort_MachineDoorOpen")
    elseif (Dir == "Out") then
      SplineFollower_StopAtPosition("Fort_MachineDoor_SF1", "Fort_MachineDoor_SF1_SK1", "Fort_MachineDoor_SF1_SK2", 0)
      SplineFollower_StopAtPosition("Fort_MachineDoor_SF2", "Fort_MachineDoor_SF2_SK1", "Fort_MachineDoor_SF2_SK2", 0)
      AudioPostEventOn("ftl_fort_01c_audio.Sound_FortMachineDoor", "Play_sfx_DG2_Fort_MachineDoorClose")
    end
  end
  return 
end
FTL_Fort_AirlockDoorChooseIdleAnim = function(target, doorName)
  local closeAnimNum = 3
  if (doorName == "Cliff") then
    closeAnimNum = 4
  end
  if (GetPropertyInt(target, "Active Sequence ID") == 1) then
    AnimGBSequence(target, "rest open")
  elseif (GetPropertyInt(target, "Active Sequence ID") == closeAnimNum) then
    if (doorName == "Fort") then
      AnimGBSequence(target, "Closed")
    else
      AnimGBSequence(target, "Rest")
    end
  end
  return 
end
FTL_Fort_AirlockStreaming = function(mech_Name, bool)
  if (bool == nil) then
    OswaldStreamAbort()
    Print((("FTL_Fort_AirlockStreaming(" .. tostring(mech_Name)) .. "): Streaming Time!"))
    local zone = "Fort"
    local subZone = "_ALTrees"
    local doorName = string.sub(mech_Name, 1, -6)
    if (doorName == "CliffDoor") then
      zone = "Docks"
    end
    if (doorName == "FortDoor") then
      subZone = "_ALTunnel"
    end
    Print((((("FTL_Fort_AirlockStreaming(" .. tostring(mech_Name)) .. "): Streaming Time - zone = ") .. zone) .. subZone))
    local levelString = LevelManager_GetCurrentState()
    local startingLevelString = string.sub(tostring(levelString), 16, 19)
    Print(("FTL_Fort_AirlockStreaming: levelString = " .. startingLevelString))
    local stateToStream, zonesToStream = FTL_Fort_AirlockStreaming_Visit((zone .. subZone))
    local zone_arrayLen = (#zonesToStream)
    Print(("FTL_Fort_AirlockStreaming: zone_arrayLen = " .. zone_arrayLen))
    local ZoneStreamingCheck = function(zone_Num)
      if (zone_Num == 0) then
        return false
      else
        local zonesStreamed = 0
        for i = 1, zone_arrayLen do
          if LevelManager_HasZoneFinishedStreaming(zonesToStream[i]) then
            zonesStreamed = (zonesStreamed + 1)
          end
        end
        if (zonesStreamed == zone_arrayLen) then
          return false
        else
          return true
        end
      end
      return 
    end
    if (doorName == "TreeDoor") then
      doorName = "TreeDoors"
    elseif (mech_Name == "ClockDoor") then
      doorName = mech_Name
    end
    if (mech_Name ~= "ClockDoor") then
      if (mech_Name == "FortDoorInner") then
        OverrideSpawnTransform(PLAYER_ONE, GetPosition((("Save_" .. doorName) .. "_MickeyStart")), GetFacing((("Save_" .. doorName) .. "_MickeyStart")))
        OverrideSpawnTransform(PLAYER_TWO, GetPosition((("Save_" .. doorName) .. "_OswaldStart")), GetFacing((("Save_" .. doorName) .. "_OswaldStart")))
      end
    end
    OverrideSpawnTransform(PLAYER_ONE, GetPosition((("Save_" .. doorName) .. "_MickeyStart")), GetFacing((("Save_" .. doorName) .. "_MickeyStart")))
    OverrideSpawnTransform(PLAYER_TWO, GetPosition((("Save_" .. doorName) .. "_OswaldStart")), GetFacing((("Save_" .. doorName) .. "_OswaldStart")))
    if (doorName ~= "FortDoor") then
      if (doorName ~= "ClockDoor") then
        ForEachEntityInGroup(AnimGBSequence, ("FTL_" .. doorName), "rumble")
      end
    end
    Print(("FTL_Fort_AirlockStreaming: state = " .. stateToStream))
    LevelManager_SetCurrentState(stateToStream)
    wait(1)
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
    Print((("FTL_Fort_AirlockStreaming: state = " .. stateToStream) .. " has streamed in. Streaming in Zones now."))
    for i = 1, zone_arrayLen do
      Print(("FTL_Fort_AirlockStreaming: zone = " .. zonesToStream[i]))
      LevelManager_SetZoneStatusActive(zonesToStream[i])
      wait(0.25)
    end
    local visitNum = string.sub(tostring(levelString), 14, 14)
    if (mech_Name == "FortDoorInner") then
      if (visitNum == "1") then
        if (GetGlobal("FTL_Fort_SpatterState") ~= 10) then
          local NPCTeleportToFortCheck = function()
            Print("NPCTeleportToFortCheck")
            if IsValidHandle("Botantist_Darvin") then
              TeleportToEntity("Botantist_Darvin", "PM_Botantist_Darvin_Streaming")
              Hide("Botantist_Darvin")
            end
            if IsValidHandle("Constance") then
              TeleportToEntity("Constance", "PM_Constance_Streaming")
              Hide("Constance")
            end
            while true do
              if (not LevelManager_HasZoneFinishedStreaming("FTL_fort01a.V1_NPCs")) then
                break
              end
              wait(0.20000000298023224)
              Print("NPCTeleportToFortCheck: Zone while loop - NPCs not Started Streaming yet")
              Print(("FTL_Fort_AirlockStreaming: NPC streaming = " .. tostring((not LevelManager_HasZoneFinishedStreaming("FTL_Fort01a.V1_NPCs")))))
            end
            while true do
              if (not (LevelManager_HasZoneFinishedStreaming("FTL_fort01a.V1_NPCs") == false)) then
                break
              end
              wait(0.20000000298023224)
              Print("NPCTeleportToFortCheck: Zone while loop - NPCs Streaming")
            end
            while true do
              if (not (LevelManager_WaitingForStreamingSync() == false)) then
                break
              end
              Wait(0.05000000074505806)
            end
            if (GetGlobal("FTL_Fort_SpatterState") ~= 10) then
              Print("NPCTeleportToFortCheck: moving NPCs")
              TeleportToEntity("Botantist_Darvin", "PM_Botantist_Darvin_Outro")
              TeleportToEntity("Constance", "PM_Constance_Outro")
            end
            return 
          end
          local NPCCheck = true
          if (mech_Name == "TreeDoorInner") then
            visitNum = "FTL_TreeDoor1"
            NPCTeleportToFortCheck = "Active Sequence ID"
            if (GetPropertyInt(visitNum, NPCTeleportToFortCheck) ~= 2) then
              NPCCheck = false
            end
          end
          if NPCCheck then
            visitNum = NPCTeleportToFortCheck
            FireThread(visitNum)
          end
        end
      end
    end
    while true do
      if (not ZoneStreamingCheck(zone_arrayLen)) then
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
    if (doorName == "TreeDoors") then
      doorName = "TreeDoor"
    end
    visitNum = mech_Name
    visitNum = "): The wait is over!"
    Print((("FTL_Fort_AirlockStreaming(" .. tostring(visitNum)) .. visitNum))
    if (doorName == "CliffDoor") then
      if (doorName == "CliffDoor") then
        if (mech_Name == "CliffDoorOuter") then
          visitNum = 100
          SetPropertyFloat("TCO_CliffDoor", "HintYaw", visitNum)
        else
          visitNum = -100
          SetPropertyFloat("TCO_CliffDoor", "HintYaw", visitNum)
        end
      end
      SetCameraAttributesForPlayer(("TCO_" .. doorName))
    end
    local deactivateFoop = true
    local deactivateProjector = true
    visitNum = "FTL_Fort_SpatterState"
    local global = GetGlobal(visitNum)
    if (global == 1) then
      deactivateProjector = false
    elseif (global ~= 10) then
      deactivateFoop = false
    end
    if (zone == "Fort") then
      if (global == 1) then
        visitNum = AnimGBSequence
        visitNum("FTL_Graveyard_ShortcutDoor", "rest open")
      end
      visitNum = DisableGuardianHint
      visitNum("GusHint_ClockDoor")
      if deactivateFoop then
        visitNum = Prefab_DECFoopToob_ChangeState
        visitNum("DEC_toFloat3D", "Deactivate")
      end
      if deactivateProjector then
        visitNum = Prefab_Projector_ChangeState
        visitNum("Projector_ToFloatShortcut", "Deactivate")
      end
      visitNum = GetGlobal
      visitNum = visitNum("FTL_Fort_SpatterCostume")
      if (visitNum == 0) then
        if (global == 1) then
          Prefab_WorldItem_Unhide("Spatter_Costume_Restored")
        elseif (global == 2) then
          Prefab_WorldItem_Unhide("Spatter_Costume_Tattered")
        end
      end
      deactivateFoop = "Is Painted"
      if GetPropertyBool("FWL_Fort_OneShots28", deactivateFoop) then
        deactivateFoop = nil
        deactivateProjector = "TrunkPainted"
        FireThread(FTL_Fort_TooggleJumpAvailability, deactivateFoop, deactivateProjector)
      else
        deactivateFoop = nil
        deactivateProjector = "TrunkThinned"
        FireThread(FTL_Fort_TooggleJumpAvailability, deactivateFoop, deactivateProjector)
        visitNum = GetCurrentCount
        visitNum = visitNum("Clock_Hand")
        if (0 < visitNum) then
          visitNum = ActivateGremlinHint
          visitNum("GusHint_ClockDoor")
        end
        if (visitNum == 2) then
          if (global ~= 1) then
            visitNum = ForceSpawn
            visitNum("Spawner_DestructiveBlotworx", 1)
          end
        end
        visitNum = GetGlobal
        visitNum = visitNum("FTL_Fort_DumboRepaired")
        if (visitNum == 0) then
          visitNum = Print
          visitNum("rotating Door")
          visitNum = InstantRotateToPosition
          visitNum("fortDumbo4_Door", -90)
        end
        if (deactivateFoop == false) then
          visitNum = SetMapMarkerVisible
          visitNum("MapMarker_FoopToob", true)
        elseif (deactivateProjector == false) then
          visitNum = SetMapMarkerVisible
          visitNum("MapMarker_FortProjector", true)
        end
        if (doorName == "ClockDoor") then
          visitNum = Disable
          visitNum("Trigger_PlaceClockHands")
          visitNum = GetGlobal
          visitNum = visitNum("FTL_ClockHandState")
          if (visitNum ~= 100) then
            deactivateFoop = tostring
            deactivateProjector = visitNum
            deactivateFoop = deactivateFoop(deactivateProjector)
            deactivateProjector = -1
            global = -1
            if (tonumber(string.sub(deactivateFoop, deactivateProjector, global)) == 1) then
              Unhide("FTL_ClockOuter_clockHourHand_DoorOpen")
            end
            deactivateFoop = tostring
            deactivateProjector = visitNum
            deactivateFoop = deactivateFoop(deactivateProjector)
            deactivateProjector = -2
            global = -2
            if (tonumber(string.sub(deactivateFoop, deactivateProjector, global)) == 1) then
              Unhide("FTL_ClockOuter_clockSecondHand_DoorOpen")
            end
            deactivateFoop = "UsableRadius"
            deactivateProjector = 2
            SetPropertyFloat("Trigger_PlaceClockHands_DoorOpen", deactivateFoop, deactivateProjector)
          end
        elseif (mech_Name == "CliffDoorOuter") then
          visitNum = Enable
          visitNum("Trigger_PlaceClockHands")
          visitNum = GetGlobal
          visitNum = visitNum("FTL_ClockHandState")
          if (visitNum == 100) then
            visitNum = SetPropertyFloat
            deactivateFoop = 1.5
            visitNum("Trigger_PlaceClockHands", "UseDelay", deactivateFoop)
          end
          visitNum = SetPropertyFloat
          deactivateFoop = 0
          visitNum("Trigger_PlaceClockHands_DoorOpen", "UsableRadius", deactivateFoop)
          visitNum = Hide
          visitNum("FTL_ClockOuter_clockSecondHand_DoorOpen")
          visitNum = Hide
          visitNum("FTL_ClockOuter_clockHourHand_DoorOpen")
        end
      end
    else
      visitNum = GetCurrentCount
      visitNum = visitNum("Clock_Hand")
      if (0 < visitNum) then
        visitNum = ActivateGremlinHint
        visitNum("GusHint_ClockDoor")
      end
      if (visitNum == 2) then
        if (global ~= 1) then
          visitNum = ForceSpawn
          visitNum("Spawner_DestructiveBlotworx", 1)
        end
      end
      visitNum = GetGlobal
      visitNum = visitNum("FTL_Fort_DumboRepaired")
      if (visitNum == 0) then
        visitNum = Print
        visitNum("rotating Door")
        visitNum = InstantRotateToPosition
        visitNum("fortDumbo4_Door", -90)
      end
      if (deactivateFoop == false) then
        visitNum = SetMapMarkerVisible
        visitNum("MapMarker_FoopToob", true)
      elseif (deactivateProjector == false) then
        visitNum = SetMapMarkerVisible
        visitNum("MapMarker_FortProjector", true)
      end
      if (doorName == "ClockDoor") then
        visitNum = Disable
        visitNum("Trigger_PlaceClockHands")
        visitNum = GetGlobal
        visitNum = visitNum("FTL_ClockHandState")
        if (visitNum ~= 100) then
          deactivateFoop = tostring
          deactivateProjector = visitNum
          deactivateFoop = deactivateFoop(deactivateProjector)
          deactivateProjector = -1
          global = -1
          if (tonumber(string.sub(deactivateFoop, deactivateProjector, global)) == 1) then
            Unhide("FTL_ClockOuter_clockHourHand_DoorOpen")
          end
          deactivateFoop = tostring
          deactivateProjector = visitNum
          deactivateFoop = deactivateFoop(deactivateProjector)
          deactivateProjector = -2
          global = -2
          if (tonumber(string.sub(deactivateFoop, deactivateProjector, global)) == 1) then
            Unhide("FTL_ClockOuter_clockSecondHand_DoorOpen")
          end
          deactivateFoop = "UsableRadius"
          deactivateProjector = 2
          SetPropertyFloat("Trigger_PlaceClockHands_DoorOpen", deactivateFoop, deactivateProjector)
        end
      elseif (mech_Name == "CliffDoorOuter") then
        visitNum = Enable
        visitNum("Trigger_PlaceClockHands")
        visitNum = GetGlobal
        visitNum = visitNum("FTL_ClockHandState")
        if (visitNum == 100) then
          visitNum = SetPropertyFloat
          deactivateFoop = 1.5
          visitNum("Trigger_PlaceClockHands", "UseDelay", deactivateFoop)
        end
        visitNum = SetPropertyFloat
        deactivateFoop = 0
        visitNum("Trigger_PlaceClockHands_DoorOpen", "UsableRadius", deactivateFoop)
        visitNum = Hide
        visitNum("FTL_ClockOuter_clockSecondHand_DoorOpen")
        visitNum = Hide
        visitNum("FTL_ClockOuter_clockHourHand_DoorOpen")
      end
    end
    visitNum = wait
    visitNum(2)
    if (doorName == "CliffDoor") then
      visitNum = ClearCameraAttributesForPlayer
      visitNum(("TCO_" .. doorName))
    end
  elseif (bool == "Save") then
    wait(1)
    ClearOverrideSpawnTransform(PLAYER_ONE)
    ClearOverrideSpawnTransform(PLAYER_TWO)
    FTL_SaveCheckpoint(mech_Name)
  end
  return 
end
FTL_Fort_UnlockAchievement = function()
  if (HasCollectible("Challenge_Fortified_Tracker") == false) then
    wait(1.5)
    GiveCollectible("Challenge_Fortified_Tracker")
  end
  return 
end

