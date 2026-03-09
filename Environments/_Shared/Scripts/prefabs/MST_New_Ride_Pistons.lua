PistonMovementAudio = true
PistonAudioActive = false
PistonAudioTarget = "mst_maddoctornewride_02a_main.newridepistons_v2 01.PistonInert 0"
PistonZone = ""
spiderBoss_PistonsUp = false
spiderBoss_PistonsActive = true
spiderBoss_MickeyOnPiston = false
spiderBoss_OswaldOnPiston = false
spiderBoss_CharacterOnPiston = "String"
spiderBoss_CharacterOnFloor = "String"
PistonsStart = function(target)
  PistonsOff(target)
  return 
end
PistonsOn = function(target, spider)
  if (GetPrefabData(target).PistonsOn == "false") then
    if (GetPrefabData(spider).NearEdges == "false") then
      spiderBoss_PistonsActive = true
      PistonsActiveSlow(target)
    end
  end
  return 
end
PistonsOff = function(target)
  PistonsFlat(target)
  ForEachEntityInGroup(Disable, ".PistonTriggerGroup")
  Disable(GetRelativePrefabEntity(target, ".PistonTriggerDown"))
  GetPrefabData(target).PistonsOn = "false"
  return 
end
PistonsFlat = function(target)
  local PistonHeight = 0.5699999928474426
  if (spiderBoss_PistonsActive == true) then
    FireThread(EnablePistonAudio_Single)
    spiderBoss_PistonsActive = false
    spiderBoss_PistonsUp = false
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PistonInert 05"), 20)
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PistonInert 05"), GetRelativePrefabEntity(target, ".PistonSplineDown"), GetRelativePrefabEntity(target, ".PistonSplineUp"), PistonHeight)
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PistonInert 01"), 20)
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PistonInert 01"), GetRelativePrefabEntity(target, ".PistonSplineDown"), GetRelativePrefabEntity(target, ".PistonSplineUp"), PistonHeight)
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PistonInert 04"), 20)
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PistonInert 04"), GetRelativePrefabEntity(target, ".PistonSplineDown"), GetRelativePrefabEntity(target, ".PistonSplineUp"), PistonHeight)
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PistonInert 02"), 20)
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PistonInert 02"), GetRelativePrefabEntity(target, ".PistonSplineDown"), GetRelativePrefabEntity(target, ".PistonSplineUp"), PistonHeight)
    SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PistonInert 03"), 20)
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PistonInert 03"), GetRelativePrefabEntity(target, ".PistonSplineDown"), GetRelativePrefabEntity(target, ".PistonSplineUp"), PistonHeight)
  end
  return 
end
PistonsActiveSlow = function(reg_0)
  return 
end
PistonsActive = function(reg_0)
  return 
end
PistonsUp = function(reg_0)
  return 
end
PistonsStep = function(target)
  FireThread(EnablePistonAudio)
  SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PistonInert 01"), 6)
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PistonInert 01"), GetRelativePrefabEntity(target, ".PistonSplineDown"), GetRelativePrefabEntity(target, ".PistonSplineUp"), 0.6000000238418579)
  wait(0.10000000149011612)
  SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PistonInert 02"), 6)
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PistonInert 02"), GetRelativePrefabEntity(target, ".PistonSplineDown"), GetRelativePrefabEntity(target, ".PistonSplineUp"), 0.699999988079071)
  wait(0.10000000149011612)
  SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PistonInert 03"), 6)
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PistonInert 03"), GetRelativePrefabEntity(target, ".PistonSplineDown"), GetRelativePrefabEntity(target, ".PistonSplineUp"), 0.800000011920929)
  wait(0.10000000149011612)
  SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PistonInert 04"), 6)
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PistonInert 04"), GetRelativePrefabEntity(target, ".PistonSplineDown"), GetRelativePrefabEntity(target, ".PistonSplineUp"), 0.8999999761581421)
  wait(0.10000000149011612)
  SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PistonInert 05"), 6)
  SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PistonInert 05"), GetRelativePrefabEntity(target, ".PistonSplineDown"), GetRelativePrefabEntity(target, ".PistonSplineUp"), 1)
  return 
end
SpiderBoss_StandingOnPistons = function(target)
  spiderBoss_MickeyOnPiston = false
  return 
