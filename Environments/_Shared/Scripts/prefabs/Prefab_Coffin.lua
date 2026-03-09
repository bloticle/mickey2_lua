Prefab_Coffin_AlwaysSetup = function(target)
  Print("__Function: Prefab_Coffin_AlwaysSetup")
  local data = GetPrefabData(target)
  local (for index), (for limit), (for step) = 1, 4, 1
  for x = (for index), (for limit), (for step) do
    if (GetGlobal((("NOS_BogEasy_Gravestone" .. tostring(x)) .. "Placed")) == 1) then
      Print(("__Destroying trigger: " .. tostring(x)))
      DestroyEntity(GetRelativePrefabEntity(target, ((".Coffin" .. tostring(x)) .. "_AttachTrigger")))
      wait(0)
      Print((("__Teleporting coffin: " .. tostring(x)) .. " into position!"))
      TeleportToEntity(GetRelativePrefabEntity(target, ((".Coffin" .. tostring(x)) .. "_TombstoneInert")), GetRelativePrefabEntity(target, ((".Knot" .. tostring(x)) .. "_2")))
      data.ItemStates[x] = 1
      DisableMotion(GetRelativePrefabEntity(target, ((".Coffin" .. tostring(x)) .. "_TombstoneInert")))
      SetPropertyFloat(GetRelativePrefabEntity(target, ((".Coffin" .. tostring(x)) .. "_TombstoneInert")), "UsableRadius", 0)
    end
  end
  if (data.ItemStates[1] == 1) then
    if (data.ItemStates[2] == 1) then
      if (data.ItemStates[3] == 1) then
        if (data.ItemStates[4] == 1) then
          if CanObtainCollectible("Forge_Gear") then
            Print("__All four items matched correctly!")
            Unhide("nos_bogeasy_01a_oldtownarea_shared.BoatQuest_Wheel_Collectible.Item_Effect")
            Unhide("nos_bogeasy_01a_oldtownarea_shared.BoatQuest_Wheel_Collectible.Pin")
          end
        end
      end
    end
  end
  return 
end
Prefab_Coffin_AttachTriggerAttempt = function(target)
  Print("_Function: Prefab_Coffin_AttachTriggerAttempt")
  local data = GetPrefabData(target)
  local Statue = _activator()
  Print(("__Activator Name: " .. tostring(GetName(Statue))))
  local Trigger = string.sub(tostring(GetName(target)), -15, -15)
  local Activator = string.sub(tostring(GetName(Statue)), -16, -16)
  Print(((("__Trigger Fired: " .. tostring(Trigger)) .. ", Activator: ") .. tostring(Activator)))
  if (Trigger == Activator) then
    Print("__Correct statue on trigger, attach to spline and disable!")
    Disable(target)
    local Knot1 = GetRelativePrefabEntity(target, ((".Knot" .. tostring(Trigger)) .. "_1"))
    local Knot2 = GetRelativePrefabEntity(target, ((".Knot" .. tostring(Trigger)) .. "_2"))
    local SplineFollower = GetRelativePrefabEntity(target, (".SplineFollower" .. tostring(Activator)))
    Print(("__Facing of Statue(1): " .. tostring(GetFacing(Statue))))
    SetPropertyFloat(Statue, "UsableRadius", 0)
    TeleportToEntity(Knot1, Statue)
    TeleportToEntity(SplineFollower, Statue)
    DisableMotion(Statue)
    Wait(0.10000000149011612)
    SetFacing(SplineFollower, GetFacing(Statue))
    SetFacing(Knot1, GetFacing(Statue))
    SetFacing(Knot2, GetFacing(Statue))
    SetParentEntity(Statue, SplineFollower)
    Print(("__Facing of Statue(2): " .. tostring(GetFacing(Statue))))
    Wait(0.10000000149011612)
    SplineFollower_StopAtPosition(SplineFollower, Knot1, Knot2, 1)
    Wait(0.10000000149011612)
    Print(("__Facing of Statue(3): " .. tostring(GetFacing(Statue))))
    SplineFollower_SetDisabled(SplineFollower, false)
    wait(1)
    data.ItemStates[tonumber(Activator)] = 1
    SetGlobal((("NOS_BogEasy_Gravestone" .. tostring(Activator)) .. "Placed"), 1)
    Prefab_Coffin_CheckForWin(target)
  else
    Prefab_Coffin_TombstoneAngry(target, tonumber(Activator), "0")
  end
  Print(((((((("__Item States: [1]: " .. tostring(data.ItemStates[1])) .. ", [2]: ") .. tostring(data.ItemStates[2])) .. ", [3]: ") .. tostring(data.ItemStates[3])) .. ", [4]: ") .. tostring(data.ItemStates[4])))
  return 
