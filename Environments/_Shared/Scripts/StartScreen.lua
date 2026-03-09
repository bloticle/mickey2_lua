PreStartScreenAction = function(self)
  StartFadeOut(0)
  ResetAbilityDisabled(GetPlayer())
  ResetAbilityDisabled(GetPlayer2OrAI())
  EnablePlayer(PLAYER_TWO, false)
  return 
end
