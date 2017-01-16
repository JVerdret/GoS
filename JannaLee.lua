if GetObjectName(GetMyHero()) ~= "Janna" then return end
require 'OpenPredict'
if FileExist(COMMON_PATH.."MixLib.lua") then
	require('MixLib')
else
PrintChat("MixLib not found. Please wait for download.")
DownloadFileAsync("https://raw.githubusercontent.com/VTNEETS/NEET-Scripts/master/MixLib.lua", COMMON_PATH.."MixLib.lua",function() 
	require('MixLib')
	end)
end
local version = 1
local qrange1 = 850
local qrange2 = 1743
local qrange3 = 120
local wrange = 600
local erange = 800
local rrange = 875 
local rrange = 725
local mode = nil
local jaq = {delay = 0.1, speed = 625, width = 100, range = qrange1}

menu = Menu("Janna Lee", "Janna Lee")
menu:SubMenu("c", "Combo")
menu.c:Boolean("cqu", "Use Q ?", true)
menu.c:Boolean("cwu", "Use W ?", true)
menu.c:Boolean("ceu", "Use E ?", true)
menu.c:Boolean("cru", "Use R ?", true)
OnTick(function()
	if not IsDead(myHero) then
		mode = Mix:Mode()
		local unit = GetCurrentTarget()
		if mode == "Combo" then 
			nsph(unit)
			ntb(unit)
		end
	end
end)

function nsph(unit)
	if menu.c.cqu:Value() and Ready(_Q) and ValidTarget(unit, qrange1) then 
		local qpred = GetPrediction(unit, jaq)
		if qpred and qpred.hitChance >= 0.9 then
			CastSkillShot(_Q, qpred.castPos)
		end
	end
end

function ntb(unit)
	if menu.c.cwu:Value() and Ready(_W) and ValidTarget(unit, wrange) then 
		CastTargetSpell(unit, _W)
	end
end

PrintChat("Janna Lee loaded")