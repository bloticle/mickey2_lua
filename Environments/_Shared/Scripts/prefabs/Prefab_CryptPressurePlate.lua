Prefab_CryptDoorGuardian_AlwaysSetup = function(target)
  Print("__Function: Prefab_CryptDoorGuardian_AlwaysSetup")
  AnimGBSequence(GetRelativePrefabEntity(target, ".CryptDoors"), "open")
  return 
end
Prefab_CryptDoorGuardian_QueryPlayerState = function(target)
  Print("__Function: Prefab_CryptDoorGuardian_QueryPlayerState")
  local data = GetPrefabData(target)
  if (data.DoorState == 0) then
    if (GetPropertyBool(_activator(), "Invisible") == false) then
      Print((tostring(_activator()) .. " is NOT invisible!!"))
      if (data.PlayersInside[1] == 1) then
        Print("__Someone is inside the crypt! They're trapped!")
      end
      AnimGBSequence(GetRelativePrefabEntity(target, ".CryptDoors"), "close")
      data.DoorState = 1
    else
      Print("__Activator is invisible!")
      Print("__Door has already been closed!")
    end
  else
    Print("__Door has already been closed!")
  end
  return 
end
Prefab_CryptDoorGuardian_OpenDoors = function(target)
  Print("__Function: Prefab_CryptDoorGuardian_OpenDoors")
  local data = GetPrefabData(target)
  Print("__Someone left the door trigger, invisible or not!")
  if (data.DoorState == 1) then
    Print("__The door was closed, opening!")
    data.DoorState = 0
    AnimGBSequence(GetRelativePrefabEntity(target, ".CryptDoors"), "open")
  end
  return 
end
Prefab_CryptDoorGuardian_CryptEntered = function(target, _Entered)
  Print(("__Function: Prefab_CryptDoorGuardian_CryptEntered, _Entered: " .. tostring(_Entered)))
  local data = GetPrefabData(target)
  if (_Entered == "Enter") then
    Print((("__" .. tostring(GetName(_activator()))) .. " Entered the crypt!"))
    if (_activator() == _player()) then
      data.PlayersInside[reg_23] = 1
    else
      data.PlayersInside[reg_24] = 1
      if (_Entered == "Exit") then
        Print((("__" .. tostring(GetName(_activator()))) .. " Exited the crypt!"))
        if (_activator() == _player()) then
          data.PlayersInside[reg_23] = 0
        else
          data.PlayersInside[reg_24] = 0
        end
      end
    end
  elseif (_Entered == "Exit") then
    Print((("__" .. tostring(GetName(_activator()))) .. " Exited the crypt!"))
    if (_activator() == _player()) then
      data.PlayersInside[reg_23] = 0
    else
      data.PlayersInside[reg_24] = 0
    end
  end
  Print(((("__PlayersInside[1]: " .. tostring(data.PlayersInside[1])) .. ", [2]: ") .. tostring(data.PlayersInside[2])))
  if (data.PlayersInside[1] == 1) then
    Print("__Someone is inside the crypt! Disabling the detection trigger.")
    Disable(GetRelativePrefabEntity(target, ".DoorTrigger"))
  end
  Print("__No one is inside the crypt! re-enabling the invisiblity trigger.")
  Enable(GetRelativePrefabEntity(target, ".DoorTrigger"))
  return 
end
Prefab_CryptDoorGuardian_HeadTracker = function(target, _Direction)
  Print(("__Function: Prefab_CryptDoorGuardian_HeadTracker, _Direction: " .. tostring(_Direction)))
  local Head1 = GetRelativePrefabEntity("CryptDoors", ".CryptGuardian")
  local Head2 = GetRelativePrefabEntity("CryptDoors", ".CryptGuardian2")
  if (GetName(target) == GetName(GetPlayer())) then
    if (_Direction == "Forward") then
      Print("__Activator is Mickey! Starting tracking for left head")
      SetPropertyEntity(Head1, "RotateToEntity", GetPlayer())
    else
      SetPropertyEntity(Head1, "RotateToEntity", nil)
      if (_Direction == "Forward") then
        Print("__Activator is Oswald! Starting tracking for right head")
        SetPropertyEntity(Head2, "RotateToEntity", GetPlayer2OrAI())
      else
        SetPropertyEntity(Head2, "RotateToEntity", nil)
      end
    end
  elseif (_Direction == "Forward") then
    Print("__Activator is Oswald! Starting tracking for right head")
    SetPropertyEntity(Head2, "RotateToEntity", GetPlayer2OrAI())
  else
    SetPropertyEntity(Head2, "RotateToEntity", nil)
  end
  return 
end

