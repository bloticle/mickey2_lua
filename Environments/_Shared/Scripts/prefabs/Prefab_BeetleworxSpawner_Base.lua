Prefab_BeetleworxSpawner_Base_AlwaysSetup = function(target)
  Print("__Function: Prefab_BeetleworxSpawner_Base_AlwaysSetup")
  local data = GetPrefabData(target)
  Disable(GetRelativePrefabEntity(target, ".Wind"))
  Hide(GetRelativePrefabEntity(target, ".Wind"))
  if (GetGlobal(data.MachineStateGlobal) == 0) then
    Print("__SpawnerBase: AlwaysSetup called and this spawner was active! Overriding to active!")
    data.SpawnerActive = "True"
  end
  if (GetGlobal(data.MachineStateGlobal) == 1) then
    Print("__SpawnerBase: Starting smoke emitters, this spawner was thinned!")
    StartEmitters(GetRelativePrefabEntity(target, ".HackboxSmoke"))
  end
  if (data.ShouldAlwaysBeDeactiveGlobalCheck[1] ~= "None") then
    Print(((((("__SpawnerBase: ShouldAlwaysBeDeactiveGlobalCheck[1] Overridden! Will check to see if: " .. tostring(data.ShouldAlwaysBeDeactiveGlobalCheck[1])) .. " is: ") .. tostring(data.ShouldAlwaysBeDeactiveGlobalCheck[2])) .. " to/than: ") .. tostring(data.ShouldAlwaysBeDeactiveGlobalCheck[3])))
    local GlobalValue = GetGlobal(data.ShouldAlwaysBeDeactiveGlobalCheck[1])
    if (data.ShouldAlwaysBeDeactiveGlobalCheck[2] == "Equal") then
      if (GlobalValue == data.ShouldAlwaysBeDeactiveGlobalCheck[3]) then
        Print("__SpawnerBase: Global == data.ShouldAlwaysBeDeactiveGlobalCheck[3]! Disabling!")
        data.SpawnerActive = "False"
        return 
      end
    elseif (data.ShouldAlwaysBeDeactiveGlobalCheck[2] == "NotEqual") then
      if (GlobalValue ~= data.ShouldAlwaysBeDeactiveGlobalCheck[3]) then
        Print("__SpawnerBase: Global ~= data.ShouldAlwaysBeDeactiveGlobalCheck[3]! Disabling!")
        data.SpawnerActive = "False"
        return 
      end
    elseif (data.ShouldAlwaysBeDeactiveGlobalCheck[2] == "LessThan") then
      if (GlobalValue < data.ShouldAlwaysBeDeactiveGlobalCheck[3]) then
        Print("__SpawnerBase: Global < data.ShouldAlwaysBeDeactiveGlobalCheck[3]! Disabling!")
        data.SpawnerActive = "False"
        return 
      end
    elseif (data.ShouldAlwaysBeDeactiveGlobalCheck[2] == "GreaterThan") then
      if (data.ShouldAlwaysBeDeactiveGlobalCheck[3] < GlobalValue) then
        Print("__SpawnerBase: Global > data.ShouldAlwaysBeDeactiveGlobalCheck[3]! Disabling!")
        data.SpawnerActive = "False"
        return 
      end
    elseif (data.ShouldAlwaysBeDeactiveGlobalCheck[2] == "LessThanOrEqualTo") then
      if (GlobalValue <= data.ShouldAlwaysBeDeactiveGlobalCheck[3]) then
        Print("__SpawnerBase: Global <= data.ShouldAlwaysBeDeactiveGlobalCheck[3]! Disabling!")
        data.SpawnerActive = "False"
        return 
      end
    elseif (data.ShouldAlwaysBeDeactiveGlobalCheck[2] == "GreaterThanOrEqualTo") then
      if (data.ShouldAlwaysBeDeactiveGlobalCheck[3] <= GlobalValue) then
        Print("__SpawnerBase: Global >= data.ShouldAlwaysBeDeactiveGlobalCheck[3]! Disabling!")
        data.SpawnerActive = "False"
        return 
      end
    end
  end
  Print("__SpawnerBase: Waiting for the state to finish streaming to continue with AlwaysSetup! This will only matter if your _Child prefab is in a different layer than your _Base!")
  while true do
    if (not (LevelManager_HasStateFinishedStreaming() == false)) then
      break
    end
    wait(0.20000000298023224)
  end
  while true do
    if (not (LevelManager_WaitingForStreamingSync() == false)) then
      break
    end
    Wait(0.05000000074505806)
  end
  if (data.SpawnerActive == "True") then
    Print("__SpawnerBase: SpawnerActive is True! Spawning a Beetleworx")
    if (GetGlobal(data.MachineStateGlobal) ~= 2) then
      if (data.MachineStateGlobal ~= "None") then
        Print((("__SpawnerBase: Setting Global: " .. tostring(data.MachineStateGlobal)) .. " to ACTIVE (0)"))
        SetGlobal(data.MachineStateGlobal, 0)
      else
        Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
        Print("__SpawnerBase: Machine State Global was 2! Will spawn and hack the beetleworx!")
      end
    else
      Print("__SpawnerBase: Machine State Global was 2! Will spawn and hack the beetleworx!")
    end
    if (data.EntityGroupNames[1] == "None") then
      Print("__SpawnerBase: EntityGroupNames[1] isn't overridden! This spawner WILL NOT work!")
      Print("__SpawnerBase: Override EntityGroupNames[1] to an entity group name of a BeetleworxChild Spawner!")
      return 
    end
    if (data.BeetleworxNumSpawned[2] == 0) then
      Print("__SpawnerBase: BeetleworxNumSpawned[2] == 0! This value is your MAX SPAWN! No Beetleworx will ever spawn out of this spawner!")
      return 
    end
    if (data.BeetleworxNumSpawned[2] < data.BeetleworxNumSpawned[1]) then
      Print("__SpawnerBase: data.BeetleworxNumSpawned[2] - YOUR MAX SPAWN - is less than your initial spawn! Fix this or bad things are going to happen")
      Print("__SpawnerBase: Not spawning any beetleworx! Make sure your max is higher than your initial!")
      return 
    end
    Prefab_BeetleworxSpawner_Base_Spawn(target)
  end
  return 
