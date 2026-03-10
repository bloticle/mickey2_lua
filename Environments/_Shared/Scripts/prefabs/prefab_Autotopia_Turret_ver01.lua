tcy_InitializeTurret = function(target)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_InitializeTurret called!!")
  local data = GetPrefabData(_self())
  local turretBody = GetRelativePrefabEntity(_self(), ".TCY_GuardianSiphon_01d_inert 01")
  local startState = data.SiphonGlobal
  data.TurretState = GetGlobal(startState)
  if (data.TurretState == 0) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_InitializeTurret finds Turret is not destroyed, Shooter Target set to default!!")
    SetPropertyEntity(turretBody, "Shooter Target", GetRelativePrefabEntity(_self(), ".Marker(Parentable) 02"), 0)
  end
  SetR3MTColorReg(GetRelativePrefabEntity(_self(), ".thinnerJet"), 1, vector4(0, 0, 0, 0), R3MT_Color_Alpha)
  return 
end
tcy_ActivateShield = function(target, direction)
  local data = GetPrefabData(target)
  local turretShield = GetRelativePrefabEntity(target, ".SplineFollower 01")
  local turretBody = GetRelativePrefabEntity(target, ".TCY_GuardianSiphon_01d_inert 01")
  SplineFollower_SetDisabled(turretShield, false)
  if (direction == "up") then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_ActivateShield called!! Turret shields raised!!")
    TimerDisable(GetRelativePrefabEntity(target, ".TurretShieldLogicTimer 01"))
    SplineFollower_SetDisabled(turretShield, false)
    SplineFollower_StopAtPosition(turretShield, GetRelativePrefabEntity(target, ".SplineKnot 01"), GetRelativePrefabEntity(target, ".SplineKnot 02"), 0)
    AudioPostEventOn(GetRelativePrefabEntity(target, ".snd_turreteye"), "Play_sfx_AUT_turret_open")
    wait(1)
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_ActivateShield fires tcy_TurretAttack!")
    tcy_TurretAttack(target)
  elseif (direction == "down") then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_ActivateShield called!! Turret shields shutdown!!")
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_ActivateShield finds data.Player_Exterior == 0; Resume Shutdown!!")
    Print("DKF *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* ShortRangeThinnerTriggerDamageBase - DisableComponent")
    DisableComponent(GetRelativePrefabEntity(target, ".ShortRangeThinnerTriggerDamageBase 01"), "Physics Trigger Damage Component")
    data.CurrentMode = 0
    TimerDisable(GetRelativePrefabEntity(target, ".TurretAttack_LogicTimerMarker 01"))
    SetPropertyEntity(turretBody, "Shooter Target", GetRelativePrefabEntity(target, ".Marker(Parentable) 02"), 0)
    DisableComponent(turretBody, "Rotator")
    DisableComponent(turretBody, "Shooter")
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_ActivateShield shuts off long range shooter!!")
    SplineFollower_StopAtPosition(turretShield, GetRelativePrefabEntity(target, ".SplineKnot 01"), GetRelativePrefabEntity(target, ".SplineKnot 02"), 1)
    AudioPostEventOn(GetRelativePrefabEntity(target, ".snd_turreteye"), "Play_sfx_AUT_turret_close")
    if (data.JetFXactive == 1) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_ActivateShield finds that data.JetFXactive == 1! Begin thinner jet VFX shutdown.")
      AudioPostEventOn(GetRelativePrefabEntity(target, ".snd_turreteye"), "Stop_sfx_AUT_turret_thinner_jet")
      local jetFx = GetRelativePrefabEntity(target, ".thinnerJet")
      data.JetFXactive = 0
      local a = 1
      while true do
        if (not (data.JetFXactive == 0)) then
          break
        end
        if (not (0 < a)) then
          break
        end
        a = (a - 0.25)
        SetR3MTColorReg(jetFx, 1, vector4(0, 0, 0, a), R3MT_Color_Alpha)
        Wait(0.05000000074505806)
        data = GetPrefabData(target)
      end
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_ActivateShield thinner jet VFX shutdown complete!!")
    end
  end
  TimerReset(GetRelativePrefabEntity(target, ".TurretShieldLogicTimer 01"))
  TimerEnable(GetRelativePrefabEntity(target, ".TurretShieldLogicTimer 01"))
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_ActivateShield Resets and activates turret shield timer (for deactivating spline behavior!!")
  return 
end
tcy_DeactivateShield = function(target)
  TimerDisable(GetRelativePrefabEntity(target, ".TurretShieldLogicTimer 01"))
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_DeactivateShield called!!  Turret shield timer disabled, splinefollower disabled.")
  return 
end
tcy_TurretShocked = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_ELECTRIC) then
    local data = GetPrefabData(_self())
    if (data.TurretState == 0) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretShocked calling tcy_ActivateShield - down.")
      FireThread(tcy_ActivateShield, _self(), "down")
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretShocked called, Turret is stunned, enable Oswald Attack timeout timer.")
      TimerReset(GetRelativePrefabEntity(_self(), ".OswaldAttack_LogicTimerMarker 01"))
      TimerEnable(GetRelativePrefabEntity(_self(), ".OswaldAttack_LogicTimerMarker 01"))
    end
  end
  return 