end
Prefab_Coffin_CheckForWin = function(target)
  Print("__Function: Prefab_Coffin_CheckForWin")
  local data = GetPrefabData(target)
  if (data.ItemStates[1] == 1) then
    if (data.ItemStates[2] == 1) then
      if (data.ItemStates[3] == 1) then
        if (data.ItemStates[4] == 1) then
          Print("__All four items matched correctly!")
          DoStinger("BOG_StingerMausoleum", 2)
          AnimGBSequence("NOS_BogEasy_MausoleumDoor", "open")
          Unhide("nos_bogeasy_01a_oldtownarea_shared.BoatQuest_Wheel_Collectible.Item_Effect")
          Unhide("nos_bogeasy_01a_oldtownarea_shared.BoatQuest_Wheel_Collectible.Pin")
          SetGlobal("NOS_BogEasy_CoffinPuzzleSolved", 1)
        end
      end
    end
  else
    ForceSequence("NOS_BogEasy_Ghost_Gilbert", "NOS_Gilbert_DonaldQuest_TombstoneBarks")
  end
  return 
end
Prefab_Coffin_TombstoneAngry = function(target, _TombstoneNum, _Section)
  Print(((("__Function: Prefab_Coffin_TombstoneAngry, _TombstoneNum: " .. tostring(_TombstoneNum)) .. ", _Section: ") .. tostring(_Section)))
  local data = GetPrefabData(target)
  if (_Section == "0") then
    SetGlobal("NOS_BogEasy_GravestoneHint", tonumber(_TombstoneNum))
    local CoffinToAnimate = tostring(((".Coffin" .. tostring(_TombstoneNum)) .. "_TombstoneInert"))
    Print(("__Coffin to animate: " .. CoffinToAnimate))
    AnimGBSequence(GetRelativePrefabEntity(target, CoffinToAnimate), "talk")
    SetParentEntity(GetRelativePrefabEntity(target, ".Conversation"), GetRelativePrefabEntity(target, CoffinToAnimate))
    ForceSequence(GetRelativePrefabEntity(target, ".Conversation"), "NOS_Gravestone_Hints")
    FireThread(Prefab_Coffin_TombstoneAngry, target, _TombstoneNum, "1")
  elseif (_Section == "1") then
    local Tombstone, Tombstone = GetRelativePrefabEntity(target, ((".Coffin" .. tostring(_TombstoneNum)) .. "_TombstoneInert")), target
    while true do
      Tombstone = IsSequencePlaying
      Tombstone = Tombstone(GetRelativePrefabEntity(target, ".Conversation"), "NOS_Gravestone_Hints")
      if (not Tombstone) then
        break
      end
      Tombstone = Print
      Tombstone("__Sequence is playing!")
      Tombstone = wait
      Tombstone(0.10000000149011612)
    end
    Tombstone = Print
    Tombstone("__Sequence is done!")
    Tombstone = ClearParent
    Tombstone(GetRelativePrefabEntity(target, ".Conversation"))
    Tombstone = tostring
    Tombstone = Tombstone(((".Coffin" .. tostring(_TombstoneNum)) .. "_TombstoneInert"))
    local CoffinToRest = ((".Coffin" .. tostring(_TombstoneNum)) .. "_TombstoneInert")
    CoffinToRest = Print
    CoffinToRest(("__Coffin to rest: " .. tostring(Tombstone)))
    CoffinToRest = AnimGBSequence
    CoffinToRest(GetRelativePrefabEntity(target, Tombstone), "rest")
    CoffinToRest = Print
    CoffinToRest(((((((("__Item States: [1]: " .. tostring(data.ItemStates[1])) .. ", [2]: ") .. tostring(data.ItemStates[2])) .. ", [3]: ") .. tostring(data.ItemStates[3])) .. ", [4]: ") .. tostring(data.ItemStates[4])))
  end
  return 
end
Prefab_Coffin_CantLeaveGraveyard = function(target)
  Print("Returning Object")
  local LaunchDirection = (GetPosition("GraveyardReturnMarker") - GetPosition(_activator()))
  LaunchDirection:normalize3()
  ApplyImpulse(_activator(), (LaunchDirection.x * TestImpulse), (TestImpulse * 2), (LaunchDirection.z * TestImpulse))
  wait(1)
  return 
end
LeavingObjects = 0
Prefab_CoffinItemGateTriggerEnter = function()
  LeavingObjects = (LeavingObjects + 1)
  AnimGBSequence("NOS_BogEasy_GraveyardGate", "close")
  Bark(nil, "That can't leave this place")
  return 
end
Prefab_CoffinItemGateTriggerLeave = function()
  LeavingObjects = (LeavingObjects - 1)
  if (LeavingObjects == 0) then
    AnimGBSequence("NOS_BogEasy_GraveyardGate", "open")
  end
  return 
end
