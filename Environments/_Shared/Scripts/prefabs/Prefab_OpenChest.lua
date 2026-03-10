Mickey_Open_Chest_SetUp = function(target)
  local data = GetPrefabData(target)
  local chest = GetRelativePrefabEntity(target, ".Chest")
  local Spawner = GetRelativePrefabEntity(target, ".Spawner_ItemGround")
  Print(("*************** Mickey_Open_Chest_SetUp: " .. data.Collectible))
  if (data.GlobalToCheck ~= "None") then
    if (GetGlobal(data.GlobalToCheck) == 1) then
      Print((("****************************** Mickey_Open_Chest_SetUp: " .. data.GlobalToCheck) .. " == 1 (Already recieved this collectible)"))
      data.ChestOpened = true
    end
  else
    Print((("****************************** Mickey_Open_Chest_SetUp: GlobalToCheck override not set! - CHEST " .. tostring(GetName(target))) .. " WILL NOT PERSIST!"))
  end
  if (not (not data.ChestOpened)) then
    Print("********************** Mickey_Open_Chest_SetUp: ChestOpened == true")
    if data.ChestOpened then
      AnimGBSequence(chest, "Idle_Open")
    end
    if (data.ChestDisabled == "True_Invulnerable") then
      SetPropertyBool(chest, "Is Real", true)
    end
  end
  return 
end
Mickey_Chest_PaintedIn = function(target)
  local data = GetPrefabData(target)
  if (not data.ChestOpened) then
    if (data.ChestDisabled == "False") then
      SetPropertyBool(GetRelativePrefabEntity(target, ".Chest"), "Is Real", false)
    end
  end
  return 
end
Mickey_Open_Chest = function(target, event, activator)
  Print("Red Chest opening attempted.  Was it Spin Stim?")
  local data = GetPrefabData(target)
  local ChestType = data.ChestType
  if (data.Spinnable == true) then
    Print("It was spinnable.  Go!")
    if StimulusEvent_HasStimulusType(event, ST_SPIN) then
      if (activator == GetPlayer()) then
        if GetPropertyBool(target, "Is Painted") then
          if (GetPropertyInt(target, "Active Sequence ID") == 1) then
            Print("It was Spin Stim.  And Mickey or Oswald did it.  Go ahead and open!")
            Prefab_Open_Chest(target)
          end
        end
      end
    end
  end
  return 
