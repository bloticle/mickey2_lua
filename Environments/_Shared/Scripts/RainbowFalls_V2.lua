RBF_OnLoadSetupZone = function(transition)
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    SetGlobal("EM2_EpisodeCheck", 2)
  end
  RF_Visit2Start(transition)
  return 
end

