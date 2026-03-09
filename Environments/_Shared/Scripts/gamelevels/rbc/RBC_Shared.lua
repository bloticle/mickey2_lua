RBC_Caverns_Setup_Launcher = function(target, level)
  Print("RBC_Caverns_Setup_Launcher")
  StartFadeOut(0)
  DestroyEntity(target)
  local currentLevel = tostring(LevelManager_GetCurrentState())
  local data = GetPrefabData("Projector_tofallsangel")
  if (string.sub(currentLevel, -8, -4) == "devil") then
    SetGlobal("DEC_Hardload", 1)
  elseif (string.sub(currentLevel, -8, -1) == "angel_v2") then
    data.ToFlyThrough = "False"
  end
  local Direction = GetGlobal("2dDirection")
  Print(("RBC_Caverns_Setup_Launcher: 2dDirection = " .. tostring(Direction)))
  if (GetGlobal("DEC_Hardload") == 1) then
    Print("RBC_Caverns_Setup_Launcher(): DEC_Hardload")
    data.MapLoad_SetupPosition = "IgnoreMe"
    GetPrefabData("Projector_ToGulch1Angel").MapLoad_SetupPosition = "IgnoreMe"
    data = GetPrefabData("FoopToob_CavernsToDECMarker")
    if (Direction == 1) then
      Print("__WARNING: Came in from launcher side!")
      Print("__WARNING: SETTING PREFAB DATA FoopToob_ToRBCavernsActivator TO TRUE")
      if (data.HardLoadExitFunction[1] ~= "Busy") then
        data.HardLoadExitFunction[1] = "True"
        Prefab_DECFoopToob_AlwaysSetup("FoopToob_CavernsToDECMarker")
      end
    else
      Print("__WARNING: Came in from opposite side!")
      Print("__WARNING: SETTING PREFAB DATA RBC_ExitFoopToobDevil TO REVERSE")
      GetPrefabData("RBC_ExitFoopToobDevil").HardLoadExitFunction[1] = "Reverse"
      Prefab_DECFoopToob_AlwaysSetup("RBC_ExitFoopToobDevil")
      Print("RBC_Caverns_Setup_Launcher(): Projector Load")
      if (GetGlobal("RBC_FallGlobal") ~= -1) then
        SetGlobal("RBC_FallGlobal", 1)
      end
      if (Direction == 0) then
        data.MapLoad_SetupPosition = "IgnoreMe"
        GetPrefabData("Projector_ToGulch1Angel").MapLoad_SetupPosition = "True"
      else
        GetPrefabData("Projector_ToGulch1Angel").MapLoad_SetupPosition = "IgnoreMe"
        data.MapLoad_SetupPosition = "True"
      end
    end
  else
    Print("RBC_Caverns_Setup_Launcher(): Projector Load")
    if (GetGlobal("RBC_FallGlobal") ~= -1) then
      SetGlobal("RBC_FallGlobal", 1)
    end
    if (Direction == 0) then
      data.MapLoad_SetupPosition = "IgnoreMe"
      GetPrefabData("Projector_ToGulch1Angel").MapLoad_SetupPosition = "True"
    else
      GetPrefabData("Projector_ToGulch1Angel").MapLoad_SetupPosition = "IgnoreMe"
      data.MapLoad_SetupPosition = "True"
    end
  end
  return 
end
gs3_Transition_RBCDevil = function(fromDEC)
  Print("__Function: gs3_Transition_RBCDevil")
  if (fromDEC == "DEC") then
    if (LevelManager_GetCurrentLevelName() == "Transition_03") then
      LevelManager_SetCurrentState("RBC_Falls.Caverns_Devil_V1")
      WaitForLevelLoad()
      StreamInterior(nil, "RBC_falls.TRAN_FallsToCaverns_Devl")
      WaitForLevelLoad()
    end
    if (GetGlobal("EM2_EpisodeCheck") == 1) then
      RBC_DevilFallsFlyby()
    end
    Prefab_DECFoopToob_Finish()
  end
  return 
end
gs4_Transition_RBCDevil = function()
  Prefab_DECFoopToob_Finish()
  return 
