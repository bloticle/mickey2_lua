BWtoBWdamage = function(activator, stimulusEvent)
  local activatorWeapon = activator
  local activatorWeaponName = GetName(activatorWeapon)
  local stimulusEventAlias = StimulusEvent_SourceStimulusAlias(stimulusEvent)
  local source = GetPropertyEntity(activatorWeapon, "Parent Entity")
  local missileWeapon = GetPropertyString(activatorWeapon, "Instance Level Name")
  local BlotworxString = "Blotworx"
  local AITypeString = GetPropertyString(_self(), "AIType")
  local RangedBlotworxString = "RangedBlotworx"
  local missile1 = "Bomb"
  local missile2 = "HomingMissile"
  Print(activatorWeaponName)
  if (string.find(activatorWeaponName, RangedBlotworxString) ~= nil) then
    if (string.find(activatorWeaponName, missile1) ~= nil) then
      source = GetPropertyEntity(missileWeapon, "Parent Entity")
    end
    if (string.find(activatorWeaponName, "ExhaustAttack") == nil) then
      if (string.find(GetPropertyString(activatorWeaponName, "AIType"), RangedBlotworxString) ~= nil) then
        source = activatorWeapon
        Print(source)
        Print(GetName(source))
      end
    end
  end
  if (0 < GetHealth(_self())) then
    if (GetCurrentTeam(source) ~= GetCurrentTeam(_self())) then
      if (stimulusEventAlias == "BruiserBlotworxMeleeWeapon") then
        if (string.find(AITypeString, BlotworxString) ~= nil) then
          if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
            SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
          elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
            SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
          elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
            SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
          else
            SetHealth(_self(), 0)
            RaiseCrushedByAnvilEvent(activator, _self())
            SetHealth(_self(), 0)
            RaiseCrushedByAnvilEvent(activator, _self())
            if (stimulusEventAlias == "MeleeBlotworxMeleeWeapon") then
              if (string.find(AITypeString, BlotworxString) ~= nil) then
                if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
                  SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
                elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
                  SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
                elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
                  SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
                elseif (string.find(AITypeString, "BruiserBlotworx") == nil) then
                  SetHealth(_self(), 0)
                  RaiseCrushedByAnvilEvent(activator, _self())
                  SetHealth(_self(), 0)
                  RaiseCrushedByAnvilEvent(activator, _self())
                  if (stimulusEventAlias == "BeetleworxFodderWeapon") then
                    local BWfodderString = "BeetleworxFodder"
                    if (string.find(AITypeString, BWfodderString) ~= nil) then
                      SetHealth(_self(), 0)
                    elseif (string.find(AITypeString, BlotworxString) ~= nil) then
                      if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
                        SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
                      elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
                        SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
                      elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
                        SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
                        local currentHealth = GetHealth(_self())
                        if (GetHealth(_self()) == 1) then
                          AnimVarInt(_self(), VAR_Death_Type, 7)
                          AnimEvent(_self(), EVENT_Start_ToPuddle)
                          SetHealth(_self(), 0)
                        else
                          SetHealth(_self(), (currentHealth - 1))
                        end
                      end
                    else
                      local currentHealth = GetHealth(_self())
                      if (GetHealth(_self()) == 1) then
                        AnimVarInt(_self(), VAR_Death_Type, 7)
                        AnimEvent(_self(), EVENT_Start_ToPuddle)
                        SetHealth(_self(), 0)
                      else
                        SetHealth(_self(), (currentHealth - 1))
                      end
                    end
                  end
                end
              else
                SetHealth(_self(), 0)
                RaiseCrushedByAnvilEvent(activator, _self())
                if (stimulusEventAlias == "BeetleworxFodderWeapon") then
                  local BWfodderString = "BeetleworxFodder"
                  if (string.find(AITypeString, BWfodderString) ~= nil) then
                    SetHealth(_self(), 0)
                  elseif (string.find(AITypeString, BlotworxString) ~= nil) then
                    if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
                      SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
                    elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
                      SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
                    elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
                      SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
                      local currentHealth = GetHealth(_self())
                      if (GetHealth(_self()) == 1) then
                        AnimVarInt(_self(), VAR_Death_Type, 7)
                        AnimEvent(_self(), EVENT_Start_ToPuddle)
                        SetHealth(_self(), 0)
                      else
                        SetHealth(_self(), (currentHealth - 1))
                      end
                    end
                  else
                    local currentHealth = GetHealth(_self())
                    if (GetHealth(_self()) == 1) then
                      AnimVarInt(_self(), VAR_Death_Type, 7)
                      AnimEvent(_self(), EVENT_Start_ToPuddle)
                      SetHealth(_self(), 0)
                    else
                      SetHealth(_self(), (currentHealth - 1))
                    end
                  end
                end
              end
            end
            if (stimulusEventAlias == "BeetleworxFodderWeapon") then
              local BWfodderString = "BeetleworxFodder"
              if (string.find(AITypeString, BWfodderString) ~= nil) then
                SetHealth(_self(), 0)
              elseif (string.find(AITypeString, BlotworxString) ~= nil) then
                if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
                  SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
                elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
                  SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
                elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
                  SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
                  local currentHealth = GetHealth(_self())
                  if (GetHealth(_self()) == 1) then
                    AnimVarInt(_self(), VAR_Death_Type, 7)
                    AnimEvent(_self(), EVENT_Start_ToPuddle)
                    SetHealth(_self(), 0)
                  else
                    SetHealth(_self(), (currentHealth - 1))
                  end
                end
              else
                local currentHealth = GetHealth(_self())
                if (GetHealth(_self()) == 1) then
                  AnimVarInt(_self(), VAR_Death_Type, 7)
                  AnimEvent(_self(), EVENT_Start_ToPuddle)
                  SetHealth(_self(), 0)
                else
                  SetHealth(_self(), (currentHealth - 1))
                end
              end
            end
          end
        else
          SetHealth(_self(), 0)
          RaiseCrushedByAnvilEvent(activator, _self())
          if (stimulusEventAlias == "MeleeBlotworxMeleeWeapon") then
            if (string.find(AITypeString, BlotworxString) ~= nil) then
              if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
                SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
              elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
                SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
              elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
                SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
              elseif (string.find(AITypeString, "BruiserBlotworx") == nil) then
                SetHealth(_self(), 0)
                RaiseCrushedByAnvilEvent(activator, _self())
                SetHealth(_self(), 0)
                RaiseCrushedByAnvilEvent(activator, _self())
                if (stimulusEventAlias == "BeetleworxFodderWeapon") then
                  local BWfodderString = "BeetleworxFodder"
                  if (string.find(AITypeString, BWfodderString) ~= nil) then
                    SetHealth(_self(), 0)
                  elseif (string.find(AITypeString, BlotworxString) ~= nil) then
                    if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
                      SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
                    elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
                      SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
                    elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
                      SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
                      local currentHealth = GetHealth(_self())
                      if (GetHealth(_self()) == 1) then
                        AnimVarInt(_self(), VAR_Death_Type, 7)
                        AnimEvent(_self(), EVENT_Start_ToPuddle)
                        SetHealth(_self(), 0)
                      else
                        SetHealth(_self(), (currentHealth - 1))
                      end
                    end
                  else
                    local currentHealth = GetHealth(_self())
                    if (GetHealth(_self()) == 1) then
                      AnimVarInt(_self(), VAR_Death_Type, 7)
                      AnimEvent(_self(), EVENT_Start_ToPuddle)
                      SetHealth(_self(), 0)
                    else
                      SetHealth(_self(), (currentHealth - 1))
                    end
                  end
                end
              end
            else
              SetHealth(_self(), 0)
              RaiseCrushedByAnvilEvent(activator, _self())
              if (stimulusEventAlias == "BeetleworxFodderWeapon") then
                local BWfodderString = "BeetleworxFodder"
                if (string.find(AITypeString, BWfodderString) ~= nil) then
                  SetHealth(_self(), 0)
                elseif (string.find(AITypeString, BlotworxString) ~= nil) then
                  if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
                    SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
                  elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
                    SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
                  elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
                    SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
                    local currentHealth = GetHealth(_self())
                    if (GetHealth(_self()) == 1) then
                      AnimVarInt(_self(), VAR_Death_Type, 7)
                      AnimEvent(_self(), EVENT_Start_ToPuddle)
                      SetHealth(_self(), 0)
                    else
                      SetHealth(_self(), (currentHealth - 1))
                    end
                  end
                else
                  local currentHealth = GetHealth(_self())
                  if (GetHealth(_self()) == 1) then
                    AnimVarInt(_self(), VAR_Death_Type, 7)
                    AnimEvent(_self(), EVENT_Start_ToPuddle)
                    SetHealth(_self(), 0)
                  else
                    SetHealth(_self(), (currentHealth - 1))
                  end
                end
              end
            end
          end
          if (stimulusEventAlias == "BeetleworxFodderWeapon") then
            local BWfodderString = "BeetleworxFodder"
            if (string.find(AITypeString, BWfodderString) ~= nil) then
              SetHealth(_self(), 0)
            elseif (string.find(AITypeString, BlotworxString) ~= nil) then
              if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
                SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
              elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
                SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
              elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
                SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
                local currentHealth = GetHealth(_self())
                if (GetHealth(_self()) == 1) then
                  AnimVarInt(_self(), VAR_Death_Type, 7)
                  AnimEvent(_self(), EVENT_Start_ToPuddle)
                  SetHealth(_self(), 0)
                else
                  SetHealth(_self(), (currentHealth - 1))
                end
              end
            else
              local currentHealth = GetHealth(_self())
              if (GetHealth(_self()) == 1) then
                AnimVarInt(_self(), VAR_Death_Type, 7)
                AnimEvent(_self(), EVENT_Start_ToPuddle)
                SetHealth(_self(), 0)
              else
                SetHealth(_self(), (currentHealth - 1))
              end
            end
          end
        end
      end
      if (stimulusEventAlias == "MeleeBlotworxMeleeWeapon") then
        if (string.find(AITypeString, BlotworxString) ~= nil) then
          if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
            SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
          elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
            SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
          elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
            SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
          elseif (string.find(AITypeString, "BruiserBlotworx") == nil) then
            SetHealth(_self(), 0)
            RaiseCrushedByAnvilEvent(activator, _self())
            SetHealth(_self(), 0)
            RaiseCrushedByAnvilEvent(activator, _self())
            if (stimulusEventAlias == "BeetleworxFodderWeapon") then
              local BWfodderString = "BeetleworxFodder"
              if (string.find(AITypeString, BWfodderString) ~= nil) then
                SetHealth(_self(), 0)
              elseif (string.find(AITypeString, BlotworxString) ~= nil) then
                if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
                  SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
                elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
                  SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
                elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
                  SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
                  local currentHealth = GetHealth(_self())
                  if (GetHealth(_self()) == 1) then
                    AnimVarInt(_self(), VAR_Death_Type, 7)
                    AnimEvent(_self(), EVENT_Start_ToPuddle)
                    SetHealth(_self(), 0)
                  else
                    SetHealth(_self(), (currentHealth - 1))
                  end
                end
              else
                local currentHealth = GetHealth(_self())
                if (GetHealth(_self()) == 1) then
                  AnimVarInt(_self(), VAR_Death_Type, 7)
                  AnimEvent(_self(), EVENT_Start_ToPuddle)
                  SetHealth(_self(), 0)
                else
                  SetHealth(_self(), (currentHealth - 1))
                end
              end
            end
          end
        else
          SetHealth(_self(), 0)
          RaiseCrushedByAnvilEvent(activator, _self())
          if (stimulusEventAlias == "BeetleworxFodderWeapon") then
            local BWfodderString = "BeetleworxFodder"
            if (string.find(AITypeString, BWfodderString) ~= nil) then
              SetHealth(_self(), 0)
            elseif (string.find(AITypeString, BlotworxString) ~= nil) then
              if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
                SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
              elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
                SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
              elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
                SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
                local currentHealth = GetHealth(_self())
                if (GetHealth(_self()) == 1) then
                  AnimVarInt(_self(), VAR_Death_Type, 7)
                  AnimEvent(_self(), EVENT_Start_ToPuddle)
                  SetHealth(_self(), 0)
                else
                  SetHealth(_self(), (currentHealth - 1))
                end
              end
            else
              local currentHealth = GetHealth(_self())
              if (GetHealth(_self()) == 1) then
                AnimVarInt(_self(), VAR_Death_Type, 7)
                AnimEvent(_self(), EVENT_Start_ToPuddle)
                SetHealth(_self(), 0)
              else
                SetHealth(_self(), (currentHealth - 1))
              end
            end
          end
        end
      end
      if (stimulusEventAlias == "BeetleworxFodderWeapon") then
        local BWfodderString = "BeetleworxFodder"
        if (string.find(AITypeString, BWfodderString) ~= nil) then
          SetHealth(_self(), 0)
        elseif (string.find(AITypeString, BlotworxString) ~= nil) then
          if IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask")) then
            SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxLowerMask"), 0)
          elseif IsValidHandle(GetChildEntityByName(_self(), "BruiserBlotworxMask")) then
            SetHealth(GetChildEntityByName(_self(), "BruiserBlotworxMask"), 0)
          elseif IsValidHandle(GetChildEntityByName(_self(), "RangedBlotworxMask")) then
            SetHealth(GetChildEntityByName(_self(), "RangedBlotworxMask"), 0)
            local currentHealth = GetHealth(_self())
            if (GetHealth(_self()) == 1) then
              AnimVarInt(_self(), VAR_Death_Type, 7)
              AnimEvent(_self(), EVENT_Start_ToPuddle)
              SetHealth(_self(), 0)
            else
              SetHealth(_self(), (currentHealth - 1))
            end
          end
        else
          local currentHealth = GetHealth(_self())
          if (GetHealth(_self()) == 1) then
            AnimVarInt(_self(), VAR_Death_Type, 7)
            AnimEvent(_self(), EVENT_Start_ToPuddle)
            SetHealth(_self(), 0)
          else
            SetHealth(_self(), (currentHealth - 1))
          end
        end
      end
    end
  end
  return 
end
Blotworx_SaveOffSpawner = function(activator)
  local temp = GetName(activator)
  Print(("Spawner = " .. temp))
  SetPropertyString(_self(), "Instance Level Name", GetName(activator))
  return 
end

