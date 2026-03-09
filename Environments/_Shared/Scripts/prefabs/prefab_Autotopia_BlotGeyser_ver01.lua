AUT_Junk_hitsVent = function(junk)
  local data = GetPrefabData(_self())
  if (data.VentDestroyed == 0) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Junk hits Vacuum!!!")
    local sKnotInit = GetRelativePrefabEntity(_self(), ".SplineKnot 01")
    DisableMotion(junk)
    MoveToEntity(sKnotInit, junk)
    SplineFollower_TeleportToKnot(junk, sKnotInit)
    Enable(junk)
    SetPropertyFloat(junk, "UsableRadius", 0)
    wait(0.5)
    SetPropertyBool(junk, "Is Mover", true)
    FireUser1(data.TargetBoulder)
    SetGlobal("Autotopia_GusHint", data.HintValue)
    data.VentDestroyed = 1
  end
  return 
end
AUT_DestroyVent = function(engine)
  local data = GetPrefabData(_self())
  local sKnotInit = _self()
  local explode1 = GetRelativePrefabEntity(sKnotInit, ".ExplosionMarker1")
  local explode2 = GetRelativePrefabEntity(sKnotInit, ".ExplosionMarker2")
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_DestroyVent!!!")
  SetPropertyEntity("explosion_FX_Spawner", "Spawn Destinations", explode1, 0)
  ForceSpawn("explosion_FX_Spawner", 1)
  Hide(GetRelativePrefabEntity(sKnotInit, ".smoke"))
  DestroyEntity(GetRelativePrefabEntity(_self(), ".playerTrigger"))
  data.PlayerAtVent = 0
  wait(0.20000000298023224)
  FireUser2(engine)
  SetPropertyEntity("Scrap_Spawner 01", "Spawn Destinations", engine, 0)
  ForceSpawn("Scrap_Spawner 01", 5)
  wait(0.699999988079071)
  SetPropertyEntity("explosion_FX_Spawner", "Spawn Destinations", explode2, 0)
  ForceSpawn("explosion_FX_Spawner", 1)
  return 
end
AUT_BlotGeyser_ShutOff = function(target)
  local data = GetPrefabData(_self())
  Hide(GetRelativePrefabEntity(_self(), ".smoke"))
  Hide(GetRelativePrefabEntity(_self(), ".playerTrigger"))
  Hide(GetRelativePrefabEntity(_self(), ".TriggerBase 01"))
  return 
end
AUT_BlotGeyser_painted = function(target)
  local data = GetPrefabData(target)
  if (data.VentDestroyed == 0) then
    Hide(GetRelativePrefabEntity(_self(), ".smoke"))
    wait(1)
    FireUser1(data.TargetBoulder)
    SetGlobal("Autotopia_GusHint", data.HintValue)
  end
  return 
end
AUT_BlotGeyser_erased = function(target)
  local data = GetPrefabData(target)
  if (data.VentDestroyed == 0) then
    Unhide(GetRelativePrefabEntity(_self(), ".smoke"))
    FireUser2(data.TargetBoulder)
  end
  return 
end
AUT_Vent_ShowDamage = function(target)
  local data = GetPrefabData(target)
  data.VentDestroyed = 1
  Hide(GetRelativePrefabEntity(_self(), ".smoke"))
  StartEmitters(GetRelativePrefabEntity(_self(), ".Common_SparksWithElectricity 01"))
  return 
end
AUT_PlayerNearVentSingleFrame = function(player)
  local data = GetPrefabData(_self())
  local vent = GetRelativePrefabEntity(_self(), ".ExplosionMarker1")
  local PlayerPos = GetPosition(player)
  local VentPos = GetPosition(vent)
  local delta = (VentPos - PlayerPos)
  if (1 < delta.x) then
    delta:normalize3()
    local ventSpeed = 4
    delta = (delta * ventSpeed)
    delta.y = 0
    SetExternalVelocity(player, delta, 0.8999999761581421)
  end
  return 
end
AUT_PlayerEscapeVent = function()
  local data = GetPrefabData(_self())
  data.PlayerAtVent = 0
  return 
end
