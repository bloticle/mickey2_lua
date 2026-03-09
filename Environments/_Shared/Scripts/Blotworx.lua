UpdateBlotworxWeakState = function(weakpoint, stimulusEvent)
  local alias = StimulusEvent_SourceStimulusAlias(stimulusEvent)
  if (alias == "Guardian") then
    if StimulusEvent_HasStimulusType(stimulusEvent, ST_PAINT) then
      FullPaint(weakpoint)
    else
      FullSketch(weakpoint)
      local status = PaintThinnerCounter_GetStatus(weakpoint)
      if (status == PTCS_Paint) then
        local blotworx = GetPropertyEntity(weakpoint, "Parent Entity")
        if (GetCurrentTeam(blotworx) ~= 3) then
          if StimulusEvent_HasStimulusType(stimulusEvent, ST_PAINT) then
            FullPaint(weakpoint)
          end
        elseif (GetCurrentTeam(blotworx) == 3) then
          if StimulusEvent_HasStimulusType(stimulusEvent, ST_THINNER) then
            SetTargetTeam(blotworx, 2)
            if (status == PTCS_Thinner) then
              FullSketch(weakpoint)
            else
              local blotworx, blotworx = GetPropertyEntity(weakpoint, "Parent Entity"), weakpoint
              blotworx = GetCurrentTeam
              blotworx = blotworx(blotworx)
              if (blotworx ~= 2) then
                blotworx = SetTargetTeam
                blotworx(blotworx, 2)
              end
            end
          end
        end
      elseif (status == PTCS_Thinner) then
        FullSketch(weakpoint)
      else
        local blotworx, blotworx = GetPropertyEntity(weakpoint, "Parent Entity"), weakpoint
        blotworx = GetCurrentTeam
        blotworx = blotworx(blotworx)
        if (blotworx ~= 2) then
          blotworx = SetTargetTeam
          blotworx(blotworx, 2)
        end
      end
    end
  else
    local status = PaintThinnerCounter_GetStatus(weakpoint)
    if (status == PTCS_Paint) then
      local blotworx = GetPropertyEntity(weakpoint, "Parent Entity")
      if (GetCurrentTeam(blotworx) ~= 3) then
        if StimulusEvent_HasStimulusType(stimulusEvent, ST_PAINT) then
          FullPaint(weakpoint)
        end
      elseif (GetCurrentTeam(blotworx) == 3) then
        if StimulusEvent_HasStimulusType(stimulusEvent, ST_THINNER) then
          SetTargetTeam(blotworx, 2)
          if (status == PTCS_Thinner) then
            FullSketch(weakpoint)
          else
            local blotworx, blotworx = GetPropertyEntity(weakpoint, "Parent Entity"), weakpoint
            blotworx = GetCurrentTeam
            blotworx = blotworx(blotworx)
            if (blotworx ~= 2) then
              blotworx = SetTargetTeam
              blotworx(blotworx, 2)
            end
          end
        end
      end
    elseif (status == PTCS_Thinner) then
      FullSketch(weakpoint)
    else
      local blotworx, blotworx = GetPropertyEntity(weakpoint, "Parent Entity"), weakpoint
      blotworx = GetCurrentTeam
      blotworx = blotworx(blotworx)
      if (blotworx ~= 2) then
        blotworx = SetTargetTeam
        blotworx(blotworx, 2)
      end
    end
  end
  return 
end
FullSketch = function(weakpoint)
  local blotworx = GetPropertyEntity(weakpoint, "Parent Entity")
  SetHealth(blotworx, 0)
  return 
end
FullPaint = function(weakpoint)
  local blotworx = GetPropertyEntity(weakpoint, "Parent Entity")
  SetTargetTeam(blotworx, 3)
  return 
end
WeakPointHitReaction = function(weakpoint)
  local blotworx = GetPropertyEntity(weakpoint, "Parent Entity")
  AnimEvent(blotworx, EVENT_Start_HitReaction)
  return 
