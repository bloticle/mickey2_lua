SetupProjector = function(target, _fromSetupPos)
  local data = GetPrefabData(target)
  local SkipSpawningScreen = false
  local Direction = GetGlobal("2dDirection")
  Print(Direction)
  local string_length = string.len(Direction)
  if (string_length == 2) then
    Direction = 0
  end
  Direction = 1
  Print(Direction)
  local SetupProjector_Activate = function()
    if (data.Film_Position ~= "Left") then
    end
    Print((("********PROJECTOR************ - SetupProjector:  " .. data.ActiveSequence) .. "  SkipSpawningScreen = true"))
    SkipSpawningScreen = true
    Hide(GetRelativePrefabEntity(target, ".ProjectorStand"))
    Hide(GetRelativePrefabEntity(target, ".ProjectorScreen"))
    Print((("********PROJECTOR************ - SetupProjector:  " .. data.ActiveSequence) .. "  Unhiding Projector Screen"))
    Unhide(GetRelativePrefabEntity(target, ".ProjectorStand"))
    Unhide(GetRelativePrefabEntity(target, ".ProjectorScreen"))
    if (SkipSpawningScreen == false) then
      Print((("********PROJECTOR************ - SetupProjector:  " .. data.ActiveSequence) .. "  SkipSpawningScreen == false"))
      if (data.ActiveSequence == "None") then
        Prefab_Projector_ChangeState(target, "Deactivate")
      end
      if (data.StartsInactive == "False") then
        Prefab_Projector_ChangeState(target, "Activate")
      elseif (data.StartsInactive == "TrueHidden") then
        Prefab_Projector_ChangeState(target, "Deactive_Hidden")
      end
    end
    return 
  end
  if (_fromSetupPos ~= nil) then
    if (data.Film_Position == "Left") then
      Print((("********PROJECTOR************ - SetupProjector:  " .. data.ActiveSequence) .. " Setting Up from SetupPosition()"))
      SetupProjector_Activate()
      Print(("********PROJECTOR************ - SetupProjector:  " .. data.ActiveSequence))
      if (data.Film_Position == "Left") then
        SetPropertyBool(target, "ForceInvulnerable", true)
        MostRecentCheckpointCallback = "None"
        if (data.StartsInactive == "False") then
          SetInside2DMap(true)
        end
      end
      if (not (not Projector_2D_Checkpoint_Loaded)) then
        if Projector_2D_Checkpoint_Loaded then
          Print(((("********PROJECTOR************ - SetupProjector:  " .. data.ActiveSequence) .. "  Projector_2D_Checkpoint_Loaded == true && Direction = ") .. Direction))
        elseif (tostring(MostRecentCheckpointCallback) == "None") then
          Print((((("********PROJECTOR************ - SetupProjector:  " .. data.ActiveSequence) .. "  MostRecentCheckpointCallback == None && Direction = ") .. Direction) .. " - We must have Hard Loaded"))
        else
          Print((((("********PROJECTOR************ - SetupProjector:  " .. data.ActiveSequence) .. " How did we get in here? Projector_2D_Checkpoint_Loaded ~= true nor does the MostRecentCheckpointCallback: ") .. tostring(MostRecentCheckpointCallback)) .. " == None"))
        end
        local Projector_2D_Checkpoint_Start = false
        if (data.Film_Position ~= "Left") then
        end
        Projector_2D_Checkpoint_Start = true
        Print(("********PROJECTOR************ - SetupProjector:  Projector_2D_Checkpoint_Start = true FOR " .. data.State_Stream))
        data.MapLoad_SetupPosition = "False"
        if (data.ZoneCamOverrideName ~= "None") then
          if (Projector_2D_Checkpoint_Start == true) then
            Print((("********PROJECTOR************ - SetupProjector:  Projector_2D_Checkpoint_Start = true FOR " .. data.State_Stream) .. " So Firing MLPS"))
            data.MapLoad_SetupPosition = "True"
            FireThread(OnMapLoad_ProjectorSetup, target)
          end
        end
      end
      SetupProjector_Activate()
    end
  else
    Print(("********PROJECTOR************ - SetupProjector:  " .. data.ActiveSequence))
    if (data.Film_Position == "Left") then
      SetPropertyBool(target, "ForceInvulnerable", true)
      MostRecentCheckpointCallback = "None"
      if (data.StartsInactive == "False") then
        SetInside2DMap(true)
      end
    end
    if (not (not Projector_2D_Checkpoint_Loaded)) then
      if Projector_2D_Checkpoint_Loaded then
        Print(((("********PROJECTOR************ - SetupProjector:  " .. data.ActiveSequence) .. "  Projector_2D_Checkpoint_Loaded == true && Direction = ") .. Direction))
      elseif (tostring(MostRecentCheckpointCallback) == "None") then
        Print((((("********PROJECTOR************ - SetupProjector:  " .. data.ActiveSequence) .. "  MostRecentCheckpointCallback == None && Direction = ") .. Direction) .. " - We must have Hard Loaded"))
      else
        Print((((("********PROJECTOR************ - SetupProjector:  " .. data.ActiveSequence) .. " How did we get in here? Projector_2D_Checkpoint_Loaded ~= true nor does the MostRecentCheckpointCallback: ") .. tostring(MostRecentCheckpointCallback)) .. " == None"))
      end
      local Projector_2D_Checkpoint_Start = false
      if (data.Film_Position ~= "Left") then
      end
      Projector_2D_Checkpoint_Start = true
      Print(("********PROJECTOR************ - SetupProjector:  Projector_2D_Checkpoint_Start = true FOR " .. data.State_Stream))
      data.MapLoad_SetupPosition = "False"
      if (data.ZoneCamOverrideName ~= "None") then
        if (Projector_2D_Checkpoint_Start == true) then
          Print((("********PROJECTOR************ - SetupProjector:  Projector_2D_Checkpoint_Start = true FOR " .. data.State_Stream) .. " So Firing MLPS"))
          data.MapLoad_SetupPosition = "True"
          FireThread(OnMapLoad_ProjectorSetup, target)
        end
      end
    end
    SetupProjector_Activate()
  end
  return 
