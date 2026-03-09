local musicvar = 0
FTL_Fort_Visit_Setup = function(method, currentLevel)
  Print("*_*_*_*_*_*_*_*_*_*@@@@ FTL_Fort_Setup() VISIT 1")
  local global = GetGlobal("FTL_Fort_SpatterState")
  Print(((("*_*_*_*_*_*_*_*_*_*@@@@ FTL_Fort_Setup() VISIT 1: currentLevel = " .. currentLevel) .. " & global = ") .. global))
  if (currentLevel ~= "dock") then
  end
  LevelManager_SetZoneStatusActive("FTL_Fort01a.V1_NPCs")
  if (GetGlobal("FTL_Ian_FortIntro_Played") == 0) then
    if (method == "Checkpoint") then
      RestrictCutSceneInput()
    end
    LevelManager_SetZoneStatusActive("FTL_Fort01a.V1_Ian")
  end
  WaitForLevelLoad()
  if (global ~= 10) then
    if (currentLevel == "fort") then
      TeleportToEntity("Botantist_Darvin", "PM_Botantist_Darvin_Outro")
      TeleportToEntity("Constance", "PM_Constance_Outro")
    end
  end
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    SetGlobal("EM2_EpisodeCheck", 2)
  end
  if (currentLevel == "fort") then
    if (GetGlobal("FTL_Fort_SpatterCombat") == 1) then
      FireThread(Prefab_OswaldElectricSwitch_ChangeState, GetRelativePrefabEntity("FortDoorOuter_Watch", ".OswaldSwitchStand"), "FullyCharged")
    end
    if IsValidHandle("Gremlin_Shaky") then
      if (global == 10) then
        GetPrefabData("Gremlin_Shaky").KeepGremlinOnReload = true
        if (GetGlobal("FTL_Shaky_Freed_Played") == 1) then
          Print("Teleporting Shaky")
          TeleportToEntity("Gremlin_Shaky", "FTL_Shaky_FortWall")
          SetNPCState("Gremlin_Shaky", 0)
          AnimVarInt("Gremlin_Shaky", VAR_Mood_Type, MOOD_Positive)
        end
      end
    end
  end
  if (GetGlobal("FTL_Gus_MachineBroken_Played") == 1) then
    if (global == 10) then
      SetGlobal("FTL_Gus_MachineBroken_Played", 0)
    end
  end
  if (musicvar == 0) then
    MusicPostEventOn(GetPlayer(), "Play_MX_DG2")
    RemoveAllMusicStateOverride()
    musicvar = 1
    Print("Started music event from FTL_Fort_Visit_Setup")
  end
  if (GetGlobal("FTL_Ian_FortIntro_Played") == 0) then
    ForcePainted(GetRelativePrefabEntity("turret_dumbo 03", ".BackBlocker"))
    local _player = GetPlayer()
    Hide(_player)
    Hide(GetPlayer2OrAI())
    FTL_SaveCheckpoint("Docks")
    local ian = ForceSpawn("Spawner_Ian", 1)[1]
    MoveToEntity(ian, "PM_IanIntro")
    PauseAllAI()
    EnableSplitScreen(false)
    HideHud()
    OswaldStopMovingAction()
    local marker = "Projector_ToTrainTunnels"
    TeleportToEntity(_player, marker)
    TeleportToEntity(GetPlayer2OrAI(), marker)
    CameraReset()
    wait(1)
    Print("Grab Shot 1")
    GrabCamera(GetRelativePrefabEntity("IGC_IanIntro", ".CameraStart"), nil, CAMERA_INSTANT_TRANSITION, 0)
    wait(0.10000000149011612)
    Unhide(_player)
    Unhide(GetPlayer2OrAI())
    wait(0.10000000149011612)
    Hide(_player)
    Hide(GetPlayer2OrAI())
    Wait(0.30000001192092896)
    Print("Grab Shot 2")
    GrabCamera(GetRelativePrefabEntity("IGC_IanIntro", ".CameraEnd"), nil, CAMERA_LERP_TRANSITION, 8)
    DisableComponent(GetRelativePrefabEntity(marker, ".ProjectorScreen"), "Usable")
    StartFadeInNoHUD(0.75)
    wait(2.5)
    AnimEvent(_player, EVENT_Special_1)
    AnimEvent(GetPlayer2OrAI(), EVENT_Special_1)
    Wait(0.05000000074505806)
    Unhide(_player)
    Unhide(GetPlayer2OrAI())
    AnimGBSequence(GetRelativePrefabEntity(marker, ".ProjectorScreen"), "warp")
    wait(1.2000000476837158)
    ForceSequence(ian, "FTL_Ian_FortIntro")
    wait(1.25)
    AnimGBSequence(GetRelativePrefabEntity(marker, ".ProjectorScreen"), "loop")
    FireUser1("IGC_IanIntro_Shot2")
    Projector_Setup_AnimationOffsetPositions(_player, GetPlayer2OrAI(), marker)
  elseif (tostring(MostRecentCheckpointCallback) ~= "FTL_Fort_Setup") then
    if (currentLevel == "dock") then
      FTL_SaveCheckpoint("Docks")
    elseif (currentLevel == "fort") then
      FTL_SaveCheckpoint("Fort_Entrance")
    end
  end
  if (currentLevel == "fort") then
    if (method == "DEC") then
      Prefab_DECFoopToob_Finish("DEC_toFloat3D")
    end
  end
  return 
