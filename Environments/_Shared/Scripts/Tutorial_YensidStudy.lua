TotalComets = 0
midLevel = 0
TelescopeThinned = 0
YSL_DebugTeleport = function(target, position)
  gusTV = 1
  ClearAllCameraAttributes()
  SetPropertyFloat(GetPlayer(), "Max Move Speed", 5)
  if (position == "2") then
    Enable("YS_BroomSpawner")
    DestroyEntity("tut_yensidstudy.Tut_YenSidStudy_Door01 01")
  end
  if (2 < tonumber(position)) then
    TeleportToEntity("YSL_DebugBrush", GetPlayer())
    ShowHud()
    SetGlobal("YSL_Yensid_2_SeeBrush_Played", 1)
  end
  DestroyEntity("ysl_yensidslab_scripting.TVIGCTrig")
  DestroyEntity("TVUseMarker")
  Enable("ysl_yensidslab_scripting.MickeyHouseTrigger2")
  Disable("ysl_yensidslab_mickeyhouse.MickeyHouseTrigger")
  return 
end
YSL_SetActiveMap = function(target, map)
  if (map == "both") then
    SetActiveSubMap(target)
    SetActiveFullMap(target)
  else
    SetActiveSubMap(target)
  end
  return 
end
YSL_SetHintFXLocation = function(target)
  local MickeyLoc = GetPosition(GetPlayer())
  SetTransformation(target, vector4(MickeyLoc.x, (MickeyLoc.y + 1.5), MickeyLoc.z), vector4(0, 0, 0))
  SetParentEntity(target, GetPlayer())
  return 
end
YSL_SetMarkersOnDeath = function(target, event)
  local subEvent = ReviveEvent_GetSubEvent(event)
  Print(subEvent)
  if (subEvent == ReviveEvent_Puddled) then
    ClearParent(target)
  elseif (subEvent == ReviveEvent_Respawn) then
    wait(1)
    YSL_SetHintFXLocation(target)
  end
  return 
end
YSL_Checkpoint = function(target, state)
  if (state == "brush") then
    YSL_SetActiveMap("ysl_yensidslab_shared.BrushRoomMapVolume", "both")
    SaveCheckpoint(GetPlayer(), "YSL_CheckpointReload", "YSL_BrushroomRespawn")
  else
  end
  return 
end
YSL_CheckpointReloadMap = function()
  YSL_CheckpointReload()
  SetCameraAttributesForPlayer("YS_HallwayCamOverride", GetPlayer())
  return 
end
YSL_CheckpointReload = function()
  if (GetGlobal("YSL_FoundBrush") == 0) then
    LockAbility(GetPlayer(), "Brush")
    LockAbility(GetPlayer(), "PaintBlast")
    LockAbility(GetPlayer(), "ThinnerBlast")
  end
  EnablePlayer(PLAYER_TWO, false)
  PlayerSetDripsVisible(GetPlayer(), false)
  EnableSplitScreen(false)
  if (GetGlobal("YSL_FoundBrush") == 0) then
    HideHud()
    SetCursorOnly(true)
  end
  return 
end
Tut_LevelSetup = function(target)
  if (GetGlobal("YSL_SetupLevel") == 0) then
    SetGlobal("YSL_SetupLevel", 1)
    EnablePlayer(PLAYER_TWO, false)
    EnableSplitScreen(false)
    PlayMovie(GetPlayer(), "fmv_intro.bik")
    StartFadeIn(0.800000011920929)
    HideHud()
    SetCursorOnly(true)
    UnlockAbility(GetPlayer(), "Use")
    UnlockAbility(GetPlayer(), "Bounce")
    HidePlayerTool(PLAYER_ONE)
    PlayerSetDripsVisible(GetPlayer(), false)
    YS_SlowMickey()
    SetDefaultCameraValues(7, 7, -1)
    SetTravelCameraValues(7, 7, -1)
    LockAbility(GetPlayer(), "Brush")
    LockAbility(GetPlayer(), "PaintBlast")
    LockAbility(GetPlayer(), "ThinnerBlast")
    SetCurrencyMax("ETicket", 99999)
    SetCurrencyMax("Cloth", 99999)
    SetCurrencyMax("ScrapMetal", 99999)
    SetCurrencyMax("Pins", 99999)
    GiveCollectibleNoPopup("Film_Intro")
    wait(0)
    Unmute()
    StartSweetMusic(target)
    wait(0.10000000149011612)
    SaveCheckpoint(GetPlayer(), "YSL_CheckpointReload", "V1ReloadTrigLoc")
  end
  return 
end
YS_MickeyHouseV1Reload = function()
  SetCameraAttributes("ysl_yensidslab_scripting.Marker(CameraOverride) 01")
  YSL_SetActiveMap("ysl_yensidslab_shared.MickeyHouseMapVolume", "both")
  Quest_SetCriticalPath("Critical_Yensid", "Critical_Yensid_6")
  YS_SlowMickey()
  return 
end
HideBrush = function(target)
  HidePlayerTool(PLAYER_ONE)
  return 
end
OnLoadHideBrush = function(target)
  if (GetGlobal("YSL_FoundBrush") == 0) then
    HidePlayerTool(PLAYER_ONE)
  end
  return 
end
GiveBrush = function(target)
  UnhidePlayerTool(PLAYER_ONE)
  return 
end
YS_SlowMickey = function()
  SetPropertyFloat(GetPlayer(), "Max Move Speed", 2.5)
  return 
end
YS_RegularMickey = function()
  SetPropertyFloat(GetPlayer(), "Max Move Speed", 5)
  return 
end
YSL_SetCustomDefaultCam = function()
  SetDefaultCameraValues(7, 10, -1)
  SetTravelCameraValues(7, 10, -1)
  return 
end
YSL_SetBrushFloorCameraValues = function()
  SetDefaultCameraValues(10, 14, -6)
  SetTravelCameraValues(10, 14, -6)
  return 
end
YS_SetPaintRoomCamera = function(target, side)
  if (side == "upper") then
    YSL_SetCustomDefaultCam()
  else
    YSL_SetBrushFloorCameraValues()
  end
  return 
end
YS_GrantAllStartQuests = function()
  FireSequence("YSL_SpiritOfWasteland_QuestGranter", "YSL_GrantQuests", 1)
  return 