end
Prefab_Projector_ChangeState = function(target, state)
  local data = GetPrefabData(target)
  local stand = GetRelativePrefabEntity(target, ".ProjectorStand")
  local screen = GetRelativePrefabEntity(target, ".ProjectorScreen")
  Print(((("********PROJECTOR************ - Prefab_Projector_ChangeState:  " .. data.ActiveSequence) .. "_") .. state))
  if (state == "Activate") then
    if (data.StartsInactive == "TrueHidden") then
      Unhide(stand)
      Unhide(screen)
    end
    data.StartsInactive = "False"
    SetPropertyFloat(screen, "UsableRadius", 3.5)
    AudioPostEventOn(stand, "Play_sfx_projector_portal")
    if (GetPropertyInt(screen, "Active Sequence ID") ~= 4) then
      Print((((("********PROJECTOR************ - Prefab_Projector_ChangeState:  " .. data.ActiveSequence) .. "_") .. state) .. ": We arent playing a To Cinema Loop, so setting to the loop anim"))
      AnimGBSequence(screen, "loop")
    end
  elseif (state == "Deactivate") then
    if (state == "Deactivate") then
      data.StartsInactive = "True"
    elseif (state == "Deactive_Hidden") then
      Hide(stand)
      Hide(screen)
    end
    AnimGBSequence(screen, "idle")
    SetPropertyFloat(screen, "UsableRadius", 0)
    AudioPostEventOn(stand, "Stop_sfx_projector_portal")
  end
  Print((((("********PROJECTOR************ - Prefab_Projector_ChangeState:  " .. data.ActiveSequence) .. "_") .. state) .. " END"))
  return 
end
Prefab_Projector_ChooseTrack = function(target, to_rest)
  local current_pos = GetPropertyInt(target, "Active Sequence ID")
  local anim_num = tonumber(string.sub(GetPropertyString(GetRelativePrefabEntity(target, ".ProjectorStand"), "Sequence Names", current_pos), -1))
  Print(((((("Prefab_Projector_ChooseTrack: current_pos (Sequence ID#) = " .. current_pos) .. " and anim_num = ") .. anim_num) .. " and to_rest = ") .. tostring(to_rest)))
  local data = GetPrefabData(target)
  local screen = GetRelativePrefabEntity(target, ".ProjectorScreen")
  if (data.Film_Position ~= "Left") then
    if (to_rest == nil) then
      SetPropertyBool(target, "ForceInvulnerable", true)
      local play_Anim = true
      if (anim_num == 4) then
        if (data.StartsInactive == "False") then
          if (GetGlobal("EM2_EpisodeCheck") ~= 1) then
            if (data.Film_Position ~= "NoCinema") then
              local screen_anim = GetPropertyInt(screen, "Active Sequence ID")
              if (screen_anim == 4) then
                AnimGBSequence(screen, "turnOffMickey", true)
                anim_num = 0
                Print("Prefab_Projector_ChooseTrack: anim_num = 0")
              else
                Print("Prefab_Projector_ChooseTrack: Conditions Met, Set to Return to Mean Streets")
                AnimGBSequence(screen, "turnOnMickey", true)
                play_Anim = false
                anim_num = 0
                Print("Prefab_Projector_ChooseTrack: anim_num = 0")
              end
            end
          end
        else
          anim_num = 0
          Print("Prefab_Projector_ChooseTrack: anim_num = 0")
        end
      end
      if play_Anim then
        anim_num = (anim_num + 1)
        Print(("Prefab_Projector_ChooseTrack: anim_num = " .. anim_num))
        AnimGBSequence(target, ("pos" .. anim_num), true)
        SetPropertyFloat(screen, "UsableRadius", 0)
      end
    else
      SetPropertyFloat(screen, "UsableRadius", 3.5)
      if (to_rest == "screen") then
        if (GetPropertyInt(target, "Active Sequence ID") == 3) then
          AnimGBSequence(target, "loopMickey")
          SetPropertyBool(GetRelativePrefabEntity(target, ".ProjectorStand"), "ForceInvulnerable", false)
        else
          AnimGBSequence(target, "loop")
          AnimGBSequence(target, ("rest" .. anim_num))
        end
      else
        AnimGBSequence(target, ("rest" .. anim_num))
      end
      Print(("Prefab_Projector_ChooseTrack: RESTED stand anim seq ID = " .. tostring(GetPropertyInt(target, "Active Sequence ID"))))
      SetPropertyBool(target, "ForceInvulnerable", false)
    end
  end
  return 
