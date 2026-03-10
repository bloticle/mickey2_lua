wait = coroutine.yield
Wait = coroutine.yield
g_MusicState = "Auto"
if (NativeAudioSetState == nil) then
  NativeAudioSetState = AudioSetState
  AudioSetState = function(object, stateGroup, state)
    if (stateGroup == nil) then
      return 
    end
    NativeAudioSetState(object, stateGroup, state)
    if (stateGroup == "Music_State") then
      g_MusicState = state
    end
    return 
  end
end
DoStinger = function(stingerState, delay)
  if (delay == nil) then
    delay = 5
  end
  AddMusicStateOverride(stingerState)
  Print(("Music - DoStinger fires state: " .. stingerState))
  FireThread(EndStinger, delay, stingerState)
  return 
end
EndStinger = function(delay, removeState)
  Wait(delay)
  RemoveMusicStateOverride(removeState)
  Print(("Music - EndStinger removes state: " .. removeState))
  return 
end
DoStinger_SceneDesigner = function(target, _StingerState, _Delay)
  Print(((("Music - DoStinger_SceneDesigner, _StingerState: " .. tostring(_StingerState)) .. ", _Delay: ") .. tostring(_Delay)))
  Print(("Music - TargetName: " .. tostring(GetName(target))))
  DoStinger(_StingerState, tonumber(_Delay))
  return 
end
ReplaceMusicStateOverride_SD = function(target, _State)
  ReplaceMusicStateOverride(_State)
  Print(("Music - ReplaceMusicStateOverride, _State: " .. tostring(_State)))
  return 
end
SetPlayStyleScoreBias_SD = function(target, _Amount)
  SetPlayStyleScoreBias(_Amount)
  Print(("Music - SetPlayStyleScoreBias to " .. tostring(_Amount)))
  return 
end
SetCombatIntensityBias_SD = function(target, _Amount)
  SetPlayStyleScoreBias(_Amount)
  Print(("Music - SetCombatIntensityBias to " .. tostring(_Amount)))
  return 
end
AutoMusic = function()
  RemoveAllMusicStateOverride()
  Print("Removed all music state overrides")
  return 
end
MusicPostEventOn = function(target, event)
  AudioPostEventOn(target, event)
  SetMusicEvent(event)
  if (target == GetPlayer()) then
    SetMusicTarget("")
  else
    SetMusicTarget(GetName(target))
  end
  return 
end
ResetMusicEvent = function()
  SetMusicEvent("")
  SetMusicTarget(nil)
  return 
end
PlayMusicFromGlobal = function()
  Print("Playing music from global")
  local event = GetMusicEvent()
  if (event == "JCBoatRideMusic") then
    MultiPosSoundStart("vtl_oasis_01b_art.audio_Boats_mx_control")
  elseif (event ~= "") then
    local targetName = GetMusicTarget()
    if (targetName == "") then
      Print(("Started saved music event (no target): " .. tostring(event)))
      AudioPostEventOn(GetPlayer(), event)
    end
    Print(((("Started saved music event: " .. tostring(event)) .. "at ") .. tostring(targetName)))
    AudioPostEventOn(targetName, event)
  end
  return 
end
HandleSoundMarker = function(label)
  if (label == "UnduckSFX") then
    AudioPostEventOn(GetPlayer(), "UnduckSFX_MX_2DProj_MadDoc")
    Print("Music - found UnduckSFX marker")
  elseif (label == "DuckSFX") then
    AudioPostEventOn(GetPlayer(), "DuckSFX_MX_2DProj_MadDoc")
    Print("Music - found DuckSFX marker")
  end
  return 
end
PrintTable = function(title, table)
  print("----", title, "----")
  for i, v in pairs(table) do
    print("t[", i, "]=", v)
  end
  print("----------------------------------------------------")
  return 
end
DoEndGame = function()
  Wait(2.25)
  HideHud()
  SetEndgameVariables()
  RestrictCutSceneInput()
  wait(0.10000000149011612)
  SetGlobal("DBC_EndGameCutscene", 1)
  GiveCollectibleNoPopup("EndgameVar_Closing")
  Wait(0.10000000149011612)
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  StartSequence(nil, "EndGame:0", true, true)
  UnrestrictCutSceneInput()
  return 
end
CreateNewGamePlus = function()
  SaveEndGame()
  Wait(0.10000000149011612)
  CleanLoadLevel("mainmenu.start")
  return 
end
SimulateEndGame = function()
  DoEndGame()
  return 
end
GiveGoldPin = function()
  GiveCurrencyItem("Gold_Pin", 1)
  return 
end
GiveSilverPin = function()
  GiveCurrencyItem("Silver_Pin", 1)
  return 
end
TestLoadCallback = function()
  Print("Load callback executed!")
  return 
end
PlayAndUnlockMovie = function(moviename, extraID)
  GiveCollectibleNoPopup(extraID)
  PlayMovie(GetPlayer(), moviename)
  return 
end
PlayMovie = function(player, moviename)
  PlayMovieInternal(player, moviename)
  return 
end
DisableGlint = function(self)
  SetR3MTLockAnimation(self, 0)
  return 
end
EnableGlint = function(self)
  SetR3MTUnlockAnimation(self)
  return 
end
SetAnimVariant = function(self, value)
  AnimVarInt(self, VAR_AI_Variant, value)
  return 
end
WaitForDialog = function(self)
  local result = nil
  while true do
    wait(0.10000000149011612)
    result = GetDialogResponse()
  end
  if (result == "Aborted") then
    result = nil
  end
  return result
end
AddGlobal = function(name, addamount)
  SetGlobal(name, (GetGlobal(name) + addamount))
  return 
end
IncrementGlobal = function(name)
  AddGlobal(name, 1)
  return 
end
DecrementGlobal = function(name)
  AddGlobal(name, -1)
  return 
end
IncrementGlobalSD = function(sdentity, name)
  AddGlobal(name, 1)
  return 
end
DecrementGlobalSD = function(sdentity, name)
  AddGlobal(name, -1)
  return 
