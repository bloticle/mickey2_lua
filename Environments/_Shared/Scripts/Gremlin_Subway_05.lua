gs_BallManager = function(target, ballNum)
  if (ballNum == 1) then
    return "DEC05_Ball_01"
  end
  return 
end
gs05_StartUp = function(target)
  AudioEffectStart("trn_gremlinsubway_05a_audio.reverb")
  local data = GetPrefabData("DEC_fromFloat2D")
  SetHorizontalSplit(GetPlayer())
  local questID, stageID = Quest_GetCriticalPath()
  if (stageID == "Critical_Gulch2_2") then
    Quest_SetCriticalPath("Critical_DEC", "Critical_DEC_7")
  end
  Prefab_DECFoopToob_Finish()
  ForEachEntityInGroup(SetEntityToNotCollideWithBuddyAI, "Oswald2DAvoidObject")
  if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
    data.HARDLOAD[2] = "FTL_FloatGraveyard.A1_IGC"
  elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
    data.HARDLOAD[2] = "FTL_FloatGraveyard.A1_v1"
  elseif (GetGlobal("OST_Moody_Destination") == 4) then
    data.HARDLOAD[2] = "FTL_FloatGraveyard.A1_Pirate"
  else
    data.HARDLOAD[2] = "FTL_FloatGraveyard.A1_v2"
  end
  return 
end
gs05_CheckpointSave = function()
  wait(0.10000000149011612)
  SaveCheckpointNoPosition("gs05_StartUp")
  return 
end
local CharacterFacing = 0
gs05_SetFacingLeft = function(activator)
  Print(((("gs05_SetFacingLeft: function entered, activator is " .. tostring(GetName(activator))) .. " and CharacterFacing = ") .. tostring(CharacterFacing)))
  if (CharacterFacing < 3) then
    if (activator == GetPlayer()) then
      if (CharacterFacing == 0) then
        SetFacing(activator, vector4(0, 90, 0))
        CharacterFacing = 1
      elseif (CharacterFacing == 2) then
        SetFacing(activator, vector4(0, 90, 0))
        CharacterFacing = 3
        if (CharacterFacing == 0) then
          SetFacing(activator, vector4(0, 90, 0))
          CharacterFacing = 2
        elseif (CharacterFacing == 1) then
          SetFacing(activator, vector4(0, 90, 0))
          CharacterFacing = 3
          DestroyEntity("TriggerSetFacingLeft")
        end
      end
    elseif (CharacterFacing == 0) then
      SetFacing(activator, vector4(0, 90, 0))
      CharacterFacing = 2
    elseif (CharacterFacing == 1) then
      SetFacing(activator, vector4(0, 90, 0))
      CharacterFacing = 3
      DestroyEntity("TriggerSetFacingLeft")
    end
  else
    DestroyEntity("TriggerSetFacingLeft")
  end
  return 
end
local PieChargedByTV = false
PieHasBeenChargedByTV = function(target)
  PieChargedByTV = true
  Print("PieHasBeenChargedByTV: PieChargedByTV set to true")
  return 
end
local PieCount = 0
PieHasBeenSmashed = function(target)
  if (PieChargedByTV == true) then
    Print("PieHasBeenSmashed: PieChargedByTV is true")
    Print("PieHasBeenSmashed: Stopping pie gears")
    wait(0.5)
    ForEachEntityInGroup(Disable, "PieGears1")
  else
    PieCount = (PieCount + 1)
    Print(("PieHasBeenSmashed: PieCount is " .. tostring(PieCount)))
    if (PieCount == 3) then
      Print("PieHasBeenSmashed: Stopping pie gears")
      wait(0.5)
      ForEachEntityInGroup(Disable, "PieGears1")
    end
  end
  return 
end
gs05_addCamera = function(player, camVal)
  local camPrefix = "Marker(CameraOverride)_O_"
  if (player == GetPlayer()) then
    camPrefix = "Marker(CameraOverride)_M_"
  end
  SetCameraAttributesForPlayer((camPrefix .. camVal), player)
  return 
end
gs05_subtractCamera = function(player, camVal)
  local camPrefix = "Marker(CameraOverride)_O_"
  if (player == GetPlayer()) then
    camPrefix = "Marker(CameraOverride)_M_"
  end
  ClearCameraAttributesForPlayer((camPrefix .. camVal), player, 1)
  return 
end
gs05_EnterToob_toFloatYard = function()
  if (GetGlobal("2dDirection") == 1) then
    GiveCollectible("Challenge_TunnelMouse__DEC5_Tracker")
  end
  return 
end
gs05_EnterToob_toFort = function()
  if (GetGlobal("2dDirection") == 0) then
    GiveCollectible("Challenge_TunnelMouse__DEC5_Tracker")
  end
  return 
end
AI_Oswald = 1
gs_BallReady = 0
gs_PlayerReady = 0
gs_Ball_OnTee = function()
  gs_BallReady = 1
  if (gs_PlayerReady == 1) then
    gs_OswaldShocksHammer()
  end
  return 
end
gs_Ball_OffTee = function()
  gs_BallReady = 0
  return 
end
gs_OswaldShocksHammer = function()
  if (AI_Oswald == 1) then
    MoveToEntity("Oswald", "gremlinsubway_05a_dynamic.OswaldPath_PositionMarker 01")
    Hide("gremlinsubway_05a_dynamic.OswaldPath_Trigger 01")
    OswaldStreamAction("gremlinsubway_05a_dynamic.OswaldPath_PositionMarker 02")
    wait(5)
    OswaldStreamPause()
    Unhide("gremlinsubway_05a_dynamic.OswaldPath_Trigger 01")
  end
  return 
