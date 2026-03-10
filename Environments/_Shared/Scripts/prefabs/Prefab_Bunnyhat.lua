NOS_BogEasy_BunnyHatsInitialSetup = function(target)
  Print("__Function: NOS_BogEasy_BunnyHatsInitialSetup")
  return 
end
Prefab_BunnyHat_AlwaysSetup = function(target)
  Print("__Function: Prefab_BunnyHat_AlwaysSetup")
  local data = GetPrefabData(target)
  if (data.ThisBunnyHatGlobal == "None") then
    Print("__Didn't assign global to this bunny hat!")
  elseif (data.ThisBunnyHatGlobal == "Interior") then
    Print("__This is the interior bunny hat!")
    DestroyEntity(GetRelativePrefabEntity(target, ".HideBunnyTrigger"))
  elseif (GetGlobal(data.ThisBunnyHatGlobal) ~= 0) then
    Print("__This bunny hat was broken, destroying everything!")
    Print(("__Bunny Hat: " .. tostring(string.sub(data.ThisBunnyHatGlobal, -7, -7))))
    ForEachEntityInPrefab(DestroyEntity, ("BunnyHatBreakable0" .. tostring(string.sub(data.ThisBunnyHatGlobal, -7, -7))))
    ForEachEntityInPrefab(DestroyEntity, target)
  end
  return 
end
Prefab_BunniesForBunnyHat_AlwaysSetup = function(target)
  Print("__Function: Prefab_BunniesForBunnyHat_AlwaysSetup")
  AnimVarInt("Bunny_01", VAR_NPC_State, 2)
  AnimVarInt("Bunny_02", VAR_NPC_State, 2)
  if (LevelManager_GetCurrentState() == "nos_bogeasy.shantytown_v2") then
    Print("__Bunny hats say we're in shanty town v2!")
    Prefab_BunniesForBunnyHat_PlaceBunniesInSection(nil, "ShantyTown")
  elseif (LevelManager_GetCurrentState() == "nos_bogeasy.louisshack_v2") then
    Print("__Bunny hats say we're in louisshack v2!")
    Prefab_BunniesForBunnyHat_PlaceBunniesInSection(nil, "LouisShack")
  elseif (LevelManager_GetCurrentState() == "nos_bogeasy.oldtown_v2") then
    Print("__Bunny hats say we're in oldtown v2!")
    Prefab_BunniesForBunnyHat_PlaceBunniesInSection(nil, "OldTown")
  end
  return 