end
testCharMood = 0
CONV_HUB_Test_Func = function(name, self)
  AnimVarInt(self, VAR_Mood_Type, testCharMood)
  AnimEvent(self, EVENT_Start_Talk)
  DialogBoxNoPause(self, ("Talking with mood=" .. testCharMood))
  WaitForDialog(self)
  wait(3)
  DialogBoxNoPause(self, "Emote negative")
  WaitForDialog(self)
  AnimEvent(self, EVENT_Start_EmoteSad)
  wait(4)
  DialogBoxNoPause(self, "Emote positive")
  WaitForDialog(self)
  AnimEvent(self, EVENT_Start_EmoteHappy)
  wait(4)
  DialogBoxNoPause(self, "Emote extra positive")
  WaitForDialog(self)
  AnimEvent(self, EVENT_Start_EmoteVeryHappy)
  wait(4)
  testCharMood = (testCharMood + 1)
  if (testCharMood == 3) then
    testCharMood = 0
  end
  return 
end
conversationEntered = false
Conversation = function(name, self, target)
  if conversationEntered then
    return 
  end
  conversationEntered = true
  EnterCutscene(self)
  FaceEntity(self, target)
  AnimEvent(self, EVENT_Start_Talk)
  RestrictCutSceneInput()
  DisableMotion_Player()
  local func = rawget(_G, (name .. "_Func"))
  if (func ~= nil) then
    func(name, self)
  else
    local textCount = 1
    while true do
      local text = nil
      text = GetConfigVariableString(((name .. "_Text") .. textCount))
      if (text ~= "") then
        Print("EST", GetConfigVariableString(((name .. "_Mood") .. textCount)))
        local mood = rawget(_G, GetConfigVariableString(((name .. "_Mood") .. textCount)))
        if (mood ~= nil) then
          AnimVarInt(self, VAR_Mood_Type, mood)
        end
        local reaction = rawget(_G, GetConfigVariableString(((name .. "_Reaction") .. textCount)))
        if (reaction ~= nil) then
          AnimVarInt(self, VAR_Reaction_Type, reaction)
        end
        local animEvent = rawget(_G, GetConfigVariableString(((name .. "_Anim") .. textCount)))
        if (animEvent ~= nil) then
          AnimEvent(self, animEvent)
        end
        DialogBoxNoPause(self, text)
        WaitForDialog(self)
        textCount = (textCount + 1)
      end
    end
    if (textCount == 1) then
      DialogBoxNoPause(self, ("No Text in conversation " .. name))
      WaitForDialog(self)
    end
  end
  AnimEvent(self, EVENT_Finished_Sequence)
  EnableMotion_Player()
  UnrestrictCutSceneInput()
  ExitCutscene(self)
  conversationEntered = false
  return 
end
global_entity_data_table = {}
Openfile("./environments/_shared/scripts/strict.lua")
Openfile("./environments/_shared/scripts/autosave.lua")
Openfile("./environments/_shared/scripts/restore.lua")
Openfile("./environments/_shared/scripts/MagicWand.lua")
Openfile("./environments/_shared/scripts/CDC.lua")
Openfile("./environments/_shared/scripts/InkWellAudio.lua")
Openfile("./environments/_shared/scripts/GrabAudio.lua")
Openfile("./environments/_shared/scripts/sketches.lua")
Openfile("./environments/_shared/scripts/GlobalScripts/Player_Scripts.lua")
Openfile("./environments/_shared/scripts/Oswald.lua")
global_data = {test = {test2 = {}}}
level_data = {test3 = {test4 = {}}}
GetPlayer2OrAI = function()
  return GetPlayerOrAI(PLAYER_TWO)
end
TestEvent = function(testArg)
  Print(("Event fired." .. testArg))
  return 
end
LoadNIF = function(self)
  LoadNIFImpl(self)
  return 
end
UnloadNIF = function(self)
  UnloadNIFImpl(self)
  return 
end
LoadLevel = function(self, levelName)
  TransitionToLevel(tostring(levelName))
  return 
end
DebugLoadLevel = function(self, levelName)
  CleanLoadLevel(tostring(levelName))
  return 
end
MostRecentCheckpointCallback = "None"
OnCheckpointLoaded = function(callbackFtn, playerOnePos, playerTwoPos)
  PlayMusicFromGlobal()
  MostRecentCheckpointCallback = callbackFtn
  LastCheckpointPos_Mickey = playerOnePos
  LastCheckpointPos_Oswald = playerTwoPos
  LastCheckpointLoadFunction = callbackFtn
  if (callbackFtn ~= nil) then
    _G[callbackFtn]()
  end
  return 
end
StreamZones = function(self, partName)
  local baseName = string.gsub(partName, "%.part$", "")
  if (string.find(baseName, ".", 1, true) == nil) then
    local levelName = LevelManager_GetCurrentLevelName()
    local stateName = ((levelName .. ".") .. baseName)
    LevelManager_SetCurrentState(tostring(stateName))
  else
    LevelManager_SetCurrentState(tostring(baseName))
  end
  return 
end
StreamInterior = function(self, gsaName)
  local baseName = string.gsub(gsaName, "%.part$", "")
  if (string.find(baseName, ".", 1, true) == nil) then
    local levelName = LevelManager_GetCurrentLevelName()
    local zoneName = ((levelName .. ".") .. baseName)
    LevelManager_SetZoneStatusActive(tostring(zoneName))
  else
    LevelManager_SetZoneStatusActive(tostring(baseName))
  end
  return 
end
RestartLevel = function(self)
  RestartCurrentLevel()
  return 
end
WaitForLevelLoad = function(self, levelName)
  WaitForLevelToLoad(false)
  return 
end
SetPlayerSpawnTransformSelf = function(self, player)
  if (player == nil) then
    player = PLAYER_ONE
  end
  SetPlayerSpawnTransformEntity(self, player)
  return 
end
LastCheckpointPos_Mickey = ""
LastCheckpointPos_Oswald = ""
LastCheckpointLoadFunction = ""
SaveCheckpointNoPosition = function(self, loadCallbackFnName)
  local loadCallback = loadCallbackFnName
  if (loadCallback == nil) then
    loadCallback = ""
  else
    LastCheckpointLoadFunction = loadCallback
  end
  SaveGameToMemory(loadCallback, false)
  return 
