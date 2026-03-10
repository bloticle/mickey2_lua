TCY_AUT_NoIntro = false
TCY_Aut_v1_HardLoad = function()
  if (TCY_AUT_NoIntro == false) then
    GetPrefabData("intoAutotopiaProjector").MapLoad_SetupPosition = "True"
    TCY_AUT_NoIntro = true
    Print(GetPlayer(), "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Switching Projector to activate setupposition")
  end
  OnMapLoad_ProjectorSetup("intoAutotopiaProjector")
  return 
end
AUT_DumpMenu_HardLoad = function()
  StreamZones(GetPlayer(), "SectionA_first.part")
  AUT_SaveCheckpoint("Projector")
  return 
end
AUT_IntroIGC_TurretOpens = function()
  local data = GetPrefabData("GuardianSiphon04")
  local turretShield = GetRelativePrefabEntity("GuardianSiphon04", ".SplineFollower 01")
  local turretBody = GetRelativePrefabEntity("GuardianSiphon04", ".TCY_GuardianSiphon_01d_inert 01")
  data.CurrentMode = 1
  SplineFollower_SetDisabled(turretShield, false)
  SplineFollower_StopAtPosition(turretShield, GetRelativePrefabEntity("GuardianSiphon04", ".SplineKnot 01"), GetRelativePrefabEntity("GuardianSiphon04", ".SplineKnot 02"), 0)
  AudioPostEventOn(GetRelativePrefabEntity("GuardianSiphon04", ".snd_turreteye"), "Play_sfx_AUT_turret_open")
  SetPropertyEntity(turretBody, "RotateToEntity", "Turret01_dead_PositionMarker 01", 0)
  EnableComponent(turretBody, "Rotator")
  SetRotatorMaxSpeed(turretBody, 90)
  return 
end
AUT_IntroIGC_TurretPanel = function()
  AnimGBSequence("TCY_GuardianSiphonPanel_01a_inert 01", "open")
  wait(1)
  AnimGBSequence("TCY_GuardianSiphonPanel_01a_inert 01", "close")
  return 
end
PostIGC_0310_AutotopiaIntro = function()
  StreamZones(GetPlayer(), "SectionA_first.part")
  RestrictCutSceneInput()
  FireUser1("Autotopia_IntroStream_FinalCamera")
  wait(0.20000000298023224)
  local data = GetPrefabData("GuardianSiphon04")
  local turretBody = GetRelativePrefabEntity("GuardianSiphon04", ".TCY_GuardianSiphon_01d_inert 01")
  tcy_TurretLongRange("mickey", "GuardianSiphon04", "on")
  wait(0.10000000149011612)
  SetPropertyEntity(turretBody, "RotateToEntity", "tmp_AutotopiaTestCar_01a_inert 02", 0)
  SetPropertyEntity(turretBody, "Shooter Target", "tmp_AutotopiaTestCar_01a_inert 02", 0)
  EnableComponent(turretBody, "Shooter")
  return 
end
AUT_introComplete = function()
  OswaldStartMovingAction()
  ShowHud()
  SetGlobal("Autotopia_Core_Progression", 0)
  AUT_CenterCamAtControlTower()
  wait(0.5)
  ClearCutSceneStack()
  Quest_SetCriticalPath("Critical_Autotopia", "Critical_Autotopia_6")
  AUT_SaveCheckpoint("Projector")
  return 
end
AUT_CenterCamAtControlTower = function()
  SetCameraAttributesForPlayer("ControlTower_Marker(CameraOverride) 03", nil)
  wait(2)
  ClearCameraAttributesForPlayer("ControlTower_Marker(CameraOverride) 03", nil)
  return 
end
TCY_Final_UnlockZoneA = function()
  AnimGBSequence("tcy_autotopia_01a_dynamic.TCY_autotopia_01a_mainTowerDoor_01a 01", "open")
  AnimGBSequence("tcy_autotopia_01a.TCY_autotopia_01a_mainTowerLift_01a 01", "down")
  enableJumpVolumeAvailability("TowerJumps_Oswald_Target")
  AnimGBSequence("tcy_autotopia_01a.TCY_autotopia_01a_mainTowerPistons_01a 01", "moveUp")
  Prefab_Projector_ChangeState("ControlTowerProjector", "Activate")
  return 
end
AUT_ControlTowerGusHints = function()
  if (0 < GetGlobal("Autotopia_Siphon01")) then
    if (0 < GetGlobal("Autotopia_Siphon02")) then
      if (0 < GetGlobal("Autotopia_Siphon03")) then
        if (GetGlobal("Autotopia_Core_Progression") == 0) then
          ActivateGremlinHint("Gus PlayerHintMarkers Visit01 04")
        elseif (0 < GetGlobal("Autotopia_Core_Progression")) then
          ActivateGremlinHint("Gus PlayerHintMarkers Visit01 05")
        end
      end
    end
  end
  return 
end
AUT_SetupEngineKillTriggers = function(target, zone)
  if (zone == "A") then
    if (0 < GetGlobal("Autotopia_Siphon01")) then
      Disable("tcy_autotopia_01a_first.PlayerKill_TriggerBase 01")
      Disable("tcy_autotopia_01a_first.PlayerKill_TriggerBase 02")
    end
  elseif (zone == "C") then
    if (0 < GetGlobal("Autotopia_Siphon02")) then
      Disable("tcy_autotopia_01c_first.PlayerKill_TriggerBase 03")
      Disable("tcy_autotopia_01c_first.PlayerKill_TriggerBase 02")
    end
  elseif (zone == "E") then
    if (0 < GetGlobal("Autotopia_Siphon03")) then
      Disable("tcy_autotopia_01e_first.PlayerKill_TriggerBase 02")
      Disable("tcy_autotopia_01e_first.PlayerKill_TriggerBase 04")
    end
  end
  return 
end
AUT_SpawnEngine = function(target, engineVar, tag)
  if (GetGlobal(engineVar) == 0) then
    local spawnIndex = (tonumber(tag) - 1)
    SetPropertyInt("engineBlock_Spawner 01", "Index To Spawn", spawnIndex)
    SetPropertyEntity("engineBlock_Spawner 01", "Spawn Destinations", target, 0)
    ForceSpawn("engineBlock_Spawner 01", 1)
    SetGlobal(engineVar, 1)
  end
  return 
end
AUT_EngineDestroyed = function(target, engineVar, phase)
  SetGlobal(engineVar, tonumber(phase))
  SetPropertyEntity("explosion_FX_Spawner", "Spawn Destinations", target, 0)
  AudioPostEventOn(target, "Play_sfx_AUT_Siphon_HackBoom")
  ForceSpawn("explosion_FX_Spawner", 1)
  DestroyEntity(target)
  return 
end
AUT_Player01_Zone = "A"
AUT_Player02_Zone = "A"
AUT_v2_PlayerInZone = function(player, ZoneName)
  local setPlayer = 0
  if (GetName(player) == GetName(GetPlayer())) then
    AUT_Player01_Zone = ZoneName
    setPlayer = 1
  else
    AUT_Player02_Zone = ZoneName
    setPlayer = 2
  end
  if (setPlayer ~= 1) then
  end
  local tarHerbie = 0
  if (setPlayer == 1) then
    tarHerbie = "AUT_Herbie01"
  elseif (setPlayer == 2) then
    tarHerbie = "AUT_Herbie02"
  end
  if (ZoneName == "A") then
    SetNextPatrolNode(tarHerbie, "PatrolNode 02")
  elseif (ZoneName == "B") then
    SetNextPatrolNode(tarHerbie, "PatrolNode 05")
  elseif (ZoneName == "C") then
    SetNextPatrolNode(tarHerbie, "PatrolNode 09")
  elseif (ZoneName == "D") then
    SetNextPatrolNode(tarHerbie, "PatrolNode 10")
  elseif (ZoneName == "E") then
    SetNextPatrolNode(tarHerbie, "PatrolNode 12")
  elseif (ZoneName == "F") then
    SetNextPatrolNode(tarHerbie, "PatrolNode 13")
  end
  AUT_v2_SpawnHerbie()
  return 
