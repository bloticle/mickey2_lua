Prefab_PhoneBox_AlwaysSetup = function(target)
  Print("__Function: Prefab_PhoneBox_AlwaysSetup")
  local data = GetPrefabData(target)
  local (for index), (for limit), (for step) = 1, 3, 1
  for x = (for index), (for limit), (for step) do
    if (data.Globals[x] == "None") then
      Print((("__GLOBAL IN OVERRIDE SLOT [" .. tostring(x)) .. "] WAS NOT OVERRIDDEN"))
    elseif (GetGlobal(data.Globals[x]) == 1) then
      ForcePainted(("Prefab_PhoneBox" .. x))
    else
      ForceSketched(("Prefab_PhoneBox" .. x))
    end
  end
  return 
end
Prefab_PhoneBox_StateChange = function(target, _State)
  Print(("__Function: Prefab_PhoneBox_StateChange, _State: " .. tostring(_State)))
  local data = GetPrefabData(target)
  local ParentData = GetPrefabData("PhoneBoxTrio_Conversation")
  if (data.BoxNum == -1) then
    Print("__YOU DID NOT OVERRIDE THE BOX NUMBER FOR THIS PHONE BOX, THE GLOBAL FOR COMPLETION WILL NOT GET SET CORRECTLY")
  elseif (_State == "Painted") then
    SetGlobal(ParentData.Globals[data.BoxNum], 1)
    SetGlobal("VTL_Oasis_TelephoneBoxCount", (GetGlobal("VTL_Oasis_TelephoneBoxCount") + 1))
    if (ParentData.Level == "None") then
      Print("__YOU DIDNT SPECIFIY A LEVEL FOR THESE PHONE BOXES! THE COLLECTIBLE WILL NOT WORK PROPERLY! SPECIFY YOUR LEVEL NAME")
    else
      local CollectibleToGive = ("PhoneBox_" .. tostring(ParentData.Level))
      Print(("__Will give collectible: " .. tostring(CollectibleToGive)))
      GiveCollectible(CollectibleToGive)
    end
    if (data.PaintedBark == 0) then
      data.PaintedBark = 1
      if (GetGlobal(ParentData.Globals[1]) == 1) then
        if (GetGlobal(ParentData.Globals[2]) == 1) then
          if (GetGlobal(ParentData.Globals[3]) == 1) then
            if (1 <= GetGlobal("VTL_Oasis_ThreePigsQuest_OsTownPhone")) then
              if (ParentData.AllBoxesPaintedBark == "None") then
                Print("__YOU DIDN'T OVERRIDE THE PARENT PREFAB AllBoxesPaintedConversationBark, NO COMPLETED BARK WILL FIRE")
              elseif (GetGlobal((tostring(ParentData.AllBoxesPaintedBark) .. "_Played")) == 0) then
                ForceSequence("PhoneBoxTrio_Conversation", ParentData.AllBoxesPaintedBark)
                FireThread(Prefab_PhoneBox_SaveCheckpoint, target)
              else
                Print("__This quest update was already fired!")
                if (GetGlobal(ParentData.Globals[1]) == 1) then
                  if (GetGlobal(ParentData.Globals[2]) == 1) then
                    if (GetGlobal(ParentData.Globals[3]) == 1) then
                      ForceSequence("PhoneBoxTrio_Conversation", "EM2_Gus_PaintedPhoneBox")
                      FireThread(Prefab_PhoneBox_SaveCheckpoint, target)
                    end
                  end
                else
                  ForceSequence("PhoneBoxTrio_Conversation", "EM2_Gus_PaintedPhoneBox")
                  if (_State == "Thinned") then
                    SetGlobal(ParentData.Globals[data.BoxNum], 0)
                    SetGlobal("VTL_Oasis_TelephoneBoxCount", (GetGlobal("VTL_Oasis_TelephoneBoxCount") - 1))
                    if (ParentData.Level == "None") then
                      Print("__YOU DIDNT SPECIFIY A LEVEL FOR THESE PHONE BOXES! THE COLLECTIBLE WILL NOT WORK PROPERLY! SPECIFY YOUR LEVEL NAME")
                    else
                      local CollectibleToGive, CollectibleToGive = ("PhoneBox_" .. tostring(ParentData.Level)), tostring(ParentData.Level)
                      CollectibleToGive = Print
                      CollectibleToGive(("__Will take away collectible: " .. tostring(CollectibleToGive)))
                      CollectibleToGive = GiveQuestItems
                      CollectibleToGive(CollectibleToGive, -1)
                    end
                    if (GetGlobal("PhoneBoxes_PaintedFlag") == 1) then
                      if (not Quest_CheckStatus("Creative_Threedom", "Creative_Threedom_9a", Quest_Completed)) then
                        Quest_SetStatus("Creative_Threedom", "Creative_Threedom_9a", Quest_Discovered, true)
                        SetGlobal("PhoneBoxes_PaintedFlag", 0)
                      end
                    end
                  else
                    Print("__IO error, whatever was passed in here wasn't Painted or Thinned!")
                  end
                end
              end
            end
          end
        end
      elseif (GetGlobal(ParentData.Globals[1]) == 1) then
        if (GetGlobal(ParentData.Globals[2]) == 1) then
          if (GetGlobal(ParentData.Globals[3]) == 1) then
            ForceSequence("PhoneBoxTrio_Conversation", "EM2_Gus_PaintedPhoneBox")
            FireThread(Prefab_PhoneBox_SaveCheckpoint, target)
          end
        end
      else
        ForceSequence("PhoneBoxTrio_Conversation", "EM2_Gus_PaintedPhoneBox")
        if (_State == "Thinned") then
          SetGlobal(ParentData.Globals[data.BoxNum], 0)
          SetGlobal("VTL_Oasis_TelephoneBoxCount", (GetGlobal("VTL_Oasis_TelephoneBoxCount") - 1))
          if (ParentData.Level == "None") then
            Print("__YOU DIDNT SPECIFIY A LEVEL FOR THESE PHONE BOXES! THE COLLECTIBLE WILL NOT WORK PROPERLY! SPECIFY YOUR LEVEL NAME")
          else
            local CollectibleToGive, CollectibleToGive = ("PhoneBox_" .. tostring(ParentData.Level)), tostring(ParentData.Level)
            CollectibleToGive = Print
            CollectibleToGive(("__Will take away collectible: " .. tostring(CollectibleToGive)))
            CollectibleToGive = GiveQuestItems
            CollectibleToGive(CollectibleToGive, -1)
          end
          if (GetGlobal("PhoneBoxes_PaintedFlag") == 1) then
            if (not Quest_CheckStatus("Creative_Threedom", "Creative_Threedom_9a", Quest_Completed)) then
              Quest_SetStatus("Creative_Threedom", "Creative_Threedom_9a", Quest_Discovered, true)
              SetGlobal("PhoneBoxes_PaintedFlag", 0)
            end
          end
        else
          Print("__IO error, whatever was passed in here wasn't Painted or Thinned!")
        end
      end
    end
  elseif (_State == "Thinned") then
    SetGlobal(ParentData.Globals[data.BoxNum], 0)
    SetGlobal("VTL_Oasis_TelephoneBoxCount", (GetGlobal("VTL_Oasis_TelephoneBoxCount") - 1))
    if (ParentData.Level == "None") then
      Print("__YOU DIDNT SPECIFIY A LEVEL FOR THESE PHONE BOXES! THE COLLECTIBLE WILL NOT WORK PROPERLY! SPECIFY YOUR LEVEL NAME")
    else
      local CollectibleToGive, CollectibleToGive = ("PhoneBox_" .. tostring(ParentData.Level)), tostring(ParentData.Level)
      CollectibleToGive = Print
      CollectibleToGive(("__Will take away collectible: " .. tostring(CollectibleToGive)))
      CollectibleToGive = GiveQuestItems
      CollectibleToGive(CollectibleToGive, -1)
    end
    if (GetGlobal("PhoneBoxes_PaintedFlag") == 1) then
      if (not Quest_CheckStatus("Creative_Threedom", "Creative_Threedom_9a", Quest_Completed)) then
        Quest_SetStatus("Creative_Threedom", "Creative_Threedom_9a", Quest_Discovered, true)
        SetGlobal("PhoneBoxes_PaintedFlag", 0)
      end
    end
  else
    Print("__IO error, whatever was passed in here wasn't Painted or Thinned!")
  end
  return 
