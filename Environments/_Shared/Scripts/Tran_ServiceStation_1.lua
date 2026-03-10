Service1_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
Service1_CheckAtStart = function()
  ResetMusicEvent()
  Print("CheckAtStart Fired")
  if (HasCollectible("FilmReel_EM2_ServiceStation1") == true) then
    if (AlreadyCheckedFilmReel == false) then
      Service1_Pickups = (Service1_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_ServiceStation")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (Service1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  return 
end
Service1_CountTicket = function()
  Print("one ticket still here")
  Service1_Pickups = (Service1_Pickups + 1)
  return 
end
Service1_CheckOnPickup = function()
  Print("Picked up item")
  Service1_Pickups = (Service1_Pickups - 1)
  if (Service1_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
Service1_2DTransitionSetup = function(target)
  Print("***Service1_2DTransitionSetup")
  local data = GetPrefabData(target)
  local global = GetGlobal("EM2_EpisodeCheck")
  Print(("Service1_2DTransitionSetup: Episode " .. global))
  if (data.Film_Position == "Right") then
    Print("Service1_2DTransitionSetup: Film_Position = Right so we are Heading to Ventureland")
    if (global == 4) then
      if (GetGlobal("VTL_Oasis_Visit") ~= 3) then
        SetGlobal("VTL_Oasis_Visit", 3)
      end
      data.ActivatedLevels = "VTL_Oasis.Main_EpilogueLoadin"
    end
  elseif (data.Film_Position == "Left") then
    Print("Service1_2DTransitionSetup: Film_Position = Left so we are Heading to Mean Streets North")
    SetGlobal("MSN_ProectorState", 3)
  end
  SetupPosition(target)
  return 
end
Service1_CarJack01_Lock = function(activator)
  if (activator == GetPlayer()) then
    TeleportToEntity("trn_servicestation_01a.DynamicPropCarJack01_Lock 01", GetPlayer())
    SetParentEntity(activator, "trn_servicestation_01a.DynamicPropCarJack01_Lock 01")
  elseif (activator == GetPlayer2OrAI()) then
    TeleportToEntity("trn_servicestation_01a.DynamicPropCarJack01_Lock 02", GetPlayer2OrAI())
    SetParentEntity(activator, "trn_servicestation_01a.DynamicPropCarJack01_Lock 02")
  end
  return 
end
Service1_CarJack02_Lock = function(activator)
  if (activator == GetPlayer()) then
    TeleportToEntity("trn_servicestation_01a.DynamicPropCarJack02_Lock 01", GetPlayer())
    SetParentEntity(activator, "trn_servicestation_01a.DynamicPropCarJack02_Lock 01")
  elseif (activator == GetPlayer2OrAI()) then
    TeleportToEntity("trn_servicestation_01a.DynamicPropCarJack02_Lock 02", GetPlayer2OrAI())
    SetParentEntity(activator, "trn_servicestation_01a.DynamicPropCarJack02_Lock 02")
  end
  return 
end
Service1_SetNoCollision = function(target)
  Print(("Service1_SetNoCollision setting -no collision- layer on " .. tostring(GetName(target))))
  SetPropertyInt(target, "Collision Layer", 13)
  return 
end
Service1_ManageOswaldAssistMickey = function(target, action, node1)
  Print("***Service1_ManageOswaldAssistMickey")
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

