PickupSpawner = ""
Prefab_SetupItemSpawner = function(target)
  PickupSpawner = GetRelativePrefabEntity(target, ".Spawner_Items")
  return 
end
Prefab_GetItemSpawnerName = function()
  return PickupSpawner
end
Prefab_AnimateBush = function(target)
  local spawner = GetRelativePrefabEntity(target, ".PickupSpawner_Object_Toon")
  if GetPropertyBool(spawner, "Is Painted") then
    AnimGBReset(spawner)
    AnimGBSequence(spawner, GetPrefabData(target).animationName)
    AudioPostEventOn(target, "Play_sfx_Prefab_Spawner_Bush")
  end
  return 
end
Prefab_SpawnItem_Check = function(target, event)
  local data = GetPrefabData(target)
  if StimulusEvent_HasStimulusType(event, ST_SPIN) then
    if GetPropertyBool(target, "Is Painted") then
      if (data.SpawnerFired == "False") then
        data.SpawnerFired = "True"
        AnimGBReset(target)
        AnimGBSequence(target, data.animationName)
        if (data.ForcedItemType == "Quest") then
          if (GetGlobal(GetPrefabData(data.CollectibleName).GlobalToSave) == 0) then
            Prefab_SpawnItem_ItemQuest(target)
          end
        else
          Prefab_SpawnItem_ItemCheck(target)
          wait(0.15000000596046448)
          AudioPostEventOn(target, "Play_sfx_Phys_Impact_Empty")
        end
      else
        wait(0.15000000596046448)
        AudioPostEventOn(target, "Play_sfx_Phys_Impact_Empty")
      end
    end
  end
  return 
end
Prefab_Breakable_SpawnItem_Check = function(target)
  local data = GetPrefabData(target)
  if (data.DoPickupRewards == true) then
    if (data.ForcedItemType == "Quest") then
      if (GetGlobal(GetPrefabData(data.CollectibleName).GlobalToSave) == 0) then
        Prefab_SpawnItem_ItemQuest(target)
      end
    else
      Prefab_SpawnItem_ItemCheck(target)
    end
  end
  return 
end
HealthInWorld = 0
ThinnerInWorld = 0
PaintInWorld = 0
Prefab_SpawnItem_InUse = false
Prefab_SpawnItem_ItemPickedUp = function(target, ItemType)
  if (ItemType == "Paint") then
    _G[(ItemType .. "InWorld")] = (_G[(ItemType .. "InWorld")] - 1)
  end
  if (ItemType == "PaintThinner") then
    PaintInWorld = (PaintInWorld - 1)
    ThinnerInWorld = (ThinnerInWorld - 1)
  elseif (ItemType == "Health") then
    HealthInWorld = (HealthInWorld - 1)
  elseif (ItemType == "HealthLarge") then
    HealthInWorld = (HealthInWorld - 3)
  end
  return 
end
Prefab_SpawnItem_ItemQuest = function(target)
  local player = GetPlayer()
  local data = GetPrefabData(target)
  MoveToEntity(data.CollectibleName, GetRelativePrefabEntity(target, ".PickUpLocation"))
  MoveToEntity(PickupSpawner, GetRelativePrefabEntity(target, ".PickUpLocation"))
  SetPropertyVector(PickupSpawner, "Spawn Offset", vector4(data.PickupOffset[1], data.PickupOffset[2], data.PickupOffset[3]), 0)
  SetPropertyInt(PickupSpawner, "Index To Spawn", 13, 0)
  ForceSpawn(PickupSpawner, 1)
  wait(0.009999999776482582)
  SetPropertyInt(PickupSpawner, "Index To Spawn", 12, 0)
  ForceSpawn(PickupSpawner, 1)
  wait(0.009999999776482582)
  Pickup_Attach_Item_To_Animation(data.CollectibleName)
  return 
