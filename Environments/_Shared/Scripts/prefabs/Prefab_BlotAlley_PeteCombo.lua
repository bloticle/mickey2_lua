Prefab_BlotAlleyPete_AlwaysSetup = function(target)
  Print("___Function: Prefab_BlotAlleyPete_AlwaysSetup")
  local data = GetPrefabData(target)
  math.randomseed(os.time())
  Hide("NOS_BlotAlley_Petetronic")
  FireThread(TeleportGremlinOut, GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".Gremlin"))
  if (GetGlobal("NOS_BlotAlleyProgress") == 1) then
    if (GetGlobal("NOS_BlotAlley_PeteRewardUnavailable") == 1) then
      Print("__Pete reward is unavailable!")
      SetPropertyFloat(GetRelativePrefabEntity(target, ".DoorbellMarker"), "UsableRadius", 0)
    else
      TeleportToEntity("NOS_BlotAlley_Petetronic", GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".PeteRepairMarker"))
      Unhide("NOS_BlotAlley_Petetronic")
      AnimEvent("NOS_BlotAlley_Petetronic", EVENT_Special_1)
    end
    StartEmitters("PeteGeneratorFX")
    Hide("BlotworxWall1")
    Hide("BlotworxWall2")
    Hide("BlotworxWall3")
    return 
  end
  if (GetGlobal("NOS_BlotAlley_Petetronic_BlotworxAttack_Played") == 1) then
    if (GetGlobal("NOS_BlotAlley_PeteScrapMetal_InitialInvestment") ~= -1) then
      if (GetGlobal("NOS_BlotAlleyProgress") == 0) then
        Print("__Need to refire blotworx attack, fading out!")
        StartFadeOut(0)
      end
    end
  end
  if (GetGlobal("NOS_BlotAlley_Petetronic_NeedScrapMetal_Played") ~= 0) then
    if (GetGlobal("NOS_BlotAlley_Petetronic_NeedScrapMetal_Played") == 1) then
      if (GetGlobal("NOS_BlotAlley_Petetronic_BlotworxAttack_Played") == 0) then
        Print("__We havent had the attack yet!")
        FireSequence(GetRelativePrefabEntity(target, ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_ScrapRepeatingHint")
        TeleportToEntity("NOS_BlotAlley_Petetronic", GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".PeteRepairMarker"))
        Unhide("NOS_BlotAlley_Petetronic")
        AnimEvent("NOS_BlotAlley_Petetronic", EVENT_Special_1)
      end
    elseif (GetGlobal("NOS_BlotAlley_Petetronic_BlotworxAttack_Played") == 1) then
      if (GetGlobal("NOS_BlotAlley_PeteScrapMetal_InitialInvestment") ~= -1) then
        if (GetGlobal("NOS_BlotAlleyProgress") == 0) then
          Print("__BTAPete: Not done with the fight, retrigger the IGC!")
          RestrictCutSceneInput()
          ForceSequence(GetRelativePrefabEntity(target, ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_BlotworxAttack")
          TeleportToEntity("NOS_BlotAlley_Petetronic", GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".PeteRepairMarker"))
          Unhide("NOS_BlotAlley_Petetronic")
          AnimEvent("NOS_BlotAlley_Petetronic", EVENT_Special_1)
        elseif (GetGlobal("NOS_BlotAlleyProgress") == 1) then
          Print("__Done with the fight! Starting fx!")
          StartEmitters("PeteGeneratorFX")
          Hide("BlotworxWall1")
          Hide("BlotworxWall2")
          Hide("BlotworxWall3")
          if (GetGlobal("NOS_BlotAlley_PeteScrapMetal_InitialInvestment") == -1) then
            StartEmitters("PeteGeneratorFX")
            Hide("BlotworxWall1")
            Hide("BlotworxWall2")
            Hide("BlotworxWall3")
          end
        end
      end
    elseif (GetGlobal("NOS_BlotAlley_PeteScrapMetal_InitialInvestment") == -1) then
      StartEmitters("PeteGeneratorFX")
      Hide("BlotworxWall1")
      Hide("BlotworxWall2")
      Hide("BlotworxWall3")
    end
  end
  return 
end
PostIGC_0230_PetetronicIntro = function()
  Print("__Function: PostIGC_0230_PetetronicIntro")
  Prefab_BlotAlleyPete_PeteGeneratorIGC_S2("NOS_BlotAlley_Petetronic")
  return 
end
PostIGC_0230b_PetetronicIntro = function()
  Print("__Function: PostIGC_0230b_PetetronicIntro")
  Prefab_BlotAlleyPete_PeteGeneratorIGC_S2("NOS_BlotAlley_Petetronic")
  return 
end
Prefab_BlotAlleyPete_PeteGeneratorIGC = function(target, _Section)
  Print(("_Function: Prefab_BlotAlleyPete_PeteGeneratorIGC, _Section: " .. _Section))
  if (_Section == "1") then
    AudioPostEventOn(GetPlayer(), "Play_sfx_Doorbell_Club13")
    if (GetGlobal("NOS_BlotAlley_Petetronic_NeedScrapMetal_Played") == 1) then
      if (GetGlobal("NOS_BlotAlley_Petetronic_OpenDoor_Played") == 1) then
        ForceSequence(GetRelativePrefabEntity(target, ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_AfterDoorOpened")
      elseif (GetGlobal("NOS_BlotAlley_Petetronic_BlotworxAttack_Played") == 0) then
        SetGlobal("NOS_BlotAlley_PeteScrapMetal_AmountGiven", GetCurrency("ScrapMetal"))
        ForceSequence(GetRelativePrefabEntity(target, ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_GiveScrapMetal")
      else
        ForceSequence(GetRelativePrefabEntity(target, ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_FightNotDone")
        RestrictCutSceneInput()
        SetPropertyFloat(GetRelativePrefabEntity(target, ".DoorbellMarker"), "UsableRadius", 0)
        LevelManager_SetZoneStatusActive("nos_blotalley_main.igc_prescott_v1")
        wait(0.5)
        DisableGuardianHint("GusHintNode_Club13")
        if (GetGlobal("NOS_BlotAlley_IanMood") < 0) then
          PlayIGC("IGC_0230b_PetetronicIntro")
        else
          PlayIGC("IGC_0230_PetetronicIntro")
        end
        wait(0.20000000298023224)
        UnrestrictCutSceneInput()
      end
    else
      RestrictCutSceneInput()
      SetPropertyFloat(GetRelativePrefabEntity(target, ".DoorbellMarker"), "UsableRadius", 0)
      LevelManager_SetZoneStatusActive("nos_blotalley_main.igc_prescott_v1")
      wait(0.5)
      DisableGuardianHint("GusHintNode_Club13")
      if (GetGlobal("NOS_BlotAlley_IanMood") < 0) then
        PlayIGC("IGC_0230b_PetetronicIntro")
      else
        PlayIGC("IGC_0230_PetetronicIntro")
      end
      wait(0.20000000298023224)
      UnrestrictCutSceneInput()
    end
  end
  return 
end
Prefab_BlotAlleyPete_ScrapCollected = function(target)
  Print("__Function: Prefab_BlotAlleyPete_ScrapCollected")
  if (GetGlobal("NOS_BlotAlley_Petetronic_NeedScrapMetal_Played") == 1) then
    if (GetGlobal("NOS_BlotAlley_PeteScrapMetal_AmountGiven") == 0) then
      FireSequence(GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_ScrapRepeatingHint")
    end
  end
  return 
end
Prefab_BlotAlleyPete_PeteGeneratorIGC_S2 = function(target)
  Prefab_BlotAlleyPete_InitialDepositAmount(target)
  LevelManager_SetZoneStatusDeactive("nos_blotalley_main.igc_prescott_v1")
  Disable("OswaldGotoClubMarker")
  OswaldStartFollowAction()
  if (GetGlobal("NOS_BlotAlley_PeteScrapMetal_InitialInvestment") == 0) then
    Print("__Player had no scrap metal! Will play nonblocking version of the conversation")
    ForceSequence(GetRelativePrefabEntity(target, ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_NeedScrapMetal")
  else
    Print("__Player had scrap metal! Will play blocking version of the conversation")
    SetGlobal("NOS_BlotAlley_PeteScrapMetal_AmountGiven", GetCurrency("ScrapMetal"))
    wait(0.20000000298023224)
    ForceSequence(GetRelativePrefabEntity(target, ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_InitialHasScrapMetal")
  end
  Quest_SetCriticalPath("Critical_BlotAlley", "Critical_BlotAlley_2")
  Print("__Sequence playing")
  SetGlobal("NOS_BlotAlley_Petetronic_NeedScrapMetal_Played", 1)
  SetMapMarkerVisible("MapMarker_Club13", false)
  NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Club13")
  wait(0.10000000149011612)
  Unhide("NOS_BlotAlley_Petetronic")
  AnimEvent("NOS_BlotAlley_Petetronic", EVENT_Special_1)
  ClearParent("NOS_BlotAlley_Petetronic")
  DisableMotion("NOS_BlotAlley_Petetronic")
  TeleportToEntity("NOS_BlotAlley_Petetronic", GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".PeteRepairMarker"))
  return 
end
Prefab_BlotAlleyPete_InitialDepositAmount = function(target)
  Print("__Function: Prefab_BlotAlleyPete_InitialDepositAmount")
  local ScrapAmount = GetCurrency("ScrapMetal")
  Print(("Player Scrap Metal: " .. tostring(ScrapAmount)))
  SetGlobal("NOS_BlotAlley_PeteScrapMetal_InitialInvestment", tonumber(ScrapAmount))
  return 
end
Prefab_BlotAlleyPete_DoorBlotworxSequence = function(target, _Section)
  Print(("_Function: Prefab_BlotAlleyPete_DoorBlotworxSequence, _Section: " .. tostring(_Section)))
  local data = GetPrefabData("NOS_BlotAlley_Petetronic")
  if (_Section == "1") then
    Prefab_BlotAlleyPete_SpawnBlotworx(target, "1")
    local (for index), (for limit), (for step) = 1, 3, 1
    for x = (for index), (for limit), (for step) do
      AI_UnregisterForSensor(data.BlotworxSpawned[x], "SeeEnemy")
      AI_UnregisterForSensor(data.BlotworxSpawned[x], "SeePlayer")
      AI_UnregisterForSensor(data.BlotworxSpawned[x], "HearEnemyFootsteps")
      AI_UnregisterForSensor(data.BlotworxSpawned[x], "Attract")
    end
    Prefab_Projector_ChangeState("TrainTunnels3DProjectorMarker", "Deactivate")
    AnimGBSequence("TrainTunnelsDoor", "rest")
    GrabCamera("BlotworxWallSequence_00", nil, CAMERA_INSTANT_TRANSITION, 0, GetNetworkPlayer())
    AudioPostEventOn(GetPlayer(), "Play_sfx_BlotAlley_IGC_WallsFall")
    EnableSplitScreen(false)
    StartFadeIn(0.800000011920929)
    wait(0.4000000059604645)
    GrabCamera("BlotworxWallSequence_01", nil, CAMERA_LERP_TRANSITION, 10, GetNetworkPlayer())
    Unhide("BlotworxWall1_BreakFX")
    StartEmitters("BlotworxWall1_BreakFX")
    AudioPostEventOn("nos_blotalley_01a_audio.SND_BlotworxWall1", "Play_sfx_BlotworxStoneWallFall")
    ShakeCamera(1.2999999523162842, 7, 0.5, 0.4000000059604645, 0.009999999776482582, 0.0020000000949949026)
    wait(0.20000000298023224)
    Hide("BlotworxWall1")
    wait(0.5)
    StopEmitters("BlotworxWall1_BreakFX")
    Hide("BlotworxWall1_BreakFX")
  elseif (_Section == "2") then
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    GrabCamera("BlotworxWallSequence_02", nil, CAMERA_INSTANT_TRANSITION, 0, GetNetworkPlayer())
    StartFadeIn(0.800000011920929)
    wait(0.4000000059604645)
    ForceSequence(GetRelativePrefabEntity(target, ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_BlotworxAttack2")
    GrabCamera("BlotworxWallSequence_03", nil, CAMERA_LERP_TRANSITION, 10, GetNetworkPlayer())
    Unhide("BlotworxWall2_BreakFX")
    StartEmitters("BlotworxWall2_BreakFX")
    AudioPostEventOn("nos_blotalley_01a_audio.SND_BlotworxWall2", "Play_sfx_BlotworxStoneWallFall")
    ShakeCamera(1.2999999523162842, 7, 0.5, 0.4000000059604645, 0.009999999776482582, 0.0020000000949949026)
    wait(0.20000000298023224)
    Hide("BlotworxWall2")
    wait(1.5)
    StopEmitters("BlotworxWall2_BreakFX")
  elseif (_Section == "3") then
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    GrabCamera("BlotworxWallSequence_04", nil, CAMERA_INSTANT_TRANSITION, 0, GetNetworkPlayer())
    StartFadeIn(0.800000011920929)
    wait(0.4000000059604645)
    ForceSequence(GetRelativePrefabEntity(target, ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_BlotworxAttack3")
    GrabCamera("BlotworxWallSequence_05", nil, CAMERA_LERP_TRANSITION, 10, GetNetworkPlayer())
    Unhide("BlotworxWall3_BreakFX")
    StartEmitters("BlotworxWall3_BreakFX")
    AudioPostEventOn("nos_blotalley_01a_audio.SND_BlotworxWall3", "Play_sfx_BlotworxWoodWallFall")
    ShakeCamera(1.2999999523162842, 7, 0.5, 0.4000000059604645, 0.009999999776482582, 0.0020000000949949026)
    wait(0.20000000298023224)
    Hide("BlotworxWall3")
    wait(1.5)
    StopEmitters("BlotworxWall3_BreakFX")
  elseif (_Section == "4") then
    if (GetGlobal("NOS_BlotAlley_Ditto_Thanks_Played") == 1) then
      StartFadeOut(0.800000011920929)
      wait(0.800000011920929)
      GrabCamera("BlotworxWallSequence_06", nil, CAMERA_INSTANT_TRANSITION, 0, GetNetworkPlayer())
      StartFadeIn(0.800000011920929)
      wait(0.4000000059604645)
      GrabCamera("BlotworxWallSequence_07", nil, CAMERA_LERP_TRANSITION, 10, GetNetworkPlayer())
      ForceSequence(GetRelativePrefabEntity(target, ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_BlotworxAttack4")
      local Ditto, Ditto = GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".Gremlin"), 10
      Ditto = "NOS_BlotAlley_Petetronic"
      Ditto = false
      TeleportGremlinToEntity(Ditto, GetRelativePrefabEntity(Ditto, ".Gremlin_DittoRepairPoint"), Ditto, false)
      Ditto = 1
      AnimVarInt(Ditto, VAR_Cutscene, Ditto)
      AnimEvent(Ditto, EVENT_Start_Cutscene)
      StartEmitters("PeteGeneratorFX")
    else
      Prefab_BlotAlleyPete_DoorBlotworxSequence(target, "5")
      if (_Section == "5") then
        StartFadeOut(0.800000011920929)
        wait(0.800000011920929)
        EnableSplitScreen(true)
        TeleportToEntity(GetPlayer(), "PeteAfterIGC_MickeyMarker")
        TeleportToEntity(GetPlayer2OrAI(), "PeteAfterIGC_OswaldMarker")
        local (for index), (for limit), (for step) = 1, 3, 1
        for x = (for index), (for limit), (for step) do
          (for index) = data.BlotworxSpawned
          (for index) = (for index)[x]
          (for limit) = "SeeEnemy"
          AI_RegisterForSensor((for index), (for limit))
          (for index) = data.BlotworxSpawned
          (for index) = (for index)[x]
          (for limit) = "SeePlayer"
          AI_RegisterForSensor((for index), (for limit))
          (for index) = data.BlotworxSpawned
          (for index) = (for index)[x]
          (for limit) = "HearEnemyFootsteps"
          AI_RegisterForSensor((for index), (for limit))
          (for index) = data.BlotworxSpawned
          (for index) = (for index)[x]
          (for limit) = "Attract"
          AI_RegisterForSensor((for index), (for limit))
          (for index) = data.BlotworxSpawned
          (for index) = (for index)[x]
          (for limit) = "BlotworxAfterIGCMarker"
          (for step) = tostring
          x = x
          (for step) = (for step)(x)
          (for limit) = ((for limit) .. (for step))
          TeleportToEntity((for index), (for limit))
        end
        ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetNetworkPlayer())
        StartFadeIn(0.800000011920929)
        DestroyEntity(GetRelativePrefabEntity(target, ".Gremlin"))
        UnrestrictCutSceneInput()
        SetGlobal("NOS_BlotAlley_Petetronic_BlotworxAttack_Played", 1)
        NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Club13")
        if (GetGlobal("NOS_BlotAlley_ChainOpenDoorFromGremlin") == 1) then
          while true do
            if (not (IsAnySequencePlaying() == true)) then
              break
            end
            wait(0.10000000149011612)
          end
          ForceSequence(GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_OpenDoor")
        end
      end
    end
  elseif (_Section == "5") then
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    EnableSplitScreen(true)
    TeleportToEntity(GetPlayer(), "PeteAfterIGC_MickeyMarker")
    TeleportToEntity(GetPlayer2OrAI(), "PeteAfterIGC_OswaldMarker")
    local (for index), (for limit), (for step) = 1, 3, 1
    for x = (for index), (for limit), (for step) do
      (for index) = data.BlotworxSpawned
      (for index) = (for index)[x]
      (for limit) = "SeeEnemy"
      AI_RegisterForSensor((for index), (for limit))
      (for index) = data.BlotworxSpawned
      (for index) = (for index)[x]
      (for limit) = "SeePlayer"
      AI_RegisterForSensor((for index), (for limit))
      (for index) = data.BlotworxSpawned
      (for index) = (for index)[x]
      (for limit) = "HearEnemyFootsteps"
      AI_RegisterForSensor((for index), (for limit))
      (for index) = data.BlotworxSpawned
      (for index) = (for index)[x]
      (for limit) = "Attract"
      AI_RegisterForSensor((for index), (for limit))
      (for index) = data.BlotworxSpawned
      (for index) = (for index)[x]
      (for limit) = "BlotworxAfterIGCMarker"
      (for step) = tostring
      x = x
      (for step) = (for step)(x)
      (for limit) = ((for limit) .. (for step))
      TeleportToEntity((for index), (for limit))
    end
    ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetNetworkPlayer())
    StartFadeIn(0.800000011920929)
    DestroyEntity(GetRelativePrefabEntity(target, ".Gremlin"))
    UnrestrictCutSceneInput()
    SetGlobal("NOS_BlotAlley_Petetronic_BlotworxAttack_Played", 1)
    NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Club13")
    if (GetGlobal("NOS_BlotAlley_ChainOpenDoorFromGremlin") == 1) then
      while true do
        if (not (IsAnySequencePlaying() == true)) then
          break
        end
        wait(0.10000000149011612)
      end
      ForceSequence(GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_OpenDoor")
    end
  end
  return 
end
Prefab_BlotAlleyPete_GoToDoorSequenceFromBlocking = function(target)
  Print("__Function: Prefab_BlotAlleyPete_GoToDoorSequenceFromBlocking")
  RestrictCutSceneInput()
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  ForceSequence(GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_BlotworxAttack")
  return 
end
Prefab_BlotAlleyPete_GusHint = function(target)
  Print("_Function: Prefab_BlotAlleyPete_GusHint")
  wait(15)
  ForceSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_BlotworxHint")
  return 
end
Prefab_BlotAlleyPete_SpawnBlotworx = function(target, _Section)
  Print(("__Function: Prefab_BlotAlleyPete_SpawnBlotworx, _Section: " .. tostring(_Section)))
  local data = GetPrefabData("NOS_BlotAlley_Petetronic")
  if (_Section == "1") then
    local (for index), (for limit), (for step) = 1, 3, 1
    for x = (for index), (for limit), (for step) do
      if (x == 1) then
        SetPropertyInt(GetRelativePrefabEntity(target, ".BlotworxSpawner"), "Index To Spawn", 1)
      end
      SetPropertyInt(GetRelativePrefabEntity(target, ".BlotworxSpawner"), "Index To Spawn", 0)
      local SpawnMarker = GetRelativePrefabEntity(target, (".BlotworxSpawnLocation" .. tostring(x)))
      TeleportToEntity(GetRelativePrefabEntity(target, ".BlotworxSpawner"), SpawnMarker)
      wait(0.10000000149011612)
      local Spawned = ForceSpawn(GetRelativePrefabEntity(target, ".BlotworxSpawner"), 1)
      data.BlotworxSpawned[x] = GetName(Spawned[1])
      wait(1)
    end
  elseif (_Section == "2") then
    SetPropertyInt(GetRelativePrefabEntity(target, ".BlotworxSpawner"), "Index To Spawn", 1)
    local SpawnMarker = GetRelativePrefabEntity(target, ".BlotworxSpawnLocation4")
    TeleportToEntity(GetRelativePrefabEntity(target, ".BlotworxSpawner"), SpawnMarker)
    local Spawned = ForceSpawn(GetRelativePrefabEntity(target, ".BlotworxSpawner"), 1)
    data.BlotworxSpawned[4] = GetName(Spawned[1])
  end
  return 
end
Prefab_BlotAlleyPete_BlotworxHandled = function(target, _Type)
  Print(("__Function: Prefab_BlotAlleyPete_BlotworxHandled, _Type: " .. tostring(_Type)))
  local data = GetPrefabData("NOS_BlotAlley_Petetronic")
  local Activator = GetName(target)
  local (for index), (for limit), (for step) = 1, 4, 1
  for x = (for index), (for limit), (for step) do
    if (Activator == data.BlotworxSpawned[x]) then
      Print((("__Blotworx at [" .. tostring(x)) .. "] handled!"))
      local Betrayal = 0
      local TeamChangeEnemy = 0
      if (_Type == "Death") then
        Print("__Blotworx Killed!")
        if (data.BlotworxOutcome[x] == 1) then
          Print("__BLOTWORX BETRAYAL")
          Betrayal = 1
          ForceSequence(GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_FriendedBlotworxDestroyedTimerDeactive")
        end
        data.BlotworxOutcome[x] = -1
      elseif (_Type == "TeamChange") then
        if (GetCurrentTeam(data.BlotworxSpawned[x]) == 3) then
          Print("__Blotworx Friended!")
          data.BlotworxOutcome[x] = 1
        else
          Print("__Blotworx made enemy! Incrimenting count")
          data.BlotworxLeft = (data.BlotworxLeft + 1)
          data.BlotworxOutcome[x] = 0
          TeamChangeEnemy = 1
        end
      end
      if (Betrayal == 0) then
        if (TeamChangeEnemy == 0) then
          data.BlotworxLeft = (data.BlotworxLeft - 1)
        end
      end
    else
    end
  end
  Print(("__BlotworxLeft: " .. tostring(data.BlotworxLeft)))
  if (data.BlotworxLeft == 1) then
    if (GetGlobal("NOS_BlotAlley_Petetronic_LastBwxDealt_Played") == 0) then
      Print("__Opening Door!")
      SetGlobal("NOS_BlotAlley_TotalBlotworxSpawned", -2)
      while true do
        if (not (IsAnySequencePlaying() == true)) then
          break
        end
        wait(0.10000000149011612)
      end
      ForceSequence(GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_OpenDoor")
      SetPropertyFloat(GetRelativePrefabEntity(target, ".DoorbellMarker"), "UsableRadius", 2)
    end
  elseif (data.BlotworxLeft == 0) then
    Print("__Queueing Reward!")
    if (data.BlotworxOutcome[1] == 1) then
      if (data.BlotworxOutcome[2] == 1) then
        if (data.BlotworxOutcome[3] == 1) then
          if (data.BlotworxOutcome[4] == 1) then
            SetGlobal("NOS_BlotAlley_TotalBlotworxSpawned", 1)
            GiveCollectible("Challenge_BlotAlleySuperstar_Tracker")
          end
        end
      end
    elseif (data.BlotworxOutcome[1] == -1) then
      if (data.BlotworxOutcome[2] == -1) then
        if (data.BlotworxOutcome[3] == -1) then
          if (data.BlotworxOutcome[4] == -1) then
            SetGlobal("NOS_BlotAlley_TotalBlotworxSpawned", -1)
          end
        end
      end
    else
      SetGlobal("NOS_BlotAlley_TotalBlotworxSpawned", 0)
    end
    while true do
      if (not (IsAnySequencePlaying() == true)) then
        break
      end
      wait(0.10000000149011612)
    end
    SetGlobal("NOS_BlotAlleyProgress", 1)
    if (GetGlobal("NOS_BlotAlley_Petetronic_LastBwxDealt_Played") == 0) then
      ForceSequence(GetRelativePrefabEntity("NOS_BlotAlley_Petetronic", ".PeteConversationMarker"), "NOS_BlotAlley_Petetronic_LastBwxDealt")
      SetGlobal("NOS_BlotAlley_Petetronic_LastBwxDealt_Played", 1)
      NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Club13")
    end
  end
  return 
end
Prefab_BlotAlleyPete_ForceRewardFromGremlin = function(target)
  Print("__Function: Prefab_BlotAlleyPete_ForceRewardFromGremlin")
  local data = GetPrefabData("NOS_BlotAlley_Petetronic")
  Print("__Forcing Reward!")
  if (data.BlotworxOutcome[1] == 1) then
    if (data.BlotworxOutcome[2] == 1) then
      if (data.BlotworxOutcome[3] == 1) then
        SetGlobal("NOS_BlotAlley_TotalBlotworxSpawned", 1)
        GiveCollectible("Challenge_BlotAlleySuperstar_Tracker")
      end
    end
  elseif (data.BlotworxOutcome[1] == -1) then
    if (data.BlotworxOutcome[2] == -1) then
      if (data.BlotworxOutcome[3] == -1) then
        SetGlobal("NOS_BlotAlley_TotalBlotworxSpawned", -1)
      end
    end
  else
    SetGlobal("NOS_BlotAlley_TotalBlotworxSpawned", 0)
  end
  SetPropertyFloat(GetRelativePrefabEntity(target, ".DoorbellMarker"), "UsableRadius", 2)
  SetGlobal("NOS_BlotAlley_Petetronic_LastBwxDealt_Played", 1)
  SetGlobal("NOS_BlotAlleyProgress", 1)
  NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Club13")
  return 
end
Prefab_BlotAlleyPete_OpenDoor = function(target)
  Print("__Function: Prefab_BlotAlleyPete_OpenDoor")
  AnimGBSequence("TrainTunnelsDoor", "open")
  Quest_SetCriticalPath("Critical_BlotAlley", "Critical_BlotAlley_3")
  Prefab_Projector_ChangeState("NOS_BlotAlley_TrainTunnelsProjector", "Activate")
  if (GetGlobal("NOS_BlotAlley_Ditto_Thanks_Played") == 0) then
    Prefab_BlotAlleyPete_SpawnBlotworx(target, "2")
    StartEmitters("PeteGeneratorFX")
  end
  SetGlobal("NOS_BlotAlley_Petetronic_OpenDoor_Played", 1)
  NOS_BlotAlley_HandleHintNodes(nil, "TTProjector")
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  return 
end
Prefab_BlotAlleyPete_CalculateScrapMetalReturn = function(target, _Modifier)
  Print("__Function: Prefab_BlotAlleyPete_CalculateScrapMetalReturn")
  local ScrapReturn = GetGlobal("NOS_BlotAlley_PeteScrapMetal_InitialInvestment")
  if (ScrapReturn == 0) then
    ScrapReturn = 1
  end
  if (_Modifier == "Paint") then
    GiveCurrencyItem("Silver_Pin", 1)
  elseif (_Modifier == "Neutral") then
    if (GetGlobal("NOS_BlotAlley_Ditto_Thanks_Played") ~= 1) then
      ScrapReturn = math.ceil((ScrapReturn * 0.800000011920929))
      if (_Modifier == "Thinner") then
        AddCurrency("ETicket", 100)
        ScrapReturn = math.ceil((ScrapReturn * 0.30000001192092896))
      end
    end
  elseif (_Modifier == "Thinner") then
    AddCurrency("ETicket", 100)
    ScrapReturn = math.ceil((ScrapReturn * 0.30000001192092896))
  end
  Print(("__ScrapReturn: " .. tostring(ScrapReturn)))
  AddCurrency("ScrapMetal", ScrapReturn)
  SetGlobal("NOS_BlotAlley_PeteScrapMetal_InitialInvestment", -1)
  NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Club13")
  return 
end
Prefab_BlotAlleyPete_SetEndGameMovieVariableAndChangeVisit = function(target)
  Print("__Function: Prefab_BlotAlleyPete_SetEndGameMovieVariable")
  return 
end
