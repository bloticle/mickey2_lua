local staggerStart = 0
YS_BroomBucketPour = function(target)
  Wait(staggerStart)
  staggerStart = (staggerStart + 0.20000000298023224)
  AnimEvent(target, EVENT_Special_2)
  return 
end
YS_BroomShowWater = function(reg_0)
  return 
end
YS_BroomHideWater = function(reg_0)
  return 
end
YS_DestroyBroom = function(target)
  DestroyEntity(_self())
  return 
end
YS_Broom_StimReactAnim = function(target)
  AnimEvent(target, EVENT_Special_4)
  return 
end
YS_Broom_StimReact = function(target)
  SetShadowScale(_self(), vector4(0, 0, 0))
  ForceSpawn(_self(), 1)
  wait(0)
  DestroyEntity(_self())
  return 
end