end
Projector_2D_Checkpoint_Loaded = false
OnMapLoad_ProjectorSetup = function(target)
  local data = GetPrefabData(target)
  local ProjectorMarker = GetRelativePrefabEntity(target, ".ProjectorMarker")
  if (GetGlobal("PlayerFirstTimeInZone") == 1) then
    Print(("********PROJECTOR************ OnMapLoad_ProjectorSetup - Start *** called from ActiveSequence: " .. data.ActiveSequence))
    Print("********PROJECTOR************ OnMapLoad_ProjectorSetup - Hard load auto detection check")
    Print(("********PROJECTOR************ OnMapLoad_ProjectorSetup - data.ExitFunction = " .. tostring(data.ExitFunction)))
    Print(("********PROJECTOR************ OnMapLoad_ProjectorSetup - MostRecentCheckpointCallback = " .. tostring(MostRecentCheckpointCallback)))
    Print(("********PROJECTOR************ OnMapLoad_ProjectorSetup - data.MapLoad_SetupPosition = " .. tostring(data.MapLoad_SetupPosition)))
    if (data.ExitFunction == "None") then
      Print("********PROJECTOR************ OnMapLoad_ProjectorSetup - data.ExitFunction = None so Changing it to Empty to bypass OML_PS() -- This should only be in most 2D")
      data.ExitFunction = "Empty"
    end
    if (data.MapLoad_SetupPosition == "Multiple") then
      while true do
        if (not (data.MapLoad_SetupPosition == "Multiple")) then
          break
        end
        wait(0.20000000298023224)
        Print(("********PROJECTOR************ OnMapLoad_ProjectorSetup - In While Loop  " .. data.ActiveSequence))
      end
    end
    Print(("********PROJECTOR************ OnMapLoad_ProjectorSetup - After While Loop. " .. data.ActiveSequence))
    if (data.MapLoad_SetupPosition ~= "True") then
      if (data.MapLoad_SetupPosition ~= "True_NoSave") then
        if (data.MapLoad_SetupPosition ~= "Multiple") then
          if (data.Film_Position ~= "Left") then
            if (data.Film_Position ~= "Right") then
              return 
            end
          end
        end
      end
    end
    Print("********PROJECTOR************ OnMapLoad_ProjectorSetup - Continuing on!")
    Print(("********PROJECTOR************ Most recent callback: " .. tostring(MostRecentCheckpointCallback)))
    if (tostring(data.ExitFunction) ~= tostring(MostRecentCheckpointCallback)) then
      if (data.MapLoad_SetupPosition == "True") then
        if (GetGlobal("DEC_Hardload") == 0) then
          Print("********PROJECTOR************ OnMapLoad_ProjectorSetup - Hard load detected!")
          Print(("********PROJECTOR************ OnMapLoad_ProjectorSetup - RestrictCutSceneInput *** called from ActiveSequence: " .. data.ActiveSequence))
          HideHud()
          SetGlobal("PlayerFirstTimeInZone", 0)
          data.MapLoad_SetupPosition = "False"
          StartFadeOut(0)
          RestrictCutSceneInput()
          Wait(0)
          Wait(0)
          OswaldStopMovingAction()
          if (data.Film_Position == "None") then
            if (Projector_2D_Checkpoint_Loaded == false) then
              InstantRotateToPosition(ProjectorMarker, data.ProjectorAngle)
            end
            SetVerticalSplit(true)
            if (GetGlobal("2dDirection") == 99) then
              Print("********PROJECTOR************ OnMapLoad_ProjectorSetup - Coming From Cinema so setting Projector to be able to send you directly back to Cinema")
              AnimGBSequence(GetRelativePrefabEntity(target, ".ProjectorScreen"), "loopMickey")
              AnimGBSequence(GetRelativePrefabEntity(target, ".ProjectorStand"), "rest4")
            else
              AnimGBSequence(GetRelativePrefabEntity(target, ".ProjectorScreen"), "loop")
              EnableSplitScreen(true)
              if (data.Film_Position == "Left") then
                if (GetGlobal("2dDirection") == 1) then
                  InstantRotateToPosition(ProjectorMarker, (data.ProjectorAngle - 90))
                end
              elseif (data.Film_Position == "Right") then
                if (GetGlobal("2dDirection") == 0) then
                  InstantRotateToPosition(ProjectorMarker, (data.ProjectorAngle + 90))
                end
              end
              if (data.ZoneCamOverrideName[2] == nil) then
                TeleportToEntity(GetPlayer(), ProjectorMarker)
                TeleportToEntity(GetPlayer2OrAI(), ProjectorMarker)
              end
              if (GetGlobal("2dDirection") == 1) then
                Print("********PROJECTOR************ - OnMapLoad_ProjectorSetup:  2dDirection = 0, so setting it to 12 since this must be a Hard Load")
                SetGlobal("2dDirection", 112)
              end
              Projector_2D_Setup(data, ProjectorMarker, "FromSetup")
            end
          end
          EnableSplitScreen(true)
          if (data.Film_Position == "Left") then
            if (GetGlobal("2dDirection") == 1) then
              InstantRotateToPosition(ProjectorMarker, (data.ProjectorAngle - 90))
            end
          elseif (data.Film_Position == "Right") then
            if (GetGlobal("2dDirection") == 0) then
              InstantRotateToPosition(ProjectorMarker, (data.ProjectorAngle + 90))
            end
          end
          if (data.ZoneCamOverrideName[2] == nil) then
            TeleportToEntity(GetPlayer(), ProjectorMarker)
            TeleportToEntity(GetPlayer2OrAI(), ProjectorMarker)
          end
          if (GetGlobal("2dDirection") == 1) then
            Print("********PROJECTOR************ - OnMapLoad_ProjectorSetup:  2dDirection = 0, so setting it to 12 since this must be a Hard Load")
            SetGlobal("2dDirection", 112)
          end
          Projector_2D_Setup(data, ProjectorMarker, "FromSetup")
          DisableGuardianSystem()
          wait(0)
          FireUser1(ProjectorMarker)
        end
      end
    end
  end
  return 
end
ProjectorInactiveCheck = function(target)
  local playerNum = 1
  if (_activator() == GetPlayer2()) then
    playerNum = 2
  end
  local data = GetPrefabData(target)
  if (data.ActiveSequence == "None") then
    Print("********PROJECTOR************ ProjectorInactiveCheck: data.ActiveSequence == None or data.StartsInactive == True")
  end
  if (data.StartsInactive == "False") then
    Print(("********PROJECTOR************ ProjectorInactiveCheck: data.StartsInactive == False && playerNum = " .. playerNum))
    if (GetPropertyInt(GetRelativePrefabEntity(target, ".ProjectorScreen"), "Active Sequence ID") == 1) then
      FireSequence(GetRelativePrefabEntity(target, ".ProjectorMarker"), data.ActiveSequence, playerNum)
    end
    FireSequence(GetRelativePrefabEntity(target, ".ProjectorMarker"), "Global_Gus_BacktoCinema", playerNum)
  end
  return 