end
tcy_TurretRecover = function(reg_0)
end
tcy_turretPlayerTracking = function(player, setting, turret)
  local tarTurret = 0
  if (turret == nil) then
    tarTurret = _self()
  else
    tarTurret = turret
    Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking was passed value " .. tarTurret) .. " from an external trigger!"))
  end
  local data = GetPrefabData(tarTurret)
  if (data.TurretState == 0) then
    local targetPlayer = 0
    local camera = GetRelativePrefabEntity(tarTurret, ".Interior_Marker(CameraOverride) 01")
    if (GetName(player) == GetName(GetPlayer())) then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking called by Mickey.")
      targetPlayer = "Mickey"
    else
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking called by Oswald.")
      targetPlayer = "Oswald"
    end
    if (setting == "enterEXT") then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as enterEXT.")
      if (targetPlayer == "Mickey") then
        data.Mickey_InRange = 1
      elseif (targetPlayer == "Oswald") then
        data.Oswald_InRange = 1
        if (setting == "leaveEXT") then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as leaveEXT.")
          if (targetPlayer == "Mickey") then
            data.Mickey_InRange = 0
          elseif (targetPlayer == "Oswald") then
            data.Oswald_InRange = 0
            if (setting == "enterINT") then
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as enterINT.")
              if (targetPlayer == "Mickey") then
                data.Mickey_InRange = 3
                SetCameraAttributesForPlayer(camera, GetPlayer())
              elseif (targetPlayer == "Oswald") then
                data.Oswald_InRange = 3
                SetCameraAttributesForPlayer(camera, GetPlayerOrAI(PLAYER_TWO))
                if (setting == "leaveINT") then
                  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as leaveINT.")
                  if (targetPlayer == "Mickey") then
                    data.Mickey_InRange = 1
                    ClearCameraAttributesForPlayer(camera, GetPlayer())
                  elseif (targetPlayer == "Oswald") then
                    data.Oswald_InRange = 1
                    ClearCameraAttributesForPlayer(camera, GetPlayerOrAI(PLAYER_TWO))
                  end
                end
              end
            elseif (setting == "leaveINT") then
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as leaveINT.")
              if (targetPlayer == "Mickey") then
                data.Mickey_InRange = 1
                ClearCameraAttributesForPlayer(camera, GetPlayer())
              elseif (targetPlayer == "Oswald") then
                data.Oswald_InRange = 1
                ClearCameraAttributesForPlayer(camera, GetPlayerOrAI(PLAYER_TWO))
              end
            end
          end
        elseif (setting == "enterINT") then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as enterINT.")
          if (targetPlayer == "Mickey") then
            data.Mickey_InRange = 3
            SetCameraAttributesForPlayer(camera, GetPlayer())
          elseif (targetPlayer == "Oswald") then
            data.Oswald_InRange = 3
            SetCameraAttributesForPlayer(camera, GetPlayerOrAI(PLAYER_TWO))
            if (setting == "leaveINT") then
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as leaveINT.")
              if (targetPlayer == "Mickey") then
                data.Mickey_InRange = 1
                ClearCameraAttributesForPlayer(camera, GetPlayer())
              elseif (targetPlayer == "Oswald") then
                data.Oswald_InRange = 1
                ClearCameraAttributesForPlayer(camera, GetPlayerOrAI(PLAYER_TWO))
              end
            end
          end
        elseif (setting == "leaveINT") then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as leaveINT.")
          if (targetPlayer == "Mickey") then
            data.Mickey_InRange = 1
            ClearCameraAttributesForPlayer(camera, GetPlayer())
          elseif (targetPlayer == "Oswald") then
            data.Oswald_InRange = 1
            ClearCameraAttributesForPlayer(camera, GetPlayerOrAI(PLAYER_TWO))
          end
        end
      end
    elseif (setting == "leaveEXT") then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as leaveEXT.")
      if (targetPlayer == "Mickey") then
        data.Mickey_InRange = 0
      elseif (targetPlayer == "Oswald") then
        data.Oswald_InRange = 0
        if (setting == "enterINT") then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as enterINT.")
          if (targetPlayer == "Mickey") then
            data.Mickey_InRange = 3
            SetCameraAttributesForPlayer(camera, GetPlayer())
          elseif (targetPlayer == "Oswald") then
            data.Oswald_InRange = 3
            SetCameraAttributesForPlayer(camera, GetPlayerOrAI(PLAYER_TWO))
            if (setting == "leaveINT") then
              Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as leaveINT.")
              if (targetPlayer == "Mickey") then
                data.Mickey_InRange = 1
                ClearCameraAttributesForPlayer(camera, GetPlayer())
              elseif (targetPlayer == "Oswald") then
                data.Oswald_InRange = 1
                ClearCameraAttributesForPlayer(camera, GetPlayerOrAI(PLAYER_TWO))
              end
            end
          end
        elseif (setting == "leaveINT") then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as leaveINT.")
          if (targetPlayer == "Mickey") then
            data.Mickey_InRange = 1
            ClearCameraAttributesForPlayer(camera, GetPlayer())
          elseif (targetPlayer == "Oswald") then
            data.Oswald_InRange = 1
            ClearCameraAttributesForPlayer(camera, GetPlayerOrAI(PLAYER_TWO))
          end
        end
      end
    elseif (setting == "enterINT") then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as enterINT.")
      if (targetPlayer == "Mickey") then
        data.Mickey_InRange = 3
        SetCameraAttributesForPlayer(camera, GetPlayer())
      elseif (targetPlayer == "Oswald") then
        data.Oswald_InRange = 3
        SetCameraAttributesForPlayer(camera, GetPlayerOrAI(PLAYER_TWO))
        if (setting == "leaveINT") then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as leaveINT.")
          if (targetPlayer == "Mickey") then
            data.Mickey_InRange = 1
            ClearCameraAttributesForPlayer(camera, GetPlayer())
          elseif (targetPlayer == "Oswald") then
            data.Oswald_InRange = 1
            ClearCameraAttributesForPlayer(camera, GetPlayerOrAI(PLAYER_TWO))
          end
        end
      end
    elseif (setting == "leaveINT") then
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking set as leaveINT.")
      if (targetPlayer == "Mickey") then
        data.Mickey_InRange = 1
        ClearCameraAttributesForPlayer(camera, GetPlayer())
      elseif (targetPlayer == "Oswald") then
        data.Oswald_InRange = 1
        ClearCameraAttributesForPlayer(camera, GetPlayerOrAI(PLAYER_TWO))
      end
    end
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_turretPlayerTracking fires tcy_TurretAttack!")
    tcy_TurretAttack(tarTurret)
  end
  return 
