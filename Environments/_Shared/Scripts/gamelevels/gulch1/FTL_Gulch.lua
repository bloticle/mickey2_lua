local FTL_BallsLoaded = 0
local FTL_Gulch_GeysersPainted = 2
local Gulch_LoaderNoRes_LoaderVar = 0
local Gulch_LoaderNoRes_BallVar = 0
FTL_Gulch_Setup = function(target)
  Print("!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Setup")
  StartFadeOut(0)
  math.randomseed(os.time())
  if (GetGlobal("FTL_Gulch_IntroPlayed") == 0) then
    if (MostRecentCheckpointCallback == "FTL_Gulch_Setup") then
      Print("!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Intro - VISIT 1: MostRecentCheckpointCallback == FTL_Gulch_Setup  so we must have quit during the intro IGC, refiring IGC")
      RestrictCutSceneInput()
    end
  end
  DestroyEntity("Trigger_FTL_Gulch_Visit_Setup")
  if (GetGlobal("FTL_WaterTowerCollapsed") ~= 1) then
    local (for index), (for limit), (for step) = 1, 4, 1
    for i = (for index), (for limit), (for step) do
      disableJumpVolumeAvailability(("Jump_WaterTower" .. i))
    end
    DisableComponent("TrainBall3", "Usable")
  else
    AudioPostEventOn("ftl_gulch_01a_audio.SND_amb_wolfFalls", "Play_sfx_dg1_waterfall_lp")
  end
  if (GetGlobal("FTL_Gulch_SaloonCollapse_Played") == 1) then
    enableJumpVolumeAvailability("JV_SaloonAlcove")
    ForEachEntityInGroup(Enable, "Trigger_SaloonAIAvoidance")
  end
  Enable("Trigger_ElevatorSphereCheck_Sphere_Checkpoint")
  if (GetPropertyInt("SaloonDoors", "Active Sequence ID") ~= 0) then
    ForEachEntityInGroup(Disable, "Triggers_Fall_OpenSaloonDoors")
    ForEachEntityInGroup(Disable, "Trigger_AIBlocker_Saloon")
  end
  if Quest_CheckStatus("Thanks_Memories", "Thanks_Memories_2b", Quest_Discovered) then
    Print("FTL_Gulch_LabSetup: Enabling Memories Train Quest Photo Marker")
    SetMapMarkerVisible("PM_Photo_Train", true)
    Enable("PM_Photo_Train")
  end
  if (GetGlobal("FTL_Gulch_TrainPlaceBall_Played") == 1) then
    EnableGuardianHint("GusHint_Exit")
    SetMapMarkerVisible("MapMarker_Exit", true)
  end
  FTL_BallsLoaded = 0
  local (for index), (for limit), (for step) = 1, 3, 1
  for i = (for index), (for limit), (for step) do
    (for index) = GetGlobal
    (for limit) = "FTL_Gulch_TrainCart"
    (for step) = i
    i = "State"
    (for limit) = (((for limit) .. (for step)) .. i)
    (for index) = (for index)((for limit))
    if ((for index) == 0) then
      (for limit) = AnimGBSequence
      (for step) = "FTL_ballDispenser_0"
      i = i
      (for step) = ((for step) .. i)
      i = "rest"
      (for limit)((for step), i)
      (for limit) = SetGlobal
      (for step) = "FTL_Gulch_TrainCart"
      i = i
      TrainCartGlobal = "State"
      (for step) = (((for step) .. i) .. TrainCartGlobal)
      i = 0
      (for limit)((for step), i)
    end
    (for limit) = GetGlobal
    (for step) = "FTL_Gulch_Ball0"
    i = (for index)
    TrainCartGlobal = "State"
    (for step) = (((for step) .. i) .. TrainCartGlobal)
    (for limit) = (for limit)((for step))
    if ((for limit) ~= -1) then
      (for limit) = GetGlobal
      (for step) = "FTL_Gulch_Ball0"
      i = (for index)
      TrainCartGlobal = "State"
      (for step) = (((for step) .. i) .. TrainCartGlobal)
      (for limit) = (for limit)((for step))
    else
      if ((for index) == 2) then
        (for limit) = SetPropertyInt
        (for step) = "TrainBall2"
        i = "Bone Attach Rotate Mode"
        TrainCartGlobal = 4
        (for limit)((for step), i, TrainCartGlobal)
      end
      (for limit) = SetGlobal
      (for step) = "FTL_Gulch_Ball0"
      i = (for index)
      TrainCartGlobal = "State"
      (for step) = (((for step) .. i) .. TrainCartGlobal)
      i = 2
      (for limit)((for step), i)
      (for limit) = SetPropertyString
      (for step) = "TrainBall"
      i = (for index)
      (for step) = ((for step) .. i)
      i = "Bone Attach Name"
      TrainCartGlobal = "bone"
      (for limit)((for step), i, TrainCartGlobal, 0)
      (for limit) = SetParentEntity
      (for step) = "TrainBall"
      i = (for index)
      (for step) = ((for step) .. i)
      i = "FTL_ballDispenser_0"
      TrainCartGlobal = i
      i = (i .. TrainCartGlobal)
      (for limit)((for step), i)
      (for limit) = Print
      (for step) = "!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Setup: Attached TrainBall"
      i = (for index)
      TrainCartGlobal = " to bone"
      (for step) = (((for step) .. i) .. TrainCartGlobal)
      (for limit)((for step))
      (for limit) = FTL_BallsLoaded
      (for limit) = ((for limit) + 1)
      FTL_BallsLoaded = (for limit)
    end
    (for limit) = GetGlobal
    (for step) = "FTL_Gulch_Ball0"
    i = i
    TrainCartGlobal = "State"
    (for step) = (((for step) .. i) .. TrainCartGlobal)
    (for limit) = (for limit)((for step))
    if ((for limit) == 4) then
      (for limit) = IsValidHandle
      (for step) = "TrainBall"
      i = i
      (for step) = ((for step) .. i)
      (for limit) = (for limit)((for step))
      if (for limit) then
        (for limit) = DestroyEntity
        (for step) = "TrainBall"
        i = i
        (for step) = ((for step) .. i)
        (for limit)((for step))
        (for limit) = SetMapMarkerVisible
        (for step) = "GusHint_TrainBall"
        i = i
        (for step) = ((for step) .. i)
        i = false
        (for limit)((for step), i)
        (for limit) = Print
        (for step) = "!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Setup: Destroying Entity TrainBall"
        i = i
        (for step) = ((for step) .. i)
        (for limit)((for step))
      end
    end
  end
  if (GetGlobal("FTL_Gulch_TrainCart4State") == 3) then
    ForEachEntityInPrefab(Hide, "RedChest_Caboose")
  elseif (GetGlobal("FTL_Gulch_DepositedBalls") == 3) then
    if (GetPropertyInt("TrainCar04", "Active Sequence ID") ~= 1) then
      AnimGBSequence("TrainCar04", "unload")
      SetGlobal("FTL_Gulch_TrainCart4State", 2)
    end
  end
  if (GetGlobal("FTL_Gulch_TrainCart4State") == 2) then
    GetPrefabData("RedChest_Caboose").ChestDisabled = "False"
    SetPropertyBool("RedChest_Caboose", "Is Real", false)
  end
  if (GetPropertyInt("MineElevator", "Active Sequence ID") ~= 0) then
    FireThread(Prefab_OswaldElectricSwitch_ChangeState, "ElevatorSwitch", "FullyCharged")
    FTL_MineElevatorRunning()
  end
  if (GetPropertyInt("FTL_Gulch_DancingRocks_Inert", "Active Sequence ID") == 2) then
    AnimGBSequence("FTL_Gulch_DancingRocks_Inert", "rest")
  end
  FTL_Gulch_GeysersPainted = 0
  local (for index), (for limit), (for step) = 1, 8, 1
  for i = (for index), (for limit), (for step) do
    if GetPropertyBool((("ftl_gulch_01a_canyon_scripting.geyserjunksteamer 0" .. i) .. ".FTL_geyserJunk_01a_toon"), "Is Painted") then
      FTL_Gulch_GeysersPainted = (FTL_Gulch_GeysersPainted + 1)
    end
  end
  Print(("!!!!!!!!!!!!!!!!!!!!!!!!! FTL_Gulch_Setup: FTL_Gulch_GeysersPainted = " .. FTL_Gulch_GeysersPainted))
  FireUser1("FTL_Boulder_SF")
  Disable("Trigger_ElevatorSphereCheck_Sphere_Checkpoint")
  if (target == nil) then
    target = "Checkpoint"
    GetPrefabData("Projector_ToCavernsAngel").MapLoad_SetupPosition = "IgnoreMe"
  elseif (target == "DEC") then
    FTL_CurrentCheckpointLocation = "PM_DevilSideStart"
  end
  FTL_Gulch_Intro(target)
  return 
end
ValleyCheckpointMusic = function()
  MusicPostEventOn(GetPlayer(), "Play_MX_DG1_Valley")
  Print("Started valley music from start checkpoint")
  return 