end
SaveCheckpoint = function(self, loadCallbackFnName, playerOneEntity, playerTwoEntity)
  local playerOneEntityName = playerOneEntity
  if (playerOneEntityName == nil) then
    playerOneEntityName = ""
  else
    LastCheckpointPos_Mickey = playerOneEntityName
  end
  local playerTwoEntityName = playerTwoEntity
  if (playerTwoEntityName == nil) then
    playerTwoEntityName = playerOneEntityName
    LastCheckpointPos_Oswald = playerOneEntityName
  else
    LastCheckpointPos_Oswald = playerTwoEntityName
  end
  local loadCallback = loadCallbackFnName
  if (loadCallback == nil) then
    loadCallback = ""
  else
    LastCheckpointLoadFunction = loadCallback
  end
  SaveGameToMemory(loadCallback, true, playerOneEntityName, playerTwoEntityName)
  return 
end
SaveCheckpointSelf = function(self, loadCallbackFnName, playerTwoEntity)
  local loadCallback = loadCallbackFnName
  if (loadCallback == nil) then
    loadCallback = ""
  else
    LastCheckpointLoadFunction = loadCallback
  end
  if (playerTwoEntity == nil) then
    playerTwoEntity = self
  end
  SetPlayerSpawnTransformEntity(self, PLAYER_ONE)
  SetPlayerSpawnTransformEntity(playerTwoEntity, PLAYER_TWO)
  SaveGameToMemory(loadCallback, false)
  return 
end
LoadCheckpoint = function(self)
  LoadGameFromMemory()
  return 
end
CreatePlayerMetric = function(self, metricName)
  CreateMetric(tostring(metricName))
  return 
end
TeleportSelf = function(target, destEntity)
  MoveToEntity(target, destEntity)
  return 
end
Enable2DSetup = function(location)
  Print("Enable 2D Setup")
  wait(0.10000000149011612)
  SetHudFor2D(GetPlayer(), true)
  IncrementSketchAbilitiesDisabled(GetPlayer())
  IncrementPaintAbilitiesDisabled(GetPlayer())
  IncrementAbilityDisabled(GetPlayer2OrAI(), "Boomerang")
  IncrementAbilityDisabled(GetPlayer2OrAI(), "ElectricBlast")
  IncrementAbilityDisabled(GetPlayer2OrAI(), "ElectricStream")
  DisableGuardianSystem()
  if (location == "interior") then
    IncrementAbilityDisabled(GetPlayer(), "Toss")
    IncrementAbilityDisabled(GetPlayer2OrAI(), "Toss")
  end
  return 
end
Disable2DSetup = function(location)
  Print("Disable 2D Setup")
  wait(0.10000000149011612)
  SetHudFor2D(GetPlayer(), false)
  DecrementSketchAbilitiesDisabled(GetPlayer())
  DecrementPaintAbilitiesDisabled(GetPlayer())
  DecrementAbilityDisabled(GetPlayer2OrAI(), "Boomerang")
  DecrementAbilityDisabled(GetPlayer2OrAI(), "ElectricBlast")
  DecrementAbilityDisabled(GetPlayer2OrAI(), "ElectricStream")
  EnableGuardianSystem()
  if (location == "interior") then
    DecrementAbilityDisabled(GetPlayer(), "Toss")
    DecrementAbilityDisabled(GetPlayer2OrAI(), "Toss")
    TogglePlayerIconSubstitute(false, false)
  end
  return 
end
StationaryCamera_UntilPlayerMoves = function(target, fromProjector, player)
  local player_string = ""
  local player1_string = "player_"
  local player2_string = "playertwo"
  local playerAI_string = "ai_oswald"
  if (player == nil) then
    player = GetPlayer()
    player_string = player1_string
  elseif (string.sub(tostring(GetName(player)), 1, 7) == player1_string) then
    player = GetPlayer()
    player_string = player1_string
  elseif (string.sub(tostring(GetName(player)), 1, 9) == player2_string) then
    player = GetPlayer2()
    player_string = player2_string
  elseif (string.sub(tostring(GetName(player)), 1, 9) == playerAI_string) then
    player = GetOswaldAI()
    player_string = playerAI_string
  end
  local OriginalPlayerPosition = GetPosition(player)
  local JustReleaseTheCamera = false
  Print("************************************* - StationaryCamera_UntilPlayerMoves - START")
  if (target == nil) then
    target = ""
    JustReleaseTheCamera = true
    Print("************************************* - StationaryCamera_UntilPlayerMoves - The target is blank, assuming we just want to release the player")
  end
  local Projector_Check = ""
  if (fromProjector == nil) then
    Projector_Check = false
  else
    Projector_Check = Prefab_Projector_CheckActivated()
  end
  local SideScrollEnabled_Check = IsSideScrollEnabled()
  while true do
    if (not (SCUPM_GetPosition(GetPosition(player), OriginalPlayerPosition) < 0.10000000149011612)) then
      break
    end
    if (not (not Projector_Check)) then
      break
    end
    if (not (not SideScrollEnabled_Check)) then
      break
    end
    wait(0.5)
    Print("************************************* - StationaryCamera_UntilPlayerMoves - wait 0.5")
    SideScrollEnabled_Check = IsSideScrollEnabled()
  end
  if (not Projector_Check) then
    if (not SideScrollEnabled_Check) then
      local ClearCamera = false
      if (JustReleaseTheCamera == true) then
        Print("************************************* - StationaryCamera_UntilPlayerMoves - ALL CLEAR - FROM JustReleaseTheCamera")
        ClearCamera = true
      elseif (GetPrefabData(target).SkipSideCameraRelease == false) then
        Print("************************************* - StationaryCamera_UntilPlayerMoves - ALL CLEAR - FROM SkipSideCameraRelease == False")
        ClearCamera = true
      else
        Print("************************************* - StationaryCamera_UntilPlayerMoves - Skipping ClearAllCameraAttributes!!!!! You will have to call StationaryCamera_UntilPlayerMoves() again!")
      end
      if (player ~= GetPlayer()) then
        if (player_string ~= string.sub(tostring(GetName(GetPlayer2OrAI())), 1, 9)) then
          Print("************************************* - StationaryCamera_UntilPlayerMoves - On Second Analysis, this is just Player 2 dropping in/out, so we will just requeue StationaryCamera_UntilPlayerMoves() on a new thread.")
          ClearCamera = false
          FireThread(StationaryCamera_UntilPlayerMoves, nil, fromProjector, GetPlayer2OrAI())
        end
      end
      if ClearCamera then
        ClearAllCameraAttributes(player, 2)
        if (GetNumPlayers() == 1) then
          ClearAllCameraAttributes(GetPlayer2OrAI())
          OswaldStartMovingAction()
        end
      end
    end
  end
  return 
