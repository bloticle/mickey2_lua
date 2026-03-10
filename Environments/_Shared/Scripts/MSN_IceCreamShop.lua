MSN_BunnyChildrenBrain = function()
  local SpecialCaseReward = 0
  Print("#### MSN_BunnyChildrenBrain")
  Print(("#### MSN_BunnyQuest_Count is " .. GetGlobal("MSN_BunnyQuest_Count")))
  Print(("#### MSN_BunnyRewardGiven is " .. GetGlobal("MSN_BunnyRewardGiven")))
  if (GetGlobal("MSN_BunnyRewardGiven") == 1) then
    if (5 <= GetGlobal("MSN_BunnyQuest_Count")) then
      AddCurrency("ETicket", 100)
      SpecialCaseReward = 1
      SetGlobal("MSN_BunnyRewardGiven", 2)
    end
  end
  Wait(0)
  if (GetGlobal("MSN_BunnyRewardGiven02") == 1) then
    if (10 <= GetGlobal("MSN_BunnyQuest_Count")) then
      AddCurrency("ETicket", 100)
      SpecialCaseReward = 1
      SetGlobal("MSN_BunnyRewardGiven02", 2)
    end
  end
  Wait(0)
  if (GetGlobal("MSN_BunnyRewardGiven03") == 1) then
    if (15 <= GetGlobal("MSN_BunnyQuest_Count")) then
      AddCurrency("ETicket", 200)
      SpecialCaseReward = 1
      SetGlobal("MSN_BunnyRewardGiven03", 2)
    end
  end
  Wait(0)
  if (GetGlobal("MSN_BunnyRewardGiven04") == 1) then
    if (20 <= GetGlobal("MSN_BunnyQuest_Count")) then
      AddCurrency("ETicket", 200)
      SetGlobal("MSN_BunnyRewardGiven04", 2)
    end
  end
  Wait(0)
  if (GetGlobal("MSN_BunnyRewardGiven05") == 1) then
    if (25 <= GetGlobal("MSN_BunnyQuest_Count")) then
      AddCurrency("ETicket", 500)
      SetGlobal("MSN_BunnyRewardGiven05", 2)
    end
  end
  Wait(0)
  if (GetGlobal("MSN_BunnyRewardGiven06") == 1) then
    if (30 <= GetGlobal("MSN_BunnyQuest_Count")) then
      AddCurrency("ETicket", 1000)
      SetGlobal("MSN_BunnyRewardGiven06", 2)
    end
  end
  MSN_SaveCheckPoint02()
  if (30 <= GetGlobal("MSN_BunnyTotal")) then
    if (20 <= GetGlobal("MSN_BunnyQuest_Count")) then
      if (HasCollectible("I_Scream_You_Scream") == false) then
        ForceSequence("MSN_IceCreamPaulie", "MSN_Paulie_I_Scream_Pin")
      end
    end
  elseif (30 <= GetGlobal("MSN_BunnyTotal")) then
    if (GetGlobal("MSN_BunnyQuest_Count") < 20) then
      if (GetGlobal("OST_BunnyQuest_Count") < 20) then
        if (GetGlobal("MSN_BunnyQuest_Count") < 20) then
          if (not Quest_CheckStatus("The_Bunny_Wranglers", "The_Bunny_Wranglers_10b", Quest_Unavailable)) then
            Quest_SetStatus("The_Bunny_Wranglers", "The_Bunny_Wranglers_10a", Quest_Unavailable, false)
            Quest_SetStatus("The_Bunny_Wranglers", "The_Bunny_Wranglers_10b", Quest_Unavailable, false)
            GiveCollectible("Challenge_Perfectionist_BunnyWrangler_Tracker")
          end
          if (SpecialCaseReward == 1) then
            ForceSequence("MSN_IceCreamPaulie", "MSN_Paulie_BunnyRewardTier02")
          end
        end
      end
      ForceSequence("MSN_IceCreamPaulie", "MSN_Paulie_IceCreamIdle")
    end
  end
  return 
end
MSN_IceCreamGivePin = function()
  GiveCollectible("I_Scream_You_Scream")
  return 
