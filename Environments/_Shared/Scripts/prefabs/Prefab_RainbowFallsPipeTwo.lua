pipeGreenSide = 0
pipeBlueSide = 0
pipeGreenCouplingOut = 0
pipeBlueCouplingOut = 0
gearBlockersPainted = 1
Prefab_DropReturnPipe = function(target)
  EnableMotion(GetRelativePrefabEntity(target, ".ReturnPipe"))
  DestroyEntity(GetRelativePrefabEntity(target, ".ForwardPipeConstraintHinge"))
  return 
end
Prefab_RaisePipeBlocker = function(target, event)
  local fairyTime = GetConfigVariableFloat("DefaultAbilities_Sketch_Fairy_Duration")
  local data = GetPrefabData(target)
  Print("got stimmed")
  Print(data.GlobalVariable)
  Print(("Fairy time is: " .. fairyTime))
  if StimulusEvent_HasStimulusType(event, ST_FAIRY) then
    Print("Got fairy stimmed")
    if (GetGlobal(data.GlobalVariable) == 0) then
      Print("on ground")
      SetGlobal(data.GlobalVariable, 1)
      SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PipeBlocker"), 2)
      SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PipeBlocker"), GetRelativePrefabEntity(target, ".PipeBlockerSK1"), GetRelativePrefabEntity(target, ".PipeBlockerSK2"), 1)
      Wait(fairyTime)
      Print("Have waited")
      if (GetGlobal(data.GlobalVariable) == 1) then
        Print("was in air")
        SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PipeBlocker"), GetRelativePrefabEntity(target, ".PipeBlockerSK1"), GetRelativePrefabEntity(target, ".PipeBlockerSK2"), 0)
        SetGlobal(data.GlobalVariable, 0)
      end
    end
  elseif StimulusEvent_HasStimulusType(event, ST_THINNER) then
    Print("Hit by thinner")
    if (GetGlobal(data.GlobalVariable) == 1) then
      Print("in air")
      SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PipeBlocker"), GetRelativePrefabEntity(target, ".PipeBlockerSK1"), GetRelativePrefabEntity(target, ".PipeBlockerSK2"), 0)
      SetGlobal(data.GlobalVariable, 0)
    end
  end
  return 
end
Prefab_GeneratorStateChange = function(target)
  local data = GetPrefabData(target)
  if GetPropertyBool(GetRelativePrefabEntity(target, ".PipeBlockerGenerator"), "Is Painted") then
    SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".GeneratorGear1"), 90)
  else
    SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".GeneratorGear1"), 0)
  end
  if GetPropertyBool(GetRelativePrefabEntity(target, ".PipeBlockerGenerator"), "Is Painted") then
    if GetPropertyBool(GetRelativePrefabEntity(target, ".GeneratorGear2"), "Is Painted") then
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".GeneratorGear2"), -90)
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".GeneratorGear3"), 90)
      SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".GeneratorGear4"), -90)
    end
  else
    SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".GeneratorGear2"), 0)
    SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".GeneratorGear3"), 0)
    SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".GeneratorGear4"), 0)
  end
  if GetPropertyBool(GetRelativePrefabEntity(target, ".PipeBlockerGenerator"), "Is Painted") then
    if GetPropertyBool(GetRelativePrefabEntity(target, ".GeneratorGear2"), "Is Painted") then
      if GetPropertyBool(GetRelativePrefabEntity(target, ".GeneratorGear5"), "Is Painted") then
        SetGlobal(data.GlobalVariable, 2)
        SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".GeneratorGear5"), 90)
        SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".GeneratorGear6"), -90)
        SetSplineFollowerInitialSpeed(GetRelativePrefabEntity(target, ".PipeBlocker"), 2)
        SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PipeBlocker"), GetRelativePrefabEntity(target, ".PipeBlockerSK1"), GetRelativePrefabEntity(target, ".PipeBlockerSK2"), 1)
      end
    end
  else
    SetGlobal(data.GlobalVariable, 0)
    SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".GeneratorGear5"), 0)
    SetRotatorMaxSpeed(GetRelativePrefabEntity(target, ".GeneratorGear6"), 0)
    SplineFollower_StopAtPosition(GetRelativePrefabEntity(target, ".PipeBlocker"), GetRelativePrefabEntity(target, ".PipeBlockerSK1"), GetRelativePrefabEntity(target, ".PipeBlockerSK2"), 0)
  end
  return 