end
FTL_Gulch_Visit_Setup = function(target, level, visit)
  Print("FTL_Gulch_Visit_Setup")
  StartFadeOut(0)
  DestroyEntity(target)
  if (visit == "v2") then
    if (GetGlobal("FTL_Gulch_IntroPlayed") == 0) then
      SetGlobal("EM2_EpisodeCheck", 2)
      SetGlobal("FTL_Gulch_IntroPlayed", 1)
      SetGlobal("FTL_Gulch_Ball01State", 1)
      SetGlobal("FTL_Gulch_Ball02State", 1)
      SetGlobal("FTL_Gulch_Ball03State", 1)
    end
  end
  Print(("FTL_Gulch_Visit_Setup global = " .. GetGlobal("EM2_EpisodeCheck")))
  if (level == "Canyon") then
    SetGlobal("FTL_Gulch_ProjectorExit", 0)
    if (GetGlobal("DEC_Hardload") == 0) then
      local Projector_Data = GetPrefabData("Projector_ToCavernsAngel")
      if (GetGlobal("FTL_Gulch_IntroPlayed") == 0) then
        if (visit ~= "v2") then
          Projector_Data.ToFlyThrough = "True"
          Projector_Data.SkipJumpOutAnim = true
        end
      end
      Projector_Data.MapLoad_SetupPosition = "True"
      SetGlobal("FTL_Gulch_StartLocation", 1)
    else
      local Projector_Data, Projector_Data = GetPrefabData("Projector_ToCavernsAngel"), "Projector_ToCavernsAngel"
      Projector_Data.MapLoad_SetupPosition = "IgnoreMe"
      Projector_Data.ExitFunction = "None"
      Projector_Data = GetPrefabData
      Projector_Data = Projector_Data("FoopToob_Gulch_ToDEC")
      local DEC_Data = "FoopToob_Gulch_ToDEC"
      DEC_Data = GetGlobal
      DEC_Data = DEC_Data("FTL_Gulch_IntroPlayed")
      if (DEC_Data == 0) then
        if (visit ~= "v2") then
          Projector_Data.SkipExitAnimationAndTeleport = "True"
          DEC_Data = {}
          DEC_Data[1] = "Fade"
          DEC_Data[2] = "UnpauseAI"
          Projector_Data.Finish_Skip = DEC_Data
        end
      end
      DEC_Data = Projector_Data.HardLoadExitFunction
      DEC_Data = DEC_Data[1]
      if (DEC_Data ~= "Busy") then
        DEC_Data = Projector_Data.HardLoadExitFunction
        DEC_Data[1] = "True"
        DEC_Data = Prefab_DECFoopToob_AlwaysSetup
        DEC_Data("FoopToob_Gulch_ToDEC")
      end
      DEC_Data = SetGlobal
      DEC_Data("FTL_Gulch_StartLocation", 2)
      if (level == "Lab") then
        local global, global = GetGlobal("FTL_Gulch_ProjectorExit"), "FTL_Gulch_StartLocation"
        global = global
        Print(("FTL_Gulch_Visit_Setup: FTL_Gulch_ProjectorExit = " .. global))
        if (global == -1) then
          global = 0
          SetGlobal("FTL_Gulch_ProjectorExit", global)
          global = 0
        end
        if (global ~= 0) then
          if (global == 1) then
            GetPrefabData("Projector_ToMadLab").MapLoad_SetupPosition = "True"
            if (GetGlobal("FTL_Gulch_DepositedBalls") == 3) then
              Hide("FTL_Gulch_SpiderDoor")
              global = 1
              FireThread(FTL_Gulch_SpiderDoorOpen_Cam, global)
            else
              Hide("FTL_Gulch_SpiderDoor")
              global = 2
              FireThread(FTL_Gulch_SpiderDoorOpen_Cam, global)
            end
            global = "Projector_ToMadLab"
            FireThread(OnMapLoad_ProjectorSetup, global)
          elseif (global == 2) then
            GetPrefabData("Projector_ToMadLabShort").MapLoad_SetupPosition = "True"
            global = "Projector_ToMadLabShort"
            FireThread(OnMapLoad_ProjectorSetup, global)
            global = "PM_LabSideStart_Mickey"
            TeleportToEntity(GetPlayer(), global)
            global = "PM_LabSideStart_Oswald"
            TeleportToEntity(GetPlayer2OrAI(), global)
            global = 4
            SetTargetTeam("FTL_Gulch_Herbie", global)
            global = "Lab"
            FireThread(FTL_SaveCheckpoint, global)
            FTL_Gulch_LabSetup()
          end
        else
          global = "PM_LabSideStart_Mickey"
          TeleportToEntity(GetPlayer(), global)
          global = "PM_LabSideStart_Oswald"
          TeleportToEntity(GetPlayer2OrAI(), global)
          global = 4
          SetTargetTeam("FTL_Gulch_Herbie", global)
          global = "Lab"
          FireThread(FTL_SaveCheckpoint, global)
          FTL_Gulch_LabSetup()
        end
      end
    end
  elseif (level == "Lab") then
    local global, global = GetGlobal("FTL_Gulch_ProjectorExit"), "EM2_EpisodeCheck"
    global = global
    Print(("FTL_Gulch_Visit_Setup: FTL_Gulch_ProjectorExit = " .. global))
    if (global == -1) then
      global = 0
      SetGlobal("FTL_Gulch_ProjectorExit", global)
      global = 0
    end
    if (global ~= 0) then
      if (global == 1) then
        GetPrefabData("Projector_ToMadLab").MapLoad_SetupPosition = "True"
        if (GetGlobal("FTL_Gulch_DepositedBalls") == 3) then
          Hide("FTL_Gulch_SpiderDoor")
          global = 1
          FireThread(FTL_Gulch_SpiderDoorOpen_Cam, global)
        else
          Hide("FTL_Gulch_SpiderDoor")
          global = 2
          FireThread(FTL_Gulch_SpiderDoorOpen_Cam, global)
        end
        global = "Projector_ToMadLab"
        FireThread(OnMapLoad_ProjectorSetup, global)
      elseif (global == 2) then
        GetPrefabData("Projector_ToMadLabShort").MapLoad_SetupPosition = "True"
        global = "Projector_ToMadLabShort"
        FireThread(OnMapLoad_ProjectorSetup, global)
        global = "PM_LabSideStart_Mickey"
        TeleportToEntity(GetPlayer(), global)
        global = "PM_LabSideStart_Oswald"
        TeleportToEntity(GetPlayer2OrAI(), global)
        global = 4
        SetTargetTeam("FTL_Gulch_Herbie", global)
        global = "Lab"
        FireThread(FTL_SaveCheckpoint, global)
        FTL_Gulch_LabSetup()
      end
    else
      global = "PM_LabSideStart_Mickey"
      TeleportToEntity(GetPlayer(), global)
      global = "PM_LabSideStart_Oswald"
      TeleportToEntity(GetPlayer2OrAI(), global)
      global = 4
      SetTargetTeam("FTL_Gulch_Herbie", global)
      global = "Lab"
      FireThread(FTL_SaveCheckpoint, global)
      FTL_Gulch_LabSetup()
    end
  end
  return 
end
FTL_Gulch_2DTransitionSetup = function(exitProjector, fromDEC)
  Print(("FTL_Gulch_2DTransitionSetup exitProjector = " .. exitProjector))
  if (fromDEC == nil) then
    if (GetGlobal("FTL_Gulch_DepositedBalls") == 0) then
      LevelManager_SetCurrentState("FTL_Gulch.Canyon_v1")
    else
      LevelManager_SetCurrentState("FTL_Gulch.Canyon_v2")
    end
    if (GetGlobal("FTL_Gulch_IntroPlayed") == 0) then
      GetPrefabData(exitProjector).ToFlyThrough = "True"
      GetPrefabData(exitProjector).SkipJumpOutAnim = false
    end
    WaitForLevelLoad()
    Print("FTL_Gulch_2DTransitionSetup fromDEC == nil")
    SetupPosition()
  else
    Print("FTL_Gulch_2DTransitionSetup fromDEC == true")
    Prefab_DECFoopToob_Finish()
  end
  return 
end
FTL_CurrentCheckpointLocation = "PM_AngelSideStart"
FTL_SaveCheckpoint = function(side, location)
  if (location ~= nil) then
    if (location ~= "parameter2") then
      FTL_CurrentCheckpointLocation = (("PM_" .. location) .. "SideStart")
      Print(("FTL_SaveCheckpoint: location ~= nil so setting FTL_CurrentCheckpointLocation[1] to " .. FTL_CurrentCheckpointLocation))
    end
  else
    if (side ~= nil) then
      if (side ~= "parameter1") then
        FTL_CurrentCheckpointLocation = (("PM_" .. side) .. "SideStart")
      end
    end
    local savefunction = "FTL_Gulch_Setup"
    if (FTL_CurrentCheckpointLocation == "PM_LabSideStart") then
      savefunction = "FTL_Gulch_LabSetup"
    end
    Print("FTL_SaveCheckpoint: Saving checkpoint ")
    local MickeyLocation = (FTL_CurrentCheckpointLocation .. "_Mickey")
    local OswaldLocation = (FTL_CurrentCheckpointLocation .. "_Oswald")
    Print(("FTL_SaveCheckpoint: Saving checkpoint: MickeyLocation = " .. MickeyLocation))
    while true do
      if (not IsAnySequencePlaying()) then
        break
      end
      wait(0.20000000298023224)
    end
    SaveCheckpoint(nil, savefunction, MickeyLocation, OswaldLocation)
  end
  return 
end
FTL_Gulch_LeaveToRBC = function(target)
  Disable(GetRelativePrefabEntity("FTL_Gulch1_GuardianPool", ".GuardianPoolVisible_StimThinner"))
  Disable(GetRelativePrefabEntity("FTL_Gulch1_GuardianPool", ".GuardianPoolVisible_Stim"))
  SetGlobal("FTL_Gulch_StartLocation", 0)
  if (target ~= nil) then
    SetupPosition(target)
  end
  return 
end
FTL_MineElevatorFixed = function(state)
  if (state == "Shocked") then
    OswaldStreamAbort()
    Enable("TBCO_Elevator")
    AnimGBSequence("MineElevator", "elevator_lower", true)
    DestroyEntity("HiddenOswald_Action_Elevator")
    wait(3)
    Disable("TBCO_Elevator")
  else
    SetPropertyBool("HiddenOswald_Action_Elevator", "ActionSpotEnabled", true)
  end
  return 
