Prefab_Nozzle_AlwaysSetup = function(target)
  Print("__Function: Prefab_Nozzle_AlwaysSetup")
  return 
end
Prefab_Nozzle_Stimmed = function(target, _Stim)
  Print(("__Function: Prefab_Nozzle_Stimmed, _Stim: " .. tostring(_Stim)))
  local data = GetPrefabData(target)
  if (data.StimResponse == "None") then
    Print("__This Nozzle is disabled!")
    return 
  end
  if (data.NozzleState == 0) then
    data.NozzleState = 1
    if (_Stim == "Paint") then
      Print("__Nozzle stimmed with paint")
      if (data.StimResponse == "Paint") then
        AnimGBReset(target)
        AnimGBSequence(target, "react")
        if (data.StimFunction[1] ~= "None") then
          FireThread(_G[data.StimFunction[1]], target)
        else
          Print("__No Paint Stim Function Specified, change StimFunction[1] to something besides none if you want a function to fire!")
          Print("__StimResponse Override set to Thinner or string is invalid, if you want this to respond to Thinner make sure it's either Painted or Both!")
          if (_Stim == "Thinner") then
            Print("__Nozzle stimmed with thinner")
            if (data.StimResponse == "Thinner") then
              AnimGBReset(target)
              AnimGBSequence(target, "react")
              if (data.StimFunction[2] ~= "None") then
                FireThread(_G[data.StimFunction[2]], target)
              else
                Print("__No Thinner Stim Function Specified, change StimFunction[2] to something besides none if you want a function to fire!")
                Print("__StimResponse Override set to Paint or string is invalid, if you want this to respond to Thinner make sure it's either Thinner or Both!")
              end
            end
            Print("__StimResponse Override set to Paint or string is invalid, if you want this to respond to Thinner make sure it's either Thinner or Both!")
          end
        end
      end
      Print("__StimResponse Override set to Thinner or string is invalid, if you want this to respond to Thinner make sure it's either Painted or Both!")
    elseif (_Stim == "Thinner") then
      Print("__Nozzle stimmed with thinner")
      if (data.StimResponse == "Thinner") then
        AnimGBReset(target)
        AnimGBSequence(target, "react")
        if (data.StimFunction[2] ~= "None") then
          FireThread(_G[data.StimFunction[2]], target)
        else
          Print("__No Thinner Stim Function Specified, change StimFunction[2] to something besides none if you want a function to fire!")
          Print("__StimResponse Override set to Paint or string is invalid, if you want this to respond to Thinner make sure it's either Thinner or Both!")
        end
      end
      Print("__StimResponse Override set to Paint or string is invalid, if you want this to respond to Thinner make sure it's either Thinner or Both!")
    end
    wait(0.5)
    data.NozzleState = 0
  end
  return 
end