end
Prefab_StartThinnerSpray = function(reg_0)
  return 
end
Prefab_StopSprayPaint = function(target)
  DisableMotion(GetRelativePrefabEntity(target, ".ReturnPipe"))
  return 
end
Prefab_StopSprayThinner = function(target)
  DisableMotion(GetRelativePrefabEntity(target, ".ReturnPipe"))
  return 
end
Prefab_ReturnPipeLocation = function(target, location)
  local data = GetPrefabData(target)
  Print(("Initial Return Pipe Location: " .. data.ReturnPipeLocation))
  data.ReturnPipeLocation = location
  Print(("Return Pipe Location: " .. data.ReturnPipeLocation))
  RF_PipeRoomSetup()
  wait(0.10000000149011612)
  RF_OswaldMoveLogic()
  return 
end
Prefab_PipeRotated = function(target, state, side)
  Print("Prefab_PipeRotated")
  if (state == "end") then
    if (side == "green") then
      pipeGreenSide = 1
    else
      pipeBlueSide = 1
    end
    Prefab_CheckPipes()
  elseif (side == "green") then
    pipeGreenSide = 0
  else
    pipeBlueSide = 0
  end
  return 
end
Prefab_ExtendBlueCoupling = function(target, state, pipe)
  Print("Prefab_ExtendBlueCoupling")
  if (state == "out") then
    if (pipe == "green") then
      pipeGreenCouplingOut = 1
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_BluePipe", "LPF_sfx_RBF_RainbowPipe_Blue_Off")
    else
      pipeBlueCouplingOut = 1
      AudioPostEventOn("rbc_falls_01_shared_audio.Snd_BluePipeNeutral", "LPF_sfx_rbf_BluePipeNeutral_Off")
    end
    Prefab_CheckPipes(target)
  elseif (pipe == "green") then
    pipeGreenCouplingOut = 0
  else
    pipeBlueCouplingOut = 0
  end
  return 
end
Prefab_CheckPipes = function(target)
  Print(pipeGreenSide)
  Print(pipeGreenCouplingOut)
  Print(pipeBlueSide)
  Print(pipeBlueCouplingOut)
  if (pipeGreenSide == 1) then
    if (pipeGreenCouplingOut == 1) then
      RF_OswaldSwtichPipe2(target, "left")
    end
  elseif (pipeBlueSide == 1) then
    if (pipeBlueCouplingOut == 1) then
      RF_OswaldSwtichPipe2(target, "right")
    end
  end
  return 
end
Prefab_SetupGearBlockers = function(reg_0)
  return 
end
Prefab_PaintThinGearBlockers = function(target, state)
  if (state == "paint") then
    gearBlockersPainted = (gearBlockersPainted + 1)
    if (gearBlockersPainted == 1) then
      Prefab_WeighGearBlockers(target, "center")
      SetGlobal("RBF_GearBlockers", 0)
    elseif (gearBlockersPainted == 2) then
      Prefab_WeighGearBlockers(target, "right")
      SetGlobal("RBF_GearBlockers", 1)
      gearBlockersPainted = (gearBlockersPainted - 1)
      if (gearBlockersPainted == 1) then
        Prefab_WeighGearBlockers(target, "center")
        SetGlobal("RBF_GearBlockers", 0)
      elseif (gearBlockersPainted == 0) then
        Prefab_WeighGearBlockers(target, "left")
        SetGlobal("RBF_GearBlockers", -1)
      end
    end
  else
    gearBlockersPainted = (gearBlockersPainted - 1)
    if (gearBlockersPainted == 1) then
      Prefab_WeighGearBlockers(target, "center")
      SetGlobal("RBF_GearBlockers", 0)
    elseif (gearBlockersPainted == 0) then
      Prefab_WeighGearBlockers(target, "left")
      SetGlobal("RBF_GearBlockers", -1)
    end
  end
  Print(gearBlockersPainted)
  return 