end
Mickey_Projector_Enter_Activated = false
TeleportToMarker_Data_Temp = ""
ActiveSequence_Data_Temp = ""
Mickey_Projector_Enter = function()
  local target = _self()
  local data = GetPrefabData(target)
  TeleportToMarker_Data_Temp = data.TeleportToMarker
  ActiveSequence_Data_Temp = data.ActiveSequence
  Print(("********PROJECTOR************ Mickey_Projector_Enter: Start *** called from ActiveSequence: " .. data.ActiveSequence))
  local camera = GetRelativePrefabEntity(target, ".EnterProjectorCamera")
  local marker = GetRelativePrefabEntity(target, ".ProjectorMarker")
  local stand = GetRelativePrefabEntity(target, ".ProjectorStand")
  local screen = GetRelativePrefabEntity(target, ".ProjectorScreen")
  local _player = GetPlayer()
  local _player2 = GetPlayer2OrAI()
  local Screen_Anim_ID = GetPropertyInt(screen, "Active Sequence ID")
  SetGlobal("OswaldAITeleportCheck", 1)
  Print("OswaldAITeleportCheck set to 1")
  if (data.Film_Position == "Left") then
    ClearNextPatrolNode(GetOswaldAI())
    OswaldStopFollowAction()
    if (data.ZoneCamOverrideName[2] ~= nil) then
      DisableSideScrollConstraint(GetRelativePrefabEntity(data.ZoneCamOverrideName[2], ".Oswald_CameraOverrideTracks"), GetPlayerOrAI(PLAYER_TWO))
    end
  end
  Mickey_Projector_Enter_Activated = true
  MostRecentCheckpointCallback = "None"
  PauseAllAI()
  SetPropertyFloat(screen, "UsableRadius", 0)
  AnimGBSetIdle(camera, false)
  RestrictCutSceneInput()
  StartFadeOut(0.5)
  wait(0)
  wait(0.75)
  _player2 = GetPlayer2OrAI()
  SetDrawSilhouettes(false)
  EnableSplitScreen(false)
  DisableGuardianSystem()
  InstantRotateToPosition(marker, (data.ProjectorAngle + 180))
  OswaldStopMovingAction()
  if (data.Film_Position == "Left") then
    ClearAllCameraAttributes(nil, 0)
  end
  Projector_Setup_AnimationOffsetPositions(_player, _player2, marker)
  Projector_Setup_AnimationOffsetPositions(_player, _player2, marker)
  GrabCameraNif(camera, nil, CAMERA_LERP_TRANSITION, 0)
  Hide(_player)
  Hide(_player2)
  SetPropertyBool(_player, "Invisible", false)
  SetPropertyBool(_player2, "Invisible", false)
  AnimGBReset(camera)
  AnimGBSequence(camera, "camera_projectorIn")
  StartFadeInNoHUD()
  wait(0.009999999776482582)
  _player2 = GetPlayer2OrAI()
  AnimEvent(_player, EVENT_Special_0)
  AnimEvent(_player2, EVENT_Special_0)
  Wait(0.05000000074505806)
  _player2 = GetPlayer2OrAI()
  Unhide(_player)
  Unhide(_player2)
  wait(3)
  AudioPostEventOn(_player, "Stop_All_Sounds")
  if (GetPropertyInt(screen, "Active Sequence ID") ~= 4) then
    AnimGBSequence(screen, "warp")
  end
  wait(0.75)
  StartFadeOut(1)
  SetGlobal("PlayerFirstTimeInZone", 1)
  SetGlobal("DEC_Hardload", false)
  Print((("********PROJECTOR************ Mickey_Projector_Enter: Global 2dDirection = " .. GetGlobal("2dDirection")) .. " Before Reverse2D Check"))
  if (data.Reverse2D == true) then
    SetGlobal("2dDirection", 0)
  else
    SetGlobal("2dDirection", 1)
  end
  Print((("********PROJECTOR************ Mickey_Projector_Enter: Global 2dDirection = " .. GetGlobal("2dDirection")) .. " After Reverse2D Check"))
  if (Screen_Anim_ID == 4) then
    Print("********PROJECTOR************ Mickey_Projector_Enter: Screen_Anim_ID == 0 so setting 2dDirection to 100 and sending us off to Mean Streets")
    SetGlobal("2dDirection", 100)
  elseif (data.Film_Position ~= "Left") then
    if (data.Film_Position ~= "Right") then
      if (data.Film_Position ~= "HardLoad") then
        local currentpos = GetPropertyInt(stand, "Active Sequence ID")
        local MickeyPos = "1"
        local OswaldPos = "2"
        if (currentpos == 2) then
          MickeyPos = "2"
          Print(("********PROJECTOR************ Mickey_Projector_Enter: MickeyPos now set to Track2, since stand anim seq ID is " .. currentpos))
        end
        Print(("********PROJECTOR************ Mickey_Projector_Enter: MickeyPos still set to Track1, since stand anim seq ID is " .. currentpos))
        if (currentpos == 4) then
          OswaldPos = "1"
          Print(("********PROJECTOR************ Mickey_Projector_Enter: OswaldPos now set to Track1, since stand anim seq ID is " .. currentpos))
        end
        Print(("********PROJECTOR************ Mickey_Projector_Enter: OswaldPos still set to Track2, since stand anim seq ID is " .. currentpos))
        SetGlobal("2dDirection", tonumber(((tostring(GetGlobal("2dDirection")) .. MickeyPos) .. OswaldPos)))
        Print(("********PROJECTOR************ Mickey_Projector_Enter: GetGlobal(2dDirection) = " .. GetGlobal("2dDirection")))
      end
    end
  end
  wait(1.25)
  AudioPostEventOn(stand, "Stop_sfx_projector_portal")
  UnpauseAllAI()
  EnableSplitScreen(true)
  wait(0.25)
  if (data.EnterFunction == "None") then
    FireThread(SetupPosition, target)
  elseif (data.EnterFunction ~= "None") then
    FireThread(_G[data.EnterFunction], target)
    Print((("******PROJECTOR WARNING******** Mickey_Projector_Enter: *EnterFunction* is " .. data.EnterFunction) .. ".  SetupPosition(target) MUST be fired in this function. Otherwise Designer Done Goofed. NOTE: You must Pass target."))
  else
    Print(("******PROJECTOR WARNING********: Mickey_Projector_Enter: *EnterFunction* inappropriate value: " .. tostring(data.EnterFunction)))
  end
  AnimGBSetIdle(camera, true)
  ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
  Print(("********PROJECTOR************ Mickey_Projector_Enter: Finish *** called from ActiveSequence: " .. data.ActiveSequence))
  return 
