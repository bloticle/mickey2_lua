MSN_TraderSetup = false
SetupBlackBags = function()
  Print("Checking online status")
  if (IsOnlineEnabled() == true) then
    Print("This is an online enabled console.")
    if (IsOnline() == true) then
      if (MSN_InPinTrader == true) then
        if (IsServerUp() == true) then
          AnimGBSequence("MSN_PinTraderBlind", "up")
          SetGlobal("MSN_OnlineCheck", true)
        else
          SetGlobal("MSN_OnlineCheck", false)
          Print("Make the online stuff unavailable.")
          SetPropertyFloat("OnlinePinsUseTrig", "UsableRadius", 0)
          DestroyEntity("OnlineInfoTrig")
          DestroyEntity("MSN_PinTraderBlind")
        end
      end
    end
  else
    Print("Make the online stuff unavailable.")
    SetPropertyFloat("OnlinePinsUseTrig", "UsableRadius", 0)
    DestroyEntity("OnlineInfoTrig")
    DestroyEntity("MSN_PinTraderBlind")
  end
  Print("Setting up black bags")
  MSN_TraderSetup = true
  MSN_BlackBag_A()
  MSN_BlackBag_B()
  MSN_BlackBag_C()
  MSN_TraderSetup = false
  Print("Done setting up black bags.")
  Print(("MSN_TraderSetup is " .. tostring(MSN_TraderSetup)))
  return 
end
ControlBlind = function(target, state)
  if (state == up) then
    AnimGBSequence("MSN_PinTraderBlind", "up")
    SetGlobal("MSN_OnlineCheck", true)
  else
    AnimGBSequence("MSN_PinTraderBlind", "down")
    SetGlobal("MSN_OnlineCheck", false)
  end
  return 
end
MSN_BlackBag_A = function()
  Print("Populating Black Bag A.")
  local BagContents_A = {"none"}
  local BagCounter = 1
  if (not HasCollectible("Mad_Doctor")) then
    BagContents_A[BagCounter] = "Mad_Doctor"
    BagCounter = (BagCounter + 1)
  end
  if (not HasCollectible("Mean_Street")) then
    BagContents_A[BagCounter] = "Mean_Street"
    BagCounter = (BagCounter + 1)
  end
  if (not HasCollectible("Oswald_Pin")) then
    BagContents_A[BagCounter] = "Oswald_Pin"
    BagCounter = (BagCounter + 1)
  end
  if (not HasCollectible("DarkBeautyCastle")) then
    BagContents_A[BagCounter] = "DarkBeautyCastle"
    BagCounter = (BagCounter + 1)
  end
  if (not HasCollectible("Repair_Mean_Street")) then
    BagContents_A[BagCounter] = "Repair_Mean_Street"
    BagCounter = (BagCounter + 1)
  end
  if (not HasCollectible("Friend_of_Gremlins")) then
    if (1 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Friend_of_Gremlins"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Mean_Street_Matchmaker")) then
    if (1 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Mean_Street_Matchmaker"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Welcome_to_Wasteland")) then
    if (1 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Welcome_to_Wasteland"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Mystery_Solved")) then
    if (1 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Mystery_Solved"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Skydiver")) then
    if (1 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Skydiver"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Dropwing")) then
    if (1 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Dropwing"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Spladoosh")) then
    if (1 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Spladoosh"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Mickey_Mum")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Mickey_Mum"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Play_a_Tune")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Play_a_Tune"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Redeem_Small_Pete")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Redeem_Small_Pete"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Stop_the_Music")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Stop_the_Music"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Swamp_Iris")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Swamp_Iris"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Unwind_the_Clock")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Unwind_the_Clock"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Heavy")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Heavy"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Case_Closed")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Case_Closed"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("No_More_Bloticles")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "No_More_Bloticles"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Entertaining")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Entertaining"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Never_Late")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Never_Late"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Basher")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Basher"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Tanker")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Tanker"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Gremlin_Guardian")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Gremlin_Guardian"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Symphony_Sunflower")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Symphony_Sunflower"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Tomorrow_City")) then
    if (2 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Tomorrow_City"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Escape_Shadow_Blot")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Escape_Shadow_Blot"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Shadow_Boxing")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Shadow_Boxing"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Sparkle_Daisy")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Sparkle_Daisy"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Ventureland_Cupid")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Ventureland_Cupid"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Blotworx_Bruiser")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Blotworx_Bruiser"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Blotworx_Melee")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Blotworx_Melee"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Blotworx_Ranged")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_A[BagCounter] = "Blotworx_Ranged"
      BagCounter = (BagCounter + 1)
    end
  end
  local realcount = (BagCounter - 1)
  Print(("Total available pins is " .. realcount))
  if (BagContents_A[1] == "none") then
    SetGlobal("MSN_DisplayBagA", false)
  else
    SetGlobal("MSN_DisplayBagA", true)
  end
  Print(("MSN_TraderSetup is " .. tostring(MSN_TraderSetup)))
  if (MSN_TraderSetup ~= true) then
    Print("Pick a pin, any pin.")
    local RandomDraw = math.random(1, realcount)
    if (not HasCollectible(BagContents_A[RandomDraw])) then
      GiveCollectible(BagContents_A[RandomDraw])
      realcount = (realcount - 1)
    else
      AddCurrency("Pins", 2)
      Print("Somehow you already had that pin.  Money refunded.")
    end
    if (realcount == 0) then
      Print("Bag should be empty.")
      SetGlobal("MSN_DisplayBagA", false)
    end
  end
  return 