end
RBC_Caverns_Setup = function(fromCheckpoint)
  Print("!!!!!!!!!!!!!!!!!!!!!!!!! RBC_Caverns_Setup")
  local currentLevel = tostring(LevelManager_GetCurrentState())
  StartFadeOut(0)
  if (fromCheckpoint == nil) then
    GetPrefabData("Projector_ToGulch1Angel").MapLoad_SetupPosition = "IgnoreMe"
    GetPrefabData("Projector_tofallsangel").MapLoad_SetupPosition = "IgnoreMe"
    DestroyEntity("PM_Load_Angel")
    DestroyEntity("PM_Load_Devil")
  end
  ObservatoryItem_Activate("MSS_ObservatoryItem_Falls", "2")
  FireThread(RBC_BridgeJumpCheck, ".ToonSword1", true)
  local location = "Angel"
  if (fromCheckpoint ~= nil) then
    if (fromCheckpoint == "DEC") then
      location = "Devil"
    end
  elseif (string.sub(currentLevel, -8, -4) == "devil") then
    location = "Devil"
  end
  RBC_Caverns_Visit_Setup(fromCheckpoint, location)
  return 
end
RBC_SETUP_TMP_Globals = function()
  SetGlobal("MSS_HiddenHeroesQuest", 1)
  SetGlobal("MSS_ObservatoryItem_Falls", 1)
  SetGlobal("MSN_Adelle_AngelVar", 1)
  RBC_SaveCheckpoint()
  return 
end
RBC_SaveCheckpointLocation = "DevilStart"
RBC_SaveCheckpoint = function(target, location)
  Print("RBC_SaveCheckpoint")
  if (location ~= nil) then
    Print(("RBC_SaveCheckpoint: location now = " .. location))
    RBC_SaveCheckpointLocation = location
  end
  if (target ~= "Setup") then
    Print(("RBC_SaveCheckpoint: Saving at = " .. RBC_SaveCheckpointLocation))
    SaveCheckpoint(GetPlayer(), "RBC_Caverns_Setup", (("RBC_CP_" .. RBC_SaveCheckpointLocation) .. "_Mickey"), (("RBC_CP_" .. RBC_SaveCheckpointLocation) .. "_Oswald"))
  end
  return 
end
RBC_AngelLoadCheckpoint = function(target, location)
  if (GetGlobal("RBC_AngelSideIntro") == 1) then
    ForEachEntityInGroup(Enable, "RC_AngelFallsEnemies")
  end
  MultiPosSoundStart("rbc_caverns_01a_audio.angel_falls_falls_Parent")
  RBC_SaveCheckpoint("Setup", location)
  return 
end
RBC_DevilLoadCheckpoint = function(target, location)
  MultiPosSoundStart("rbc_caverns_01a_audio.lava_ambiance_Parent")
  wait(0.5)
  FireThread(RBC_StartDevilEyes)
  ForEachEntityInGroup(Enable, "RC_DevilFallsEnemies")
  RBC_SaveCheckpoint("Setup", location)
  return 
end
RBC_ClothSave = function()
  RBC_SaveCheckpoint(nil, "AngelStart")
  return 
end
RBC_UnlockLevelAchievement = function(method, direction)
  local global = GetGlobal("RBC_FallGlobal")
  if (global ~= -1) then
    SetGlobal("RBC_FallGlobal", 0)
  end
  if (direction == "Gulch") then
    if (HasCollectible("Challenge_YourConscienceBeYourGuide_Tracker") == false) then
      wait(1.5)
      GiveCollectible("Challenge_YourConscienceBeYourGuide_Tracker")
    end
  end
  if (global == 1) then
    if (method == "DEC") then
      if (HasCollectible("Challenge_FallGrace_Tracker") == false) then
        GiveCollectible("Challenge_FallGrace_Tracker")
        SetGlobal("RBC_FallGlobal", -1)
      end
    end
  end
  return 
end
RBC_StartDevilEyes = function()
  Unhide("EyesFire")
  AnimGBSequence("EyesFire", "start", true)
  MultiPosSoundStart("rbc_caverns_01a_audio.SND_fx_DevilEyeGlow_controller")
  return 
end
RC_FireMazeTriggerOne = function()
  Prefab_FireMazeEastOn("FireMazeTarget2")
  Prefab_FireMazeEastOff("FireMazeTarget3")
  Prefab_FireMazeWestOn("FireMazeTarget3")
  Prefab_FireMazeWestOff("FireMazeTarget4")
  Prefab_FireMazeEastOff("FireMazeTarget5")
  Prefab_FireMazeNorthOff("FireMazeTarget6")
  Prefab_FireMazeSouthOn("FireMazeTarget6")
  Prefab_FireMazeWestOn("FireMazeTarget6")
  Prefab_FireMazeNorthOn("FireMazeTarget7")
  Prefab_FireMazeEastOff("FireMazeTarget7")
  Prefab_FireMazeSouthOn("FireMazeTarget7")
  Prefab_FireMazeWestOff("FireMazeTarget8")
  Prefab_FireMazeSouthOn("FireMazeTarget10")
  Prefab_FireMazeEastOn("FireMazeTarget10")
  return 
