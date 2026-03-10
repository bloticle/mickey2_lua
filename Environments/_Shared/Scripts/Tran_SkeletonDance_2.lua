Skeleton2_Pickups = 1
MusicEventVar = 0
AlreadyCheckedFilmReel = false
NOS_BogEasy_PickBlotAlleyVisit_2D = function(target)
  Print("__Function: NOS_BogEasy_PickBlotAlleyVisit_2D")
  if (GetGlobal("FTL_Fort_SpatterState") ~= 10) then
    Print("__WE'RE DONE WITH THE IAN FIGHT IN GULCH 2 -- FLIPPING TO BLOT ALLEY SECOND VISIT")
    if (GetGlobal("FTL_Fort_SpatterState") ~= 1) then
      SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
      if (GetGlobal("NOS_BlotAlley_Ian_2ndVisit_ThinSpatter_Played") == 0) then
        Print("__We should be angry but we havent played the IGC with Ian yet (in gulch or blot)! Prime for it!")
        GetPrefabData("SkeletonDance_Projector_ToBlotAlley").ActivatedLevels = "nos_blotalley_main.section1_visit2_ian"
      else
        Print("__We're angry and we played the igc! Will be no-ian")
        GetPrefabData("SkeletonDance_Projector_ToBlotAlley").ActivatedLevels = "nos_blotalley_main.section1_visit2_noian"
        GetPrefabData("SkeletonDance_Projector_ToBlotAlley").ActivatedLevels = "nos_blotalley_main.section1_visit2_ian"
      end
    end
    GetPrefabData("SkeletonDance_Projector_ToBlotAlley").ActivatedLevels = "nos_blotalley_main.section1_visit2_ian"
    SetGlobal("NOS_BlotAlley_VisitNum", 2)
  end
  return 
end
NOS_BlotAlley_PickBogEasyVisit_2D = function(target)
  Print("__Function: NOS_BlotAlley_PickBogEasyVisit_2D")
  if (GetGlobal("NOS_BogEasy_FirstVisit") ~= 1) then
    Print("__TRANSITION TO BOG EASY FLIPPING TO SECOND VISIT")
    GetPrefabData("SkeletonDance_Projector_ToBogEasy").ActivatedLevels = "nos_bogeasy.oldtown_v2"
  end
  return 