end
FTL_Fort_IanIntro = function(shot, delayAnim, delayHide)
  if (shot == 1) then
    wait(2)
    FireUser1("IGC_IanIntro_Shot3")
  elseif (shot == 2) then
    wait(1)
    FireUser1("IGC_IanIntro_Shot4")
  elseif (shot == 3) then
    FireUser3("IGC_IanIntro_Shot4")
    wait(0.75)
    ObservatoryItem_Activate("MSS_ObservatoryItem_Fort", "6")
    Projector_To_IGC_Cleanup("Projector_ToTrainTunnels")
    ForceSketched(GetRelativePrefabEntity("turret_dumbo 03", ".BackBlocker"))
    wait(0.75)
    EnableComponent(GetRelativePrefabEntity("Projector_ToTrainTunnels", ".ProjectorScreen"), "Usable")
    Quest_SetCriticalPath("Critical_Gulch2", "Critical_Gulch2_1")
    FTL_SaveCheckpoint("Docks")
  end
  return 
end
FTL_Fort_EnterJail = function()
  if (GetGlobal("FTL_Gulch_Fiddler_Rescued_Played") == 0) then
    if (GetGlobal("MSN_Quest_3Pigs_State") ~= 2) then
      ForceSpawn("Spawner_Fiddler", 1)
    end
  end
  ReplaceMusicStateOverride("DG2_IntFortJail")
  Prefab_EnterInterior_FadeIn()
  return 
end
FTL_Fort_AirlockStreaming_Visit = function(loc)
  Print(("FTL_Fort_AirlockStreaming_Visit: loc = " .. loc))
  local zones = {}
  local location = string.sub(loc, 1, 4)
  Print(("FTL_Fort_AirlockStreaming_Visit: location = " .. location))
  if (location == "Dock") then
    if (GetGlobal("FTL_Fort_SpatterState") == 10) then
      table.insert(zones, "FTL_fort01a.V1_NPCs")
    else
      LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.V1_NPCs")
    end
    table.insert(zones, "FTL_fort01a.V1_SideSpladooshes")
  elseif (location == "Fort") then
    local inForest = false
    if (string.sub(loc, -1) == "s") then
      inForest = true
      table.insert(zones, "FTL_Fort01a.Q_BunnyChildrenDummy")
    end
    if (GetGlobal("FTL_Fort_SpatterState") == 10) then
      if inForest then
        table.insert(zones, "FTL_fort01a.V1_Forest")
      end
      LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.V1_NPCs")
    else
      table.insert(zones, "FTL_fort01a.V1_NPCs")
    end
    if (GetGlobal("FTL_Shaky_Freed_Played") == 0) then
      table.insert(zones, "FTL_fort01a.Q_RescueGremlin")
    elseif (GetGlobal("FTL_Shaky_Freed_Played") == 1) then
      if (GetGlobal("FTL_Shaky_PipeDisable_Played") == 0) then
        if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
          table.insert(zones, "FTL_fort01a.Q_RescueGremlin")
        end
      end
    else
      Print("FTL_Fort_AirlockStreaming_Visit: Unload Gremlin")
      LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.Q_RescueGremlin")
    end
  end
  local state, state = ("FTL_fort01a.V1_" .. loc), loc
  state = state
  return state, zones
end
FTL_MachineShock = function(target)
  local OswaldSwitchState = GetPrefabData(target).OswaldSwitchState
  if (OswaldSwitchState == 2) then
    Print("FTL_MachineShock:  OswaldSwitchState = 2")
    Wait(1)
    if (GetPrefabData("ftl_fort_01c_scripting.switch_oswaldelectric 01.OswaldSwitchSign").OswaldSwitchState == 2) then
      if (GetPrefabData("ftl_fort_01c_scripting.switch_oswaldelectric 02.OswaldSwitchSign").OswaldSwitchState == 2) then
        Print("FTL_MachineShock:  Both Switches = 2")
        if (GetName(target) == "ftl_fort_01c_scripting.switch_oswaldelectric 01.OswaldSwitchLever") then
          OswaldStartFollowAction()
          FireThread(FTL_Fort_SpawnSpatters)
          DestroyEntity("ftl_fort_01a_visit1.GusHint_CorePath_5")
        end
      end
    else
      Print("FTL_MachineShock:  else")
      Prefab_OswaldElectricSwitch_ChangeState(target, "Reset")
    end
  end
  return 
end
local FTL_Fort_InitalSpatterState_var = {0, 0, 0, 0, 0}
FTL_Fort_SpawnSpatters = function(target, loaded)
  Print("__Function: FTL_Fort_SpawnSpatters")
  if (GetGlobal("FTL_Gus_MachineBroken_Played") == 0) then
    Print("__FTL_Gus_MachineBroken_Played == 0! and we aren't streaming!")
    if (loaded == nil) then
      Print("__LOADED == NIL!")
      SetGlobal("FTL_Fort_SpatterCombat", 1)
      GetPrefabData("EnterInterior_Jail").StartsInactive = "True"
      if (GetPropertyInt("FTL_FortDoor", "Active Sequence ID") ~= 0) then
        AnimGBSequence("FTL_FortDoor", "close", true)
      end
      FireThread(Prefab_OswaldElectricSwitch_ChangeState, GetRelativePrefabEntity("FortDoorOuter_Watch", ".OswaldSwitchStand"), "FullyCharged")
      if (GetGlobal("FTL_Shaky_Freed_Played") == 0) then
        LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.Q_RescueGremlin")
      end
      while true do
        if (not (GetPropertyInt("FTL_FortDoor", "Active Sequence ID") == 3)) then
          break
        end
        wait(0.20000000298023224)
      end
      LevelManager_SetCurrentState("FTL_fort01a.V1_Fort_SpatterFight")
      LevelManager_SetZoneStatusActive("FTL_Fort01a.V1_FortSpatters")
      LevelManager_SetZoneStatusActive("FTL_Fort01a.V1_Slobber")
      while true do
        if (not (LevelManager_HasZoneFinishedStreaming("FTL_Fort01a.V1_FortSpatters") == false)) then
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
      Quest_SetCriticalPath("Critical_Gulch2", "Critical_Gulch2_5")
      MoveClockHands("FortOuter", "Unhide")
      Print("__LOADED == OnMapLoadOrStream!")
      ForceSequence("Gus_v1", "FTL_Gus_MachineBroken")
      SetPropertyInt("Spawner_Fort_Spatters", "Index To Spawn", 0, 0)
      LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.airlock_tunnel")
      local (for index), (for limit), (for step) = 1, 4, 1
      for i = (for index), (for limit), (for step) do
        Print(tostring(i))
        FireThread(FTL_Fort_SpawnSpatters, nil, i)
        wait(0.15000000596046448)
      end
      wait(1)
      FTL_SaveCheckpoint("Fort_Entrance")
      FTL_Fort_InitalSpatterState_var[5] = Prefab_SpatterPipe_Spawn(("Fort_Spatter_Spawner" .. math.random(1, 4)), "return")
    elseif (loaded ~= nil) then
      Print(("__LOADED ~= " .. loaded))
      FTL_Fort_InitalSpatterState_var[loaded] = Prefab_SpatterPipe_Spawn(("Fort_Spatter_Spawner" .. loaded), "return")
      wait(4)
      GoToEntity(FTL_Fort_InitalSpatterState_var[loaded], "PN_SeerEnterFort")
    end
  end
  return 
