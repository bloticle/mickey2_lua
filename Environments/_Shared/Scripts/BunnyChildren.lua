TurnIntoBunnyBall = function(bunnyChild, deathEvent)
  if (DeathEvent_DeathType(deathEvent) == 6) then
    return 
  end
  if IsValidHandle(bunnyChild) then
    local bunnyBall = ForceSpawn(bunnyChild, 1)
    InheritFairyState(bunnyChild, bunnyBall[1])
  end
  return 
end
TurnIntoBunnyBallFromElectricity = function(self)
  Kill(self)
  return 
end
TurnIntoBunny = function(bunnyBall)
  if IsValidHandle(bunnyBall) then
    local bunnyChild = ForceSpawn(bunnyBall, 1)
    InheritFairyState(bunnyBall, bunnyChild[1])
    DestroyEntity(bunnyBall)
  end
  return 
end
FirstTimeBunnyAttach = function()
  if (GetGlobal("BunnyHasAttached") == 0) then
    SetGlobal("BunnyHasAttached", 1)
  end
  return 
end
BunnyChildThinnerImmunity = function(self)
  Wait(0.032999999821186066)
  DestroyEntity(self)
  return 
end
