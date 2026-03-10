Attic_EnterProjector_toAUT = function()
  if (GetEntity("VisitSetup 02") == nil) then
    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
  else
    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
  end
  return 
end
TCY_Load_MD_FilmStrip = function(target)
  SetupPosition(target)
  return 
end
Attic_2DTransitionSetup = function()
  StartFadeOut(0)
  Print("Attic_2DTransitionSetup")
  local visit = 1
  if IsValidHandle("VisitSetup 02") then
    visit = 2
  end
  Print(("Attic_2DTransitionSetup: We are in Visit" .. tostring(visit)))
  if (visit == 2) then
    if (GetGlobal("Attic_IntroCutSceneVar") == 0) then
      Print("Attic_2DTransitionSetup: We are in Visit2 and Attic_IntroCutSceneVar == 0; We must have HardLoaded here")
      SetGlobal("LMR_TheAttic_VisitNumber", 2)
      SetGlobal("LMR_TheAttic_Generator01", 1)
      SetGlobal("LMR_TheAttic_Generator02", 1)
      SetGlobal("LMR_TheAttic_Generator03", 1)
      SetGlobal("LMR_TheAttic_Gus_Hint1_Played", 1)
      SetGlobal("LMR_TheAttic_Markus_CageDown3_Played", 1)
      SetGlobal("LMR_TheAttic_VaultState", 1)
      SetGlobal("Attic_IntroCutSceneVar", 1)
    end
  end
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    Print("Attic_2DTransitionSetup: EM2_EpisodeCheck == 1, so setting to 3; We must have HardLoaded here")
    SetGlobal("EM2_EpisodeCheck", 3)
  end
  if (GetGlobal("2dDirection") == 0) then
    GetPrefabData("ProjectorToAutotopia").MapLoad_SetupPosition = "IgnoreMe"
    GetPrefabData("ProjectorToRide").MapLoad_SetupPosition = "True"
  else
    local data = GetPrefabData("ProjectorToAutotopia")
    if (visit == 1) then
      if (GetGlobal("Attic_IntroCutSceneVar") == 0) then
        Print("Attic_2DTransitionSetup: Visit1 Intro Not Played")
        data.ToFlyThrough = "True"
        data.SkipJumpOutAnim = true
        data.SkipSideCameraRelease = true
      end
    end
    data.MapLoad_SetupPosition = "True"
    GetPrefabData("ProjectorToRide").MapLoad_SetupPosition = "IgnoreMe"
  end
  return 
end
LMR_MadDoctorAttic_ToNewRide = function()
  UnrestrictCutSceneInput()
  LoadLevel(GetPlayer(), "MeanStreet_North.HardLoadUndermill")
  return 
end
LMR_Attic_SaveCheckpoint = function()
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  SaveCheckpoint(GetPlayer(), "LMR_Attic_LoadCheckpoint", "StartPositionMarker_Mickey", "StartPositionMarker_Oswald")
  return 
end
LMR_Attic_LoadCheckpoint = function()
  DestroyEntity("Attic_LauncherSetup")
  GetPrefabData("ProjectorToRide").MapLoad_SetupPosition = "IgnoreMe"
  GetPrefabData("ProjectorToAutotopia").MapLoad_SetupPosition = "IgnoreMe"
  LMR_MadDoctorAttic_AlwaysSetup()
  return 