end
YSL_TVIGC = function(target)
  if (gusTV == 0) then
    gusTV = 1
    DestroyEntity("UseTutorialTrig")
    Hide("TutUseIcon")
    Enable("ysl_yensidslab_scripting.MickeyHouseTrigger2")
    Disable("ysl_yensidslab_mickeyhouse.MickeyHouseTrigger")
    RestrictCutSceneInput()
    SetCursorOnly(false)
    PlayIGC("IGC_0050_IntroToTV")
    wait(3)
    SetCameraAttributesForPlayer("YS_HallwayCamOverride", GetPlayer())
  end
  return 
end
YS_JumpIntoTV = function()
  UnrestrictCutSceneInput()
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
  ResetDefaultCameraValues(GetPlayer())
  AnimGBSequence("YSL_TV", "startGlow")
  MirrorEnterProjector(GetPlayer(), 90, 0, "tut_yensidstudy.TeleportPositionMarker 01", "toLab")
  return 
end
YS_JumpIntoDJPainting = function(target)
  SetCursorOnly(false)
  RestrictCutSceneInput()
  Hide("DoubleJumpUseMarker")
  StartFadeOut(0.4000000059604645)
  wait(0.4000000059604645)
  TeleportToEntity(GetPlayer(), "YS_IntoJumpPaintingTeleport")
  wait(0.009999999776482582)
  SetCameraAttributes("YS_JumpPaintingOverride")
  wait(0.10000000149011612)
  StartFadeIn(0.4000000059604645)
  while true do
    if (not (LevelManager_HasStateFinishedStreaming() == false)) then
      break
    end
    wait(0.25)
  end
  while true do
    if (not (LevelManager_WaitingForStreamingSync() == false)) then
      break
    end
    Wait(0.05000000074505806)
  end
  MirrorEnterProjector(target, -1, 0, "YSL_BrushroomRespawn", "toPaintRoom", "true")
  return 
end
YS_JumpIntoBrushPainting = function(target)
  FireThread(ClearBlockTable)
  Hide("BrushRoomUseMarker")
  RestrictCutSceneInput()
  StartFadeOut(0.4000000059604645)
  wait(0.4000000059604645)
  TeleportToEntity(GetPlayer(), "YS_JumpIntoBrushPaintingMarker")
  wait(0.009999999776482582)
  SetCameraAttributes("YS_BrushPaintingOverride")
  wait(0.10000000149011612)
  StartFadeIn(0.4000000059604645)
  DestroyEntity("TVUseMarker")
  Enable("YS_MickeyHouseVistaCam")
  Disable("YS_MickeyHouseCamHintTrigger")
  MirrorEnterProjector(target, -1, 0, "YSL_MickeyHouseRespawn", "toMickeyHouse", "true")
  return 
end
YS_MirrorEnterAudio = function(IGC)
  if (IGC == "toLab") then
    AudioPostEventOn(GetPlayer(), "Play_sfx_tut_through_TV_enter")
  elseif (IGC == "toPaintRoom") then
    AudioPostEventOn(GetPlayer(), "Play_sfx_tut_through_mirror_enter")
    ReplaceMusicStateOverride("Stinger_Unique1")
    Print("Enter mirror music stinger")
    AudioPostEventOn("ysl_tutorial_01a_jumproom_audio.mirror_loop", "Play_sfx_ysl_dbljumproom_mirror_enter")
    AudioPostEventOn("Sounds_Double_Jump_Rooms_Loops", "Stop_sfx_YSL_watersplashLP_all")
    MultiPosSoundStop("ysl_yensidslab_audio.fountain_controller")
    AudioPostEventOn("ysl_yensidslab_audio.dbl_jmp_room_basement", "Stop_sfx_YSL_dbljumproom_rmbl")
    AudioPostEventOn(GetPlayer(), "Play_sfx_YSL_brushroom_rumble")
    AudioPostEventOn("ysl_tutorial_01a_brushroom_audio.brushroom_mirror_exit", "Play_sfx_ysl_brushroom_mirror_lp")
  elseif (IGC == "toMickeyHouse") then
    MultiPosSoundStop("ysl_tutorial_01a_brushroom_audio.OceanArray controller")
    AudioPostEventOn(GetPlayer(), "Play_sfx_tut_through_mirror_enter")
    AudioPostEventOn("ysl_tutorial_01a_brushroom_audio.brushroom_mirror_exit", "Play_sfx_ysl_brushroom_mirror_enter")
    ReplaceMusicStateOverride("Stinger_Unique1")
    Print("Enter mirror music stinger")
    ForEachEntityInGroup(Unhide, "YSL_ObservatoryAssets")
    AudioPostEventOn(GetPlayer(), "Stop_sfx_YSL_brushroom_rumble")
  end
  return 
end
MirrorEnterProjector = function(player, direction1, direction2, location, IGC, unrestrict)
  FireThread(YS_MirrorEnterAudio, IGC)
  local WAIT_JUMP_IN = 3
  local WAIT_JUMP_OUT = 0.8999999761581421
  local facing = vector4(tonumber(direction1), 0, tonumber(direction2))
  SetFacing(player, facing)
  RestrictCutSceneInput()
  wait(0.25)
  if (IGC == "toMickeyHouse") then
    while true do
      if (not (LevelManager_HasStateFinishedStreaming() == false)) then
        break
      end
      wait(0.25)
    end
    while true do
      if (not (LevelManager_WaitingForStreamingSync() == false)) then
        break
      end
      Wait(0.05000000074505806)
    end
  end
  DisableMotion_Player(player)
  DriveMotionWithPhysics(player)
  AnimEvent(player, EVENT_Special_0)
  wait(WAIT_JUMP_IN)
  if (IGC == "toLabUNUSED") then
    wait(0.4000000059604645)
    gusTV = 1
  else
  end
  TeleportMirror(location)
  DriveMotionWithPhysics(player)
  if (IGC == "toMickeyHouse") then
    PlayIGC("Mickey_YensidLab_Outro")
  else
    PlayIGC("Mickey_YensidLab")
  end
  wait(0.30000001192092896)
  StartFadeIn(0.5)
  wait(1)
  if (IGC == "toLab") then
    AudioPostEventOn("tut_yensidstudy_audio.enterLab_pt1", "Play_sfx_tut_through_mirror_land")
    wait(1.100000023841858)
    ReplaceMusicStateOverride("YSL_Mickey_house_intro")
    Print("Set music state to YSL_Mickey_house_intro")
  elseif (IGC == "toPaintRoom") then
    AudioPostEventOn("ysl_yensidslab_audio.enterCosmos", "Play_sfx_tut_through_mirror_land")
    wait(1.100000023841858)
    MultiPosSoundStart("ysl_tutorial_01a_brushroom_audio.OceanArray controller")
    ReplaceMusicStateOverride("YSL_Space_Comets0")
    Print("Set music state to YSL_Space_Comets0")
    SetCursorOnly(true)
  elseif (IGC == "toMickeyHouse") then
    MultiPosSoundStop("ysl_tutorial_01a_brushroom_audio.OceanArray controller")
    AudioPostEventOn(GetPlayer(), "Play_sfx_tut_through_mirror_land")
    wait(1.100000023841858)
    ReplaceMusicStateOverride("YSL_Mickey_house_thinner")
    Print("Set music state to YSL_Mickey_house_thinner")
  end
  EnableMotion_Player(player)
  FallFromAir(player)
  UnrestrictCutSceneInput()
  if (unrestrict == "true") then
    UnrestrictCutSceneInput()
  end
  if (unrestrict == "true") then
    UnrestrictCutSceneInput()
  end
  ClearCutSceneStack()
  return 
