TurnOnStrictGlobalVariableChecks = function()
  Print(BuildConfig(), "Strict.lua will run.")
  local mt = getmetatable(_G)
  if (mt == nil) then
    mt = {}
    setmetatable(_G, mt)
  end
  mt.__declared = {}
  local what = function()
    local d = debug.getinfo(3, "S")
    if (not d) then
    end
    return 3
  end
  mt.__newindex = function(t, n, v)
    if (not mt.__declared[n]) then
      local w = what()
      if (w ~= "main") then
        if (w ~= "C") then
          error((("assign to undeclared variable '" .. n) .. "'"), 2)
        end
      end
      mt.__declared[n] = true
    end
    rawset(t, n, v)
    return 
  end
  mt.__index = function(t, n)
    if (not mt.__declared[n]) then
      if (what() ~= "C") then
        error((("variable '" .. n) .. "' is not declared"), 2)
      end
    end
    return rawget(t, n)
  end
  return 
end
if (BuildConfig() ~= "FINAL") then
  TurnOnStrictGlobalVariableChecks()
end