end
FTL_MineElevatorRunning = function()
  if (GetPropertyInt("MineElevator", "Active Sequence ID") == 1) then
    AnimGBSequence("MineElevator", "elevator_rise", true)
  elseif (GetPropertyInt("MineElevator", "Active Sequence ID") == 2) then
    AnimGBSequence("MineElevator", "elevator_lower", true)
  end
  return 
end
FTL_ElevatorSphereCheck = function(target, state)
  Print(("FTL_ElevatorSphereCheck: state = " .. state))
  if (state == "SphereCheckpoint") then
    ApplyImpulse(_activator(), -10000, 0, 0)
  elseif (state == "SphereIn") then
    Enable("Trigger_ElevatorSphereCheck_Elevator")
  elseif (state == "SphereOut") then
    Disable("Trigger_ElevatorSphereCheck_Elevator")
    if (GetPropertyInt("MineElevator", "Active Sequence ID") ~= 0) then
      AnimGBSetIdle("MineElevator", false)
    end
  elseif (state == "ElevatorIn") then
    if (GetPropertyInt("MineElevator", "Active Sequence ID") == 1) then
      AnimGBSetIdle("MineElevator", true)
    end
  end
  return 
end
FTL_Gulch_GeyserChange = function(target)
  if GetPropertyBool(target, "Is Painted") then
    FTL_Gulch_GeysersPainted = (FTL_Gulch_GeysersPainted + 1)
  else
    FTL_Gulch_GeysersPainted = (FTL_Gulch_GeysersPainted - 1)
  end
  return 
end
FTL_Gulch_SpinningRockAnim = function(target)
  if (GetGlobal("FTL_Gulch_SpinningRockState") == 0) then
    AnimGBSequence(target, "spin", true)
  elseif (GetPropertyInt(target, "Active Sequence ID") == 1) then
    AnimGBSequence(target, "slowStop", true)
  end
  return 
end
FTL_Gulch_BoulderMovement = function(target, stopsound)
  if (stopsound == nil) then
    local FTL_Boulder_Mass = GetPropertyFloat("FTL_Gulch_Boulder", "Mass")
    if (FTL_Boulder_Mass == 1) then
      SetPropertyFloat("FTL_Gulch_Boulder", "Mass", 2)
      if (7 <= FTL_Gulch_GeysersPainted) then
        SplineFollower_StopAtPosition(target, "FTL_boulder_SK1", "FTL_boulder_SK2", 1)
      else
        SplineFollower_StopAtPosition(target, "FTL_boulder_SK1", "FTL_boulder_SK2", (FTL_Gulch_GeysersPainted / 12))
      end
      if (0 < FTL_Gulch_GeysersPainted) then
        AudioPostEventOn(target, "Play_sfx_dg1_boulder_steam_balance_lift")
      end
    elseif (FTL_Boulder_Mass == 2) then
      SetPropertyFloat("FTL_Gulch_Boulder", "Mass", 1)
      SplineFollower_StopAtPosition(target, "FTL_boulder_SK1", "FTL_boulder_SK2", 0)
    end
    wait(5)
    FireUser1(target)
  elseif (0 < FTL_Gulch_GeysersPainted) then
    AudioPostEventOn(target, "Play_sfx_dg1_boulder_steam_balance_land")
  end
  return 
end
FTL_Gulch_Canyon_SpawnSpatters = function()
  if (GetGlobal("FTL_Griff_FreeCage_Played") == 0) then
    Prefab_SpatterPipe_Spawn("Spawner_CanyonSpatter1")
  end
  return 
end
FTL_Gulch_Training_GPO = function(target, location, state)
  if (location == "Saloon") then
    FireUser4("FTL_Gulch1_SaloonGuardianPool")
    local before, JigsawPercentage = 0, 0
    JigsawPercentage = --[[ return 2 of ]] Jigsaw_GetPercentagePainted(target)
    before = Jigsaw_GetPercentagePainted(target)
    Print(((("before = " .. before) .. "   &&  after = ") .. JigsawPercentage))
    if (JigsawPercentage < before) then
      state = "Thinned"
    else
      state = "Painted"
    end
  end
  Print(state)
  if (_activator() == GetPlayer()) then
    if (state == "Thinned") then
      wait(0.75)
      if (FTL_Gulch_GusGPOHints[1] == 3) then
        FireSequence("Gus_v1", "FTL_Gulch_GPTraining_Thinned")
        FTL_Gulch_GusGPOHints[1] = 0
      else
        FTL_Gulch_GusGPOHints[1] = (FTL_Gulch_GusGPOHints[1] + 1)
        if (state == "Painted") then
          wait(0.75)
          if (FTL_Gulch_GusGPOHints[2] == 3) then
            FireSequence("Gus_v1", "FTL_Gulch_GPTraining_Painted")
            FTL_Gulch_GusGPOHints[2] = 0
          else
            FTL_Gulch_GusGPOHints[2] = (FTL_Gulch_GusGPOHints[2] + 1)
          end
        end
      end
    elseif (state == "Painted") then
      wait(0.75)
      if (FTL_Gulch_GusGPOHints[2] == 3) then
        FireSequence("Gus_v1", "FTL_Gulch_GPTraining_Painted")
        FTL_Gulch_GusGPOHints[2] = 0
      else
        FTL_Gulch_GusGPOHints[2] = (FTL_Gulch_GusGPOHints[2] + 1)
      end
    end
  end
  return 
end
FTL_Gulch_GusGPOHints = {3, 3}
FTL_Gulch_ChangeGlobalGuardianPool = function(GuardianPool)
  local data = GetPrefabData(GuardianPool)
  Print(("FTL_Gulch_ChangeGlobalGuardianPool: data.GuardianNames = " .. data.GuardianNames))
  local GuardianPoolStim = "GP_WaterTower_GuardianPoolVisible_Stim_Dynamic"
  if (data.GuardianNames == "FTL_WT_Guardians") then
    if (GetGlobal("FTL_Gulch_GP_WaterTower") == 0) then
      ForceSketched("WaterTowerBase")
      if (GetGlobal("FTL_WaterTowerCollapsed") == 0) then
        if (_activator() == GetPlayer()) then
          FireSequence("Gus_v1", "FTL_GulchWaterTowerGuardianThinned")
        end
      end
    end
  elseif (data.GuardianNames == "FTL_SaloonGuardians") then
    if (GetGlobal("FTL_Gulch_SaloonCollapse_Played") == 0) then
      local before, JigsawPercentage = Jigsaw_GetPercentagePainted((data.GP_Jigsaw[1] .. "1"))
      if (GetGlobal(data.GP_PaintedObjects[1]) == 5) then
        if (JigsawPercentage == 1) then
          FireThread(FTL_Gulch_OpenSaloonDoors)
          Disable("ftl_gulch_01a_visit1.Trigger_GPIntro_Saloon")
          ClearCameraAttributesForPlayer("CO_SaloonGuardianPool", GetPlayer(), 2)
          ClearCameraAttributesForPlayer("CO_SaloonGuardianPool", GetPlayer2OrAI(), 2)
          FireThread(FTL_Gulch_CheckPlayerDistance, "CO_SaloonCollapse", "OpenSaloon", GetPlayer())
        end
      end
    end
    GuardianPoolStim = "GP_Saloon_GuardianPoolVisible_Stim_Dynamic"
  elseif (data.GuardianNames == "FTL_Gulch_Guardians") then
    local CurrentPlaystyle, CurrentPlaystyle = GetPropertyFloat(GetRelativePrefabEntity("FTL_Gulch1_GuardianPool", ".GuardianPoolVisible_Visual"), "CurrentPlaystyle"), "CurrentPlaystyle"
    CurrentPlaystyle = "FTL_Gulch_GuardianFall_Pig"
    SetPropertyFloat(CurrentPlaystyle, "CurrentPlaystyle", CurrentPlaystyle)
    CurrentPlaystyle = "FTL_Gulch_GuardianFall_Pig_Splash"
    SetPropertyFloat(CurrentPlaystyle, "CurrentPlaystyle", CurrentPlaystyle)
    CurrentPlaystyle = "FTL_Gulch_GuardianFall_Wolf"
    SetPropertyFloat(CurrentPlaystyle, "CurrentPlaystyle", CurrentPlaystyle)
    CurrentPlaystyle = "FTL_gulchWaterSplash_01a_Tower"
    SetPropertyFloat(CurrentPlaystyle, "CurrentPlaystyle", CurrentPlaystyle)
    GuardianPoolStim = "GP_River_GuardianPoolVisible_Stim_Dynamic"
  end
  if (data.GP_State == "Neutral") then
    SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 0, 0)
    SetPropertyInt("FTL_Gulch_GuardianFall_Wolf", "Collision Layer", 13)
    SetPropertyInt("FTL_Gulch_GuardianFall_Pig", "Collision Layer", 13)
  elseif (data.GP_State == "Paint") then
    SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 2, 0)
    SetPropertyInt(GuardianPoolStim, "StimulusTypeList", 1, 0)
    SetPropertyInt("FTL_Gulch_GuardianFall_Wolf", "Collision Layer", 13)
    SetPropertyInt("FTL_Gulch_GuardianFall_Pig", "Collision Layer", 13)
  elseif (data.GP_State == "Thinner") then
    SetPropertyFloat(GuardianPoolStim, "StimulusPerSecondList", 2, 0)
    SetPropertyInt(GuardianPoolStim, "StimulusTypeList", 0, 0)
    SetPropertyInt("FTL_Gulch_GuardianFall_Wolf", "Collision Layer", 31)
    SetPropertyInt("FTL_Gulch_GuardianFall_Pig", "Collision Layer", 31)
  end
  return 