end
Prefab_BeetleworxSpawner_Base_Activate = function(target)
  Print("__Function: Prefab_BeetleworxSpawner_Base_Activate")
  Print(("__SpawnerBase: ACTIVATING SPAWNER: " .. tostring(target)))
  if (GetPrefabData(target).SpawnerActive == "True") then
    Print("__SpawnerBase: THIS TRIGGER IS ALREADY ACTIVE! DONT REACTIVATE IT AGAIN!")
  else
    GetPrefabData(target).SpawnerActive = "True"
    Prefab_BeetleworxSpawner_Base_AlwaysSetup(target)
  end
  return 
end
Prefab_BeetleworxSpawner_Base_Spawn = function(target)
  Print("__SpawnerBase Function: Prefab_BeetleworxSpawner_Base_Spawn")
  local data = GetPrefabData(target)
  local EmergencyOpen = false
  local TotalTimeWaited = 0
  while true do
    if (not (data.EmergencyTrigger ~= 0)) then
      break
    end
    if (EmergencyOpen == false) then
      EmergencyOpen = true
      Prefab_BeetleworxSpawner_Base_Doors(target, "Open")
    end
    Print("__SpawnerBase: Something's in the emergency trigger! Wait until everything is clear!")
    EmergencyOpen = true
    wait(0.20000000298023224)
    TotalTimeWaited = (TotalTimeWaited + 0.20000000298023224)
  end
  if (EmergencyOpen == true) then
    while true do
      if (not (data.EmergencyTrigger ~= 0)) then
        break
      end
      Print("__SpawnerBase: Waiting to close doors...")
      wait(0.10000000149011612)
      TotalTimeWaited = (TotalTimeWaited + 0.10000000149011612)
    end
    if (TotalTimeWaited < 1.2000000476837158) then
      local ToWait = (1.2000000476837158 - TotalTimeWaited)
      Print(((("__SpawnerBase: Doors were only opening for " .. tostring(TotalTimeWaited)) .. ", we need to wait for anims for another ") .. tostring(ToWait)))
      wait(ToWait)
    end
    Prefab_BeetleworxSpawner_Base_Doors(target, "Close")
    wait(2)
    FireThread(Prefab_BeetleworxSpawner_Base_Spawn, target)
    return 
  end
  data.EntitiesInTrigger = 0
  data.ClearToSpawn = 1
  Disable(GetRelativePrefabEntity(target, ".EmergencyDoorOpenTrigger"))
  if (data.BeetleworxNumSpawned[2] == 0) then
    Print("__SpawnerBase: BeetleworxNumSpawned[2] == 0! This value is your MAX SPAWN! No Beetleworx will ever spawn out of this spawner!")
    Print("__SpawnerBase: Override this to something nonzero!")
    return 
  end
  if (data.BeetleworxNumSpawned[1] < data.BeetleworxNumSpawned[2]) then
    if (data.ClearToSpawn == 1) then
      if (data.SpawnerActive == "True") then
        if (data.DoorsRemainOpen == "False") then
          data.BeetleworxNumSpawned[1] = (data.BeetleworxNumSpawned[1] + 1)
          Print(((("__SpawnerBase: Beetleworx Spawned: " .. tostring(data.BeetleworxNumSpawned[1])) .. ", Max: ") .. tostring(data.BeetleworxNumSpawned[2])))
          if (data.EntityGroupNames[1] == "None") then
            Print("__SpawnerBase: EntityGroupNames[1] isn't overridden! This spawner WILL NOT work!")
            Print("__SpawnerBase: Override EntityGroupNames[1] to an entity group name of a BeetleworxChild Spawner!")
            return 
          end
          TeleportToEntity(data.EntityGroupNames[1], GetRelativePrefabEntity(target, ".SpawnerLocation"))
          Enable(GetRelativePrefabEntity(target, ".DoorTrigger"))
          if (data.LastUniqueEntityDestroyed == "None") then
            Print("__SpawnerBase: LastUniqueEntityDestroyed == None! This can mean two things: ")
            Print("__SpawnerBase: 1. You only are using 1 entity out of this spawner, so this spawner doesn't care about this value")
            Print("__SpawnerBase: 2. You are using more than one spawner, but a bwx hasnt been destroyed yet, so there's no need to recycle one of the spawn group names")
            Print(("__SpawnerBase: Will spawn this entity with Spawn Group: " .. tostring((data.EntityGroupNames[2] .. tostring(data.BeetleworxNumSpawned[1])))))
            SetPropertyString(data.EntityGroupNames[1], "Spawn Group", tostring((data.EntityGroupNames[2] .. tostring(data.BeetleworxNumSpawned[1]))))
          else
            Print((("__SpawnerBase: LastUniqueEntityDestroyed HAS VALUE: " .. tostring(data.LastUniqueEntityDestroyed)) .. ".  Will spawn the next enemy with this Spawn Group!"))
            SetPropertyString(data.EntityGroupNames[1], "Spawn Group", tostring(data.LastUniqueEntityDestroyed))
          end
          local Spawned, Spawned = ForceSpawn(data.EntityGroupNames[1], 1), data.EntityGroupNames[1]
          Spawned = ClearNextPatrolNode
          Spawned(Spawned[1])
          Spawned = wait
          Spawned(0.10000000149011612)
          Spawned = SetNextPatrolNode
          Spawned(Spawned[1], GetRelativePrefabEntity(target, ".PatrolNode"))
          Spawned = Prefab_BeetleworxSpawner_Base_Doors
          Spawned(target, "Open")
          Spawned = GetGlobal
          Spawned = Spawned(data.MachineStateGlobal)
          if (Spawned == 2) then
            Spawned = Print
            Spawned("__SpawnerBase: We called Spawn while the box was hacked! Will friend this bwx!")
            Spawned = SetTargetTeam
            Spawned(Spawned[1], 3)
            data.SpawnerActive = "False"
          end
        end
      end
    end
  elseif (data.ClearToSpawn == 0) then
    Print("__SpawnerBase: Beetleworx will not spawn because the doors arent shut! Waiting until they are to spawn the next one!")
  elseif (data.BeetleworxNumSpawned[1] == data.BeetleworxNumSpawned[2]) then
    Print("__SpawnerBase: BeetleworxNumSpawned[1] == BeetleworxNumSpawned[2]! We have all available spawn slots for this spawner taken!")
  else
    Print("__SpawnerBase: This spawner is disabled!")
  end
  return 