end
Prefab_SpawnItem_ItemCheck = function(target, _FromToon)
  local player = GetPlayer()
  local PlayerCurrentPaint = GetAmmo("Paint")
  local PlayerMaxPaint = GetAmmoMax("Paint")
  local PlayerCurrentThinner = GetAmmo("Thinner")
  local PlayerMaxThinner = GetAmmoMax("Thinner")
  local PlayerThinnerPercentage = (PlayerCurrentThinner / PlayerMaxThinner)
  local PlayerPaintPercentage = (PlayerCurrentPaint / PlayerMaxPaint)
  local PlayerCurrentHealth = GetPropertyInt(player, "Health", 0)
  local PlayerMaxHealth = GetPropertyInt(player, "MaxHealth", 0)
  local ammo1percentage = PlayerPaintPercentage
  local ammo1 = "Paint"
  local ammo2percentage = PlayerThinnerPercentage
  local ammo2 = "Thinner"
  local data = "None"
  local ItemToSpawn = "None"
  local ForcedItem = "None"
  if (_FromToon == nil) then
    data = GetPrefabData(target)
    ItemToSpawn = data.ForcedItemType
    ForcedItem = data.ForcedItemType
  else
    ItemToSpawn = _FromToon
    ForcedItem = _FromToon
  end
  if (0 < GetScrapperPercent(player)) then
    ammo1percentage = PlayerThinnerPercentage
    ammo1 = "Thinner"
    ammo2percentage = PlayerPaintPercentage
    ammo2 = "Paint"
  end
  local SpawnTickets = true
  local CheckAvailability = function()
    if (ForcedItem == "None") then
      if (ItemToSpawn == "PaintThinner") then
        if ((PlayerCurrentPaint + (PaintInWorld * 10)) < PlayerMaxPaint) then
          if ((PlayerCurrentThinner + (ThinnerInWorld * 10)) < PlayerMaxThinner) then
            PaintInWorld = (PaintInWorld + 1)
            ThinnerInWorld = (ThinnerInWorld + 1)
          end
        end
      elseif (ItemToSpawn == "Paint") then
        if ((PlayerCurrentPaint + (PaintInWorld * 10)) < PlayerMaxPaint) then
          PaintInWorld = (PaintInWorld + 1)
        end
      elseif (ItemToSpawn == "Thinner") then
        if ((PlayerCurrentThinner + (ThinnerInWorld * 10)) < PlayerMaxThinner) then
          ThinnerInWorld = (ThinnerInWorld + 1)
        end
      elseif (ItemToSpawn == "Health") then
        if ((PlayerCurrentHealth + HealthInWorld) < PlayerMaxHealth) then
          HealthInWorld = (HealthInWorld + 1)
        end
      elseif (ItemToSpawn == "HealthLarge") then
        if ((PlayerCurrentHealth + HealthInWorld) < PlayerMaxHealth) then
          HealthInWorld = (HealthInWorld + 3)
        end
      else
        if (ItemToSpawn == "HealthLarge") then
          ItemToSpawn = "Health"
        elseif (ItemToSpawn == "Health") then
          ItemToSpawn = "PaintThinner"
        elseif (ItemToSpawn == "PaintThinner") then
          ItemToSpawn = ammo1
        elseif (ItemToSpawn == ammo1) then
          ItemToSpawn = ammo2
        elseif (ItemToSpawn == ammo2) then
          ItemToSpawn = "Tickets"
        end
        if (ItemToSpawn == "Tickets") then
          if (SpawnTickets == false) then
            ItemToSpawn = ammo1
          end
        else
          CheckAvailability()
        end
      end
    end
    return 
  end
  local Prefab_SpawnItem = function()
    if (Prefab_SpawnItem_InUse == false) then
      Prefab_SpawnItem_InUse = true
      if (_FromToon == nil) then
        MoveToEntity(PickupSpawner, GetRelativePrefabEntity(target, ".PickUpLocation"))
      else
        MoveToEntity(PickupSpawner, target)
      end
      SetPropertyInt(PickupSpawner, "Index To Spawn", 13, 0)
      if (data == "None") then
        SetPropertyVector(PickupSpawner, "Spawn Offset", vector4(0, 2, 0), 0)
      else
        SetPropertyVector(PickupSpawner, "Spawn Offset", vector4(data.PickupOffset[1], data.PickupOffset[2], data.PickupOffset[3]), 0)
      end
      CheckAvailability()
      wait(0.20000000298023224)
      ForceSpawn(PickupSpawner, 1)
      wait(0.009999999776482582)
      SetPropertyInt(PickupSpawner, "Index To Spawn", 12, 0)
      ForceSpawn(PickupSpawner, 1)
      wait(0.009999999776482582)
      if (ItemToSpawn == "Paint") then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 1, 0)
      elseif (ItemToSpawn == "PaintThinner") then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 2, 0)
      elseif (ItemToSpawn == "Thinner") then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 3, 0)
      elseif (ItemToSpawn == "Tickets") then
        if (ForcedItem == "None") then
          SetGlobal("Prefab_TicketChance", (GetGlobal("Prefab_TicketChance") + 1))
          local i = math.random(1, 100)
          i = ((GetGlobal("Prefab_TicketChance") / 12) * math.random(1, 100))
          if (GetGlobal("MS_MeanStreetProgress") < 2) then
            SetPropertyInt(PickupSpawner, "Index To Spawn", 8, 0)
            SetGlobal("Prefab_TicketChance", (GetGlobal("Prefab_TicketChance") - 1))
          elseif (GetGlobal("MS_MeanStreetProgress") == 2) then
            if (i < 58) then
              SetPropertyInt(PickupSpawner, "Index To Spawn", 8, 0)
            elseif (57 < i) then
              SetPropertyInt(PickupSpawner, "Index To Spawn", 7, 0)
              SetGlobal("Prefab_TicketChance", (GetGlobal("Prefab_TicketChance") - 3))
              if (GetGlobal("Prefab_TicketChance") < 0) then
                SetGlobal("Prefab_TicketChance", 0)
                if (2 < GetGlobal("MS_MeanStreetProgress")) then
                  if (i < 58) then
                    SetPropertyInt(PickupSpawner, "Index To Spawn", 8, 0)
                  elseif (57 < i) then
                    if (i < 83) then
                      SetPropertyInt(PickupSpawner, "Index To Spawn", 7, 0)
                    end
                  elseif (82 < i) then
                    SetPropertyInt(PickupSpawner, "Index To Spawn", 6, 0)
                    SetGlobal("Prefab_TicketChance", (GetGlobal("Prefab_TicketChance") - 3))
                    if (GetGlobal("Prefab_TicketChance") < 0) then
                      SetGlobal("Prefab_TicketChance", 0)
                      if (ForcedItem ~= "None") then
                        if (ForcedItem == "1Ticket") then
                          SetPropertyInt(PickupSpawner, "Index To Spawn", 8, 0)
                        elseif (ForcedItem == "10Ticket") then
                          SetPropertyInt(PickupSpawner, "Index To Spawn", 7, 0)
                        elseif (ForcedItem == "30Ticket") then
                          SetPropertyInt(PickupSpawner, "Index To Spawn", 6, 0)
                          if (ItemToSpawn == "Health") then
                            SetPropertyInt(PickupSpawner, "Index To Spawn", 11, 0)
                            SetPropertyVector(PickupSpawner, "Spawn Offset", vector4(0, 0.5, 0), 0)
                          elseif (ItemToSpawn == "HealthLarge") then
                            SetPropertyInt(PickupSpawner, "Index To Spawn", 10, 0)
                          elseif (ItemToSpawn == "TV") then
                            SetPropertyInt(PickupSpawner, "Index To Spawn", 1, 0)
                          elseif (ItemToSpawn == "Anvil") then
                            SetPropertyInt(PickupSpawner, "Index To Spawn", 0, 0)
                          elseif (ItemToSpawn == "Watch") then
                            SetPropertyInt(PickupSpawner, "Index To Spawn", 2, 0)
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          elseif (2 < GetGlobal("MS_MeanStreetProgress")) then
            if (i < 58) then
              SetPropertyInt(PickupSpawner, "Index To Spawn", 8, 0)
            elseif (57 < i) then
              if (i < 83) then
                SetPropertyInt(PickupSpawner, "Index To Spawn", 7, 0)
              end
            elseif (82 < i) then
              SetPropertyInt(PickupSpawner, "Index To Spawn", 6, 0)
              SetGlobal("Prefab_TicketChance", (GetGlobal("Prefab_TicketChance") - 3))
              if (GetGlobal("Prefab_TicketChance") < 0) then
                SetGlobal("Prefab_TicketChance", 0)
                if (ForcedItem ~= "None") then
                  if (ForcedItem == "1Ticket") then
                    SetPropertyInt(PickupSpawner, "Index To Spawn", 8, 0)
                  elseif (ForcedItem == "10Ticket") then
                    SetPropertyInt(PickupSpawner, "Index To Spawn", 7, 0)
                  elseif (ForcedItem == "30Ticket") then
                    SetPropertyInt(PickupSpawner, "Index To Spawn", 6, 0)
                    if (ItemToSpawn == "Health") then
                      SetPropertyInt(PickupSpawner, "Index To Spawn", 11, 0)
                      SetPropertyVector(PickupSpawner, "Spawn Offset", vector4(0, 0.5, 0), 0)
                    elseif (ItemToSpawn == "HealthLarge") then
                      SetPropertyInt(PickupSpawner, "Index To Spawn", 10, 0)
                    elseif (ItemToSpawn == "TV") then
                      SetPropertyInt(PickupSpawner, "Index To Spawn", 1, 0)
                    elseif (ItemToSpawn == "Anvil") then
                      SetPropertyInt(PickupSpawner, "Index To Spawn", 0, 0)
                    elseif (ItemToSpawn == "Watch") then
                      SetPropertyInt(PickupSpawner, "Index To Spawn", 2, 0)
                    end
                  end
                end
              end
            end
          end
        elseif (ForcedItem ~= "None") then
          if (ForcedItem == "1Ticket") then
            SetPropertyInt(PickupSpawner, "Index To Spawn", 8, 0)
          elseif (ForcedItem == "10Ticket") then
            SetPropertyInt(PickupSpawner, "Index To Spawn", 7, 0)
          elseif (ForcedItem == "30Ticket") then
            SetPropertyInt(PickupSpawner, "Index To Spawn", 6, 0)
            if (ItemToSpawn == "Health") then
              SetPropertyInt(PickupSpawner, "Index To Spawn", 11, 0)
              SetPropertyVector(PickupSpawner, "Spawn Offset", vector4(0, 0.5, 0), 0)
            elseif (ItemToSpawn == "HealthLarge") then
              SetPropertyInt(PickupSpawner, "Index To Spawn", 10, 0)
            elseif (ItemToSpawn == "TV") then
              SetPropertyInt(PickupSpawner, "Index To Spawn", 1, 0)
            elseif (ItemToSpawn == "Anvil") then
              SetPropertyInt(PickupSpawner, "Index To Spawn", 0, 0)
            elseif (ItemToSpawn == "Watch") then
              SetPropertyInt(PickupSpawner, "Index To Spawn", 2, 0)
            end
          end
        end
      elseif (ItemToSpawn == "Health") then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 11, 0)
        SetPropertyVector(PickupSpawner, "Spawn Offset", vector4(0, 0.5, 0), 0)
      elseif (ItemToSpawn == "HealthLarge") then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 10, 0)
      elseif (ItemToSpawn == "TV") then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 1, 0)
      elseif (ItemToSpawn == "Anvil") then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 0, 0)
      elseif (ItemToSpawn == "Watch") then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 2, 0)
      end
      local spawnedObjs, spawnedObjs = ForceSpawn(PickupSpawner, 1), PickupSpawner
      spawnedObjs = GetElementCount
      spawnedObjs = spawnedObjs(spawnedObjs[1], "Child Entities")
      local numChildren = spawnedObjs[1]
      numChildren = AudioPostEventOn
      numChildren(target, "Play_sfx_Spawner_Spawn")
      numChildren = 0
      local (for index), (for limit) = spawnedObjs, 1
      for (for step) = numChildren, (for index), (for limit) do
        i = GetChildEntityByIndex
        i = i(spawnedObjs[1], (for step))
        local childEntity = spawnedObjs[1]
        childEntity = PlayerPickup_SetPendingActivation
        childEntity(i, 0.800000011920929)
      end
      numChildren = false
      Prefab_SpawnItem_InUse = numChildren
    elseif (Prefab_SpawnItem_InUse == true) then
      Print((("******************************* Prefab_SpawnItem() - ItemToSpawn = " .. ItemToSpawn) .. " IN USE! Waiting .15 secs and trying again"))
      wait(0.15000000596046448)
      Prefab_SpawnItem()
    end
    return 
  end
  if (ForcedItem == "None") then
    if (PlayerCurrentHealth <= (PlayerMaxHealth - 3)) then
      ItemToSpawn = "HealthLarge"
    elseif (PlayerCurrentHealth < (PlayerMaxHealth - 1)) then
      ItemToSpawn = "Health"
    elseif (PlayerCurrentHealth == PlayerMaxHealth) then
      if (ammo1percentage < 0.75) then
        if (ammo2percentage < 0.75) then
          ItemToSpawn = "PaintThinner"
        end
      elseif (ammo1percentage < 0.800000011920929) then
        ItemToSpawn = ammo1
      elseif (ammo2percentage < 0.800000011920929) then
        ItemToSpawn = ammo2
      else
        ItemToSpawn = "Tickets"
        if (ammo1percentage < 0.75) then
          if (ammo2percentage < 0.75) then
            ItemToSpawn = "PaintThinner"
          end
        elseif (ammo1percentage < 0.6600000262260437) then
          ItemToSpawn = ammo1
        elseif (ammo2percentage < 0.6600000262260437) then
          ItemToSpawn = ammo2
        elseif (0.75 < ammo1percentage) then
          ItemToSpawn = "Tickets"
        end
      end
    elseif (ammo1percentage < 0.75) then
      if (ammo2percentage < 0.75) then
        ItemToSpawn = "PaintThinner"
      end
    elseif (ammo1percentage < 0.6600000262260437) then
      ItemToSpawn = ammo1
    elseif (ammo2percentage < 0.6600000262260437) then
      ItemToSpawn = ammo2
    elseif (0.75 < ammo1percentage) then
      ItemToSpawn = "Tickets"
    end
  end
  Prefab_SpawnItem()
  return 
