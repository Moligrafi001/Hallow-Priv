-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Bits%20Inc.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Bits Incremental",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().UpgValue = false
getgenv().UpgMax = false
getgenv().UpgCold = false
getgenv().UpgGold = false
getgenv().UpgMyth = false
getgenv().AutoClick = false

-- Funções
local function UpgValue()
	while getgenv().UpgValue == true do
		if workspace.BitsMap.Upgrades.BitsValueUpgradeBoard.SurfaceGui.BuyButton.BackgroundColor3 == Color3.fromRGB(88, 166, 114) then
			game:GetService("ReplicatedStorage").Remotes.Upgrades.BitsValueUpgrade.BuyRemote:FireServer(game:GetService("Players").LocalPlayer)
		end
		wait(0.5)
	end
end
local function UpgMax()
	while getgenv().UpgMax == true do
		if workspace.BitsMap.Upgrades.MaxBitsUpgradeBoard.SurfaceGui.BuyButton.BackgroundColor3 == Color3.fromRGB(88, 166, 114) then
			game:GetService("ReplicatedStorage").Remotes.Upgrades.MaxBitsUpgrade.BuyRemote:FireServer(game:GetService("Players").LocalPlayer)
		end
		wait(0.5)
	end
end
local function UpgCold()
	while getgenv().UpgCold == true do
		if workspace.BitsMap.Upgrades.CooldownUpgradeBoard.SurfaceGui.BuyButton.BackgroundColor3 == Color3.fromRGB(88, 166, 114) then
			game:GetService("ReplicatedStorage").Remotes.Upgrades.CooldownUpgrade.BuyRemote:FireServer(game:GetService("Players").LocalPlayer)
		end
		wait(0.5)
	end
end
local function UpgGold()
	while getgenv().UpgGold == true do
		if workspace.BitsMap.Upgrades.GoldenBitUpgradeBoard.SurfaceGui.BuyButton.BackgroundColor3 == Color3.fromRGB(88, 166, 114) then
			game:GetService("ReplicatedStorage").Remotes.Upgrades.GoldenBitUpgrade.BuyRemote:FireServer(game:GetService("Players").LocalPlayer)
		end
		wait(0.5)
	end
end
local function UpgMyth()
	while getgenv().UpgMyth == true do
		if workspace.BitsMap.Upgrades.MythicalBitUpgradeBoard.SurfaceGui.BuyButton.BackgroundColor3 == Color3.fromRGB(88, 166, 114) then
			game:GetService("ReplicatedStorage").Remotes.Upgrades.MythicalBitUpgrade.BuyRemote:FireServer(game:GetService("Players").LocalPlayer)
		end
		wait(0.5)
	end
end
local function AutoClick()
	while getgenv().AutoClick == true do
		local numero = tonumber(workspace.BitsMap.BitsBoard.SurfaceGui.StatsFrame.Cooldown.Text:match("%d+%.?%d*"))
		game:GetService("ReplicatedStorage").Remotes.MainButtons.BitsButton.SpawnBit:FireServer()
		wait(numero)
	end
end

-- Menu		
local Menu = Window:CreateTab("Bits", "home")
local Section = Menu:CreateSection("Auto Farm")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Click Bits",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoClick = Value
   	AutoClick()
   end,
})
local Section = Menu:CreateSection("Auto Upgrade")
local Toggle =  Menu:CreateToggle({
   Name = "Upgrade Bits Value",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().UpgValue = Value
   	UpgValue()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Upgrade Max Bits",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().UpgMax = Value
   	UpgMax()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Upgrade Bits Cooldown",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().UpgCold = Value
   	UpgCold()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Upgrade Gold Chance",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().UpgGold = Value
   	UpgGold()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Upgrade Myth Chance",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().UpgMyth = Value
   	UpgMyth()
   end,
})