end
Prefab_BeetleworxSpawner_Base_Doors = function(target, _OpenClose)
  Print(("__Function: Prefab_BeetleworxSpawner_Base_Doors, _OpenClose: " .. tostring(_OpenClose)))
  local data = GetPrefabData(target)
  if (_OpenClose == "Open") then
    Print("__SpawnerBase: Opening Doors!")
    AnimGBSequence(GetRelativePrefabEntity(target, ".OuterDoors_Left"), "Open")
    if (data.NumberDoors == 2) then
      AnimGBSequence(GetRelativePrefabEntity(target, ".OuterDoors_Right"), "Open")
    end
    AudioPostEventOn(GetRelativePrefabEntity(target, ".OuterDoors_Left"), "Play_sfx_btlwrx_dooropen1a")
    SetPropertyBool(GetRelativePrefabEntity(target, ".Orb"), "InvulnerableToPaintThinner", false)
    wait(1)
    AnimGBSequence(GetRelativePrefabEntity(target, ".Orb"), "Open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".InnerDoors"), "Open")
    AudioPostEventOn(GetRelativePrefabEntity(target, ".InnerDoors"), "Play_sfx_btlwrx_dooropen2a")
    Wait(0.10000000149011612)
    Enable(GetRelativePrefabEntity(target, ".Wind"))
    Unhide(GetRelativePrefabEntity(target, ".Wind"))
  elseif (_OpenClose == "Close") then
    Print("__SpawnerBase: Closing Doors!")
    Enable(GetRelativePrefabEntity(target, ".EmergencyDoorOpenTrigger"))
    AnimGBSequence(GetRelativePrefabEntity(target, ".InnerDoors"), "Close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Orb"), "Close")
    AudioPostEventOn(GetRelativePrefabEntity(target, ".InnerDoors"), "Play_sfx_btlwrx_dooropen2a")
    Wait(0.5)
    Disable(GetRelativePrefabEntity(target, ".Wind"))
    Hide(GetRelativePrefabEntity(target, ".Wind"))
    wait(0.5)
    SetPropertyBool(GetRelativePrefabEntity(target, ".Orb"), "InvulnerableToPaintThinner", true)
    AnimGBSequence(GetRelativePrefabEntity(target, ".OuterDoors_Left"), "Close")
    if (data.NumberDoors == 2) then
      AnimGBSequence(GetRelativePrefabEntity(target, ".OuterDoors_Right"), "Close")
    end
    AudioPostEventOn(GetRelativePrefabEntity(target, ".OuterDoors_Left"), "Play_sfx_btlwrx_doorcls3b")
  end
  return 
