OldMill3_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
local OldMill3_CoopLeft = false
local OldMill3_CoopRight = false
local OldMill3_CoopOnce = 0
local OldMill3_ActionSpotsEnabled = false
local MickeySide = "Left"
local OswaldSide = "Left"
local previousNum = -1
local MickeyPastCollision = false
local OswaldPastCollision = false
local OldMill3_LeftSideClosed = false
local MickeyCoopWoodLeft = false
local MickeyCoopWoodRight = false
OldMill3_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  if (HasCollectible("FilmReel_EM2_OldMill3") == true) then
    if (AlreadyCheckedFilmReel == false) then
      OldMill3_Pickups = (OldMill3_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_OldMill")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (OldMill3_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  return 
end
OldMill3_CountTicket = function()
  Print("one ticket still here")
  OldMill3_Pickups = (OldMill3_Pickups + 1)
  return 
end
OldMill3_CheckOnPickup = function()
  Print("Picked up item")
  OldMill3_Pickups = (OldMill3_Pickups - 1)
  if (OldMill3_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
OldMill3_Left = function(target, value)
  if (value == "Add") then
    Print("OldMill3_Left Add")
    OldMill3_CoopLeft = true
    if (target == GetPlayer()) then
      MickeyCoopWoodLeft = true
      if (OldMill3_ActionSpotsEnabled == false) then
        FireThread(OldMill3_DoCoopWoodOswaldSplitFollowDisabled)
      end
    end
    OldMill3_CheckCoopStates()
  else
    Print("OldMill3_Left Subtract")
    OldMill3_CoopLeft = false
    if (target == GetPlayer()) then
      MickeyCoopWoodLeft = false
      if (OldMill3_ActionSpotsEnabled == false) then
        Disable("OldMill3_ActionSpot_Right99")
      end
    end
  end
  return 
end
OldMill3_Right = function(target, value)
  if (value == "Add") then
    Print("OldMill3_Right Add")
    OldMill3_CoopRight = true
    if (target == GetPlayer()) then
      MickeyCoopWoodRight = true
      if (OldMill3_ActionSpotsEnabled == false) then
        FireThread(OldMill3_DoCoopWoodOswaldSplitFollowDisabled)
      end
    end
    OldMill3_CheckCoopStates()
  else
    Print("OldMill3_Right Subtract")
    OldMill3_CoopRight = false
    if (target == GetPlayer()) then
      MickeyCoopWoodRight = false
      if (OldMill3_ActionSpotsEnabled == false) then
        Disable("OldMill3_ActionSpot_Left77")
      end
    end
  end
  return 
end
OldMill3_DoCoopWoodOswaldSplitFollowDisabled = function()
  if (MickeyCoopWoodLeft == true) then
    Enable("OldMill3_ActionSpot_Right99")
  end
  if (MickeyCoopWoodRight == true) then
    if (OswaldSide == "Left") then
      Enable("OldMill3_ActionSpot_Left77")
    end
  end
  return 
end
OldMill3_CheckCoopStates = function()
  Print(((((("OldMill3_CheckCoopStates function entered, Once is " .. tostring(OldMill3_CoopOnce)) .. ", Left is ") .. tostring(OldMill3_CoopLeft)) .. ", Right is ") .. tostring(OldMill3_CoopRight)))
  if (OldMill3_CoopOnce == 0) then
    OldMill3_CoopOnce = 9
    Print("OldMill3_CheckCoopStates initial break")
    AnimGBSequence("trn_oldmill_03a.TRN_oldMill_collapsewood05A_03a 01", "action", true)
    AudioPostEventOn("trn_oldmill_03a.TRN_oldMill_collapsewood05A_03a 01", "Play_sfx_OM_WoodPlatform_Destroy")
  elseif (OldMill3_CoopOnce == 9) then
    while true do
      wait(0.10000000149011612)
    end
  end
  if (OldMill3_CoopOnce == 1) then
    if (OldMill3_CoopLeft == true) then
      if (OldMill3_CoopRight == true) then
        OldMill3_CoopOnce = 2
        Print("OldMill3_CheckCoopStates full break")
        AnimGBSequence("trn_oldmill_03a.TRN_oldMill_collapsewood05A_03a 01", "fall")
        AudioPostEventOn("trn_oldmill_03a.TRN_oldMill_collapsewood05A_03a 01", "Play_sfx_OM_WoodPlatform_Destroy")
        Disable("trn_oldmill_03a.TriggerBase_CoopWood_Left 01")
        Disable("trn_oldmill_03a.TriggerBase_CoopWood_Right 01")
        MickeyCoopWoodLeft = false
        MickeyCoopWoodRight = false
        Disable("OldMill3_ActionSpot_Left77")
        Disable("OldMill3_ActionSpot_Left99")
        Enable("trn_oldmill_03a.TriggerDamageBase 04")
      end
    end
  end
  return 
end
OldMill3_SetCoopOnce = function()
  Print("OldMill3_SetCoopOnce function entered")
  OldMill3_CoopOnce = 1
  return 
end
OldMill3_2DTransitionSetup = function(target)
  Print("***OldMill3_2DTransitionSetup")
  local data = GetPrefabData(target)
  local global = GetGlobal("EM2_EpisodeCheck")
  Print(("OldMill3_2DTransitionSetup: Episode " .. global))
  OswaldClearOverrideTeleportDistance()
  if (OldMill3_ActionSpotsEnabled == true) then
    OldMill3_ActionSpotsEnabled = false
    DecrementAbilityDisabled(GetPlayer(), "Toss")
  end
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  if (data.Film_Position == "Left") then
    SetGlobal("FTL_FloatGraveyard_AliceProjector", 2)
    Print("OldMill3_2DTransitionSetup: Film_Position = Left so we are Heading to Float")
    if (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
      if (GetCurrentCount("BunnyChildren_FloatGraveyard") ~= 5) then
        Print("OldMill3_2DTransitionSetup: Loading Bunnies")
        data.ActivatedLevels = "FTL_FloatGraveyard.A4_Bunny"
      end
    else
      Print("OldMill3_2DTransitionSetup: Loading Normal A4_v2")
      data.ActivatedLevels = "FTL_FloatGraveyard.A4_v2"
      if (data.Film_Position == "Right") then
        Print("OldMill3_2DTransitionSetup: Film_Position = Right so we are Heading to Prescott Arena")
        if (3 <= global) then
          data.ActivatedLevels = "FTL_PrescottsArena.OutsideV2"
        else
          data.ActivatedLevels = "FTL_PrescottsArena.Thinner"
        end
      end
    end
  elseif (data.Film_Position == "Right") then
    Print("OldMill3_2DTransitionSetup: Film_Position = Right so we are Heading to Prescott Arena")
    if (3 <= global) then
      data.ActivatedLevels = "FTL_PrescottsArena.OutsideV2"
    else
      data.ActivatedLevels = "FTL_PrescottsArena.Thinner"
    end
  end
  SetupPosition(target)
  return 
end
OldMill3_ClearSpawnTransforms = function()
  Print("OldMill3_ClearSpawnTransforms function entered")
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  return 
end
OldMill3_CheckCharacterSides = function()
  Print("OldMill3_CheckCharacterSides function entered")
  while true do
    wait(0)
  end
  Print(("OldMill3_CheckCharacterSides 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
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
  Print(((("OldMill3_CheckCharacterSides: Mickey is " .. tostring(MickeySide)) .. " and Oswald is ") .. tostring(OswaldSide)))
  if (MickeySide == OswaldSide) then
    Print("OldMill3_CheckCharacterSides: Mickey and Oswald are on same side")
  else
    Print("OldMill3_CheckCharacterSides: Mickey and Oswald are on opposite sides, calling OldMill3_OswaldSplitFollow()")
    OswaldOverrideTeleportDistance(nil, 100)
    IncrementAbilityDisabled(GetPlayer(), "Toss")
    OldMill3_ActionSpotsEnabled = true
    FireThread(OldMill3_OswaldSplitFollow)
  end
  return 
end
OldMill3_OswaldSplitFollow = function()
  if (OldMill3_ActionSpotsEnabled == true) then
    local pos = GetPosition(GetPlayer())
    local num = 0
    pos = pos.y
    if (pos < 5) then
      num = 1
    elseif (5 <= pos) then
      if (pos < 17.5) then
        num = 2
      end
    elseif (17.5 <= pos) then
      if (pos < 29.799999237060547) then
        num = 3
      end
    elseif (29.799999237060547 <= pos) then
      if (pos < 41.29999923706055) then
        num = 4
      end
    elseif (41.29999923706055 <= pos) then
      if (pos < 52.29999923706055) then
        num = 5
      end
    elseif (52.29999923706055 <= pos) then
      num = 6
    end
    if (OldMill3_LeftSideClosed == true) then
      if (OswaldSide == "Left") then
        if (num < 5) then
          num = 5
        end
      end
    end
    if (OswaldPastCollision == true) then
      num = 6
    end
    if (num == 6) then
      if (MickeyCoopWoodLeft == true) then
        num = 99
      end
      if (MickeyCoopWoodRight == true) then
        if (OswaldSide == "Left") then
          num = 77
        end
      end
    end
    if (0 < num) then
      if (num ~= previousNum) then
        Print(((((("OldMill3_OswaldSplitFollow updating action spot from " .. OswaldSide) .. tostring(previousNum)) .. " to ") .. OswaldSide) .. tostring(num)))
        Enable((("OldMill3_ActionSpot_" .. OswaldSide) .. tostring(num)))
        Print("OldMill3_OswaldSplitFollow Resetting Oswald teleport countdown timer")
        QueueBrainEvent(GetOswaldAI(), BRAIN_ResetOswaldCallForHelpTimer)
        wait(0.10000000149011612)
        if (0 < previousNum) then
          Disable((("OldMill3_ActionSpot_" .. OswaldSide) .. tostring(previousNum)))
        end
        previousNum = num
      end
    else
      Print("OldMill3_OswaldSplitFollow num = 0")
    end
    wait(0.5)
    FireThread(OldMill3_OswaldSplitFollow)
  end
  return 
end
OldMill3_ActionSpotsDone = function(target, side)
  Print("OldMill3_ActionSpotsDone function entered")
  if (OldMill3_ActionSpotsEnabled == true) then
    OldMill3_ActionSpotsEnabled = false
    DecrementAbilityDisabled(GetPlayer(), "Toss")
    Print("OldMill3_ActionSpotsDone is deactivating action spots")
    wait(1)
    for x = 1, 6 do
      Disable(("OldMill3_ActionSpot_Left" .. tostring(x)))
      Disable(("OldMill3_ActionSpot_Right" .. tostring(x)))
    end
    OswaldStartFollowAction()
    Print("OldMill3_ActionSpotsDone has deactivated spots, Oswald should be following now")
  end
  return 
end
OldMill3_CharacterPastOneWayCollision = function(character, side)
  Print("OldMill3_CharacterPastOneWayCollision function entered")
  if (side == "Left") then
    OldMill3_LeftSideClosed = true
    if (MickeySide == "Left") then
      OverrideSpawnTransform(PLAYER_ONE, GetPosition("Marker_SpawnPastCollisionLeft_Mickey"), GetFacing("Marker_SpawnPastCollisionLeft_Mickey"))
    end
    if (OswaldSide == "Left") then
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("Marker_SpawnPastCollisionLeft_Oswald"), GetFacing("Marker_SpawnPastCollisionLeft_Oswald"))
    end
  else
    if (character == GetPlayer()) then
      if (MickeyPastCollision == false) then
        MickeyPastCollision = true
        OverrideSpawnTransform(PLAYER_ONE, GetPosition("Marker_SpawnPastCollisionRight_Mickey"), GetFacing("Marker_SpawnPastCollisionRight_Mickey"))
      end
    elseif (OswaldPastCollision == false) then
      OswaldPastCollision = true
      OverrideSpawnTransform(PLAYER_TWO, GetPosition("Marker_SpawnPastCollisionRight_Oswald"), GetFacing("Marker_SpawnPastCollisionRight_Oswald"))
    end
    if (MickeySide ~= OswaldSide) then
      if (MickeyPastCollision == true) then
        if (OswaldPastCollision == true) then
          OldMill3_ActionSpotsDone()
        end
      end
    end
  end
  return 
end

