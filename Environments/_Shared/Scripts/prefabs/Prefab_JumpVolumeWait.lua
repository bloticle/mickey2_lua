resumeJumpVolumeWait = function(target)
  local data = GetPrefabData(target)
  if (data.gsaName == "Environments/_Design/MapZone/YourMapName.gsa") then
    print("**ERROR: JumpVolumeWait prefab data override for 'gsaName' not set**")
  end
  if (data.userEdgeID == "CustomUserEdgeName") then
    print("**ERROR: JumpVolumeWait prefab data override for 'userEdgeID' not set**")
  end
  SetUserEdgeWaiting(data.gsaName, data.userEdgeID, false)
  return 
end
pauseJumpVolumeWait = function(target)
  local data = GetPrefabData(target)
  if (data.gsaName == "Environments/_Design/MapZone/YourMapName.gsa") then
    print("**ERROR: JumpVolumeWait prefab data override for 'gsaName' not set**")
  end
  if (data.userEdgeID == "CustomUserEdgeName") then
    print("**ERROR: JumpVolumeWait prefab data override for 'userEdgeID' not set**")
  end
  SetUserEdgeWaiting(data.gsaName, data.userEdgeID, true)
  return 
end
enableJumpVolumeAvailability = function(target)
  local data = GetPrefabData(target)
  if (data.gsaName == "Environments/_Design/MapZone/YourMapName.gsa") then
    print("**ERROR: JumpVolumeWait prefab data override for 'gsaName' not set**")
  end
  if (data.userEdgeID == "CustomUserEdgeName") then
    print("**ERROR: JumpVolumeWait prefab data override for 'userEdgeID' not set**")
  end
  SetUserEdgeDisabled(data.gsaName, data.userEdgeID, false)
  return 
end
disableJumpVolumeAvailability = function(target)
  local data = GetPrefabData(target)
  if (data.gsaName == "Environments/_Design/MapZone/YourMapName.gsa") then
    print("**ERROR: JumpVolumeWait prefab data override for 'gsaName' not set**")
  end
  if (data.userEdgeID == "CustomUserEdgeName") then
    print("**ERROR: JumpVolumeWait prefab data override for 'userEdgeID' not set**")
  end
  SetUserEdgeDisabled(data.gsaName, data.userEdgeID, true)
  return 
end