end
SCUPM_GetPosition = function(position1, position2)
  local diff = (position1 - position2)
  return diff:length2()
end
EnableGuardianHint = function(marker)
  ForEachEntityInGroup(EnableComponent, marker, "Guardian Hint Component")
  return 
end
DisableGuardianHint = function(marker)
  ForEachEntityInGroup(DisableComponent, marker, "Guardian Hint Component")
  return 
end
SetMickeyTickets = function()
  local mickeytick = GetCurrency("ETicket")
  SetGlobal("Mickey_Tickets", mickeytick)
  return 
end
ShakeCamera_Default = function(target)
  local csTime = 2
  local csFreq = 5
  local csCenter = 0.05000000074505806
  local csSharpness = 4
  local csVScale = 0.10000000149011612
  local csHScale = 0.02500000037252903
  ShakeCamera(csTime, csFreq, csCenter, csSharpness, csVScale, csHScale)
  return 
end
ShakeCameraFromSceneDesigner = function(target, csTime, csFreq, csCenter, csSharpness, csVScale, csHScale)
  ShakeCamera(tonumber(csTime), tonumber(csFreq), tonumber(csCenter), tonumber(csSharpness), tonumber(csVScale), tonumber(csHScale))
  return 
end
KnockbackExplode_Default = function(target)
  local stimType = ST_KNOCKBACK
  local stimDamage = 1
  local targetPos = GetPosition(target)
  local stimRadius = 6
  StimulusSphere(_self(), stimType, stimDamage, targetPos, stimRadius)
  return 
end
PaintPush_Impulse = function(target, event)
  if StimulusEvent_HasStimulusType(event, ST_PAINT) then
    local PlayerPosi = GetPosition(GetPlayer())
    local ShooterPosi = GetPosition(target)
    local BulletDir = (ShooterPosi - PlayerPosi)
    BulletDir:normalize3()
    BulletDir = (BulletDir * 10)
    ApplyImpulse(target, BulletDir.x, 0, BulletDir.z)
  end
  return 
end
lua_zoom_to = function(self, level)
  Print(("ZoomTo called with:" .. level))
  ZoomToLevel(level)
  return 
end
SetMickeyToMaxHealth = function()
  local player = _player()
  local maxHealth = 10
  SetPropertyInt(player, "MaxHealth", maxHealth, 0)
  SetPropertyInt(player, "Health", maxHealth, 0)
  return 
end
IncreaseMickeysMaxHealth = function(target)
  local player = _player()
  local maxHealth = GetPropertyInt(player, "MaxHealth", 0)
  if (maxHealth < 10) then
    maxHealth = (maxHealth + 1)
    SetPropertyInt(player, "MaxHealth", maxHealth, 0)
    SetPropertyInt(player, "Health", maxHealth, 0)
  end
  return 
end
GiveScrapMetal = function(amount)
  local player = _player()
  AddCurrency("ScrapMetal", amount)
  return 
end
RemoveAllScrapMetal = function()
  local player = _player()
  SetCurrency("ScrapMetal", 0)
  return 
end
SetPaintAmmoToMax = function()
  local maxPaintAmmo = 70
  local maxPaintRecharge = 10
  local containerSize = 10
  maxPaintRecharge = (maxPaintRecharge + 20)
  SetAmmoMax("Paint", maxPaintAmmo)
  SetAmmoRechargeMax("Paint", maxPaintRecharge)
  SetAmmo("Paint", maxPaintAmmo)
  return 
end
SetThinnerAmmoToMax = function()
  local maxThinnerAmmo = 70
  local maxThinnerRecharge = 10
  local containerSize = 10
  maxThinnerRecharge = (maxThinnerRecharge + 20)
  SetAmmoMax("Thinner", maxThinnerAmmo)
  SetAmmoRechargeMax("Thinner", maxThinnerRecharge)
  SetAmmo("Thinner", maxThinnerAmmo)
  return 
end
IncreaseMaxPaintAmmo = function()
  local maxPaintAmmo = GetAmmoMax("Paint")
  local maxPaintRecharge = GetAmmoRechargeMax("Paint")
  local containerSize = 10
  if (maxPaintAmmo < 60) then
    maxPaintAmmo = (maxPaintAmmo + containerSize)
    maxPaintRecharge = (maxPaintRecharge + (containerSize / 2))
    SetAmmoMax("Paint", maxPaintAmmo)
    SetAmmoRechargeMax("Paint", maxPaintRecharge)
    SetAmmo("Paint", maxPaintAmmo)
  end
  return 
end
IncreaseMaxThinnerAmmo = function()
  local maxThinnerAmmo = GetAmmoMax("Thinner")
  local maxThinnerRecharge = GetAmmoRechargeMax("Thinner")
  local containerSize = 10
  if (maxThinnerAmmo < 60) then
    maxThinnerAmmo = (maxThinnerAmmo + containerSize)
    maxThinnerRecharge = (maxThinnerRecharge + (containerSize / 2))
    SetAmmoMax("Thinner", maxThinnerAmmo)
    SetAmmoRechargeMax("Thinner", maxThinnerRecharge)
    SetAmmo("Thinner", maxThinnerAmmo)
  end
  return 