end
Prefab_BunniesForBunnyHat_PlaceBunniesInSection = function(target, _Section)
  Print(("__Function: Prefab_BunniesForBunnyHat_PlaceBunniesInSection, _Section: " .. tostring(_Section)))
  local data = GetPrefabData("Bunny_01")
  data.BunniesSeen = 0
  if (_Section == "ShantyTown") then
    if (GetGlobal("NOS_BogEasy_BunnyHat5Broken") == 0) then
      TeleportToEntity("Bunny_01", "BunnyHat5Marker")
      AnimVarInt("Bunny_01", VAR_NPC_State, 2)
      AnimEvent("Bunny_01", EVENT_Special_1)
      Unhide("Bunny_01")
    else
      Hide("Bunny_01")
    end
    if (GetGlobal("NOS_BogEasy_BunnyHat6Broken") == 0) then
      TeleportToEntity("Bunny_02", "BunnyHat6Marker")
      AnimVarInt("Bunny_02", VAR_NPC_State, 2)
      AnimEvent("Bunny_02", EVENT_Special_1)
      Unhide("Bunny_02")
    else
      Hide("Bunny_02")
      if (_Section == "LouisShack") then
        if (GetGlobal("NOS_BogEasy_BunnyHat1Broken") == 0) then
          TeleportToEntity("Bunny_01", "BunnyHat1Marker")
          AnimVarInt("Bunny_01", VAR_NPC_State, 2)
          AnimEvent("Bunny_01", EVENT_Special_1)
          Unhide("Bunny_01")
        else
          Hide("Bunny_01")
        end
        if (GetGlobal("NOS_BogEasy_BunnyHat2Broken") == 0) then
          TeleportToEntity("Bunny_02", "BunnyHat2Marker")
          AnimVarInt("Bunny_02", VAR_NPC_State, 2)
          AnimEvent("Bunny_02", EVENT_Special_1)
          Unhide("Bunny_02")
        else
          Hide("Bunny_02")
          if (_Section == "OldTown") then
            if (GetGlobal("NOS_BogEasy_BunnyHat3Broken") == 0) then
              TeleportToEntity("Bunny_01", "BunnyHat3Marker")
              AnimVarInt("Bunny_01", VAR_NPC_State, 2)
              AnimEvent("Bunny_01", EVENT_Special_1)
              Unhide("Bunny_01")
            else
              Hide("Bunny_01")
            end
            if (GetGlobal("NOS_BogEasy_BunnyHat4Broken") == 0) then
              TeleportToEntity("Bunny_02", "BunnyHat4Marker")
              AnimVarInt("Bunny_02", VAR_NPC_State, 2)
              AnimEvent("Bunny_02", EVENT_Special_1)
              Unhide("Bunny_02")
            else
              Hide("Bunny_02")
              Print(("__Where are bunnies trying to be spawned?? Section: " .. tostring(_Section)))
            end
          else
            Print(("__Where are bunnies trying to be spawned?? Section: " .. tostring(_Section)))
          end
        end
      elseif (_Section == "OldTown") then
        if (GetGlobal("NOS_BogEasy_BunnyHat3Broken") == 0) then
          TeleportToEntity("Bunny_01", "BunnyHat3Marker")
          AnimVarInt("Bunny_01", VAR_NPC_State, 2)
          AnimEvent("Bunny_01", EVENT_Special_1)
          Unhide("Bunny_01")
        else
          Hide("Bunny_01")
        end
        if (GetGlobal("NOS_BogEasy_BunnyHat4Broken") == 0) then
          TeleportToEntity("Bunny_02", "BunnyHat4Marker")
          AnimVarInt("Bunny_02", VAR_NPC_State, 2)
          AnimEvent("Bunny_02", EVENT_Special_1)
          Unhide("Bunny_02")
        else
          Hide("Bunny_02")
          Print(("__Where are bunnies trying to be spawned?? Section: " .. tostring(_Section)))
        end
      else
        Print(("__Where are bunnies trying to be spawned?? Section: " .. tostring(_Section)))
      end
    end
  elseif (_Section == "LouisShack") then
    if (GetGlobal("NOS_BogEasy_BunnyHat1Broken") == 0) then
      TeleportToEntity("Bunny_01", "BunnyHat1Marker")
      AnimVarInt("Bunny_01", VAR_NPC_State, 2)
      AnimEvent("Bunny_01", EVENT_Special_1)
      Unhide("Bunny_01")
    else
      Hide("Bunny_01")
    end
    if (GetGlobal("NOS_BogEasy_BunnyHat2Broken") == 0) then
      TeleportToEntity("Bunny_02", "BunnyHat2Marker")
      AnimVarInt("Bunny_02", VAR_NPC_State, 2)
      AnimEvent("Bunny_02", EVENT_Special_1)
      Unhide("Bunny_02")
    else
      Hide("Bunny_02")
      if (_Section == "OldTown") then
        if (GetGlobal("NOS_BogEasy_BunnyHat3Broken") == 0) then
          TeleportToEntity("Bunny_01", "BunnyHat3Marker")
          AnimVarInt("Bunny_01", VAR_NPC_State, 2)
          AnimEvent("Bunny_01", EVENT_Special_1)
          Unhide("Bunny_01")
        else
          Hide("Bunny_01")
        end
        if (GetGlobal("NOS_BogEasy_BunnyHat4Broken") == 0) then
          TeleportToEntity("Bunny_02", "BunnyHat4Marker")
          AnimVarInt("Bunny_02", VAR_NPC_State, 2)
          AnimEvent("Bunny_02", EVENT_Special_1)
          Unhide("Bunny_02")
        else
          Hide("Bunny_02")
          Print(("__Where are bunnies trying to be spawned?? Section: " .. tostring(_Section)))
        end
      else
        Print(("__Where are bunnies trying to be spawned?? Section: " .. tostring(_Section)))
      end
    end
  elseif (_Section == "OldTown") then
    if (GetGlobal("NOS_BogEasy_BunnyHat3Broken") == 0) then
      TeleportToEntity("Bunny_01", "BunnyHat3Marker")
      AnimVarInt("Bunny_01", VAR_NPC_State, 2)
      AnimEvent("Bunny_01", EVENT_Special_1)
      Unhide("Bunny_01")
    else
      Hide("Bunny_01")
    end
    if (GetGlobal("NOS_BogEasy_BunnyHat4Broken") == 0) then
      TeleportToEntity("Bunny_02", "BunnyHat4Marker")
      AnimVarInt("Bunny_02", VAR_NPC_State, 2)
      AnimEvent("Bunny_02", EVENT_Special_1)
      Unhide("Bunny_02")
    else
      Hide("Bunny_02")
      Print(("__Where are bunnies trying to be spawned?? Section: " .. tostring(_Section)))
    end
  else
    Print(("__Where are bunnies trying to be spawned?? Section: " .. tostring(_Section)))
  end
  return 
