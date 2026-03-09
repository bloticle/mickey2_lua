Prefab_TutorialIcon_Destroy = function(target)
  local data = GetPrefabData(target)
  if (data.DestroyFunction[1] == "function") then
    Print("***************************** - Prefab_TutorialIcon: No function declared.")
  else
    FireThread(_G[data.DestroyFunction[1]], data.DestroyFunction[2], data.DestroyFunction[3])
  end
  DestroyEntity(GetRelativePrefabEntity(target, ".ActivationTrigger"))
  DestroyEntity(GetRelativePrefabEntity(target, ".ControllerIcon"))
  return 
end
Prefab_TutorialIcon_Display = function(target, action)
  local data = GetPrefabData(target)
  if (action == "enter") then
    data.PlayerCheck = (data.PlayerCheck + 1)
    Unhide(GetRelativePrefabEntity(target, ".ControllerIcon"))
  elseif (action == "exit") then
    data.PlayerCheck = (data.PlayerCheck - 1)
    if (data.PlayerCheck == 0) then
      Hide(GetRelativePrefabEntity(target, ".ControllerIcon"))
    end
  end
  return 
end
Prefab_TutorialIcon_Enable = function(target, action)
  local data = GetPrefabData(target)
  if (action == "enable") then
    Enable(GetRelativePrefabEntity(target, ".ActivationTrigger"))
  elseif (action == "disable") then
    data.PlayerCheck = 0
    Disable(GetRelativePrefabEntity(target, ".ActivationTrigger"))
    Hide(GetRelativePrefabEntity(target, ".ControllerIcon"))
  end
  return 
end
