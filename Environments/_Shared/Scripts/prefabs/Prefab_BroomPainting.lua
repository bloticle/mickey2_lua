Prefab_PaintingSetup = function(target)
  local data = GetPrefabData(target)
  if (data.StartPainted == "false") then
    ForceSketched(GetRelativePrefabEntity(target, ".ToonPainting"))
  else
    local (for index), (for limit), (for step) = 1, 0, -0.019999999552965164
    for i = (for index), (for limit), (for step) do
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
      local (for index), (for limit), (for step) = 0, 1, 0.019999999552965164
      for i = (for index), (for limit), (for step) do
        SetR3MTColorRegOnSubGraph(GetRelativePrefabEntity(target, ".PaintingSpout"), "Water_Main", 1, vector4(1, 1, 1, i))
        SetR3MTColorRegOnSubGraph(GetRelativePrefabEntity(target, ".PaintingSpout"), "Water_Top", 1, vector4(1, 1, 1, i))
        wait(0.009999999776482582)
      end
      StartEmitters(GetRelativePrefabEntity(target, ".PaintingSplash"))
    end
  else
    StopEmitters(GetRelativePrefabEntity(target, ".PaintingSplash"))
    local (for index), (for limit), (for step) = 1, 0, -0.019999999552965164
    for i = (for index), (for limit), (for step) do
      (for index) = SetR3MTColorRegOnSubGraph
      (for limit) = GetRelativePrefabEntity
      (for step) = target
      i = ".PaintingSpout"
      (for limit) = (for limit)((for step), i)
      (for step) = "Water_Main"
      i = 1
      (for index)((for limit), (for step), i, vector4(1, 1, 1, i))
      (for index) = SetR3MTColorRegOnSubGraph
      (for limit) = GetRelativePrefabEntity
      (for step) = target
      i = ".PaintingSpout"
      (for limit) = (for limit)((for step), i)
      (for step) = "Water_Top"
      i = 1
      (for index)((for limit), (for step), i, vector4(1, 1, 1, i))
      (for index) = wait
      (for limit) = 0.009999999776482582
      (for index)((for limit))
    end
  end
  return 
end