end
tcy_Turret_firedShot = function()
  local data = GetPrefabData(_self())
  data.ShotCooldownLock = 1
  wait(1.5)
  data.ShotCooldownLock = 0
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_Turret_firedShot fires tcy_TurretAttack!")
  tcy_TurretAttack(_self())
  return 
end
tcy_TurretAttack = function(turret)
  local data = GetPrefabData(turret)
  local mickey_player = GetPlayer()
  local oswald = GetPlayerOrAI(PLAYER_TWO)
  if (data.ShotCooldownLock == 0) then
    if (data.TurretState == 0) then
      Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack finds turret CurrentMode is " .. data.CurrentMode) .. "!"))
      Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack finds MickeyTracking is " .. data.Mickey_InRange) .. "!"))
      Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack finds OswaldTracking is " .. data.Oswald_InRange) .. "!"))
      if (data.CurrentMode == 0) then
        if (data.Oswald_InRange ~= 0) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack opens shield - calling tcy_ActivateShield - up!")
          data.CurrentMode = 1
          tcy_ActivateShield(turret, "up")
        end
      elseif (TCY_AUT_PlayerOne_Invis == 0) then
        if (data.Mickey_InRange == 3) then
          if (data.CurrentMode ~= 3) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack activates Short Range - Mickey!")
            tcy_TurretJetsCloseRange(mickey_player, turret, "on")
          end
        end
      elseif (TCY_AUT_PlayerTwo_Invis == 0) then
        if (data.Oswald_InRange == 3) then
          if (data.CurrentMode ~= 3) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack activates Short Range - Oswald!")
            tcy_TurretJetsCloseRange(oswald, turret, "on")
          end
        end
      elseif (TCY_AUT_PlayerOne_Invis == 0) then
        if (data.Mickey_InRange == 1) then
          if (data.CurrentMode == 3) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack deactivates Short Range - Mickey!")
            tcy_TurretJetsCloseRange(mickey_player, turret, "off")
          elseif (0 < data.CurrentMode) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack fires tcy_TurretLongRange at Mickey!")
            tcy_TurretLongRange("mickey", turret, "on")
            if (TCY_AUT_PlayerTwo_Invis == 0) then
              if (data.Oswald_InRange == 1) then
                if (data.CurrentMode == 3) then
                  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack deactivates Short Range - Oswald!")
                  tcy_TurretJetsCloseRange(oswald, turret, "off")
                elseif (0 < data.CurrentMode) then
                  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack fires tcy_TurretLongRange at Oswald!")
                  tcy_TurretLongRange("oswald", turret, "on")
                  if (TCY_AUT_PlayerOne_Invis == 1) then
                    if (TCY_AUT_PlayerTwo_Invis == 1) then
                      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack finds neither player in range. Calling tcy_ActivateShield - down.")
                      data.CurrentMode = 0
                      tcy_ActivateShield(turret, "down")
                    end
                  end
                end
              end
            elseif (TCY_AUT_PlayerOne_Invis == 1) then
              if (TCY_AUT_PlayerTwo_Invis == 1) then
                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack finds neither player in range. Calling tcy_ActivateShield - down.")
                data.CurrentMode = 0
                tcy_ActivateShield(turret, "down")
              end
            end
          end
        end
      elseif (TCY_AUT_PlayerTwo_Invis == 0) then
        if (data.Oswald_InRange == 1) then
          if (data.CurrentMode == 3) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack deactivates Short Range - Oswald!")
            tcy_TurretJetsCloseRange(oswald, turret, "off")
          elseif (0 < data.CurrentMode) then
            Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack fires tcy_TurretLongRange at Oswald!")
            tcy_TurretLongRange("oswald", turret, "on")
            if (TCY_AUT_PlayerOne_Invis == 1) then
              if (TCY_AUT_PlayerTwo_Invis == 1) then
                Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack finds neither player in range. Calling tcy_ActivateShield - down.")
                data.CurrentMode = 0
                tcy_ActivateShield(turret, "down")
              end
            end
          end
        end
      elseif (TCY_AUT_PlayerOne_Invis == 1) then
        if (TCY_AUT_PlayerTwo_Invis == 1) then
          Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretAttack finds neither player in range. Calling tcy_ActivateShield - down.")
          data.CurrentMode = 0
          tcy_ActivateShield(turret, "down")
        end
      end
    end
  end
  return 
