DeleteChildEntity = function(target, name)
  local childEntity = GetChildEntityByName(target, name)
  DestroyEntity(childEntity)
  return 
end
TVImpactCharacter = function(tv, activator)
  if (activator == GetPlayer()) then
    wait(0.10000000149011612)
    local stimType = ST_KNOCKBACK
    local stimDamage = GetConfigVariableFloat("DefaultAbilities_Sketch_Anvil_AnvilKnockbackStim")
    local stimRadius = 0
    StimulusEntityWithAliasCalculateDirectionInRadius(tv, stimType, stimDamage, stimRadius, activator, "TV")
  else
    RemovePhysicsFromWorld(tv)
    AnimVarInt(tv, VAR_Death_Type, 1)
    AnimEvent(tv, EVENT_Start_Death)
    AudioPostEventOn(tv, "Stop_sfx_tv20")
    AudioPostEventOn(tv, "Stop_sfx_tv_last5")
    DeleteChildEntity(tv, "PaintTV_Screen")
    Wait(0.6000000238418579)
    DestroyEntity(tv)
  end
  return 
end
DestroyAnvil = function(anvil)
  AnimEvent(anvil, EVENT_Start_Death)
  RemovePhysicsFromWorld(anvil)
  Wait(0.33000001311302185)
  DestroyEntity(anvil)
  return 
end
AnvilImpactCharacter = function(anvil, activator)
  if (activator == GetPlayer()) then
    local targetPos = GetPosition(activator)
    wait(0.10000000149011612)
    local stimType = ST_KNOCKBACK
    local stimDamage = GetConfigVariableFloat("DefaultAbilities_Sketch_Anvil_AnvilKnockbackStim")
    local stimRadius = 6
    StimulusEntityWithAliasCalculateDirectionInRadius(anvil, stimType, stimDamage, stimRadius, activator, "Anvil")
    StimulusEntityWithAlias(anvil, ST_PHYSICAL, 1, targetPos, activator, "Anvil")
  else
    RaiseCrushedByAnvilEvent(anvil, activator)
    if IsAlive(activator) then
      if CanEntitiesCollide(anvil, activator) then
        AudioPostEventOn(anvil, "Play_anvil_hit")
        local groupname = GetPropertyString(activator, "EntityGroups", 0)
        if (groupname ~= "Dropwing") then
          DestroyAnvil(anvil)
        end
      end
    end
  end
  return 
end
AnvilImpactDamage = function(target)
  local stimType = ST_PHYSICAL
  local stimDamage = 10
  local targetPos = GetPosition(_self())
  local stimRadius = 3
  StimulusSphereWithAlias(GetPlayer(), stimType, stimDamage, targetPos, stimRadius, "Anvil")
  return 
end
AnvilImpactKnockback = function(anvil)
  wait(0.10000000149011612)
  local stimType = ST_KNOCKBACK
  local stimDamage = GetConfigVariableFloat("DefaultAbilities_Sketch_Anvil_AnvilKnockbackStim")
  local targetPos = GetPosition(anvil)
  local stimRadius = 5
  StimulusSphereWithAlias(GetPlayer(), stimType, stimDamage, targetPos, stimRadius, "Anvil")
  StimulusEntityWithAliasCalculateDirectionInRadius(anvil, stimType, stimDamage, stimRadius, GetPlayer(), "Anvil")
  return 
end
ApplyFairyStimFromFairySketch = function(fairy)
  FairyResetSuccess()
  wait(0.20000000298023224)
  local stimType = ST_FAIRY
  local stimDamage = GetConfigVariableFloat("DefaultAbilities_Sketch_Fairy_StimDamage")
  local stimPosition = GetPosition(fairy)
  local stimRadius = GetConfigVariableFloat("DefaultAbilities_Sketch_Fairy_StimRadius")
  StimulusSphereWithAlias(GetPlayer(), stimType, stimDamage, stimPosition, stimRadius, "FairySketch")
  wait(0.20000000298023224)
  FairyTargetCheck()
  return 