end
Prefab_PhoneBox_SaveCheckpoint = function(target)
  Print("__Function: Prefab_PhoneBox_SaveCheckpoint")
  while true do
    if (not (IsAnySequencePlaying() == true)) then
      break
    end
    wait(0.10000000149011612)
  end
  local data = GetPrefabData("PhoneBoxTrio_Conversation")
  local BoxData = GetPrefabData(target)
  if (data.CheckpointFunction ~= "None") then
    Print(("__Firing Checkpoint Function: " .. tostring(data.CheckpointFunction)))
    local Param1, Param2 = nil, nil
    if (data.CheckpointFunctionParam1 ~= "None") then
      Print(("__Will pass extra param1: " .. tostring(data.CheckpointFunctionParam1)))
      Param1 = data.CheckpointFunctionParam1
    end
    if (data.CheckpointFunctionParam2 ~= "None") then
      Print(("__Will pass extra param1: " .. tostring(data.CheckpointFunctionParam1)))
      Param2 = data.CheckpointFunctionParam2
    end
    Print((("__Will pass: " .. tostring(BoxData.BoxNum)) .. " as target param!"))
    FireThread(_G[data.CheckpointFunction], tonumber(BoxData.BoxNum), Param1, Param2)
  else
    Print("__No Checkpoint overridden for all phone boxes being painted in! You need to at least override the checkpoint function!")
  end
  return 
end
Prefab_PhoneBox_QuestComplete = function()
  if (GetGlobal("PhoneBoxes_PaintedFlag") == 0) then
    if (GetGlobal("VTL_Oasis_ThreePigsQuest_Donated") == false) then
      Quest_SetStatus("Creative_Threedom", "Creative_Threedom_9a", Quest_TurnIn, true)
      SetGlobal("PhoneBoxes_PaintedFlag", 1)
      ForceSequence("PhoneBoxTrio_Conversation", "EM2_Gus_PaintedPhoneBox")
    end
  end
  return 
end
