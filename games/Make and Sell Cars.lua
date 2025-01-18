-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Make%20and%20Sell%20Cars.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Make and Sell Cars",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
_G.InfRock = false
_G.InfCars = false
_G.InfMoney = false

-- Funções
local function InfRock()
	while _G.InfRock == true do
		game:GetService("ReplicatedStorage").Event.Train:FireServer(999999999999999999999999)
		wait(0.33)
	end
end
local function InfCars()
	while _G.InfCars == true do
		game:GetService("ReplicatedStorage").Event.CraftWeapon:FireServer("Ager", 999999999999999999999999)
		wait(0.33)
	end
end
local function InfMoney()
	while _G.InfMoney == true do
		game:GetService("ReplicatedStorage").Event.SellWeapon:FireServer(999999999999999999999999, 0)
		wait(0.33)
	end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Inf Resources")
local Toggle =  Menu:CreateToggle({
   Name = "Rocks",
   CurrentValue = false,
   Callback = function(Value)
   	_G.InfRock = Value
   	InfRock()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Cars",
   CurrentValue = false,
   Callback = function(Value)
   	_G.InfCars = Value
   	InfCars()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Money",
   CurrentValue = false,
   Callback = function(Value)
   	_G.InfMoney = Value
   	InfMoney()
   end,
})