end
MSN_BunnyReward_PreBrain = function()
  if (5 <= GetGlobal("MSN_BunnyQuest_Count")) then
    if (GetGlobal("MSN_BunnyQuest_Count") < 10) then
      if (GetGlobal("MSN_BunnyRewardGiven") == 0) then
        SetGlobal("MSN_BunnyRewardGiven", 1)
      end
    end
  elseif (10 <= GetGlobal("MSN_BunnyQuest_Count")) then
    if (GetGlobal("MSN_BunnyQuest_Count") < 15) then
      if (GetGlobal("MSN_BunnyRewardGiven02") == 0) then
        SetGlobal("MSN_BunnyRewardGiven02", 1)
        if (GetGlobal("MSN_BunnyRewardGiven") == 0) then
          SetGlobal("MSN_BunnyRewardGiven", 1)
        end
      end
    end
  elseif (15 <= GetGlobal("MSN_BunnyQuest_Count")) then
    if (GetGlobal("MSN_BunnyQuest_Count") < 20) then
      if (GetGlobal("MSN_BunnyRewardGiven03") == 0) then
        SetGlobal("MSN_BunnyRewardGiven03", 1)
        if (GetGlobal("MSN_BunnyRewardGiven") == 0) then
          SetGlobal("MSN_BunnyRewardGiven", 1)
        end
        if (GetGlobal("MSN_BunnyRewardGiven02") == 0) then
          SetGlobal("MSN_BunnyRewardGiven02", 1)
        end
      end
    end
  elseif (20 <= GetGlobal("MSN_BunnyQuest_Count")) then
    if (GetGlobal("MSN_BunnyQuest_Count") < 25) then
      if (GetGlobal("MSN_BunnyRewardGiven04") == 0) then
        SetGlobal("MSN_BunnyRewardGiven04", 1)
        if (GetGlobal("MSN_BunnyRewardGiven") == 0) then
          SetGlobal("MSN_BunnyRewardGiven", 1)
        end
        if (GetGlobal("MSN_BunnyRewardGiven02") == 0) then
          SetGlobal("MSN_BunnyRewardGiven02", 1)
        end
        if (GetGlobal("MSN_BunnyRewardGiven03") == 0) then
          SetGlobal("MSN_BunnyRewardGiven03", 1)
        end
      end
    end
  elseif (25 <= GetGlobal("MSN_BunnyQuest_Count")) then
    if (GetGlobal("MSN_BunnyQuest_Count") < 30) then
      if (GetGlobal("MSN_BunnyRewardGiven05") == 0) then
        SetGlobal("MSN_BunnyRewardGiven05", 1)
        if (GetGlobal("MSN_BunnyRewardGiven") == 0) then
          SetGlobal("MSN_BunnyRewardGiven", 1)
        end
        if (GetGlobal("MSN_BunnyRewardGiven02") == 0) then
          SetGlobal("MSN_BunnyRewardGiven02", 1)
        end
        if (GetGlobal("MSN_BunnyRewardGiven03") == 0) then
          SetGlobal("MSN_BunnyRewardGiven03", 1)
        end
        if (GetGlobal("MSN_BunnyRewardGiven04") == 0) then
          SetGlobal("MSN_BunnyRewardGiven04", 1)
        end
      end
    end
  elseif (30 <= GetGlobal("MSN_BunnyQuest_Count")) then
    if (GetGlobal("MSN_BunnyRewardGiven06") == 0) then
      SetGlobal("MSN_BunnyRewardGiven06", 1)
      if (GetGlobal("MSN_BunnyRewardGiven") == 0) then
        SetGlobal("MSN_BunnyRewardGiven", 1)
      end
      if (GetGlobal("MSN_BunnyRewardGiven02") == 0) then
        SetGlobal("MSN_BunnyRewardGiven02", 1)
      end
      if (GetGlobal("MSN_BunnyRewardGiven03") == 0) then
        SetGlobal("MSN_BunnyRewardGiven03", 1)
      end
      if (GetGlobal("MSN_BunnyRewardGiven04") == 0) then
        SetGlobal("MSN_BunnyRewardGiven04", 1)
      end
      if (GetGlobal("MSN_BunnyRewardGiven05") == 0) then
        SetGlobal("MSN_BunnyRewardGiven05", 1)
      end
    end
  end
  Print(("#### PreBrain MSN_BunnyQuest_Count is " .. GetGlobal("MSN_BunnyQuest_Count")))
  Print(("#### PreBrain MSN_BunnyRewardGiven is " .. GetGlobal("MSN_BunnyRewardGiven")))
  ForceSequence("MSN_IceCreamPaulie", "MSN_Paulie_BunnyRewardMaster")
  return 
end

