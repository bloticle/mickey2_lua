IncreaseClothCount = function(target)
  local data = GetPrefabData(target)
  if (GetGlobal(data.ClothGlobal) == 0) then
    SetGlobal(data.ClothGlobal, 1)
    DestroyEntity(GetRelativePrefabEntity(target, ".WorldPickupEffect"))
    DestroyEntity(GetRelativePrefabEntity(target, ".WorldPickupAnim"))
    FireSequence(GetRelativePrefabEntity(target, ".ConversationMarker"), "Global_Gus_FoundCloth")
    if (data.EndFunction ~= "none") then
      FireThread(_G[data.EndFunction])
    end
  end
  AudioPostEventOn(GetPlayer(), "Play_sfx_Pickup_PowerSpark")
  return 
end
LoadClothCheck = function(target)
  local data = GetPrefabData(target)
  if (data.StartHidden ~= "false") then
    Hide(GetRelativePrefabEntity(target, ".WorldPickupEffect"))
    Hide(GetRelativePrefabEntity(target, ".WorldPickupAnim"))
    Hide(target)
  end
  if (data.ClothGlobal ~= "None") then
    if (GetGlobal(data.ClothGlobal) == 1) then
      DestroyEntity(GetRelativePrefabEntity(target, ".WorldPickupEffect"))
      DestroyEntity(GetRelativePrefabEntity(target, ".WorldPickupAnim"))
      DestroyEntity(target)
    end
  end
  return 
end
ChangeClothHiddenState = function(target, state)
  local data = GetPrefabData(target)
  if (data.ClothGlobal ~= "None") then
    if (GetGlobal(data.ClothGlobal) == 0) then
      if (state == "Unhide") then
        Unhide(GetRelativePrefabEntity(target, ".WorldPickupEffect"))
        Unhide(GetRelativePrefabEntity(target, ".WorldPickupAnim"))
        Unhide(GetRelativePrefabEntity(target, ".Cloth"))
      elseif (state == "Hide") then
        Hide(GetRelativePrefabEntity(target, ".WorldPickupEffect"))
        Hide(GetRelativePrefabEntity(target, ".WorldPickupAnim"))
        Hide(GetRelativePrefabEntity(target, ".Cloth"))
      end
    end
  end
  return 
end