end
MSN_BlackBag_B = function()
  Print("Populating Black Bag B.")
  local BagContents_B = {"none"}
  local BagCounter = 1
  if (not HasCollectible("Mouseterpiece")) then
    if (GetGlobal("Mouseterpiece_Pin") == 0) then
      BagContents_B[BagCounter] = "Mouseterpiece"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Beauty_Only_Thin_Deep")) then
    BagContents_B[BagCounter] = "Beauty_Only_Thin_Deep"
    BagCounter = (BagCounter + 1)
  end
  if (not HasCollectible("Belle_Of_The_Ball")) then
    BagContents_B[BagCounter] = "Belle_Of_The_Ball"
    BagCounter = (BagCounter + 1)
  end
  if (not HasCollectible("Lockbreaker")) then
    if (GetGlobal("MSN_GremlinStructure_WindMill") == 1) then
      BagContents_B[BagCounter] = "Lockbreaker"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Locksmith")) then
    if (2 <= GetGlobal("MSN_VaultDoorState")) then
      BagContents_B[BagCounter] = "Locksmith"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Bibbidi_Bobbidi_Boo")) then
    if (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingOccupant") == 2) then
      BagContents_B[BagCounter] = "Bibbidi_Bobbidi_Boo"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Hockety_Pockety_Wockety_Wack")) then
    if (GetGlobal("NOS_BogEasy_MagicShopQuest_BuildingOccupant") == 2) then
      BagContents_B[BagCounter] = "Hockety_Pockety_Wockety_Wack"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Green_Thumb")) then
    if HasCollectible("Spatter_Stylist") then
      BagContents_B[BagCounter] = "Green_Thumb"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not (not HasCollectible("Diving_Miss_Daisy"))) then
  end
  BagContents_B[BagCounter] = "Diving_Miss_Daisy"
  BagCounter = (BagCounter + 1)
  if (not HasCollectible("Gotcha")) then
    if (GetGlobal("NOS_BogEasy_DonaldQuest_WhichGear") == 10) then
      BagContents_B[BagCounter] = "Gotcha"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Dandy_Evan")) then
    if (GetGlobal("Q_ScurvyPatToGulch") == 0) then
      BagContents_B[BagCounter] = "Dandy_Evan"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Parrotless_Steve")) then
    if (GetGlobal("Q_ScurvyPatToGulch") == 0) then
      BagContents_B[BagCounter] = "Parrotless_Steve"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Slouchin_Brian")) then
    if (GetGlobal("Q_ScurvyPatToGulch") == 0) then
      BagContents_B[BagCounter] = "Slouchin_Brian"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("On_the_House")) then
    if (GetGlobal("VTL_Oasis_CraneDecision") == 1) then
      BagContents_B[BagCounter] = "On_the_House"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Taking_Out_the_Trash")) then
    if (GetGlobal("VTL_Oasis_CraneDecision") == 1) then
      BagContents_B[BagCounter] = "Taking_Out_the_Trash"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Perfect_Harmony")) then
    if (GetGlobal("NOS_BogEasy_JugbandState") == -1) then
      BagContents_B[BagCounter] = "Perfect_Harmony"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Autotopia_Racing")) then
    if (GetGlobal("OST_Moody_Photo5") == 10) then
      BagContents_B[BagCounter] = "Autotopia_Racing"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Everyone_Loves_a_Parade")) then
    if (GetGlobal("OST_Moody_Photo5") == 10) then
      BagContents_B[BagCounter] = "Everyone_Loves_a_Parade"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Gremlins_Prescott")) then
    if (GetGlobal("OST_Moody_Photo5") == 10) then
      BagContents_B[BagCounter] = "Gremlins_Prescott"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Visit_Fort_Wasteland")) then
    if (GetGlobal("OST_Moody_Photo5") == 10) then
      BagContents_B[BagCounter] = "Visit_Fort_Wasteland"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Welcome_to_the_Gulch")) then
    if (GetGlobal("OST_Moody_Photo5") == 10) then
      BagContents_B[BagCounter] = "Welcome_to_the_Gulch"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not (not HasCollectible("Falls_of_Rainbow_Caverns"))) then
  end
  BagContents_B[BagCounter] = "Falls_of_Rainbow_Caverns"
  BagCounter = (BagCounter + 1)
  if (not HasCollectible("Simple_Life")) then
    if (GetGlobal("OST_Moody_Destination") ~= -1) then
      BagContents_B[BagCounter] = "Simple_Life"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Wild_Frontier")) then
    if (GetGlobal("OST_Moody_Destination") <= 5) then
      if (GetGlobal("OST_Moody_Destination") ~= -1) then
        BagContents_B[BagCounter] = "Wild_Frontier"
        BagCounter = (BagCounter + 1)
      end
    end
  end
  if (not HasCollectible("Bog_Easy_Conductor")) then
    if (GetGlobal("NOS_BogEasy_TrainDestroyed") == 1) then
      BagContents_B[BagCounter] = "Bog_Easy_Conductor"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Ostown_Train_Conductor")) then
    if (GetGlobal("OST_OsTown_TrainRestored") == 0) then
      if (2 < GetGlobal("EM2_EpisodeCheck")) then
        BagContents_B[BagCounter] = "Ostown_Train_Conductor"
        BagCounter = (BagCounter + 1)
      end
    end
  end
  if (not HasCollectible("Ventureland_Preservationist")) then
    if (GetGlobal("VTL_Oasis_TrainRestored") == 0) then
      if (3 < GetGlobal("EM2_EpisodeCheck")) then
        BagContents_B[BagCounter] = "Ventureland_Preservationist"
        BagCounter = (BagCounter + 1)
      end
    end
  end
  if (not HasCollectible("Ventureland_Train_Conductor")) then
    if (GetGlobal("VTL_Oasis_TrainRestored") == 0) then
      if (3 < GetGlobal("EM2_EpisodeCheck")) then
        BagContents_B[BagCounter] = "Ventureland_Train_Conductor"
        BagCounter = (BagCounter + 1)
      end
    end
  end
  if (not HasCollectible("Mean_Street_Train_Conductor")) then
    if (GetGlobal("MSS_TrainRestored") == -2) then
      if (2 < GetGlobal("EM2_EpisodeCheck")) then
        BagContents_B[BagCounter] = "Mean_Street_Train_Conductor"
        BagCounter = (BagCounter + 1)
      end
    end
  end
  if (not HasCollectible("Consumate_Collector")) then
    if (3 <= GetGlobal("MSS_ObservatoryItem_Copernicus")) then
      BagContents_B[BagCounter] = "Consumate_Collector"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Pirate_Hero")) then
    if (GetGlobal("Q_ScurvyPatToGulch") == 0) then
      BagContents_B[BagCounter] = "Pirate_Hero"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Pirates_of_the_Wasteland")) then
    if (GetGlobal("Q_ScurvyPatToGulch") == 0) then
      BagContents_B[BagCounter] = "Pirates_of_the_Wasteland"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Swashbuckler")) then
    if (GetGlobal("Q_ScurvyPatToGulch") == 0) then
      BagContents_B[BagCounter] = "Swashbuckler"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Gremlin_Village")) then
    if (GetGlobal("OST_Moody_Photo5") == 10) then
      BagContents_B[BagCounter] = "Gremlin_Village"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Lonesome_Manor")) then
    if (GetGlobal("OST_Moody_Photo5") == 10) then
      BagContents_B[BagCounter] = "Lonesome_Manor"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Mickeyjunk_Mountain")) then
    if (GetGlobal("OST_Moody_Photo5") == 10) then
      BagContents_B[BagCounter] = "Mickeyjunk_Mountain"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Fixer_Upper")) then
    if (not (not HasCollectible("Demolition_Expert"))) then
      BagContents_B[BagCounter] = "Fixer_Upper"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Foreman")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      if (GetGlobal("LMR_TheAttic_VaultState") == 2) then
        BagContents_B[BagCounter] = "Foreman"
        BagCounter = (BagCounter + 1)
      end
    end
  end
  if (not HasCollectible("Handymouse")) then
    if (not (not HasCollectible("Eradicator"))) then
      BagContents_B[BagCounter] = "Handymouse"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Demolition_Expert")) then
    if (not (not HasCollectible("Fixer_Upper"))) then
      BagContents_B[BagCounter] = "Demolition_Expert"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Eradicator")) then
    if (not (not HasCollectible("Handymouse"))) then
      BagContents_B[BagCounter] = "Eradicator"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Urban_Renewal")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      if (GetGlobal("LMR_TheAttic_VaultState") == 2) then
        BagContents_B[BagCounter] = "Urban_Renewal"
        BagCounter = (BagCounter + 1)
      end
    end
  end
  local realcount = (BagCounter - 1)
  Print(("Total available pins in Bag B is " .. realcount))
  if (BagContents_B[1] == "none") then
    Print("Set MSN_DisplayBagB to false.")
    SetGlobal("MSN_DisplayBagB", false)
  else
    Print("Set MSN_DisplayBagB to true.")
    SetGlobal("MSN_DisplayBagB", true)
  end
  Print(("MSN_TraderSetup is " .. tostring(MSN_TraderSetup)))
  if (MSN_TraderSetup ~= true) then
    Print("Pick a pin, any pin.")
    local RandomDraw = math.random(1, realcount)
    Print(("This is realcount: " .. realcount))
    Print(("This is RandomDraw: " .. RandomDraw))
    if (not HasCollectible(BagContents_B[RandomDraw])) then
      Print(("Giving collectible: " .. tostring(BagContents_B[RandomDraw])))
      GiveCollectible(BagContents_B[RandomDraw])
      realcount = (realcount - 1)
    else
      AddCurrency("Pins", 4)
      Print("Somehow you already had that pin.  Money refunded.")
    end
    if (realcount == 0) then
      Print("Bag should be empty.")
      SetGlobal("MSN_DisplayBagB", false)
    end
  end
  return 