end
ForceSlobberCombatMusic = function()
  local (for index), (for limit), (for step) = 1, 10, 1
  for i = (for index), (for limit), (for step) do
    SetCombatIntensityBias((10 * i))
    Print("Music - setting combat intensity bias + 100")
    wait(1)
  end
  SetCombatIntensityBias(0)
  Print("Music - setting combat intensity bias to 0")
  return 
end
FTL_Fort_SlobberDetection_AdjustSpawns = function(target, state)
  if (state == "In") then
    OverrideSpawnTransform(PLAYER_ONE, GetPosition("MickeyStart_SlobberOverride"), GetFacing("MickeyStart_SlobberOverride"))
    OverrideSpawnTransform(PLAYER_TWO, GetPosition("OswaldStart_SlobberOverride"), GetFacing("OswaldStart_SlobberOverride"))
  elseif (state == "Out") then
    ClearOverrideSpawnTransform(PLAYER_ONE)
    ClearOverrideSpawnTransform(PLAYER_TWO)
  end
  return 
end
local FTL_Fort_BlotlingState_var = {0, 0, 0, 0}
FTL_Fort_BlotlingState = function(target, event, state, Slobber)
  local _event = event
  Print(("FTL_Fort_BlotlingState: " .. state))
  local SpatterMaxCount = 5
  if (GetGlobal("FTL_Fort_SpatterState") ~= 10) then
    SpatterMaxCount = 4
  end
  if ((FTL_Fort_BlotlingState_var[1] + FTL_Fort_BlotlingState_var[2]) ~= SpatterMaxCount) then
    if (state == "Death") then
      FTL_Fort_BlotlingState_var[2] = (FTL_Fort_BlotlingState_var[2] + 1)
      if (Slobber == nil) then
        if (GetName(DeathEvent_Killer(_event)) ~= nil) then
          local killer = tostring(GetName(DeathEvent_Killer(_event)))
          Print(killer)
          if (string.find(killer, "theblob") == nil) then
            if (string.find(killer, "slobber") == nil) then
              if (string.find(killer, "spatter") == nil) then
                Print((("FTL_Fort_BlotlingState: " .. state) .. " - Killed by Player!"))
                FTL_Fort_BlotlingState_var[4] = (FTL_Fort_BlotlingState_var[4] + 1)
              end
            end
          end
          if string.find(killer, "theblobfrontattack") then
            if (GetCurrentTeam(target) == 3) then
              FTL_Fort_BlotlingState_var[1] = (FTL_Fort_BlotlingState_var[1] - 1)
            end
          end
        end
      else
        FTL_Fort_BlotlingState_var[4] = (FTL_Fort_BlotlingState_var[4] + 1)
      end
      local (for index), (for index), (for limit) = 1, SpatterMaxCount, 1
      for (for step) = (for index), (for index), (for limit) do
        i = FTL_Fort_InitalSpatterState_var
        i = i[(for step)]
        if (i == GetName(target)) then
          i = FTL_Fort_InitalSpatterState_var
          i[(for step)] = 0
        elseif (state == "TeamChange") then
          if (GetCurrentTeam(target) == 2) then
            FTL_Fort_BlotlingState_var[1] = (FTL_Fort_BlotlingState_var[1] - 1)
          elseif (GetCurrentTeam(target) == 3) then
            FTL_Fort_BlotlingState_var[1] = (FTL_Fort_BlotlingState_var[1] + 1)
            FireThread(FTL_Fort_SpatterToExitPipe, target, "ToPipe")
          end
        end
      end
    elseif (state == "TeamChange") then
      if (GetCurrentTeam(target) == 2) then
        FTL_Fort_BlotlingState_var[1] = (FTL_Fort_BlotlingState_var[1] - 1)
      elseif (GetCurrentTeam(target) == 3) then
        FTL_Fort_BlotlingState_var[1] = (FTL_Fort_BlotlingState_var[1] + 1)
        FireThread(FTL_Fort_SpatterToExitPipe, target, "ToPipe")
      end
    end
  end
  if ((FTL_Fort_BlotlingState_var[1] + FTL_Fort_BlotlingState_var[2]) == SpatterMaxCount) then
    local BlotlingState_var1 = FTL_Fort_BlotlingState_var[1]
    local BlotlingState_var2 = FTL_Fort_BlotlingState_var[2]
    local BlotlingState_var4 = FTL_Fort_BlotlingState_var[4]
    BlotlingState_var1 = BlotlingState_var1
    BlotlingState_var2 = " Friended"
    Print((("FTL_Fort_BlotlingState_vars[1] = " .. BlotlingState_var1) .. BlotlingState_var2))
    BlotlingState_var1 = BlotlingState_var2
    BlotlingState_var2 = " Killed"
    Print((("FTL_Fort_BlotlingState_vars[2] = " .. BlotlingState_var1) .. BlotlingState_var2))
    BlotlingState_var1 = BlotlingState_var4
    BlotlingState_var2 = " Player Killed"
    Print((("FTL_Fort_BlotlingState_vars[4] = " .. BlotlingState_var1) .. BlotlingState_var2))
    FTL_Fort_BlotlingState_var[1] = -100
    FTL_Fort_BlotlingState_var[2] = -100
    FTL_Fort_BlotlingState_var[4] = 0
    local global = GetGlobal("FTL_Fort_SpatterState")
    if (global == 10) then
      BlotlingState_var1 = 2
      wait(BlotlingState_var1)
      BlotlingState_var1 = "IGC_IntroSlobber"
      FireUser1(BlotlingState_var1)
      BlotlingState_var1 = 0.30000001192092896
      wait(BlotlingState_var1)
      BlotlingState_var1 = "Boss_Intro"
      BlotlingState_var2 = 2
      DoStinger(BlotlingState_var1, BlotlingState_var2)
      if (BlotlingState_var1 == 5) then
        local FTL_FortSpatter1 = 0
        BlotlingState_var1 = 0
        BlotlingState_var2 = 1
        BlotlingState_var4 = 5
        global = 1
        for FTL_FortSpatter1 = BlotlingState_var2, BlotlingState_var4, global do
          FTL_FortSpatter2 = FTL_Fort_InitalSpatterState_var
          FTL_FortSpatter2 = FTL_FortSpatter2[FTL_FortSpatter1]
          if (FTL_FortSpatter2 ~= 0) then
            if (FTL_FortSpatter1 == 0) then
              FTL_FortSpatter2 = FTL_Fort_InitalSpatterState_var
              FTL_FortSpatter1 = FTL_FortSpatter2[FTL_FortSpatter1]
            elseif (BlotlingState_var1 == 0) then
              FTL_FortSpatter2 = FTL_Fort_InitalSpatterState_var
              BlotlingState_var1 = FTL_FortSpatter2[FTL_FortSpatter1]
            else
            end
          else
          end
        end
        BlotlingState_var2 = SetGlobal
        BlotlingState_var4 = "FTL_Fort_SpatterState"
        global = 100
        BlotlingState_var2(BlotlingState_var4, global)
        BlotlingState_var2 = ClearNextPatrolNode
        BlotlingState_var4 = FTL_FortSpatter1
        BlotlingState_var2(BlotlingState_var4)
        BlotlingState_var2 = ClearNextPatrolNode
        BlotlingState_var4 = BlotlingState_var1
        BlotlingState_var2(BlotlingState_var4)
        BlotlingState_var2 = AI_UnregisterForSensor
        BlotlingState_var4 = FTL_FortSpatter1
        global = "SeeEnemy"
        BlotlingState_var2(BlotlingState_var4, global)
        BlotlingState_var2 = AI_UnregisterForSensor
        BlotlingState_var4 = BlotlingState_var1
        global = "SeeEnemy"
        BlotlingState_var2(BlotlingState_var4, global)
        BlotlingState_var2 = MoveToEntity
        BlotlingState_var4 = FTL_FortSpatter1
        global = "PN_SlobberIntro1_1"
        BlotlingState_var2(BlotlingState_var4, global)
        BlotlingState_var2 = MoveToEntity
        BlotlingState_var4 = BlotlingState_var1
        global = "PN_SlobberIntro2_1"
        BlotlingState_var2(BlotlingState_var4, global)
        BlotlingState_var2 = SetNextPatrolNode
        BlotlingState_var4 = FTL_FortSpatter1
        global = "PN_SlobberIntro1_1"
        BlotlingState_var2(BlotlingState_var4, global)
        BlotlingState_var2 = SetNextPatrolNode
        BlotlingState_var4 = BlotlingState_var1
        global = "PN_SlobberIntro2_1"
        BlotlingState_var2(BlotlingState_var4, global)
        BlotlingState_var2 = wait
        BlotlingState_var4 = 2.5
        BlotlingState_var2(BlotlingState_var4)
      end
      if (BlotlingState_var2 == 5) then
        BlotlingState_var1 = "FTL_Fort_SpatterState"
        BlotlingState_var2 = 200
        SetGlobal(BlotlingState_var1, BlotlingState_var2)
      else
        BlotlingState_var1 = "FTL_Fort_SpatterState"
        BlotlingState_var2 = 300
        SetGlobal(BlotlingState_var1, BlotlingState_var2)
      end
      BlotlingState_var1 = 0.4000000059604645
      wait(BlotlingState_var1)
      BlotlingState_var1 = "Spawner_Slobber"
      BlotlingState_var2 = 1
      local slobber = ForceSpawn(BlotlingState_var1, BlotlingState_var2)[1]
      BlotlingState_var1 = wait
      BlotlingState_var2 = 0.699999988079071
      BlotlingState_var1(BlotlingState_var2)
      BlotlingState_var1 = FireThread
      BlotlingState_var2 = ForceSlobberCombatMusic
      BlotlingState_var1(BlotlingState_var2)
      BlotlingState_var1 = Print
      BlotlingState_var2 = "Slobber intro music"
      BlotlingState_var1(BlotlingState_var2)
      BlotlingState_var1 = ShakeCamera
      BlotlingState_var2 = 3
      BlotlingState_var4 = 3
      global = 0.3499999940395355
      BlotlingState_var1(BlotlingState_var2, BlotlingState_var4, global, 2, 0.03500000014901161, 0.03500000014901161)
      BlotlingState_var1 = AudioPostEventOn
      BlotlingState_var2 = slobber
      BlotlingState_var4 = "Play_sfx_slobber_land"
      BlotlingState_var1(BlotlingState_var2, BlotlingState_var4)
      BlotlingState_var1 = AudioPostEventOn
      BlotlingState_var2 = slobber
      BlotlingState_var4 = "Play_sfx_Fort_treeLandImpact"
      BlotlingState_var1(BlotlingState_var2, BlotlingState_var4)
      BlotlingState_var1 = AudioPostEventOn
      BlotlingState_var2 = slobber
      BlotlingState_var4 = "Play_sfx_Slobber_GroundPound"
      BlotlingState_var1(BlotlingState_var2, BlotlingState_var4)
      BlotlingState_var1 = StartEmitters
      BlotlingState_var2 = "FX_SlobberEntrance_ImpactDust"
      BlotlingState_var1(BlotlingState_var2)
      BlotlingState_var1 = wait
      BlotlingState_var2 = 1.2999999523162842
      BlotlingState_var1(BlotlingState_var2)
      BlotlingState_var1 = 3
      BlotlingState_var2 = 1
      BlotlingState_var4 = 5
      global = 1
      for i = BlotlingState_var2, BlotlingState_var4, global do
        if (FTL_Fort_InitalSpatterState_var[i] ~= 0) then
          if (GetCurrentTeam(FTL_Fort_InitalSpatterState_var[i]) == 3) then
            if (0 < BlotlingState_var1) then
              BlotlingState_var1 = (BlotlingState_var1 - 1)
              Print(("We have a live one! Decrementing blotlingsForSlobberFight by 1; which now equals: " .. BlotlingState_var1))
            end
          else
            Print(("Destroying Extra Dude: " .. tostring(FTL_Fort_InitalSpatterState_var[i])))
            DestroyEntity(FTL_Fort_InitalSpatterState_var[i])
          end
        end
      end
      BlotlingState_var2 = wait
      BlotlingState_var4 = 1
      BlotlingState_var2(BlotlingState_var4)
      BlotlingState_var2 = StopEmitters
      BlotlingState_var4 = "FX_SlobberEntrance_ImpactDust"
      BlotlingState_var2(BlotlingState_var4)
      BlotlingState_var2 = wait
      BlotlingState_var4 = 3
      BlotlingState_var2(BlotlingState_var4)
      BlotlingState_var2 = ForceSequence
      BlotlingState_var4 = "Gus_v1"
      global = "FTL_Gus_SlobberTraining"
      BlotlingState_var2(BlotlingState_var4, global)
      BlotlingState_var2 = wait
      BlotlingState_var4 = 1
      BlotlingState_var2(BlotlingState_var4)
      BlotlingState_var2 = LevelManager_SetZoneStatusActive
      BlotlingState_var4 = "FTL_Fort01a.V1_Ian"
      BlotlingState_var2(BlotlingState_var4)
      BlotlingState_var2 = FireThread
      BlotlingState_var4 = FTL_Fort_ResetAndSpawnSpatters
      global = "SlobberFight"
      BlotlingState_var2(BlotlingState_var4, global, BlotlingState_var1)
      BlotlingState_var2 = wait
      BlotlingState_var4 = 1
      BlotlingState_var2(BlotlingState_var4)
      BlotlingState_var2 = FireUser3
      BlotlingState_var4 = "IGC_IntroSlobber"
      BlotlingState_var2(BlotlingState_var4)
    else
      BlotlingState_var1 = tostring
      BlotlingState_var2 = global
      BlotlingState_var1 = BlotlingState_var1(BlotlingState_var2)
      BlotlingState_var2 = -2
      BlotlingState_var4 = -2
      if (string.sub(BlotlingState_var1, BlotlingState_var2, BlotlingState_var4) == "0") then
        if (BlotlingState_var1 == 4) then
          BlotlingState_var1 = "FTL_Fort_SpatterState"
          BlotlingState_var2 = (global + 10)
          SetGlobal(BlotlingState_var1, BlotlingState_var2)
          BlotlingState_var1 = "FTL_Fort_BlotlingState: All Enemies Painted!"
          Print(BlotlingState_var1)
        end
        BlotlingState_var1 = "FTL_Fort_SpatterState"
        BlotlingState_var2 = (global + 20)
        SetGlobal(BlotlingState_var1, BlotlingState_var2)
        BlotlingState_var1 = "FTL_Fort_BlotlingState: Enemies Thinned And/Or Friended!"
        Print(BlotlingState_var1)
        BlotlingState_var1 = FTL_Ian_BlotlingsResolution
        FireThread(BlotlingState_var1)
        Print((("FTL_Fort_BlotlingState_vars[1] = " .. FTL_Fort_BlotlingState_var[1]) .. " Friended"))
        Print((("FTL_Fort_BlotlingState_vars[2] = " .. FTL_Fort_BlotlingState_var[2]) .. " Killed"))
        Print((("FTL_Fort_BlotlingState_vars[4] = " .. FTL_Fort_BlotlingState_var[4]) .. " Player Killed"))
      end
    end
  else
    Print((("FTL_Fort_BlotlingState_vars[1] = " .. FTL_Fort_BlotlingState_var[1]) .. " Friended"))
    Print((("FTL_Fort_BlotlingState_vars[2] = " .. FTL_Fort_BlotlingState_var[2]) .. " Killed"))
    Print((("FTL_Fort_BlotlingState_vars[4] = " .. FTL_Fort_BlotlingState_var[4]) .. " Player Killed"))
  end
  return 