end
gs_Player_Hammer_Ready = function()
  gs_PlayerReady = 1
  if (gs_BallReady == 1) then
    gs_OswaldShocksHammer()
  end
  return 
end
gs_Player_Hammer_NotReady = function()
  gs_PlayerReady = 0
  return 
end
gs_fingerGas_On = function()
  Enable("fingerWheel_01a_inert 02")
  SplineFollower_SetDisabled("fingerGas", false)
  SplineFollower_SetDisabled("fingerMagnet", false)
  Enable("MagnetGear")
  ForEachEntityInGroup(SplineFollower_SetDisabled, "fingerGas_weight01", false)
  ForEachEntityInGroup(Enable, "PieGears1")
  return 
end
gs05_FerrisToggle = function(target)
  Print(("gs05_FerrisToggle triggered by: " .. tostring(GetName(target))))
  if (GetName(target) == "gremlinsubway_05a_static.TRN_gremlinSubway_05a_ferrisWheelPlatform 01") then
    enableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolmovingplatform 01.prefab_jumpvolumewait 01.TargetToSend")
    disableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolmovingplatform 04.prefab_jumpvolumewait 01.TargetToSend")
    disableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolumewait 01.TargetToSend")
    enableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolumewait 02.TargetToSend")
    pauseJumpVolumeWait("gremlinsubway_05a_static.prefab_jumpvolumewait 02.TargetToSend")
    wait(1)
    resumeJumpVolumeWait("gremlinsubway_05a_static.prefab_jumpvolumewait 02.TargetToSend")
  elseif (GetName(target) == "gremlinsubway_05a_static.TRN_gremlinSubway_05a_ferrisWheelPlatform 04") then
    enableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolmovingplatform 04.prefab_jumpvolumewait 01.TargetToSend")
    disableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolmovingplatform 05.prefab_jumpvolumewait 01.TargetToSend")
    disableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolumewait 04.TargetToSend")
    enableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolumewait 01.TargetToSend")
    pauseJumpVolumeWait("gremlinsubway_05a_static.prefab_jumpvolumewait 01.TargetToSend")
    wait(1)
    resumeJumpVolumeWait("gremlinsubway_05a_static.prefab_jumpvolumewait 01.TargetToSend")
  elseif (GetName(target) == "gremlinsubway_05a_static.TRN_gremlinSubway_05a_ferrisWheelPlatform 03") then
    enableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolmovingplatform 05.prefab_jumpvolumewait 01.TargetToSend")
    disableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolmovingplatform 06.prefab_jumpvolumewait 01.TargetToSend")
    disableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolumewait 03.TargetToSend")
    enableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolumewait 04.TargetToSend")
    pauseJumpVolumeWait("gremlinsubway_05a_static.prefab_jumpvolumewait 04.TargetToSend")
    wait(1)
    resumeJumpVolumeWait("gremlinsubway_05a_static.prefab_jumpvolumewait 04.TargetToSend")
  elseif (GetName(target) == "gremlinsubway_05a_static.TRN_gremlinSubway_05a_ferrisWheelPlatform 02") then
    enableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolmovingplatform 06.prefab_jumpvolumewait 01.TargetToSend")
    disableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolmovingplatform 01.prefab_jumpvolumewait 01.TargetToSend")
    disableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolumewait 02.TargetToSend")
    enableJumpVolumeAvailability("gremlinsubway_05a_static.prefab_jumpvolumewait 03.TargetToSend")
    pauseJumpVolumeWait("gremlinsubway_05a_static.prefab_jumpvolumewait 03.TargetToSend")
    wait(1)
    resumeJumpVolumeWait("gremlinsubway_05a_static.prefab_jumpvolumewait 03.TargetToSend")
  end
  return 
end
gs_ConfettiHorn = function(target, horn, confettiFX)
  AnimGBReset(horn)
  AnimGBSequence(horn, "blow")
  wait(0.5)
  AudioPostEventOn(horn, "Play_sfx_dec_confetti_blast")
  StartEmitters(confettiFX)
  wait(1)
  StartEmitters(confettiFX)
  wait(0.5)
  AnimGBSequence(horn, "rest")
  wait(0.5)
  StopEmitters(confettiFX)
  return 
end
gs05_TicketsGiven = 0
gs05_TicketButton = function()
  if (gs05_TicketsGiven < 4) then
    local attach = function(index)
      SetPropertyInt("TicketSpawner 01", "Index To Spawn", index, 0)
      return ForceSpawn("TicketSpawner 01", 1)[1]
    end
    AnimGBReset("TRN_gremlinSubway_confettiPopper_01a_inert 04")
    AnimGBSequence("TRN_gremlinSubway_confettiPopper_01a_inert 04", "blow")
    wait(0.5)
    AudioPostEventOn("TRN_gremlinSubway_confettiPopper_01a_inert 04", "Play_sfx_dec_confetti_blast")
    local reward = 0
    if (gs05_TicketsGiven < 3) then
      reward = attach(2)
      Print((("Spaning E Ticket " .. gs05_TicketsGiven) .. " "))
    elseif (gs05_TicketsGiven == 3) then
      reward = attach(1)
      Print((("Spaning C Ticket " .. gs05_TicketsGiven) .. " "))
    end
    wait(0)
    local proj = attach(0)
    SetParentEntity(reward, proj)
    ApplyImpulse(proj, -2, 4, 0)
    wait(1.5)
    ClearParent(reward)
    DestroyEntity(proj)
    AnimGBSequence("TRN_gremlinSubway_confettiPopper_01a_inert 04", "rest")
    gs05_TicketsGiven = (gs05_TicketsGiven + 1)
  else
    Print((("Ticket Spawner Exhausted! " .. gs05_TicketsGiven) .. "Tickets already given!"))
  end
  return 
end