end
Animation_Entity = "None"
Pickup_Find_Animation_Entity = function(target)
  Print("************************************* - Pickup_Find_Animation_Entity Started")
  Animation_Entity = target
  Print("************************************* - Pickup_Find_Animation_Entity Finished")
  wait(2)
  DestroyEntity(target)
  return 
end
Pickup_Attach_Item_To_Animation = function(target)
  Print("************************************* - Pickup_Attach_Item_To_Animation Started")
  while true do
    if (not (Animation_Entity == "None")) then
      break
    end
    wait(0.0010000000474974513)
  end
  SetParentEntity(target, Animation_Entity)
  SetPropertyString(target, "Bone Attach Name", "VFX_01", 0)
  Animation_Entity = "None"
  Print("************************************* - Pickup_Attach_Item_To_Animation Finished")
  return 
end
Prefab_DetachChildrenAndRemove = function(target)
  local numChildren = GetElementCount(target, "Child Entities")
  local (for index), (for limit), (for step) = 0, numChildren, 1
  for i = (for index), (for limit), (for step) do
    local childEntity = GetChildEntityByIndex(target, i)
    ClearParent(childEntity)
  end
  DestroyEntity(target)
  return 
end
Prefab_Spawn_Ammo_Bouncy = function(target, isPaint)
  local Jigsaw_Position = GetPosition(target)
  local Jigsaw_StimType = tonumber(isPaint)
  Jigsaw_SpawnDirection = --[[ return 2 of ]] AdjustJigsawAmmoSpawnPosition(Jigsaw_Position, 0.25)
  Jigsaw_Position = AdjustJigsawAmmoSpawnPosition(Jigsaw_Position, 0.25)
  Jigsaw_SpawnDirection.y = 2
  if IsValidHandle(PickupSpawner) then
    SetTransformation(PickupSpawner, Jigsaw_Position, vector4(0, 0, 0))
    if (Jigsaw_StimType == 0) then
      SetPropertyInt(PickupSpawner, "Index To Spawn", 4, 0)
    elseif (Jigsaw_StimType == 1) then
      SetPropertyInt(PickupSpawner, "Index To Spawn", 5, 0)
    end
    local spawnedItems = ForceSpawn(PickupSpawner, 1)
    local velocity = (Jigsaw_SpawnDirection * 3.200000047683716)
    ApplyImpulse(spawnedItems[1], velocity.x, velocity.y, velocity.z)
    local ammo = GetChildEntityByName(spawnedItems[1], "Ammo_Paint")
    if (IsValidHandle(ammo) == false) then
      ammo = GetChildEntityByName(spawnedItems[1], "Ammo_Thinner")
    end
    local NIF = GetChildEntityByName(ammo, "Ammo_Paint_Nif")
    if (IsValidHandle(NIF) == false) then
      NIF = GetChildEntityByName(ammo, "Ammo_Thinner_Parentable")
    end
    if IsValidHandle(NIF) then
      SetPropertFloat(NIF, "Bone Scale Multiplier", 0, 0)
      SetPropertyFloat(NIF, "Lifetime", 30, 0)
      SetPropertyBool(NIF, "Shrink Over Lifetime", true, 0)
      PlayerPickup_SetPendingActivation(NIF, 2)
    end
  end
  return 