end
Prefab_BeetleworxSpawner_Base_EmergencyTrigger = function(target, _EnterExit)
  local data = GetPrefabData(target)
  if (_EnterExit == "Enter") then
    if (data.EmergencyTrigger == 0) then
      Print(("__Function: Prefab_BeetleworxSpawner_Base_EmergencyTrigger, _EnterExit: " .. tostring(_EnterExit)))
    end
    data.EmergencyTrigger = 1
  elseif (_EnterExit == "Exit") then
    Print(("__Function: Prefab_BeetleworxSpawner_Base_EmergencyTrigger, _EnterExit: " .. tostring(_EnterExit)))
    data.EmergencyTrigger = 0
  end
  return 
end
Prefab_BeetleworxSpawner_Base_Trigger = function(target, _EnterExit)
  local data = GetPrefabData(target)
  if (_EnterExit == "Enter") then
    if (data.EntitiesInTrigger == 0) then
      Print(("__Function: Prefab_BeetleworxSpawner_Base_Trigger, _EnterExit: " .. tostring(_EnterExit)))
      Print("__SpawnerBase: Entity entered the trigger! Keeping doors open!")
      data.ClearToSpawn = 0
    end
    data.EntitiesInTrigger = 1
  elseif (_EnterExit == "Exit") then
    Print(("__Function: Prefab_BeetleworxSpawner_Base_Trigger, _EnterExit: " .. tostring(_EnterExit)))
    Print("__SpawnerBase: Entity exited the trigger! Checking to close doors!")
    data.EntitiesInTrigger = 0
    if (data.EntitiesInTrigger == 0) then
      if (data.DoorsRemainOpen == "False") then
        Print("__SpawnerBase: EntitiesInTrigger == 0! Closing Doors and deactivating trigger until the next spawn!")
        Disable(GetRelativePrefabEntity(target, ".DoorTrigger"))
        Prefab_BeetleworxSpawner_Base_Doors(target, "Close")
        data.ClearToSpawn = 1
        wait(2)
        Prefab_BeetleworxSpawner_Base_Spawn(target)
      end
    end
  end
  return 
end
Prefab_BeetleworxSpawner_Base_HackBoxPainted = function(target, _Painted, GlobalName, GlobalValue)
  Print(("__Function: Prefab_BeetleworxSpawner_Base_HackBoxPainted, _Painted: " .. tostring(_Painted)))
  local data = GetPrefabData(target)
  if (_Painted == "Painted") then
    if (GetGlobal(data.MachineStateGlobal) == 0) then
      if (data.SendOswaldToHackBoxWhenPainted == "True") then
        Print("__SpawnerBase: Sending Oswald to hack the box!")
        OswaldSetPathAction(GetRelativePrefabEntity(target, ".OswaldHackPatrolNode"))
      else
        Print("__SpawnerBase: Hack box painted! Oswald IS NOT set to hack this box automatically! Flip SendOswaldToHackBoxWhenPainted to True to have him do it!")
      end
      if (GlobalName == "NotSetUp") then
        EnableComponent(GetRelativePrefabEntity(data.HackboxBaseEntity, ".OswaldReprogramScreen"), "Hack")
        Enable(data.OswaldHintEntityGroupName)
        if (_Painted == "Thinned") then
          DisableComponent(GetRelativePrefabEntity(data.HackboxBaseEntity, ".OswaldReprogramScreen"), "Hack")
          Disable(data.OswaldHintEntityGroupName)
          OswaldStartFollowAction()
        end
      end
    end
  elseif (_Painted == "Thinned") then
    DisableComponent(GetRelativePrefabEntity(data.HackboxBaseEntity, ".OswaldReprogramScreen"), "Hack")
    Disable(data.OswaldHintEntityGroupName)
    OswaldStartFollowAction()
  end
  return 
end
Prefab_BeetleworxSpawner_Base_OswaldHackPatrolReached = function(target)
  Print("__Function: Prefab_BeetleworxSpawner_Base_OswaldHackPatrolReached")
  local data = GetPrefabData(target)
  if (GetName(_activator()) == GetName(GetOswaldAI())) then
    Print("__SpawnerBase: Oswald reached hint entity! Firing hack event!")
    local HackBoxScreen = GetRelativePrefabEntity(data.HackboxBaseEntity, ".OswaldReprogramScreen")
    Print(("__SpawnerBase: Will attempt to Hack Entity: " .. tostring(GetName(HackBoxScreen))))
    OswaldHackAction(HackBoxScreen)
    wait(0.10000000149011612)
    OswaldStartFollowAction()
    if (data.SpawnerActive == "True") then
      ForEachEntityInGroup(AI_SetPermanentTarget, data.EntityGroupNames[2], GetPlayer())
    else
      Print("__SpawnerBase: Hack box was painted when machine was disabled, dont set any perma-targets on mickey!")
      Print((("__SpawnerBase: Someone fired OnReachedPatrolNode that wasn't Oswald! Activator: " .. tostring(GetName(_activator()))) .. ", Is this intended?"))
    end
  else
    Print((("__SpawnerBase: Someone fired OnReachedPatrolNode that wasn't Oswald! Activator: " .. tostring(GetName(_activator()))) .. ", Is this intended?"))
  end
  return 