end
AUT_Herbie01 = "X"
AUT_Herbie02 = "X"
AUT_v2_SpawnHerbie = function()
  if (AUT_Herbie01 == "X") then
    ForceSpawn("RangedBlotworx_Spawner 01", 1)
    wait(0.10000000149011612)
    SetNextPatrolNode("Herbie_01", "PatrolNode 02")
    AUT_Herbie01 = "O"
    AnimGBSequence("RangedBlotworxDoor", "up")
  elseif (AUT_Herbie02 == "X") then
    ForceSpawn("RangedBlotworx_Spawner 01", 1)
    wait(0.10000000149011612)
    SetNextPatrolNode("Herbie_02", "PatrolNode 02")
    AUT_Herbie02 = "O"
  end
  return 
end
AUT_v2_HerbieDies = function(target, herbieNum)
  if (herbieNum == "1") then
    AUT_Herbie01 = "X"
  elseif (herbieNum == "2") then
    AUT_Herbie02 = "X"
  end
  return 
end
OswaldPanelLock = 0
AUT_Hack01ButtonPressed = 0
Siphon01_HackPanel01 = 0
LastTurretPanelHacked = 0
AUT_HackHints = function()
  if (AUT_Hack01ButtonPressed == 0) then
    AUT_Hack01ButtonPressed = 1
    ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_05")
  end
  return 
end
AUT_JunkHintGiven = 0
AUT_JunkHints = function()
  if (AUT_JunkHintGiven == 0) then
    if (GetGlobal("Autotopia_Siphon01") == 0) then
      AUT_JunkHintGiven = 1
      ForceSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_06")
    end
  end
  return 
end
Siphon01_PanelHacked = function()
  if (GetGlobal("Autotopia_Siphon01") == 0) then
    if (Siphon01_HackPanel01 == 0) then
      Siphon01_HackPanel01 = 1
      SetPropertyBool("Siphon01_HackSpot01", "ActionSpotEnabled", false)
      RestrictCutSceneInput()
      SetCameraAttributesForPlayer("Turret01_Button01_Marker(CameraOverride) 01", nil)
    end
  end
  return 
end
AUT_FirstSiphonButtonOn = function()
  if (GetGlobal("Autotopia_Siphon01") == 0) then
    if (Siphon01_HackPanel01 == 0) then
      AnimGBSequence("TCY_GuardianSiphonPanel_01a_inert 01", "open")
      SetPropertyBool("Siphon01_HackSpot01", "ActionSpotEnabled", true)
      if (OswaldPanelLock == 0) then
        OswaldPanelLock = 1
      end
      AUT_HackHints()
    end
  end
  return 
end
AUT_FirstSiphonButtonOff = function()
  if (GetGlobal("Autotopia_Siphon01") == 0) then
    AnimGBSequence("TCY_GuardianSiphonPanel_01a_inert 01", "close")
  end
  OswaldPanelLock = 0
  SetPropertyBool("Siphon01_HackSpot01", "ActionSpotEnabled", false)
  OswaldAbortScriptedBehavior()
  OswaldStartFollowAction()
  return 
end
AUT_SiphonButton_CameraTriggered = function(target, siphon, button)
  if (siphon == "1") then
    if (GetGlobal("Autotopia_Siphon01") == 0) then
      SetCameraAttributesForPlayer("Siphon01_Button01_Marker(CameraOverride) 01", target)
    end
  elseif (siphon == "2") then
    if (GetGlobal("Autotopia_Siphon02") == 0) then
      if (button == "1") then
        SetCameraAttributesForPlayer("Siphon02_Button01_Marker(CameraOverride) 01", target)
      else
        SetCameraAttributesForPlayer("Siphon02_Button02_Marker(CameraOverride) 01", target)
        if (siphon == "3") then
          if (GetGlobal("Autotopia_Siphon03") == 0) then
            if (button == "1") then
              SetCameraAttributesForPlayer("Siphon03_Button01_Marker(CameraOverride) 01", target)
            elseif (button == "2") then
              SetCameraAttributesForPlayer("Siphon03_Button02_Marker(CameraOverride) 01", target)
            else
              SetCameraAttributesForPlayer("Siphon03_Button03_Marker(CameraOverride) 01", target)
            end
          end
        end
      end
    end
  elseif (siphon == "3") then
    if (GetGlobal("Autotopia_Siphon03") == 0) then
      if (button == "1") then
        SetCameraAttributesForPlayer("Siphon03_Button01_Marker(CameraOverride) 01", target)
      elseif (button == "2") then
        SetCameraAttributesForPlayer("Siphon03_Button02_Marker(CameraOverride) 01", target)
      else
        SetCameraAttributesForPlayer("Siphon03_Button03_Marker(CameraOverride) 01", target)
      end
    end
  end
  return 
end
Siphon02_HackPanel01 = 0
Siphon02_HackPanel02 = 0
AUT_Hack02Button01Pressed = 0
AUT_Hack02Button02Pressed = 0
Siphon02_PanelHacked = function(target, panelident)
  if (GetGlobal("Autotopia_Siphon02") == 0) then
    if (panelident == "1") then
      if (Siphon02_HackPanel01 == 0) then
        Siphon02_HackPanel01 = 1
        LastTurretPanelHacked = 21
        FireUser1("GuardianSiphon03")
        AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 01", "close")
        SetPropertyBool("Siphon02_HackHint01", "ActionSpotEnabled", false)
        AUT_SiphonPanelHacked("Turret02_HackPanel 01", "Turret02_HackPanel PositionMarker 01", 2)
      end
    elseif (panelident == "2") then
      if (Siphon02_HackPanel02 == 0) then
        Siphon02_HackPanel02 = 1
        LastTurretPanelHacked = 22
        FireUser1("GuardianSiphon03")
        AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 02", "close")
        SetPropertyBool("Siphon02_HackHint02", "ActionSpotEnabled", false)
        AUT_SiphonPanelHacked("Turret02_HackPanel 02", "Turret02_HackPanel PositionMarker 02", 2)
      end
    end
  end
  return 
