Spatter_Kamikaze_Explode = function(self)
  local parentEntity = GetPropertyEntity(self, "Parent Entity")
  DialogBox(GetPlayer(), parentEntity)
  KnockbackExplode_Default(parentEntity)
  Damage(GetPlayer(), 1)
  wait(0.20000000298023224)
  Kill(parentEntity)
  wait(0.10000000149011612)
  DestroyEntity(self)
  return 
end
Spladoosh_Play_Spin_React = function(self, event)
  if StimulusEvent_HasStimulusType(event, ST_SPIN) then
    AudioPostEventOn(self, "Play_sfx_BltKmk_mvmt_HitReact")
  end
  return 
end
Total_Elec_Stim = 0
Spatter_Electric_Player2 = function(self)
  Total_Elec_Stim = (Total_Elec_Stim + 0.5)
  if (10 < Total_Elec_Stim) then
    Kill(self)
    Total_Elec_Stim = 0
  end
  return 
end
Spatter_SetReward = function(target)
  local scrapper_playstyle_value = GetScrapperPercent(GetPlayer())
  local hero_playstyle_value = GetHeroPercent(GetPlayer())
  if (0.33000001311302185 < hero_playstyle_value) then
    SetPropertyInt(target, "RewardSpawnIndex", 1, 0)
  elseif (0.33000001311302185 < scrapper_playstyle_value) then
    SetPropertyInt(target, "RewardSpawnIndex", 2, 0)
  else
    SetPropertyInt(target, "RewardSpawnIndex", 0, 0)
  end
  return 
end
SpatterRanged_SetReward = function(target)
  local i = math.random(1, 100)
  wait(0.10000000149011612)
  i = math.random(1, 100)
  if (66 < i) then
    SetPropertyInt(target, "RewardSpawnIndex", 1, 0)
  else
    SetPropertyInt(target, "RewardSpawnIndex", 2, 0)
  end
  return 
end
Spatter_TrackKnockbackReward = function(target)
  SetPropertyInt(target, "Index To Spawn", 1, 0)
  SetPropertyFloat(target, "Spawn Radius", 1, 0)
  SetPropertyVector(target, "Spawn Offset", vector4(0, 1.25, 0))
  Wait(0.5)
  if (target ~= nil) then
    ForceSpawn(target, 1)
    SetPropertyInt(target, "Index To Spawn", 0, 0)
    SetPropertyFloat(target, "Spawn Radius", 2, 0)
    SetPropertyVector(target, "Spawn Offset", vector4(0, 0, 0))
  end
  return 
end
SpatterOceanDeath = function()
  Wait(0.10000000149011612)
  DisableMotion(_self())
  AIController_SetDisabled(_self(), true)
  return 
end
SpatterOceanDeath_RemoveRewards = function()
  SetPropertyInt(_self(), "RewardDeathTypes", 0, 0)
  SetPropertyString(_self(), "Templates To Spawn", "", 0)
  return 
end
SweeperLowerProjectileSplash = function(self)
  local temp_pos = (GetPosition(self) + vector4(0, -1.100000023841858, 0))
  SetTransformation(self, temp_pos, vector4(0, 0, 0))
  return 
end
SweeperSetWeaponPosition = function()
  local rangedWeapon = GetChildEntityByName(_self(), "SpatterExplosionWeapon")
  SetPropertyVector(rangedWeapon, "Bone Attach Offset", vector4(0, -2, 11), 0)
  return 
end
SweeperResetWeaponPosition = function()
  local rangedWeapon = GetChildEntityByName(_self(), "SpatterExplosionWeapon")
  SetPropertyVector(rangedWeapon, "Bone Attach Offset", vector4(0, 0, 0), 0)
  return 
end
SweeperProjectileChange = function(self)
  if (GetCurrentTeam(self) == 2) then
    SetPropertyInt(GetChildEntityByName(self, "SpatterExplosionWeapon"), "Projectile Spawn Index", 1, 0)
  elseif (GetCurrentTeam(self) == 3) then
    SetPropertyInt(GetChildEntityByName(self, "SpatterExplosionWeapon"), "Projectile Spawn Index", 2, 0)
  end
  return 
end
SlobberVacuum_Offself = function(self)
  Disable(self)
  Hide(self)
  return 
end
SlobberVacuum_Off = function()
  local toonVacuum = GetChildEntityByName(_self(), "TheBlobVacuumToonStim")
  Disable(toonVacuum)
  Hide(toonVacuum)
  return 
end
SlobberVacuum_On = function()
  local toonVacuum = GetChildEntityByName(_self(), "TheBlobVacuumToonStim")
  Wait(0.5)
  Unhide(toonVacuum)
  Enable(toonVacuum)
  Wait(1)
  Wait(0)
  Disable(toonVacuum)
  Hide(toonVacuum)
  return 
end
SlobberAllowStomp_On = function()
  SetPropertyBool(_self(), "AllowStomp", true)
  return 
end
SlobberAllowStomp_Off = function()
  SetPropertyBool(_self(), "AllowStomp", false)
  return 
end