end
Prefab_Open_Chest = function(target)
  Print("Making chest invulnerable to thinner!")
  local chest = GetRelativePrefabEntity(target, ".Chest")
  Print("Opening the chest!  Stand back!")
  Print("*********************** Mickey_Open_Chest()")
  local Spawner = GetRelativePrefabEntity(target, ".Spawner_ItemGround")
  Print(("This is the spawner: " .. GetName(Spawner)))
  local data2 = GetPrefabData(Spawner)
  local SpawnerLocation = GetPosition(Spawner)
  if (data2.SequenceType == "Chest") then
    Print("*********************** Prefab_Open_Chest() -- Firing Chest Sequence")
    AnimGBSetIdle(chest, false)
    if (data2.IsDEC == "Yes") then
      AudioPostEventOn(GetPlayer(), "Play_MX_DEC_Chest")
      Print("In a DEC, fire chest music stinger as oneshot")
    elseif (data2.IsELPArea == "Yes") then
      AudioPostEventOn(GetPlayer(), "Play_MX_Oneshot_Chest")
      AudioPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_ELP", "Stop_MX_FGY_ELP")
      FireThread(ChestStingerResumeELPFloatMusic)
    elseif (data2.IsAliceArea == "Yes") then
      if (GetGlobal("FTL_FloatGraveyard_AliceMachines") == 1) then
        AudioPostEventOn(GetPlayer(), "Play_MX_Oneshot_Chest")
        AudioPostEventOn("ftl_floatgraveyard_01a_audio.Sound_Marker_Music_Alice", "Stop_MX_FGY_Alice")
        FireThread(ChestStingerResumeAliceFloatMusic)
      else
        DoStinger("TreasureChest", 2)
        DoStinger("TreasureChest", 2)
      end
    else
      DoStinger("TreasureChest", 2)
    end
    AnimGBReset(chest)
    AnimGBSequence(chest, "Chest_Open", true)
    AudioPostEventOn(target, "Play_sfx_red_chest_open")
    if (data2.TreasureMarker == ".OswaldChest") then
      Print("It's an Oswald chest.  Disable the Action Spot!")
      local OswaldActionSpot = GetRelativePrefabEntity(target, ".OswaldChest_ActionSpot")
      Print(OswaldActionSpot)
      data2.ChestOpened = true
      OswaldStreamAbort()
    else
      Print("Not an Oswald chest.  Disable the spin trigger!")
      local SpinTrigger, SpinTrigger = GetRelativePrefabEntity(target, ".RedChest_OpenTrigger"), target
      SpinTrigger = Print
      SpinTrigger(SpinTrigger)
      SpinTrigger = Disable
      SpinTrigger(SpinTrigger)
    end
    Print("*********************** Prefab_Open_Chest() -- Enable Spawner")
    wait(1)
    Print(("This is what it thinks is the collectible: " .. data2.Collectible))
    local attach, attach = function(index)
      SetPropertyInt(Spawner, "Index To Spawn", index, 0)
      return ForceSpawn(Spawner, 1)[1]
    end, data2.Collectible
    attach = data2.GlobalToCheck
    if (GetGlobal(attach) == 1) then
      attach = "Not doing anything."
      Print(attach)
    else
      attach = data2.Collectible
      if HasCollectible(attach) then
        if (data2.CollectibleType == "Costume") then
          attach = "Original Collectible was a costume; Give a silver pin."
          Print(attach)
          data2.Collectible = "Silver_Pin"
          attach = Spawner
          SetPropertyVector(attach, "Spawn Offset", vector4(0, 40, 0))
          attach = 3
          local reward, reward = attach(attach), "Spawn Offset"
          attach = wait
          reward = 0
          attach(reward)
          attach = SetPropertyVector
          reward = Spawner
          attach(reward, "Spawn Offset", vector4(0, 0.10000000149011612, 0))
          attach = attach
          reward = 0
          attach = attach(reward)
          local proj = "Spawn Offset"
          reward = MoveToEntity
          proj = reward
          reward(proj, attach)
          reward = SetParentEntity
          proj = reward
          reward(proj, attach)
        else
          attach = "Should be giving a gold pin."
          Print(attach)
          data2.Collectible = "Gold_Pin"
          attach = Spawner
          SetPropertyVector(attach, "Spawn Offset", vector4(0, 40, 0))
          attach = 2
          local reward = attach(attach)
          attach = wait
          attach(0)
          attach = SetPropertyVector
          reward = vector4
          reward = reward(0, 0.10000000149011612, 0)
          attach(Spawner, "Spawn Offset", reward)
          attach = attach
          attach = attach(0)
          reward = attach
          MoveToEntity(reward, reward)
          reward = attach
          SetParentEntity(reward, reward)
        end
        attach = "Should be all done giving stuff away now."
        Print(attach)
      else
        attach = "Should be giving "
        attach = (attach .. data2.Collectible)
        Print(attach)
        attach = Spawner
        SetPropertyVector(attach, "Spawn Offset", vector4(0, 40, 0))
        attach = 1
        local reward = attach(attach)
        attach = wait
        attach(0)
        attach = SetPropertyVector
        reward = 0.10000000149011612
        attach(Spawner, "Spawn Offset", vector4(0, reward, 0))
        attach = attach
        attach = attach(0)
        MoveToEntity(reward, attach)
        SetParentEntity(reward, attach)
      end
    end
  end
  data2.ChestOpened = true
  Print(data2.TreasureMarker)
  SetTransformation(Spawner, SpawnerLocation, vector4(0, 0, 0))
  if (data2.SequenceType == "Chest") then
    wait(5)
    AnimGBSetIdle(chest, true)
  end
  return 
end
Prefab_ChestOpenable = function(target, status)
  local data = GetPrefabData(target)
  if (status == "true") then
    if (data.ChestDisabled == "False") then
      Print("Spinnable!")
      data.Spinnable = true
    end
  else
    Print("Not spinnable!")
    data.Spinnable = false
  end
  return 
end
Mickey_Find_ItemAnimationEntity = function(target)
  Print("************************************* - Mickey_Find_ItemAnimationEntity Started")
  FireThread(Prefab_Oswald_LaunchItem, target)
  Print(("************************************* - Mickey_Find_ItemAnimationEntity GetName = " .. tostring(GetName(target))))
  Print("************************************* - Mickey_Find_ItemAnimationEntity Finished")
  return 
end
Mickey_Attach_Item_To_Animation = function(target)
  PlayerPickup_SetPendingActivation(target, 1)
  Print("************************************* - Mickey_Attach_Item_To_Animation Started")
  Print(("************************************* - Mickey_Attach_Item_To_Animation: GetName = " .. tostring(GetName(target))))
  wait(0.5)
  Print("************************************* - Mickey_Attach_Item_To_Animation: ClearParent")
  ClearParent(target)
  wait(0.5)
  SetPropertyBool(target, "AutoAttracts", true)
  Print("************************************* - Mickey_Attach_Item_To_Animation Finished")
  return 
