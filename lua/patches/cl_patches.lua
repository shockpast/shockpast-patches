do
  local tag = "patches:client[shootpos_fix]"

  hook.Add("SetupMove", tag, function(self)
    if self:IsBot() or self:Health() <= 0 then return end

    self.m_RealShootPos = self:GetShootPos()
  end)

  hook.Add("EntityFireBullets", tag, function(self, data)
    if not self:IsPlayer() or self:IsBot() or self:Health() <= 0 then return end

    local src = self:GetShootPos()

    if data.Src == src then
      data.Src = self.m_RealShootPos or src

      return true
    end
  end)
end

do
  local tag = "patches:client[focus_attack_fix]"
  local lastUnFocusedTime = 0

  hook.Add("CreateMove", tag, function(cmd)
    if CurTime() - lastUnFocusedTime < 0.25 then
      cmd:RemoveKey(IN_ATTACK)
      cmd:RemoveKey(IN_ATTACK2)
    end

    if system.HasFocus() then return end

    lastUnFocusedTime = CurTime()
  end)
end