end
SetupPosition = function(target)
  local data = GetPrefabData(target)
  if (Mickey_Projector_Enter_Activated ~= true) then
    data = GetPrefabData(target)
    TeleportToMarker_Data_Temp = data.TeleportToMarker
    ActiveSequence_Data_Temp = data.ActiveSequence
  end
  Print(("********PROJECTOR************ SetupPosition: Start *** called from ActiveSequence: " .. ActiveSequence_Data_Temp))
  Mickey_Projector_Enter_Activated = false
  if (data.Film_Position == "Left") then
    Disable2DSetup()
    if (GetEntity(".Mickey_CameraOverrideTracks") ~= nil) then
      if (GetPrefabData(".Mickey_CameraOverrideTracks").MickeyControls == false) then
        Print("********PROJECTOR************ SetupPosition: calling Prefab_MultiTrack_EnableControls for Mickey")
        Prefab_MultiTrack_EnableControls(".Mickey_CameraOverrideTracks", GetPlayer())
      end
      if (GetPrefabData(".Mickey_CameraOverrideTracks").TossAbilityActive == false) then
        Print("********PROJECTOR************ SetupPosition: calling Prefab_MultiTrack_EnableToss")
        Prefab_MultiTrack_EnableToss(".Mickey_CameraOverrideTracks")
      end
    end
    if (GetEntity(".Oswald_CameraOverrideTracks") ~= nil) then
      if (GetPrefabData(".Oswald_CameraOverrideTracks").OswaldControls == false) then
        Print("********PROJECTOR************ SetupPosition: calling Prefab_MultiTrack_EnableControls for Oswald")
        Prefab_MultiTrack_EnableControls(".Oswald_CameraOverrideTracks", GetPlayerOrAI(PLAYER_TWO))
      end
    end
  end
  OswaldStartMovingAction()
  UnrestrictCutSceneInput()
  if (GetGlobal("2dDirection") == 100) then
    Print((("********PROJECTOR************ SetupPosition: Start *** called from ActiveSequence: " .. ActiveSequence_Data_Temp) .. " - 2dDirection == 100 so sending ya back to Mean Streets. Adios, Pardner!"))
    LoadLevel(GetPlayer(), "MeanStreet_North.Visit_2")
  elseif (data.ActivatedLevels ~= "None") then
    Print(((("********PROJECTOR************ SetupPosition: Start *** called from ActiveSequence: " .. ActiveSequence_Data_Temp) .. " - data.ActivatedLevels ~= None - so LoadLevel Called on") .. data.ActivatedLevels))
    if (data.Film_Position == "Left") then
      Print((("********PROJECTOR************ SetupPosition: Start *** called from ActiveSequence: " .. ActiveSequence_Data_Temp) .. " - We are in a 2D Level, so lets find out where we want to go"))
    end
    Print((("********PROJECTOR************ SetupPosition: Start *** called from ActiveSequence: " .. ActiveSequence_Data_Temp) .. " - We are in a 3D Level, so lets find out where we want to go"))
    LoadLevel(GetPlayer(), data.ActivatedLevels)
  else
    Print((("********PROJECTOR************ SetupPosition: Start *** called from ActiveSequence: " .. ActiveSequence_Data_Temp) .. " - data.ActivatedLevels == None - so Fading Back in quickly."))
    StartFadeIn(0)
  end
  return 
