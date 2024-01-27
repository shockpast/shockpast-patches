SPatches = SPatches or {}

local color_cornflower = Color(84, 109, 229)
local color_gray = Color(210, 218, 226)

function SPatches.Log(...)
  MsgC(color_cornflower, "[#] ", color_gray, ..., "\n")
end

if SERVER then
  AddCSLuaFile("patches/sh_patches.lua")
  AddCSLuaFile("patches/cl_patches.lua")

  include("patches/sh_patches.lua")
  include("patches/cl_patches.lua")
  include("patches/sv_patches.lua")
end

if CLIENT then
  include("patches/sh_patches.lua")
  include("patches/cl_patches.lua")
end