end
MSN_BlackBag_C = function()
  Print("Populating Black Bag C.")
  local BagContents_C = {"none"}
  local BagCounter = 1
  if (not HasCollectible("Hat")) then
    if (GetGlobal("MSS_GremlinStructure_Agency") == 2) then
      if (GetGlobal("MSS_Hatter_PowerRestored_Played") == 0) then
        BagContents_C[BagCounter] = "Hat"
        BagCounter = (BagCounter + 1)
      end
    end
  end
  if (not HasCollectible("Spatter_Whisperer")) then
    if (GetGlobal("NOS_BlotAlley_IanMood") < 1) then
      if (GetGlobal("NOS_BlotAlley_Ian_Airlock3_Played") == 1) then
        BagContents_C[BagCounter] = "Spatter_Whisperer"
        BagCounter = (BagCounter + 1)
      end
    end
  end
  if (not HasCollectible("Ohana")) then
    if HasCollectible("Gremlin_Ballista") then
      BagContents_C[BagCounter] = "Ohana"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Love_Conquers_All")) then
    if HasCollectible("Careful_Planning") then
      BagContents_C[BagCounter] = "Love_Conquers_All"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Spatter_Stylist")) then
    if HasCollectible("Green_Thumb") then
      BagContents_C[BagCounter] = "Spatter_Stylist"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Blotyguard")) then
    if (GetGlobal("VTL_Oasis_CraneDecision") == 2) then
      BagContents_C[BagCounter] = "Blotyguard"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Angels_Dancing")) then
    if (GetGlobal("RBF_AngelOrDevil") == 2) then
      BagContents_C[BagCounter] = "Angels_Dancing"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Booty_to_the_Head")) then
    if HasCollectible("Love_Conquers_All") then
      BagContents_C[BagCounter] = "Booty_to_the_Head"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("All_Ears")) then
    if (GetGlobal("MSN_UsherCompleted_3Pigs") == 1) then
      BagContents_C[BagCounter] = "All_Ears"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Beautiful_Friendship")) then
    if (GetGlobal("MSS_HoraceQuest_Assistant") == 2) then
      BagContents_C[BagCounter] = "Beautiful_Friendship"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Music_to_My_Ears")) then
    if (GetGlobal("NOS_Rolly_OutOfToon_QuestCompleted_Played") == 1) then
      BagContents_C[BagCounter] = "Music_to_My_Ears"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Road_Rally_Pin")) then
    if (GetGlobal("OST_Moody_Photo5") == 10) then
      BagContents_C[BagCounter] = "Road_Rally_Pin"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Adventurous_Life")) then
    if (GetGlobal("OST_Moody_Photo5") == 10) then
      BagContents_C[BagCounter] = "Adventurous_Life"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("I_Scream_You_Scream")) then
    if (not (not HasCollectible("Not_Quite_101"))) then
      BagContents_C[BagCounter] = "I_Scream_You_Scream"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Pump_It_Up")) then
    if HasCollectible("Dont_Know_My_Own_Strength") then
      BagContents_C[BagCounter] = "Pump_It_Up"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Aggressive_Driver_Pin")) then
    if HasCollectible("Pedal_to_the_Metal") then
      BagContents_C[BagCounter] = "Aggressive_Driver_Pin"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Gremlin_Ballista")) then
    if (not (not HasCollectible("Ohana"))) then
      BagContents_C[BagCounter] = "Gremlin_Ballista"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Careful_Planning")) then
    if HasCollectible("Love_Conquers_All") then
      BagContents_C[BagCounter] = "Careful_Planning"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Mouse_Catcher")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_C[BagCounter] = "Mouse_Catcher"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Dont_Know_My_Own_Strength")) then
    if (not (not HasCollectible("Pump_It_Up"))) then
      BagContents_C[BagCounter] = "Dont_Know_My_Own_Strength"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Jumpstart")) then
    if (GetGlobal("NOS_BogEasy_SparksPinCanGet") == 0) then
      BagContents_C[BagCounter] = "Jumpstart"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Good_Head_on_His_Shoulders")) then
    if HasCollectible("Heads_I_Win") then
      BagContents_C[BagCounter] = "Good_Head_on_His_Shoulders"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("All_Aboard_Wasteland")) then
    if (GetGlobal("VTL_Oasis_TrainRestored") ~= 0) then
      if (GetGlobal("MSS_TrainRestored") ~= -2) then
        if (GetGlobal("OST_OsTown_TrainRestored") ~= 0) then
        end
      end
    end
    BagContents_C[BagCounter] = "All_Aboard_Wasteland"
    BagCounter = (BagCounter + 1)
  end
  if (not HasCollectible("Black_Bill")) then
    if (GetGlobal("Q_ScurvyPatToGulch") == 0) then
      BagContents_C[BagCounter] = "Black_Bill"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Make_Ghosts_Lonesome")) then
    if (GetGlobal("FTL_Fort_SpatterState") == 1) then
      BagContents_C[BagCounter] = "Make_Ghosts_Lonesome"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Heads_I_Win")) then
    if HasCollectible("Good_Head_on_His_Shoulders") then
      BagContents_C[BagCounter] = "Heads_I_Win"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Lost_and_Found")) then
    if (GetGlobal("MSS_HoraceQuest_Assistant") == 3) then
      BagContents_C[BagCounter] = "Lost_and_Found"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Pedal_to_the_Metal")) then
    if HasCollectible("Aggressive_Driver_Pin") then
      BagContents_C[BagCounter] = "Pedal_to_the_Metal"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("20000_Leagues_Under")) then
    if (GetGlobal("NOS_BogEasy_DonaldQuest_WhichCompleted") == -1) then
      BagContents_C[BagCounter] = "20000_Leagues_Under"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Fan_Club_President")) then
    if (3 < GetGlobal("EM2_EpisodeCheck")) then
      BagContents_C[BagCounter] = "Fan_Club_President"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Recycler")) then
    if (GetGlobal("VTL_Oasis_CraneDecision") == 2) then
      BagContents_C[BagCounter] = "Recycler"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Silly_Symphony")) then
    if (GetGlobal("NOS_BogEasy_JugbandState") == -1) then
      BagContents_C[BagCounter] = "Silly_Symphony"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Not_Quite_101")) then
    if (not (not HasCollectible("I_Scream_You_Scream"))) then
      BagContents_C[BagCounter] = "Not_Quite_101"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Breaking_News")) then
    if (GetGlobal("VTL_Oasis_DaisyQuest_JackTurnin") == 5) then
      BagContents_C[BagCounter] = "Breaking_News"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Looking_at_the_Stars")) then
    if (3 <= GetGlobal("MSS_ObservatoryItem_Laralee")) then
      BagContents_C[BagCounter] = "Looking_at_the_Stars"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("Breaking_News")) then
    if (GetGlobal("VTL_Oasis_BlackPearlStolen") == 1) then
      if (3 < GetGlobal("EM2_EpisodeCheck")) then
        BagContents_C[BagCounter] = "Breaking_News"
        BagCounter = (BagCounter + 1)
      end
    end
  end
  if (not HasCollectible("Meet_Your_Maker")) then
    if (GetGlobal("MSS_TrainRestored") == -2) then
      BagContents_C[BagCounter] = "Meet_Your_Maker"
      BagCounter = (BagCounter + 1)
    end
  end
  if (not HasCollectible("When_Elephants_Fly")) then
    if (GetGlobal("FTL_Gulch_SaloonCollapse_Played") == 1) then
      BagContents_C[BagCounter] = "When_Elephants_Fly"
      BagCounter = (BagCounter + 1)
    end
  end
  local realcount = (BagCounter - 1)
  Print(("Total available pins in Bag C is " .. realcount))
  if (BagContents_C[1] == "none") then
    SetGlobal("MSN_DisplayBagC", false)
  else
    SetGlobal("MSN_DisplayBagC", true)
  end
  Print(("MSN_TraderSetup is " .. tostring(MSN_TraderSetup)))
  if (MSN_TraderSetup ~= true) then
    Print("Pick a pin, any pin.")
    local RandomDraw = math.random(1, realcount)
    if (not HasCollectible(BagContents_C[RandomDraw])) then
      GiveCollectible(BagContents_C[RandomDraw])
      realcount = (realcount - 1)
    else
      AddCurrency("Pins", 8)
      Print("Somehow you already had that pin.  Money refunded.")
    end
    if (realcount == 0) then
      Print("Bag should be empty.")
      SetGlobal("MSN_DisplayBagC", false)
    end
  end
  return 
end