end
SpiderBoss_StandingOnFloor = function(target)
  spiderBoss_CharacterOnFloor = target
  if (spiderBoss_CharacterOnFloor == GetPlayer()) then
    spiderBoss_MickeyOnPiston = false
  elseif (spiderBoss_CharacterOnFloor == GetPlayer2OrAI()) then
    spiderBoss_OswaldOnPiston = false
  end
  if (spiderBoss_HasReachedTopPlatform == 0) then
    PistonsActive(".PistonInert 01")
  else
    PistonsActive(".PistonInert 01_2")
  end
  return 
end
EnablePistonAudio = function()
  if (PistonAudioActive == false) then
    PistonAudioActive = true
    PistonsAudioMovementLoop()
  end
  return 
end
PistonsAudioMovementLoop = function()
  PistonAudioTarget = "mst_maddoctornewride_02a_main.newridepistons_v2 01.PistonInert 0"
  if (spiderBoss_HasReachedTopPlatform == 0) then
    PistonZone = ""
    PistonAudioTarget = "mst_maddoctornewride_02a_main.newridepistons_v2 01.PistonInert 0"
  else
    PistonZone = "_2"
    PistonAudioTarget = "mst_maddoctornewride_02a_main.newridepistons_v2 02.PistonInert 0"
  end
  local moving = false
  local AudioTarget1 = ((PistonAudioTarget .. 1) .. PistonZone)
  local AudioTarget2 = ((PistonAudioTarget .. 2) .. PistonZone)
  local AudioTarget3 = ((PistonAudioTarget .. 3) .. PistonZone)
  local AudioTarget4 = ((PistonAudioTarget .. 4) .. PistonZone)
  local AudioTarget5 = ((PistonAudioTarget .. 5) .. PistonZone)
  local PistonVelocity1 = GetVelocity(AudioTarget1)
  local PistonVelocity2 = GetVelocity(AudioTarget2)
  local PistonVelocity3 = GetVelocity(AudioTarget3)
  local PistonVelocity4 = GetVelocity(AudioTarget4)
  local PistonVelocity5 = GetVelocity(AudioTarget5)
  local yVelo1 = PistonVelocity1.y
  local yVelo2 = PistonVelocity2.y
  local yVelo3 = PistonVelocity3.y
  local yVelo4 = PistonVelocity4.y
  local yVelo5 = PistonVelocity5.y
  while true do
    while true do
      while true do
        while true do
          while true do
            PistonVelocity1 = GetVelocity(AudioTarget1)
            PistonVelocity2 = GetVelocity(AudioTarget2)
            PistonVelocity3 = GetVelocity(AudioTarget3)
            PistonVelocity4 = GetVelocity(AudioTarget4)
            PistonVelocity5 = GetVelocity(AudioTarget5)
            yVelo1 = PistonVelocity1.y
            yVelo2 = PistonVelocity2.y
            yVelo3 = PistonVelocity3.y
            yVelo4 = PistonVelocity4.y
            yVelo5 = PistonVelocity5.y
            if (PistonVelocity1.y ~= 0) then
              if (moving == false) then
                moving = true
                AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_PistonPlatform")
              end
            end
            wait(0.10000000149011612)
          end
        end
      end
    end
  end
  local moving1 = true
  local moving2 = true
  local moving3 = true
  local moving4 = true
  local moving5 = true
  while true do
    while true do
      while true do
        while true do
          while true do
            PistonVelocity1 = GetVelocity(AudioTarget1)
            PistonVelocity2 = GetVelocity(AudioTarget2)
            PistonVelocity3 = GetVelocity(AudioTarget3)
            PistonVelocity4 = GetVelocity(AudioTarget4)
            PistonVelocity5 = GetVelocity(AudioTarget5)
            yVelo1 = PistonVelocity1.y
            yVelo2 = PistonVelocity2.y
            yVelo3 = PistonVelocity3.y
            yVelo4 = PistonVelocity4.y
            yVelo5 = PistonVelocity5.y
            AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_PistonPlatform")
            wait(0.019999999552965164)
            if (PistonVelocity1.y < 0.009999999776482582) then
              if (-0.009999999776482582 < PistonVelocity1.y) then
                if (moving1 == true) then
                  moving1 = false
                  AudioPostEventOn(GetPlayer(), "Stop_DEM2_BGS_PistonPlatform")
                end
              end
            end
            if (PistonVelocity2.y < 0.009999999776482582) then
              if (-0.009999999776482582 < PistonVelocity2.y) then
                if (moving2 == true) then
                  moving2 = false
                  AudioPostEventOn(GetPlayer(), "Stop_DEM2_BGS_PistonPlatform")
                end
              end
            end
            if (PistonVelocity3.y < 0.009999999776482582) then
              if (-0.009999999776482582 < PistonVelocity3.y) then
                if (moving3 == true) then
                  moving3 = false
                  AudioPostEventOn(GetPlayer(), "Stop_DEM2_BGS_PistonPlatform")
                end
              end
            end
            if (PistonVelocity4.y < 0.009999999776482582) then
              if (-0.009999999776482582 < PistonVelocity4.y) then
                if (moving4 == true) then
                  moving4 = false
                  AudioPostEventOn(GetPlayer(), "Stop_DEM2_BGS_PistonPlatform")
                end
              end
            end
            if (PistonVelocity5.y < 0.009999999776482582) then
              if (-0.009999999776482582 < PistonVelocity5.y) then
                if (moving5 == true) then
                  moving5 = false
                  AudioPostEventOn(GetPlayer(), "Stop_DEM2_BGS_PistonPlatform")
                end
              end
            end
          end
        end
      end
    end
  end
  PistonAudioActive = false
  return 