end
AUT_SiphonPanelHacked = function(panel, marker, siphon)
  SetPropertyEntity("explosion_FX_Spawner", "Spawn Destinations", panel, 0)
  AudioPostEventOn(marker, "Play_sfx_AUT_Siphon_HackBoom")
  ForceSpawn("explosion_FX_Spawner", 1)
  local attach = function(index)
    SetPropertyInt("Health_Spawner 01", "Index To Spawn", index, 0)
    return ForceSpawn("Health_Spawner 01", 1)[1]
  end
  local FireHealthSpawn = function(marker)
    local reward = attach(0)
    wait(0)
    local proj = attach(1)
    SetParentEntity(reward, proj)
    local impulseVec = GetFacing(marker)
    ApplyImpulse(proj, (impulseVec.x * 7), 5, (impulseVec.z * 7))
    wait(1)
    ClearParent(reward)
    DestroyEntity(proj)
    return 
  end
  if (siphon == 2) then
    SetPropertyEntity("Health_Spawner 01", "Spawn Destinations", marker, 0)
    if (Siphon02_HackPanel01 == 1) then
      if (Siphon02_HackPanel02 == 1) then
        RestrictCutSceneInput()
        if (LastTurretPanelHacked == 21) then
          SetCameraAttributesForPlayer("Turret02_Button01_Marker(CameraOverride) 01", nil)
        elseif (LastTurretPanelHacked == 22) then
          SetCameraAttributesForPlayer("Turret02_Button02_Marker(CameraOverride) 01", nil)
        end
        MoveToEntity("Siphon02_PinReward", marker)
        local proj = attach(0)
        SetParentEntity("Siphon02_PinReward", proj)
        local impulseVec = GetFacing(marker)
        ApplyImpulse(proj, (impulseVec.x * 7), 5, (impulseVec.z * 7))
        wait(1)
        ClearParent("Siphon02_PinReward")
        DestroyEntity(proj)
      end
    else
      FireHealthSpawn(marker)
      if (siphon == 3) then
        SetPropertyEntity("Health_Spawner 01", "Spawn Destinations", marker, 0)
        if (Siphon03_HackPanel01 == 1) then
          if (Siphon03_HackPanel02 == 1) then
            if (Siphon03_HackPanel03 == 1) then
              RestrictCutSceneInput()
              if (LastTurretPanelHacked == 31) then
                SetCameraAttributesForPlayer("Turret03_Button01_Marker(CameraOverride) 01", nil)
              elseif (LastTurretPanelHacked == 32) then
                SetCameraAttributesForPlayer("Turret03_Button02_Marker(CameraOverride) 01", nil)
              elseif (LastTurretPanelHacked == 33) then
                SetCameraAttributesForPlayer("Turret03_Button03_Marker(CameraOverride) 01", nil)
              end
              MoveToEntity("Siphon03_PinReward", marker)
              local proj, proj = attach(0), marker
              proj = "Siphon03_PinReward"
              SetParentEntity(proj, proj)
              proj = marker
              local impulseVec, impulseVec = GetFacing(proj), proj
              proj = ApplyImpulse
              impulseVec = proj
              proj(impulseVec, (impulseVec.x * 7), 5, (impulseVec.z * 7))
              proj = wait
              impulseVec = 1
              proj(impulseVec)
              proj = ClearParent
              impulseVec = "Siphon03_PinReward"
              proj(impulseVec)
              proj = DestroyEntity
              impulseVec = proj
              proj(impulseVec)
            end
          end
        else
          FireHealthSpawn(marker)
        end
      end
    end
  elseif (siphon == 3) then
    SetPropertyEntity("Health_Spawner 01", "Spawn Destinations", marker, 0)
    if (Siphon03_HackPanel01 == 1) then
      if (Siphon03_HackPanel02 == 1) then
        if (Siphon03_HackPanel03 == 1) then
          RestrictCutSceneInput()
          if (LastTurretPanelHacked == 31) then
            SetCameraAttributesForPlayer("Turret03_Button01_Marker(CameraOverride) 01", nil)
          elseif (LastTurretPanelHacked == 32) then
            SetCameraAttributesForPlayer("Turret03_Button02_Marker(CameraOverride) 01", nil)
          elseif (LastTurretPanelHacked == 33) then
            SetCameraAttributesForPlayer("Turret03_Button03_Marker(CameraOverride) 01", nil)
          end
          MoveToEntity("Siphon03_PinReward", marker)
          local proj, proj = attach(0), marker
          proj = "Siphon03_PinReward"
          SetParentEntity(proj, proj)
          proj = marker
          local impulseVec, impulseVec = GetFacing(proj), proj
          proj = ApplyImpulse
          impulseVec = proj
          proj(impulseVec, (impulseVec.x * 7), 5, (impulseVec.z * 7))
          proj = wait
          impulseVec = 1
          proj(impulseVec)
          proj = ClearParent
          impulseVec = "Siphon03_PinReward"
          proj(impulseVec)
          proj = DestroyEntity
          impulseVec = proj
          proj(impulseVec)
        end
      end
    else
      FireHealthSpawn(marker)
    end
  end
  Hide(panel)
  return 
end
AUT_SecondSiphonButtonOn = function(target, button, state)
  if (button == "1") then
    if (state == "on") then
      if (GetGlobal("Autotopia_Siphon02") == 0) then
        if (Siphon02_HackPanel01 == 0) then
          AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 01", "open")
          OswaldPanelLock = 1
          AUT_Hack02Button01Pressed = 1
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Oswald to spot 01!")
          SetPropertyBool("Siphon02_HackHint01", "ActionSpotEnabled", true)
          AUT_HackHints()
        end
      else
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* TURRET IS OFF!")
        if (state == "off") then
          if (GetGlobal("Autotopia_Siphon02") == 0) then
            AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 01", "close")
          end
          OswaldPanelLock = 0
          AUT_Hack02Button01Pressed = 0
          SetPropertyBool("Siphon02_HackHint01", "ActionSpotEnabled", false)
          OswaldAbortScriptedBehavior()
          OswaldStartFollowAction()
          if (button == "2") then
            if (state == "on") then
              if (GetGlobal("Autotopia_Siphon02") == 0) then
                if (Siphon02_HackPanel02 == 0) then
                  AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 02", "open")
                  OswaldPanelLock = 1
                  AUT_Hack02Button02Pressed = 1
                  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Oswald to spot 02!")
                  SetPropertyBool("Siphon02_HackHint02", "ActionSpotEnabled", true)
                  AUT_HackHints()
                end
              else
                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* TURRET IS OFF!")
                if (state == "off") then
                  if (GetGlobal("Autotopia_Siphon02") == 0) then
                    AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 02", "close")
                  end
                  OswaldPanelLock = 0
                  AUT_Hack02Button02Pressed = 0
                  SetPropertyBool("Siphon02_HackHint02", "ActionSpotEnabled", false)
                  OswaldAbortScriptedBehavior()
                  OswaldStartFollowAction()
                end
              end
            elseif (state == "off") then
              if (GetGlobal("Autotopia_Siphon02") == 0) then
                AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 02", "close")
              end
              OswaldPanelLock = 0
              AUT_Hack02Button02Pressed = 0
              SetPropertyBool("Siphon02_HackHint02", "ActionSpotEnabled", false)
              OswaldAbortScriptedBehavior()
              OswaldStartFollowAction()
            end
          end
        end
      end
    elseif (state == "off") then
      if (GetGlobal("Autotopia_Siphon02") == 0) then
        AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 01", "close")
      end
      OswaldPanelLock = 0
      AUT_Hack02Button01Pressed = 0
      SetPropertyBool("Siphon02_HackHint01", "ActionSpotEnabled", false)
      OswaldAbortScriptedBehavior()
      OswaldStartFollowAction()
      if (button == "2") then
        if (state == "on") then
          if (GetGlobal("Autotopia_Siphon02") == 0) then
            if (Siphon02_HackPanel02 == 0) then
              AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 02", "open")
              OswaldPanelLock = 1
              AUT_Hack02Button02Pressed = 1
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Oswald to spot 02!")
              SetPropertyBool("Siphon02_HackHint02", "ActionSpotEnabled", true)
              AUT_HackHints()
            end
          else
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* TURRET IS OFF!")
            if (state == "off") then
              if (GetGlobal("Autotopia_Siphon02") == 0) then
                AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 02", "close")
              end
              OswaldPanelLock = 0
              AUT_Hack02Button02Pressed = 0
              SetPropertyBool("Siphon02_HackHint02", "ActionSpotEnabled", false)
              OswaldAbortScriptedBehavior()
              OswaldStartFollowAction()
            end
          end
        elseif (state == "off") then
          if (GetGlobal("Autotopia_Siphon02") == 0) then
            AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 02", "close")
          end
          OswaldPanelLock = 0
          AUT_Hack02Button02Pressed = 0
          SetPropertyBool("Siphon02_HackHint02", "ActionSpotEnabled", false)
          OswaldAbortScriptedBehavior()
          OswaldStartFollowAction()
        end
      end
    end
  elseif (button == "2") then
    if (state == "on") then
      if (GetGlobal("Autotopia_Siphon02") == 0) then
        if (Siphon02_HackPanel02 == 0) then
          AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 02", "open")
          OswaldPanelLock = 1
          AUT_Hack02Button02Pressed = 1
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Oswald to spot 02!")
          SetPropertyBool("Siphon02_HackHint02", "ActionSpotEnabled", true)
          AUT_HackHints()
        end
      else
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* TURRET IS OFF!")
        if (state == "off") then
          if (GetGlobal("Autotopia_Siphon02") == 0) then
            AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 02", "close")
          end
          OswaldPanelLock = 0
          AUT_Hack02Button02Pressed = 0
          SetPropertyBool("Siphon02_HackHint02", "ActionSpotEnabled", false)
          OswaldAbortScriptedBehavior()
          OswaldStartFollowAction()
        end
      end
    elseif (state == "off") then
      if (GetGlobal("Autotopia_Siphon02") == 0) then
        AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 02", "close")
      end
      OswaldPanelLock = 0
      AUT_Hack02Button02Pressed = 0
      SetPropertyBool("Siphon02_HackHint02", "ActionSpotEnabled", false)
      OswaldAbortScriptedBehavior()
      OswaldStartFollowAction()
    end
  end
  return 
