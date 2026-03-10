Building1_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
local Building1_ActionSpotsEnabled = false
local MickeySide = "Left"
local OswaldSide = "Left"
local previousNum = -1
Building1_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  if (HasCollectible("FilmReel_EM2_Building1") == true) then
    if (AlreadyCheckedFilmReel == false) then
      Building1_Pickups = (Building1_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_Building")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (Building1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  return 
end
Building1_CountTicket = function()
  Print("one ticket still here")
  Building1_Pickups = (Building1_Pickups + 1)
  return 
end
Building1_CheckOnPickup = function()
  Print("Picked up item")
  Building1_Pickups = (Building1_Pickups - 1)
  if (Building1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
Building1_2DTransitionSetup = function(target)
  Print("***Building1_2DTransitionSetup")
  local data = GetPrefabData(target)
  local visit = "2"
  local global = GetGlobal("EM2_EpisodeCheck")
  Print(("Building1_2DTransitionSetup: Episode " .. global))
  OswaldClearOverrideTeleportDistance()
  SetGlobal("RF_ReverseAngel", 1)
  if (Building1_ActionSpotsEnabled == true) then
    Building1_ActionSpotsEnabled = false
    DecrementAbilityDisabled(GetPlayer(), "Toss")
  end
  if (data.Film_Position == "Left") then
    Print("Building1_2DTransitionSetup: Film_Position = Left so we are Heading to RBF")
    if (global < 2) then
      visit = "1"
    end
    data.ActivatedLevels = ("RBC_falls.MachineRoomV" .. visit)
  elseif (data.Film_Position == "Right") then
    Print("Building1_2DTransitionSetup: Film_Position = Right so we are Heading to RBC")
    if (global == 1) then
      data.ActivatedLevels = "RBC_falls.Caverns_Angel_v1"
    else
      data.ActivatedLevels = "RBC_falls.Caverns_Angel_v2"
    end
  end
  SetupPosition(target)
  return 
end
Building1_CheckCharacterSides = function()
  Print("Building1_CheckCharacterSides function entered")
  while true do
    wait(0)
  end
  Print(("Building1_CheckCharacterSides 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
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
  Print(((("Building1_CheckCharacterSides: Mickey is " .. tostring(MickeySide)) .. " and Oswald is ") .. tostring(OswaldSide)))
  if (MickeySide == OswaldSide) then
    Print("Building1_CheckCharacterSides: Mickey and Oswald are on same side")
    wait(4)
    if (GetEntity("trn_building_01a.ETicket_Oswald_NIF 02") ~= nil) then
      Enable("trn_building_01a.hiddenoswald_action 02.Marker(BuddyAIAction) 01")
    end
    if (GetEntity("trn_building_01a.ETicket_Oswald_NIF 03") ~= nil) then
      Enable("trn_building_01a.hiddenoswald_action 01.Marker(BuddyAIAction) 01")
    end
  else
    Print("Building1_CheckCharacterSides: Mickey and Oswald are on opposite sides, calling Building1_OswaldSplitFollow()")
    if (OswaldSide == "Left") then
      Enable("trn_building_01a.TriggerBase 03")
    end
    OswaldOverrideTeleportDistance(nil, 100)
    IncrementAbilityDisabled(GetPlayer(), "Toss")
    Building1_ActionSpotsEnabled = true
    FireThread(Building1_OswaldSplitFollow)
    if (OswaldSide == "Right") then
      pauseJumpVolumeWait("trn_building_01a.prefab_jumpvolmovingplatform 05.prefab_jumpvolumewait 02.TargetToSend")
    end
  end
  return 
end
Building1_OswaldSplitFollow = function()
  if (Building1_ActionSpotsEnabled == true) then
    local pos = GetPosition(GetPlayer())
    local num = 0
    pos = pos.y
    if (pos < 6.199999809265137) then
      num = 1
    elseif (6.199999809265137 <= pos) then
      if (pos < 13.600000381469727) then
        num = 2
      end
    elseif (13.600000381469727 <= pos) then
      if (pos < 25.5) then
        num = 3
      end
    elseif (25.5 <= pos) then
      if (pos < 38) then
        num = 4
      end
    elseif (38 <= pos) then
      if (pos < 48.70000076293945) then
        num = 5
      end
    elseif (48.70000076293945 <= pos) then
      num = 6
    end
    if (0 < num) then
      if (num ~= previousNum) then
        Print(((((("Building1_OswaldSplitFollow updating action spot from " .. OswaldSide) .. tostring(previousNum)) .. " to ") .. OswaldSide) .. tostring(num)))
        Enable((("Building1_ActionSpot_" .. OswaldSide) .. tostring(num)))
        Print("Building1_OswaldSplitFollow Resetting Oswald teleport countdown timer")
        QueueBrainEvent(GetOswaldAI(), BRAIN_ResetOswaldCallForHelpTimer)
        wait(0.10000000149011612)
        if (0 < previousNum) then
          Disable((("Building1_ActionSpot_" .. OswaldSide) .. tostring(previousNum)))
        end
        previousNum = num
      end
    else
      Print("Building1_OswaldSplitFollow num = 0")
    end
    wait(0.5)
    FireThread(Building1_OswaldSplitFollow)
  end
  return 
end
Building1_ActionSpotsDone = function(target, side)
  Print("Building1_ActionSpotsDone function entered")
  if (Building1_ActionSpotsEnabled == true) then
    if (side ~= "Plane") then
    end
    Building1_ActionSpotsEnabled = false
    DecrementAbilityDisabled(GetPlayer(), "Toss")
    Print("Building1_ActionSpotsDone is deactivating action spots")
    wait(1)
    for x = 1, 6 do
      Disable(("Building1_ActionSpot_Left" .. tostring(x)))
      Disable(("Building1_ActionSpot_Right" .. tostring(x)))
    end
    OswaldStartFollowAction()
    if (GetEntity("trn_building_01a.ETicket_Oswald_NIF 02") ~= nil) then
      Enable("trn_building_01a.hiddenoswald_action 02.Marker(BuddyAIAction) 01")
    end
    if (GetEntity("trn_building_01a.ETicket_Oswald_NIF 03") ~= nil) then
      Enable("trn_building_01a.hiddenoswald_action 01.Marker(BuddyAIAction) 01")
    end
    Print("Building1_ActionSpotsDone has deactivated spots, Oswald should be following now")
  end
  return 
end
Building1_ManageOswaldAssistMickey = function(target, action, node1)
  Print("***Building1_ManageOswaldAssistMickey")
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