end
Mickey_Projector_Exit = function(target)
  local data = GetPrefabData(target)
  Print(("********PROJECTOR************ Mickey_Projector_Exit: Start *** called from ActiveSequence: " .. tostring(data.ActiveSequence)))
  local camera = GetRelativePrefabEntity(target, ".ExitProjectorCamera")
  local marker = GetRelativePrefabEntity(target, ".ProjectorMarker")
  local stand = GetRelativePrefabEntity(target, ".ProjectorStand")
  local screen = GetRelativePrefabEntity(target, ".ProjectorScreen")
  local _player = GetPlayer()
  local _player2 = GetPlayer2OrAI()
  local mickey_played_exit_anim = false
  if (data.MapLoad_SetupPosition == "IgnoreMe") then
    Print("********PROJECTOR************ Mickey_Projector_Exit: data.MapLoad_SetupPosition = IgnoreMe so we are breaking out of this Exit Function")
    return 
  end
  Mickey_Projector_Enter_Activated = false
  PauseAllAI()
  SetPropertyFloat(screen, "UsableRadius", 0)
  AudioPostEventOn(stand, "Stop_sfx_projector_portal")
  if (data.Film_Position == "Left") then
    Print(("********PROJECTOR************ Mickey_Projector_Exit: 2D *** called from ActiveSequence: " .. tostring(data.ActiveSequence)))
    SetLedgeGrabEnabled(_player, false)
    SetLedgeGrabEnabled(_player2, false)
    SetInside2DMap(true)
  end
  SetInside2DMap(false)
  SetLedgeGrabEnabled(_player, true)
  SetLedgeGrabEnabled(_player2, true)
  if (data.SkipJumpOutAnim == false) then
    Print(("********PROJECTOR************ Mickey_Projector_Exit: 3D *** called from ActiveSequence: " .. tostring(data.ActiveSequence)))
    SetDrawSilhouettes(false)
    AnimGBSetIdle(camera, false)
    EnableSplitScreen(false)
    Hide(_player)
    Hide(_player2)
    StartFadeOut(0)
    Wait(0)
    wait(0.10000000149011612)
    InstantRotateToPosition(marker, data.ProjectorAngle)
    TeleportToEntity(_player, marker)
    TeleportToEntity(GetPlayer2OrAI(), marker)
    GrabCameraNif(camera, nil, CAMERA_LERP_TRANSITION, 0)
    AnimGBReset(camera)
    AnimGBSequence(camera, "camera_projectorOut")
    wait(0)
    AnimGBSetIdle(camera, true)
    wait(0.10000000149011612)
    Unhide(_player)
    Unhide(GetPlayer2OrAI())
    wait(0.10000000149011612)
    Hide(_player)
    Hide(GetPlayer2OrAI())
    Wait(0)
    StartFadeInNoHUD(0.75)
    wait(0.25)
    AnimGBSetIdle(camera, false)
    AnimGBReset(camera)
    AnimEvent(_player, EVENT_Special_1)
    AnimEvent(GetPlayer2OrAI(), EVENT_Special_1)
    Wait(0.05000000074505806)
    Unhide(_player)
    Unhide(GetPlayer2OrAI())
    if (GetPropertyInt(screen, "Active Sequence ID") ~= 4) then
      AnimGBSequence(screen, "warp")
    end
    wait(2)
    StartFadeOut(0.5)
    wait(0.5)
    EnableSplitScreen(true)
  end
  _player2 = GetPlayer2OrAI()
  if (data.Film_Position ~= "Left") then
    if (data.Film_Position ~= "Right") then
      Projector_Setup_AnimationOffsetPositions(_player, _player2, marker)
      FireThread(StationaryCamera_UntilPlayerMoves, target, true, _player)
      FireThread(StationaryCamera_UntilPlayerMoves, target, true, _player2)
      SetDrawSilhouettes(true)
      EnableGuardianSystem()
      if (data.ToFlyThrough == "False") then
        ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
      end
      mickey_played_exit_anim = true
    end
  end
  if (data.State_Stream ~= "None") then
    if (data.State_Stream ~= "Disabled") then
      if (Projector_2D_Checkpoint_Loaded == false) then
        if (data.Film_Position ~= "Left") then
          if (data.Film_Position ~= "Right") then
            Print(("********PROJECTOR************ Mickey_Projector_Exit: StreamZones: " .. tostring(data.State_Stream)))
            StreamZones(nil, data.State_Stream)
            WaitForLevelLoad()
          end
        end
      end
    end
  end
  if (data.Film_Position == "Left") then
    if (data.State_Stream ~= "Disabled") then
      Print("********PROJECTOR************ Mickey_Projector_Exit: Save Function, so Saving in 2D")
      FireThread(Projector_2D_CheckpointSave, marker)
    end
    Print("********PROJECTOR************ Mickey_Projector_Exit: FireUser1 on 2D Level Audio Triggers")
    AudioPostEventOn(_player, "Set_Volume_Enter_2D")
  end
  Print(("********PROJECTOR************ Mickey_Projector_Exit: Saving in 3D: FunctionCall = " .. data.ExitFunction))
  if (GetPropertyString(marker, "EntityGroups", 1) ~= nil) then
    if (data.ToFlyThrough == "False") then
      SaveCheckpoint(_player, data.ExitFunction, GetPropertyString(marker, "EntityGroups", 1))
    end
  end
  SetGlobal("PlayerFirstTimeInZone", 1)
  if (data.ExitFunction ~= "None") then
    if (data.ExitFunction ~= "Empty") then
      Print(("********PROJECTOR************ Mickey_Projector_Exit: ExitFunction: " .. tostring(data.ExitFunction)))
      FireThread(_G[data.ExitFunction], marker)
    end
  end
  wait(0.25)
  if (GetPropertyInt(screen, "Active Sequence ID") ~= 4) then
    if (data.StartsInactive ~= "True") then
      AnimGBSequence(screen, "loop")
    end
  end
  ReleaseCamera(CAMERA_LERP_TRANSITION, 0)
  if (data.ToFlyThrough == "False") then
    if (data.Film_Position == "Left") then
      OswaldStartMovingAction()
    end
    local Cam_Override = GetRelativePrefabEntity(target, ".ProjectorMarker")
    SetPropertyInt(Cam_Override, "SideScrollActive", 1)
    SetPropertyInt(Cam_Override, "HintEntityActive", 2)
    SetCameraAttributesForPlayer(Cam_Override)
    ShowHud()
    wait(0.6000000238418579)
    StartFadeIn(1)
    UnrestrictCutSceneInput()
  else
    local Cam_Override, Cam_Override = GetRelativePrefabEntity(target, ".ProjectorMarker"), target
    Cam_Override = SetPropertyInt
    Cam_Override(Cam_Override, "SideScrollActive", 1)
    Cam_Override = SetPropertyInt
    Cam_Override(Cam_Override, "HintEntityActive", 2)
  end
  EnableMotion_Player(_player)
  EnableMotion_Player(GetPlayer2OrAI())
  AnimGBSetIdle(camera, true)
  UnpauseAllAI()
  wait(2)
  Projector_2D_Checkpoint_Loaded = false
  if (data.StartsInactive == "False") then
    SetPropertyFloat(screen, "UsableRadius", 3.5)
    if (mickey_played_exit_anim == true) then
      AudioPostEventOn(stand, "Play_sfx_projector_portal")
    end
  end
  Print(("********PROJECTOR************ Mickey_Projector_Exit - Finish *** called from ActiveSequence: " .. tostring(data.ActiveSequence)))
  return 
end
Prefab_Projector_SetOnlySideCamera = function(target, noSCUPM)
  local Cam_Override = GetRelativePrefabEntity(target, ".ProjectorMarker")
  SetPropertyInt(Cam_Override, "HintEntityActive", 2)
  SetPropertyInt(Cam_Override, "SideScrollActive", 1)
  SetCameraAttributesForPlayer(Cam_Override)
  if (noSCUPM == nil) then
    FireThread(StationaryCamera_UntilPlayerMoves, nil, true, GetPlayer2OrAI())
    StationaryCamera_UntilPlayerMoves(nil, true, GetPlayer())
  end
  return 
end
Prefab_Projector_CheckActivated = function()
  return Mickey_Projector_Enter_Activated
