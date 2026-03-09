Prefab_2DTicketSplineTripleSetup = function(target)
  local data = GetPrefabData(target)
  if (data.InstantSpawn == false) then
    if (data.TicketOrder == {0, 0, 0}) then
      local n = math.random(1, 6)
      if (n == 1) then
        data.TicketOrder = {1, 2, 3}
      elseif (n == 2) then
        data.TicketOrder = {1, 3, 2}
      elseif (n == 3) then
        data.TicketOrder = {2, 1, 3}
      elseif (n == 4) then
        data.TicketOrder = {2, 3, 1}
      elseif (n == 5) then
        data.TicketOrder = {3, 1, 2}
      else
        data.TicketOrder = {3, 2, 1}
      end
    end
  end
  return 
end
Prefab_TicketRain = function(target)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Prefab_TicketRain called!")
  local data = GetPrefabData(target)
  local spawner = GetRelativePrefabEntity(target, ".ticketSpawner 01")
  local Prefab_SpawnTicket_AtKnot = function(spawner, index, tKnot)
    SetPropertyInt(spawner, "Index To Spawn", index)
    SetPropertyEntity(spawner, "Spawn Destinations", tKnot, 0)
    ForceSpawn(spawner, 1)
    return 
  end
  local Prefab_PickTicket_ToSpawn = function(whichTix)
    Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Prefab_TicketRain calls Prefab_PickTicket_ToSpawn for target " .. whichTix) .. "!!"))
    if (whichTix == 1) then
      Prefab_SpawnTicket_AtKnot(spawner, 0, GetRelativePrefabEntity(target, ".SplineKnot 11"))
    elseif (whichTix == 2) then
      Prefab_SpawnTicket_AtKnot(spawner, 1, GetRelativePrefabEntity(target, ".SplineKnot 21"))
    elseif (whichTix == 3) then
      Prefab_SpawnTicket_AtKnot(spawner, 2, GetRelativePrefabEntity(target, ".SplineKnot 31"))
    end
    return 
  end
  if (data.InstantSpawn == true) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Prefab_TicketRain is set to InstantSpawn!!")
    Prefab_SpawnTicket_AtKnot(spawner, 0, GetRelativePrefabEntity(target, ".SplineKnot 11"))
    Prefab_SpawnTicket_AtKnot(spawner, 1, GetRelativePrefabEntity(target, ".SplineKnot 21"))
    Prefab_SpawnTicket_AtKnot(spawner, 2, GetRelativePrefabEntity(target, ".SplineKnot 31"))
    Enable(GetRelativePrefabEntity(target, ".ETicket1"))
    Enable(GetRelativePrefabEntity(target, ".ETicket2"))
    Enable(GetRelativePrefabEntity(target, ".ETicket3"))
  else
    local (for index), (for limit), (for step) = 1, 3, 1
    for x = (for index), (for limit), (for step) do
      if (data.TicketOrder[x] == 1) then
        wait(((math.random(8) + 2) / 10))
        Prefab_PickTicket_ToSpawn(x)
        Enable(GetRelativePrefabEntity(target, (".ETicket" .. tostring(x))))
      end
    end
    local (for index), (for limit), (for step) = 1, 3, 1
    for x = (for index), (for limit), (for step) do
      (for index) = data.TicketOrder
      (for index) = (for index)[x]
      if ((for index) == 2) then
        (for index) = wait
        (for limit) = math
        (for limit) = (for limit).random
        (for step) = 8
        (for limit) = (for limit)((for step))
        (for limit) = ((for limit) + 2)
        (for limit) = ((for limit) / 10)
        (for index)((for limit))
        (for index) = Prefab_PickTicket_ToSpawn
        (for limit) = x
        (for index)((for limit))
        (for index) = Enable
        (for limit) = GetRelativePrefabEntity
        (for step) = target
        x = ".ETicket"
        x = (x .. tostring(x))
        (for limit) = (for limit)((for step), x)
        (for index)((for limit))
      end
    end
    local (for index), (for limit), (for step) = 1, 3, 1
    for x = (for index), (for limit), (for step) do
      if (data.TicketOrder[x] == 3) then
        wait(((math.random(8) + 2) / 10))
        Prefab_PickTicket_ToSpawn(x)
        (for index) = tostring
        (for limit) = x
        (for index) = (for index)((for limit))
        Enable(GetRelativePrefabEntity(target, (".ETicket" .. (for index))))
      end
    end
  end
  return 
end