end
FTL_Gulch_ChangeGuardianFalls = function(target, state)
  Print(("FTL_Gulch_ChangeGuardianFalls: " .. state))
  if (state == "Neutral") then
    SetPropertyFloat(target, "StimulusPerSecondList", 0, 0)
    SetPropertyFloat(target, "StimulusPerSecondList", 0, 1)
    SetPropertyFloat(target, "StimulusPerSecondList", 0, 2)
    SetPropertyFloat(target, "StimulusPerSecondList", 0, 3)
    SetPropertyInt(target, "Collision Layer", 13)
  else
    SetPropertyInt(target, "Collision Layer", 1)
    if (state == "Paint") then
      SetPropertyFloat(target, "StimulusPerSecondList", 1.2000000476837158, 2)
    elseif (state == "Thinner") then
      SetPropertyFloat(target, "StimulusPerSecondList", 100, 0)
      SetPropertyFloat(target, "StimulusPerSecondList", 1, 1)
      SetPropertyFloat(target, "StimulusPerSecondList", 10, 2)
      SetPropertyFloat(target, "StimulusPerSecondList", 1, 3)
    end
  end
  return 
end
FTL_Gulch_WaterTowerBase_Thinned = function()
  if (5 <= GetGlobal("FTL_Gulch_GP_WaterTower")) then
    wait(0.10000000149011612)
    ForcePainted("WaterTowerBase")
    if (_activator() == GetPlayer()) then
      FireSequence("Gus_v1", "FTL_GulchWaterTowerThinned")
    end
  elseif (GetGlobal("FTL_WaterTowerCollapsed") == 0) then
    SetGlobal("FTL_WaterTowerCollapsed", 1)
    AnimGBSequence("FTL_gulch_01a_waterTower_inert_01a", "1stAnim", true)
    SetPropertyFloat("FTL_gulchTowerFallDust_01a", "CurrentPlaystyle", GetPropertyFloat(GetRelativePrefabEntity("WaterTowerGuardianPool", ".GuardianPoolVisible_Visual"), "CurrentPlaystyle"))
    StartEmitters("FTL_gulchTowerFallDust_01a")
    AnimGBSequence("FTL_Gulch_wolfJaw", "fall")
    AudioPostEventOn("ftl_gulch_01a_audio.SND_amb_wolfFalls", "Play_sfx_dg1_waterfall_lp")
    SetGlobal("DG_QuestHealth", (GetGlobal("DG_QuestHealth") - 10))
    FireThread(FTL_Gulch_CheckPlayerDistance, "CO_TrappedTowerGuardians", "CollapseTower", GetPlayer())
    wait(3)
    local (for index), (for limit), (for step) = 1, 4, 1
    for i = (for index), (for limit), (for step) do
      enableJumpVolumeAvailability(("Jump_WaterTower" .. i))
    end
    Enable("ftl_gulch_01a_canyon_scripting.Trigger_AutoLevel_WaterTower")
    Unhide("FTL_Gulch_GuardianFall_Wolf")
    StartEmitters("FTL_gulchWaterSplash_01a_Tower")
    ClearParent("TrainBall3")
    EnableComponent("TrainBall3", "Usable")
    StopEmitters("FTL_gulchTowerFallDust_01a")
    wait(1)
    FTL_SaveCheckpoint()
    wait(1.5)
    ClearCameraAttributesForPlayer("CO_TrappedTowerGuardians")
  end
  return 
end
FTL_Gulch_FreedGriff = function(state)
  Print(("FTL_Gulch_FreedGriff: state = " .. state))
  if (state == "In") then
    FireUser1("IGC_GremlinShutdownPipe")
    local gremlin = "Gremlin_Griff"
    FireThread(TeleportGremlinToEntity, gremlin, "PM_Gremlin_StopSpawner", true, false)
    wait(2.6700000762939453)
    AnimVarInt(gremlin, VAR_Cutscene, 1)
    AnimEvent(gremlin, EVENT_Start_Cutscene)
    wait(0.5)
    DoStinger("Comment_Rest", 5)
  elseif (state == "Out") then
    wait(0.25)
    TeleportGremlinOut("Gremlin_Griff")
    wait(0.5)
    FireUser3("IGC_GremlinShutdownPipe")
    FTL_SaveCheckpoint()
  end
  return 
end
FTL_Gulch_GusHintMarkers = function(target, state, ball_num)
  if (state == "Grabbed") then
    if (GetGlobal("FTL_Gulch_TrainPlaceBall_Played") == 0) then
      EnableGuardianHint("GusHint_SphereReceptor")
    end
  elseif (state == "Deposited") then
    SetMapMarkerVisible(("GusHint_TrainBall" .. ball_num), false)
  end
  return 
end
FTL_ForceSphere2InPosition = function()
  Print("FTL_ForceSphere2InPosition()")
  local (for index), (for limit), (for step) = 1, 3, 1
  for i = (for index), (for limit), (for step) do
    if (GetGlobal((("FTL_Gulch_TrainCart" .. i) .. "State")) == 2) then
      SetParentEntity("TrainBall2", ("FTL_ballDispenser_0" .. i))
      Print("FTL_ForceSphere2InPosition: Forcing TrainBall2 into position")
    end
  end
  return 
