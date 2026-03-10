local musicevent = 0
NOS_BogEasy_TrainRideSetup = function(target)
  Print("__Function: NOS_BogEasy_TrainRideSetup")
  if (GetName(target) == "nos_bogeasy_01a_louisshackarea_rv.CHECKPOINT_TrainTeleportMarker_Mickey") then
    if (GetGlobal("EM2_TrainRide") == 1) then
      Print("__Coming from a train ride!")
      RestrictCutSceneInput()
      StartFadeOut(0)
      Print("__LOAD: STARTING FADE OUT")
      wait(0.5)
      Print("__LOAD: TELEPORTING PLAYER")
      TeleportToEntity(GetPlayer(), "CHECKPOINT_TrainTeleportMarker")
      TeleportToEntity(GetPlayer2OrAI(), "CHECKPOINT_TrainTeleportMarker_Oswald")
      Print("__LOAD: TELEPORTING CAMERA")
      GrabCamera("TrainLoadCamera", nil, CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
      GrabCamera("TrainLoadCamera", nil, CAMERA_INSTANT_TRANSITION, 0, GetPlayer2OrAI())
      wait(0.10000000149011612)
      Print("__LOAD: RELEASING CAMERA")
      ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
      ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0, GetPlayer2OrAI())
      Print("__LOAD: FADE IN")
      wait(0.4000000059604645)
      UnrestrictCutSceneInput()
      StartFadeIn(0.800000011920929)
      wait(0.800000011920929)
      NOS_BogEasy_SaveCheckpoint("CHECKPOINT_TrainTeleportMarker")
    end
  end
  NOS_BogEasy_AlwaysSetup(target)
  if (GetName(target) == "nos_bogeasy_01a_louisshackarea_rv.CHECKPOINT_TrainTeleportMarker_Mickey") then
    if (GetGlobal("EM2_TrainRide") == 1) then
      SetGlobal("EM2_TrainRide", 0)
      wait(0.800000011920929)
      ForceSequence("NOS_BogEasy_SpiritOfTheWasteland", "nos_spirit_TrainWelcome")
    end
  end
  return 
end
NOS_BogEasy_AlwaysSetup = function(target)
  Print("___Function: NOS_BogEasy_AlwaysSetup")
  Print("___Bog Easy Return Visit Setup Function")
  SetGlobal("NOS_BogEasy_FirstVisit", 0)
  if (musicevent == 0) then
    musicevent = 1
    MusicPostEventOn(GetPlayer(), "Play_MX_BOG")
    RemoveAllMusicStateOverride()
    Print("Started music event from NOS_BogEasy_AlwaysSetup")
  end
  return 
end
local TomInFinalTrigger = 0
NOS_BogEasy_TrainQuest_OnTVDropped = function(target)
  Print("__Function: NOS_BogEasy_TrainQuest_OnTVDropped")
  return 
end
NOS_BogEasy_TrainQuest_TVGone = function(target)
  Print("__Function: NOS_BogEasy_TrainQuest_TVGone")
  ForceSequence("NOS_BogEasy_Pedestrian_TrainConductorTom_V2", "NOS_Tom_TrainQuest_LureIdle")
  return 
end
NOS_BogEasy_TrainQuest_TomInFinalTrigger = function(target, _In)
  Print(("__Function: NOS_BogEasy_TrainQuest_TomInFinalTrigger, _In: " .. tostring(_In)))
  if (_In == "In") then
    Print("__Tom entered the trigger!")
    SetGlobal("NOS_BogEasy_TrainQuest_TomInTrigger", 1)
  else
    Print("__Tom exited the trigger!")
    if (GetGlobal("NOS_BogEasy_TrainQuest_TomInTrigger") == 2) then
      Print("__But we fired the complete sequence. not resetting!")
      return 
    else
      SetGlobal("NOS_BogEasy_TrainQuest_TomInTrigger", 0)
    end
  end
  return 
end
NOS_BogEasy_TrainQuest_TeleportToStation = function(target)
  Print("__NOS_BogEasy_TrainQuest_TeleportToStation")
  RestrictCutSceneInput()
  StartFadeOut(0.800000011920929)
  wait(0.800000011920929)
  SetPropertyBool("NOS_BogEasy_Pedestrian_TrainConductorTom_V2", "ShouldFacePlayer", false)
  TeleportToEntity("NOS_BogEasy_Pedestrian_TrainConductorTom_V2", "NOS_BogEasy_TrainQuest_QuestCompletedTeleportMarker")
  SetGlobal("NOS_BogEasy_TrainRestored", 1)
  wait(0.800000011920929)
  StartFadeIn(0.800000011920929)
  FireUser1("TrainStationExplosion")
  UnrestrictCutSceneInput()
  NOS_BogEasy_SaveCheckpoint("CHECKPOINT_LouisShack_Airlock")
  return 
