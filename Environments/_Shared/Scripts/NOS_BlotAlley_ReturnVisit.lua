local LastSection = nil
NOS_BlotAlley_ReturnVisitAISpawner = function(target, _Section)
  Print(("__Function: NOS_BlotAlley_ReturnVisitAISpawner, _Section: " .. tostring(_Section)))
  if (LastSection == nil) then
    LastSection = string.sub(LevelManager_GetCurrentState(), 27, 27)
    Print(("__Last section not set yet! Will set initial to: " .. tostring(LastSection)))
  end
  Print(("__LastSection: " .. tostring(LastSection)))
  Print("__Level has been switched from hard load!")
  if (string.sub(LevelManager_GetCurrentState(), -5, -5) == "n") then
    Print("__We're in No Ian Visit 2! Don't attempt to get rid of any spatters, there are none!")
  else
    Print("__We're in Ian Visit 2!")
    if (_Section == "1") then
      if (LastSection == "2") then
        ForEachEntityInGroup(DestroyEntity, "Spatter_Room3")
        ForEachEntityInGroup(DestroyEntity, "Spatter_Room5")
      end
      LastSection = "1"
    elseif (_Section == "2") then
      if (LastSection == "1") then
        ForEachEntityInGroup(DestroyEntity, "Spatter_Room1")
        ForEachEntityInGroup(DestroyEntity, "Spatter_Room2")
      end
      LastSection = "2"
    elseif (_Section == "4") then
      if (LastSection == "1") then
        ForEachEntityInGroup(DestroyEntity, "Spatter_Room1")
        ForEachEntityInGroup(DestroyEntity, "Spatter_Room2")
      end
      if (LastSection == "2") then
        ForEachEntityInGroup(DestroyEntity, "Spatter_Room3")
        ForEachEntityInGroup(DestroyEntity, "Spatter_Room5")
      end
      LastSection = "4"
    end
    Prefab_RVAIPicker_AlwaysSetup("NOS_BlotAlley_RVAIPicker_Spawner", _Section)
  end
  return 
end
NOS_BlotAlley_AlwaysSetup = function(target)
  Print("__Function: NOS_BlotAlley_AlwaysSetup, Return Visit")
  SetGlobal("NOS_BlotAlley_VisitNum", 2)
  if (LevelManager_GetCurrentState() == "nos_blotalley_main.section1_visit2_ian") then
    if (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 1) then
      if (GetGlobal("NOS_BlotAlley_Ian_2ndVisit_ThinSpatter_Played") == 0) then
        Print("__We havent played the angry IGC! Playing!")
        Unhide("NOS_BlotAlley_Ian_RV")
        ClearAllCameraAttributes()
        wait(1)
        EnableSplitScreen(false)
        GrabCamera("IanAngryCCP_00", nil, CAMERA_INSTANT_TRANSITION, 0, GetPlayer())
        wait(0.10000000149011612)
        ForceSequence("NOS_BlotAlley_Ian_RV", "NOS_BlotAlley_Ian_2ndVisit_ThinSpatter")
        GrabCamera("IanAngryCCP_01", nil, CAMERA_LERP_TRANSITION, 10, GetPlayer())
        StartFadeIn(0.800000011920929)
      end
    end
  end
  return 
end
NOS_BlotAlley_VisitCheckpointLoad = function(target)
  Print("__Function: NOS_BlotAlley_VisitCheckpointLoad, Visit 2!")
  NOS_BlotAlley_AlwaysSetup(target)
  return 
end
NOS_BlotAlley_TedworthTeleportOut = function(target)
  Print("__Function: NOS_BlotAlley_TedworthTeleportOut")
  AnimVarInt(target, VAR_Cutscene, 2)
  AnimEvent(target, EVENT_Start_Cutscene)
  wait(2)
  Hide(target)
  DestroyEntity(target)
  return 
end
NOS_BlotAlley_AllBunniesCaptured = function(target)
  Print("__Function: NOS_BlotAlley_AllBunniesCaptured")
  ForceSequence("NOS_BlotAlley_Gus", "NOS_BlotAlley_Gus_BunnyChildrenSucked")
  return 
end
NOS_BlotAlley_ClothGot = function(target)
  Print("__Functon: NOS_BlotAlley_ClothGot")
  ForceSequence("NOS_BlotAlley_Gus", "Global_Gus_FoundCloth")
  return 
end
