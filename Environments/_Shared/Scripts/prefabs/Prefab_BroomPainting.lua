Prefab_PaintingSetup = function(target)
  local data = GetPrefabData(target)
  if (data.StartPainted == "false") then
    ForceSketched(GetRelativePrefabEntity(target, ".ToonPainting"))
  else
    for i = 1, 0, -0.019999999552965164 do
      SetR3MTColorRegOnSubGraph(GetRelativePrefabEntity(target, ".PaintingSpout"), "Water_Main", 1, vector4(1, 1, 1, i))
      SetR3MTColorRegOnSubGraph(GetRelativePrefabEntity(target, ".PaintingSpout"), "Water_Top", 1, vector4(1, 1, 1, i))
      wait(0.009999999776482582)
    end
  end
  return 
end
Prefab_PaintingThinned = function(target, state)
  local data = GetPrefabData(target)
  if (state == "thin") then
    if (GetGlobal("YSL_WaterSecretFound") == 0) then
      for i = 0, 1, 0.019999999552965164 do
        SetR3MTColorRegOnSubGraph(GetRelativePrefabEntity(target, ".PaintingSpout"), "Water_Main", 1, vector4(1, 1, 1, i))
        SetR3MTColorRegOnSubGraph(GetRelativePrefabEntity(target, ".PaintingSpout"), "Water_Top", 1, vector4(1, 1, 1, i))
        wait(0.009999999776482582)
      end
      StartEmitters(GetRelativePrefabEntity(target, ".PaintingSplash"))
    end
  else
    StopEmitters(GetRelativePrefabEntity(target, ".PaintingSplash"))
    for i = 1, 0, -0.019999999552965164 do
      i = ".PaintingSpout"
      i = 1
      SetR3MTColorRegOnSubGraph(GetRelativePrefabEntity(target, i), "Water_Main", i, vector4(1, 1, 1, i))
      i = ".PaintingSpout"
      i = 1
      SetR3MTColorRegOnSubGraph(GetRelativePrefabEntity(target, i), "Water_Top", i, vector4(1, 1, 1, i))
      wait(0.009999999776482582)
    end
  end
  return 
end

