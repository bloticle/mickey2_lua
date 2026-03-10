Prefab_KnotholeSurprise_AlwaysSetup = function(target)
  Print("____Prefab_KnotholeSurprise_AlwaysSetup")
  local data = GetPrefabData(target)
  Hide(GetRelativePrefabEntity(target, ".Reward"))
  return 
end
Prefab_KnotholeSurprise_KnotholeThinned = function(target)
  Print("____Prefab_KnotholeSurprise_KnotholeThinned")
  local data = GetPrefabData(target)
  local SurpriseType = data.SurpriseInfo
  Unhide(GetRelativePrefabEntity(target, ".Reward"))
  if (data.AchievementTrackerVariable ~= "None") then
    Print(("__Awarding achievement tracker: " .. tostring(data.AchievementTrackerVariable)))
    GiveCollectible(data.AchievementTrackerVariable)
  end
  if (SurpriseType == "Knothole") then
    AnimGBSequence(GetRelativePrefabEntity(target, ".Surprise"), "spring_out")
    if (data.FXName ~= "None") then
      FireThread(Prefab_KnotholeSurprise_FX, data.FXName, 2)
    end
    wait(2)
    ClearParent(GetRelativePrefabEntity(target, ".Reward"))
    EnableMotion(GetRelativePrefabEntity(target, ".Reward"))
    FireThread(Prefab_KnotholeSurprise_LaunchReward, target)
  elseif (SurpriseType == "Skeleton") then
    AnimGBSequence(GetRelativePrefabEntity(target, ".Surprise"), "wall")
    if (data.FXName ~= "None") then
      FireThread(Prefab_KnotholeSurprise_FX, data.FXName, 2)
    end
    wait(0.75)
    ClearParent(GetRelativePrefabEntity(target, ".Reward"))
    EnableMotion(GetRelativePrefabEntity(target, ".Reward"))
    FireThread(Prefab_KnotholeSurprise_LaunchReward, target)
  elseif (SurpriseType == "SkeletonGround") then
    AnimGBSequence(GetRelativePrefabEntity(target, ".Surprise"), "ground")
    if (data.FXName ~= "None") then
      FireThread(Prefab_KnotholeSurprise_FX, data.FXName, 2)
    end
    wait(0.75)
    ClearParent(GetRelativePrefabEntity(target, ".Reward"))
    EnableMotion(GetRelativePrefabEntity(target, ".Reward"))
    FireThread(Prefab_KnotholeSurprise_LaunchReward, target)
  end
  return 
end
Prefab_KnotholeSurprise_FX = function(target, _Delay)
  Print(("__Function: Prefab_KnotholeSurprise_FX, _Delay: " .. tostring(_Delay)))
  Print(("__Firing FX: " .. tostring(GetName(target))))
  StartEmitters(target)
  wait(tonumber(_Delay))
  StopEmitters(target)
  return 
end
Prefab_KnotholeSurprise_LaunchReward = function(target)
  Print("Prefab_KnotholeSurprise_LaunchReward")
  local data = GetPrefabData(target)
  local SurpriseType = data.SurpriseInfo
  local ImpulseValue = 1
  if (SurpriseType == "SkeletonGround") then
    ImpulseValue = 4
  elseif (SurpriseType == "Knothole") then
    ImpulseValue = 6
  end
  local LaunchDirection = (GetPosition(GetRelativePrefabEntity(target, ".LaunchPosition")) - GetPosition(GetRelativePrefabEntity(target, ".Reward")))
  LaunchDirection:normalize3()
  ApplyImpulse(GetRelativePrefabEntity(target, ".Reward"), (LaunchDirection.x * 1), ImpulseValue, (LaunchDirection.z * ImpulseValue))
  wait(0.5)
  SetPropertyInt(GetRelativePrefabEntity(target, ".Reward"), "Collision Layer", 19)
  return 
end

