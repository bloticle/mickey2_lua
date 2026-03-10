Building2_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
local Building2_ActionSpotsEnabled = false
local MickeySide = "Bottom"
local OswaldSide = "Bottom"
local Building2_TopDoorOpen = 0
local Building2_BottomDoorOpen = 0
local previousNum = -1
local TopDoorOpened = false
local BottomDoorOpened = false
Building2_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  if (HasCollectible("FilmReel_EM2_Building2") == true) then
    if (AlreadyCheckedFilmReel == false) then
      Building2_Pickups = (Building2_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_Building")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (Building2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  return 
end
Building2_CountTicket = function()
  Print("one ticket still here")
  Building2_Pickups = (Building2_Pickups + 1)
  return 
end
Building2_CheckOnPickup = function()
  Print("Picked up item")
  Building2_Pickups = (Building2_Pickups - 1)
  if (Building2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
Building2_TopDoorCheck = function(target, source)
  if (source == "Switch") then
    Building2_TopDoorOpen = 1
    wait(1.5)
    Building2_TopDoorOpen = 2
  elseif (source == "Trigger") then
    if (0 < Building2_TopDoorOpen) then
      if (Building2_TopDoorOpen == 1) then
        while true do
          wait(0.10000000149011612)
        end
      end
      AnimGBSequence("trn_building_02a.TRN_Building_Door_02a 04", "close")
      AnimGBSequence("trn_building_02a.TRN_building_Switch_01a 04", "Idle")
      wait(1.5)
      Enable("trn_building_02a.TRN_Building_Box_01a 04")
      Building2_TopDoorOpen = 0
      if (OswaldSide == "Top") then
        if (MickeySide == "Bottom") then
          Enable("trn_building_02a.TriggerBase 09")
          Enable("trn_building_02a.TriggerBase 11")
        end
      end
    end
  end
  return 
end
Building2_BottomDoorCheck = function(target, source)
  if (source == "Switch") then
    Building2_BottomDoorOpen = 1
    wait(1.5)
    Building2_BottomDoorOpen = 2
  elseif (source == "Trigger") then
    if (0 < Building2_BottomDoorOpen) then
      if (Building2_BottomDoorOpen == 1) then
        while true do
          wait(0.10000000149011612)
        end
      end
      AnimGBSequence("trn_building_02a.TRN_Building_Door_02a 05", "close")
      AnimGBSequence("trn_building_02a.TRN_building_Switch_01a 05", "Idle")
      wait(1.5)
      Enable("trn_building_02a.TRN_Building_Box_01a 02")
      Building2_BottomDoorOpen = 0
      if (OswaldSide == "Bottom") then
        if (MickeySide == "Top") then
          Enable("trn_building_02a.TriggerBase 10")
          Enable("trn_building_02a.TriggerBase 12")
        end
      end
    end
  end
  return 
end
Building2_OswaldAtDoorDoorOpen = function(target, side)
  if (side == "Top") then
    if (Building2_TopDoorOpen == 0) then
      AnimGBSequence("trn_building_02a.TRN_Building_Door_02a 04", "open")
    end
  elseif (side == "Bottom") then
    if (Building2_BottomDoorOpen == 0) then
      AnimGBSequence("trn_building_02a.TRN_Building_Door_02a 05", "open")
    end
  end
  return 
end
Building2_2DTransitionSetup = function(target)
  Print("***Building2_2DTransitionSetup")
  local data = GetPrefabData(target)
  SetGlobal("FTL_FloatGraveyard_A2CheckpointLocation", 1)
  OswaldClearOverrideTeleportDistance()
  if (Building2_ActionSpotsEnabled == true) then
    Building2_ActionSpotsEnabled = false
    DecrementAbilityDisabled(GetPlayer(), "Toss")
  end
  if (data.Film_Position == "Left") then
    Print("Building2_2DTransitionSetup: Film_Position = Left so we are Heading to Fort Wasteland")
    data.ActivatedLevels = "FTL_Fort01a.V2_Fort_ALTunnel"
  elseif (data.Film_Position == "Right") then
    Print("Building2_2DTransitionSetup: Film_Position = Right so we are Heading to Floatyard")
    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
      data.ActivatedLevels = "FTL_FloatGraveyard.A2_IGC"
    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
      data.ActivatedLevels = "FTL_FloatGraveyard.A2_v1"
    else
      data.ActivatedLevels = "FTL_FloatGraveyard.A2_v2"
    end
  end
  SetupPosition(target)
  return 
end
Building2_CheckCharacterSides = function()
  Print("Building2_CheckCharacterSides function entered")
  while true do
    wait(0)
  end
  Print(("Building2_CheckCharacterSides 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
  if (string.sub(tostring(GetGlobal("2dDirection")), -2, -2) == "1") then
    MickeySide = "Bottom"
  else
    MickeySide = "Top"
  end
  if (string.sub(tostring(GetGlobal("2dDirection")), -1, -1) == "1") then
    OswaldSide = "Bottom"
  else
    OswaldSide = "Top"
  end
  Print(((("Building2_CheckCharacterSides: Mickey is " .. tostring(MickeySide)) .. " and Oswald is ") .. tostring(OswaldSide)))
  if (MickeySide == OswaldSide) then
    Print("Building2_CheckCharacterSides: Mickey and Oswald are on same side")
    if (OswaldSide == "Top") then
      wait(4)
      Enable("Building2_OswaldTossActionSpot")
    end
  else
    Print("Building2_CheckCharacterSides: Mickey and Oswald are on opposite sides, calling Building2_OswaldSplitFollow()")
    OswaldOverrideTeleportDistance(nil, 130)
    IncrementAbilityDisabled(GetPlayer(), "Toss")
    Building2_ActionSpotsEnabled = true
    FireThread(Building2_OswaldSplitFollow)
    if (OswaldSide == "Top") then
      Enable("trn_building_02a.TriggerBase 07")
      Enable("trn_building_02a.TriggerBase 09")
    elseif (OswaldSide == "Bottom") then
      Enable("trn_building_02a.TriggerBase 10")
    end
  end
  return 
end
Building2_OswaldSplitFollow = function()
  if (Building2_ActionSpotsEnabled == true) then
    local pos = GetPosition(GetPlayer())
    local num = 0
    pos = pos.z
    if (pos < -56.5) then
      num = 1
    elseif (-56.5 <= pos) then
      if (pos < -40.20000076293945) then
        num = 2
      end
    elseif (-40.20000076293945 <= pos) then
      if (pos < -25.700000762939453) then
        num = 3
      end
    elseif (-25.700000762939453 <= pos) then
      if (pos < -13.100000381469727) then
        num = 4
      end
    elseif (-13.100000381469727 <= pos) then
      if (pos < -1.5) then
        num = 5
      end
    elseif (-1.5 <= pos) then
      if (pos < 11.199999809265137) then
        num = 6
      end
    elseif (11.199999809265137 <= pos) then
      if (pos < 26.700000762939453) then
        num = 7
      end
    elseif (26.700000762939453 <= pos) then
      if (pos < 44.29999923706055) then
        num = 8
      end
    elseif (44.29999923706055 <= pos) then
      num = 9
    end
    if (0 < num) then
      if (num ~= previousNum) then
        Print(((((("Building2_OswaldSplitFollow updating action spot from " .. OswaldSide) .. tostring(previousNum)) .. " to ") .. OswaldSide) .. tostring(num)))
        Enable((("Building2_ActionSpot_" .. OswaldSide) .. tostring(num)))
        Print("Building2_OswaldSplitFollow Resetting Oswald teleport countdown timer")
        QueueBrainEvent(GetOswaldAI(), BRAIN_ResetOswaldCallForHelpTimer)
        wait(0.10000000149011612)
        if (0 < previousNum) then
          Disable((("Building2_ActionSpot_" .. OswaldSide) .. tostring(previousNum)))
        end
        previousNum = num
      end
    else
      Print("Building2_OswaldSplitFollow num = 0")
    end
    wait(0.5)
    FireThread(Building2_OswaldSplitFollow)
  end
  return 
end
Building2_ActionSpotsDone = function(target, side)
  Print("Building2_ActionSpotsDone function entered")
  if (side == "Top") then
    TopDoorOpened = true
  elseif (side == "Bottom") then
    BottomDoorOpened = true
  end
  if (Building2_ActionSpotsEnabled == true) then
    if (TopDoorOpened == true) then
      if (BottomDoorOpened == true) then
        Building2_ActionSpotsEnabled = false
        DecrementAbilityDisabled(GetPlayer(), "Toss")
        Print("Building2_ActionSpotsDone is deactivating action spots")
        wait(1)
        for x = 1, 9 do
          Disable(("Building2_ActionSpot_Top" .. tostring(x)))
          Disable(("Building2_ActionSpot_Bottom" .. tostring(x)))
        end
        OswaldStartFollowAction()
        Print("Building2_ActionSpotsDone has deactivated spots, Oswald should be following now")
        Enable("Building2_OswaldTossActionSpot")
      end
    end
  end
  return 
end