end
RBC_LavaDoorCheck = function(target)
  if GetPropertyBool(target, "Is Painted") then
    RBC_HideLavaDoor()
  else
    RBC_ShowLavaDoor()
  end
  return 
end
RBC_HideLavaDoor = function()
  Unhide("RBC_LavaDoorFX")
  AnimGBSequence("RBC_LavaDoorFX", "start", true)
  wait(1)
  Hide("LavaFallsDoor")
  SetPropertyInt("LavaFallsDoor", "Stimulus Collision Layers", 13, 0)
  SetPropertyInt("LavaFallsDoor", "Trigger Collision Layers", 13, 0)
  SetPropertyInt("LavaFallsDoor", "Stimulus Collision Layers", 13, 1)
  SetPropertyInt("LavaFallsDoor", "Trigger Collision Layers", 13, 1)
  SetPropertyInt("LavaFallsDoor", "Collision Layer", 13)
  SetPropertyFloat("LavaFallsDoor", "StimulusPerSecondList", 0, 0)
  SetPropertyFloat("LavaFallsDoor", "StimulusPerSecondList", 0, 1)
  return 
end
RBC_ShowLavaDoor = function()
  AnimGBSequence("RBC_LavaDoorFX", "end")
  wait(1)
  Unhide("LavaFallsDoor")
  SetPropertyInt("LavaFallsDoor", "Stimulus Collision Layers", 3, 0)
  SetPropertyInt("LavaFallsDoor", "Trigger Collision Layers", 3, 0)
  SetPropertyInt("LavaFallsDoor", "Stimulus Collision Layers", 3, 1)
  SetPropertyInt("LavaFallsDoor", "Trigger Collision Layers", 3, 1)
  SetPropertyFloat("LavaFallsDoor", "StimulusPerSecondList", 1, 0)
  SetPropertyFloat("LavaFallsDoor", "StimulusPerSecondList", 5, 1)
  SetPropertyInt("LavaFallsDoor", "Collision Layer", 10)
  wait(1)
  Hide("RBC_LavaDoorFX")
  return 
end
RBC_SinkIntoLava = function(target)
  local ObjectPosition = GetPosition(target)
  DisableMotion(target)
  Print("Stopping the object in the lava")
  local (for index), (for limit), (for step) = ObjectPosition.y, (ObjectPosition.y - 10), -0.02500000037252903
  for i = (for index), (for limit), (for step) do
    SetPropertyVector(target, "Translation", vector4(ObjectPosition.x, i, ObjectPosition.z))
    wait(0)
  end
  if (GetName(target) == "rbc_caverns_01a_scripting.RBC_sisterStatue_01a_inert 01") then
    RBC_KillSparkles(target)
  end
  DestroyEntity(target)
  return 
end
RBC_KillSparkles = function(target)
  Print(("RBC_KillSparkles: EntityName is: " .. GetName(target)))
  if (GetName(target) == "rbc_caverns_01a_scripting.RBC_sisterStatue_01a_inert 01") then
    ForEachEntityInGroup(DestroyEntity, "Sister1")
  elseif (GetName(target) == "rbc_caverns_01a_scripting.RBC_sisterStatue_01a_inert 02") then
    ForEachEntityInGroup(DestroyEntity, "Sister2")
  end
  return 