end
tcy_TurretJetsCloseRange = function(player, turret, setting)
  local data = GetPrefabData(turret)
  local jetFx = GetRelativePrefabEntity(turret, ".thinnerJet")
  if (setting == "on") then
    data.CurrentMode = 3
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose called!!  Turret shortrange attack engaged.")
    local turretBody = GetRelativePrefabEntity(turret, ".TCY_GuardianSiphon_01d_inert 01")
    EnableComponent(turretBody, "Rotator")
    DisableComponent(turretBody, "Shooter")
    SetRotatorMaxSpeed(turretBody, 60)
    SetPropertyEntity(turretBody, "RotateToEntity", nil, 0)
    if (data.TurretState == 0) then
      if (data.TurretStunned == 0) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose finds that data.Player_Interior > 0!")
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose FadeIn ThinnerJet FX begins")
        AudioPostEventOn(GetRelativePrefabEntity(turret, ".snd_turreteye"), "Play_sfx_AUT_turret_thinner_jet")
        data.JetFXactive = 1
        local a = 0.20000000298023224
        while true do
          if (not (data.JetFXactive == 1)) then
            break
          end
          if (not (a < 1)) then
            break
          end
          a = (a + 0.20000000298023224)
          SetR3MTColorReg(jetFx, 1, vector4(0, 0, 0, a), R3MT_Color_Alpha)
          Wait(0.05000000074505806)
          data = GetPrefabData(turret)
        end
        Print("DKF *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* ShortRangeThinnerTriggerDamageBase - EnableComponent")
        EnableComponent(GetRelativePrefabEntity(turret, ".ShortRangeThinnerTriggerDamageBase 01"), "Physics Trigger Damage Component")
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose FadeIn ThinnerJet FX complete")
      end
    end
    if (data.TurretState == 0) then
      if (data.TurretStunned == 0) then
        Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose STILL finds that data.Player_Interior > 0!")
        local turretSwitchDir, turretSwitchDir = 0, "*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose STILL finds that data.Player_Interior > 0!"
        turretSwitchDir = Print
        turretSwitchDir("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose begin rotation compares against player position")
        while true do
          turretSwitchDir = data.JetFXactive
          if (not (turretSwitchDir == 1)) then
            break
          end
          turretSwitchDir = GetPosition
          turretSwitchDir = turretSwitchDir(player)
          local PlayerPosition = player
          PlayerPosition = GetPosition
          PlayerPosition = PlayerPosition(turretBody)
          local TurretPosition = turretBody
          TurretPosition = (turretSwitchDir - PlayerPosition)
          local TurretToPlayer = 0
          TurretToPlayer = GetFacing
          TurretToPlayer = TurretToPlayer(turretBody)
          local TurretFacing = turretBody
          TurretPosition.y = 0
          TurretFacing = TurretPosition.normalize3
          TurretFacing(TurretPosition)
          TurretToPlayer.y = 0
          TurretFacing = TurretToPlayer.normalize3
          TurretFacing(TurretToPlayer)
          TurretFacing = TurretToPlayer.x
          TurretFacing = (TurretFacing * TurretPosition.x)
          TurretFacing = (TurretFacing + (TurretToPlayer.z * TurretPosition.z))
          local dotProduct = (TurretToPlayer.z * TurretPosition.z)
          if (TurretFacing < -0.8999999761581421) then
            if (turretSwitchDir == 1) then
              turretSwitchDir = 0
              dotProduct = Reverse
              dotProduct(turretBody)
              dotProduct = SetRotatorMaxSpeed
              dotProduct(turretBody, math.random(60, 90))
            end
          elseif (0.8999999761581421 < TurretFacing) then
            turretSwitchDir = 1
            dotProduct = Print
            dotProduct("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose (switch direction) fires tcy_TurretAttack!")
            dotProduct = tcy_TurretAttack
            dotProduct(turret)
          end
          dotProduct = print
          dotProduct((("Compare value" .. TurretFacing) .. " "))
          dotProduct = wait
          dotProduct(0.30000001192092896)
          dotProduct = GetPrefabData
          dotProduct = dotProduct(_self())
        end
      end
    end
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose rotation compare loop broken")
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose called, shortrange attack terminates.")
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose called, begin FadeOut ThinnerJet FX")
    AudioPostEventOn(GetRelativePrefabEntity(_self(), ".snd_turreteye"), "Stop_sfx_AUT_turret_thinner_jet")
    Print("DKF *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* ShortRangeThinnerTriggerDamageBase - DisableComponent")
    DisableComponent(GetRelativePrefabEntity(_self(), ".ShortRangeThinnerTriggerDamageBase 01"), "Physics Trigger Damage Component")
    data.JetFXactive = 0
    local turretBody = GetRelativePrefabEntity(turret, ".TCY_GuardianSiphon_01d_inert 01")
    SetRotatorMaxSpeed(turretBody, 180)
    local a = 1
    while true do
      if (not (data.JetFXactive == 0)) then
        break
      end
      if (not (0 < a)) then
        break
      end
      a = (a - 0.25)
      turretBody = a
      SetR3MTColorReg(jetFx, 1, vector4(0, 0, 0, turretBody), R3MT_Color_Alpha)
      Wait(0.05000000074505806)
      data = GetPrefabData(turret)
    end
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose finished FadeOut ThinnerJet FX")
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose rotate the turret to face the player")
    local dotProduct = 1
    while (0.10000000149011612 < dotProduct) do
      local PlayerPosition = GetPosition(player)
      local TurretPosition = GetPosition(turretBody)
      local TurretToPlayer = (PlayerPosition - TurretPosition)
      local TurretFacing = GetFacing(turretBody)
      TurretToPlayer.y = 0
      TurretToPlayer:normalize3()
      TurretFacing.y = 0
      TurretFacing:normalize3()
      turretBody = TurretToPlayer.z
      dotProduct = ((TurretFacing.x * TurretToPlayer.x) + (TurretFacing.z * turretBody))
      wait(0.30000001192092896)
    end
    data.CurrentMode = 1
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretJetsClose fires tcy_TurretAttack!")
    tcy_TurretAttack(turret)
  end
  return 