end
NOS_BogEasy_ReturnVisit_DonaldStreamed = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_DonaldStreamed")
  local DoCheck = 1
  local Tugboat = -1
  local Submarine = 0
  if (Quest_CheckStatus("Donalds_Date", "Donalds_Date_3a", Quest_Completed) ~= true) then
  end
  local QuestsNotComplete = false
  Print(("__Quests not complete?: " .. tostring(QuestsNotComplete)))
  if QuestsNotComplete then
    if (GetGlobal("NOS_BogEasy_DonaldQuest_DonaldTimerState") ~= 2) then
      if (GetGlobal("NOS_Sparks_OnCageBroken_Played") == 1) then
        Tugboat = 0
        Unhide("NOS_BogEasy_AnimatronicDonald_V2")
        if (GetGlobal("NOS_Sparks_DonaldQuest_GetGear_Played") == 1) then
          Tugboat = 1
          if (GetGlobal("NOS_BogEasy_DonaldQuest_WhichGear") == 10) then
            Tugboat = 2
            Submarine = 1
          end
        end
      else
        DestroyEntity("NOS_BogEasy_AnimatronicDonald_V2")
        if (GetGlobal("NOS_BogEasy_DonaldQuest_DonaldTimerState") == 2) then
          Print("__Quest abandoned!")
        else
          Print("__Quest Complete!")
        end
        DestroyEntity("NOS_BogEasy_DonaldTugboat")
        DestroyEntity("DonaldQuest_TugboatRippleFX")
        DestroyEntity("NOS_BogEasy_DonaldSubmarine")
        DestroyEntity("DonaldQuest_SubmarineRippleFX")
        DestroyEntity("NOS_BogEasy_AnimatronicDonald_V2")
        DoCheck = 0
      end
    end
  else
    if (GetGlobal("NOS_BogEasy_DonaldQuest_DonaldTimerState") == 2) then
      Print("__Quest abandoned!")
    else
      Print("__Quest Complete!")
    end
    DestroyEntity("NOS_BogEasy_DonaldTugboat")
    DestroyEntity("DonaldQuest_TugboatRippleFX")
    DestroyEntity("NOS_BogEasy_DonaldSubmarine")
    DestroyEntity("DonaldQuest_SubmarineRippleFX")
    DestroyEntity("NOS_BogEasy_AnimatronicDonald_V2")
    DoCheck = 0
  end
  if (DoCheck == 1) then
    if (Tugboat == -1) then
      Hide("NOS_BogEasy_DonaldTugboat")
      Hide("DonaldQuest_TugboatRippleFX")
    elseif (Tugboat == 0) then
      AnimGBSequence("DonaldQuest_TugboatRippleFX", "float")
    elseif (Tugboat == 1) then
      TeleportToEntity("NOS_BogEasy_DonaldTugboat", "DonaldQuest_DonaldTugboat_TugboatPositionFixed")
      AnimGBSequence("DonaldQuest_TugboatRippleFX", "float")
      SetPropertyFloat("NOS_BogEasy_DonaldTugboat", "Weight Requirement", 10000)
    else
      DestroyEntity("NOS_BogEasy_DonaldTugboat")
      DestroyEntity("DonaldQuest_TugboatRippleFX")
    end
    if (Submarine == 0) then
      AudioPostEventOn("NOS_BogEasy_DonaldSubmarine", "Stop_sfx_Donald_sub_sinking")
      Hide("NOS_BogEasy_DonaldSubmarine")
      Hide("DonaldQuest_SubmarineRippleFX")
    elseif (Submarine == 1) then
      Unhide("NOS_BogEasy_DonaldSubmarine")
      TeleportToEntity("NOS_BogEasy_DonaldSubmarine", "SubmarineTeleportPosition")
      AnimGBSequence("DonaldQuest_SubmarineRippleFX", "float")
    else
      AudioPostEventOn("NOS_BogEasy_DonaldSubmarine", "Stop_sfx_Donald_sub_sinking")
      DestroyEntity("NOS_BogEasy_DonaldSubmarine")
      DestroyEntity("DonaldQuest_SubmarineRippleFX")
    end
  end
  return 