end
IncreaseMaxElectricityAmmo = function()
  local maxElectricityAmmo = GetAmmoMax("Electric")
  local maxElectricityRecharge = GetAmmoRechargeMax("Electric")
  local containerSize = 10
  if (maxElectricityAmmo < 60) then
    maxElectricityAmmo = (maxElectricityAmmo + containerSize)
    maxElectricityRecharge = (maxElectricityRecharge + (containerSize / 2))
    SetAmmoMax("Electric", maxElectricityAmmo)
    SetAmmoRechargeMax("Electric", maxElectricityRecharge)
    SetAmmo("Electric", maxElectricityAmmo)
  end
  return 
end
DEBUG_SetPlayer_InkWell = function(state)
  if (state == "Invisible") then
    PlayerEnablePowerup(GetPlayer(), "Indelible", false)
  else
    PlayerEnablePowerup(GetPlayer(), "Invisible", false)
  end
  AddInkWellAmmo(state, 10, GetPlayer())
  PlayerEnablePowerup(GetPlayer(), state, true)
  return 
end
PlayPickupFX = function(pickup, pickerUpper)
  local pickupFX = ForceSpawn(pickup, 1)
  MoveToEntity(pickupFX[1], pickerUpper)
  SetParentEntity(pickupFX[1], pickerUpper)
  return 
end
AddAllSketchUpgrades = function()
  UnlockAbility(GetPlayer(), "Sketch_Watch")
  Wait(0.10000000149011612)
  UnlockAbility(GetPlayer(), "Sketch_Fairy")
  Wait(0.10000000149011612)
  UnlockAbility(GetPlayer(), "Sketch_Anvil")
  Wait(0.10000000149011612)
  UnlockAbility(GetPlayer(), "Sketch_TV")
  Wait(0.10000000149011612)
  GiveCollectible("SketchUpgrade_Sketch_Watch")
  Wait(0.10000000149011612)
  GiveCollectible("SketchUpgrade_Sketch_Fairy")
  Wait(0.10000000149011612)
  GiveCollectible("SketchUpgrade_Sketch_Anvil")
  Wait(0.10000000149011612)
  GiveCollectible("SketchUpgrade_Sketch_TV")
  Wait(0.10000000149011612)
  GiveCollectible("SketchUpgrade_Global")
  return 
end
IncreaseMaxTicket = function(level)
  local new_maxticket = "None"
  if (level == "L1") then
    new_maxticket = 3000
  elseif (level == "L2") then
    new_maxticket = 5000
  elseif (level == "L3") then
    new_maxticket = 9999
  end
  if (new_maxticket ~= "None") then
    SetCurrencyMax("ETicket", new_maxticket)
    Print(("*************INVENTORY: TICKET MAX =  " .. new_maxticket))
  end
  return 
end
TotalTicketsInLevel = 0
ResetTicketsCount = function(target, count)
  ResetTicketCount()
  TotalTicketsInLevel = count
  return 
end
DisplayMapStats = function(target)
  local TicketPercentage = math.floor(((GetTicketCount() * 100) / TotalTicketsInLevel))
  local GremlinsMsg = ((((((("You saved " .. GremlinCount) .. " / ") .. TotalGremlins) .. " Gremlins!\nYou collected ") .. TicketPercentage) .. " % ") .. "of the tickets!")
  Display(target, GremlinsMsg, 8)
  return 
end
PaintStim = function(target)
  local stimType = ST_PAINT
  local stimDamage = 1
  local targetPos = GetPosition(target)
  StimulusEntity(self, stimType, stimDamage, targetPos, target)
  return 
end
PickupLifetime = 15
SetPickupLifetime = function(target)
  SetPropertyFloat(target, "Lifetime", ETicketLifetime, 0)
  return 
end
ToggleFollow = function(follower, entityToFollow)
  QueueBrainEvent(follower, BRAIN_ToggleFollowEntity, vector4(0, 0, 0), entityToFollow)
  return 
end
AI_StartFollowingSpline = function(ai, initialKnot)
  DisableMotion(ai)
  SplineFollower_TeleportToKnot(ai, initialKnot)
  SplineFollower_SetDisabled(ai, false)
  return 
end
AI_StopFollowingSpline = function(ai)
  SplineFollower_SetDisabled(ai, true)
  EnableMotion(ai)
  return 
end
AI_SetHomeToCurrent = function(self, location)
  Wait(5)
  AIBSetTetherLoc(self, GetPosition(location))
  Print("AI Home Reset")
  return 
end
GetNPCHitPoints = function(npc)
  local currentCounter = GetPropertyFloat(npc, "CounterStart")
  if (0 < currentCounter) then
    currentCounter = 0
  end
  local thinnerThreshold = GetPropertyFloat(npc, "ThinnerThreshold")
  local hitPoints = (currentCounter - thinnerThreshold)
  if (hitPoints < 0) then
    hitPoints = 0
  end
  return hitPoints
end
MovePickupToMickey = function(target)
  MoveToEntity(target, GetPlayer())
  return 