end
AnvilImpactBreakables = function(target)
  local stimType = ST_BREAKABLE
  local stimDamage = 10
  local targetPos = GetPosition(_self())
  local stimRadius = 4
  StimulusSphereWithAlias(GetPlayer(), stimType, stimDamage, targetPos, stimRadius, "Anvil")
  return 
end
AnvilPuddle = function(self, anvil)
  SetResponseModifierActive(self, false)
  local targetPos = GetPosition(self)
  local stimDamage = GetAnvilThinnerDamage()
  StimulusEntityWithAlias(anvil, ST_THINNER, stimDamage, targetPos, self, "Anvil")
  return 
end
AnvilStun = function(self)
  local anvilStun = GetConfigVariableFloat("DefaultAbilities_Sketch_Anvil_AnvilStunStim")
  local targetPos = GetPosition(self)
  StimulusEntityWithAlias(GetPlayer(), ST_STUN, anvilStun, targetPos, self, "Anvil")
  return 
end
AnvilDamage = function(self)
  local anvilPhysical = GetConfigVariableFloat("DefaultAbilities_Sketch_Anvil_AnvilPhysicalStim")
  local targetPos = GetPosition(self)
  StimulusEntityWithAlias(GetPlayer(), ST_PHYSICAL, anvilPhysical, targetPos, self, "Anvil")
  return 
end
TurnOnTV = function(tvObject)
  EnableComponent(tvObject, "AttractRepel")
  return 
end
BMCComponent_DriveMotionWithPhysics = function()
  DriveMotionWithPhysics(_activator())
  return 
end
BMCComponent_StopDriveMotionWithPhysics = function()
  local child = GetChildEntityByIndex(_self(), 1)
  if IsValidHandle(child) then
    local activator = GetPropertyEntity(child, "Second Entity", 0)
    if IsValidHandle(activator) then
      FallFromAir(activator)
    end
  end
  return 
end
PhysicsForceComponent_ActivateForces = function()
  ActivateForces(_self())
  return 
end
PhysicsForceComponent_AddAffectedEntity = function()
  if (GetPropertyFloat(_activator(), "Max Air Speed") == 0) then
    SetPropertyFloat(_self(), "Modified Gravity", 0, 0)
  end
  AddAffectedEntity(_self(), _activator())
  return 
end
Constraint_SetEntities = function()
  Print("Constraint_SetEntities")
  local pos = 0
  local facing = 0
  local child = 0
  child = GetChildEntityByIndex(_self(), 1)
  pos = GetPosition(_activator())
  pos.y = (pos.y + 2.5)
  facing = GetFacing(_self())
  SetTransformation(_self(), pos, facing)
  SetConstraintEntities(child, _self(), _activator())
  return 
