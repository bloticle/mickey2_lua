Service2_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
Service2_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  if (HasCollectible("FilmReel_EM2_ServiceStation2") == true) then
    if (AlreadyCheckedFilmReel == false) then
      Service2_Pickups = (Service2_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_ServiceStation")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (Service2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  return 
end
Service2_CountTicket = function()
  Print("one ticket still here")
  Service2_Pickups = (Service2_Pickups + 1)
  return 
end
Service2_CheckOnPickup = function()
  Print("Picked up item")
  Service2_Pickups = (Service2_Pickups - 1)
  if (Service2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
Service2_2DTransitionSetup = function(target)
  Print((("***Service2_2DTransitionSetup called by " .. GetName(target)) .. "!!"))
  local data = GetPrefabData(target)
  local visit = "2"
  local global = GetGlobal("EM2_EpisodeCheck")
  Print(("Service2_2DTransitionSetup: Episode " .. global))
  SetGlobal("Autotopia_HardLoad", 0)
  if (data.Film_Position == "Right") then
    Print("Service2_2DTransitionSetup: Film_Position = Right so we are Heading to Autotopia")
    if (global == 4) then
      if (GetGlobal("Autotopia_Core_Progression") == 1) then
        data.ActivatedLevels = "TCY_autotopia_visit1.Main_Visit2"
      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
        data.ActivatedLevels = "TCY_autotopia_visit1.SectionA_trial"
      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
        data.ActivatedLevels = "TCY_autotopia_visit1.SectionA_derby"
        if (GetGlobal("Autotopia_Core_Progression") == 0) then
          data.ActivatedLevels = "TCY_autotopia_visit1.SectionA_first"
        elseif (GetGlobal("Autotopia_Core_Progression") == 1) then
          data.ActivatedLevels = "TCY_autotopia_visit1.SectionG_first"
          if (data.Film_Position == "Left") then
            Print("Service2_2DTransitionSetup: Film_Position = Left so we are Heading to Ventureland")
            SetGlobal("VTL_Oasis_Checkpoint_ZoneMapLoad", 2)
            if (global == 4) then
              data.ActivatedLevels = "VTL_Oasis.Expansion_Epilogue"
            else
              data.ActivatedLevels = "VTL_Oasis.Expansion_MainStory"
            end
          end
        end
      end
    elseif (GetGlobal("Autotopia_Core_Progression") == 0) then
      data.ActivatedLevels = "TCY_autotopia_visit1.SectionA_first"
    elseif (GetGlobal("Autotopia_Core_Progression") == 1) then
      data.ActivatedLevels = "TCY_autotopia_visit1.SectionG_first"
      if (data.Film_Position == "Left") then
        Print("Service2_2DTransitionSetup: Film_Position = Left so we are Heading to Ventureland")
        SetGlobal("VTL_Oasis_Checkpoint_ZoneMapLoad", 2)
        if (global == 4) then
          data.ActivatedLevels = "VTL_Oasis.Expansion_Epilogue"
        else
          data.ActivatedLevels = "VTL_Oasis.Expansion_MainStory"
        end
      end
    end
  elseif (data.Film_Position == "Left") then
    Print("Service2_2DTransitionSetup: Film_Position = Left so we are Heading to Ventureland")
    SetGlobal("VTL_Oasis_Checkpoint_ZoneMapLoad", 2)
    if (global == 4) then
      data.ActivatedLevels = "VTL_Oasis.Expansion_Epilogue"
    else
      data.ActivatedLevels = "VTL_Oasis.Expansion_MainStory"
    end
  end
  SetupPosition(target)
  return 
end
local MickeyBouncing = 0
local OswaldBouncing = 0
Service2_BoardBounce = function(character)
  if (character == GetPlayer()) then
    if (MickeyBouncing == 0) then
      MickeyBouncing = 1
      ApplyImpulse(character, 0, 6200, 0)
      wait(1)
      MickeyBouncing = 0
    end
  elseif (OswaldBouncing == 0) then
    OswaldBouncing = 1
    ApplyImpulse(character, 0, 6200, 0)
    wait(1)
    OswaldBouncing = 0
  end
  return 
end
local MickeyKnockedBack = 0
local OswaldKnockedBack = 0
Service2_KnockbackLeft = function(character)
  if (character == GetPlayer()) then
    if (MickeyKnockedBack == 0) then
      MickeyKnockedBack = 1
      ApplyImpulse(character, 0, 1000, -7000)
    end
  elseif (OswaldKnockedBack == 0) then
    OswaldKnockedBack = 1
    ApplyImpulse(character, 0, 1000, -7000)
  end
  return 
end
Service2_KnockbackRight = function(character)
  if (character == GetPlayer()) then
    if (MickeyKnockedBack == 0) then
      MickeyKnockedBack = 1
      ApplyImpulse(character, 0, 1000, 7000)
    end
  elseif (OswaldKnockedBack == 0) then
    OswaldKnockedBack = 1
    ApplyImpulse(character, 0, 1000, 7000)
  end
  return 
end
Service2_MovePlayerUpInHouse = function(target)
  local MickPos = GetPosition(target)
  SetPositionFloat(target, MickPos.x, (MickPos.y + 0.44999998807907104), MickPos.z)
  return 
end
Service2_ActivatorToFrontPlane = function(character, teleLoc)
  Print("Service2_ActivatorToFrontPlane function entered")
  Prefab_MultiTrack_DisableControls("2DFromVTLToAUT_MultiTrack", character)
  wait(0.10000000149011612)
  if (character == GetPlayer()) then
    SetMickeyPlaneWithTeleport("2DFromVTLToAUT_MultiTrack", 0, teleLoc)
  else
    SetOswaldPlaneWithTeleport("2DFromVTLToAUT_MultiTrack_Oswald", 0, teleLoc)
  end
  wait(0.10000000149011612)
  Prefab_MultiTrack_EnableControls("2DFromVTLToAUT_MultiTrack", character)
  Prefab_MultiTrack_EnableToss("2DFromVTLToAUT_MultiTrack")
  return 
end
Service2_GoldTicketTeeterSetup = function()
  if (GetEntity("trn_servicestation_02b.ETicket_Oswald_NIF 01") ~= nil) then
    TeleportToEntity("trn_servicestation_02b.ETicket_Oswald_NIF 01", "gspawnloc")
  else
    TeleportToEntity("trn_servicestation_02b.ETicket_C_Nif_SmallRadius 01", "gspawnloc")
  end
  if (GetEntity("trn_servicestation_02b.ETicket_Oswald_NIF 01b") ~= nil) then
    TeleportToEntity("trn_servicestation_02b.ETicket_Oswald_NIF 01b", "gspawnloc2")
  else
    TeleportToEntity("trn_servicestation_02b.ETicket_C_Nif_SmallRadius 02", "gspawnloc2")
  end
  return 
end
Remove_TeleportTrigger = function()
  Wait(5)
  DestroyEntity("InsideHouseMoveMickeyTrigger")
  return 
end
Service2_ManageOswaldAssistMickey = function(target, action, node1)
  Print("***Service2_ManageOswaldAssistMickey")
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