end
TeleportMirror = function(target)
  StartFadeOut(0.5)
  wait(0.5)
  TeleportToEntity(GetPlayer(), target)
  DriveMotionWithPhysics(target)
  wait(0)
  ClearAllCameraAttributes()
  wait(0)
  CameraReset()
  wait(0.800000011920929)
  return 
end
gusTV = 0
gusLine = 1
YS_GusTVStatic = function()
  if (gusTV == 0) then
    if (gusLine == 1) then
      gusLine = 2
      FireSequence("ysl_yensidslab_scripting.ConversationGus", "YSL_Gus_RandomCall1")
    elseif (gusLine == 2) then
      gusLine = 3
      FireSequence("ysl_yensidslab_scripting.ConversationGus", "YSL_Gus_RandomCall2")
    elseif (gusLine == 3) then
      gusLine = 1
      FireSequence("ysl_yensidslab_scripting.ConversationGus", "YSL_Gus_RandomCall3")
    end
    wait(8)
    FireThread(YS_GusTVStatic)
  end
  return 
end
hatGrabbed = 0
JumpTutIconShow = function()
  if (hatGrabbed == 0) then
    Unhide("TutUseIcon")
  end
  return 
end
WorldItemGrab = function()
  SetCursorOnly(false)
  RestrictCutSceneInput()
  hatGrabbed = 1
  TimerDisable("YSL_GlassHintTimer")
  DestroyEntity("YSL_GlassHintTimer")
  ForceInterruptSequence("ysl_yensidslab_scripting.ConversationYensid", "YSL_Yensid_1_BreakBottle")
  FireUser1("FancyCam1")
  DestroyEntity("ysl_yensidslab_maproom.HintFXTrigGlass")
  DestroyEntity("ysl_yensidslab_maproom.HintFXGlass")
  AudioSetState(GetPlayer(), "DX_YSL_Yensid", "None")
  ReplaceMusicStateOverride("YSL_Mickey_PU_Hat")
  Print("Set music state to YSL_Mickey_PU_Hat")
  wait(0.800000011920929)
  TeleportToEntity(GetPlayer(), "MickeyGrabHatMarker")
  wait(0)
  DestroyEntity("YSL_ShardGlass")
  DestroyEntity("ysl_yensidslab_maproom.Tut_MagicHatTable")
  local MickeyLoc = GetPosition(GetPlayer())
  AnimEvent(GetPlayer(), EVENT_Special_8)
  DestroyEntity("ysl_tutorial_01a_maproom_fx.YSL_glassDomeGLow_01a 01")
  SetTransformation("ysl_tutorial_01a_maproom_fx.YSL_magicHatGlow_01a 01", vector4(MickeyLoc.x, (MickeyLoc.y + 1.600000023841858), MickeyLoc.z), vector4(0, 0, 0))
  Unhide("ysl_tutorial_01a_maproom_fx.YSL_magicHatGlow_01a 01")
  StartEmitters("ysl_tutorial_01a_maproom_fx.YSL_magicHatGlow_01a 01")
  Enable("ysl_audio_trigger_jumproom")
  ForceSpawn("PreplacedBroomSpawner2", 1)
  wait(1)
  GiveCollectible("Costume_Sorcerers_Apprentice_1")
  SetGlobal("EM2_Costume_Sorcerer01", 1)
  AudioPostEventOn(GetPlayer(), "Play_sfx_ysl_magichat_magic")
  AnimGBSequence("YS_SpinAttackBook", "spinFall")
  DisableComponent("YS_SpinAttackBook", "Rotator")
  SetPropertyEntity("YS_SpinAttackBook", "RotateToEntity", "YSL_Wasteland")
  AnimGBSequence("YSL_SpinBookHologram", "turnOff")
  SetPropertyFloat("tut_yensidstudy.Tut_DoubleJumpBook01 02", "RotateToEntityDistance", 0)
  StartEmitters("ysl_tutorial_01a_maproom_fx.YSL_starDust_01a 01")
  wait(0.10000000149011612)
  Hide("tut_yensidstudy.Tut_YenSidStudy_Door01 01")
  wait(1)
  SetCameraAttributesForPlayer("ysl_yensidslab_maproom.BroomSpawnCamOverride", GetPlayer())
  ReleaseCamera(CAMERA_SAMEPLACE_TRANSITION, 0)
  wait(1)
  Enable("YS_BroomSpawner")
  ForceSpawn("PreplacedBroomSpawner1", 1)
  ForceSequence("GusConvo", "YSL_IGC_ForceConvoPose")
  wait(2.5)
  wait(5)
  StopEmitters("ysl_tutorial_01a_maproom_fx.YSL_magicHatGlow_01a 01")
  DestroyEntity("ysl_tutorial_01a_maproom_fx.YSL_magicHatGlow_01a 01")
  SetCameraAttributesForPlayer("YSL_BroomSpawnCam2", GetPlayer())
  wait(4)
  Quest_SetCriticalPath("Critical_Yensid", "Critical_Yensid_2")
  ForceInterruptSequence("GusConvo", "YSL_IGC_ForceConvoPose")
  ClearAllCameraAttributes(GetPlayer())
  UnrestrictCutSceneInput()
  SetCursorOnly(true)
  return 
end
EnableBroomCollision = function(target, state)
  local collision = GetChildEntityByIndex(target, 2)
  if (state ~= "noknockback") then
    wait(4.400000095367432)
    Enable("BroomSpawnKnockbackTrig")
    wait(1.5)
    Disable("BroomSpawnKnockbackTrig")
  end
  SetPropertyInt(collision, "Collision Layer", 2)
  return 
end
YS_HatTeleport = function()
  TeleportToEntity(GetPlayer(), "ysl_yensidslab_scripting.HatGetTeleportTrigger")
  CameraReset()
  return 