end
Prefab_BeetleworxSpawner_Base_HackBoxSuccess = function(target)
  Print("__Function: Prefab_BeetleworxSpawner_Base_HackSuccess")
  local data = GetPrefabData(target)
  OswaldAbortScriptedBehavior()
  Disable(data.OswaldHintEntityGroupName)
  if (data.SpawnerActive == "True") then
    if (data.EntityGroupNames[2] == "None") then
      Print("__SpawnerBase: EntityGroupNames[2] == None! Your beetleworx most definitely will not hack! Override this to the entity group name of your child prefab!")
      return 
    else
      Print("__SpawnerBase: FORCE HACKING ALL BEETLEWORX AND DISABLING SPAWNER!")
      data.SpawnerActive = "False"
      if (data.OnBoxHackedBark ~= "None") then
        while true do
          if (not (IsAnySequencePlaying() == true)) then
            break
          end
          wait(0.20000000298023224)
        end
        Print("__SpawnerBase: All clear to fire hacked sequence!")
        FireSequence(GetRelativePrefabEntity(target, ".Conversation"), data.OnBoxHackedBark)
      else
        Print("__SpawnerBase: OnBoxHackedBark is NOT DEFINED! No bark will play!")
      end
      ForEachEntityInGroup(AI_ClearTarget, data.EntityGroupNames[2])
      ForEachEntityInGroup(SetTargetTeam, data.EntityGroupNames[2], 3)
      data.SpawnerActive = "False"
      if (data.OnMachineDisabledFunction[1] ~= "None") then
        Print("__SpawnerBase: THE SPAWNER HAS BEEN DISABLED. FIRING END FUNCTION")
        Print((("__SpawnerBase: Firing Function: " .. tostring(data.OnMachineDisabledFunction[1])) .. " with override: Hacked"))
        FireThread(_G[data.OnMachineDisabledFunction[1]], target, "Hacked")
      else
        Print("__SpawnerBase: THE SPAWNER HAS BEEN DISABLED but OnMachineDisabledFunction[1] wasn't overridden! No function will fire!")
        if (data.MachineStateGlobal ~= "None") then
          if (GetGlobal(data.MachineStateGlobal) ~= -1) then
            if (data.OnBoxHackedBark ~= "None") then
              Print("__SpawnerBase: Firing OnBoxHackedBark Bark! Nothing should play if you have this set to once only.")
              Print("__SpawnerBase: If you want a separate bark for hacking the box after the machine has been disabled already, check if your MachineStateGlobal is > 0!")
              FireSequence(GetRelativePrefabEntity(target, ".Conversation"), data.OnBoxHackedBark)
            else
              Print("__SpawnerBase: OnBoxHackedBark is NOT DEFINED! No bark will play!")
              Print("__SpawnerBase: BOX WAS HACKED WHILE THE SPAWNER WAS DEACTIVE. If the player can get to this hackbox, the spawner should probably have been active first!")
              Print("__SpawnerBase: Activate this spawner if you want it to respond to the hackbox being hacked!")
              Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
            end
          else
            Print("__SpawnerBase: BOX WAS HACKED WHILE THE SPAWNER WAS DEACTIVE. If the player can get to this hackbox, the spawner should probably have been active first!")
            Print("__SpawnerBase: Activate this spawner if you want it to respond to the hackbox being hacked!")
            Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
          end
        else
          Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
        end
      end
    end
  elseif (data.MachineStateGlobal ~= "None") then
    if (GetGlobal(data.MachineStateGlobal) ~= -1) then
      if (data.OnBoxHackedBark ~= "None") then
        Print("__SpawnerBase: Firing OnBoxHackedBark Bark! Nothing should play if you have this set to once only.")
        Print("__SpawnerBase: If you want a separate bark for hacking the box after the machine has been disabled already, check if your MachineStateGlobal is > 0!")
        FireSequence(GetRelativePrefabEntity(target, ".Conversation"), data.OnBoxHackedBark)
      else
        Print("__SpawnerBase: OnBoxHackedBark is NOT DEFINED! No bark will play!")
        Print("__SpawnerBase: BOX WAS HACKED WHILE THE SPAWNER WAS DEACTIVE. If the player can get to this hackbox, the spawner should probably have been active first!")
        Print("__SpawnerBase: Activate this spawner if you want it to respond to the hackbox being hacked!")
        Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
      end
    else
      Print("__SpawnerBase: BOX WAS HACKED WHILE THE SPAWNER WAS DEACTIVE. If the player can get to this hackbox, the spawner should probably have been active first!")
      Print("__SpawnerBase: Activate this spawner if you want it to respond to the hackbox being hacked!")
      Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
    end
  else
    Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
  end
  return 
