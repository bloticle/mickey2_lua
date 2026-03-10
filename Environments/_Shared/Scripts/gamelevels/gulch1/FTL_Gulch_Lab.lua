FTL_Gulch_LabSetup = function(fromProjector)
  Print("^^^^^^^^^^^^^^^^^^^^^^^ FTL_Gulch_LabSetup")
  if IsValidHandle("Trigger_Visit_Setup") then
    DestroyEntity("Trigger_Visit_Setup")
  end
  if (GetGlobal("FTL_Gulch_Ball01State") == 0) then
    SetGlobal("FTL_Gulch_Ball01State", 3)
    SetGlobal("FTL_Gulch_Ball02State", 3)
    SetGlobal("FTL_Gulch_Ball03State", 3)
    SetGlobal("FTL_Gulch_TrainCart1State", 2)
    SetGlobal("FTL_Gulch_TrainCart2State", 3)
    SetGlobal("FTL_Gulch_TrainCart3State", 1)
    SetGlobal("FTL_Gulch_TrainCart4State", 0)
  end
  local var_balls = GetGlobal("FTL_Gulch_DepositedBalls")
  if (var_balls == 0) then
    Quest_SetCriticalPath("Critical_Gulch1", "Critical_Gulch1_5")
  end
  local Numof_CartSphere = nil
  for i = 1, 3 do
    Numof_CartSphere = GetGlobal((("FTL_Gulch_TrainCart" .. i) .. "State"))
    if (Numof_CartSphere ~= 0) then
      if (GetGlobal((("FTL_Gulch_Ball0" .. Numof_CartSphere) .. "State")) == 3) then
        var_balls = (var_balls + 1)
      end
    end
  end
  local SphereSetup = {0, 0, 0}
  for SphereSetup = 1, 4 do
    x = "State"
    local Numof_CartSphere = GetGlobal((("FTL_Gulch_TrainCart" .. SphereSetup) .. x))
    x = SphereSetup
    Numof_CartSphere = "State: "
    Print(((("FTL_Gulch_TrainCart" .. x) .. Numof_CartSphere) .. tostring(Numof_CartSphere)))
    local SphereGlobal, SphereGlobal = 0, tostring(Numof_CartSphere)
    if (Numof_CartSphere ~= 0) then
      if (SphereSetup < 4) then
        x = "FTL_Gulch_Ball0"
        Numof_CartSphere = Numof_CartSphere
        SphereGlobal = "State"
        x = ((x .. Numof_CartSphere) .. SphereGlobal)
        SphereGlobal = GetGlobal(x)
      end
    elseif (SphereSetup == 4) then
      SphereGlobal = Numof_CartSphere
      if (SphereGlobal == -1) then
        x = Hide
        Numof_CartSphere = "RedChest_Caboose"
        ForEachEntityInPrefab(x, Numof_CartSphere)
      end
    end
    if (SphereGlobal == -1) then
      x = Hide
      Numof_CartSphere = "TrainCar0"
      SphereGlobal = SphereSetup
      Numof_CartSphere = (Numof_CartSphere .. SphereGlobal)
      ForEachEntityInGroup(x, Numof_CartSphere)
    end
    if (SphereGlobal == 3) then
      if (SphereSetup < 4) then
        x = "TrainBall"
        Numof_CartSphere = Numof_CartSphere
        x = (x .. Numof_CartSphere)
        Numof_CartSphere = "TrainCar0"
        SphereGlobal = SphereSetup
        Numof_CartSphere = ((Numof_CartSphere .. SphereGlobal) .. "BallMarker")
        MoveToEntity(x, Numof_CartSphere)
        x = "Moving TrainBall"
        Numof_CartSphere = Numof_CartSphere
        SphereGlobal = " to TrainCar0"
        x = ((((x .. Numof_CartSphere) .. SphereGlobal) .. SphereSetup) .. " BallMarker")
        Print(x)
        SphereSetup[Numof_CartSphere] = 1
        x = Unhide
        Numof_CartSphere = "TrainCar0"
        SphereGlobal = SphereSetup
        Numof_CartSphere = (Numof_CartSphere .. SphereGlobal)
        ForEachEntityInGroup(x, Numof_CartSphere)
      end
    end
  end
  for SphereSetup = 1, 3 do
    if (SphereSetup[SphereSetup] == 0) then
      Hide(("TrainBall" .. SphereSetup))
    else
      Unhide(("TrainBall" .. SphereSetup))
    end
  end
  FireThread(FTL_Gulch_Lab_RandomDust)
  if (GetGlobal("Global_Gus_ProjectorTutorial_Played") == 1) then
    ForEachEntityInGroup(DestroyEntity, "TriggerLookAt_SeeProjector")
  elseif (GetPropertyInt("FTL_JimCricketHead", "Active Sequence ID") == 1) then
    SphereSetup = true
    SetPropertyBool("ftl_gulch_01c.TriggerLookAt_SeeProjector", "Look At Trigger Enabled", SphereSetup)
  end
  SetActiveFullMap("ftl_gulch_01c_shared.MapVolume 01")
  if (fromProjector == nil) then
    SetActiveSubMap("ftl_gulch_01c_shared.MapVolume 02")
  else
    SetGlobal("FTL_Gulch_ScurvyPin_Given", 0)
    SetActiveSubMap("ftl_gulch_01c_shared.MapVolume 03")
  end
  SphereSetup = Quest_Discovered
  if Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_2b", SphereSetup) then
    Print("FTL_Gulch_LabSetup: Enabling Memories Train Quest Photo Marker")
    SetMapMarkerVisible("PM_Photo_Train", true)
    Enable("PM_Photo_Train")
  end
  SphereSetup = "EM2_EpisodeCheck"
  Print(("GetGlobal('EM2_EpisodeCheck') = " .. GetGlobal(SphereSetup)))
  if (1 < GetGlobal("EM2_EpisodeCheck")) then
    local piratesLoaded = 0
    local Parrotless_Steve_Pin = GetCurrentCount("Parrotless_Steve")
    SphereSetup = "Dandy_Evan"
    local Parrotless_Evan_Pin = GetCurrentCount(SphereSetup)
    SphereSetup = GetCurrentCount
    SphereSetup = SphereSetup("Slouchin_Brian")
    local Parrotless_Bill_Pin = GetCurrentCount("Black_Bill")
    if (GetGlobal("MSS_Horace_EliminateJones_Played") == 1) then
      if (Parrotless_Steve_Pin == 0) then
        LevelManager_SetZoneStatusActive("FTL_Gulch.Q_Lab_Horace")
        Print("FTL_Gulch_LabSetup: Enabling Memories Train Quest Photo Marker")
        SetMapMarkerVisible("MapMarker_Horace_ScurvyPat", true)
        piratesLoaded = (piratesLoaded + 1)
        local MovePat = function()
          while true do
            if (not (LevelManager_HasZoneFinishedStreaming("FTL_Gulch.Q_Lab_Horace") == false)) then
              break
            end
            wait(0.20000000298023224)
          end
          while true do
            if (not (LevelManager_WaitingForStreamingSync() == false)) then
              break
            end
            Wait(0.05000000074505806)
          end
          if (Parrotless_Evan_Pin == 0) then
            if (Parrotless_Brian_Pin == 0) then
              if (Parrotless_Bill_Pin == 0) then
                Print("FTL_Gulch_LabSetup: Player Doesnt have Bill Pin, doing nothing")
                return 
              end
              Print("FTL_Gulch_LabSetup: Player Doesnt have Brian Pin, but has Bill Pin: Moving to Location 2")
              MoveToEntity("ScurvyPat", "PM_Scurvy_Pin2")
              MoveToEntity("MapMarker_Horace_ScurvyPat", "PM_Scurvy_Pin2")
              return 
            end
            Print("FTL_Gulch_LabSetup: Player Doesnt have Evan Pin, but has Brian Pin: Moving to Location 3")
            MoveToEntity("ScurvyPat", "PM_Scurvy_Pin3")
            MoveToEntity("MapMarker_Horace_ScurvyPat", "PM_Scurvy_Pin3")
            return 
          end
          Print("FTL_Gulch_LabSetup: Player Doesnt have Brian Pin, but has Evan Pin: Moving to Location 4")
          MoveToEntity("ScurvyPat", "PM_Scurvy_Pin4")
          MoveToEntity("MapMarker_Horace_ScurvyPat", "PM_Scurvy_Pin4")
          return 
        end
        FireThread(MovePat)
      end
    else
      LevelManager_SetZoneStatusUnloaded("FTL_Gulch.Q_Lab_Horace")
    end
    local BlotworxCheck = true
    if (GetGlobal("OST_Moody_Photo5") == 10) then
      if (GetGlobal("FTL_Greene_Rescued_Played") == 0) then
        LevelManager_SetZoneStatusActive("FTL_Gulch.Q_Lab_Memories_GreenSolo")
        Print("FTL_Gulch_LabSetup: Enabling Memories Map Marker for Greene Solo")
        SetMapMarkerVisible("MapMarker_Memories_GreeneSolo", true)
        WaitForLevelLoad()
        BlotworxCheck = false
        Print("BlotworxCheck == false")
        local spatter = 1
        local spawner = "Spawner_GreeneSpatters"
        local spatter_global = GetGlobal("FTL_Gulch_GreeneSpatters")
        local marker = "none"
        if (spatter_global ~= 0) then
          for i = 1, spatter_global do
            piratesLoaded = Print
            Parrotless_Steve_Pin = "Spawning Spatter "
            Parrotless_Evan_Pin = i
            Parrotless_Steve_Pin = (Parrotless_Steve_Pin .. Parrotless_Evan_Pin)
            piratesLoaded(Parrotless_Steve_Pin)
            piratesLoaded = "PN_GreeneSpatter 0"
            Parrotless_Steve_Pin = i
            marker = (piratesLoaded .. Parrotless_Steve_Pin)
            piratesLoaded = SetPropertyEntity
            Parrotless_Steve_Pin = spawner
            Parrotless_Evan_Pin = "Spawn Destinations"
            Parrotless_Brian_Pin = marker
            Parrotless_Bill_Pin = 0
            piratesLoaded(Parrotless_Steve_Pin, Parrotless_Evan_Pin, Parrotless_Brian_Pin, Parrotless_Bill_Pin)
            piratesLoaded = ForceSpawn
            Parrotless_Steve_Pin = spawner
            Parrotless_Evan_Pin = 1
            piratesLoaded = piratesLoaded(Parrotless_Steve_Pin, Parrotless_Evan_Pin)
            spatter = piratesLoaded[1]
            piratesLoaded = DisableMotion
            Parrotless_Steve_Pin = spatter
            piratesLoaded(Parrotless_Steve_Pin)
            piratesLoaded = SetPropertyString
            Parrotless_Steve_Pin = spatter
            Parrotless_Evan_Pin = "Spawn Group"
            Parrotless_Brian_Pin = marker
            Parrotless_Bill_Pin = 0
            piratesLoaded(Parrotless_Steve_Pin, Parrotless_Evan_Pin, Parrotless_Brian_Pin, Parrotless_Bill_Pin)
            piratesLoaded = wait
            Parrotless_Steve_Pin = 0.10000000149011612
            piratesLoaded(Parrotless_Steve_Pin)
          end
        end
      end
    else
      LevelManager_SetZoneStatusUnloaded("FTL_Gulch.Q_Lab_Memories_GreenSolo")
    end
    if (GetGlobal("FTL_Gulch_Greene_Intro_Played") == 0) then
      if (GetGlobal("OST_Moody_Destination") == 2) then
        Print("FTL_Gulch_LabSetup: Enabling Memories Train Quest Photo Marker")
        LevelManager_SetZoneStatusActive("FTL_Gulch.Q_Lab_Memories")
        SetMapMarkerVisible("MapMarker_Memories_GreeneMoody", true)
        piratesLoaded = (piratesLoaded + 1)
      end
    else
      LevelManager_SetZoneStatusUnloaded("FTL_Gulch.Q_Lab_Memories")
    end
    if (BlotworxCheck == true) then
      Print("BlotworxCheck == true")
      if (GetGlobal("FTL_Gulch_DepositedBalls") == 3) then
        if (Parrotless_Steve_Pin ~= 0) then
          LevelManager_SetZoneStatusActive("FTL_Gulch.Lab_AI_v2_BlotworxM")
          LevelManager_SetZoneStatusActive("FTL_Gulch.ASL_AI_BlotworxM_Shared")
        end
        LevelManager_SetZoneStatusUnloaded("FTL_Gulch.Lab_AI_v2_BlotworxR")
        LevelManager_SetZoneStatusUnloaded("FTL_Gulch.ASL_AI_BlotworxR_Shared")
        LevelManager_SetZoneStatusUnloaded("FTL_Gulch.Lab_AI_v2_Sweeper")
        LevelManager_SetZoneStatusUnloaded("FTL_Gulch.ASL_AI_Sweepers")
      else
        LevelManager_SetZoneStatusActive("FTL_Gulch.Lab_AI_v2_BlotworxM")
        LevelManager_SetZoneStatusActive("FTL_Gulch.ASL_AI_BlotworxM_Shared")
        if (Parrotless_Steve_Pin == 0) then
          if (Parrotless_Evan_Pin == 1) then
            Print("FTL_Gulch_LabSetup: Moving Blocker to Pats location")
            local MoveBlocker = function()
              while true do
                if (not (LevelManager_HasZoneFinishedStreaming("FTL_Gulch.Lab_AI_v2_BlotworxM") == false)) then
                  break
                end
                wait(0.20000000298023224)
              end
              while true do
                if (not (LevelManager_WaitingForStreamingSync() == false)) then
                  break
                end
                Wait(0.05000000074505806)
              end
              MoveToEntity("v2_Blocker", "PM_PatLoc1")
              return 
            end
            FireThread(MoveBlocker)
          end
        elseif (piratesLoaded ~= 2) then
          LevelManager_SetZoneStatusActive("FTL_Gulch.Lab_AI_v2_BlotworxR")
          LevelManager_SetZoneStatusActive("FTL_Gulch.ASL_AI_BlotworxR_Shared")
        end
        LevelManager_SetZoneStatusActive("FTL_Gulch.Lab_AI_v2_Sweeper")
        LevelManager_SetZoneStatusActive("FTL_Gulch.ASL_AI_Sweepers")
        if (SphereSetup == 0) then
          if (Parrotless_Bill_Pin == 1) then
            Print("FTL_Gulch_LabSetup: Moving Sweeper to Pats location")
            local MoveSweeper = function()
              while true do
                if (not (LevelManager_HasZoneFinishedStreaming("FTL_Gulch.Lab_AI_v2_Sweeper") == false)) then
                  break
                end
                wait(0.20000000298023224)
              end
              while true do
                if (not (LevelManager_WaitingForStreamingSync() == false)) then
                  break
                end
                Wait(0.05000000074505806)
              end
              MoveToEntity("v2_Sweeper", "PM_PatLoc1")
              return 
            end
            FireThread(MoveSweeper)
          end
        end
      end
    end
  end
  MusicPostEventOn("ftl_gulch_01c_audio.Sound_Marker_Music_Lab_TrainPA", "Play_MX_DG1_Lab")
  RemoveAllMusicStateOverride()
  SetCombatIntensityBias(-100)
  Print("Started Lab music event")
  FTL_BallReceptorDetection("Setup")
  return 