end
SetEndgameVariables = function()
  Print("Setting up endgame variables")
  local horacequests = 0
  local petequests = 0
  if (GetGlobal("GV_PeteStuff") == 1) then
    SetGlobal("Endgame_Var_Pos_SmallPete", 1)
  end
  if (GetGlobal("CT_ClockTowerResolution") == 1) then
    SetGlobal("Endgame_Var_Pos_Clocktower", 1)
  end
  if (GetGlobal("MS_petetronicresolution") == 1) then
    SetGlobal("Endgame_Var_Pos_Petetronic", 1)
  end
  if (GetGlobal("PoTW_ZoneM_HookIsDead") == 0) then
    SetGlobal("Endgame_Var_Pos_Hook", 1)
  end
  if (GetGlobal("TT_GoofyAssembleBik_Played") == 1) then
    SetGlobal("Endgame_Var_Pos_Goofy", 1)
  end
  if (GetGlobal("NO_DonaldFMV_Played") == 1) then
    SetGlobal("Endgame_Var_Pos_Donald", 1)
  end
  if (GetGlobal("AL_V2_ReAssemble_Played") == 1) then
    SetGlobal("Endgame_Var_Pos_Daisy", 1)
  end
  if (GetGlobal("MS_petetronicresolution") == 1) then
    petequests = (petequests + 1)
  end
  if (GetGlobal("GV_PeteStuff") == 1) then
    petequests = (petequests + 1)
  end
  if (GetGlobal("MS_petepanresolution") == 1) then
    petequests = (petequests + 1)
  end
  if (GetGlobal("MS_dogtags") == 1) then
    horacequests = (horacequests + 1)
  end
  if (GetGlobal("PotW_Jail_CagedPirate2Freed") == 1) then
    horacequests = (horacequests + 1)
  end
  if (GetGlobal("MS_murderweaponfound") == 1) then
    horacequests = (horacequests + 1)
  end
  if (1 < horacequests) then
    SetGlobal("Endgame_Var_Pos_Horace", 1)
  end
  if (petequests == 3) then
    SetGlobal("Endgame_Var_Pos_Pete", 1)
  end
  Print(("Endgame_Var_Pos_Pete: " .. GetGlobal("Endgame_Var_Pos_Pete")))
  Print(("Endgame_Var_Pos_Horace: " .. GetGlobal("Endgame_Var_Pos_Horace")))
  Print(("Endgame_Var_Pos_Goofy: " .. GetGlobal("Endgame_Var_Pos_Goofy")))
  Print(("Endgame_Var_Pos_Donald: " .. GetGlobal("Endgame_Var_Pos_Donald")))
  Print(("Endgame_Var_Pos_Daisy: " .. GetGlobal("Endgame_Var_Pos_Daisy")))
  Print(("Endgame_Var_Pos_Clocktower: " .. GetGlobal("Endgame_Var_Pos_Clocktower")))
  Print(("Endgame_Var_Pos_Hook: " .. GetGlobal("Endgame_Var_Pos_Hook")))
  Print(("Endgame_Var_Pos_SmallPete: " .. GetGlobal("Endgame_Var_Pos_SmallPete")))
  Print(("Endgame_Var_Pos_Petetronic: " .. GetGlobal("Endgame_Var_Pos_Petetronic")))
  return 
end
GetPlayerSpeed = function()
  local velocity = GetVelocity(GetPlayer())
  return velocity:length2()
end
GroupSetAppCulled = function(target, group)
  ForEachEntityInGroup(SetAppCulled, group)
  return 
end
GroupClearAppCulled = function(target, group)
  ForEachEntityInGroup(ClearAppCulled, group)
  return 
end
Generic_DoorLocked_SFX = function()
  AudioPostEventOn(GetPlayer(), "Play_sfx_door_lock")
  return 
end
Mickey_Damage_Audio = function(self, event)
  if DamageEvent_HasStimulusType(event, ST_PHYSICAL) then
    if (0 < DamageEvent_EffectiveAmount(event, ST_PHYSICAL)) then
      AudioPostEventOn(self, "Play_sfx_Mickey_damage_NotThinner")
    end
  elseif DamageEvent_HasStimulusType(event, ST_THINNER) then
    if (0 < DamageEvent_EffectiveAmount(event, ST_THINNER)) then
      AudioPostEventOn(self, "Play_sfx_Mickey_damage")
    end
  end
  if (self == GetPlayer()) then
    AudioPostEventOn(self, "Play_vocal_mickey_pipdeath")
  else
    AudioPostEventOn(self, "Play_vocal_oswald_pipdeath")
  end
  return 
end
CrossingStreamsDestroy = function(self, event)
  if StimulusEvent_HasStimulusType(event, ST_CROSSED_STREAM) then
    DestroyEntity(self)
  end
  return 
end
vtl_oasis_zone01a = function()
  local assetList = {"packfiles/ventureland_rubble.asl", "packfiles/ventureland_half_built.asl", "packfiles/ventureland_fully_built.asl"}
  if (GetGlobal("VTL_Oasis_CrowsNestState") == 3) then
    SetGlobal("VTL_Oasis_CrowsNestFullyBuilt", 1)
  end
  return assetList[GetGlobal("VTL_Oasis_CrowsNestState")]
end
vtl_oasis_zone01c_epilogue = function()
  if (GetGlobal("VTL_Oasis_CraneDecision") == 0) then
    SetGlobal("VTL_Oasis_CraneDecision", 1)
    SetGlobal("VTL_Oasis_BlotlingsQuest_State", 1)
    GiveCollectible("Challenge_Perfectionist_MuchAdo_Tracker")
    Quest_SetStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_1a", Quest_Unavailable, false)
    Quest_SetStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_2a", Quest_Unavailable, false)
    Quest_SetStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_1b", Quest_Unavailable, false)
    Quest_SetStatus("Much_Ado_About_Blotlings", "Much_Ado_About_Blotlings_2b", Quest_Unavailable, false)
  end
  if (GetGlobal("VTL_Oasis_CraneDecision") == 1) then
    return "packfiles/vtl_spatter_apt.asl"
  end
  return "packfiles/vtl_pirate_cantina.asl"
end
meanstreet_north_mstn_main = function()
  local fishHead = "packfiles/fishheadpartial.asl"
  local oswaldTower = "packfiles/oswaldtowerfallen.asl"
  local windmill = "packfiles/windmillpartial.asl"
  if (GetGlobal("MSN_GremlinStructure_FishHead") ~= 0) then
    fishHead = "packfiles/fishheadbuilt.asl"
  end
  local msnOswaldTowerValue = GetGlobal("MSN_OswaldTower")
  if (GetGlobal("RBF_AngelOrDevil") == 2) then
    if (msnOswaldTowerValue == 2) then
      oswaldTower = "packfiles/oswaldtowerstanding.asl"
    end
  end
  oswaldTower = "packfiles/oswaldtowerstanding.asl"
  if (GetGlobal("MSN_GremlinStructure_WindMill") ~= 0) then
    windmill = "packfiles/windmillbuilt.asl"
  end
  return fishHead, oswaldTower, windmill