end
YS_HatSpinHint = function()
  if (GetGlobal("YSL_Yensid_1_BreakBottle_Played") == 0) then
    FireSequence("ysl_yensidslab_scripting.ConversationYensid", "YSL_Yensid_1_BreakBottle")
  end
  return 
end
YS_BroomBucketIdle = function(target)
  AnimEvent(target, EVENT_Special_0)
  return 
end
YS_SpawnBroom = function(target, broom)
  AnimEvent(target, EVENT_Special_3)
  if (broom ~= "placed") then
    AnimEvent("tut_yensidstudy_scripting.FantasiaBroom_ShardBucket", EVENT_Special_1)
  end
  return 
end
YS_StartBroomWalking = function(target, walk)
  if (walk ~= "skip") then
    local collision = GetChildEntityByIndex(_self(), 2)
    SetSplineFollowerInitialSpeed(_self(), 2)
    SetVulnerability(collision, ST_SPIN, 1)
  end
  AnimEvent(_self(), EVENT_Special_5)
  return 
end
YSL_StartPlacedBroom = function(target)
  SetSplineFollowerInitialSpeed(target, 2)
  return 
end
local YS_BroomReact_InProgress = false
YS_BroomReact = function(target, event, broom)
  local parentEntity = GetPropertyEntity(target, "Parent Entity", 0)
  if (YS_BroomReact_InProgress == false) then
    YS_BroomReact_InProgress = true
    Print("YS_BroomReact_InProgress = TRUE")
    if StimulusEvent_HasStimulusType(event, ST_SPIN) then
      Print((("   StimType = SPIN (" .. broom) .. ")"))
      if (broom == "pour") then
        AnimEvent(parentEntity, EVENT_Special_7)
      elseif (GetPropertyFloat(target, "Spin Vulnerability") == 1) then
        AnimEvent(parentEntity, EVENT_Special_6)
      elseif (GetPropertyFloat(target, "Spin Vulnerability") == 2) then
        AnimVarFloat(parentEntity, VAR_Hit_Blend, 1)
        wait(1)
        AnimVarFloat(parentEntity, VAR_Hit_Blend, 0)
        if StimulusEvent_HasStimulusType(event, ST_PAINT) then
          Print("   StimType = PAINT")
          AnimEvent(parentEntity, EVENT_Special_4)
        elseif StimulusEvent_HasStimulusType(event, ST_THINNER) then
          Print("   StimType = THINNER")
          if (GetPropertyFloat(target, "Contact Vulnerability") == 0) then
            AnimEvent(parentEntity, EVENT_Special_1)
          else
            Print("      Ignoring due to animation")
          end
        end
      end
    elseif StimulusEvent_HasStimulusType(event, ST_PAINT) then
      Print("   StimType = PAINT")
      AnimEvent(parentEntity, EVENT_Special_4)
    elseif StimulusEvent_HasStimulusType(event, ST_THINNER) then
      Print("   StimType = THINNER")
      if (GetPropertyFloat(target, "Contact Vulnerability") == 0) then
        AnimEvent(parentEntity, EVENT_Special_1)
      else
        Print("      Ignoring due to animation")
      end
    end
    Print("YS_BroomReact_InProgress = FALSE")
    YS_BroomReact_InProgress = false
  end
  return 
end
YS_BounceReact = function(target, state)
  local parentEntity = GetPropertyEntity(target, "Parent Entity", 0)
  if (YS_BroomReact_InProgress == false) then
    YS_BroomReact_InProgress = true
    if (GetPropertyFloat(target, "Spin Vulnerability") == 2) then
      AnimVarFloat(parentEntity, VAR_Hit_Blend, 2)
      wait(1)
      AnimVarFloat(parentEntity, VAR_Hit_Blend, 0)
    elseif (state == "pour") then
      AnimEvent(parentEntity, EVENT_Special_9)
    elseif (GetPropertyFloat(target, "Spin Vulnerability") == 1) then
      AnimEvent(parentEntity, EVENT_Special_8)
    end
    YS_BroomReact_InProgress = false
  end
  return 
end
YS_BroomTelescopeReact = function(target)
  if (YS_BroomReact_InProgress == false) then
    YS_BroomReact_InProgress = true
    if (GetPropertyFloat(target, "Contact Vulnerability") == 0) then
      AnimEvent(target, EVENT_Special_7)
    end
    YS_BroomReact_InProgress = false
  end
  return 
end
YS_BroomTelescopeReact_Disable = function()
  SetPropertyFloat(_self(), "Contact Vulnerability", 1)
  return 
end
YS_BroomTelescopeReact_Enable = function()
  SetPropertyFloat(_self(), "Contact Vulnerability", 0)
  return 
end
Broom_ScoopWater = function(target)
  local collision = GetChildEntityByIndex(target, 2)
  SetVulnerability(collision, ST_SPIN, 2)
  AnimEvent(target, EVENT_Special_0)
  return 
end
YSL_SetDoubleJumpRoomCamera = function()
  Print("DoubleJumpRoomCam")
  SetTravelCameraValues(8, 12, -9)
  SetDefaultCameraValues(8, 12, -9)
  return 
end
BrushGrab = function(target)
  SetCursorOnly(false)
  local brush = GetChildEntityByName(target, "MagicBrush")
  SetGlobal("YSL_FoundBrush", 1)
  RestrictCutSceneInput()
  CenterMouseCursor()
  FireUser1("FancyCam2")
  HideHud()
  wait(0.800000011920929)
  Hide("BrushVisualProp")
  StartEmitters("BrushFXSparkle")
  TeleportToEntity(GetPlayer(), "YS_BrushTutMarker")
  DestroyEntity("ysl_tutorial_01a_brushroom_fx.YSL_brushAttract_01a 01")
  Unhide("BrushGrabVisual")
  Quest_SetCriticalPath("Critical_Yensid", "Critical_Yensid_3")
  AnimEvent(GetPlayer(), EVENT_Special_8)
  ReplaceMusicStateOverride("Stinger_Moment")
  Print("Get brush music stinger")
  wait(1.7000000476837158)
  StopEmitters("BrushFXSparkle")
  UnhidePlayerTool(PLAYER_ONE)
  Hide("BrushGrabVisual")
  ReplaceMusicStateOverride("YSL_Space_Comets1")
  Print("Got brush so set music state to YenSid_comet1")
  wait(0.6000000238418579)
  FireUser3("FancyCam2")
  wait(0.699999988079071)
  FireThread(YS_TeachPaint)
  return 
