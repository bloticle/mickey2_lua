BandConcert1_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
BandConcert1_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  if (HasCollectible("FilmReel_EM2_BandConcert1") == true) then
    if (AlreadyCheckedFilmReel == false) then
      BandConcert1_Pickups = (BandConcert1_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_BandConcert")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (BandConcert1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  return 
end
BandConcert1_CountTicket = function()
  Print("one ticket still here")
  BandConcert1_Pickups = (BandConcert1_Pickups + 1)
  return 
end
BandConcert1_CheckOnPickup = function()
  Print("Picked up item")
  BandConcert1_Pickups = (BandConcert1_Pickups - 1)
  if (BandConcert1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
BandConcert1_2DTransitionSetup = function(target)
  Print("*** BandConcert1_2DTransitionSetup")
  SetGlobal("MSN_ProectorState", 1)
  SetupPosition(target)
  return 
end
local MickeyPushed = false
local OswaldPushed = false
BandConcert1_ShutterPush = function(character, direction)
  Print("BandConcert1_ShutterPush function entered")
  local impulse = -5000
  if (direction == "Left") then
    impulse = 5000
  end
  Print(("BandConcert1_ShutterPush impulse is " .. tostring(impulse)))
  if (character == GetPlayer()) then
    if (MickeyPushed == false) then
      MickeyPushed = true
      ApplyImpulse(character, 0, 0, impulse)
      Print("BandConcert1_ShutterPush impulsed Mickey")
      wait(1.5)
      MickeyPushed = false
    end
  elseif (OswaldPushed == false) then
    OswaldPushed = true
    ApplyImpulse(character, 0, 0, impulse)
    Print("BandConcert1_ShutterPush impulsed Oswald")
    wait(1.5)
    OswaldPushed = false
  end
  return 
end

