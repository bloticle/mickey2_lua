InkWellLevelName = ""
InkWellPosition = 0
InkWellFacing = 0
CurrentETickets = 0
CurrentHealth = 0
CurrentLives = 0
CurrentPaint = 0
CurrentThinner = 0
SetCurrentInventory = function()
  local target = GetPlayer()
  CurrentPaint = GetPropertyFloat(target, "Paint", 0)
  CurrentThinner = GetPropertyFloat(target, "Thinner", 0)
  CurrentETickets = GetPropertyFloat(target, "ETicket", 0)
  CurrentHealth = GetPropertyInt(target, "Health", 0)
  CurrentLives = GetPropertyInt(target, "Lives", 0)
  return 
end
SetCurrentInkWell = function(target, levelName)
  InkWellPosition = GetPosition(target)
  InkWellFacing = GetFacing(target)
  InkWellLevelName = levelName
  return 
end
SaveInkWell = function(target, levelName)
  SetCurrentInventory()
  SetCurrentInkWell(target, levelName)
  return 
end
RestoreToLastInkWell = function(target)
  if (InkWellLevelName == "") then
    Print("No InkWell saved")
  else
    SetHealth(target, CurrentHealth)
    SetLives(target, CurrentLives)
    SetItemCount(target, "ETicket", CurrentETickets)
    SetItemCount(target, "Thinner", CurrentThinner)
    SetItemCount(target, "Paint", CurrentPaint)
    LoadLevel(target, InkWellLevelName)
    SetTransformation(target, InkWellPosition, InkWellFacing)
  end
  if (GusThinnerRising == true) then
    Reverse("S3_sw_ZoneZ_static_Scenario6_Thinner 01")
    SetSplineFollowerInitialSpeed("S3_sw_ZoneZ_static_Scenario6_Thinner 01", 100)
    wait(1)
    Display("S3_sw_ZoneZ_static_Scenario6_Thinner 01", "The thinner is rising! Get out of here!", 3)
    wait(2)
    SetSplineFollowerInitialSpeed("S3_sw_ZoneZ_static_Scenario6_Thinner 01", 0.3499999940395355)
    wait(0.10000000149011612)
    Reverse("S3_sw_ZoneZ_static_Scenario6_Thinner 01")
  end
  return 
end