end
Spirit_Unlocked = function(spirit)
  FireSequence("GBL_Gus_HintMarker", "Global_Gus_UnlockedSpirit", 1)
  if (spirit ~= nil) then
    if (Quest_CheckStatus("Spirit_of_Wasteland", ("Spirit_of_Wasteland_10" .. spirit), Quest_Unavailable) == false) then
      Quest_SetStatus("Spirit_of_Wasteland", ("Spirit_of_Wasteland_2" .. spirit), Quest_Completed, false)
      Quest_SetStatus("Spirit_of_Wasteland", ("Spirit_of_Wasteland_10" .. spirit), Quest_TurnIn, true)
    end
  end
  return 
end
ACH_EnemyPhotoCheck = function(target)
  local enemyPhoto = GetPropertyString(target, "QuestFlag")
  Print(("^^^^^ - ACH_EnemyPhotoCheck: enemyPhoto = " .. enemyPhoto))
  if (GetGlobal(enemyPhoto) == 2) then
    Print("^^^^^ - ACH_EnemyPhotoCheck: enemyPhoto global = 2 so giving Collectible")
    GiveCollectibleNoPopup((("Challenge_RoguesGallery_" .. string.sub(enemyPhoto, 10, -1)) .. "_Tracker"))
    DisableComponent(target, "Camera Ability Target Component")
  end
  return 
end
ACH_Friended = function(self)
  if (GetCurrentTeam(self) == 3) then
    GiveCollectible("Challenge_Recycler_Tracker")
    GiveCollectible("Challenge_PrinceCharming_Tracker")
  end
  return 
end
ACH_Destroyed = function()
  GiveCollectible("Challenge_Junker_Tracker")
  GiveCollectible("Challenge_Thinderella_Tracker")
  return 
end
ACH_Revive = function(self, event, instigator)
  local subEvent = ReviveEvent_GetSubEvent(event)
  return 
end
ObservatoryItem_Activate = function(global, quest)
  if (GetGlobal(global) == 0) then
    SetGlobal(global, 1)
    if (Quest_CheckStatus("Watch_the_Skies", "Watch_the_Skies_11", Quest_Discovered) == true) then
      if (3 <= GetGlobal("MSS_ObservatoryItem_Laralee")) then
        Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. quest) .. "a"), Quest_Unavailable, false)
        Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. quest) .. "b"), Quest_Discovered, false)
      elseif (3 <= GetGlobal("MSS_ObservatoryItem_Copernicus")) then
        Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. quest) .. "b"), Quest_Unavailable, false)
        Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. quest) .. "a"), Quest_Discovered, false)
      else
        Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. quest) .. "b"), Quest_Discovered, false)
        Quest_SetStatus("Watch_the_Skies", (("Watch_the_Skies_" .. quest) .. "a"), Quest_Discovered, false)
      end
    end
  end
  return 
end
SpawnAmmoFromOneShot = function(target, xoffset, yoffset, zoffset)
  Print("SpawnAmmoFromOneShot")
  local OneShotPosition = GetCenterPosition(target)
  OneShotPosition.x = (OneShotPosition.x + tonumber(xoffset))
  OneShotPosition.y = (OneShotPosition.y + tonumber(yoffset))
  OneShotPosition.z = (OneShotPosition.z + tonumber(zoffset))
  local OneShot_SpawnDirection = (GetPosition(_activator()) - OneShotPosition)
  OneShot_SpawnDirection:normalize3()
  OneShot_SpawnDirection.y = 2
  local SpawnChosenAmmoFromOneShot = function(target)
    if IsValidHandle(PickupSpawner) then
      SetTransformation(PickupSpawner, OneShotPosition, vector4(0, 0, 0))
      if GetPropertyBool(target, "Is Painted") then
        SetPropertyInt(PickupSpawner, "Index To Spawn", 4, 0)
      else
        SetPropertyInt(PickupSpawner, "Index To Spawn", 5, 0)
      end
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
  SetGlobal("Prefab_JigsawRewardChance", (GetGlobal("Prefab_JigsawRewardChance") + 1))
  local i = 0
  i = ((GetGlobal("Prefab_JigsawRewardChance") / 4) * math.random(1, 100))
  if (75 < i) then
    SetGlobal("Prefab_JigsawRewardChance", 0)
    SpawnChosenAmmoFromOneShot(target)
  end
  return 
end
GLB_CameraRollFull = function()
  ForceSequence(_self(), "Global_FilmRollFull", 0)
  return 
end
Debug_ChangeIGCStatChannel = function(channel)
  ChangeIGCStatChannel(channel)
  return 
end
Reprogram_HideAllControls = function()
  local player2 = GetPlayer2()
  if (player2 ~= nil) then
    StopEmitterByName(GetPlayer2(), "ReprogramControls1")
    StopEmitterByName(GetPlayer2(), "ReprogramControls2")
  end
  return 