end
RBC_NoseBreakSequence = function()
  ShakeCamera(3, 10, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  EnableMotion("FallingDevilNose")
  Wait(0)
  SetPropertyInt("FallingDevilNose", "Collision Layer", 6)
  Rumble(nil, 1)
  Rumble(nil, 1, 1)
  wait(1.399999976158142)
  Unhide("NoseLavaSplash")
  StartEmitters("NoseLavaSplash")
  TeleportToEntity("NoseLavaSplash", "FallingDevilNose")
  wait(1.600000023841858)
  StopEmitters("NoseLavaSplash")
  ForEachEntityInGroup(StopEmitters, "DevilFaceDust")
  return 
end
RBC_RaiseDevilLever = function(target, teamchange)
  local raiselever = true
  if (teamchange ~= nil) then
    if (GetCurrentTeam(target) == 2) then
      raiselever = false
    end
  end
  if (DevilLeverUp == false) then
    if raiselever then
      SetCameraAttributesForPlayer("rainbowcaverns_scripting_s2.DevilTurningColumnOverride")
      wait(2)
      SetSplineFollowerInitialSpeed("DevilMouthSplineFollower", 2)
      SetSplineFollowerInitialSpeed("TurningColumnCover", 3)
      DevilLeverUp = true
    end
  end
  return 
end
RBC_DevilMouthCamera = function()
  SetCameraAttributesForPlayer("rainbowcaverns_scripting_s2.DevilCombatZoneOverride2")
  return 
end
RBC_AngelToDevil = function()
  Unhide("EyesFire")
  AnimGBSequence("EyesFire", "start", true)
  MultiPosSoundStart("rbc_caverns_01a_audio.SND_fx_DevilEyeGlow_controller")
  return 
end
RBC_OccupyAIWithGhost = function(entityToOccupy)
  Print("#### Change enemy to neutral")
  if (entityToOccupy == "Right") then
    local (for index), (for limit), (for step) = 1, 2, 1
    for i = (for index), (for limit), (for step) do
      if (GetCurrentTeam(("RightSideSpiritSweeper0" .. i)) == 2) then
        SetTargetTeam(("RightSideSpiritSweeper0" .. i), 4)
      end
    end
  elseif (entityToOccupy == "Left") then
    local (for index), (for limit), (for step) = 3, 4, 1
    for i = (for index), (for limit), (for step) do
      (for index) = GetCurrentTeam
      (for limit) = "RightSideSpiritSweeper0"
      (for step) = i
      (for limit) = ((for limit) .. (for step))
      (for index) = (for index)((for limit))
      if ((for index) == 2) then
        (for index) = SetTargetTeam
        (for limit) = "RightSideSpiritSweeper0"
        (for step) = i
        (for limit) = ((for limit) .. (for step))
        (for step) = 4
        (for index)((for limit), (for step))
      end
    end
  end
  return 
end
RBC_StopOccupyingAIWithGhost = function(entityToOccupy)
  Print("#### Change neutral to enemy")
  if (entityToOccupy == "Right") then
    local (for index), (for limit), (for step) = 1, 2, 1
    for i = (for index), (for limit), (for step) do
      if (GetCurrentTeam(("RightSideSpiritSweeper0" .. i)) == 4) then
        SetTargetTeam(("RightSideSpiritSweeper0" .. i), 2)
      end
    end
  elseif (entityToOccupy == "Left") then
    local (for index), (for limit), (for step) = 3, 4, 1
    for i = (for index), (for limit), (for step) do
      (for index) = GetCurrentTeam
      (for limit) = "RightSideSpiritSweeper0"
      (for step) = i
      (for limit) = ((for limit) .. (for step))
      (for index) = (for index)((for limit))
      if ((for index) == 4) then
        (for index) = SetTargetTeam
        (for limit) = "RightSideSpiritSweeper0"
        (for step) = i
        (for limit) = ((for limit) .. (for step))
        (for step) = 2
        (for index)((for limit), (for step))
      end
    end
  end
  return 
end
RBC_SevenSistersStatue = function(target, state, side)
  local sweeper1 = "none"
  local sweeper2 = "none"
  if (side == "Right") then
    sweeper1 = "1"
    sweeper2 = "2"
  elseif (side == "Left") then
    sweeper1 = "3"
    sweeper2 = "4"
  end
  Print((("Statue " .. state) .. " trigger"))
  if (state == "in") then
    StopEmitters((side .. "SideSpirit"))
    Print("Sweepers changing to enemy")
    if (not (not IsValidHandle(("RightSideSpiritSweeper0" .. sweeper1)))) then
      RBC_StopOccupyingAIWithGhost(side)
      StartEmitters((side .. "SideSpirit"))
      Print("Sweepers changing to friend")
      if (not (not IsValidHandle(("RightSideSpiritSweeper0" .. sweeper1)))) then
        RBC_OccupyAIWithGhost(side)
      end
    end
  else
    StartEmitters((side .. "SideSpirit"))
    Print("Sweepers changing to friend")
    if (not (not IsValidHandle(("RightSideSpiritSweeper0" .. sweeper1)))) then
      RBC_OccupyAIWithGhost(side)
    end
  end
  return 
end
RBC_PillarsTravelCameraSet = function()
  return 
end
RBC_PillarsTravelCameraRelease = function()
  return 
end
RBC_BlotworxTemp = function()
  DestroyEntity("BLOTWORXMELEE")
  return 
end
SpladooshOnNode = false
RBC_Caverns_Visit2_SpladooshOnPressurePlate = function(target, alive)
  if (alive == "true") then
    SpladooshOnNode = true
  else
    SpladooshOnNode = false
  end
  return 
end
RBC_Caverns_OswaldToPressurePlate = function()
  if (SpladooshOnNode == false) then
    OswaldSetPathAction("PressurePlatePatrolNode1")
  end
  return 
end
RBC_BridgeJumpCheck = function(target, setup)
  enableJumpVolumeAvailability("JumpVolumeAvailability1")
  enableJumpVolumeAvailability("JumpVolumeAvailability2")
  enableJumpVolumeAvailability("JumpVolumeAvailability3")
  enableJumpVolumeAvailability("JumpVolumeAvailability4")
  enableJumpVolumeAvailability("JumpVolumeAvailability5")
  enableJumpVolumeAvailability("JumpVolumeAvailability6")
  enableJumpVolumeAvailability("JumpVolumeAvailability7")
  enableJumpVolumeAvailability("JumpVolumeAvailability8")
  enableJumpVolumeAvailability("JumpVolumeAvailability9")
  enableJumpVolumeAvailability("JumpVolumeAvailability10")
  enableJumpVolumeAvailability("JumpVolumeAvailability11")
  enableJumpVolumeAvailability("JumpVolumeAvailability12")
  enableJumpVolumeAvailability("JumpVolumeAvailability13")
  enableJumpVolumeAvailability("JumpVolumeAvailability14")
  enableJumpVolumeAvailability("JumpVolumeAvailability15")
  enableJumpVolumeAvailability("JumpVolumeAvailability16")
  Print("#### Bridge Check 01")
  local toon_state = {}
  local (for index), (for limit), (for step) = 1, 15, 1
  for i = (for index), (for limit), (for step) do
    if (i <= 11) then
      toon_state[i] = GetPropertyBool(GetRelativePrefabEntity(target, (".ToonSword" .. i)), "Is Painted")
    end
  end
  if (setup ~= nil) then
    if (setup == "PP_Check") then
      wait(0.5)
    end
  end
  if (GetPrefabData(".ToonSword1").TotalPressurePlatesState ~= 0) then
    local no_connection = false
    if toon_state[9] then
      Print("#### Bridge Check 02")
      enableJumpVolumeAvailability("JumpVolumeAvailability1")
      if (toon_state[7] == false) then
        if toon_state[6] then
          Print("#### Bridge Check 03")
          enableJumpVolumeAvailability("JumpVolumeAvailability3")
        else
          no_connection = true
          if (toon_state[8] == false) then
            Print("#### Bridge Check 04")
            enableJumpVolumeAvailability("JumpVolumeAvailability2")
            no_connection = true
          end
        end
      elseif (toon_state[8] == false) then
        Print("#### Bridge Check 04")
        enableJumpVolumeAvailability("JumpVolumeAvailability2")
        no_connection = true
      end
    else
      no_connection = true
    end
    if (toon_state[6] == false) then
      Print("#### Bridge Check 05")
      if toon_state[7] then
        if toon_state[5] then
          enableJumpVolumeAvailability("JumpVolumeAvailability4")
        elseif toon_state[4] then
          Print("#### Bridge Check 06")
          enableJumpVolumeAvailability("JumpVolumeAvailability14")
        else
          no_connection = true
          no_connection = true
          if (toon_state[5] == false) then
            if (toon_state[4] == false) then
              Print("#### Bridge Check 07")
              enableJumpVolumeAvailability("JumpVolumeAvailability5")
            end
          end
        end
      else
        no_connection = true
        if (toon_state[5] == false) then
          if (toon_state[4] == false) then
            Print("#### Bridge Check 07")
            enableJumpVolumeAvailability("JumpVolumeAvailability5")
          end
        end
      end
    elseif (toon_state[5] == false) then
      if (toon_state[4] == false) then
        Print("#### Bridge Check 07")
        enableJumpVolumeAvailability("JumpVolumeAvailability5")
      end
    end
    if (toon_state[4] == false) then
      Print("#### Bridge Check 08")
      if toon_state[3] then
        if toon_state[6] then
          enableJumpVolumeAvailability("JumpVolumeAvailability6")
        elseif toon_state[5] then
          Print("#### Bridge Check 09")
          enableJumpVolumeAvailability("JumpVolumeAvailability7")
        else
          no_connection = true
          no_connection = true
        end
      else
        no_connection = true
      end
    end
    if (toon_state[3] == false) then
      Print("#### Bridge Check 10")
      if toon_state[1] then
        if toon_state[2] then
          enableJumpVolumeAvailability("JumpVolumeAvailability8")
        elseif toon_state[4] then
          Print("#### Bridge Check 11")
          enableJumpVolumeAvailability("JumpVolumeAvailability9")
          if (toon_state[2] == false) then
            no_connection = true
            if (toon_state[1] == false) then
              Print("#### Bridge Check 12")
              if toon_state[11] then
                if toon_state[2] then
                  enableJumpVolumeAvailability("JumpVolumeAvailability10")
                else
                  enableJumpVolumeAvailability("JumpVolumeAvailability16")
                  no_connection = true
                end
              else
                no_connection = true
              end
            end
          end
        end
      elseif (toon_state[2] == false) then
        no_connection = true
        if (toon_state[1] == false) then
          Print("#### Bridge Check 12")
          if toon_state[11] then
            if toon_state[2] then
              enableJumpVolumeAvailability("JumpVolumeAvailability10")
            else
              enableJumpVolumeAvailability("JumpVolumeAvailability16")
              no_connection = true
            end
          else
            no_connection = true
          end
        end
      end
    elseif (toon_state[1] == false) then
      Print("#### Bridge Check 12")
      if toon_state[11] then
        if toon_state[2] then
          enableJumpVolumeAvailability("JumpVolumeAvailability10")
        else
          enableJumpVolumeAvailability("JumpVolumeAvailability16")
          no_connection = true
        end
      else
        no_connection = true
      end
    end
    if (toon_state[11] == false) then
      Print("#### Bridge Check 13")
      if toon_state[10] then
        if toon_state[1] then
          enableJumpVolumeAvailability("JumpVolumeAvailability11")
          enableJumpVolumeAvailability("JumpVolumeAvailability13")
        end
      else
        no_connection = true
        if toon_state[10] then
          Print("#### Bridge Check 14")
          enableJumpVolumeAvailability("JumpVolumeAvailability13")
        end
        enableJumpVolumeAvailability("JumpVolumeAvailability12")
        enableJumpVolumeAvailability("JumpVolumeAvailability15")
      end
    else
      if toon_state[10] then
        Print("#### Bridge Check 14")
        enableJumpVolumeAvailability("JumpVolumeAvailability13")
      end
      enableJumpVolumeAvailability("JumpVolumeAvailability12")
      enableJumpVolumeAvailability("JumpVolumeAvailability15")
    end
    if (setup == "PP_Check") then
      Print("#### Bridge Check 15")
      return no_connection
    elseif (GetPrefabData(".ToonSword1").TotalPressurePlatesState == 2) then
      if (no_connection == true) then
        if (GetNumPlayers() == 1) then
          FireSequence("CM_Oswald", "RC_Oswald_BridgeNotSafe")
        end
      else
        Print("#### Bridge Check 16")
        FireSequence("CM_Oswald", "RC_Oswald_BridgeSafe")
      end
    end
  end
  return 
end
RBC_SlobberReveal = function(target, instigator)
  if (instigator == "trigger") then
    AIHintEnable("RBC_AngelChestToon", true)
  else
    SetCameraAttributesForPlayer("SlobberRevealCameraOverride", _activator())
    wait(2)
    ClearCameraAttributesForPlayer("SlobberRevealCameraOverride", _activator(), 2)
  end
  SetCombatIntensityBias(0)
  return 
end
OswalNearFirstPPlate = false
RBC_OswaldNearFirstPressurePlate = function(target, direction)
  if (direction == "in") then
    OswalNearFirstPPlate = true
  else
    OswalNearFirstPPlate = false
  end
  return 
end
RBC_BridgeOswaldSafety = function(target, safe)
  local no_connection = RBC_BridgeJumpCheck(".ToonSword1", "PP_Check")
  wait(0.5)
  if (safe ~= nil) then
    if (no_connection == true) then
      if (OswalNearFirstPPlate == true) then
        if (GetNumPlayers() == 1) then
          FireSequence("CM_Oswald", "RC_Oswald_BridgeNotSafe")
        end
      end
    elseif (GetPrefabData(".ToonSword1").TotalPressurePlatesState == 2) then
      FireSequence("CM_Oswald", "RC_Oswald_BridgeSafe")
      QueueBrainEvent(GetOswaldAI(), BRAIN_StopFighting)
      OswaldSetPathAction("RBC_OswaldAngelPat")
      if (GetPrefabData(".ToonSword1").TotalPressurePlatesState == 1) then
        OswaldSetPathAction("PressurePlatePatrolNode1")
      else
        OswaldStartFollowAction()
      end
      QueueBrainEvent(GetOswaldAI(), BRAIN_StartFighting)
    end
  else
    if (GetPrefabData(".ToonSword1").TotalPressurePlatesState == 1) then
      OswaldSetPathAction("PressurePlatePatrolNode1")
    else
      OswaldStartFollowAction()
    end
    QueueBrainEvent(GetOswaldAI(), BRAIN_StartFighting)
  end
  return 
end
RBC_Photo_Taken = function(global)
  if (global == "MSN_Adelle_AngelVar") then
    local before = 0
    local after = 0
    after = --[[ return 2 of ]] Jigsaw_GetPercentagePainted("rbc_caverns_01a_art.RBC_caverns_02d_angelHead_toon 01")
    before = Jigsaw_GetPercentagePainted("rbc_caverns_01a_art.RBC_caverns_02d_angelHead_toon 01")
    if (after == 1) then
      SetGlobal(global, 2)
    else
      SetGlobal(global, 1)
    end
    ForEachEntityInGroup(Disable, "RBCAngelPhoto")
  end
  return 
end
RBC_LoadingCheckpoint = false
DevilLeverUp = false
RBC_Intro = function()
  if (GetGlobal("RC_Gus_FallsIntro_Played") == 0) then
    Wait(3)
    FireSequence("RBC_GusConvoMarker", "RC_Gus_FallsIntro", 1)
  end
  return 
end
RBC_MazeChat = function()
  if (GetGlobal("RC_Gus_MazeChatter_Played") == 0) then
    FireSequence("RBC_GusConvoMarker", "RC_Gus_MazeChatter", 1)
  end
  return 
end
RBC_WrenchHint = function()
  if (GetGlobal("RC_Gus_MazeHint1_Played") == 0) then
    FireSequence("RBC_GusConvoMarker", "RC_Gus_MazeHint1", 1)
  end
  return 
end
RBC_SwordHint = function()
  if (GetGlobal("RC_Gus_SwordHint2_Played") == 0) then
    FireSequence("RBC_GusConvoMarker", "RC_Gus_SwordHint2", 1)
  end
  return 
end
RBC_StatueHint = function()
  if (GetGlobal("RC_Gus_SwordHint1_Played") == 0) then
    FireSequence("RBC_GusConvoMarker", "RC_Gus_SwordHint1", 1)
  end
  return 
end
RBC_SecretRoomToonDisable = function()
  Disable("RBC_CavernKiller")
  return 
end
RBC_SecretRoomToonEnable = function()
  Enable("RBC_CavernKiller")
  return 
end
RBC_LowerBridgeStart = function(target)
  Print("######### LOWERBRIDGESTART")
  local data = GetPrefabData(target)
  SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".ToonSword1"), 180)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".ToonSword1"), -84)
  return 
