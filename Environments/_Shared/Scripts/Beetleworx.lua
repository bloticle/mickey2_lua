BeetleworxCannonPaintAttachment = function(paintedChild, nameOfChildToPaint)
  local cannon = GetPropertyEntity(paintedChild, "Parent Entity")
  if IsValidHandle(cannon) then
    local childToPaint = GetChildEntityByName(cannon, nameOfChildToPaint)
    if IsValidHandle(childToPaint) then
      ForcePainted(childToPaint)
    end
  end
  return 
end
BeetleworxCannonThinAttachment = function(thinnedChild, nameOfChildToThin)
  local cannon = GetPropertyEntity(thinnedChild, "Parent Entity")
  if IsValidHandle(cannon) then
    local childToThin = GetChildEntityByName(cannon, nameOfChildToThin)
    if IsValidHandle(childToThin) then
      ForceSketched(childToThin)
    end
  end
  return 
end
DisableAllWeapons = function(cannon)
  local berserkShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonBerserkShot")
  local leftUpShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonLeftShotPaintLow")
  local rightUpShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonRightShotPaintLow")
  local doubleUpShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonDoubleShot")
  local leftDownShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonLeftShotThinnerLow")
  local rightDownShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonRightShotThinnerLow")
  local doubleDownShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonDoubleDownShot")
  local swipeWeapon = GetChildEntityByName(cannon, "BeetleworxCannonSwipe")
  DisableWeapon(berserkShotWeapon)
  DisableWeapon(rightUpShotWeapon)
  DisableWeapon(doubleUpShotWeapon)
  DisableWeapon(doubleDownShotWeapon)
  return 
end
EnableBerserkWeapons = function(cannon, enable)
  local berserkShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonBerserkShot")
  local leftUpShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonLeftShotPaintLow")
  local rightUpShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonRightShotPaintLow")
  local doubleUpShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonDoubleShot")
  local leftDownShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonLeftShotThinnerLow")
  local rightDownShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonRightShotThinnerLow")
  local doubleDownShotWeapon = GetChildEntityByName(cannon, "BeetleworxCannonDoubleDownShot")
  local swipeWeapon = GetChildEntityByName(cannon, "BeetleworxCannonSwipe")
  if enable then
    EnableWeapon(berserkShotWeapon)
    DisableWeapon(rightUpShotWeapon)
    DisableWeapon(doubleUpShotWeapon)
    DisableWeapon(doubleDownShotWeapon)
    DisableWeapon(swipeWeapon)
  else
    DisableWeapon(berserkShotWeapon)
    EnableWeapon(leftUpShotWeapon)
    EnableWeapon(rightUpShotWeapon)
    EnableWeapon(doubleUpShotWeapon)
    EnableWeapon(leftDownShotWeapon)
    EnableWeapon(rightDownShotWeapon)
    EnableWeapon(doubleDownShotWeapon)
    EnableWeapon(swipeWeapon)
  end
  return 
end
BeetleworxCannonCarChangedState = function(car)
  local cannon = GetPropertyEntity(car, "Parent Entity")
  if IsValidHandle(cannon) then
    EnableBerserkWeapons(cannon, (not GetPropertyBool(car, "Is Painted")))
  end
  return 
end
BeetleworxCannonGunChangedState = function(gun)
  local parentEntity = GetPropertyEntity(gun, "Parent Entity")
  if IsValidHandle(parentEntity) then
    BeetleworxCannonUpdateShotWeapons(parentEntity)
  end
  return 
end
DisableWeapon = function(weapon)
  if IsValidHandle(weapon) then
    SetPropertyInt(weapon, "WeaponShots", 0)
  end
  return 
end
EnableWeapon = function(weapon)
  if IsValidHandle(weapon) then
    SetPropertyInt(weapon, "WeaponShots", -1)
  end
  return 
end
DamageParent = function(self, stimulusEvent)
  local parentEntity = GetPropertyEntity(self, "Parent Entity", 0)
  if IsValidHandle(parentEntity) then
    if StimHasDamage(stimulusEvent) then
      PlayWeakspotHitEffect(parentEntity, stimulusEvent)
    end
  end
  return 
end
BeetleworxCannonAnvilDamage = function(self)
  if (not HasCollectible("SketchUpgrade_Sketch_Anvil")) then
    local health = (GetHealth(self) - 1)
    SetHealth(self, health)
    if (0 < GetHealth(self)) then
      DestroyAnvil(_activator())
    end
  else
    local health, health = 0, "SketchUpgrade_Sketch_Anvil"
    health = SetHealth
    health(self, health)
  end
  return 
end
BeetleworxBasherAnvilDamage = function(self)
  if (not HasCollectible("SketchUpgrade_Sketch_Anvil")) then
    local health = (GetHealth(self) - 1)
    SetHealth(self, health)
    if (0 < GetHealth(self)) then
      DestroyAnvil(_activator())
      QueueBrainEvent(self, BRAIN_FinishedHitReaction)
    end
  else
    local health, health = 0, "SketchUpgrade_Sketch_Anvil"
    health = SetHealth
    health(self, health)
  end
  return 
end
BeetleworxThinnerOceanDestroy = function(self)
  local health = 0
  if (GetPropertyFloat(self, "Slow Vulnerability", 0) <= 0) then
    return 
  end
  SetPropertyFloat(self, "Slow Vulnerability", 0, 0)
  Wait(2)
  DisableMotion(self)
  AIController_SetDisabled(self, true)
  SetHealth(self, health)
  return 
