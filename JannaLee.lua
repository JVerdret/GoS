if GetObjectName(GetMyHero()) ~= "Janna" then return end

--[[if FileExist(COMMON_PATH.."MixLib.lua") then
	require('MixLib')
else
PrintChat("MixLib not found. Please wait for download.")
	DownloadFileAsync("https://raw.githubusercontent.com/VTNEETS/NEET-Scripts/master/MixLib.lua", COMMON_PATH.."MixLib.lua",function() 
	require('MixLib')
	end)
end]]--
local version = 1
local qrange1 = 850
local qrange2 = 1743
local qrange3 = 120
local wrange = 600
local erange = 800
local rrange = 875 
local rrange = 725
local mode = nil

menu = Menu("Janna Lee", "Jenna Lee")
menu:SubMenu("c", "Combo")
menu.c:Boolean("cqu", "Use Q ?", true)
menu.c:Boolean("cwu", "Use W ?", true)
menu.c:Boolean("ceu", "Use E ?", true)
menu.c:Boolean("cru", "Use R ?", true)
OnTick(function()
	if not IsDead(myHero) then
		--mode = Mix:Mode()
		local unit = GetCurrentTarget()
	end
end)

PrintChat("Janna Lee loaded")