end
Prefab_BeetleworxSpawner_Base_OrbThinned = function(target)
  Print("__Function: Prefab_BeetleworxSpawner_Base_OrbThinned")
  local data = GetPrefabData(target)
  Print("__SpawnerBase: Machine is now disabled!")
  if (data.SpawnerActive == "True") then
    data.SpawnerActive = "False"
    DisableComponent(GetRelativePrefabEntity(data.HackboxBaseEntity, ".OswaldReprogramScreen"), "Hack")
    Disable(data.OswaldHintEntityGroupName)
    StartEmitters(GetRelativePrefabEntity(target, ".HackboxSmoke"))
    OswaldAbortScriptedBehavior()
    OswaldStartFollowAction()
    if (data.OnOrbThinnedBark ~= "None") then
      while true do
        if (not (IsAnySequencePlaying() == true)) then
          break
        end
        wait(0.20000000298023224)
      end
      Print("__SpawnerBase: All clear to fire thinned sequence!")
      FireSequence(GetRelativePrefabEntity(target, ".Conversation"), data.OnOrbThinnedBark)
    else
      Print("__SpawnerBase: OnOrbThinnedBark is NOT DEFINED! No bark will play!")
    end
    if (data.OnMachineDisabledFunction[2] == "Disable") then
      if (data.OnMachineDisabledFunction[1] ~= "None") then
        Print("__SpawnerBase: THE SPAWNER HAS BEEN DISABLED. FIRING END FUNCTION")
        Print(((("__SpawnerBase: Firing Function: " .. tostring(data.OnMachineDisabledFunction[1])) .. " with override: ") .. tostring(data.OnMachineDisabledFunction[2])))
        FireThread(_G[data.OnMachineDisabledFunction[1]], target, tostring(data.OnMachineDisabledFunction[2]))
      else
        Print("__SpawnerBase: THE SPAWNER HAS BEEN DISABLED but OnMachineDisabledFunction[1] wasn't overridden! No function will fire!")
        if (data.OnMachineDisabledFunction[2] == "DisableAndDeath") then
          Print("__SpawnerBase: WILL NOT FIRE ENDFUNCTION UNTIL ALL BWX ARE DESTROYED")
          if (data.MachineStateGlobal ~= "None") then
            if (GetGlobal(data.MachineStateGlobal) ~= -1) then
              if (GetGlobal(data.MachineStateGlobal) ~= 2) then
                if (data.OnOrbThinnedBark ~= "None") then
                  Print("__SpawnerBase: Firing OnOrbThinnedBark Bark! Nothing should play if you have this set to once only.")
                  Print("__SpawnerBase: If you want a separate bark for hacking the box after the machine has been disabled already, check if your MachineStateGlobal is > 0!")
                  FireSequence(GetRelativePrefabEntity(target, ".Conversation"), data.OnOrbThinnedBark)
                else
                  Print("__SpawnerBase: OnOrbThinnedBark is NOT DEFINED! No bark will play!")
                  Print("__SpawnerBase: ORB WAS THINNED WHILE IT WAS DEACTIVE OR FRIENDED?")
                  Print("__SpawnerBase: Activate this Spawner if you want it to respond to the Orb being thinned!")
                  Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
                end
              end
            else
              Print("__SpawnerBase: ORB WAS THINNED WHILE IT WAS DEACTIVE OR FRIENDED?")
              Print("__SpawnerBase: Activate this Spawner if you want it to respond to the Orb being thinned!")
              Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
            end
          else
            Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
          end
        end
      end
    end
    if (data.OnMachineDisabledFunction[2] == "DisableAndDeath") then
      Print("__SpawnerBase: WILL NOT FIRE ENDFUNCTION UNTIL ALL BWX ARE DESTROYED")
    end
  elseif (data.MachineStateGlobal ~= "None") then
    if (GetGlobal(data.MachineStateGlobal) ~= -1) then
      if (GetGlobal(data.MachineStateGlobal) ~= 2) then
        if (data.OnOrbThinnedBark ~= "None") then
          Print("__SpawnerBase: Firing OnOrbThinnedBark Bark! Nothing should play if you have this set to once only.")
          Print("__SpawnerBase: If you want a separate bark for hacking the box after the machine has been disabled already, check if your MachineStateGlobal is > 0!")
          FireSequence(GetRelativePrefabEntity(target, ".Conversation"), data.OnOrbThinnedBark)
        else
          Print("__SpawnerBase: OnOrbThinnedBark is NOT DEFINED! No bark will play!")
          Print("__SpawnerBase: ORB WAS THINNED WHILE IT WAS DEACTIVE OR FRIENDED?")
          Print("__SpawnerBase: Activate this Spawner if you want it to respond to the Orb being thinned!")
          Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
        end
      end
    else
      Print("__SpawnerBase: ORB WAS THINNED WHILE IT WAS DEACTIVE OR FRIENDED?")
      Print("__SpawnerBase: Activate this Spawner if you want it to respond to the Orb being thinned!")
      Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
    end
  else
    Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
  end
  return 