end
NOS_BogEasy_ReturnVisit_DonaldQuestUpdate = function(target, _Section)
  Print(("__Function: NOS_BogEasy_ReturnVisit_DonaldQuestUpdate, _Section: " .. tostring(_Section)))
  if (_Section == "1") then
    SetGlobal("NOS_BogEasy_DonaldQuest_DonaldTimerState", 0)
    wait(3)
    ForceSequence("NOS_BogEasy_Gus", "NOS_Gus_DonaldQuest_QuestStarted")
    NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
  elseif (_Section == "2") then
    SetGlobal("NOS_Sparks_DonaldQuest_ForgeFixed_Played", 1)
    SetGlobal("NOS_BogEasy_DonaldQuest_DonaldTimerState", 1)
    if (GetGlobal("NOS_BogEasy_SparksLocation") == 0) then
      NOS_BogEasy_SaveCheckpoint("CHECKPOINT_LouisShack_Airlock")
    elseif (GetGlobal("NOS_BogEasy_SparksLocation") == 1) then
      NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
      if (_Section ~= "3") then
        if (_Section == "4") then
          RestrictCutSceneInput()
          StartFadeOut(0.800000011920929)
          wait(0.800000011920929)
          SetGlobal("NOS_BogEasy_DonaldQuest_WhichCompleted", -1)
          DestroyEntity("NOS_BogEasy_AnimatronicDonald_V2")
          DestroyEntity("NOS_BogEasy_DonaldTugboat")
          DestroyEntity("DonaldQuest_TugboatRippleFX")
          DestroyEntity("DonaldQuest_ConversationMarker")
          StartFadeIn(0.800000011920929)
          UnrestrictCutSceneInput()
          NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
        elseif (_Section == "5") then
          RestrictCutSceneInput()
          StartFadeOut(0.800000011920929)
          wait(0.800000011920929)
          EnableSplitScreen(false)
          Hide("NOS_BogEasy_AnimatronicDonald_V2")
          SetCameraAttributesForPlayer("DonaldQuest_FinalCameraOverride", GetPlayer())
          StartFadeIn(0.800000011920929)
          AudioPostEventOn("NOS_BogEasy_DonaldSubmarine", "Play_sfx_Donald_sub_sinking")
          AnimGBSequence("NOS_BogEasy_DonaldSubmarine", "dive")
          AnimGBSequence("DonaldQuest_SubmarineRippleFX", "dive")
          wait(1)
          ForceSequence("NOS_BogEasy_AnimatronicDonald_V2", "NOS_Donald_DonaldQuest_SubmarineTakingOff")
          wait(9)
          SetGlobal("NOS_BogEasy_DonaldQuest_WhichCompleted", 1)
          StartFadeOut(0.800000011920929)
          wait(0.800000011920929)
          ClearAllCameraAttributes()
          DestroyEntity("NOS_BogEasy_AnimatronicDonald_V2")
          AudioPostEventOn("NOS_BogEasy_DonaldSubmarine", "Stop_sfx_Donald_sub_sinking")
          DestroyEntity("NOS_BogEasy_DonaldSubmarine")
          DestroyEntity("DonaldQuest_SubmarineRippleFX")
          DestroyEntity("DonaldQuest_ConversationMarker")
          EnableSplitScreen(true)
          StartFadeIn(0.800000011920929)
          UnrestrictCutSceneInput()
          NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
        end
      end
    end
  elseif (_Section ~= "3") then
    if (_Section == "4") then
      RestrictCutSceneInput()
      StartFadeOut(0.800000011920929)
      wait(0.800000011920929)
      SetGlobal("NOS_BogEasy_DonaldQuest_WhichCompleted", -1)
      DestroyEntity("NOS_BogEasy_AnimatronicDonald_V2")
      DestroyEntity("NOS_BogEasy_DonaldTugboat")
      DestroyEntity("DonaldQuest_TugboatRippleFX")
      DestroyEntity("DonaldQuest_ConversationMarker")
      StartFadeIn(0.800000011920929)
      UnrestrictCutSceneInput()
      NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
    elseif (_Section == "5") then
      RestrictCutSceneInput()
      StartFadeOut(0.800000011920929)
      wait(0.800000011920929)
      EnableSplitScreen(false)
      Hide("NOS_BogEasy_AnimatronicDonald_V2")
      SetCameraAttributesForPlayer("DonaldQuest_FinalCameraOverride", GetPlayer())
      StartFadeIn(0.800000011920929)
      AudioPostEventOn("NOS_BogEasy_DonaldSubmarine", "Play_sfx_Donald_sub_sinking")
      AnimGBSequence("NOS_BogEasy_DonaldSubmarine", "dive")
      AnimGBSequence("DonaldQuest_SubmarineRippleFX", "dive")
      wait(1)
      ForceSequence("NOS_BogEasy_AnimatronicDonald_V2", "NOS_Donald_DonaldQuest_SubmarineTakingOff")
      wait(9)
      SetGlobal("NOS_BogEasy_DonaldQuest_WhichCompleted", 1)
      StartFadeOut(0.800000011920929)
      wait(0.800000011920929)
      ClearAllCameraAttributes()
      DestroyEntity("NOS_BogEasy_AnimatronicDonald_V2")
      AudioPostEventOn("NOS_BogEasy_DonaldSubmarine", "Stop_sfx_Donald_sub_sinking")
      DestroyEntity("NOS_BogEasy_DonaldSubmarine")
      DestroyEntity("DonaldQuest_SubmarineRippleFX")
      DestroyEntity("DonaldQuest_ConversationMarker")
      EnableSplitScreen(true)
      StartFadeIn(0.800000011920929)
      UnrestrictCutSceneInput()
      NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
    end
  end
  return 
end
NOS_BogEasy_ReturnVisit_DonaldQuestLeftZone = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_DonaldQuestLeftZone")
  Print("__Setting Donald Quest to LEFT ZONE!")
  GiveCollectible("Challenge_Perfectionist_DonaldDate_Tracker")
  SetGlobal("NOS_BogEasy_DonaldQuest_Sparks", -1)
  SetGlobal("NOS_BogEasy_DonaldQuest_DonaldTimerState", 2)
  return 
end
NOS_BogEasy_ReturnVisit_GateStreamed = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_GateStreamed")
  AnimGBSequence("NOS_BogEasy_GraveyardGate", "open")
  return 
end
NOS_BogEasy_ReturnVisit_ExitForge = function(target)
  Print("__Function: NOS_ReturnVisit_ExitForge")
  if (GetGlobal("NOS_BogEasy_DonaldQuest_OswaldToGenerator") == 1) then
    if (GetGlobal("NOS_Sparks_DonaldQuest_FixForge_Played") == 1) then
      if (GetGlobal("NOS_Sparks_DonaldQuest_ForgeFixed_Played") == 0) then
        Prefab_GremlinForge_SendOswaldToGenerator(target)
      end
    end
  end
  RemoveAllMusicStateOverride()
  Prefab_ExitInterior_FadeIn()
  return 