end
local ItemCleared = false
Mickey_Receive_Item_NPC = function(spawner_EGN, item, prev_item)
  local data = GetPrefabData(spawner_EGN)
  local camera = GetRelativePrefabEntity(spawner_EGN, ".Camera")
  local Spawner = GetRelativePrefabEntity(spawner_EGN, ".Spawner_ItemGround")
  Print("*********************** Mickey_Receive_Item_NPC() - Firing Store Sequence")
  AnimGBSetIdle(camera, false)
  local SpawnerLocation = GetPosition(Spawner)
  if (data.Position2D == "Left") then
    AnimGBSequence(camera, "mickey_idle_paint_acquireItem_chest_cam")
  elseif (data.Position2D == "Right") then
    AnimGBSequence(camera, "mickey_idle_paint_acquireItem_chest_cam")
  end
  local itemnum = Mickey_PickItemToSpawn(spawner_EGN, item)
  local prev_itemnum = ""
  ItemCleared = false
  if (prev_item == nil) then
    Mickey_Spawn_ItemTransferFX(spawner_EGN)
    AudioPostEventOn(GetPlayer(), "Play_sfx_UI_NPC_GiveItem")
  else
    Mickey_GetItem_ClearItem(spawner_EGN, prev_item)
  end
  wait(0.30000001192092896)
  if (not ItemCleared) then
    SetPropertyInt(Spawner, "Index To Spawn", itemnum, 0)
    SetPropertyVector(Spawner, "Spawn Offset", vector4(0, data.Item_Hoffset, 0), 0)
    Enable(Spawner)
  end
  return 
end
Mickey_PickItemToSpawn = function(spawner_EGN, item)
  Print("*********************** Mickey_PickItemToSpawn() - Start")
  local data = GetPrefabData(spawner_EGN)
  local dataitem = ""
  if (item == data.Item1) then
    Print("*********************** Mickey_PickItemToSpawn() - item == data.item1  RETURNING 1")
    return 1
  elseif (item == data.Item2) then
    Print("*********************** Mickey_PickItemToSpawn() - item == data.item2  RETURNING 2")
    return 2
  elseif (item == data.Item3) then
    Print("*********************** Mickey_PickItemToSpawn() - item == data.item3  RETURNING 3")
    return 3
  elseif (item == data.Item4) then
    Print("*********************** Mickey_PickItemToSpawn() - item == data.item4  RETURNING 4")
    return 4
  elseif (item == data.Item5) then
    Print("*********************** Mickey_PickItemToSpawn() - item == data.item5  RETURNING 5")
    return 5
  elseif (item == data.Item6) then
    Print("*********************** Mickey_PickItemToSpawn() - item == data.item6  RETURNING 6")
    return 6
  elseif (item == data.Item7) then
    Print("*********************** Mickey_PickItemToSpawn() - item == data.item7  RETURNING 7")
    return 7
  elseif (item == data.Item8) then
    Print("*********************** Mickey_PickItemToSpawn() - item == data.item8  RETURNING 8")
    return 8
  elseif (item == data.Item9) then
    Print("*********************** Mickey_PickItemToSpawn() - item == data.item9  RETURNING 9")
    return 9
  elseif (item == data.Item10) then
    Print("*********************** Mickey_PickItemToSpawn() - item == data.item10  RETURNING 10")
    return 10
  end
  return 
end
Mickey_Spawn_ItemTransferFX = function(spawner_EGN)
  Print("*********************** Mickey_Spawn_ItemTransferFX() - SPAWN ITEM TRANSFER FX")
  local Spawner = GetRelativePrefabEntity(spawner_EGN, ".Spawner_ItemGround")
  SetPropertyVector(Spawner, "Spawn Offset", vector4(0, 0, 0), 0)
  SetPropertyInt(Spawner, "Index To Spawn", 0, 0)
  Enable(Spawner)
  wait(0.5)
  return 
end
Mickey_GetItem_ClearItem = function(spawner_EGN, item)
  Print("*********************** Mickey_GetItem_ClearItem() - Clearing Extra Items")
  ItemCleared = true
  local itemnum = Mickey_PickItemToSpawn(spawner_EGN, item)
  Mickey_Spawn_ItemTransferFX(spawner_EGN)
  AudioPostEventOn(GetPlayer(), "Play_sfx_UI_NPC_GiveItem")
  DestroyEntity((".Item" .. itemnum))
  return 