end
TV_Damage = function(self, event)
  if StimulusEvent_HasStimulusType(event, ST_PHYSICAL) then
    print(("\n--------------------- I am getting hit by (more accurately)" .. StimulusEvent_SourceStimulusAlias(event)))
    if (StimulusEvent_SourceStimulusAlias(event) == "BeetleworxFodderWeapon") then
      print(("\n--------------------- Valid source of dmg for TV splosion " .. StimulusEvent_SourceStimulusAlias(event)))
      StartEmitterByName(self, "TVArcFX")
      Wait(0.25)
      AnimVarInt(self, VAR_Death_Type, 1)
      AnimEvent(self, EVENT_Start_Death)
      AudioPostEventOn(self, "Stop_sfx_tv20")
      AudioPostEventOn(self, "Stop_sfx_tv_last5")
      DeleteChildEntity(self, "PaintTV_Screen")
      Wait(0.6000000238418579)
      DestroyEntity(self)
      if StimulusEvent_HasStimulusType(event, ST_THINNER) then
        if (StimulusEvent_SourceStimulusAlias(event) == "ThinnerOcean") then
          DisableMotion(self)
          AudioPostEventOn(self, "Play_sfx_Sketch_Thinner_Splash")
          Wait(0.032999999821186066)
          ForceSketched(self)
          if StimulusEvent_HasStimulusType(event, ST_KNOCKBACK) then
            if (StimulusEvent_SourceStimulusAlias(event) == "BossAttackStimulus") then
              StartEmitterByName(self, "TVArcFX")
              Wait(0.25)
              AnimVarInt(self, VAR_Death_Type, 1)
              AnimEvent(self, EVENT_Start_Death)
              AudioPostEventOn(self, "Stop_sfx_tv20")
              AudioPostEventOn(self, "Stop_sfx_tv_last5")
              DeleteChildEntity(self, "PaintTV_Screen")
              Wait(0.6000000238418579)
              DestroyEntity(self)
            end
          end
        end
      elseif StimulusEvent_HasStimulusType(event, ST_KNOCKBACK) then
        if (StimulusEvent_SourceStimulusAlias(event) == "BossAttackStimulus") then
          StartEmitterByName(self, "TVArcFX")
          Wait(0.25)
          AnimVarInt(self, VAR_Death_Type, 1)
          AnimEvent(self, EVENT_Start_Death)
          AudioPostEventOn(self, "Stop_sfx_tv20")
          AudioPostEventOn(self, "Stop_sfx_tv_last5")
          DeleteChildEntity(self, "PaintTV_Screen")
          Wait(0.6000000238418579)
          DestroyEntity(self)
        end
      end
    end
  elseif StimulusEvent_HasStimulusType(event, ST_THINNER) then
    if (StimulusEvent_SourceStimulusAlias(event) == "ThinnerOcean") then
      DisableMotion(self)
      AudioPostEventOn(self, "Play_sfx_Sketch_Thinner_Splash")
      Wait(0.032999999821186066)
      ForceSketched(self)
      if StimulusEvent_HasStimulusType(event, ST_KNOCKBACK) then
        if (StimulusEvent_SourceStimulusAlias(event) == "BossAttackStimulus") then
          StartEmitterByName(self, "TVArcFX")
          Wait(0.25)
          AnimVarInt(self, VAR_Death_Type, 1)
          AnimEvent(self, EVENT_Start_Death)
          AudioPostEventOn(self, "Stop_sfx_tv20")
          AudioPostEventOn(self, "Stop_sfx_tv_last5")
          DeleteChildEntity(self, "PaintTV_Screen")
          Wait(0.6000000238418579)
          DestroyEntity(self)
        end
      end
    end
  elseif StimulusEvent_HasStimulusType(event, ST_KNOCKBACK) then
    if (StimulusEvent_SourceStimulusAlias(event) == "BossAttackStimulus") then
      StartEmitterByName(self, "TVArcFX")
      Wait(0.25)
      AnimVarInt(self, VAR_Death_Type, 1)
      AnimEvent(self, EVENT_Start_Death)
      AudioPostEventOn(self, "Stop_sfx_tv20")
      AudioPostEventOn(self, "Stop_sfx_tv_last5")
      DeleteChildEntity(self, "PaintTV_Screen")
      Wait(0.6000000238418579)
      DestroyEntity(self)
    end
  end
  return 
end
ForceThin = function(self, event)
  if StimulusEvent_HasStimulusType(event, ST_THINNER) then
    if (StimulusEvent_SourceStimulusAlias(event) == "ThinnerOcean") then
      DisableMotion(self)
      AudioPostEventOn(self, "Play_sfx_Sketch_Thinner_Splash")
      Wait(0.032999999821186066)
      ForceSketched(self)
    end
  end
  return 
end
ImpulseFairyObject = function(target, stimulusEvent)
  if StimulusEvent_HasStimulusType(stimulusEvent, ST_SPIN) then
    local land_spot = (GetPosition(target) - GetPosition(_activator()))
    land_spot:normalize3()
    ApplyImpulse(target, (land_spot.x * 250), 0, (land_spot.z * 250))
  end
  return 
end
