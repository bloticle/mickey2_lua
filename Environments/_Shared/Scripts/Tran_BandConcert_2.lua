BandConcert2_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
local TreeCam1Facing = vector4(0, 0, 0, 0)
local TreeCam2Facing = vector4(0, 0, 0, 0)
BandConcert2_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  if (HasCollectible("FilmReel_EM2_BandConcert2") == true) then
    if (AlreadyCheckedFilmReel == false) then
      BandConcert2_Pickups = (BandConcert2_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_BandConcert")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (BandConcert2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  wait(5)
  TreeCam1Facing = GetFacing("trn_bandconcert_02a.CameraControlPointSplineFollower 01")
  TreeCam2Facing = GetFacing("trn_bandconcert_02a.CameraControlPointSplineFollower 02")
  Print(("BandConcert2_CheckAtStart cached TreeCam1Facing at " .. tostring(TreeCam1Facing)))
  Print(("BandConcert2_CheckAtStart cached TreeCam2Facing at " .. tostring(TreeCam2Facing)))
  return 
end
BandConcert2_ResetSplineCamFacing = function(target)
  if (target == GetEntity("trn_bandconcert_02a.CameraControlPointSplineFollower 01")) then
    SetFacing(target, TreeCam1Facing)
  elseif (target == GetEntity("trn_bandconcert_02a.CameraControlPointSplineFollower 02")) then
    SetFacing(target, TreeCam2Facing)
  end
  return 
end
BandConcert2_CountTicket = function()
  Print("one ticket still here")
  BandConcert2_Pickups = (BandConcert2_Pickups + 1)
  return 
end
BandConcert2_CheckOnPickup = function()
  Print("Picked up item")
  BandConcert2_Pickups = (BandConcert2_Pickups - 1)
  if (BandConcert2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
FTL_FloatGraveyard_ManagePrescottStream = function()
  if (3 <= GetGlobal("EM2_EpisodeCheck")) then
    local data = GetPrefabData("toPrescottArenaPaint_Projector_Upper")
    data.TeleportToMarker = "ThinnerEntrance"
  end
  return 
end
BandConcert2_2DTransitionSetup = function(target)
  Print("***BandConcert2_2DTransitionSetup")
  local data = GetPrefabData(target)
  local global = GetGlobal("EM2_EpisodeCheck")
  Print(("BandConcert2_2DTransitionSetup: Episode " .. global))
  if (data.Film_Position == "Left") then
    Print("BandConcert2_2DTransitionSetup: Film_Position = Left so we are Heading to Float")
    SetGlobal("FTL_FloatGraveyard_AliceProjector", 1)
    if (GetGlobal("OST_BunnyQuest_QuestStarted") == 2) then
      if (GetCurrentCount("BunnyChildren_FloatGraveyard") ~= 5) then
        Print("BandConcert2_2DTransitionSetup: Loading Bunnies")
        data.ActivatedLevels = "FTL_FloatGraveyard.A4_Bunny"
      end
    else
      Print("BandConcert2_2DTransitionSetup: Loading Normal A4_v2")
      data.ActivatedLevels = "FTL_FloatGraveyard.A4_v2"
      if (data.Film_Position == "Right") then
        Print("BandConcert2_2DTransitionSetup: Film_Position = Right so we are Heading to Prescott Arena")
        if (3 <= global) then
          data.ActivatedLevels = "FTL_PrescottsArena.OutsideV2"
        else
          data.ActivatedLevels = "FTL_PrescottsArena.Paint"
        end
      end
    end
  elseif (data.Film_Position == "Right") then
    Print("BandConcert2_2DTransitionSetup: Film_Position = Right so we are Heading to Prescott Arena")
    if (3 <= global) then
      data.ActivatedLevels = "FTL_PrescottsArena.OutsideV2"
    else
      data.ActivatedLevels = "FTL_PrescottsArena.Paint"
    end
  end
  SetupPosition(target)
  return 
end
local MickeySide = false
local OswaldSide = false
Band2_CheckCharacterSides = function()
  Print("Band2_CheckCharacterSides function entered")
  while true do
    wait(0)
  end
  Print(("Band2_CheckCharacterSides 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
  if (string.sub(tostring(GetGlobal("2dDirection")), -2, -2) == "1") then
    MickeySide = "Front"
  else
    MickeySide = "Back"
  end
  if (string.sub(tostring(GetGlobal("2dDirection")), -1, -1) == "1") then
    OswaldSide = "Front"
  else
    OswaldSide = "Back"
  end
  Print(((("Band2_CheckCharacterSides: Mickey is " .. tostring(MickeySide)) .. " and Oswald is ") .. tostring(OswaldSide)))
  if (MickeySide == "Back") then
    if (OswaldSide == "Front") then
      Print("Band2_CheckCharacterSides: Mickey is in Back, Oswald is in Front, enabling goto node trigger")
      Enable("trn_bandconcert_02a.prefab_gotonodevolume 01.TriggerBase 01")
    end
  elseif (MickeySide == "Front") then
    if (OswaldSide == "Back") then
      Print("Band2_CheckCharacterSides: Mickey is in Front, Oswald is in Back, enabling oswald action spot on branch")
      Enable("trn_bandconcert_02a.hiddenoswald_action 01.Marker(BuddyAIAction) 01")
    end
  end
  return 
end
Band2_ManageOswaldAssistMickey = function(target, action, node1)
  Print("***Band2_ManageOswaldAssistMickey")
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