end
FTL_Fort_PipeSpatterSpawned = function(target)
  Print("FTL_Fort_PipeSpatterSpawned")
  GoToEntity(target, GetPlayer())
  if (GetGlobal("FTL_Fort_SpatterState") == 10) then
    local (for index), (for limit), (for step) = 1, 5, 1
    for i = (for index), (for limit), (for step) do
      if (FTL_Fort_InitalSpatterState_var[i] == 0) then
        Print((("FTL_Fort_InitalSpatterState_var[" .. i) .. "] == 0"))
        FTL_Fort_InitalSpatterState_var[i] = GetName(target)
        Print(((("FTL_Fort_InitalSpatterState_var[" .. i) .. "] == ") .. FTL_Fort_InitalSpatterState_var[i]))
      else
      end
    end
  end
  return 
end
FTL_Fort_SpatterToExitPipe = function(target, state)
  Print(("FTL_Fort_SpatterToExitPipe: " .. state))
  if (state == "ToPipe") then
    if (GetGlobal("FTL_Fort_SpatterState") ~= 10) then
      ForceSequence("Ian", "FTL_Ian_BlotlingFriended")
    end
  elseif (state == "AtPipe") then
    DestroyEntity(target)
    FTL_Fort_BlotlingState_var[2] = (FTL_Fort_BlotlingState_var[2] - 1)
    if (GetGlobal("FTL_Ian_BlotlingResolution_Played") ~= 0) then
      FireThread(FTL_Fort_SpatterWaves, nil, "PipeExit")
    elseif (GetGlobal("FTL_Fort_SpatterState") == 10) then
      FireThread(FTL_Fort_BlotlingState, target, "PipeExit")
    end
  end
  return 