end
Siphon03_HackPanel01 = 0
Siphon03_HackPanel02 = 0
Siphon03_HackPanel03 = 0
AUT_Hack03Button01Pressed = 0
AUT_Hack03Button02Pressed = 0
AUT_Hack03Button03Pressed = 0
Siphon03_PanelHacked = function(target, panelident)
  if (GetGlobal("Autotopia_Siphon03") == 0) then
    if (panelident == "1") then
      if (Siphon03_HackPanel01 == 0) then
        Siphon03_HackPanel01 = 1
        LastTurretPanelHacked = 31
        FireUser1("GuardianSiphon02")
        SetPropertyBool("Turret03_OswaldHackHint01", "ActionSpotEnabled", false)
        AUT_SiphonPanelHacked("Turret03_HackPanel 01", "Turret03_HackPanel PositionMarker 01", 3)
      end
    elseif (panelident == "2") then
      if (Siphon03_HackPanel02 == 0) then
        Siphon03_HackPanel02 = 1
        LastTurretPanelHacked = 32
        FireUser1("GuardianSiphon02")
        SetPropertyBool("Turret03_OswaldHackHint02", "ActionSpotEnabled", false)
        AUT_SiphonPanelHacked("Turret03_HackPanel 02", "Turret03_HackPanel PositionMarker 02", 3)
      end
    elseif (panelident == "3") then
      if (Siphon03_HackPanel03 == 0) then
        Siphon03_HackPanel03 = 1
        LastTurretPanelHacked = 33
        FireUser1("GuardianSiphon02")
        SetPropertyBool("Turret03_OswaldHackHint03", "ActionSpotEnabled", false)
        AUT_SiphonPanelHacked("Turret03_HackPanel 03", "Turret03_HackPanel PositionMarker 03", 3)
      end
    end
  end
  return 
end
AUT_ThirdSiphonButtonOn = function(target, button, state)
  if (button == "1") then
    if (state == "on") then
      if (GetGlobal("Autotopia_Siphon03") == 0) then
        if (Siphon03_HackPanel01 == 0) then
          AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 01", "open")
          OswaldPanelLock = 1
          AUT_Hack03Button01Pressed = 1
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Oswald to spot 01!")
          SetPropertyBool("Turret03_OswaldHackHint01", "ActionSpotEnabled", true)
          AUT_HackHints()
        end
      end
    elseif (state == "off") then
      if (GetGlobal("Autotopia_Siphon03") == 0) then
        AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 01", "close")
      end
      OswaldPanelLock = 0
      AUT_Hack03Button01Pressed = 0
      SetPropertyBool("Turret03_OswaldHackHint01", "ActionSpotEnabled", false)
      OswaldAbortScriptedBehavior()
      OswaldStartFollowAction()
      if (button == "2") then
        if (state == "on") then
          if (GetGlobal("Autotopia_Siphon03") == 0) then
            if (Siphon03_HackPanel02 == 0) then
              AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 02", "open")
              OswaldPanelLock = 1
              AUT_Hack03Button02Pressed = 1
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Oswald to spot 02!")
              SetPropertyBool("Turret03_OswaldHackHint02", "ActionSpotEnabled", true)
              AUT_HackHints()
            end
          end
        elseif (state == "off") then
          if (GetGlobal("Autotopia_Siphon03") == 0) then
            AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 02", "close")
          end
          OswaldPanelLock = 0
          AUT_Hack03Button02Pressed = 0
          SetPropertyBool("Turret03_OswaldHackHint02", "ActionSpotEnabled", false)
          OswaldAbortScriptedBehavior()
          OswaldStartFollowAction()
          if (button == "3") then
            if (state == "on") then
              if (GetGlobal("Autotopia_Siphon03") == 0) then
                if (Siphon03_HackPanel03 == 0) then
                  AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 03", "open")
                  OswaldPanelLock = 1
                  AUT_Hack03Button03Pressed = 1
                  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Oswald to spot 02!")
                  SetPropertyBool("Turret03_OswaldHackHint03", "ActionSpotEnabled", true)
                  AUT_HackHints()
                end
              end
            elseif (state == "off") then
              if (GetGlobal("Autotopia_Siphon03") == 0) then
                AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 03", "close")
              end
              OswaldPanelLock = 0
              AUT_Hack03Button03Pressed = 0
              SetPropertyBool("Turret03_OswaldHackHint03", "ActionSpotEnabled", false)
              OswaldAbortScriptedBehavior()
              OswaldStartFollowAction()
            end
          end
        end
      elseif (button == "3") then
        if (state == "on") then
          if (GetGlobal("Autotopia_Siphon03") == 0) then
            if (Siphon03_HackPanel03 == 0) then
              AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 03", "open")
              OswaldPanelLock = 1
              AUT_Hack03Button03Pressed = 1
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Oswald to spot 02!")
              SetPropertyBool("Turret03_OswaldHackHint03", "ActionSpotEnabled", true)
              AUT_HackHints()
            end
          end
        elseif (state == "off") then
          if (GetGlobal("Autotopia_Siphon03") == 0) then
            AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 03", "close")
          end
          OswaldPanelLock = 0
          AUT_Hack03Button03Pressed = 0
          SetPropertyBool("Turret03_OswaldHackHint03", "ActionSpotEnabled", false)
          OswaldAbortScriptedBehavior()
          OswaldStartFollowAction()
        end
      end
    end
  elseif (button == "2") then
    if (state == "on") then
      if (GetGlobal("Autotopia_Siphon03") == 0) then
        if (Siphon03_HackPanel02 == 0) then
          AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 02", "open")
          OswaldPanelLock = 1
          AUT_Hack03Button02Pressed = 1
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Oswald to spot 02!")
          SetPropertyBool("Turret03_OswaldHackHint02", "ActionSpotEnabled", true)
          AUT_HackHints()
        end
      end
    elseif (state == "off") then
      if (GetGlobal("Autotopia_Siphon03") == 0) then
        AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 02", "close")
      end
      OswaldPanelLock = 0
      AUT_Hack03Button02Pressed = 0
      SetPropertyBool("Turret03_OswaldHackHint02", "ActionSpotEnabled", false)
      OswaldAbortScriptedBehavior()
      OswaldStartFollowAction()
      if (button == "3") then
        if (state == "on") then
          if (GetGlobal("Autotopia_Siphon03") == 0) then
            if (Siphon03_HackPanel03 == 0) then
              AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 03", "open")
              OswaldPanelLock = 1
              AUT_Hack03Button03Pressed = 1
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Oswald to spot 02!")
              SetPropertyBool("Turret03_OswaldHackHint03", "ActionSpotEnabled", true)
              AUT_HackHints()
            end
          end
        elseif (state == "off") then
          if (GetGlobal("Autotopia_Siphon03") == 0) then
            AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 03", "close")
          end
          OswaldPanelLock = 0
          AUT_Hack03Button03Pressed = 0
          SetPropertyBool("Turret03_OswaldHackHint03", "ActionSpotEnabled", false)
          OswaldAbortScriptedBehavior()
          OswaldStartFollowAction()
        end
      end
    end
  elseif (button == "3") then
    if (state == "on") then
      if (GetGlobal("Autotopia_Siphon03") == 0) then
        if (Siphon03_HackPanel03 == 0) then
          AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 03", "open")
          OswaldPanelLock = 1
          AUT_Hack03Button03Pressed = 1
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Oswald to spot 02!")
          SetPropertyBool("Turret03_OswaldHackHint03", "ActionSpotEnabled", true)
          AUT_HackHints()
        end
      end
    elseif (state == "off") then
      if (GetGlobal("Autotopia_Siphon03") == 0) then
        AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 03", "close")
      end
      OswaldPanelLock = 0
      AUT_Hack03Button03Pressed = 0
      SetPropertyBool("Turret03_OswaldHackHint03", "ActionSpotEnabled", false)
      OswaldAbortScriptedBehavior()
      OswaldStartFollowAction()
    end
  end
  return 
end
AUT_Damage_MainContainer = function()
  local towerDmg = 0
  if (GetGlobal("Autotopia_Siphon01") == 1) then
    towerDmg = (towerDmg + 1)
    StartEmitters(("Main_ContainerDamage_0" .. towerDmg))
  end
  if (GetGlobal("Autotopia_Siphon02") == 1) then
    towerDmg = (towerDmg + 1)
    StartEmitters(("Main_ContainerDamage_0" .. towerDmg))
  end
  if (GetGlobal("Autotopia_Siphon03") == 1) then
    towerDmg = (towerDmg + 1)
    StartEmitters(("Main_ContainerDamage_0" .. towerDmg))
  end
  return 
