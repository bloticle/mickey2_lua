TRT_VisitSpecificSetup = function(target)
  if (GetGlobal("EM2_EpisodeCheck") == 1) then
    SetGlobal("EM2_EpisodeCheck", 2)
  end
  FireThread(TRT_EndLevelSetup, target)
  return 
end

