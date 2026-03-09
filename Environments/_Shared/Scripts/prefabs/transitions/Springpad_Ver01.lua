gsSP_AttachBall_to_Springpad = function(target)
  local data = GetPrefabData(_self())
  if (data.SpringPadInAction == 0) then
    data.SpringPadInAction = 1
    data.BallToRelease = target
    local sf = GetRelativePrefabEntity(_self(), ".Ball_SplineMotor 01")
    local sk = GetRelativePrefabEntity(_self(), ".Ball_SplineKnot 01")
    local ball = target
    local sp = GetRelativePrefabEntity(_self(), ".SpringPad 01")
    Disable(sf)
    DisableMotion(ball)
    Disable(ball)
    SetPropertyInt(ball, "Collision Layer", 13)
    TeleportToEntity(sf, ball)
    TeleportToEntity(sk, ball)
    SetParentEntity(ball, sf)
    Enable(sf)
    SetSplineFollowerInitialSpeed(sf, 20)
    AnimGBReset(sp)
    AnimGBSequence(sp, "launch")
    data.SpringPadInAction = 0
    local i = 20
    while (7 < i) do
      i = (i - 1)
      Print((("Slowing ball to speed " .. i) .. "!"))
      SetSplineFollowerInitialSpeed(sf, i)
      wait(0.03999999910593033)
    end
  end
  return 
end
gsSP_Ball_NearsTop = function(target)
  Print("Ball hits hook!")
  local data = GetPrefabData(_self())
  local sf = GetRelativePrefabEntity(_self(), ".Ball_SplineMotor 01")
  local i = 7
  while (3 < i) do
    i = (i - 1)
    Print((("Slowing ball to speed " .. i) .. "!"))
    SetSplineFollowerInitialSpeed(sf, i)
    wait(0.07999999821186066)
  end
  wait(0)
  while (i < 7) do
    i = (i + 1)
    Print((("Slowing ball to speed " .. i) .. "!"))
    SetSplineFollowerInitialSpeed(sf, i)
    wait(0.20000000298023224)
  end
  return 
end
gsSP_ReleaseBall = function(target)
  Print("Ball is released!")
  local data = GetPrefabData(target)
  local sf = GetRelativePrefabEntity(_self(), ".Ball_SplineMotor 01")
  local ball = data.BallToRelease
  ClearParent(ball)
  EnableMotion(ball)
  SetPropertyBool(ball, "Is Mover", false)
  Disable(sf)
  MoveToEntity(ball, sf)
  SetPropertyInt(ball, "Collision Layer", 2)
  SplineFollower_TeleportToKnot(sf, GetRelativePrefabEntity(_self(), ".Ball_SplineKnot 01"))
  SetEntitiesToNotCollide(GetOswaldAI(), GetRelativePrefabEntity(ball, "Oswald2DAvoidObject"))
  ApplyForce(ball, 0, -3000, 0)
  EnableComponent(ball, "Usable")
  return 
end
gsSP_PlayerHit = function(target)
  AnimGBReset(target)
  AnimGBSequence(target, "launch")
  return 
end
gsSP_BlockerPainted = function(target)
  local data = GetPrefabData(_self())
  SplineKnotComponent_SetBranchProbability(GetRelativePrefabEntity(data.Springpad, ".Ball_SplineKnot 01"), 1)
  return 
end
gsSP_BlockerThinned = function(target)
  local data = GetPrefabData(_self())
  SplineKnotComponent_SetBranchProbability(GetRelativePrefabEntity(data.Springpad, ".Ball_SplineKnot 01"), 0)
  return 
end