end
AUT_FirstSiphon_Destroyed = function()
  SetPropertyEntity("explosion_FX_Spawner", "Spawn Destinations", "Turret01_HackPanel 01", 0)
  AudioPostEventOn("Turret01_HackPanel 01", "Play_sfx_AUT_Siphon_Destroy")
  AudioPostEventOn("Turret01_HackPanel 01", "Stop_sfx_oswald_hacking")
  ForceSpawn("explosion_FX_Spawner", 1)
  if (Siphon01_HackPanel01 == 1) then
    AnimGBSequence("TCY_GuardianSiphonPanel_01a_inert 01", "close")
  end
  Hide("Turret01_HackPanel 01")
  Unhide("Siphon01_PinReward")
  local attach = function(index)
    SetPropertyInt("Health_Spawner 01", "Index To Spawn", index, 0)
    return ForceSpawn("Health_Spawner 01", 1)[1]
  end
  SetPropertyEntity("Health_Spawner 01", "Spawn Destinations", "Turret01_dead_PositionMarker 01", 0)
  MoveToEntity("Siphon01_PinReward", "Turret01_dead_PositionMarker 01")
  local proj = attach(1)
  SetParentEntity("Siphon01_PinReward", proj)
  local impulseVec = GetFacing("Turret01_dead_PositionMarker 01")
  ApplyImpulse(proj, (impulseVec.x * 7), 5, (impulseVec.z * 7))
  wait(1)
  ClearParent("Siphon01_PinReward")
  DestroyEntity(proj)
  ClearCameraAttributesForPlayer("Siphon01_Button01_Marker(CameraOverride) 01", nil)
  FireSequence("Marker(Conversation) Gus", "AUT_v1_Area01_Exit")
  return 
end
AUT_FirstSiphon_Disabled = function()
  AUT_TurretDestroyed()
  AudioPostEventOn("Turret01_HackPanel 01", "Stop_sfx_oswald_hacking")
  if (Siphon01_HackPanel01 == 0) then
    FireUser1("Gate01_OpensCam")
  end
  ClearCameraAttributesForPlayer("Siphon01_Button01_Marker(CameraOverride) 01", nil)
  ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  Rumble(GetPlayer(), 0.6600000262260437)
  Rumble(nil, 0.6600000262260437, 1)
  AudioPostEventOn(GetPlayer(), "Play_sfx_EarthquakeCamShake")
  SetGlobal("AUT_GateB", 1)
  Enable("FirstBwrxSpawner 01")
  ForceSpawn("FirstBwrxSpawner 01", 1)
  Disable("ZoneB_ThinnerGate_A_TriggerDamageBase 01")
  AnimGBSequence("ZoneB_ThinnerGate_A_fireColumn 01", "turnOffLeft")
  AnimGBSequence("ZoneB_ThinnerGate_A_fireColumn 02", "turnOffRight")
  ForEachEntityInGroup(Hide, "ZoneB_ThinnerGate_A_Collision")
  Disable("tcy_autotopia_01a_first.PlayerKill_TriggerBase 01")
  Disable("tcy_autotopia_01a_first.PlayerKill_TriggerBase 02")
  AUT_SiphonFX_Initialize("boulder_01")
  wait(0.5)
  SetGlobal("Autotopia_GusHint", 17)
  ActivateGremlinHint("Gus PlayerHintMarkers Visit01 01")
  AUT_SaveCheckpoint("ControlTower")
  wait(2)
  if (GetGlobal("Autotopia_Siphon01") == 1) then
    UnrestrictCutSceneInput()
  end
  ClearCameraAttributesForPlayer("Turret01_Button01_Marker(CameraOverride) 01", nil)
  return 
end
AUT_SecondSiphon_Destroyed = function()
  SetPropertyEntity("explosion_FX_Spawner", "Spawn Destinations", "Turret02_HackPanel 02", 0)
  AudioPostEventOn("Turret02_HackPanel 02", "Play_sfx_AUT_Siphon_Destroy")
  AudioPostEventOn("Turret02_HackPanel 02", "Stop_sfx_oswald_hacking")
  ForceSpawn("explosion_FX_Spawner", 1)
  if (AUT_Hack02Button01Pressed == 1) then
    AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 01", "close")
  end
  if (AUT_Hack02Button02Pressed == 1) then
    AnimGBSequence("TCY_GuardianSiphonPanel_02a_inert 02", "close")
  end
  Hide("Turret02_HackPanel 02")
  Unhide("Siphon02_PinReward")
  FireSequence("Marker(Conversation) Oswald", "AUT_v1_Area02_Exit")
  AUT_TurretDestroyed()
  SetGlobal("Autotopia_GusHint", 27)
  ClearCameraAttributesForPlayer("Siphon02_Button01_Marker(CameraOverride) 01", nil)
  ClearCameraAttributesForPlayer("Siphon02_Button02_Marker(CameraOverride) 01", nil)
  Disable("tcy_autotopia_01c_first.PlayerKill_TriggerBase 03")
  Disable("tcy_autotopia_01c_first.PlayerKill_TriggerBase 02")
  FireUser1("Gate02_OpensCam")
  wait(2)
  ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  Rumble(GetPlayer(), 0.6600000262260437)
  Rumble(nil, 0.6600000262260437, 1)
  AudioPostEventOn(GetPlayer(), "Play_sfx_EarthquakeCamShake")
  SetGlobal("AUT_GateD", 1)
  SetPropertyFloat("tcy_autotopia_01a_shared.PatrolNode 02", "BranchPathChance", 1)
  SetPropertyFloat("tcy_autotopia_01a_shared.PatrolNode 03", "BranchPathChance", 1)
  SetPropertyFloat("tcy_autotopia_01a_shared.PatrolNode 04", "BranchPathChance", 1)
  Disable("ZoneD_ThinnerGate_C_TriggerDamageBase 01")
  AudioPostEventOn("ZoneD_ThinnerGate_C_fireColumn 01", "Stop_sfx_AUT_thinner_curtain_LP")
  AnimGBSequence("ZoneD_ThinnerGate_C_fireColumn 01", "turnOffLeft")
  AnimGBSequence("ZoneD_ThinnerGate_C_fireColumn 02", "turnOffRight")
  AnimGBSequence("ZoneD_TankC", "Empty")
  AUT_SiphonFX_Initialize("Turret_02_boulder_01")
  ForEachEntityInGroup(Hide, "ZoneD_ThinnerGate_C_Collision")
  ActivateGremlinHint("Gus PlayerHintMarkers Visit01 02")
  Quest_SetCriticalPath("Critical_Autotopia", "Critical_Autotopia_7")
  AUT_SaveCheckpoint("Siphon02exit")
  wait(2)
  ClearCameraAttributesForPlayer("Turret02_Button01_Marker(CameraOverride) 01", nil)
  ClearCameraAttributesForPlayer("Turret02_Button02_Marker(CameraOverride) 01", nil)
  if (GetGlobal("Autotopia_Siphon02") == 1) then
    UnrestrictCutSceneInput()
  end
  return 
end
AUT_SecondSiphon_Disabled = function()
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* SECOND SIPHON DOWN")
  FireSequence("Marker(Conversation) Oswald", "AUT_v1_Area02_Exit")
  AUT_TurretDestroyed()
  AudioPostEventOn("Turret02_HackPanel 02", "Stop_sfx_oswald_hacking")
  ClearCameraAttributesForPlayer("Siphon02_Button01_Marker(CameraOverride) 01", nil)
  ClearCameraAttributesForPlayer("Siphon02_Button02_Marker(CameraOverride) 01", nil)
  FireUser1("Gate02_OpensCam")
  wait(2)
  ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  Rumble(GetPlayer(), 0.6600000262260437)
  Rumble(nil, 0.6600000262260437, 1)
  AudioPostEventOn(GetPlayer(), "Play_sfx_EarthquakeCamShake")
  SetGlobal("AUT_GateD", 1)
  SetPropertyFloat("tcy_autotopia_01a_shared.PatrolNode 02", "BranchPathChance", 1)
  SetPropertyFloat("tcy_autotopia_01a_shared.PatrolNode 03", "BranchPathChance", 1)
  SetPropertyFloat("tcy_autotopia_01a_shared.PatrolNode 04", "BranchPathChance", 1)
  Disable("ZoneD_ThinnerGate_C_TriggerDamageBase 01")
  AudioPostEventOn("ZoneD_ThinnerGate_C_fireColumn 01", "Stop_sfx_AUT_thinner_curtain_LP")
  AnimGBSequence("ZoneD_ThinnerGate_C_fireColumn 01", "turnOffLeft")
  AnimGBSequence("ZoneD_ThinnerGate_C_fireColumn 02", "turnOffRight")
  AnimGBSequence("ZoneD_TankC", "Empty")
  AUT_SiphonFX_Initialize("Turret_02_boulder_01")
  ForEachEntityInGroup(Hide, "ZoneD_ThinnerGate_C_Collision")
  Disable("tcy_autotopia_01c_first.PlayerKill_TriggerBase 03")
  Disable("tcy_autotopia_01c_first.PlayerKill_TriggerBase 02")
  SetGlobal("Autotopia_GusHint", 27)
  ActivateGremlinHint("Gus PlayerHintMarkers Visit01 02")
  AUT_SaveCheckpoint("Siphon02exit")
  return 