end
QA_SetupEndGame = function(arg)
  local states = tostring(arg)
  local endGameGlobals = {"Extras_Mad_Doctor_Redemption", "Extras_Petes_Dragon_Paint", "Extras_Horace_And_Clarabelle_Paint", "Extras_Prescotts_Mech_Paint", "Extras_Ghost_Ian_Paint", "Extras_Donald_And_Daisy_Paint", "Extras_Petetronic_Present"}
  local numStates = (#endGameGlobals)
  if (string.len(states) ~= numStates) then
    print((("Invalid argument. String must be " .. tostring(numStates)) .. " characters long consisted of only 1s and 0s"))
    return 
  end
  for i = 1, numStates do
    local c = string.sub(states, i, i)
    if (c ~= "1") then
      if (c ~= "0") then
        print("Invalid argument. Use only 1s and 0s in your argument")
        return 
      end
    end
    print(((("Setting " .. endGameGlobals[i]) .. " to ") .. c))
    SetGlobal(endGameGlobals[i], tonumber(c))
  end
  print("End game globals updated.")
  return 
end
SetupGremlinTeleportInFXColors = function(fx, gremlinType)
  local warp = "pSys_warp_blueShape"
  local burst = "pSys_burstShape"
  local color = vector4(0, 0, 0, 0)
  if (gremlinType == "Gus") then
    color = vector4(0.5609999895095825, 0.20800000429153442, 0.10599999874830246, 0)
  elseif (gremlinType == "Variant1") then
    color = vector4(0.3059999942779541, 0.42399999499320984, 0.4860000014305115, 0)
  elseif (gremlinType == "Variant2") then
    color = vector4(0.6859999895095825, 0.5609999895095825, 0.18000000715255737, 0)
  elseif (gremlinType == "Variant3") then
    color = vector4(0.36899998784065247, 0.2630000114440918, 0.4350000023841858, 0)
  elseif (gremlinType == "Variant4") then
    color = vector4(0.3370000123977661, 0.46700000762939453, 0.3059999942779541, 0)
  else
    Print(("ERROR: Tried to setup TeleportInFX colors for unknown gremlin type: " .. gremlinType))
  end
  SetR3MTConstRegOnSubGraph(fx, warp, 1, color)
  SetR3MTConstRegOnSubGraph(fx, burst, 1, color)
  return 
end
SetupGremlinTeleportOutFXColors = function(fx, gremlinType)
  local face = "pSys_warp_face"
  local suit = "pSys_warp_suit"
  local hat = "pSys_warp_hat"
  local gloves = "pSys_warp_gloves"
  local shoes = "pSys_warp_shoes"
  if (gremlinType == "Gus") then
    SetR3MTConstRegOnSubGraph(fx, face, 1, vector4(0.27799999713897705, 0.2939999997615814, 0.07800000160932541, 0))
    SetR3MTConstRegOnSubGraph(fx, hat, 1, vector4(0.6389999985694885, 0.27799999713897705, 0.19200000166893005, 0))
    SetR3MTConstRegOnSubGraph(fx, suit, 1, vector4(0.5609999895095825, 0.20800000429153442, 0.10599999874830246, 0))
    SetR3MTConstRegOnSubGraph(fx, gloves, 1, vector4(0.6269999742507935, 0.5839999914169312, 0.49399998784065247, 0))
    SetR3MTConstRegOnSubGraph(fx, shoes, 1, vector4(0.24699999392032623, 0.18400000035762787, 0.125, 0))
  elseif (gremlinType == "Variant1") then
    SetR3MTConstRegOnSubGraph(fx, face, 1, vector4(0.6119999885559082, 0.3529999852180481, 0.03500000014901161, 0))
    SetR3MTConstRegOnSubGraph(fx, hat, 1, vector4(0.27000001072883606, 0.3799999952316284, 0.5019999742507935, 0))
    SetR3MTConstRegOnSubGraph(fx, suit, 1, vector4(0.3059999942779541, 0.42399999499320984, 0.4860000014305115, 0))
    SetR3MTConstRegOnSubGraph(fx, gloves, 1, vector4(0.6269999742507935, 0.5839999914169312, 0.49399998784065247, 0))
    SetR3MTConstRegOnSubGraph(fx, shoes, 1, vector4(0.24699999392032623, 0.18400000035762787, 0.125, 0))
  elseif (gremlinType == "Variant2") then
    SetR3MTConstRegOnSubGraph(fx, face, 1, vector4(0.6349999904632568, 0.37599998712539673, 0.07500000298023224, 0))
    SetR3MTConstRegOnSubGraph(fx, hat, 1, vector4(0.2939999997615814, 0.41200000047683716, 0.28999999165534973, 0))
    SetR3MTConstRegOnSubGraph(fx, suit, 1, vector4(0.6859999895095825, 0.5609999895095825, 0.18000000715255737, 0))
    SetR3MTConstRegOnSubGraph(fx, gloves, 1, vector4(0.6269999742507935, 0.5839999914169312, 0.49399998784065247, 0))
    SetR3MTConstRegOnSubGraph(fx, shoes, 1, vector4(0.24699999392032623, 0.18400000035762787, 0.125, 0))
  elseif (gremlinType == "Variant3") then
    SetR3MTConstRegOnSubGraph(fx, face, 1, vector4(0.6510000228881836, 0.5220000147819519, 0.2709999978542328, 0))
    SetR3MTConstRegOnSubGraph(fx, hat, 1, vector4(0.28200000524520874, 0.2590000033378601, 0.37599998712539673, 0))
    SetR3MTConstRegOnSubGraph(fx, suit, 1, vector4(0.36899998784065247, 0.2630000114440918, 0.4350000023841858, 0))
    SetR3MTConstRegOnSubGraph(fx, gloves, 1, vector4(0.19599999487400055, 0.13300000131130219, 0.07800000160932541, 0))
    SetR3MTConstRegOnSubGraph(fx, shoes, 1, vector4(0.24699999392032623, 0.18400000035762787, 0.125, 0))
  elseif (gremlinType == "Variant4") then
    SetR3MTConstRegOnSubGraph(fx, face, 1, vector4(0.5920000076293945, 0.3529999852180481, 0.054999999701976776, 0))
    SetR3MTConstRegOnSubGraph(fx, hat, 1, vector4(0.24699999392032623, 0.4390000104904175, 0.2709999978542328, 0))
    SetR3MTConstRegOnSubGraph(fx, suit, 1, vector4(0.3370000123977661, 0.46700000762939453, 0.3059999942779541, 0))
    SetR3MTConstRegOnSubGraph(fx, gloves, 1, vector4(0.6269999742507935, 0.5839999914169312, 0.49399998784065247, 0))
    SetR3MTConstRegOnSubGraph(fx, shoes, 1, vector4(0.24699999392032623, 0.18400000035762787, 0.125, 0))
  else
    Print(("ERROR: Tried to setup TeleportOutFX colors for unknown gremlin type: " .. gremlinType))
  end
  return 
end
QA_StartEndGame = function()
  ClearOverrideSpawnTransform(PLAYER_ONE)
  ClearOverrideSpawnTransform(PLAYER_TWO)
  StartSequence(nil, "EndGame:0", true, true)
  return 
end