end
Prefab_BeetleworxSpawner_Base_ChangeState = function(target, _State)
  Print(("__Function: Prefab_BeetleworxSpawner_Base_ChangeState, _State: " .. tostring(_State)))
  local data = GetPrefabData(target)
  if (_State == "Hacked") then
    if (data.MachineStateGlobal ~= "None") then
      if (GetGlobal(data.MachineStateGlobal) == 0) then
        Print((("__SpawnerBase: Setting Global: " .. tostring(data.MachineStateGlobal)) .. " to HACKED (2)"))
        SetGlobal(data.MachineStateGlobal, 2)
      elseif (GetGlobal(data.MachineStateGlobal) == -1) then
        Print("__SpawnerBase: Attempting to set global to hacked when it was deactive! Did you cheat?")
      else
        Print("__SpawnerBase: We've already hacked or disabled! Not setting global to Hacked!")
        Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
        if (_State == "Thinned") then
          if (data.MachineStateGlobal ~= "None") then
            if (GetGlobal(data.MachineStateGlobal) == 0) then
              Print((("__SpawnerBase: Setting Global: " .. tostring(data.MachineStateGlobal)) .. " to DISABLED (1)"))
              SetGlobal(data.MachineStateGlobal, 1)
            elseif (GetGlobal(data.MachineStateGlobal) == -1) then
              Print("__SpawnerBase: Attempting to set global to disabled when it was deactive! Did you cheat?")
            else
              Print("__SpawnerBase: We've already hacked or disabled this machine! Not setting to Disabled.")
              Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
            end
          else
            Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
          end
        end
      end
    else
      Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
      if (_State == "Thinned") then
        if (data.MachineStateGlobal ~= "None") then
          if (GetGlobal(data.MachineStateGlobal) == 0) then
            Print((("__SpawnerBase: Setting Global: " .. tostring(data.MachineStateGlobal)) .. " to DISABLED (1)"))
            SetGlobal(data.MachineStateGlobal, 1)
          elseif (GetGlobal(data.MachineStateGlobal) == -1) then
            Print("__SpawnerBase: Attempting to set global to disabled when it was deactive! Did you cheat?")
          else
            Print("__SpawnerBase: We've already hacked or disabled this machine! Not setting to Disabled.")
            Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
          end
        else
          Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
        end
      end
    end
  elseif (_State == "Thinned") then
    if (data.MachineStateGlobal ~= "None") then
      if (GetGlobal(data.MachineStateGlobal) == 0) then
        Print((("__SpawnerBase: Setting Global: " .. tostring(data.MachineStateGlobal)) .. " to DISABLED (1)"))
        SetGlobal(data.MachineStateGlobal, 1)
      elseif (GetGlobal(data.MachineStateGlobal) == -1) then
        Print("__SpawnerBase: Attempting to set global to disabled when it was deactive! Did you cheat?")
      else
        Print("__SpawnerBase: We've already hacked or disabled this machine! Not setting to Disabled.")
        Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
      end
    else
      Print("__SpawnerBase: No Global assigned to this bwx machine! Is this intended?")
    end
  end
  if (data.CheckpointFunction[1] ~= "None") then
    if (data.CheckpointFunction[2] ~= "Param1") then
      Print(((("__Will fire checkpoint function: " .. tostring(data.CheckpointFunction[1])) .. " with Param1: ") .. tostring(data.CheckpointFunction[2])))
      FireThread(_G[data.CheckpointFunction[1]], data.CheckpointFunction[2])
    else
      Print(((("__Param1 not overriden! Will fire checkpoint function: " .. tostring(data.CheckpointFunction[1])) .. " with whatever invoked this function call: ") .. tostring(GetName(target))))
      FireThread(_G[data.CheckpointFunction[1]], target)
      Print("__No Checkpoint defined! Your global state probably wont save!")
    end
  else
    Print("__No Checkpoint defined! Your global state probably wont save!")
  end
  return 
end
Prefab_BeetleworxSpawner_Base_TogglePlayerCollision = function(target, _Toggle)
  Print(("__Function: Prefab_BeetleworxSpawner_Base_TogglePlayerCollision, _Toggle: " .. tostring(_Toggle)))
  if (_Toggle == "On") then
    Unhide(GetRelativePrefabEntity(target, ".PlayerCollision"))
  elseif (_Toggle == "Off") then
    Hide(GetRelativePrefabEntity(target, ".PlayerCollision"))
  end
  return 
