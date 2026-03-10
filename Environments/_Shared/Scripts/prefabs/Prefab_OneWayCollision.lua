PlayerPastObstacle = function(trigger)
  local data = GetPrefabData(trigger)
  local tempCollisionObj = GetRelativePrefabEntity(trigger, ".CollisionObj")
  if (_activator() == GetPlayer()) then
    if (data.player1ObjCollision == 0) then
      if (data.player2ObjCollision == 0) then
        SetPropertyInt(tempCollisionObj, "Collision Layer", 1)
        SetEntityToNotCollideWithPlayerTwo(tempCollisionObj)
        SetEntityToNotCollideWithBuddyAI(tempCollisionObj)
      elseif (data.player2ObjCollision == 1) then
        ResetEntityFromNoCollide(tempCollisionObj)
        Disable(trigger)
      else
        print("LUA ERROR: PlayerPastObstacle(trigger) called and data.player2ObjCollision is other than 0 or 1")
        print(("LUA ERROR: data.player2ObjCollision = " .. tostring(data.player2ObjCollision)))
      end
      data.player1ObjCollision = 1
    end
  elseif (_activator() == GetPlayerOrAI(PLAYER_TWO)) then
    if (data.player2ObjCollision == 0) then
      if (data.player1ObjCollision == 0) then
        SetPropertyInt(tempCollisionObj, "Collision Layer", 1)
        SetEntityToNotCollideWithPlayerOne(tempCollisionObj)
      elseif (data.player1ObjCollision == 1) then
        ResetEntityFromNoCollide(tempCollisionObj)
        Disable(trigger)
      else
        print("LUA ERROR: PlayerPastObstacle(trigger) called and data.player1ObjCollision is other than 0 or 1")
        print(("LUA ERROR: data.player1ObjCollision = " .. tostring(data.player1ObjCollision)))
      end
      data.player2ObjCollision = 1
    end
  end
  return 
end
DisableCollisionOnLoad = function(collisionObj)
  local data = GetPrefabData(collisionObj)
  if (data.player1ObjCollision == 0) then
    if (data.player2ObjCollision == 1) then
      SetPropertyInt(collisionObj, "Collision Layer", 1)
      SetEntityToNotCollideWithPlayerOne(collisionObj)
    end
  elseif (data.player1ObjCollision == 1) then
    if (data.player2ObjCollision == 0) then
      SetPropertyInt(collisionObj, "Collision Layer", 1)
      SetEntityToNotCollideWithPlayerTwo(collisionObj)
      SetEntityToNotCollideWithBuddyAI(collisionObj)
    end
  end
  return 
end
DoTriggeredReDisable = function(trigger)
  local data = GetPrefabData(trigger)
  if (_activator() == GetPlayer()) then
    if (data.player1ObjCollision == 1) then
      ReDisableCollisionForPlayer(GetRelativePrefabEntity(trigger, ".CollisionObj"), 1)
    end
  elseif (_activator() == GetPlayerOrAI(PLAYER_TWO)) then
    if (data.player2ObjCollision == 1) then
      ReDisableCollisionForPlayer(GetRelativePrefabEntity(trigger, ".CollisionObj"), 2)
    end
  end
  return 
end
ReDisableCollisionForPlayer = function(collisionObj, playerNumber)
  local data = GetPrefabData(collisionObj)
  if (playerNumber ~= 3) then
    if (playerNumber ~= 1) then
    end
  else
    ResetEntityFromNoCollide(collisionObj)
    SetPropertyInt(collisionObj, "Collision Layer", 13)
    data.player1ObjCollision = 0
    data.player2ObjCollision = 0
    Enable(GetRelativePrefabEntity(collisionObj, ".Trigger"))
  end
  if (playerNumber == 1) then
    if (data.player2ObjCollision == 1) then
      ResetEntityFromNoCollide(collisionObj)
      SetPropertyInt(collisionObj, "Collision Layer", 1)
      SetEntityToNotCollideWithPlayerOne(collisionObj)
      data.player1ObjCollision = 0
      Enable(GetRelativePrefabEntity(collisionObj, ".Trigger"))
    end
  elseif (playerNumber == 2) then
    if (data.player1ObjCollision == 1) then
      ResetEntityFromNoCollide(collisionObj)
      SetPropertyInt(collisionObj, "Collision Layer", 1)
      SetEntityToNotCollideWithPlayerTwo(collisionObj)
      SetEntityToNotCollideWithBuddyAI(collisionObj)
      data.player2ObjCollision = 0
      Enable(GetRelativePrefabEntity(collisionObj, ".Trigger"))
    end
  else
    print("LUA ERROR: ReDisableCollisionForPlayer(collisionObj, playerNumber) failed to change anything, check your calls and parameters")
    print(("LUA ERROR: collisionObj = " .. GetName(collisionObj)))
    print((("LUA ERROR: playerNumber = " .. tostring(playerNumber)) .. " [1 for p1, 2 for p2, or 3 for both players]"))
    print(("LUA ERROR: data.player1ObjCollision = " .. tostring(data.player1ObjCollision)))
    print(("LUA ERROR: data.player2ObjCollision = " .. tostring(data.player2ObjCollision)))
  end
  return 
end

