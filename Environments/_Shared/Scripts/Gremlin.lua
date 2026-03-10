TeleportGremlinToEntity = function(gremlin, target, ...)
  local args = {}
  local snapToGround = nil
  if (0 < (#args)) then
    snapToGround = args[1]
  else
    snapToGround = true
  end
  local waitForLand = nil
  if (1 < (#args)) then
    waitForLand = args[2]
  else
    waitForLand = true
  end
  local startedInCutscene = IsInCutscene(gremlin)
  TeleportGremlinOut(gremlin)
  TeleportGremlinIn(gremlin, target, startedInCutscene, snapToGround, waitForLand)
  return 
end
TeleportGremlinOut = function(gremlin_entity)
  local gremlin = gremlin_entity
  if (gremlin == nil) then
    Print("Gremlin == nil")
    gremlin = _self()
  end
  DisableComponent(gremlin, "Usable")
  wait(1)
  AnimVarInt(gremlin, VAR_Cutscene, 6)
  AnimEvent(gremlin, EVENT_Start_Cutscene)
  wait(0.8999999761581421)
  Hide(gremlin)
  SetPropertyInt(gremlin, "Collision Layer", 7)
  return 
end
TeleportGremlinIn = function(gremlin, target, startedInCutscene, ...)
  local args = {}
  local snapToGround = nil
  if (0 < (#args)) then
    snapToGround = args[1]
  else
    snapToGround = true
  end
  local waitForLand = nil
  if (1 < (#args)) then
    waitForLand = args[2]
  else
    waitForLand = true
  end
  ForceUnpuddled(gremlin)
  TeleportToEntity(gremlin, target, snapToGround, false)
  StartGremlinTeleportInFX(gremlin)
  wait(0.6600000262260437)
  SetPropertyInt(gremlin, "Collision Layer", 4)
  Unhide(gremlin)
  AnimVarInt(gremlin, VAR_Cutscene, 5)
  AnimEvent(gremlin, EVENT_Start_Cutscene)
  if waitForLand then
    wait(1.5)
  end
  wait(1.7000000476837158)
  EnableComponent(gremlin, "Usable")
  return 
end
StartGremlinTeleportOutFX = function()
  Print("StartGremlinTeleportOutFX")
  local gremlin = _self()
  local gremlinType = GetPropertyString(gremlin, "AIType")
  Print(("StartGremlinTeleportOutFX: gremlinType = " .. gremlinType))
  if (gremlinType == "Gremlin:Gus") then
    StartEmitterByNameFireForget(gremlin, "GremlinGusTeleportOutFX")
  elseif (gremlinType == "Gremlin:Variant1") then
    StartEmitterByNameFireForget(gremlin, "GremlinVariant1TeleportOutFX")
  elseif (gremlinType == "Gremlin:Variant2") then
    StartEmitterByNameFireForget(gremlin, "GremlinVariant2TeleportOutFX")
  else
    if (gremlinType == "Gremlin:Variant3") then
      StartEmitterByNameFireForget(gremlin, "GremlinVariant3TeleportOutFX")
    end
    if (gremlinType == "Gremlin:Variant4") then
      StartEmitterByNameFireForget(gremlin, "GremlinVariant4TeleportOutFX")
    elseif (gremlinType == "Gremlin:Prescott") then
      StartEmitterByNameFireForget(gremlin, "GremlinPrescottTeleportOutFX")
    elseif (gremlinType == "Gremlin:Markus") then
      StartEmitterByNameFireForget(gremlin, "JamfaceTeleportOutFX")
    else
      Print(("ERROR: Tried to start TeleportOutFX on unknown gremlin type: " .. gremlinType))
    end
  end
  return 
end
StartGremlinTeleportInFX = function(gremlin)
  local gremlinType = GetPropertyString(gremlin, "AIType")
  if (gremlinType == "Gremlin:Gus") then
    StartEmitterByNameFireForget(gremlin, "GremlinGusTeleportInFX")
  elseif (gremlinType == "Gremlin:Variant1") then
    StartEmitterByNameFireForget(gremlin, "GremlinVariant1TeleportInFX")
  elseif (gremlinType == "Gremlin:Variant2") then
    StartEmitterByNameFireForget(gremlin, "GremlinVariant2TeleportInFX")
  elseif (gremlinType == "Gremlin:Variant3") then
    StartEmitterByNameFireForget(gremlin, "GremlinVariant3TeleportInFX")
  elseif (gremlinType == "Gremlin:Variant4") then
    StartEmitterByNameFireForget(gremlin, "GremlinVariant4TeleportInFX")
  elseif (gremlinType == "Gremlin:Prescott") then
    StartEmitterByNameFireForget(gremlin, "GremlinPrescottTeleportInFX")
  elseif (gremlinType == "Gremlin:Markus") then
    StartEmitterByNameFireForget(gremlin, "JamfaceTeleportInFX")
  else
    Print(("ERROR: Tried to start TeleportInFX on unknown gremlin type: " .. gremlinType))
  end
  return 
end
HideGremlinWrench = function()
  Hide(GetChildEntityByName(_self(), "GremlinWrench"))
  return 
end
UnhideGremlinWrench = function()
  if (not IsHidden(_self())) then
    Unhide(GetChildEntityByName(_self(), "GremlinWrench"))
  end
  return 
end

