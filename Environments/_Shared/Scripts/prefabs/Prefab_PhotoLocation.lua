Prefab_SetUp_PhotoLocation = function(target)
  local data = GetPrefabData(target)
  Print(("***************************** - Prefab_SetUp_PhotoLocation: " .. data.Global))
  if (data.Hero == "False") then
    if (data.Global == "None") then
      Print((("***************************** - Prefab_SetUp_PhotoLocation: Global = " .. data.Global) .. "!! Create or Add a Global for proper functionality"))
    elseif (GetGlobal(data.Global) ~= 0) then
      Disable(target)
      if (GetGlobal("MSS_HiddenHeroesQuest") == 0) then
        Disable(target)
      end
    end
  elseif (GetGlobal("MSS_HiddenHeroesQuest") == 0) then
    Disable(target)
  end
  return 
end
Prefab_Found_PhotoLocation = function(target)
  local data = GetPrefabData(target)
  Print(("***************************** - Prefab_Found_PhotoLocation: " .. data.Global))
  if (data.Global ~= "None") then
    SetGlobal(data.Global, 1)
  end
  local GuardianPoolState = GetPropertyFloat(GetRelativePrefabEntity(data.LevelGP, ".GuardianPoolVisible_New"), "CurrentPlaystyle")
  if (GuardianPoolState ~= nil) then
    Print((("***************************** - Prefab_Found_PhotoLocation: GuardianPoolState = " .. GuardianPoolState) .. " --- Incrementing appropriate Global"))
    if (0.8999999761581421 < GuardianPoolState) then
      IncrementGlobal("EM2_WastelandVista_PaintedPicInventory")
    elseif (GuardianPoolState < 0.10000000149011612) then
      IncrementGlobal("EM2_WastelandVista_ThinnedPicInventory")
    else
      IncrementGlobal("EM2_WastelandVista_NeutralPicInventory")
    end
  end
  if (data.Convo[1] ~= "Role") then
    ForceSequence(data.Convo[1], data.Convo[2])
  end
  Disable(target)
  return 
end
