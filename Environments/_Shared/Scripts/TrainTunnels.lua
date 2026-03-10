visitnum = 1
TRT_SetupTrainTunnels = function(target)
  if (target == nil) then
    Print("Target was nil, setting dummy target")
    target = "none"
  end
  if (2 < GetGlobal("EM2_EpisodeCheck")) then
    SetGlobal("TRT_VisitNumber", 2)
  else
    SetGlobal("TRT_VisitNumber", 1)
  end
  TRT_VisitSpecificSetup(target)
  return 
end
TRT_EndLevelSetup = function(target)
  Print("End Train Tunnels Setup")
  UnpauseAllAI()
  wait(3)
  if (target == "none") then
    Print("No target! Ending without checkpoint")
  else
    local data = GetPrefabData(target)
    if (data.Interior_Stream == "NOS_BlotAlley_Main.Film_TrainTunnels") then
      Print("TRT: Came out of Clock projector!")
      SaveCheckpoint(GetPlayer(), "TRT_SetupTrainTunnels", "TRT_ProjectorCheckpointReload", "TRT_ProjectorCheckpointReload_O")
    elseif (data.Interior_Stream == "TRT_TrainTunnels.Musicland2D") then
      Print("TRT: Came out of Blot projector!")
      SaveCheckpoint(GetPlayer(), "TRT_SetupTrainTunnels", "TRT_ProjectorCheckpointReload", "TRT_ProjectorCheckpointReload_O")
    end
  end
  return 
end
TRT_Checkpoint = function(target, area)
  wait(0.3499999940395355)
  if (area == "clock") then
    SaveCheckpoint(GetPlayer(), "TRT_SetupTrainTunnels", "TRT_ProjectorCheckpointReload", "TRT_ProjectorCheckpointReload_O")
  elseif (area == "doc") then
    SaveCheckpoint(GetPlayer(), "TRT_SetupTrainTunnels", "ToDocOswaldArrival", "ToDocOswaldArrival_O")
  elseif (area == "blot") then
    SaveCheckpoint(GetPlayer(), "TRT_SetupTrainTunnels", "TRT_PitTeleport", "TRT_PitTeleport_O")
  end
  return 
end
TRT_ClockCheckpoint = function()
  TRT_Checkpoint(nil, "clock")
  return 
end
TRT_ConceptCheckpoint = function()
  SaveCheckpoint(GetPlayer(), "TRT_SetupTrainTunnels", "TRT_PitTeleport", "TRT_PitTeleport_O")
  return 
end
TRT_SetInitialQuestStage = function()
  if (GetGlobal("TRT_QuestStateSet") == 0) then
    Quest_SetCriticalPath("Critical_TT", "Critical_TT_1")
  end
  return 
end
TRT_BlueChestCheckpoint = function()
  TRT_Checkpoint(nil, "doc")
  return 
end
TRT_OnMapLoadOrStream = function(target, diorama)
  if (diorama == "blot") then
    if (GetGlobal("TRT_V1Complete") == 1) then
      FireThread(TRT_AutomateBlot)
      FireThread(TRT_BlotCompleteFailsafe)
    end
  end
  return 
end
TRT_HideAbe = function()
  if (GetGlobal("TRT_OpeningIGCVar") == 0) then
    if (GetGlobal("EM2_EpisodeCheck") < 3) then
      AnimEvent("TRT_AbeClock", EVENT_Special_2)
    end
  end
  return 
end
TRT_ExitClockProjector = function()
end
TRT_ExitBlotProjector = function()
  TRT_SetupTrainTunnels()
  return 
end
TRT_SetupProjector = function()
end
TRT_StreamPerVisit = function(target)
  Print("***TRT_StreamPerVisit")
  if (GetGlobal("EM2_EpisodeCheck") < 3) then
    LevelManager_SetCurrentState("TRT_TrainTunnels.ClockV1")
  else
    LevelManager_SetCurrentState("TRT_TrainTunnels.ClockV2")
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
TRT_TubeDoorsPersist = function(target, state)
  if (state == "clock") then
    if (0 < GetGlobal("TRT_ClockEndPlayed")) then
      Print("Open Clock tube doors")
      AnimGBSequence("TRT_ClockTransport", "Open")
      SetPropertyFloat("ClockElevatorButton", "UsableRadius", 2)
    end
  end
  if (state == "doc") then
    if (GetGlobal("TRT_ShockerDefeated") == 1) then
      Print("Open Doc tube doors")
      AnimGBSequence("TRT_DocTransport", "Open")
      SetPropertyFloat("DocElevatorButton", "UsableRadius", 2)
    end
  end
  return 
end
TRT_DisableUsable = function(target, diorama)
  if (diorama == "clock") then
    if (GetGlobal("TRT_ClockEndPlayed") == 0) then
      SetPropertyFloat(target, "UsableRadius", 0)
    end
  elseif (diorama == "doc") then
    if (GetGlobal("TRT_BlotworxResolved") == 0) then
      SetPropertyFloat(target, "UsableRadius", 0)
    end
  end
  return 
end
TRT_OswaldActionEnable = function(target, state)
  if (state == "on") then
    SetPropertyBool(target, "ActionSpotEnabled", true)
  else
    SetPropertyBool(target, "ActionSpotEnabled", false)
  end
  return 
end
TRT_StreamZone = function(target, zone)
  if (zone == "DocClock") then
    if (GetGlobal("EM2_EpisodeCheck") < 3) then
      LevelManager_SetCurrentState("TRT_TrainTunnels.ClockV1")
    else
      LevelManager_SetCurrentState("TRT_TrainTunnels.ClockV2")
    end
  end
  if (zone == "DocBlot") then
    SetGlobal("TRT_InBlotDiorama", 1)
    if (GetGlobal("EM2_EpisodeCheck") < 3) then
      LevelManager_SetCurrentState("TRT_TrainTunnels.BlotV1")
    else
      LevelManager_SetCurrentState("TRT_TrainTunnels.BlotV2")
    end
  end
  return 
end
TRT_StreamOptionalZones = function(target, direction)
  if (direction == "blot") then
    LevelManager_SetZoneStatusUnloaded("TRT_TrainTunnels.ClockStream")
    wait(0.5)
    LevelManager_SetZoneStatusActive("TRT_TrainTunnels.BlotStream")
  else
    LevelManager_SetZoneStatusUnloaded("TRT_TrainTunnels.BlotStream")
    wait(0.5)
    LevelManager_SetZoneStatusActive("TRT_TrainTunnels.ClockStream")
  end
  return 
