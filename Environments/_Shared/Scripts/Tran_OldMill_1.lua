OldMill1_Pickups = 1
AlreadyCheckedFilmReel = false
MusicEventVar = 0
local OldMill1_ActionSpotsEnabled = false
local MickeySide = "Left"
local OswaldSide = "Left"
local previousNum = -1
local MickeyPastCollision = false
local OswaldPastCollision = false
OldMill1_ParitcleHack = function(position)
  if (position == "left") then
    StartEmitters("trn_oldmill_01a_fx.BirdsNestFX")
    wait(2)
    StopEmitters("trn_oldmill_01a_fx.BirdsNestFX")
  else
    StartEmitters("trn_oldmill_01a_fx.BirdsNestFXRight")
    wait(2)
    StopEmitters("trn_oldmill_01a_fx.BirdsNestFXRight")
  end
  return 
end
OldMill1_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  Print("Add MICKEY Abilities: USE")
  UnlockAbility(GetPlayer(), "Use")
  Print("Add MICKEY Abilities: JUMP")
  UnlockAbility(GetPlayer(), "Jump")
  Print("Add MICKEY Abilities: BOUNCE")
  UnlockAbility(GetPlayer(), "Bounce")
  Print("Add MICKEY Abilities: SPIN")
  UnlockAbility(GetPlayer(), "Spin")
  Print("Add MICKEY Abilities: HOVER")
  UnlockAbility(GetPlayer(), "Hover")
  Print("Add MICKEY Abilities: TOSS")
  UnlockAbility(GetPlayer(), "Toss")
  Print("Add MICKEY Abilities: COOPMOVE")
  UnlockAbility(GetPlayer(), "CoopMove")
  Print("Add MICKEY Abilities: EARLIFT")
  UnlockAbility(GetPlayer(), "Earlift")
  Print("Add OSWALD Abilities: USE")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Use")
  Print("Add OSWALD Abilities: JUMP")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Jump")
  Print("Add OSWALD Abilities: BOUNCE")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Bounce")
  Print("Add OSWALD Abilities: SPIN")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Spin")
  Print("Add OSWALD Abilities: HOVER")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Hover")
  Print("Add OSWALD Abilities: TOSS")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Toss")
  Print("Add OSWALD Abilities: COOPMOVE")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "CoopMove")
  Print("Add OSWALD Abilities: EARLIFT")
  UnlockAbility(GetPlayerOrAI(PLAYER_TWO), "Earlift")
  if (HasCollectible("FilmReel_EM2_OldMill1") == true) then
    if (AlreadyCheckedFilmReel == false) then
      OldMill1_Pickups = (OldMill1_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_OldMill")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (OldMill1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  return 
end
OldMill1_CountTicket = function()
  Print("one ticket still here")
  OldMill1_Pickups = (OldMill1_Pickups + 1)
  return 
end
OldMill1_CheckOnPickup = function()
  Print("Picked up item")
  OldMill1_Pickups = (OldMill1_Pickups - 1)
  if (OldMill1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
OldMill1_E3_GiveAbilitiesCheck = function()
  if (GetConfigVariableBool("InDemoMode") == true) then
    UnlockAllAbilities()
  end
  return 
end
OldMill1_ClearSpawnTransforms = function()
  Print("OldMill1_ClearSpawnTransforms function entered")
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  return 
end
OldMill1_2DTransitionSetup = function(target)
  Print("***OldMill1_2DTransitionSetup")
  local data = GetPrefabData(target)
  local global = GetGlobal("EM2_EpisodeCheck")
  Print(("OldMill1_2DTransitionSetup: Episode " .. global))
  OswaldClearOverrideTeleportDistance()
  if (OldMill1_ActionSpotsEnabled == true) then
    OldMill1_ActionSpotsEnabled = false
    DecrementAbilityDisabled(GetPlayer(), "Toss")
  end
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  if (data.Film_Position == "Left") then
    Print("OldMill1_2DTransitionSetup: Film_Position = Left so we are Heading to Gulch Lab")
    SetGlobal("FTL_Gulch_ProjectorExit", 1)
  elseif (data.Film_Position == "Right") then
    Print("OldMill1_2DTransitionSetup: Film_Position = Right so we are Heading to Dragon Boss")
    if (2 <= global) then
      data.ActivatedLevels = "FTL_BlotworxDragon.SecondVisit"
    else
      data.ActivatedLevels = "FTL_BlotworxDragon.Main"
    end
    SetGlobal("FTL_Gulch_ProjectorExit", 3)
  end
  SetupPosition(target)
  return 
end
OldMill1_CheckCharacterSides = function()
  Print("OldMill1_CheckCharacterSides function entered")
  while true do
    wait(0)
  end
  Print(("OldMill1_CheckCharacterSides 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
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
  Print(((("OldMill1_CheckCharacterSides: Mickey is " .. tostring(MickeySide)) .. " and Oswald is ") .. tostring(OswaldSide)))
  if (MickeySide == OswaldSide) then
    Print("OldMill1_CheckCharacterSides: Mickey and Oswald are on same side")
    if (GetEntity("trn_oldmill_01a.ETicket_Oswald_NIF 02") ~= nil) then
      Enable("OldMill1_GoldTicketToss")
    end
  else
    Print("OldMill1_CheckCharacterSides: Mickey and Oswald are on opposite sides, calling OldMill1_OswaldSplitFollow()")
    OswaldOverrideTeleportDistance(nil, 100)
    IncrementAbilityDisabled(GetPlayer(), "Toss")
    OldMill1_ActionSpotsEnabled = true
    FireThread(OldMill1_OswaldSplitFollow)
  end
  return 
end
OldMill1_OswaldSplitFollow = function()
  if (OldMill1_ActionSpotsEnabled == true) then
    local pos = GetPosition(GetPlayer())
    local num = 0
    pos = pos.y
    if (pos < 13.199999809265137) then
      num = 1
    elseif (13.199999809265137 <= pos) then
      if (pos < 22.600000381469727) then
        num = 2
      end
    elseif (22.600000381469727 <= pos) then
      if (pos < 31.899999618530273) then
        num = 3
      end
    elseif (31.899999618530273 <= pos) then
      if (pos < 41) then
        num = 4
      end
    elseif (41 <= pos) then
      if (pos < 52.5) then
        num = 5
      end
    elseif (52.5 <= pos) then
      num = 6
    end
    if (OswaldPastCollision == true) then
      if (OswaldSide == "Left") then
        num = 6
      elseif (num < 5) then
        num = 5
      end
    end
    if (0 < num) then
      if (num ~= previousNum) then
        Print(((((("OldMill1_OswaldSplitFollow updating action spot from " .. OswaldSide) .. tostring(previousNum)) .. " to ") .. OswaldSide) .. tostring(num)))
        Enable((("OldMill1_ActionSpot_" .. OswaldSide) .. tostring(num)))
        Print("OldMill1_OswaldSplitFollow Resetting Oswald teleport countdown timer")
        QueueBrainEvent(GetOswaldAI(), BRAIN_ResetOswaldCallForHelpTimer)
        wait(0.10000000149011612)
        if (0 < previousNum) then
          Disable((("OldMill1_ActionSpot_" .. OswaldSide) .. tostring(previousNum)))
        end
        previousNum = num
      end
    else
      Print("OldMill1_OswaldSplitFollow num = 0")
    end
    wait(0.5)
    FireThread(OldMill1_OswaldSplitFollow)
  end
  return 
end
OldMill1_ActionSpotsDone = function()
  Print("OldMill1_ActionSpotsDone function entered")
  if (OldMill1_ActionSpotsEnabled == true) then
    OldMill1_ActionSpotsEnabled = false
    DecrementAbilityDisabled(GetPlayer(), "Toss")
    Print("OldMill1_ActionSpotsDone is deactivating action spots")
    wait(1)
    local (for index), (for limit), (for step) = 1, 6, 1
    for x = (for index), (for limit), (for step) do
      Disable(("OldMill1_ActionSpot_Left" .. tostring(x)))
      Disable(("OldMill1_ActionSpot_Right" .. tostring(x)))
    end
    OswaldStartFollowAction()
    Print("OldMill1_ActionSpotsDone has deactivated spots, Oswald should be following now")
    if (GetEntity("trn_oldmill_01a.ETicket_Oswald_NIF 02") ~= nil) then
      Enable("OldMill1_GoldTicketToss")
    end
  end
  return 
end
OldMill1_CharacterPastOneWayCollision = function(character)
  Print("OldMill1_CharacterPastOneWayCollision function entered")
  if (character == GetPlayer()) then
    MickeyPastCollision = true
    if (MickeySide == "Left") then
      OverrideSpawnTransform(PLAYER_ONE, GetPosition("Marker_SpawnPastCollisionLeft_Mickey"), GetFacing("Marker_SpawnPastCollisionLeft_Mickey"))
    else
      OverrideSpawnTransform(PLAYER_ONE, GetPosition("Marker_SpawnPastCollisionRight_Mickey"), GetFacing("Marker_SpawnPastCollisionRight_Mickey"))
      OswaldPastCollision = true
      if (OswaldSide == "Left") then
        OverrideSpawnTransform(PLAYER_TWO, GetPosition("Marker_SpawnPastCollisionLeft_Oswald"), GetFacing("Marker_SpawnPastCollisionLeft_Oswald"))
      else
        OverrideSpawnTransform(PLAYER_TWO, GetPosition("Marker_SpawnPastCollisionRight_Oswald"), GetFacing("Marker_SpawnPastCollisionRight_Oswald"))
      end
    end
  else
    OswaldPastCollision = true
    if (OswaldSide == "Left") then
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("Marker_SpawnPastCollisionLeft_Oswald"), GetFacing("Marker_SpawnPastCollisionLeft_Oswald"))
    else
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("Marker_SpawnPastCollisionRight_Oswald"), GetFacing("Marker_SpawnPastCollisionRight_Oswald"))
    end
  end
  if (MickeySide ~= OswaldSide) then
    if (MickeyPastCollision == true) then
      if (OswaldPastCollision == true) then
        OldMill1_ActionSpotsDone()
      end
    end
  end
  return 
end