end
YS_PaintRoomCleanup = function()
  ForEachEntityInGroup(DestroyEntity, "LevelCleanup1")
  ForEachEntityInGroup(DestroyEntity, "YSL_DoubleJumpRoomAssets")
  return 
end
YS_TeachPaint = function()
  SetCursorOnly(true)
  TeleportToEntity(GetPlayer(), "YS_BrushTutMarker2")
  SetCameraAttributesForPlayer("tut_yensidstudy_scripting.PaintTrainingCamOverride", GetPlayer())
  ShowHud()
  SetCursorOnly(false)
  DisableMovementInput(GetPlayer())
  Unhide("TutPaintIcon")
  return 
end
YS_TeachBlast = function()
  FireSequence("GusConvo", "Tutorial_PaintTrainingAlt1")
  return 
end
rockspainted = 0
YS_PaintStreamTraining = function()
  if (rockspainted == 0) then
    FireSequence("GusConvo", "Tutorial_PaintTrainingAlt2")
  else
    FireSequence("GusConvo", "Tutorial_PaintTrainingAlt2")
    wait(6)
    ForceInterruptSequence("GusConvo", "Tutorial_PaintTrainingAlt2")
  end
  return 
end
YSL_PaintStars = function(target, state)
  Print("PAINTING ALPHA FADE ZLKXCJ")
  if (state == "paint") then
    local (for index), (for limit), (for step) = 0, 1, 0.0333000011742115
    for i = (for index), (for limit), (for step) do
      StartEmitters(target)
      SetR3MTConstReg(target, 1, vector4(1, 1, 1, i))
      wait(0.0333000011742115)
    end
  else
    local (for index), (for limit), (for step) = 1, 0, -0.0333000011742115
    for i = (for index), (for limit), (for step) do
      (for index) = StopEmitters
      (for limit) = target
      (for index)((for limit))
      (for index) = SetR3MTConstReg
      (for limit) = target
      (for step) = 1
      i = vector4
      i = i(1, 1, 1, i)
      (for index)((for limit), (for step), i)
      (for index) = wait
      (for limit) = 0.0333000011742115
      (for index)((for limit))
    end
  end
  return 
end
comets = 0
YS_CometSounds = function(target, state)
  if (state == "paint") then
    SetGlobal("YSL_Comets", (GetGlobal("YSL_Comets") + 1))
  elseif (state == "thin") then
    SetGlobal("YSL_Comets", (GetGlobal("YSL_Comets") - 1))
  end
  if (GetGlobal("YSL_Comets") ~= 0) then
    if (GetGlobal("YSL_Comets") == 1) then
      ReplaceMusicStateOverride("YSL_Space_Comets2")
      Print("Set music state to YSL_Space_Comets2")
    elseif (GetGlobal("YSL_Comets") ~= 3) then
      if (GetGlobal("YSL_Comets") == 5) then
        ReplaceMusicStateOverride("YSL_Space_Comets3")
        Print("Set music state to YSL_Space_Comets3")
      elseif (GetGlobal("YSL_Comets") == 7) then
        ReplaceMusicStateOverride("YSL_Space_Comets4")
        Print("Set music state to YSL_Space_Comets4")
      elseif (GetGlobal("YSL_Comets") == 9) then
        SetGlobal("YSL_Comets", 100)
        GiveCollectible("Challenge_WishUponAStar_Tracker")
        StartEmitters("YSL_MickeyStars")
        ReplaceMusicStateOverride("YSL_Space_Comets5")
        Print("Set music state to YSL_Space_Comets5")
      end
    end
  end
  return 
end
starspainted = 0
YS_PaintStarsCheck = function(target, paint)
  EnableMovementInput(GetPlayer())
  ClearAllCameraAttributes(GetPlayer())
  AnimGBSequence("tut_yensidstudy.Tut_DoubleJumpBook01 05", "Fall")
  AnimGBSequence("YSL_PaintBookFX", "turnOff")
  DisableComponent("tut_yensidstudy.Tut_DoubleJumpBook01 05", "Rotator")
  Enable("ysl_yensidslab_scripting.PaintPathCameraTrigger")
  Hide("TutPaintIcon")
  rockspainted = 1
  ForceInterruptSequence("GusConvo", "Tutorial_PaintTrainingAlt2")
  return 
end
YSL_ConstellationCheck = function(target)
  Print("ConstellationCheck")
  if (GetGlobal("YSL_Comets") < 9) then
    Hide("ObservatoryConstellation")
  end
  return 
end
YS_RockTrigger = function()
  Print("EnableTrigger")
  return 
end
SetEntityRotate = function(target, state)
  if (state == "off") then
    SetPropertyEntity(target, "RotateToEntity", nil)
  else
    SetPropertyEntity(target, "RotateToEntity", GetPlayer())
  end
  return 
end
YS_EndPaintRoomCamera = function()
  return 
end
YS_LookAtMap = function()
  StartCameraPivotSnap("tut_yensidstudy.Tut_MapA1 01", 2, 0, false, false)
  return 
end
CometStateChange = function(reg_0, reg_1)
  return 
end
YS_MickeyHouseCamStart = function()
  SetDefaultCameraValues(3, 10, -7)
  return 
end
YS_MickeyHouseCamEnd = function()
  ResetDefaultCameraValues(GetPlayer())
  return 
end
YS_SlideMickey = function()
  Print("Slope on")
  DisableMotion_Player(GetPlayer())
  return 
end
YS_NoSlideMickey = function()
  Print("Slope OFF")
  DisableMotion_Player(GetPlayer())
  return 
end
YS_MickeySlide = function(target)
  SetExternalVelocity(target, vector4(7, 0, -7), 0.8999999761581421)
  return 
end
StartSweetMusic = function()
  return 
end
telescopeBaseThinned = 0
YSL_ThinnerTutorialText = function()
  if (telescopeBaseThinned == 0) then
    ForceSequence("GusConvo", "Tutorial_BrushStreamTraining")
  end
  return 
end
YSL_StopThinnerTut = function()
  telescopeBaseThinned = 1
  ForceInterruptSequence("GusConvo", "Tutorial_BrushStreamTraining")
  return 
end
YSL_CloseThinnerBook = function()
  AnimGBSequence("YSL_ThinnerBook2", "Fall")
  AnimGBSequence("YSL_ThinnerBook2FX", "turnOff")
  DisableComponent("YSL_ThinnerBook2", "Rotator")
  return 
