BaldMountain2_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
local Bald2_ActionSpotsEnabled = false
local MickeySide = "Left"
local OswaldSide = "Left"
local previousNum = -1
BaldMountain2_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  if (4 <= GetGlobal("EM2_EpisodeCheck")) then
    GetPrefabData("toNewRide_Projector_Upper").ActivatedLevels = "MST_NewRide.SecVLower"
  end
  if (HasCollectible("FilmReel_EM2_BaldMountain2") == true) then
    if (AlreadyCheckedFilmReel == false) then
      BaldMountain2_Pickups = (BaldMountain2_Pickups - 1)
      Print(BaldMountain2_Pickups)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_BaldMountain")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (BaldMountain2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  return 
end
Bald2_EnterFunction = function(target)
  Print("Bald2_EnterFunction function entered")
  OswaldClearOverrideTeleportDistance()
  if (Bald2_ActionSpotsEnabled == true) then
    Bald2_ActionSpotsEnabled = false
    DecrementAbilityDisabled(GetPlayer(), "Toss")
  end
  SetupPosition(target)
  return 
end
BaldMountain2_CountTicket = function()
  Print("one ticket still here")
  BaldMountain2_Pickups = (BaldMountain2_Pickups + 1)
  Print(BaldMountain2_Pickups)
  return 
end
BaldMountain2_CheckOnPickup = function()
  Print("Picked up item")
  BaldMountain2_Pickups = (BaldMountain2_Pickups - 1)
  Print(BaldMountain2_Pickups)
  if (BaldMountain2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
Bald2_CheckCharacterSides = function()
  Print("Bald2_CheckCharacterSides function entered")
  while true do
    wait(0)
  end
  Print(("Bald2_CheckCharacterSides 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
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
  Print(((("Bald2_CheckCharacterSides: Mickey is " .. tostring(MickeySide)) .. " and Oswald is ") .. tostring(OswaldSide)))
  if (MickeySide == OswaldSide) then
    Print("Bald2_CheckCharacterSides: Mickey and Oswald are on same side")
    if (GetEntity("trn_baldmountain_02a.ETicket_Oswald_NIF 01") ~= nil) then
      Enable("Bald2_GoldTicketActionSpot")
    end
  else
    Print("Bald2_CheckCharacterSides: Mickey and Oswald are on opposite sides, calling Bald2_OswaldSplitFollow()")
    OswaldOverrideTeleportDistance(nil, 120)
    IncrementAbilityDisabled(GetPlayer(), "Toss")
    Bald2_ActionSpotsEnabled = true
    FireThread(Bald2_OswaldSplitFollow)
  end
  if (OswaldSide == "Left") then
    enableJumpVolumeAvailability("trn_baldmountain_02a.prefab_jumpvolmovingplatform 08.prefab_jumpvolumewait 01.TargetToSend")
    enableJumpVolumeAvailability("trn_baldmountain_02a.prefab_jumpvolmovingplatform 09.prefab_jumpvolumewait 01.TargetToSend")
    wait(4)
    Disable("trn_baldmountain_02a.TriggerDamageBackTrackFire 01")
    AnimGBSequence("trn_baldmountain_02a.TRN_baldMountain_BackTrackFire 01", "disappeccr")
  end
  if (OswaldSide == "Right") then
    wait(4)
    Disable("trn_baldmountain_02a.TriggerDamageBackTrackFire 02")
    AnimGBSequence("trn_baldmountain_02a.TRN_baldMountain_BackTrackFire 02", "disappeccr")
  end
  return 
end
Bald2_OswaldSplitFollow = function()
  if (Bald2_ActionSpotsEnabled == true) then
    local pos = GetPosition(GetPlayer())
    local num = 0
    pos = pos.y
    if (pos < 6) then
      num = 1
    elseif (6 <= pos) then
      if (pos < 11.699999809265137) then
        num = 2
      end
    elseif (11.699999809265137 <= pos) then
      if (pos < 17.600000381469727) then
        num = 3
      end
    elseif (17.600000381469727 <= pos) then
      if (pos < 25.700000762939453) then
        num = 4
      end
    elseif (25.700000762939453 <= pos) then
      if (pos < 37.599998474121094) then
        num = 5
      end
    elseif (37.599998474121094 <= pos) then
      if (pos < 42.79999923706055) then
        num = 6
      end
    elseif (42.79999923706055 <= pos) then
      if (pos < 49) then
        num = 7
      end
    elseif (49 <= pos) then
      if (pos < 60) then
        num = 8
      end
    elseif (60 <= pos) then
      num = 9
    end
    if (0 < num) then
      if (num ~= previousNum) then
        Print(((((("Bald2_OswaldSplitFollow updating action spot from " .. OswaldSide) .. tostring(previousNum)) .. " to ") .. OswaldSide) .. tostring(num)))
        Enable((("Bald2_ActionSpot_" .. OswaldSide) .. tostring(num)))
        Print("Bald2_OswaldSplitFollow Resetting Oswald teleport countdown timer")
        QueueBrainEvent(GetOswaldAI(), BRAIN_ResetOswaldCallForHelpTimer)
        wait(0.10000000149011612)
        if (0 < previousNum) then
          Disable((("Bald2_ActionSpot_" .. OswaldSide) .. tostring(previousNum)))
        end
        previousNum = num
      end
    else
      Print("Bald2_OswaldSplitFollow num = 0")
    end
    wait(0.5)
    FireThread(Bald2_OswaldSplitFollow)
  end
  return 
end
Bald2_ActionSpotsDone = function()
  Print("Bald2_ActionSpotsDone function entered")
  if (Bald2_ActionSpotsEnabled == true) then
    Bald2_ActionSpotsEnabled = false
    DecrementAbilityDisabled(GetPlayer(), "Toss")
    Print("Bald2_ActionSpotsDone is deactivating action spots")
    wait(1)
    local (for index), (for limit), (for step) = 1, 9, 1
    for x = (for index), (for limit), (for step) do
      Disable(("Bald2_ActionSpot_Left" .. tostring(x)))
      Disable(("Bald2_ActionSpot_Right" .. tostring(x)))
    end
    OswaldStartFollowAction()
    Print("Bald2_ActionSpotsDone has deactivated spots, Oswald should be following now")
    if (GetEntity("trn_baldmountain_02a.ETicket_Oswald_NIF 01") ~= nil) then
      Enable("Bald2_GoldTicketActionSpot")
    end
  end
  return 
end
Bald2_ManageOswaldAssistMickey = function(target, action, node1)
  Print("***Bald2_ManageOswaldAssistMickey")
  local activator = GetName(_activator())
  if (action == "enter") then
    if (activator == GetName(GetPlayer())) then
      SetPropertyBool("OswaldAssistLeverGroup", "ActionSpotEnabled", true)
    end
  elseif (action == "exit") then
    if (activator == GetName(GetPlayer())) then
      SetPropertyBool("OswaldAssistLeverGroup", "ActionSpotEnabled", false)
    end
  end
  return 
end