end
RBC_NoseFall = function()
  Print("RBC_NoseFall")
  SetPropertyInt("FallingDevilNose", "Collision Layer", 6)
  return 
end
RBC_IndelibleOff = function(target)
  StopAbility(target, "Indelible")
  StopAbility(target, "Invisible")
  return 
end
RBC_OswaldStopFollowing = function()
  Print("############################# RBC_OswaldStopFollowing ####################")
  OswaldOverrideFollowAndTeleportDistance(nil, 200, 200)
  OswaldStopMovingAction()
  OswaldStopFollowAction()
  Disable("RBC_OswaldActionMarkerFalls")
  Disable("RBC_OswaldActionMarkerGulch")
  return 
end
RBC_OswaldStartFollowing = function()
  Print("############### RBC_OswaldStartFollowing ####")
  OswaldClearOverrideDistances()
  OswaldStartFollowAction()
  Disable("Trigger_DisableHiddenAction_Falls")
  Disable("Trigger_DisableHiddenAction_Gulch")
  return 
end
PPFalls_Pressed = false
PPGulch_Pressed = false
RBC_PressurePlateDepress = function(target, Side, state)
  Print(((("######## RBC_" .. Side) .. "SidePlateDepress: state = ") .. state))
  FireThread(RBC_BridgeJumpCheck, "RBC_ToonSword01", "PP_Check")
  local oppositePP = "Gulch"
  if (Side == oppositePP) then
    oppositePP = "Falls"
  end
  Print(((("######## RBC_" .. Side) .. "SidePlateDepress: PPFalls_Pressed = ") .. tostring(PPFalls_Pressed)))
  Print(((("######## RBC_" .. Side) .. "SidePlateDepress: PPGulch_Pressed = ") .. tostring(PPGulch_Pressed)))
  if (state == "Leave") then
    _G[(("PP" .. Side) .. "_Pressed")] = false
    Print(((((("######## RBC_" .. Side) .. "SidePlateDepress: PP") .. Side) .. "_Pressed = ") .. tostring(_G[(("PP" .. Side) .. "_Pressed")])))
    if (PPFalls_Pressed == false) then
      if (PPGulch_Pressed == false) then
        Print((("######## RBC_" .. Side) .. "SidePlateDepress: Both PressurePlates are depressed, so clearing Oswald to move again"))
        RBC_OswaldStartFollowing()
      end
    end
  elseif (state == "Hit") then
    OswaldOverrideFollowAndTeleportDistance(nil, 200, 200)
    if (PPFalls_Pressed == false) then
      if (PPGulch_Pressed == false) then
        Disable(("RBC_OswaldActionMarker" .. oppositePP))
        Enable(("RBC_OswaldActionMarker" .. Side))
        Enable(("Trigger_DisableHiddenAction_" .. oppositePP))
      end
    end
    _G[(("PP" .. Side) .. "_Pressed")] = true
    Print(((((("######## RBC_" .. Side) .. "SidePlateDepress: PP") .. Side) .. "_Pressed = ") .. tostring(_G[(("PP" .. Side) .. "_Pressed")])))
    if PPFalls_Pressed then
      if PPGulch_Pressed then
        local no_connection = RBC_BridgeJumpCheck(".ToonSword1", "PP_Check")
        wait(0.5)
        if (no_connection == true) then
          if (GetNumPlayers() == 1) then
            FireSequence("CM_Oswald", "RC_Oswald_BridgeNotSafe")
          end
        else
          Disable(("RBC_OswaldActionMarker" .. oppositePP))
          Enable(("RBC_OswaldActionMarker" .. Side))
        end
      end
    end
  end
  return 