end
AUT_ThirdSiphon_Destroyed = function()
  SetPropertyEntity("explosion_FX_Spawner", "Spawn Destinations", "Turret03_HackPanel 02", 0)
  AudioPostEventOn("Turret03_HackPanel 02", "Play_sfx_AUT_Siphon_Destroy")
  AudioPostEventOn("Turret03_HackPanel 02", "Stop_sfx_oswald_hacking")
  ForceSpawn("explosion_FX_Spawner", 1)
  if (AUT_Hack03Button01Pressed == 1) then
    AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 01", "close")
  end
  if (AUT_Hack03Button02Pressed == 1) then
    AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 02", "close")
  end
  if (AUT_Hack03Button03Pressed == 1) then
    AnimGBSequence("TCY_GuardianSiphonPanel_03a_inert 03", "close")
  end
  ClearCameraAttributesForPlayer("Siphon03_Button01_Marker(CameraOverride) 01", nil)
  ClearCameraAttributesForPlayer("Siphon03_Button02_Marker(CameraOverride) 01", nil)
  ClearCameraAttributesForPlayer("Siphon03_Button03_Marker(CameraOverride) 01", nil)
  Hide("Turret03_HackPanel 02")
  Unhide("Siphon03_PinReward")
  FireSequence("Marker(Conversation) Oswald", "AUT_v1_Area03_Exit")
  return 
end
AUT_ThirdSiphonCameraOn = 0
AUT_ThirdSiphon_Disabled = function()
  AUT_TurretDestroyed()
  AudioPostEventOn("Turret03_HackPanel 02", "Stop_sfx_oswald_hacking")
  FireUser1("Gate03_OpensCam")
  ClearCameraAttributesForPlayer("Siphon03_Button01_Marker(CameraOverride) 01", nil)
  ClearCameraAttributesForPlayer("Siphon03_Button02_Marker(CameraOverride) 01", nil)
  ClearCameraAttributesForPlayer("Siphon03_Button03_Marker(CameraOverride) 01", nil)
  wait(2)
  AnimGBSequence("TCY_autotopia_01a_tunnelBlocker_03a 01", "explode")
  Disable("ZoneF_ThinnerGate_E_TriggerDamageBase 01")
  AudioPostEventOn("ZoneF_ThinnerGate_E_fireColumn 01", "Stop_sfx_AUT_thinner_curtain_LP")
  AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 02", "turnOffLeft")
  AnimGBSequence("ZoneF_ThinnerGate_E_fireColumn 01", "turnOffRight")
  ForEachEntityInGroup(AnimGBSequence, "ZoneF_TankE", "Empty")
  ForEachEntityInGroup(Hide, "ZoneF_ThinnerGate_E_Collision")
  SetGlobal("Autotopia_GusHint", 50)
  Disable("tcy_autotopia_01e_first.PlayerKill_TriggerBase 02")
  Disable("tcy_autotopia_01e_first.PlayerKill_TriggerBase 04")
  AUT_SiphonFX_Initialize("Turret_01_boulder_01")
  ActivateGremlinHint("Gus PlayerHintMarkers Visit01 03")
  AUT_SaveCheckpoint("Siphon03exit")
  wait(2)
  ClearCameraAttributesForPlayer("Turret03_Button01_Marker(CameraOverride) 01", nil)
  ClearCameraAttributesForPlayer("Turret03_Button02_Marker(CameraOverride) 01", nil)
  ClearCameraAttributesForPlayer("Turret03_Button03_Marker(CameraOverride) 01", nil)
  if (GetGlobal("Autotopia_Siphon03") == 1) then
    UnrestrictCutSceneInput()
  end
  wait(0.5)
  DestroyEntity("TCY_autotopia_01a_tunnelBlocker_03a 01")
  return 
end
AUT_PlayersReturnToEnd = function()
  if (0 < GetGlobal("Autotopia_Siphon01")) then
    if (0 < GetGlobal("Autotopia_Siphon02")) then
      if (0 < GetGlobal("Autotopia_Siphon03")) then
        if (GetGlobal("Autotopia_Core_Progression") == 0) then
          FireSequence("Marker(Conversation) Oswald", "AUT_v1_Finale")
          wait(1)
          AudioSetState(GetPlayer(), "Designer_IGC", "Special_Events")
          Print("audio set state to Designer IGC Special Events from AUT_PlayersReturnToEnd")
        end
      end
    end
  end
  return 
end
AUT_FinalResolution = function()
  SetGlobal("Autotopia_Core_Progression", 1)
  Quest_SetCriticalPath("Critical_Autotopia", "Critical_Autotopia_3")
  local towerDmg = 0
  if (GetGlobal("Autotopia_Siphon01") == 1) then
    towerDmg = (towerDmg + 1)
  end
  if (GetGlobal("Autotopia_Siphon02") == 1) then
    towerDmg = (towerDmg + 1)
  end
  if (GetGlobal("Autotopia_Siphon03") == 1) then
    towerDmg = (towerDmg + 1)
  end
  if (GetGlobal("Autotopia_Core_State") == 1) then
    StartEmitters("GuardianEscapeFX")
  end
  ActivateGremlinHint("Gus PlayerHintMarkers Visit01 05")
  DisableGuardianHint("Gus PlayerHintMarkers Visit01 04")
  Print((("*_*_**_*_*_*_*_*_**_*_*_*_*_*_*_*_**_*_*_*_*_*_*_* Total Damage " .. towerDmg) .. " "))
  if (1 < towerDmg) then
    Print("*_*_**_*_*_*_*_*_**_*_*_*_*_*_*_*_**_*_*_*_*_*_*_* PAINT ENDING")
    SetGlobal("Autotopia_Core_State", 1)
    FireUser1("Cam_ReleaseGuardians")
    wait(2)
    SetGlobal("AUT_QuestHealth", 35)
    AUT_TowerExplode()
    AUT_GuardiansGo()
    DoStinger("Comment_Rest", 5)
    Print("siphon restorative music comment")
    AudioSetState(GetPlayer(), "Designer_IGC", "Gameplay")
    Print("audio set state to Designer IGC Gameplay from AUT_FinalResolution paint ending")
  else
    SetGlobal("Autotopia_Core_State", 2)
    Print("*_*_**_*_*_*_*_*_**_*_*_*_*_*_*_*_**_*_*_*_*_*_*_* THINNER ENDING")
    DoStinger("Comment_Dest", 5)
    Print("siphon destructive music comment")
    AudioSetState(GetPlayer(), "Designer_IGC", "Gameplay")
    Print("audio set state to Designer IGC Gameplay from AUT_FinalResolution thinner ending")
    ForEachEntityInGroup(ForceSketched, "AUT_Area01_toon")
    AUT_TowerFinaleThinner(1)
  end
  return 
end
AUT_TowerExplode = function()
  local x = 0
  local y = 0
  while (x < 8) do
    SetPropertyEntity("explosion_FX_Spawner", "Spawn Destinations", ("TowerFinale_Explosion_PositionMarker 0" .. (x + 1)), 0)
    ForceSpawn("explosion_FX_Spawner", 1)
    AudioPostEventOn(("TowerFinale_Explosion_PositionMarker 0" .. (x + 1)), "Play_sfx_aut_siphon_explode")
    x = (x + 1)
    y = (y + 1)
    if (y == 3) then
      y = 0
      wait(0.20000000298023224)
    else
      wait(0.699999988079071)
    end
    if (x == 3) then
      AUT_ControlTowerOpen()
    end
    if (x == 5) then
      if (GetGlobal("Autotopia_Core_State") == 1) then
        GrabCamera("TowerDestruction_CameraControlPoint 01", nil, CAMERA_LERP_TRANSITION, 0)
      end
    end
    Hide("ControlTowerGlassIntact")
  end
  return 
