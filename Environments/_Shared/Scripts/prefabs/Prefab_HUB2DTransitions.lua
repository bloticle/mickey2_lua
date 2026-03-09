SetTomorrowlandProgress = function()
  SetGlobal("MS_MeanStreetProgress", 2)
  return 
end
ToMSPosition1 = function()
  SetGlobal("HUB_startposition", 1)
  LoadMeanStreet()
  return 
end
ToMSPosition2 = function()
  SetGlobal("HUB_startposition", 2)
  LoadMeanStreet()
  return 
end
ToMSPosition3 = function()
  SetGlobal("HUB_startposition", 3)
  LoadMeanStreet()
  return 
end
ToMSPosition4 = function()
  SetGlobal("HUB_startposition", 4)
  LoadMeanStreet()
  return 
end
LoadMeanStreet = function()
  UnrestrictCutSceneInput()
  if (GetGlobal("MS_MeanStreetProgress") == 1) then
    LoadLevel(GetPlayer(), "Levels/MeanStreet_V1.Level")
  end
  if (GetGlobal("MS_MeanStreetProgress") == 2) then
    LoadLevel(GetPlayer(), "Levels/MeanStreet_V2.Level")
  end
  if (GetGlobal("MS_MeanStreetProgress") == 3) then
    LoadLevel(GetPlayer(), "Levels/MeanStreet_V3.Level")
  end
  if (GetGlobal("MS_MeanStreetProgress") == 4) then
    LoadLevel(GetPlayer(), "Levels/MeanStreet_V4.Level")
  end
  if (GetGlobal("MS_MeanStreetProgress") == 5) then
    LoadLevel(GetPlayer(), "Levels/MeanStreet_V5.Level")
  end
  if (GetGlobal("MS_MeanStreetProgress") == 6) then
    if (GetGlobal("MS_InvasionRepelled") == 0) then
      LoadLevel(GetPlayer(), "Levels/MeanStreet_V6.Level")
    else
      LoadLevel(GetPlayer(), "Levels/MeanStreet_V6_NoEnemies.level")
    end
  end
  return 
end
LoadVentureland = function()
  if (GetGlobal("AL_AdventurelandProgress") == 1) then
    LoadLevel(GetPlayer(), "Levels/Adventureland_v1.Level")
  end
  if (GetGlobal("AL_AdventurelandProgress") == 2) then
    LoadLevel(GetPlayer(), "Levels/Adventureland_v2_NoPirates.level")
  end
  if (GetGlobal("AL_AdventurelandProgress") == 3) then
    LoadLevel(GetPlayer(), "Levels/Adventureland_v2_Pirates.level")
  end
  if (GetGlobal("AL_AdventurelandProgress") == 4) then
    LoadLevel(GetPlayer(), "Levels/Adventureland_v3.level")
  end
  return 
end
LoadNewOrleansSquare = function()
  if (GetGlobal("NO_NewOrleansProgress") == 1) then
    LoadLevel(GetPlayer(), "Levels/NewOrleans_V1.level")
  end
  if (GetGlobal("NO_NewOrleansProgress") == 2) then
    LoadLevel(GetPlayer(), "Levels/NewOrleans_V2.level")
  end
  if (GetGlobal("NO_NewOrleansProgress") == 3) then
    LoadLevel(GetPlayer(), "Levels/NewOrleans_V3.level")
  end
  return 
end
LoadToonTown = function()
  if (GetGlobal("TT_ToonTownProgress") == 1) then
    LoadLevel(GetPlayer(), "Levels/ToonTown_V1.level")
  end
  if (GetGlobal("TT_ToonTownProgress") == 2) then
    LoadLevel(GetPlayer(), "Levels/ToonTown_V2.level")
  end
  if (GetGlobal("TT_ToonTownProgress") == 3) then
    LoadLevel(GetPlayer(), "Levels/ToonTown_V3.level")
  end
  return 
end
LoadTomorrowland = function()
  UnrestrictCutSceneInput()
  EnableGuardianSystem()
  if (GetGlobal("MS_MeanStreetProgress") == 2) then
    LoadLevel(GetPlayer(), "Levels/TL_Start.Level")
    TeleportToEntity(GetPlayer(), "tl_minihub_zoneb.Start")
  end
  if (GetGlobal("MS_MeanStreetProgress") == 6) then
    LoadLevel(GetPlayer(), "Levels/TL_Visit2_Start.Level")
  end
  return 
end
LoadMickeyjunk = function()
  Print("Loading Mickeyjunk")
  UnrestrictCutSceneInput()
  EnableGuardianSystem()
  if (GetGlobal("TT_ToonTownProgress") == 1) then
    LoadLevel(GetPlayer(), "Levels/MJM_ZoneA.Level")
  end
  if (GetGlobal("TT_ToonTownProgress") == 2) then
    LoadLevel(GetPlayer(), "Levels/MJM_ZoneF2.Level")
  end
  return 
end
LoadLonesomeManor = function()
  UnrestrictCutSceneInput()
  EnableGuardianSystem()
  if (GetGlobal("NO_NewOrleansProgress") == 1) then
    LoadLevel(GetPlayer(), "Levels/HM_Start.Level")
  end
  if (GetGlobal("NO_NewOrleansProgress") == 2) then
    LoadLevel(GetPlayer(), "Levels/HMv2_Start.Level")
  end
  return 
end
GV_SBW_Load = function()
  local data = GetPrefabData("GV_SBW")
  if (GetConfigVariableBool("DemoLevelCheck") == true) then
    data.TeleportToMarker = "EnterScalpRock"
    data.EnterFunction = "HardLoadToSR"
    StreamZones(GetPlayer(), "E3_SBW")
  else
    data.TeleportToMarker = "gremlinvillage_zonef.MickeyStartPositionZoneF"
    StreamZones(GetPlayer(), "stream_7")
  end
  return 
end
HardLoadToSR = function()
  LoadLevel(GetPlayer(), "Levels/E3Demo_SR.level")
  return 
end
