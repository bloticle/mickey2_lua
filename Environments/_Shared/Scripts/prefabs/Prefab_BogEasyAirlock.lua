Prefab_BogEasyAirlock_AlwaysSetup = function(target)
  Print("__Function: Prefab_BogEasyAirlock_AlwaysSetup")
  if (string.sub(LevelManager_GetCurrentState(), 13, 13) == "l") then
    Print("__LOADING INTO LOUIS SHACK, OPENING DOORS ON LOUIS SIDE!")
    Prefab_BogEasyAirlock_SwitchState(target, "LouisShack")
    SetPropertyBool("Airlock_Gator_Lookat", "Look At Trigger Enabled", true)
  elseif (string.sub(LevelManager_GetCurrentState(), 13, 13) == "o") then
    Print("__LOADING INTO OLDTOWN, OPENING DOORS ON THAT SIDE!")
    Prefab_BogEasyAirlock_SwitchState(target, "OldTown")
    SetPropertyInt(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide"), "Collision Layer", 13)
    SetPropertyInt(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide2"), "Collision Layer", 13)
    wait(3)
    SetPropertyInt(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide"), "Collision Layer", 2)
    SetPropertyInt(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide2"), "Collision Layer", 2)
    SetPropertyBool("Airlock_Gator_Lookat", "Look At Trigger Enabled", true)
  else
    Print("__We're in shanty town!")
    SetPropertyBool("Airlock_Gator_Lookat", "Look At Trigger Enabled", false)
    Prefab_BogEasyAirlock_EntityHide(nil, "Hide")
  end
  return 
end
Prefab_BogEasyAirlock_EntityHide = function(target, _Hidden)
  Print(("__Function: Prefab_BogEasyAirlock_EntityHide, _Hidden: " .. tostring(_Hidden)))
  target = "BogEasy_Airlock"
  if (_Hidden == "Hide") then
    Hide("Airlock_Building")
    Hide(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide"))
    Hide(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide"))
    Hide(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide2"))
    Hide(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide2"))
  elseif (_Hidden == "Unhide") then
    Unhide("Airlock_Building")
    Unhide(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide"))
    Unhide(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide"))
    Unhide(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide2"))
    Unhide(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide2"))
  end
  return 
end
Prefab_BogEasyAirlock_GatorLookatTrigger = function(target, _Direction)
  Print(("__Function: Prefab_BogEasyAirlock_GatorLookatTrigger, _Direction: " .. tostring(_Direction)))
  local data = GetPrefabData("BogEasy_Airlock")
  if (_Direction == "At") then
    if (GetName(_activator()) == GetName(GetPlayer())) then
      data.LookingAtGators[1] = 1
      if (data.LookingAtGators[2] == 1) then
        Print("__Oswald already looking at gators!")
        return 
      end
      Print("__Starting gator anims!")
      local (for index), (for limit), (for step) = 1, 4, 1
      for x = (for index), (for limit), (for step) do
        Unhide(("Airlock_Gator 0" .. tostring(x)))
        AnimGBSequence(("Airlock_Gator 0" .. tostring(x)), ("gator" .. tostring(x)))
      end
    else
      data.LookingAtGators[2] = 1
      if (data.LookingAtGators[1] == 1) then
        Print("__Mickey already looking at gators!")
        return 
      end
      Print("__Starting gator anims!")
      local (for index), (for limit), (for step) = 1, 4, 1
      for x = (for index), (for limit), (for step) do
        (for index) = Unhide
        (for limit) = "Airlock_Gator 0"
        (for step) = tostring
        x = x
        (for step) = (for step)(x)
        (for limit) = ((for limit) .. (for step))
        (for index)((for limit))
        (for index) = AnimGBSequence
        (for limit) = "Airlock_Gator 0"
        (for step) = tostring
        x = x
        (for step) = (for step)(x)
        (for limit) = ((for limit) .. (for step))
        (for step) = "gator"
        x = tostring
        x = x(x)
        (for step) = ((for step) .. x)
        (for index)((for limit), (for step))
      end
      if (_Direction == "Away") then
        if (GetName(_activator()) == GetName(GetPlayer())) then
          data.LookingAtGators[1] = 0
          if (data.LookingAtGators[2] == 0) then
            Print("__Oswald not looking either! Hiding!")
            local (for index), (for limit), (for step) = 1, 4, 1
            for x = (for index), (for limit), (for step) do
              Hide(("Airlock_Gator 0" .. tostring(x)))
              AnimGBSequence(("Airlock_Gator 0" .. tostring(x)), "idle")
            end
          else
            Print("__Oswald still looking!")
            return 
            Print("__Mickey not looking either! Hiding!")
            local (for index), (for limit), (for step) = 1, 4, 1
            for x = (for index), (for limit), (for step) do
              Hide(("Airlock_Gator 0" .. tostring(x)))
              AnimGBSequence(("Airlock_Gator 0" .. tostring(x)), "idle")
            end
            Print("__Oswald still looking!")
            return 
          end
        else
          data.LookingAtGators[2] = 0
          if (data.LookingAtGators[1] == 0) then
            Print("__Mickey not looking either! Hiding!")
            local (for index), (for limit), (for step) = 1, 4, 1
            for x = (for index), (for limit), (for step) do
              Hide(("Airlock_Gator 0" .. tostring(x)))
              AnimGBSequence(("Airlock_Gator 0" .. tostring(x)), "idle")
            end
          else
            Print("__Oswald still looking!")
            return 
          end
        end
      end
    end
  elseif (_Direction == "Away") then
    if (GetName(_activator()) == GetName(GetPlayer())) then
      data.LookingAtGators[1] = 0
      if (data.LookingAtGators[2] == 0) then
        Print("__Oswald not looking either! Hiding!")
        local (for index), (for limit), (for step) = 1, 4, 1
        for x = (for index), (for limit), (for step) do
          Hide(("Airlock_Gator 0" .. tostring(x)))
          AnimGBSequence(("Airlock_Gator 0" .. tostring(x)), "idle")
        end
      else
        Print("__Oswald still looking!")
        return 
        Print("__Mickey not looking either! Hiding!")
        local (for index), (for limit), (for step) = 1, 4, 1
        for x = (for index), (for limit), (for step) do
          Hide(("Airlock_Gator 0" .. tostring(x)))
          AnimGBSequence(("Airlock_Gator 0" .. tostring(x)), "idle")
        end
        Print("__Oswald still looking!")
        return 
      end
    else
      data.LookingAtGators[2] = 0
      if (data.LookingAtGators[1] == 0) then
        Print("__Mickey not looking either! Hiding!")
        local (for index), (for limit), (for step) = 1, 4, 1
        for x = (for index), (for limit), (for step) do
          Hide(("Airlock_Gator 0" .. tostring(x)))
          AnimGBSequence(("Airlock_Gator 0" .. tostring(x)), "idle")
        end
      else
        Print("__Oswald still looking!")
        return 
      end
    end
  end
  Print(((("__GatorLookAtState: [1]: " .. tostring(data.LookingAtGators[1])) .. ", [2]: ") .. tostring(data.LookingAtGators[2])))
  return 
end
Prefab_BogEasyAirlock_Doors = function(target, _Which, _LeverNum)
  Print(((("__Function: Prefab_BogEasyAirlock_Doors, _Which: " .. tostring(_Which)) .. ", _LeverNum: ") .. tostring(_LeverNum)))
  target = "BogEasy_Airlock"
  local data = GetPrefabData(target)
  if (data.DoorsBusy == 0) then
    data.DoorsBusy = 1
    Disable("AirlockJump1")
    Disable("AirlockJump2")
    if (_Which == "LouisShack") then
      Print((("__Setting LouisShackSwitchState[" .. tonumber(_LeverNum)) .. "] to 1!"))
      data.LouisShackSwitchState[tonumber(_LeverNum)] = 1
      if (data.LouisShackSwitchState[1] == 1) then
        if (data.LouisShackSwitchState[2] == 1) then
          Print("__Both LouisShackSwitchState values 1! Closing OldTown doors!!")
          data.AirlockState = "Airlock"
          Prefab_FireworksManager_StreamZoneOut("FireworksManager", "B")
          data.RespawnTriggerOverride[1] = 2
          data.RespawnTriggerOverride[2] = 2
          Prefab_BogEasyAirlock_OverrideSpawnLocations(target)
          Prefab_BlotAlleyAirlock_HandleSwitchAvailability(nil, "Streaming")
          AnimGBSequence(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide"), "close")
          AnimGBSequence(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide2"), "close")
          AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_Doors_Airlock_OldTown", "Play_sfx_AirlockDoors_Close")
          wait(1.5)
          AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_Airlock", "Mix_sfx_amb_airlock_in")
          AudioPostEventOn("nos_bogeasy_01a_whirlpool_audio.Snd_Whirlpool", "Stop_sfx_Steamboat_Whirlpool_Lp")
          AudioPostEventOn("nos_bogeasy_01a_whirlpool_audio.Snd_Ferry", "Stop_sfx_Steamboat_Engine_Lp")
          AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_2D_Amb_Start", "Play_sfx_amb_bogeasy_swamp")
          if (GetGlobal("NOS_BogEasy_FirstVisit") == 1) then
            LevelManager_SetCurrentState("nos_bogeasy.louisshack_v1")
          else
            LevelManager_SetCurrentState("nos_bogeasy.louisshack_v2")
          end
          AnimGBSequence(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide"), "rumble")
          AnimGBSequence(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide2"), "rumble")
          Print("__Waiting for stream to finish!")
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
          Prefab_FireworksManager_StreamZoneIn("FireworksManager", "A")
          Prefab_BlotAlleyAirlock_HandleSwitchAvailability(nil, "LouisShack")
          data.AirlockState = "LouisShack"
          Prefab_BogEasyAirlock_OverrideSpawnLocations(target)
          AnimGBSequence(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide"), "open")
          AnimGBSequence(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide2"), "open")
          AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_Doors_Airlock_LouisShack", "Play_sfx_AirlockDoors_Open")
          AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_Airlock", "Mix_sfx_amb_airlock_out")
          AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_2D_Amb_Start", "Play_bogeasy_thinner_river_2D")
          if (GetGlobal("NOS_BogEasy_FirstVisit") == 0) then
            Prefab_BunniesForBunnyHat_PlaceBunniesInSection(nil, "LouisShack")
          end
          NOS_BogEasy_SaveCheckpoint("CHECKPOINT_LouisShack_Airlock")
        end
      end
    elseif (_Which == "OldTown") then
      Print((("__Setting OldTownSwitchState[" .. tonumber(_LeverNum)) .. "] to 1!"))
      data.OldTownSwitchState[tonumber(_LeverNum)] = 1
      if (data.OldTownSwitchState[1] == 1) then
        if (data.OldTownSwitchState[2] == 1) then
          Print("__Both OldTownSwitchState values 1! Closing Louis Shack doors!!")
          data.AirlockState = "Airlock"
          Prefab_FireworksManager_StreamZoneOut("FireworksManager", "A")
          data.RespawnTriggerOverride[1] = 1
          data.RespawnTriggerOverride[2] = 1
          Prefab_BogEasyAirlock_OverrideSpawnLocations(target)
          Prefab_BlotAlleyAirlock_HandleSwitchAvailability(nil, "Streaming")
          AnimGBSequence(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide"), "close")
          AnimGBSequence(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide2"), "close")
          AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_Doors_Airlock_LouisShack", "Play_sfx_AirlockDoors_Close")
          wait(1.5)
          AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_Airlock", "Mix_sfx_amb_airlock_in")
          AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_2D_Amb_Start", "Stop_bogeasy_thinner_river_2D")
          if (GetGlobal("NOS_BogEasy_FirstVisit") == 1) then
            LevelManager_SetCurrentState("nos_bogeasy.oldtown_v1")
          else
            LevelManager_SetCurrentState("nos_bogeasy.oldtown_v2")
          end
          AnimGBSequence(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide"), "rumble")
          AnimGBSequence(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide2"), "rumble")
          Print("__Waiting for stream to finish!")
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
          Prefab_FireworksManager_StreamZoneIn("FireworksManager", "B")
          Prefab_BlotAlleyAirlock_HandleSwitchAvailability(nil, "OldTown")
          data.AirlockState = "OldTown"
          Prefab_BogEasyAirlock_OverrideSpawnLocations(target)
          AnimGBSequence(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide"), "open")
          AnimGBSequence(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide2"), "open")
          AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_Doors_Airlock_OldTown", "Play_sfx_AirlockDoors_Open")
          AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_Airlock", "Mix_sfx_amb_airlock_out")
          AudioPostEventOn("nos_bogeasy_01a_whirlpool_audio.Snd_Whirlpool", "Play_sfx_Steamboat_Whirlpool_Lp")
          AudioPostEventOn("nos_bogeasy_01a_whirlpool_audio.Snd_Ferry", "Play_sfx_Steamboat_Engine_Lp")
          AudioPostEventOn("nos_bogeasy_01a_main_audio.Snd_2D_Amb_Start", "Play_sfx_amb_bogeasy_edge")
          if (GetGlobal("NOS_BogEasy_FirstVisit") == 0) then
            Prefab_BunniesForBunnyHat_PlaceBunniesInSection(nil, "OldTown")
          end
          NOS_BogEasy_SaveCheckpoint("CHECKPOINT_OldTown_Airlock")
        end
      end
    else
      Print(("Hoa? What airlock state are we in? " .. tostring(data.AirlockState)))
    end
    data.DoorsBusy = 0
    Enable("AirlockJump1")
    Enable("AirlockJump2")
  else
    Print("__Doors are currently busy! Pulling this switch won't do anything!")
  end
  return 
end
Prefab_BogEasyAirlock_SwitchEndTouch = function(target, _Which, _LeverNum)
  Print(((("__Function: Prefab_BogEasyAirlock_SwitchEndTouch, _Which: " .. tostring(_Which)) .. ", _LeverNum: ") .. tostring(_LeverNum)))
  local data = GetPrefabData("BogEasy_Airlock")
  if (_Which == "LouisShack") then
    Print((("__Setting LouisShackSwitchState[" .. tostring(_LeverNum)) .. "] to 0!"))
    data.LouisShackSwitchState[tonumber(_LeverNum)] = 0
  elseif (_Which == "OldTown") then
    Print((("__Setting OldTownSwitchState[" .. tostring(_LeverNum)) .. "] to 0!"))
    data.OldTownSwitchState[tonumber(_LeverNum)] = 0
  end
  return 
end
Prefab_BogEasyAirlock_SwitchGrabbed = function(target, _Switch, _On)
  Print(((("__Function: Prefab_BogEasyAirlock_SwitchGrabbed, _Switch: " .. tostring(_Switch)) .. ", _On: ") .. tostring(_On)))
  if (GetName(GetPlayer()) ~= GetName(target)) then
    target = GetPlayer2OrAI()
  end
  if (_On == "On") then
    if (_Switch == "1") then
      SetCameraAttributesForPlayer(GetRelativePrefabEntity("BogEasy_Airlock", ".LouisShackCamera_Override"), target)
    end
    if (_Switch == "3") then
      SetCameraAttributesForPlayer(GetRelativePrefabEntity("BogEasy_Airlock", ".OldTownCamera_Override"), target)
      ClearCameraAttributesForPlayer(GetRelativePrefabEntity("BogEasy_Airlock", ".LouisShackCamera_Override"), target)
      ClearCameraAttributesForPlayer(GetRelativePrefabEntity("BogEasy_Airlock", ".OldTownCamera_Override"), target)
    end
  else
    ClearCameraAttributesForPlayer(GetRelativePrefabEntity("BogEasy_Airlock", ".LouisShackCamera_Override"), target)
    ClearCameraAttributesForPlayer(GetRelativePrefabEntity("BogEasy_Airlock", ".OldTownCamera_Override"), target)
  end
  return 
end
Prefab_BlotAlleyAirlock_HandleSwitchAvailability = function(target, _State)
  Print(("__Function: Prefab_BlotAlleyAirlock_HandleSwitchAvailability, _State: " .. tostring(_State)))
  if (_State == "LouisShack") then
    SetPropertyFloat("AirlockHandle1", "UsableRadius", 0)
    SetPropertyFloat("AirlockHandle2", "UsableRadius", 0)
    SetPropertyFloat("AirlockHandle3", "UsableRadius", 2)
    SetPropertyFloat("AirlockHandle4", "UsableRadius", 2)
  elseif (_State == "OldTown") then
    SetPropertyFloat("AirlockHandle1", "UsableRadius", 2)
    SetPropertyFloat("AirlockHandle2", "UsableRadius", 2)
    SetPropertyFloat("AirlockHandle3", "UsableRadius", 0)
    SetPropertyFloat("AirlockHandle4", "UsableRadius", 0)
  elseif (_State == "Streaming") then
    SetPropertyFloat("AirlockHandle1", "UsableRadius", 0)
    SetPropertyFloat("AirlockHandle2", "UsableRadius", 0)
    SetPropertyFloat("AirlockHandle3", "UsableRadius", 0)
    SetPropertyFloat("AirlockHandle4", "UsableRadius", 0)
  end
  return 
end
Prefab_BogEasyAirlock_SwitchState = function(target, _State)
  Print(("__Function: Prefab_BogEasyAirlock_SwitchState, _State: " .. tostring(_State)))
  local data = GetPrefabData(target)
  data.AirlockState = _State
  if (_State == "LouisShack") then
    AnimGBSequence(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide"), "open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide2"), "open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide2"), "close")
    Prefab_FireworksManager_SetCurrentZone("FireworksManager", "A")
    SetPropertyBool("Airlock_Gator_Lookat", "Look At Trigger Enabled", true)
    Prefab_BlotAlleyAirlock_HandleSwitchAvailability(nil, "LouisShack")
    Prefab_BogEasyAirlock_EntityHide(nil, "Unhide")
  elseif (_State == "OldTown") then
    AnimGBSequence(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide"), "open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Door_OldTown_AirlockSide2"), "open")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide"), "close")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Door_LouisShack_AirlockSide2"), "close")
    Prefab_FireworksManager_SetCurrentZone("FireworksManager", "B")
    SetPropertyBool("Airlock_Gator_Lookat", "Look At Trigger Enabled", true)
    Prefab_BlotAlleyAirlock_HandleSwitchAvailability(nil, "OldTown")
    Prefab_BogEasyAirlock_EntityHide(nil, "Unhide")
  end
  Print(("__New Airlock state: " .. tostring(data.AirlockState)))
  return 
end
Prefab_BogEasyAirlock_RespawnTriggerOverride = function(target, _Which)
  Print(("__Function: Prefab_BogEasyAirlock_RespawnTriggerOverride, _Which: " .. tostring(_Which)))
  local data = GetPrefabData("BogEasy_Airlock")
  if (_Which == "LouisShack") then
    if (GetName(_activator()) == GetName(GetPlayer())) then
      Print("__Overridding Mickey to LouisShack respawn marker!")
      data.RespawnTriggerOverride[1] = 1
    else
      Print("__Overridding Oswald to LouisShack respawn marker!")
      data.RespawnTriggerOverride[2] = 1
      if (_Which == "OldTown") then
        if (GetName(_activator()) == GetName(GetPlayer())) then
          Print("__Overridding Mickey to OldTown respawn marker!")
          data.RespawnTriggerOverride[1] = 2
        else
          Print("__Overridding Oswald to OldTown respawn marker!")
          data.RespawnTriggerOverride[2] = 2
        end
      end
    end
  elseif (_Which == "OldTown") then
    if (GetName(_activator()) == GetName(GetPlayer())) then
      Print("__Overridding Mickey to OldTown respawn marker!")
      data.RespawnTriggerOverride[1] = 2
    else
      Print("__Overridding Oswald to OldTown respawn marker!")
      data.RespawnTriggerOverride[2] = 2
    end
  end
  Prefab_BogEasyAirlock_OverrideSpawnLocations("BogEasy_Airlock")
  return 
end
Prefab_BogEasyAirlock_OverrideSpawnLocations = function(target)
  Print("__Function: Prefab_BogEasyAirlock_OverrideSpawnLocations")
  local data = GetPrefabData(target)
  if (data.AirlockState == "Airlock") then
    Print("__Setting respawn overrides")
    local Mickey = data.RespawnTriggerOverride[1]
    local Oswald = data.RespawnTriggerOverride[2]
    if (Mickey == 1) then
      OverrideSpawnTransform(PLAYER_ONE, GetPosition("Airlock_RespawnOverride_LouisShack"), GetFacing("Airlock_RespawnOverride_LouisShack"))
    elseif (Mickey == 2) then
      OverrideSpawnTransform(PLAYER_ONE, GetPosition("Airlock_RespawnOverride_OldTown"), GetFacing("Airlock_RespawnOverride_OldTown"))
    end
    if (Oswald == 1) then
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("Airlock_RespawnOverride_LouisShack"), GetFacing("Airlock_RespawnOverride_LouisShack"))
    elseif (Oswald == 2) then
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("Airlock_RespawnOverride_OldTown"), GetFacing("Airlock_RespawnOverride_OldTown"))
      Print("__Clearing respawn overrides")
      ClearOverrideSpawnTransform(PLAYER_ONE)
      ClearOverrideSpawnTransform(PLAYER_TWO)
    end
  else
    Print("__Clearing respawn overrides")
    ClearOverrideSpawnTransform(PLAYER_ONE)
    ClearOverrideSpawnTransform(PLAYER_TWO)
  end
  return 
end