end
Prefab_GearBlockersOnLoad = function(target)
  if (GetGlobal("RBF_GearBlockers") == -1) then
    gearBlockersPainted = 0
    Prefab_WeighGearBlockers(target, "left")
  elseif (GetGlobal("RBF_GearBlockers") == 0) then
    gearBlockersPainted = 1
    Prefab_WeighGearBlockers(target, "center")
  else
    gearBlockersPainted = 2
    Prefab_WeighGearBlockers(target, "right")
  end
  return 
end
WeightPosition = 0
Prefab_WeighGearBlockers = function(target, weight)
  Print(weight)
  if (weight == "left") then
    WeightPosition = -1
    if (pipeunderweight == 0) then
      SplineFollower_StopAtPosition("RF_PipeBlocker1", "RF_Blocker1Knot1", "RF_Blocker1Knot2", 0)
      SplineFollower_StopAtPosition("RF_PipeBlocker2", "RF_Blocker2Knot1", "RF_Blocker2Knot2", 1)
    end
  elseif (weight == "center") then
    WeightPosition = 0
    if (pipeunderweight == 0) then
      SplineFollower_StopAtPosition("RF_PipeBlocker1", "RF_Blocker1Knot1", "RF_Blocker1Knot2", 0.5)
      SplineFollower_StopAtPosition("RF_PipeBlocker2", "RF_Blocker2Knot1", "RF_Blocker2Knot2", 0.5)
    end
  elseif (weight == "right") then
    WeightPosition = 1
    if (pipeunderweight == 0) then
      SplineFollower_StopAtPosition("RF_PipeBlocker1", "RF_Blocker1Knot1", "RF_Blocker1Knot2", 1)
      SplineFollower_StopAtPosition("RF_PipeBlocker2", "RF_Blocker2Knot1", "RF_Blocker2Knot2", 0)
    end
  end
  Print(("WeightPosition: " .. WeightPosition))
  return 
end
leftblocked = 0
rightblocked = 0
pipeunderweight = 0
Prefab_PipeUnderBlockers = function(target, side, state)
  if (side == "left") then
    if (state == "in") then
      leftblocked = 1
      pipeunderweight = 1
    else
      rightblocked = 0
      if (state == "in") then
        rightblocked = 1
        pipeunderweight = 1
      else
        rightblocked = 0
      end
    end
  elseif (state == "in") then
    rightblocked = 1
    pipeunderweight = 1
  else
    rightblocked = 0
  end
  Print(("Under Weight: " .. pipeunderweight))
  Print(("Right Blocked: " .. rightblocked))
  Print(("Left Blocked: " .. leftblocked))
  Print(("WeightPosition: " .. WeightPosition))
  return 
end
Prefab_PipeLeaveUnderWeight = function()
  pipeunderweight = 0
  if (WeightPosition == -1) then
    SplineFollower_StopAtPosition("RF_PipeBlocker1", "RF_Blocker1Knot1", "RF_Blocker1Knot2", 0)
    SplineFollower_StopAtPosition("RF_PipeBlocker2", "RF_Blocker2Knot1", "RF_Blocker2Knot2", 1)
  elseif (WeightPosition == 0) then
    SplineFollower_StopAtPosition("RF_PipeBlocker1", "RF_Blocker1Knot1", "RF_Blocker1Knot2", 0.5)
    SplineFollower_StopAtPosition("RF_PipeBlocker2", "RF_Blocker2Knot1", "RF_Blocker2Knot2", 0.5)
  else
    SplineFollower_StopAtPosition("RF_PipeBlocker1", "RF_Blocker1Knot1", "RF_Blocker1Knot2", 1)
    SplineFollower_StopAtPosition("RF_PipeBlocker2", "RF_Blocker2Knot1", "RF_Blocker2Knot2", 0)
  end
  Print(("WeightPosition Leaving Under Weight: " .. WeightPosition))
  return 
end