end
AUT_GuardiansGo = function()
  DoStinger("Stinger_Success", 5)
  Print("siphon restorative music comment from AUT_GuardiansGo")
  ForEachEntityInGroup(StartEmitters, "pntGuardians")
  ForEachEntityInGroup(SetSplineFollowerInitialSpeed, "pntGuardians", 9)
  wait(2)
  StopEmitters("GuardianEscapeFX")
  wait(2.5)
  AUT_SiphonPool_A_Changed("GuardianEndingGeyser")
  ForEachEntityInGroup(StopEmitters, "pntGuardians")
  local x = 1
  while (x < 10) do
    ForcePainted(("AUT_GP01_Jigsaw" .. x))
    x = (x + 1)
    wait(0.009999999776482582)
  end
  x = 1
  while (x < 13) do
    ForcePainted(("AUT_GP01_Toon" .. x))
    x = (x + 1)
    wait(0.009999999776482582)
  end
  ForEachEntityInGroup(DestroyEntity, "AUTgp01Guard")
  FireUser1("GeysersEruptCamera")
  Unhide("GuardianEndingPaintPin")
  wait(0.699999988079071)
  FireUser1("ControlTowerGeyser1")
  FireUser1("ControlTowerGeyser2")
  FireUser1("ControlTowerGeyser3")
  FireUser1("ControlTowerGeyser4")
  FireThread(TCY_MoveGeyser, "ControlTowerGeyser1")
  TCY_ShowGeyser("ControlTowerGeyser1")
  AudioPostEventOn("ControlTowerGeyser1", "Play_sfx_aut_geyser_rise")
  wait(0.3499999940395355)
  FireThread(TCY_MoveGeyser, "ControlTowerGeyser2")
  TCY_ShowGeyser("ControlTowerGeyser2")
  AudioPostEventOn("ControlTowerGeyser2", "Play_sfx_aut_geyser_rise")
  wait(0.3499999940395355)
  FireThread(TCY_MoveGeyser, "ControlTowerGeyser3")
  TCY_ShowGeyser("ControlTowerGeyser3")
  AudioPostEventOn("ControlTowerGeyser3", "Play_sfx_aut_geyser_rise")
  wait(0.3499999940395355)
  FireThread(TCY_MoveGeyser, "ControlTowerGeyser4")
  TCY_ShowGeyser("ControlTowerGeyser4")
  AudioPostEventOn("ControlTowerGeyser4", "Play_sfx_aut_geyser_rise")
  FireSequence("Marker(Conversation) Oswald", "AUT_v1_FinalePaint")
  return 
end
AUT_FinishGuardianScene = function()
  FireUser1("CameraControlTowerOpens")
  wait(2)
  ForceSequence("Marker(Conversation) Oswald", "AUT_v1_FinaleTowerPaint")
  return 
end
AUT_TowerFinaleThinner = function(phase)
  if (phase == 1) then
    FireUser1("Cam_TowerShutdown")
    wait(2)
    AUT_TowerExplode()
    ForceSequence("Marker(Conversation) Oswald", "AUT_v1_FinaleThinner")
  else
    wait(0.5)
    GrabCamera("Projector_CameraControlPoint 01", nil, CAMERA_LERP_TRANSITION, 0.5)
    ForceSequence("Marker(Conversation) Oswald", "AUT_v1_FinalTowerThinner")
  end
  return 
end
AUT_ControlTowerOpen = function()
  AnimGBSequence("tcy_autotopia_01a.TCY_autotopia_01a_mainTowerLift_01a 01", "down")
  enableJumpVolumeAvailability("TowerJumps_Oswald_Target")
  wait(0.5)
  AnimGBSequence("tcy_autotopia_01a.TCY_autotopia_01a_mainTowerPistons_01a 01", "moveUp")
  AUT_TurretsDown = 4
  AnimGBSequence("tcy_autotopia_01a_dynamic.TCY_autotopia_01a_mainTowerDoor_01a 01", "open")
  Prefab_Projector_ChangeState("ControlTowerProjector", "Activate")
  return 
end
AUT_TurretsDown = 0
AUT_TurretDestroyed = function()
  AUT_TurretsDown = (AUT_TurretsDown + 1)
  return 
end
TCY_QuakeToggle = 0
TCY_QuakeOrBark = 0
AUT_WeakTremor = function()
  if (GetGlobal("Autotopia_GusHint") < 50) then
    if (TCY_QuakeToggle == 1) then
      TCY_QuakeToggle = 0
      ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
      Rumble(GetPlayer(), 0.6600000262260437)
      Rumble(nil, 0.6600000262260437, 1)
      AudioPostEventOn(GetPlayer(), "Play_sfx_EarthquakeCamShake")
    elseif (TCY_QuakeOrBark == 0) then
      TCY_QuakeOrBark = 1
      ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
      Rumble(GetPlayer(), 0.6600000262260437)
      Rumble(nil, 0.6600000262260437, 1)
      AudioPostEventOn(GetPlayer(), "Play_sfx_EarthquakeCamShake")
    else
      if (GetGlobal("Autotopia_GusHint") == 0) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_0")
      elseif (GetGlobal("Autotopia_GusHint") == 11) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_11")
      elseif (GetGlobal("Autotopia_GusHint") == 15) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_15")
      elseif (GetGlobal("Autotopia_GusHint") == 16) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_16")
      elseif (GetGlobal("Autotopia_GusHint") == 17) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_17")
      elseif (GetGlobal("Autotopia_GusHint") == 20) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_20")
      elseif (GetGlobal("Autotopia_GusHint") == 21) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_21")
      elseif (GetGlobal("Autotopia_GusHint") == 25) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_25")
      elseif (GetGlobal("Autotopia_GusHint") == 26) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_26")
      elseif (GetGlobal("Autotopia_GusHint") == 27) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_27")
      elseif (GetGlobal("Autotopia_GusHint") == 30) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_30")
      elseif (GetGlobal("Autotopia_GusHint") == 31) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_31")
      elseif (GetGlobal("Autotopia_GusHint") == 35) then
        FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_35")
      end
      TCY_QuakeToggle = 0
    end
    if (GetGlobal("Autotopia_GusHint") == 50) then
      FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_50")
    elseif (GetGlobal("Autotopia_GusHint") == 55) then
      FireSequence("Gus HelpMarker(Conversation) 01", "AUT_v1_Gus_PlayerReminder_55")
    end
  end
  return 
end
PlayersEnterAUT = function()
  SplineFollower_StopAtPosition(GetRelativePrefabEntity("GuardianSiphon04", ".SplineFollower 01"), GetRelativePrefabEntity("GuardianSiphon04", ".SplineKnot 01"), GetRelativePrefabEntity("GuardianSiphon04", ".SplineKnot 02"), 0)
  return 
end
AUT_ReachedFirstGate = function()
  Unhide("Turret02_Gate01")
  return 
end
AUT_ReachedSecondArea = function()
  if (GetGlobal("Autotopia_Siphon02") == 0) then
    Quest_SetCriticalPath("Critical_Autotopia", "Critical_Autotopia_8")
    AUT_SaveCheckpoint("Siphon02")
    FireSequence("Marker(Conversation) Oswald", "AUT_v1_Area02_Intro")
  end
  return 
end
AUT_HerbieGetsMad = function(herbie)
  AI_SetPermanentTarget(herbie, GetPlayer())
  return 
end
AUT_ReachedSecondGate = function()
  Unhide("Turret03_Gate01")
  return 
end
AUT_ReachedThirdArea = function()
  SetGlobal("Autotopia_GusHint", 30)
  Quest_SetCriticalPath("Critical_Autotopia", "Critical_Autotopia_9")
  AUT_SaveCheckpoint("Siphon03")
  return 