end
tcy_TurretLongRange = function(player, turret, setting)
  local data = GetPrefabData(turret)
  local turretBody = GetRelativePrefabEntity(turret, ".TCY_GuardianSiphon_01d_inert 01")
  if (setting == "on") then
    Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretLongRange called, turret will target " .. player) .. ""))
    if (player == "mickey") then
      player = GetPlayer()
    else
      player = GetPlayerOrAI(PLAYER_TWO)
    end
    data.CurrentMode = 1
    SetPropertyEntity(turretBody, "RotateToEntity", player, 0)
    EnableComponent(turretBody, "Rotator")
    SetRotatorMaxSpeed(turretBody, 90)
    SetPropertyEntity(turretBody, "Shooter Target", player, 0)
    EnableComponent(turretBody, "Shooter")
  else
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretLongRange called, shooter disengaging.")
    SetPropertyEntity(turretBody, "Shooter Target", GetRelativePrefabEntity(turret, ".Marker(Parentable) 02"), 0)
    DisableComponent(turretBody, "Shooter")
  end
  return 
end
tcy_TurretSleep = function(target)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretSleep called!!")
  local data = GetPrefabData(target)
  if (data.TurretState == 0) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretSleep thinks Turret is alive, clearing player data... (this seems wrong)")
    data.Player_Interior = 0
    data.Player_Exterior = 0
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretSleep sets data.Player_Interior = 0; data.Player_Exterior = 0")
    TimerDisable(GetRelativePrefabEntity(target, ".TurretAttack_LogicTimerMarker 01"))
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretSleep called tcy_ActivateShield - down!!")
    FireThread(tcy_ActivateShield, target, "down")
  end
  return 
