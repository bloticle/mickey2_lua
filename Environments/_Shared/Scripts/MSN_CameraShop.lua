MSN_Camera_Rewards = function()
  local Episode1Photos = 4
  local Episode2Photos = 10
  local Episode3Photos = 2
  local pictureVar = 0
  if Quest_CheckStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_1", Quest_TurnIn) then
    pictureVar = (pictureVar + Episode1Photos)
    Quest_SetStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_1", Quest_Completed, true)
  end
  if Quest_CheckStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_2", Quest_TurnIn) then
    pictureVar = (pictureVar + Episode2Photos)
    Quest_SetStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_2", Quest_Completed, true)
  end
  if Quest_CheckStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_3", Quest_TurnIn) then
    pictureVar = (pictureVar + Episode3Photos)
    Quest_SetStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_3", Quest_Completed, true)
  end
  pictureVar = (pictureVar * 50)
  AddCurrency("ETicket", pictureVar)
  return 
end
MSN_Camera_OpenPictureBook = function()
  FireSequence("MSN_PictureBookConv", "MSN_CameraShop", 1)
  return 
end
MSN_DiscoverQuestStages = function()
  local episode = GetGlobal("EM2_EpisodeCheck")
  SetGlobal("MSN_RainbowFalls_PhotoComponent01", 1)
  SetGlobal("MSN_RainbowCaverns_PhotoComponent01", 1)
  SetGlobal("MSN_Gulch1_PhotoComponent01", 1)
  SetGlobal("MSN_Gulch1_PhotoComponent02", 1)
  SetGlobal("MSN_Gulch1_PhotoComponent03", 1)
  SetGlobal("MSN_BlotAlley_PhotoComponent01", 1)
  SetGlobal("MSN_BlotAlley_PhotoComponent02", 1)
  SetGlobal("MSN_BlotAlley_PhotoComponent03", 1)
  SetGlobal("MSN_TrainTunnels_PhotoComponent01", 1)
  SetGlobal("MSN_TrainTunnels_PhotoComponent02", 1)
  SetGlobal("MSN_TrainTunnels_PhotoComponent03", 1)
  SetGlobal("MSN_Gulch2_PhotoComponent01", 1)
  SetGlobal("MSN_Gulch2_PhotoComponent02", 1)
  SetGlobal("MSN_FloatGY_PhotoComponent01", 1)
  SetGlobal("MSN_FloatGY_PhotoComponent02", 1)
  SetGlobal("MSN_Autotopia_PhotoComponent01", 1)
  SetGlobal("MSN_Autotopia_PhotoComponent02", 1)
  if (1 < episode) then
    Quest_SetStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_2", Quest_Discovered, false)
  end
  if (2 < episode) then
    Quest_SetStatus("Encyclopaedia_Wastelandica", "Encyclopaedia_Wastelandica_3", Quest_Discovered, false)
  end
  return 
end
