Prefab_RVAIPicker_AlwaysSetup = function(target, _MapSection)
  Print(("__Function: Prefab_RVAIPicker_AlwaysSetup, _MapSection: " .. tostring(_MapSection)))
  if (_MapSection == "1") then
    if Quest_CheckStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_10a", Quest_Completed) then
      Prefab_RVAIPicker_SpawnEnemy(target, "1", "Jester")
    else
      Prefab_RVAIPicker_SpawnEnemy(target, "1", "Naked")
    end
    if Quest_CheckStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_11a", Quest_Completed) then
      Prefab_RVAIPicker_SpawnEnemy(target, "2", "TopHat")
    else
      Prefab_RVAIPicker_SpawnEnemy(target, "2", "Naked")
      if (_MapSection == "2") then
        if Quest_CheckStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_9a", Quest_Completed) then
          Prefab_RVAIPicker_SpawnEnemy(target, "3", "Africa")
        else
          Prefab_RVAIPicker_SpawnEnemy(target, "3", "Naked")
        end
        if Quest_CheckStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_1a", Quest_Completed) then
          Prefab_RVAIPicker_SpawnEnemy(target, "5", "Asia")
        else
          Prefab_RVAIPicker_SpawnEnemy(target, "5", "Naked")
        end
      end
    end
  elseif (_MapSection == "2") then
    if Quest_CheckStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_9a", Quest_Completed) then
      Prefab_RVAIPicker_SpawnEnemy(target, "3", "Africa")
    else
      Prefab_RVAIPicker_SpawnEnemy(target, "3", "Naked")
    end
    if Quest_CheckStatus("Clothes_Make_The_Spatter", "Clothes_Make_The_Spatter_1a", Quest_Completed) then
      Prefab_RVAIPicker_SpawnEnemy(target, "5", "Asia")
    else
      Prefab_RVAIPicker_SpawnEnemy(target, "5", "Naked")
    end
  end
  return 
end
Prefab_RVAIPicker_SpawnEnemy = function(target, _Room, _Type)
  Print(((("__Function: Prefab_RVAIPicker_SpawnEnemy, _Room: " .. tostring(_Room)) .. ", _Type: ") .. tostring(_Type)))
  local data = GetPrefabData(target)
  local Index = -1
  if (_Type == "Africa") then
    Index = 0
  elseif (_Type == "Asia") then
    Index = 1
  elseif (_Type == "Jester") then
    Index = 2
  elseif (_Type == "TopHat") then
    Index = 4
  else
    Index = 3
  end
  SetPropertyInt(target, "Index To Spawn", Index)
  local Loop = 2
  if (_Room == "5") then
    Loop = 3
  end
  SetPropertyString(target, "Spawn Group", ("Spatter_Room" .. tostring(_Room)))
  Print(("__Spatter Spawning Getting Set to Spawn Group: " .. GetPropertyString(target, "Spawn Group")))
  for x = 1, Loop do
    local TeleportLocation = (((".SpawnMarker_Room" .. tostring(_Room)) .. "_Spatter") .. tostring(x))
    Print(("__Teleporting To Entity: " .. TeleportLocation))
    TeleportToEntity(target, GetRelativePrefabEntity(target, TeleportLocation))
    local Spawned = ForceSpawn(target, 1)
    wait(0.10000000149011612)
    if (Index ~= 3) then
      SetTargetTeam(Spawned[1], 3)
    end
  end
  return 
end
Prefab_RVAIPicker_ChangeSpatter = function(target, _Section)
  Print(("__Function: Prefab_RVAIPicker_ChangeSpatter, _Section: " .. _Section))
  local data = GetPrefabData(target)
  StartFadeOut(0.800000011920929)
  wait(0.4000000059604645)
  local RoomNumber = -1
  if (_Section == "Jester") then
    RoomNumber = 1
    UseQuestItems("Costume_SpatterJester", 1)
  elseif (_Section == "TopHat") then
    RoomNumber = 2
    UseQuestItems("Costume_SpatterManor", 1)
  elseif (_Section == "Africa") then
    RoomNumber = 3
    UseQuestItems("Costume_SpatterAfrica", 1)
  elseif (_Section == "Asia") then
    RoomNumber = 5
    UseQuestItems("Costume_SpatterAsia", 1)
  end
  if (RoomNumber == 1) then
    ForEachEntityInGroup(DestroyEntity, ("Spatter_Room" .. tostring(RoomNumber)))
    Prefab_RVAIPicker_SpawnEnemy(target, tostring(RoomNumber), _Section)
  end
  Print("__Will spawn new enemies on the next spawn of that section!")
  StartFadeIn(0.800000011920929)
  return 
end
Prefab_RVAIPicker_DestroySpatters = function(target, _Section)
  Print(("__Function: Prefab_RVAIPicker_DestroySpatters, _Section: " .. tostring(_Section)))
  if (_Section == "1") then
    ForEachEntityInGroup(DestroyEntity, "Spatter_Room1")
    ForEachEntityInGroup(DestroyEntity, "Spatter_Room2")
  elseif (_Section == "2") then
    ForEachEntityInGroup(DestroyEntity, "Spatter_Room3")
    ForEachEntityInGroup(DestroyEntity, "Spatter_Room5")
  end
  return 
end
Prefab_RVAIPicker_SpatterDeath = function(target)
  Print("__Function: Prefab_RVAIPicker_SpatterDeath")
  if (GetGlobal("NOS_BlotAlley_IanAngrySecondVisit") == 0) then
    SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
    SetGlobal("Extras_Ghost_Ian_Paint", 0)
    if (LevelManager_GetCurrentState() == "nos_blotalley_main.section1_visit2_ian") then
      SetPropertyFloat("NOS_BlotAlley_Ian_RV", "UsableRadius", 0)
      while true do
        if (not (IsAnySequencePlaying() == true)) then
          break
        end
        wait(0.10000000149011612)
      end
      AnimVarInt("NOS_BlotAlley_Ian_RV", VAR_Cutscene, 1)
      AnimEvent("NOS_BlotAlley_Ian_RV", EVENT_Start_Cutscene)
      wait(3)
      Hide("NOS_BlotAlley_Ian_RV")
    end
  end
  return 
end