end
tcy_TV_HitsTurret = function(target)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TV_HitsTurret called!!")
  local data = GetPrefabData(_self())
  if (data.TurretState == 0) then
    data.TurretStunned = 1
    TimerDisable(GetRelativePrefabEntity(_self(), ".TurretAttack_LogicTimerMarker 01"))
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TV_HitsTurret called tcy_ActivateShield - down!!")
    FireThread(tcy_ActivateShield, _self(), "down")
  end
  return 
end
tcy_TV_OffTurret = function(target)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TV_OffTurret called!! This is doing nothing right now!")
  local data = GetPrefabData(_self())
  if (data.TurretState == 0) then
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TV_OffTurret called tcy_TurretFocusOnMickey!!")
  end
  return 
end
tcy_BreakTurretPanel = function(target)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_BreakTurretPanel called  Turret Panel hacked!!")
  local data = GetPrefabData(_self())
  data.HowManyPanels = (data.HowManyPanels - 1)
  if (data.HowManyPanels == 0) then
    if (data.TurretState == 0) then
      data.TurretState = 1
      SetGlobal(data.SiphonGlobal, 1)
      Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_BreakTurretPanel called tcy_ActivateShield - down!!")
      FireThread(tcy_ActivateShield, _self(), "down")
      ClearCameraAttributesForPlayer(GetRelativePrefabEntity(_self(), ".Interior_Marker(CameraOverride) 01"), nil)
      FireUser1(data.SiphonGeyser)
    end
  end
  return 