end
Mickey_ReceieveItem_Quick = function(spawner_EGN)
  Print("*********************** Mickey_ReceieveItem_Quick() - Clearing Extra Items")
  local camera = GetRelativePrefabEntity(spawner_EGN, ".Camera")
  local Spawner = GetRelativePrefabEntity(spawner_EGN, ".Spawner_ItemGround")
  RestrictCutSceneInput()
  SetTransformation(camera, GetPosition(GetPlayer()), vector4(0, 0, 0))
  AnimGBReset(camera)
  AnimGBSequence(camera, "mickey_idle_paint_acquireItem_chest_cam")
  wait(0.20000000298023224)
  StartFadeInNoHUD(0.5)
  GrabCameraNif(camera, nil, 0, 0)
  AnimEvent(GetPlayer(), EVENT_Special_8)
  SetPropertyVector(Spawner, "Spawn Offset", vector4(0, 0, 0), 0)
  SetTransformation(Spawner, (GetPosition(GetPlayer()) + vector4(0, 1.25, 0)), vector4(0, 0, 0))
  wait(0.75)
  ItemCleared = false
  SetPropertyInt(Spawner, "Index To Spawn", 1, 0)
  Enable(Spawner)
  wait(1)
  if (data.Collectible == "Gold_Pin") then
    if (GetGlobal(data.GlobalToCheck) == 0) then
      GiveCollectible(data.Collectible)
      if (data.Collectible == "Bronze_Pin") then
        GiveCurrencyItem("Bronze_Pin", 1)
      elseif (data.Collectible == "Silver_Pin") then
        GiveCurrencyItem("Silver_Pin", 1)
      else
        GiveCurrencyItem("Gold_Pin", 1)
      end
    end
    SetGlobal(data.GlobalToCheck, 1)
    UpdatePins()
  end
  if (data.Collectible == "NoCollectible") then
    SetGlobal(data.GlobalToCheck, 1)
  else
    GiveCollectible(data.Collectible)
    if (data.GlobalToCheck ~= "None") then
      SetGlobal(data.GlobalToCheck, 1)
    end
  end
  wait(1)
  StartFadeOut(1)
  wait(1)
  ReleaseCamera(CAMERA_SAMEPLACE_TRANSITION, 1)
  ForEachEntityInGroup(DestroyEntity, "Spawned_Item_Get")
  StartFadeIn(1)
  UnrestrictCutSceneInput()
  AnimGBSetIdle(camera, true)
  if (data.EndFunction ~= "none") then
    Print("*********************** Oswald_Open_Chest(): data.EndFunction != none")
    if (data.EndFunctionParam2 ~= "None") then
      FireThread(_G[data.EndFunction], data.EndFunctionParam1, data.EndFunctionParam2)
    elseif (data.EndFunctionParam1 ~= "None") then
      FireThread(_G[data.EndFunction], data.EndFunctionParam1)
    else
      FireThread(_G[data.EndFunction])
    end
  end
  return 
end
Mickey_GiveItemToCharacter = function(spawner_EGN, item)
  Print("*********************** Mickey_GiveItemToCharacter() - Start")
  local data = GetPrefabData(spawner_EGN)
  local camera = GetRelativePrefabEntity(spawner_EGN, ".Camera")
  local Spawner = GetRelativePrefabEntity(spawner_EGN, ".Spawner_ItemGround")
  AnimGBSetIdle(camera, false)
  if (data.SequenceType == "Store") then
    Print("*********************** Mickey_GiveItemToCharacter() - Store")
    if (data.Position2D == "Left") then
      AnimGBSequence(camera, "mickey_idle_paint_acquireItem_chest_cam")
    elseif (data.Position2D == "Right") then
      AnimGBSequence(camera, "mickey_idle_paint_acquireItem_chest_cam")
    end
  end
  local itemnum = Mickey_PickItemToSpawn(spawner_EGN, item)
  wait(0.30000001192092896)
  ItemCleared = false
  Mickey_Spawn_ItemTransferFX(spawner_EGN)
  AudioPostEventOn(GetPlayer(), "Play_sfx_UI_NPC_GiveItem")
  SetPropertyInt(Spawner, "Index To Spawn", itemnum, 0)
  SetPropertyVector(Spawner, "Spawn Offset", vector4(0.10000000149011612, data.Item_Hoffset, 0.10000000149011612), 0)
  Enable(Spawner)
  data.MickeyRewarded = "Yes"
  if (data.MickeyRewarded ~= "Yes") then
    if (data.MickeyRewarded == "No") then
      UnrestrictCutSceneInput()
      AnimGBSetIdle(camera, true)
    end
  end
  return 
end