end
Projector_Setup_AnimationOffsetPositions = function(_player, _player2, TeleportToMarker_Data_Temp, flip_facing, player1_deg, player2_deg, delay)
  local pos = GetPosition(TeleportToMarker_Data_Temp)
  local fac = GetFacing(TeleportToMarker_Data_Temp)
  local set_temp_position = function(player, degrees)
    InstantRotateToPosition(TeleportToMarker_Data_Temp, degrees)
    wait(delay)
    local new_fac = GetFacing(TeleportToMarker_Data_Temp)
    InstantRotateToPosition(TeleportToMarker_Data_Temp, 0)
    wait(delay)
    SetFacing(TeleportToMarker_Data_Temp, vector4(0, 0, 0))
    TeleportToEntity(_player, TeleportToMarker_Data_Temp)
    wait(delay)
    SetTransformation(TeleportToMarker_Data_Temp, vector4(pos.x, pos.y, (pos.z + 1)), vector4(0, 0, 0))
    wait(delay)
    SetParentEntity(TeleportToMarker_Data_Temp, _player)
    SetFacing(_player, new_fac)
    wait(delay)
    ClearParent(TeleportToMarker_Data_Temp)
    wait(delay)
    if (flip_facing == nil) then
      SetFacing(TeleportToMarker_Data_Temp, fac)
    else
      SetFacing(TeleportToMarker_Data_Temp, (-fac))
    end
    TeleportToEntity(player, TeleportToMarker_Data_Temp)
    SetTransformation(TeleportToMarker_Data_Temp, pos, fac)
    return 
  end
  if (player1_deg == nil) then
    player1_deg = 90
  end
  if (player2_deg == nil) then
    player2_deg = -90
  end
  if (delay == nil) then
    delay = 0
  end
  set_temp_position(_player2, player2_deg)
  set_temp_position(_player, player1_deg)
  return 
end
Projector_To_IGC_Cleanup = function(projector, noSCUPM)
  CameraReset()
  if (projector ~= nil) then
    FireThread(Prefab_Projector_SetOnlySideCamera, projector, noSCUPM)
  end
  UnrestrictCutSceneInput()
  return 
end
Projector_2D_Setup = function(data, ProjectorMarker, FromSetup)
  Print(("********PROJECTOR************ Projector_2D_Setup: Set Camera Attributes - " .. ActiveSequence_Data_Temp))
  if (data.ZoneCamOverrideName[2] == nil) then
    Print("if data.ZoneCamOverrideName[2] == nil then")
    if (data.ZoneCamOverrideName == "None") then
      Print("if data.ZoneCamOverrideName == none then")
      SetPropertyEntity(ProjectorMarker, "ControlPointEntity", nil)
      SetPropertyInt(ProjectorMarker, "SideScrollActive", 2)
      SetCameraAttributesForPlayer(ProjectorMarker)
    else
      Print("if data.ZoneCamOverrideName ~= none then")
      local Cam_Override = data.ZoneCamOverrideName
      SetPropertyInt(Cam_Override, "SideScrollActive", 2)
      SetPropertyInt(Cam_Override, "HintEntityActive", 1)
      SetCameraAttributesForPlayer(Cam_Override)
      local Cam_Override, Cam_Override = data.ZoneCamOverrideName[2], SetCameraAttributesForPlayer
      Cam_Override = GetGlobal
      Cam_Override = Cam_Override("2dDirection")
      local global = "2dDirection"
      global = tonumber
      global = global(string.sub(data.TrackMarkers[1], -1))
      local MickeyStart = string.sub(data.TrackMarkers[1], -1)
      MickeyStart = tonumber
      MickeyStart = MickeyStart(string.sub(data.TrackMarkers[2], -1))
      local OswaldStart = string.sub(data.TrackMarkers[2], -1)
      OswaldStart = string
      OswaldStart = OswaldStart.len
      OswaldStart = OswaldStart(data.TrackMarkers[1])
      OswaldStart = (OswaldStart - 1)
      local str_len = data.TrackMarkers[1]
      str_len = string
      str_len = str_len.sub
      str_len = str_len(data.TrackMarkers[1], 1, OswaldStart)
      local marker_string = data.TrackMarkers[1]
      if (FromSetup == nil) then
        marker_string = SetGlobal
        marker_string("2dDirection", tonumber(((tostring(Cam_Override) .. global) .. MickeyStart)))
        marker_string = Print
        marker_string(("********PROJECTOR************ Projector_2D_Setup: GetGlobal(2dDirection) = " .. GetGlobal("2dDirection")))
      else
        marker_string = tonumber
        marker_string = marker_string(string.sub(tostring(Cam_Override), -2, -2))
        global = marker_string
        marker_string = tonumber
        marker_string = marker_string(string.sub(tostring(Cam_Override), -1, -1))
        MickeyStart = marker_string
        marker_string = TeleportToEntity
        marker_string(GetPlayer(), (str_len .. global))
        marker_string = TeleportToEntity
        marker_string(GetPlayer2OrAI(), (str_len .. MickeyStart))
      end
      marker_string = Print
      marker_string((("********PROJECTOR************ Projector_2D_Setup: MickeyStart = " .. str_len) .. global))
      marker_string = Print
      marker_string((("********PROJECTOR************ Projector_2D_Setup: OswaldStart = " .. str_len) .. MickeyStart))
      marker_string = data.TrackMarkers
      marker_string[reg_26] = tostring((str_len .. global))
      marker_string = data.TrackMarkers
      marker_string[str_len] = tostring((str_len .. MickeyStart))
      marker_string = data.ZoneCamOverrideName
      marker_string = marker_string[1]
      if (marker_string == "Multi") then
        marker_string = Print
        marker_string("if data.ZoneCamOverrideName[1] == Multi then")
        marker_string = GetPrefabData
        marker_string = marker_string(Cam_Override)
        local Cam_data = Cam_Override
        Cam_data = (global - 1)
        marker_string.startTrackMickey = Cam_data
        Cam_data = (MickeyStart - 1)
        marker_string.startTrackOswald = Cam_data
        Cam_data = Setup_2DCoopMultiTrack
        Cam_data(Cam_Override)
      else
        marker_string = data.ZoneCamOverrideName
        marker_string = marker_string[1]
        if (marker_string == "Solo") then
          marker_string = GetConfigVariableBool
          marker_string = marker_string("InDemoMode")
          if (marker_string == true) then
            marker_string = TeleportToEntity
            marker_string(GetPlayer(), (str_len .. "2"))
            marker_string = TeleportToEntity
            marker_string(GetPlayer2OrAI(), (str_len .. "1"))
          end
          marker_string = Print
          marker_string("if data.ZoneCamOverrideName[1] == Solo then")
          marker_string = SetCameraAttributesForPlayer
          marker_string(Cam_Override, GetPlayer())
          marker_string = setupConstraint2
          marker_string(GetRelativePrefabEntity(Cam_Override, ".Player2_Override"))
        end
      end
    end
  else
    local Cam_Override, Cam_Override = data.ZoneCamOverrideName[2], ("********PROJECTOR************ Projector_2D_Setup: Set Camera Attributes - " .. ActiveSequence_Data_Temp)
    Cam_Override = GetGlobal
    Cam_Override = Cam_Override("2dDirection")
    local global = "2dDirection"
    global = tonumber
    global = global(string.sub(data.TrackMarkers[1], -1))
    local MickeyStart = string.sub(data.TrackMarkers[1], -1)
    MickeyStart = tonumber
    MickeyStart = MickeyStart(string.sub(data.TrackMarkers[2], -1))
    local OswaldStart = string.sub(data.TrackMarkers[2], -1)
    OswaldStart = string
    OswaldStart = OswaldStart.len
    OswaldStart = OswaldStart(data.TrackMarkers[1])
    OswaldStart = (OswaldStart - 1)
    local str_len = data.TrackMarkers[1]
    str_len = string
    str_len = str_len.sub
    str_len = str_len(data.TrackMarkers[1], 1, OswaldStart)
    local marker_string = data.TrackMarkers[1]
    if (FromSetup == nil) then
      marker_string = SetGlobal
      marker_string("2dDirection", tonumber(((tostring(Cam_Override) .. global) .. MickeyStart)))
      marker_string = Print
      marker_string(("********PROJECTOR************ Projector_2D_Setup: GetGlobal(2dDirection) = " .. GetGlobal("2dDirection")))
    else
      marker_string = tonumber
      marker_string = marker_string(string.sub(tostring(Cam_Override), -2, -2))
      global = marker_string
      marker_string = tonumber
      marker_string = marker_string(string.sub(tostring(Cam_Override), -1, -1))
      MickeyStart = marker_string
      marker_string = TeleportToEntity
      marker_string(GetPlayer(), (str_len .. global))
      marker_string = TeleportToEntity
      marker_string(GetPlayer2OrAI(), (str_len .. MickeyStart))
    end
    marker_string = Print
    marker_string((("********PROJECTOR************ Projector_2D_Setup: MickeyStart = " .. str_len) .. global))
    marker_string = Print
    marker_string((("********PROJECTOR************ Projector_2D_Setup: OswaldStart = " .. str_len) .. MickeyStart))
    marker_string = data.TrackMarkers
    marker_string[reg_26] = tostring((str_len .. global))
    marker_string = data.TrackMarkers
    marker_string[str_len] = tostring((str_len .. MickeyStart))
    marker_string = data.ZoneCamOverrideName
    marker_string = marker_string[1]
    if (marker_string == "Multi") then
      marker_string = Print
      marker_string("if data.ZoneCamOverrideName[1] == Multi then")
      marker_string = GetPrefabData
      marker_string = marker_string(Cam_Override)
      local Cam_data = Cam_Override
      Cam_data = (global - 1)
      marker_string.startTrackMickey = Cam_data
      Cam_data = (MickeyStart - 1)
      marker_string.startTrackOswald = Cam_data
      Cam_data = Setup_2DCoopMultiTrack
      Cam_data(Cam_Override)
    else
      marker_string = data.ZoneCamOverrideName
      marker_string = marker_string[1]
      if (marker_string == "Solo") then
        marker_string = GetConfigVariableBool
        marker_string = marker_string("InDemoMode")
        if (marker_string == true) then
          marker_string = TeleportToEntity
          marker_string(GetPlayer(), (str_len .. "2"))
          marker_string = TeleportToEntity
          marker_string(GetPlayer2OrAI(), (str_len .. "1"))
        end
        marker_string = Print
        marker_string("if data.ZoneCamOverrideName[1] == Solo then")
        marker_string = SetCameraAttributesForPlayer
        marker_string(Cam_Override, GetPlayer())
        marker_string = setupConstraint2
        marker_string(GetRelativePrefabEntity(Cam_Override, ".Player2_Override"))
      end
    end
  end
  Enable2DSetup()
  return 