end
FTL_Ian_BlotlingsResolution = function()
  Print("########################### FTL_Ian_BlotlingsResolution")
  DoStinger("Boss_Win", 2)
  wait(3)
  StartFadeOut(0.30000001192092896)
  wait(0.4000000059604645)
  LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.V1_Slobber")
  ForEachEntityInGroup(DestroyEntity, "FTL_FortSpatters")
  wait(0.10000000149011612)
  local global = GetGlobal("FTL_Fort_SpatterState")
  if (global == 110) then
    LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.V1_FortSpatters")
    FireUser1("IGC_Open_FloatShortcut")
  else
    FireUser1("IGC_IanOutro")
  end
  wait(0.4000000059604645)
  local ian = ForceSpawn("Spawner_Ian", 1)[1]
  SetParentEntity("Ian_ItemSpawner", ian)
  if (global == 110) then
    MoveToEntity(ian, "PM_OutroGood_Ian")
    MoveToEntity(GetPlayer(), "PM_OutroGood_Player")
  else
    AnimVarInt(ian, VAR_Mood_Type, MOOD_Negative)
  end
  wait(0.699999988079071)
  ForceSequence(ian, "FTL_Ian_BlotlingResolution")
  wait(0.5)
  GetPrefabData("IGC_IanOutro").shotOrder = "mid"
  if (GetGlobal("FTL_Shaky_Freed_Played") == 1) then
    ForceUnpuddled("Gremlin_Shaky")
  end
  return 
