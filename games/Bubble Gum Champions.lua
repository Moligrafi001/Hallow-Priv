-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Bubble%20Gum%20Champions.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Bubble Gum Champions",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().AutoBubbles = false
getgenv().AutoCoins = false
getgenv().AutoGems = false

-- Funções
local function AutoBubbles()
	while getgenv().AutoBubbles == true do
		game:GetService("ReplicatedStorage").RemoteEvent:FireServer("BlowBubble")
		wait(0.01)
	end
end
local function AutoCoins()
local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
local touch = character.HumanoidRootPart
	while getgenv().AutoCoins == true do
		for _, coin in pairs(workspace.PickupAreas.Overworld.Pickups:GetChildren()) do
			if coin:IsA("Model") and coin.Name ~= "Gem" then
				for _, ti in pairs(coin:GetDescendants()) do
					if ti.Name == "TouchInterest" then
						firetouchinterest(touch, ti.Parent, 0)
						firetouchinterest(touch, ti.Parent, 1)
					end
				end
			end
		end
		wait(1)
	end
end
local function AutoGems()
local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
local touch = character.HumanoidRootPart
	while getgenv().AutoGems == true do
		for _, coin in pairs(workspace.PickupAreas.Overworld.Pickups:GetChildren()) do
			if coin:IsA("Model") and coin.Name == "Gem" then
				for _, ti in pairs(coin:GetDescendants()) do
					if ti.Name == "TouchInterest" then
						firetouchinterest(touch, ti.Parent, 0)
						firetouchinterest(touch, ti.Parent, 1)
					end
				end
			end
		end
		wait(1)
	end
end
local function ReedemCodes()
	game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("RedeemCode", "MEGABOOST")
	game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("RedeemCode", "INSANEBOOST")
end

-- Menu		
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farm")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Bubbles",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoBubbles = Value
   	AutoBubbles()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Auto Coins",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoCoins = Value
   	AutoCoins()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Auto Gems",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoGems = Value
   	AutoGems()
   end,
})
local Section = Menu:CreateSection("More")
local Button = Menu:CreateButton({
   Name = "Reedem Codes",
   Callback = function()
   	ReedemCodes()
   end,
})