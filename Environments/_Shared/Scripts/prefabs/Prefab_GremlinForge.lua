Prefab_GremlinForge_AlwaysSetup = function(target)
  Print("___Function: Prefab_GremlinForge_AlwaysSetup")
  local data = GetPrefabData(target)
  if (GetGlobal("NOS_BogEasy_DonaldQuest_WhichGear") == 11) then
    AnimGBSequence(GetRelativePrefabEntity(target, ".Flap"), "broken")
    AnimGBSequence(GetRelativePrefabEntity(target, ".Lift"), "broken")
    if (GetGlobal(data.ForgePoweredGlobal) == 1) then
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Roof"), "break")
    else
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Roof"), "broken")
      if (GetGlobal(data.ForgePoweredGlobal) ~= 0) then
        if (GetGlobal(data.ForgePoweredGlobal) == 1) then
          data.ForgeState = -1
          AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Lift"), "moveUp")
          AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Flap"), "open")
          AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Roof"), "break")
        elseif (GetGlobal(data.ForgePoweredGlobal) == 2) then
          data.ForgeState = 1
          AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Lift"), "moveUp")
          AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Flap"), "open")
          AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Roof"), "open")
        end
      end
    end
  elseif (GetGlobal(data.ForgePoweredGlobal) ~= 0) then
    if (GetGlobal(data.ForgePoweredGlobal) == 1) then
      data.ForgeState = -1
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Lift"), "moveUp")
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Flap"), "open")
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Roof"), "break")
    elseif (GetGlobal(data.ForgePoweredGlobal) == 2) then
      data.ForgeState = 1
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Lift"), "moveUp")
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Flap"), "open")
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Roof"), "open")
    end
  end
  return 
end
Prefab_GremlinForge_CameraOverride = function(target)
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 0) then
    SetDefaultCameraValues(13, 25, -18, _activator())
    SetTravelCameraValues(16, 25, -18, _activator())
  end
  return 
end
Prefab_GremlinForge_RestoreCamera = function(target)
  if (GetGlobal("NOS_BogEasy_FirstVisit") == 0) then
    SetTravelCameraValues(7, 8, -1, _activator())
    SetDefaultCameraValues(5, 6, 0, _activator())
  end
  return 