end
FTL_Fort_ResetAndSpawnSpatters = function(state, spattersToSpawnForSlobberFight)
  Print(("FTL_Fort_ResetAndSpawnSpatters: state = " .. state))
  if (state == "Ian") then
    FireUser1("IGC_SpatterAttack1")
    SetPropertyInt("Spawner_Fort_Spatters", "Index To Spawn", 1, 0)
    wait(0.30000001192092896)
  end
  FTL_Fort_BlotlingState_var[1] = 0
  FTL_Fort_BlotlingState_var[2] = 0
  local spattersToSpawn = 3
  if (spattersToSpawnForSlobberFight ~= nil) then
    Print(((("FTL_Fort_ResetAndSpawnSpatters: We have " .. tostring((3 - spattersToSpawnForSlobberFight))) .. " Friended Spatters from the First Fight, so we will only spawn ") .. tostring(spattersToSpawnForSlobberFight)))
    spattersToSpawn = spattersToSpawnForSlobberFight
    FTL_Fort_BlotlingState_var[1] = (3 - spattersToSpawnForSlobberFight)
  end
  if (spattersToSpawn ~= 0) then
    local (for index), (for limit), (for step) = 1, spattersToSpawn, 1
    for i = (for index), (for limit), (for step) do
      wait((0.25 * i))
      FireThread(Prefab_SpatterPipe_Spawn, ("Fort_Spatter_Spawner" .. i))
    end
    if (GetGlobal("FTL_Shaky_Freed_Played") == 0) then
      if (state == "Ian") then
        FireThread(Prefab_SpatterPipe_Spawn, "Fort_Spatter_Spawner4")
        FTL_Fort_BlotlingState_var[3] = 4
      end
    elseif (GetGlobal("FTL_Shaky_Freed_Played") == 1) then
      if (state == "SlobberFight") then
        ForceSequence("Shaky", "FTL_Shaky_PipeDisable")
      else
        FTL_Fort_BlotlingState_var[3] = 5
        wait(2)
        local (for index), (for limit), (for step) = 1, 2, 1
        for i = (for index), (for limit), (for step) do
          (for index) = wait
          (for limit) = 0.25
          (for index)((for limit))
          (for index) = FireThread
          (for limit) = Prefab_SpatterPipe_Spawn
          (for step) = "Fort_Spatter_Spawner"
          i = i
          (for step) = ((for step) .. i)
          (for index)((for limit), (for step))
        end
      end
    end
    if (state == "Ian") then
      AnimEvent(state, EVENT_Start_WatchTV)
      SetPropertyInt(state, "Collision Layer", 13)
      SplineFollower_SetDisabled(state, false)
      wait(1)
      AnimEvent(state, EVENT_Start_WatchTV)
    end
  end
  return 