end
Prefab_BeetleworxSpawner_Child_BeetleworxHandled = function(target, _How)
  Print(("__Function: Prefab_BeetleworxSpawner_Child_BeetleworxHandled, _How: " .. tostring(_How)))
  local ChildData = GetPrefabData(target)
  if (ChildData.BasePrefabMarkerEntityGroupName == "None") then
    Print("__SpawnerChild: BasePrefabMarkerEntityGroupName is None! Override this to guarentee a link to the base prefab!")
    Print("__SpawnerChild: The Base prefab will have no idea to spawn another bwx on death if this isnt overridden!")
    return 
  end
  local BaseData = GetPrefabData(ChildData.BasePrefabMarkerEntityGroupName)
  if (_How == "Death") then
    BaseData.BeetleworxNumSpawned[1] = (BaseData.BeetleworxNumSpawned[1] - 1)
    Print(("__SpawnerChild: NumBlotworxSpawned according to the BaseData: " .. tostring(BaseData.BeetleworxNumSpawned[1])))
    if (1 < BaseData.BeetleworxNumSpawned[2]) then
      Print("__SpawnerChild: SpawnerBase has more than one possible bwx to spawn! Setting unique entity group name to spawn the what we just destroyed")
      BaseData.LastUniqueEntityDestroyed = GetPropertyString(_self(), "EntityGroups", 2)
      Print(("__SpawnerChild: Set LastUniqueEntityDestroyed to: " .. tostring(BaseData.LastUniqueEntityDestroyed)))
    end
    if (BaseData.OnBwxKilledBark ~= "None") then
      if (BaseData.SpawnerActive == "True") then
        Print("__SpawnerChild: BWX KILLED! Firing OnBwxKilledBark")
        FireSequence(GetRelativePrefabEntity(ChildData.BasePrefabMarkerEntityGroupName, ".Conversation"), BaseData.OnBwxKilledBark)
      end
    else
      Print("__SpawnerChild: BWX KILLED! OnBwxKilledBark NOT DEFINED! No bark will play!")
    end
    if (BaseData.BeetleworxNumSpawned[1] == 0) then
      if (GetGlobal(BaseData.MachineStateGlobal) ~= 2) then
        if (BaseData.SpawnerActive == "False") then
          if (BaseData.OnMachineDisabledFunction[2] == "DisableAndDeath") then
            if (BaseData.OnMachineDisabledFunction[1] ~= "None") then
              Print("__SpawnerChild: THE SPAWNER HAS BEEN DISABLED AND THERE ARE NO REMAINING BWX. WE'VE KILLED EVERYTHING. FIRING END FUNCTION")
              Print(((("__SpawnerChild: Firing Function: " .. tostring(BaseData.OnMachineDisabledFunction[1])) .. " with override: ") .. tostring(BaseData.OnMachineDisabledFunction[2])))
              FireThread(_G[BaseData.OnMachineDisabledFunction[1]], tostring(ChildData.BasePrefabMarkerEntityGroupName), tostring(BaseData.OnMachineDisabledFunction[2]))
            else
              Print("__SpawnerChild: THE SPAWNER HAS BEEN DISABLED AND THERE ARE NO REMAINING BWX, but OnMachineDisabledFunction[1] wasn't overridden! No function will fire!")
            end
          end
        end
      end
    end
    Prefab_BeetleworxSpawner_Base_Spawn(ChildData.BasePrefabMarkerEntityGroupName)
  elseif (_How == "Hack") then
    if (BaseData.BeetleworxNumSpawned[1] == BaseData.BeetleworxNumSpawned[2]) then
      Print("__SpawnerChild: All BWX are spawned!")
      local Hacked = 0
      local (for index), (for limit), (for step) = 1, BaseData.BeetleworxNumSpawned[1], 1
      for x = (for index), (for limit), (for step) do
        if (GetCurrentTeam(tostring((BaseData.EntityGroupName[2] .. tostring(x)))) == 3) then
          Hacked = (Hacked + 1)
        end
      end
      Print(((("__Hacked Bwx: " .. tostring(Hacked)) .. ", NumBWXSpawned: ") .. tostring(BaseData.BeetleworxNumSpawned[1])))
      if (Hacked == BaseData.BeetleworxNumSpawned[1]) then
        if (BaseData.OnALLBwxHackedBark ~= "None") then
          Print("__SpawnerChild: ALL BWX HACKED! Firing OnALLBwxHackedBark")
          FireSequence(GetRelativePrefabEntity(ChildData.BasePrefabMarkerEntityGroupName, ".Conversation"), BaseData.OnALLBwxHackedBark)
        else
          Print("__SpawnerChild: ALL BWX HACKED! OnALLBwxHackedBark NOT DEFINED! No bark will play!")
          if (BaseData.OnBwxHackedBark ~= "None") then
            Print("__SpawnerChild: BWX Hacked! Firing OnBwxHackedBark")
            FireSequence(GetRelativePrefabEntity(ChildData.BasePrefabMarkerEntityGroupName, ".Conversation"), BaseData.OnBwxHackedBark)
          else
            Print("__SpawnerChild: BWX Hacked! OnBwxHackedBark NOT DEFINED! No Bark will play!")
          end
        end
      end
    elseif (BaseData.OnBwxHackedBark ~= "None") then
      Print("__SpawnerChild: BWX Hacked! Firing OnBwxHackedBark")
      FireSequence(GetRelativePrefabEntity(ChildData.BasePrefabMarkerEntityGroupName, ".Conversation"), BaseData.OnBwxHackedBark)
    else
      Print("__SpawnerChild: BWX Hacked! OnBwxHackedBark NOT DEFINED! No Bark will play!")
    end
  end
  return 
end
