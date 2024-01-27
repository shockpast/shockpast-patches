do
  local tag = "patches:server[pod_performance]"

  hook.Add("OnEntityCreated", tag, function(ent)
    if ent:GetClass() == "prop_vehicle_prisoner_pod" then
      return ent:AddEFlags(EFL_NO_THINK_FUNCTION)
    end
  end)

  hook.Add("PlayerLeaveVehicle", tag, function(_, ent)
    if ent:GetClass() == "prop_vehicle_prisoner_pod" then
      hook.Add("Think", ent, function()
        hook.Remove("Think", ent)

        if ent:GetInternalVariable("m_bEnterAnimOn") or ent:GetInternalVariable("m_bExitAnimOn") then
          return
        end

        return ent:AddEFlags(EFL_NO_THINK_FUNCTION)
      end)
    end
  end)

  hook.Add("PlayerEnteredVehicle", tag, function(_, ent)
    if ent:GetClass() == "prop_vehicle_prisoner_pod" then
      ent:RemoveEFlags(EFL_NO_THINK_FUNCTION)

      return hook.Remove("Think", ent)
    end
  end)

  hook.Add("EntityTakeDamage", tag, function(ent, info)
    if ent:GetClass() ~= "prop_vehicle_prisoner_pod" or ent.AcceptDamageForce then
      return
    end

    return ent:TakePhysicsDamage(ent, info)
  end)
end

do
  local tag = "patches:server[spawn_sound]"

  hook.Add("EntityEmitSound", tag, function(soundData)
    if soundData["OriginalSoundName"] ~= "Player.DrownStart" then return end

    local ply = soundData.Entity
    if not ply:IsPlayer() then return end

    if ply:GetInternalVariable("m_AirFinished") < 0.1 then
      return false
    end
  end)
end

SPatches.Log("sPatches blessed this server.")