end
FTL_Fort_IanToFlying = function(_time)
  Print("FTL_Fort_IanToFlying")
  FireUser3("IGC_SpatterAttack1")
  if (_time == nil) then
    wait(2)
  else
    wait(_time)
  end
  Print("Watch TV")
  AnimEvent("Ian", EVENT_Start_WatchTV)
  return 
end
FTL_Fort_IanExit = function(state)
  if (state ~= "Intro") then
    RestrictCutSceneInput()
  end
  local Ian = "Ian"
  SetPropertyFloat(Ian, "UsableRadius", 0)
  wait(0.30000001192092896)
  AnimVarInt(Ian, VAR_Cutscene, 1)
  AnimEvent(Ian, EVENT_Start_Cutscene)
  if (state ~= "Intro") then
    LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.Q_RescueGremlin")
    LevelManager_SetCurrentState("FTL_fort01a.V1_Fort_ALTunnel")
    FireThread(Prefab_OswaldElectricSwitch_ChangeState, GetRelativePrefabEntity("FortDoorOuter_Watch", ".OswaldSwitchStand"), "Reset")
    GetPrefabData("EnterInterior_Jail").StartsInactive = "False"
    SetGlobal("FTL_Fort_SpatterCombat", 0)
    if (state == "bad") then
      SetGlobal("Extras_Ghost_Ian_Paint", 0)
      SetGlobal("BTA_QuestHealth", (GetGlobal("BTA_QuestHealth") - 15))
      wait(0.699999988079071)
      Prefab_WorldItem_Unhide("Spatter_Costume_Tattered")
      ForceSequence("Gus_v1", "FTL_Gus_CostumePiece", 1)
      wait(1)
      while true do
        if (not (GetGlobal("FTL_Gus_CostumePiece_Played") == 0)) then
          break
        end
        wait(0.25)
      end
      FireUser1("IGC_Open_FloatExit")
      wait(0.30000001192092896)
      SetPropertyFloat("Botantist_Darvin", "UsableRadius", 0)
      SetPropertyFloat("Constance", "UsableRadius", 0)
      Unhide("Botantist_Darvin")
      Unhide("Constance")
      TeleportToEntity(GetPlayer(), "PM_OutroNPC_Mickey")
      OswaldStopMovingAction()
      TeleportToEntity(GetPlayer2OrAI(), "PM_OutroNPC_Oswald")
      wait(0.5)
      ForceSequence("Botantist_Darvin", "FTL_Darvin_OpenExit", 1)
    else
      LevelManager_SetZoneStatusActive("FTL_Fort01a.V1_NPCs")
      local NPCStreaming = function()
        while true do
          if (not (LevelManager_HasZoneFinishedStreaming("FTL_fort01a.V1_NPCs") == false)) then
            break
          end
          wait(0.20000000298023224)
          Print("FTL_Fort_IanExit: Zone while loop - NPCs Streaming")
        end
        while true do
          if (not (LevelManager_WaitingForStreamingSync() == false)) then
            break
          end
          Wait(0.05000000074505806)
        end
        TeleportToEntity("Botantist_Darvin", "PM_Botantist_Darvin_Outro")
        TeleportToEntity("Constance", "PM_Constance_Outro")
        return 
      end
      FireThread(NPCStreaming)
      SetGlobal("FTL_Fort_SpatterState", 1)
      SetGlobal("Extras_Ghost_Ian_Paint", 1)
      FireThread(Mickey_GetItem_ClearItem, "Ian_ItemSpawner", "FlowerCostume")
      wait(0.5)
      FireUser3("IGC_Open_FloatExit")
      wait(0.29499998688697815)
      Prefab_WorldItem_Unhide("Spatter_Costume_Restored")
      Enable("ftl_fort_01c_scripting.exitbuildingcamera 01.Trigger_EnterInterior")
      wait(2)
      wait(2)
      FireThread(FTL_Fort_IanIntro, 3)
    end
  else
    wait(2)
    FireThread(FTL_Fort_IanIntro, 3)
  end
  wait(1)
  DestroyEntity(Ian)
  if (state == "Intro") then
    FireThread(FTL_Fort_Setup, "setupTurrets")
  end
  wait(0.5)
  if (state ~= "bad") then
    LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.V1_Ian")
  end
  if (state == "Intro") then
    LevelManager_SetZoneStatusActive("FTL_Fort01a.V1_SideSpladooshes")
    FTL_SaveCheckpoint("Docks")
  elseif (state == "good") then
    FTL_SaveCheckpoint("Fort_Entrance")
  end
  if (state ~= "Intro") then
    UnrestrictCutSceneInput()
  end
  return 