end
DisbleTremorDamageVolume = function()
  local tremorDamageVolume = GetChildEntityByName(_self(), "BruiserBlotworxTremorDamageVolume")
  DisableComponent(tremorDamageVolume, "Physics Trigger Damage Component")
  return 
end
EnableTremorDamageVolume = function()
  local tremorDamageVolume = GetChildEntityByName(_self(), "BruiserBlotworxTremorDamageVolume")
  EnableComponent(tremorDamageVolume, "Physics Trigger Damage Component")
  Rumble(GetPlayer(), 1.25)
  Rumble(nil, 1.25, 1)
  ShakeCamera_Default("camera")
  return 
end
EnablePoundVolume = function()
  local tremorDamageVolume = GetChildEntityByName(_self(), "BruiserBlotworxLeftPoundVolume")
  EnableComponent(tremorDamageVolume, "Physics Trigger Damage Component")
  local tremorDamageVolume = GetChildEntityByName(_self(), "BruiserBlotworxRightPoundVolume")
  EnableComponent(tremorDamageVolume, "Physics Trigger Damage Component")
  return 
end
DisablePoundVolume = function()
  local tremorDamageVolume = GetChildEntityByName(_self(), "BruiserBlotworxLeftPoundVolume")
  DisableComponent(tremorDamageVolume, "Physics Trigger Damage Component")
  local tremorDamageVolume = GetChildEntityByName(_self(), "BruiserBlotworxRightPoundVolume")
  DisableComponent(tremorDamageVolume, "Physics Trigger Damage Component")
  return 
end
SharedMaskOnDeath = function()
  local blotworx = GetPropertyEntity(_self(), "Parent Entity")
  if IsValidHandle(blotworx) then
    AnimVarInt(blotworx, VAR_Armor_State, 0)
  end
  return 
end
SharedMaskStartup = function(self, state)
  AnimVarInt(self, VAR_Armor_State, tonumber(state))
  return 
end
BruiserMaskOnDeath = function()
  local blotworx = GetPropertyEntity(_self(), "Parent Entity")
  SetBoneScale(blotworx, "face", 0)
  SetBoneScale(blotworx, "neck", 0)
  SetExhaustStateHigh(blotworx)
  return 
end
EnableExhaustBehaviorCallback = function()
  return 
end
DisableExhaustBehaviorCallback = function()
  return 
end
EnableRangedExhaustAttack = function()
  local exhaustAttack = GetChildEntityByName(_self(), "RangedBlotworxExhaustAttack")
  SetPropertyInt(exhaustAttack, "WeaponShots", -1)
  return 
end
DisableRangedExhaustAttack = function()
  local exhaustAttack = GetChildEntityByName(_self(), "RangedBlotworxExhaustAttack")
  SetPropertyInt(exhaustAttack, "WeaponShots", 0)
  return 
end
SetExhaustStateShared = function(blotworx, active)
  local leftExhaust = GetChildEntityByName(blotworx, "BruiserBlotworx_Root_Transform_exhaustLeft_bruiser_ExhaustLight_01a")
  local rightExhaust = GetChildEntityByName(blotworx, "BruiserBlotworx_Root_Transform_exhaustRight_bruiser_ExhaustLight_01a")
  if (tonumber(active) == 1) then
    local exhaustDamageVolume = GetChildEntityByName(blotworx, "BruiserBlotworxExhaustDamageVolume")
    EnableComponent(exhaustDamageVolume, "Physics Trigger Damage Component")
    SetVisualScale(leftExhaust, 1)
    SetVisualScale(rightExhaust, 1)
    SetEmitterSpawnRate(leftExhaust, "pEmit_SmokeShape", 36)
    SetEmitterSpawnRate(rightExhaust, "pEmit_SmokeShape", 36)
    SetEmitterSpawnRate(leftExhaust, "pasted__pEmit_flamesShape", 20)
    SetEmitterSpawnRate(rightExhaust, "pasted__pEmit_flamesShape", 20)
  else
    local exhaustDamageVolume, exhaustDamageVolume = GetChildEntityByName(blotworx, "BruiserBlotworxExhaustDamageVolume"), blotworx
    exhaustDamageVolume = Print
    exhaustDamageVolume("OLD FUNCTION")
    exhaustDamageVolume = DisableComponent
    exhaustDamageVolume(exhaustDamageVolume, "Physics Trigger Damage Component")
    exhaustDamageVolume = SetVisualScale
    exhaustDamageVolume(leftExhaust, 0.5)
    exhaustDamageVolume = SetVisualScale
    exhaustDamageVolume(rightExhaust, 0.5)
    exhaustDamageVolume = SetEmitterSpawnRate
    exhaustDamageVolume(leftExhaust, "pEmit_SmokeShape", 0)
    exhaustDamageVolume = SetEmitterSpawnRate
    exhaustDamageVolume(rightExhaust, "pEmit_SmokeShape", 0)
  end
  return 