end
AUT_ReachedThirdGate = function()
  TCY_QuakeToggle = 0
  ShakeCamera(3, 5, 0.5, 0.5, 0.009999999776482582, 0.009999999776482582)
  Rumble(GetPlayer(), 0.6600000262260437)
  Rumble(nil, 0.6600000262260437, 1)
  AudioPostEventOn(GetPlayer(), "Play_sfx_EarthquakeCamShake")
  wait(0.4000000059604645)
  AnimGBSequence("tcy_autotopia_01a.TCY_autotopia_01a_shortcutBlocker_02a 01", "fall")
  wait(1)
  SetPropertyEntity("explosion_FX_Spawner", "Spawn Destinations", "ZoneF_TankPositionMarker 01", 0)
  ForceSpawn("explosion_FX_Spawner", 1)
  Hide("tcy_autotopia_01a.TCY_autotopia_01a_shortcutBlocker_02a 01")
  return 
end
TCY_AUT_PlayerOne_Invis = 0
TCY_AUT_PlayerTwo_Invis = 0
AUT_PlayersInvisible = function(player, tag)
  if (tag == "1") then
    TCY_AUT_PlayerOne_Invis = 1
  else
    TCY_AUT_PlayerTwo_Invis = 1
  end
  return 
end
AUT_PlayerUnInvis = function(player, tag)
  if (tag == "1") then
    TCY_AUT_PlayerOne_Invis = 0
  else
    TCY_AUT_PlayerTwo_Invis = 0
  end
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* PLAYERS NO LONGER INVIS")
  if (0 < GetGlobal("Autotopia_Siphon01")) then
    if (GetGlobal("Autotopia_Siphon02") == 0) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* WAKING SECOND TURRET")
      FireUser3(GetRelativePrefabEntity("GuardianSiphon03", ".OswaldAttack_LogicTimerMarker 01"))
    end
  elseif (0 < GetGlobal("Autotopia_Siphon02")) then
    if (GetGlobal("Autotopia_Siphon03") == 0) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* WAKING THIRD TURRET")
      FireUser3(GetRelativePrefabEntity("GuardianSiphon02", ".OswaldAttack_LogicTimerMarker 01"))
    end
  end
  return 
end
AUT_BwrxSpawned = function(bwrx)
  local CurrentLevel = LevelManager_GetCurrentState()
  if (CurrentLevel == "tcy_autotopia_visit1.sectionc_first") then
    if (GetGlobal("Autotopia_Siphon02") == 0) then
      SetNextPatrolNode(bwrx, "tcy_autotopia_01d_both.PatrolNode 01")
    end
  elseif (CurrentLevel == "tcy_autotopia_visit1.sectiona_first") then
    SetNextPatrolNode(bwrx, "tcy_autotopia_01b_both.PatrolNode 01")
  end
  if (AUT_BwrxSpawnToggle == 0) then
    AUT_BwrxSpawnToggle = 1
    SetPropertyFloat(bwrx, "AttackSlotAttackDistance", 6, 0)
    SetPropertyFloat(bwrx, "AttackSlotWaitDistance", 6, 0)
  else
    AUT_BwrxSpawnToggle = 0
    SetPropertyFloat(bwrx, "AttackSlotAttackDistance", 10, 0)
    SetPropertyFloat(bwrx, "AttackSlotWaitDistance", 10, 0)
  end
  return 
end
AUT_BwrxPatrol01 = 0
AUT_BwrxPatrol02 = 0
AUT_BwrxSpawnToggle = 0
AUT_BwrxReachMid = function(target)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AUT_BwrxPatrol01 reached Zone A intro Patrol Node ")
  local bwrxTeam = GetCurrentTeam(target)
  Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Beetleworx passed end of short patrol, is set to Team " .. bwrxTeam) .. "!"))
  local CurrentLevel = LevelManager_GetCurrentState()
  if (CurrentLevel == "tcy_autotopia_visit1.sectionc_first") then
    if (GetGlobal("Autotopia_Siphon02") == 0) then
      if (bwrxTeam == 3) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Beetleworx is friendly, killing Beetleworx!")
        Kill(target)
      else
        SetNextPatrolNode(target, "tcy_autotopia_01d_both.PatrolNode 01")
        MoveToEntity(target, "tcy_autotopia_01d_both.PatrolNode 01")
        if (AUT_BwrxPatrol01 == 0) then
          AUT_BwrxPatrol01 = GetName(target)
          Print((("AUT_BwrxPatrol01 set to " .. AUT_BwrxPatrol01) .. " "))
        elseif (AUT_BwrxPatrol02 == 0) then
          AUT_BwrxPatrol02 = GetName(target)
          Print((("AUT_BwrxPatrol02 set to " .. AUT_BwrxPatrol02) .. " "))
        end
      end
    end
  elseif (AUT_BwrxPatrol01 == 0) then
    AUT_BwrxPatrol01 = GetName(target)
    Print((("AUT_BwrxPatrol01 set to " .. AUT_BwrxPatrol01) .. " "))
  elseif (AUT_BwrxPatrol02 == 0) then
    AUT_BwrxPatrol02 = GetName(target)
    Print((("AUT_BwrxPatrol02 set to " .. AUT_BwrxPatrol02) .. " "))
  end
  return 
end
AUT_BwrxReachEnd = function(bwrx)
  local bwrxTeam = GetCurrentTeam(bwrx)
  Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Beetleworx passed end of first patrol, is set to Team " .. bwrxTeam) .. "!"))
  local CurrentLevel = LevelManager_GetCurrentState()
  if (CurrentLevel == "tcy_autotopia_visit1.sectionc_first") then
    if (GetGlobal("Autotopia_Siphon02") == 0) then
      if (bwrxTeam == 3) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Beetleworx is friendly, killing Beetleworx!")
        Kill(bwrx)
      else
        SetNextPatrolNode(bwrx, "tcy_autotopia_01d_both.PatrolNode 01")
        MoveToEntity(bwrx, "tcy_autotopia_01d_both.PatrolNode 01")
        if (CurrentLevel == "tcy_autotopia_visit1.sectiona_first") then
          if (bwrxTeam == 3) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Beetleworx is friendly, killing Beetleworx!")
            Kill(bwrx)
          else
            SetNextPatrolNode(bwrx, "tcy_autotopia_01b_both.PatrolNode 01")
            MoveToEntity(bwrx, "tcy_autotopia_01b_both.PatrolNode 01")
            Disable("FirstBwrxSpawner 01")
            DestroyEntity(bwrx)
          end
        else
          Disable("FirstBwrxSpawner 01")
          DestroyEntity(bwrx)
        end
      end
    end
  elseif (CurrentLevel == "tcy_autotopia_visit1.sectiona_first") then
    if (bwrxTeam == 3) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* Beetleworx is friendly, killing Beetleworx!")
      Kill(bwrx)
    else
      SetNextPatrolNode(bwrx, "tcy_autotopia_01b_both.PatrolNode 01")
      MoveToEntity(bwrx, "tcy_autotopia_01b_both.PatrolNode 01")
      Disable("FirstBwrxSpawner 01")
      DestroyEntity(bwrx)
    end
  else
    Disable("FirstBwrxSpawner 01")
    DestroyEntity(bwrx)
  end
  if (AUT_BwrxPatrol01 == GetName(bwrx)) then
    AUT_BwrxPatrol01 = 0
    Print("AUT_BwrxPatrol01 reset")
  elseif (AUT_BwrxPatrol02 == GetName(bwrx)) then
    AUT_BwrxPatrol02 = 0
    Print("AUT_BwrxPatrol02 reset")
  end
  return 
end
AUT_MagicHatQuest_GildaPhotoCheckOnLoad = function()
  if (GetGlobal("AUT_GildaPictureTaken") == 1) then
    ForEachEntityInGroup(DestroyEntity, "GildaCameraPosition Marker (Camera Ability) 01")
  end
  return 
end
AUT_MagicHatQuest_GildaPhoto = function(target, event, obj)
  local score = GetPictureScoreFromEvent(event)
  Print(((("Photo " .. obj) .. " ") .. tostring(score)))
  if (score == 1) then
    ForEachEntityInGroup(DestroyEntity, "GildaCameraPosition Marker (Camera Ability) 01")
    FireSequence("Marker(Conversation) Gus 01", "AUT_v2_MagicHatPhoto")
  end
  return 
end