end
tcy_PressureRising = function(target)
  Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_PressureRising called!! Final vacuum vent was plugged!!")
  local data = GetPrefabData(_self())
  StartEmitters(GetRelativePrefabEntity(_self(), ".explosion 01"))
  if (data.TurretState == 0) then
    data.TurretState = 2
    SetGlobal(data.SiphonGlobal, 2)
    Print("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_PressureRising called tcy_ActivateShield - down!!")
    FireThread(tcy_ActivateShield, _self(), "down")
    ClearCameraAttributesForPlayer(GetRelativePrefabEntity(_self(), ".Interior_Marker(CameraOverride) 01"), nil)
    FireUser1("TCY_autotopia_01a_zapper_01a 01")
    FireUser1(data.TurretDestroyedCont)
  end
  return 
end
tcy_TurretSpray_Interrupt = function(target, turret, state)
  Print((("*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretSpray_Interrupt called!! Will " .. state) .. " the VFX!!"))
  local data = GetPrefabData(turret)
  local jetFx = GetRelativePrefabEntity(turret, ".thinnerJet")
  if (state == "show") then
    local a = 0.25
    while true do
      if (not (data.JetFXactive == 1)) then
        break
      end
      if (not (a < 1)) then
        break
      end
      a = (a + 0.25)
      SetR3MTColorReg(jetFx, 1, vector4(0, 0, 0, a), R3MT_Color_Alpha)
      Wait(0.05000000074505806)
      data = GetPrefabData(turret)
    end
    if (data.JetFXactive == 1) then
      Print("DKF *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* ShortRangeThinnerTriggerDamageBase - EnableComponent")
      EnableComponent(GetRelativePrefabEntity(turret, ".ShortRangeThinnerTriggerDamageBase 01"), "Physics Trigger Damage Component")
    else
      Print("DKF *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* tcy_TurretSpray_Interrupt showing but the jet is inactive!")
      if (state == "hide") then
        local a, a = 1, Print
        a = Print
        a("DKF *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* ShortRangeThinnerTriggerDamageBase - DisableComponent")
        a = DisableComponent
        a(GetRelativePrefabEntity(turret, ".ShortRangeThinnerTriggerDamageBase 01"), "Physics Trigger Damage Component")
        while true do
          a = data.JetFXactive
          if (not (a == 1)) then
            break
          end
          if (not (0 < a)) then
            break
          end
          a = (a - 0.25)
          a = SetR3MTColorReg
          a(jetFx, 1, vector4(0, 0, 0, a), R3MT_Color_Alpha)
          a = Wait
          a(0.05000000074505806)
          a = GetPrefabData
          a = a(turret)
          data = a
        end
      end
    end
  elseif (state == "hide") then
    local a, a = 1, ".thinnerJet"
    a = Print
    a("DKF *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* ShortRangeThinnerTriggerDamageBase - DisableComponent")
    a = DisableComponent
    a(GetRelativePrefabEntity(turret, ".ShortRangeThinnerTriggerDamageBase 01"), "Physics Trigger Damage Component")
    while true do
      a = data.JetFXactive
      if (not (a == 1)) then
        break
      end
      if (not (0 < a)) then
        break
      end
      a = (a - 0.25)
      a = SetR3MTColorReg
      a(jetFx, 1, vector4(0, 0, 0, a), R3MT_Color_Alpha)
      a = Wait
      a(0.05000000074505806)
      a = GetPrefabData
      a = a(turret)
      data = a
    end
  end
  return 
end