end
Skeleton2_CheckAtStart = function()
  Print("CheckAtStart Fired")
  ResetMusicEvent()
  if (HasCollectible("FilmReel_EM2_SkeletonDance2") == true) then
    if (AlreadyCheckedFilmReel == false) then
      Skeleton2_Pickups = (Skeleton2_Pickups - 1)
      AlreadyCheckedFilmReel = true
    end
  end
  if (MusicEventVar == 0) then
    AudioPostEventOn(GetPlayer(), "Play_MX_2DProj_SkeletonDance")
    MusicEventVar = 1
    Print("Started music event")
  end
  wait(1)
  if (Skeleton2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  else
    ReplaceMusicStateOverride("Exp_N")
    Print("Playing bad music state")
  end
  Print("Skeleton2_CheckAtStart now checking character tracks")
  local data = GetPrefabData("trn_skeletondance_02a.prefab_onewaycollision 01.StaticProp_CollisionObj")
  local data2 = GetPrefabData("trn_skeletondance_02a.prefab_onewaycollision 02.StaticProp_CollisionObj")
  while true do
    wait(0)
  end
  Print(("Skeleton2_CheckAtStart 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
  if (string.sub(tostring(GetGlobal("2dDirection")), -2, -2) == "1") then
    data.player1ObjCollision = 1
  else
    data2.player1ObjCollision = 1
  end
  if (string.sub(tostring(GetGlobal("2dDirection")), -1, -1) == "1") then
    data.player2ObjCollision = 1
  else
    data2.player2ObjCollision = 1
  end
  DisableCollisionOnLoad("trn_skeletondance_02a.prefab_onewaycollision 01.StaticProp_CollisionObj")
  DisableCollisionOnLoad("trn_skeletondance_02a.prefab_onewaycollision 02.StaticProp_CollisionObj")
  return 
end
Skeleton2_CountTicket = function()
  Print("one ticket still here")
  Skeleton2_Pickups = (Skeleton2_Pickups + 1)
  return 
end
Skeleton2_CheckOnPickup = function()
  Print("Picked up item")
  Skeleton2_Pickups = (Skeleton2_Pickups - 1)
  if (Skeleton2_Pickups == 0) then
    ReplaceMusicStateOverride("Exp_L")
    Print("Playing good music state")
  end
  return 
end
Skeleton2_SetNoCollision = function(target)
  Print(("Skeleton2_SetNoCollision setting -no collision- layer on " .. tostring(GetName(target))))
  SetPropertyInt(target, "Collision Layer", 13)
  return 
end
local RoosterCrowed = false
Skeleton2_SetRooster = function()
  Print("Skeleton2_SetRooster setting RoosterCrowed true")
  RoosterCrowed = true
  return 
end
Skeleton2_CheckRooster = function()
  Print(("Skeleton2_CheckRooster function entered, RoosterCrowed is " .. tostring(RoosterCrowed)))
  if (RoosterCrowed == true) then
    ForEachEntityInGroup(DestroyEntity, "BatCgroup")
  end
  return 
end
local MickeyFailSafe = false
local OswaldFailSafe = false
Skeleton2_FailSafe = function(character, state)
  Print("Skeleton2_FailSafe function entered")
  if (state == "exit") then
    Print("Skeleton2_FailSafe state is exit, going to set bool to false")
    if (character == GetPlayer()) then
      MickeyFailSafe = false
      Print(("Skeleton2_FailSafe state is exit, character is Mickey = " .. tostring(MickeyFailSafe)))
    else
      OswaldFailSafe = false
      Print(("Skeleton2_FailSafe state is exit, character is Oswald = " .. tostring(OswaldFailSafe)))
      Print(((("Skeleton2_FailSafe state is " .. tostring(state)) .. " and character is ") .. tostring(character)))
      if (character == GetPlayer()) then
        MickeyFailSafe = true
        FireThread(Skeleton2_FailSafeCountdown, character, (state .. "Mickey"))
      else
        OswaldFailSafe = true
        FireThread(Skeleton2_FailSafeCountdown, character, (state .. "Oswald"))
      end
    end
  else
    Print(((("Skeleton2_FailSafe state is " .. tostring(state)) .. " and character is ") .. tostring(character)))
    if (character == GetPlayer()) then
      MickeyFailSafe = true
      FireThread(Skeleton2_FailSafeCountdown, character, (state .. "Mickey"))
    else
      OswaldFailSafe = true
      FireThread(Skeleton2_FailSafeCountdown, character, (state .. "Oswald"))
    end
  end
  return 
end
Skeleton2_FailSafeCountdown = function(character, teleLoc)
  Print(((("Skeleton2_FailSafeCountdown starting timer for " .. tostring(character)) .. " with teleLoc ") .. tostring(teleLoc)))
  wait(7)
  if (character == GetPlayer()) then
    if (MickeyFailSafe == true) then
      Print(("Skeleton2_FailSafeCountdown timed out, teleporting Mickey to " .. teleLoc))
      TeleportToEntity(GetPlayer(), teleLoc)
    end
  elseif (OswaldFailSafe == true) then
    Print(("Skeleton2_FailSafeCountdown timed out, teleporting Oswald to " .. teleLoc))
    TeleportToEntity(GetPlayerOrAI(PLAYER_TWO), teleLoc)
  end
  return 
end
local LidActive = 0
Skeleton2_ActivateGraveLid = function()
  if (LidActive == 0) then
    LidActive = 1
    Print("Skeleton2_ActivateGraveLid LidActive was 0 and triggered so starting 1st opening")
    SetRotatorMaxSpeed("GraveLid", 100)
    StartRotateToPosition("GraveLid", 90)
    wait(1.7999999523162842)
    if (LidActive == 2) then
      Print("Skeleton2_ActivateGraveLid LidActive was 2 inside 1st opening sequence so returning")
      return 
    end
    SetRotatorMaxSpeed("GraveLid", 60)
    StartRotateToPosition("GraveLid", 0)
    wait(0.4000000059604645)
    if (LidActive == 2) then
      Print("Skeleton2_ActivateGraveLid LidActive was 2 inside 1st opening sequence so returning")
      return 
    end
    StartRotateToPosition("GraveLid", 10)
    wait(0.20000000298023224)
    if (LidActive == 2) then
      Print("Skeleton2_ActivateGraveLid LidActive was 2 inside 1st opening sequence so returning")
      return 
    end
    StartRotateToPosition("GraveLid", 0)
    wait(0.20000000298023224)
    if (LidActive == 2) then
      Print("Skeleton2_ActivateGraveLid LidActive was 2 inside 1st opening sequence so returning")
      return 
    end
    StartRotateToPosition("GraveLid", 10)
    wait(0.20000000298023224)
    if (LidActive == 2) then
      Print("Skeleton2_ActivateGraveLid LidActive was 2 inside 1st opening sequence so returning")
      return 
    end
    StartRotateToPosition("GraveLid", 0)
    LidActive = 0
  elseif (LidActive == 1) then
    LidActive = 2
    Print("Skeleton2_ActivateGraveLid LidActive was 1 and triggered so doing 2nd opening")
    SetRotatorMaxSpeed("GraveLid", 100)
    StartRotateToPosition("GraveLid", 90)
    wait(1.7999999523162842)
    SetRotatorMaxSpeed("GraveLid", 60)
    StartRotateToPosition("GraveLid", 0)
    wait(0.4000000059604645)
    StartRotateToPosition("GraveLid", 10)
    wait(0.20000000298023224)
    StartRotateToPosition("GraveLid", 0)
    wait(0.20000000298023224)
    StartRotateToPosition("GraveLid", 10)
    wait(0.20000000298023224)
    StartRotateToPosition("GraveLid", 0)
    LidActive = 0
  end
  return 
end
local Lid2Active = 0
Skeleton2_ActivateGraveLid2 = function()
  if (Lid2Active == 0) then
    Lid2Active = 1
    Print("Skeleton2_ActivateGraveLid2 Lid2Active was 0 and triggered so starting 1st opening")
    SetRotatorMaxSpeed("GraveLid2", 100)
    StartRotateToPosition("GraveLid2", -90)
    wait(1.7999999523162842)
    if (Lid2Active == 2) then
      Print("Skeleton2_ActivateGraveLid2 Lid2Active was 2 inside 1st opening sequence so returning")
      return 
    end
    SetRotatorMaxSpeed("GraveLid2", 60)
    StartRotateToPosition("GraveLid2", 0)
    wait(0.4000000059604645)
    if (Lid2Active == 2) then
      Print("Skeleton2_ActivateGraveLid2 Lid2Active was 2 inside 1st opening sequence so returning")
      return 
    end
    StartRotateToPosition("GraveLid2", -10)
    wait(0.20000000298023224)
    if (Lid2Active == 2) then
      Print("Skeleton2_ActivateGraveLid2 Lid2Active was 2 inside 1st opening sequence so returning")
      return 
    end
    StartRotateToPosition("GraveLid2", 0)
    wait(0.20000000298023224)
    if (Lid2Active == 2) then
      Print("Skeleton2_ActivateGraveLid2 Lid2Active was 2 inside 1st opening sequence so returning")
      return 
    end
    StartRotateToPosition("GraveLid2", -10)
    wait(0.20000000298023224)
    if (Lid2Active == 2) then
      Print("Skeleton2_ActivateGraveLid2 Lid2Active was 2 inside 1st opening sequence so returning")
      return 
    end
    StartRotateToPosition("GraveLid2", 0)
    Lid2Active = 0
  elseif (Lid2Active == 1) then
    Lid2Active = 2
    Print("Skeleton2_ActivateGraveLid2 Lid2Active was 1 and triggered so doing 2nd opening")
    SetRotatorMaxSpeed("GraveLid2", 100)
    StartRotateToPosition("GraveLid2", -90)
    wait(1.7999999523162842)
    SetRotatorMaxSpeed("GraveLid2", 60)
    StartRotateToPosition("GraveLid2", 0)
    wait(0.4000000059604645)
    StartRotateToPosition("GraveLid2", -10)
    wait(0.20000000298023224)
    StartRotateToPosition("GraveLid2", 0)
    wait(0.20000000298023224)
    StartRotateToPosition("GraveLid2", -10)
    wait(0.20000000298023224)
    StartRotateToPosition("GraveLid2", 0)
    Lid2Active = 0
  end
  return 
end
local GlideAbilityActive = true
Skeleton2_CheckGlideDisable = function()
  Print("Skeleton2_CheckGlideDisable function entered")
  while true do
    wait(0)
  end
  Print(("Skeleton2_CheckGlideDisable 2dDirection is fully set at " .. tostring(GetGlobal("2dDirection"))))
  if (string.sub(tostring(GetGlobal("2dDirection")), -2, -2) ~= string.sub(tostring(GetGlobal("2dDirection")), -1, -1)) then
    if (GlideAbilityActive == true) then
      Print("Skeleton2_CheckGlideDisable disabling Glide since Mickey and Oswald on different tracks")
      GlideAbilityActive = false
      IncrementAbilityDisabled(GetPlayer(), "Earlift")
      Print("Skeleton2_CheckGlideDisable disabled Glide ability")
    end
  end
  return 
end
Skeleton2_EnterToBlotAlley = function(target)
  if (GlideAbilityActive == false) then
    GlideAbilityActive = true
    DecrementAbilityDisabled(GetPlayer(), "Earlift")
    Print("Skeleton2_EnterToBlotAlley enabled Glide ability")
  end
  SetupPosition(target)
  return 
end
Skeleton2_EnterToBogEasy = function(target)
  if (GlideAbilityActive == false) then
    GlideAbilityActive = true
    DecrementAbilityDisabled(GetPlayer(), "Earlift")
    Print("Skeleton2_EnterToBogEasy enabled Glide ability")
  end
  SetupPosition(target)
  return 
end
Skeleton2_ManageOswaldAssistMickey = function(target, action, node1)
  Print("***Skeleton2_ManageOswaldAssistMickey")
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

