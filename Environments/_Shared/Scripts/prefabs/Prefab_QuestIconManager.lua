Prefab_QuestIconManager_IconDisplayCheck = function(target)
  local data = GetPrefabData(target)
  local Quest1NotAvailable = 0
  local Quest2NotAvailable = 0
  local Quest3NotAvailable = 0
  local Quest1Complete = 0
  local Quest2Complete = 0
  local Quest3Complete = 0
  Print(("QuestIconManager --- Quest Giver: " .. data.QuestGiver))
  if (data.Quest1Prerequisite[1] ~= "GlobalName") then
    Print(((("QuestIconManager --- Quest1Prerequisite GlobalName: " .. data.Quest1Prerequisite[1]) .. ", Quest1Prerequisite Value: ") .. data.Quest1Prerequisite[2]))
    if (GetGlobal(data.Quest1Prerequisite[1]) < data.Quest1Prerequisite[2]) then
      Quest1NotAvailable = -1
    else
      Quest1NotAvailable = 1
      Quest1NotAvailable = 0
    end
  else
    Quest1NotAvailable = 0
  end
  if (data.Quest2Prerequisite[1] ~= "GlobalName") then
    Print(((("QuestIconManager --- Quest2Prerequisite GlobalName: " .. data.Quest2Prerequisite[1]) .. ", Quest2Prerequisite Value: ") .. data.Quest2Prerequisite[2]))
    if (GetGlobal(data.Quest2Prerequisite[1]) < data.Quest2Prerequisite[2]) then
      Quest2NotAvailable = -1
    else
      Quest2NotAvailable = 1
      Quest2NotAvailable = 0
    end
  else
    Quest2NotAvailable = 0
  end
  if (data.Quest3Prerequisite[1] ~= "GlobalName") then
    Print(((("QuestIconManager --- Quest3Prerequisite GlobalName: " .. data.Quest3Prerequisite[1]) .. ", Quest3Prerequisite Value: ") .. data.Quest3Prerequisite[2]))
    if (GetGlobal(data.Quest3Prerequisite[1]) < data.Quest3Prerequisite[2]) then
      Quest3NotAvailable = -1
    else
      Quest3NotAvailable = 1
      Quest3NotAvailable = 0
    end
  else
    Quest3NotAvailable = 0
  end
  if (data.Quest1FinalStage[1] ~= "QuestID") then
    Print(((("QuestIconManager --- Quest1FinalStage QuestID: " .. data.Quest1FinalStage[1]) .. ", Quest1FinalStage StageID: ") .. data.Quest1FinalStage[2]))
    if (data.Quest1FinalStage[3] == 100) then
      if (Quest_CheckStatus(data.Quest1FinalStage[1], data.Quest1FinalStage[2], Quest_Completed) == true) then
        Quest1Complete = -1
      end
      Quest1Complete = 1
    elseif (data.Quest1FinalStage[2] == "LessThan") then
      if (GetGlobal(data.Quest1FinalStage[1]) < data.Quest1FinalStage[3]) then
        Quest1Complete = -1
      else
        Quest1Complete = 1
        if (data.Quest1FinalStage[2] == "Equals") then
          if (GetGlobal(data.Quest1FinalStage[1]) == data.Quest1FinalStage[3]) then
            Quest1Complete = -1
          else
            Quest1Complete = 1
            if (data.Quest1FinalStage[2] == "GreaterThan") then
              if (data.Quest1FinalStage[3] < GetGlobal(data.Quest1FinalStage[1])) then
                Quest1Complete = -1
              else
                Quest1Complete = 1
                Quest1Complete = 0
              end
            end
          end
        elseif (data.Quest1FinalStage[2] == "GreaterThan") then
          if (data.Quest1FinalStage[3] < GetGlobal(data.Quest1FinalStage[1])) then
            Quest1Complete = -1
          else
            Quest1Complete = 1
            Quest1Complete = 0
          end
        end
      end
    elseif (data.Quest1FinalStage[2] == "Equals") then
      if (GetGlobal(data.Quest1FinalStage[1]) == data.Quest1FinalStage[3]) then
        Quest1Complete = -1
      else
        Quest1Complete = 1
        if (data.Quest1FinalStage[2] == "GreaterThan") then
          if (data.Quest1FinalStage[3] < GetGlobal(data.Quest1FinalStage[1])) then
            Quest1Complete = -1
          else
            Quest1Complete = 1
            Quest1Complete = 0
          end
        end
      end
    elseif (data.Quest1FinalStage[2] == "GreaterThan") then
      if (data.Quest1FinalStage[3] < GetGlobal(data.Quest1FinalStage[1])) then
        Quest1Complete = -1
      else
        Quest1Complete = 1
        Quest1Complete = 0
      end
    end
  else
    Quest1Complete = 0
  end
  if (data.Quest2FinalStage[1] ~= "QuestID") then
    Print(((("QuestIconManager --- Quest2FinalStage QuestID: " .. data.Quest2FinalStage[1]) .. ", Quest2FinalStage StageID: ") .. data.Quest2FinalStage[2]))
    if (data.Quest2FinalStage[3] == 100) then
      if (Quest_CheckStatus(data.Quest2FinalStage[1], data.Quest2FinalStage[2], Quest_Completed) == true) then
        Quest2Complete = -1
      end
      Quest2Complete = 1
    elseif (data.Quest2FinalStage[2] == "LessThan") then
      if (GetGlobal(data.Quest2FinalStage[1]) < data.Quest2FinalStage[3]) then
        Quest2Complete = -1
      else
        Quest2Complete = 1
        if (data.Quest2FinalStage[2] == "Equals") then
          if (GetGlobal(data.Quest2FinalStage[1]) == data.Quest2FinalStage[3]) then
            Quest2Complete = -1
          else
            Quest2Complete = 1
            if (data.Quest2FinalStage[2] == "GreaterThan") then
              if (data.Quest2FinalStage[3] < GetGlobal(data.Quest2FinalStage[1])) then
                Quest2Complete = -1
              else
                Quest2Complete = 1
                Quest2Complete = 0
              end
            end
          end
        elseif (data.Quest2FinalStage[2] == "GreaterThan") then
          if (data.Quest2FinalStage[3] < GetGlobal(data.Quest2FinalStage[1])) then
            Quest2Complete = -1
          else
            Quest2Complete = 1
            Quest2Complete = 0
          end
        end
      end
    elseif (data.Quest2FinalStage[2] == "Equals") then
      if (GetGlobal(data.Quest2FinalStage[1]) == data.Quest2FinalStage[3]) then
        Quest2Complete = -1
      else
        Quest2Complete = 1
        if (data.Quest2FinalStage[2] == "GreaterThan") then
          if (data.Quest2FinalStage[3] < GetGlobal(data.Quest2FinalStage[1])) then
            Quest2Complete = -1
          else
            Quest2Complete = 1
            Quest2Complete = 0
          end
        end
      end
    elseif (data.Quest2FinalStage[2] == "GreaterThan") then
      if (data.Quest2FinalStage[3] < GetGlobal(data.Quest2FinalStage[1])) then
        Quest2Complete = -1
      else
        Quest2Complete = 1
        Quest2Complete = 0
      end
    end
  else
    Quest2Complete = 0
  end
  if (data.Quest3FinalStage[1] ~= "QuestID") then
    Print(((("QuestIconManager --- Quest3FinalStage QuestID: " .. data.Quest3FinalStage[1]) .. ", Quest3FinalStage StageID: ") .. data.Quest3FinalStage[2]))
    if (data.Quest3FinalStage[3] == 100) then
      if (Quest_CheckStatus(data.Quest3FinalStage[1], data.Quest3FinalStage[2], Quest_Completed) == true) then
        Quest3Complete = -1
      end
      Quest3Complete = 1
    elseif (data.Quest3FinalStage[2] == "LessThan") then
      if (GetGlobal(data.Quest3FinalStage[1]) < data.Quest3FinalStage[3]) then
        Quest3Complete = -1
      else
        Quest3Complete = 1
        if (data.Quest3FinalStage[2] == "Equals") then
          if (GetGlobal(data.Quest3FinalStage[1]) == data.Quest3FinalStage[3]) then
            Quest3Complete = -1
          else
            Quest3Complete = 1
            if (data.Quest3FinalStage[2] == "GreaterThan") then
              if (data.Quest3FinalStage[3] < GetGlobal(data.Quest3FinalStage[1])) then
                Quest3Complete = -1
              else
                Quest3Complete = 1
                Quest3Complete = 0
              end
            end
          end
        elseif (data.Quest3FinalStage[2] == "GreaterThan") then
          if (data.Quest3FinalStage[3] < GetGlobal(data.Quest3FinalStage[1])) then
            Quest3Complete = -1
          else
            Quest3Complete = 1
            Quest3Complete = 0
          end
        end
      end
    elseif (data.Quest3FinalStage[2] == "Equals") then
      if (GetGlobal(data.Quest3FinalStage[1]) == data.Quest3FinalStage[3]) then
        Quest3Complete = -1
      else
        Quest3Complete = 1
        if (data.Quest3FinalStage[2] == "GreaterThan") then
          if (data.Quest3FinalStage[3] < GetGlobal(data.Quest3FinalStage[1])) then
            Quest3Complete = -1
          else
            Quest3Complete = 1
            Quest3Complete = 0
          end
        end
      end
    elseif (data.Quest3FinalStage[2] == "GreaterThan") then
      if (data.Quest3FinalStage[3] < GetGlobal(data.Quest3FinalStage[1])) then
        Quest3Complete = -1
      else
        Quest3Complete = 1
        Quest3Complete = 0
      end
    end
  else
    Quest3Complete = 0
  end
  if (Quest1NotAvailable ~= 0) then
    if (Quest1NotAvailable == -1) then
      Print("QuestIconManager: Available__Quest1 should NOT be active! Will check remaining quests")
    elseif (Quest1Complete == -1) then
      Print("QuestIconManager: Quest1 is completed! Will check remaining quests")
    else
      Print("QuestIconManager: Quest1 should be active! Will skip everything else since we know we need the icon")
      return 
      if (Quest1Complete == -1) then
        Print("QuestIconManager: Quest1 is completed! Will check remaining quests")
      else
        Print("QuestIconManager: Quest1 should be active! Will skip everything else since we know we need the icon")
        return 
      end
    end
  else
    Print("QuestIconManager: No prerequisite set for Quest1, checking to see if it completed or defined!")
    if (Quest1Complete ~= 0) then
      if (Quest1Complete == -1) then
        Print("QuestIconManager: Quest1 is completed! Will check remaining quests")
      else
        Print("QuestIconManager: Quest1 should be active! Will skip everything else since we know we need the icon")
        return 
      end
    else
      Print("QuestIconManager: Quest1 not defined, this quest is not being tracked!")
    end
  end
  if (Quest2NotAvailable ~= 0) then
    if (Quest2NotAvailable == -1) then
      Print("QuestIconManager: Available__Quest2 should NOT be active! Will check remaining quests")
    elseif (Quest2Complete == -1) then
      Print("QuestIconManager: Quest2 is completed! Will check remaining quests")
    else
      Print("QuestIconManager: Quest2 should be active! Will skip everything else since we know we need the icon")
      return 
      if (Quest2Complete == -1) then
        Print("QuestIconManager: Quest2 is completed! Will check remaining quests")
      else
        Print("QuestIconManager: Quest2 should be active! Will skip everything else since we know we need the icon")
        return 
      end
    end
  else
    Print("QuestIconManager: No prerequisite set for Quest2, checking to see if it completed or defined!")
    if (Quest2Complete ~= 0) then
      if (Quest2Complete == -1) then
        Print("QuestIconManager: Quest2 is completed! Will check remaining quests")
      else
        Print("QuestIconManager: Quest2 should be active! Will skip everything else since we know we need the icon")
        return 
      end
    else
      Print("QuestIconManager: Quest2 not defined, this quest is not being tracked!")
    end
  end
  if (Quest3NotAvailable ~= 0) then
    if (Quest3NotAvailable == -1) then
      Print("QuestIconManager: Available__Quest3 should NOT be active! Will check remaining quests")
    elseif (Quest3Complete == -1) then
      Print("QuestIconManager: Quest3 is completed! Will check remaining quests")
    else
      Print("QuestIconManager: Quest3 should be active! Will skip everything else since we know we need the icon")
      return 
      if (Quest3Complete == -1) then
        Print("QuestIconManager: Quest3 is completed! Will check remaining quests")
      else
        Print("QuestIconManager: Quest3 should be active! Will skip everything else since we know we need the icon")
        return 
      end
    end
  else
    Print("QuestIconManager: No prerequisite set for Quest3, checking to see if it completed or defined!")
    if (Quest3Complete ~= 0) then
      if (Quest3Complete == -1) then
        Print("QuestIconManager: Quest3 is completed! Will check remaining quests")
      else
        Print("QuestIconManager: Quest3 should be active! Will skip everything else since we know we need the icon")
        return 
      end
    else
      Print("QuestIconManager: Quest3 not defined, this quest is not being tracked!")
    end
  end
  Print("QuestIconManager:__All Checks came back not defined or should_disable. disabling this npc")
  DisableAutoQuestGiver(data.QuestGiver, true)
  return 
end
Prefab_QuestIconManager_ForceDisplayIcon = function(target)
  local data = GetPrefabData(target)
  DisableAutoQuestGiver(data.QuestGiver, false)
  return 
end

