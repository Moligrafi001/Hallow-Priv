-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Snow%20Incremental%20Simulator.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | ❄️Snow Incremental Simulator",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
_G.AutoSnow = false
_G.AutoRebirth = false

-- Funções
local function AutoSnow()
	while _G.AutoSnow == true do
		game:GetService("ReplicatedStorage").Events.StatChange:FireServer("SnowFlakes", true, 999999999)
		wait(0.01)
	end
end
local function AutoRebirth()
	while _G.AutoRebirth == true do
		game:GetService("ReplicatedStorage").Events.StatChange:FireServer("Rebirth", true,1)
		wait(0.05)
	end
end
local function BuyAll()
	game:GetService("ReplicatedStorage").Events.ShovelBuy:FireServer(0, "Buy", "Larger Shovel")
	game:GetService("ReplicatedStorage").Events.ShovelBuy:FireServer(0, "Buy", "Dual-Blade Plow")
	game:GetService("ReplicatedStorage").Events.ShovelBuy:FireServer(0, "Buy", "Heat Stick")
	game:GetService("ReplicatedStorage").Events.ShovelBuy:FireServer(0, "Buy", "Tri-Sword")
	game:GetService("ReplicatedStorage").Events.ShovelBuy:FireServer(0, "Buy", "Snow Rake")
	game:GetService("ReplicatedStorage").Events.ShovelBuy:FireServer(0, "Buy", "Larger Plow")
	game:GetService("ReplicatedStorage").Events.ShovelBuy:FireServer(0, "Buy", "Basic Plow")
	game:GetService("ReplicatedStorage").Events.ShovelBuy:FireServer(0, "Buy", "Magnet")
	game:GetService("ReplicatedStorage").Events.ShovelBuy:FireServer(0, "Buy", "Lightning Staff")
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farm")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Snow",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AutoSnow = Value
   	AutoSnow()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AutoRebirth = Value
   	AutoRebirth()
   end,
})
local Section = Menu:CreateSection("Extra")
local Button = Menu:CreateButton({
   Name = "Reedem Codes",
   Callback = function()
game:GetService("ReplicatedStorage").Events.Code:FireServer("Bruh")
game:GetService("ReplicatedStorage").Events.Code:FireServer("Noob")
game:GetService("ReplicatedStorage").Events.Code:FireServer("Secret")
    end,
})

-- Blades
local BladesTab = Window:CreateTab("Blades", "sword")
local Section = BladesTab:CreateSection("Blades")
local Button = BladesTab:CreateButton({
   Name = "Get All Blades",
   Callback = function()
   	BuyAll()
    end,
})
local Button = BladesTab:CreateButton({
   Name = "Equip Magnet",
   Callback = function()
   	game:GetService("ReplicatedStorage").Events.ShovelBuy:FireServer(0, "Equip", "Magnet")
    end,
})