end
SetExhaustStateLow = function()
  local leftExhaust = GetChildEntityByName(_self(), "BruiserBlotworx_Root_Transform_exhaustLeft_bruiser_ExhaustLight_01a")
  local rightExhaust = GetChildEntityByName(_self(), "BruiserBlotworx_Root_Transform_exhaustRight_bruiser_ExhaustLight_01a")
  local exhaustDamageVolume = GetChildEntityByName(_self(), "BruiserBlotworxExhaustDamageVolume")
  local playerCollision = GetChildEntityByName(_self(), "BruiserBlotworxPlayerCollision")
  EnableComponent(playerCollision, "Bouncy")
  DisableComponent(exhaustDamageVolume, "Physics Trigger Damage Component")
  SetVisualScale(leftExhaust, 0.375)
  SetVisualScale(rightExhaust, 0.375)
  SetEmitterSpawnRate(leftExhaust, "pEmit_SmokeShape", 0)
  SetEmitterSpawnRate(rightExhaust, "pEmit_SmokeShape", 0)
  return 
end
SetExhaustStateCheck = function()
  if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
    SetExhaustStateMid()
  else
    SetExhaustStateHigh()
  end
  return 
end
SetExhaustStateMid = function()
  local leftExhaust = GetChildEntityByName(_self(), "BruiserBlotworx_Root_Transform_exhaustLeft_bruiser_ExhaustLight_01a")
  local rightExhaust = GetChildEntityByName(_self(), "BruiserBlotworx_Root_Transform_exhaustRight_bruiser_ExhaustLight_01a")
  local exhaustDamageVolume = GetChildEntityByName(_self(), "BruiserBlotworxExhaustDamageVolume")
  local playerCollision = GetChildEntityByName(_self(), "BruiserBlotworxPlayerCollision")
  DisableComponent(playerCollision, "Bouncy")
  EnableComponent(exhaustDamageVolume, "Physics Trigger Damage Component")
  SetVisualScale(leftExhaust, 0.5)
  SetVisualScale(rightExhaust, 0.5)
  SetEmitterSpawnRate(leftExhaust, "pEmit_SmokeShape", 0)
  SetEmitterSpawnRate(rightExhaust, "pEmit_SmokeShape", 0)
  return 
end
SetExhaustStateHigh = function(target)
  local self = _self()
  if (target ~= nil) then
    self = target
  end
  local leftExhaust = GetChildEntityByName(self, "BruiserBlotworx_Root_Transform_exhaustLeft_bruiser_ExhaustLight_01a")
  local rightExhaust = GetChildEntityByName(self, "BruiserBlotworx_Root_Transform_exhaustRight_bruiser_ExhaustLight_01a")
  local exhaustDamageVolume = GetChildEntityByName(self, "BruiserBlotworxExhaustDamageVolume")
  local playerCollision = GetChildEntityByName(self, "BruiserBlotworxPlayerCollision")
  DisableComponent(playerCollision, "Bouncy")
  EnableComponent(exhaustDamageVolume, "Physics Trigger Damage Component")
  SetVisualScale(leftExhaust, 1)
  SetVisualScale(rightExhaust, 1)
  SetEmitterSpawnRate(leftExhaust, "pEmit_SmokeShape", 36)
  SetEmitterSpawnRate(rightExhaust, "pEmit_SmokeShape", 36)
  SetEmitterSpawnRate(leftExhaust, "pasted__pEmit_flamesShape", 20)
  SetEmitterSpawnRate(rightExhaust, "pasted__pEmit_flamesShape", 20)
  return 
