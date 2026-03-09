gsXy_DropHammer = function(target, hammer)
  hammer = tonumber(hammer)
  local data = GetPrefabData(target)
  if (data.HammerDown[hammer] == 0) then
    data.HammerDown[hammer] = 1
    if (_activator() == GetOswaldAI()) then
      Print("OswaldAI hit xylophone, giving him an extra .2 sec")
      wait(0.699999988079071)
    else
      wait(0.699999988079071)
    end
    FireUser1(target)
    StartRotateToPosition(target, -85)
    AudioPostEventOn(target, "Play_sfx_dec_mallet_beater_drop_single")
    wait(7)
    StartRotateToPosition(target, 0)
    wait(0.5)
    data.HammerDown[hammer] = 0
  end
  return 
end
gsXy_StartUp_Xylophone_ver02 = function(target)
  local data = GetPrefabData(target)
  StartRotateToPosition(target, 0)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".hammer02"), 0)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".hammer03"), 0)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".hammer04"), 0)
  StartRotateToPosition(GetRelativePrefabEntity(target, ".hammer05"), 0)
  return 
end