end
Prefab_GremlinForge_GeneratorShockStateChanged = function(target, _State)
  Print(("__Function: Prefab_GremlinForge_GeneratorShockStateChanged, _State: " .. tostring(_State)))
  local data = GetPrefabData("NOS_BogEasy_Forge")
  data.GeneratorPowered = tostring(_State)
  Print(("__ForgeState: " .. tostring(data.ForgeState)))
  if (data.ForgeState == 0) then
    if (_State == "Off") then
      AnimGBSequence("Forge_Generator", "rest")
      AnimGBReset("Forge_Generator")
      while true do
        if (not (data.ForgeAnimating == 1)) then
          break
        end
        Print("__ForgeAnimating!")
        wait(0.10000000149011612)
      end
      Print("__Animating Closed!")
      data.ForgeAnimating = 1
      SetPropertyBool(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Support"), "InvulnerableToPaintThinner", true)
      SetPropertyBool(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Clamp"), "InvulnerableToPaintThinner", true)
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Roof"), "close")
      wait(0.30000001192092896)
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Flap"), "closed")
      wait(0.30000001192092896)
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Lift"), "moveDown")
      data.ForgeAnimating = 0
      Print("__Done Animating Closed!")
    elseif (_State == "On") then
      AnimGBSequence("Forge_Generator", "loop")
      while true do
        if (not (data.ForgeAnimating == 1)) then
          break
        end
        Print("__ForgeAnimating!")
        wait(0.10000000149011612)
      end
      Print("__Animating Open!")
      data.ForgeAnimating = 1
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Lift"), "moveUp")
      wait(0.30000001192092896)
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Flap"), "open")
      wait(0.30000001192092896)
      SetPropertyBool(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Support"), "InvulnerableToPaintThinner", false)
      SetPropertyBool(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Clamp"), "InvulnerableToPaintThinner", false)
      AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Roof"), "open")
      data.ForgeAnimating = 0
      Print("__Done Animating Open!")
    end
  end
  return 
end
Prefab_GremlinForge_RoofPieceShocked = function(target)
  Print("__Function: Prefab_GremlinForge_RoofPieceShocked")
  local data = GetPrefabData("NOS_BogEasy_Forge")
  if (data.ForgeState == -1) then
    SetGlobal(data.ForgePoweredGlobal, 1)
  elseif (data.ForgeState == 1) then
    SetGlobal(data.ForgePoweredGlobal, 2)
  end
  StartEmitters(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".SmokeFX"))
  StartEmitters(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".SteamFX"))
  Disable("OswaldHint_EmergencyGenerator_Roof")
  OswaldStreamAbort()
  OswaldStartFollowAction()
  ForceSequence("NOS_BogEasy_Gus", "NOS_Gus_ForgeHints")
  return 
end
Prefab_GremlinForge_ToonStateChanged = function(target, _Piece, _Painted)
  Print(((("__Function: Prefab_GremlinForge_ToonStateChanged, _Piece: " .. tostring(_Piece)) .. ", _Painted: ") .. tostring(_Painted)))
  local data = GetPrefabData(target)
  if (_Painted == "Painted") then
    if (_Piece == "Clamp") then
      if (data.ForgeState == 0) then
        Print("__Forge Hatch Forced Open!")
        data.ForgeState = 1
        data.ForgeAnimating = 1
        AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Lift"), "moveUp")
        wait(0.30000001192092896)
        AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Flap"), "open")
        wait(0.30000001192092896)
        SetPropertyBool(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Support"), "InvulnerableToPaintThinner", false)
        SetPropertyBool(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Clamp"), "InvulnerableToPaintThinner", false)
        AnimGBSequence(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".Roof"), "open")
        data.ForgeAnimating = 0
        Prefab_GremlinForge_BringOswaldToRoof(target)
      elseif (data.ForgeState == -1) then
        Print("__Unneccessary hatch paint!")
        if (_Piece == "Clamp") then
          if (data.ForgeState == 1) then
            Print("__Forge Hatch Closed Possible!")
            data.ForgeState = 0
          elseif (data.ForgeState == -1) then
            Print("__Unneccessary hatch thin!")
            if (data.ForgeState ~= -1) then
              Print("__Roof breaking off!")
              data.ForgeState = -1
              AnimGBSequence(GetRelativePrefabEntity(target, ".Roof"), "break")
              Prefab_GremlinForge_BringOswaldToRoof(target)
            end
          end
        elseif (data.ForgeState ~= -1) then
          Print("__Roof breaking off!")
          data.ForgeState = -1
          AnimGBSequence(GetRelativePrefabEntity(target, ".Roof"), "break")
          Prefab_GremlinForge_BringOswaldToRoof(target)
        end
      end
    end
  elseif (_Piece == "Clamp") then
    if (data.ForgeState == 1) then
      Print("__Forge Hatch Closed Possible!")
      data.ForgeState = 0
    elseif (data.ForgeState == -1) then
      Print("__Unneccessary hatch thin!")
      if (data.ForgeState ~= -1) then
        Print("__Roof breaking off!")
        data.ForgeState = -1
        AnimGBSequence(GetRelativePrefabEntity(target, ".Roof"), "break")
        Prefab_GremlinForge_BringOswaldToRoof(target)
      end
    end
  elseif (data.ForgeState ~= -1) then
    Print("__Roof breaking off!")
    data.ForgeState = -1
    AnimGBSequence(GetRelativePrefabEntity(target, ".Roof"), "break")
    Prefab_GremlinForge_BringOswaldToRoof(target)
  end
  return 
end
Prefab_GremlinForge_ForgeDestroyed = function(target)
  Print("__Function: Prefab_ForgeDestroyed")
  local data = GetPrefabData(target)
  FireUser1("ForgeScrapMetalSpawner")
  ShakeCamera(1, 3, 1, 0.75, 0.02500000037252903, 0.02500000037252903)
  AnimGBSequence(GetRelativePrefabEntity(target, ".Flap"), "broken")
  AnimGBSequence(GetRelativePrefabEntity(target, ".Lift"), "broken")
  if (data.ForgeState ~= -1) then
    AnimGBSequence(GetRelativePrefabEntity(target, ".Roof"), "broken")
  end
  SetGlobal("NOS_QuestHealth", (GetGlobal("NOS_QuestHealth") - 15))
  StopEmitters(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".SmokeFX"))
  StopEmitters(GetRelativePrefabEntity("NOS_BogEasy_Forge", ".SteamFX"))
  return 
end
Prefab_GremlinForge_SendOswaldToGenerator = function(target)
  Print("__Function: Prefab_GremlinForge_SendOswaldToGenerator")
  ForceSequence("NOS_BogEasy_Oswald", "NOS_Oswald_GotoGenerator")
  wait(1)
  SetGlobal("NOS_BogEasy_DonaldQuest_OswaldToGenerator", 0)
  OswaldStopFollowAction()
  Enable("OswaldHint_EmergencyGenerator_Generator")
  Enable("OswaldHintTrigger_Generator")
  return 
end
Prefab_GremlinForge_OswaldReachedGenerator = function(target)
  Print("__Function: Prefab_GremlinForge_OswaldReachedGenerator")
  ForceSequence("NOS_BogEasy_Oswald", "NOS_Oswald_GotoGenerator")
  return 
end
Prefab_GremlinForge_BringOswaldToRoof = function(target)
  Print("__Function: Prefab_GremlinForge_BringOswaldToRoof")
  local data = GetPrefabData("NOS_BogEasy_Forge")
  if (data.OswaldAttemptingToShockForge == 0) then
    data.OswaldAttemptingToShockForge = 1
    OswaldStreamAbort()
    Disable("OswaldHint_EmergencyGenerator_Generator")
    Disable("OswaldHintTrigger_Generator")
    Enable("OswaldHint_EmergencyGenerator_Roof")
  end
  return 
end
Prefab_GremlinForge_OswaldEmergencyPlaneTrigger = function(target, _Direction)
  Print(("__Function: Prefab_GremlinForge_OswaldEmergencyGenerator, _Direction: " .. tostring(_Direction)))
  local data = GetPrefabData("NOS_BogEasy_Forge")
  if (GetNumPlayers() == 1) then
    if (GetGlobal(data.ForgePoweredGlobal) == 0) then
      if (GetGlobal("NOS_Sparks_DonaldQuest_FixForge_Played") == 1) then
        if (GetGlobal("NOS_Sparks_DonaldQuest_ForgeFixed_Played") == 0) then
          if (_Direction == "Forward") then
            SetGlobal("NOS_BogEasy_DonaldQuest_OswaldToGenerator", -1)
            ForceSequence("NOS_BogEasy_Oswald", "NOS_Oswald_GotoGenerator")
            OswaldStreamAbort()
            OswaldStartFollowAction()
            Disable("OswaldHint_EmergencyGenerator_Generator")
            Disable("OswaldHintTrigger_Generator")
            data.OswaldAttemptingToShockForge = 0
          elseif (_Direction == "Backward") then
            if (data.ForgeState == 0) then
              SetGlobal("NOS_BogEasy_DonaldQuest_OswaldToGenerator", 1)
              Prefab_GremlinForge_SendOswaldToGenerator(target)
            elseif (data.ForgeState == 1) then
              Prefab_GremlinForge_BringOswaldToRoof(target)
            end
          end
        end
      end
    end
  end
  return 
end

