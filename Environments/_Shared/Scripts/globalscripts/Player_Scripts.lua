Mickey_Puddle_Emitter = nil
Mickey_Revive_Event = function(entity, event)
  local subEvent = ReviveEvent_GetSubEvent(event)
  if (subEvent == ReviveEvent_Respawn) then
    local magicBrush = nil
    if (_self() == _player()) then
      magicBrush = GetChildEntityByName(_self(), "MagicBrush")
    else
      magicBrush = GetChildEntityByName(_self(), "oswald_remote")
    end
    Hide(magicBrush)
    RestoreShadowScale(_self())
    PlayerSetDripsVisible(_self(), true)
    wait(1)
    Unhide(magicBrush)
  end
  return 
end
Mickey_Start_Death = function()
  if (Mickey_Puddle_Emitter ~= nil) then
    if IsValidHandle(Mickey_Puddle_Emitter) then
      DestroyEntity(Mickey_Puddle_Emitter)
      Mickey_Puddle_Emitter = nil
    end
  end
  if (_self() == _player()) then
    wait(0.33329999446868896)
  end
  SetVisualScale(_self(), 0)
  if (_self() == _player()) then
    Mickey_Puddle_Emitter = StartEmitterByNameFireForget(_self(), "MK_Puddle_Drip")
  else
    Mickey_Puddle_Emitter = StartEmitterByNameFireForget(_self(), "Oswald_Puddle_Drips")
  end
  PlayerSetDripsVisible(_self(), false)
  local magicBrush = nil
  if (_self() == _player()) then
    magicBrush = GetChildEntityByName(_self(), "MagicBrush")
  else
    magicBrush = GetChildEntityByName(_self(), "oswald_remote")
  end
  Hide(magicBrush)
  SetShadowScale(_self(), vector4(0, 0, 0))
  return 
end
Mickey_Start_Revive = function()
  RestoreShadowScale(_self())
  local magicBrush = nil
  if (_self() == _player()) then
    magicBrush = GetChildEntityByName(_self(), "MagicBrush")
  else
    magicBrush = GetChildEntityByName(_self(), "oswald_remote")
  end
  Unhide(magicBrush)
  if (Mickey_Puddle_Emitter ~= nil) then
    if IsValidHandle(Mickey_Puddle_Emitter) then
      Hide(Mickey_Puddle_Emitter)
      DestroyEntity(Mickey_Puddle_Emitter)
      Mickey_Puddle_Emitter = nil
    end
  end
  return 
end
Mickey_Stop_Death = function()
  return 
end
ScaleDrip = function(mickey, emitter)
  local startScale = 0
  local endScale = 1
  local totalTime = 0.33329999446868896
  local scalePerFrame = (((endScale - startScale) * 0.033330000936985016) / totalTime)
  local currentScale = startScale
  while (currentScale < endScale) do
    wait(0)
    currentScale = (currentScale + scalePerFrame)
  end
  return 
end
