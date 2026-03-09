Prefab_TrainStationExplosion_AlwaysSetup = function(target)
  Print("__TrainStationExplosion__Function: Prefab_TrainStationExplosion_AlwaysSetup")
  local data = GetPrefabData(target)
  Print(("__TrainStationExplosion__Global Value: " .. tostring(data.StateGlobal)))
  if (GetGlobal(data.StateGlobal) == -1) then
    Print("__This station was fixed!")
    Disable(GetRelativePrefabEntity(target, ".ExplosionTrigger"))
    return 
  end
  if (GetGlobal(data.StateGlobal) == 0) then
    Print(("__TrainStationExplosion__First time setup on global, will set to value: " .. tostring(data.EpisodeCheck[1])))
    SetGlobal(data.StateGlobal, data.EpisodeCheck[1])
  end
  local doCheck = true
  if (GetGlobal("EM2_EpisodeCheck") < GetGlobal(data.StateGlobal)) then
    Print("__TrainStationExplosion__Value greater than our visit check! It means we already broke this station!")
    Disable(GetRelativePrefabEntity(target, ".ExplosionTrigger"))
    doCheck = false
  elseif (GetGlobal(data.StateGlobal) < GetGlobal("EM2_EpisodeCheck")) then
    Print("__The explosion wasn't triggered last time! Will incriment it as if it was!")
    Print("__WARNING: IF YOUR ARRAY WAS NOT SET UP PROPERLY IN THE BEGINNING, THE FIRST TIME SETUP WILL CALL THIS AUTOMATICALLY AND YOUR TRAIN STATION WILL ADVANCE TO THE WRONG STAGE")
    Print("__WARNING: MAKE SURE [1] IN THE ARRAY IS THE FIRST EPISODE YOU WILL EVER SEE THIS TRAIN STATION")
    SetGlobal(data.StateGlobal, (GetGlobal(data.StateGlobal) + 1))
  end
  if (doCheck == true) then
    local (for index), (for limit), (for step) = 1, 3, 1
    for x = (for index), (for limit), (for step) do
      if (GetGlobal("EM2_EpisodeCheck") == data.EpisodeCheck[x]) then
        Print((("__TrainStationExplosion__Episode Check is equal to [" .. tostring(x)) .. "] of the episode check array!"))
        if (x == 1) then
          Print("__TrainStationExplosion__Should be in will-start-smoking-soon state!")
        elseif (x == 2) then
          Print("__TrainStationExplosion__Should be in more smoking state!")
        elseif (x == 3) then
          Print("__TrainStationExplosion__Should be in final bust state!")
        end
        return 
      end
    end
  end
  return 