end
YSL_TelescopeBaseThinned = function()
  TelescopeThinned = 1
  Hide("TutThinIcon")
  wait(0.30000001192092896)
  ShakeCamera(1, 5, 0.75, 0.75, 0.029999999329447746, 0.029999999329447746)
  wait(0.20000000298023224)
  ForEachEntityInGroup(FireUser3, "TelescopeBroom")
  return 
end
YSL_TelescopeHintIconToggle = function(target, state)
  if (state == "enter") then
    if (TelescopeThinned == 0) then
      Unhide("TutThinIcon")
    end
  else
    Hide("TutThinIcon")
  end
  return 
end
water = 9
waterIGC = 0
YS_TrackWater = function(target, state)
  if (state == "add") then
    SetGlobal("YSL_TrackedWater", (GetGlobal("YSL_TrackedWater") + 1))
    if (0 < GetGlobal("YSL_TrackedWater")) then
      Unhide("ysl_yensidslab_art.YSL_tutorial_01d_water_toon 01")
      ForEachEntityInGroup(Unhide, "tut_yensidstudy.Tut_YenSidWater")
    end
  end
  if (state == "sub") then
    SetGlobal("YSL_TrackedWater", (GetGlobal("YSL_TrackedWater") - 1))
    if (GetGlobal("YSL_TrackedWater") == 0) then
      if (GetGlobal("YSL_WaterSecretFound") == 0) then
        SetGlobal("YSL_WaterSecretFound", 1)
        Hide("watercaustics")
        FireUser1("YS_ShutterIGC")
        DoStinger("Stinger_Success", 4)
        ForEachEntityInGroup(DestroyEntity, "Gen3LiquidInteraction")
        DestroyEntity("YSL_LiquidInteraction")
        ForEachEntityInGroup(DestroyEntity, "YSL_BucketRippleGroup")
        wait(0.800000011920929)
        Unhide("YSL_WaterDrainFX")
        DestroyEntity("ysl_yensidslab_art.YSL_tutorial_01d_water_toon 01")
        ForEachEntityInGroup(SetVulnerability, "YSL_SecretTreasure", "ST_BREAKABLE", 1)
        Unhide("ysl_yensidslab_scripting.Shutter1Ticket")
        Unhide("ysl_yensidslab_scripting.Shutter2Ticket")
        wait(0.6000000238418579)
        AnimGBReset("YSL_WaterDrainFX")
        AnimGBSequence("YSL_WaterDrainFX", "Drain")
        AudioPostEventOn(GetPlayer(), "Play_sfx_YSL_water_drain")
        Print("Stopping observatory water SFX from YS_TrackWater")
        AudioPostEventOn("ysl_tutorial_01a_observatory_audio.water_ambiance", "Stop_sfx_YSL_running_water")
        AudioPostEventOn("ysl_yensidslab_observatory.WaterPot.PickupSpawner_Toon", "Stop_sfx_YSL_waterpot_liquid_LP_01")
        AudioPostEventOn("ysl_yensidslab_observatory.WaterPot 01.PickupSpawner_Toon", "Stop_sfx_YSL_waterpot_liquid_LP_02")
        AudioPostEventOn("ysl_yensidslab_observatory.WaterPot 02.PickupSpawner_Toon", "Stop_sfx_YSL_waterpot_liquid_LP_03")
        AudioPostEventOn("ysl_yensidslab_observatory.WaterPot 03.PickupSpawner_Toon", "Stop_sfx_YSL_waterpot_liquid_LP_04")
        AudioPostEventOn(GetPlayer(), "Play_sfx_YSL_running_water_drained")
        wait(1)
        AnimGBSequence("YS_Shutter1", "Open")
        AudioPostEventOn(GetPlayer(), "Play_sfx_YS_Shutter1_Open")
        wait(2.5)
        AnimGBSequence("YS_Shutter2", "Open")
        AudioPostEventOn(GetPlayer(), "Play_sfx_YS_Shutter2_Open")
        wait(1)
        ForEachEntityInGroup(DestroyEntity, "YSL_ShutterFX")
        ForEachEntityInGroup(Enable, "ObservHintFXTrig")
        wait(3)
        Hide("YSL_WaterDrainFX")
      end
    end
  end
  return 
end
YS_ResetWaterTracking = function()
  wait(3)
  SetGlobal("YSL_TrackedWater", 12)
  return 
end
YSL_ManageWaterPotFX = function(target, action, splash, ripple)
  if (GetGlobal("YSL_WaterSecretFound") == 0) then
    if (action == "paint") then
      StopEmitters(splash)
      Hide(ripple)
    elseif (action == "thin") then
      StartEmitters(target)
      StartEmitters(splash)
      Unhide(ripple)
      Wait(1)
      StopEmitters(target)
    end
  end
  return 
end
YS_TelescopeKnockback = function(target)
  ApplyForce(target, 100, 0, 0)
  return 
end
YS_RotatePlanets = function()
  ForEachEntityInGroup(FireUser1, "YS_Planet")
  return 
end
YSL_SpawnPlanetReward = function(target, spawnloc)
  planet = target
  Print(GetName(planet))
  local OneShotPosition = GetCenterPosition(target)
  OneShotPosition.y = OneShotPosition.y
  TeleportToEntity(PickupSpawner, spawnloc)
  SetPropertyInt(PickupSpawner, "Index To Spawn", 13, 0)
  SetPropertyVector(PickupSpawner, "Spawn Offset", vector4(0, 2, 0), 0)
  wait(0.05000000074505806)
  EffectTarget = ForceSpawn(PickupSpawner, 1)
  wait(0.009999999776482582)
  SetParentEntity(EffectTarget, spawnloc)
  wait(0.05000000074505806)
  SetPropertyInt(PickupSpawner, "Index To Spawn", 12, 0)
  parentTarget = ForceSpawn(PickupSpawner, 1)
  wait(0.009999999776482582)
  SetParentEntity(parentTarget, spawnloc)
  wait(0.03999999910593033)
  SetPropertyInt(PickupSpawner, "Index To Spawn", 9, 0)
  local spawnedObjs = ForceSpawn(PickupSpawner, 1)
  local numChildren = GetElementCount(spawnedObjs[1], "Child Entities")
  AudioPostEventOn(target, "Play_sfx_Spawner_Spawn")
  local (for index), (for limit), (for step) = 0, numChildren, 1
  for i = (for index), (for limit), (for step) do
    local childEntity = GetChildEntityByIndex(spawnedObjs[1], i)
    PlayerPickup_SetPendingActivation(childEntity, 0.800000011920929)
  end
  return 
