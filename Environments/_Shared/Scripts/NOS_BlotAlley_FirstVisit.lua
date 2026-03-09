NOS_BlotAlley_ReturnVisitAISpawner = function(target)
  Print("__FUNCTION: NOS_BlotAlley_ReturnVisitAISpawner IN FIRST VISIT, WILL NOT SPAWN ANYTHING BECAUSE WE ARE NOT IN THE RETURN VISIT!")
  return 
end
NOS_BlotAlley_AlwaysSetup = function(target)
  Print("__Function: NOS_BlotAlley_AlwaysSetup, First Visit")
  SetGlobal("NOS_BlotAlley_VisitNum", 1)
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    SetGlobal("EM2_EpisodeCheck", 2)
  end
  if (GetGlobal("NOS_BlotAlley_ZoneEntered") == 0) then
    SetGlobal("NOS_BlotAlley_ZoneEntered", 1)
    PlayMovie(GetPlayer(), "PH_2_2_Ian_Blot_Alley.bik")
    GiveCollectibleNoPopup("Film_PH2_2")
    Quest_SetCriticalPath("Critical_BlotAlley", "Critical_BlotAlley_4")
    RestrictCutSceneInput()
    TeleportToEntity(GetPlayer(), "MickeyAfterPowerhouseStartPos")
    TeleportToEntity(GetPlayer2OrAI(), "CHECKPOINT_Section1_Projector")
    EnableSplitScreen(false)
    wait(0.800000011920929)
    ForceSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_PanicBellTraining")
    FireUser1("BellTrainingCam")
    StartFadeIn(0.800000011920929)
    wait(0.5)
  end
  return 
end
NOS_BlotAlley_VisitCheckpointLoad = function(target)
  Print("__Function: NOS_BlotAlley_VisitCheckpointLoad, Visit 1!")
  return 
end
NOS_BlotAlley_FirstCameraShot = function(target)
  Print("__Function: NOS_BlotAlley_FirstCameraShot")
  Print("__FirstCameraShot Waiting")
  StartFadeOut(0.800000011920929)
  wait(0.800000011920929)
  Print("__FirstCameraShot Sequence Check")
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
    Print("__FirstCameraShot Sequence Playing")
  end
  FireUser3("BellTrainingCam")
  Print("__FirstCameraShot Enabling Playing")
  Enable("MickeyAfterPowerhouseCamOverride")
  Enable("OswaldAfterPowerhouseCamOverride")
  Print("__FirstCameraShot Waiting 2")
  EnableSplitScreen(true)
  UnrestrictCutSceneInput()
  wait(0.800000011920929)
  Print("__FirstCameraShot Fadein")
  StartFadeIn(0.800000011920929)
  NOS_BlotAlley_OswaldPathHandler(nil, "OswaldPath_Section1_Node1")
  NOS_BlotAlley_SaveCheckpoint("CHECKPOINT_Section1_Projector")
  return 
end
NOS_BlotAlley_ClearFirstCamera = function(reg_0)
  return 
end
NOS_BlotAlley_SpladooshTraining = function(target)
  FireSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_SpladooshTraining")
  return 
end
local NumPlayersInTrigger = 0
local FiringIGC = 0
NOS_BlotAlley_IanRewardTriggerInside = function(target, _Entered)
  Print(("__Function: NOS_BlotAlley_IanRewardTriggerInside, _Entered: " .. tostring(_Entered)))
  if (_Entered == "Entered") then
    NumPlayersInTrigger = (NumPlayersInTrigger + 1)
  elseif (_Entered == "Exited") then
    NumPlayersInTrigger = (NumPlayersInTrigger - 1)
  end
  if (NumPlayersInTrigger == 2) then
    if (FiringIGC == 0) then
      FiringIGC = 1
      Print("__Both players in trigger! Firing IGC!")
      StopAbility(GetPlayer(), "Use")
      StopAbility(GetPlayer2OrAI(), "Use")
      NOS_BlotAlley_IanIGC("NOS_BlotAlley_Ian", "1")
    else
      Print("__Already firing the igc!")
      Print("__Both Players not there! Waiting!")
      FireSequence("IanGateBark_ConversationMarker", "NOS_BlotAlley_Ian_CloserToGate")
    end
  else
    Print("__Both Players not there! Waiting!")
    FireSequence("IanGateBark_ConversationMarker", "NOS_BlotAlley_Ian_CloserToGate")
  end
  return 
end
NOS_BlotAlley_StreamPeteArea = function(target)
  Print("__Function: NOS_BlotAlley_StreamPeteArea")
  StreamZones(GetPlayer(), "NOS_BlotAlley_v1_Pete")
  return 
end
NOS_BlotAlley_GusBrokenBuildingHint = function(target)
  Print("__Function: NOS_BlotAlley_GusBrokenBuildingHint")
  FireSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_BrokenBuildingHint")
  return 
end