end
Prefab_TrainStationExplosion_TriggerExplosion = function(target)
  Print("__TrainStationExplosion__Function: Prefab_TrainStationExplosion_TriggerExplosion")
  local data = GetPrefabData(target)
  local SpawnerData = GetPrefabData("Prefab_TrainStationExplosion_Spawner")
  if (data.StateGlobal[1] == "Global") then
    Print("__TrainStationExplosion__NO STATE GLOBAL DEFINED, YOUR STATION EXPLOSION WILL NOT WORK PROPERLY")
  elseif (GetGlobal(data.StateGlobal) ~= -1) then
    if (data.EpisodeCheck[3] == 3) then
      if (GetGlobal("EM2_EpisodeCheck") == 4) then
        if (string.sub(LevelManager_GetCurrentState(), 1, 3) == "ost") then
          if (GetGlobal("OST_TrainStation_Destroyed") ~= 3) then
            Print("Player missed the station on the episode when it should have exploded.  Bypassing.")
            SetGlobal(data.StateGlobal, 4)
          end
        end
      end
    end
    if (GetGlobal(data.StateGlobal) == GetGlobal("EM2_EpisodeCheck")) then
      Print("__TrainStationExplosion__State global == episode check! Will fire off this explosion")
      SetGlobal(data.StateGlobal, (GetGlobal(data.StateGlobal) + 1))
      Print(("__TrainStationExplosion__Will activate this explosion again in episode: " .. tostring(GetGlobal(data.StateGlobal))))
      local ArraySpot = -1
      local (for index), (for limit), (for step) = 1, 3, 1
      for x = (for index), (for limit), (for step) do
        if (GetGlobal("EM2_EpisodeCheck") == data.EpisodeCheck[x]) then
          Print((("__TrainStationExplosion__Episode Check is equal to [" .. tostring(x)) .. "] of the episode check array! Using those values!"))
          ArraySpot = x
          SpawnerData.NumPiecesToLaunch = data.ScrapMetalAmounts[x]
        else
        end
      end
      if (data.EpisodeCheck[3] == 3) then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          if (string.sub(LevelManager_GetCurrentState(), 1, 3) == "ost") then
            if (GetGlobal("OST_TrainStation_Destroyed") ~= 3) then
              Print("Player missed the station on the episode when it should have exploded.  Bypassing.")
              SpawnerData.NumPiecesToLaunch = data.ScrapMetalAmounts[3]
              ArraySpot = 3
            end
          end
        end
      end
      ShakeCamera(1.2999999523162842, 7, 0.5, 0.4000000059604645, 0.009999999776482582, 0.0020000000949949026)
      Rumble(nil, 1.25)
      Rumble(nil, 1.25, 1)
      if (data.BarkOverrides[1] == "Default") then
        Print("__TrainStationExplosion__Will use default Gus Bark!")
        FireSequence(GetRelativePrefabEntity(target, ".GusBark"), "Global_Gus_TrainStationWarnings")
      else
        Print((("__TrainStationExplosion__Will use overridden Gus bark: " .. tostring(data.BarkOverrides[1])) .. "! If it doesnt play, did you forget to put the sequence on the gus marker?"))
        FireSequence(GetRelativePrefabEntity(target, ".GusBark"), data.BarkOverrides[1])
      end
      FireThread(Prefab_TrainStationExplosion_FX, target)
      FireUser1("Prefab_TrainStationExplosion_Spawner")
      wait(0.5)
      if (ArraySpot ~= 1) then
        if (ArraySpot ~= 2) then
          if (ArraySpot == 3) then
            Quest_SetStatus("The_Wasteland_Limited", "The_Wasteland_Limited_1", Quest_Unavailable, false)
            Quest_SetStatus("The_Wasteland_Limited", "The_Wasteland_Limited_6", Quest_Unavailable, false)
            GiveCollectible("Challenge_OffTrack_Tracker")
            if (data.StateGlobal == "VTL_Oasis_TrainStationState") then
              Quest_SetStatus("The_Wasteland_Limited", "The_Wasteland_Limited_5", Quest_Unavailable, false)
            elseif (data.StateGlobal == "NOS_BogEasy_TrainStationState") then
              Quest_SetStatus("The_Wasteland_Limited", "The_Wasteland_Limited_4", Quest_Unavailable, false)
            elseif (data.StateGlobal == "OST_Center_TrainStationState") then
              Quest_SetStatus("The_Wasteland_Limited", "The_Wasteland_Limited_3", Quest_Unavailable, false)
            elseif (data.StateGlobal == "MST_South_TrainStationState") then
              Quest_SetStatus("The_Wasteland_Limited", "The_Wasteland_Limited_2", Quest_Unavailable, false)
            end
            if Quest_CheckStatus("The_Wasteland_Limited", "The_Wasteland_Limited_5", Quest_Unavailable) then
              if Quest_CheckStatus("The_Wasteland_Limited", "The_Wasteland_Limited_4", Quest_Unavailable) then
                if Quest_CheckStatus("The_Wasteland_Limited", "The_Wasteland_Limited_3", Quest_Unavailable) then
                  if Quest_CheckStatus("The_Wasteland_Limited", "The_Wasteland_Limited_2", Quest_Unavailable) then
                    GiveCollectible("Challenge_Perfectionist_WastelandLimited_Tracker")
                  end
                end
              end
            end
            if (data.FinalExplosionFunction ~= "None") then
              FireThread(_G[data.FinalExplosionFunction], target)
            else
              Print("__No FinalExplosionFunction defined! Nothing's going to happen probably")
              Print("__TrainStationExplosion__This train station has been exploded-ed before during this episode! Will not fire off the event")
              Print((((("__TrainStationExplosion__StateGlobal is set to: " .. GetGlobal(data.StateGlobal)) .. ", and EpisodeCheck is set to: ") .. GetGlobal("EM2_EpisodeCheck")) .. "!!"))
            end
          end
        end
      end
    else
      Print("__TrainStationExplosion__This train station has been exploded-ed before during this episode! Will not fire off the event")
      Print((((("__TrainStationExplosion__StateGlobal is set to: " .. GetGlobal(data.StateGlobal)) .. ", and EpisodeCheck is set to: ") .. GetGlobal("EM2_EpisodeCheck")) .. "!!"))
    end
  end
  return 
end
Prefab_TrainStationExplosion_FX = function(target)
  Print("__Function: Prefab_TrainStationExplosion_FX")
  StartEmitters("Prefab_TrainStationExplosion_FX")
  wait(2.6600000858306885)
  StopEmitters("Prefab_TrainStationExplosion_FX")
  return 