end
lastDamageTime = nil
PlayOrientedEffect = function(self, effectName, stimulusEvent)
  StartEmitterByName(self, effectName)
  local effectEntity = GetChildEntityByName(self, effectName)
  local myPosition = GetTargetPosition(self)
  local directionToStim = (-StimulusEvent_Direction(stimulusEvent))
  if (directionToStim.y < 0) then
    directionToStim.y = 0
    directionToStim:normalize3()
  end
  local desiredPosition = (myPosition + (directionToStim * 0.5))
  SetTransformation(effectEntity, desiredPosition, directionToStim)
  return 
end
WeakspotExposed = function(self)
  local weakspotEntity = GetChildEntityByName(self, "BeetleworxCannonWeakSpot")
  if IsValidHandle(weakspotEntity) then
    if (not (not GetPropertyBool(self, "ForceInvulnerable"))) then
      return false
    end
  end
  return true
end
StimHasDamage = function(stimulusEvent)
  local hasStimulus = false
  if StimulusEvent_HasStimulusType(stimulusEvent, ST_SPIN) then
    if (0 < StimulusEvent_EffectiveAmount(stimulusEvent, ST_SPIN)) then
      return true
    end
  end
  return false
end
PlayWeakspotHitEffect = function(self, stimulusEvent)
  if WeakspotExposed(self) then
    if StimHasDamage(stimulusEvent) then
      if (lastDamageTime == nil) then
        lastDamageTime = timestamp()
      end
    end
  end
  return 
end
PlayInvulnerableHitEffect = function(self, stimulusEvent)
  if (not WeakspotExposed(self)) then
    if StimulusEvent_HasStimulusType(stimulusEvent, ST_SPIN) then
      if (lastDamageTime == nil) then
        lastDamageTime = timestamp()
      end
    end
  end
  return 
end
BeetleworxCannonReorientHealthRing = function(ring)
  local ringUp = GetUp(ring)
  SetFacing(ring, ringUp)
  return 
end
BeetleworxCannonEndHindrance = function(self, stimulusEvent)
  if StimulusEvent_HasStimulusType(stimulusEvent, ST_THINNER) then
    local cannon = GetPropertyEntity(self, "Parent Entity")
    if IsValidHandle(cannon) then
      EndHindrance(cannon)
    end
  end
  return 
end
BeetleworxGibAngularImpulse = function()
  local x = math.random(20, 40)
  local y = math.random(20, 40)
  local z = math.random(20, 40)
  ApplyAngularImpulse(_self(), x, y, z)
  return 
end
HinderTurnRate = function(self)
  SetOverrideTurnRate(self, 0)
  return 
end
EndHinderTurnRate = function(self)
  ResetOverrideTurnRate(self)
  return 
end
OnBeetleworxCrawlerToonStimmedPaintThinner = function(self)
  BeetleworxToonShellThinnedUpdateSound(self, "BW_Thinned", 100)
  return 
end
OnBeetleworxFodderToonStimmedPaintThinner = function(self)
  BeetleworxToonShellThinnedUpdateSound(self, "BW_Thinned", 100)
  return 
end
OnBeetleworxMeleeToonStimmedPaintThinner = function(self)
  BeetleworxToonShellThinnedUpdateSound(self, "BW_Thinned", 100)
  return 
end
OnBeetleworxCannonToonStimmedPaintThinner = function(self)
  BeetleworxToonShellThinnedUpdateSound(self, "BW_Thinned", 100)
  return 
end
BeetleworxToonShellThinnedUpdateSound = function(self, soundParameterName, multiplier)
  local paintedPercentage = PaintThinnerCounter_GetPaintedPercentage(self)
  AudioSetParameter(nil, soundParameterName, (multiplier * paintedPercentage))
  return 
end
BeetleworxGibFadeOut = function(self)
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
BW_SpawnerOrb = function(self, event)
  local anim_event = AnimGBSequenceEndedName(self, event)
  local orb = GetRelativePrefabEntity(self, ".BW_Spawner_Orb")
  Print("DOOR ANIM EVENT")
  if (anim_event == "Close") then
    Print("DOOR CLOSED - SET ORB INVULN")
    SetPropertyBool(orb, "InvulnerableToPaintThinner", true)
  elseif (anim_event == "Open") then
    Print("DOOR OPEN - SET ORB VULN")
    SetPropertyBool(orb, "InvulnerableToPaintThinner", false)
  end
  return 
end
BWX_DamageFromElectricBlast = function(target, _event)
  local alias = StimulusEvent_SourceStimulusAlias(_event)
  local AITypeString = GetPropertyString(target, "AIType")
  if (alias == "ElectricBlast") then
    local health = (GetHealth(target) - 1)
    SetHealth(target, health)
    if (string.find(AITypeString, "BeetleworxCrawler") ~= nil) then
      StartEmitterByName(target, "BeetleworxCrawler_SmokeFXLifetime")
    elseif (string.find(AITypeString, "BeetleworxCannon") ~= nil) then
      StartEmitterByName(target, "BeetleworxCannonDamageSmokeFXLifetime")
    elseif (string.find(AITypeString, "AnimatronicPirateMelee") ~= nil) then
      StartEmitterByName(target, "Beetleworx_SmokeFXLifetime")
    end
  end
  return 
end
ACH_Reprogrammed = function()
  GiveCollectible("Challenge_GetWithTheProgram_Tracker")
  return 
end
BWX_TrackKnockbackReward = function(target)
  SetPropertyInt(target, "Index To Spawn", 4, 0)
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

