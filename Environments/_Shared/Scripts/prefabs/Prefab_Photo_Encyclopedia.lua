Prefab_EncyclopediaSetup = function(target)
  Print("********ENCYCLOPEDIA******** Running setup function")
  local data = GetPrefabData(target)
  SetPropertyString(GetRelativePrefabEntity(target, ".PhotoLocation"), "QuestFlag", data.PhotoTrackingGlobal)
  SetPropertyFloat(GetRelativePrefabEntity(target, ".PhotoSpotIcon"), "UsableRadius", 2)
  Disable(target)
  return 
end
Prefab_EnPhotoSuccess = function(target, event)
  local data = GetPrefabData(target)
  Print((((("********ENCYCLOPEDIA******** Taking Encyclopedia Photo: " .. data.QuestActiveGlobal) .. " & Only ") .. string.format("%.2f", tostring((GetPictureScoreFromEvent(event) * 100)))) .. "% of the object in frame"))
  SetMapMarkerVisible(GetRelativePrefabEntity(target, ".PhotoLocation"), false)
  _G[data.GlobalChangeFunction](data.QuestActiveGlobal)
  if (0 <= GetGlobal(data.QuestActiveGlobal)) then
    if (data.CollectibleName ~= "None") then
      GiveCollectible(data.CollectibleName)
      GiveCollectible("Challenge_StaffPhotographer_Tracker")
      if (data.CollectibleName == "Photo_Encyclopaedia_RBF_Falls") then
        if Quest_CheckHaveAllItems("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_1") then
          Quest_SetStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_1", Quest_TurnIn, true)
        end
      end
      if (data.CollectibleName == "Photo_Encyclopaedia_BlotAlley_Square") then
        if Quest_CheckHaveAllItems("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_2") then
          Quest_SetStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_2", Quest_TurnIn, true)
        end
      end
      if (data.CollectibleName == "Photo_Encyclopaedia_Autotopia_Tower") then
        if Quest_CheckHaveAllItems("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_3") then
          Quest_SetStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_3", Quest_TurnIn, true)
        end
      end
    end
    if (data.InCorrectSpot == true) then
      SetGlobal(data.OptimalSpotGlobal, 1)
    end
    if (data.Sequence[1] == "UsePrefabMarker") then
      ForceSequence(GetRelativePrefabEntity(target, ".ConversationMarker"), data.Sequence[2])
    else
      ForceSequence(data.Sequence[1], data.Sequence[2])
    end
    SetPropertyFloat(GetRelativePrefabEntity(target, ".PhotoSpotIcon"), "UsableRadius", 0)
  end
  return 
end
Prefab_EncyclopediaHint = function(target)
  local data = GetPrefabData(target)
  if (data.HintSequence ~= "None") then
    if (data.Sequence[1] == "UsePrefabMarker") then
      ForceSequence(GetRelativePrefabEntity(target, ".ConversationMarker"), data.HintSequence)
    else
      ForceSequence(data.Sequence[1], data.HintSequence)
    end
    SetPropertyFloat(_self(), "UsableRadius", 0)
    Wait(3)
    SetPropertyFloat(_self(), "UsableRadius", 2)
  end
  return 
end
Prefab_InCorrectPhotoSpot = function(target, state)
  local data = GetPrefabData(target)
  if (state == "correct") then
    Print("********ENCYCLOPEDIA******** InCorrectPhotoSpot")
    if (GetGlobal(data.PhotoTrackingGlobal) == 1) then
      Enable(GetRelativePrefabEntity(target, ".PhotoLocation"))
    end
  else
    Print("********ENCYCLOPEDIA******** Left CorrectPhotoSpot")
    Disable(GetRelativePrefabEntity(target, ".PhotoLocation"))
  end
  return 
end
Prefab_SetUpEncyclopediaMapMarker = function(target)
  local data = GetPrefabData(target)
  if (GetGlobal(data.PhotoTrackingGlobal) == 1) then
    SetMapMarkerVisible(GetRelativePrefabEntity(target, ".PhotoLocation"), true)
  end
  return 
end