end
FTL_Gulch_Lab_Intro_SCUPM = function()
  FireThread(StationaryCamera_UntilPlayerMoves, nil, nil, GetPlayer2OrAI())
  StationaryCamera_UntilPlayerMoves()
  SetTargetTeam("FTL_Gulch_Herbie", 2)
  return 
end
FTL_Gulch_FromLab_Setup = function(target)
  LevelManager_SetCurrentState("FTL_Gulch.Lab_v2")
  SetupPosition(target)
  return 
end
FTL_BallReceptorDetection = function(state, ...)
  Print("FTL_BallReceptorDetection")
  if (state == "Setup") then
    Print("FTL_BallReceptorDetection: Initial Setup")
    local var_balls = GetGlobal("FTL_Gulch_DepositedBalls")
    local initial_var_balls = var_balls
    local Numof_CartSphere = nil
    local SphereSetup = {0, 0, 0}
    for i = 1, 3 do
      Numof_CartSphere = GetGlobal((("FTL_Gulch_TrainCart" .. i) .. "State"))
      if (Numof_CartSphere ~= 0) then
        if (GetGlobal((("FTL_Gulch_Ball0" .. Numof_CartSphere) .. "State")) == 3) then
          var_balls = (var_balls + 1)
          SphereSetup[i] = 1
          SetGlobal((("FTL_Gulch_Ball0" .. Numof_CartSphere) .. "State"), 4)
          SetGlobal("DG_QuestHealth", (GetGlobal("DG_QuestHealth") + 5))
        else
          Hide(("TrainBall" .. Numof_CartSphere))
        end
      end
    end
    SetGlobal("FTL_Gulch_DepositedBalls", var_balls)
    if (GetGlobal("FTL_Gulch_DepositedBalls") ~= initial_var_balls) then
      FireThread(FTL_BallReceptorDetection, "Intro", SphereSetup, initial_var_balls)
    else
      FTL_BallReceptorDetection(nil, initial_var_balls)
      if (state == "Intro") then
        Print("FTL_BallReceptorDetection: Intro")
        wait(0)
        CameraReset()
        wait(0)
        FireUser1("BridgeLookCamera")
        AddMusicStateOverride("IGC_1A_01")
        Print("Playing Lab Intro IGC music")
        local RemoveSpheres = function(x)
          Print(("RemoveSpheres: TrainCart" .. x))
          local Numof_CartSphere = ("TrainBall" .. GetGlobal((("FTL_Gulch_TrainCart" .. x) .. "State")))
          SetGlobal((("FTL_Gulch_TrainCart" .. x) .. "State"), 0)
          AnimGBSequence(("FTL_ballDispenser_0" .. x), "restLoaded")
          SetParentEntity(Numof_CartSphere, ("FTL_ballDispenser_0" .. x))
          SetPropertyString(Numof_CartSphere, "Bone Attach Name", "bone", 0)
          wait(0.5)
          AnimGBSequence(("FTL_ballDispenser_0" .. x), "unload", true)
          wait(0.550000011920929)
          AudioPostEventOn(GetPlayer(), "Play_SphereSuckedUp")
          return 
        end
        local TrainCart4State = GetGlobal("FTL_Gulch_TrainCart4State")
        if (GetGlobal("FTL_Gulch_DepositedBalls") == 3) then
          if (TrainCart4State == 1) then
            local adjust_offset = function()
              wait(1.899999976158142)
              SetPropertyVector("RedChest_Caboose", "Bone Attach Offset", vector4(0, 0.6000000238418579, 0.8999999761581421), 0)
              return 
            end
            AnimGBSequence("TrainCar04_Caboose", "unload")
            FireThread(adjust_offset)
            SetGlobal("FTL_Gulch_TrainCart4State", 3)
          end
        end
        local args = {}
        FireThread(FTL_BallReceptorDetection, nil, args[2], "FromIGC")
        local SphereSetup = args[1]
        for x = 3, 1, -1 do
          RemoveSpheres = SphereSetup[x]
          if (RemoveSpheres == 1) then
            RemoveSpheres = FireThread
            TrainCart4State = RemoveSpheres
            RemoveSpheres(TrainCart4State, x)
            RemoveSpheres = wait
            TrainCart4State = 0.6600000262260437
            RemoveSpheres(TrainCart4State)
          end
        end
      else
        Print("FTL_BallReceptorDetection: Start Bridge")
        local args = {}
        Print(("#args = " .. (#args)))
        for i = 1, (#args) do
          Print(((("args[" .. i) .. "] = ") .. tostring(args[i])))
        end
        local initial_var_balls = args[1]
        local var_balls = GetGlobal("FTL_Gulch_DepositedBalls")
        local fromIGC = false
        if (args[2] ~= nil) then
          fromIGC = true
        end
        if (GetGlobal("FTL_Gulch_TrainCart4State") == 3) then
          GetPrefabData("RedChest_Caboose").ChestDisabled = "False"
          SetPropertyBool("RedChest_Caboose", "Is Real", false)
          if (fromIGC == false) then
            SetPropertyVector("RedChest_Caboose", "Bone Attach Offset", vector4(0, 0.6000000238418579, 0.8999999761581421), 0)
          end
        end
        Print(("FTL_BallReceptorDetection: var_balls = " .. var_balls))
        if fromIGC then
          wait(1)
        end
        if (var_balls ~= 1) then
          var_IntermitSpray = 0
          ForEachEntityInGroup(SetPropertyInt, "FTL_BridgeSpray_Thinner", "StimulusTypeList", 1, 0)
          ForEachEntityInGroup(SetPropertyFloat, "FTL_BridgeSpray_Thinner", "StimulusPerSecondList", 0, 0)
          ForEachEntityInGroup(SetPropertyInt, "FTL_BridgeSpray_Thinner", "StimulusTypeList", 1, 1)
          AnimGBSequence("FTL_BridgeThinnerFX", "PaintFlow_NoParticles")
        end
        Print(("FTL_BallReceptorDetection: initial_var_balls = " .. initial_var_balls))
        if (initial_var_balls == 0) then
          wait(4)
          FTL_ChangeBridgeState("activate", 1)
          FireSequence("Gus", "FTL_BridgeStarted")
          Hide("FTL_SpiderCollision_Open")
          Unhide("FTL_SpiderCollision_Closed")
          wait(2)
          if (var_balls ~= 3) then
            FireThread(FTL_Gulch_SpiderDoorOpen_Cam, 2)
          end
          wait(1)
        end
        if (var_balls == 3) then
          Enable("LookAt_HDC_MagPaint")
          Disable("LookAt_HDC_MagThinner")
          FireThread(FTL_Gulch_SpiderDoorOpen_Cam, 1, fromIGC)
          Unhide("FTL_SpiderCollision_Open")
          Hide("FTL_SpiderCollision_Closed")
          FTL_ChangeBridgeState("paint_loop", "All")
          AnimGBSequence("FTL_Exit_Container", "Painted_Idle")
          AnimGBSequence("FTL_Piston", "paint2_loop")
          AnimGBSequence("FTL_Gulch_Whistlesteam", "wPaint")
        elseif (var_balls == 2) then
          FTL_ChangeBridgeState("paint_loop", 1)
          FTL_ChangeBridgeState("thinner_loop", 2)
          AnimGBSequence("FTL_Gulch_Whistlesteam", "wThinner")
          AnimGBSequence("FTL_Exit_Container", "Neutral_Idle")
        elseif (var_balls == 1) then
          var_IntermitSpray = 1
          FTL_ChangeBridgeState("thinner_loop", 1)
          AnimGBSequence("FTL_Bridge_UmbrellaPlatform", "thinner_loop")
          AnimGBSequence("FTL_Gulch_Whistles", "thinner_loop")
          AnimGBSequence("FTL_Gulch_Whistlesteam", "wThinner")
          ForEachEntityInGroup(SetPropertyInt, "FTL_BridgeSpray_Thinner", "StimulusTypeList", 0, 0)
          ForEachEntityInGroup(SetPropertyFloat, "FTL_BridgeSpray_Thinner", "StimulusPerSecondList", 1, 0)
          ForEachEntityInGroup(SetPropertyInt, "FTL_BridgeSpray_Thinner", "StimulusTypeList", 0, 1)
          AnimGBSequence("FTL_Exit_Container", "Thinned_Idle")
        end
        local StopPlate = function()
          wait(1.25)
          AnimGBSetIdle("FTL_Bridge_PlatePlatform", true)
          return 
        end
        if fromIGC then
          StopPlate()
        else
          FireThread(StopPlate)
        end
        if (GetGlobal("FTL_Gulch_DepositedBalls") ~= initial_var_balls) then
          RemoveMusicStateOverride("IGC_1A_01")
          Print("Returning to Lab Exp music from Intro IGC")
        end
        Print(("FTL_BallReceptorDetection: global = " .. GetGlobal("FTL_Gulch_ProjectorExit")))
        local global = GetGlobal("FTL_Gulch_ProjectorExit")
        if (global == 0) then
          if (GetNumPlayers() == 2) then
            SetCameraAttributesForPlayer("FTL_Gulch_01c_IntroOverride_coopPlayer1", GetPlayer())
          else
            SetCameraAttributesForPlayer("FTL_Gulch_01c_IntroOverride", GetPlayer())
          end
          SetCameraAttributesForPlayer("FTL_Gulch_01c_IntroOverride_coopPlayer2", GetPlayer2OrAI())
          FireThread(FTL_Gulch_Lab_Intro_SCUPM)
        elseif (global == 1) then
          ShowHud()
          FireThread(Projector_To_IGC_Cleanup, "Projector_ToMadLab")
        elseif (global == 2) then
          ShowHud()
          FireThread(Projector_To_IGC_Cleanup, "Projector_ToMadLabShort")
        end
        if fromIGC then
          GrabCamera("ftl_gulch_01c_scripting1.BridgeLookCamera_Shot2.FancyCameraStart 01", "Projector_ToMadLab", CAMERA_LERP_TRANSITION, 8)
          wait(5.5)
          FireThread(Prefab_GrabCameraFancy_Release_NoFading, 7, "SkipLetterBox")
          wait(6)
        else
          StartFadeIn()
        end
        SetGlobal("FTL_Gulch_ProjectorExit", 0)
        if (tostring(MostRecentCheckpointCallback) ~= "FTL_Gulch_LabSetup") then
          FireThread(FTL_SaveCheckpoint, "Lab")
        else
          Print("FTL_BallReceptorDetection: Setting Save Location on Checkpoint Reload")
          FireThread(FTL_SaveCheckpoint, nil, "Lab")
        end
      end
    end
  elseif (state == "Intro") then
    Print("FTL_BallReceptorDetection: Intro")
    wait(0)
    CameraReset()
    wait(0)
    FireUser1("BridgeLookCamera")
    AddMusicStateOverride("IGC_1A_01")
    Print("Playing Lab Intro IGC music")
    local RemoveSpheres = function(x)
      Print(("RemoveSpheres: TrainCart" .. x))
      local Numof_CartSphere = ("TrainBall" .. GetGlobal((("FTL_Gulch_TrainCart" .. x) .. "State")))
      SetGlobal((("FTL_Gulch_TrainCart" .. x) .. "State"), 0)
      AnimGBSequence(("FTL_ballDispenser_0" .. x), "restLoaded")
      SetParentEntity(Numof_CartSphere, ("FTL_ballDispenser_0" .. x))
      SetPropertyString(Numof_CartSphere, "Bone Attach Name", "bone", 0)
      wait(0.5)
      AnimGBSequence(("FTL_ballDispenser_0" .. x), "unload", true)
      wait(0.550000011920929)
      AudioPostEventOn(GetPlayer(), "Play_SphereSuckedUp")
      return 
    end
    local TrainCart4State = GetGlobal("FTL_Gulch_TrainCart4State")
    if (GetGlobal("FTL_Gulch_DepositedBalls") == 3) then
      if (TrainCart4State == 1) then
        local adjust_offset = function()
          wait(1.899999976158142)
          SetPropertyVector("RedChest_Caboose", "Bone Attach Offset", vector4(0, 0.6000000238418579, 0.8999999761581421), 0)
          return 
        end
        AnimGBSequence("TrainCar04_Caboose", "unload")
        FireThread(adjust_offset)
        SetGlobal("FTL_Gulch_TrainCart4State", 3)
      end
    end
    local args = {}
    FireThread(FTL_BallReceptorDetection, nil, args[2], "FromIGC")
    local SphereSetup = args[1]
    for x = 3, 1, -1 do
      RemoveSpheres = SphereSetup[x]
      if (RemoveSpheres == 1) then
        RemoveSpheres = FireThread
        TrainCart4State = RemoveSpheres
        RemoveSpheres(TrainCart4State, x)
        RemoveSpheres = wait
        TrainCart4State = 0.6600000262260437
        RemoveSpheres(TrainCart4State)
      end
    end
  else
    Print("FTL_BallReceptorDetection: Start Bridge")
    local args = {}
    Print(("#args = " .. (#args)))
    for i = 1, (#args) do
      Print(((("args[" .. i) .. "] = ") .. tostring(args[i])))
    end
    local initial_var_balls = args[1]
    local var_balls = GetGlobal("FTL_Gulch_DepositedBalls")
    local fromIGC = false
    if (args[2] ~= nil) then
      fromIGC = true
    end
    if (GetGlobal("FTL_Gulch_TrainCart4State") == 3) then
      GetPrefabData("RedChest_Caboose").ChestDisabled = "False"
      SetPropertyBool("RedChest_Caboose", "Is Real", false)
      if (fromIGC == false) then
        SetPropertyVector("RedChest_Caboose", "Bone Attach Offset", vector4(0, 0.6000000238418579, 0.8999999761581421), 0)
      end
    end
    Print(("FTL_BallReceptorDetection: var_balls = " .. var_balls))
    if fromIGC then
      wait(1)
    end
    if (var_balls ~= 1) then
      var_IntermitSpray = 0
      ForEachEntityInGroup(SetPropertyInt, "FTL_BridgeSpray_Thinner", "StimulusTypeList", 1, 0)
      ForEachEntityInGroup(SetPropertyFloat, "FTL_BridgeSpray_Thinner", "StimulusPerSecondList", 0, 0)
      ForEachEntityInGroup(SetPropertyInt, "FTL_BridgeSpray_Thinner", "StimulusTypeList", 1, 1)
      AnimGBSequence("FTL_BridgeThinnerFX", "PaintFlow_NoParticles")
    end
    Print(("FTL_BallReceptorDetection: initial_var_balls = " .. initial_var_balls))
    if (initial_var_balls == 0) then
      wait(4)
      FTL_ChangeBridgeState("activate", 1)
      FireSequence("Gus", "FTL_BridgeStarted")
      Hide("FTL_SpiderCollision_Open")
      Unhide("FTL_SpiderCollision_Closed")
      wait(2)
      if (var_balls ~= 3) then
        FireThread(FTL_Gulch_SpiderDoorOpen_Cam, 2)
      end
      wait(1)
    end
    if (var_balls == 3) then
      Enable("LookAt_HDC_MagPaint")
      Disable("LookAt_HDC_MagThinner")
      FireThread(FTL_Gulch_SpiderDoorOpen_Cam, 1, fromIGC)
      Unhide("FTL_SpiderCollision_Open")
      Hide("FTL_SpiderCollision_Closed")
      FTL_ChangeBridgeState("paint_loop", "All")
      AnimGBSequence("FTL_Exit_Container", "Painted_Idle")
      AnimGBSequence("FTL_Piston", "paint2_loop")
      AnimGBSequence("FTL_Gulch_Whistlesteam", "wPaint")
    elseif (var_balls == 2) then
      FTL_ChangeBridgeState("paint_loop", 1)
      FTL_ChangeBridgeState("thinner_loop", 2)
      AnimGBSequence("FTL_Gulch_Whistlesteam", "wThinner")
      AnimGBSequence("FTL_Exit_Container", "Neutral_Idle")
    elseif (var_balls == 1) then
      var_IntermitSpray = 1
      FTL_ChangeBridgeState("thinner_loop", 1)
      AnimGBSequence("FTL_Bridge_UmbrellaPlatform", "thinner_loop")
      AnimGBSequence("FTL_Gulch_Whistles", "thinner_loop")
      AnimGBSequence("FTL_Gulch_Whistlesteam", "wThinner")
      ForEachEntityInGroup(SetPropertyInt, "FTL_BridgeSpray_Thinner", "StimulusTypeList", 0, 0)
      ForEachEntityInGroup(SetPropertyFloat, "FTL_BridgeSpray_Thinner", "StimulusPerSecondList", 1, 0)
      ForEachEntityInGroup(SetPropertyInt, "FTL_BridgeSpray_Thinner", "StimulusTypeList", 0, 1)
      AnimGBSequence("FTL_Exit_Container", "Thinned_Idle")
    end
    local StopPlate = function()
      wait(1.25)
      AnimGBSetIdle("FTL_Bridge_PlatePlatform", true)
      return 
    end
    if fromIGC then
      StopPlate()
    else
      FireThread(StopPlate)
    end
    if (GetGlobal("FTL_Gulch_DepositedBalls") ~= initial_var_balls) then
      RemoveMusicStateOverride("IGC_1A_01")
      Print("Returning to Lab Exp music from Intro IGC")
    end
    Print(("FTL_BallReceptorDetection: global = " .. GetGlobal("FTL_Gulch_ProjectorExit")))
    local global = GetGlobal("FTL_Gulch_ProjectorExit")
    if (global == 0) then
      if (GetNumPlayers() == 2) then
        SetCameraAttributesForPlayer("FTL_Gulch_01c_IntroOverride_coopPlayer1", GetPlayer())
      else
        SetCameraAttributesForPlayer("FTL_Gulch_01c_IntroOverride", GetPlayer())
      end
      SetCameraAttributesForPlayer("FTL_Gulch_01c_IntroOverride_coopPlayer2", GetPlayer2OrAI())
      FireThread(FTL_Gulch_Lab_Intro_SCUPM)
    elseif (global == 1) then
      ShowHud()
      FireThread(Projector_To_IGC_Cleanup, "Projector_ToMadLab")
    elseif (global == 2) then
      ShowHud()
      FireThread(Projector_To_IGC_Cleanup, "Projector_ToMadLabShort")
    end
    if fromIGC then
      GrabCamera("ftl_gulch_01c_scripting1.BridgeLookCamera_Shot2.FancyCameraStart 01", "Projector_ToMadLab", CAMERA_LERP_TRANSITION, 8)
      wait(5.5)
      FireThread(Prefab_GrabCameraFancy_Release_NoFading, 7, "SkipLetterBox")
      wait(6)
    else
      StartFadeIn()
    end
    SetGlobal("FTL_Gulch_ProjectorExit", 0)
    if (tostring(MostRecentCheckpointCallback) ~= "FTL_Gulch_LabSetup") then
      FireThread(FTL_SaveCheckpoint, "Lab")
    else
      Print("FTL_BallReceptorDetection: Setting Save Location on Checkpoint Reload")
      FireThread(FTL_SaveCheckpoint, nil, "Lab")
    end
  end
  return 
end
FTL_Gulch_Lab_SphereLoaded = function(target, num)
  AnimGBSequence((("Receptacle" .. num) .. "_BulbMachineRedSm"), "OffRed")
  AnimGBSequence((("Receptacle" .. num) .. "_BulbMachineGreenSm"), "OnGreen")
  Hide(GetChildEntityByName(target, "TrainBalls"))
  return 
end
FTL_ChangeBridgeState = function(animation, bridge_part)
  if (bridge_part == "All") then
    AnimGBSequence("FTL_Bridge_PlatePlatform", animation)
    AnimGBSequence("FTL_Bridge_HatPlatform", animation)
    AnimGBSequence("FTL_Bridge_RacketPlatform", animation)
    AnimGBSequence("FTL_Bridge_AnvilPlatform", animation)
  end
  if (bridge_part == "All") then
    AnimGBSequence("FTL_Bridge_UmbrellaPlatform", animation)
    AnimGBSequence("FTL_Gulch_Whistles", animation)
    AnimGBSequence("FTL_Bridge_ClockPlatform", animation)
    if (bridge_part == "All") then
      AnimGBSequence("FTL_Gulch_Madlab_cage", "paint_loop")
    else
      AnimGBSequence("FTL_Piston", animation)
    end
    if (not GetPropertyBool("DGL_OneShots1", "Is Painted")) then
      AnimGBSetIdle("FTL_Bridge_ClockPlatform", true)
    end
  end
  return 
end
FTL_Lab_ClockPlatform = function(target, state)
  Print(("FTL_Lab_ClockPlatform: state == " .. state))
  if (state == "Painted") then
    AnimGBSetIdle("FTL_Bridge_ClockPlatform", false)
  elseif (state == "Thinned") then
    AnimGBSetIdle("FTL_Bridge_ClockPlatform", true)
  end
  return 
end
FTL_IGC_JiminyHeadOpen = function(target, state)
  if (state == nil) then
    ForEachEntityInPrefab(DestroyEntity, "HiddenOswald_RecepticleCharge")
    ForEachEntityInGroup(SplineFollower_SetDisabled, "JiminyHeadMachineFX", false)
    ForEachEntityInGroup(AudioPostEventOn, "JiminyHeadMachineFX", "Play_sfx_SecretMachine_TravelSpark")
    OswaldStreamAbort()
    AnimGBSequence("FTL_gulch_01c_secretMachine_inert", "run")
    AudioPostEventOn("ftl_gulch_01c_audio.SND_SecretMachineFX", "Stop_sfx_secretmachine_light_lp")
    SetPropertyBool("TriggerLookAt_OpenJiminyHead", "Look At Trigger Enabled", true)
  elseif (state == "Jiminy") then
    FireSequence("Gus", "FTL_Gulch_JiminyHeadOpen")
    SetPropertyBool("ftl_gulch_01c.TriggerLookAt_SeeProjector", "Look At Trigger Enabled", true)
    AnimGBSequence("FTL_JimCricketHead", "open")
    StartEmitters("ftl_gulch_01c_fx.FTL_jiminyHead_01a 01")
    DoStinger("Stinger_Unique1", 2)
    Wait(0.699999988079071)
    StopEmitters("ftl_gulch_01c_fx.FTL_jiminyHead_01a 01")
    AudioPostEventOn("ftl_gulch_01c_audio.SND_SecretMachineFX", "Stop_sfx_secretmachine_light_lp")
  end
  return 
end
var_IntermitSpray = 0
var_SprayState = 0
FTL_Gulch_BridgeSpray = function()
  if (var_IntermitSpray == 1) then
    if (var_SprayState == 0) then
      AnimGBSequence("FTL_BridgeThinnerFX", "ThinnerFlow_WithParticles")
      Wait(0.4000000059604645)
      ForEachEntityInGroup(Enable, "FTL_BridgeSpray_Thinner")
    elseif (var_SprayState == 1) then
      AnimGBSequence("FTL_BridgeThinnerFX", "ThinnerFlow_NoParticles")
      ForEachEntityInGroup(Disable, "FTL_BridgeSpray_Thinner")
    elseif (var_SprayState == 4) then
      var_SprayState = -1
    end
    var_SprayState = (var_SprayState + 1)
  end
  return 
end
local CurrStatus = "Out"
FTL_Gulch_Bridge_PaintRestore = function(target, status)
  CurrStatus = status
  local activator = _activator()
  Print("FTL_Gulch_Bridge_PaintRestore")
  if (GetPropertyInt(target, "StimulusTypeList", 0) == 1) then
    Print("FTL_Gulch_Bridge_PaintRestore: StimulusTypeList = 1")
    if (activator == GetPlayer()) then
      Print("FTL_Gulch_Bridge_PaintRestore: Player 1 or 2")
      while true do
        if (not (CurrStatus == "In")) then
          break
        end
        SetHealth(_activator(), (GetHealth(_activator()) + 1))
        Wait(0.5)
      end
    end
  end
  return 
end
FTL_PipeBridge_DamageTrigger = function(target, trig_num)
  StimulusEntityWithAliasInEntityDirectionInRadius(target, ST_KNOCKBACK, 2, 0, _activator(), ("PM_ElectricFieldDir" .. trig_num), "")
  return 
end
FTL_Gulch_SpiderDoorOpen_Cam = function(state, fromIGC)
  AnimVarInt("FTL_Gulch_SpiderDoor", VAR_Cutscene, state)
  AnimEvent("FTL_Gulch_SpiderDoor", EVENT_Start_Cutscene)
  StartEmitters("FTL_machineDoorDustUp_01a")
  AnimGBSequence("FTL_AnimatedCamera1", "gp_demo_IGC_cam_pressure_plate_reaction_2_LabExit")
  wait(6)
  Unhide("FTL_Gulch_SpiderDoor")
  return 
end
FTL_ElecgtridBridgeKnockaway = function(trigger, number1, number2)
  StimulusEntity(trigger, ST_KNOCKBACK, 20, GetPosition(_activator()), _activator(), vector4(tonumber(number1), 0, tonumber(number2)))
  return 
end
FTL_OnBridgeCamera = function(target)
  local myActivator = target
  SetDefaultCameraValues(11, 17, -7, myActivator)
  SetCombatCameraValues(11, 17, -7, myActivator)
  SetTravelCameraValues(11, 17, -7, myActivator)
  return 
end
FTL_DefaultCamera = function(target)
  local myActivator = target
  ResetTravelCameraValues(myActivator)
  ResetCombatCameraValues(myActivator)
  ResetDefaultCameraValues(myActivator)
  return 
end
FTL_Lab_UnlockAchievement = function()
  SetGlobal("FTL_Gulch_ScurvyPin_Given", 0)
  if (GetPrefabData(_self()).TeleportToMarker == "tomdlab_Projector_Lower") then
    Print("FTL_Gulch_LeaveLab: Entering Old Mill 1 - Setting FTL_Gulch_ProjectorExit to 1 incase we crash and restart in Lab")
    SetGlobal("FTL_Gulch_ProjectorExit", 1)
  else
    Print("FTL_Gulch_LeaveLab: Entering Old Mill 2 - Setting FTL_Gulch_ProjectorExit to 2 incase we crash and restart in Lab")
    SetGlobal("FTL_Gulch_ProjectorExit", 2)
  end
  if (HasCollectible("Challenge_Trailblazer_Tracker") == false) then
    wait(1.5)
    GiveCollectible("Challenge_Trailblazer_Tracker")
  end
  return 
end
FTL_Gulch_DisableOswaldAction = function(target, state)
  if IsValidHandle("HiddenOswald_RecepticleCharge") then
    if (state == "Painted") then
      SetPropertyBool("HiddenOswald_RecepticleCharge", "ActionSpotEnabled", true)
    elseif (state == "Thinned") then
      SetPropertyBool("HiddenOswald_RecepticleCharge", "ActionSpotEnabled", false)
      OswaldStreamAbort()
    end
  end
  return 
end
FTL_Gulch_GreeneSpatters = function(spatter, state, setup)
  Print(("FTL_Gulch_GreeneSpatters " .. state))
  if (state == "Enter") then
    EnableMotion(spatter)
    ExitCutscene(spatter)
  elseif (state == "Exit") then
    local marker = GetPropertyString(spatter, "Spawn Group")
    GoToEntity(spatter, marker)
    SetNextPatrolNode(spatter, marker)
  elseif (state == "Angry") then
    if (setup ~= nil) then
      math.randomseed(os.time())
      wait((10 + (math.random(3, 15) / 10)))
    end
    AnimEvent(spatter, EVENT_Start_AngryIdle)
  elseif (state == "TeamChange") then
    if (GetCurrentTeam(spatter) == 2) then
      IncrementGlobal("FTL_Gulch_GreeneSpatters")
    elseif (GetCurrentTeam(spatter) == 3) then
      DecrementGlobal("FTL_Gulch_GreeneSpatters")
      if (state == "Death") then
        DecrementGlobal("FTL_Gulch_GreeneSpatters")
      end
    end
  elseif (state == "Death") then
    DecrementGlobal("FTL_Gulch_GreeneSpatters")
  end
  return 
end
FTL_Gulch_Greene_PinsBought = function()
  GiveCurrencyItem("Gold_Pin", 2)
  GiveCurrencyItem("Silver_Pin", 2)
  AddCurrency("ETicket", -25)
  SetGlobal("FTL_Gulch_Greene_PinsBought", 1)
  SetMapMarkerVisible("MapMarker_Memories_GreeneSolo", false)
  SetGlobal("OST_Moody_Destination", 1)
  while true do
    if (not IsAnySequencePlaying()) then
      break
    end
    wait(0.20000000298023224)
  end
  FTL_SaveCheckpoint("Lab")
  return 
end
FTL_Gulch_ToggleShamPhoto = function(target, state)
  Print("FTL_Gulch_ToggleShamPhoto")
  if (GetGlobal("MSS_HiddenHeroesQuest") == 1) then
    Print("FTL_Gulch_ToggleShamPhoto: Enable")
    Enable(target)
  end
  return 
end
FTL_CheckHiddenMachine = function()
  local before, after = Jigsaw_GetPercentagePainted("DG_Zone02_Jigsaw2")
  if (after == 1) then
    FireSequence("Cov_Oswald", "FTL_Lab_UnableToShockMachine", 2)
  else
    OswaldStreamAction("BallHackedChargerTarget")
  end
  return 
end
FTL_Lab_LedgeHintToggle = function(target, Hint, state)
  Print("FTL_Lab_LedgeHintToggle")
  local activator = _activator()
  local playerHint = "_Mickey"
  if (activator ~= GetPlayer()) then
    playerHint = "_Oswald"
  end
  Print(((("FTL_Lab_LedgeHintToggle: playerHint = " .. playerHint) .. " & state = ") .. state))
  if (state == "In") then
    SetPropertyBool((Hint .. playerHint), "Look At Trigger Enabled", true)
  elseif (state == "Out") then
    SetPropertyBool((Hint .. playerHint), "Look At Trigger Enabled", false)
  end
  return 
end
FTL_Gulch_Lab_RandomDust = function(target)
  if (target ~= nil) then
    StartEmitters(target)
    wait(2.5)
    StopEmitters(target)
    local wait_flux = math.random(15, 25)
    wait(wait_flux)
  end
  FireUser1(("GBL_dustInWind_01a_0" .. tostring(math.random(1, 5))))
  return 
end
FTL_Gulch_Lab_KillAIAndRescuePlayer = function(_activator)
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
  if (_activator == GetPlayer()) then
    if (_activator == GetPlayer()) then
      if (GetNumPlayers() == 2) then
        SetCameraAttributesForPlayer("FTL_Gulch_01c_IntroOverride_coopPlayer1", _activator)
      else
        SetCameraAttributesForPlayer("FTL_Gulch_01c_IntroOverride", _activator)
        SetCameraAttributesForPlayer("FTL_Gulch_01c_IntroOverride_coopPlayer2", _activator)
      end
    else
      SetCameraAttributesForPlayer("FTL_Gulch_01c_IntroOverride_coopPlayer2", _activator)
    end
    StationaryCamera_UntilPlayerMoves(nil, nil, _activator)
  end
  return 
end
FTL_Gulch_Lab_ProjectorTraining = function()
  if (GetGlobal("RF_Gus_PrejectorTutorial_Played") == 0) then
    local Projector_ToMadLab_screen = GetRelativePrefabEntity("Projector_ToMadLab", ".ProjectorScreen")
    local Projector_ToMadLabShort_screen = GetRelativePrefabEntity("Projector_ToMadLabShort", ".ProjectorScreen")
    SetPropertyFloat(Projector_ToMadLab_screen, "UsableRadius", 0)
    SetPropertyFloat(Projector_ToMadLabShort_screen, "UsableRadius", 0)
    FireSequence("Gus", "Global_Gus_ProjectorTutorial", 1)
    while true do
      if (not IsSequencePlaying("Gus", "Global_Gus_ProjectorTutorial")) then
        break
      end
      wait(0.20000000298023224)
    end
    SetPropertyFloat(Projector_ToMadLab_screen, "UsableRadius", 3.5)
    SetPropertyFloat(Projector_ToMadLabShort_screen, "UsableRadius", 3.5)
  end
  return 
end

