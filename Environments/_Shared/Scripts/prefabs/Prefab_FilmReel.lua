SetReel = function(target)
  wait(1)
  local data = GetPrefabData(target)
  Print("Film Reel: Checking to destroy film reel")
  if HasCollectible(data.CollectibleName) then
    Print("Film Reel: Destroying Film Reel")
    DestroyEntity(target)
  end
  if (data.CollectibleName == "None") then
    Print("You forgot to change your collectible name in the master prefab object")
  end
  return 
end
SetCollectiblePickup = function(target)
  local data = GetPrefabData(target)
  if (data.CollectibleType == "Unlock") then
    Print(("**************This is a " .. data.CollectibleType))
    if (data.GlobalToSave == "none") then
      Print("__No GlobalToSaveSpecified! your collectible probably isnt going to persist correctly!")
    elseif (data.CollectibleType == "Quest") then
      if (GetGlobal(data.GlobalToSave) == 1) then
        Print((("**************have gotten " .. data.CollectibleType) .. " item, removing from world"))
        DestroyEntity(GetRelativePrefabEntity(target, ".CollectibleEffect"))
        DestroyEntity(target)
      end
    elseif (GetGlobal(data.GlobalToSave) == 1) then
      Print((("**************have gotten " .. data.CollectibleType) .. " item, removing from world"))
      DestroyEntity(GetRelativePrefabEntity(target, ".CollectibleEffect"))
      DestroyEntity(target)
      if (data.CollectibleType == "Pin") then
        Print("**************This is a Pin")
        if HasCollectible(data.CollectibleName) then
          Print("**************Hiding Pin")
          Hide(GetRelativePrefabEntity(target, ".Pin"))
        end
      elseif (data.CollectibleType == "ConceptArt") then
        Print("++++++++++++++ This is Concept Art!")
        if HasCollectible(data.CollectibleName) then
          Print("++++++++++++++++++++ Concept Art already collected.  Destroying it.")
          DestroyEntity(GetRelativePrefabEntity(target, ".CollectibleEffect"))
          DestroyEntity(target)
        end
      end
    end
  end
  if (data.CollectibleType == "Pin") then
    Print("**************This is a Pin")
    if HasCollectible(data.CollectibleName) then
      Print("**************Hiding Pin")
      Hide(GetRelativePrefabEntity(target, ".Pin"))
    end
  elseif (data.CollectibleType == "ConceptArt") then
    Print("++++++++++++++ This is Concept Art!")
    if HasCollectible(data.CollectibleName) then
      Print("++++++++++++++++++++ Concept Art already collected.  Destroying it.")
      DestroyEntity(GetRelativePrefabEntity(target, ".CollectibleEffect"))
      DestroyEntity(target)
    end
  end
  return 
end
CollectReel = function(target)
  Print("*******************Collecting Film")
  local data = GetPrefabData(target)
  Print(data.CollectibleName)
  if HasCollectible(data.CollectibleName) then
    Print("*************alreadyhasdontgive")
    return 
  end
  SetGlobal("FR_TotalReels", (GetGlobal("FR_TotalReels") + 1))
  Print(GetGlobal("FR_TotalReels"))
  GiveCollectible(data.CollectibleName)
  GiveCollectibleNoPopup("Challenge_FilmBuff_Tracker")
  Print(GetCurrentCount("Challenge_FilmBuff_Tracker"))
  return 
end
SteamboatFilm = function()
  GiveCollectible("FR_Steamboat01")
  return 
end
ObtainCollectible = function(target)
  local data = GetPrefabData(target)
  if (data.CollectibleType == "Pin") then
    if (not HasCollectible(data.CollectibleName)) then
      Print("***********************Giving a collectible pin")
      GiveCollectible(data.Collectible)
      if (data.GlobalToSave == "none") then
        Print("__No GlobalToSaveSpecified! your collectible probably isnt going to save.")
      else
        SetGlobal(data.GlobalToSave, 1)
      end
      if (data.Collectible == "Bronze_Pin") then
        GiveCurrencyItem("Bronze_Pin", 1)
      elseif (data.Collectible == "Silver_Pin") then
        GiveCurrencyItem("Silver_Pin", 1)
      else
        GiveCurrencyItem("Gold_Pin", 1)
        if (data.CollectibleType == "ConceptArt") then
          Print("************** giving Concept Art")
          GiveCollectible(data.CollectibleName)
        elseif (data.CollectibleType == "Quest") then
          Print("**************giving a collectable")
          GiveCollectible(data.CollectibleName)
          if (data.GlobalToSave == "none") then
            Print("__No GlobalToSaveSpecified! your collectible probably isnt going to persist correctly!")
          else
            SetGlobal(data.GlobalToSave, 1)
            if (data.CollectibleType == "Unlock") then
              Print("**************giving a unlock")
              GiveCollectible(data.CollectibleName)
              if (data.GlobalToSave == "none") then
                Print("__No GlobalToSaveSpecified! your collectible probably isnt going to persist correctly!")
              else
                SetGlobal(data.GlobalToSave, 1)
              end
            end
          end
        elseif (data.CollectibleType == "Unlock") then
          Print("**************giving a unlock")
          GiveCollectible(data.CollectibleName)
          if (data.GlobalToSave == "none") then
            Print("__No GlobalToSaveSpecified! your collectible probably isnt going to persist correctly!")
          else
            SetGlobal(data.GlobalToSave, 1)
          end
        end
      end
    end
  elseif (data.CollectibleType == "ConceptArt") then
    Print("************** giving Concept Art")
    GiveCollectible(data.CollectibleName)
  elseif (data.CollectibleType == "Quest") then
    Print("**************giving a collectable")
    GiveCollectible(data.CollectibleName)
    if (data.GlobalToSave == "none") then
      Print("__No GlobalToSaveSpecified! your collectible probably isnt going to persist correctly!")
    else
      SetGlobal(data.GlobalToSave, 1)
      if (data.CollectibleType == "Unlock") then
        Print("**************giving a unlock")
        GiveCollectible(data.CollectibleName)
        if (data.GlobalToSave == "none") then
          Print("__No GlobalToSaveSpecified! your collectible probably isnt going to persist correctly!")
        else
          SetGlobal(data.GlobalToSave, 1)
        end
      end
    end
  elseif (data.CollectibleType == "Unlock") then
    Print("**************giving a unlock")
    GiveCollectible(data.CollectibleName)
    if (data.GlobalToSave == "none") then
      Print("__No GlobalToSaveSpecified! your collectible probably isnt going to persist correctly!")
    else
      SetGlobal(data.GlobalToSave, 1)
    end
  end
  DestroyEntity(GetRelativePrefabEntity(target, ".CollectibleEffect"))
  if (data.EndFunction ~= "none") then
    Print("*********************** Mickey_Open_Chest(): data.EndFunction != none")
    FireThread(_G[data.EndFunction])
  end
  return 
end
