Prefab_GeyserOnPainted = function(target)
  local data = GetPrefabData(target)
  if (data.OnPaintedFunction == "NotSetUp") then
    Print("You have not set up the OnPainted function")
  else
    FireThread(_G[data.OnPaintedFunction], target)
  end
  local Emitter = GetRelativePrefabEntity(target, ".GeyserJunkSteamEmitter")
  StopEmitters(Emitter)
  Disable(GetRelativePrefabEntity(target, ".GeyserJunkDamageTrigger"))
  AudioPostEventOn(Emitter, "Stop_sfx_dg1_geyser_lp")
  return 
end
Prefab_GeyserOnSketched = function(target)
  local data = GetPrefabData(target)
  if (data.OnSketchedFunction == "NotSetUp") then
    Print("You have not set up the OnSketched function")
  else
    FireThread(_G[data.OnSketchedFunction], target)
  end
  local Emitter = GetRelativePrefabEntity(target, ".GeyserJunkSteamEmitter")
  StartEmitters(Emitter)
  Enable(GetRelativePrefabEntity(target, ".GeyserJunkDamageTrigger"))
  AudioPostEventOn(Emitter, "Play_sfx_dg1_geyser_lp")
  return 
end
Prefab_SetupJunkGeyser = function(target)
  if (GetPropertyBool(target, "Is Painted") ~= true) then
    local Emitter = GetRelativePrefabEntity(target, ".GeyserJunkSteamEmitter")
    StartEmitters(Emitter)
    Enable(GetRelativePrefabEntity(target, ".GeyserJunkDamageTrigger"))
    AudioPostEventOn(Emitter, "Play_sfx_dg1_geyser_lp")
  else
    Disable(GetRelativePrefabEntity(target, ".GeyserJunkDamageTrigger"))
  end
  return 
end