end
Projector_2D_CheckpointSave = function(target)
  Print(("********PROJECTOR************ Projector_2D_CheckpointSave -=- " .. tostring(target)))
  local data = GetPrefabData(target)
  local pos1 = ""
  local pos2 = ""
  if (data.ZoneCamOverrideName[2] == nil) then
    Print("********PROJECTOR************ Projector_2D_CheckpointSave -- if data.ZoneCamOverrideName[2] == nil then")
    local marker = GetPropertyString(target, "EntityGroups", 1)
    if (marker == nil) then
      local marker00 = GetPropertyString(target, "EntityGroups", 0)
      if (marker00 == ".ProjectorMarker") then
        marker00 = "the correct Teleport to Name"
      end
      Print(("********PROJECTOR WARNING************ Projector_2D_CheckpointSave -- No Valid Entity Group Defined in Entity Groups [01]!! THIS IS BAD! Reset your Entity Group so [00] is .ProjectorMarker and [01] is " .. marker00))
    end
    pos1 = marker
    pos2 = marker
  else
    Print("********PROJECTOR************ Projector_2D_CheckpointSave -- if data.ZoneCamOverrideName[2] ~= nil then")
    pos1 = data.TrackMarkers[1]
    pos2 = data.TrackMarkers[2]
  end
  if (GetConfigVariableBool("InDemoMode") == true) then
    pos1 = "Track2"
    pos2 = "Track1"
  end
  SetGlobal("OswaldAITeleportCheck", 0)
  Print("OswaldAITeleportCheck set to 0")
  SaveCheckpoint(target, "Projector_2D_LoadCheckpoint", pos1, pos2)
  return 
end
Projector_2D_LoadCheckpoint = function()
  Print("********PROJECTOR************ Projector_2D_LoadCheckpoint")
  StartFadeOut(0)
  SetGlobal("PlayerFirstTimeInZone", 1)
  Projector_2D_Checkpoint_Loaded = true
  return 
end
Costume_UnhideCheck = function(self)
  if (GetCurrentCostumeName(GetPlayer()) == "Steamboat_Willie") then
    Unhide(self)
  end
  return 
end