end
NOS_BogEasy_ReturnVisit_SparksGeneratorExplanation = function(target, _Section)
  Print(("__Function: NOS_BogEasy_ReturnVisit_SparksGeneratorExplanation, _Section: " .. tostring(_Section)))
  if (_Section == "1") then
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    RestrictCutSceneInput()
    ClearAllCameraAttributes()
    GrabCamera("ForgeIGC 00", nil, CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
    wait(0.10000000149011612)
    StartFadeIn(0.800000011920929)
    wait(0.4000000059604645)
    GrabCamera("ForgeIGC 01", nil, CAMERA_LERP_TRANSITION, 5, GetPlayer())
  elseif (_Section == "2") then
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    GrabCamera("ForgeIGC 02", nil, CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
    wait(0.10000000149011612)
    StartFadeIn(0.800000011920929)
    wait(0.4000000059604645)
    GrabCamera("ForgeIGC 03", nil, CAMERA_LERP_TRANSITION, 6, GetPlayer())
    SplineFollower_StopAtPosition("Forge_EmergencyGeneratorPlatform", "Forge_EmergencyGenerator_Knot1", "Forge_EmergencyGenerator_Knot2", 1)
    SplineFollower_SetDisabled("Forge_EmergencyGeneratorPlatform", false)
    StartEmitters("EmergencyGeneratorFX")
    wait(4)
    StopEmitters("EmergencyGeneratorFX")
  elseif (_Section == "3") then
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
    wait(0.10000000149011612)
    local Cam_Override1 = GetRelativePrefabEntity("NOS_BogEasy_EnterInterior_Forge", ".ExitBuildingOverride1")
    local Cam_Override2 = GetRelativePrefabEntity("NOS_BogEasy_EnterInterior_Forge", ".ExitBuildingOverride2")
    SetCameraAttributesForPlayer(Cam_Override1, GetPlayer())
    SetCameraAttributesForPlayer(Cam_Override2, GetPlayerOrAI(PLAYER_TWO))
    UnrestrictCutSceneInput()
    StartFadeIn(0.800000011920929)
  end
  return 
end
NOS_BogEasy_ReturnVisit_OswaldReachedTarget = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_OswaldReachedTarget")
  ForceSequence("NOS_BogEasy_Oswald", "NOS_Oswald_GotoGenerator")
  Disable(target)
  OswaldStreamAction("GremlinForge_OswaldBackupGeneratorShockPoint", -1)
  return 
end
NOS_BogEasy_ReturnVisit_DonaldBoatJumped = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_DonaldBoatJumped")
  Print(("__WHO DID THIS???: " .. tostring(GetName(_activator()))))
  ForceSequence("NOS_BogEasy_AnimatronicDonald_V2", "NOS_Donald_Tugboat_JumpedOn")
  return 
end
NOS_BogEasy_ReturnVisit_RealGearGot = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_RealGearGot")
  if (GetGlobal("NOS_BogEasy_DonaldQuest_DonaldTimerState") ~= 2) then
    RestrictCutSceneInput()
    while true do
      if (not (IsAnySequencePlaying() == true)) then
        break
      end
      wait(0.10000000149011612)
    end
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    EnableSplitScreen(false)
    SetGlobal("NOS_BogEasy_GilbertGearIGC", 1)
    DestroyEntity("NOS_BogEasy_Ghost_Gilbert")
    TeleportToEntity(GetPlayer(), "GilbertGearGot_MickeyTeleport")
    TeleportToEntity(GetPlayer2OrAI(), "GilbertGearGot_OswaldTeleport")
    wait(0.20000000298023224)
    TeleportToEntity("Ghost_Gilbert_CutsceneCopy", "GilbertGearGotTeleportMarker")
    Unhide("Ghost_Gilbert_CutsceneCopy")
    if (GetGlobal("NOS_BogEasy_MagicShopEligibleForUpgrade") == 0) then
      FireThread(NOS_BogEasy_MagicShop_GremlinTrigger, "NOS_BogEasy_MagicShop", "In")
    end
    StartFadeIn(0.800000011920929)
    ForceSequence("Ghost_Gilbert_CutsceneCopy", "NOS_Gilbert_DonaldQuest_GotRealGear")
  else
    SetGlobal("NOS_Gilbert_DonaldQuest_GotRealGear_Played", 1)
    ForceSequence("NOS_BogEasy_Gus", "NOS_Gus_RealGearGotDonaldGone")
    NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
  end
  return 
end
NOS_BogEasy_ReturnVisit_RealGearGot_Cleanup = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_RealGearGot_Cleanup")
  SetGlobal("NOS_BogEasy_GilbertGearIGC", 0)
  StartFadeOut(0.800000011920929)
  wait(0.800000011920929)
  EnableSplitScreen(true)
  StartFadeIn(0.800000011920929)
  UnrestrictCutSceneInput()
  NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
  return 
end
NOS_BogEasy_ReturnVisit_BertrandMetairieFacePlayer = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_BertrandMetairieFacePlayer")
  FaceEntity("NOS_BogEasy_Pedestrian_Bertrand", GetPlayer())
  FaceEntity("NOS_BogEasy_Pedestrian_Metairie_V2", GetPlayer())
  return 
end
NOS_BogEasy_ReturnVisit_MagicShopNPCStreamed = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_MagicShopNPCStreamed")
  if (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingOccupant") ~= -1) then
    DestroyEntity(target)
  end
  return 
end
NOS_BogEasy_ReturnVisit_PickNPCForMagicShopInterior = function(target)
  Print("___Function: NOS_BogEasy_ReturnVisit_PickNPCForMagicShopInterior")
  if (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingOccupant") == -1) then
    GetPrefabData("NOS_BogEasy_EnterInterior_MagicShop").InteriorToStream = "Interior_Magic_Empty"
  elseif (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingOccupant") == 1) then
    GetPrefabData("NOS_BogEasy_EnterInterior_MagicShop").InteriorToStream = "Interior_Magic_Bertrand"
  elseif (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingOccupant") == 2) then
    GetPrefabData("NOS_BogEasy_EnterInterior_MagicShop").InteriorToStream = "Interior_Magic_Metairie"
  end
  return 
end
NOS_BogEasy_ReturnVisit_PickNPCForMagicShopInterior_Part2 = function(target)
  Print("___Function: NOS_BogEasy_ReturnVisit_PickNPCForMagicShopInterior_Part2")
  if (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingOccupant") == 1) then
    if (GetGlobal("NOS_BogEasy_NumBunnyHats") ~= 0) then
      Prefab_BunnyHat_HideInteriorBunnyHat("InteriorBunnyHat")
    end
  end
  ReplaceMusicStateOverride("BOG_IntMagicShop")
  Prefab_EnterInterior_FadeIn()
  math.randomseed(os.time())
  return 
end
NOS_BogEasy_ReturnVisit_RollyStreamed = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_RollyStreamed")
  if (not (not Quest_CheckStatus("Out_Of_Toon", "Out_Of_Toon_2a", Quest_Completed))) then
    DestroyEntity(target)
  end
  return 
end
NOS_BogEasy_ReturnVisit_FineasStreamed = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_FineasStreamed")
  if (GetGlobal("NOS_BogEasy_JugbandState") == -1) then
    DestroyEntity(target)
  elseif (GetGlobal("NOS_BogEasy_JugbandState") == 0) then
    DisableMotion(target)
    NOS_BogEasy_ReturnVisit_HideFineas(target)
  elseif (GetGlobal("NOS_BogEasy_JugbandState") == 1) then
    TeleportToEntity(target, "Fineas_FishingMarker")
    Unhide(target)
  end
  if (not (not Quest_CheckStatus("Out_Of_Toon", "Out_Of_Toon_2a", Quest_Completed))) then
    DestroyEntity(target)
  end
  return 
end
NOS_BogEasy_ReturnVisit_HideFineas = function(target)
  Hide(target)
  return 
end
NOS_BogEasy_ReturnVisit_OutOfToon_FineasAppear = function(target)
  Print("__Function: NOS_BogEasy_ReturnVisit_OutOfToon_FineasAppear")
  StartFadeOut(0.800000011920929)
  wait(0.800000011920929)
  RestrictCutSceneInput()
  EnableSplitScreen(false)
  ForceUnpuddled("NOS_BogEasy_Ghost_Rolly")
  TeleportToEntity(GetPlayer(), "JugbandFix_MickeyTeleportLocation")
  TeleportToEntity(target, "FineasRoofMarker")
  GrabCamera("JugbandFixedCCP1", nil, CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
  Unhide(target)
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  StartFadeIn(0.800000011920929)
  GrabCamera("JugbandFixedCCP2", nil, CAMERA_LERP_TRANSITION, 10, GetPlayer())
  wait(2)
  StartEmitters("FineasAppearFX")
  wait(0.20000000298023224)
  AnimEvent(target, EVENT_Force_Idle)
  wait(0.800000011920929)
  StopEmitters("FineasAppearFX")
  ForceSequence("NOS_BogEasy_Ghost_Fineas", "NOS_Fineas_Jugband")
  return 
end
NOS_BogEasy_JugbandSequenceCleanup = function(target)
  Print("__Function: NOS_BogEasy_JugbandSequenceCleanup")
  GrabCamera("JugbandFixedCCP4", nil, CAMERA_LERP_TRANSITION, 4, GetPlayer())
  NOS_BogEasy_ReturnVisit_OutOfToon_FineasConvoDone("NOS_BogEasy_Ghost_Fineas")
  StartFadeOut(0.800000011920929)
  wait(0.800000011920929)
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
  EnableSplitScreen(true)
  wait(0.10000000149011612)
  UnrestrictCutSceneInput()
  StartFadeIn(0.800000011920929)
  NOS_BogEasy_SaveCheckpoint("CHECKPOINT_ShantyShop_LouisShack")
  return 
end
NOS_BogEasy_ReturnVisit_OutOfToon_FineasConvoDone = function(target, _Done)
  Print("__Function: NOS_BogEasy_ReturnVisit_OutOfToon_FineasConvoDone")
  if (_Done == nil) then
    if (GetGlobal("NOS_BogEasy_JugbandState") == 1) then
      if (IsAnySequencePlaying() == true) then
        wait(0.20000000298023224)
      end
      AnimVarInt(target, VAR_Cutscene, 1)
      AnimEvent(target, EVENT_Start_Cutscene)
      wait(2)
      AnimEvent(target, EVENT_Force_Idle)
      Hide(target)
      TeleportToEntity(target, "Fineas_FishingMarker")
      Unhide(target)
      EnableMotion(target)
    elseif (GetGlobal("NOS_BogEasy_JugbandState") == -1) then
      if (IsAnySequencePlaying() == true) then
        wait(0.20000000298023224)
      end
      AnimVarInt(target, VAR_Cutscene, 1)
      AnimEvent(target, EVENT_Start_Cutscene)
      wait(3)
      Hide(target)
    else
      Print("__How did we get in here? This global should only be 1 or -1!")
      if (IsAnySequencePlaying() == true) then
        wait(0.20000000298023224)
      end
      AnimVarInt(target, VAR_Cutscene, 1)
      AnimEvent(target, EVENT_Start_Cutscene)
      wait(3)
      Hide(target)
    end
  else
    if (IsAnySequencePlaying() == true) then
      wait(0.20000000298023224)
    end
    AnimVarInt(target, VAR_Cutscene, 1)
    AnimEvent(target, EVENT_Start_Cutscene)
    wait(3)
    Hide(target)
  end
  return 
end
NOS_BogEasy_ReturnVisit_OutOfToon_DisableGhosts = function()
  SetPropertyFloat("NOS_BogEasy_Ghost_Rolly", "UsableRadius", 0)
  SetPropertyFloat("NOS_BogEasy_Ghost_Fineas", "UsableRadius", 0)
  return 
end
NOS_BogEasy_LanternBought = function(target)
  Print("__Function: NOS_BogEasy_LanternBought")
  ForceSequence("NOS_BogEasy_ShopKeeperChad, NOS_ShantyShopkeeper_LanternQuestUpdate")
  return 
end
NOS_BogEasy_LoadLevelFromTrain = function(target)
  Print("__Function: NOS_BogEasy_LoadLevelFromTrain")
  if (GetGlobal("NOS_BogEasy_DonaldQuest_DonaldTimerState") == -1) then
    Print("__Donald quest not started or done! Will not update")
  end
  Print("__Donald quest active!")
  local FinishQuest = false
  if (not (not Quest_CheckStatus("Donalds_Date", "Donalds_Date_1", Quest_Discovered))) then
    Quest_SetStatus("Donalds_Date", "Donalds_Date_1", Quest_Unavailable, false)
  end
  if (not (not Quest_CheckStatus("Donalds_Date", "Donalds_Date_4", Quest_Discovered))) then
    Quest_SetStatus("Donalds_Date", "Donalds_Date_4", Quest_Unavailable, false)
  end
  if Quest_CheckStatus("Donalds_Date", "Donalds_Date_4", Quest_Completed) then
    Print("__Forge was fixed! We should send donald off at least in his tugboat")
    FinishQuest = true
  end
  if (not (not Quest_CheckStatus("Donalds_Date", "Donalds_Date_2", Quest_Discovered))) then
    Quest_SetStatus("Donalds_Date", "Donalds_Date_2", Quest_Unavailable, false)
  end
  Print(("__FinishQuest: " .. tostring(FinishQuest)))
  if (FinishQuest == true) then
    GiveCollectible("Challenge_Perfectionist_DonaldDate_Tracker")
    if (GetGlobal("NOS_BogEasy_DonaldQuest_WhichGear") == 10) then
      SetGlobal("NOS_BogEasy_DonaldQuest_WhichCompleted", 1)
      SetGlobal("Extras_Donald_And_Daisy_Paint", 1)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3a", Quest_Unavailable, false)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3b", Quest_Completed, true)
    else
      SetGlobal("NOS_BogEasy_DonaldQuest_WhichCompleted", -1)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3a", Quest_Completed, true)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3b", Quest_Unavailable, false)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3a", Quest_Unavailable, false)
      Quest_SetStatus("Donalds_Date", "Donalds_Date_3b", Quest_Unavailable, false)
    end
  else
    Quest_SetStatus("Donalds_Date", "Donalds_Date_3a", Quest_Unavailable, false)
    Quest_SetStatus("Donalds_Date", "Donalds_Date_3b", Quest_Unavailable, false)
  end
  NOS_BogEasy_ReturnVisit_DonaldQuestLeftZone(nil)
  local TrainRide, TrainRide = GetGlobal("NOS_BogEasy_TrainRideChoice"), "NOS_BogEasy_TrainRideChoice"
  TrainRide = Print
  TrainRide(("__TrainRide Choice: " .. tostring(TrainRide)))
  TrainRide = SetGlobal
  TrainRide("EM2_TrainRide", 1)
  TrainRide = SetGlobal
  TrainRide("NOS_BogEasy_TrainRideChoice", 0)
  if (TrainRide == 2) then
    TrainRide = GetGlobal
    TrainRide = TrainRide("EM2_EpisodeCheck")
    if (TrainRide == 4) then
      TrainRide = GetGlobal
      TrainRide = TrainRide("VTL_Oasis_Visit")
      if (TrainRide ~= 3) then
        TrainRide = SetGlobal
        TrainRide("VTL_Oasis_Visit", 3)
      end
    end
  end
  TrainRide = NOS_BogEasy_SaveCheckpoint
  TrainRide("CHECKPOINT_TrainTeleportMarker", "Skip")
  if (TrainRide == 0) then
    TrainRide = LoadLevel
    TrainRide(GetPlayer(), "MeanStreet_South.Visit1")
  elseif (TrainRide == 1) then
    TrainRide = GetGlobal
    TrainRide = TrainRide("EM2_EpisodeCheck")
    if (TrainRide == 1) then
      TrainRide = LoadLevel
      TrainRide(GetPlayer(), "OST_Center.Main_Visit1")
    else
      TrainRide = LoadLevel
      TrainRide(GetPlayer(), "OST_Center.Main_Visit2")
      if (TrainRide == 2) then
        TrainRide = GetGlobal
        TrainRide = TrainRide("EM2_EpisodeCheck")
        if (TrainRide == 4) then
          TrainRide = LoadLevel
          TrainRide(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
        else
          TrainRide = LoadLevel
          TrainRide(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
          TrainRide = Print
          TrainRide("__Invalid Destination passed through Apprentice!")
        end
      else
        TrainRide = Print
        TrainRide("__Invalid Destination passed through Apprentice!")
      end
    end
  elseif (TrainRide == 2) then
    TrainRide = GetGlobal
    TrainRide = TrainRide("EM2_EpisodeCheck")
    if (TrainRide == 4) then
      TrainRide = LoadLevel
      TrainRide(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
    else
      TrainRide = LoadLevel
      TrainRide(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
      TrainRide = Print
      TrainRide("__Invalid Destination passed through Apprentice!")
    end
  else
    TrainRide = Print
    TrainRide("__Invalid Destination passed through Apprentice!")
  end
  return 
end
NOS_BogEasy_SparksDisableFrogs = function(target, _Section)
  Print(("__Function: NOS_BogEasy_SparksDisableFrogs, _Section: " .. tostring(_Section)))
  if (_Section == "0") then
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    EnableSplitScreen(false)
    RestrictCutSceneInput()
    FireThread(TeleportGremlinToEntity, "NOS_BogEasy_GremlinSparks", "SparksDisableFrogsMarker", false, false)
    SetGlobal("NOS_BogEasy_DisableSparks_WhichQuest", 3)
    if (IsAnySequencePlaying() == true) then
      wait(0.10000000149011612)
    end
    ForceSequence("NOS_BogEasy_GremlinSparks", "NOS_Sparks_DisableFrogs")
    FireUser1("DisableFrogsFancyCam")
  elseif (_Section == "0_0") then
    StartFadeOut(0.800000011920929)
    wait(0.800000011920929)
    EnableSplitScreen(false)
    RestrictCutSceneInput()
    FireThread(TeleportGremlinToEntity, "NOS_BogEasy_GremlinSparks", "SparksDisableFrogsMarker", false, false)
    SetGlobal("NOS_BogEasy_DisableSparks_WhichQuest", 4)
    if (IsAnySequencePlaying() == true) then
      wait(0.10000000149011612)
    end
    ForceSequence("NOS_BogEasy_GremlinSparks", "NOS_Sparks_DisableFrogs")
    FireUser1("DisableFrogsFancyCam")
  elseif (_Section == "1") then
    AnimVarInt(target, VAR_Cutscene, 1)
    AnimEvent(target, EVENT_Start_Cutscene)
  elseif (_Section == "2") then
    SpittingFrog_DisablePermanently("SpittingFrog5")
  elseif (_Section == "3") then
    SpittingFrog_DisablePermanently("SpittingFrog4")
    SpittingFrog_DisablePermanently("SpittingFrog2")
    SpittingFrog_DisablePermanently("SpittingFrog1")
    FireUser3("DisableFrogsFancyCam")
    FireThread(TeleportGremlinToEntity, "NOS_BogEasy_GremlinSparks", "GremlinSparks_HouseMarker")
    wait(1.600000023841858)
    EnableSplitScreen(true)
    if (GetGlobal("NOS_BogEasy_DisableSparks") == 3) then
      SetGlobal("NOS_BogEasy_DisableSparks_WhichQuest", 5)
      ForceSequence("NOS_BogEasy_Ghost_Rolly", "NOS_Rolly_OutOfToon_SecondGoal")
    elseif (GetGlobal("NOS_BogEasy_DisableSparks") == 4) then
      SetGlobal("NOS_BogEasy_DisableSparks_WhichQuest", 5)
      ForceSequence("NOS_BogEasy_Ghost_Rolly", "NOS_Rolly_OutOfToon_SecondGoalHints")
    end
    UnrestrictCutSceneInput()
  end
  return 
end
NOS_BogEasy_StartBunnyQuest = function()
  ForEachEntityInGroup(FireUser1, "NOS_Bunnies")
  return 
end
NOS_BunnyHatBroken = function()
  Print("___Function: NOS_BunnyHatBroken")
  SetGlobal("NOS_BogEasy_NumBunnyHats", (GetGlobal("NOS_BogEasy_NumBunnyHats") - 1))
  if (GetGlobal("NOS_BogEasy_NumBunnyHats") == 0) then
    Unhide("Bertrand_CompletedQuestBunny")
  end
  Print(("Num Bunnies Left: " .. GetGlobal("NOS_BogEasy_NumBunnyHats")))
  return 
end
NOS_BogEasy_TrainQuestComplete = function()
  FireSequence("NOS_BogEasy_Pedestrian_TrainConductorTom", "NOS_Tom_CompletedFireflyQuest")
  ClearNextPatrolNode("NOS_BogEasy_Pedestrian_TrainConductorTom")
  SetNextPatrolNode("NOS_BogEasy_Pedestrian_TrainConductorTom", "nos_bogeasy_ai.TrainConductorAfterQuestPatrolNode 01")
  SetPropertyBool("NOS_BogEasy_Pedestrian_TrainConductorTom", "ShouldFacePlayer", true)
  SetPropertyFloat("NOS_BogEasy_Pedestrian_TrainConductorTom", "PatrolSpeed", 1)
  SetPropertyFloat("NOS_BogEasy_Pedestrian_TrainConductorTom", ".UsableRadius", 2.5)
  return 
end
NOS_BogEasy_ReturnVisit_GabrielHeadstone = function(target, _Painted)
  Print(("___Function:NOS_BogEasy_ReturnVisit_GabrielHeadstone, _Painted: " .. _Painted))
  if (_Painted == "1") then
    SetGlobal("NOS_BogEasy_GabrielHeadstonePainted", 1)
  elseif (_Painted == "0") then
    SetGlobal("NOS_BogEasy_GabrielHeadstonePainted", 0)
  end
  return 
end
NOS_BogEasy_ReturnVisit_BunnyTrickRandomGenerator = function(target)
  local randomPull = math.random(1, 100)
  StartEmitters("BunnyHatBlast")
  Print(("Random number from bunny hat: " .. tostring(randomPull)))
  if (1 <= randomPull) then
    if (randomPull <= 30) then
      SetGlobal("NOS_BogEasy_HatReward", 1)
    end
  elseif (31 <= randomPull) then
    if (randomPull <= 60) then
      SetGlobal("NOS_BogEasy_HatReward", 2)
    end
  elseif (61 <= randomPull) then
    if (randomPull <= 80) then
      SetGlobal("NOS_BogEasy_HatReward", 3)
    end
  elseif (81 <= randomPull) then
    if (randomPull <= 90) then
      SetGlobal("NOS_BogEasy_HatReward", 4)
    end
  elseif (91 <= randomPull) then
    if (randomPull <= 95) then
      SetGlobal("NOS_BogEasy_HatReward", 5)
    end
  elseif (96 <= randomPull) then
    if (randomPull <= 98) then
      SetGlobal("NOS_BogEasy_HatReward", 6)
    end
  elseif (randomPull == 99) then
    if (GetGlobal("NOS_BogEasy_HatPin1Got") == 0) then
      SetGlobal("NOS_BogEasy_HatReward", 7)
      SetGlobal("NOS_BogEasy_HatPin1Got", 1)
    else
      SetGlobal("NOS_BogEasy_HatReward", 6)
      if (randomPull == 100) then
        if (GetGlobal("NOS_BogEasy_HatPin2Got") == 0) then
          SetGlobal("NOS_BogEasy_HatReward", 8)
          SetGlobal("NOS_BogEasy_HatPin2Got", 1)
        else
          SetGlobal("NOS_BogEasy_HatReward", 6)
        end
      end
    end
  elseif (randomPull == 100) then
    if (GetGlobal("NOS_BogEasy_HatPin2Got") == 0) then
      SetGlobal("NOS_BogEasy_HatReward", 8)
      SetGlobal("NOS_BogEasy_HatPin2Got", 1)
    else
      SetGlobal("NOS_BogEasy_HatReward", 6)
    end
  end
  Print(("__REWARD GIVEN: " .. tostring(GetGlobal("NOS_BogEasy_HatReward"))))
  wait(1)
  StopEmitters("BunnyHatBlast")
  return 
end
local TombstonesInTrigger = 0
NOS_BogEasy_TombstoneEscapeAttempt = function(target, _Direction)
  Print(("__Function: NOS_BogEasy_TombstoneEscapeAttempt, _Direction: " .. tostring(_Direction)))
  if (_Direction == "In") then
    if (TombstonesInTrigger == 0) then
      AnimGBSequence("NOS_BogEasy_GraveyardGate", "close")
    end
    TombstonesInTrigger = (TombstonesInTrigger + 1)
  elseif (_Direction == "Out") then
    TombstonesInTrigger = (TombstonesInTrigger - 1)
    if (TombstonesInTrigger == 0) then
      AnimGBSequence("NOS_BogEasy_GraveyardGate", "open")
    end
  end
  Print(("__TombstonesInTrigger: " .. tostring(TombstonesInTrigger)))
  return 
end
Jugband_Music_State = function()
  if (GetGlobal("NOS_BogEasy_FirstVisit") ~= 1) then
    local data = GetPrefabData("NOS_BogEasy_Jugband")
    if (data.CurrentState == "Fixed") then
      AudioPostEventOn(GetPlayer(), "Stop_MX_BOG")
      MusicPostEventOn("nos_bogeasy_01a_louisshackarea_audio.Sound_Marker_Music_Jugband", "Play_MX_BOG_Jugband_Good")
      Print("Playing jugband music from Jugband_Music_State")
    end
  end
  Disable("nos_bogeasy_01a_louisshackarea_audio.Trig_Music_JugbandState")
  Print("Fired and disabled Jugband_Music_State")
  return 
end
Jugband_Music_State_Disable = function()
  Disable("nos_bogeasy_01a_louisshackarea_audio.Trig_Music_JugbandState")
  return 
end
Prefab_GremlinForge_DestroyFromAfar = function(target)
  Print("__Function: Prefab_GremlinForge_DestroyFromAfar")
  FireUser1("ForgeScrapMetalSpawner")
  SetGlobal("NOS_QuestHealth", (GetGlobal("NOS_QuestHealth") - 15))
  return 
end
NOS_BogEasy_DonaldQuest_SparksCleanUp = function()
  TeleportGremlinToEntity("NOS_BogEasy_GremlinSparks", "GremlinSparks_HouseMarker")
  return 
end
NOS_BogEasy_DonaldQuest_SparksGearCheckpoint = function()
  if (GetGlobal("NOS_BogEasy_SparksLocation") == 0) then
    NOS_BogEasy_SaveCheckpoint("CHECKPOINT_LouisShack_Airlock")
  elseif (GetGlobal("NOS_BogEasy_SparksLocation") == 1) then
    NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown")
  end
  return 
end

