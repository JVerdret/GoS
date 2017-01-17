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
local move = {delay = 0.5, speed = math.huge, width = 50, range = math.huge}
local autolevel = {[1] = {_Q, _W, _E, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _Q, _Q, _R}}

menu = Menu("Janna Lee", "Janna Lee")
menu:SubMenu("c", "Combo")
menu.c:Boolean("cqu", "Use Q ?", true)
menu.c:Boolean("cwu", "Use W ?", true)
menu.c:Boolean("ceu", "Use E ?", true)
menu.c:Boolean("cru", "Use R ?", true)
menu:SubMenu("s", "Shield")
menu.s:Boolean("shj", "Shield Janna", true)
menu.s:Slider("sjhp", "Janna's HP Percentage", 50, 0, 100, 1)
menu.s:Boolean("sha", "Shield Allies", true)
menu.s:Slider("shp", "Ally's HP Percentage", 50, 0, 100, 1)
menu.s:Boolean("sot", "Shield when targetted", true)
menu.s:Boolean("se", "Emergency Shield", true)
menu:Boolean("al", "Use Auto Level spell", true)
OnTick(function()
	if not IsDead(myHero) then
		mode = Mix:Mode()
		local unit = GetCurrentTarget()
		als()
		if mode == "Combo" then 
			nsph(unit)
			ntb(unit)
		end
		shi()
		if menu.s.se:Value() then
			eshi()
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

function als()
	if menu.al:Value() and GetLevelPoints(myHero) >= 1 then
		LevelSpell(autolevel[1][GetLevel(myHero) - GetLevelPoints(myHero) + 1])
	end
end

function shi()
DelayAction(function()
	for _, ally in pairs(GetAllyHeroes()) do
		if Ready(_E) and GetDistance(myHero, ally) <= 800 and GetPercentHP(ally) <= menu.s.shp:Value() and menu.s.sha:Value() then
			ally:Cast(_E, ally)
		end
	end
	if Ready(_E) and GetPercentHP(myHero) <= menu.s.sjhp:Value() and menu.s.shj:Value() then
		myHero:Cast(_E, myHero)
	end
end, GetWindUp(myHero))
end

function eshi()
	if GetPercentHP(myHero) < 8 then
		myHero:Cast(_E, myHero)
	end
end
PrintChat("Janna Lee loaded")