end
local PlayerInReceptorTrigger = false
FTL_TrainCar_Loaded = function(target, state)
  Print("***** FTL_TrainCar_Loaded")
  if (state == nil) then
    ForEachEntityInGroup(Disable, "TrainCars")
    Disable("Trigger_SphereDetection")
    Print("***** FTL_TrainCar_Loaded: Into the Receptacle")
    DisableComponent(target, "Usable")
    TeleportToEntity("Canyon_SphereLoader_SK", target)
    local Canyon_SphereLoader_SF = "Canyon_SphereLoader_SF"
    SplineFollower_TeleportToKnot(Canyon_SphereLoader_SF, "Canyon_SphereLoader_SK")
    SetParentEntity(target, Canyon_SphereLoader_SF)
    SplineFollower_SetDisabled(Canyon_SphereLoader_SF, false)
  elseif (state == "splinedone") then
    Print("***** FTL_TrainCar_Loaded - Spline Done - Enabling Player Check Trigger ")
    PlayerInReceptorTrigger = false
    Enable("TriggerBase_ReceptorCheck")
    wait(0.20000000298023224)
    if (PlayerInReceptorTrigger == false) then
      Disable("TriggerBase_ReceptorCheck")
      FTL_TrainCar_Loaded(nil, "TriggerEmpty")
    end
  elseif (state == "InTrigger") then
    Print("***** FTL_TrainCar_Loaded - InTrigger!")
    PlayerInReceptorTrigger = true
  elseif (state == "InitialRise") then
    AnimGBSequence("Canyon_SphereLoader", "raise")
    FireThread(FTL_Gulch_CheckForTrainBallRespawn)
    Enable("Trigger_BallReceptor_SphereCheck")
    wait(2)
    Enable("Trigger_SphereDetection")
  elseif (state == "CollisionIn") then
    Print("***** FTL_TrainCar_Loaded - CollisionIn --Player is in InvisibleCollisionCheck")
    if (GetPropertyInt("Canyon_SphereLoader", "Active Sequence ID") == 1) then
      Print("***** FTL_TrainCar_Loaded - CollisionIn -- GetPropertyInt(Canyon_SphereLoader,Active Sequence ID) == 1")
      Enable("Trigger_BallReceptor_CO")
      Enable("BallActionSpot")
      wait(1)
      if (GetPropertyInt("Canyon_SphereLoader", "Active Sequence ID") == 1) then
        Print("***** FTL_TrainCar_Loaded - CollisionIn -- Receptacle still open, so Unhide(Receptacle_HiddenCubeCollision)")
        Unhide("Receptacle_HiddenCubeCollision")
      end
    end
  elseif (state == "CollisionOut") then
    Print("***** FTL_TrainCar_Loaded - CollisionOut --Player has left InvisibleCollisionCheck")
    Hide("Receptacle_HiddenCubeCollision")
    Disable("BallActionSpot")
    Disable("Trigger_BallReceptor_CO")
    wait(0)
    ClearCameraAttributes("Trigger_BallReceptor_CO")
  elseif (state == "TriggerEmpty") then
    PlayerInReceptorTrigger = false
    Print("***** FTL_TrainCar_Loaded - Trigger Empty")
    Disable("TriggerBase_ReceptorCheck")
    SplineFollower_SetDisabled("Canyon_SphereLoader_SF", true)
    local sphere, sphere = GetChildEntityByIndex("Canyon_SphereLoader_SF", 0), "Canyon_SphereLoader_SF"
    if (sphere ~= nil) then
      sphere = SetPropertyString
      sphere(sphere, "Bone Attach Name", "batteryball_bone", 0)
      sphere = SetPropertyVector
      sphere(sphere, "Bone Attach Offset", vector4(-0.10000000149011612, -0.44999998807907104, 0.10000000149011612), 0)
      sphere = "Canyon_SphereLoader"
      local Canyon_SphereLoader = sphere
      Canyon_SphereLoader = SetParentEntity
      Canyon_SphereLoader(sphere, sphere)
      Canyon_SphereLoader = AnimGBSequence
      Canyon_SphereLoader(sphere, "lower")
      Canyon_SphereLoader = StartEmitters
      Canyon_SphereLoader("ftl_gulch_01a_fx.FTL_batteryReceptacle_01a 01")
      Canyon_SphereLoader = Hide
      Canyon_SphereLoader("Receptacle_HiddenCubeCollision")
      Canyon_SphereLoader = string
      Canyon_SphereLoader = Canyon_SphereLoader.sub
      Canyon_SphereLoader = Canyon_SphereLoader(GetName(sphere), -1)
      local ball_num = GetName(sphere)
      ball_num = FireThread
      ball_num(FTL_Gulch_GusHintMarkers, nil, "Deposited", Canyon_SphereLoader)
      ball_num = wait
      ball_num(1)
      ball_num = FTL_BallsLoaded
      ball_num = (ball_num + 1)
      local car_num = 1
      car_num = SetGlobal
      car_num((("FTL_Gulch_TrainCart" .. ball_num) .. "State"), Canyon_SphereLoader)
      car_num = SetGlobal
      car_num((("FTL_Gulch_Ball0" .. Canyon_SphereLoader) .. "State"), 2)
      car_num = FTL_BallsLoaded
      car_num = (car_num + 1)
      FTL_BallsLoaded = car_num
      car_num = ForceSequence
      car_num("Gus_v1", "FTL_Gulch_TrainPlaceBall")
      car_num = wait
      car_num(0.5)
      car_num = AudioPostEventOn
      car_num(("ftl_gulch_01a_audio.SND_event_train_Sphere" .. ball_num), ("Play_sfx_ballloaded_0" .. ball_num))
      car_num = wait
      car_num(1)
      car_num = StopEmitters
      car_num("ftl_gulch_01a_fx.FTL_batteryReceptacle_01a 01")
      car_num = FTL_BallsLoaded
      car_num = (4 - car_num)
      local lights = "ftl_gulch_01a_fx.FTL_batteryReceptacle_01a 01"
      lights = AnimGBSequence
      lights(("ftl_gulch_01a_lightfixtures.GBL_BulbMachineRedSm_01a_inert 0" .. car_num), "OffRed")
      lights = AnimGBSequence
      lights(("ftl_gulch_01a_lightfixtures.GBL_BulbMachineGreenSm_01a_inert 0" .. car_num), "OnGreen")
      lights = SetPropertyVector
      lights(sphere, "Bone Attach Offset", vector4(0, 0, 0), 0)
      lights = SetParentEntity
      lights(sphere, ("FTL_ballDispenser_0" .. FTL_BallsLoaded))
      lights = SetPropertyString
      lights(sphere, "Bone Attach Name", "bone", 0)
      lights = AnimGBSequence
      lights(("FTL_ballDispenser_0" .. FTL_BallsLoaded), "load")
      lights = AudioPostEventOn
      lights("ftl_gulch_01a_scripting.FTL_trainCar_01a_inert 03", "Play_sfx_ballloaded_01")
      lights = FTL_BallsLoaded
      if (lights ~= 3) then
        lights = FTL_BallsLoaded
        if (lights == 1) then
          lights = AudioPostEventOn
          lights("ftl_gulch_01a_audio.SND_event_trainidle", "Play_sfx_dg1_train_idle_lp")
          lights = 1
          local (for index), (for limit), (for step) = 2, 1, "bone"
          for (for step) = lights, (for index), (for limit) do
            i = StartEmitters
            i(("TrainSteam" .. (for step)))
          end
          lights = EnableGuardianHint
          lights("GusHint_Exit")
          lights = SetMapMarkerVisible
          lights("MapMarker_Exit", true)
          lights = Quest_GetCriticalPath
          lights = lights()
          local stageID, questID, stageID = --[[ return 2 of ]] lights(), 0, 0
          if (GetGlobal("EM2_EpisodeCheck") == 1) then
            if (lights == "Critical_Gulch1") then
              if (stageID ~= "Critical_Gulch1_5") then
                Quest_SetCriticalPath("Critical_Gulch1", "Critical_Gulch1_4")
              end
            end
          end
        end
        lights = AnimGBSequence
        lights(sphere, "raise")
        lights = FireThread
        lights(FTL_Gulch_CheckForTrainBallRespawn)
      else
        lights = AnimGBSequence
        lights("ftl_gulch_01a_scripting.FTL_trainCar_01a_inert 04", "unload")
        lights = SetGlobal
        lights("FTL_Gulch_TrainCart4State", 2)
        lights = GetPrefabData
        lights = lights("RedChest_Caboose")
        lights.ChestDisabled = "False"
        lights = SetPropertyBool
        lights("RedChest_Caboose", "Is Real", false)
        lights = Quest_GetCriticalPath
        lights = lights()
        local stageID = --[[ return 2 of ]] lights()
        if (GetGlobal("EM2_EpisodeCheck") == 1) then
          if (lights == "Critical_Gulch1") then
            if (stageID ~= "Critical_Gulch1_5") then
              Quest_SetCriticalPath("Critical_Gulch1", "Critical_Gulch1_2")
            end
          end
        end
      end
      lights = wait
      lights(1)
      lights = Enable
      lights("Trigger_SphereDetection")
      lights = wait
      lights(2)
      lights = AnimGBSequence
      lights(("FTL_ballDispenser_0" .. FTL_BallsLoaded), "restLoaded")
      lights = ForEachEntityInGroup
      lights(Enable, "TrainCars")
      lights = Print
      lights("***** FTL_TrainCar_Loaded --- Saving")
      lights = FTL_SaveCheckpoint
      lights()
    end
  end
  return 
end
local FTL_SaloonReviveCheck = false
FTL_CollapseSaloon = function(target, Rumble)
  if (Rumble == nil) then
    local before, JigsawPercentage = 0, 0
    local before2, JigsawPercentage2 = 0, 0
    JigsawPercentage = --[[ return 2 of ]] Jigsaw_GetPercentagePainted("ftl_gulch_01a_art.FTL_gulch_01a_saloonBraces_01a")
    before = Jigsaw_GetPercentagePainted("ftl_gulch_01a_art.FTL_gulch_01a_saloonBraces_01a")
    JigsawPercentage2 = --[[ return 2 of ]] Jigsaw_GetPercentagePainted("ftl_gulch_01a_art.FTL_gulch_01a_saloonBraces_02a")
    before2 = Jigsaw_GetPercentagePainted("ftl_gulch_01a_art.FTL_gulch_01a_saloonBraces_02a")
    Print(((("before = " .. before) .. "   &&  after = ") .. JigsawPercentage))
    Print(((("before2 = " .. before2) .. "   &&  after2 = ") .. JigsawPercentage2))
    if (JigsawPercentage == 0) then
      if (JigsawPercentage2 == 0) then
        if (GetGlobal("FTL_Gulch_SaloonCollapse_Played") == 0) then
          FireSequence("Gus_Shared", "FTL_Gulch_SaloonCollapse")
          SetGlobal("FTL_Gulch_SaloonWarning_Played", 1)
          AudioPostEventOn("ftl_gulch_01a_audio.SND_amb_WoodCreaks_1", "Play_sfx_WoodCreak")
          DoStinger("Comment_Dest", 5)
          AnimGBSequence("SaloonInertAnim", "fall")
          ForEachEntityInGroup(Disable, "Trigger_AIBlocker_Saloon")
          SetGlobal("DG_QuestHealth", (GetGlobal("DG_QuestHealth") - 15))
          if (GetPropertyInt("SaloonDoors", "Active Sequence ID") == 1) then
            AnimGBSequence("SaloonDoors", "break_open")
          else
            AnimGBSequence("SaloonDoors", "break_closed")
          end
          local (for index), (for limit), (for step) = 1, 3, 1
          for i = (for index), (for limit), (for step) do
            StartEmitters(("FTL_Saloon_FallingDust" .. tostring(i)))
            wait(0.25)
          end
          wait(1.25)
          ForEachEntityInGroup(Enable, "Trigger_CameraRumble")
          wait(0.75)
          FTL_SaloonReviveCheck = true
          ForEachEntityInGroup(Enable, "Trigger_SphereImpulse")
          ForEachEntityInGroup(Enable, "Trigger_SaloonAIAvoidance")
          wait(0.5)
          enableJumpVolumeAvailability("JV_SaloonAlcove")
          SetPropertyBool(".SaloonCrashBlueChest", "ActionSpotEnabled", true)
          ForEachEntityInGroup(Disable, "Trigger_SphereImpulse")
          ForEachEntityInGroup(Disable, "Trigger_CameraRumble")
          local (for index), (for limit), (for step), (for index) = 1, 3, 1, JigsawPercentage2
          for i = (for index), (for limit), (for step) do
            (for index) = StopEmitters
            (for limit) = "FTL_Saloon_FallingDust"
            (for step) = i
            (for limit) = ((for limit) .. (for step))
            (for index)((for limit))
          end
          wait(10)
          FTL_SaloonReviveCheck = false
        end
      end
    elseif (GetGlobal("FTL_Gulch_SaloonWarning_Played") == 0) then
      if (_activator() == GetPlayer()) then
        if (JigsawPercentage < before) then
          FireSequence("Gus_Shared", "FTL_Gulch_SaloonWarning")
          SetGlobal("FTL_Gulch_SaloonWarning_Played", 1)
          if (Rumble == "ReviveCheck") then
            if FTL_SaloonReviveCheck then
              SetPlayerUnrevivable(_activator())
            end
          else
            FTL_Gulch_CheckPlayerDistance(target, "CollapseSaloon", GetPlayer())
          end
        end
      end
    end
  elseif (Rumble == "ReviveCheck") then
    if FTL_SaloonReviveCheck then
      SetPlayerUnrevivable(_activator())
    end
  else
    FTL_Gulch_CheckPlayerDistance(target, "CollapseSaloon", GetPlayer())
  end
  return 