end
TRT_StreamBunnySuction = function()
  if (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
    if (GetGlobal("TRT_ExitedZone") == 1) then
      LevelManager_SetZoneStatusActive("TRT_TrainTunnels.MadDoc_Bunnies")
    end
  else
    LevelManager_SetZoneStatusActive("TRT_TrainTunnels.MadDoc_BunniesDummy")
  end
  wait(0.009999999776482582)
  WaitForLevelLoad()
  return 
end
transitioning = 0
TRT_TransitionToNextDiorama = function(target, room, direction)
  Print(((("TRT_TransitionToNextDiorama: room = " .. room) .. " & direction = ") .. direction))
  if (transitioning == 0) then
    transitioning = 1
    RestrictCutSceneInput()
    PauseAllAI()
    OswaldStopFollowAction()
    StartFadeOut(0.4000000059604645)
    wait(0.4000000059604645)
    ForEachEntityInGroup(DisableComponent, "ElevatorButtons", "Usable")
    ForEachEntityInGroup(SetPropertyInt, "ElevatorCollision", "Collision Layer", 13)
    if (direction == "forward") then
      if (room == "todoc") then
        leavingclock = 1
        TimerDisable("TRT_TubeHintTimer")
        Disable("ClockHackHintMarker")
        EnableSplitScreen(false)
        GrabCamera("TRT_ToDocTubeCam", nil, CAMERA_INSTANT_TRANSITION, 0)
        TeleportToEntity(GetPlayer(), "ClockElevatorLeftTeleport")
        TeleportToEntity(GetPlayer2OrAI(), "ClockElevatorRightTeleport")
        StartFadeIn(0.4000000059604645)
        if (GetGlobal("EM2_EpisodeCheck") < 3) then
          LevelManager_SetCurrentState("TRT_TrainTunnels.DocV1")
        else
          LevelManager_SetCurrentState("TRT_TrainTunnels.DocV2")
        end
        if (GetGlobal("TRT_ClockTerminalHintPlayed") == 0) then
          DestroyEntity("TRT_Hint_ClockTube")
          Quest_SetCriticalPath("Critical_TT", "Critical_TT_4")
          GrabCamera("TRT_ToDocIGCCam", nil, CAMERA_INSTANT_TRANSITION, 0)
          if (GetGlobal("TRT_DioramaDestroyedClock") == 0) then
            AnimGBSequence("TRT_ClockTerminal", "docSecret")
          else
            AnimGBSequence("TRT_ClockTerminal", "graveyardOne")
          end
          TRT_ClockTerminalHint(target)
          GrabCamera("TRT_ToDocTubeCam", nil, CAMERA_INSTANT_TRANSITION, 0)
        end
        wait(2)
        AnimGBSequence("TRT_ClockTransport", "Close")
        wait(1.2000000476837158)
        StartFadeOut(0.4000000059604645)
        AudioPostEventOn("trt_dioramas_01a_audio.Sound_Marker_Music_Clock", "Stop_MX_TRT_Clock")
        Print("Stopped Clock music event")
        wait(0.4000000059604645)
        WaitForLevelLoad()
        TRT_StreamBunnySuction()
        wait(0)
        ForEachEntityInGroup(EnableComponent, "ElevatorButtons", "Usable")
        AnimGBSequence("TRT_ClockTransport", "Open")
        AnimGBSequence("ToClockTransport", "Open")
        SetPropertyFloat("ClockElevatorButton", "UsableRadius", 2)
        TeleportToEntity(GetPlayer(), "ToDocMickeyArrival")
        TeleportToEntity(GetPlayer2OrAI(), "ToDocOswaldArrival")
        TRT_SetAbeState(nil, "doc")
        if (GetGlobal("TRT_VisitNumber") == 2) then
          if (GetGlobal("TRT_AbeDestroyed") == 0) then
            FireUser2("TRT_ClockNarration")
            FireUser1("TRT_DocNarration")
          end
        end
        FireThread(TRT_Checkpoint, nil, "doc")
        MusicPostEventOn("trt_dioramas_01a_audio.Sound_Marker_Music_Attic", "Play_MX_TRT_Attic")
        Print("Started Attic music event")
        TRT_DocStageProgressMusic3D()
      elseif (room == "toblot") then
        EnableSplitScreen(false)
        Disable("DocHackThoughtNode")
        GrabCamera("ClockDocTubeCam", nil, CAMERA_INSTANT_TRANSITION, 0)
        TeleportToEntity(GetPlayer(), "DocElevatorLeftTeleport")
        TeleportToEntity(GetPlayer2OrAI(), "DocElevatorRightTeleport")
        StartFadeIn(0.4000000059604645)
        if (GetGlobal("EM2_EpisodeCheck") < 3) then
          LevelManager_SetCurrentState("TRT_TrainTunnels.BlotV1")
        else
          LevelManager_SetCurrentState("TRT_TrainTunnels.BlotV2")
        end
        if (GetGlobal("TRT_DocTerminalHintPlayed") == 0) then
          DestroyEntity("TRT_Hint_DocTube")
          Quest_SetCriticalPath("Critical_TT", "Critical_TT_6")
          GrabCamera("TRT_ToBlotIGCCam", nil, CAMERA_INSTANT_TRANSITION, 0)
          if (GetGlobal("TRT_DioramaDestroyedDoc") == 0) then
            AnimGBSequence("TT_BiotDioramaTerminal2", "graveyardTwo")
          else
            AnimGBSequence("TT_BiotDioramaTerminal2", "tunnelSecret")
          end
          TRT_DocTerminalHint(target)
          GrabCamera("ClockDocTubeCam", nil, CAMERA_INSTANT_TRANSITION, 0)
        end
        wait(2)
        AnimGBSequence("TRT_DocTransport", "Close")
        wait(1.2000000476837158)
        StartFadeOut(0.4000000059604645)
        AudioPostEventOn("trt_dioramas_01a_audio.Sound_Marker_Music_Attic", "Stop_MX_TRT_Attic")
        Print("Stopped Attic music event")
        wait(0.4000000059604645)
        WaitForLevelLoad()
        wait(0)
        TeleportToEntity(GetPlayer(), "trt_dioramas_01a_scripting.ToBlotMickeyTeleport")
        TeleportToEntity(GetPlayer2OrAI(), "trt_dioramas_01a_scripting.ToBlotOswaldTeleport")
        AnimGBSequence("TRT_DocTransport", "Open")
        AnimGBSequence("ToDocFromBlotElevator", "Open")
        ForEachEntityInGroup(EnableComponent, "ElevatorButtons", "Usable")
        if (GetGlobal("TRT_SetBlotAbe") == 0) then
          SetGlobal("TRT_SetBlotAbe", 1)
          TRT_SetAbeState(nil, "blot")
        end
        if (GetGlobal("TRT_VisitNumber") == 2) then
          if (GetGlobal("TRT_AbeDestroyed") == 0) then
            FireUser2("TRT_DocNarration")
            FireUser1("TRT_BlotNarration")
          end
        end
        FireThread(TRT_Checkpoint, nil, "blot")
        MusicPostEventOn("trt_dioramas_01a_audio.Sound_Marker_Music_Blot", "Play_MX_TRT_Blot")
        Print("Started Blot music event")
        TRT_BlotFixedOrDestroyedMusic3D()
        if (room == "todoc") then
          if (GetGlobal("EM2_EpisodeCheck") < 3) then
            LevelManager_SetCurrentState("TRT_TrainTunnels.DocV1")
            Enable("DocHackThoughtNode")
          else
            LevelManager_SetCurrentState("TRT_TrainTunnels.DocV2")
          end
          EnableSplitScreen(false)
          GrabCamera("ToDocFromBlotElevatorCamera", nil, CAMERA_INSTANT_TRANSITION, 0)
          TeleportToEntity(GetPlayer(), "BlotElevatorMarker1")
          TeleportToEntity(GetPlayer2OrAI(), "BlotElevatorMarker2")
          StartFadeIn(0.4000000059604645)
          wait(2)
          AnimGBSequence("ToDocFromBlotElevator", "Close")
          wait(1.2000000476837158)
          StartFadeOut(0.4000000059604645)
          AudioPostEventOn("trt_dioramas_01a_audio.Sound_Marker_Music_Blot", "Stop_MX_TRT_Blot")
          Print("Stopped Blot music event")
          wait(0.4000000059604645)
          WaitForLevelLoad()
          TRT_StreamBunnySuction()
          wait(0)
          ForEachEntityInGroup(EnableComponent, "ElevatorButtons", "Usable")
          AnimGBSequence("ToDocFromBlotElevator", "Open")
          AnimGBSequence("TRT_DocTransport", "Open")
          TeleportToEntity(GetPlayer(), "FromBlotToDocMarker1")
          TeleportToEntity(GetPlayer2OrAI(), "FromBlotToDocMarker2")
          SetPropertyFloat("DocElevatorButton", "UsableRadius", 2)
          if (GetGlobal("TRT_VisitNumber") == 2) then
            if (GetGlobal("TRT_AbeDestroyed") == 0) then
              FireUser2("TRT_BlotNarration")
              FireUser1("TRT_DocNarration")
            end
          end
          FireThread(TRT_Checkpoint, nil, "doc")
          MusicPostEventOn("trt_dioramas_01a_audio.Sound_Marker_Music_Attic", "Play_MX_TRT_Attic")
          Print("Started Attic music event")
          TRT_DocStageProgressMusic()
        elseif (room == "toclock") then
          leavingclock = 0
          if (GetGlobal("EM2_EpisodeCheck") < 3) then
            LevelManager_SetCurrentState("TRT_TrainTunnels.ClockV1")
            Enable("ClockHackHintMarker")
          else
            LevelManager_SetCurrentState("TRT_TrainTunnels.ClockV2")
          end
          EnableSplitScreen(false)
          GrabCamera("ToClockElevatorCam", nil, CAMERA_INSTANT_TRANSITION, 0)
          TeleportToEntity(GetPlayer(), "ToClockElevatorMarker1")
          TeleportToEntity(GetPlayer2OrAI(), "ToClockElevatorMarker2")
          StartFadeIn(0.4000000059604645)
          AudioPostEventOn("trt_dioramas_01a_audio.Sound_Marker_Music_Attic", "Stop_MX_TRT_Attic")
          Print("Stopped Attic music event")
          wait(2)
          AnimGBSequence("ToClockTransport", "Close")
          wait(1.2000000476837158)
          StartFadeOut(0.4000000059604645)
          wait(0.4000000059604645)
          WaitForLevelLoad()
          wait(0)
          ForEachEntityInGroup(EnableComponent, "ElevatorButtons", "Usable")
          TeleportToEntity(GetPlayer(), "ToClockMickeyArrival")
          TeleportToEntity(GetPlayer2OrAI(), "ToClockOswaldArrival")
          AnimGBSequence("TRT_ClockTransport", "Open")
          AnimGBSequence("ToClockTransport", "Open")
          SetPropertyFloat("ClockElevatorButton", "UsableRadius", 2)
          if (GetGlobal("TRT_VisitNumber") == 2) then
            if (GetGlobal("TRT_AbeDestroyed") == 0) then
              FireUser2("TRT_DocNarration")
              FireUser1("TRT_ClockNarration")
            end
          end
          FireThread(TRT_Checkpoint, nil, "clock")
          MusicPostEventOn("trt_dioramas_01a_audio.Sound_Marker_Music_Clock", "Play_MX_TRT_Clock")
          Print("Started Clock music event")
          TRT_ClockStatusCheckMusic()
        end
      end
    elseif (room == "todoc") then
      if (GetGlobal("EM2_EpisodeCheck") < 3) then
        LevelManager_SetCurrentState("TRT_TrainTunnels.DocV1")
        Enable("DocHackThoughtNode")
      else
        LevelManager_SetCurrentState("TRT_TrainTunnels.DocV2")
      end
      EnableSplitScreen(false)
      GrabCamera("ToDocFromBlotElevatorCamera", nil, CAMERA_INSTANT_TRANSITION, 0)
      TeleportToEntity(GetPlayer(), "BlotElevatorMarker1")
      TeleportToEntity(GetPlayer2OrAI(), "BlotElevatorMarker2")
      StartFadeIn(0.4000000059604645)
      wait(2)
      AnimGBSequence("ToDocFromBlotElevator", "Close")
      wait(1.2000000476837158)
      StartFadeOut(0.4000000059604645)
      AudioPostEventOn("trt_dioramas_01a_audio.Sound_Marker_Music_Blot", "Stop_MX_TRT_Blot")
      Print("Stopped Blot music event")
      wait(0.4000000059604645)
      WaitForLevelLoad()
      TRT_StreamBunnySuction()
      wait(0)
      ForEachEntityInGroup(EnableComponent, "ElevatorButtons", "Usable")
      AnimGBSequence("ToDocFromBlotElevator", "Open")
      AnimGBSequence("TRT_DocTransport", "Open")
      TeleportToEntity(GetPlayer(), "FromBlotToDocMarker1")
      TeleportToEntity(GetPlayer2OrAI(), "FromBlotToDocMarker2")
      SetPropertyFloat("DocElevatorButton", "UsableRadius", 2)
      if (GetGlobal("TRT_VisitNumber") == 2) then
        if (GetGlobal("TRT_AbeDestroyed") == 0) then
          FireUser2("TRT_BlotNarration")
          FireUser1("TRT_DocNarration")
        end
      end
      FireThread(TRT_Checkpoint, nil, "doc")
      MusicPostEventOn("trt_dioramas_01a_audio.Sound_Marker_Music_Attic", "Play_MX_TRT_Attic")
      Print("Started Attic music event")
      TRT_DocStageProgressMusic()
    elseif (room == "toclock") then
      leavingclock = 0
      if (GetGlobal("EM2_EpisodeCheck") < 3) then
        LevelManager_SetCurrentState("TRT_TrainTunnels.ClockV1")
        Enable("ClockHackHintMarker")
      else
        LevelManager_SetCurrentState("TRT_TrainTunnels.ClockV2")
      end
      EnableSplitScreen(false)
      GrabCamera("ToClockElevatorCam", nil, CAMERA_INSTANT_TRANSITION, 0)
      TeleportToEntity(GetPlayer(), "ToClockElevatorMarker1")
      TeleportToEntity(GetPlayer2OrAI(), "ToClockElevatorMarker2")
      StartFadeIn(0.4000000059604645)
      AudioPostEventOn("trt_dioramas_01a_audio.Sound_Marker_Music_Attic", "Stop_MX_TRT_Attic")
      Print("Stopped Attic music event")
      wait(2)
      AnimGBSequence("ToClockTransport", "Close")
      wait(1.2000000476837158)
      StartFadeOut(0.4000000059604645)
      wait(0.4000000059604645)
      WaitForLevelLoad()
      wait(0)
      ForEachEntityInGroup(EnableComponent, "ElevatorButtons", "Usable")
      TeleportToEntity(GetPlayer(), "ToClockMickeyArrival")
      TeleportToEntity(GetPlayer2OrAI(), "ToClockOswaldArrival")
      AnimGBSequence("TRT_ClockTransport", "Open")
      AnimGBSequence("ToClockTransport", "Open")
      SetPropertyFloat("ClockElevatorButton", "UsableRadius", 2)
      if (GetGlobal("TRT_VisitNumber") == 2) then
        if (GetGlobal("TRT_AbeDestroyed") == 0) then
          FireUser2("TRT_DocNarration")
          FireUser1("TRT_ClockNarration")
        end
      end
      FireThread(TRT_Checkpoint, nil, "clock")
      MusicPostEventOn("trt_dioramas_01a_audio.Sound_Marker_Music_Clock", "Play_MX_TRT_Clock")
      Print("Started Clock music event")
      TRT_ClockStatusCheckMusic()
    end
    wait(0.20000000298023224)
    EnableSplitScreen(true)
    ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
    ClearAllCameraAttributes()
    CameraReset()
    wait(0.20000000298023224)
    ForEachEntityInGroup(SetPropertyInt, "ElevatorCollision", "Collision Layer", 1)
    StartFadeIn(0.4000000059604645)
    UnrestrictCutSceneInput()
    OswaldStartFollowAction()
    UnpauseAllAI()
    transitioning = 0
  end
  return 
end
TRT_SetAbeState = function(target, state)
  wait(1)
  if (state == "doc") then
    if (GetGlobal("TRT_DioramaDestroyedClock") ~= 0) then
      AnimEvent("TRT_AbeDoc", EVENT_Special_1)
      if (GetGlobal("TRT_DioramaDestroyedDoc") ~= 0) then
        AnimEvent("TRT_AbeBlot", EVENT_Special_1)
      end
    end
  elseif (GetGlobal("TRT_DioramaDestroyedDoc") ~= 0) then
    AnimEvent("TRT_AbeBlot", EVENT_Special_1)
  end
  return 
end
TRT_SetV2Abe = function(target)
  wait(1)
  if (2 < GetGlobal("EM2_EpisodeCheck")) then
    if (1 < GetGlobal("TRT_DestroyedDioramas")) then
      AnimEvent(target, EVENT_Special_1)
    end
  end
  return 
end
TRT_TerminalHacked = function(target, terminal)
  Print("terminal hacked")
  if (target == "clock") then
    SetGlobal("TRT_ClockSecurity", 1)
    DestroyEntity("ClockHackHintMarker")
    ForceSequence("TRT_NarratorMarker", "TRT_Narrator_ClockConsoleHacked")
    AnimGBSequence("TRT_ClockHopperCage", "Open")
    AnimGBSequence("TRT_ClockHopperCage2", "Open", true)
    Unhide("TRT_ClockCageLight1")
    Unhide("TRT_ClockCageLight2")
    StartEmitters("TRT_ClockCageLight1")
    StartEmitters("TRT_ClockCageLight2")
    wait(0.20000000298023224)
    if (GetGlobal("EM2_EpisodeCheck") < 3) then
      ForEachEntityInGroup(AI_SetDisabled, "TRT_ClockHopper", false)
      ForEachEntityInGroup(SetTargetTeam, "TRT_ClockHopper", 2)
    else
      ForEachEntityInGroup(AI_SetDisabled, "TRT_ClockV2Spinner", false)
      ForEachEntityInGroup(SetTargetTeam, "TRT_ClockV2Spinner", 2)
    end
    TimerReset("TRT_ClockHintTimer")
  elseif (target == "doc") then
    SetGlobal("TRT_DocSecurity", 1)
    DestroyEntity("DocHackThoughtNode")
    ForceSequence("TRT_NarratorMarker", "TRT_Narrator_DocConsoleHacked")
    AnimGBSequence("TRT_DocSpinnerCage2", "Open", true)
    AnimGBSequence("TRT_DocSpinnerCage1", "Open")
    Unhide("TRT_DocCageLight1")
    Unhide("TRT_DocCageLight2")
    StartEmitters("TRT_DocCageLight2")
    StartEmitters("TRT_DocCageLight1")
    wait(0.5)
    if (GetGlobal("EM2_EpisodeCheck") < 3) then
      AI_SetDisabled("TRT_CagedSpinner", false)
      ForEachEntityInGroup(SetTargetTeam, "TRT_CagedSpinner", 2)
    else
      AI_SetDisabled("TRT_DocBasherV2", false)
      ForEachEntityInGroup(SetTargetTeam, "TRT_DocBasherV2", 2)
    end
    ForEachEntityInGroup(SetTargetTeam, "TRT_CagedSpinner", 2)
    TimerReset("TRT_DocHintTimer")
  elseif (target == "blot") then
    SetGlobal("TRT_BlotSecurity", 1)
    DestroyEntity("BlotHackThoughtNode")
    AnimGBSequence("TRT_BlotCage1", "Open")
    Unhide("TRT_BlotCageLight1")
    Unhide("TRT_BlotCageLight2")
    StartEmitters("TRT_BlotCageLight1")
    AudioPostEventOn("TRT_BlotCageLight1", "Play_sfx_trt_hopper_siren")
    AnimGBSequence("TRT_BlotCage2", "Open", true)
    StartEmitters("TRT_BlotCageLight2")
    AudioPostEventOn("TRT_BlotCageLight2", "Play_sfx_trt_hopper_siren")
    ForceSequence("TRT_NarratorMarker", "TRT_Narrator_BlotConsoleHacked")
    TimerReset("TRT_BlotHintTimer")
    if (GetGlobal("EM2_EpisodeCheck") < 3) then
      ForEachEntityInGroup(AI_SetDisabled, "BlotCagedSpatter", false)
      ForEachEntityInGroup(SetTargetTeam, "BlotCagedSpatter", 2)
    else
      ForEachEntityInGroup(AI_SetDisabled, "TRT_BlotCagedSpinner", false)
      ForEachEntityInGroup(SetTargetTeam, "TRT_BlotCagedSpinner", 2)
    end
  end
  DestroyEntity(target)
  return 
end
TRT_CheckBlotScreenChange = function()
  if (GetGlobal("TRT_Narrator_BlotConsoleHacked_Played") == 1) then
    AnimGBSequence("TT_BiotDioramaTerminal2", "stormBlot")
    AnimGBSequence("TRT_BlotIntroTerminal", "stormBlot")
  end
  return 
end
TRT_OswaldShockPlatformSwitch = function(target, state)
  if (state == "wires") then
    OswaldStreamAction("TRT_WireShockTarget")
  elseif (state == "bunnybox") then
    OswaldStreamAction("trt_dioramas_01a_visit2.bunnysuction 01.switch_oswaldelectric 01.OswaldSwitchSign")
  else
    OswaldStreamAction("trt_dioramas_01a_clock.OswaldPlatformSwitchShockMarker")
  end
  wait(3)
  OswaldStreamAbort()
  return 
end
TRT_SetGusMood = function(target)
  DisableComponent("TRT_Gus", "Usable")
  AnimVarInt("TRT_Gus", VAR_Mood_Type, 1)
  return 
end
railCartFlyby = 0
TRT_RailCartFlyby = function(target)
  if (railCartFlyby == 0) then
    railCartFlyby = 1
    AnimGBSequence("TRT_HandCart", "Roll")
  end
  return 
end
TRT_SetHallwayTerminal = function(target, terminal)
  if (terminal == "doc") then
    if (GetGlobal("TRT_DioramaDestroyedClock") == 0) then
      AnimGBSequence("TRT_DocIntroTerminal", "docSecret")
    else
      AnimGBSequence("TRT_DocIntroTerminal", "graveyardOne")
      if (GetGlobal("TRT_DioramaDestroyedDoc") == 0) then
        AnimGBSequence("TRT_BlotIntroTerminal", "blotSecret")
      else
        AnimGBSequence("TRT_BlotIntroTerminal", "graveyardTwo")
      end
    end
  elseif (GetGlobal("TRT_DioramaDestroyedDoc") == 0) then
    AnimGBSequence("TRT_BlotIntroTerminal", "blotSecret")
  else
    AnimGBSequence("TRT_BlotIntroTerminal", "graveyardTwo")
  end
  return 
end
TRT_V2ClockAICheck = function()
  if (GetGlobal("TRT_ClockSecurity") == 1) then
    AI_SetDisabled("TRT_ClockV2Spinner", false)
    ForEachEntityInGroup(SetTargetTeam, "TRT_ClockV2Spinner", 2)
    AudioPostEventOn("trt_dioramas_01a_clock_fx.TRT_cageLightRaysSpin_01a 01", "Play_sfx_trt_hopper_siren")
  end
  return 
end
TRT_TrackClockToon = function(target, state)
  if (state == "paint") then
    SetGlobal("TRT_GuardianPoolToonTracker", (GetGlobal("TRT_GuardianPoolToonTracker") + 1))
  else
    SetGlobal("TRT_GuardianPoolToonTracker", (GetGlobal("TRT_GuardianPoolToonTracker") - 1))
  end
  TRT_SetClockGuardianPool()
  return 
end
TRT_SetClockGuardianPool = function()
  if (GetGlobal("TRT_GuardianPoolRestored") == 1) then
    if (GetGlobal("TRT_ClockRightArmHacked") == 1) then
      if (GetGlobal("TRT_ClockLeftArmHacked") == 1) then
        SetGlobal("TRT_GuardianPool", 0)
      end
    else
      SetGlobal("TRT_GuardianPool", GetGlobal("TRT_GuardianPoolToonTracker"))
    end
    TRT_ClearPoolGuardians()
  end
  return 
end
TRT_ClearPoolGuardians = function(state)
  local data = GetPrefabData("TRT_ClockPool")
  if (state == "paint") then
    SetGlobal("TRT_GuardianPool", 15)
    ForEachEntityInGroup(DestroyEntity, "TRT_Guardians")
    data.PoolGuardians = 0
  end
  Prefab_ChangeGuardianPoolState("TRT_ClockPool")
  return 
end
TRT_SetupGuardianPool = function(target)
  if (GetGlobal("TRT_ClockRestore") < 2) then
    SetGlobal("TRT_GuardianPool", 0)
    TRT_ClearPoolGuardians()
  end
  SetGlobal("TRT_GuardianPool", 2)
  TRT_ClearPoolGuardians("paint")
  return 
end
TRT_SetClockJumpPath = function(target, state)
  if (state == "on") then
    resumeJumpVolumeWait(target)
  elseif (GetGlobal("TRT_FreeClockGremlin") == 0) then
    pauseJumpVolumeWait(target)
  end
  return 
end
TRT_PersistPlatformStop = function()
end
TRT_ResolveClockPhoto = function()
  Print("SET CLOCK PHOTO VARIABLE")
  if (GetGlobal("TRT_DioramaDestroyedClock") == 0) then
    SetGlobal("MSN_Adelle_TrainTunClocktowerVar", 2)
  else
    SetGlobal("MSN_Adelle_TrainTunClocktowerVar", 1)
  end
  return 
end
TRT_OpeningBark = function()
  if (GetGlobal("TRT_Gus_TunnelsBark_Played") == 0) then
    wait(3)
    FireSequence("TRT_GusMarker", "TRT_Gus_TunnelsBark")
  end
  return 
end
TRT_V2ClockNarrations = function(target)
  if (GetGlobal("TRT_VisitNumber") == 2) then
    if (GetGlobal("TRT_AbeDestroyed") == 0) then
      FireUser1("TRT_ClockNarration")
    end
  end
  return 
end
TRT_AnimatedIGC = function()
  TRT_OpeningIGC()
  return 
end
PostIGC_0240_TrainTunnelsIntro = function()
  Quest_SetCriticalPath("Critical_TT", "Critical_TT_2")
  AnimGBSequence("TRT_AbeClock", "BrokenRest")
  ForEachEntityInGroup(AI_SetDisabled, "TRT_ClockFodderRoaming", false)
  ForEachEntityInGroup(SetTargetTeam, "TRT_ClockFodderRoaming", 2)
  AnimGBSequence("TRT_ClockRoomDoor", "Open")
  ShowHud()
  SaveCheckpoint(GetPlayer(), "TRT_SetupTrainTunnels", "TRT_ProjectorCheckpointReload", "TRT_ProjectorCheckpointReload_O")
  FireThread(TRT_DestroyGus)
  return 
end
PostIGC_0245a_AbeRestored = function()
  SaveCheckpoint(GetPlayer(), "TRT_SetupTrainTunnels", "TRT_PitTeleport", "TRT_PitTeleport_O")
  return 
end
PostIGC_0245b_AbeDestroyed = function()
  SetGlobal("TRT_AbeDestroyed", 1)
  AnimEvent("TRT_AbeBlotOutside", EVENT_Special_1)
  wait(0)
  SaveCheckpoint(GetPlayer(), "TRT_SetupTrainTunnels", "TRT_PitTeleport", "TRT_PitTeleport_O")
  return 
end
TRT_OpeningIGC = function()
  if (GetGlobal("TRT_OpeningIGCVar") == 0) then
    SetGlobal("TRT_OpeningIGCVar", 1)
    ForceInterruptSequence("TRT_ToAlleyProjector", "TRT_Projector_ToBlotAlley")
    ForceInterruptSequence("TRT_ToAlleyProjector", "Global_Gus_BacktoCinema")
    PlayIGC("IGC_0240_TrainTunnelsIntro")
  end
  return 
end
TRT_OpeningIGCTerminal = function()
  AnimGBSequence("ClockOutsideTerminal", "clock")
  return 
end
TRT_SetAIEnabled = function(target, diorama)
  if (diorama == "clock") then
    if (GetGlobal("EM2_EpisodeCheck") < 3) then
      if (GetGlobal("TRT_OpeningIGCVar") == 1) then
        ForEachEntityInGroup(AI_SetDisabled, "TRT_ClockFodderRoaming", false)
        ForEachEntityInGroup(SetTargetTeam, "TRT_ClockFodderRoaming", 2)
      end
      if (GetGlobal("TRT_ClockSecurity") == 1) then
        ForEachEntityInGroup(AI_SetDisabled, "TRT_ClockHopper", false)
        ForEachEntityInGroup(AI_SetDisabled, "TRT_ClockHopper", false)
        ForEachEntityInGroup(SetTargetTeam, "TRT_ClockHopper", 2)
      end
    elseif (GetGlobal("TRT_ClockSecurity") == 1) then
      ForEachEntityInGroup(AI_SetDisabled, "TRT_ClockV2Spinner", false)
      ForEachEntityInGroup(SetTargetTeam, "TRT_ClockV2Spinner", 2)
      if (diorama == "doc") then
        if (GetGlobal("EM2_EpisodeCheck") < 3) then
          if (GetGlobal("TRT_DocSecurity") == 1) then
            ForEachEntityInGroup(AI_SetDisabled, "TRT_CagedSpinner", false)
            ForEachEntityInGroup(SetTargetTeam, "TRT_CagedSpinner", 2)
          end
        elseif (GetGlobal("TRT_DocSecurity") == 1) then
          ForEachEntityInGroup(AI_SetDisabled, "TRT_DocBasherV2", false)
          ForEachEntityInGroup(SetTargetTeam, "TRT_DocBasherV2", 2)
          if (diorama == "blot") then
            if (GetGlobal("TRT_BlotSecurity") == 1) then
              AnimGBSequence("TRT_BlotCage2", "Open", true)
              AnimGBSequence("TRT_BlotCage1", "Open", true)
              Unhide("TRT_BlotCageLight1")
              Unhide("TRT_BlotCageLight2")
              StartEmitters("TRT_BlotCageLight1")
              StartEmitters("TRT_BlotCageLight1")
              if (GetGlobal("EM2_EpisodeCheck") < 3) then
                ForEachEntityInGroup(AI_SetDisabled, "BlotCagedSpatter", false)
                ForEachEntityInGroup(SetTargetTeam, "BlotCagedSpatter", 2)
              else
                ForEachEntityInGroup(AI_SetDisabled, "TRT_BlotCagedSpinner", false)
                ForEachEntityInGroup(SetTargetTeam, "TRT_BlotCagedSpinner", 2)
              end
            end
          end
        end
      elseif (diorama == "blot") then
        if (GetGlobal("TRT_BlotSecurity") == 1) then
          AnimGBSequence("TRT_BlotCage2", "Open", true)
          AnimGBSequence("TRT_BlotCage1", "Open", true)
          Unhide("TRT_BlotCageLight1")
          Unhide("TRT_BlotCageLight2")
          StartEmitters("TRT_BlotCageLight1")
          StartEmitters("TRT_BlotCageLight1")
          if (GetGlobal("EM2_EpisodeCheck") < 3) then
            ForEachEntityInGroup(AI_SetDisabled, "BlotCagedSpatter", false)
            ForEachEntityInGroup(SetTargetTeam, "BlotCagedSpatter", 2)
          else
            ForEachEntityInGroup(AI_SetDisabled, "TRT_BlotCagedSpinner", false)
            ForEachEntityInGroup(SetTargetTeam, "TRT_BlotCagedSpinner", 2)
          end
        end
      end
    end
  elseif (diorama == "doc") then
    if (GetGlobal("EM2_EpisodeCheck") < 3) then
      if (GetGlobal("TRT_DocSecurity") == 1) then
        ForEachEntityInGroup(AI_SetDisabled, "TRT_CagedSpinner", false)
        ForEachEntityInGroup(SetTargetTeam, "TRT_CagedSpinner", 2)
      end
    elseif (GetGlobal("TRT_DocSecurity") == 1) then
      ForEachEntityInGroup(AI_SetDisabled, "TRT_DocBasherV2", false)
      ForEachEntityInGroup(SetTargetTeam, "TRT_DocBasherV2", 2)
      if (diorama == "blot") then
        if (GetGlobal("TRT_BlotSecurity") == 1) then
          AnimGBSequence("TRT_BlotCage2", "Open", true)
          AnimGBSequence("TRT_BlotCage1", "Open", true)
          Unhide("TRT_BlotCageLight1")
          Unhide("TRT_BlotCageLight2")
          StartEmitters("TRT_BlotCageLight1")
          StartEmitters("TRT_BlotCageLight1")
          if (GetGlobal("EM2_EpisodeCheck") < 3) then
            ForEachEntityInGroup(AI_SetDisabled, "BlotCagedSpatter", false)
            ForEachEntityInGroup(SetTargetTeam, "BlotCagedSpatter", 2)
          else
            ForEachEntityInGroup(AI_SetDisabled, "TRT_BlotCagedSpinner", false)
            ForEachEntityInGroup(SetTargetTeam, "TRT_BlotCagedSpinner", 2)
          end
        end
      end
    end
  elseif (diorama == "blot") then
    if (GetGlobal("TRT_BlotSecurity") == 1) then
      AnimGBSequence("TRT_BlotCage2", "Open", true)
      AnimGBSequence("TRT_BlotCage1", "Open", true)
      Unhide("TRT_BlotCageLight1")
      Unhide("TRT_BlotCageLight2")
      StartEmitters("TRT_BlotCageLight1")
      StartEmitters("TRT_BlotCageLight1")
      if (GetGlobal("EM2_EpisodeCheck") < 3) then
        ForEachEntityInGroup(AI_SetDisabled, "BlotCagedSpatter", false)
        ForEachEntityInGroup(SetTargetTeam, "BlotCagedSpatter", 2)
      else
        ForEachEntityInGroup(AI_SetDisabled, "TRT_BlotCagedSpinner", false)
        ForEachEntityInGroup(SetTargetTeam, "TRT_BlotCagedSpinner", 2)
      end
    end
  end
  return 
end
TRT_DestroyGus = function()
  TeleportGremlinToEntity("TRT_Gus", "trt_dioramas_01a_clock.GusTeleportToDoc")
  return 
end
TRT_GusClockHint = function()
  if (GetGlobal("TRT_Gus_EnterClock_Played") == 0) then
    FireSequence("TRT_Gus", "TRT_Gus_EnterClock")
  end
  return 
end
TRT_OswaldCuckcooActivated = function()
  SetGlobal("TRT_OswaldCuckcooActivated", 1)
  DestroyEntity("HiddenShockerAIBuddyHint")
  ForEachEntityInGroup(DestroyEntity, "TRT_OswaldCuckoo")
  AnimGBSequence("trt_dioramas_01a_clock.TRT_cuckcoo_01a_inert 04", "Ticket")
  AnimGBSequence("trt_dioramas_01a_clock.TRT_cuckcoo_01a_inert 03", "Ticket")
  return 
end
TRT_FreeClockGremlin = function()
  local gremlin = "TRT_GremlinMortimer"
  SetGlobal("TRT_FreeClockGremlin", 1)
  TRT_Checkpoint(nil, "clock")
  TeleportGremlinToEntity(gremlin, "TRT_GremlinGearMarker", false, false)
  SetPropertyFloat("TRT_GremlinMortimer", "UsableRadius", 0)
  AnimVarInt(gremlin, VAR_Cutscene, 1)
  AnimEvent(gremlin, EVENT_Start_Cutscene)
  ForEachEntityInGroup(FireUser1, "TRT_ClockMovingPlatforms")
  wait(2)
  ForEachEntityInGroup(Disable, "TRT_GremlinPlatformGears")
  wait(1.5)
  TeleportGremlinOut(gremlin)
  DestroyEntity(gremlin)
  wait(3)
  TRT_SetClockJumpPath("trt_dioramas_01a_clock.prefab_jumpvolumeavailability 02.TargetToSend", "on")
  TRT_SetClockJumpPath("trt_dioramas_01a_clock.prefab_jumpvolumeavailability 05.TargetToSend", "on")
  return 
end
TRT_PersistClockGremlinReward = function()
  if (GetGlobal("TRT_FreeClockGremlin") == 1) then
    ForEachEntityInGroup(Disable, "TRT_GremlinPlatformGears")
    ForEachEntityInGroup(FireUser1, "TRT_ClockMovingPlatforms")
    wait(3)
    TRT_SetClockJumpPath("trt_dioramas_01a_clock.prefab_jumpvolumeavailability 02.TargetToSend", "on")
    TRT_SetClockJumpPath("trt_dioramas_01a_clock.prefab_jumpvolumeavailability 05.TargetToSend", "on")
  end
  return 
end
TRT_ClockPlatformsCamera = function(target, state)
  if (state == "start") then
    SetCameraAttributes("trt_dioramas_01a_clock.PlatformsCameraOverride")
  else
    ClearAllCameraAttributes(target)
  end
  return 
end
TRT_OpenArmPanel = function(target, side)
  Print("OpenArm")
  if (side == "left") then
    if (GetGlobal("TRT_ClockLeftArmHacked") == 0) then
      AnimGBSequence("TRT_LeftArmDoor", "Open")
      SetPropertyInt("TRT_LeftArmPowerBox", "Collision Layer", 2)
    end
  elseif (side == "right") then
    if (GetGlobal("TRT_ClockRightArmHacked") == 0) then
      AnimGBSequence("TRT_RightArmDoor", "Open")
      SetPropertyInt("TRT_RightArmPowerBox", "Collision Layer", 2)
    end
  end
  return 
end
TRT_CloseArmPanel = function(target)
  SetPropertyInt(target, "Collision Layer", 13)
  return 
end
TRT_ClockRestore = function()
  SetGlobal("TRT_ClockRestore", ((GetGlobal("TRT_ClockFaceVar") + GetGlobal("TRT_ClockLeftArmVar")) + GetGlobal("TRT_ClockRightArmVar")))
  local clockRepairCheckRestore = (GetGlobal("TRT_ClockRestore") + GetGlobal("TRT_ClockDestroy"))
  if (GetGlobal("TRT_ClockRestore") == 1) then
    if (clockRepairCheckRestore < 3) then
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_PaintClock1")
      TimerReset("TRT_ClockHintTimer")
    end
    SetGlobal("TRT_LastAction", 1)
    TRT_ClockStatusCheck()
  end
  if (GetGlobal("TRT_ClockRestore") == 2) then
    SetGlobal("TRT_GuardianPool", 2)
    SetGlobal("TRT_GuardianPoolRestored", 1)
    TRT_ClearPoolGuardians("paint")
    wait(1.5)
    FireSequence("TRT_NarratorMarker", "TRT_Narrator_PaintClock2")
    TimerReset("TRT_ClockHintTimer")
    SetGlobal("TRT_LastAction", 1)
    TRT_ClockStatusCheck()
  end
  if (GetGlobal("TRT_ClockRestore") == 3) then
    SetGlobal("TRT_LastAction", 1)
    TRT_ClockStatusCheck()
  end
  return 
end
TRT_ClockDestroy = function()
  local clockRepairCheck = (GetGlobal("TRT_ClockRestore") + GetGlobal("TRT_ClockDestroy"))
  if (GetGlobal("TRT_ClockDestroy") == 1) then
    if (clockRepairCheck < 3) then
      TimerReset("TRT_ClockHintTimer")
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_ThinClock1")
    end
    SetGlobal("TRT_LastAction", 2)
    TRT_ClockStatusCheck()
  end
  if (GetGlobal("TRT_ClockDestroy") == 2) then
    FireSequence("TRT_NarratorMarker", "TRT_Narrator_ThinClock2")
    TRT_ClockDamaged()
    TimerReset("TRT_ClockHintTimer")
    SetGlobal("TRT_LastAction", 2)
    TRT_ClockStatusCheck()
  end
  if (GetGlobal("TRT_ClockDestroy") == 3) then
    SetGlobal("TRT_LastAction", 2)
    TRT_ClockStatusCheck()
  end
  return 
end
TRT_ClockStatusCheck = function(state)
  local clockRepairs = (GetGlobal("TRT_ClockRestore") + GetGlobal("TRT_ClockDestroy"))
  if (clockRepairs == 3) then
    if (GetGlobal("TRT_ClockEndPlayed") == 0) then
      SetGlobal("TRT_ClockEndPlayed", 1)
      Quest_SetCriticalPath("Critical_TT", "Critical_TT_3")
      DestroyEntity("TRT_TubeHintTrig")
      if (2 <= GetGlobal("TRT_ClockRestore")) then
        FireSequence("TRT_NarratorMarker", "TRT_Narrator_ClockPaint")
        TimerReset("TRT_ClockHintTimer")
        ReplaceMusicStateOverride("Exp_L")
        Print("Music Clock Exp_L")
      elseif (2 <= GetGlobal("TRT_ClockDestroy")) then
        SetGlobal("TRT_DestroyedDioramas", (GetGlobal("TRT_DestroyedDioramas") + 1))
        SetGlobal("TRT_DioramaDestroyedClock", 1)
        FireSequence("TRT_NarratorMarker", "TRT_Narrator_ClockThin")
        TimerReset("TRT_ClockHintTimer")
        ReplaceMusicStateOverride("Exp_D")
        Print("Music Clock Exp_D")
        if (GetGlobal("TRT_ClockDestroy") == 2) then
          if (GetGlobal("TRT_DioramaDestroyedClock") == 0) then
            SetGlobal("TRT_DioramaDestroyedClock", 1)
            SetGlobal("TRT_DestroyedDioramas", (GetGlobal("TRT_DestroyedDioramas") + 1))
            TRT_Checkpoint(nil, "clock")
          end
        end
      end
    elseif (GetGlobal("TRT_ClockDestroy") == 2) then
      if (GetGlobal("TRT_DioramaDestroyedClock") == 0) then
        SetGlobal("TRT_DioramaDestroyedClock", 1)
        SetGlobal("TRT_DestroyedDioramas", (GetGlobal("TRT_DestroyedDioramas") + 1))
        TRT_Checkpoint(nil, "clock")
      end
    end
  else
    TRT_Checkpoint(nil, "clock")
  end
  return 
end
TRT_ClockStatusCheckMusic = function(state)
  local clockRepairs = (GetGlobal("TRT_ClockRestore") + GetGlobal("TRT_ClockDestroy"))
  if (clockRepairs == 3) then
    if (2 <= GetGlobal("TRT_ClockRestore")) then
      ReplaceMusicStateOverride("Exp_L")
      Print("Music Clock Exp_L")
    elseif (2 <= GetGlobal("TRT_ClockDestroy")) then
      ReplaceMusicStateOverride("Exp_D")
      Print("Music Clock Exp_D")
      ReplaceMusicStateOverride("Exp_N")
      Print("Music Clock Exp_N")
    end
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Music Clock Exp_N")
  end
  return 
end
TRT_ClockStatusCheckMusic3D = function(state)
  local clockRepairs = (GetGlobal("TRT_ClockRestore") + GetGlobal("TRT_ClockDestroy"))
  if (clockRepairs == 3) then
    if (GetGlobal("TRT_ClockEndPlayed") == 0) then
      if (2 <= GetGlobal("TRT_ClockRestore")) then
        ReplaceMusicStateOverride("Exp_L_3D")
        Print("Music Clock Exp_L_3D")
      elseif (2 <= GetGlobal("TRT_ClockDestroy")) then
        ReplaceMusicStateOverride("Exp_D_3D")
        Print("Music Clock Exp_D_3D")
        ReplaceMusicStateOverride("Exp_N_3D")
        Print("Music Clock Exp_N_3D")
        ReplaceMusicStateOverride("Exp_N_3D")
        Print("Music Clock Exp_N_3D")
      end
    else
      ReplaceMusicStateOverride("Exp_N_3D")
      Print("Music Clock Exp_N_3D")
      ReplaceMusicStateOverride("Exp_N_3D")
      Print("Music Clock Exp_N_3D")
    end
  else
    ReplaceMusicStateOverride("Exp_N_3D")
    Print("Music Clock Exp_N_3D")
  end
  return 
end
TRT_CuckcooKnockback = function(target, direction)
  StimulusEntityWithAliasInEntityDirectionInRadius(target, ST_KNOCKBACK, 10, 0, _activator(), direction, "")
  return 
end
TRT_PaintArm = function(target, arm)
  if (arm == "left") then
    SetGlobal("TRT_LeftArmPainted", (GetGlobal("TRT_LeftArmPainted") + 1))
    AudioPostEventOn("trt_dioramas_01a_clock_audio.Sound_RobotArm_ElectricB_01_Parent", "Stop_sfx_trt_RobotArm_Electricity_LP")
  end
  if (arm == "right") then
    SetGlobal("TRT_RightArmPainted", (GetGlobal("TRT_RightArmPainted") + 1))
    AudioPostEventOn("trt_dioramas_01a_clock_audio.Sound_RobotArm_ElectricA_01_Parent", "Stop_sfx_trt_RobotArm_Electricity_LP")
  end
  return 
end
TRT_ThinArm = function(target, arm)
  if (arm == "left") then
    SetGlobal("TRT_LeftArmPainted", (GetGlobal("TRT_LeftArmPainted") - 1))
  end
  if (arm == "right") then
    SetGlobal("TRT_RightArmPainted", (GetGlobal("TRT_RightArmPainted") - 1))
  end
  return 
end
TRT_StartArmMovement = function(target, state)
  if (state == "left") then
    if (GetGlobal("TRT_ClockLeftArmHacked") == 0) then
      AnimGBSequence(target, "Malfunction", true)
    end
  elseif (GetGlobal("TRT_ClockRightArmHacked") == 0) then
    AnimGBSequence(target, "Malfunction", true)
  end
  return 
end
TRT_HackArm = function(target, arm)
  if (arm == "left") then
    if (GetGlobal("TRT_ClockLeftArmHacked") == 0) then
      SetGlobal("TRT_ClockLeftArmHacked", 1)
      AnimGBSequence("TRT_ClockLeftArm", "Break")
      AudioPostEventOn("trt_dioramas_01a_clock_audio.Sound_RobotArmLeft_Break", "Play_sfx_ClockTowerArms_Left")
      ForEachEntityInGroup(DestroyEntity, "TRT_LeftArmHack")
      DestroyEntity("TRT_LeftArmFX")
      DestroyEntity("TRT_Hint_ClockHandLeft")
      SetGlobal("TRT_ClockDestroy", (GetGlobal("TRT_ClockDestroy") + 1))
      SetGlobal("TRT_ClockLeftArmVar", 0)
      SetGlobal("TRT_ClockRestore", ((GetGlobal("TRT_ClockFaceVar") + GetGlobal("TRT_ClockLeftArmVar")) + GetGlobal("TRT_ClockRightArmVar")))
      FireThread(TRT_SetClockGuardianPool)
      TRT_ClockDestroy()
    end
  end
  if (arm == "right") then
    if (GetGlobal("TRT_ClockRightArmHacked") == 0) then
      SetGlobal("TRT_ClockRightArmHacked", 1)
      DestroyEntity("TRT_Hint_ClockHandRight")
      AnimGBSequence("TRT_ClockRightArm", "Break")
      AudioPostEventOn("trt_dioramas_01a_clock_audio.Sound_RobotArmRight_Break", "Play_sfx_ClockTowerArms_Right")
      DestroyEntity("TRT_RightArmFX")
      ForEachEntityInGroup(DestroyEntity, "TRT_RightArmHack")
      SetGlobal("TRT_ClockDestroy", (GetGlobal("TRT_ClockDestroy") + 1))
      SetGlobal("TRT_ClockRightArmVar", 0)
      SetGlobal("TRT_ClockRestore", ((GetGlobal("TRT_ClockFaceVar") + GetGlobal("TRT_ClockLeftArmVar")) + GetGlobal("TRT_ClockRightArmVar")))
      FireThread(TRT_SetClockGuardianPool)
      TRT_ClockDestroy()
    end
  end
  return 
end
TRT_CheckArm = function(target, state)
  if (state == "left") then
    if (GetGlobal("TRT_ClockLeftArmHacked") == 0) then
      if (GetGlobal("TRT_LeftArmPainted") == 3) then
        AnimGBSequence("TRT_ClockLeftArm", "Fixed")
        AnimGBSequence("TRT_ClockLeftCloud", "Move")
        StopEmitters("TRT_LeftArmFX")
        if (GetGlobal("TRT_ClockLeftArmVar") == 0) then
          SetGlobal("TRT_ClockLeftArmVar", 1)
          DestroyEntity("TRT_Hint_ClockHandLeft")
          TRT_ClockRestore()
        end
      else
        StartEmitters("TRT_LeftArmFX")
        AnimGBSequence("TRT_ClockLeftArm", "Malfunction", true)
        AnimGBSequence("TRT_ClockLeftCloud", "Rest")
      end
    end
  end
  if (state == "right") then
    if (GetGlobal("TRT_ClockRightArmHacked") == 0) then
      if (GetGlobal("TRT_RightArmPainted") == 3) then
        AnimGBSequence("TRT_ClockRightArm", "Fixed")
        AnimGBSequence("TRT_ClockRightCloud", "Move")
        StopEmitters("TRT_RightArmFX")
        if (GetGlobal("TRT_ClockRightArmVar") == 0) then
          SetGlobal("TRT_ClockRightArmVar", 1)
          DestroyEntity("TRT_Hint_ClockHandRight")
          TRT_ClockRestore()
        end
      else
        StartEmitters("TRT_RightArmFX")
        AnimGBSequence("TRT_ClockRightArm", "Malfunction", true)
        AnimGBSequence("TRT_ClockRightCloud", "Rest")
      end
    end
  end
  return 
end
TRT_FaceRestore = function(target, event)
  if (GetGlobal("TRT_ClockFaceVar") == 0) then
    if (GetGlobal("TRT_ClockFaceStage") == 0) then
      SetGlobal("TRT_ClockFaceStage", 1)
      AnimGBSequence("trt_dioramas_01a_clock.TRT_dioramas_01b_faceArm_inert_01a 01", "Retract1")
    elseif (GetGlobal("TRT_ClockFaceStage") == 1) then
      SetGlobal("TRT_ClockFaceStage", 2)
      AnimGBSequence("trt_dioramas_01a_clock.TRT_dioramas_01b_faceArm_inert_01a 01", "Retract2")
    elseif (GetGlobal("TRT_ClockFaceStage") == 2) then
      SetGlobal("TRT_ClockFaceStage", 3)
      AnimGBSequence("trt_dioramas_01a_clock.TRT_dioramas_01b_faceArm_inert_01a 01", "Retract3")
      ForEachEntityInGroup(DestroyEntity, "TRT_ClockGearSpinSetup")
      if (GetGlobal("TRT_ClockFaceBroken") == 0) then
        SetGlobal("TRT_ClockFaceVar", 1)
        SetGlobal("TRT_ClockFaceDone", 1)
        ForEachEntityInGroup(DestroyEntity, "TRT_FaceFX")
        DestroyEntity("TRT_Hint_ClockFace")
        TRT_ClockRestore()
      end
      ForEachEntityInGroup(DestroyEntity, "OswaldClockGearSetup")
      OswaldStartFollowAction()
    end
  end
  return 
end
TRT_FacePersist = function()
  if (GetGlobal("TRT_ClockFaceBroken") == 1) then
    ClearParent("trt_dioramas_01a_clock.TRT_clockFace_01a_inert 01")
    EnableMotion("trt_dioramas_01a_clock.TRT_clockFace_01a_inert 01")
    EnableMotion("TRT_ClockFaceToon")
    SetParentEntity("TRT_ClockFaceToon", "trt_dioramas_01a_clock.TRT_clockFace_01a_inert 01")
    ApplyImpulse("trt_dioramas_01a_clock.TRT_clockFace_01a_inert 01", 1, 1, 1)
    ForEachEntityInGroup(DestroyEntity, "TRT_FaceFX")
  end
  return 
end
TRT_FaceBreak = function()
  ForEachEntityInGroup(DestroyEntity, "TRT_ClockGearSpinSetup")
  if (GetGlobal("TRT_ClockFaceBroken") == 0) then
    SetGlobal("TRT_ClockFaceBroken", 1)
    SetGlobal("TRT_ClockFaceDone", 1)
    ClearParent("trt_dioramas_01a_clock.TRT_clockFace_01a_inert 01")
    EnableMotion("trt_dioramas_01a_clock.TRT_clockFace_01a_inert 01")
    EnableMotion("TRT_ClockFaceToon")
    ApplyImpulse("trt_dioramas_01a_clock.TRT_clockFace_01a_inert 01", 1, 1, 1)
    SetParentEntity("TRT_ClockFaceToon", "trt_dioramas_01a_clock.TRT_clockFace_01a_inert 01")
    AudioPostEventOn("trt_dioramas_01a_clock.TRT_clockFace_01a_inert 01", "Play_sfx_ClockFaceFallingImpact")
    ForEachEntityInGroup(DestroyEntity, "TRT_FaceFX")
    if (GetGlobal("TRT_ClockFaceVar") == 0) then
      SetGlobal("TRT_ClockDestroy", (GetGlobal("TRT_ClockDestroy") + 1))
      DestroyEntity("TRT_Hint_ClockFace")
      TRT_ClockDestroy()
    end
  end
  return 
end
TRT_PoweredPlatforms = function(target)
  ForEachEntityInGroup(Enable, "TRT_ClockAlcovePlatforms")
  return 
end
TRT_ClockTerminalHint = function(target, state)
  local pausetime = 0
  SetGlobal("TRT_ClockTerminalHintPlayed", 1)
  if (2 <= GetGlobal("TRT_ClockRestore")) then
    state = "restored"
    FireSequence("TRT_GusMarker", "TRT_Gus_ClockRestoredImage")
    TimerReset("TRT_ClockHintTimer")
    pausetime = 9
  else
    FireSequence("TRT_GusMarker", "TRT_Gus_ClockDestroyedImage")
    TimerReset("TRT_ClockHintTimer")
    pausetime = 6.5
  end
  wait(pausetime)
  return 
end
TRT_CompleteClockRoom = function(state)
  Print("Complete Clock Room")
  AnimGBSequence("TRT_ClockTransport", "Open")
  SetPropertyFloat("ClockElevatorButton", "UsableRadius", 2)
  TimerEnable("TRT_TubeHintTimer")
  EnableGuardianHint("TRT_Hint_ClockTube")
  if (state == "restored") then
    AnimGBSequence("TRT_ClockTerminal", "docSecret")
  else
    AnimGBSequence("TRT_ClockTerminal", "graveyardOne")
  end
  TRT_Checkpoint(nil, "clock")
  return 
end
TRT_TubeHint = function()
  local clockRepairs = (GetGlobal("TRT_ClockRestore") + GetGlobal("TRT_ClockDestroy"))
  if (clockRepairs < 3) then
    FireSequence("TRT_GusMarker", "TRT_Gus_TransportInitialHint")
  end
  return 
end
local LeftLedge1 = 0
local LeftLedge2 = 0
local LeftLedge3 = 0
EnableLeftLedges = function(reg_0)
end
leavingclock = 0
DisableLeftLedges = function(reg_0)
end
local OswaldClockGearState = "Exit"
OswaldClockGearStatusUpdate = function(target, state)
  OswaldClockGearState = state
  return 
end
local ClockGearLeft = 0
local ClockGearRight = 0
ClockGearStatusCheck = function(target, side)
  if (side == "Left") then
    ClockGearLeft = 1
  elseif (side == "Right") then
    ClockGearRight = 1
  end
  wait(1)
  if ((ClockGearLeft + ClockGearRight) == 2) then
    ClockGearLeft = 0
    ClockGearRight = 0
    FireThread(TRT_FaceRestore)
  elseif (side == "Left") then
    ClockGearLeft = 0
  elseif (side == "Right") then
    ClockGearRight = 0
  end
  return 
end
TRT_EnableDisableSpinTrig = function(target)
  Enable(target)
  wait(0.30000001192092896)
  Disable(target)
  return 
end
TRT_OswaldSpin = function(target, side)
  if (side == "right") then
    OswaldSpinAction("ClockGearRight")
  else
    OswaldSpinAction("ClockGearLeft")
  end
  return 
end
local RightLedge1 = 0
local RightLedge2 = 0
local RightLedge3 = 0
EnableRightLedges = function(target)
  if (leavingclock == 0) then
    if (GetName(target) == "trt_dioramas_01a_clock.clockmovingplatform 08.TRT_platformPopper_01a_toon 01") then
      RightLedge1 = 1
      enableJumpVolumeAvailability("RightLedge0to1")
    elseif (GetName(target) == "trt_dioramas_01a_clock.clockmovingplatform 06.TRT_platformPopper_01a_toon 01") then
      RightLedge2 = 1
      enableJumpVolumeAvailability("RightLedge2to0")
    elseif (GetName(target) == "trt_dioramas_01a_clock.clockmovingplatform 07.TRT_platformPopper_01a_toon 01") then
      RightLedge3 = 1
      enableJumpVolumeAvailability("RightLedge3to0")
      enableJumpVolumeAvailability("RightLedge3to4")
    else
      Print(("DESIGN ERROR: EnableRightLedges called inappropriately by: " .. tostring(GetName(target))))
    end
    if (RightLedge1 == 1) then
      if (RightLedge2 == 1) then
        enableJumpVolumeAvailability("RightLedge1to2")
      end
    end
    if (RightLedge2 == 1) then
      if (RightLedge3 == 1) then
        enableJumpVolumeAvailability("RightLedge2to3")
      end
    end
  end
  return 
end
DisableRightLedges = function(target)
  if (leavingclock == 0) then
    if (GetName(target) == "trt_dioramas_01a_clock.clockmovingplatform 08.TRT_platformPopper_01a_toon 01") then
      RightLedge1 = 0
      disableJumpVolumeAvailability("RightLedge0to1")
    elseif (GetName(target) == "trt_dioramas_01a_clock.clockmovingplatform 06.TRT_platformPopper_01a_toon 01") then
      RightLedge2 = 0
      disableJumpVolumeAvailability("RightLedge2to0")
    elseif (GetName(target) == "trt_dioramas_01a_clock.clockmovingplatform 07.TRT_platformPopper_01a_toon 01") then
      RightLedge3 = 0
      disableJumpVolumeAvailability("RightLedge3to0")
      disableJumpVolumeAvailability("RightLedge3to4")
    else
      Print(("DESIGN ERROR: DisableRightLedges called inappropriately by: " .. tostring(GetName(target))))
    end
    if (RightLedge1 == 0) then
      disableJumpVolumeAvailability("RightLedge1to2")
    end
    if (RightLedge2 == 0) then
      disableJumpVolumeAvailability("RightLedge2to3")
    end
  end
  return 
end
TVSwitch = 0
TRT_DisableCartCollide = function()
  Print("Disable Cart Collisions")
  SetEntitiesToNotCollide("TRT_DocMineCart", "TRT_SlidingTrack")
  SetEntitiesToNotCollide("TRT_DocMineCart", "TRT_DocDioramaShell")
  return 
end
TRT_DocIntroIGC = function()
  if (GetGlobal("TRT_DocIntroPlayed") == 0) then
    SetGlobal("TRT_DocIntroPlayed", 1)
    RestrictCutSceneInput()
    StartFadeOut(0.4000000059604645)
    wait(0.4000000059604645)
    EnableSplitScreen(false)
    GrabCamera("TRT_DocIntroCam", nil, CAMERA_INSTANT_TRANSITION, 0)
    TeleportToEntity(GetPlayer(), "TRT_DocIGCMickeyTeleport")
    TeleportToEntity(GetPlayer2OrAI(), "TRT_DocIGCOswaldTeleport")
    StartFadeIn(0.4000000059604645)
    if (GetGlobal("TRT_DioramaDestroyedClock") == 0) then
      ForceSequence("TRT_AbeDoc", "TRT_Narrator_DocOverview")
    else
      TeleportGremlinToEntity("TRT_Gus", "TRT_DocIntGusTele")
      ForceSequence("TRT_Gus", "TRT_Gus_DocOverview")
    end
  end
  return 
end
TRT_ReleaseDocIntroIGC = function()
  Print("DocIntroIGC 111222333")
  FireThread(TeleportGremlinToEntity, "TRT_Gus", "TRT_GusInSpaceMarker")
  StartFadeOut(0.4000000059604645)
  wait(0.4000000059604645)
  GrabCamera("TRT_DocIntroEndCam", nil, CAMERA_INSTANT_TRANSITION, 0)
  wait(0.10000000149011612)
  EnableSplitScreen(true)
  ReleaseCamera(CAMERA_SAMEPLACE_TRANSITION, 2)
  StartFadeIn(0.4000000059604645)
  UnrestrictCutSceneInput()
  TRT_Checkpoint(nil, "doc")
  return 
end
TRT_ResolveDocPhoto = function()
  Print("SET Doc PHOTO VARIABLE")
  if (GetGlobal("TRT_DocGlobeState") == 2) then
    SetGlobal("MSN_Adelle_SnowGlobeVar", 1)
  else
    SetGlobal("MSN_Adelle_SnowGlobeVar", 2)
  end
  return 
end
TRT_DocSwingingDoors = function()
  ForEachEntityInGroup(SetPropertyBool, "TRT_DocSwingingDoors", "Allow Look Through", true)
  return 
end
TRT_DestroyDocSecretWall = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    TRT_ShakeCamera()
    AnimGBSequence(target, "Break")
    wait(1.5)
    Enable("TRT_BlueChest1ShockHint")
  end
  return 
end
TRT_DestroySparks = function(target, sparks)
  Print("DestroySparks NMEJSL")
  if (sparks == "panel") then
    ForEachEntityInPrefab(DestroyEntity, "PanelSparks")
  else
    ForEachEntityInPrefab(DestroyEntity, "GlobeSparks")
    ForEachEntityInPrefab(DestroyEntity, "GlobeSparks2")
  end
  return 
end
TRT_ResolveTV = function(target, state)
  if (TVSwitch == 0) then
    TVSwitch = 1
    if (state == "fix") then
      AnimGBSequence("trt_dioramas_01a_maddoc.TRT_dioramas_01c_tvMachine_inert_02a 01", "Fixed")
      DestroyEntity("trt_dioramas_01a_maddoc.TRT_dioramas_01c_tvMachine_inert_01a 01")
      ForEachEntityInGroup(DestroyEntity, "TRT_TVPulleySparkFX")
    end
    if (state == "drop") then
      AnimGBSequence("trt_dioramas_01a_maddoc.TRT_dioramas_01c_tvMachine_inert_02a 01", "Break")
      ForEachEntityInGroup(DestroyEntity, "TRT_TVPulleySparkFX")
      EnableMotion("trt_dioramas_01a_maddoc.TRT_dioramas_01c_tvMachine_inert_01a 01")
      AudioPostEventOn("trt_dioramas_01a_maddoc.TRT_dioramas_01c_tvMachine_inert_02a 01", "Play_sfx_trt_maddoc_anvildrop")
    end
  else
    if (state == "drop") then
      AnimGBSequence("trt_dioramas_01a_maddoc.TRT_dioramas_01c_tvMachine_inert_02a 01", "Break")
      AudioPostEventOn("trt_dioramas_01a_maddoc.TRT_dioramas_01c_tvMachine_inert_02a 01", "Play_sfx_trt_TVDrop_Snap")
    end
    if (state == "fix") then
      DestroyEntity("trt_dioramas_01a_maddoc.TRT_dioramas_01c_tvMachine_inert_01a 01")
    end
  end
  return 
end
TRT_DropTV = function()
  if (GetGlobal("TRT_TVSwitch") == 0) then
    SetGlobal("TRT_TVSwitch", 1)
    Enable("AnvilPropKnockbackTrig")
    SetPropertyInt("TRT_MadDocTV", "Collision Layer", 19)
    AnimGBSequence("trt_dioramas_01a_maddoc.TRT_dioramas_01c_tvMachine_inert_02a 01", "Break")
    AudioPostEventOn("trt_dioramas_01a_maddoc.TRT_dioramas_01c_tvMachine_inert_02a 01", "Play_sfx_trt_TVDrop_Snap")
    wait(0.8999999761581421)
    DestroyEntity("AnvilPropKnockbackTrigAI")
    DestroyEntity("AnvilPropKnockbackTrig")
    DestroyEntity("trt_dioramas_01a_maddoc.TRT_dioramas_01c_tvMachine_inert_02a 01")
    Unhide("trt_dioramas_01a_maddoc.ETicket_A 01")
  end
  return 
end
TRT_CartDeadEnd = function(target)
  ForEachEntityInGroup(StartEmitters, "TRT_BrokenTrackFX")
  wait(1.5)
  Reverse(target)
  ForEachEntityInGroup(StopEmitters, "TRT_BrokenTrackFX")
  return 
end
TRT_TrackMotion = function(target, state)
  if (state == "start") then
    EnableMotion(target)
  else
    DisableMotion(target)
  end
  return 
end
TRT_SetupSlidingTrackOnLoad = function()
  wait(2)
  if (GetGlobal("TRT_DocTrackState") == 1) then
    SetPropertyFloat("TRT_SlidingTrack", "UsableRadius", 0)
    DisableMotion("TRT_SlidingTrack")
  elseif (GetGlobal("TRT_DocTrackState") == 2) then
    SetPropertyFloat("TRT_SlidingTrack", "UsableRadius", 0)
    DisableMotion("TRT_SlidingTrack")
  end
  return 
end
TRT_SetCartOrientation = function()
  SetPropertyInt("TRT_DocMineCartSplineFollower", "OrientationType", 1)
  return 
end
TRT_SetTrack = function(target, track)
  Print("Set Track! LWEKEFJZ")
  if (GetGlobal("TRT_DocTrackState") == 0) then
    AudioPostEventOn("TRT_sfx_MineCartBroken_LP", "Stop_sfx_MineCartBroken_Lp")
    if (track == "straight") then
      SetGlobal("TRT_DocTrackState", 1)
      SetGlobal("TRT_DocRestore", (GetGlobal("TRT_DocRestore") + 1))
      SetPropertyFloat("TRT_SlidingTrack", "UsableRadius", 0)
      DisableMotion("TRT_SlidingTrack")
      SplineKnotComponent_SetBranchProbability("trt_dioramas_01a_maddoc.ReverseBranchTrackKnot2", 1)
      SplineKnotComponent_SetBranchProbability("trt_dioramas_01a_maddoc.SplineKnot 15", 1)
      SplineKnotComponent_SetBranchProbability("TRT_BrokenTrackBranch", 1)
      SetPropertyFloat("TRT_SlidingTrack", "UsableRadius", 0)
    end
    if (track == "curved") then
      AudioPostEventOn("TRT_sfx_MineCartBroken_LP", "Stop_sfx_MineCartBroken_Lp")
      SetGlobal("TRT_DocTrackState", 2)
      SetGlobal("TRT_DocDestroy", (GetGlobal("TRT_DocDestroy") + 1))
      SetPropertyFloat("TRT_SlidingTrack", "UsableRadius", 0)
      DisableMotion("TRT_SlidingTrack")
      SplineKnotComponent_SetBranchProbability("trt_dioramas_01a_maddoc.ReverseBranchTrackKnot2", 1)
      SplineKnotComponent_SetBranchProbability("TRT_BrokenTrackBranch", 1)
      SetPropertyFloat("TRT_SlidingTrack", "UsableRadius", 0)
      wait(2)
    end
  end
  return 
end
TRT_CartEndHit = function(target, track)
  if (GetGlobal("TRT_CartEnded") == 0) then
    SetGlobal("TRT_CartEnded", 1)
    DestroyEntity("TRT_Hint_Track")
    if (track == "straight") then
      SetGlobal("TRT_LastAction", 1)
      TRT_DocStageProgress("paint")
    else
      DestroyEntity("CartLookAtMe")
      DestroyEntity(target)
      DestroyEntity("TRT_DocMineCart")
      SetGlobal("TRT_LastAction", 2)
      TRT_DocStageProgress("thin")
    end
  end
  return 
end
TRT_ReverseKnot = function(target, state)
  if (state == "reverse") then
    wait(0.5)
    SetLocalSpaceFacing("TRT_DocMineCart", vector4(0, 0, -1))
    Reverse(target)
    TeleportToEntity("CartLookAtMe", "CartLookBack")
  else
    wait(0.5)
    SetLocalSpaceFacing("TRT_DocMineCart", vector4(0, 0, 1))
    Reverse(target)
    TeleportToEntity("CartLookAtMe", "CartLookForward")
  end
  return 
end
TRT_OswaldSteamPlatform = function(target, state)
  if (state == "start") then
    resumeJumpVolumeWait("SteamPlatformController")
  else
    pauseJumpVolumeWait("SteamPlatformController")
  end
  return 
end
TRT_BeetleSpawnDoorCartReact = function()
  if (GetGlobal("TRT_Narrator_DocDestroyed_Played") == 0) then
    if (GetGlobal("TRT_Narrator_DocRestored_Played") == 0) then
      AnimGBSequence("TRT_BeetleCartDoor", "cartHit")
    end
  end
  return 
end
TRT_GlobeMachinePower = function(target, state)
  if (state == "paint") then
    SetGlobal("TRT_DocGlobePower", (GetGlobal("TRT_DocGlobePower") + 1))
    if (GetGlobal("TRT_DocGlobePower") == 3) then
      DestroyEntity("TRT_Hint_Globe")
      DestroyEntity("TRT_DocPanelBoomerang")
      DestroyEntity("TRT_RaftersNodeSwitchTrig")
      AudioPostEventOn("trt_dioramas_01a_maddoc_audio.Sound_MadDoc_GlobeSparks", "Stop_sfx_CablesElectric_Lrg_LP")
      TRT_ResolveGlobeMachine("paint")
    end
  elseif (state == "thin") then
    SetGlobal("TRT_DocGlobePower", (GetGlobal("TRT_DocGlobePower") - 1))
  end
  return 
end
TRT_DestroyedDocPanel = function()
  DestroyEntity("TRT_DocPanelBoomerang")
  DestroyEntity("TRT_RaftersNodeSwitchTrig")
  DestroyEntity("TRT_MadDocPanel")
  return 
end
TRT_OswaldToGlobeMachine = function(target, state)
  if (GetNumPlayers() == 1) then
    if (state == "in") then
      TeleportToEntity(GetOswaldAI(), "trt_dioramas_01a_blot.OswaldToGlobeMarker")
    else
      TeleportToEntity(GetOswaldAI(), "trt_dioramas_01a_blot.OswaldAwayFromGlobeMarker")
    end
  end
  return 
end
TRT_OswaldBoomerangGlobePanel = function()
  OswaldSingleTargetBoomerangAction("TRT_BlotGlobeBoomerang")
  return 
end
TRT_GlobeMachineDestroy = function(target, state)
  if (state == "paint") then
    SetGlobal("TRT_DocGlobeSupports", (GetGlobal("TRT_DocGlobeSupports") - 1))
  else
    SetGlobal("TRT_DocGlobeSupports", (GetGlobal("TRT_DocGlobeSupports") + 1))
  end
  if (GetGlobal("TRT_DocGlobeSupports") == 2) then
    AnimGBSequence("TRT_MadDocGlobeMachine", "Break")
    FireUser1("GlobeKillTrig")
    DestroyEntity("TRT_PlatformWaitNode")
    DestroyEntity("TRT_RaftersNodeSwitchTrig")
    DestroyEntity("TRT_Hint_Globe")
    TRT_DestroySparks()
    if (GetGlobal("TRT_DocGlobeState") == 1) then
      SetGlobal("TRT_DocGlobeState", 2)
      SetGlobal("TRT_DocRestore", (GetGlobal("TRT_DocRestore") - 1))
      SetGlobal("TRT_DocDestroy", (GetGlobal("TRT_DocDestroy") + 1))
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocThin")
    else
      wait(1.5)
      TRT_ResolveGlobeMachine("thin")
    end
  end
  return 
end
TRT_ResolveGlobeMachine = function(state)
  if (GetGlobal("TRT_DocGlobeState") == 0) then
    DestroyEntity("TRT_Hint_Globe")
    if (state == "paint") then
      SetGlobal("TRT_DocGlobeState", 1)
      SetGlobal("TRT_DocRestore", (GetGlobal("TRT_DocRestore") + 1))
      AnimGBSequence("TRT_MadDocGlobeMachine", "Fixed")
      SetGlobal("TRT_LastAction", 1)
      TRT_DocStageProgress("paint")
    elseif (state == "thin") then
      SetGlobal("TRT_DocGlobeState", 2)
      SetGlobal("TRT_DocDestroy", (GetGlobal("TRT_DocDestroy") + 1))
      AnimGBSequence("TRT_MadDocGlobeMachine", "Break")
      FireUser1("GlobeKillTrig")
      SetGlobal("TRT_LastAction", 2)
      TRT_DocStageProgress("thin")
    end
  end
  return 
end
TRT_DocStageProgress = function(state)
  if (GetGlobal("TRT_DocProgress") == 0) then
    SetGlobal("TRT_DocProgress", 1)
    if (state == "paint") then
      TimerReset("TRT_DocHintTimer")
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocPaint")
      TRT_Checkpoint(nil, "doc")
    else
      TimerReset("TRT_DocHintTimer")
      TRT_DocDestructiveSequence()
      if (GetGlobal("TRT_DocProgress") == 1) then
        SetGlobal("TRT_DocProgress", 2)
        if (state == "paint") then
          TimerReset("TRT_DocHintTimer")
          FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocPaint2")
          TRT_Checkpoint(nil, "doc")
        else
          TimerReset("TRT_DocHintTimer")
          TRT_DocDestructiveSequence()
          if (GetGlobal("TRT_DocProgress") == 2) then
            SetGlobal("TRT_DocProgress", 3)
            RestrictCutSceneInput()
            StartFadeOut(0.4000000059604645)
            wait(0.4000000059604645)
            EnableSplitScreen(false)
            SetPropertyInt("TRT_BeetleCartDoor", "Collision Layer", 13)
            GrabCamera("TRT_BlotworxIntroCam", nil, CAMERA_LERP_TRANSITION, 0)
            TeleportToEntity(GetPlayer(), "ShockerPortMickey")
            TeleportToEntity(GetPlayer2OrAI(), "ShockerPortOswald")
            StartFadeIn(0.4000000059604645)
            if (2 <= GetGlobal("TRT_DocRestore")) then
              Hide("TRT_DocMineCart")
              TimerReset("TRT_DocHintTimer")
              ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocPaint2")
              ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocThin2")
              FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocRestored")
              ReplaceMusicStateOverride("Exp_L")
              Print("Music Attic Exp_L")
            else
              TimerReset("TRT_DocHintTimer")
              ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocPaint2")
              ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocThin2")
              FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocDestroyed")
              SetGlobal("TRT_DestroyedDioramas", (GetGlobal("TRT_DestroyedDioramas") + 1))
              SetGlobal("TRT_DioramaDestroyedDoc", 1)
              ReplaceMusicStateOverride("Exp_D")
              Print("Music Attic Exp_D")
            end
          end
        end
      elseif (GetGlobal("TRT_DocProgress") == 2) then
        SetGlobal("TRT_DocProgress", 3)
        RestrictCutSceneInput()
        StartFadeOut(0.4000000059604645)
        wait(0.4000000059604645)
        EnableSplitScreen(false)
        SetPropertyInt("TRT_BeetleCartDoor", "Collision Layer", 13)
        GrabCamera("TRT_BlotworxIntroCam", nil, CAMERA_LERP_TRANSITION, 0)
        TeleportToEntity(GetPlayer(), "ShockerPortMickey")
        TeleportToEntity(GetPlayer2OrAI(), "ShockerPortOswald")
        StartFadeIn(0.4000000059604645)
        if (2 <= GetGlobal("TRT_DocRestore")) then
          Hide("TRT_DocMineCart")
          TimerReset("TRT_DocHintTimer")
          ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocPaint2")
          ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocThin2")
          FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocRestored")
          ReplaceMusicStateOverride("Exp_L")
          Print("Music Attic Exp_L")
        else
          TimerReset("TRT_DocHintTimer")
          ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocPaint2")
          ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocThin2")
          FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocDestroyed")
          SetGlobal("TRT_DestroyedDioramas", (GetGlobal("TRT_DestroyedDioramas") + 1))
          SetGlobal("TRT_DioramaDestroyedDoc", 1)
          ReplaceMusicStateOverride("Exp_D")
          Print("Music Attic Exp_D")
        end
      end
    end
  elseif (GetGlobal("TRT_DocProgress") == 1) then
    SetGlobal("TRT_DocProgress", 2)
    if (state == "paint") then
      TimerReset("TRT_DocHintTimer")
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocPaint2")
      TRT_Checkpoint(nil, "doc")
    else
      TimerReset("TRT_DocHintTimer")
      TRT_DocDestructiveSequence()
      if (GetGlobal("TRT_DocProgress") == 2) then
        SetGlobal("TRT_DocProgress", 3)
        RestrictCutSceneInput()
        StartFadeOut(0.4000000059604645)
        wait(0.4000000059604645)
        EnableSplitScreen(false)
        SetPropertyInt("TRT_BeetleCartDoor", "Collision Layer", 13)
        GrabCamera("TRT_BlotworxIntroCam", nil, CAMERA_LERP_TRANSITION, 0)
        TeleportToEntity(GetPlayer(), "ShockerPortMickey")
        TeleportToEntity(GetPlayer2OrAI(), "ShockerPortOswald")
        StartFadeIn(0.4000000059604645)
        if (2 <= GetGlobal("TRT_DocRestore")) then
          Hide("TRT_DocMineCart")
          TimerReset("TRT_DocHintTimer")
          ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocPaint2")
          ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocThin2")
          FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocRestored")
          ReplaceMusicStateOverride("Exp_L")
          Print("Music Attic Exp_L")
        else
          TimerReset("TRT_DocHintTimer")
          ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocPaint2")
          ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocThin2")
          FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocDestroyed")
          SetGlobal("TRT_DestroyedDioramas", (GetGlobal("TRT_DestroyedDioramas") + 1))
          SetGlobal("TRT_DioramaDestroyedDoc", 1)
          ReplaceMusicStateOverride("Exp_D")
          Print("Music Attic Exp_D")
        end
      end
    end
  elseif (GetGlobal("TRT_DocProgress") == 2) then
    SetGlobal("TRT_DocProgress", 3)
    RestrictCutSceneInput()
    StartFadeOut(0.4000000059604645)
    wait(0.4000000059604645)
    EnableSplitScreen(false)
    SetPropertyInt("TRT_BeetleCartDoor", "Collision Layer", 13)
    GrabCamera("TRT_BlotworxIntroCam", nil, CAMERA_LERP_TRANSITION, 0)
    TeleportToEntity(GetPlayer(), "ShockerPortMickey")
    TeleportToEntity(GetPlayer2OrAI(), "ShockerPortOswald")
    StartFadeIn(0.4000000059604645)
    if (2 <= GetGlobal("TRT_DocRestore")) then
      Hide("TRT_DocMineCart")
      TimerReset("TRT_DocHintTimer")
      ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocPaint2")
      ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocThin2")
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocRestored")
      ReplaceMusicStateOverride("Exp_L")
      Print("Music Attic Exp_L")
    else
      TimerReset("TRT_DocHintTimer")
      ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocPaint2")
      ForceInterruptSequence("TRT_NarratorMarker", "TRT_Narrator_DocThin2")
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocDestroyed")
      SetGlobal("TRT_DestroyedDioramas", (GetGlobal("TRT_DestroyedDioramas") + 1))
      SetGlobal("TRT_DioramaDestroyedDoc", 1)
      ReplaceMusicStateOverride("Exp_D")
      Print("Music Attic Exp_D")
    end
  end
  return 
end
TRT_DocStageProgressMusic = function(state)
  if (GetGlobal("TRT_DocProgress") == 3) then
    if (2 <= GetGlobal("TRT_DocRestore")) then
      ReplaceMusicStateOverride("Exp_L")
      Print("Music Attic Exp_L")
    else
      ReplaceMusicStateOverride("Exp_D")
      Print("Music Attic Exp_D")
      ReplaceMusicStateOverride("Exp_N")
      Print("Music Attic Exp_N")
    end
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Music Attic Exp_N")
  end
  return 
end
TRT_DocStageProgressMusic3D = function(state)
  if (GetGlobal("TRT_DocProgress") == 3) then
    if (2 <= GetGlobal("TRT_DocRestore")) then
      ReplaceMusicStateOverride("Exp_L_3D")
      Print("Music Attic Exp_L_3D")
    else
      ReplaceMusicStateOverride("Exp_D_3D")
      Print("Music Attic Exp_D_3D")
      ReplaceMusicStateOverride("Exp_N_3D")
      Print("Music Attic Exp_N_3D")
    end
  else
    ReplaceMusicStateOverride("Exp_N_3D")
    Print("Music Attic Exp_N_3D")
  end
  return 
end
TRT_DocDestructiveSequence = function()
  if (GetGlobal("TRT_DocDestroy") == 1) then
    Print("__Firing Doc Thin Sequence!")
    FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocThin")
    TRT_Checkpoint(nil, "doc")
  else
    Print("__Firing Doc Thin2 Sequence!")
    FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocThin2")
  end
  return 
end
TRT_ReleaseDocCutscene = function()
  StartFadeOut(0.4000000059604645)
  wait(0.4000000059604645)
  EnableSplitScreen(true)
  ForEachEntityInGroup(DestroyEntity, "DocDoorDust")
  Unhide("TRT_DocMineCart")
  SetSplineFollowerInitialSpeed("TRT_DocMineCart", 3)
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
  CameraReset()
  UnrestrictCutSceneInput()
  wait(0.10000000149011612)
  StartFadeIn(0.4000000059604645)
  TRT_Checkpoint(nil, "doc")
  return 
end
docWallSteamOn = 0
docWallSteam2On = 1
TRT_DocWallSteamJet = function(target, number)
  if (number == "1") then
    if (docWallSteamOn == 0) then
      docWallSteamOn = 1
      Enable("TRT_DocWallKnockbackTrig")
      StartEmitters("TRT_DocWallSteamJetFX")
      AudioPostEventOn("trt_dioramas_01a_maddoc_audio.Sound_MadDoc_Steam01", "Play_sfx_trt_SteamBlast_LP")
      SetPropertyFloat("TRT_DocWallSteamTimer", "TimerInterval", 1)
    else
      docWallSteamOn = 0
      Disable("TRT_DocWallKnockbackTrig")
      StopEmitters("TRT_DocWallSteamJetFX")
      AudioPostEventOn("trt_dioramas_01a_maddoc_audio.Sound_MadDoc_Steam01", "Stop_sfx_trt_SteamBlast_LP")
      SetPropertyFloat("TRT_DocWallSteamTimer", "TimerInterval", 2)
      wait(0.20000000298023224)
      if (docWallSteam2On == 0) then
        docWallSteam2On = 1
        Enable("TRT_DocWallKnockbackTrig2")
        StartEmitters("TRT_DocWallSteamJetFX2")
        AudioPostEventOn("trt_dioramas_01a_maddoc_audio.Sound_MadDoc_Steam02", "Play_sfx_trt_SteamBlast_LP")
        SetPropertyFloat("TRT_DocWallSteamTimer2", "TimerInterval", 1)
      else
        docWallSteam2On = 0
        Disable("TRT_DocWallKnockbackTrig2")
        StopEmitters("TRT_DocWallSteamJetFX2")
        AudioPostEventOn("trt_dioramas_01a_maddoc_audio.Sound_MadDoc_Steam02", "Stop_sfx_trt_SteamBlast_LP")
        SetPropertyFloat("TRT_DocWallSteamTimer2", "TimerInterval", 2)
      end
    end
  else
    wait(0.20000000298023224)
    if (docWallSteam2On == 0) then
      docWallSteam2On = 1
      Enable("TRT_DocWallKnockbackTrig2")
      StartEmitters("TRT_DocWallSteamJetFX2")
      AudioPostEventOn("trt_dioramas_01a_maddoc_audio.Sound_MadDoc_Steam02", "Play_sfx_trt_SteamBlast_LP")
      SetPropertyFloat("TRT_DocWallSteamTimer2", "TimerInterval", 1)
    else
      docWallSteam2On = 0
      Disable("TRT_DocWallKnockbackTrig2")
      StopEmitters("TRT_DocWallSteamJetFX2")
      AudioPostEventOn("trt_dioramas_01a_maddoc_audio.Sound_MadDoc_Steam02", "Stop_sfx_trt_SteamBlast_LP")
      SetPropertyFloat("TRT_DocWallSteamTimer2", "TimerInterval", 2)
    end
  end
  return 
end
TRT_DocWallSteamStim = function(target, number)
  if (number == "2") then
    StimulusEntityWithAliasInEntityDirectionInRadius("TRT_DocWallKnockbackTrig", ST_KNOCKBACK, 10, 0, target, "TRT_DocWallSteamKnockbackMarker2", "")
  end
  StimulusEntityWithAliasInEntityDirectionInRadius("TRT_DocWallKnockbackTrig", ST_KNOCKBACK, 10, 0, target, "TRT_DocWallSteamKnockbackMarker", "")
  return 
end
playerInBeetleSpawn1 = 0
TRT_PlayerInBeetleSpawner = function(target, state)
  if (state == "inside") then
    playerInBeetleSpawn1 = 1
  else
    playerInBeetleSpawn1 = 0
  end
  return 
end
beetleDirection = 0
beetleOnToon = 0
TRT_BeetleDirection = function(target, state)
  if (state == "right") then
    beetleDirection = 1
  else
    beetleDirection = 0
  end
  return 
end
TRT_BeetleOnToonCheck = function(target, state)
  if (state == "left") then
    if (beetleDirection == 0) then
      if (playerInBeetleSpawn1 == 0) then
        if (GetGlobal("TRT_BeetleDoorPainted") == 1) then
          AnimGBSequence("TRT_DocSpawnerDoor", "Close")
        end
      end
      beetleOnToon = 1
    else
      if (GetGlobal("TRT_BeetleDoorPainted") == 1) then
        AnimGBSequence("TRT_DocSpawnerDoor", "Open")
      end
      beetleOnToon = 0
      if (beetleDirection == 1) then
        beetleOnToon = 1
      else
        beetleOnToon = 1
      end
    end
  elseif (beetleDirection == 1) then
    beetleOnToon = 1
  else
    beetleOnToon = 1
  end
  return 
end
TRT_SpinnerToonStateChange = function(target, state)
  if (state == "paint") then
    SetGlobal("TRT_SpinnerToonThinned", 0)
  else
    SetGlobal("TRT_SpinnerToonThinned", 1)
    if (beetleOnToon == 1) then
      DisableComponent("LeftBWXProp", "SplineFollower")
      EnableMotion("LeftBWXProp")
      wait(0.009999999776482582)
      ApplyImpulse("LeftBWXProp", 1, 0, 0)
      TRT_BeetlePropDestroyed()
    end
  end
  return 
end
TRT_BeetleThinnedToonReverse = function(target)
  if (GetGlobal("TRT_SpinnerToonThinned") == 1) then
    Reverse(target)
  else
    TRT_BeetleOnToonCheck(target, "left")
  end
  return 
end
beetleDoorPainted = 0
TRT_BeetleDoorReverse = function(target)
  if (GetGlobal("TRT_BeetleDoorPainted") == 0) then
    Reverse(target)
  end
  return 
end
TRT_PaintBeetleDoor = function(target, state)
  if (state == "paint") then
    SetGlobal("TRT_BeetleDoorPainted", 1)
    AnimGBSequence("TRT_DocSpawnerDoor", "Open")
    StopEmitters("TRT_SpawnerDoor1FX")
  else
    SetGlobal("TRT_BeetleDoorPainted", 0)
    StartEmitters("TRT_SpawnerDoor1FX")
  end
  return 
end
TRT_BranchSpawnerDoor = function(knot, state)
  if (state == "paint") then
    SplineKnotComponent_SetBranchProbability(knot, 1)
  else
    SplineKnotComponent_SetBranchProbability(knot, 0)
  end
  return 
end
TRT_TrackRightEye = function(target, state)
  if (state == "paint") then
    SetGlobal("TRT_TrackRightEyeDoor", 1)
  else
    SetGlobal("TRT_TrackRightEyeDoor", 0)
  end
  return 
end
TRT_PersistRightEyeDoor = function()
  if (GetGlobal("TRT_TrackRightEyeDoor") == 1) then
    AnimGBSequence("TRT_DocSpawnerDoor2", "Open")
    SetSplineFollowerInitialSpeed("TRT_RightBWXCutout", 1.5)
  end
  return 
end
TRT_BeetlePropRestored = function(target)
  if (GetGlobal("TRT_DocBeetleState") == 0) then
    SetGlobal("TRT_DocBeetleState", 1)
    SetGlobal("TRT_DocRestore", (GetGlobal("TRT_DocRestore") + 1))
    SetGlobal("TRT_LastAction", 1)
    DestroyEntity("TRT_Hint_BWX")
    TRT_DocStageProgress("paint")
  end
  return 
end
TRT_BeetlePropDestroyed = function(target)
  if (GetGlobal("TRT_DocBeetleState") == 0) then
    DestroyEntity("TRT_Hint_BWX")
    SetGlobal("TRT_DocBeetleState", 2)
    SetGlobal("TRT_DocDestroy", (GetGlobal("TRT_DocDestroy") + 1))
    wait(1)
    SetGlobal("TRT_LastAction", 2)
    TRT_DocStageProgress("thin")
  end
  return 
end
TRT_PersistLeftBWX = function(target)
  if (GetGlobal("TRT_DocBeetleState") == 2) then
    DestroyEntity(target)
  end
  return 
end
docSpawnDoorOpen1 = 0
docSpawnDoorOpen2 = 0
TRT_OpenCloseSpawnerDoor = function(target)
  if (docSpawnDoorOpen1 == 0) then
    AnimGBSequence("TRT_DocSpawnerDoor", "Open")
  else
    AnimGBSequence("TRT_DocSpawnerDoor", "Close")
  end
  return 
end
playerInBeetleSpawn2 = 1
TRT_Beetle2Direction = function(target, state)
  if (playerInBeetleSpawn2 == 0) then
    if (state == "retreat") then
      docSpawnDoorOpen2 = 0
    else
      docSpawnDoorOpen2 = 1
    end
  end
  return 
end
TRT_OpenCloseSpawnerDoor2 = function(target)
  if (docSpawnDoorOpen2 == 0) then
    AnimGBSequence("TRT_DocSpawnerDoor2", "Open")
  elseif (docSpawnDoorOpen2 == 1) then
    if (playerInBeetleSpawn2 == 0) then
      AnimGBSequence("TRT_DocSpawnerDoor2", "Close")
    end
  end
  return 
end
TRT_EnterBeetleSpawner2 = function(target, state)
  if (state == "enter") then
    playerInBeetleSpawn2 = (playerInBeetleSpawn2 + 1)
    SetCameraAttributesForPlayer("TRT_InsideSpawner2Cam", target)
  else
    playerInBeetleSpawn2 = (playerInBeetleSpawn2 - 1)
    ClearAllCameraAttributes(target)
  end
  return 
end
MiniBoss_defeated = 0
TRT_DocBlotworxDefeated = function()
  if (MiniBoss_defeated == 0) then
    while true do
      if (not IsAnySequencePlaying()) then
        break
      end
      wait(0.10000000149011612)
    end
    if (2 <= GetGlobal("TRT_DocRestore")) then
      TimerReset("TRT_DocHintTimer")
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocBlotPaint")
    else
      TimerReset("TRT_DocHintTimer")
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_DocBlotThinner")
    end
    DoStinger("MiniBoss_Win", 2)
    Print("MiniBoss Win stinger music")
    wait(1)
    TRT_DocStageProgressMusic()
    MiniBoss_defeated = 1
  end
  return 
end
TRT_DocTerminalHint = function(target)
  SetGlobal("TRT_DocTerminalHintPlayed", 1)
  if (2 <= GetGlobal("TRT_DocRestore")) then
    TimerReset("TRT_DocHintTimer")
    FireSequence("TRT_GusMarker", "TRT_Gus_DocRestoredImage")
  else
    TimerReset("TRT_DocHintTimer")
    FireSequence("TRT_GusMarker", "TRT_Gus_DocDestroyedImage")
  end
  wait(8)
  return 
end
TRT_PaintLights = function(target, state)
  Print("PAINTING ALPHA FADE ZLKXCJ")
  if (state == "paint") then
    for i = 0, 1, 0.0333000011742115 do
      SetR3MTConstRegAlpha(target, 1, i)
      wait(0.0333000011742115)
    end
  else
    for i = 1, 0, -0.0333000011742115 do
      i = i
      SetR3MTConstRegAlpha(target, 1, i)
      wait(0.0333000011742115)
    end
  end
  return 
end
TRT_RevealBruiser = function()
  SplineFollower_TeleportToKnot("TRT_DocMineCartSplineFollower", "CartTeleportKnot")
  SetSplineFollowerInitialSpeed("TRT_DocMineCart", 0)
  Enable("TRT_BruiserSpawnerDevice")
  AnimGBSequence("TRT_BeetleCartDoor", "breakOut", true)
  ForEachEntityInGroup(StartEmitters, "DocDoorDust")
  ReplaceMusicStateOverride("IGC_1A_01")
  Print("Reveal Bruiser music stinger")
  ShakeCamera(1.5, 5, 0.75, 0.75, 0.029999999329447746, 0.029999999329447746)
  wait(1.25)
  GoToEntity("TRT_DocBlotworxBruiser", "ShockerIGCPatrol")
  wait(0.25)
  ReplaceMusicStateOverride("Combat_Lev3")
  wait(1)
  return 
end
TRT_PersistDocMickeyCutout = function()
end
TRT_BackupSpawnerPersist = function()
  if (2 < GetGlobal("TRT_DocProgress")) then
    if (GetGlobal("TRT_ShockerDefeated") == 0) then
      Enable("TRT_BruiserSpawnerDevice")
    end
  end
  return 
end
TRT_DisableDocElevator = function()
  if (GetGlobal("TRT_DocProgress") < 3) then
    if (GetGlobal("EM2_EpisodeCheck") < 3) then
      SetPropertyFloat("DocElevatorButton", "UsableRadius", 0)
    end
  end
  return 
end
TRT_ResolveDocBlotworx = function(state)
  AnimGBSequence("TRT_DocTransport", "Open")
  SetPropertyFloat("DocElevatorButton", "UsableRadius", 2)
  SetGlobal("TRT_BlotworxResolved", 1)
  EnableGuardianHint("TRT_Hint_DocTube")
  if (state == "restored") then
    AnimGBSequence("TRT_DocTerminal", "blotSecret")
  else
    AnimGBSequence("TRT_DocTerminal", "graveyardTwo")
  end
  if (GetGlobal("TRT_ShockerDefeated") == 0) then
    Quest_SetCriticalPath("Critical_TT", "Critical_TT_5")
    SetGlobal("TRT_ShockerDefeated", 1)
  end
  wait(0.20000000298023224)
  TRT_Checkpoint(nil, "doc")
  return 
end
TRT_CompleteDocRoom = function(state)
end
TRT_V2BlotAICheck = function()
  if (1 < GetGlobal("TRT_BlotPartsDestroyed")) then
    AI_SetDisabled("TRT_DocBasherV2", false)
    ForEachEntityInGroup(SetTargetTeam, "TRT_DocBasherV2", 2)
    AnimGBSequence("TRT_BlotCage2", "Open", true)
  end
  return 
end
TRT_BlotIntroIGC = function()
  if (GetGlobal("TRT_BlotIntroPlayed") == 0) then
    SetGlobal("TRT_BlotIntroPlayed", 1)
    RestrictCutSceneInput()
    StartFadeOut(0.4000000059604645)
    wait(0.4000000059604645)
    EnableSplitScreen(false)
    GrabCamera("TRT_BlotIntroCam", nil, CAMERA_INSTANT_TRANSITION, 0)
    TeleportToEntity(GetPlayer(), "TRT_BlotIGCMickeyTeleport")
    TeleportToEntity(GetPlayer2OrAI(), "TRT_BlotIGCOswaldTeleport")
    StartFadeIn(0.4000000059604645)
    if (GetGlobal("TRT_DioramaDestroyedDoc") == 0) then
      ForceSequence("TRT_AbeBlot", "TRT_Narrator_BlotOverview")
    else
      TeleportGremlinToEntity("TRT_Gus", "TRT_BlotIntGusTele")
      ForceSequence("TRT_Gus", "TRT_Gus_BlotOverview")
    end
  end
  return 
end
TRT_ReleaseBlotIntroIGC = function()
  FireThread(TeleportGremlinToEntity, "TRT_Gus", "TRT_GusInSpaceMarker")
  StartFadeOut(0.4000000059604645)
  wait(0.4000000059604645)
  GrabCamera("TRT_BlotIntroEndCam", nil, CAMERA_INSTANT_TRANSITION, 0)
  wait(0.10000000149011612)
  ReleaseCamera(CAMERA_SAMEPLACE_TRANSITION, 2)
  EnableSplitScreen(true)
  StartFadeIn(0.4000000059604645)
  UnrestrictCutSceneInput()
  TRT_Checkpoint(nil, "blot")
  return 
end
TRT_ResolveBlotPhoto = function()
  Print("SET Blot PHOTO VARIABLE")
  if (GetGlobal("TRT_DioramaDestroyedBlot") == 0) then
    SetGlobal("MSN_Adelle_BlotVar", 2)
  else
    SetGlobal("MSN_Adelle_BlotVar", 1)
  end
  return 
end
TRT_IncreaseBlotSecurity = function()
  AnimGBSequence("TRT_BlotCage2", "Open", true)
  AnimGBSequence("TRT_BlotCage1", "Open", true)
  DestroyEntity("BlotHackThoughtNode")
  SetGlobal("TRT_BlotSecurity", 1)
  Unhide("TRT_BlotCageLight1")
  Unhide("TRT_BlotCageLight2")
  StartEmitters("TRT_BlotCageLight1")
  StartEmitters("TRT_BlotCageLight1")
  wait(0.5)
  ForEachEntityInGroup(AI_SetDisabled, "BlotCagedSpatter", false)
  ForEachEntityInGroup(SetTargetTeam, "BlotCagedSpatter", 2)
  ForEachEntityInGroup(AI_SetDisabled, "TRT_BlotCagedSpinner", false)
  ForEachEntityInGroup(SetTargetTeam, "TRT_BlotCagedSpinner", 2)
  return 
end
TRT_BlotCheckAIEnable = function()
  if (GetGlobal("TRT_DioramaDestroyedDoc") == 1) then
    ForEachEntityInGroup(AI_SetDisabled, "TRT_BlotCagedSpinner", false)
    ForEachEntityInGroup(SetTargetTeam, "TRT_BlotCagedSpinner", 2)
  end
  return 
end
TRT_ShakeCamera = function()
  ShakeCamera(1.5, 5, 0.75, 0.75, 0.029999999329447746, 0.029999999329447746)
  return 
end
TRT_ShockClouds = function(target, side)
  if (blotDioramaState == 0) then
    if (side == "left") then
      ForEachEntityInGroup(AnimGBSequence, "TRT_CloundExtendPlatformsLeft", "Extend")
      wait(5)
      ForEachEntityInGroup(AnimGBSequence, "TRT_CloundExtendPlatformsLeft", "Retract")
    else
      ForEachEntityInGroup(AnimGBSequence, "TRT_CloundExtendPlatformsLeft", "Extend")
      wait(5)
      ForEachEntityInGroup(AnimGBSequence, "TRT_CloundExtendPlatformsLeft", "Retract")
    end
  end
  return 
end
TRT_SendRailSparks = function()
  ForceSpawn("TRT_RailSparks1", 1)
  wait(0)
  ForceSpawn("TRT_RailSparks2", 1)
  wait(0)
  ForceSpawn("TRT_RailSparks3", 1)
  return 
end
TRT_CheckCloudExtend = function(target)
  if (GetPropertyBool(target, "Is Painted") == true) then
    FireUser2(target)
  end
  return 
end
TRT_SetCartOnSpline = function(target, state)
  if (GetGlobal("TRT_BlotCartMove") == 0) then
    SetGlobal("TRT_BlotCartMove", 1)
    if (state == "restore") then
      SplineFollower_TeleportToKnot("TRT_FlyingBlotCart", "TRT_BlotCartRestoreKnot")
      EnableComponent("TRT_FlyingBlotCart", "SplineFollower")
    else
      SplineFollower_TeleportToKnot("TRT_FlyingBlotCart", "TRT_BlotCartDestroyKnot")
      EnableComponent("TRT_FlyingBlotCart", "SplineFollower")
    end
  end
  return 
end
grabbingGroundBlotTurnstile = false
TRT_GrabGroundBlot = function(target)
  SetRotatorMaxSpeed("TRT_BlotSpring", 360)
  grabbingGroundBlotTurnstile = true
  while true do
    if (not (grabbingGroundBlotTurnstile == true)) then
      break
    end
    local TurnstileDirection = (GetHeading(target) * 57.3248405456543)
    if (TurnstileDirection < 0) then
      TurnstileDirection = ((180 - (TurnstileDirection * -1)) + 180)
    end
    Print(nil, ("Pre-Direction : " .. TurnstileDirection))
    TurnstileDirection = (TurnstileDirection / 6)
    Print(nil, ("The current direction : " .. TurnstileDirection))
    StartRotateToPosition("TRT_BlotSpring", (TurnstileDirection - 60))
    wait(0)
  end
  return 
end
TRT_ReleaseGroundBlot = function()
  grabbingGroundBlotTurnstile = false
  return 
end
RF_PersistGoundBlot = function()
  if (0 < GetGlobal("TRT_BlotGroundState")) then
    DisableComponent("Handle", "Coop Movable Component")
    ForEachEntityInGroup(SetParentEntity, "GroundBlotSparkPipe", "TRT_GroundBlotHandle")
  end
  return 
end
TRT_RestoreGroundBlot = function(target)
  SetGlobal("TRT_BlotGroundState", 1)
  DisableComponent("TRT_GroundBlotHandle", "Coop Movable Component")
  grabbingGroundBlotTurnstile = false
  StopAbility(GetPlayer(), "CoopMove")
  StopAbility(GetPlayer2OrAI(), "CoopMove")
  FireThread(TRT_SetSpringDown)
  SetParentEntity("TRT_GroundBlot", "TRT_GroundBlotHandle")
  AnimGBSequence("TRT_GroundBlotHandle", "poleRetract")
  ForEachEntityInGroup(DestroyEntity, "TRT_GroundBlotSparks")
  DestroyEntity("TRT_Hint_GroundBlot")
  wait(0.75)
  DestroyEntity("TRT_BlotSpring")
  AnimGBSequence("TRT_GroundBlot", "Swipe")
  Disable("TRT_GroundBlotKnockbackTrig")
  StopEmitters("TRT_GroundBlotSteamFX")
  ForEachEntityInGroup(SetParentEntity, "GroundBlotSparkPipe", "TRT_GroundBlotHandle")
  wait(2)
  if (GetGlobal("TRT_BlotFlyingState") == 0) then
    FireSequence("TRT_NarratorMarker", "TRT_Narrator_ShadowPaint1")
  end
  TRT_CheckShadowBlot()
  return 
end
TRT_DestroyGroundBlot = function(target)
  if (GetGlobal("TRT_BlotGroundState") == 0) then
    DisableComponent("TRT_GroundBlotHandle", "Coop Movable Component")
    AnimGBSequence("TRT_GroundBlotHandle", "poleRetract")
    SetGlobal("TRT_BlotGroundState", 2)
    DestroyEntity("TRT_Hint_GroundBlot")
    DestroyEntity("BlotHackThoughtNode")
    FireThread(TRT_FadeDestroyedGroundBlot)
    SetGlobal("TRT_BlotPartsDestroyed", (GetGlobal("TRT_BlotPartsDestroyed") + 1))
    if (GetGlobal("TRT_BlotFlyingState") == 0) then
      SetGlobal("TRT_BlotSecurity", 1)
      TimerReset("TRT_BlotHintTimer")
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_ShadowThin1")
      AnimGBSequence("TRT_BlotCage1", "Open")
      Unhide("TRT_BlotCageLight1")
      Unhide("TRT_BlotCageLight2")
      StartEmitters("TRT_BlotCageLight1")
      AnimGBSequence("TRT_BlotCage2", "Open", true)
      StartEmitters("TRT_BlotCageLight2")
      ForEachEntityInGroup(AI_SetDisabled, "BlotCagedSpatter", false)
      ForEachEntityInGroup(SetTargetTeam, "BlotCagedSpatter", 2)
    end
    TRT_CheckShadowBlot()
  end
  return 
end
TRT_FadeDestroyedGroundBlot = function(target)
  DestroyEntity("TRT_GroundBlotSteamFX")
  wait(3.5)
  DestroyEntity("TRT_GroundBlot")
  return 
end
TRT_GroundBlotSteamJet = function()
  if (GetGlobal("TRT_BlotGroundState") == 0) then
    if (groundSteamOn == 0) then
      groundSteamOn = 1
      Enable("TRT_GroundBlotKnockbackTrig")
      StartEmitters("TRT_GroundBlotSteamFX")
      AudioPostEventOn("TRT_SFX_TowerSteam", "Play_sfx_trt_steam_oneshot_01")
      SetPropertyFloat("TRT_BlotSteamTimer", "TimerInterval", 1)
    else
      groundSteamOn = 0
      Disable("TRT_GroundBlotKnockbackTrig")
      StopEmitters("TRT_GroundBlotSteamFX")
      SetPropertyFloat("TRT_BlotSteamTimer", "TimerInterval", 6)
    end
  end
  return 
end
TRT_GroundBlotSteamStim = function(reg_0)
end
TRT_PersistBlotBox = function()
  if (GetGlobal("TRT_BlotFlyingState") == 1) then
    DisableMotion("TRT_FlyingBlotBox")
    SetPropertyFloat("TRT_BlotMachineHandle", "UsableRadius", 0)
    DisableMotion("TRT_BlotMachineHandle")
    ClearParent("TRT_FlyingBlotCart")
    DisableMotion("TRT_FlyingBlotCart")
    SetParentEntity("TRT_FlyingBlotBox", "TRT_FlyingBlotCart")
    SetParentEntity("TRT_BlotMachineHandle", "TRT_FlyingBlotBox")
    SetPropertyString("TRT_FlyingBlotBox", "Bone Attach Name", "toprope", 0)
  end
  return 
end
TRT_RestoreFlyingBlot = function()
  if (GetGlobal("TRT_BlotFlyingState") == 0) then
    StopAbility(GetPlayer(), "Use")
    StopAbility(GetPlayer2OrAI(), "Use")
    DestroyEntity("TRT_Hint_FlyingBlot")
    DisableMotion("TRT_FlyingBlotBox")
    SetPropertyInt("TRT_FlyingBlotBox", "Collision Layer", 13)
    SetPropertyInt("TRT_BlotMachineHandle", "Collision Layer", 13)
    SetPropertyFloat("TRT_BlotMachineHandle", "UsableRadius", 0)
    DisableMotion("TRT_BlotMachineHandle")
    SetGlobal("TRT_BlotFlyingState", 1)
    ClearParent("TRT_FlyingBlotCart")
    DisableMotion("TRT_FlyingBlotCart")
    SetParentEntity("TRT_FlyingBlotBox", "TRT_FlyingBlotCart")
    SetParentEntity("TRT_BlotMachineHandle", "TRT_FlyingBlotBox")
    wait(0)
    SetPropertyString("TRT_FlyingBlotBox", "Bone Attach Name", "toprope", 0)
    AnimGBSequence("TRT_FlyingBlotCart", "fixedLoad")
    wait(3)
    if (GetGlobal("TRT_BlotGroundState") == 0) then
      TimerReset("TRT_BlotHintTimer")
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_ShadowPaint1")
    end
    FireThread(TRT_CheckShadowBlot)
    SetPropertyInt("TRT_FlyingBlotBox", "Collision Layer", 14)
    SetPropertyInt("TRT_BlotMachineHandle", "Collision Layer", 14)
  end
  return 
end
TRT_DestroyFlyingBlot = function()
  if (GetGlobal("TRT_BlotFlyingState") == 0) then
    StopAbility(GetPlayer(), "Use")
    StopAbility(GetPlayer2OrAI(), "Use")
    DisableMotion("TRT_FlyingBlotBox")
    SetPropertyInt("TRT_FlyingBlotBox", "Collision Layer", 13)
    SetPropertyInt("TRT_BlotMachineHandle", "Collision Layer", 13)
    SetPropertyFloat("TRT_BlotMachineHandle", "UsableRadius", 0)
    DisableMotion("TRT_BlotMachineHandle")
    SetGlobal("TRT_BlotFlyingState", 2)
    ClearParent("TRT_FlyingBlotCart")
    SetParentEntity("TRT_FlyingBlotBox", "TRT_FlyingBlotCart")
    SetParentEntity("TRT_BlotMachineHandle", "TRT_FlyingBlotBox")
    wait(0)
    SetPropertyString("TRT_FlyingBlotBox", "Bone Attach Name", "toprope", 0)
    AnimGBSequence("TRT_FlyingBlotCart", "Break")
    DestroyEntity("TRT_BlotThinnerSprayTrig")
    DestroyEntity("TRT_BlotThinnerSprayFly")
    DestroyEntity("TRT_Hint_FlyingBlot")
    SetGlobal("TRT_BlotPartsDestroyed", (GetGlobal("TRT_BlotPartsDestroyed") + 1))
    if (GetGlobal("TRT_BlotGroundState") == 0) then
      TimerReset("TRT_BlotHintTimer")
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_ShadowThin1")
      AnimGBSequence("TRT_BlotCage1", "Open")
      Unhide("TRT_BlotCageLight1")
      Unhide("TRT_BlotCageLight2")
      StartEmitters("TRT_BlotCageLight1")
      AnimGBSequence("TRT_BlotCage2", "Open", true)
      StartEmitters("TRT_BlotCageLight2")
      ForEachEntityInGroup(AI_SetDisabled, "BlotCagedSpatter", false)
      ForEachEntityInGroup(SetTargetTeam, "BlotCagedSpatter", 2)
    end
    wait(3)
    TRT_CheckShadowBlot()
  end
  return 
end
TRT_CheckShadowBlot = function()
  if (0 < GetGlobal("TRT_BlotFlyingState")) then
    if (0 < GetGlobal("TRT_BlotGroundState")) then
      TRT_RevealBlot()
    end
  else
    TRT_Checkpoint(nil, "blot")
  end
  return 
end
TRT_SetSpringPersistFailsafe = function()
  if (GetGlobal("TRT_BlotGroundState") == 1) then
    FireThread(TRT_SetSpringDown, "reload")
  elseif (GetGlobal("TRT_BlotGroundState") == 2) then
    DisableComponent("TRT_GroundBlotHandle", "Coop Movable Component")
    Hide("TRT_BlotSpring")
    DestroyEntity("TRT_GroundBlot")
  end
  return 
end
TRT_SetSpringDown = function(state)
  DisableComponent("TRT_GroundBlotHandle", "Coop Movable Component")
  SetRotatorMaxSpeed("TRT_GroundBlotHandle", 0)
  SetPropertyInt("TRT_BlotSpring", "Collision Layer", 13)
  SetRotatorMaxSpeed("TRT_BlotSpring", 90)
  StartRotateToPosition("TRT_BlotSpring", -60)
  if (state == "reload") then
    wait(1.2000000476837158)
    SetParentEntity("TRT_GroundBlot", "TRT_GroundBlotHandle")
    wait(0.10000000149011612)
    DestroyEntity("TRT_BlotSpring")
  end
  return 
end
TRT_RevealBlotPersistFailsafe = function()
  if (0 < GetGlobal("TRT_BlotRevealed")) then
    if (GetGlobal("TRT_V1Complete") < 1) then
      FireThread(TRT_SetSpringDown)
      ForEachEntityInGroup(DestroyEntity, "TRT_GroundBlotSparks")
      AnimGBSequence("TRT_GroundBlot", "Down")
      AnimGBSequence("TRT_GroundBlotHandle", "Down")
      AnimGBSequence("TRT_SparksWireSwitch", "handleDown")
      Enable("TRT_ExplodeFastTrig")
      Enable("TRT_DetectFireworksCatapultTrig")
      Unhide("BlotRoomAir")
      FireThread(TRT_ShadowToStormTransition)
    end
  elseif (0 < GetGlobal("TRT_V1Complete")) then
    Firethread(TRT_AutomateBlot)
  end
  return 
end
TRT_BlotCompleteFailsafe = function()
  if (0 < GetGlobal("TRT_BlotStormState")) then
    AnimGBSequence("TRT_BlotRoomDoor", "Open")
    Unhide("BlotRoomAir")
    if (GetGlobal("TRT_TowerComplete") == 1) then
      SetParentEntity("TRT_BlotFirework2", "TRT_BlotTower2")
      SetParentEntity("TRT_BlotFirework3", "TRT_BlotTower3")
      SetParentEntity("TRT_BlotFirework4", "TRT_BlotTower4")
      wait(0.20000000298023224)
      SetRotatorMaxSpeed("TRT_BlotTower2", 180)
      SetRotatorMaxSpeed("TRT_BlotTower4", 180)
      StartRotateToPosition("TRT_BlotTower2", 270)
      StartRotateToPosition("TRT_BlotTower4", 180)
    end
  end
  return 
end
TRT_RevealBlot = function()
  if (GetGlobal("TRT_BlotRevealed") == 0) then
    SetGlobal("TRT_BlotRevealed", 1)
    PauseAllAI()
    DoStinger("IGC_1A_01", 5)
    Print("Blot Reveal music stinger")
    FireUser1("TRT_BlotRevealCam")
    FireThread(TRT_OpenSwitchDoors)
    wait(0)
    wait(0.800000011920929)
    FireThread(Prefab_ClearFireworksFromScene, "BlotFireworks")
    if (GetGlobal("TRT_BlotGroundState") == 2) then
      Hide("TRT_BlotSpring")
    end
    TeleportToEntity(GetPlayer(), "MickeyRevealBlotIGCMarker")
    TeleportToEntity(GetPlayer2OrAI(), "OswaldRevealBlotIGCMarker")
    Enable("TRT_BlotIGCTeleportSafetyTrig")
    TeleportToEntity("BlotSpatterA", "SpatterCrushMarker")
    ForEachEntityInGroup(DestroyEntity, "TRT_GroundBlotSparks")
    wait(2)
    FireThread(StartScriptedIGC)
    wait(1)
    AnimGBSequence("TRT_GroundBlot", "Down")
    AnimGBSequence("TRT_GroundBlotHandle", "Down")
    SetSplineFollowerInitialSpeed("TRT_TowerLeverBase", 3)
    ForEachEntityInGroup(Unhide, "Blot_ShockBlot")
    ActivateNavMeshObstacle("TRT_StormBlotBreakableFloor", true)
    Enable("TRT_ExplodeFastTrig")
    Enable("TRT_DetectFireworksCatapultTrig")
    FireThread(TRT_ShadowToStormTransition)
    TRT_BlotFixedOrDestroyedMusic()
    wait(1)
    AnimGBSequence("TRT_SparksWireSwitch", "handleDown")
    EnableGuardianHint("TRT_Hint_StormBlot")
  end
  return 
end
TRT_OnLoadSwitchDoors = function()
  if (GetGlobal("TRT_BlotStormState") == 0) then
    if (GetGlobal("TRT_BlotRevealed") == 1) then
      AnimGBSequence("TRT_SwitchFloorDoor", "Open")
      wait(0.5)
      Reverse("TRT_PowerSwitchButton")
      Reverse("TRT_SparksWireSwitch")
    end
  end
  return 
end
TRT_OpenSwitchDoors = function()
  wait(11)
  AnimGBSequence("TRT_SwitchFloorDoor", "Open")
  wait(0.5)
  Reverse("TRT_PowerSwitchButton")
  Reverse("TRT_SparksWireSwitch")
  return 
end
TRT_EndBlotReveal = function()
  Disable("TRT_BlotIGCTeleportSafetyTrig")
  UnpauseAllAI()
  FireThread(TRT_Checkpoint, nil, "blot")
  return 
end
TRT_DestroyBlotFace = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    Print("Crossing Streams")
    TRT_DestroyStormBlot()
  end
  return 
end
TRT_OswaldPathAfterStim = function(target, event)
  if (not (not StimulusEvent_HasStimulusType(event, ST_PAINT))) then
    OswaldSetPathAction(target)
  end
  return 
end
TRT_DestroyGroundBlotWithStreams = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    TRT_DestroyGroundBlot()
  end
  return 
end
TRT_ShadowToStormTransition = function()
  blotTransitioning = 1
  blotDioramaState = 1
  ForEachEntityInGroup(AnimGBSequence, "TRT_CloundExtendPlatforms", "Retract")
  AnimGBSequence("TRT_BlotBottle", "Rise")
  wait(1)
  ForEachEntityInGroup(SetPropertyInt, "NoCollideWhenRetracting", "Collision Layer", 13)
  AnimGBSequence("TRT_LeftBlotCorner", "TurnToHand")
  AnimGBSequence("TRT_RightBlotCorner", "TurnToHand")
  AnimGBSequence("TRT_BlotBackdrop", "Raise")
  if (GetGlobal("TRT_BlotStormState") == 2) then
    AnimGBSequence("TRT_StormBlotFace", "outbroken")
  else
    AnimGBSequence("TRT_StormBlotFace", "Out")
  end
  wait(1)
  Enable("trt_dioramas_01a_blot.StormBlotAnvilTrigger")
  ForEachEntityInGroup(AnimGBSequence, "TRT_BlotTowers", "Rise")
  FireThread(TRT_Emit, "TRT_TowerSteamLeft")
  FireThread(TRT_Emit, "TRT_TowerSteamCenter")
  FireThread(TRT_Emit, "TRT_TowerSteamRight")
  ForEachEntityInGroup(AnimGBSequence, "TRT_BlotFloorDoors", "Open")
  AnimGBSequence("TRT_BlotDoor4", "Open")
  ForEachEntityInGroup(AnimGBSequence, "TRT_BlotFireworks", "Drop")
  if (GetGlobal("TRT_BlotStormState") < 2) then
    AnimGBSequence("TRT_LeftBlotCorner", "HandRelease")
    AnimGBSequence("TRT_RightBlotCorner", "HandRelease")
  else
    AnimGBSequence("TRT_LeftBlotCorner", "drop")
    AnimGBSequence("TRT_RightBlotCorner", "drop")
  end
  wait(1)
  AnimGBSequence("TRT_StormBlotBreakableFloor", "Break")
  Unhide("BlotRoomAir")
  AudioPostEventOn("trt_dioramas_01a_blot.Sound_Wind", "Play_sfx_WindCyclone")
  ForEachEntityInGroup(DestroyEntity, "TRT_MidBlotThinnerSpray")
  attackcycle = 1
  wait(2.549999952316284)
  FireThread(TRT_HandAttackCycle, "TRT_LeftBlotCorner")
  wait(0.5)
  DestroyEntity("TRT_StormBlotBreakableFloor")
  FireThread(TRT_HandAttackCycle, "TRT_RightBlotCorner")
  SetParentEntity("TRT_BlotFirework2", "TRT_BlotTower2")
  SetParentEntity("TRT_BlotFirework3", "TRT_BlotTower3")
  SetParentEntity("TRT_BlotFirework4", "TRT_BlotTower4")
  FireThread(TRT_SetTowerLights)
  blotTransitioning = 0
  return 
end
TRT_StormToShadowTransition = function()
  attackcycle = 0
  blotDioramaState = 0
  blotTransitioning = 0
  wait(0.5)
  ForEachEntityInGroup(AnimGBSequence, "TRT_BlotTowers", "Lower")
  ForEachEntityInGroup(AnimGBSequence, "TRT_BlotFireworks", "Raise")
  AnimGBSequence("TRT_LeftBlotCorner", "HandRetract")
  AnimGBSequence("TRT_RightBlotCorner", "HandRetract")
  wait(1)
  ForEachEntityInGroup(AnimGBSequence, "TRT_BlotFloorDoors", "Close")
  AnimGBSequence("TRT_BlotDoor4", "Close")
  AnimGBSequence("TRT_LeftBlotCorner", "TurnToJunk")
  AnimGBSequence("TRT_RightBlotCorner", "TurnToJunk")
  AnimGBSequence("TRT_BlotBackdrop", "Lower")
  ForEachEntityInGroup(SetPropertyInt, "NoCollideWhenRetracting", "Collision Layer", 2)
  if (GetGlobal("TRT_BlotStormState") == 2) then
    AnimGBSequence("TRT_StormBlotFace", "inBroken")
  else
    AnimGBSequence("TRT_StormBlotFace", "In")
  end
  Disable("trt_dioramas_01a_blot.StormBlotAnvilTrigger")
  wait(1)
  AnimGBSequence("TRT_BlotBottle", "Lower")
  blotTransitioning = 0
  ForEachEntityInGroup(FireUser1, "TRT_BlotClouds")
  return 
end
attackcycle = 0
blothandsdown = 0
TRT_HandAttackCycle = function(target)
  if (GetGlobal("TRT_BlotStormState") < 2) then
    while true do
      while true do
        while true do
          if (attackcycle == 1) then
            blothandsdown = 1
            AnimGBSequence(target, "attack", true)
            wait(4)
            blothandsdown = 0
            if (GetGlobal("TRT_BlotStormState") == 2) then
              if (attackcycle == 1) then
                AnimGBSequence("TRT_LeftBlotCorner", "drop")
              end
              wait(0.5)
            end
          end
        end
        AnimGBSequence("TRT_RightBlotCorner", "drop")
      end
      if (attackcycle == 1) then
        AnimGBSequence(target, "attackRest")
      end
      wait(1)
    end
  end
  return 
end
rotateLeft = 0
rotateMid = 1
rotateRight = 1
wireTrackState = 1
wireTrackDegrees = 0
towersTurning = 0
TRT_SetElectricRotation = function(target)
  DisableComponent(target, "Coop Movable Component")
  local TurnstileDirection = (GetHeading(target) * 57.3248405456543)
  Print(TurnstileDirection)
  if (TurnstileDirection < 0) then
    TurnstileDirection = ((180 - (TurnstileDirection * -1)) + 180)
  end
  Print(TurnstileDirection)
  TurnstileDirection = math.floor(TurnstileDirection)
  wait(0)
  SetRotatorMaxSpeed("TRT_SparksWireSwitch", 180)
  if (270 < TurnstileDirection) then
    if (TurnstileDirection <= 330) then
      StartRotateToPosition(target, 0)
      wireTrackState = 0
    end
  elseif (210 < TurnstileDirection) then
    if (TurnstileDirection <= 270) then
      StartRotateToPosition(target, 60)
      wireTrackState = 1
    end
  elseif (150 < TurnstileDirection) then
    if (TurnstileDirection <= 210) then
      StartRotateToPosition(target, 120)
      wireTrackState = 2
    end
  elseif (90 < TurnstileDirection) then
    if (TurnstileDirection <= 150) then
      StartRotateToPosition(target, 180)
      wireTrackState = 3
    end
  elseif (30 < TurnstileDirection) then
    if (TurnstileDirection <= 90) then
      StartRotateToPosition(target, 240)
      wireTrackState = 4
    end
  elseif (TurnstileDirection <= 30) then
    StartRotateToPosition(target, 300)
    wireTrackState = 5
  end
  Print(wireTrackState)
  TRT_TowerPower()
  wait(1)
  SetRotatorMaxSpeed(target, 0)
  StopRotateToPosition("TRT_SparksWireSwitch", 0)
  EnableComponent(target, "Coop Movable Component")
  return 
end
TRT_TowerPower = function()
  if (wireTrackState == 0) then
    rotateLeft = 0
    rotateMid = 1
    rotateRight = 1
  elseif (wireTrackState == 1) then
    rotateLeft = 1
    rotateMid = 0
    rotateRight = 1
  elseif (wireTrackState == 2) then
    rotateLeft = 0
    rotateMid = 1
    rotateRight = 0
  elseif (wireTrackState == 3) then
    rotateLeft = 1
    rotateMid = 0
    rotateRight = 1
  elseif (wireTrackState == 4) then
    rotateLeft = 1
    rotateMid = 1
    rotateRight = 0
  elseif (wireTrackState == 5) then
    rotateLeft = 1
    rotateMid = 1
    rotateRight = 1
  end
  return 
end
TRT_ActivateTowerRotation = function(target, number)
  if (towersTurning == 0) then
    towersTurning = 1
    if (rotateLeft == 1) then
      FireUser1("TRT_TowerSparks1")
    end
    if (rotateMid == 1) then
      FireUser1("TRT_TowerSparks2")
    end
    if (rotateRight == 1) then
      FireUser1("TRT_TowerSparks3")
    end
    wait(1.7999999523162842)
    towersTurning = 0
  end
  return 
end
TRT_SparkTurnsTower = function(target, state)
  if (state == "left") then
    FireThread(TRT_RotateTowerWithFX, target, "1")
  end
  if (state == "mid") then
    FireThread(TRT_RotateTowerWithFX, target, "2")
  end
  if (state == "right") then
    FireThread(TRT_RotateTowerWithFX, target, "3")
  end
  DestroyEntity(target)
  return 
end
TRT_RotateTowerWithFX = function(target, tower)
  if (tower == "1") then
    FireThread(TRT_Emit, "TRT_TowerSteamLeft", "TRT_BlotTowersSparks1")
    wait(0.30000001192092896)
    FireUser1("TRT_BlotTower2")
  elseif (tower == "2") then
    FireThread(TRT_Emit, "TRT_TowerSteamCenter", "TRT_BlotTowersSparks2")
    wait(0.30000001192092896)
    FireUser1("TRT_BlotTower3")
  else
    FireThread(TRT_Emit, "TRT_TowerSteamRight", "TRT_BlotTowersSparks3")
    wait(0.30000001192092896)
    FireUser1("TRT_BlotTower4")
  end
  return 
end
TRT_Emit = function(target, sparks)
  ForEachEntityInGroup(StartEmitters, sparks)
  StartEmitters(target)
  wait(1.2000000476837158)
  ForEachEntityInGroup(StopEmitters, sparks)
  StopEmitters(target)
  return 
end
towerrotate2 = 0
towerrotate3 = 0
towerrotate4 = 0
towerstatus2 = 1
towerstatus3 = 0
towerstatus4 = 2
TRT_RotateTrack = function(target, track)
  if (blotTransitioning == 0) then
    if (blotDioramaState == 1) then
      if (GetGlobal("TRT_TowerComplete") == 0) then
        _G[("towerrotate" .. track)] = (_G[("towerrotate" .. track)] + 90)
        SetRotatorMaxSpeed(target, 90)
        StartRotateToPosition(target, _G[("towerrotate" .. track)])
        _G[("towerstatus" .. track)] = (_G[("towerstatus" .. track)] + 1)
        if (_G[("towerstatus" .. track)] == 4) then
          _G[("towerstatus" .. track)] = 0
        end
        FireThread(TRT_SetTowerLights)
        wait(0.20000000298023224)
        TRT_SolveTowers()
      end
    end
  end
  return 
end
TRT_SetTowerLights = function()
  if (towerstatus2 == 0) then
    AnimGBSequence("TRT_BlotDoor2", "allGreen")
  elseif (towerstatus2 == 1) then
    AnimGBSequence("TRT_BlotDoor2", "green2")
  elseif (towerstatus2 == 2) then
    AnimGBSequence("TRT_BlotDoor2", "green1")
  elseif (towerstatus2 == 3) then
    AnimGBSequence("TRT_BlotDoor2", "green4")
  end
  if (towerstatus3 == 0) then
    AnimGBSequence("TRT_BlotDoor3", "allGreen")
  elseif (towerstatus3 == 1) then
    AnimGBSequence("TRT_BlotDoor3", "green2")
  elseif (towerstatus3 == 2) then
    AnimGBSequence("TRT_BlotDoor3", "green1")
  elseif (towerstatus3 == 3) then
    AnimGBSequence("TRT_BlotDoor3", "green4")
  end
  if (towerstatus4 == 0) then
    AnimGBSequence("TRT_BlotDoor4", "allGreen")
  elseif (towerstatus4 == 1) then
    AnimGBSequence("TRT_BlotDoor4", "green2")
  elseif (towerstatus4 == 2) then
    AnimGBSequence("TRT_BlotDoor4", "green1")
  elseif (towerstatus4 == 3) then
    AnimGBSequence("TRT_BlotDoor4", "green4")
  end
  return 
end
TRT_DebugSolveTowers = function()
  towerstatus2 = 0
  towerstatus3 = 0
  towerstatus4 = 0
  TRT_SolveTowers()
  return 
end
TRT_SolveTowers = function()
  if (towerstatus2 == 0) then
    if (towerstatus3 == 0) then
      if (towerstatus4 == 0) then
        if (GetGlobal("TRT_TowerComplete") == 0) then
          SetGlobal("TRT_TowerComplete", 1)
          if (GetGlobal("TRT_BlotStormState") == 0) then
            SetGlobal("TRT_BlotStormState", 1)
            RestrictCutSceneInput()
            EnableSplitScreen(false)
            SetCameraAttributesForPlayer("TRT_StormBlotFireworksCam", GetPlayer())
            AnimGBSequence("TRT_SparksWireSwitch", "handleUp")
            wait(1)
            ForEachEntityInGroup(AnimGBSequence, "TRT_BlotFireworks", "Fire")
            Reverse("TRT_PowerSwitchButton")
            Reverse("TRT_SparksWireSwitch")
            SetPropertyFloat("TRT_SparksWireSwitch", "UsableRadius", 0)
            SetPropertyFloat("TRT_SparksWireSwitch", "Activate Radius", 0)
            wait(2.5)
            AnimGBSequence("TRT_SwitchFloorDoor", "Close")
            FireThread(TRT_BlotFixedOrDestroyed)
            wait(3)
            Reverse("TRT_TowerLeverBase")
            FireThread(TRT_AutomateBlot)
            wait(2)
            EnableSplitScreen(true)
            ClearAllCameraAttributes(GetPlayer())
            UnrestrictCutSceneInput()
          end
        end
      end
    end
  end
  return 
end
TRT_StartWires = function(target, state)
  AnimGBSequence("TRT_SparksWireSwitch", "lightOn")
  if (state == "1") then
    wireTrackState = 1
    ForEachEntityInGroup(StartEmitters, "TRT_BlotWire1Sparks")
    ForEachEntityInGroup(StartEmitters, "TRT_BlotWire3Sparks")
  elseif (state == "2") then
    wireTrackState = 4
    ForEachEntityInGroup(StartEmitters, "TRT_BlotWire1Sparks")
    ForEachEntityInGroup(StartEmitters, "TRT_BlotWire2Sparks")
  elseif (state == "3") then
    wireTrackState = 5
    ForEachEntityInGroup(StartEmitters, "TRT_BlotWire1Sparks")
    ForEachEntityInGroup(StartEmitters, "TRT_BlotWire2Sparks")
    ForEachEntityInGroup(StartEmitters, "TRT_BlotWire3Sparks")
  elseif (state == "4") then
    wireTrackState = 0
    ForEachEntityInGroup(StartEmitters, "TRT_BlotWire2Sparks")
    ForEachEntityInGroup(StartEmitters, "TRT_BlotWire3Sparks")
  elseif (state == "5") then
    wireTrackState = 3
    ForEachEntityInGroup(StartEmitters, "TRT_BlotWire1Sparks")
    ForEachEntityInGroup(StartEmitters, "TRT_BlotWire3Sparks")
  else
    wireTrackState = 2
    ForEachEntityInGroup(StartEmitters, "TRT_BlotWire2Sparks")
  end
  return 
end
TRT_FireworksCatapult = function(target)
  TeleportToEntity("TRT_FireworkSplineFollower", "BlotFireworks")
  DisableMotion("BlotFireworks")
  wait(0)
  SetParent("BlotFireworks", "TRT_FireworkSplineFollower")
  TeleportToEntity("FireworksCatapultBaseKnot", "TRT_FireworkSplineFollower")
  SetReversed("TRT_FireworkSplineFollower", false)
  SplineFollower_TeleportToKnot("TRT_FireworkSplineFollower", "FireworksCatapultBaseKnot")
  SetSplineFollowerInitialSpeed("TRT_FireworkSplineFollower", 3)
  return 
end
TRT_SplineStatus = function(target, state)
  if (state == "enable") then
    SetSplineFollowerInitialSpeed(target, 8)
  else
    SetSplineFollowerInitialSpeed(target, 0)
  end
  return 
end
TRT_ClearFireworksParent = function(target)
  local fireworks = GetChildEntityByIndex(target, 0)
  EnableMotion("BlotFireworks")
  ClearParent("BlotFireworks")
  return 
end
TRT_DestroyFireworks = function(target, destroy)
  local data = GetPrefabData(target)
  local doors = GetRelativePrefabEntity(target, ".Doors")
  AnimGBSequence(doors, "close")
  data.DispenserActive = "True"
  if (destroy ~= "false") then
    DestroyEntity(target)
  end
  Prefab_FireworksDispenserTriggered(target)
  return 
end
TRT_ExplodingFireworks_Detonate = function(target, event)
  Print("TRT detonate")
  local data = GetPrefabData(target)
  local doors = GetRelativePrefabEntity(target, ".Doors")
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    SetVulnerability(target, ST_ELECTRIC, 0)
    Print("Detonate!")
    if (GetPropertyFloat(target, "ExplodeDelay") == 0) then
      Print("Detonate FACE!")
      AnimGBSequence(doors, "close")
      data.DispenserActive = "True"
      DestroyEntity(target)
      DestroyEntity("TRT_ExplodeFastTrig")
      TRT_DestroyStormBlot()
    else
      Print("Detonate Regularly!!")
      AnimGBSequence(doors, "close")
      data.DispenserActive = "True"
      ExplodingFireworks_Detonate(target, event)
    end
  end
  return 
end
TRT_CheckHandCollapse = function(target, hand)
  if (GetGlobal("TRT_BlotStormState") == 2) then
    if (GetGlobal("TRT_DestroyedBlotHands") == 0) then
      SetGlobal("TRT_DestroyedBlotHands", 1)
      Print("collapse hand")
      if (hand == "left") then
        AnimGBSequence("TRT_LeftBlotCorner", "drop")
        wait(0.5)
        AnimGBSequence("TRT_RightBlotCorner", "drop")
      else
      end
    end
  end
  return 
end
TRT_SetExplodeDelay = function(target)
  SetPropertyFloat(target, "ExplodeDelay", 0)
  return 
end
TRT_StopWireSparks = function()
  ForEachEntityInGroup(StopEmitters, "TRT_BlotWire1Sparks")
  ForEachEntityInGroup(StopEmitters, "TRT_BlotWire2Sparks")
  ForEachEntityInGroup(StopEmitters, "TRT_BlotWire3Sparks")
  AnimGBSequence("TRT_SparksWireSwitch", "lightOff")
  return 
end
TRT_DestroyStormBlot = function()
  SetGlobal("TRT_BlotStormState", 2)
  attackcycle = 0
  AnimGBSequence("TRT_StormBlotFace", "Break")
  wait(1)
  if (blothandsdown == 0) then
    AnimGBSequence("TRT_LeftBlotCorner", "drop")
  end
  DestroyEntity("BlotFaceDestroyedFX")
  SetGlobal("TRT_BlotPartsDestroyed", (GetGlobal("TRT_BlotPartsDestroyed") + 1))
  wait(0.5)
  if (blothandsdown == 0) then
    AnimGBSequence("TRT_RightBlotCorner", "drop")
  end
  TRT_BlotFixedOrDestroyed()
  return 
end
TRT_BlotFixedOrDestroyed = function()
  SetGlobal("TRT_V1Complete", 1)
  GiveCollectible("Challenge_Tryptic_Tracker")
  DestroyEntity("TRT_Hint_StormBlot")
  if (GetGlobal("TRT_BlotPartsDestroyed") < 2) then
    TimerReset("TRT_BlotHintTimer")
    if (GetGlobal("TRT_EndIGCVar") == 0) then
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_BlotOverallRestore")
    end
    ReplaceMusicStateOverride("Exp_L")
    Print("Music Blot Exp_L")
  else
    SetGlobal("TRT_DestroyedDioramas", (GetGlobal("TRT_DestroyedDioramas") + 1))
    SetGlobal("TRT_DioramaDestroyedBlot", 1)
    TimerReset("TRT_BlotHintTimer")
    if (GetGlobal("TRT_EndIGCVar") == 0) then
      FireSequence("TRT_NarratorMarker", "TRT_Narrator_BlotOverallDestroy")
    end
    ReplaceMusicStateOverride("Exp_D")
    Print("Music Blot Exp_D")
  end
  TRT_SetEndTerminalScreen()
  wait(1)
  while true do
    if (not IsAnySequencePlaying()) then
      break
    end
    wait(0.10000000149011612)
  end
  AnimGBSequence("TRT_BlotRoomDoor", "Open")
  TRT_Checkpoint(nil, "blot")
  return 
end
TRT_BlotFixedOrDestroyedMusic = function()
  if (GetGlobal("TRT_V1Complete") == 1) then
    if (GetGlobal("TRT_BlotPartsDestroyed") < 2) then
      ReplaceMusicStateOverride("Exp_L")
      Print("Music Blot Exp_L")
    else
      ReplaceMusicStateOverride("Exp_D")
      Print("Music Blot Exp_D")
      ReplaceMusicStateOverride("Exp_N")
      Print("Music Blot Exp_N")
    end
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Music Blot Exp_N")
  end
  return 
end
TRT_BlotFixedOrDestroyedMusic3D = function()
  if (GetGlobal("TRT_V1Complete") == 1) then
    if (GetGlobal("TRT_BlotPartsDestroyed") < 2) then
      ReplaceMusicStateOverride("Exp_L_3D")
      Print("Music Blot Exp_L_3D")
    else
      ReplaceMusicStateOverride("Exp_D_3D")
      Print("Music  Blot Exp_D_3D")
      ReplaceMusicStateOverride("Exp_N_3D")
      Print("Music  Blot Exp_N_3D")
    end
  else
    ReplaceMusicStateOverride("Exp_N_3D")
    Print("Music  Blot Exp_N_3D")
  end
  return 
end
TRT_AutomateBlot = function()
  TRT_StormToShadowTransition()
  AnimGBSequence("TRT_BlotDoor4", "Open")
  wait(0.5)
  AnimGBSequence("TRT_GroundBlotHandle", "Up")
  if (GetGlobal("TRT_BlotGroundState") == 1) then
    Print("AutomateBlot")
    Enable("TRT_GroundBlotKnockbackTrig")
    StartEmitters("TRT_GroundBlotSteamFX")
    Reverse("TRT_BlotMickey")
    AnimGBSequence("TRT_GroundBlot", "Up")
    wait(2.5)
    Disable("TRT_GroundBlotKnockbackTrig")
    StopEmitters("TRT_GroundBlotSteamFX")
    AnimGBReset("TRT_GroundBlot")
    AnimGBSequence("TRT_GroundBlot", "Swipe")
    Reverse("TRT_BlotMickey")
  else
    wait(1.5)
  end
  wait(1.5)
  AnimGBSequence("TRT_GroundBlot", "Down")
  AnimGBSequence("TRT_GroundBlotHandle", "Down")
  wait(0.5)
  AnimGBSequence("TRT_BlotDoor4", "Close")
  if (GetGlobal("TRT_BlotFlyingState") == 1) then
    AnimGBReset("TRT_FlyingBlotCart")
    AnimGBSequence("TRT_FlyingBlotCart", "fixedLoop")
  end
  wait(4)
  TRT_ShadowToStormTransition()
  wait(6)
  if (GetGlobal("TRT_TowerComplete") == 1) then
    ForEachEntityInGroup(AnimGBSequence, "TRT_BlotFireworks", "Fire")
  end
  wait(6)
  FireThread(TRT_AutomateBlot)
  return 
end
TRT_TransitionRightCorner = function(target, direction)
  if (direction == "outside") then
    SetCameraAttributesForPlayer("trt_dioramas_01a_blot.BlotRightCornerCamOut", _activator())
    ClearCameraAttributesForPlayer("trt_dioramas_01a_blot.BlotRightCornerCamIn", _activator())
    wait(0)
    SetPropertyBool("trt_dioramas_01a_blot.BlotRightCornerCamIn", "InstantTransition", true)
  elseif (direction == "inside") then
    SetCameraAttributesForPlayer("trt_dioramas_01a_blot.BlotRightCornerCamIn", _activator())
    ClearCameraAttributesForPlayer("trt_dioramas_01a_blot.BlotRightCornerCamOut", _activator())
    wait(0)
    SetPropertyBool("trt_dioramas_01a_blot.BlotRightCornerCamIn", "InstantTransition", false)
  end
  return 
end
TRT_TransitionLeftCorner = function(target, direction)
  if (direction == "outside") then
    SetCameraAttributesForPlayer("TT_BlotLeftCornerCamOut", _activator())
    ClearCameraAttributesForPlayer("TT_BlotLeftCornerCamIn", _activator())
    wait(0)
    SetPropertyBool("TT_BlotLeftCornerCamIn", "InstantTransition", true)
  elseif (direction == "inside") then
    SetCameraAttributesForPlayer("TT_BlotLeftCornerCamIn", _activator())
    ClearCameraAttributesForPlayer("TT_BlotLeftCornerCamOut", _activator())
    wait(0)
    SetPropertyBool("TT_BlotLeftCornerCamIn", "InstantTransition", false)
  end
  return 
end
TRT_SetEndTerminalScreen = function()
  if (GetGlobal("TRT_Narrator_BlotOverallDestroy_Played") == 1) then
    AnimGBSequence("TT_BiotDioramaTerminal2", "graveyardTwo")
  else
    AnimGBSequence("TT_BiotDioramaTerminal2", "tunnelSecret")
  end
  if (1 < GetGlobal("TRT_DestroyedDioramas")) then
    AnimGBSequence("TRT_EndIGCTerminal", "error")
  end
  return 
end
TRT_EndTerminalIGCAnimRestored = function()
  AnimGBSequence("TRT_EndIGCTerminal", "docSecret")
  wait(6)
  AnimGBSequence("TRT_EndIGCTerminal", "tunnelSecret")
  return 
end
TRT_EndTerminalIGCAnimDestroyed = function()
  AnimGBSequence("TRT_EndIGCTerminal", "graveyardChest01")
  wait(0.6000000238418579)
  AnimGBSequence("TRT_EndIGCTerminal", "graveyardChest02")
  wait(0.6000000238418579)
  AnimGBSequence("TRT_EndIGCTerminal", "graveyardChest03")
  wait(0.6000000238418579)
  FireThread(TRT_EndTerminalIGCAnimDestroyed)
  return 
end
TRT_EndIGC = function()
  if (GetGlobal("TRT_EndIGCVar") == 0) then
    SetGlobal("TRT_EndIGCVar", 1)
    Quest_SetCriticalPath("Critical_TT", "Critical_TT_7")
    if (GetGlobal("TRT_DestroyedDioramas") < 2) then
      ForEachEntityInGroup(Unhide, "BlotDioramaFullyRestoredGoldPin")
      PlayIGC("IGC_0245a_AbeRestored")
    else
      PlayIGC("IGC_0245b_AbeDestroyed")
    end
  end
  return 
end
TRT_SetupGoldPin = function()
  if (GetGlobal("TRT_DestroyedDioramas") < 2) then
    if (GetGlobal("TRT_EndIGCVar") == 1) then
      ForEachEntityInGroup(Unhide, "BlotDioramaFullyRestoredGoldPin")
      AnimGBSequence("TRT_RewardBlotCage", "Open")
    end
  end
  if (GetGlobal("TRT_EndGoldPin") == 1) then
    DestroyEntity(GetRelativePrefabEntity("BlotDioramaFullyRestoredGoldPin", ".CollectibleEffect"))
    ForEachEntityInGroup(DestroyEntity, "BlotDioramaFullyRestoredGoldPin")
  end
  if (1 < GetGlobal("TRT_DestroyedDioramas")) then
    if (GetGlobal("TRT_EndIGCVar") == 1) then
      TRT_EndTerminalIGCAnimDestroyed()
    end
  end
  return 
end
TRT_HideEndAbe = function()
  if (GetGlobal("TRT_EndIGCVar") == 0) then
    AnimEvent("TRT_AbeBlotOutside", EVENT_Special_2)
  end
  return 
end
TRT_OswaldGapGlide = function()
  QueueBrainEvent(GetOswaldAI(), BRAIN_Glide_Wait_For_Attach, GetPosition("TRT_ProjectorCheckpointReload"))
  return 
end
TRT_DestroyOnV2 = function(target)
  if (visitnum == 2) then
    DestroyEntity(target)
  end
  return 
end
TRT_BunnyCleanup = function()
  FireSequence("TRT_GusMarker", "TRT_Gus_BunnyQuestComplete")
  return 
end
TRT_ClockDamaged = function()
  SetGlobal("TRT_ClockSecurity", 1)
  DestroyEntity("ClockHackHintMarker")
  AnimGBSequence("TRT_ClockHopperCage", "Open")
  Unhide("TRT_ClockCageLight1")
  Unhide("TRT_ClockCageLight2")
  StartEmitters("TRT_ClockCageLight1")
  StartEmitters("TRT_ClockCageLight2")
  AudioPostEventOn("trt_dioramas_01a_clock_fx.TRT_cageLightRaysSpin_01a 02", "Play_sfx_trt_hopper_siren")
  AnimGBSequence("TRT_ClockHopperCage2", "Open", true)
  AudioPostEventOn("trt_dioramas_01a_clock_fx.TRT_cageLightRaysSpin_01a 01", "Play_sfx_trt_hopper_siren")
  wait(0.30000001192092896)
  ForEachEntityInGroup(AI_SetDisabled, "TRT_ClockHopper", false)
  ForEachEntityInGroup(SetTargetTeam, "TRT_ClockHopper", 2)
  if (GetGlobal("EM2_EpisodeCheck") < 3) then
    ForEachEntityInGroup(AI_SetDisabled, "TRT_ClockHopper", false)
    ForEachEntityInGroup(SetTargetTeam, "TRT_ClockHopper", 2)
  else
    ForEachEntityInGroup(AI_SetDisabled, "TRT_ClockV2Spinner", false)
    ForEachEntityInGroup(SetTargetTeam, "TRT_ClockV2Spinner", 2)
  end
  TRT_Checkpoint(nil, "clock")
  return 
end
TRT_DocDamaged = function()
  SetGlobal("TRT_DocSecurity", 1)
  DestroyEntity("DocHackThoughtNode")
  AnimGBSequence("TRT_DocSpinnerCage2", "Open", true)
  Unhide("TRT_DocCageLight2")
  StartEmitters("TRT_DocCageLight2")
  AnimGBSequence("TRT_DocSpinnerCage1", "Open")
  Unhide("TRT_DocCageLight1")
  StartEmitters("TRT_DocCageLight1")
  wait(0.5)
  AI_SetDisabled("TRT_CagedSpinner", false)
  ForEachEntityInGroup(SetTargetTeam, "TRT_CagedSpinner", 2)
  TRT_Checkpoint(nil, "doc")
  return 
end
TRT_PickBlotAlleyLevel = function(target)
  Print("Pick Blot Alley Level")
  if (2 < GetGlobal("EM2_EpisodeCheck")) then
    Print("__BLOT ALLEY SECOND VISIT, FLIPPING VISIT")
    GetPrefabData("MusicLand_Projector_ToTrainTunnels").State_Stream = "NOS_BlotAlley_Main.FromTrainTunnels_V2"
    if (GetGlobal("FTL_Fort_SpatterState") ~= 1) then
      SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
      GetPrefabData("MusicLand_Projector_ToBlotAlley").ActivatedLevels = "nos_blotalley_main.Section4_Visit2_NoIan"
    else
      GetPrefabData("MusicLand_Projector_ToBlotAlley").ActivatedLevels = "nos_blotalley_main.Section4_Visit2_Ian"
    end
  end
  SetupPosition(target)
  return 
end
TRT_SetZoneEnded = function(target)
  SetGlobal("TRT_ExitedZone", 1)
  SetupPosition(target)
  return 
end
TRT_KillAIAndRescuePlayer = function(_activator)
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
  if (_activator == GetPlayer2OrAI()) then
    ClearAllCameraAttributes(GetPlayer2OrAI())
  else
    ClearAllCameraAttributes(GetPlayer())
  end
  return 
end
groundSteamOn = 0
faceBroken = 0
blotDioramaState = 0
blotTransitioning = 0