end
planet = "nil"
parentTarget = "nil"
EffectTarget = "nil"
YSL_PlanetParenting = function(target)
  Print(GetName(parentTarget))
  Print(((GetName(target) .. " target:planet ") .. GetName(planet)))
  wait(0.20000000298023224)
  SetParentEntity(target, planet)
  return 
end
YSL_SpawnAmmoFromOneShot = function(target, xoffset, yoffset, zoffset)
  local OneShotPosition = GetCenterPosition(target)
  OneShotPosition.x = (OneShotPosition.x + tonumber(xoffset))
  OneShotPosition.y = (OneShotPosition.y + tonumber(yoffset))
  OneShotPosition.z = (OneShotPosition.z + tonumber(zoffset))
  local OneShot_SpawnDirection = (GetPosition(GetPlayer()) - OneShotPosition)
  OneShot_SpawnDirection:normalize3()
  OneShot_SpawnDirection.y = 2
  local SpawnChosenAmmoFromOneShot = function(target)
    if IsValidHandle(PickupSpawner) then
      SetTransformation(PickupSpawner, OneShotPosition, vector4(0, 0, 0))
      SetPropertyInt(PickupSpawner, "Index To Spawn", 8, 0)
      local spawnedItems = ForceSpawn(PickupSpawner, 1)
      local velocity = (OneShot_SpawnDirection * 3.200000047683716)
      ApplyImpulse(spawnedItems[1], velocity.x, velocity.y, velocity.z)
      local ammo = GetChildEntityByName(spawnedItems[1], "Ammo_Paint")
      if (IsValidHandle(ammo) == false) then
        ammo = GetChildEntityByName(spawnedItems[1], "Ammo_Thinner")
      end
      local NIF = GetChildEntityByName(ammo, "Ammo_Paint_Nif")
      if (IsValidHandle(NIF) == false) then
        NIF = GetChildEntityByName(ammo, "Ammo_Thinner_Parentable")
      end
      if IsValidHandle(NIF) then
        SetPropertyFloat(NIF, "Bone Scale Multiplier", 0, 0)
        SetPropertyFloat(NIF, "Lifetime", 30, 0)
        SetPropertyBool(NIF, "Shrink Over Lifetime", true, 0)
        PlayerPickup_SetPendingActivation(NIF, 2)
      end
    end
    return 
  end
  SpawnChosenAmmoFromOneShot(target)
  return 
end
firstPlanetStatus = 0
YS_PaintFirstPlanet = function(target, state)
  if (state == "thin") then
    if (firstPlanetStatus == 0) then
      firstPlanetStatus = 1
      Hide("TutThinIcon")
      Unhide("TutPaintIcon")
    end
  elseif (firstPlanetStatus == 1) then
    firstPlanetStatus = 2
    Hide("TutPaintIcon")
  end
  return 
end
YS_SpawnGoodie = function(target)
  Prefab_SpawnItem_ItemCheck(target)
  return 
end
YS_PlanetHintIcon = function(target, state)
  if (state == "enter") then
    if (firstPlanetStatus == 0) then
      Unhide("TutThinIcon")
    elseif (firstPlanetStatus == 1) then
      Unhide("TutPaintIcon")
      Hide("TutPaintIcon")
      Hide("TutThinIcon")
    end
  else
    Hide("TutPaintIcon")
    Hide("TutThinIcon")
  end
  return 
end
YS_ChoiceHallIGC = function()
  RestrictCutSceneInput()
  DoStinger("Boss_Intro", 30)
  GrabCamera("YSL_ChoiceCam1", nil, CAMERA_LERP_TRANSITION, 0.5)
  ForceSequence("ysl_yensidslab_scripting.ConversationYensid", "YSL_Yensid_5_PlayerChoice")
  wait(0.5)
  GrabCamera("YSL_ChoiceCam2", nil, CAMERA_LERP_TRANSITION, 5)
  wait(5)
  TeleportToEntity(GetPlayer(), "YSL_ChoiceHallTeleport")
  wait(2)
  GrabCamera("YSL_ChoiceCam1", nil, CAMERA_LERP_TRANSITION, 5)
  wait(5)
  Quest_SetCriticalPath("Critical_Yensid", "Critical_Yensid_5")
  ReleaseCamera(CAMERA_SAMEPLACE_TRANSITION, 3)
  UnrestrictCutSceneInput()
  return 
end
paintedpicture = 3
picturecomplete = 0
YS_PaintingTracker = function(target, state)
  if (picturecomplete == 0) then
    if (state == "paint") then
      paintedpicture = (paintedpicture + 1)
    else
      paintedpicture = (paintedpicture - 1)
    end
    Print(paintedpicture)
    if (paintedpicture == 6) then
      YS_ChoicePaint()
    elseif (paintedpicture == 0) then
      YS_ChoiceThin()
    end
  end
  return 
end
YS_ChoicePaint = function()
  picturecomplete = 1
  DestroyEntity("YSL_PaintingCamTrig")
  ClearCameraAttributesForPlayer("YSL_PaintingCamOverride", GetPlayer())
  ForcePainted("YS_ToonFrame")
  AnimGBSequence("YS_ExpandingHallwayInert", "End")
  AudioPostEventOn(GetPlayer(), "Play_MX_YSL_Stinger_HallOfChoice_1")
  wait(0)
  Hide("YS_ExpandingHallwayInert")
  wait(0)
  AnimGBSequence("YS_ExpandingHallway", "Expand")
  AnimGBSequence("YS_ChoiceChest", "Expand")
  AnimGBSequence("YS_HallwayDoor", "Expand")
  StartEmitters("YSL_RewardTransitionMask")
  ForEachEntityInGroup(DestroyEntity, "TRT_PaintingPiece")
  DestroyEntity("YS_ChoiceTicket")
  DestroyEntity("YS_InertPainting")
  DestroyEntity("YS_ToonPainting")
  wait(3)
  StopEmitters("YSL_RewardTransitionMask")
  DestroyEntity("YS_ExpandingHallway")
  Unhide("YS_ExpandingHallwayInert")
  Unhide("JisgsawHallway")
  Unhide("YS_HallwayChest")
  Enable("RedChestHintFXTrig")
  DestroyEntity("YS_ChoiceChest")
  DestroyEntity("YS_ChoiceTicket")
  DestroyEntity("YS_HallwayDoor")
  DestroyEntity("YS_PaintingHallwayBlocker")
  return 
