-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Clicking%20Quest.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Clicking Quest!",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
local RebirthNumber = 1
_G.AutoClick = false
_G.ClaimGift = false
_G.AutoRebirth = false

-- Funções
local function AutoClick()
	while _G.AutoClick == true do
		game:GetService("ReplicatedStorage").TappingRemote.Tap:FireServer()
		game:GetService("ReplicatedStorage").TappingRemote.SuperTap:FireServer()
		wait(0.01)
	end
end
local function ClaimGift()
	while _G.ClaimGift == true do
		for gift = 1, 9 do
			game:GetService("ReplicatedStorage").GiftFolder.ClaimGift:InvokeServer(gift)
		end
		wait(0.5)
	end
end
local function AutoRebirth()
	while _G.AutoRebirth == true do
		game:GetService("ReplicatedStorage").Rebirth:FireServer(RebirthNumber)
		wait(0.05)
	end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farm")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Click",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AutoClick = Value
   	AutoClick()
   end,
})
local Section = Menu:CreateSection("Rebirth")
local Dropdown = Menu:CreateDropdown({
   Name = "How many rebirths at once?",
   Options = {1, 5, 10, 25, 50, 100, 250, 500},
   CurrentOption = {"Sigma Boy Sigma Sigma Boy"},
   MultipleOptions = false,
   Callback = function(Options)
   		RebirthNumber = Options[1]
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
local Section = Menu:CreateSection("Gifts")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Claim Time Gifts",
   CurrentValue = false,
   Callback = function(Value)
   	_G.ClaimGift = Value
   	ClaimGift()
   end,
})