end
BlotworxAnvilDamage = function(self)
  if (not HasCollectible("SketchUpgrade_Sketch_Anvil")) then
    if IsValidHandle(GetChildEntityByName(self, "BruiserBlotworxLowerMask")) then
      SetHealth(GetChildEntityByName(self, "BruiserBlotworxLowerMask"), 0)
      DestroyAnvil(_activator())
    elseif IsValidHandle(GetChildEntityByName(self, "BruiserBlotworxMask")) then
      SetHealth(GetChildEntityByName(self, "BruiserBlotworxMask"), 0)
      DestroyAnvil(_activator())
    elseif IsValidHandle(GetChildEntityByName(self, "RangedBlotworxMask")) then
      SetHealth(GetChildEntityByName(self, "RangedBlotworxMask"), 0)
      DestroyAnvil(_activator())
    else
      local health = 0
      SetHealth(self, health)
      local health, health = 0, SetHealth
      health = SetHealth
      health(self, health)
    end
  else
    local health, health = 0, "SketchUpgrade_Sketch_Anvil"
    health = SetHealth
    health(self, health)
  end
  return 
end
RangedMaskDestroyed = function(mask)
  local blotworx = GetPropertyEntity(mask, "Parent Entity")
  if IsValidHandle(blotworx) then
    StartEmitterByNameFireForget(blotworx, "RangedBlotworx_Hood_Transform_rangedBlotworx_hoodBreakDust_01a")
    AnimEvent(blotworx, EVENT_Done_Stunned)
  end
  return 
end
RangedMissileCollided = function(missile)
  SetAppCulledOnNode(missile, "Missle_Main", true)
  local effectName = ""
  if IsCharacter(_activator()) then
    effectName = "RangedBlotworxBombExplodeEffect_Characters"
  elseif (0.5 < math.random()) then
    effectName = "RangedBlotworxBombExplodeEffect"
  else
    effectName = "RangedBlotworxBombExplodeEffect_Alternate"
  end
  StartEmitterByNameFireForget(missile, effectName)
  return 
end
RangedPlayerColSpawned = function(col)
  local blotworx = GetPropertyEntity(col, "Parent Entity")
  if IsValidHandle(blotworx) then
    SetPropertyEntity(col, "EntityToRelayTo", blotworx)
    RegisterForEventTypes(col)
  end
  return 
end
BruiserLowerMaskDestroyed = function()
  local blotworx = GetPropertyEntity(_self(), "Parent Entity")
  if IsValidHandle(blotworx) then
    local upperMask = GetChildEntityByName(blotworx, "BruiserBlotworxMask")
    local invulnerableTime = GetPropertyFloat(upperMask, "InvulnerableDuration", 0)
    if (0 < invulnerableTime) then
      wait(invulnerableTime)
    end
    if IsValidHandle(upperMask) then
      SetPropertyBool(upperMask, "ForceInvulnerable", false)
    end
  end
  return 
end
BruiserExhaustDamageEffects = function()
  local blotworx = GetPropertyEntity(_self(), "Parent Entity")
  return 
end
BlotworxBombDetonate = function()
  local stimType = ST_KNOCKBACK
  local stimDamage = 1
  local targetPos = GetPosition(_self())
  local stimRadius = 1.5
  StimulusSphere(_self(), stimType, stimDamage, targetPos, stimRadius)
  return 