end
FTL_Fort_SpatterWaves = function(target, _event, state)
  if (GetGlobal("FTL_Fort_SpatterState") == 10) then
    FireThread(FTL_Fort_BlotlingState, target, state)
  else
    local global = GetGlobal("FTL_Fort_SpatterState")
    if (string.sub(tostring(global), -1) == "0") then
      if (state == "TeamChange") then
        if (GetCurrentTeam(target) == 2) then
          FTL_Fort_BlotlingState_var[1] = (FTL_Fort_BlotlingState_var[1] - 1)
        elseif (GetCurrentTeam(target) == 3) then
          FTL_Fort_BlotlingState_var[1] = (FTL_Fort_BlotlingState_var[1] + 1)
          FireThread(FTL_Fort_SpatterToExitPipe, target, "ToPipe")
          if (state == "Death") then
            FTL_Fort_BlotlingState_var[3] = (FTL_Fort_BlotlingState_var[3] - 1)
            FTL_Fort_BlotlingState_var[2] = (FTL_Fort_BlotlingState_var[2] + 1)
            wait(2)
            if ((FTL_Fort_BlotlingState_var[1] + FTL_Fort_BlotlingState_var[2]) < 6) then
              if (GetGlobal("FTL_Shaky_Freed_Played") == 0) then
                FireThread(Prefab_SpatterPipe_Spawn, ("Fort_Spatter_Spawner" .. math.random(1, 4)))
              else
                FireThread(Prefab_SpatterPipe_Spawn, ("Fort_Spatter_Spawner" .. math.random(1, 3)))
              end
              FTL_Fort_BlotlingState_var[3] = (FTL_Fort_BlotlingState_var[3] + 1)
            end
          end
        end
      elseif (state == "Death") then
        FTL_Fort_BlotlingState_var[3] = (FTL_Fort_BlotlingState_var[3] - 1)
        FTL_Fort_BlotlingState_var[2] = (FTL_Fort_BlotlingState_var[2] + 1)
        wait(2)
        if ((FTL_Fort_BlotlingState_var[1] + FTL_Fort_BlotlingState_var[2]) < 6) then
          if (GetGlobal("FTL_Shaky_Freed_Played") == 0) then
            FireThread(Prefab_SpatterPipe_Spawn, ("Fort_Spatter_Spawner" .. math.random(1, 4)))
          else
            FireThread(Prefab_SpatterPipe_Spawn, ("Fort_Spatter_Spawner" .. math.random(1, 3)))
          end
          FTL_Fort_BlotlingState_var[3] = (FTL_Fort_BlotlingState_var[3] + 1)
        end
      end
      if (FTL_Fort_BlotlingState_var[3] == FTL_Fort_BlotlingState_var[1]) then
        local BlotlingState_var1 = FTL_Fort_BlotlingState_var[1]
        local BlotlingState_var2 = FTL_Fort_BlotlingState_var[2]
        FTL_Fort_BlotlingState_var[1] = -100
        FTL_Fort_BlotlingState_var[2] = -100
        local end_state = 0
        if (BlotlingState_var1 == 8) then
          end_state = 1
        elseif (BlotlingState_var2 == 8) then
          end_state = 2
        else
          end_state = 3
        end
        SetGlobal("FTL_Fort_SpatterState", end_state)
        FireUser1("IGC_IanOutro")
        wait(0.5)
        LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.V1_FortSpatters")
        LevelManager_SetZoneStatusActive("FTL_Fort01a.V1_NPCs")
        WaitForLevelLoad()
        Hide("Botantist_Darvin")
        Hide("Constance")
        TeleportToEntity("Botantist_Darvin", "PM_Botantist_Darvin_Outro")
        TeleportToEntity("Constance", "PM_Constance_Outro")
        local Ian = "Ian"
        SetPropertyInt(Ian, "Collision Layer", 4)
        SplineFollower_SetDisabled(Ian, true)
        SplineFollower_TeleportToKnot(Ian, "ftl_fort_01a_visit1ai_ian.SplineKnot 01")
        AnimEvent(Ian, EVENT_Finish_WatchTV)
        ForceSequence(Ian, "FTL_Ian_BlotlingAttackOver")
        while true do
          if (not (GetGlobal("FTL_Fort_SpatterState") ~= -1)) then
            break
          end
          wait(0.25)
        end
        local global = (global + end_state)
        if (global == 222) then
          SetGlobal("FTL_Fort_SpatterState", 2)
        else
          SetGlobal("FTL_Fort_SpatterState", 3)
          if (state == "Death") then
            ForceSequence("Ian", "FTL_Ian_BlotlingFlavor")
          end
        end
      elseif (state == "Death") then
        ForceSequence("Ian", "FTL_Ian_BlotlingFlavor")
      end
      Print((("FTL_Fort_BlotlingState_vars[1] = " .. FTL_Fort_BlotlingState_var[1]) .. " Friended"))
      Print((("FTL_Fort_BlotlingState_vars[2] = " .. FTL_Fort_BlotlingState_var[2]) .. " Killed"))
      Print((("FTL_Fort_BlotlingState_vars[3] = " .. FTL_Fort_BlotlingState_var[3]) .. " Alive"))
      Print((("FTL_Fort_BlotlingState_vars[4] = " .. FTL_Fort_BlotlingState_var[4]) .. " Killed by Player"))
    end
  end
  return 
end
FTL_NPC_Outro = function(state)
  if (state == "RubbleAnim") then
    AnimGBSequence("FTL_fort_OutroRockfaceRubble", "Anim")
    StartEmitters("FX_DEC_ExitDust")
  elseif (state == "Finish") then
    LevelManager_SetZoneStatusUnloaded("FTL_Fort01a.V1_Ian")
    SetPropertyFloat("Botantist_Darvin", "UsableRadius", 2)
    SetPropertyFloat("Constance", "UsableRadius", 2)
    CameraReset()
    DestroyEntity("FTL_fort_OutroRockfaceRubble")
    StopEmitters("FX_DEC_ExitDust")
    FireThread(Prefab_DECFoopToob_ChangeState, "DEC_toFloat3D", "Activate")
    OswaldStartMovingAction()
    FTL_SaveCheckpoint("Fort_Entrance")
  end
  return 
end