end
LMR_Attic_ManageLoad = 0
LMR_MadDoctorAttic_AlwaysSetup = function(target)
  StartFadeOut(0)
  if (GetGlobal("Attic_IntroCutSceneVar") ~= 0) then
    RestrictCutSceneInput()
  end
  if (GetGlobal("LMR_TheAttic_Gus_Hint1_Played") == 1) then
    local visit = 1
    if IsValidHandle("VisitSetup 02") then
      visit = 2
    end
    if (visit == 1) then
      LevelManager_SetZoneStatusUnloaded("LMR_MadDoctorAttic.IGCLayer")
    end
  end
  Print("LMR_MadDoctorAttic_AlwaysSetup: function entered")
  Print(("LMR_MadDoctorAttic_AlwaysSetup: EM2_EpisodeCheck is " .. tostring(GetGlobal("EM2_EpisodeCheck"))))
  if (target == nil) then
    ForEachEntityInGroup(Enable, "Trigger_Checkpoint_EnableProjectorCamera")
  end
  local global_LMR_TheAttic_VisitNumber, global_LMR_TheAttic_VisitNumber = GetGlobal("LMR_TheAttic_VisitNumber"), "LMR_TheAttic_VisitNumber"
  global_LMR_TheAttic_VisitNumber = Print
  global_LMR_TheAttic_VisitNumber(("LMR_MadDoctorAttic_AlwaysSetup: LMR_TheAttic_VisitNumber is " .. tostring(global_LMR_TheAttic_VisitNumber)))
  global_LMR_TheAttic_VisitNumber = GetGlobal
  global_LMR_TheAttic_VisitNumber = global_LMR_TheAttic_VisitNumber("LMR_TheAttic_VaultState")
  local global_LMR_TheAttic_VaultState = "LMR_TheAttic_VaultState"
  if (global_LMR_TheAttic_VisitNumber == 2) then
    global_LMR_TheAttic_VaultState = ForceSpawn
    global_LMR_TheAttic_VaultState("Attic_DropWingSpawner01", 1)
    global_LMR_TheAttic_VaultState = ForceSpawn
    global_LMR_TheAttic_VaultState("Attic_DropWingSpawner02", 1)
    global_LMR_TheAttic_VaultState = ForEachEntityInGroup
    global_LMR_TheAttic_VaultState(DestroyEntity, "HackBox_FXgroup")
    global_LMR_TheAttic_VaultState = ForEachEntityInGroup
    global_LMR_TheAttic_VaultState(StopEmitters, "GlobeSnow")
  end
  global_LMR_TheAttic_VaultState = GetGlobal
  global_LMR_TheAttic_VaultState = global_LMR_TheAttic_VaultState("LMR_TheAttic_Gus_Hint1_Played")
  local LMR_TheAttic_Gus_Hint1_Played_global = "LMR_TheAttic_Gus_Hint1_Played"
  LMR_TheAttic_Gus_Hint1_Played_global = Print
  LMR_TheAttic_Gus_Hint1_Played_global(("#### LMR_TheAttic_Gus_Hint1_Played = " .. tostring(global_LMR_TheAttic_VaultState)))
  LMR_TheAttic_Gus_Hint1_Played_global = GetGlobal
  LMR_TheAttic_Gus_Hint1_Played_global = LMR_TheAttic_Gus_Hint1_Played_global("VTL_Oasis_DaisyQuest_PhotoAttic")
  if (LMR_TheAttic_Gus_Hint1_Played_global == 1) then
    LMR_TheAttic_Gus_Hint1_Played_global = GetGlobal
    LMR_TheAttic_Gus_Hint1_Played_global = LMR_TheAttic_Gus_Hint1_Played_global("VTL_Oasis_DaisyQuest_Step")
    if (1 <= LMR_TheAttic_Gus_Hint1_Played_global) then
      LMR_TheAttic_Gus_Hint1_Played_global = Enable
      LMR_TheAttic_Gus_Hint1_Played_global("lmr_maddoctorattic_01a_scripting.Photo_DaisyQuest")
    end
  end
  LMR_TheAttic_Gus_Hint1_Played_global = GetGlobal
  LMR_TheAttic_Gus_Hint1_Played_global = LMR_TheAttic_Gus_Hint1_Played_global("LMR_TheAttic_Generator01")
  local Generator_Global = "LMR_TheAttic_Generator01"
  Generator_Global = GetGlobal
  Generator_Global = Generator_Global("LMR_BWXSpawner1_DestComplete")
  if (Generator_Global ~= 0) then
    if (LMR_TheAttic_Gus_Hint1_Played_global == 1) then
      Generator_Global = AnimGBSequence
      Generator_Global("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpMachine_inert_01a 01", "popUp")
      Generator_Global = AnimGBSequence
      Generator_Global("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_oswald_inert_01a 01", "up")
      Generator_Global = SetGlobal
      Generator_Global("LMR_GeneratorStatus01", 0)
      Generator_Global = 1
      LMR_Attic_ManageLoad = Generator_Global
    elseif (LMR_TheAttic_Gus_Hint1_Played_global == 2) then
      Generator_Global = Enable
      Generator_Global("lmr_maddoctorattic_01a_scripting.Generator02_FXSpawner")
      Generator_Global = SetGlobal
      Generator_Global("LMR_GeneratorStatus01", 0)
      Generator_Global = 1
      LMR_Attic_ManageLoad = Generator_Global
    end
  end
  Generator_Global = GetGlobal
  Generator_Global = Generator_Global("LMR_TheAttic_Generator02")
  LMR_TheAttic_Gus_Hint1_Played_global = Generator_Global
  Generator_Global = GetGlobal
  Generator_Global = Generator_Global("LMR_BWXSpawner2_DestComplete")
  if (Generator_Global ~= 0) then
    if (LMR_TheAttic_Gus_Hint1_Played_global == 1) then
      Generator_Global = AnimGBSequence
      Generator_Global("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpDesk_inert_01a 01", "popUp")
      Generator_Global = AnimGBSequence
      Generator_Global("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_madDoctor_inert_01a 01", "up")
      Generator_Global = SetGlobal
      Generator_Global("LMR_GeneratorStatus02", 0)
      Generator_Global = 1
      LMR_Attic_ManageLoad = Generator_Global
    elseif (LMR_TheAttic_Gus_Hint1_Played_global == 2) then
      Generator_Global = Enable
      Generator_Global("lmr_maddoctorattic_01a_scripting.Generator01_FXSpawner")
      Generator_Global = SetGlobal
      Generator_Global("LMR_GeneratorStatus02", 0)
      Generator_Global = 1
      LMR_Attic_ManageLoad = Generator_Global
    end
  end
  Generator_Global = GetGlobal
  Generator_Global = Generator_Global("LMR_TheAttic_Generator03")
  LMR_TheAttic_Gus_Hint1_Played_global = Generator_Global
  Generator_Global = GetGlobal
  Generator_Global = Generator_Global("LMR_BWXSpawner3_DestComplete")
  if (Generator_Global ~= 0) then
    if (LMR_TheAttic_Gus_Hint1_Played_global == 1) then
      Generator_Global = SetGlobal
      Generator_Global("LMR_GeneratorStatus03", 0)
      Generator_Global = 1
      LMR_Attic_ManageLoad = Generator_Global
    elseif (LMR_TheAttic_Gus_Hint1_Played_global == 2) then
      Generator_Global = Enable
      Generator_Global("lmr_maddoctorattic_01a_scripting.Generator03_FXSpawner")
      Generator_Global = SetGlobal
      Generator_Global("LMR_GeneratorStatus03", 0)
      Generator_Global = 1
      LMR_Attic_ManageLoad = Generator_Global
    end
  end
  Generator_Global = GetGlobal
  Generator_Global = Generator_Global("LMR_TheAttic_Markus_CageDown3_Played")
  if (Generator_Global == 1) then
    Generator_Global = AnimGBSequence
    Generator_Global("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "leftDown003")
    Generator_Global = AnimGBSequence
    Generator_Global("GremlinSnowglobe", "break")
    Generator_Global = ForEachEntityInGroup
    Generator_Global(StopEmitters, "GlobeSnow")
  else
    Generator_Global = GetGlobal
    Generator_Global = Generator_Global("LMR_TheAttic_Markus_CageUp3_Played")
    if (Generator_Global == 1) then
      Generator_Global = AnimGBSequence
      Generator_Global("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "leftUp003")
      Generator_Global = AnimGBSequence
      Generator_Global("ChestSnowglobe", "break")
      Generator_Global = ForEachEntityInGroup
      Generator_Global(StopEmitters, "GlobeSnow")
      Generator_Global = GetGlobal
      Generator_Global = Generator_Global("LMR_TheAttic_RedChest01")
      if (Generator_Global == 0) then
        Generator_Global = FireThread
        Generator_Global(Prefab_ChestOpenable, "CageRedChest", "true")
      end
    end
  end
  Generator_Global = GetGlobal
  Generator_Global = Generator_Global("Attic_SaveStairs")
  local Attic_SaveStairs_global = "Attic_SaveStairs"
  if (Generator_Global == 1) then
    Attic_SaveStairs_global = ForEachEntityInGroup
    Attic_SaveStairs_global(StopEmitters, "StairWireSparkGroup")
    Attic_SaveStairs_global = ForEachEntityInGroup
    Attic_SaveStairs_global(AnimGBSequence, "LMR_Animated_Audience", "up")
    Attic_SaveStairs_global = ForEachEntityInGroup
    Attic_SaveStairs_global(SetPropertyBool, "LMR_Animated_Audience", "Start Active", true)
    Attic_SaveStairs_global = ForEachEntityInGroup
    Attic_SaveStairs_global(Enable, "StairCameraGroup")
    Attic_SaveStairs_global = enableJumpVolumeAvailability
    Attic_SaveStairs_global("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 01.TargetToSend")
    Attic_SaveStairs_global = enableJumpVolumeAvailability
    Attic_SaveStairs_global("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 02.TargetToSend")
    Attic_SaveStairs_global = enableJumpVolumeAvailability
    Attic_SaveStairs_global("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 03.TargetToSend")
  elseif (Generator_Global == 0) then
    Attic_SaveStairs_global = ForEachEntityInGroup
    Attic_SaveStairs_global(AnimGBSequence, "LMR_Animated_Audience", "down")
    Attic_SaveStairs_global = ForEachEntityInGroup
    Attic_SaveStairs_global(StartEmitters, "StairWireSparkGroup")
    Attic_SaveStairs_global = ForEachEntityInGroup
    Attic_SaveStairs_global(Disable, "StairCameraGroup")
    Attic_SaveStairs_global = disableJumpVolumeAvailability
    Attic_SaveStairs_global("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 01.TargetToSend")
    Attic_SaveStairs_global = disableJumpVolumeAvailability
    Attic_SaveStairs_global("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 02.TargetToSend")
    Attic_SaveStairs_global = disableJumpVolumeAvailability
    Attic_SaveStairs_global("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 03.TargetToSend")
  end
  if (global_LMR_TheAttic_VisitNumber == 1) then
    Attic_SaveStairs_global = Print
    Attic_SaveStairs_global("Attic Vault Door Setup State 1")
    Attic_SaveStairs_global = AnimGBSequence
    Attic_SaveStairs_global("GremlinSnowglobe", "break")
    Attic_SaveStairs_global = AnimGBSequence
    Attic_SaveStairs_global("lmr_maddoctorattic_01a_scripting.LMR_VaultDoor", "open")
    Attic_SaveStairs_global = TeleportToEntity
    Attic_SaveStairs_global("Attic_HiddenPhotoMarker01", "Attic_PhotoMarkerDestination01")
    Attic_SaveStairs_global = TeleportToEntity
    Attic_SaveStairs_global("Attic_HiddenPhotoMarker02", "Attic_PhotoDestination02")
  elseif (global_LMR_TheAttic_VisitNumber == 2) then
    Attic_SaveStairs_global = Print
    Attic_SaveStairs_global("Attic Vault Door Setup State 2")
    Attic_SaveStairs_global = AnimGBSequence
    Attic_SaveStairs_global("ChestSnowglobe", "break")
    Attic_SaveStairs_global = GetGlobal
    Attic_SaveStairs_global = Attic_SaveStairs_global("LMR_TheAttic_RedChest01")
    if (Attic_SaveStairs_global == 0) then
      Attic_SaveStairs_global = FireThread
      Attic_SaveStairs_global(Prefab_ChestOpenable, "CageRedChest", "true")
    end
    Attic_SaveStairs_global = AnimGBSequence
    Attic_SaveStairs_global("lmr_maddoctorattic_01a_scripting.LMR_VaultDoor", "fall")
    Attic_SaveStairs_global = TeleportToEntity
    Attic_SaveStairs_global("Attic_HiddenPhotoMarker01", "Attic_PhotoMarkerDestination01")
    Attic_SaveStairs_global = TeleportToEntity
    Attic_SaveStairs_global("Attic_HiddenPhotoMarker02", "Attic_PhotoDestination02")
  end
  Attic_SaveStairs_global = GetGlobal
  Attic_SaveStairs_global = Attic_SaveStairs_global("LMR_TheAttic_LoweringPlatform")
  if (Attic_SaveStairs_global == 1) then
    Attic_SaveStairs_global = AnimGBSequence
    Attic_SaveStairs_global("lmr_maddoctorattic_01a_scripting.Stage_BackDrop 01", "rest")
    Attic_SaveStairs_global = AnimGBSequence
    Attic_SaveStairs_global("lmr_maddoctorattic_01a_scripting.Stage_ChainsLock 01", "break")
    Attic_SaveStairs_global = AnimGBSequence
    Attic_SaveStairs_global("lmr_maddoctorattic_01a_scripting.Stage_ChainsLock 02", "break")
    Attic_SaveStairs_global = enableJumpVolumeAvailability
    Attic_SaveStairs_global("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 09.TargetToSend")
  end
  if (global_LMR_TheAttic_VisitNumber == 2) then
    Attic_SaveStairs_global = PostIGC_0320_AtticIntroWithMarkus
    Attic_SaveStairs_global()
  elseif (global_LMR_TheAttic_VisitNumber == 1) then
    Attic_SaveStairs_global = LMR_MadDoctorAttic_IntroCutscene
    Attic_SaveStairs_global()
  end
  Attic_SaveStairs_global = GetGlobal
  Attic_SaveStairs_global = Attic_SaveStairs_global("Attic_MarkusStandNearVault")
  if (Attic_SaveStairs_global == 0) then
    if (global_LMR_TheAttic_VisitNumber == 1) then
      if (global_LMR_TheAttic_VaultState == 1) then
        Attic_SaveStairs_global = DisableMotion
        Attic_SaveStairs_global("LMR_GremlinMarkus")
        Attic_SaveStairs_global = DriveMotionWithPhysics
        Attic_SaveStairs_global("LMR_GremlinMarkus")
        Attic_SaveStairs_global = Wait
        Attic_SaveStairs_global(0.10000000149011612)
        Attic_SaveStairs_global = Unhide
        Attic_SaveStairs_global("LMR_GremlinMarkus")
        Attic_SaveStairs_global = TeleportToEntity
        Attic_SaveStairs_global("LMR_GremlinMarkus", "lmr_maddoctorattic_01a_scripting.GremlinCage_AttachMarker 01")
        Attic_SaveStairs_global = GetPosition
        Attic_SaveStairs_global = Attic_SaveStairs_global("LMR_GremlinMarkus")
        local current_pos = "LMR_GremlinMarkus"
        current_pos = GetGlobal
        current_pos = current_pos("LMR_CagePosition")
        if (current_pos == 1) then
          current_pos = SetTransformation
          current_pos("LMR_GremlinMarkus", vector4(Attic_SaveStairs_global.x, (Attic_SaveStairs_global.y + 2.4000000953674316), Attic_SaveStairs_global.z), vector4(0, 0, 0))
        else
          current_pos = SetTransformation
          current_pos("LMR_GremlinMarkus", vector4(Attic_SaveStairs_global.x, (Attic_SaveStairs_global.y + 0.10000000149011612), Attic_SaveStairs_global.z), vector4(0, 0, 0))
        end
        current_pos = GetFacing
        current_pos = current_pos("LMR_GremlinMarkus")
        local current_facing = "LMR_GremlinMarkus"
        current_facing = current_pos.y
        current_facing = (current_facing - 180)
        current_pos.z = current_facing
        current_facing = current_pos.normalize3
        current_facing(current_pos)
        current_facing = SetFacing
        current_facing("LMR_GremlinMarkus", current_pos)
        current_facing = SetParentEntity
        current_facing("LMR_GremlinMarkus", "lmr_maddoctorattic_01a_scripting.GremlinCage_AttachMarker 01")
      end
    end
  else
    Attic_SaveStairs_global = GetGlobal
    Attic_SaveStairs_global = Attic_SaveStairs_global("Attic_MarkusStandNearVault")
    if (Attic_SaveStairs_global == 1) then
      if (global_LMR_TheAttic_VisitNumber == 1) then
        Attic_SaveStairs_global = EnableMotion
        Attic_SaveStairs_global("EM2_MSTN_GremlinMarkus")
        Attic_SaveStairs_global = Wait
        Attic_SaveStairs_global(0)
        Attic_SaveStairs_global = SetVulnerability
        Attic_SaveStairs_global("LMR_GremlinMarkus", ST_PAINT, 1)
        Attic_SaveStairs_global = SetVulnerability
        Attic_SaveStairs_global("LMR_GremlinMarkus", ST_THINNER, 1)
        Attic_SaveStairs_global = MoveToEntity
        Attic_SaveStairs_global("LMR_GremlinMarkus", "MarkusTeleportSpot")
      end
    else
      Attic_SaveStairs_global = GetGlobal
      Attic_SaveStairs_global = Attic_SaveStairs_global("Attic_MarkusStandNearVault")
      if (Attic_SaveStairs_global == 2) then
        Attic_SaveStairs_global = Hide
        Attic_SaveStairs_global("LMR_GremlinMarkus")
      end
    end
  end
  Attic_SaveStairs_global = GetPropertyBool
  Attic_SaveStairs_global = Attic_SaveStairs_global("Attic_OneShot9", "Is Painted")
  if Attic_SaveStairs_global then
    Attic_SaveStairs_global = ForEachEntityInGroup
    Attic_SaveStairs_global(Enable, "GeneratorGearGroup")
    Attic_SaveStairs_global = AudioPostEventOn
    Attic_SaveStairs_global("lmr_maddoctorattic_01a_audio.Snd_Gear", "Play_sfx_MDA_gears")
  else
    Attic_SaveStairs_global = ForEachEntityInGroup
    Attic_SaveStairs_global(Disable, "GeneratorGearGroup")
  end
  Attic_SaveStairs_global = GetGlobal
  Attic_SaveStairs_global = Attic_SaveStairs_global("Attic_IntroCutSceneVar")
  if (Attic_SaveStairs_global ~= 0) then
    Attic_SaveStairs_global = UnrestrictCutSceneInput
    Attic_SaveStairs_global()
    if (target ~= nil) then
      Attic_SaveStairs_global = StartFadeIn
      Attic_SaveStairs_global(0.5)
    end
  end
  return 
end
LMR_MadDoctorAttic_IntroCutscene = function()
  Print("##### LMR_MadDoctorAttic_IntroCutscene")
  if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
    if (GetGlobal("Attic_IntroCutSceneVar") == 0) then
      StartFadeOut(0)
      LevelManager_SetZoneStatusActive("LMR_MadDoctorAttic.IGCLayer")
      WaitForLevelLoad()
      PlayIGC("IGC_0320_AtticIntroWithMarkus")
    end
  else
    PostIGC_0320_AtticIntroWithMarkus()
  end
  return 
end
PostIGC_0320_AtticIntroWithMarkus = function()
  SetGlobal("Attic_IntroCutSceneVar", 1)
  Print("######## PostIGC_0320_AtticIntroWithMarkus")
  Wait(0)
  local LMR_TheAttic_VisitNumber_global = GetGlobal("LMR_TheAttic_VisitNumber")
  ClearAllCameraAttributes()
  if (LMR_TheAttic_VisitNumber_global == 1) then
    if (GetGlobal("LMR_TheAttic_Gus_Hint1_Played") == 0) then
      Quest_SetCriticalPath("Critical_Attic", "Critical_Attic_2")
      FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_Hint1")
      TeleportToEntity(GetPlayer(), "StartPositionMarker_Mickey")
      TeleportToEntity(GetPlayer2OrAI(), "StartPositionMarker_Oswald")
      Projector_To_IGC_Cleanup()
      Prefab_Projector_SetOnlySideCamera("ProjectorToAutotopia")
    end
  end
  if (LMR_TheAttic_VisitNumber_global == 1) then
    DisableMotion("LMR_GremlinMarkus")
    DriveMotionWithPhysics("LMR_GremlinMarkus")
    Wait(0.10000000149011612)
    Unhide("LMR_GremlinMarkus")
    wait(0.10000000149011612)
    SetParentEntity("LMR_GremlinMarkus", "lmr_maddoctorattic_01a_scripting.GremlinCage_AttachMarker 01")
  end
  ShowHud()
  MusicPostEventOn(GetPlayer(), "Play_MX_MDA")
  Print("Started music event from PostIGC_0320_AtticIntroWithMarkus")
  if (LMR_TheAttic_VisitNumber_global == 1) then
    if (GetGlobal("LMR_TheAttic_VaultState") == 0) then
      wait(0)
      local data = GetPrefabData("Beetleworx_Spawner01")
      if (GetGlobal("LMR_BWXSpawner1_DestComplete") == 0) then
        if (data.BeetleworxNumSpawned[1] == 0) then
          if (GetGlobal(GetPrefabData("Beetleworx_Spawner01").MachineStateGlobal) == -1) then
            Prefab_BeetleworxSpawner_Base_Activate("Beetleworx_Spawner01")
          end
        end
      end
      wait(0)
      data = GetPrefabData("Beetleworx_Spawner02")
      if (GetGlobal("LMR_BWXSpawner2_DestComplete") == 0) then
        if (data.BeetleworxNumSpawned[1] == 0) then
          if (GetGlobal(GetPrefabData("Beetleworx_Spawner02").MachineStateGlobal) == -1) then
            Prefab_BeetleworxSpawner_Base_Activate("Beetleworx_Spawner02")
          end
        end
      end
      wait(0)
      data = GetPrefabData("Beetleworx_Spawner03")
      if (GetGlobal("LMR_BWXSpawner3_DestComplete") == 0) then
        if (data.BeetleworxNumSpawned[1] == 0) then
          if (GetGlobal(GetPrefabData("Beetleworx_Spawner03").MachineStateGlobal) == -1) then
            Prefab_BeetleworxSpawner_Base_Activate("Beetleworx_Spawner03")
          end
        end
      end
    end
  end
  wait(2)
  if (LMR_TheAttic_VisitNumber_global == 1) then
    LevelManager_SetZoneStatusUnloaded("LMR_MadDoctorAttic.IGCLayer")
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
  if (LMR_TheAttic_VisitNumber_global == 1) then
    while true do
      if (not (IsAnySequencePlaying() == true)) then
        break
      end
      wait(0.10000000149011612)
    end
    TimerEnable("lmr_maddoctorattic_01a_scripting.GremlinCage_HintTimer 01")
    LMR_Attic_SaveCheckpoint()
  end
  return 
end
Attic_ShowTheHud = function()
  ShowHud()
  return 
end
LMR_MadDoctorAttic_IntroIGCOutro = function()
  ShowHud()
  Wait(1.5)
  FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_Hint1")
  return 
end
LMR_MadDoctorAttic_SetLocalVariable = function(target, variable, value)
  _G[variable] = tonumber(value)
  return 
end
LMR_MadDoctorAttic_CoOpThrowOswald = function()
  OswaldTossAction()
  ClearNextPatrolNode(GetOswaldAI())
  return 
end
LMR_MadDoctorAttic_TeleportAndPathOswald = function(marker, node)
  TeleportToEntity(GetOswaldAI(), marker)
  Wait(0.5)
  OswaldSetPathAction(node)
  return 
end
LMR_MadDoctorAttic_SetPatrolOswald = function(target)
  ClearNextPatrolNode(GetOswaldAI())
  Wait(0.10000000149011612)
  OswaldSetPathAction(target)
  return 
end
LMR_MadDoctorAttic_SetHackTarget = function(target, hack)
  ClearNextPatrolNode(GetOswaldAI())
  Wait(0.10000000149011612)
  OswaldHackAction(hack)
  return 
end
Attic_SaveCheckpoint_Hacks = function(hackbox)
  if (hackbox == "DontIgnore") then
    SaveCheckpoint(GetPlayer(), "LMR_Attic_LoadCheckpoint", "StartPositionMarker_Mickey 01", "StartPositionMarker_Oswald 01")
  end
  return 
end
LMR_MadDoctorAttic_ThinGenerator = function(target, spark, variable, action, camera, spawner, var2)
  if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
    Print(((("LMR VARIABLE IS: " .. variable) .. " and equal to ") .. tostring(GetGlobal(variable))))
    while true do
      if (not (GetGlobal(GetPrefabData(target).MachineStateGlobal) == 0)) then
        break
      end
      wait(0.10000000149011612)
    end
    if (GetGlobal(variable) == 1) then
      if (GetGlobal(GetPrefabData(target).MachineStateGlobal) ~= 2) then
        SetGlobal(variable, 0)
        SetGlobal("LMR_CageThinnerCount", (GetGlobal("LMR_CageThinnerCount") + 1))
        Print(("LMR_MadDoctorAttic_ThinGenerator LMR_CageThinnerCount++ to " .. tostring(GetGlobal("LMR_CageThinnerCount"))))
        if (GetGlobal("LMR_CageThinnerCount") == 1) then
          FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_GeneratorDestroyed1")
        elseif (GetGlobal("LMR_CageThinnerCount") == 2) then
          FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_GeneratorDestroyed3")
        elseif (GetGlobal("LMR_CageThinnerCount") == 3) then
          FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_GeneratorDestroyed4")
        end
        Disable(camera)
        ClearAllCameraAttributes(GetPlayer())
        Enable(spawner)
        SetGlobal(var2, 2)
      end
    else
      FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_GeneratorDestroyed2")
    end
  end
  return 
end
LMR_MadDoctorAttic_DestroyMachines = function(target, machine, effect1, effect2)
  StartEmitters(effect1)
  return 
end
LMR_MadDoctorAttic_DamageVault = function(target, action)
  if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
    if (LMR_Attic_ManageLoad == 0) then
      ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
      Rumble(nil, 1)
      Rumble(nil, 1, 1)
      AudioPostEventOn("lmr_maddoctorattic_01a_audio.Snd_Vault", "Play_sfx_MDA_vaultDoor_explosion")
      StartEmitters("lmr_maddoctorattic_01a_scripting.Stage_VaultDestroyFX 01")
      Wait(0.5)
      StopEmitters("lmr_maddoctorattic_01a_scripting.Stage_VaultDestroyFX 01")
    end
    if (GetGlobal("LMR_VaultHealth") ~= 0) then
      LMR_MadDoctorAttic_MoveCages(target, action)
    end
  end
  return 
end
LMR_MadDoctorAttic_OpenVault = function(target, action)
  Quest_SetCriticalPath("Critical_Attic", "Critical_Attic_3")
  if (GetGlobal("LMR_VaultHealth") == 0) then
    TimerDisable("lmr_maddoctorattic_01a_scripting.GremlinCage_HintTimer 01")
    if (action ~= "restored") then
      if (action == "destroyed") then
        DestroyEntity(target)
        AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_VaultDoor", "fall")
        TeleportToEntity("Attic_HiddenPhotoMarker01", "Attic_PhotoMarkerDestination01")
        TeleportToEntity("Attic_HiddenPhotoMarker02", "Attic_PhotoDestination02")
        DoStinger("Comment_Dest", 5)
        SetPropertyBool("lmr_maddoctorattic_01a_scripting.LMR_VaultDoor", "Start Active", true)
        SetGlobal("LMR_TheAttic_VaultState", 2)
      end
    end
  end
  return 
end
LMR_AtticGremlinOpenVault = function()
  Quest_SetCriticalPath("Critical_Attic", "Critical_Attic_3")
  TimerDisable("lmr_maddoctorattic_01a_scripting.GremlinCage_HintTimer 01")
  AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_VaultDoor", "open")
  TeleportToEntity("Attic_HiddenPhotoMarker01", "Attic_PhotoMarkerDestination01")
  TeleportToEntity("Attic_HiddenPhotoMarker02", "Attic_PhotoDestination02")
  DoStinger("Comment_Rest", 5)
  SetGlobal("Attic_MarkusStandNearVault", 2)
  SetGlobal("LMR_TheAttic_VaultState", 1)
  LMR_Attic_SaveCheckpoint()
  return 
end
LMR_HackEnabled01 = 0
LMR_HackEnabled02 = 0
LMR_HackEnabled03 = 0
LMR_PlatformPosition02 = 0
LMR_PlatformPosition03 = 0
LMR_MadDoctorAttic_ToggleHackPanel = function(target, action, hack, prefab, variable, check, check2, emitter)
  if (action == "painted") then
    _G[check2] = 1
    StopEmitters(emitter)
    if (_G[variable] == 1) then
      Enable(hack)
      if (check == "none") then
        ForEachEntityInGroup(Unhide, prefab)
      elseif (_G[check] == 1) then
        ForEachEntityInGroup(Unhide, prefab)
        if (variable == GetGlobal("LMR_GeneratorStatus03")) then
          ForEachEntityInGroup(Unhide, prefab)
        else
          FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_GeneratorDisabled2")
          if (action == "thinned") then
            _G[check2] = 0
            StartEmitters(emitter)
            Disable(hack)
            ForEachEntityInGroup(Hide, prefab)
          end
        end
      end
    elseif (variable == GetGlobal("LMR_GeneratorStatus03")) then
      ForEachEntityInGroup(Unhide, prefab)
    else
      FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_GeneratorDisabled2")
      if (action == "thinned") then
        _G[check2] = 0
        StartEmitters(emitter)
        Disable(hack)
        ForEachEntityInGroup(Hide, prefab)
      end
    end
  elseif (action == "thinned") then
    _G[check2] = 0
    StartEmitters(emitter)
    Disable(hack)
    ForEachEntityInGroup(Hide, prefab)
  end
  return 
end
LMR_HackboxPosition = 0
LMR_MadDoctorAttic_ActivateHackPlatform = function(target, action, group)
  if (action == "painted") then
    LMR_PlatformPosition03 = 1
    ForEachEntityInGroup(Enable, group)
    if (GetGlobal("LMR_GeneratorStatus03") == 1) then
      Enable("lmr_maddoctorattic_01a_scripting.HackBox_CameraTrigger 03")
    end
    if (LMR_HackEnabled03 == 1) then
      ForEachEntityInGroup(Unhide, "HiddenOswald_Generator3")
    end
    if (LMR_HackboxPosition == 0) then
      AnimGBSequence("HackPanel_Door 01", "open")
    end
    SetSplineFollowerInitialSpeed("lmr_maddoctorattic_01a_scripting.LMR_Platform_01a_inert 01", 2)
  elseif (action == "thinned") then
    LMR_PlatformPosition03 = 0
    ForEachEntityInGroup(Disable, group)
    ForEachEntityInGroup(Hide, "HiddenOswald_Generator3")
    if (GetGlobal("LMR_GeneratorStatus03") == 1) then
      Disable("lmr_maddoctorattic_01a_scripting.HackBox_CameraTrigger 03")
      ClearAllCameraAttributes(GetPlayer())
    end
    SetSplineFollowerInitialSpeed("lmr_maddoctorattic_01a_scripting.LMR_Platform_01a_inert 01", 1)
  end
  Reverse("lmr_maddoctorattic_01a_scripting.LMR_Platform_01a_inert 01")
  return 
end
LMR_MadDoctorAttic_HackPanelDoor = function(target, action)
  if (action == "extend") then
    LMR_HackboxPosition = 1
    AnimGBSequence("HackPanel_Door 01", "close002")
  elseif (action == "retract") then
    if (LMR_HackboxPosition == 1) then
      AnimGBSequence("HackPanel_Door 01", "open")
    end
  elseif (action == "rest") then
    LMR_HackboxPosition = 0
    AnimGBSequence("HackPanel_Door 01", "close002")
  end
  return 
end
LMR_MadDoctorAttic_PaintHackPlatform = function(target)
  local before = 0
  local after = 0
  after = --[[ return 2 of ]] Jigsaw_GetPercentagePainted(target)
  before = Jigsaw_GetPercentagePainted(target)
  if (after == 1) then
    LMR_PlatformPosition02 = 1
    Enable("lmr_maddoctorattic_01a_scripting.HackBox_CameraTrigger 02")
    if (LMR_HackEnabled02 == 1) then
      if (GetGlobal("LMR_GeneratorStatus02") == 1) then
        ForEachEntityInGroup(Unhide, "HiddenOswald_Generator2")
      end
    end
  else
    LMR_PlatformPosition02 = 0
    Disable("lmr_maddoctorattic_01a_scripting.HackBox_CameraTrigger 02")
    ForEachEntityInGroup(Hide, "HiddenOswald_Generator2")
  end
  return 
end
LMR_MadDoctorAttic_TeleportOswaldHackBox = function(marker, hack, check)
  ClearNextPatrolNode(GetOswaldAI())
  OswaldClearGlideTargetsAction()
  Wait(1)
  if (check == GetGlobal("LMR_GeneratorStatus03")) then
    if (GetGlobal("LMR_GeneratorStatus03") == 0) then
      if (LMR_StagePlatformToon01 == 0) then
        if (LMR_StagePlatformToon02 == 0) then
          if (0 < LMR_StagePlatformHealth) then
            OswaldAddBoomerangTarget("lmr_maddoctorattic_01a_scripting.Stage_ChainsLock 01")
            OswaldAddBoomerangTarget("lmr_maddoctorattic_01a_scripting.Stage_ChainsLock 02")
            Wait(0.5)
            OswaldBoomerangAction()
          elseif (LMR_StagePlatformHealth == 0) then
            OswaldSetPathAction("GlideStart_MovingPlatform")
            Print("Why aren't you gliding?")
            FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_Oswald", "LMR_TheAttic_Oswald_DoWhat")
            if (_G[check] == 1) then
              Print("OswaldHackAction - Spot1")
              OswaldHackAction(hack)
            end
          end
        end
      else
        FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_Oswald", "LMR_TheAttic_Oswald_DoWhat")
        if (_G[check] == 1) then
          Print("OswaldHackAction - Spot1")
          OswaldHackAction(hack)
        end
      end
    end
  elseif (_G[check] == 1) then
    Print("OswaldHackAction - Spot1")
    OswaldHackAction(hack)
  end
  return 
end
Attic_StopOswald_Hack01Success = function()
  SetPropertyBool("SpawnerHackNode01", "ActionSpotEnabled", false)
  return 
end
LMR_MadDoctorAttic_ActivateWires = function(target, timer)
  AnimGBSequence(target, "wiggle")
  TimerEnable(timer)
  return 
end
LMR_WireTimerState01 = 0
LMR_WireTimerState02 = 0
LMR_WireTimerState03 = 0
LMR_MadDoctorAttic_WireTimer = function(target, variable, volume, emitter)
  if (_G[variable] == 0) then
    _G[variable] = 1
    Enable(volume)
    StartEmitters(emitter)
  elseif (_G[variable] == 1) then
    _G[variable] = 0
    Disable(volume)
    StopEmitters(emitter)
  end
  return 
end
local AnimDownInAction = 0
LMR_MadDoctorAttic_MoveCages = function(target, _State)
  Print("LMR_MadDoctorAttic_MoveCages function entered")
  local data = GetPrefabData(target)
  local LMR_CagePosition_global = GetGlobal("LMR_CagePosition")
  if (GetGlobal("LMR_VaultHealth") == 0) then
    ForceInterruptSequence("ProjectorToAutotopia", "LMR_TheAtticEntranceProjector")
    ForceInterruptSequence("ProjectorToAutotopia", "Global_Gus_BacktoCinema")
    Print("LMR_MadDoctorAttic_MoveCages LMR_VaultHealth is 0")
    if (GetGlobal("LMR_CageThinnerCount") < GetGlobal("LMR_CagePaintCount")) then
      SetGlobal("LMR_TheAttic_Generator01", 2)
      SetGlobal("LMR_TheAttic_Generator02", 2)
      SetGlobal("LMR_TheAttic_Generator03", 2)
      SetGlobal("MSN_Markus_RescueGremlinsTracker", (GetGlobal("MSN_Markus_RescueGremlinsTracker") + 1))
      if (data.CheckpointFunction[2] == "Attic_Spawner01") then
        Print("########### Attic_SaveCheckpoint_Hacks  Attic_Spawner01 ####")
        Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner01", "Hacked")
      elseif (data.CheckpointFunction[2] == "Attic_Spawner02") then
        Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner02", "Hacked")
      elseif (data.CheckpointFunction[2] == "Attic_Spawner03") then
        Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner03", "Hacked")
      end
      Print("LMR_MadDoctorAttic_MoveCages LMR_CagePaintCount is >")
      Enable("lmr_maddoctorattic_01a_scripting.Cage_KnockbackVolume 01")
      ForEachEntityInGroup(StartEmitters, "ElectricWaves")
      wait(0.4000000059604645)
      ForEachEntityInGroup(Kill, "Attic_Crawler")
      wait(0.20000000298023224)
      ForEachEntityInGroup(StopEmitters, "ElectricWaves")
      ForEachEntityInGroup(Kill, "Attic_Pirate")
      wait(0.20000000298023224)
      ForEachEntityInGroup(Kill, "Attic_Cannon")
      wait(2)
      ForEachEntityInGroup(DestroyEntity, "Attic_Crawler")
      ForEachEntityInGroup(DestroyEntity, "Attic_Pirate")
      ForEachEntityInGroup(DestroyEntity, "Attic_Cannon")
      SetPropertyBool(GetPlayer(), "ForceInvulnerable", true)
      SetPropertyBool(GetPlayer2OrAI(PLAYER_TWO), "ForceInvulnerable", true)
      StartFadeOut(0.5)
      wait(0.6000000238418579)
      StartScriptedIGC()
      TeleportToEntity(GetPlayer(), "FancyCamTeleport_Mickey")
      TeleportToEntity(GetPlayer2OrAI(PLAYER_TWO), "FancyCamTeleport_Oswald")
      wait(0.10000000149011612)
      FireUser1("GremlinGlobeFancyCam1")
      wait(1.5)
      AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "leftDown003", true)
      while true do
        if (not (AnimDownInAction == 0)) then
          break
        end
        wait(0.10000000149011612)
      end
      AnimGBSequence("GremlinSnowglobe", "break")
      ForEachEntityInGroup(StopEmitters, "GlobeSnow")
      GiveCollectible("Gremlin_EP3_Rescued")
      GiveCollectible("Challenge_WhoLeftThese_Tracker")
      if (GetCurrentCount("Gremlin_EP3_Rescued") == 3) then
        Quest_SetStatus("Operation_Gremlin", "Operation_Gremlin_3", Quest_TurnIn, true)
      end
      Print("LMR_MadDoctorAttic_MoveCages past break")
      SetPropertyBool("LMR_GremlinMarkus", "InvulnerableToPaintThinner", false)
      SetVulnerability("LMR_GremlinMarkus", ST_PAINT, 1)
      SetVulnerability("LMR_GremlinMarkus", ST_THINNER, 1)
      TeleportGremlinToEntity("LMR_GremlinMarkus", "FancyCamTeleport_Markus1")
      wait(1)
      AnimVarInt("LMR_GremlinMarkus", VAR_Mood_Type, MOOD_Positive)
      ForceSequence("LMR_GremlinMarkus", "LMR_TheAtticRescued", 1)
      SetPropertyBool(GetPlayer(), "ForceInvulnerable", false)
      SetPropertyBool(GetPlayer2OrAI(PLAYER_TWO), "ForceInvulnerable", false)
    elseif (GetGlobal("LMR_CagePaintCount") < GetGlobal("LMR_CageThinnerCount")) then
      Print("LMR_MadDoctorAttic_MoveCages LMR_CageThinnerCount is >")
      SetGlobal("LMR_TheAttic_Generator01", 1)
      SetGlobal("LMR_TheAttic_Generator02", 1)
      SetGlobal("LMR_TheAttic_Generator03", 1)
      SetGlobal("Attic_Spawner01", 1)
      SetGlobal("Attic_Spawner02", 1)
      SetGlobal("Attic_Spawner03", 1)
      Enable("lmr_maddoctorattic_01a_scripting.Cage_KnockbackVolume 02")
      LMR_MadDoctorAttic_OpenVault(target, _State)
      AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "leftUp003", true)
      while true do
        if (not (AnimDownInAction == 0)) then
          break
        end
        wait(0.10000000149011612)
      end
      SetPropertyBool("CageRedChest", "InvulnerableToPaintThinner", false)
      FireThread(Prefab_ChestOpenable, "CageRedChest", "true")
      AnimGBSequence("ChestSnowglobe", "break")
      ForEachEntityInGroup(StopEmitters, "GlobeSnow")
      Print("LMR_MadDoctorAttic_MoveCages past break")
      if (GetGlobal("Attic_SpawnerHackBox02") == 2) then
        Print("##### DisableAndDeath Beetleworx_Spawner02 ######")
        Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner02", "Thinned")
      end
      if (GetGlobal("Attic_SpawnerHackBox01") == 2) then
        Print("##### DisableAndDeath Beetleworx_Spawner01 ######")
        Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner01", "Thinned")
      end
      if (GetGlobal("Attic_SpawnerHackBox03") == 2) then
        Print("##### DisableAndDeath Beetleworx_Spawner03 ######")
        Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner03", "Thinned")
      end
      FireSequence("LMR_GremlinMarkus", "LMR_TheAttic_Markus_CageUp3")
      if (_State == "Hacked") then
        Print(("LMR_MadDoctorAttic_MoveCages Hacked, LMR_CagePosition is " .. tostring(LMR_CagePosition_global)))
        if (LMR_CagePosition_global == 4) then
          AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "center")
        elseif (LMR_CagePosition_global == 3) then
          AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "leftDown001")
          SetPropertyBool("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "Start Active", true)
        elseif (LMR_CagePosition_global == 2) then
          AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "leftDown002")
        end
        SetGlobal("LMR_CagePosition", (LMR_CagePosition_global - 1))
        if (data.CheckpointFunction[2] == "Attic_Spawner01") then
          Print("########### Attic_SaveCheckpoint_Hacks  Attic_Spawner01 ####")
          Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner01", "Hacked")
        elseif (data.CheckpointFunction[2] == "Attic_Spawner02") then
          Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner02", "Hacked")
        elseif (data.CheckpointFunction[2] == "Attic_Spawner03") then
          Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner03", "Hacked")
        end
        Enable("Attic_GremlinCageStarter")
        Attic_SaveCheckpoint_Hacks("DontIgnore")
      elseif (_State == "DisableAndDeath") then
        Print(("LMR_MadDoctorAttic_MoveCages DisableAndDeath, LMR_CagePosition is " .. tostring(LMR_CagePosition_global)))
        if (LMR_CagePosition_global == 4) then
          AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "leftUp002")
        elseif (LMR_CagePosition_global == 3) then
          AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "leftUp001")
          SetPropertyBool("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "Start Active", true)
        elseif (LMR_CagePosition_global == 2) then
          AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "center")
        end
        SetGlobal("LMR_CagePosition", (LMR_CagePosition_global + 1))
        LMR_MadDoctorAttic_MarkusReaction(target, _State)
        if (GetGlobal("Attic_SpawnerHackBox02") == 2) then
          Print("##### DisableAndDeath Beetleworx_Spawner02 ######")
          Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner02", "Thinned")
        end
        if (GetGlobal("Attic_SpawnerHackBox01") == 2) then
          Print("##### DisableAndDeath Beetleworx_Spawner01 ######")
          Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner01", "Thinned")
        end
        if (GetGlobal("Attic_SpawnerHackBox03") == 2) then
          Print("##### DisableAndDeath Beetleworx_Spawner03 ######")
          Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner03", "Thinned")
        end
        Attic_SaveCheckpoint_Hacks("DontIgnore")
      end
    end
  elseif (_State == "Hacked") then
    Print(("LMR_MadDoctorAttic_MoveCages Hacked, LMR_CagePosition is " .. tostring(LMR_CagePosition_global)))
    if (LMR_CagePosition_global == 4) then
      AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "center")
    elseif (LMR_CagePosition_global == 3) then
      AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "leftDown001")
      SetPropertyBool("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "Start Active", true)
    elseif (LMR_CagePosition_global == 2) then
      AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "leftDown002")
    end
    SetGlobal("LMR_CagePosition", (LMR_CagePosition_global - 1))
    if (data.CheckpointFunction[2] == "Attic_Spawner01") then
      Print("########### Attic_SaveCheckpoint_Hacks  Attic_Spawner01 ####")
      Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner01", "Hacked")
    elseif (data.CheckpointFunction[2] == "Attic_Spawner02") then
      Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner02", "Hacked")
    elseif (data.CheckpointFunction[2] == "Attic_Spawner03") then
      Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner03", "Hacked")
    end
    Enable("Attic_GremlinCageStarter")
    Attic_SaveCheckpoint_Hacks("DontIgnore")
  elseif (_State == "DisableAndDeath") then
    Print(("LMR_MadDoctorAttic_MoveCages DisableAndDeath, LMR_CagePosition is " .. tostring(LMR_CagePosition_global)))
    if (LMR_CagePosition_global == 4) then
      AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "leftUp002")
    elseif (LMR_CagePosition_global == 3) then
      AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "leftUp001")
      SetPropertyBool("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "Start Active", true)
    elseif (LMR_CagePosition_global == 2) then
      AnimGBSequence("lmr_maddoctorattic_01a_scripting.LMR_madDoctorAttic_01a_cage_inert_01a 01", "center")
    end
    SetGlobal("LMR_CagePosition", (LMR_CagePosition_global + 1))
    LMR_MadDoctorAttic_MarkusReaction(target, _State)
    if (GetGlobal("Attic_SpawnerHackBox02") == 2) then
      Print("##### DisableAndDeath Beetleworx_Spawner02 ######")
      Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner02", "Thinned")
    end
    if (GetGlobal("Attic_SpawnerHackBox01") == 2) then
      Print("##### DisableAndDeath Beetleworx_Spawner01 ######")
      Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner01", "Thinned")
    end
    if (GetGlobal("Attic_SpawnerHackBox03") == 2) then
      Print("##### DisableAndDeath Beetleworx_Spawner03 ######")
      Prefab_BeetleworxSpawner_Base_ChangeState("Beetleworx_Spawner03", "Thinned")
    end
    Attic_SaveCheckpoint_Hacks("DontIgnore")
  end
  return 
end
Attic_Spawner01Thinned = function()
  SetGlobal("Attic_SpawnerHackBox01", 2)
  SetGlobal("Attic_Spawner01", 1)
  return 
end
Attic_Spawner02Thinned = function()
  SetGlobal("Attic_SpawnerHackBox02", 2)
  SetGlobal("Attic_Spawner02", 1)
  return 
end
Attic_Spawner03Thinned = function()
  SetGlobal("Attic_SpawnerHackBox03", 2)
  SetGlobal("Attic_Spawner03", 1)
  return 
end
LMR_MadDoctorAttic_BreakCage = function(target)
  Print(("LMR_MadDoctorAttic_BreakCage function entered, target is " .. tostring(GetName(target))))
  AnimDownInAction = 1
  ForEachEntityInGroup(Disable, "CageDamageVolumes")
  AudioPostEventOn("lmr_maddoctorattic_01a_audio.Snd_Cage_Break", "Play_sfx_MDA_cage_break")
  return 
end
LMR_MadDoctorAttic_MarkusToVault = function()
  SetGlobal("Attic_MarkusStandNearVault", 1)
  SetVulnerability("LMR_GremlinMarkus", ST_PAINT, 1)
  SetVulnerability("LMR_GremlinMarkus", ST_THINNER, 1)
  FireThread(TeleportGremlinToEntity, "LMR_GremlinMarkus", "MarkusTeleportSpot")
  FireUser1("GremlinGlobeFancyCam2")
  wait(3)
  LMR_Attic_SaveCheckpoint()
  FireUser3("GremlinGlobeFancyCam3")
  Wait(0.800000011920929)
  CameraReset()
  return 
end
LMR_MadDoctorAttic_MarkusReaction = function(target, _State)
  if (_State == "Hacked") then
    if (GetGlobal("LMR_CagePaintCount") == 1) then
      FireSequence("LMR_GremlinMarkus", "LMR_TheAttic_Markus_CageDown1")
    elseif (GetGlobal("LMR_CagePaintCount") == 2) then
      FireSequence("LMR_GremlinMarkus", "LMR_TheAttic_Markus_CageDown2")
      if (_State == "DisableAndDeath") then
        if (GetGlobal("LMR_CageThinnerCount") == 1) then
          FireSequence("LMR_GremlinMarkus", "LMR_TheAttic_Markus_CageUp1")
        elseif (GetGlobal("LMR_CageThinnerCount") == 2) then
          FireSequence("LMR_GremlinMarkus", "LMR_TheAttic_Markus_CageUp2")
        end
      end
    end
  elseif (_State == "DisableAndDeath") then
    if (GetGlobal("LMR_CageThinnerCount") == 1) then
      FireSequence("LMR_GremlinMarkus", "LMR_TheAttic_Markus_CageUp1")
    elseif (GetGlobal("LMR_CageThinnerCount") == 2) then
      FireSequence("LMR_GremlinMarkus", "LMR_TheAttic_Markus_CageUp2")
    end
  end
  return 
end
LMR_MadDoctorAttic_ActivateSpawners = function()
  FireUser2("Beetleworx_Spawner01")
  FireUser2("Beetleworx_Spawner02")
  FireUser2("Beetleworx_Spawner03")
  Wait(1)
  BWX_Spawner_Activate("Beetleworx_Spawner02", 1)
  Wait(1)
  BWX_Spawner_Activate("Beetleworx_Spawner01", 1)
  Wait(1)
  BWX_Spawner_Activate("Beetleworx_Spawner03", 1)
  return 
end
LMR_MadDoctorAttic_PopUpObjects = function(target, group, sequence, variable)
  Print("########## LMR_MadDoctorAttic_PopUpObjects")
  if (group == "oswald") then
    Print("########## LMR_MadDoctorAttic_PopUpObjects OSWALD")
    if (sequence == "up") then
      DisableMotion("Attic_PopUp_OswaldCouch")
      SetPropertyFloat("Attic_PopUp_OswaldCouch", "UsableRadius", 0)
      AnimGBSequence("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpMachine_inert_01a 01", "popUp")
      SetPropertyBool("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpMachine_inert_01a 01", "Start Active", true)
      AnimGBSequence("LMR_Animated_OswaldCutout", "up")
      SetPropertyBool("LMR_Animated_OswaldCutout", "Start Active", true)
    elseif (sequence == "down") then
      AnimGBSequence("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpMachine_inert_01a 01", "rest001")
      SetPropertyBool("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpMachine_inert_01a 01", "Start Active", true)
      AnimGBSequence("LMR_Animated_OswaldCutout", "down")
      SetPropertyBool("LMR_Animated_OswaldCutout", "Start Active", true)
      if (group == "doctor") then
        Print("########## LMR_MadDoctorAttic_PopUpObjects DOCTOR")
        if (sequence == "up") then
          Print("########## LMR_MadDoctorAttic_PopUpObjects DOCTOR UP")
          DisableMotion("PopUpTab_Table")
          SetPropertyFloat("PopUpTab_Table", "UsableRadius", 0)
          AnimGBSequence("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpDesk_inert_01a 01", "popUp")
          SetPropertyBool("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpDesk_inert_01a 01", "Start Active", true)
          AnimGBSequence("LMR_Animated_MadDoctorCutOut", "up")
          SetPropertyBool("LMR_Animated_MadDoctorCutOut", "Start Active", true)
        elseif (sequence == "down") then
          Print("########## LMR_MadDoctorAttic_PopUpObjects DOCTOR DOWN")
          AnimGBSequence("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpDesk_inert_01a 01", "rest001")
          SetPropertyBool("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpDesk_inert_01a 01", "Start Active", true)
          AnimGBSequence("LMR_Animated_MadDoctorCutOut", "down")
          SetPropertyBool("LMR_Animated_MadDoctorCutOut", "Start Active", true)
          if (group == "tv") then
            Print("########## LMR_MadDoctorAttic_PopUpObjects TV")
          elseif (group == "trigger") then
            Print("########## LMR_MadDoctorAttic_PopUpObjects TRIGGER")
            if (GetGlobal(variable) == 1) then
              if (sequence == "one") then
                FireSequence("LMR_ConversationMarker_Oswald", "LMR_TheAttic_Oswald_OswaldCutOut")
              elseif (sequence == "two") then
                FireSequence("LMR_ConversationMarker_GusIntro", "LMR_TheAttic_Gus_DoctorCutOut")
              elseif (sequence == "three") then
                FireSequence("LMR_ConversationMarker_Prescott", "LMR_TheAttic_Prescott_ShowIntro")
              end
            end
          end
        end
      elseif (group == "tv") then
        Print("########## LMR_MadDoctorAttic_PopUpObjects TV")
      elseif (group == "trigger") then
        Print("########## LMR_MadDoctorAttic_PopUpObjects TRIGGER")
        if (GetGlobal(variable) == 1) then
          if (sequence == "one") then
            FireSequence("LMR_ConversationMarker_Oswald", "LMR_TheAttic_Oswald_OswaldCutOut")
          elseif (sequence == "two") then
            FireSequence("LMR_ConversationMarker_GusIntro", "LMR_TheAttic_Gus_DoctorCutOut")
          elseif (sequence == "three") then
            FireSequence("LMR_ConversationMarker_Prescott", "LMR_TheAttic_Prescott_ShowIntro")
          end
        end
      end
    end
  elseif (group == "doctor") then
    Print("########## LMR_MadDoctorAttic_PopUpObjects DOCTOR")
    if (sequence == "up") then
      Print("########## LMR_MadDoctorAttic_PopUpObjects DOCTOR UP")
      DisableMotion("PopUpTab_Table")
      SetPropertyFloat("PopUpTab_Table", "UsableRadius", 0)
      AnimGBSequence("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpDesk_inert_01a 01", "popUp")
      SetPropertyBool("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpDesk_inert_01a 01", "Start Active", true)
      AnimGBSequence("LMR_Animated_MadDoctorCutOut", "up")
      SetPropertyBool("LMR_Animated_MadDoctorCutOut", "Start Active", true)
    elseif (sequence == "down") then
      Print("########## LMR_MadDoctorAttic_PopUpObjects DOCTOR DOWN")
      AnimGBSequence("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpDesk_inert_01a 01", "rest001")
      SetPropertyBool("lmr_maddoctorattic_01a_art.LMR_madDoctorAttic_01a_popUpDesk_inert_01a 01", "Start Active", true)
      AnimGBSequence("LMR_Animated_MadDoctorCutOut", "down")
      SetPropertyBool("LMR_Animated_MadDoctorCutOut", "Start Active", true)
      if (group == "tv") then
        Print("########## LMR_MadDoctorAttic_PopUpObjects TV")
      elseif (group == "trigger") then
        Print("########## LMR_MadDoctorAttic_PopUpObjects TRIGGER")
        if (GetGlobal(variable) == 1) then
          if (sequence == "one") then
            FireSequence("LMR_ConversationMarker_Oswald", "LMR_TheAttic_Oswald_OswaldCutOut")
          elseif (sequence == "two") then
            FireSequence("LMR_ConversationMarker_GusIntro", "LMR_TheAttic_Gus_DoctorCutOut")
          elseif (sequence == "three") then
            FireSequence("LMR_ConversationMarker_Prescott", "LMR_TheAttic_Prescott_ShowIntro")
          end
        end
      end
    end
  elseif (group == "tv") then
    Print("########## LMR_MadDoctorAttic_PopUpObjects TV")
  elseif (group == "trigger") then
    Print("########## LMR_MadDoctorAttic_PopUpObjects TRIGGER")
    if (GetGlobal(variable) == 1) then
      if (sequence == "one") then
        FireSequence("LMR_ConversationMarker_Oswald", "LMR_TheAttic_Oswald_OswaldCutOut")
      elseif (sequence == "two") then
        FireSequence("LMR_ConversationMarker_GusIntro", "LMR_TheAttic_Gus_DoctorCutOut")
      elseif (sequence == "three") then
        FireSequence("LMR_ConversationMarker_Prescott", "LMR_TheAttic_Prescott_ShowIntro")
      end
    end
  end
  return 
end
LMR_MadDoctorAttic_ChangeWires = function(target, action, volume, emitter)
  local before = 0
  local after = 0
  after = --[[ return 2 of ]] Jigsaw_GetPercentagePainted(target)
  before = Jigsaw_GetPercentagePainted(target)
  if (action == "painted") then
    Disable(volume)
    StopEmitters(emitter)
  elseif (action == "thinned") then
    Enable(volume)
    StartEmitters(emitter)
  elseif (action == "jigsaw") then
    if (after < 1) then
      Enable(volume)
      ForEachEntityInGroup(StartEmitters, emitter)
    else
      Disable(volume)
      ForEachEntityInGroup(StopEmitters, emitter)
    end
  end
  return 
end
LMR_MadDoctorAttic_ToggleSeating = function(target, action)
  if (action == "painted") then
    SetGlobal("Attic_SaveStairs", 1)
    ActivateGremlinHint("Attic_GusHint01")
    ForEachEntityInGroup(StopEmitters, "StairWireSparkGroup")
    ForEachEntityInGroup(AnimGBSequence, "LMR_Animated_Audience", "up")
    AudioPostEventOn("lmr_maddoctorattic_01a_audio.Snd_Crowd_Popup", "Play_sfx_MDA_crowdPlatforms_up")
    ForEachEntityInGroup(SetPropertyBool, "LMR_Animated_Audience", "Start Active", true)
    FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_Seating")
    ForEachEntityInGroup(Enable, "StairCameraGroup")
    enableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 01.TargetToSend")
    enableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 02.TargetToSend")
    enableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 03.TargetToSend")
  elseif (action == "thinned") then
    SetGlobal("Attic_SaveStairs", 0)
    ForEachEntityInGroup(AnimGBSequence, "LMR_Animated_Audience", "down")
    AudioPostEventOn("lmr_maddoctorattic_01a_audio.Snd_Crowd_Popup", "Play_sfx_MDA_crowdPlatforms_down")
    ForEachEntityInGroup(StartEmitters, "StairWireSparkGroup")
    ForEachEntityInGroup(Disable, "StairCameraGroup")
    disableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 01.TargetToSend")
    disableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 02.TargetToSend")
    disableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 03.TargetToSend")
  end
  return 
end
LMR_StagePlatformToon01 = 1
LMR_StagePlatformToon02 = 1
LMR_StagePlatformHealth = 2
LMR_MadDoctorAttic_LowerStagePlatform = function(target)
  LMR_StagePlatformHealth = (LMR_StagePlatformHealth - 1)
  AnimGBSequence(target, "break")
  SetPropertyBool(target, "Start Active", true)
  if (LMR_StagePlatformHealth == 0) then
    Disable("Attic_BackdropAction")
    SetGlobal("LMR_TheAttic_LoweringPlatform", 1)
    AnimGBSequence("lmr_maddoctorattic_01a_scripting.Stage_BackDrop 01", "down")
    SetPropertyBool("lmr_maddoctorattic_01a_scripting.Stage_BackDrop 01", "Start Active", true)
    enableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 09.TargetToSend")
    Wait(0.5)
    OswaldSetPathAction("GlideStart_MovingPlatform")
  end
  return 
end
LMR_MadDoctorAttic_ToggleStageLocks = function(target, action, lock, variable)
  if (action == "painted") then
    _G[variable] = 1
  elseif (action == "thinned") then
    Unhide(lock)
    _G[variable] = 0
  end
  return 
end
Attic_LeftLock = 0
Attic_RightLock = 0
Attic_LeftLockPainted = function()
  Attic_LeftLock = 0
  Disable("Attic_BackdropAction")
  return 
end
Attic_RightLockPainted = function()
  Attic_RightLock = 0
  Disable("Attic_BackdropAction")
  return 
end
Attic_LeftLockThinned = function()
  Attic_LeftLock = 1
  Attic_BothLocksThinned()
  return 
end
Attic_RightLockThinned = function()
  Attic_RightLock = 1
  Attic_BothLocksThinned()
  return 
end
Attic_BothLocksThinned = function()
  if (Attic_LeftLock == 1) then
    if (Attic_RightLock == 1) then
      Enable("Attic_BackdropAction")
    end
  end
  return 
end
Attic_MakeOswaldBoomLocks = function()
  if (GetEntity("Attic_LeftInsideLock") ~= nil) then
    OswaldSingleTargetBoomerangAction("Attic_LeftInsideLock")
    Wait(2)
  end
  OswaldSingleTargetBoomerangAction("Attic_RightInsideLock")
  return 
end
LMR_SandbagState01 = 0
LMR_SandbagState02 = 0
LMR_BackdropState = 1
local StingerVar = 0
LMR_MadDoctorAttic_ToggleSandbags = function(target, action, variable)
  if (action == "painted") then
    _G[variable] = 1
    AnimGBSequence(target, "down")
    SetPropertyBool(target, "Start Active", true)
    LMR_BackdropState = (LMR_BackdropState + 1)
    if (LMR_BackdropState == 2) then
      AnimGBSequence("lmr_maddoctorattic_01a_scripting.Stage_BackDrop 02", "Pos1ToPos2")
      if (StingerVar == 0) then
        DoStinger("MDA_StingerTreasureReveal", 2)
        StingerVar = 1
      end
      SetPropertyBool("lmr_maddoctorattic_01a_scripting.Stage_BackDrop 02", "Start Active", true)
    elseif (LMR_BackdropState == 3) then
      AnimGBSequence("lmr_maddoctorattic_01a_scripting.Stage_BackDrop 02", "Pos2ToPos3")
      SetPropertyBool("lmr_maddoctorattic_01a_scripting.Stage_BackDrop 02", "Start Active", true)
      if (action == "thinned") then
        _G[variable] = 0
        AnimGBSequence(target, "up")
        LMR_BackdropState = (LMR_BackdropState - 1)
        if (LMR_BackdropState == 1) then
          AnimGBSequence("lmr_maddoctorattic_01a_scripting.Stage_BackDrop 02", "Pos2ToPos1")
        elseif (LMR_BackdropState == 2) then
          AnimGBSequence("lmr_maddoctorattic_01a_scripting.Stage_BackDrop 02", "Pos3ToPos2")
        end
      end
    end
  elseif (action == "thinned") then
    _G[variable] = 0
    AnimGBSequence(target, "up")
    LMR_BackdropState = (LMR_BackdropState - 1)
    if (LMR_BackdropState == 1) then
      AnimGBSequence("lmr_maddoctorattic_01a_scripting.Stage_BackDrop 02", "Pos2ToPos1")
    elseif (LMR_BackdropState == 2) then
      AnimGBSequence("lmr_maddoctorattic_01a_scripting.Stage_BackDrop 02", "Pos3ToPos2")
    end
  end
  return 
end
LMR_SpotlightState = 0
LMR_MadDoctorAttic_ToggleSpotlight = function()
  if (LMR_SpotlightState == 0) then
    LMR_SpotlightState = 1
    AnimGBSequence("lmr_maddoctorattic_01a_scripting.Stage_SpotlightSwitch 01", "on")
    Unhide("lmr_maddoctorattic_01a_scripting.Stage_Spotlight 01")
  elseif (LMR_SpotlightState == 1) then
    LMR_SpotlightState = 0
    AnimGBSequence("lmr_maddoctorattic_01a_scripting.Stage_SpotlightSwitch 01", "off")
    Hide("lmr_maddoctorattic_01a_scripting.Stage_Spotlight 01")
  end
  return 
end
LMR_MadDoctorAttic_MarkusHint = function()
  if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
    if (GetGlobal("LMR_TheAttic_DialoguePlayingCheck") == 0) then
      local LMR_VaultHealth_global = GetGlobal("LMR_VaultHealth")
      if (LMR_VaultHealth_global == 3) then
        FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_CageHint1")
      elseif (LMR_VaultHealth_global == 2) then
        FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_CageHint2")
      elseif (LMR_VaultHealth_global == 1) then
        FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_CageHint3")
        SetGlobal("LMR_TheAttic_DialoguePlayingCheck", 1)
        TimerDisable("lmr_maddoctorattic_01a_scripting.GremlinCage_HintTimer 01")
        TimerReset("lmr_maddoctorattic_01a_scripting.GremlinCage_HintTimer 01")
      end
    end
  else
    SetGlobal("LMR_TheAttic_DialoguePlayingCheck", 1)
    TimerDisable("lmr_maddoctorattic_01a_scripting.GremlinCage_HintTimer 01")
    TimerReset("lmr_maddoctorattic_01a_scripting.GremlinCage_HintTimer 01")
  end
  return 
end
LMR_MadDoctorAttic_ManageHintTimer = function(target, state)
  if (state == "start") then
    SetGlobal("LMR_TheAttic_DialoguePlayingCheck", 1)
    TimerDisable("lmr_maddoctorattic_01a_scripting.GremlinCage_HintTimer 01")
    TimerReset("lmr_maddoctorattic_01a_scripting.GremlinCage_HintTimer 01")
  elseif (state == "end") then
    SetGlobal("LMR_TheAttic_DialoguePlayingCheck", 0)
    TimerEnable("lmr_maddoctorattic_01a_scripting.GremlinCage_HintTimer 01")
  end
  return 
end
LMR_Costume01 = 0
LMR_Costume02 = 0
LMR_MadDoctorAttic_CostumeHint = function(target, variable)
  if (_G[variable] == 0) then
    if (GetGlobal("LMR_TheAttic_Gus_CostumeHint_Played") == 0) then
      FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_GusIntro", "LMR_TheAttic_Gus_CostumeHint")
    else
      FireSequence("lmr_maddoctorattic_01a_scripting.Marker(Conversation)_Oswald", "LMR_TheAttic_Oswald_CostumeHint")
    end
  end
  return 
end
LMR_MadDoctorAttic_CageKnockback = function(target)
  Enable(target)
  Wait(0.30000001192092896)
  Disable(target)
  return 
end
LMR_MadDoctorAttic_DisableSandbags = function(target, location)
  if (_activator() == _player()) then
    if (location == "inside") then
      ForEachEntityInGroup(SetPropertyBool, "ToonSandbagGroup", "Is Real", true)
    elseif (location == "outside") then
      ForEachEntityInGroup(SetPropertyBool, "ToonSandbagGroup", "Is Real", false)
    end
  end
  return 
end
LMR_MadDoctorAttic_DaisyQuestItem = function(target)
  if (IsAnySequencePlaying() == true) then
    wait(0.20000000298023224)
  end
  FireSequence("LMR_ConversationMarker_GusIntro", "LMR_TheAttic_Gus_DaisyItem")
  return 
end
LMR_MadDoctorAttic_CoOpTossManage = function(target, action)
  if (action == "paint") then
    Enable("Attic_SideTossMarker")
    ForEachEntityInGroup(Unhide, "HiddenOswald_CoOpToss01")
  elseif (action == "thin") then
    Disable("Attic_SideTossMarker")
    ForEachEntityInGroup(Hide, "HiddenOswald_CoOpToss01")
  end
  return 
end
LMR_MadDoctorAttic_CombatManage = function(target, location)
  if (location == "top") then
    OswaldStopFighting()
  elseif (location == "bottom") then
    OswaldStartFighting()
  end
  OswaldStartFollowAction()
  return 
end
LMR_MadDoctorAttic_RafterJumpsManage = function(target, action)
  if (action == "enable") then
    enableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 04.TargetToSend")
    enableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 05.TargetToSend")
    enableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 06.TargetToSend")
    enableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 07.TargetToSend")
  elseif (action == "disable") then
    disableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 04.TargetToSend")
    disableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 05.TargetToSend")
    disableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 06.TargetToSend")
    disableJumpVolumeAvailability("lmr_maddoctorattic_01a.prefab_jumpvolumeavailability 07.TargetToSend")
  end
  return 
end
LMR_GiveBallistaPin = function()
  GiveCollectible("Gremlin_Ballista")
  SetGlobal("Gremlin_Ballista_Pin", (GetGlobal("Gremlin_Ballista_Pin") + 1))
  return 
end
IGC_0320_AtticIntroWithMarkus_OuterDoorsOpen = function()
  AnimGBSequence(GetRelativePrefabEntity("Beetleworx_Spawner02", ".OuterDoors_Right"), "Open")
  AnimGBSequence(GetRelativePrefabEntity("Beetleworx_Spawner02", ".OuterDoors_Left"), "Open")
  return 
end
IGC_0320_AtticIntroWithMarkus_InnerDoorsOpen = function()
  AnimGBSequence(GetRelativePrefabEntity("Beetleworx_Spawner02", ".Orb"), "Open")
  AnimGBSequence(GetRelativePrefabEntity("Beetleworx_Spawner02", ".InnerDoors"), "Open")
  return 
end
IGC_0320_AtticIntroWithMarkus_OuterDoorsClose = function()
  AnimGBSequence(GetRelativePrefabEntity("Beetleworx_Spawner02", ".InnerDoors"), "Close")
  return 
end
IGC_0320_AtticIntroWithMarkus_InnerDoorsClose = function()
  AnimGBSequence(GetRelativePrefabEntity("Beetleworx_Spawner02", ".OuterDoors_Right"), "Close")
  return 
end
Attic_EMPDialogue = function()
  if (GetGlobal("LMR_TheAttic_Gus_EMPBlast_Played") == 0) then
    FireSequence("LMR_ConversationMarker_GusIntro", "LMR_TheAttic_Gus_EMPBlast")
  end
  return 
end
Attic_Visit2ProjectorSave = function()
  if (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
    wait(2)
    FireSequence("LMR_ConversationMarker_GusIntro", "LMR_TheAttic_Gus_Visit2")
  end
  return 
end
Attic_SpawnerMaster = function(target, _State)
  Print("Attic_SpawnerMaster Start")
  Print(("target: " .. tostring(GetName(target))))
  Print(("_State: " .. tostring(_State)))
  local data = GetPrefabData(target)
  Wait(0.25)
  if (_State == "Hacked") then
    Print("LMR Attic_SpawnerMaster: State = Hacked")
    SetGlobal("LMR_VaultHealth", (GetGlobal("LMR_VaultHealth") - 1))
    SetGlobal("LMR_CagePaintCount", (GetGlobal("LMR_CagePaintCount") + 1))
    LMR_MadDoctorAttic_MoveCages(target, _State)
  elseif (_State == "DisableAndDeath") then
    Print(("BWX Num Spawned = " .. tostring(data.BeetleworxNumSpawned[1])))
    Print(("BWX MachineStateGlobal = " .. tostring(data.MachineStateGlobal)))
    if (data.BeetleworxNumSpawned[1] == 0) then
      if (GetGlobal(data.MachineStateGlobal) == 2) then
        return 
      end
      Print("LMR Attic_SpawnerMaster: State = DisableAndDeath : the spawner is disabled and has no more live AI")
      if (string.find(data.MachineStateGlobal, "1") ~= nil) then
        SetGlobal("LMR_BWXSpawner1_DestComplete", 1)
        SetGlobal("Attic_SpawnerHackBox01", 2)
      elseif (string.find(data.MachineStateGlobal, "2") ~= nil) then
        SetGlobal("LMR_BWXSpawner2_DestComplete", 1)
        SetGlobal("Attic_SpawnerHackBox02", 2)
      elseif (string.find(data.MachineStateGlobal, "3") ~= nil) then
        SetGlobal("LMR_BWXSpawner3_DestComplete", 1)
        SetGlobal("Attic_SpawnerHackBox03", 2)
      end
      SetGlobal("LMR_VaultHealth", (GetGlobal("LMR_VaultHealth") - 1))
      LMR_MadDoctorAttic_MoveCages(target, _State)
    end
  end
  if (GetGlobal("LMR_VaultHealth") == 0) then
    local VaultThinned = 0
    if (GetGlobal("LMR_BWXSpawner1_DestComplete") == 1) then
      VaultThinned = (VaultThinned + 1)
    end
    if (GetGlobal("LMR_BWXSpawner2_DestComplete") == 1) then
      VaultThinned = (VaultThinned + 1)
    end
    if (GetGlobal("LMR_BWXSpawner3_DestComplete") == 1) then
      VaultThinned = (VaultThinned + 1)
    end
    if (2 <= VaultThinned) then
      LMR_MadDoctorAttic_OpenVault(target, "destroyed")
    end
  end
  return 
end
Attic_MoveGremlinToExit = function()
  if (GetGlobal("Attic_MarkusStandNearVault") == 1) then
    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
      Print("######################### MOVE GREMLIN RELOAD")
      EnableMotion("LMR_GremlinMarkus")
      Wait(0)
      MoveToEntity("LMR_GremlinMarkus", "MarkusTeleportSpot")
      AnimVarInt("LMR_GremlinMarkus", VAR_Mood_Type, MOOD_Positive)
    end
  elseif (GetGlobal("Attic_MarkusStandNearVault") == 2) then
    Hide("LMR_GremlinMarkus")
  end
  return 
end
Attic_ExitCameraMaster = function()
  if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
    StartFadeOut(0.5)
    Wait(0.5)
    PlayMovie(GetPlayer(), "PH_3_3_Rise_of_Mad_Doctor.bik")
    GiveCollectibleNoPopup("Film_PH3_3")
    SetGlobal("LMR_TheAttic_VisitNumber", 2)
    Wait(0.10000000149011612)
    StartFadeIn(0)
    ShowHud()
    LoadLevel(GetPlayer(), "MST_NewRide.upper")
  else
    Mickey_Projector_Enter()
  end
  return 
end
Attic_LockGremlinToCage = function()
  if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
    if (GetGlobal("LMR_TheAttic_Gus_Hint1_Played") == 0) then
      DisableMotion("LMR_GremlinMarkus")
      DriveMotionWithPhysics("LMR_GremlinMarkus")
      Wait(0.10000000149011612)
      Unhide("LMR_GremlinMarkus")
      wait(0.10000000149011612)
      SetParentEntity("LMR_GremlinMarkus", "lmr_maddoctorattic_01a_scripting.GremlinCage_AttachMarker 01")
    end
  end
  return 
end
Attic_TankerAIHintCheck = function(target)
  if (GetCurrentTeam(target) == 3) then
    ForEachEntityInGroup(AIHintEnable, "TankerTargetGroup", false)
  else
    ForEachEntityInGroup(AIHintEnable, "TankerTargetGroup", true)
  end
  return 
end

