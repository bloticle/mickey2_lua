OldMill2_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
local OldMill2_ActionSpotsEnabled = false
local MickeySide = "Left"
local OswaldSide = "Left"
local previousNum = -1
local MickeyPastCollision = false
local OswaldPastCollision = false
OldMill2_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  if (HasCollectible("FilmReel_EM2_OldMill2") == true) then
    if (AlreadyCheckedFilmReel == false) then
      OldMill2_Pickups = (OldMill2_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_OldMill")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (OldMill2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  return 
end
OldMill2_CountTicket = function()
  Print("one ticket still here")
  OldMill2_Pickups = (OldMill2_Pickups + 1)
  return 
end
OldMill2_CheckOnPickup = function()
  Print("Picked up item")
  OldMill2_Pickups = (OldMill2_Pickups - 1)
  if (OldMill2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
OldMill2_ClearSpawnTransforms = function()
  Print("OldMill2_ClearSpawnTransforms function entered")
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  return 
end
OldMill2_2DTransitionSetup = function(target)
  Print("***OldMill2_2DTransitionSetup")
  local data = GetPrefabData(target)
  local global = GetGlobal("EM2_EpisodeCheck")
  Print(("OldMill2_2DTransitionSetup: Episode " .. global))
  OswaldClearOverrideTeleportDistance()
  if (OldMill2_ActionSpotsEnabled == true) then
    OldMill2_ActionSpotsEnabled = false
    DecrementAbilityDisabled(GetPlayer(), "Toss")
  end
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  if (data.Film_Position == "Left") then
    Print("OldMill2_2DTransitionSetup: Film_Position = Left so we are Heading to Gulch Lab")
    SetGlobal("FTL_Gulch_ProjectorExit", 2)
  elseif (data.Film_Position == "Right") then
    Print("OldMill2_2DTransitionSetup: Film_Position = Right so we are Heading to Dragon Boss")
    if (2 <= global) then
      data.ActivatedLevels = "FTL_BlotworxDragon.SecondVisit"
    else
      data.ActivatedLevels = "FTL_BlotworxDragon.Main"
    end
    SetGlobal("FTL_Gulch_ProjectorExit", 4)
  end
  SetupPosition(target)
  return 
end
OldMill2_CheckCharacterSides = function()
  Print("OldMill2_CheckCharacterSides function entered")
  while true do
    wait(0)
  end
  Print(("OldMill2_CheckCharacterSides 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
  if (string.sub(tostring(GetGlobal("2dDirection")), -2, -2) == "1") then
    MickeySide = "Right"
  else
    MickeySide = "Left"
  end
  if (string.sub(tostring(GetGlobal("2dDirection")), -1, -1) == "1") then
    OswaldSide = "Right"
  else
    OswaldSide = "Left"
  end
  Print(((("OldMill2_CheckCharacterSides: Mickey is " .. tostring(MickeySide)) .. " and Oswald is ") .. tostring(OswaldSide)))
  if (MickeySide == OswaldSide) then
    Print("OldMill2_CheckCharacterSides: Mickey and Oswald are on same side")
  else
    Print("OldMill2_CheckCharacterSides: Mickey and Oswald are on opposite sides, calling OldMill2_OswaldSplitFollow()")
    OswaldOverrideTeleportDistance(nil, 120)
    IncrementAbilityDisabled(GetPlayer(), "Toss")
    OldMill2_ActionSpotsEnabled = true
    FireThread(OldMill2_OswaldSplitFollow)
    if (OswaldSide == "Left") then
      Enable("trn_oldmill_02a.TriggerBase 11")
    end
  end
  return 
end
OldMill2_OswaldSplitFollow = function()
  if (OldMill2_ActionSpotsEnabled == true) then
    local pos = GetPosition(GetPlayer())
    local num = 0
    pos = pos.y
    if (pos < 19.799999237060547) then
      num = 1
    elseif (19.799999237060547 <= pos) then
      if (pos < 29.700000762939453) then
        num = 2
      end
    elseif (29.700000762939453 <= pos) then
      if (pos < 38.70000076293945) then
        num = 3
      end
    elseif (38.70000076293945 <= pos) then
      if (pos < 50.599998474121094) then
        num = 4
      end
    elseif (50.599998474121094 <= pos) then
      if (pos < 62.79999923706055) then
        num = 5
      end
    elseif (62.79999923706055 <= pos) then
      if (pos < 73) then
        num = 6
      end
    elseif (73 <= pos) then
      num = 7
    end
    if (OswaldPastCollision == true) then
      num = 7
    end
    if (0 < num) then
      if (num ~= previousNum) then
        Print(((((("OldMill2_OswaldSplitFollow updating action spot from " .. OswaldSide) .. tostring(previousNum)) .. " to ") .. OswaldSide) .. tostring(num)))
        Enable((("OldMill2_ActionSpot_" .. OswaldSide) .. tostring(num)))
        Print("OldMill2_OswaldSplitFollow Resetting Oswald teleport countdown timer")
        QueueBrainEvent(GetOswaldAI(), BRAIN_ResetOswaldCallForHelpTimer)
        wait(0.10000000149011612)
        if (0 < previousNum) then
          Disable((("OldMill2_ActionSpot_" .. OswaldSide) .. tostring(previousNum)))
        end
        previousNum = num
      end
    else
      Print("OldMill2_OswaldSplitFollow num = 0")
    end
    wait(0.5)
    FireThread(OldMill2_OswaldSplitFollow)
  end
  return 
end
OldMill2_ActionSpotsDone = function()
  Print("OldMill2_ActionSpotsDone function entered")
  if (OldMill2_ActionSpotsEnabled == true) then
    OldMill2_ActionSpotsEnabled = false
    DecrementAbilityDisabled(GetPlayer(), "Toss")
    Print("OldMill2_ActionSpotsDone is deactivating action spots")
    wait(1)
    local (for index), (for limit), (for step) = 1, 7, 1
    for x = (for index), (for limit), (for step) do
      Disable(("OldMill2_ActionSpot_Left" .. tostring(x)))
      Disable(("OldMill2_ActionSpot_Right" .. tostring(x)))
    end
    OswaldStartFollowAction()
    Print("OldMill2_ActionSpotsDone has deactivated spots, Oswald should be following now")
  end
  return 
end
OldMill2_CharacterPastOneWayCollision = function(character)
  Print("OldMill2_CharacterPastOneWayCollision function entered")
  if (character == GetPlayer()) then
    if (MickeyPastCollision == false) then
      MickeyPastCollision = true
      if (MickeySide == "Left") then
        OverrideSpawnTransform(PLAYER_ONE, GetPosition("Marker_SpawnPastCollisionLeft_Mickey"), GetFacing("Marker_SpawnPastCollisionLeft_Mickey"))
      else
        OverrideSpawnTransform(PLAYER_ONE, GetPosition("Marker_SpawnPastCollisionRight_Mickey"), GetFacing("Marker_SpawnPastCollisionRight_Mickey"))
        if (OswaldPastCollision == false) then
          OswaldPastCollision = true
          Disable("trn_oldmill_02a.TriggerBase 13")
          Disable("trn_oldmill_02a.TriggerBase 14")
          if (OswaldSide == "Left") then
            OverrideSpawnTransform(PLAYER_TWO, GetPosition("Marker_SpawnPastCollisionLeft_Oswald"), GetFacing("Marker_SpawnPastCollisionLeft_Oswald"))
          else
            OverrideSpawnTransform(PLAYER_TWO, GetPosition("Marker_SpawnPastCollisionRight_Oswald"), GetFacing("Marker_SpawnPastCollisionRight_Oswald"))
          end
        end
      end
    end
  elseif (OswaldPastCollision == false) then
    OswaldPastCollision = true
    Disable("trn_oldmill_02a.TriggerBase 13")
    Disable("trn_oldmill_02a.TriggerBase 14")
    if (OswaldSide == "Left") then
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("Marker_SpawnPastCollisionLeft_Oswald"), GetFacing("Marker_SpawnPastCollisionLeft_Oswald"))
    else
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("Marker_SpawnPastCollisionRight_Oswald"), GetFacing("Marker_SpawnPastCollisionRight_Oswald"))
    end
  end
  if (MickeySide ~= OswaldSide) then
    if (MickeyPastCollision == true) then
      if (OswaldPastCollision == true) then
        OldMill2_ActionSpotsDone()
      end
    end
  end
  return 
end
OldMill2_CharacterPastOneWayCollisionFromTop = function(character)
  Print("OldMill2_CharacterPastOneWayCollisionFromTop function entered")
  if (character == GetPlayer()) then
    if (MickeyPastCollision == false) then
      MickeyPastCollision = true
      OverrideSpawnTransform(PLAYER_ONE, GetPosition("Marker_SpawnPastCollisionLeft_Mickey"), GetFacing("Marker_SpawnPastCollisionLeft_Mickey"))
    end
  elseif (OswaldPastCollision == false) then
    OswaldPastCollision = true
    Disable("trn_oldmill_02a.TriggerBase 13")
    Disable("trn_oldmill_02a.TriggerBase 14")
    OverrideSpawnTransform(PLAYER_TWO, GetPosition("Marker_SpawnPastCollisionLeft_Oswald"), GetFacing("Marker_SpawnPastCollisionLeft_Oswald"))
  end
  if (MickeySide ~= OswaldSide) then
    if (MickeyPastCollision == true) then
      if (OswaldPastCollision == true) then
        OldMill2_ActionSpotsDone()
      end
    end
  end
  return 
end
OldMill2_ManageOswaldAssistMickey = function(target, action, node1)
  Print("***OldMill2_ManageOswaldAssistMickey")
  local activator = GetName(_activator())
  if (action == "enter") then
    if (activator == GetName(GetPlayer())) then
      OswaldSetPathAction("OswaldAssistPatrolNode")
    end
  else
  end
  return 
end