end
Prefab_BunnyHat_LookAt = function(target, _Direction)
  Print(("__Function: Prefab_BunnyHat_LookAt, _Direction: " .. tostring(_Direction)))
  local data = GetPrefabData("Bunny_01")
  if (_Direction == "At") then
    AnimEvent(GetPrefabData(target).TeleportedBunnyEntityGroupName, EVENT_Special_0)
    data.BunniesSeen = (data.BunniesSeen + 1)
  elseif (_Direction == "Away") then
    AnimEvent(GetPrefabData(target).TeleportedBunnyEntityGroupName, EVENT_Special_1)
    data.BunniesSeen = (data.BunniesSeen - 1)
  end
  return 
end
Prefab_BunnyHat_HatBroken = function(target, _WhichHat)
  Print(("__Function: Prefab_BunnyHat_HatBroken, _WhichHat: " .. tostring(_WhichHat)))
  local CheckpointMarker = "CHECKPOINT_Projector_MeanStreet"
  if (_WhichHat == "1") then
    CheckpointMarker = "CHECKPOINT_ShantyShop_LouisShack"
  end
  if (_WhichHat == "3") then
    CheckpointMarker = "CHECKPOINT_OldTown"
  end
  Print(("__Will Save Checkpoint @: " .. tostring(CheckpointMarker)))
  local Hat = (("BunnyHat" .. tostring(_WhichHat)) .. "Marker")
  local data = GetPrefabData(Hat)
  if (data.ThisBunnyHatGlobal == "None") then
    Print("__Didn't assign global to this bunny hat!")
  else
    SetGlobal(data.ThisBunnyHatGlobal, 1)
  end
  SetGlobal(data.NumBunnyHatsGlobal, (GetGlobal(data.NumBunnyHatsGlobal) - 1))
  GiveCollectible("Bunny_Hat")
  Print(("__Num Bunny Hats Left: " .. tostring(GetGlobal(data.NumBunnyHatsGlobal))))
  StartEmitterByNameFireForget(data.TeleportedBunnyEntityGroupName, "BunnySpawnFX")
  DisableMotion(data.TeleportedBunnyEntityGroupName)
  Hide(data.TeleportedBunnyEntityGroupName)
  Disable(GetRelativePrefabEntity(Hat, ".HideBunnyTrigger"))
  DestroyEntity(GetRelativePrefabEntity(Hat, ".HideBunnyTrigger"))
  ForceSequence("NOS_BogEasy_Gus", "NOS_Gus_MagicShopQuest_BunnyHatBroken")
  NOS_BogEasy_SaveCheckpoint(CheckpointMarker)
  return 
end
Prefab_BunnyHat_HideInteriorBunnyHat = function(target)
  Print("__Function: Prefab_BunnyHat_HideInteriorBunnyHat")
  Hide(GetRelativePrefabEntity(target, ".Bunny"))
  ForEachEntityInPrefab(Hide, "InteriorBunnyHat_Hat")
  return 
end
BunnyDeathTest = function(target)
  Print(((("__I'm dead (" .. tostring(GetName(target))) .. ")! What killed me? ") .. tostring(_activator())))
  return 
end