end
EnablePistonAudio_Single = function()
  if (PistonAudioActive == false) then
    PistonAudioActive = true
    PistonsAudioMovementLoop_Single()
  end
  return 
end
PistonsAudioMovementLoop_Single = function()
  PistonAudioTarget = "mst_maddoctornewride_02a_main.newridepistons_v2 01.PistonInert 0"
  if (spiderBoss_HasReachedTopPlatform == 0) then
    PistonZone = ""
    PistonAudioTarget = "mst_maddoctornewride_02a_main.newridepistons_v2 01.PistonInert 0"
  else
    PistonZone = "_2"
    PistonAudioTarget = "mst_maddoctornewride_02a_main.newridepistons_v2 02.PistonInert 0"
  end
  local moving = false
  local AudioTarget1 = ((PistonAudioTarget .. 1) .. PistonZone)
  local AudioTarget2 = ((PistonAudioTarget .. 2) .. PistonZone)
  local AudioTarget3 = ((PistonAudioTarget .. 3) .. PistonZone)
  local AudioTarget4 = ((PistonAudioTarget .. 4) .. PistonZone)
  local AudioTarget5 = ((PistonAudioTarget .. 5) .. PistonZone)
  local PistonVelocity1 = GetVelocity(AudioTarget1)
  local PistonVelocity2 = GetVelocity(AudioTarget2)
  local PistonVelocity3 = GetVelocity(AudioTarget3)
  local PistonVelocity4 = GetVelocity(AudioTarget4)
  local PistonVelocity5 = GetVelocity(AudioTarget5)
  local yVelo1 = PistonVelocity1.y
  local yVelo2 = PistonVelocity2.y
  local yVelo3 = PistonVelocity3.y
  local yVelo4 = PistonVelocity4.y
  local yVelo5 = PistonVelocity5.y
  while true do
    PistonVelocity1 = GetVelocity(AudioTarget1)
    PistonVelocity2 = GetVelocity(AudioTarget2)
    PistonVelocity3 = GetVelocity(AudioTarget3)
    PistonVelocity4 = GetVelocity(AudioTarget4)
    PistonVelocity5 = GetVelocity(AudioTarget5)
    yVelo1 = PistonVelocity1.y
    yVelo2 = PistonVelocity2.y
    yVelo3 = PistonVelocity3.y
    yVelo4 = PistonVelocity4.y
    yVelo5 = PistonVelocity5.y
    if (PistonVelocity1.y ~= 0) then
      if (moving == false) then
        moving = true
        AudioPostEventOn(GetPlayer(), "Play_DEM2_BGS_PistonPlatform")
      end
    end
    wait(0.10000000149011612)
  end
  while true do
    while true do
      while true do
        while true do
          while true do
            while true do
              while true do
                while true do
                  while true do
                    while true do
                      wait(0.10000000149011612)
                      PistonVelocity1 = GetVelocity(AudioTarget1)
                      PistonVelocity2 = GetVelocity(AudioTarget2)
                      PistonVelocity3 = GetVelocity(AudioTarget3)
                      PistonVelocity4 = GetVelocity(AudioTarget4)
                      PistonVelocity5 = GetVelocity(AudioTarget5)
                      yVelo1 = PistonVelocity1.y
                      yVelo2 = PistonVelocity2.y
                      yVelo3 = PistonVelocity3.y
                      yVelo4 = PistonVelocity4.y
                      yVelo5 = PistonVelocity5.y
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  moving = false
  AudioPostEventOn(GetPlayer(), "Stop_DEM2_BGS_PistonPlatform")
  PistonAudioActive = false
  return 
end