end
Prefab_TrainStationExplosion_FixStation = function(target)
  Print("__Function: Prefab_TrainStationExplosion_FixStation")
  SetGlobal(GetPrefabData(target).StateGlobal, -1)
  return 
end
Prefab_TrainStationExplosion_StartCutscene = function(target)
  Print("__TrainStationExplosion__Function: Prefab_TrainStationExplosion_StartCutscene")
  local data = GetPrefabData(target)
  if (GetGlobal(data.StateGlobal) == GetGlobal("EM2_EpisodeCheck")) then
    Print("__TrainStationExplosion__Episode check equal! Could fire explosion if first time!")
    if (GetGlobal(data.StateGlobal) == data.EpisodeCheck[1]) then
      Print("__TrainStationExplosion__Will fire IGC, this is the first time! Also need to disable trigger this round")
      Disable(GetRelativePrefabEntity(target, ".ExplosionTrigger"))
      if (data.FancyCamEntity == "None") then
        Print("__TrainStationExplosion__No Fancy cam defined! Override FancyCamEntity and add an entity group name to your fancy cam!")
      else
        Print(((("__TrainStationExplosion__Will fire fancycam fireuser: " .. tostring(data.FancyCamStartFireUser)) .. " on camera: ") .. tostring(data.FancyCamEntity)))
        _G[data.FancyCamStartFireUser](tostring(data.FancyCamEntity))
      end
      if (data.FancyCamEndFireUser[1] == "AutoFire") then
        FireThread(Prefab_TrainStationExplosion_WaitForEndCutscene, target)
      else
        Print("__TrainStationExplosion__AutoFire off! You'll have to FireUser3 on your Train Station Explosion yourself!")
      end
      if (data.DelayBeforePlayingExplosion == -1) then
        Print("__TrainStationExplosion__DelayBeforePlayingExplosion not set! Your explosion won't work!")
      else
        wait(data.DelayBeforePlayingExplosion)
        FireThread(Prefab_TrainStationExplosion_TriggerExplosion, target)
      end
      if (data.DelayBeforePlayingTextBoxAfterExplosion == -1) then
        Print("__TrainStationExplosion__DelayBeforePlayingTextBoxAfterExplosion not set! Your text box won't show up!")
      else
        wait(data.DelayBeforePlayingTextBoxAfterExplosion)
        if (data.BarkOverrides[2] == "Default") then
          Print("__TrainStationExplosion__Will use default Gus Text!")
          FireSequence(target, "Global_Gus_TrainStationText")
        else
          Print((("__TrainStationExplosion__Will use overridden Gus bark/text: " .. tostring(data.BarkOverrides[2])) .. "! If it doesnt play, did you forget to put the sequence on the gus marker?"))
          FireSequence(target, data.BarkOverrides[2])
          Print("__TrainStationExplosion__we've already fired this IGC once! Won't do anything")
          Print("__TrainStationExplosion__Already fired IGC this time!")
        end
      end
    else
      Print("__TrainStationExplosion__we've already fired this IGC once! Won't do anything")
      Print("__TrainStationExplosion__Already fired IGC this time!")
    end
  else
    Print("__TrainStationExplosion__Already fired IGC this time!")
  end
  return 
end
Prefab_TrainStationExplosion_WaitForEndCutscene = function(target)
  Print("__Function: Prefab_TrainStationExplosion_WaitForEndCutscene")
  local data = GetPrefabData(target)
  local FancyCamTime = GetPrefabData(data.FancyCamEntity).transitionTime
  Print((("__TrainStationExplosion__Will wait " .. tostring(FancyCamTime)) .. " seconds before autofire of the fancycam end!"))
  wait(tonumber(FancyCamTime))
  Print("__TrainStationExplosion__Firing EndCutscene!")
  FireThread(Prefab_TrainStationExplosion_EndCutscene, target)
  return 
end
Prefab_TrainStationExplosion_EndCutscene = function(target)
  Print("__Function: Prefab_TrainStationExplosion_EndCutscene")
  local data = GetPrefabData(target)
  if (data.FancyCamEntity == "None") then
    Print("__TrainStationExplosion__No Fancy cam defined! Override FancyCamEntity and add an entity group name to your fancy cam!")
  else
    Print(((("__Will fire fancycam fireuser: " .. tostring(data.FancyCamEndFireUser[2])) .. " on camera: ") .. tostring(data.FancyCamEntity)))
    _G[data.FancyCamEndFireUser[2]](tostring(data.FancyCamEntity))
  end
  return 
end