end
YS_ChoiceThin = function()
  picturecomplete = 1
  DestroyEntity("YSL_PaintingCamTrig")
  ClearCameraAttributesForPlayer("YSL_PaintingCamOverride", GetPlayer())
  Unhide("YS_ExpandingHallwayInert")
  DestroyEntity("YS_ExpandingHallway")
  AnimGBSequence("YS_ExpandingHallwayInert", "Expand")
  AudioPostEventOn(GetPlayer(), "Play_MX_YSL_Stinger_HallOfChoice_1")
  AnimGBSequence("YS_ChoiceTicket", "Expand")
  AnimGBSequence("YS_HallwayDoor", "Expand")
  StartEmitters("YSL_RewardTransitionMask")
  ForEachEntityInGroup(DestroyEntity, "TRT_PaintingPiece")
  DestroyEntity("YS_ChoiceChest")
  DestroyEntity("YS_InertPainting")
  DestroyEntity("YS_ToonPainting")
  wait(3)
  Unhide("YS_OswaldTicket")
  StopEmitters("YSL_RewardTransitionMask")
  DestroyEntity("YS_ChoiceTicket")
  DestroyEntity("YS_ChoiceChest")
  DestroyEntity("YS_HallwayDoor")
  DestroyEntity("YS_PaintingHallwayBlocker")
  return 
end
YSL_RedChestCheckpoint = function()
  return 
end
YS_BookshelfDust = function()
  ForEachEntityInGroup(StartEmitters, "BookcaseDust")
  wait(1.5)
  ForEachEntityInGroup(StopEmitters, "BookcaseDust")
  return 
end
RegisterBlocks = function()
  ClearBlockTable()
  ForEachEntityInGroup(AddBlockToList, "Blocks")
  return 
end
YS_PickUpHallwayReward = function()
  GiveCollectible("Challenge_LabTested_Tracker")
  RestrictCutSceneInput()
  DestroyEntity("YSL_ShardGlass")
  ForEachEntityInGroup(DestroyEntity, "YSL_AfterBookcaseDestroy")
  GrabCamera("YSL_OpenBookshelfCam", nil, CAMERA_EASING_TRANSITION, 1)
  wait(1)
  AnimGBSequence("YS_PaintBookshelf", "Open")
  ForEachEntityInGroup(DestroyEntity, "YSL_AfterBookcaseDestroy")
  FireThread(YS_BookshelfDust)
  wait(4.5)
  StartFadeOut(0.4000000059604645)
  wait(0.4000000059604645)
  ReleaseCamera(CAMERA_INSTANT_TRANSITION, 0)
  UnrestrictCutSceneInput()
  YS_EndIGC()
  return 
end
YS_EndIGC = function()
  ResetDefaultCameraValues(GetPlayer())
  ResetTravelCameraValues(GetPlayer())
  DestroyEntity("YS_SpinAttackBook")
  DestroyEntity("ysl_yensidslab_maproom.HintFXGlass")
  DestroyEntity("ysl_tutorial_01a_maproom_fx.YSL_bookHologram_01a 01")
  PlayIGC("IGC_0060_MickeyAndTheMap")
  wait(1)
  if (GetConfigVariableBool("InDemoMode") ~= true) then
    LevelManager_SetCurrentState("YensidsLab.MapOutro")
  end
  return 
end
YS_ToMS = function()
  if (GetConfigVariableBool("InDemoMode") == true) then
    ResetDefaultCameraValues()
    ResetTravelCameraValues()
    EnablePlayer(PLAYER_TWO, true)
    EnableSplitScreen(true)
    PlayerSetDripsVisible(GetPlayer(), true)
    LoadLevel(GetPlayer(), "FTL_Gulch.TRAN_OldMill")
  else
    GiveCollectible("Challenge_LabTested_Tracker")
    UnrestrictCutSceneInput()
    ResetDefaultCameraValues()
    ResetTravelCameraValues()
    EnablePlayer(PLAYER_TWO, true)
    EnableSplitScreen(true)
    PlayerSetDripsVisible(GetPlayer(), true)
    LoadLevel(GetPlayer(), "DarkBeautyCastle_V1.Stream_1")
  end
  return 
end
YSL_StreamZone = function(target, zone)
  if (zone == "maproom") then
    StreamZones(GetPlayer(), "MapRoom")
  end
  if (zone == "brushroom") then
    midLevel = 1
    StreamZones(GetPlayer(), "BrushRoom")
  end
  if (zone == "observatory") then
    StreamZones(GetPlayer(), "Observatory")
    wait(0.10000000149011612)
    SetActiveSubMap("ysl_yensidslab_shared.MickeyHouseMapVolume")
    SetActiveFullMap("ysl_yensidslab_shared.YensidOverviewMapVolume")
    Quest_SetCriticalPath("Critical_Yensid", "Critical_Yensid_4")
    SaveCheckpoint(GetPlayer(), "YSL_CheckpointReload", "YSL_MickeyHouseRespawn")
  end
  return 
end
YSL_TurnOnBroomLeftPail = function()
  Unhide(GetChildEntityByName(_self(), "fx_bucket_water_left_broom"))
  return 
end
YSL_TurnOnBroomRightPail = function()
  Unhide(GetChildEntityByName(_self(), "fx_bucket_water_right_broom"))
  return 
end
YSL_TurnOffBroomPailFX = function()
  Hide(GetChildEntityByName(_self(), "fx_bucket_water_left_broom"))
  Hide(GetChildEntityByName(_self(), "fx_bucket_water_right_broom"))
  return 
end
PostIGC_0050_IntroToTV = function()
  SetCursorOnly(true)
  UnrestrictCutSceneInput()
  YSL_SetActiveMap("ysl_yensidslab_shared.MapRoomMapVolume", "both")
  Quest_SetCriticalPath("Critical_Yensid", "Critical_Yensid_1")
  SetCameraAttributesForPlayer("YS_HallwayCamOverride", GetPlayer())
  SaveCheckpoint(GetPlayer(), "YSL_CheckpointReloadMap", "YS_MapCheckpointMarker")
  return 
end
ResetIGC_0050 = function()
  return 
end
local stingervar = 0
YSL_Music_WallReveal = function()
  if (stingervar == 0) then
    ReplaceMusicStateOverride("YSL_Mickey_house_thinswall")
    wait(1)
    ReplaceMusicStateOverride("Minor_Boss")
    stingervar = 1
    Print("Played wall reveal stinger music")
  end
  return 
end
YSL_Music_BypassWallReveal = function()
  ReplaceMusicStateOverride("Minor_Boss")
  Disable("ysl_tutorial_01a_observatory_audio.Trig_Music_Observatory")
  stingervar = 1
  Print("Music - bypassed wall reveal, disabled plane trigger")
  return 
end