end
RBC_ShutOffHiddenAction = function()
  OswaldClearOverrideDistances()
  Print("########## RBC_ShutOffHiddenAction")
  Disable("RBC_HiddenOswaldMarkerGulch")
  Disable("RBC_HiddenActionMarkerFalls")
  Disable("Trigger_DisableHiddenAction_Falls")
  Disable("Trigger_DisableHiddenAction_Gulch")
  Wait(0.10000000149011612)
  return 
end
RBC_DeathCamera = function(target)
  local activator = _activator()
  FreezeCamera(activator)
  return 
end
RBC_DeathCamera2 = function(target)
  local activator = _activator()
  KillAIAndRescuePlayer(activator)
  local health = GetHealth(target)
  if (health > 0) then
    CameraReset(activator)
  end
  return 
end
RBC_ShutOffMouthCamPlanes = function()
  return 
end
RBC_TurnOnMouthCamPlanes = function()
  Enable("RBC_MouthCamPlane01")
  Enable("RBC_MouthCamPlane02")
  return 
end
RBC_OpenDevilMouthFast = function()
  Unhide("DevilMouthRisingPlatform")
  SetSplineFollowerInitialSpeed("DevilMouthJaw", 100)
  SplineFollower_StopAtPosition("DevilMouthJaw", "DevilSKTop", "DevilSKBottom", 1)
  SetSplineFollowerInitialSpeed("DevilMouthRisingPlatform", 100)
  SplineFollower_StopAtPosition("DevilMouthRisingPlatform", "DevilRisingPlatSKBottom", "DevilRisingPlatSKTop", 1)
  return 
end