end
Jigsaw_SpawnDirection = ""
Prefab_SpawnItem_Jigsaw = function(target, event)
  local Jigsaw_Position = JigsawStateChangedEvent_Position(event)
  local Jigsaw_StimType = JigsawStateChangedEvent_AmmoType(event)
  Jigsaw_SpawnDirection = --[[ return 2 of ]] AdjustJigsawAmmoSpawnPosition(Jigsaw_Position, 0.25)
  Jigsaw_Position = AdjustJigsawAmmoSpawnPosition(Jigsaw_Position, 0.25)
  Jigsaw_SpawnDirection.y = 2
  local Prefab_SpawnJigsaw = function()
    if IsValidHandle(PickupSpawner) then
      SetTransformation(PickupSpawner, Jigsaw_Position, vector4(0, 0, 0))
      if (Jigsaw_StimType == 0) then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 4, 0)
      elseif (Jigsaw_StimType == 1) then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 5, 0)
      end
      local spawnedItems = ForceSpawn(PickupSpawner, 1)
      local velocity = (Jigsaw_SpawnDirection * 3.200000047683716)
      ApplyImpulse(spawnedItems[1], velocity.x, velocity.y, velocity.z)
      local ammo = GetChildEntityByName(spawnedItems[1], "Ammo_Paint")
      if (IsValidHandle(ammo) == false) then
        ammo = GetChildEntityByName(spawnedItems[1], "Ammo_Thinner")
      end
      local NIF = GetChildEntityByName(ammo, "Ammo_Paint_Nif")
      if (IsValidHandle(NIF) == false) then
        NIF = GetChildEntityByName(ammo, "Ammo_Thinner_Parentable")
      end
      if IsValidHandle(NIF) then
        SetPropertyFloat(NIF, "Bone Scale Multiplier", 0, 0)
        SetPropertyFloat(NIF, "Lifetime", 30, 0)
        SetPropertyBool(NIF, "Shrink Over Lifetime", true, 0)
        PlayerPickup_SetPendingActivation(NIF, 2)
      end
    end
    return 
  end
  SetGlobal("Prefab_JigsawRewardChance", (GetGlobal("Prefab_JigsawRewardChance") + 1))
  local i = math.random(1, 100)
  i = ((GetGlobal("Prefab_JigsawRewardChance") / 4) * math.random(1, 100))
  if (75 < i) then
    SetGlobal("Prefab_JigsawRewardChance", 0)
    Prefab_SpawnJigsaw()
  end
  return 
end