end
FTL_Gulch_CheckPlayerDistance = function(object, event, _player)
  Print("FTL_Gulch_CheckPlayerDistance")
  local object_loc = GetPosition(object)
  if (_player == nil) then
    _player = _activator()
  end
  if (GetNumPlayers() == 2) then
    if (_player ~= GetPlayer2()) then
      Print("FTL_Gulch_CheckPlayerDistance: Fire For Player 2")
      FireThread(FTL_Gulch_CheckPlayerDistance, object, event, GetPlayer2())
    end
  end
  local player_loc = GetPosition(_player)
  local distance = SCUPM_GetPosition(object_loc, player_loc)
  Print(("FTL_Gulch_CheckPlayerDistance: Player Distance = " .. tostring(distance)))
  if (event == "CollapseSaloon") then
    if (distance < 10) then
      SetCameraAttributesForPlayer("CO_SaloonCollapse", _player)
      Rumble(_player, 1.25)
      Rumble(nil, 1.25, 1)
      ShakeCamera(3, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
      wait(4)
      ClearCameraAttributesForPlayer("CO_SaloonCollapse", _player)
    end
  elseif (event == "OpenSaloon") then
    if (distance < 5) then
      SetCameraAttributesForPlayer("CO_SaloonDoor", _player)
      wait(4)
      ClearCameraAttributesForPlayer("CO_SaloonDoor", _player)
    end
  elseif (event == "CollapseTower") then
    if (distance < 14) then
      SetCameraAttributesForPlayer("CO_TrappedTowerGuardians", _player)
      wait(4)
      ClearCameraAttributesForPlayer("CO_TrappedTowerGuardians", _player)
    end
  end
  return distance
end
FTL_Gulch_OpenSaloonDoors = function(target, DistanceCheck)
  Print("FTL_Gulch_OpenSaloonDoors")
  ForEachEntityInGroup(Disable, "Triggers_Fall_OpenSaloonDoors")
  ForEachEntityInGroup(Disable, "Trigger_AIBlocker_Saloon")
  if (GetGlobal("FTL_Gulch_SaloonCollapse_Played") == 0) then
    if (GetPropertyInt("SaloonDoors", "Active Sequence ID") == 0) then
      Print("FTL_Gulch_OpenSaloonDoors: We ahvent collapsed the Saloon yet")
      AnimGBSequence("SaloonDoors", "open")
      if IsValidHandle("GusHint_Saloon") then
        Print("FTL_Gulch_OpenSaloonDoors: Hint entity Valid so Deleting")
        DestroyEntity("GusHint_Saloon")
      end
      if (DistanceCheck ~= "FromAbove") then
        DoStinger("Comment_Rest", 5)
        Print("Music - Saloon Doors open??")
      end
    end
  end
  return 
end
FTL_Gulch_MoveSpatter = function(target, state)
  Print(("__Function: FTL_Gulch_MoveSpatter, state: " .. state))
  if (GetGlobal("FTL_Gulch_SpinningRockState") == 0) then
    SetPropertyBool("TriggerLookAt_SpatterRock_Repeat", "Look At Trigger Enabled", false)
    SetGlobal("FTL_Gulch_SpinningRockState", 1)
    local trainSphere = "TrainBall2"
    DeactivateFairySketch(trainSphere)
    ClearParent(trainSphere)
    EnableMotion(trainSphere)
    SetRotatorMaxSpeed(trainSphere, 0)
    SetPropertyVector(trainSphere, "Bone Attach Offset", vector4(0, 0, 0), 0)
    if (state ~= "Thin") then
      if (state == "Paint") then
        SetGlobal("FTL_Gulch_SpinningRockState", 2)
      end
      SetVulnerability(target, ST_ELECTRIC, 1)
      ClearParent(target)
      EnableMotion(target)
      StimulusSphere(nil, ST_KNOCKBACK, 2, GetPosition(target), 2)
      SetPropertyVector(target, "Indicator Offset", vector4(0, 1, 0))
      SetPropertyVector(target, "Lock Offset", vector4(0, 1, 0))
    end
    ForEachEntityInGroup(Disable, "DancingRock_HintTriggers")
    wait(2)
    AudioPostEventOn(GetEntity("ftl_gulch_01a_canyon_scripting.DancingRocks_Inert"), "Stop_sfx_dg1_spinning_rock_lp")
  end
  return 
end
FTL_Gulch_TeleportTrainToCanyon_Shared = function(part, toonConnectorState)
  if (part == 1) then
    RestrictCutSceneInput()
    StartFadeOut(0.5)
    wait(1)
    ShowLoadingIcon(true)
    if (GetGlobal("FTL_Gulch_SpinningRockState") == 0) then
      AnimGBSequence("FTL_Gulch_DancingRocks_Inert", "rest")
      SetGlobal("FTL_Gulch_SpinningRockState", -1)
      ClearParent("TrainBall2")
    end
    local toonState = {true, true, true, true}
    local (for index), (for limit), (for step) = 1, 3, 1
    for i = (for index), (for limit), (for step) do
      if (not GetPropertyBool(("FTL_trainCarConnector_01a_toon 0" .. i), "Is Painted")) then
        toonState[(i + 1)] = false
        Print((("FTL_trainCarConnector_01a_toon 0" .. i) .. " Is not Painted"))
      end
    end
    local (for index), (for limit), (for step) = 1, 4, 1
    for i = (for index), (for limit), (for step) do
      (for index) = GetGlobal
      (for limit) = "FTL_Gulch_TrainCart"
      (for step) = i
      i = "State"
      (for limit) = (((for limit) .. (for step)) .. i)
      (for index) = (for index)((for limit))
      (for limit) = (i - 1)
      (for step) = toonState[i]
      if (for step) then
        (for step) = Print
        i = "FTL_trainCarConnector_01a_toon 0"
        Cart_BallNum = (for limit)
        toonNum = " Is Painted"
        i = ((i .. Cart_BallNum) .. toonNum)
        (for step)(i)
        if (i < 4) then
          if (0 < (for index)) then
            (for step) = SetGlobal
            i = "FTL_Gulch_Ball0"
            Cart_BallNum = (for index)
            toonNum = "State"
            i = ((i .. Cart_BallNum) .. toonNum)
            Cart_BallNum = 3
            (for step)(i, Cart_BallNum)
            (for step) = Print
            i = "Sphere #"
            Cart_BallNum = (for index)
            toonNum = " global is > 0 : Setting to New Value 3"
            i = ((i .. Cart_BallNum) .. toonNum)
            (for step)(i)
          end
        end
      else
        (for step) = Print
        i = "FTL_trainCarConnector_01a_toon 0"
        Cart_BallNum = (for limit)
        toonNum = " Is Not Painted"
        i = ((i .. Cart_BallNum) .. toonNum)
        (for step)(i)
        if (i == 4) then
          (for step) = SetGlobal
          i = "FTL_Gulch_TrainCart4State"
          Cart_BallNum = -1
          (for step)(i, Cart_BallNum)
        else
          if (0 < (for index)) then
            (for step) = SetGlobal
            i = "FTL_Gulch_Ball0"
            Cart_BallNum = (for index)
            toonNum = "State"
            i = ((i .. Cart_BallNum) .. toonNum)
            Cart_BallNum = -1
            (for step)(i, Cart_BallNum)
            (for step) = Print
            i = "Sphere #"
            Cart_BallNum = (for index)
            toonNum = " global is > 0 : Setting to New Value -1"
            i = ((i .. Cart_BallNum) .. toonNum)
            (for step)(i)
          else
            (for step) = Print
            i = "Train Connector #"
            Cart_BallNum = i
            toonNum = " Is Thinned, so setting Cart to -1"
            i = ((i .. Cart_BallNum) .. toonNum)
            (for step)(i)
            (for step) = SetGlobal
            i = "FTL_Gulch_TrainCart"
            Cart_BallNum = i
            toonNum = "State"
            i = ((i .. Cart_BallNum) .. toonNum)
            Cart_BallNum = -1
            (for step)(i, Cart_BallNum)
          end
          (for step) = 4
          i = i
          Cart_BallNum = -1
          for toonNum = (for step), i, Cart_BallNum do
            toonState[toonNum] = false
          end
        end
      end
    end
    FTL_Gulch_LeaveToRBC()
    if (GetNumPlayers() == 1) then
      OswaldStopFollowAction()
      TeleportToEntity(GetOswaldAI(), "Gus_Shared")
      wait(0.25)
      Print("Teleported")
    end
    return toonState
  elseif (part == 2) then
    WaitForLevelLoad()
    FTL_SaveCheckpoint("Lab")
    AudioPostEventOn(GetPlayer(), "Stop_MX_DG1_Valley")
    Print("Stopped valley music event")
    TeleportToEntity(GetPlayer(), "PM_LabSideStart_Mickey")
    TeleportToEntity(GetPlayer2OrAI(), "PM_LabSideStart_Oswald")
    Wait(0.009999999776482582)
    CameraReset()
    Wait(0.009999999776482582)
    OswaldStartFollowAction()
    SetGlobal("FTL_Gulch_ScurvyPin_Given", 0)
    local hideConnectors = false
    local (for index), (for limit), (for step) = 1, 3, 1
    for i = (for index), (for limit), (for step) do
      Unhide(("FTL_trainConnector 0" .. i))
      if (toonConnectorState[(i + 1)] == true) then
        ForcePainted(("FTL_trainConnector 0" .. i))
      elseif (hideConnectors == true) then
        Hide(("FTL_trainConnector 0" .. i))
      else
        ForceSketched(("FTL_trainConnector 0" .. i))
        hideConnectors = true
      end
    end
  end
  return 
end
FTL_Gulch_GusHints = function(target, Hint_num, var2)
  Print(("__Function: FTL_Gulch_GusHints, Hint_num: " .. tostring(Hint_num)))
  if (_activator() == GetPlayer()) then
    if (Hint_num == "GusIntro") then
      if (GetGlobal("FTL_Gulch_Gus_GuardianTraining_Played") == 0) then
        FireSequence("Gus_v1", "FTL_Gulch_Gus_GuardianTraining", 1)
      end
    elseif (Hint_num == "WT_TrappedGuardians") then
      if (GetGlobal("FTL_GulchWaterTowerTrappedGuardians_Played") == 0) then
        SetCameraAttributesForPlayer("TrappedTowerGuardiansHintCam", GetPlayer())
        FireSequence("Gus_v1", "FTL_GulchWaterTowerTrappedGuardians", 1)
      end
    elseif (Hint_num == "TrainExit") then
      if (GetGlobal("FTL_Gulch_IntroPlayed") == 0) then
        Print("Visit2, GetGlobal(FTL_Gulch_IntroPlayed)==0 SO assuming DEBUG load")
        SetGlobal("FTL_Gulch_Ball01State", 4)
      end
      ForceSequence("Gus_Shared", "FTL_Gulch_TrainExit", 1)
    elseif (Hint_num == "SpinningRock") then
      if (GetGlobal("FTL_Gulch_SpinningRockHint_Played") == 0) then
        if (GetGlobal("FTL_Gulch_SpinningRockState") == 0) then
          FireSequence("Gus_v1", "FTL_Gulch_SpinningRockHint", 1)
        end
      end
    elseif (Hint_num == "SpatterTower") then
      if (GetGlobal("FTL_Gulch_Gus_SpatterTower_Played") == 0) then
        FireSequence("Gus_v1", "FTL_Gulch_Gus_SpatterTower", 1)
        SetPropertyBool("TriggerLookAt_SpatterRock", "Look At Trigger Enabled", false)
        SetPropertyBool("TriggerLookAt_SpatterRock_Repeat", "Look At Trigger Enabled", true)
      else
        Print(("__Function: FTL_Gulch_GusHints, var2: " .. tostring(var2)))
        if (var2 == "InTrigger") then
          SetPropertyBool("TriggerLookAt_SpatterRock_Repeat", "Look At Trigger Enabled", true)
        elseif (var2 == "LeaveTrigger") then
          SetPropertyBool("TriggerLookAt_SpatterRock_Repeat", "Look At Trigger Enabled", false)
        else
          FTL_Gulch_GuardianTutorialCheck()
          if (Hint_num == "ThinTrainWarning") then
            FireSequence("Gus_Shared", "FTL_Gulch_ThinTrainWarning", 1)
          elseif (Hint_num == "GuardianTraining") then
            if (LevelManager_GetCurrentState() == "ftl_gulch.canyon_v1") then
              if (GetGlobal("FTL_Gulch_Gus_GuardianTutorial_Played") == 0) then
                while true do
                  if (not IsAnySequencePlaying()) then
                    break
                  end
                  wait(0.20000000298023224)
                end
                FireSequence("Gus_v1", "FTL_Gulch_Gus_GuardianTutorial", 1)
              end
            end
          end
        end
      end
    elseif (Hint_num == "ThinTrainWarning") then
      FireSequence("Gus_Shared", "FTL_Gulch_ThinTrainWarning", 1)
    elseif (Hint_num == "GuardianTraining") then
      if (LevelManager_GetCurrentState() == "ftl_gulch.canyon_v1") then
        if (GetGlobal("FTL_Gulch_Gus_GuardianTutorial_Played") == 0) then
          while true do
            if (not IsAnySequencePlaying()) then
              break
            end
            wait(0.20000000298023224)
          end
          FireSequence("Gus_v1", "FTL_Gulch_Gus_GuardianTutorial", 1)
        end
      end
    end
  end
  return 
end
FTL_Gulch_GuardianTutorialCheck = function()
  if IsPlayerMoveControlled(0) then
    FireSequence("Gus_v1", "Tutorial_GuardianAlt1TrainingMoveAlt", 1)
  else
    FireSequence("Gus_v1", "Tutorial_GuardianAlt1Training", 1)
  end
  return 
end
FTL_Gulch_ToonForObservationMarkerSwitch = function(target, state)
  if (state == "Painted") then
    SetPropertyBool("HiddenOswald_Action_Observation", "ActionSpotEnabled", true)
  elseif (state == "Thinned") then
    SetPropertyBool("HiddenOswald_Action_Observation", "ActionSpotEnabled", true)
  end
  return 
end
FTL_Gulch_Fifer_Dialogue = function()
  if (GetGlobal("FTL_Fifer_Rescued_Played") == 1) then
    ForceSequence("FiferPig", "FTL_Fifer_Idle")
  else
    ForceSequence("FiferPig", "FTL_Fifer_Rescued")
  end
  return 
end
FTL_Gulch_BunniesCaptured = function()
  FireSequence("Gus_v2", "FTL_Gulch_CapturedAllBunnies", 1)
  return 
end
FTL_Gulch_NunchuckTraining = function(state)
  if (state == "Show") then
    ForEachEntityInGroup(Enable, "DancingRock_HintTriggers")
    local player_loc = GetPosition(GetPlayer())
    SetTransformation("Spawner_UI_NunChuck", vector4(player_loc.x, (player_loc.y + 1.5), player_loc.z), vector4(0, 0, 0))
    local NunChuck = ForceSpawn("Spawner_UI_NunChuck", 1)[1]
    SetParentEntity(NunChuck, GetPlayer())
    Unhide(NunChuck)
    wait(7)
    Hide(NunChuck)
  elseif (state == "Hide") then
    while true do
      if (not IsAnySequencePlaying()) then
        break
      end
      wait(0.20000000298023224)
    end
    FTL_Gulch_GuardianTutorialCheck()
  end
  return 
end
FTL_Gulch_PhotoTaken = function(global, _event, obj)
  local event = _event
  if (event == nil) then
    Print(("Photo: " .. global))
    if (global == "MSN_Adelle_Gulch1PoolVar") then
      local river_playstyle = GetPropertyFloat(GetRelativePrefabEntity("FTL_Gulch1_GuardianPool", ".GuardianPoolVisible_Visual"), "CurrentPlaystyle")
      if (0.6549999713897705 <= river_playstyle) then
        SetGlobal(global, 2)
      elseif (GetGlobal("FTL_Gulch_GuardianPool") <= 0.3449999988079071) then
        SetGlobal(global, 1)
      else
        SetGlobal(global, 3)
        if (global == "MSN_Adelle_Gulch1HeadsVar") then
          if (GetGlobal("FTL_Gulch_SaloonCollapse_Played") == 0) then
            local data, data = GetPrefabData("FTL_Gulch1_SaloonGuardianPool"), "FTL_Gulch1_SaloonGuardianPool"
            data = Jigsaw_GetPercentagePainted
            data = data((data.GP_Jigsaw[1] .. "1"))
            local before, JigsawPercentage = --[[ return 2 of ]] data((data.GP_Jigsaw[1] .. "1")), "1"
            JigsawPercentage = GetGlobal
            JigsawPercentage = JigsawPercentage(data.GP_PaintedObjects[1])
            if (JigsawPercentage == 5) then
              if (before == 1) then
                JigsawPercentage = SetGlobal
                JigsawPercentage(global, 2)
              end
            else
              JigsawPercentage = SetGlobal
              JigsawPercentage(global, 3)
              SetGlobal(global, 1)
              if (global == "MSN_Adelle_Gulch1JunkBridgeVar") then
                if (GetGlobal("FTL_Gulch_DepositedBalls") == 0) then
                  SetGlobal(global, 1)
                elseif (GetGlobal("FTL_Gulch_DepositedBalls") == 3) then
                  SetGlobal(global, 2)
                else
                  SetGlobal(global, 3)
                  local score, score = GetPictureScoreFromEvent(event), global
                  score = " "
                  Print(((("Photo " .. obj) .. score) .. tostring(score)))
                  local displayText, displayText = false, tostring(score)
                  if (obj == "Memories_Train") then
                    score = obj
                    displayText = "Photo_Played"
                    if (GetGlobal((("FTL_Gus_" .. score) .. displayText)) == 0) then
                      displayText = true
                    end
                  elseif (obj == "ScoreCheck") then
                    if (score < 1) then
                      if (0.30000001192092896 < score) then
                        score = "Global_Gus_PhotoNotQuite"
                        FireSequence("Gus_Shared", score)
                      end
                    end
                  end
                  if displayText then
                    Disable(global)
                    score = false
                    SetMapMarkerVisible(global, score)
                    score = "FTL_Gus_"
                    displayText = obj
                    score = ((score .. displayText) .. "Photo")
                    displayText = 1
                    FireSequence("Gus_Shared", score, displayText)
                  end
                end
              end
            end
          else
            SetGlobal(global, 1)
            if (global == "MSN_Adelle_Gulch1JunkBridgeVar") then
              if (GetGlobal("FTL_Gulch_DepositedBalls") == 0) then
                SetGlobal(global, 1)
              elseif (GetGlobal("FTL_Gulch_DepositedBalls") == 3) then
                SetGlobal(global, 2)
              else
                SetGlobal(global, 3)
                local score = GetPictureScoreFromEvent(event)
                score = " "
                Print(((("Photo " .. obj) .. score) .. tostring(score)))
                local displayText, displayText = false, tostring(score)
                if (obj == "Memories_Train") then
                  score = obj
                  displayText = "Photo_Played"
                  if (GetGlobal((("FTL_Gus_" .. score) .. displayText)) == 0) then
                    displayText = true
                  end
                elseif (obj == "ScoreCheck") then
                  if (score < 1) then
                    if (0.30000001192092896 < score) then
                      score = "Global_Gus_PhotoNotQuite"
                      FireSequence("Gus_Shared", score)
                    end
                  end
                end
                if displayText then
                  Disable(global)
                  score = false
                  SetMapMarkerVisible(global, score)
                  score = "FTL_Gus_"
                  displayText = obj
                  score = ((score .. displayText) .. "Photo")
                  displayText = 1
                  FireSequence("Gus_Shared", score, displayText)
                end
              end
            end
          end
        elseif (global == "MSN_Adelle_Gulch1JunkBridgeVar") then
          if (GetGlobal("FTL_Gulch_DepositedBalls") == 0) then
            SetGlobal(global, 1)
          elseif (GetGlobal("FTL_Gulch_DepositedBalls") == 3) then
            SetGlobal(global, 2)
          else
            SetGlobal(global, 3)
            local score = GetPictureScoreFromEvent(event)
            score = " "
            Print(((("Photo " .. obj) .. score) .. tostring(score)))
            local displayText, displayText = false, tostring(score)
            if (obj == "Memories_Train") then
              score = obj
              displayText = "Photo_Played"
              if (GetGlobal((("FTL_Gus_" .. score) .. displayText)) == 0) then
                displayText = true
              end
            elseif (obj == "ScoreCheck") then
              if (score < 1) then
                if (0.30000001192092896 < score) then
                  score = "Global_Gus_PhotoNotQuite"
                  FireSequence("Gus_Shared", score)
                end
              end
            end
            if displayText then
              Disable(global)
              score = false
              SetMapMarkerVisible(global, score)
              score = "FTL_Gus_"
              displayText = obj
              score = ((score .. displayText) .. "Photo")
              displayText = 1
              FireSequence("Gus_Shared", score, displayText)
            end
          end
        end
      end
    elseif (global == "MSN_Adelle_Gulch1HeadsVar") then
      if (GetGlobal("FTL_Gulch_SaloonCollapse_Played") == 0) then
        local data, data = GetPrefabData("FTL_Gulch1_SaloonGuardianPool"), "FTL_Gulch1_SaloonGuardianPool"
        data = Jigsaw_GetPercentagePainted
        data = data((data.GP_Jigsaw[1] .. "1"))
        local before, JigsawPercentage = --[[ return 2 of ]] data((data.GP_Jigsaw[1] .. "1")), "1"
        JigsawPercentage = GetGlobal
        JigsawPercentage = JigsawPercentage(data.GP_PaintedObjects[1])
        if (JigsawPercentage == 5) then
          if (before == 1) then
            JigsawPercentage = SetGlobal
            JigsawPercentage(global, 2)
          end
        else
          JigsawPercentage = SetGlobal
          JigsawPercentage(global, 3)
          SetGlobal(global, 1)
          if (global == "MSN_Adelle_Gulch1JunkBridgeVar") then
            if (GetGlobal("FTL_Gulch_DepositedBalls") == 0) then
              SetGlobal(global, 1)
            elseif (GetGlobal("FTL_Gulch_DepositedBalls") == 3) then
              SetGlobal(global, 2)
            else
              SetGlobal(global, 3)
              local score, score = GetPictureScoreFromEvent(event), global
              score = " "
              Print(((("Photo " .. obj) .. score) .. tostring(score)))
              local displayText, displayText = false, tostring(score)
              if (obj == "Memories_Train") then
                score = obj
                displayText = "Photo_Played"
                if (GetGlobal((("FTL_Gus_" .. score) .. displayText)) == 0) then
                  displayText = true
                end
              elseif (obj == "ScoreCheck") then
                if (score < 1) then
                  if (0.30000001192092896 < score) then
                    score = "Global_Gus_PhotoNotQuite"
                    FireSequence("Gus_Shared", score)
                  end
                end
              end
              if displayText then
                Disable(global)
                score = false
                SetMapMarkerVisible(global, score)
                score = "FTL_Gus_"
                displayText = obj
                score = ((score .. displayText) .. "Photo")
                displayText = 1
                FireSequence("Gus_Shared", score, displayText)
              end
            end
          end
        end
      else
        SetGlobal(global, 1)
        if (global == "MSN_Adelle_Gulch1JunkBridgeVar") then
          if (GetGlobal("FTL_Gulch_DepositedBalls") == 0) then
            SetGlobal(global, 1)
          elseif (GetGlobal("FTL_Gulch_DepositedBalls") == 3) then
            SetGlobal(global, 2)
          else
            SetGlobal(global, 3)
            local score = GetPictureScoreFromEvent(event)
            score = " "
            Print(((("Photo " .. obj) .. score) .. tostring(score)))
            local displayText, displayText = false, tostring(score)
            if (obj == "Memories_Train") then
              score = obj
              displayText = "Photo_Played"
              if (GetGlobal((("FTL_Gus_" .. score) .. displayText)) == 0) then
                displayText = true
              end
            elseif (obj == "ScoreCheck") then
              if (score < 1) then
                if (0.30000001192092896 < score) then
                  score = "Global_Gus_PhotoNotQuite"
                  FireSequence("Gus_Shared", score)
                end
              end
            end
            if displayText then
              Disable(global)
              score = false
              SetMapMarkerVisible(global, score)
              score = "FTL_Gus_"
              displayText = obj
              score = ((score .. displayText) .. "Photo")
              displayText = 1
              FireSequence("Gus_Shared", score, displayText)
            end
          end
        end
      end
    elseif (global == "MSN_Adelle_Gulch1JunkBridgeVar") then
      if (GetGlobal("FTL_Gulch_DepositedBalls") == 0) then
        SetGlobal(global, 1)
      elseif (GetGlobal("FTL_Gulch_DepositedBalls") == 3) then
        SetGlobal(global, 2)
      else
        SetGlobal(global, 3)
        local score = GetPictureScoreFromEvent(event)
        score = " "
        Print(((("Photo " .. obj) .. score) .. tostring(score)))
        local displayText, displayText = false, tostring(score)
        if (obj == "Memories_Train") then
          score = obj
          displayText = "Photo_Played"
          if (GetGlobal((("FTL_Gus_" .. score) .. displayText)) == 0) then
            displayText = true
          end
        elseif (obj == "ScoreCheck") then
          if (score < 1) then
            if (0.30000001192092896 < score) then
              score = "Global_Gus_PhotoNotQuite"
              FireSequence("Gus_Shared", score)
            end
          end
        end
        if displayText then
          Disable(global)
          score = false
          SetMapMarkerVisible(global, score)
          score = "FTL_Gus_"
          displayText = obj
          score = ((score .. displayText) .. "Photo")
          displayText = 1
          FireSequence("Gus_Shared", score, displayText)
        end
      end
    end
  else
    local score = GetPictureScoreFromEvent(event)
    score = " "
    Print(((("Photo " .. obj) .. score) .. tostring(score)))
    local displayText, displayText = false, tostring(score)
    if (obj == "Memories_Train") then
      score = obj
      displayText = "Photo_Played"
      if (GetGlobal((("FTL_Gus_" .. score) .. displayText)) == 0) then
        displayText = true
      end
    elseif (obj == "ScoreCheck") then
      if (score < 1) then
        if (0.30000001192092896 < score) then
          score = "Global_Gus_PhotoNotQuite"
          FireSequence("Gus_Shared", score)
        end
      end
    end
    if displayText then
      Disable(global)
      score = false
      SetMapMarkerVisible(global, score)
      score = "FTL_Gus_"
      displayText = obj
      score = ((score .. displayText) .. "Photo")
      displayText = 1
      FireSequence("Gus_Shared", score, displayText)
    end
  end
  return 
end
FTL_Gulch_KillAIAndRescuePlayer = function(_activator)
  ClearAllCameraAttributes(_activator)
  KillAIAndRescuePlayer(_activator)
  if (_activator == GetPlayer()) then
    if (0 < GetHealth(_activator)) then
      local side = string.sub(FTL_CurrentCheckpointLocation, 4, 8)
      if (GetNumPlayers() == 2) then
        if (side == "Angel") then
          if (_activator == GetPlayer()) then
            SetCameraAttributesForPlayer((("FTL_Gulch_IntroOverride_" .. side) .. "_coopPlayer1"), _activator)
          else
            SetCameraAttributesForPlayer((("FTL_Gulch_IntroOverride_" .. side) .. "_coopPlayer2"), _activator)
            SetCameraAttributesForPlayer(("FTL_Gulch_IntroOverride_" .. side), _activator)
          end
        end
      else
        SetCameraAttributesForPlayer(("FTL_Gulch_IntroOverride_" .. side), _activator)
      end
      StationaryCamera_UntilPlayerMoves(nil, nil, _activator)
    end
  end
  return 
end
Gulch_Ball_Checker = function(target, var)
  Print("#### Gulch_Ball_Checker 1")
  if (var == "inside") then
    Print("#### Gulch_Ball_Checker 2")
    Enable("Trigger_BallReceptor_CO")
  else
    Print("#### Gulch_Ball_Checker 3")
    SetPlayerRevivable(GetPlayer())
    SetPlayerRevivable(GetPlayer2OrAI())
    ClearCameraAttributes("Trigger_BallReceptor_CO")
    Disable("Trigger_BallReceptor_CO")
  end
  return 
end
FTL_Gulch_PreventWaterTowerSquashRevive = function(target, state)
  Print("***FTL_Gulch_PreventWaterTowerSquashRevive")
  if (state == "enter") then
    Print("***(enter)")
    SetPlayerUnrevivable(GetPlayer())
  else
    Print("***(exit)")
    SetPlayerRevivable(GetPlayer())
  end
  return 
end
FTL_Gulch_CheckForTrainBallRespawn = function()
  Wait(4)
  FTL_Gulch_CheckForTrainBallRespawn_Hack()
  return 
end
