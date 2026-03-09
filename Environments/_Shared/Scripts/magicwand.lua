DisableSketchTarget = function(myself)
  myself = _self()
  Print("myself  ", myself)
  local targetEntity = GetAutoTarget_Player()
  if IsValidHandle(targetEntity) then
    Disable(targetEntity)
    Print("DisableSketchTarget ", targetEntity)
    local entity_data = global_entity_data_table[myself]
    if (entity_data == nil) then
      global_entity_data_table[myself] = {}
      entity_data = global_entity_data_table[myself]
    end
    entity_data.Target = targetEntity
  end
  return 
end
EnableSketchTarget = function(myself)
  myself = _self()
  local entity_data = global_entity_data_table[myself]
  if (entity_data == nil) then
    global_entity_data_table[myself] = {}
    entity_data = global_entity_data_table[myself]
  end
  local targetEntity = entity_data.Target
  entity_data.Target = nil
  if IsValidHandle(targetEntity) then
    Print("EnableSketchTarget ", targetEntity)
    Enable(targetEntity)
  end
  return 
end