end
ForwardElectricStim = function(weakpoint, stimulusEvent)
  local blotworx = GetPropertyEntity(weakpoint, "Parent Entity")
  if IsValidHandle(blotworx) then
    if StimulusEvent_HasStimulusType(stimulusEvent, ST_ELECTRIC) then
      local source = StimulusEvent_Source(stimulusEvent)
      local stimType = ST_ELECTRIC
      local alias = StimulusEvent_SourceStimulusAlias(stimulusEvent)
      local baseAmount = StimulusEvent_BaseAmount(stimulusEvent, ST_ELECTRIC)
      local direction = StimulusEvent_Direction(stimulusEvent)
      StimulusEntityWithAlias(source, stimType, baseAmount, direction, blotworx, alias)
    end
  end
  return 
end
BlotworxThinnerOceanDestroy = function(self)
  local health = 0
  SetHealth(self, health)
  local ObjectPosition = GetPosition(self)
  local (for index), (for limit), (for step) = ObjectPosition.y, (ObjectPosition.y - 15), -0.02500000037252903
  for i = (for index), (for limit), (for step) do
    SetPositionFloat(self, ObjectPosition.x, i, ObjectPosition.z)
    Wait(0)
  end
  return 
end
BlotworxGibFadeOut = function(self)
  local inc = 0.05000000074505806
  local total = 0
  SetR3MTOverrideTransparent(self)
  while (total < 1) do
    total = (total + inc)
    SetR3MTConstRegAlpha(self, 3, (1 - total))
    Wait(0.05000000074505806)
  end
  return 
end
BlotworxGibAngularImpulse = function()
  local impulseAmount = 10000
  EnableMotion(_self())
  ApplyImpulseFromCenter(_self(), impulseAmount)
  return 
end
MeleeBlotworxDisableBounce = function()
  DisableComponent(GetChildEntityByName(_self(), "MeleeBlotworxPlayerCollision"), "Bouncy")
  SetPropertyBool(_self(), "AllowStomp", false)
  return 
end
MeleeBlotworxEnableBounce = function()
  EnableComponent(GetChildEntityByName(_self(), "MeleeBlotworxPlayerCollision"), "Bouncy")
  SetPropertyBool(_self(), "AllowStomp", true)
  return 
end
Blotworx_DamageFromElectricBlast = function(target, _event)
  local alias = StimulusEvent_SourceStimulusAlias(_event)
  if (alias == "ElectricBlast") then
    if (not IsValidHandle(GetChildEntityByName(target, "BruiserBlotworxLowerMask"))) then
      if (not IsValidHandle(GetChildEntityByName(target, "BruiserBlotworxMask"))) then
        if (not IsValidHandle(GetChildEntityByName(target, "RangedBlotworxMask"))) then
          QueueBrainEvent(target, BRAIN_FinishedElectroStunned)
          Wait(0.10000000149011612)
          AnimEvent(target, EVENT_Become_Vulnerable)
        end
      end
    end
  end
  return 
end
RangedBlotworxDefaultPlayerCollision = ""
RangedBlotworx_AdjustPlayerCollision = function()
  local playerCollision = GetChildEntityByName(_self(), "RangerBlotworxPlayerCollision")
  RangedBlotworxDefaultPlayerCollision = GetPropertyVector(playerCollision, "Bone Attach Offset")
  SetPropertyVector(playerCollision, "Bone Attach Offset", vector4(RangedBlotworxDefaultPlayerCollision.x, RangedBlotworxDefaultPlayerCollision.y, (RangedBlotworxDefaultPlayerCollision.z - 10)), 0)
  return 
end
RangedBlotworx_ResetPlayerCollision = function()
  local playerCollision = GetChildEntityByName(_self(), "RangerBlotworxPlayerCollision")
  SetPropertyVector(playerCollision, "Bone Attach Offset", RangedBlotworxDefaultPlayerCollision, 0)
  return 
end
BruiserBlotworxTremorDeathFX = function(self)
  SetPropertyInt(self, "Index To Spawn", 1, 0)
  ForceSpawn(self, 1)
  return 
end
