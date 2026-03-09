BaldMountain1_Pickups = 0
MusicEventVar = 0
AlreadyCheckedFilmReel = false
BaldMountain1_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  if (HasCollectible("FilmReel_EM2_BaldMountain1") == true) then
    if (AlreadyCheckedFilmReel == false) then
      BaldMountain1_Pickups = (BaldMountain1_Pickups - 1)
      Print(BaldMountain1_Pickups)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_BaldMountain")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (BaldMountain1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  return 
end
BaldMountain1_CountTicket = function()
  Print("one ticket still here")
  BaldMountain1_Pickups = (BaldMountain1_Pickups + 1)
  Print(BaldMountain1_Pickups)
  return 
end
BaldMountain1_CheckOnPickup = function()
  Print("Picked up item")
  BaldMountain1_Pickups = (BaldMountain1_Pickups - 1)
  Print(BaldMountain1_Pickups)
  if (BaldMountain1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
local MickeySide = "Back"
local OswaldSide = "Front"
Bald1_CheckOswaldTrack = function()
  Print("Bald1_CheckOswaldTrack function entered")
  while true do
    wait(0)
  end
  Print("Bald1_CheckOswaldTrack 2dDirection is fully set")
  if (string.sub(tostring(GetGlobal("2dDirection")), -1, -1) == "2") then
    Print("Bald1_CheckOswaldTrack Oswald in back track, enabling action spot by gold ticket tower")
    Enable("Bald1_ActionSpotGoldTicketTower")
    OswaldSide = "Back"
  end
  return 
end
Bald1_CheckMickeyTrack = function(target)
  Print("Bald1_CheckMickeyTrack function entered")
  while true do
    wait(0)
  end
  Print("Bald1_CheckMickeyTrack 2dDirection is fully set")
  if (string.sub(tostring(GetGlobal("2dDirection")), -2, -2) == "1") then
    Print("Bald1_CheckMickeyTrack Mickey in front track, enabling trigger volume to jump attack window boards")
    Enable(target)
    MickeySide = "Front"
  end
  return 
end
Bald1_CheckTossState = function(character)
  Print("Bald1_CheckTossState function entered")
  if (character == GetPlayer()) then
    MickeySide = "Front"
  else
    OswaldSide = "Front"
  end
  if (MickeySide == OswaldSide) then
    Print("Bald1_CheckTossState both characters in front, calling Prefab_MultiTrack_EnableToss")
    Prefab_MultiTrack_EnableToss("2DMountGulchtoMSN")
  end
  return 
end
Bald1_2DTransitionSetup = function(target)
  Print("***Bald1_2DTransitionSetup")
  local data = GetPrefabData(target)
  local visit = "2"
  local global = GetGlobal("EM2_EpisodeCheck")
  Print(("Bald1_2DTransitionSetup: Episode " .. global))
  if (data.Film_Position == "Right") then
    Print("Bald1_2DTransitionSetup: Film_Position = Right so we are Heading to Gulch")
    if (GetGlobal("FTL_Gulch_DepositedBalls") == 0) then
      data.ActivatedLevels = "FTL_Gulch.Canyon_v1"
    else
      data.ActivatedLevels = "FTL_Gulch.Canyon_v2"
      if (data.Film_Position == "Left") then
        Print("Bald1_2DTransitionSetup: Film_Position = Left so we are Heading to RBC")
        if (global == 1) then
          data.ActivatedLevels = "RBC_falls.Caverns_Angel_v1"
        else
          data.ActivatedLevels = "RBC_falls.Caverns_Angel_v2"
        end
      end
    end
  elseif (data.Film_Position == "Left") then
    Print("Bald1_2DTransitionSetup: Film_Position = Left so we are Heading to RBC")
    if (global == 1) then
      data.ActivatedLevels = "RBC_falls.Caverns_Angel_v1"
    else
      data.ActivatedLevels = "RBC_falls.Caverns_Angel_v2"
    end
  end
  SetupPosition(target)
  return 
end
Bald1_DisableCollisionOnGraveRock = function(target)
  SetPropertyInt(target, "Collision Layer", 13)
  return 
end
Bald1_ManageOswaldAssistMickey = function(target, action, node1)
  Print("***Bald1_ManageOswaldAssistMickey")
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
